/****** Object:  Table [dbo].[person]    Script Date: 26-Dec-18 10:56:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[person](
	[person_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[state_id] [int] NULL,
	[gender] [char](1) NULL,
	[dob] [datetime] NULL,
 CONSTRAINT [PK_person] PRIMARY KEY CLUSTERED 
(
	[person_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[states]    Script Date: 26-Dec-18 10:56:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[states](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[state_code] [char](2) NULL,
 CONSTRAINT [PK_states] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[person]  WITH CHECK ADD  CONSTRAINT [FK_person_person] FOREIGN KEY([state_id])
REFERENCES [dbo].[states] ([state_id])
GO
ALTER TABLE [dbo].[person] CHECK CONSTRAINT [FK_person_person]
GO
/****** Object:  StoredProcedure [dbo].[uspPersonGet]    Script Date: 26-Dec-18 10:56:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspPersonGet]
	-- Add the parameters for the stored procedure here
	@person_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.person_id,
		   p.first_name,
		   p.last_name,
		   p.gender,
		   p.state_id,
		   s.state_code,
		   p.dob
	FROM person p
		JOIN states s
		 ON p.state_id = s.state_id
	WHERE p.person_id=@person_id
END
GO
/****** Object:  StoredProcedure [dbo].[uspPersonSearch]    Script Date: 26-Dec-18 10:56:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspPersonSearch]
	-- Add the parameters for the stored procedure here
	@name varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.person_id,
		   p.first_name,
		   p.last_name,
		   p.gender,
		   p.state_id,
		   s.state_code,
		   p.dob
	FROM person p
		JOIN states s
		 ON p.state_id = s.state_id
	WHERE p.first_name like '%'+@name+'%' or p.last_name like '%'+@name+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[uspPersonUpsert]    Script Date: 26-Dec-18 10:56:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspPersonUpsert] 
	-- Add the parameters for the stored procedure here
	@Person_Id int,
	@First_Name varchar(50),
	@Last_Name varchar(50),
	@State_Id int,
	@Gender char(1),
	@Dob datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @Person_Id > 0
	BEGIN
		UPDATE person
		SET first_name=@First_Name,
			last_name=@Last_Name,
			gender= @Gender,
			state_id=@State_Id,
			dob=@Dob
		WHERE person_id=@Person_Id
		SELECT @Person_Id
	END
	ELSE
	BEGIN
		INSERT INTO person (first_name,last_name,gender,state_id,dob)
					VALUES(@First_Name,@Last_Name,@Gender,@State_Id,@Dob)

		SELECT @@IDENTITY
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspStatesList]    Script Date: 26-Dec-18 10:56:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspStatesList]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM states
END
GO
