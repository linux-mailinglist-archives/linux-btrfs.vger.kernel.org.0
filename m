Return-Path: <linux-btrfs+bounces-2539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82C85AC6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CE51C22A65
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B79A5822A;
	Mon, 19 Feb 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IhKWNLYw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SSVTx67G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214751C4A;
	Mon, 19 Feb 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372188; cv=fail; b=A9MBxjZi/LLgCd32WbI6V550oyr1XHeeUmlmBBBBLtrqhnwiZtW4HUifkYlkUFV0wQUuch8fF7WfbqvnfwViLNj98PlZzy5ieZ3hQud37tBrleuhDU4RLlRKWYVnFK2pjbuLxy0VMJb8INF2shE/kQxBudVPXIS7Ekxq6hTuI8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372188; c=relaxed/simple;
	bh=NSo0WDtDKicxYT0gwgZCO5A2HJQOaSvKwQlF8X+UxiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miZXoBdqSvsDvo6mCuUirARd2iiSFp0V0hgNhjW0h2rpHRAPlqWlQXRRFt1uFFqgpUOxgtfE7uIzZHKo2yf43cgL+vPtDYgauBeDcR8OGVHO26iWq0Insekrh3Heizhp5gfRirkpMUns8nWQ91zwLwij09DDSEQzOzodIJl+KwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IhKWNLYw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SSVTx67G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJe7i006594;
	Mon, 19 Feb 2024 19:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=KAVAoq7pzsHjuViYDYOAOc2DHNwnu5xp6D5tzewYYvQ=;
 b=IhKWNLYw9dy1jcQ6im3AkvY6SiqZxbix++2ilYFqA499/QlEHT79Q3oA/J7M2gNtpaj6
 pZfcWKp1f3UTOS1eWBKfKmxnv3Mv78xZgWfZFsn273yGikwr6q9Y8RhyAD9JZwTsjKAA
 S7JYGwXrXS9hMkn8jt3m8by41iR0GCBEDN18jsWHdDRtipMVTcCuf3Y+8s/Te4ZkTwX5
 vtwhrRMZoPy+8wqeGHNz3a+FExOtX6VMbNyjbXDCL79/Jj33jDQ4IehuDonFdfF2hhQ3
 0vj7UWaPWBJTJL4TRvNNwO9k2iqI73LQAOvZ/zRBK3OLwuUgGfqEIoF1uulhV1aMPDSq 1g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvcwcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIIsAF037793;
	Mon, 19 Feb 2024 19:49:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86a13c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAcnEdur+3hrftImTq06uEgEEK147UPg9SIoccxLXgLqvLLmoD/TxiIscUbw2P+ZwlTT/nItfuFXsxo4snpX0HZwYk7ekhsD0sI/wZfluCqkW5um16mJMhiLMK40mQtrKGZOL5+x5aFimB8gJkue1lmyak0522WkGx8Ibw+67sjN2+LtLvnoYGZZDrTFVbLnMPL3siovqG0NnyCSUNeoIj2ZNRihWVYz0IE/mrrhh1MmfGfmcMr+EZcodzr1st7tzv5AJNCALZbfjJcTd4z6EQtHKQrWYypfUfNTJsKHJlxcaihHfgUkhJO7wlH0khGl5EMprHN/7oeoWvoUYdpQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAVAoq7pzsHjuViYDYOAOc2DHNwnu5xp6D5tzewYYvQ=;
 b=als2TMgwps9msbkVKBd4JWGI1eSp6ahXzMCbvWcm0yv8lPrq2wroeZMLcahSRrmjv6gnSbs9KUWSsKxrXQAYDaFrY1QM28UjZtjIK5jsi4GJT5ViypQ6RJzlJsggmXX+TPNgCt/XVlMmbY5nK7aBtCmpo5jwUaho92hHH2/k9rTBRPuuX00IMn14m6WrWkyJ484LADL4qUEeggBQFFqkeZynBdCPM4MPQNFwOeXd+O4VcVJ3UAL7yNEp+kXPfWOXKqzFgogpAEhXP0GEjpQ/dIrwVOgrqH1X2Ow1MUKDVl3ns856BX5xbAR8voenVQHffc5dJfq1NolxZ2zDE8Rxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAVAoq7pzsHjuViYDYOAOc2DHNwnu5xp6D5tzewYYvQ=;
 b=SSVTx67Gl+2a1Gp78nB5JGOK01j1nFuI+1GMZQzMKAI7eEeWtm0Qaxi+/e3citL+DZYiHg752JWg3W7bnhjeyEP/9Mu0/KykRsn9yrfjTgF4s0OgJY3RmRr4FUL+SZqus94v+XtHL7b/+AhfQwxfQpP245Zi+a1Bq8ndZktCO5Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 19:49:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 06/10] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
Date: Tue, 20 Feb 2024 03:48:46 +0800
Message-Id: <664d640d44d787f0b7c5cfba1b57abd2260b747c.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 9722cd86-da9c-4a91-c780-08dc3183e8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	paurMj9CdCGCzt8icQK/m0XJjvj40+SiKmYATPFnGs+EUVUsI44CrkCh1aCUFggh/0HFLSkq4WZP6SABCOnHLZB6i3ARcgMGVRe1Qn9xnU0oQk8aEYz9cr/fE76NH7/XzY8ta0dSnGTA4ZA7OWBHGT7DA5PErhmTNQ1ewRAx0rr2mbRusDB2AQAbM2H8hhs2m24EsFLlY9HyMOLhHEMDFoKeeutfSQpogNIvZ9Rv/zbe3NJNSwF+XODL4CWa776lKXvQNKLm8eZGEZzL6gWKXZYU2iDpxsIdeDwzW9QfvKwhlirz0H73ZMeftpzPIMvKUW5g5IsurXbVua4Y9L8hGepnN7q3cxFsrjo34PKwPIgai2OEUgKMRpLDq62Di3KvULuUnAy6Ale6hJPZ+/pcQ2cwl10GSrVWq4vTeMR8Hen+vvughCM1ZdFW/yboFGEPh3PJrMPs8X/7umxvXAATqnrCtsexedLohq1zhX6k0NF1Pow9IUtsJIWDqlLTjtyNKBDrqebcdtXkwB5D0j2IxYu6D6ZdrfkTa6xPgdW8oPw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sb+RAgqIV+LAbe9+SgV5oduWE21o50M6GGZ5+gxQSEv/QA1RcrguWArDk+M6?=
 =?us-ascii?Q?ACCyPbIBiX5fotS4GFpgvfW54Xa3Z8Ggs8If73W+1DPD6/3bAJ+KSDMTtUtU?=
 =?us-ascii?Q?js8yT2WJp2pihf8WrakcpKpuWkMrP8mm46nKkQrKJ2BnOvWsOfc0MBXoondc?=
 =?us-ascii?Q?x6P5xbZYyw97Orw8twsh1S1/+7gMsLlrYdYiQxCOG4KcPfuKlwLicipnADm7?=
 =?us-ascii?Q?mm/Rp/KC/hy0rOTutNa0Y5JFS98pX7fxqmxEvR29y0AjB2NaU+AohE1yPgav?=
 =?us-ascii?Q?/Tjc3agARf+tN+gZKnz1I/TSLNeVOqh+rLdnO9KKjZMHHWKLK77HbWNp3uxC?=
 =?us-ascii?Q?3JwGEIv5LIYlkBY0iBgas0haOaRSpUd3ScEM3P9+pK4NYTT+He5dyH0U7eCA?=
 =?us-ascii?Q?05+pP14mrYbU1EqmRpg3o/Qe/gj4PD/qnmX3Iv8P0p8RWczqGy1dqBiXptrl?=
 =?us-ascii?Q?Q4A/ptChkzV6az3HmAnPg36HorzZnYwagb0bDpotExxZ4rk11WdMyO0z3TsH?=
 =?us-ascii?Q?oXF/L3pm0JzR0CpdjuFEMpdwn+NoUJbsT97k2bgdNQPeLdhym+1UTrC/W6zt?=
 =?us-ascii?Q?0aBjh6SI11ZP1m8uIZZrE58a6LC78LexWH1AVUZOB0Qo/g2EG4flHTI4ttuV?=
 =?us-ascii?Q?HAblNpikB7zrz0hh0zXgn3LoXbRItUHf/ezT85z6GXE3VBPV/dG4K8aTgj4d?=
 =?us-ascii?Q?YXOcD0utkaXgZkJG1PWKivWph0uJyNBPSiUsuuX29kTVIssVYB6bDiBnp8+g?=
 =?us-ascii?Q?uQaorxD94MWrFLP0y/uvD30DdTsOVXHPGqWL9bxeypgBRx+pXsqnzHE7oPE5?=
 =?us-ascii?Q?H56KERzHvyjfDYgNJfSEy6CVAAQsdUFTVfq51BU5DXFQjtzAE1sUTeSy9YdK?=
 =?us-ascii?Q?CIhmaQc6DwNAX8RE0u1QwbXeTqRmeNzPAu2JJUWdlKcoW83jt5EljjZcl8mV?=
 =?us-ascii?Q?8okAAMgWmUW1dFI2X+tjWwmJTcIaElV+ftI0nOWkbdng09gMj9B1N+51zX0R?=
 =?us-ascii?Q?37+PxXoINFOKavEH0EP6GTm1b3Mf9fC6pE769MLuyC0NNgQIGg2gfijgnoZy?=
 =?us-ascii?Q?iF5q+KdgU1OdcIyiYuINANm5AFXDUu7EHYccAHsxw7ItxyaR4SqZWLyRIkdj?=
 =?us-ascii?Q?RAp6gvUjmHO78siP48jgnrqiMDvoho3n3adYbExVoZxXPDVJSHySPXMQ2L/T?=
 =?us-ascii?Q?nIBip8b8MJVaoJSm45k/H3Kki+8Ubmq4tYun3cC7yqhMohuV3w3KaihD/Quv?=
 =?us-ascii?Q?lc7b3fESizZiTZaKbiFM7jK5jo8DRtA747R50hCaLvNn0JwLxdwZCQbNCXY6?=
 =?us-ascii?Q?WXiNQ9Dant3p/dS1BOpdk0nol3OdTerwpy2b1Ub9EkGRP3EQmfnqW8XF3KVs?=
 =?us-ascii?Q?tX1nfjdAwmnaFiNziU9guYenR/t40gqkaPQxrjDZYb/cMVNeBsjMskC6U10D?=
 =?us-ascii?Q?AluMMjFTaMc8S87W+Yo4py1ERp/ddJRIScqvXV4AYOkOogYeWUWWrhYsP4Or?=
 =?us-ascii?Q?Ymi81QFNR5ZET4X44TuLTQyHluPhEFEuBzu4Z/Ytn+Cf+ylZazIkLllEnlvi?=
 =?us-ascii?Q?yGwROChRJJe9V8EaVOq8GppIpbpq40/l9XpExqHw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yRthX/+sR3ZMSWqlPbz2VuKUkqzCwCoj2iYedUpoOrsQKfFHrjnjCma8UfXbAezzwVplObcozy8/34kNqQT/ebjUjv/mKw7SN61zUu7hk5FkKZuGazJOpqKe+ve4BJG16UuWuCNUGgFJpp60b85qFPNBIpselsHxBF1iRrm8K4RQPdGGTIpcTUQsfe5FdZlyrmPfHrZ/mtzMybU3M6Z+jEN7mhnj9wYCSYHwspIpV/8+PEp2ys48guzTdTu+9/HCieikv8ZXtqWmCW3cvlTqsClFLRGXt7WLg01tSm+ytUzixpLVTMxAcgjqzvAaHCW42dUd758E2vUP68vIjWZG8r3Zjfs2MsnWz+73cJ7CHDV5zj2GCvMPGIsJaRzP+GQYZe8NEH0cB5X+goWYwe5x601dKTp4xCYNB16Z+w5J6eWhjdIHDEhnEo9f0iYH/U6y08aj1rUJ1OaKp6BSRiVYkIM/HED3oEMqrCJrsAwN2JR21OAZaqYti7mnHJGTLW7ci6aE55BzrWpk0qvz5zGRUF0Ne2xeH5K6US5bnEiZClWhxyYIaAnYWI2aRemBeSkvn1U/Usfgf6tedCURUW/TMo3OsePGuwB4frqBErvijW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9722cd86-da9c-4a91-c780-08dc3183e8c9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:39.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr+lrevMUuN/iDspLPUVRO346xrQ1r1jajATxrDQQM9NnT/qnpLAnsPDT3Qa/g3oLVmT4pQCzm/BnfO518ytvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-GUID: tOWI2QL_HkgnT-sNF6jBEXc-Od_TwuSn
X-Proofpoint-ORIG-GUID: tOWI2QL_HkgnT-sNF6jBEXc-Od_TwuSn

For easier and more effective testing of btrfs tempfsid, newer versions
of mkfs.btrfs contain options such as --device-uuid. Check if the
currently running mkfs.btrfs contains this option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Fix coding style, add space before grep
 Fix typp option -> options

 common/btrfs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 797f6a794dfc..f694afac3d13 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -88,6 +88,17 @@ _require_btrfs_mkfs_feature()
 		_notrun "Feature $feat not supported in the available version of mkfs.btrfs"
 }
 
+_require_btrfs_mkfs_uuid_option()
+{
+	local cnt
+
+	cnt=$($MKFS_BTRFS_PROG --help 2>&1 | \
+				grep -E --count "\-\-uuid|\-\-device-uuid")
+	if [ $cnt != 2 ]; then
+		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid options"
+	fi
+}
+
 _require_btrfs_fs_feature()
 {
 	if [ -z $1 ]; then
-- 
2.39.3


