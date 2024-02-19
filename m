Return-Path: <linux-btrfs+bounces-2537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E885AC6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4BB1C22548
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632658209;
	Mon, 19 Feb 2024 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4aJ8zhb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XMrlDeHq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42E58109;
	Mon, 19 Feb 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372177; cv=fail; b=Ve2x3LGJbeD8kz5BhXXLdjq6DdHlmrx1sZXj0An8MMGOHzA9o86vDnKscSq4wzoPp5NqNVVk5k9pB865203mxiSfoBx1W424MhFdJp4IKeIuaJ2br7D8k1Rv7V9yMiyvBNww2YuAxdjoT9fOq8JdyHpBisb4Jq/THL+47b+t0kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372177; c=relaxed/simple;
	bh=7DNUkGH5E0XTVURvZawrgNQw6VF0jkID+KmaP/orhLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arg9oUCH8j5PfASaJ83GwY7jbp9DEXscrXBMopGuGfHXEr/X5hcQ1OR9xPlGvbP6aX4AuyctqG9gbecw2W0JLLKnukoRR2ZRQ1tJ/KGsa9jSdBPIaZwTIlYm4zh4KuKAVaXFjZwazZhn/q37oyZ1eIS2k68ExOV+R29bsDrYSUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m4aJ8zhb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XMrlDeHq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJ5gF031783;
	Mon, 19 Feb 2024 19:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=x3mJBMlVeyoDXD4ZIyIXOOcP+Z/p5CkmR1Ta7N70glE=;
 b=m4aJ8zhb7KEbA8cXz7QouB3P4GIEQdCBYOSgZcjkFY3fHoQQfFSQ2c1JIQq4/oyS1hAO
 hXYZGbREfL045QTt5mQcNnA1HviegXOCyo/z0XuU8C80viz9o87h/ogVkoLfgET7VGY7
 +NFkgxbU0m7ASW2Ih3oG/gO1sJz09zGwLoIwWhzp923mbrWl4p+JchoBJbNXjgh46R5H
 Pwg+XdTfaYOlNtk2eKA6wVoKcvN2I9Lh20/XOgapBh7tRM/flBL8eR0B5yaDUgI2o1dB
 t4zaFpt8M+ld6Mm+IEDxV2GdHo+gVdmyDWNXTRTXiIMRsPnTpXaCa6PTbq8LVp95XlG6 hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7ed0pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIPxFt006609;
	Mon, 19 Feb 2024 19:49:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86hytg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJX0f5nGmIovLszz8PsZRgIdxXAE1eJlrpHrsvNFayHKsehucMZGZ7fIk3BOLvmUTVzvc6vmbfHjgV34Zik1AGgG/bmuZUFUq3Ac0BFBup72dXSVOS2eHA4/GL+nHDx4z3qEiOMqFygzQKrivYKSwAtx9/6mOIp5206EKfQHeR8esosr2F2xJx2B6fZKyCymbWfwjzqiO4BSX5Ie9nKLeJC7GEpvP93L2a3djkrzYZl1wvT/+cPYwMNdFB7o79ZpYTdSxUSHk1j5oNJMdj+si+x7cTB2tzIx5eICvSt0zXrnoJZFJYr2LODrPlaS4STV31sk0M/A1swIeYzP6oqugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3mJBMlVeyoDXD4ZIyIXOOcP+Z/p5CkmR1Ta7N70glE=;
 b=cH2Sy87hMpAdIs2M3jxSKg2o5oWwmgRyoOKriq7m+q83hntmMcXcrnKdXgey96PLVxA3ANmChnzxmMF9X/0NECMh/f7gTqMFsYQ+laVZ4AsOrq66PnXdgpoE1km+O5LGwbiv9/g24oAsLhHIZnrWMDJM+Fd4QeMlK4SD7++aSyHk7ZH2kYhhp2Zv72UG/EQS/aYNbKfuNQBUdfjrcd8d9amnumwfjUCmwUGY2UODPDERegNFGt+BOZjRqbYnbM0xkk5/gRi80PdF2zxRn0dvZbsM95wQW8JuECO6A6ba32R7seqY8OhqXZNqMJs4B7p0AUKzBBDT2cyeRMnjMiHeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3mJBMlVeyoDXD4ZIyIXOOcP+Z/p5CkmR1Ta7N70glE=;
 b=XMrlDeHqmtIvCbL8cKCxNc3WW3VuZEILpGPluxQQx2ZK/sFaVzIJR6rOJIY3I6bPAOArDGGYy1UZf2cYBTDDfdBK6Ukmoe7f5w3tPJpgje4q6AgxCbh+ktoxSWR9gYj2AIhCj1RO8IFGU14KhsqSCj2HjScHDKu3UTq6e4nD/V0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7573.namprd10.prod.outlook.com (2603:10b6:610:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 19:49:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 04/10] btrfs: verify that subvolume mounts are unaffected by tempfsid
Date: Tue, 20 Feb 2024 03:48:44 +0800
Message-Id: <5c5a57b1f937b7a6470976643fad1c147c682e80.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf6fbca-3980-41c3-7081-08dc3183e1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bjntQegZUCFl+5T4Y/PYyvQwoTOSVkSSs9QoIRdDEI5D/8WIPOaeiFzGKP/3rbqgp20jaDgBKoxFh+54BfHVbOCpY8QctapEnJrlERn7l2pubuVPezuNHnANpeEL0T1RM+pIOQisLyB/DnJu/MFn8WJnuvep9YL/92xaRNP92TabUz3ohRJABJZ3KKwy5XkwCtn2fp4PwvlQMIVn/NXDh00F43Zd4CeV2kcSIyCGEvjTFOXnAJbxGzrOsRfVBI+SlpJI0lch/REYmBXp3rM4tBe0JySy+K1rRXkhRotg27Dz+nTZJDbHnj3O6YRnyCr15qW00fQ25GpjNjr0KInw20ea+6vRtG4u2icmnilFwtLy5ucrwn+CySqU7BithhTR+z5NtAUP7mxS+e7f/gTlEpBhDWzrh5bB0UVmfWSG5C0WX2/mmsdobiA4GzTRuoOnU3XN0HLLEhALeixT/Eb48I90ZOp8m+D5ZbfyeyfEupRb9ukBZRCsM4pSG8eB6O8lv8I2dLKnNET9bZHUT1UeRXK4dNWNv1afLGKGdmF0ZAs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ceytfywe9eNDurbQ8UxwmItnF0Bf1VhmSMlK36VU3GLPrOTO98+eyF0SoEt6?=
 =?us-ascii?Q?EaUw2ZhvbP+BP2P81lI8+EgExlkUZdFIrtQosdYyFcLwOWiIHNWkfgr/kk1K?=
 =?us-ascii?Q?NGV7pyCK4yh10V/A1wXy533lONqheLim23ASfQG9jaEi0fh7R9v165s0grjb?=
 =?us-ascii?Q?rtk4RxcuyvUVEp6apv4LRqKSBQ8mH8wXzyYaj9eJUjBcTSTWm5tGwg7BoKpZ?=
 =?us-ascii?Q?icn52TQIqRVFpeitSkJ0lIsvwdgPGh75Mx7oMe0+onyHaNgMP/SvGRsV3MIr?=
 =?us-ascii?Q?IoHrP84H3GPyW+cDejcHEVIF+SL6AQRTUV29nVNlPC62sUysF+amvYXpFfM/?=
 =?us-ascii?Q?EZvQ+7j+v4kB+CaxsLC6BG9M/WiEDS0ePG7bPzz51VpO3J0R1cI9UYrGQals?=
 =?us-ascii?Q?Fzfi7vw6jbsoG0atAKICFxkFaFoK7BVZEmGU1FQEJmXwvP8cxKvUZv7PuCM9?=
 =?us-ascii?Q?dIEwxGdGypndEfnhB0a9qJwq2tg9japVWdag2d+Pnlsu3E2EOiowyIQDUKx4?=
 =?us-ascii?Q?CyKRPn/8Pg5MUGoJUQU48Q0YUj1yksPE6yE6ZVuq/j6zboI9YZEtT8PRDhxB?=
 =?us-ascii?Q?3smF/wwFIiVepWrGnnEhxXEhv9t22Ct0YmruNRlENH2Wbivj6zFzu0kbyDnt?=
 =?us-ascii?Q?KadXKZANJPw6B+NoLDNeQMWK6qsc0iZ10nIZsP+fLaGCtozx+Ef+4WHlQutk?=
 =?us-ascii?Q?wjmQ9bRSWB1M2NVKekuOybICHMgk3Q4rBftc95N+erGc7m4Jj8CEjS5B8Dev?=
 =?us-ascii?Q?bUtC4dYiiT0O8aspxqKbk+O8JLCULEomaaVKfdVTXtszIVMiBBkR/CaMiVXK?=
 =?us-ascii?Q?fjG8bUkAdIm5X9N/iFyr2YbcwsqiLQuKnrvhSPyPuL1irSlbcRQkqIbwCG4I?=
 =?us-ascii?Q?oEsZwWpB8CgYwF8rqZMqG2ctGTeRnZ0NlLaqiM2vS8IvP67ejPuavKUWbc9V?=
 =?us-ascii?Q?pVDiWt368qiUdN2rAvOumMk42L2Xt4pXNCFsq/aRnmH78Wp8iuus8rMXSiKE?=
 =?us-ascii?Q?0rOWUazGoPiE65WOajwhJQtT6Xh+SBdlPUy3oprygrSLXzQAKtSl131CiDiN?=
 =?us-ascii?Q?Am8a8haVSBfphXcksdcz+rdAAs/vKx41HPghb1+Ijq2A2DSSIlaZBnlAQs+P?=
 =?us-ascii?Q?0bXPuSQZTfshFc0te/X0BLGI1gB1A2Rd+bX2I8qAptMcxklPkVrpmU7BxOaO?=
 =?us-ascii?Q?O/g3/Zwl6gLJYJyixPTEPGsdggNeQPR4zrwBXVNrOSIaw8gCzmt85qgv6fak?=
 =?us-ascii?Q?x98KymrvqY4ECm8KshfmFbGu5wkIAbCPGlv/hI/ayPJYGA/ZSL1tmZCWLqnp?=
 =?us-ascii?Q?y7izQt7WgGIkglViMf2gxBQL3b42CAqs01YWmvKyHfgc5rS+pfwwTDOii6dc?=
 =?us-ascii?Q?dOW/GU2PGaCgV/Zthi0Jed1eP1yvLexNFXaq8PVc7X0wu2I4Zzlr63l/xyDg?=
 =?us-ascii?Q?sHQnnFy9mz0NUMx9hK2y9taPM/9IB5kkWjek5Oy77fRxZdS+PqBFFwOqrD62?=
 =?us-ascii?Q?sjZe5i5NOpA//fAWseXG3EaLJ3yK+71+dTIFC61Zo2GYSZu8Zj45B5X0poq0?=
 =?us-ascii?Q?hxMOo584YAnNKwfG6WzPV/HVhru9iUa9LPI7O8ew?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GRowYf2aTrPLEIEVWk2bVVqR4nBobsGjKRHFfLkanjGZgWrIr/DgeuXsRKn3YsOcrUwOA4T3R7h+hnPvoRJC0TItE3bxCvbgnPg944zXISbSgdcUGffAuOgt83gEomngi/TQBicCPR9qnv22LvHoaY+9QQ/C24SJnPoX8sJsoYeBKm3a7Ss+CcZFNJkeFzIxRxAz51bO8Ox0IgM+0Hg2Vyze2euKYuIAiosMaaKv01l49TmaoYaDVxlrBqpL7f9uq8ceDCmD0trFcSEdHispNv2o9tgtbXTkO6S97bkKdT61MJpzH7GSX4v/b9pnmHlEGmn40mJB1vlgsY9603HWliXrWXx8mtTJXCeFJ3mphcnYxXJUrDO7iU1+Xdi6BnLDdsKQe5GGVzYTb4VNbrAznRaEKv2b/9ZHL2DrFqXyFL8LYqujvFS+mbpOmdtzaZmaTdFoX7R3RmqmqWkNgrXyjOMGOO5JlSQiJOWrUvN5Zxso/QRWGGGgyHMC5ptr9s7fKJO4PQwCVfYIwDM6djndTntLE4bV68+JIFJfnpOadiG1bp+HnnPPYr7FxqatfjSAyOQ5+c+f7GZ5GEB6XrgEcT3wSxQIOBkhfcgUOne36Bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf6fbca-3980-41c3-7081-08dc3183e1ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:28.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vv4jxKX++ZRitiy8dZlXH8IRTWt00kVUT6wcoOwkOAVNrN6TRIXNRupVEPoYk13BNvEICVX/DP6WQ+eROQ/s5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-GUID: U0-9PTm9IA0IJz4BK1FiIGKbrfkWUIch
X-Proofpoint-ORIG-GUID: U0-9PTm9IA0IJz4BK1FiIGKbrfkWUIch

The tempfsid logic must determine whether the incoming mount request
is for a device already mounted or a new device mount. Verify that it
recognizes the device already mounted well by creating reflink across
the subvolume mount points.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
add subvol group
use $UMOUNT_PROG
remove _fail for _cp_reflink

 tests/btrfs/311     | 89 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 ++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out

diff --git a/tests/btrfs/311 b/tests/btrfs/311
new file mode 100755
index 000000000000..cebbc3a59e6a
--- /dev/null
+++ b/tests/btrfs/311
@@ -0,0 +1,89 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 311
+#
+# Mount the device twice check if the reflink works, this helps to
+# ensure device is mounted as the same device.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol tempfsid
+
+# Override the default cleanup function.
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
+# Modify as appropriate.
+_supported_fs btrfs
+_require_cp_reflink
+_require_btrfs_sysfs_fsid
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_scratch
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+same_dev_mount()
+{
+	echo ---- $FUNCNAME ----
+
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+
+	echo Mount the device again to a different mount point
+	_mount $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_subvol_mount()
+{
+	echo ---- $FUNCNAME ----
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/subvol/foo | \
+								_filter_xfs_io
+
+	echo Mounting a subvol
+	_mount -o subvol=subvol $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/subvol/foo $mnt1/bar
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_mount
+
+_scratch_unmount
+_cleanup
+mkdir -p $mnt1
+
+same_dev_subvol_mount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
new file mode 100644
index 000000000000..8787f24ab867
--- /dev/null
+++ b/tests/btrfs/311.out
@@ -0,0 +1,24 @@
+QA output created by 311
+---- same_dev_mount ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mount the device again to a different mount point
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+---- same_dev_subvol_mount ----
+Create subvolume '/mnt/scratch/subvol'
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mounting a subvol
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/subvol/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
-- 
2.39.3


