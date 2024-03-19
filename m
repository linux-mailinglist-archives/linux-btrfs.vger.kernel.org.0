Return-Path: <linux-btrfs+bounces-3420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782988001F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC58281C85
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C441657AD;
	Tue, 19 Mar 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ur0CXXiu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QQWi/Ktw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54B54FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860336; cv=fail; b=jfY6kTBTt63qIhH4NKMSqUiweQNiOuVepI5WMMpxMEiiptzi6F0WZ969puYIBBj+dpGVdhoO1+XO9YS7NvDuQ/I/pV0TvbpES2/kBVKQza5AQCWXL7s2WfxA6CWnQl5LQe9JdPcIQgbS18Pl99uObJc8LLQ99+AaH4X+WEMTbkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860336; c=relaxed/simple;
	bh=zm9lxhsdLqCFeS1Fp8jnt2ResFzbdGmpfUCtfxnkTIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oVbsUNmPJzjjJjqOWBcDdoZV94K4pfF4vWD4x0stNayCaNqGVWuO1ttdbIqXRlQuwO2KuKd2sWmgVoE1t5XhOaoOJYRlEsP8SVag2LadXVF8NtBhgR0VzhMvTKucFYy+mRQ/w3jrZgKo4HyFYKRgclY4vOu5eOtiY8NeslzwDhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ur0CXXiu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QQWi/Ktw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHe7N026503
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=pXJ3VQ7E6YApFd6CN3I3i4NKT14icR2l0ggMHHsPI8g=;
 b=Ur0CXXiuk4Nt88+IUx6zKYcT5Qx4ZWeEqa2HgWm9rFNUdEbgHR7wnGOFtMwTJKyCkajD
 MgBv3CEJOfeZQiqDrA6D8hT5jjKqnhYlfTLkMJsVC9WFjlgnvXSnG9qdBgKZ4XY0op0P
 E8SZv082ID+kCHTsCdPvzD85Ivg/Rf2lY5e+eGBoEPAW647zPvEOJMFTJlZGvp3tnEoP
 DQDOsbv5CQS2kY2dwgGZ4Eq9wL/XhPMQACi8JdfUg22Eprr1ug6rYOwssB7dEpAvEHDZ
 7UACSxIWfFLVgezLHDcP6x6mckcHGn/GwxwQtvplE2MKgK4hTScmfnl4CubSa6eyk0L2 ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272wtxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDfb9T024194
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6mt9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV3WKUleQ96h5BcIXnrXh/KMiGluzL/pcMQ3bYHFdcG5eccUtpqfVMEdSYMDkTwMck5TqCa9dzXtkpqOAo6tg6N/IxkI7WzvMxkI9rQZxJJxwLEdQ0KB/StacRf9+GgtQrJ12uAV5T2T8gn76ohlZQrEps8QXfROwwotuoxiQIvT9/8nS6tved6CpsceM5bWENAsyd3XJ5FPaPxuNkZ1chzHN4NnwOORr+enhy3NS+/9cYQOY70LRJNAjMxQ3LP44U9ggDRgNwrq0AiMOkDxWYjoaogGcVSlfQUN+8pk+w4+mZtkCdWx81HYs5HVwKVgbatZPMMJ3IIun/cks/3Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXJ3VQ7E6YApFd6CN3I3i4NKT14icR2l0ggMHHsPI8g=;
 b=XsSYwqDmUTDa9je6+rmRUyBUcVpvLQsm3p0HHmtQEe/Ey6381imGGcZys5m17/ZI5xatFrEblo21JB+xG1QO+KYedi0UFO22XPizN9WXwm0wH7hBA31F37cBzB6usUVnrgQMz8PO3CQY+YMtRdY0T1ztzvAd7Jm4RFyyij3fixmcLILalFMC/SLslDWGYTbh3mxbQ4m8nspascACWzK6St5t3LbyApxKkbhM514+DHYFsMFbPpIHPgna9eUMnvujoHJTz3u0H20SFKoDo1/ZqsZZ7LAZ9rQK6gf9yfwOpaNehe+5FQ/aAKo1GOusNYr2eKij3R+ISZgHMEf+YezxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXJ3VQ7E6YApFd6CN3I3i4NKT14icR2l0ggMHHsPI8g=;
 b=QQWi/Ktw2QbmZcoBKaTfu2rsmWHvSJxno1gqUtFP2Lj9m3LVl5MgySHqH0I339Ep7BOYw3BkaQQDiZqCZZmy7YXTRZC6HEbQLX83YXtONTUqYDj2KNSSBC5lMENqv9wOjCTQyCzyWag5B6t+k/Sp/1NEx/voTADrTjW4V9UDk6c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:58:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:45 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 25/29] btrfs: btrfs_drop_subtree rename retw to ret2
Date: Tue, 19 Mar 2024 20:25:33 +0530
Message-ID: <dd5209c549f11a1e1b85a924cf414258c398b59e.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bsJMI5JFWbLTF7fbpIjX6AmVnGGkrEHZ3RVQoAD44SNqWbP2uvTvwI8KEwmvki7Xu+5tiV6kwT7ZkLKtDfkbWNZ7nGFRG0RZ0ADO3SgW3HkAa7mttj8qGesMNDRBHx9EOATRrIWAyBzVjhVMqK73if4C6PObmGdP+0tiaQQufSoaEHFqzUuZ4VjiBFECA0iclnMbjybJkezoE5xlSe3YsVbsEezhcvDmuztWK3Oy2mBXfGyIDPYHJMQzrri6EHHR+wvo42nfadodL7C0RGuLxeaHNSD7KGfdigaYnrXC2Yui5a+qU5eq9UL40/lILyUfcIRyYnG4JKaKgELi/InMdL9hHx8kpLcz2CaoNfRxDn3MaJxNpCQlTUhtos040VpIsHQpBDqd8iTmP/nYoq6Yj4vwes8hoyTi0vdAOVY1jYB3ICBafFPTOCOqDpfPmsu7lLbKCmSqOsUaoZId7hHcDXjlCKW9tHvQMcpO4w1ukO1SeoztQv8dvtfPSyUU/RJFlYkqEAXVW9sdnBaMtXTEsIS3e/sX4/mxjDmMkWA4OyOzHpmV+HMpZZDfZS0hQ+eD0e6uyWreGaNJNIZvBHQa+wsMHP/Yl4dGmou8/XvOXhKjukBsZ65UHZMfBY/EGNpmNy9XklptmLkiwgFKIBeQ5y2FPCyQETGme143jL52uDg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MsBn8r/GyFdpFfLTd0QIO95FVVyDFmsDFzLSP5oY0XUCu54xZdtBeOBl+/QG?=
 =?us-ascii?Q?S7yo+VapxYwbJmgoolmp/NDoxq7Ct6dTVCwxoh0vS08hJwJZ/zUUuJVThYa+?=
 =?us-ascii?Q?OWTrbwA010grmCD9+667jyLQKvW8M4Th9351ZxJ4+RcOnZa6NKullwD03f0M?=
 =?us-ascii?Q?PbfddN0igdqI1Q960ShAcE8gF2kDbCj4HGYs1jgb29z8ZjyDVO7Q9hpoPfhS?=
 =?us-ascii?Q?LFI60gmyR21qDfkpCknfEqZnfoWhw+mDI2+4Wd5c84t7ruFNpD8fSPCaQhXK?=
 =?us-ascii?Q?eBYUHkWhhNeje+2jhTJ/YRzznVubJoCg+vFlkDs/qmR7SotcGvxBHtk02r/M?=
 =?us-ascii?Q?iR0/Md7LeL1iGwlhUU8Ff6zNGR1NU+lIwKrcrotDoFOC7TV+E2NzsZjuCxCh?=
 =?us-ascii?Q?HkXTapoO3s6msFCuThjJRPlJdSAc4Vl3LdpFXtpJxQRqUnOPYuRcxRHqtk2n?=
 =?us-ascii?Q?vN0yHs2fo0YS6uLQbBSXpXO8dk+oQ0KZQJdEXq8iloAAsi9z/O6PcHNTpLgn?=
 =?us-ascii?Q?9nTiGuw6PVdLKRMWNaMpEi3M79/e8mPw+KuvVLgJkh6TSVa6XD4771xL5crh?=
 =?us-ascii?Q?K5/ES2RiYXcJ2OmcvQx8y0A21dEUJfZ0tk5xRW6CU0Uo9c3wIT0pGpr4d1t3?=
 =?us-ascii?Q?Bo+aATkl2o6DK/ocHq4/Pdhagf81ih72LDF0HiDLrASLuTwl+cu1G+3iOQ+1?=
 =?us-ascii?Q?IhN9bTkoYzyWKXLSc31zEpW6OZrsnWv4i6IEYHGDZAQGMruqDzqh/yB09gwn?=
 =?us-ascii?Q?cC1QoxeA5FF8kfqKm01aUDiAfOTomQJahl6Oz2Bx9jqA4ALUD6pCrw2IwyXQ?=
 =?us-ascii?Q?GHuDguAZMOtuKxb+6iudplbYSG8ryt6dvmTRXT3vPCOOt9YWY0jSIb083xER?=
 =?us-ascii?Q?BkxVqBSSQ9FpeWEJXQYLRqw+6wOOVu+JjKUlf8d2D+G1UfbUxTllXo3wnC3H?=
 =?us-ascii?Q?lJ8vAbVLO/D5hn7RX/PIE4rjs3C57Zn2uM1fT5OZWE0WdeV7CRg40z9EqLKq?=
 =?us-ascii?Q?OQSJi7YAnRaXQXvFEfps+r6y59JtBBViVYkZXF929ZJSlhSAoLDE4Lzy0Uxh?=
 =?us-ascii?Q?NgHFJi/nnex6fGBnxoH4M2OCvsotz7biVERT5moEZiLY/TuII46bDS1cNQ9P?=
 =?us-ascii?Q?0Syy8eWrG93hERCIDfZJoluLyGpIEi40LA1ULimgjpSxo8gZr+MAtckq1nGI?=
 =?us-ascii?Q?WSMW/+oWKFovf30O2q2fFkXjuW7MKrQ0TH4sCQWpG1AJY9pXidUQIPpbS+sy?=
 =?us-ascii?Q?xTlLxTc+3SjWU2O8972qB5fRvshaSnZ60GL/ZQkH0esBcnwjx7qtSw5esneu?=
 =?us-ascii?Q?ZtYH33YHcLfh54sYtXRype1wV65aS3xcr0csEwBFmE2ug/gpw8gcH6gL8EEv?=
 =?us-ascii?Q?sk6AQcUzoL6PXoN701ALnO/8pPi2yF42S1UeTj28Y9C2s3bLFuRn3zKoLaLy?=
 =?us-ascii?Q?6ldjtwEDbGE7hFx39pfNcFsiqCRR+Ld6+ntk4KHheCvtLzjWyk+3Q9lvSa2Z?=
 =?us-ascii?Q?LXCJrJciaLQgcmamTjKUIO5bWbrLlMqhglDLZQnSKiRK4JWUZMIHofJ0kgsQ?=
 =?us-ascii?Q?/HeEeFo8D5Vrkgjqy2Cu/bb0eYCSTSfeg8KvJJCefuhv2kekAM53oeDUFdmQ?=
 =?us-ascii?Q?IVUUDNDPFHrhox+KsVGdpp46zoWAbVfSYt2DDEl+uiAK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Clf+APU9I386jZA6Adyi6b48PMGFcRyruiJUuYjqFYNgqSI/aDfFMjR5s2Bhe9KCOisbqGN4X58flSSzIuW1cjHsQ/CkwK1vFH3d0HiNxQthuEn+ZUVGnwTfDNpARcKG7ymeJkCKQvztGreBJ7Fd21g+KLqHuEoutHCeLefumW5MHfXE739yEEUIr4zZUM5apq35pl9kPiXTCGS1JNldE49nOJpeKusZUfoNtx+TOphBTYqMsQ5keySH7q1eoThQkFDKZZ8PFyvxya9NsfjRpTMZlVht/gFSmg0VuEurGjblYSpL31XLtRzExb4gNCSpPvEDQCP5aVJGWtf0+iq0GNvxqluxcfHqxXiLmFzfCaNpjdeVOXL38JFNm0F6f3LTCCqw9jnn7xUBqz2t6jm5nUN5ZXjyS01skiKzwh1CRPFbUcDZNiH11aMetFxUWPxQ25v8NVudNrUR86+QszHfao+Ra863FAyxV5TRH88Ecm0SNQUU0Y95ygb/25qZwKhCWoCHpYjSY2n9OLrgzLzrdGEbN2O9dstKh5rEmTikznb/BNiKQgFO+j8eo2L6x15Ko9IJ0q23GRD/JLr2/MOAZWGSfgUji0ZU0WXL93KSy2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6016f5c-48a8-4bc7-5679-08dc482512f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:45.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3K0sbyBO15kjKh7kmQW/99STwks1Vs+3udIkd4uiZRtubHTTkWC473s9mM0Jp0BnP5Iwet6ItpEbQmJPV+BPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: dBKaWkjNlakqs7myNuNyI3sx_7eNGHC3
X-Proofpoint-ORIG-GUID: dBKaWkjNlakqs7myNuNyI3sx_7eNGHC3

retw is a helper return variable used to update the actual return value
ret. Rename it to ret2.

Additionally, ret2 is used only inside 'while (1)', which could potentially
be declared inside the loop. I chose not to do that to minimize the number
of times the 'while' loop has to allocate/deallocate.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index acea2a7be4e5..5064cdd55d2f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6125,7 +6125,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	int level;
 	int parent_level;
 	int ret = 0;
-	int wret;
+	int ret2;
 
 	BUG_ON(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
@@ -6161,16 +6161,16 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
 
 	while (1) {
-		wret = walk_down_tree(trans, root, path, wc);
-		if (wret < 0) {
-			ret = wret;
+		ret2 = walk_down_tree(trans, root, path, wc);
+		if (ret2 < 0) {
+			ret = ret2;
 			break;
 		}
 
-		wret = walk_up_tree(trans, root, path, wc, parent_level);
-		if (wret < 0)
-			ret = wret;
-		if (wret != 0)
+		ret2 = walk_up_tree(trans, root, path, wc, parent_level);
+		if (ret2 < 0)
+			ret = ret2;
+		if (ret2 != 0)
 			break;
 	}
 
-- 
2.38.1


