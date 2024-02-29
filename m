Return-Path: <linux-btrfs+bounces-2891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5663B86BE81
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C01C211F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F4364D6;
	Thu, 29 Feb 2024 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ye51VOiC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DDovjEdT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61170364A5;
	Thu, 29 Feb 2024 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171451; cv=fail; b=RXQAdFCk2EXWZDX4tR0WGVf9WNp8b0HmLq5vC93x6Fr7CibJu2P4cJkciLXORRrWPC/bU7Aa0f62KKheN1q6SNhuPo4I1wJrkpN+o7s7Gk0Tp5w1g7+LeKKn48/mkACmILcAbf3tbm7viep/CJynFexR392UdMIQl8tGwDrcVVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171451; c=relaxed/simple;
	bh=/pZNnBx4kH3pua3tyjfmfsU4M+DpJirQo1tssCUx9/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVLBXEv8dpqMysLNLJ74arjc4ya9/eLf6qCaatUqezrzFwPKWw1y6jK+cb+2p2vsPngVy0JJMUGs7xxsRIy5/UDEHw2TdcbLIfIpfHjIch0mFQIYfPzCd67OgGEfXLzmYqFPJtw7F3Z5mtmyXczJOuFLFX9KLe/NsjHOZPwFiPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ye51VOiC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DDovjEdT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SK17YJ013144;
	Thu, 29 Feb 2024 01:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=R3h4BbyhqSSDCqwJSZyCjzhERA6u6LNIzouBZzSQRZg=;
 b=Ye51VOiCFDJepy6EZq3UjofyKf6LykIgBhVqp7WVjbF+DnjzwpCp+qnfS8MaYs+BjXHx
 RDX6Sdh5WCOXIvjFWbFEvwoqXxxjO50jH7v4s0QElm1meRFx2AqrTiTVsE9GagTYsUpB
 AH1YIIuIWxnt+yrZRtDZmAlZuk4NBga/DaCdSHTy9pFqGFpgiru3xBlxFcJCs2x2xIYc
 pUTBuuvNvQXpRfNBTLXq/5/U2nogomH3so8ntE0VXw3NVeWLqpnaczQ1bTsCG2vtOtO0
 btCF4Lq7YDdZoU33J2sYDdaTRwG7bTwY/o8fb83ETZZMGzyx+CQfcZOxDOgjuGni+cfI mQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vbx56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T1UwHp015291;
	Thu, 29 Feb 2024 01:50:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9yxxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6uVnXJNLTFalmXOnmJGVZ+n531ZZ516zc35pHuRIpM0q+TLjM1qfjUtKCEsoSPDo2xqxFg7Z1WGaILY3IIcGk92znoBLE0HcXWL2F4+tt4rSemT//5ee9h6/WDJOSrWIzXua1ClxgpNIsRz0pOXmvYjq3iff0dwlYfSd0C0tCbfoLkvjiwqk3j5xa9TEwMTmRjQSBaarvRkIp494H7u85FMEyfMUUzE4tEEL58kyWpxqPlpECS8zprCs+UejRkMuwZikKEAcUS9sYNT/j+G04J+xVDhQR2R2HkG8+aMYRR188fvTmVZ1UNRu7wO6fZpdPgz6s1CGAH4PomJsZPlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3h4BbyhqSSDCqwJSZyCjzhERA6u6LNIzouBZzSQRZg=;
 b=cyDDqbqhqVfN5cGGj9wqevGCrgt/+u1EW8RG47gKitGsCBNzz+G9R1LVrXUyy11fd6ge4ycGN4/Wby67nkLQKYiXzowNIrYpoDrBm35/5V5NgiekLQYcLaw5yzwGq5wt85hXv5are6g2Uvg9HAD9hTz2xovgWH8PNVHhiX8yXX9kHLObgV+//nizzsTOtmNOQONTtyE1PvTNFUSZyb+O6+dkSljVOLE5N/S4kqse1HqmhEgW0DzIM/gc5mx07Q3zHW5RvkJB78221OjHpxG3WgbvpVMZiIVCzG+/nG1sayWfy6X9Ub5Ly3jPO1GWF0kDk30e0fp4X0Oa9tHu7aJdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3h4BbyhqSSDCqwJSZyCjzhERA6u6LNIzouBZzSQRZg=;
 b=DDovjEdTetgXWBgVgsGAeNKgZXJpUXGEAj+MPfkqZN8iSwt3z5CtoFAmrwS2G32m1Deuslktg3GNbs9LV8XLAIBT1HQGXpwnlZU6eifjyc9ha3NXVyCdnp4aLyUurohmbS+y8zKZTinQCrjNq2MV4uTGRf8HerpYfu3fGxOUG+M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 01:50:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:45 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 05/10] btrfs: check if cloned device mounts with tempfsid
Date: Thu, 29 Feb 2024 07:19:22 +0530
Message-ID: <377e9a27befd2d4b7f771f082ffafe57876d7cce.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: ef81225f-6a24-48df-38ba-08dc38c8d818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yoa/wWALSKuCD+BANZKGh9FxtdpG/7A8sYUdTR/i07ARB5f1xL83vFpO9AZNmzHaUK8+RTEoG4v+fekI4EnRJkkt17O98aloH6DmI5por2w+vk+Y6dfsOUz7z/pMwJxVR/rTBCVQRuTtDZQxdbsbgOxmkClQ9o/czJWS2AeDoqOnfWUZauHiwJTPnlIFFc+1m/DgmDJ4S4XsdonM24lPjlnA5ufP5aERB458H5n1YbfxTM9gqjzsyGOiGTc8aPdewLLB1cDLvjJIFJRHDFASqA0buyc58YRaWMl5DBmsLACNV2H58M1Seqjo5uyza8y6HarZgZbQNV766sEDRWAbyFV1f2AodpHLX/94k8Ykrntobzv54MUVt3vzkdUWnCZLm3EcjBz0QyR1h8lcGqkhd09h90ZYfPGqCkImLBDty/ZAY5LZYl0Ls4D0Mu1Y0xu/egHeQEXzOxST2Ni85JHvZABQ2bWmP8JfK5hn7phhfXoBlB//arEi8eSec0MludzVy1CiUfu3US9iGXqTGZ24/ctpo1X89tzRCOLUhCyrABInWXTcVLPC5OS+DMHvs5rMzIc2MMvtyXB86Fl2qCT5pBN+sixDJkzpGvHj4ILoIFNAfk+q3CMLkJ+x0PtlfBDv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rG6Tvqk9Z975mkc/iVBuWgNH1FAHIryK+yZACV6XTd2zD7DRosjnwfng07dr?=
 =?us-ascii?Q?8asaYtFvapHsS8f/ZqnmGTw5aaX76a8QoWfT7q0AgYC8XpJTs58ejMwHXHcW?=
 =?us-ascii?Q?wshxWaFOAesSfvGZjslswmTFTWfduPn/+PRpqHKBozi6x+S0Y52Ka0ubuVX3?=
 =?us-ascii?Q?uSuoNYDK72yn52nF1gJb5oaUTfCBsNbijjZnJJisp450A8QD8glMasKqd1HI?=
 =?us-ascii?Q?2e7I/1SItykliJCUa0NoTVQZbb75X7UGPjN/iM4csbDFObxsmVdcwcWhZExV?=
 =?us-ascii?Q?YtjYueg+cNIYVB7PTYP8NkBmqT82jLjwKjipEnQK1L1+BYG07rP0poVCjdeV?=
 =?us-ascii?Q?7YT7/vWGyVnA0fmOFSbT4FaiiB1AA+qXjHCOQ9d/DlNR1yJjFRF7L2Uy42eC?=
 =?us-ascii?Q?UPRZknhDuu6G5Ji/wtld9zjjIC1YiOR063pLtMRJIVB7NAZiv8vM6JJjQp+y?=
 =?us-ascii?Q?gb+xjeayHnTZvxExFYN9waREIaenkglEMfh2ueY+ClknYXS+egeb3QL/f7MC?=
 =?us-ascii?Q?ch7oN954fRR1I73dpqsCr999fWrpLY4HmH0jsdjgSiN/7/Fz2rDjpDoBXSnh?=
 =?us-ascii?Q?GuuwAmoSodh8kWn1Yrb/fOByOldQzZc1sJKfJ4i8R/xkusFrJIqzHnympsDf?=
 =?us-ascii?Q?OUFURuNaupyJEKSXJvzmdzy/o9mbWJlubyvAiFaSu9wvqMVnYGfbxZEGyiYP?=
 =?us-ascii?Q?pUudNR3pN+DLvFJoKimAoSV5RqbcXX1wCnoTJAcQo1rzC+X2/n9EgK99scl8?=
 =?us-ascii?Q?1RIMpYPh6c1x75eTPLoYx1DFI0Qi4kJndGVaC/wQDnJV7w95df4azUHxYuAW?=
 =?us-ascii?Q?gxv4eUpSq5JRYT6rTbOImaBpe9OxTtTSK9MfssPqqa7c8Z0h079qiS9kZTI4?=
 =?us-ascii?Q?QzxbEJpAdVKK2+cp0cZgpROCZZKXtJw7ewwrpp0F/hCd2NPv9ElD0ekWlBhs?=
 =?us-ascii?Q?/aaNbXlweK5vCDOsqIC550OMpu+tj60T2unPNvTlqudx6Vf+Z6U8cDDsF00F?=
 =?us-ascii?Q?A1l1M3itDpxgT//qdFxN4uV4gylKfLfmzVxLDLTYJajmMqxjH6SPzxSpVF+M?=
 =?us-ascii?Q?exOG/ZNKYMmsJ+SSJu5l7j/qwBPdfM3msBmI0q4sXK9UimgcKhJy05sEfiCF?=
 =?us-ascii?Q?RsbmbIe8djWdLtIJ8QBEelYj/2wOg/KzEgCd1TlpuswTXwktLxCW/UvrWTOF?=
 =?us-ascii?Q?iIBw8mkd/Zen+nQctkXuk5zBXnenrygOgyNo2h4FxhWVYOPcw1oOQRBmNzeb?=
 =?us-ascii?Q?C/2rBdqV9tdE2pN4yMmSM42YwAf3xqhMfD1iHCgCcsWFm8N/iEFnFi0GcMY3?=
 =?us-ascii?Q?mgi2HPHMoOGbQWHLisdHYUMzyxc75hgRfJMz3c147vcInYiElMjrHVD2ZMRp?=
 =?us-ascii?Q?SqN8hsGjTPK4uya4ZuoaPjiuBsMdDjYZ6GSKr1niqN1hL12RWYVALaiD32fy?=
 =?us-ascii?Q?fQ40b3v9pam5wYf9G0H3Vw72RzWTB5wKQ6pOdXqDqgxeFElUc5YKFHsy+5x4?=
 =?us-ascii?Q?KhCuqvRL5xxE/Bks7SO/6mnuS/SNUnyYQ+Q3VowyDU32BmPckNdtBVfyO70x?=
 =?us-ascii?Q?fs66i6AdxauobhmEs/Ulz9VwRITBV5yJfwvJlWdR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4QAtBkhl/iNh0xOhzWeJO5K62BU3pf3VaYFNOay5vKV/yfqYFfGmT161a500OdGlv7lJzTNluEELZnBsNU4mbmzLl2hllePW7bihaXhYPUISXOXFd18pbiGqnYCmR/H6rDq3fGwv0j4hpvFkDaa5Gt7xW5WAShLH1ojIoHJ49PnrDCsKBOxYwObDUXV0n5//1uHcWy1phcMvSa5Oym8Cg0pCRlSYtoWdZzGGTpybOn31Hp6RSURIs83fVytoNbRYKocqD33hyUUEiOymd5DbPlC/vToF80ejKC7ti9GJJR8Q0CfARYhUrEOOxM6gK1sUu3BCkCJCSSxV5qSF20zxcnqn9HC5+uC7b6vEANmr5WxlLY5hNbfGMYQDjOk3xvd4oAiKj1K6f4qMwfGxZeAg9D544IkYp1EkleYlZiJtixbOa/N/JB9sHXubWWkrAaTyloqO5Jyq4ymOU4Ud1J/LNOTJ5FyksmzR7biJL+P2MB00xiV7Mwx0LQm8xIT3LZGVrVB1SAMOYBzWFggn34IE9fKDNY/RnVQVH/k3lrC+Syr5jFXFQ+wUC/KI4zHC6ED+oRyiJZrPq35Ul8VvLggKe5NaFn4zuA9f/8DRSNJSYf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef81225f-6a24-48df-38ba-08dc38c8d818
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:45.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzlmZoq5GgF140e12yn29DptC+b0WehGjDbzgbDkyldOrpAeWNMHDXWilCSj1kWACss7DWuuOZl5MnXm5su3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: Ut2u00598gnwyTyC1w0Kt29ugnaTceHb
X-Proofpoint-ORIG-GUID: Ut2u00598gnwyTyC1w0Kt29ugnaTceHb

If another device with the same fsid and uuid would mount then verify if
it mounts with a temporary fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/312     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 +++++++++++
 2 files changed, 97 insertions(+)
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out

diff --git a/tests/btrfs/312 b/tests/btrfs/312
new file mode 100755
index 000000000000..eedcf11a2308
--- /dev/null
+++ b/tests/btrfs/312
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 312
+#
+# On a clone a device check to see if tempfsid is activated.
+#
+. ./common/preamble
+_begin_fstest auto quick clone tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+_supported_fs btrfs
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+_require_btrfs_fs_feature temp_fsid
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+create_cloned_devices()
+{
+	local dev1=$1
+	local dev2=$2
+
+	echo -n Creating cloned device...
+	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
+
+	_mount $dev1 $SCRATCH_MNT
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	$UMOUNT_PROG $SCRATCH_MNT
+	# device dump of $dev1 to $dev2
+	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
+							_fail "dd failed: $?"
+	echo done
+}
+
+mount_cloned_device()
+{
+	echo ---- $FUNCNAME ----
+	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+	echo Mounting original device
+	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	check_fsid ${SCRATCH_DEV_NAME[0]}
+
+	echo Mounting cloned device
+	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
+				_fail "mount failed, tempfsid didn't work"
+
+	echo cp reflink must fail
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
+						_filter_testdir_and_scratch
+
+	check_fsid ${SCRATCH_DEV_NAME[1]}
+}
+
+mount_cloned_device
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
new file mode 100644
index 000000000000..b7de6ce3cc6e
--- /dev/null
+++ b/tests/btrfs/312.out
@@ -0,0 +1,19 @@
+QA output created by 312
+---- mount_cloned_device ----
+Creating cloned device...wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+done
+Mounting original device
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
-- 
2.39.3


