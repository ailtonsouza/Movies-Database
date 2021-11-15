
Create TRIGGER Checking_OscarAward
    ON [dbo].[OscarAward]
    INSTEAD OF INSERT, UPDATE
    AS
    BEGIN
	set nocount on

	Declare @Id int
	Declare @Category int
	Declare @PID as int
	Declare @MID as int
	Declare @message as varchar(150)

	select @Id = Count(*) From Inserted

	select * into #Temp from Inserted

	WHILE exists (select * from #Temp)
	begin
	
	SELECT top(1) @category = CategoryId from #Temp;
	SELECT top(1) @PID = ProfessionalId from #Temp; 
	SELECT top(1) @MID = MovieId from #Temp;


	if @category in (31,1,2,3,4,8) and @PID is null
	BEGIN
		set @message = concat('Oscar award category ' , @category , ' requires a professional id') ;
		select @message;
		THROW 51000, @message, 1;  
	END

	if @category in (31,1,2) 
	BEGIN
		if not exists(select * from ProfessionalMovie
		where Professional_Id = @PID	
		and Movie_Id = @MID
		and Role_Id = 2)
			Begin
				set @message = concat('Oscar award category category ' , @category , ' requires a professional id that have worked on this movie on category 2') ;
				THROW 51000, @message, 1;  
			END
	END

	if @category in (3,4) 
	BEGIN
		if not exists(select * from ProfessionalMovie
		where Professional_Id = @PID	
		and Movie_Id = @MID
		and Role_Id = 3)
		set @message = concat('Oscar award category category ' , @category , ' requires a professional id that have worked on this movie on category 3') ;
		THROW 51000, @message, 1;  

	END

	if @category = 8 
	BEGIN
		if not exists(select * from ProfessionalMovie
		where Professional_Id = @PID	
		and Movie_Id = @MID
		and Role_Id = 4)
		set @message = concat('Oscar award category category ' , @category , ' requires a professional id that have worked on this movie on category 4') ;
		THROW 51000, @message, 1;  

	END

	delete top(1) from #Temp

	end

	insert into OscarAward select Movie_Id, Professional_Id, IMDBEventId, Category_Id, CerimonyDate, CerimonyNumber, moviesReleasedIn from inserted
	
	END


