Return-Path: <linux-btrfs+bounces-2719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47976862616
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1120283198
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96628134B4;
	Sat, 24 Feb 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPqpuUpF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SCPjtUqm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207E4C624;
	Sat, 24 Feb 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793069; cv=fail; b=O9fJma/li9uCcjERQx7ESkVGrDM5F0G1/Tr4C6deEfAcTJpAaqNoLsIuTnvBR2SkwFcv4bl5xAd6rrL+SMmQEvfPLZglS+uq3ZFH/qh+UOquXMX9qZV/ZDKq4oLVr3uOXb5lsVrWC381YSxyAMt+VV/VnKQATdOSVWf2mmVSv1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793069; c=relaxed/simple;
	bh=TEBPT50sctmUGDhrnpgDxl/RDIgbuWixdteeBK+Y8q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPh2cOqmEZ5k227QP7qanQbqaU+fdXvRaNW70lIOWSDHlLP2/pKpCMXgq8K4c/ysY3DLNKcSVgVDaqScgkx/F/aNgbj23THvUoFi/Y3Cr4dsG+IFWy+XeYjkdHS+jFxhKPax8xPeSfs2rzfWu2CblmdiTmy6rBWuRIuuwSeMb+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JPqpuUpF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SCPjtUqm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFT64S020715;
	Sat, 24 Feb 2024 16:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=nYG05HgIVrznb/Yaex+6irikFnZwv2GQd3afXAeqbLM=;
 b=JPqpuUpFkBOM+JeDuMlLOpwOGXPF/1ewku6sIwY3saOaNVC+tODaTLQtxKNfpPjob5YI
 2TPmtTExDywF709IWw1vviPY0UnbFWWROg+83MxmO+Ox5yq+Q+hcERnwID9zamt+Ww97
 BKvbI8112lD4xthCIk4A/5ccW2PZbhWD+FNSh4RVTOC+uf9N58swMBalcAUF29nztUZx
 /SP3LoUEi0CPLvYb6Bx1Mjr85eJd/cRJ8wFhdHWjWBPU30yCl26qdxFI7tG4BTE6jwo8
 oaLEXT0ZVbZVmrBm8hEsG1o/COLZFLIVdSRW9IvodsBMewyuyT4qLO4Ar1CMdFa4icWZ LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v1104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41ODqjpP040828;
	Sat, 24 Feb 2024 16:44:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3tv4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agB4LcKwTQDx8TdhJJ3+avsb6A2qmqNoq6DKHW31Xo8XITpvqqihTCOmRi+ICe1vipSXdJeE4rd2jFDUSQr2WaQXs4tYUKsG30nDHS8/05S1tm/Wydn3IvC8JSZSeI/Xy7Yo2PSvVTPbzxdSgwkIhMccd4KzKUNXVeSgxeZ227VF/JsvShacGxv93siVM7VGo7tCybip7WWzh7P0pszpfvWvC+B68oMUJK2Q5gsD9pwOov7L9pxf3rqFkeIG56ecAvYdr4NWs1cFWgvrYFimga66DV7ckLPtnDgTIAabpCS/061XO7YXPyFerNCWJiWnzUvaXrRCUGEN2Llfn69R0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYG05HgIVrznb/Yaex+6irikFnZwv2GQd3afXAeqbLM=;
 b=aYuh3Bnn7+MhqA7g5CVTdIDAy/CSTrOywRTEP5znFxiTeijgqRRbFUgAJtBZuQ1+LdKU8yEpwhSthwNTedtqhTqA+s4WVlR2SoOTt2zkKbe8fGt9dYTBjA2S+PCMnBIjJHen5zLLT+obEXF312XDYZwwxP/vHP3pxb0fsJ+x8ThTZkrhmKks923InQnibdj/QMbLGT0xOydydwKU75A2dg1c0QDGXgmiyjBCeP0bOkOEZt4wxuUZCGzs6r/tWTuyGS522lmS2uf5dEUP2kIPiDCiSGi1tKXNvxQoTBugKUEAeGlCt1FHgwf31j/KDiuSBfn0ZIkXcL8wdaXKoaPwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYG05HgIVrznb/Yaex+6irikFnZwv2GQd3afXAeqbLM=;
 b=SCPjtUqmauvfUZiZtVkTliILt05/HZ0L0+iH/g2t9Pnhd7fk5oCizRYTJU9zeizE1x+H5bEICUfCENErleiY6SZ5ICg5WQXlgu2TXVD+OKYXcOR7Bv6PHwbCYsoPcrCI9vYRERH1GdZKpXjo3X7gUQb1QqcTcjlJI3ad++cwW9k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:44:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:44:23 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 09/10] btrfs: validate send-receive operation with tempfsid.
Date: Sat, 24 Feb 2024 22:13:10 +0530
Message-ID: <afc075746adfa6c6c9b6cdc73387606bc33b6933.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5fe74f-2aff-4481-c6b6-08dc3557daba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ffcx/ORfLtvNB7Yz8TSacpbBewgUva+Lnlp2/WLZ+6vQpaJupwjnJ18X/NiidTnWf1jm7R+WWLONFiW+135LVjaUzjt37mhlYH3dFYLcaT67SfCcFfWCRDPrlxNn3olxtMaeHgVhd/4J/iNzlNhFH7O64m5SkeuNI1RqGJxS+MRS6APrRzQZ2UrAyBYU+xRNjdzmct/emhGFjvhm0b6MlbM+Xt6mOXsWpBeYFlERw7fBJ9OmKjPhpH+ZoTImhGcG3H5QbfFrezf572+y3DlJsvTVgqylAKGG5URNIrvviXf9jh9CdzPHiADxb5v0A9UzH7zWT+ddKg2lB3QXel7TWTyq6knjBfJIV4HFoKIFMaxWDQCoZfAUtMJap0Lw5mWmAn0tVS7FZNRrodsZdaV6P0/MexMc0dnDu+TTMk3ZZA+23bJoO61RcO6an7CCYdZBSoZH8xnvqfS8UlSYYF/j2Ek+jHNjfZMS0VBEpFtnLG3oA856Tfr7CCgs9+k96eIgx42JTmNIsH15haQOhVSGut9bg1P+bbHs9gG/ndUv9Ao=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TAMVrTrxl0uGduBYxXr34TxxgYbzQM2MTf9jmX/QBqZe9W/xlcjalqQnU7eu?=
 =?us-ascii?Q?/+1S2pJwt1oINjy3hHryHSB8p4IwMfbyUyj5+jwsHbZL21cu/0XKO5lWpWq0?=
 =?us-ascii?Q?bzjZmFZJvEG92X7Ah+7O7aeTJVW880XV51Wq46CzctkCtt8BL7WUKH5mnu0R?=
 =?us-ascii?Q?SSz8BOWhO8H8mzV8qGcERn6qvnTpGpbidkfBDROUrb4K6vHRwDbMCMy0qv1Y?=
 =?us-ascii?Q?6noeWcyHh9FqOWutf6FNInW+D6AaKNQ3tuIaGkOp9RRJwANHzczCoSumDv4J?=
 =?us-ascii?Q?ugll2LbH8DAhxgHCCK48R206P/cLgLCrFWxNCCp8X41D8zVFDs0Y44xy4m0u?=
 =?us-ascii?Q?iM4AZMpg8zFx6VJQPiC1vQsJ1tXGbuLTO3gf25TzWOhAIRQK6i2wRVWFkUDZ?=
 =?us-ascii?Q?13ZWkizE5RswFPzyufdxQI4vgr+nZLqhXOEyfn7E8nZ4jyFiw4pHsQxYoAQC?=
 =?us-ascii?Q?op6/5BEDaTVt7qnK8Ca7k+tgOKrHsYPKr7LR8V153bfuY/1ZPkWOYhBFyh1o?=
 =?us-ascii?Q?IiR0hzJvd9Ez003qlVSGzal5j1DYvwfI0vC3jx4sLAT6e6Rt6Hvl//eGYBYS?=
 =?us-ascii?Q?eGf4nCay4GcK+0QlssQDEdhLgC3EXnXJ4quMWI/KLKeDPdvygjRaIsAoFz5P?=
 =?us-ascii?Q?3BCU6eyWFPZiBLqb1t/ukLHuicAPoMfrnVGunF0m/+6124vb9JJX+BQM6/tt?=
 =?us-ascii?Q?caDOXmFHXXtZGsQ0R5ETCZRWPHaOmaqn2b+D6aSAzWRLarjALS7kvYd40A2B?=
 =?us-ascii?Q?lamkPqBHvDQsR/EhDfJDuUTEIKvyYRmxpvoGEJJTTpuVncn6zw4NJC3RgATB?=
 =?us-ascii?Q?SoHLdZWR7q/jHvZpT5yY5OjTAvgyQRyfpa/ADFlSPEzdYiZ3jIOWZtl/lfW/?=
 =?us-ascii?Q?XrlrK8slMUUcEAubzooRg43pvIIH6COmZZH2wgw8PEkDVOweOiqllE4devNv?=
 =?us-ascii?Q?NxOMbLNF3f6H445RSFsrf1TCAHKoIwN1GsbU3AEn1rv2tN1sOWymCi6cbOa6?=
 =?us-ascii?Q?LCB/nMWhprts9QzO/ZNXqrYc0rZOrVAwhYQSaXD8+lJT2t47WS+g6WAek65b?=
 =?us-ascii?Q?uXNR8Z5T9y6bSsdtJCDR39kdSQTsR7ffJYGXmI0Kpv80flt35SnbN6EcOjoR?=
 =?us-ascii?Q?h97juNNAOtSHsB3AfhsQQL9xr44XOJ5xM2o40ex3LwbCyEwl7i14mNEUDC1U?=
 =?us-ascii?Q?axVb0im3wiuVLPL58lBsfrTWpEryQGPDzjeP9hQ2hX2kPE60h2kNJZb1/XDt?=
 =?us-ascii?Q?TdKzT0NOAkn3U5lQziZvJvqv02dcMDS0H97BD7LR41oqArO/k5g24H7Uk6AD?=
 =?us-ascii?Q?YbW5pwu8Kz+MzaLnhNrBcKlpGrhuO8ao7dx6uVTEroMekQCNn3H7I2MmBMcJ?=
 =?us-ascii?Q?CZgBBkPaK5HRffMFdPQxBlV5+v4A7WmNBYX5Jt+WTVJvdy8yVgAfyW7xedKb?=
 =?us-ascii?Q?mNQ5QJv3+Sb1e0D21z6MDG1jWupunLWqQTic1RMbkDaY0JZDnuoBaWcafEP9?=
 =?us-ascii?Q?56EKrlpskDFKg30N9g7amxy1DKlGGg/XPZWp8o0/ugkJpWZ8c7HZNRmhKyLf?=
 =?us-ascii?Q?FrfCYRSHwx+cGdompRs8R+D4o2XZL+PVOdLzpggs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PgOvV3m8rpF/xM26SR9ATXQtHp8xl3pzwfnlQMwHQ0B4cZBI71V4bEY9HbiA6th5Ce7gisqxOE1jkMUrQXugtENAZqxEea9VDqBWM4acjXYwNALRfcPxvxBfz9FsMm0S33ujHrlqnJb97PR9KAdEe0Fh/vMccCO84SVgl2f1zw1rE/cLi0o0EJADjCiuynljCNX7vT0MPHanPqMs21FKwNA+lv7SAxnl+1PMvtlWfTIZdEdxM7fURgEYhIdjo1pQ1wYyfuE8mzLKqVdYH5Ttz0x30rLkctRIqefNW33MMZoniP9Oa6DF3XNGROaL5zN/Sw1y0vDQqKiwTMW4DDxB0W0Ubr1NrhJ4pRMYUwWVeoFMoMHLxk9xgYopYjYKGyrQ3294+ONDnLa3C+puav6vf6SvPhF7Wle6/sXS1q597r6C2oYNV+hUme3Kg09WCqN+6w50RfdHdO9MnUgEw0L1TPUi1GaKPmUu0bWqBIp6IFQtHkmbryAgaKaOw73HVbg0dpBy612WX/6XNsiU3iwNs2AO5Pd3gbTteJ8kW+Zw1O8QHMym5ysUARYHqUPldXuDOqc3L9Aqk/5CnZTGN/rnRtrwemw0eGxJd+FMkF40hzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5fe74f-2aff-4481-c6b6-08dc3557daba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:44:23.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBx6z2dy+eMNusoXMViIVcInVb335JcPhD8JMWOUk8MhRJSGHbpteT9K/u/GkHblo5vkOppusJWCWrnx9cMnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240140
X-Proofpoint-GUID: 76Lxz5sEUl8wxeucts2hEQF1w38kMYA4
X-Proofpoint-ORIG-GUID: 76Lxz5sEUl8wxeucts2hEQF1w38kMYA4

Given concurrent mounting of both the original and its clone device on
the same system, this test confirms the integrity of send and receive
operations in the presence of active tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
 Drop prerequisite check in the testcase

v2:
 Organize changes to its right patch.
 Fix _fail erorr message.
 Declare local variables for fsid and uuid.

 tests/btrfs/314     | 79 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 23 +++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out

diff --git a/tests/btrfs/314 b/tests/btrfs/314
new file mode 100755
index 000000000000..4a5b1ed2c06f
--- /dev/null
+++ b/tests/btrfs/314
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 314
+#
+# Send and receive functionality test between a normal and
+# tempfsid filesystem.
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot send tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $tempfsid_mnt 2>/dev/null
+	rm -r -f $tmp.*
+	rm -r -f $sendfile
+	rm -r -f $tempfsid_mnt
+}
+
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+
+_scratch_dev_pool_get 2
+
+# mount point for the tempfsid device
+tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
+sendfile=$TEST_DIR/$seq/replicate.send
+
+send_receive_tempfsid()
+{
+	local src=$1
+	local dst=$2
+
+	# Use first 2 devices from the SCRATCH_DEV_POOL
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_scratch_mount
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
+	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
+						_filter_testdir_and_scratch
+
+	echo Send ${src} | _filter_testdir_and_scratch
+	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
+						_filter_testdir_and_scratch
+	echo Receive ${dst} | _filter_testdir_and_scratch
+	$BTRFS_UTIL_PROG receive -f ${sendfile} ${dst} | \
+						_filter_testdir_and_scratch
+	echo -e -n "Send:\t"
+	md5sum  ${src}/foo | _filter_testdir_and_scratch
+	echo -e -n "Recv:\t"
+	md5sum ${dst}/snap1/foo | _filter_testdir_and_scratch
+}
+
+mkdir -p $tempfsid_mnt
+
+echo -e \\nFrom non-tempfsid ${SCRATCH_MNT} to tempfsid ${tempfsid_mnt} | \
+						_filter_testdir_and_scratch
+send_receive_tempfsid $SCRATCH_MNT $tempfsid_mnt
+
+_scratch_unmount
+_cleanup
+mkdir -p $tempfsid_mnt
+
+echo -e \\nFrom tempfsid ${tempfsid_mnt} to non-tempfsid ${SCRATCH_MNT} | \
+						_filter_testdir_and_scratch
+send_receive_tempfsid $tempfsid_mnt $SCRATCH_MNT
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
new file mode 100644
index 000000000000..21963899c2b2
--- /dev/null
+++ b/tests/btrfs/314.out
@@ -0,0 +1,23 @@
+QA output created by 314
+
+From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Send SCRATCH_MNT
+At subvol SCRATCH_MNT/snap1
+Receive TEST_DIR/314/tempfsid_mnt
+At subvol snap1
+Send:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
+Recv:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/snap1/foo
+
+From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
+Send TEST_DIR/314/tempfsid_mnt
+At subvol TEST_DIR/314/tempfsid_mnt/snap1
+Receive SCRATCH_MNT
+At subvol snap1
+Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
+Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
-- 
2.39.3


