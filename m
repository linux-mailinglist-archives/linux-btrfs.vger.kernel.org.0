Return-Path: <linux-btrfs+bounces-3803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87A89384D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807F82819AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 06:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC4944D;
	Mon,  1 Apr 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YN7fiurN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PKwLdc+S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7CEBA33;
	Mon,  1 Apr 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952209; cv=fail; b=emQ2K/pgtSyq376GwZMlB19gLWu2V17eNBT+ehzjc5UIWkyjidrIxjoSv0TaZ7k+cP9jBH7ThYAppcrylNIioNBXPV9gOkVgGFCE6nlVUQ9X5nHiQpxVH6E+tbEOwkg8xQ+cJVqNUIz7hCl+SlBM4QeOEfF7MSClb3XkbaWfj5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952209; c=relaxed/simple;
	bh=RCw0SGi/j0dfUgtYkLt0OgbxcPQIt7urHwzpmTgEXi4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uii1oQmeLK46JLdmwQ7PphgXTa9O6DVqoASdSTfy03eWdec9qPsgxyOzW8STGITbzoHbpBndFAnf23MvqCrD+HjPOXwZwzDjOh+K6e2+B8JiVeigk0Rms6a3y+180Dg/VJD7ZeYMG4pK8KF/16iB4zJf280TvPRr9rYTjq2m0RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YN7fiurN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PKwLdc+S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42VMeIJt032063;
	Mon, 1 Apr 2024 06:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=a72arAfel+3iicdp7chxwwTitCO8EZoZpRrQQZMTVWQ=;
 b=YN7fiurN4oam1E6kWUwXmV4wO1kmcL0mKaMj149QCuwjkQI21DZvWEk4CmB0aP7aM5aa
 UTdUHaQ341HW4fj0vJYzohejs/9bkq6rHe1+Hb3oDur24kqDcjM3qU4hjah1Hpwuc8+B
 16BRTpu/eBq/+cIeLw81rujnH2oe7JR/M4bnheulAQd1Y+nmzSWP3uj0KmbUwypNOxNw
 QMVoxNIMhkI/lWMZksw7V5PfpomwSoHTpAPu7H6n7p9E5Jjje2iH488nUanZX4lf2jlv
 2jcNTETSp7CWA2B+orRgRldjRok5WyuMJTFNfPc4fFqS0n6tZCINEXe0NlpJjvS2WgDN Rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69nchrup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 06:16:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4314QGlR028058;
	Mon, 1 Apr 2024 06:16:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6964ym37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 06:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVf89rYcp7riW7ZmCjn/q60q0ZpP/yiGGWCXaz09hufmwpgKXahiFUEnbVpaGwUYpj0wPwcL6bCZHhNj8/n1Wi49Cft1qUtnvnqH5C7tEQcyU5EyDW1WekpafmJuuk8gVTvzMmpmrcrlrDeY1kmQhblY5fNh4E6Ysdw7KPnfoGbWdiLxIAAuuJCNjRC4SGPAwYKMkNIvYalVeFsyftap5pQGnCn8t5zcs60E+4uO56nmfvPEOPXHfOYY9bKh8TqmihM8ddK/xaxpNDryEOQXvL6VP4mhr9rlGGma6hbHoq5npmcGu8u0ZOGb5euiOrP2G5j7BgFREdS/RJ7ZaAswzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a72arAfel+3iicdp7chxwwTitCO8EZoZpRrQQZMTVWQ=;
 b=WDw5GWpwo9u5K7OdAVd5OyRB2HcGvIpcZLEIDmWOvkg0GEduI49JJZYuD7/Csk0zBEd321sjUPp9aK2XzJTuAbAqz4AEoUR0GafiP1wqu0GQNAGUfoUye3mg9VYh/zfN3FjrqRdUS/CqtnWw5vD5pwjUpHnzIB6YC7yXq8s9L+emwlelJniUvzowXMU8nuhn7T9dsE0GrIVxpWZUu5ySGcz5kdoplvaGb7x4qPIQ76mXh8G5x6bpUu02akNmAR3fzEY0/QhUUemTQXWHYwkGS2dC5TSdz9cbhcan/lqiUuz1tyFZdAPNgHZhYv8yw3iDK0AAtLuc3gjZRFndDf7sXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a72arAfel+3iicdp7chxwwTitCO8EZoZpRrQQZMTVWQ=;
 b=PKwLdc+S5KJJ+Wz5fNVVDQiVCdif5NZMuQ4y0WRqXSNE9KuG9UoacW2ai8NW8byOXllknPM8sQyYIMgM8ndoj+4NYpOmqiyW/dk5Rata4NI9eVckWEFUnxRO76c3y+CHhUy6r6pmW5DBRLUITzg7M+/hn5GPd5eggGKHNnOkhu4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7378.namprd10.prod.outlook.com (2603:10b6:930:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 06:16:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 06:16:37 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] common/btrfs: lookup running processes using pgrep
Date: Mon,  1 Apr 2024 14:16:00 +0800
Message-ID: <572b5b3f11cc414bd990d1580f8bf287f4797676.1711952124.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7378:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WZrV1ahL9XPhowh51SYcFcu6m1pQMIyNHJvNaohisoxdBuR++fYrt2Zch5QZfG0gZJJUXpKTf2xRkhcMopd4cVB3y8Wd9hCUuL5XcFrnl8qBhdBUKkcEZzpU5uzwfScJi5VBoQnKnEpwFDX53HJY4JZakJF6/fDchrE5x7ILL8bx+WKmFJOMgS6bQqWc2zCPu9+drWKTIpbvuWoq3aPBGNPEjTNVpidkRpO9ZX7XEN3ODwPt6bV5Z/wp8dk/0lE9z6VuRn5K8hKueh1jKNk+MaPjg6txmHGd0P4B/GxZ+TAh34GAkr/ePS/ZAp/nHU3fNzH8G2MvjLHmyeFSI9bT8VFu68h0g+71yoKztNEL7yXk0gjPwNJWzytMPg0idoAtT5uKqSgSfX0YkWb9kWafN8Bey02IxeFym9+qkVkkMEFKhRpv2JGjXYEu3cmD051mWtSshkd1B5Yo7Rkx5wGV+aMKJr3sS6X8cIrJK+91v3cVRa3XVyBbpqMOx8uAQAnF/xM+9x+6FKLxv0ZFGfZgUgA5E4DYpLb5do0Db26Wwrz/xpzUe9CSqCm7BGnLMr5IcUz6TafYd3GDIHy8qzAugrk/XeO6AGNBCF4+sRsZnzMtIGpOcdCq0xsfsLzJ9RIQKrjMNOtaOraBGIR2+K3tZA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pazyax+iFBlSea64bHt3mAXeJ2Sd5RNIQoluRewP0qeqtWkDRc+fenMBJucA?=
 =?us-ascii?Q?WfTEGwJ3Jp69ax/u2EPNo9Z8vZ+kt+U0yK3/Wrp4axY0RO8EjROQB3jK4CJO?=
 =?us-ascii?Q?AdkOKhZP3E3z9N5fY0610/XVhfQ9WXV9ZVHIezWBgPRZA7+m8o63XaXRPcKf?=
 =?us-ascii?Q?I43M5pIDNYX7ejP41p5D+taqaoXKyC5DNOFmujityzxI8Gt8Ps/7tO1t3B39?=
 =?us-ascii?Q?6BXhI54tqmhMtM99P8+zcCXQRzHnuRv11N1nAUeBinyonDZi0FA6KeouQwKq?=
 =?us-ascii?Q?ABKJt9Qqfg08LzanWIkY7J+8BDI5lorVCl7kmhbR4Wne8dpU1nP9+ONIqoS5?=
 =?us-ascii?Q?XLYinob+ULn79z/fowM7v64TGBSoX3VECfx7eI/suVCfuxB1LjS6ut9ucEP9?=
 =?us-ascii?Q?jcP8kcfgq71cBnCR8GvI9XiZ7DIks5ZT5nkqaLJH3iqryJFciAAWsX9Gg9oQ?=
 =?us-ascii?Q?/WkqsrZfyGp26YMmdFstaIMFDYUCQoiQZfDmSxz9eO1huvZN/zmF5A0mNv0P?=
 =?us-ascii?Q?hEYMrWAKlJye3TaVVoEsPqQ/td7WaALMFRmLWwXRaEfg3tG6RaUaV58pFtYV?=
 =?us-ascii?Q?ODNV6VAx2Bpwc20AWTSZRQgRV924ZG/VFlkChfnFff/87G7iO1OunAXEQo2K?=
 =?us-ascii?Q?lm+BOCcvAH5U2EhlYT5v5DSSLsRj2+HudwOZ5XhKGZTiSK4he3RI70u3HXe+?=
 =?us-ascii?Q?yOY6CfaV/F4Nb6P6xHF6E1XNUPLHFE4sKcDtSOOpzyKWTMF886+rqFIOrE/n?=
 =?us-ascii?Q?29jJ/Z0Ob5QqXAchXXsWIodaAMu+Ti9sXXfJ+7SIG/jiwC0M5XFktiS6czl0?=
 =?us-ascii?Q?sFqjt8zi3CNykH0Ws78nkJAkkj1wepsCJV8dhnfessbmx8lopjf9PxdRl5Il?=
 =?us-ascii?Q?oK3gqodHoDve4YD+/xzkCKzn/sr9RDZVBpiPkkSji2a3V67yT8FfUt//tcIC?=
 =?us-ascii?Q?CdcAr6VULVzmTOnCEMBsDuTADqblfG3Wyui/ISbYeGhH9KayFUiZovgNIOUO?=
 =?us-ascii?Q?hh/BoAvQJMMESleoCT8j375KzbPEs/1BsobIbTtfIHsTIX5hLYpm8ubhQM0H?=
 =?us-ascii?Q?Nk55+OQmT/x4EQQNLlkJv9QRENOTAjFnuxEtGqs34c53DjMGJ7O2DfpCbjGp?=
 =?us-ascii?Q?PM4BgXbC+pclZSiVleUTVLDzqvTc3YljYjelmmMRW7N015VvxrApf2ycCBBd?=
 =?us-ascii?Q?yWFFvOsRobZ5t5ks6vwrQ7+xnV1ZAip3bwk/CHQJ4GM78w3E7QDkyQ7DKZ7d?=
 =?us-ascii?Q?Xv4wxZfZHMPQ1BCRz7khG5smSaAha3PN/9jFL1GLi9czUb4TeO4+LCjH924p?=
 =?us-ascii?Q?a2fVUycgUUMJsggJ9ygf1g2EWVnMuioY0utFzEPGysFcfb6FTDVVdiI88PHg?=
 =?us-ascii?Q?DvOlkJv+1oJIZ2gDkEkRrF7n882rLL//f5ntPkp9Omcn8DFot75HgCXUmqZq?=
 =?us-ascii?Q?MdReh3UkQhiHYHwVN8+9w8frzSEVL1OkGZjBkJCoY5X+g4NG3uT9sLzliqsG?=
 =?us-ascii?Q?sK14/Zuc3vvXuSryGOzMrKZSH5RwplsuNXykm2vtz9iya3jLLtLwfGRSuf/3?=
 =?us-ascii?Q?83eoihn7Giv0a5W6y/LMLR2P6blNitD78rp39qag?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TQK0BGXUk/gu3e6cInGZrp+BFoXEG0SPnKjKhEkAL4VTTr8OWsHifIRaiIU0ESpWKz05hM98CfOKxKJz8IuyQ6NgCjF6Lh1QqdQ0m1g/NTkkk+2uZ9ESmTI1MOUfCsvAby4tAdACBLzOugtKW2v9SNxI1ViMm07HQfzmbnAi0by8KFk1yGqRL12s7kurTy8WJ7aKoJokbsNCK+BkH27MQMxNSriIk5GnawzIzLAqqJG0mK7+xTFHSoZtzbASYfB1R8bBP6s35e4mmnFfJ3kX5ABp7fBuDlEZUGA3bzFfJpUuJliIQCjelNlgNO0kG+LLyfv+pRE2Sw1xgsnEr/mtfwXQjr9SMNx7refHAadGBeRXLwNGxypWkp/9h8QPxBrqYvhTj5P96CjuSjkJBILNCOuAu3rfnZbrpCmfMk4ycXhGQigCvPJebGL3qKi+EkNzG9QnhvaghMBbY+LgqXixh/IchaGG49BPwBrFeBXByXZqvcoYKwuaXJ1pRUDccPE+0/D77XbpqGVhJ+/kw9ggL5Hn1AFYqNMddpvDcFQB7P7OjxgKz13ElPq+iQi2bnUyVitmzQmwr9oLiEdVvFh2oqhz1gCNc+DC+huwChCVgBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873ebc65-2301-45cc-9d59-08dc5213498c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 06:16:37.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H8MS5eCpjAwZUfN+DfQAxBcdJu5ntv8mtn+Qs8q017uFxpluAXapAfuvGLYI/Be9Y293dXiZ0NkzH8cI0A5mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_03,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404010043
X-Proofpoint-GUID: Sovg_Npcmv2bdpMBwvcd1hLqZ6ktXM1a
X-Proofpoint-ORIG-GUID: Sovg_Npcmv2bdpMBwvcd1hLqZ6ktXM1a

Certain helper functions and the testcase btrfs/132 use the following
script to find running processes:

	while ps aux | grep "balance start" | grep -qv grep; do
	<>
	done

Instead, using pgrep is more efficient.

	while pgrep -f "btrfs balance start" > /dev/null; do
	<>
	done

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs    | 10 +++++-----
 tests/btrfs/132 |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 2c086227d8e0..a320b0e41d0d 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -327,7 +327,7 @@ _btrfs_kill_stress_balance_pid()
 	kill $balance_pid &> /dev/null
 	wait $balance_pid &> /dev/null
 	# Wait for the balance operation to finish.
-	while ps aux | grep "balance start" | grep -qv grep; do
+	while pgrep -f "btrfs balance start" > /dev/null; do
 		sleep 1
 	done
 }
@@ -381,7 +381,7 @@ _btrfs_kill_stress_scrub_pid()
        kill $scrub_pid &> /dev/null
        wait $scrub_pid &> /dev/null
        # Wait for the scrub operation to finish.
-       while ps aux | grep "scrub start" | grep -qv grep; do
+       while pgrep -f "btrfs scrub start" > /dev/null; do
                sleep 1
        done
 }
@@ -415,7 +415,7 @@ _btrfs_kill_stress_defrag_pid()
        kill $defrag_pid &> /dev/null
        wait $defrag_pid &> /dev/null
        # Wait for the defrag operation to finish.
-       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
+       while pgrep -f "btrfs filesystem defrag" > /dev/null; do
                sleep 1
        done
 }
@@ -444,7 +444,7 @@ _btrfs_kill_stress_remount_compress_pid()
 	kill $remount_pid &> /dev/null
 	wait $remount_pid &> /dev/null
 	# Wait for the remount loop to finish.
-	while ps aux | grep "mount.*${btrfs_mnt}" | grep -qv grep; do
+	while pgrep -f "mount.*${btrfs_mnt}" > /dev/null; do
 		sleep 1
 	done
 }
@@ -507,7 +507,7 @@ _btrfs_kill_stress_replace_pid()
        kill $replace_pid &> /dev/null
        wait $replace_pid &> /dev/null
        # Wait for the replace operation to finish.
-       while ps aux | grep "replace start" | grep -qv grep; do
+       while pgrep -f "btrfs replace start" > /dev/null; do
                sleep 1
        done
 }
diff --git a/tests/btrfs/132 b/tests/btrfs/132
index f50420f51181..b48395c1884f 100755
--- a/tests/btrfs/132
+++ b/tests/btrfs/132
@@ -70,7 +70,7 @@ kill $pids
 wait
 
 # Wait all writers really exits
-while ps aux | grep "$SCRATCH_MNT" | grep -qv grep; do
+while pgrep -f "$SCRATCH_MNT" > /dev/null; do
 	sleep 1
 done
 
-- 
2.39.3


