Return-Path: <linux-btrfs+bounces-4396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4668A93BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E828142A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F033B79F;
	Thu, 18 Apr 2024 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gyz8NuOX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0/Rhonk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2E2D057
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424180; cv=fail; b=OQ7LXCTngaD+JSXZp+Jbf1PpEuj2TiTdr51/hyLGxfkExL+VCechW1XNMNaQYMh2Cijdtl2W65XsMzKzYJnI8Fn/e4vIrL8HGt4ZCUcVZmGMAait3Ix8Z90DI+6Anxs/wiJ7h3Nl0iGl5+pqdQn/8Jl+j2aCA4zuj+ur4pXT7zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424180; c=relaxed/simple;
	bh=/vJ9U5W8XvRFwZZ3DoWHKjELtDPjZtnmU2D61ZLqGMU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EtcYUoRbNdVh1NfdSjwxPr+JHUfLlDjrJs2vsMRc34mmgPYY+0LlQmW18lyCoXiesAl2AN2DOq0BmR6wwjchym2JPq59CdeFcgbgwlHSqyYVNlrQQSUeV6k5O3Zumpmv+/ZVGQGxW7QV8gfj6heYx1odkTqhOpLtgyfDZ6UVBpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gyz8NuOX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0/Rhonk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3x2Dk007720
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=NYan85vHYWmCOlXpo0R2OyQL+qrm3BfX5czfXGyYquk=;
 b=gyz8NuOX2gfiCFDElbsmIpvU6v+ueOAetjeLPG6pX24yVHs+xw+cpmggPH54svSD0V1B
 z+spOiq5OBWB6+z1xuj6zST33UNzxibEwTruIJftWTySCtQVXoRtpRimLYNeNUOikkbo
 JmDsIdvdoJ6qQ2WTtzPSbMJMI3knuXDZ5n3ckeAOpp4mYAbqrOUxFOwCECQr/WTqOxWR
 KguhWbDHRxT2t3X+cHNeibE/tH38J78kr5l+tJhQ64jEUz1kFra5m/LOqS/ShXdB0ruY
 vb123fduEVHFwNvWSW+NCdcdTWF9QwNT8GHPUfa/vnIN2axFNOm72v2BW9v/Evjwb8Mv aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2smsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I6Geen028881
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y71y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB/JM2GECmN+/ijRsOshw1vn8OeP3Cg0g1C7R64gbyIKoHaFwhF41qOUUhcaL/LuqDOWXZGNxZtTu78ZphrMqCfu3UOe0LVa5JnMt8+UvytWlS2getRX9ktIEGMdeDqM/9NMBPG9EupMMi8hBXyQxsaoGSvYfqeIU8+routD62En5XDR/ncSxTkZrRGgJiEyXTopw1FHUSmVKcRI0whS9zl7tGLf4tnElhB7EkRuHnJIA1gQX0Ntr/GvVPEokTjhOZaG1+Jf7yZ1cj7CLVCfIAQpKSbJTc9HtRv7KZEkBNnGjtQrQnxngMTelum+ulpwaSxVMZbUIgg88a2rYC300w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYan85vHYWmCOlXpo0R2OyQL+qrm3BfX5czfXGyYquk=;
 b=KyXFgQE9nIkQHAko2cUoCZgMSToSzJyaTu5LnP4B+bTdxWT1Zd3zDNU/WxdmVe2mNnMIei/xtr6HSwEQE0uXYbemOTbzh3ELXF4RJNfYyToRh+LWdmkvfcG0E9lPm8prJFSoUAZdZt6lcG4Qqyb6j0qCJ9SSZEAgI6ZPDZyGWfrVoRTdxZDvEc97S/x3Zap9/Li0OnZT/b7pHD2GqK8WwX4n9olQ6LDFxeXif1/9bUH4ibhQWBJKhxIpHLlopID28gQMSaIiG0CkfwGRcDU4DXGg1RiwaPrpzXsLYxwXOfnxzC8OG4aNb4fArWZWNvwsjg6OLYhuHbw7Jw8Kbn9S3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYan85vHYWmCOlXpo0R2OyQL+qrm3BfX5czfXGyYquk=;
 b=j0/RhonkkfJ3eA02Rn9SohN4ikq+0CH90gN9NOUe0N0gFAwPy806Fvr8FW6UcRFNciCPwErQHRAYj9yuGszqyQWZ3rQ854PAjiN6NG0/EXrQkJHnQroLPQY3tavsfoT2tBDXU8NNROrA5IPnFPn8qPJpt0sEurg83RnurJn8hnM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:09:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:09:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 00/11] part2 trivial adjustments for return variable coding style
Date: Thu, 18 Apr 2024 15:08:32 +0800
Message-ID: <cover.1713370756.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: cb303fe0-74cf-4c06-7107-08dc5f76808e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vUDtAaneYnv2M2UuYM9VZsex4iUVebbqKEonzZgABCCtLWEi0CeDA1iHpTpclvglJLwMPIsx+3uyolpebekCWtexWrCMN5UGSXIMQoH2ufbiQQKi6nxn+img/Zaaou1wR9pfturcdl6BMbsRGbvFpJckxcO1R0vqy4EHfjAsZT4K/L6HM5fgx8c9qFwoyOopEKHwKjs+up5oG59lGIO3krYFZU4+MF+CE3YbAqhsZ5nmSTaEDGqrYpY2n9DG0hKinlJWN91lTjg+kVJa+eRluL1vSqQTZkRGLj8i30bEp/YPBAAw2afT0bRQIZwN/aSNBE0c27c6U5aBzkc2hj8NMNovBn+LWjyvLcucpwUh+D5IM7Nbg/cr+QAavZovTbOsboypdW/xPiOvYDsBucbuldbCc2aR1qhu5p6U8IT3CF9l1SGaRb399W1lF3GUfs8O75o9eIEwEadxQnzT/ioyNAO81uf2tT/k/UG5rF3KpGGA02PeKtoNbjV+odw7L24E5WIkeadhZMFjtynj43pg5IjEvTHXhqInGC2z+a0d6assL+rl/gB3cIF5jReG2pVDu/jYx1kp7rmLMjYbaSVg1V3DcdahvcldmB8H2LrGEQrN3gfOX6gajgm0iQ1aGmWb5Ob/fPt0xrULw04lxkHLWT71rGS09P8SIXe95KuYjp0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hnmciq/DClthC29DoRQP1xplwR/UqeRknDD16TCer4G86BXJKOcDt2SUKIbL?=
 =?us-ascii?Q?Mc6qBD1LvFSJDSWR9Gl8mXD0X+UkGfQQDN8bHs/e+CkLbeF3JFDNNWX96s4+?=
 =?us-ascii?Q?cwG+Rpy7d+dearuO+134wgebQzaKNwlHemeyBu7p9qBvHUl/Ex7pYqUvK4u3?=
 =?us-ascii?Q?I3xEzo0Pk3O1q8iI5U5p4KyZzmsNzhj9aDK0XV5a7E8ewH+mBiINrjcVwsp+?=
 =?us-ascii?Q?lRaXutZFhC9TPtQcCfO8rllAjAr3gTyhpinwbaxaKcMfL/H/fTD8nUs30o8G?=
 =?us-ascii?Q?uCH8LJNeVo3HJOuwYx2C1UyHenAkOgNqLlJgdkyRuQUutcvM627FOx/5C9jd?=
 =?us-ascii?Q?caBKLPHa08RVgoIHxHe04c063Z9OrcYoIBQPrlWCNKj35SxheBl0pxXKzdsB?=
 =?us-ascii?Q?OjTpx5slhoT/kQ73IqwE8ObQtUCPJynae3obhWQnJHF4Nqow2PW48uB1y6Pi?=
 =?us-ascii?Q?RoyQt20eLo7jmff1bB3ZsBj8zbuWV5Q0XtSPS8eC+XD+IeBVUyHcH/jhz7cN?=
 =?us-ascii?Q?HJw+d5Kw67kWVHpI1wGcZtP28U5+WgwYydTFA9VIVX9Nwe7rE702aOK4/gqL?=
 =?us-ascii?Q?NMYoXpFbQV3HoBl6svrKew7vyMZgqZoWhaVTzzjMLtLjSJfxRH2k2h5kFRMN?=
 =?us-ascii?Q?+NWxFXX7d4qGmYzqW/oBy/kftqRby26gnlt/AO0x3+hMHSfpfk1wU5CjOlib?=
 =?us-ascii?Q?vOrikwL7aujxw8f7WVVmqX1KKWbZTb4gHRurGSwhwqMRAXEfvo0SPV9PsNeb?=
 =?us-ascii?Q?UO48l4O9LBwHnhXDwhVHZO3DExMxm0oRjwE3v/oxSNOumMjiLfQiJcfG7UX2?=
 =?us-ascii?Q?YtzBMxc1kfajnXNL5PmSUy8G0jHJ7U9i8qE9KWbMfjEubuCvrB9/r0crHu4T?=
 =?us-ascii?Q?B62CSvTk6677zNF7ThR+NgoUKnQyChLOz3lD85sgWGQUNV/YXuxnUpFwlRLz?=
 =?us-ascii?Q?O6XYpBXiVMmDj0U0jN53uZHn/Gv05gug1r1L90oGm2qkQAjNapOJXcuFwrxz?=
 =?us-ascii?Q?08N5kZXpV1+mpB3dQdicve50tvV+SC+mU54wnDOpv6IEZxWLiWcIk2X0mm5N?=
 =?us-ascii?Q?QzfXXzwuwRLAq3gLskZosZCvrQ4cWz5sG/4z/UktRtkiWUuenrBcz2n7btqC?=
 =?us-ascii?Q?JfnmVeJeRLJH4/apAFj8FJg3Xl/xBWbI47O8ZyUZ9ml1/BvnKpLEPdhKv8Is?=
 =?us-ascii?Q?oqlNGsVJ3zAyiX8c0DCz3b5L6bh6oVNXZS5W3AAt8+ZmbTvIBCm7gXgi5S2b?=
 =?us-ascii?Q?fkNsQm0v6Xxqx+15k7F4ycHbxRcADKiS1TOp/c7WnzGZPLIideHpu4WIVokM?=
 =?us-ascii?Q?p6HrbVbbfNr3h6HlQW4cajh75HWGuv/VUFwbvNL3U8yzaKsWZFPiRgjkas+Q?=
 =?us-ascii?Q?CYowo2SbfKjDgWwrKuoS1Y9jbruh/hpG/U3Ao41pjCE60phZ3Qhk1bahq7N5?=
 =?us-ascii?Q?JH3sn3/xV0pG4ftmfieOVNuSfABsF+K5x2YhyV7IyCqRNQTe06E2CG3MAxmi?=
 =?us-ascii?Q?GsGMB3GP2VCHc/Sm/9tg555Q9lC1go6Nj/PKy8hE/cpdC8f9QvCMYjcAnErJ?=
 =?us-ascii?Q?aDQl4NiKBjA9WxYQf5yV+VJKyXQwkIsf1RwD+afY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d20LsmKyHUyNsAvZ8ZaGph/J37V2+1WwuEQF8+OjC1iNvtRwV9vd7sUV4S1pOcKu7Chm9yW6L9mCBP0ItjOCHvaUeCA9O8W1KPu59cn5GwMHXhlavAV0mqVEHojLjxTrG5dE2eUCH2q987N5MqBjY/iY7m/agQ/wZ/jcvUUmhmwGEGjTrr80qS8sl1LUeNJsJJbRRoEhMPZY8kcCOJnboJ6lhwxd8vCvKmBhWsP/jG81G3KpyL3CUwBGa2if1v9YacdOtTz2gTZAsPm2zY8/jdldV2iYjEeLHybtzNSAYIUMiwggsrtHCZjah2sHkffKO73c6PL78TkEXypdfCtWiGEb9mPXqQHDTc8M7IeoKAHLzkRrXmt31CLCaq4HFm9/emlSR8Vp8M9gg1q4F6aSvZYdgRuWebJ8mW3uMLg9A43whm+XfhfV7kcZ9abdMXA2kTjHcU18ivIIqA8Jbq/C29a7YMs4wMlGmkMuX86wnSyMdK+lFYIDaH7a5qmj0W4EvtzDBnOxrl965r+jSQxGCoJ2B63Eo2VP3ptoZntU1gdg1THn5bfTJRFZVaCqfZqy4kUhaX6C7krJudfHKB/JRFChIirJMcw7qK7eFZyC70Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb303fe0-74cf-4c06-7107-08dc5f76808e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:09:34.8295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBDpTIiG8pOo/lV9j7mRIW24ZP1xIp7ppH/YUyRqb6Wx/c480fIZQksHWkZkw4oha/iw1lNUT3G3r773ru29hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: Ievll63rJrbGxJ4JWqpEFCe0ah2hp85e
X-Proofpoint-GUID: Ievll63rJrbGxJ4JWqpEFCe0ah2hp85e

This is Part 2 of the series, following v1 as below. Changes includes
optimizations on top of reorganizing the return variables in each function,
as stated in the each patch, based on the received review feedback. Thank you.

v1:
  https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/

Anand Jain (11):
  btrfs: btrfs_cleanup_fs_roots handle ret variable
  btrfs: btrfs_write_marked_extents rename werr and err to ret
  btrfs: __btrfs_wait_marked_extents rename werr and err to ret
  btrfs: build_backref_tree rename err and ret to ret
  btrfs: relocate_tree_blocks reuse ret instead of err
  btrfs: btrfs_recover_relocation rename ret to ret2 and err to ret
  btrfs: quick_update_accounting drop variable err
  btrfs: btrfs_qgroup_rescan_worker rename ret to ret2 and err to ret
  btrfs: lookup_extent_data_ref code optimize return
  btrfs: btrfs_drop_snapshot optimize return variable
  btrfs: btrfs_drop_subtree optimize return variable

 fs/btrfs/disk-io.c     |  33 ++++++--------
 fs/btrfs/extent-tree.c |  93 ++++++++++++++++++-------------------
 fs/btrfs/qgroup.c      |  45 +++++++++---------
 fs/btrfs/relocation.c  | 101 +++++++++++++++++++----------------------
 fs/btrfs/transaction.c |  44 ++++++++----------
 5 files changed, 146 insertions(+), 170 deletions(-)

-- 
2.41.0


