Return-Path: <linux-btrfs+bounces-1299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F76826986
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 09:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979E9B2150A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E6BE5B;
	Mon,  8 Jan 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D/J3TohO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HcDdmjsR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A62BA39
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4088F1OI031953
	for <linux-btrfs@vger.kernel.org>; Mon, 8 Jan 2024 08:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=o2PzKH4CsWFiNIHfaUcSuejwJYITpMHu/dPGiVEv5uQ=;
 b=D/J3TohOBYuL2BeQ+Ps9I432uIXQu/SWGhOaMx1fLQC2I0iDVuco7hAHMegrUPV5ZcnC
 JwD8ez1ZAo928H1ZlOCFLHG/QWBTHeSL0D1g7ruipMT30PH98G1TkgemYqMwkosT/y4V
 7lQdVsSFqSD8bry0MvBgCPq7OWZiR3X5ds3niikqM90wAk/R6975vjRq5U2rIO+ObzHj
 YdfwP7RHwqtiG9oGjhUIHWSrRhir3vQ/wFOYYdKA3wnS36akXIjTSDFCrn81bAHzapW2
 o/XUqT50sm9tiMkJOnyJbk7xNGw9ITQLvOj/QgAPNs/uRUPU/Q/fE1uffz4BRL0YvFVM Kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgdc6r1mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 08:31:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4087LYap012477
	for <linux-btrfs@vger.kernel.org>; Mon, 8 Jan 2024 08:31:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuweu1mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 08:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMRWJv6VNCssTdSi1NT8u7+eQoXzD8lYcBdcJn2LKtvMbuFs8QMaKakBR0kkmm88EExn7rS9zntRZOABUKMkB+jigRERwEIJqshioeqfy44h31yCCYDhkV7ttRjrqV8rGvyV8rMS8j4Ym8jizn/O3GL/oZgo6sf/01iURfN+mjJR2LSm+7PmoQTONaPsWgTPpAqaGaUB3CpKyElpPlBUkBpWQ22WTMt2GI0EPRgRtsB9lWGmr9cuUzNKjoo934l/ypxX4HFGU1hsxE3nFLl9nktzGMlIlm/ccvu1mnfU2tP1xjZp13fcvHbzB4ndxlj5T0n0LDPc45IBD50Wh0wqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2PzKH4CsWFiNIHfaUcSuejwJYITpMHu/dPGiVEv5uQ=;
 b=VjJwMsaL08EtF96yAtZr2hoPSu/A1d4OSRmDERHHB66LhR//6dUhRsPAceAO2GAJ794BXx5GgFYyizefWhwzWWuF69XLtj/nuaDGQzQeY/h2bLkAADVtqqYCjz1IE0PyvfeRL6OgGtDTFRngTliXQaJkCS+YGjyNNGZnCTk8oJWqcwmVkA/6BnA0SECIuWN/wHTLtqdMfKnXiskwD9YKhcY3+nIyCmIwtgrh+cVutg2OOXiG/tqGXEGlzY1vMMAhalZTzDYzsRYB/BZNBF+zci3amw0HBFn2/R8bgRrPp/x8poZZ3RiiEQO1oeKRtBq/YPg16SatDAhpDbTaUCbu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2PzKH4CsWFiNIHfaUcSuejwJYITpMHu/dPGiVEv5uQ=;
 b=HcDdmjsRgKcEcjMh1kx+cPT2K3QVRGVPUuxMw8q0feqk3FKevyE9tsuih58/gfPj5XA+hJcpTA0WboEhLrfDlakVaraC7E+BLwDoBsH12qGQ1BdoByaoy0wLAN+CBwv5mKixflPXsGlLwlvrzhG7Oxh3cR0V1ypvE6Z88E6Immg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 08:31:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:31:13 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: Documentation: fix compile an error and
Date: Mon,  8 Jan 2024 16:31:06 +0800
Message-Id: <cover.1704438755.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: df2f9a2c-55c6-4bf1-54c9-08dc10242cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wOD0bJGel/HkEoq0MxF3vpCHc8RIyWFAd+epEGIW0K38GVem1cYpQYKwTH/NKOILegsaa0DSjvOvJfzJZ4TcUxop1NHUk32eN/mnoGl7FkU22bNP7rrCS9riCyuoynIfJtFjFtf8gM/Fd8a1rOW6IDtkUtogoaZCVt/uFqUmWr2TvKIN9JQ2ehJ7Lhr7C6p03ih+dHWNACe6d8ojwEoNxSj3fd9mTolMuVlyPp1VB+W25OxMFj/g4jOU9psgXZ9Crf9lLHdWcR+acwOktlHH1kDhoVJVhlBYt4m0/kpRbiu+2wI7FiqaQG+4KrpMR0YGagqOcrih4vvdQ1PxhQ6GdyYrN5hu8bseqZAhXIBiURQ45gvRc4iYesTnFDFPiYSQ4lxXpGnbfuVJV80cHbLKR8VF4AZExOgot1qSvH8rNwpy5tMeK6DhJRIU8cUxlKF8wg206Q+RQ2i6LiyVh4eWc58fjaFpAuNAg+2Hgy4RV5y+DfQEnU7IpWJ4JEr3Wv1B7TNZS1o/xDxduqapqrI7A9Ef02GPDQTzXV+EQqqhPBlIY6Y2hWri/OzX27qGGN2de6fsZhojn1p+gv6ioIjGzHm3URfhobXGHB8woYz4OZNIH62UR0Pwmq3/lDWR37X5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(4744005)(2906002)(6486002)(2616005)(26005)(66476007)(66556008)(66946007)(41300700001)(86362001)(36756003)(5660300002)(316002)(83380400001)(6506007)(6666004)(6512007)(44832011)(478600001)(6916009)(8936002)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fwhAz2TMjtzkmXudWI+pLDwW/ltX4a5+JBP291UvLWMbAuUAUQVmYaQkqKFD?=
 =?us-ascii?Q?ByOzDcBEX09Gk04ywiHkjP9P1MepxIo8aIzeSrDQBKPVHVJmk6Dtdk9PrNZi?=
 =?us-ascii?Q?5cCFYMvvPCzC+7gOMBnz9OOvEecWsWRAJua3TKEhXEzDdKe18RRilffTVSfv?=
 =?us-ascii?Q?mwi972xXvLVL8XPwEG0BCGsldWyVIQ8cCJwDGDsn/8M7Rk6sYOlduP/i2+4z?=
 =?us-ascii?Q?bvS9mB+J4Gmy2HPMH6HfG0HJg6ioT/XB6RS8AdVO/ulWHbE3HWpp2Kh3Ispu?=
 =?us-ascii?Q?GPS+/le91+d2/O1fxTUZOCxo3xn49cWTEguvhP6XBc+ce+ZhiefvG5OsjVRP?=
 =?us-ascii?Q?SbOIBDZhSJH77FuUWk8RUAg21BtzLz1RNrHkG68iPBrZXT58xLfDrDuOZIfP?=
 =?us-ascii?Q?KsT7N9OWLuImqIoWcbgBi2XgujBp8c791XBLiuScA9U9FhnlWlrSabo0qZK4?=
 =?us-ascii?Q?nwYLVGQkyyc41AZ34J3X+nwWs9Lm/Pt3lKv7oIbdLs60znjVZDeinLyOvBtK?=
 =?us-ascii?Q?NFT5gEKMCUIO4sc9BRg51ywRY0gmoTYo++a46s5Rx4J6wFh7ZSX184jJ0szy?=
 =?us-ascii?Q?++qj2aVcF+68atH53JYa0xzQ/MJo2i2K7TfDfO4vSlLbaDkcWJ00KOHZtcLs?=
 =?us-ascii?Q?T57JitmR5FTfrez3n4wbTrtU0TTs/8X1x/po3DyXuwHo9a/h/q17BTZZT/hl?=
 =?us-ascii?Q?sEWVy7CDZVlrKoeUIaCn+EpNZsRXWssRrtcZbV7969EVaopfvoWkfSq6I43x?=
 =?us-ascii?Q?Uv4dSVVy9Fv5GxaQQEU2Lz38vhzCXoTIMfmqPVPAVhLm9azO754b6L9ITdVg?=
 =?us-ascii?Q?16ENIKtiS6pzv7teJSnbcLAW01idq5bH3L4Igpn7gfnD21mlwE6aPYKzch5g?=
 =?us-ascii?Q?wZriccYagMTeTTG/mbb+0S6N5wl0PdgWiOsPyQcWi5J1hX1zEwuxZ9UQ5XES?=
 =?us-ascii?Q?xC9v/+VAVX4ikQxcbu+5rUiCa7Tw84/a1UqbafXfxJDu40iY4m1e6UClx7ky?=
 =?us-ascii?Q?YLBOpn3Xr0S9JdCmk+tzBtZf4hPlZDhez/vzGSL5JdRJqwSvL25heAJICcMT?=
 =?us-ascii?Q?78LIu5Cec4Jss0H69Mz401SO2KXwncQyLPa6WuHvuFBbqfDz3S2+HOBYfL6c?=
 =?us-ascii?Q?B+BaIrx9a5rTAHVDn9NuJnwxgFkMqVgpzRiFSkgnRD0meQvVJP7NeV1Q6UfY?=
 =?us-ascii?Q?DvcZJYVKBagaAjrvMGk+mLSSUTUZhn2GbDPl7DqVr4v5gEUxBBk1lrullhTf?=
 =?us-ascii?Q?38z6rIRIzXSH682ZeuAji5njc4XQLGwsuZl5TlpiTSCfmeOfINCB5WJnnQS7?=
 =?us-ascii?Q?EGIVakOtfy03fjR0MO4GuNiVrPq6Jn5TDToJ1emp9FxIBGspnTMF+DuSH861?=
 =?us-ascii?Q?6vP+x6/+msyY3QAw70gFxM1H9bSIfy8LBFMqJL8JtUk1CD69nGx9AGN/F1Qq?=
 =?us-ascii?Q?DlNYPaISCwDoSXgd4vvvj6aD3sWS9pC9RcrN4ioZVEtAgtmaVNvhtElK6oVp?=
 =?us-ascii?Q?FgprcQi3iCZJ7bofK/v4f0WgV8q13zbKHIzAzIPlCxB7OOpFE+6udvkPZQhI?=
 =?us-ascii?Q?BsEhoY92f4WqnbWBn4ksovI81tozLwBqTRVwkJD/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+RNXEaGpolMdUJDcrmvthjTbplgkbUX0huVRM4mjaCCSSJEDmyjtmRe2DA6PfNmaWed109DmgWcdKl2v+PWJtf1fAOHW0sWfdxZyMzKCi/j8lNNxzqv9DxukJsR6l4nmhzSy9Q9VOWdoakvv9Xb8xJ2Wum7vNWoI1cArw1wBBAmx8UU3IfZQPwb2UfjSL6MSa5wdPf7JCKRsFyx3ZTVL/1Ek3OXsS4EGaP/sOykZR0g1muGBS/J7gmV+V+nqSeBx4euQrJJk+lJMm7azG7BpOkTyXBtYnm1xio2y/Gz4bZ5BGs8SzIdLvCizMbHBmrBHx1vBrCl7I0Z/YglfqA6MTPZU+HHcDz9cQTF0BAI9EpBjxYI1n5duWNbzD4H+M/c/68tLySMtDhSU1LGq8lYulFDPqtO080eZ9BHmwjtokfmpeIL4eHvnPZNpceNEJy11OY+pJCJ2LL6y0mGBRMO3VbfiboT4n3K1vsnquiO5mVM/7bKN8/9yjHW5Rq9qXsn57vSsMYJDE5XYSjsKYNTlF9hiO4PBAxDbNBwqALujipkeZQWZvKPpecIVQVOQYrjCOb1U5V2AqBrCp+iM6hrdHjafhXvzF7ymR60kgCA5jdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2f9a2c-55c6-4bf1-54c9-08dc10242cd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:31:13.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV7+goQ89P7uE5v85y8njB69+Me+UhNvaALrKIk4Qk09+hEJhnWOs4ZruGcWH1C45uK/decXWb1J2449DRB3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_15,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=737 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080071
X-Proofpoint-ORIG-GUID: WxwdHFBDqQ-3VqO1Fh5kEUbMMzbLCRkR
X-Proofpoint-GUID: WxwdHFBDqQ-3VqO1Fh5kEUbMMzbLCRkR

Fixes a warning and an error during the build with Sphinx.

Anand Jain (2):
  btrfs-progs: Documentation: fix sphinx code-block warning
  btrfs-progs Documentation: placeholder for contents.rst file

 Documentation/Tree-checker.rst               |  4 ++--
 Documentation/ch-subvolume-intro.rst         | 10 +++++-----
 Documentation/ch-volume-management-intro.rst |  2 +-
 Documentation/contents.rst                   |  0
 Documentation/dev/Developer-s-FAQ.rst        |  2 +-
 Documentation/dev/Experimental.rst           |  4 ++--
 Documentation/dev/dev-btrfs-design.rst       |  8 ++++----
 Documentation/trouble-index.rst              | 16 ++++++++--------
 8 files changed, 23 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/contents.rst

-- 
2.31.1


