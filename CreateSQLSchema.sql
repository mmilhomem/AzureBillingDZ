GO
/****** Object:  Table [dbo].[BillingDetail]    Script Date: 5/24/2015 10:56:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillingDetail](
	[BillingID] [int] IDENTITY(1,1) NOT NULL,
	[EANumber] [int] NOT NULL,
	[AccountOwnerId] [nvarchar](255) NULL,
	[AccountName] [nvarchar](255) NULL,
	[ServiceAdministratorId] [nvarchar](255) NULL,
	[SubscriptionId] [float] NULL,
	[SubscriptionGuid] [nvarchar](255) NULL,
	[SubscriptionName] [nvarchar](255) NULL,
	[Date] [datetime] NOT NULL,
	[Month] [float] NULL,
	[Day] [float] NULL,
	[Year] [float] NULL,
	[Product] [nvarchar](255) NULL,
	[ResourceGUID] [nvarchar](255) NOT NULL,
	[Service] [nvarchar](255) NULL,
	[ServiceType] [nvarchar](255) NULL,
	[ServiceRegion] [nvarchar](255) NULL,
	[ServiceResource] [nvarchar](255) NULL,
	[ResourceQtyConsumed] [float] NULL,
	[ResourceRate] [float] NULL,
	[ExtendedCost] [float] NULL,
	[ServiceSubRegion] [nvarchar](255) NULL,
	[ServiceInfo] [nvarchar](255) NULL,
	[Component] [nvarchar](255) NULL,
	[ServiceInfo1] [nvarchar](255) NULL,
	[ServiceInfo2] [nvarchar](255) NULL,
	[AdditionalInfo] [nvarchar](255) NULL,
	[Tags] [nvarchar](255) NULL,
	[StoreServiceIdentifier] [nvarchar](255) NULL,
	[DepartmentName] [nvarchar](255) NULL,
	[CostCenter] [nvarchar](255) NULL,
 CONSTRAINT [PK_BillingDetail_1] PRIMARY KEY CLUSTERED 
(
	[BillingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BillingSummary]    Script Date: 5/24/2015 10:56:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingSummary](
	[BillingID] [int] IDENTITY(1,1) NOT NULL,
	[EANumber] [int] NULL,
	[CurrencyCode] [varchar](3) NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[MonthName] [nvarchar](30) NULL,
	[BeginningBalance] [float] NULL,
	[NewPurchases] [float] NULL,
	[Adjustments] [float] NULL,
	[UtilizedSubtractedFromBalance] [float] NULL,
	[EndingBalance] [float] NULL,
	[Overage] [float] NULL,
	[ServiceOverage] [float] NULL,
	[ChargesBilledSeparately] [float] NULL,
	[TotalOverage] [float] NULL,
	[TotalUsage] [float] NULL,
	[AzureMarketplaceServiceCharges] [float] NULL,
	[ReportGenerationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EAContracts]    Script Date: 5/24/2015 10:56:41 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EAContracts](
	[EANumber] [int] NOT NULL,
	[EAKey] [text] NOT NULL,
	[Customer] [nvarchar](100) NULL,
	[LastReportDate] [smalldatetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PrimaryKey_a4ea1bf0-df44-4398-ac16-fe7fc4ee36ac] PRIMARY KEY CLUSTERED 
(
	[EANumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  View [dbo].[DimDates]    Script Date: 5/24/2015 10:56:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[DimDates] as
select distinct
	date
	, datepart(year, date) as year
	, datepart(month, date) as month
	, datepart(day, date) as day
	, datepart(dayofyear, date) as dayofyear
	, datepart(week, date) as week
	, datepart(weekday, date) as weekday
	, datepart(quarter, date) as quarter
from BillingDetail
GO
ALTER TABLE [dbo].[BillingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BillingDetail_EAContracts] FOREIGN KEY([EANumber])
REFERENCES [dbo].[EAContracts] ([EANumber])
GO
ALTER TABLE [dbo].[BillingDetail] CHECK CONSTRAINT [FK_BillingDetail_EAContracts]
GO
ALTER TABLE [dbo].[BillingSummary]  WITH CHECK ADD  CONSTRAINT [FK_BillingSummary_EAContracts] FOREIGN KEY([EANumber])
REFERENCES [dbo].[EAContracts] ([EANumber])
GO
ALTER TABLE [dbo].[BillingSummary] CHECK CONSTRAINT [FK_BillingSummary_EAContracts]
GO
