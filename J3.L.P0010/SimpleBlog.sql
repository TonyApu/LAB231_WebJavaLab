USE [master]
GO
/****** Object:  Database [SimpleBlog]    Script Date: 27/10/2021 00:26:34 ******/
CREATE DATABASE [SimpleBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SocialNetWork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SocialNetWork.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SocialNetWork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SocialNetWork_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SimpleBlog] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SimpleBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SimpleBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SimpleBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SimpleBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SimpleBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SimpleBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SimpleBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SimpleBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SimpleBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SimpleBlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SimpleBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SimpleBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SimpleBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SimpleBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SimpleBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SimpleBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SimpleBlog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SimpleBlog] SET  MULTI_USER 
GO
ALTER DATABASE [SimpleBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SimpleBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SimpleBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SimpleBlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SimpleBlog] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SimpleBlog]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 27/10/2021 00:26:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comment](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](100) NULL,
	[post_id] [int] NULL,
	[content] [nvarchar](200) NOT NULL,
	[comment_status] [varchar](10) NULL DEFAULT ('Active'),
	[date_created] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post]    Script Date: 27/10/2021 00:26:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post](
	[post_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[content] [nvarchar](2000) NOT NULL,
	[date_created] [datetime] NOT NULL,
	[date_updated] [datetime] NULL,
	[post_status] [varchar](10) NULL CONSTRAINT [DF__Post__post_statu__182C9B23]  DEFAULT ('New'),
	[email] [varchar](100) NOT NULL,
	[short_description] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserInfor]    Script Date: 27/10/2021 00:26:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfor](
	[email] [varchar](100) NOT NULL,
	[password] [varchar](200) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[user_role] [varchar](20) NULL DEFAULT ('Member'),
	[user_status] [varchar](20) NULL DEFAULT ('New'),
PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([comment_id], [email], [post_id], [content], [comment_status], [date_created]) VALUES (23, N'tamnxlse141130@fpt.edu.vn', 33, N'test comment', N'Active', CAST(N'2021-10-23 17:15:05.463' AS DateTime))
INSERT [dbo].[Comment] ([comment_id], [email], [post_id], [content], [comment_status], [date_created]) VALUES (24, N'tamnxl1@gmail.com', 45, N'bai viet hay', N'Active', CAST(N'2021-10-23 17:19:42.220' AS DateTime))
INSERT [dbo].[Comment] ([comment_id], [email], [post_id], [content], [comment_status], [date_created]) VALUES (25, N'hoangndxse141003@fpt.edu.vn', 36, N'chao ban', N'Active', CAST(N'2021-10-25 23:06:13.873' AS DateTime))
INSERT [dbo].[Comment] ([comment_id], [email], [post_id], [content], [comment_status], [date_created]) VALUES (26, N'hoangndxse141003@fpt.edu.vn', 45, N'test comment', N'Active', CAST(N'2021-10-26 02:00:56.210' AS DateTime))
INSERT [dbo].[Comment] ([comment_id], [email], [post_id], [content], [comment_status], [date_created]) VALUES (27, N'hoangndxse141003@fpt.edu.vn', 36, N'dang nhap de comment', N'Active', CAST(N'2021-10-27 00:17:59.433' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (31, N'Huawei should dissolve, disperse and seed Chinaâs high-tech future', N'Huawei, a chinese firm emblematic of the breakdown in Sino-American relations, makes for a perfect business-school case study. Less than two years ago the company, based in the southern boom town of Shenzhen, had not only surpassed Nokia and Ericsson, its Nordic rivals, to become the worldâs leading supplier of telecoms infrastructure. It had also overtaken Samsung to become the biggest seller of mobile phones. Like all good case studies, it has vivid characters, from its founder, Ren Zhengfei, a former army officer and engineer, to his daughter, Meng Wanzhou, just freed from a starring role in the first prisoner-exchange drama of the tech cold war. It is a groundbreaking firm. Like Japanâs Sony in the 1980s, it helped change the perception of its home country from one of cheap knock-offs to eye-catching innovation. And its very future may be in peril. With the long arm of American law enforcement around its neck, it is being throttled by a lack access to cutting-edge technology, such as 5g smartphone chips.', CAST(N'2021-10-23 16:54:30.870' AS DateTime), NULL, N'Active', N'tamnxl1@gmail.com', N'It is too prominent to be able to reinvent itself')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (32, N'Enter third wave economics', N'As part of his plan for socialism in the early 1970s, Salvador Allende created Project Cybersyn. The Chilean presidentâs idea was to offer bureaucrats unprecedented insight into the countryâs economy. Managers would feed information from factories and fields into a central database. In an operations room bureaucrats could see if production was rising in the metals sector but falling on farms, or what was happening to wages in mining. They would quickly be able to analyse the impact of a tweak to regulations or production quotas.', CAST(N'2021-10-23 16:56:08.797' AS DateTime), NULL, N'Deleted', N'tamnxl1@gmail.com', N'How the pandemic reshaped the dismal science')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (33, N'Britain sluggish stockmarket', N'If britainâs two truly world-beating exports are entertainment and finance, 2005 was a big year. Its bestselling album was âX&Yâ by Coldplay, a British rock band. âHarry Potter and the Half-Blood Princeâ sold more copies in its first 24 hours than any novel before it. âPeppa Pigâ, a childrenâs television programme set to become so popular that American parents would complain it was giving their children British accents, made its transatlantic debut.

Londonâs financial district, too, seemed on top of the world. Gone was the post-war backwater that scratched out its living financing the remnants of the imperial commodities trade. Half a century of financial innovation, freer trade and deregulation had lured foreign banks to the Square Mile and then cracked it open to international capital. As the birthplace of the Eurobond market, which allowed firms to borrow American dollars outside America, London had long been an international hub for raising debt and trading foreign currencies.', CAST(N'2021-10-23 16:57:51.097' AS DateTime), NULL, N'Active', N'tamnxl1@gmail.com', N'Why London is no longer the worldâs bourse')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (34, N'How the world learns to live with covid19', N'Winter 2025 could, with luck, be normal. Health-care systems will come under strain, as always, from the spread of respiratory diseases that land people in hospital. Influenza will afflict the elderly. Respiratory syncytial virus will make some children gravely ill. And a newish seasonal disease will belong in the mix: covid-19. It will overwhelmingly sicken the old, even more than flu. But, outside hospitals, life will continue largely uninterrupted.', CAST(N'2021-10-23 17:00:33.677' AS DateTime), NULL, N'Active', N'tamnxl1@gmail.com', N'From pandemic to epidemic')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (35, N'The Bank of England should not raise interest rates until 2022', N'Britain is uniquely exposed to the malign forces troubling the world economy. It gets two-fifths of its energy from natural gas, which is in short supply. Trade flows are worth more than half of its gdp, making bunged-up supply chains particularly painful. Brexit has exacerbated its labour shortage and disrupted trade further. It even has a high rate of covid-19 infections, posing a lingering threat to consumer confidence, though more than 90% of the population has antibodies against the disease.', CAST(N'2021-10-23 17:02:09.803' AS DateTime), NULL, N'Active', N'tamnxl1@gmail.com', N'But Britain may need tighter money sooner than America')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (36, N'At last, a backlash against bad government in Eastern Europe', N'Corruption, autocracy, overbearing government - these were the perils many hoped eastern Europe was escaping when its fledgling democracies joined the European Union in the early 2000s. Instead, the rest of Europe now worries, the eastern members have simply smuggled these vices into the eu.
One of the biggest offenders is Poland. First the government in Warsaw stacked its constitutional court with pliant judges and then got them to rule that the Polish constitution can override the European treaties - an assault on a basic principle of eu membership. Viktor Orban, Hungary s long - serving prime minister, has bullied political opponents, critical media outlets and gay Hungarians, among others.

', CAST(N'2021-10-23 17:07:22.503' AS DateTime), NULL, N'Active', N'tony05@gmail.com', N'The EUs battles with Poland and an opposition alliance in Hungary are overdue signs of change')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (37, N'A real-time revolution will up-end the practice of macroeconomics', N'Does anyone really understand what is going on in the world economy? The pandemic has made plenty of observers look clueless. Few predicted $80 oil, let alone fleets of container ships waiting outside Californian and Chinese ports. As covid-19 let rip in 2020, forecasters overestimated how high unemployment would be by the end of the year. Today prices are rising faster than expected and nobody is sure if inflation and wages will spiral upward. For all their equations and theories, economists are often fumbling in the dark, with too little information to pick the policies that would maximise jobs and growth.', CAST(N'2021-10-23 17:09:30.813' AS DateTime), NULL, N'Active', N'tony05@gmail.com', N'The pandemic has hastened a shift towards novel data and fast analysis')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (38, N'Insurgency, secessionism and banditry threaten Nigeria', N'Little more than six decades ago, as Nigeria was nearing independence, even those who were soon to govern Africaâs largest country had their doubts about whether it would hold together. British colonists had drawn a border around land that was home to more than 250 ethnic groups. Obafemi Awolowo, a politician of that era, evoked Metternich, fretting that âNigeria is not a nation. It is a mere geographical expression.â
The early years of independence seemed to prove him right. Coup followed coup. Ethnic pogroms helped spark a civil war that cost 1m lives, as the south-eastern region calling itself Biafra tried to break away and was ruthlessly crushed. Military rule was the norm until 1999. Despite this inauspicious start, Nigeria is now a powerhouse. Home to one in six sub-Saharan Africans, it is the continentâs most boisterous democracy. Its economy, the largest, generates a quarter of Africaâs gdp. Nollywood makes more titles than any other countryâs film industry bar Bollywood. Three of sub-Saharan Africaâs four fintech âunicornsâ (startups valued at more than $1bn) are Nigerian.

', CAST(N'2021-10-23 17:10:47.900' AS DateTime), NULL, N'Active', N'tony05@gmail.com', N'Africaâs biggest nation faces its biggest test since its civil war 50 years ago')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (39, N'China is ratcheting up military pressure on Taiwan', N'It was a deliberate provocation, patriotically timed. On October 1st, the countryâs national day, China flew 38 aircraft, including fighter jets and bombers, towards Taiwan (one type, the j-16, is pictured). They entered the islandâs Air Defence Identification Zone (adiz), a buffer region where intrusions often prompt military alerts. It was the yearâs daily record. Over the next three days China sent another 111 planes. In response, Taiwan scrambled jets, broadcast warnings and tracked the Chinese aircraft with missile systems. The islandâs defence minister, Chiu Kuo-cheng, called it âthe toughest situation I have seen in more than 40 years of my military lifeâ.

The skies around Taiwan were quieter as The Economist went to press. On October 6th China flew no military planes through the adiz. So far none of the flights has crossed into Taiwanâs territorial airspace, which extends 12 nautical miles (about 22km) from the island. The intruders typically fly 35 nautical miles or more from the Taiwanese coast. But American officials clearly share Mr Chiuâs anxiety. On October 6th Americaâs secretary of state, Antony Blinken, called on China to halt its âprovocativeâ activity near Taiwan. Also that day, Jake Sullivan, President Joe Bidenâs national security adviser, conveyed Americaâs concern at a meeting in Switzerland with Yang Jiechi, Chinaâs most senior diplomat and a member of the ruling Politburo.

', CAST(N'2021-10-23 17:11:27.663' AS DateTime), NULL, N'Active', N'tony05@gmail.com', N'Its aerial sorties near the island are increasing the risk of a crisis')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (40, N'In Xinjiang, officials are trying to stamp out Uyghur identity', N'Officials in xinjiang have always been suspicious of the distinctive cultural identity of ethnic Uyghurs. They worry that it may fuel separatist yearnings in the far-western region. But in 2014, as the authorities stepped up their campaign to crush terrorism there, the government still tolerated displays of pride in Uyghur culture. In October that year a new talent show, âThe Voice of the Silk Roadâ, aired on state-owned Xinjiang Television. It featured songs in various styles, from pop and r&b to traditional muqam music with lyrics influenced by classical poetry. The judges mostly spoke in Uyghur.

When China began to open up in the late 1970s, after the death of Mao Zedong, Uyghur culture was allowed to flourish, as long as it avoided any hint of support for a separate Uyghur state. Uyghur writers produced poems and songs filled with universally familiar themes such as love and loss, but also conveying pride in their identity. They created innovative blends of muqam with rock and hip-hop that turned a few Uyghurs into household names in China. Songs in such styles were aired on âThe Voice of the Silk Roadâ.

', CAST(N'2021-10-23 17:11:57.300' AS DateTime), NULL, N'Deleted', N'tony05@gmail.com', N'Uyghur artists and intellectuals are being rounded up, but some of their work escapes')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (41, N'Artists and craftsmen try to preserve the sounds of old Beijing', N'With oneâs eyes closed, Beijingâs main roads sound like any Chinese city. All around is the roar of traffic, punctuated by honks from delivery scooters, recorded safety warnings from buses and the occasional bell of a rental-bicycle. But in the capitalâs last hutongs, as its ancient grey-walled alleys are known, fragments of an older soundscape can be heard.

The chirping of caged crickets is one. Hung in the doorways of courtyard homes or small shops, the insects bring a rural note into the city. A quarter-century ago their song was common. Beijing was still home to cycle rickshaws and delivery tricycles. Some riders hung crickets from their handlebars, inside spherical cages woven from reeds. Today, cricket-sellers cling on, lurking near a motorway bridge in southern Beijing. A big specimen sells for 20 yuan ($3). They are heirs to a grand tradition. In imperial times, bored courtiers and Manchu army officers spent fortunes on caged crickets and songbirds.

', CAST(N'2021-10-23 17:12:25.257' AS DateTime), NULL, N'Deleted', N'tony05@gmail.com', N'A new museum in the city keeps some of them alive')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (42, N'What if America tackled its opioid crisis?', N'Editor''s note: This year What If?, our annual collection of scenarios, considers the future of health. Each of these stories is ï¬ction, but grounded in historical fact, current speculation and real science. They do not present a uniï¬ed narrative but are set in diï¬erent possible futures

Projections from the Centres for Disease Control and Prevention (cdc) published this month predict that in 2025, for the first time, more than 100,000 Americans will die from a drug overdose, bringing the total to more than 1m since 1999. At current rates, by the time of the next presidential election in 2028, more Americans will have died in the 21st century of drug overdoses than died in all of Americaâs wars over its entire history. These horrifying statistics have at last focused attention on this neglected crisis.

', CAST(N'2021-10-23 17:16:15.903' AS DateTime), NULL, N'Active', N'tamnxlse141130@fpt.edu.vn', N'Kamala Harris''s administration is getting serious about tackling deaths from drug overdoses. It is a problem with deep roots. An imagined scenario from 2025')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (43, N'What if a deadly heatwave hit India?', N'Editor''s note: This year What If?, our annual collection of scenarios, considers the future of health. Each of these stories is ï¬ction, but grounded in historical fact, current speculation and real science. They do not present a uniï¬ed narrative but are set in diï¬erent possible futures

In new delhi, Indiaâs capital, the roads have begun to melt. Temperatures in the city reached 49.3C (120.7F) as the deadliest heatwave in the countryâs history entered its third week. It was even hotter in the south, where temperatures rose above 50C, peaking at a record-breaking 52.1C in the town of Markapur, Andhra Pradesh, on June 23rd. But the centre of the crisis is the city of Chennai, where hospitals are buckling in the face of heat-related illnesses. The worst scenes were outside Jawaharlal Nehru Hospital, where 11 people died from heat exposure while queuing.

', CAST(N'2021-10-23 17:17:01.670' AS DateTime), NULL, N'Active', N'tamnxlse141130@fpt.edu.vn', N'Why Hyderabad is weathering Indiaâs deadly heatwave so much better than Chennai. An imagined scenario from 2041')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (44, N'What if dementia was preventable and treatable?', N'Editor''s note: This year What If?, our annual collection of scenarios, considers the future of health. Each of these stories is ï¬ction, but grounded in historical fact, current speculation and real science. They do not present a uniï¬ed narrative but are set in diï¬erent possible futures

Reluctantly, watanabe keiko puts down her book. She enjoys Tolstoy so much more in the original Russian, she explains. When she first decided to learn it, a decade ago in 2040, she was already 82, and felt a little old for the endeavour. But the doctors who monitored her were delighted: that, they purred, would be just excellent for her brain. They had been watching her closely ever since a routine test back in 2023, when she was 65, identified her as being at high risk of developing dementia. So terrifying was this prospect that she meekly submitted herself to many of the recommendations they made about her lifestyle, as did many of her neighbours on Shikoku island.

', CAST(N'2021-10-23 17:17:42.923' AS DateTime), NULL, N'New', N'tamnxlse141130@fpt.edu.vn', N'How behavioural changes and new therapies turned the tide against dementia. An imagined scenario from 2050')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (45, N'Governments are finding new ways to squash free expression online', N'On october 8th two journalists, Maria Ressa and Dmitry Muratov, won the Nobel peace prize for their "efforts to safeguard freedom of expression". The Kremlin congratulated Mr Muratov for being "brave", which he is. Six of his colleagues at Novaya Gazeta, the Russian newspaper he founded in 1993, have been murdered.

Ms Ressa is brave, too. Her news organisation, Rappler, started as a Facebook page in 2011. It is one of very few in the Philippines that criticises Rodrigo Duterte, a president who urges the police to kill suspects without trial. At least ten journalists have been murdered since Mr Duterte came to power. In 2016, when he was president-elect, he said: "just because youâre a journalist you are not exempted from assassination, if youâre a son of a bitch."

', CAST(N'2021-10-23 17:18:49.320' AS DateTime), NULL, N'Active', N'tamnxlse141130@fpt.edu.vn', N'Would-be autocrats are learning from China, and each other')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (46, N'JAVA', N'Test bai viet JAVA', CAST(N'2021-10-26 01:05:51.747' AS DateTime), NULL, N'Active', N'hoangndxse141003@fpt.edu.vn', N'Test bai dang dau tien')
INSERT [dbo].[Post] ([post_id], [title], [content], [date_created], [date_updated], [post_status], [email], [short_description]) VALUES (47, N'Liverpool - Manchester United ', N'ti so 5-0', CAST(N'2021-10-27 00:19:19.597' AS DateTime), NULL, N'Active', N'hoangndxse141003@fpt.edu.vn', N'The thao')
SET IDENTITY_INSERT [dbo].[Post] OFF
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'2noobgaming159632@gmail.com', N'481f6cc0511143ccdd7e2d1b1b94faf0a700a8b49cd13922a70b5ae28acaa8c5', N'Xung Vang', N'Member', N'Active')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'hoangndxse141003@fpt.edu.vn', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'Nham Duc Hoang', N'Member', N'New')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tamnxl@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'tamnxl', N'Admin', N'Active')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tamnxl1@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Nguyen Xuan Linh Tam', N'Member', N'Active')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tamnxl2@gmail.com', N'6d036232c409dd5d717c895d8d695d9e1750d9062a13788bb2dda8dad603a5c5', N'Linh Tam', N'Member', N'New')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tamnxlse141130@fpt.edu.vn', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Nham Duc Dat', N'Member', N'Active')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tony01@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Tran Duy Nghiem', N'Member', N'New')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tony02@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Nham Duc Dat', N'Member', N'New')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tony04@gmail.com', N'6d036232c409dd5d717c895d8d695d9e1750d9062a13788bb2dda8dad603a5c5', N'Nguyen Chi Khoi', N'Member', N'Active')
INSERT [dbo].[UserInfor] ([email], [password], [full_name], [user_role], [user_status]) VALUES (N'tony05@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Xuan Hoang', N'Member', N'Active')
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([post_id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_UserInfor] FOREIGN KEY([email])
REFERENCES [dbo].[UserInfor] ([email])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_UserInfor]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_UserInfor] FOREIGN KEY([email])
REFERENCES [dbo].[UserInfor] ([email])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_UserInfor]
GO
USE [master]
GO
ALTER DATABASE [SimpleBlog] SET  READ_WRITE 
GO
