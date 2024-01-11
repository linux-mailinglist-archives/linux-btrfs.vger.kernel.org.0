Return-Path: <linux-btrfs+bounces-1384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9C882A6EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 05:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB128A3AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 04:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D301879;
	Thu, 11 Jan 2024 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlAdcQ8Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tR5NOagW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780301118
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B442Sj009258;
	Thu, 11 Jan 2024 04:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=vhZXOA1JsjCF39VPnlxy37vFI4ZmGkvxE3kXWhFJ0Jc=;
 b=XlAdcQ8QJHhG4KTU/eTReVbKQErZZTErblxwlgLdKcfgOEh9lJ2Lp+Wz4n46tk8hM8jQ
 nuDf+yiclJN9mPlbYtQWspcZAewtShgp/WaoQ8z9tXGUc+wgUDPlIsbWee7bEnza9/yc
 qz2beQ0uTtTQHLlWUkGv/99fqTNlfxaFW6gtfoLSTr+nIQ7/qAHiiBGcPROkKKFloUL1
 RkuQtmRDgtebq/gm7kN1YBSZyjtgK8/QCvQwUwcCmKgZHSi1ApC5AZfsOTGIFZMhRXY9
 TMU+HP6cOpucA7wzCQAAMekRzMFP85FwQNc4LJQP5nM0bLtyIu5MGPOwebdiVe+t+sHc FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj4at0aqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 04:21:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B4EnVn030155;
	Thu, 11 Jan 2024 04:21:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutpjpg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 04:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILszw2zbi23gLUEv9XQaQnV+N/CYmqE2b61hZmc+jlAaWXxFZAcB9rVtyinvqRSWkldZF/LtuTR1D1Wd0IgU+ZqXtkVtGhfDYaK7eYZJEtAICv0cAldzkkEJIpgpA5GpSfb45lBiqwPE6jPispMXWct8jvg36oA+IDO7GqpohVLXx5i4oxukffJodb0Id3hWRXHPj1OFIMjVDWwZnNmO4I/ZvECS/NpvW+jpGpOKWwUmCeL7Ia/iR8hnki1y8Ao0Ph+70lMulh+vm98aU++0nPjv+hf0NCQj48afkLimm0UR1F/WTZHc8EnfVQdqoner8YdGcv9gEnWR1XXC6c6ccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhZXOA1JsjCF39VPnlxy37vFI4ZmGkvxE3kXWhFJ0Jc=;
 b=AxA1VEWZ7G9+2mdzw0xw3/XjdH1iNJe2UwyqEj158oY4aNVWIXqgvQpU9lVt4/423hOk/hjBfzCtbRetA3dnCUvXLPP7uSv20IQgxU144rbt1rfRKcmKgaYb0F9BGBpYfC3lEWY3A84KfGhgxq9KUzNBs2y4ShKmhyM/agIwiJxZlE/NCXuVK8w1T00uj+AEFwdZ3JCl0ZTlsU6vZJpgssW+FmRNu1gdeIMkDyq4ajTcLKO9aDVQtEKKXgXJ3xv8gC12n/jsH0YqIN0eEOhR7ef4n11un/90ZCHVnpua+bg+owIwjDUI6oAzlPr3ZVA+lgthBmBGnxEiv7IOWdfWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhZXOA1JsjCF39VPnlxy37vFI4ZmGkvxE3kXWhFJ0Jc=;
 b=tR5NOagWXmIut+XTKoCwTYca1lryI/8NV/JJQuW0tl9r755MadD3piegNycN19TGf+vMALz0FVF0HuZHzzN/5i2Goujc1dHjVsNNnuq9B7ePLMT4QoRe2sST4sbAAoTMIqcRb/WEzgBm5tH2A+PkDJ648wLAqIfDSVJ9V54+ARA=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SA1PR10MB7662.namprd10.prod.outlook.com (2603:10b6:806:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 04:21:10 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 04:21:10 +0000
From: Anand Jain <anand.jain@oracle.com>
To: dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fixup: v2 Documentation: placeholder for contents.rst file
Date: Thu, 11 Jan 2024 12:21:00 +0800
Message-Id: <adb208f0750fdbca06594f775eb0a81f886574c7.1704942814.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1704906806.git.anand.jain@oracle.com>
References: <cover.1704906806.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SA1PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 781a914a-2737-4da5-5a39-08dc125cbd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oJDFCmJIt6sjDBV5dyqhaldb7rWqS3hQiRGEH5aA+vwr5hM8lfjNiH0TFcYbW3EDKzh/iOtcbMAEVTfY2QeSpsoYxVcv6zScskFTkqWPtJBhoOzBeNgHKJ79ymHXzDDpAz1uFBN8FdpMAYyz5xudSe0YkLb+DZ2bjz4FsDmUtPbqoxG9ArTN0wWICh7T+XT1mUqfsTcjuTkmj0uuNBV3DnnC4Al3fjYEZQK2aXVsKzvNiX4bpgn4Ovk2ZEkNxRfxdbMu9uN4d4Ji4BYZBWwt5/hJPm3Q2y847L64G0Yj47mJVaS+2PyclJi630OVEx/UACXhDgbwpUZlBsfCyNPbgHs6/NbgvmCeekJPpi37aFjoa5d7V0aulBOv96Hm6jsYEDiQlP9+306Coe01DI6VInDM4y/ClOElwWzDKryUjzbUibEN6Dnb/pKrKk8XiOkHCJQpknGa/nAlpEqaM9vaeqf10UD4K8Mwxc7YPygXRS0Hz2Gsk1OatzwhkU6d9ZE34spy6wTSGSq4qjy5VKxcpF2DJf//HOTyQV/64+tmauEsqFTrIzzPaMxZi+xlnfmI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(478600001)(6666004)(4744005)(6506007)(36756003)(44832011)(4326008)(8676002)(316002)(41300700001)(8936002)(6486002)(6916009)(66946007)(66476007)(66556008)(6512007)(2616005)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MlN33/Lrq7ZfqVaPm5Rbl3mx/0QRjtRy6ayoBNp1cvUbzwVILjt2yzb2x/e1?=
 =?us-ascii?Q?NSx82QLwZ8yb1jj/nyEQuB3Mvaag7iVQ6NlJX1H8XIYhT05EgF+ehQ4jUweZ?=
 =?us-ascii?Q?9bqQsqQDJG5Q84MxYy5RkwMGYa++rpz1lvE6/fD8/5wq2/JQHsj+q7PfmuyZ?=
 =?us-ascii?Q?Gcni13Th5LXvKi/ETZ4jotAdfUoeVe5zPb8mw1aH8n12lTd2N2n/Yuto1qVr?=
 =?us-ascii?Q?xdJnA1Dd3DQS+kP7x1HVpbavE9X/iPONc1ziMtlfAwnq4hvGYkABcwAy6tLv?=
 =?us-ascii?Q?3FG+lqPw3abN+x8bD6F4mvkszn8DeFrX5hI5vpVTY7ditu1AZigk5WMiWf7w?=
 =?us-ascii?Q?UeYfhzYige/Y8M+KAiLyXFDOSmeo2ozYq8+WzGlLwROsHitXm4ypu7LRmoT1?=
 =?us-ascii?Q?F+2MiSRt4Br1fnoxCJgt/mE5Eg07Ujm8fO20tMqwLgKGOIN/aKe03Frv+h0q?=
 =?us-ascii?Q?+I4BKk51unn5QqfXYQrL4kEjhRpTIJ0EMOF5VZqRPYhIfVpCw9CIthrQq4ze?=
 =?us-ascii?Q?s89YO6U+Pkyb15cD0cULWclwAvYtW/dmJRlbfgT7TcDIAS1Pqyu+mOMFKmwf?=
 =?us-ascii?Q?BJnnWcVhX00Z9pqpsiquEqjXjoIpu502jeN2dYqbY3A8pk80ftjSB5NFLecb?=
 =?us-ascii?Q?VDOEXmc4ziQf42rqXEar92z96V7bHatXFUs1yKAGbBMnhA07ezfRAgsQLHtO?=
 =?us-ascii?Q?70ewZuI2uS1YnT+FCKw0Eih5OZltkkf+r9RSJtE96wJx1tCYW1YZYpEs7EEW?=
 =?us-ascii?Q?R/x/bwq4xZtC2Pyr95OEdiJ56KTJtaDWkTukDRrkcJ02syhIJAcAAa6PZzSa?=
 =?us-ascii?Q?PerF/XANh3OVCqSLhiAClcEjC1fZZXlv1j7cYlwSAGdvlazKrpzRC+hq8In9?=
 =?us-ascii?Q?gCTifftahhDPsIeCCM1VZBIRSRsnhsvrOhfVVwZtnrBXPDbwLNLaUtRsbRKG?=
 =?us-ascii?Q?lcRy3BJl6p4ekcmj8WBp2MCGefxf7m1M2EBAi6AUZ3rvV8rcoSxd44RvaN3G?=
 =?us-ascii?Q?s9gq6fX8PQhlsYg7qnecM59FJZ184+CF1Eq8dygjNyCO74fz4zOdieFmwuUC?=
 =?us-ascii?Q?udhX6HdFKnBwIIL3E2AHF+UuXB0lDAZRONNCIznfA1UCL9KZihhPdYTDrzPM?=
 =?us-ascii?Q?01M3kkLaUcVZGKb2gqN4SS8WIMOgEdNfouy8O7yTF1K81f6ODOI63KiIi2VR?=
 =?us-ascii?Q?5UVuIW1cahtYjIUCeCkHlRx79Ne+ivqkelJOyP/tp5MjAMV7A6/nbuOJ70Dy?=
 =?us-ascii?Q?exCdkHDS0j4N06de0uSTY/PWGA54eff/swX+m0W7eh18EdBQHPCd1j9m69hx?=
 =?us-ascii?Q?X4sariBjSJ2ho9UaqLoQtNaRHfXp7Z2z99oKm2wiBrrSUHT8dhvZwA0XZxKr?=
 =?us-ascii?Q?AEo9yaXJRmxlcB18qx7iLDw1rPWgbh+Au9RyTJcT54rjdu60UsjBlAaG4PND?=
 =?us-ascii?Q?QP9jI4fG30Ogh+P/o9CwpEksVNl574KHamqptl5WM6spwqRERO8khzv7QISO?=
 =?us-ascii?Q?3zdulHmMwwoPlgGryx0vUrB0CwowFSdDyGO9HMgR5NBO1QFy+747xFrlXfec?=
 =?us-ascii?Q?8vZvIPFJixt24NwpL3nyjT3VF/Lb9sBjkz0canU5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o1275vJAhmESMqMo2xgUcuovwSxfdGyCvQPpVrNpead0szuddXXWfDDQ/570th8fxAhi7iXyj11PXeeKClRCMS3M5tWsgpaKpqKWXtiSuEUJVhctZM+H/+LbvRuJfdPtISh7wsEYktB3FCRcVTULl+VAeivIP3T3hzuKJRelEPMnQ/4Kgfo+n07ZHgqdeD2u4AkXfi5p4GW56JuFq2snb99OeoQm7jSvwRzXuCDahT1MnvbKeSIiyQnOHR17Sd7kgQEiT8Aepj/DD7M1yrg9ZQIS2uDpowJxaagKHRTaGOQwPeTG60Ow/8BgJysIGLcGIH4PGLfvvSy9Nz0W5IuAVsEblMlYfADDuk9Oj14B7L/47WGDtydIY3386W0fig9bEe4DIaqSOvGPJxzeED5SfoWSmun86NrcnbkkkqLKOEv2UqZ2WeRmMtUIb3FtezF7XM//a9HgHnIxTpI/7uP8cFai+lBeaKlFbiDERN03bD/rTLKoi5SsIaae5HpDWFuuXdl7VpGnuGZoejpVeP820G0/V/DS6fCWsu4AWa6h3KqyxMwZKDHpQgmLhN7ptDds6zrQY705Iawwzou88dweRgGh/bJIHeEevEryhh3SYzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781a914a-2737-4da5-5a39-08dc125cbd71
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 04:21:10.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMSKqIgYU1enHqmVShxkGmeRDJG31k7RH1F1b27rvjca6sLUmN56qqNzVvl4RSVeZOwMrexAnAYWh0U5UDxNrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_14,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110032
X-Proofpoint-GUID: WJReIxuU6xIkUzgi4GpR5lbjXtedjPa0
X-Proofpoint-ORIG-GUID: WJReIxuU6xIkUzgi4GpR5lbjXtedjPa0

We don't need touch Documentation/contents.rst in the Makefile when
Documentation/Makefile.in is doing it. Fix the devel commit 7479e750ba65
("btrfs-progs: docs: placeholder for contents.rst file on older sphinx version").

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index d206928e9c86..374f59b99150 100644
--- a/Makefile
+++ b/Makefile
@@ -417,12 +417,6 @@ endif
 .PHONY: $(CLEANDIRS)
 .PHONY: all install clean
 .PHONY: FORCE
-.PHONY: contents.rst
-
-contents.rst:
-	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then	\
-		touch Documentation/contents.rst;				\
-	fi
 
 # Create all the static targets
 static_objects = $(patsubst %.o, %.static.o, $(objects))
-- 
2.39.2


