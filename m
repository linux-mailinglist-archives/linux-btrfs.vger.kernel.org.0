Return-Path: <linux-btrfs+bounces-2897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A386BE87
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D7F1C21C50
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143ED3770B;
	Thu, 29 Feb 2024 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVMcPDy8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ako5U4da"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB8376E5;
	Thu, 29 Feb 2024 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171482; cv=fail; b=bfx9zxg5qG8EsT+0kY9D4ihk9d9aKwfT3uxrqxabcsRU7iK1GI6lEE1gxlDPLR2YeFdnHyMejboa4iukSIMZKC/QyYKjrTvO9VpuUFTt4Z5Kqqhq5rsPOsXFD0oKyjW5XCpS0S1ScksOk76hEcGss+wJCss/o7P0woHtaT+NuFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171482; c=relaxed/simple;
	bh=H8P05pTJpEr9EJ4neTMrXkg6cn3EbvrIFPECcH5SmT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tGkd4CpHyc09DDF2CDYHvtuunlihUGxj/20Oo3zatbqGPgm++LmBEJhGDWmcZbTNPLbj+nyQWkLs4hjLC9gDDqIUe7k2is/8n2i5uN8n1PABJqcrR0f0zb4eeLVgjlRgpso9cEQDmgww6EDKES5eRs6j45jl1ohmnlWRMtAgXQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bVMcPDy8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ako5U4da; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKItRw012815;
	Thu, 29 Feb 2024 01:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=OTcfKAj8wCaLnmKpnfi61eLdeMWXzRGmWmU8TBAW2mE=;
 b=bVMcPDy8YZsPlyc1weIJjT4SpC8u5Egj6Xx/mS6H/rwU4nbhfIVNc72lbVh4G04YEwXJ
 F/Y/fRZL7f1VUZ05a9jVVy8jw+doDN/6qwCr03obvuaVaRFGqrAAA2csaARZbFscNI4Z
 F1MngpXpyy885hxfLgwaczFWBUFisIxY5KbnnZNXEXOH7g+6DDvoDKPb8mYobWlCSTAo
 4zWJfNcAm4YJhXQbMdYQoS7X8NWMlqJquZVk6p+ywcV4QUurUUBXuOX/ZH/5+7yrq9x7
 gtBTKwvjLxVhDkQ1Ehq56r/Wf7CBHK+mS7UcRFxp9arjJPHB4Nse+1oNJXx7T+F1qTCZ EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784m5jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:51:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0vGwV001669;
	Thu, 29 Feb 2024 01:51:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9tc0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:51:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB+dU3eM78sdyngO9q/WMWsdxa1GejQA7IyAvDUiLf0q8nsBp/j73FfY53eS4FXVz5LLKUigQCbIymUsbO5KWP526Wz23PDymdno36351gRq2LIOnYv8xrHCQ+73KbUKWWMo/wZbxpEANLGnWZN9LfLXk8AN9adQRvr/8pFdXsQRk+TrY4IZNYXYjsZzqW3c/v+Se3wBbBh+ZGuEAUg0EOs6lm1KruSm07Fb1YfveItgvC76a5CtkF6oI1/xVzn7DhL0Bk57SN8UAazHb09HTexZCRLaE1JVDlvuY2x2BTT3rpf9oH7yzPNm8+Qf35v9zl1TuPl78uoHp/Zjs7R48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTcfKAj8wCaLnmKpnfi61eLdeMWXzRGmWmU8TBAW2mE=;
 b=QzqIb7iiqHAzVv2TW4VnnXlGExRGeCwu8L5U6tCe6Snpmb0M9bqJ/Da+Frw0bDQ09jgXmhUSAIGw1MTN5m4/ucPDeg/FRIWltrAo2EF0xPh1mlVnlc7XTX1mjdj+JXaH11QFCTTz6vuwFQAE2IIyJGJjuTJiLSI9Iwisqblf16orTc67+FY+U5s7O5zvYhvh9tWy0QWFox4r7st3UV4mXyA/s7DhrA+r7lA8fWkkkhIoBefXBMP+/0eKvM7klfo9pRhDouAhWZsVlKxrNrLztSrI4rflUHTOYh8Xpd+KJn+qSnfM5JXi4pjOj0+zjp6SatNNOD5VB2OMK4aOHQcViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTcfKAj8wCaLnmKpnfi61eLdeMWXzRGmWmU8TBAW2mE=;
 b=Ako5U4davEMXJ5G0QHfOkEx49gSiNd77OytUsH9y5N4iab28xL1AMG4MeE4ivjykTqZ63t8XNEi1n9vLtTOoJG7zUMITPwWovprzSTUqz459Glv0mKnNffc7V259QkO7kO4v4AE6w8X3GtEwv/HKz8nPcM2rSWZkoRso3wAm2Lg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:51:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:51:14 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 10/10] btrfs: test tempfsid with device add, seed, and balance
Date: Thu, 29 Feb 2024 07:19:27 +0530
Message-ID: <f5c5894f51e8d19f292f5fb7df3976e397c8e4eb.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e75dfd-acb7-4c2e-c8ae-08dc38c8e9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pNL2XM6HlZlKQGQAYbhSz8QJT2ivojuc1ACxPr2QPfNak8+raAYp3lRkLlpGOxm1G4gu0oTHq1VJdZ/cuu+O0TFhdpjVose+kun1gjENUw/g089SvM2obXvkd507i3OXtnR8sulUyxJpXsAQjg5mE9ef4zqt49lH+X4uMOXzTCJGaoP14qKbIboxsmlGZYgKLGIpcmYPYWn1ruQpXDTSH0S4BvAhncVBKjjHsM+6saKStANiMSwA/HO2bbM0vZtXgSiGbTGmHyLaUEV4qtkHGgLxTmmb8yaPAzXLSQtRv+W6SSe7azKbZeedTyFYjq+qFSaawPqGk55J8mQxXDOMXaKdL986j4tDMq9fuXTtuQGIUQ+I4IedpLiOcT1Da/FXM90uQvRV4t+Yk/9+rqNV1mHSLB+iX1Wzv5+xLteYU72R9bGRKDfNCqZLdWg1CNSmBjON/+GHGmDBazoWTgprNWeJ16j/IjSQMSWMucdUqSsx+YIHGkD6Y5b+OjEWGfkBY7Jc7OxEfKseMEbi5ukVSnyUvpVl/gr7DkGA8uqC3C0jVRjEwHi55uX4WUQBWc+Jj3liElry+qmhGMQbX29aeVjk+vQxKA2jHrNQBmND031iq9miPD076A5JR8zB7TrT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eKnWBxW7W+4u2kWoO652l40MmRLGymNvhS6hCOdZC4YJT/2SqbbmS/Bqhko6?=
 =?us-ascii?Q?g51RmQVWAiWtsDkWIOZ9rkcBe71YLUieTlU4qb4vKn/MH76n+lRzo1814eNJ?=
 =?us-ascii?Q?MyT1jYyq2cAadzYf13WPB/4sf2rf5GGDX4+kvLCsu0S3R5Q4X4HqrKcLDX5R?=
 =?us-ascii?Q?HHG6iIi5fz6ccFDdVqoqALO0SmjFGOMoIxkC3SIe5WxiKOEAGoqYIcR6hZ0e?=
 =?us-ascii?Q?P0Lz907OPlBTLLl3O81+5tbFYOlsBV6rgP0gIWfb9RljZ6Bp+KpFtP2V/LmB?=
 =?us-ascii?Q?aG2sVKLdjAtkY28FOKA/L7KmeRoVGHZnWgemqkzuH39LEg7dNnUaSSS1oSG/?=
 =?us-ascii?Q?Dv4014sMLJXr9zoLxaKYA22ZgNHk3kAgbNKM1vafbXC5fjimXdr6b35eejS4?=
 =?us-ascii?Q?sM/D9zukT+hRH+ljMvGbFcRI9xD8X9peNfL+ecr8hIeZxzfcS235kI1i99Va?=
 =?us-ascii?Q?u5btIrrXQyZkShG7WB0BaCVJNZP6PB6CADe6H/SF89O6ibtAj95G1tretqu5?=
 =?us-ascii?Q?ZGCnAgRF3AoPiDa8GzlEbmJzGSDzlN37VJG6POkNxnWC2fHltvbmxLV00CLG?=
 =?us-ascii?Q?TYyqcJsWjxEYdFRVgonINY+OQGO3SvOoz+kbIjckiC3cDt+Qb/WopvHoOcPc?=
 =?us-ascii?Q?uZXWxm/bwDdnWEacd5ubZzvmVfym4CR8rNaouBnIio81yzX1dcvxzvWLal3o?=
 =?us-ascii?Q?EJKFN0boUg6wXoRm5gi6M8mZCQspa9X34rL2yrRhO7+4NZqPLNxeoCJW9IuR?=
 =?us-ascii?Q?L74QcoLhG6qU3htgFUP6RU1QdQ0yqmvB5ZxtKPQJHcsgzLx0/BnMnZsupMP0?=
 =?us-ascii?Q?XxRKb5bKzH02hrTkk8w15v0rxLbnFvzITLKwqIEB/s8jW7+CqKP7+A1Jbrdw?=
 =?us-ascii?Q?CgdR4Wh6h4QTnpbXtcp0UW9kDCJgtdfI5LYqQTTOCmbHub8KB5IfBnCrEMeQ?=
 =?us-ascii?Q?S4wIFYAs2YP0FWHkn6ZmlVkrnEVM3SiXMU/NZYoc1GgO+LM1jUN49H+lVq4Q?=
 =?us-ascii?Q?5ZAQD/NaunfFjbj7nknAKdJxsfdlCaXPsefmtm47keoBMThQYpgKV49P3nzM?=
 =?us-ascii?Q?28ajqJ3SO2X6PEfy1nBMZFQhn5rBVgUyPsYsJl9DBEVdHKdmG5TdtVaJVwu7?=
 =?us-ascii?Q?TjVEV6gsQXzbjyY1v4qad634wR/FYUqyx88+H3IUq4pjIgJEVxmNiTVqQNI+?=
 =?us-ascii?Q?a0PhdA2ioGkZ1x22bKIJ8m30TgUn0KcrSRfRe4dIehAIjdXS/w+/lhnQ4NzX?=
 =?us-ascii?Q?BOnZElihKRq+ZisevB0FYgIfM2xuxOYbv6bpCBtsHYnUiKxyuDUSf29wASy1?=
 =?us-ascii?Q?deDYhm/O4elHwI+SwH9I44f5yNEt7fW7RBjrWlrvmK9rvv17N3D1Psmj3Nwl?=
 =?us-ascii?Q?ScZ5GeK1FEdxBYekETHyumEAXTolTNLG6RRXCG8dlyRDnjKkp6aLikKzkJQ+?=
 =?us-ascii?Q?/i/A+jn8M/QrxSUC1dd1ZSnk9uwJEC6GV/ptFZbgXqN36qgIF7KWm/oEx5LI?=
 =?us-ascii?Q?ZhI1CQJ9y1JmF2ktp7qlvlkl2TclcyycRIiL9h50xl1CPaWPmg9FmCSvCvsr?=
 =?us-ascii?Q?piQr7P9LiCv9TOmipDzmZuR/iG/GdrAtfpeLM5vb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i+HlJEWW1oTEEdSJ09G2F7U7dbxV4l3y7IRE8wBabzyEPOoVTBU1ihZ/wg6g18Z+Ye36SG6Mr5WX/erbwASMUPfv7Ra8wmCfE7fWHhkWFDl2bRdTGplL/wV/MYegQ1oYE7JSPR6+MdpGlrR+b2FM9y76i8XXB5b3lJrLuTYxp9tgT46hOr+l0v5Cg1jsjWvZ6ui0DAf9+83a6z8jJ1Qvhkpu57TGyNxOnKUur6ldpauGkeey+ET5YSJIg2R4C59OfYeBvfOLdIoYVVFnv//cVOX7O05KcJrvlCFj/FPSmogMlbQPuo2G0hMg3Xrvt4gO3UQPk4b6GYKMs1eFxkoiHRcSLVWIARccHnxP65dpDE7x6iT904Ks6gAr0w6MPyYAf9RZ+Bg6YGf14mU17z8eMSsGeq0audNJ003nL9dimVbHBl0awv5XYhk8VpkXLEsr4MgPRE5M4tYOyekA93Imzzzi1uu1MjaZHJCP1QMKUiQirN9uW+pKvFyLZ5Yj4VkQ0EaJC+d14WpYNMK/rrdZMFqRGu94d5YmVhePGee9qOU77SV2gy0zkD4xhMsGK8jjLAGiha3MyviVBQsYn/GgXpLumG5F9MG2j+YVjMZGyWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e75dfd-acb7-4c2e-c8ae-08dc38c8e9af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:51:14.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApWOjkcElb3Fhog8gn/NQ05nRdV+aJqILgcw3Hizf2xCsvFwpW9I9UqMEhUPLQEcSjh3N8WCk54JB3AhsvOxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: mBvEUBCttnPQDmmfbV0XmrlZ0hjCFhCK
X-Proofpoint-ORIG-GUID: mBvEUBCttnPQDmmfbV0XmrlZ0hjCFhCK

Make sure that basic functions such as seeding and device add fail,
while balance runs successfully with tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/315     | 91 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out | 10 +++++
 2 files changed, 101 insertions(+)
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out

diff --git a/tests/btrfs/315 b/tests/btrfs/315
new file mode 100755
index 000000000000..7e5c74df4316
--- /dev/null
+++ b/tests/btrfs/315
@@ -0,0 +1,91 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 315
+#
+# Verify if the seed and device add to a tempfsid filesystem fails
+# and balance devices is successful.
+#
+. ./common/preamble
+_begin_fstest auto quick volume seed balance tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $tempfsid_mnt 2>/dev/null
+	rm -r -f $tmp.*
+	rm -r -f $tempfsid_mnt
+}
+
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_scratch_dev_pool 3
+_require_btrfs_fs_feature temp_fsid
+
+_scratch_dev_pool_get 3
+
+# mount point for the tempfsid device
+tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
+
+_filter_mount_error()
+{
+	# There are two different errors that occur at the output when
+	# mounting fails; as shown below, pick out the common part. And,
+	# remove the dmesg line.
+
+	# mount: <mnt-point>: mount(2) system call failed: File exists.
+
+	# mount: <mnt-point>: fsconfig system call failed: File exists.
+	# dmesg(1) may have more information after failed mount system call.
+
+	grep -v dmesg | _filter_test_dir | sed -e "s/mount(2)\|fsconfig//g"
+}
+
+seed_device_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
+
+	_scratch_mount 2>&1 | _filter_scratch
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_mount_error
+}
+
+device_add_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_scratch_mount
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+							_filter_xfs_io
+
+$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 2>&1 | \
+		grep -v "Performing full device TRIM" | _filter_scratch_pool
+
+	echo Balance must be successful
+	_run_btrfs_balance_start ${tempfsid_mnt}
+}
+
+mkdir -p $tempfsid_mnt
+
+seed_device_must_fail
+
+_scratch_unmount
+_cleanup
+mkdir -p $tempfsid_mnt
+
+device_add_must_fail
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
new file mode 100644
index 000000000000..3ea7a35ab040
--- /dev/null
+++ b/tests/btrfs/315.out
@@ -0,0 +1,10 @@
+QA output created by 315
+---- seed_device_must_fail ----
+mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
+mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
+---- device_add_must_fail ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ERROR: error adding device 'SCRATCH_DEV': Invalid argument
+Balance must be successful
+Done, had to relocate 3 out of 3 chunks
-- 
2.39.3


