Return-Path: <linux-btrfs+bounces-2668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A7861057
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 12:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C0328493B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2E76907;
	Fri, 23 Feb 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJ5rrAVy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJVXdRRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697C1758D
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687637; cv=fail; b=iwUsOi0TIGcpHcE/Yo/zBhyF/Yk1rXnwaD4/JifvDBkuCTIaHHrC94Hi/eBL0uWeklMPl+7e102fPlfRMFTX1VW4jtfGQlmaCUnbs7hXj8uIzJCBncObUTQ/Dw4quaIewe+4af4z+Dclrn9VedDNhgPAmepC32bY52WHrugyg+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687637; c=relaxed/simple;
	bh=t2IRYAdcwe8IXrRgv18Fo9xt7vOQUDh5UefVKB2QVs0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I3UJSKkeSAqq5FPn0bvbk3hZON0Ycm76OMV8GpHWQfTTejwE94KZiRrKH5KqYLOiGBoqUHaZa+F0xLWlA9rIag696U005tUidTzd34Olb53vJi8pShrYEJbtjQr9ZeSBZD+aWs4OgJb7/Z+6QRZhvjNWHkwx4AXdIxItTjPD/5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hJ5rrAVy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kJVXdRRR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N4xKH9012605
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 11:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=BKzFljK0NWZ1YYFDc/etHbArTfiINsScYNN1qtCdaqg=;
 b=hJ5rrAVyDU0Hm315rVcMSDBrPKVORVbqSvr5r0DIHvHFdC+I4r7oP5JE2h89S/yWSexV
 b1mfCRlfT8S3/qKgoT6SyivbNmssfFT87UmWPsJMRdnRGTLfwCcDdyLqzmo03TUXuNTm
 FQipXkox+t2cANzseBZCYmq8zWkTT1k6zgLfIOqTapq6H2epBV+CiC/GpTUf5hNNks4e
 04eQruJ9JAbYgyGlmFuNsxfWGF1ep7L70OMcaUSntv7ect7q6gvaW+GR1dwvpEWaE5gb
 qi7drRvKiNrXUGjQrRAz9TT7NC5wQibiWkb3Wp66qjQ7kQuNKb/hWwOBxgYUhcRCbuYd iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqcfcfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 11:27:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NA8VkZ030761
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 11:27:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8by4jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 11:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iECzW9aN9/A9MuUD6O4e4pdkXPqj1Ak9ek9AiTsD27AEmQBiEzGRFkdwo2yhsPkr8dTuuMEbxLVBKjnV0xXN/D5PrQiskDZgqLlYBzhKsd45wRN+ZQ0r80bBxKu3o22Qqzfb6xOsR2E16qzS2l/EXdAUtxsBmI9nxXV2+mO6CHrUd4rzbFJFBH63TxBsE8dYzNJFo1MglpWSUQAHAcGrHO9XpxxNPm4UnS2n1+AYKE29NN+ihCnwSlog4MxmxdmubuidRlN3Lep5iOUq7JZ96mWzMTj4gVTt+ok/xqXJkdG6/5Sjbp+DqJ8ioFOygfIb6qdABFp7PVB4V0JNgX56fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKzFljK0NWZ1YYFDc/etHbArTfiINsScYNN1qtCdaqg=;
 b=QwxFK6rQTQhEwVZQImm1B50au95Jq57evzv5cRJQK+ddEOi0m9bvxZPUcUIgIfjq3xCY33INshYNWE4lxZn6pBNzdWbL3bl7MXnpscS/sxuq38BgS/fD4IZujS4gt9Ux9UwJu0OfZL87HnuMbbe7CBNs/O9C5LL+zFWp4YLIFS0nSST4Tiw002WX6kZ3B+lLKzRKgC5ohZL0z5qMzdOoBA7ZTHjV/opXY6hnFuGm0EGSBLi4Q5NZNpb72R7+HjQ5iAcsQHuYQU96b0NtIpLMHwnEr71xjsqUro8hjq82ab+kn34v8wYd4pEO3wKDtP/858xuhUxAtynujIUILV73iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKzFljK0NWZ1YYFDc/etHbArTfiINsScYNN1qtCdaqg=;
 b=kJVXdRRRZlFy+voZPvgWB4+A7MsDBQQw/Vnk/uc5G/XIKIjzNYHMi36piZ1czl6BraByreKCzjyVJWIKkD4ZgIwm3Taxt5GyrARItMe6S7NCwpzRPVR6xfWmV7TOMRXfMAwoRIGjJUapEQwjpcFudjEtoLMCoMZr1KOG7z/qt3k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 11:27:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 11:27:11 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: include device major and minor numbers in the device scan notice
Date: Fri, 23 Feb 2024 19:26:53 +0800
Message-Id: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c50a44e-3ef8-4ad8-13c3-08dc34626087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IWXud80aILjuoyBJPk6G67y6mDvZn+LJQe67A3Ivu2ZyeNLqA7f7di6lGfibcOdX+BRzNCbHFu+/xNusJYQ34WICoJzcz79WS5RRx5SgA3kbArWmK7nRKYFgyXT9oPvVhDLILVTtXs+GAa9ng8WXYNFIxDox2zDKMQfDyriQrN+aCAEKTtJhCGyD1MJStByJ7bVdlu1zn6q/pDFfIFI0knL39NR0ulNkDh/KwiJip6U4BxobL62dJzzLRXb1jRQEszeOIuUhoiVa/uvn8K7pTtR395Lj+u81cxtWI82tMC8C6+wFFdtBDjrJJMySTD8FmnCeEMGhiojEEXd+CNxPV40+/CiOooVEYBsCI4i8nuG2Dg5jpY3On3yJClPv50lZgiIxw44k0TQ9kFddg9IZJsysPT60udOiAtbTHnOt6U2rIfXkv4VzAF+rTzLuii13cBr5G1yVSE1IIayWk878YzuXW9rfDqw5GfflOQIULKxVMosZwyPkTQXJHi6dO6jCbCCVcaCN2jTnquBKroM3Waof2krlcaOD9+hbEeo5CH4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zMXedys+iQ0q02e1uB7grlqADEeE3xm5amZdhLgExpbO4h4PrbiDDpJvU/Js?=
 =?us-ascii?Q?4sgSF+HnuhP+Vzp7NeeiE/+TWD/EBrhkP/sw6PxmiqTozAZoOx1f1TEk4KRw?=
 =?us-ascii?Q?BTMArmE2FOo1OXp41plVdAMPuQd1vK0WOw1ZknycWdJECviq2FJ8ZNF+TKXV?=
 =?us-ascii?Q?L/dvRkfpbw0IqyEhdM6ydS0LXL1nWAPDap7+raBj48imXC1z0KDzTdMgmD/l?=
 =?us-ascii?Q?SzLHmVD1wQFdjx5akPIe6F2g1rayPYG5vNWuNrGx7FjmLGcXMiPibpZRg6TC?=
 =?us-ascii?Q?nFYEr4oCN8tuDLYHA7eSzNzpz546NCnhJTesrW+LNnOyXBwAEkxfW2d3VtRu?=
 =?us-ascii?Q?5Ed1NTBwpgmH2zkhMqyZooMB7ILE+ubieQBX4y1xn0rAqlTXWsrFr9BJEfh/?=
 =?us-ascii?Q?vhITBqRY4+gmu2dIPOb9R+S+9Ci3/H3THa47Zx2Hp91Errf1M6q+tagQgNUc?=
 =?us-ascii?Q?cR1yRs2jIb45tCx5cgXPrFh7YgWMXJQblwCHU+US8jMltr16XWtdxDFJ3vgV?=
 =?us-ascii?Q?dmosXkAv0QCekjhpmEAHGmMvcUkBPdc353tyu6AOSzKxY0Z+ajYsFS42VB7G?=
 =?us-ascii?Q?vITNsUHjmFKcZHkDrXlonNBoinf33ahjuu/5PV+k+grkS8eZRL1Z3XXhHYen?=
 =?us-ascii?Q?7g1MnpF0/dcPkkjmU4JC4k+V/VE2SWph2mPi/eH99v2Kg30mHCRrIwpa0pqJ?=
 =?us-ascii?Q?lzTUTQW5jseoIKa5Q1igy7l2pAZvS8EYUhn9STpqcS4ccF8JKSsQtusBOXRo?=
 =?us-ascii?Q?UpsaGb6Fnt7z3NZHE0v/pcdKLODugtFXSqqj9fDD3rh7jJ6zoo3oStyiYpwd?=
 =?us-ascii?Q?Gm5jthY7vkWOPZ+m5v1GXNHBhhwkUXMaTgINq+pZf0MtXsz3dFDy2Fj/jKBh?=
 =?us-ascii?Q?/RbhLJj7u+N4W22gxgbVL5PDLJLMkkAM6CSIQYGaneeTqSooQtHTfweVofB9?=
 =?us-ascii?Q?Wk3L/YsuWcOdpo6m2IByVKS77GEWDxKKzPbVHxmNa4jt5rCjqibGpazeGws6?=
 =?us-ascii?Q?p6QRselCWe1QaMiWLhXnHOqoIG4Zg/wLAarGdeBEnK7QEKjpEjLS9iPzlF5h?=
 =?us-ascii?Q?gIVzwnpgr/6XSRtdQQQ4rJyIbA/pDm+eOHXAcVoiM7DrCqfpnA1+ws2AANTb?=
 =?us-ascii?Q?ECZDoa8kFhHgKh47v4yA+Y/URhsUmkrnfk6bplJ4O2kfvCWclDFNW18cIDzz?=
 =?us-ascii?Q?xx3naOCHR9ApQcQcz3YogeXlrzaTNYCB/R2qYani8co8mpfXeidESRZShwJ+?=
 =?us-ascii?Q?8uMZD+IPEgpEZW0oD2RT9SZTMpxntsJNC4krVNoJV/y54vRMOTAJ3tpuYh/n?=
 =?us-ascii?Q?KCo9LBGamFrJntyhEo9W5Y9tAZQPMuWlcriwMvLccXuy8XO9KR6FzzLDjuRy?=
 =?us-ascii?Q?Y8Z9VE6Rosiyi4OaT0iOSnGqjJ4B4IGK0skpl5a1HswtOG1lhg6MZHAl0qY2?=
 =?us-ascii?Q?Wv5BhXnQg1/wuucUVy+7CwfEHvEAEj1a5THWYs0Zc8gS/AUF/3fUe/PYdexl?=
 =?us-ascii?Q?oowjokoCDwmzhSUSloGSfsnGc10I0p0VAQfuziXjRVeZZd7L/2cpCHfKWHQS?=
 =?us-ascii?Q?Kges1HwCnOVNGyjaFEinQthWJYaSa7G3NJUKYFPv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GcT7xaQym46ukHe13ZY1yMn+ifOnfBl/3dP/wcYfDX6L0D9tnbbnXwvg/2yBSaD6UhNvrrulzaVtHhO1sTAuNA1O7FGBb+JBfa8Z/7F9jeMCtqqWMeh45lSsjwbNrB81bMoUilKAX+ZrvuuLEyiWAj5GJmFy2bh+cUVpzq1LPipR7nYWMd7KJmQD8+NN5GDQ82a8CfHuJv28+0glLkLiRNN0aAnQmBN8ZCymuD1AQajHVdOrg8h0jmQH14Yep1jnRKKS+N/YGitQc0N6z/1oFI2wpQj4gviJtNcMn3T1qWaVSGlfPLKRjxGc53DqPp2YDcaTRfzszQYHphChtDMG7jR/B+OxRoUGNx1cKg5LZyw4qHEHOPTw4M+vrMMlgDmRV1xJs8JSabyQtNnxK+8m9IW4I64fnuzAH5dP4cyHQHIE87MHanKQWME/2V1aMcIS5i+ArHqXm3YlBhxFQ0DZttPjviAeYyY9N+MvmDDoUB1d3qC7QoQaPc417CCqTBeZ5jnesB+780VpDLhnRTYk6T/CbNsJLl7dTD2y06NMCnsDNoxnsY1gMu4p13984eqw9j1+kPJ0gkVf94EQFxC939LRM672rQOhk5IcHAVKPis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c50a44e-3ef8-4ad8-13c3-08dc34626087
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 11:27:11.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/swf9CaJ+bKlGMtEeNGTU6couVnstxctm0BCwMLjwy+uUme8jnyQnv/QWKsuhZm0zK2bdTUMpYH49FoxQsFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230081
X-Proofpoint-GUID: GRiCUwVLktb9J4I13rqTKafGBbzAQ9gO
X-Proofpoint-ORIG-GUID: GRiCUwVLktb9J4I13rqTKafGBbzAQ9gO

To better debug issues surrounding device scans, include the device's
major and minor numbers in the device scan notice for btrfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 32312f0de2bb..6db37615a3e5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -824,13 +824,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 		if (disk_super->label[0])
 			pr_info(
-	"BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)\n",
+"BTRFS: device label %s devid %llu transid %llu %s(%d:%d) scanned by %s (%d)\n",
 				disk_super->label, devid, found_transid, path,
+				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 		else
 			pr_info(
-	"BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)\n",
+"BTRFS: device fsid %pU devid %llu transid %llu %s(%d:%d) scanned by %s (%d)\n",
 				disk_super->fsid, devid, found_transid, path,
+				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 
 	} else if (!device->name || strcmp(device->name->str, path)) {
-- 
2.38.1


