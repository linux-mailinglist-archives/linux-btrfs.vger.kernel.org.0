Return-Path: <linux-btrfs+bounces-5178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27808CB2A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EC61C219EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6591482F5;
	Tue, 21 May 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kL5eyvEA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W1pknImb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0197142910
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311586; cv=fail; b=c23zxWP+mqn8Fc1FnXIn0tVEGfNuxZnP2FfXcd5wfn/kaqIXzjD/wbPwtS0SfX06omHzEOHr+DaXEAZha0fMiWdTNcQ8UQ7+uaQWQMAk1e3Lyn0z+s42zG/CvzGL9m+QVSDYOblaQy/u8ykd4X+5chuSdlLuhMSLo7uQ6v0kgIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311586; c=relaxed/simple;
	bh=VFW9v3QPvGMUOQSd5roxZKIsTxAnVPAFCOOuD5WfZbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kIwrPyISOxKRjwbyEFXXkMt0tHpuDqDO6zZorot8vktZl3kX4oNU6iUvc9EJFuCT5EARAYikJqGlCa3th+2aEAXhD+RH8WDtpEdviQELeCrR1Otw/Toxzp8I3FElwiC1oDNTV5jbUa+ipVGUie8bMNVMKF1YTtN+nmaZ/0k5ytI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kL5eyvEA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W1pknImb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGxLPl001516
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=IcinQkBetQ9pXCylSBrRsQd5iUtlsqIszeUJdoE85kI=;
 b=kL5eyvEAVb5Mm+H+OrzjcHlNza+j+7KwFa6le26eVHtEWTQAMG4Fet95k/WqMtNE2ZLs
 p9VbQp6CecEhim1iuak/Ab4rFZ8zSyKTFdPPU1lMtY9Q42JQpyl1y/bAuxg13u1jYzgl
 zS2AX4VzmP7iocnC0zWndL/Tl4mPLTvDZp5ki/kaAa5ckglEsNK/GYWxKmdYcyJat5Cr
 DK0zkNDCNkbtVCztKdci1BW1MXrpoLgmBZ8Ez2EUIUudkr3rC/EfGBZX83VjOc1uvBjL
 aQFN0jihHRBMvUdh69Ys+6l6oH1qgjGq24gEUJZUXsSYsTjIG/pB81RAoZZ3FGeXy4QO eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv5w0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:13:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LH9JQD038423
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:13:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jse1tdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVdO2MFWjCoFqXS9W/51jG2PpxUOXpp48reQ2NP6iwfTbpiPImiiaN3x8jeYDbQ77B+byn4U1iI/a/cED5OZddVpxyj0cML6KzhsqFPv8mxTWn4XyXm2wbJ65PIKq8AI071W9670GdFhvNBeav4SmcD4ouo3u4XF8SYOmCzgMRGLrWhFHUchZMtLQ37EuCZx7EPC4ntZVtQrGdh63SitLRMe39fMnza8NtdzFjpz1qr40Mt0tQCB+Hz5WEXZIPDNZcT3Pf6eXGT+8eP6Xrys2DAXcOUFwz2f2M5mIz/1o3goTG4J6iObwR8/tqhuii04urU86i0zgAIHIAaPKv7uvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcinQkBetQ9pXCylSBrRsQd5iUtlsqIszeUJdoE85kI=;
 b=Avwpl9sLyh4uj7smrz/RE7Thjyq7EwENMSvOljvJF6whaGGtUXZiKeGDP93BYN4GYcJS2E4TisBc8NHJeUMbLRcsPTBuGihNYYrlz/3i7xkFieMFjqWvLXILcTZgWKglDZsb2bmHNHXHDAXdsvi69AOmhA+7uUynCzXFexCAe66ZCelHLWzDl1R+iZTaFSyn3wbrcPh5I763dSefPA2Txr5ZhmeFptm6xP3Ys0SOvfak6lA0V+FweOgb1hmkn/CZ0w7fW5uqajyPCV15g11exJKWJtEwPjdzPQbYuDcKkQ6j0KbeJKKcOf3+63bp1wJBjwrKnZNayo9+SFn5jtTiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcinQkBetQ9pXCylSBrRsQd5iUtlsqIszeUJdoE85kI=;
 b=W1pknImbmrk7w753GZN9b4EP6Q4DDGNHmNO8usHrM6LXidc4lF0A+zEcOjQCxBIffv3+z1zxTgUlHYoahzPkmb185U0Vviv7+ArJEd6OaOjzItDoUJzFKKbokwWeEHFC2aYOAqeeDPVRmFC/EYfwx4wAIrQhx7US9dSsJvB2No0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:13:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:13:00 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 6/6] btrfs: rename err to ret in btrfs_find_orphan_roots()
Date: Wed, 22 May 2024 01:11:12 +0800
Message-ID: <5579ea3ed3d669b2655b64dc67fbdc7587338f8d.1716310365.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1716310365.git.anand.jain@oracle.com>
References: <cover.1716310365.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d354999-9872-4100-b782-08dc79b94435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Eer7aM3F9G9lFiN4hl/C8A/4aOC7JbyEHEiovrfRmcx/e/CX57jPEOdK6k44?=
 =?us-ascii?Q?vGGxnqz8kdlACxpWri9ekZZRHMuICj3Cp+cpKGW1A/UOmN5RzkrNRyR+N5Fu?=
 =?us-ascii?Q?Id7nvMGQ1Fpat9ojSaWxZUbsXkfG8SEv1Cf+dW5yRjMJUtX1hYJfqtRfsdqx?=
 =?us-ascii?Q?U9rV5ZBHffckFZKs3x0vp38z+dCHXXyOdonVcin+lHNivY8TEMLQQ5GNMmlz?=
 =?us-ascii?Q?eBttlq3louNduhwBnvNGWXcM2Lz1WpgE8sPF6ntX3r+QgnCJRDrU0RBNH5ph?=
 =?us-ascii?Q?dKvB9sCIg3ZiboTVg6GVfI3vqMnFGRb4zF8gTqnjVaU5MlaxDfBsJ0dCZnLr?=
 =?us-ascii?Q?pUmB9HimXhmVDhdc9Du7rnE+/BnAEQ5zy7yM1tb9hXccc3TfDxNCpbJk8vmR?=
 =?us-ascii?Q?+wiDvef61BC7fG6JUIbagqp0iwZ2SURJAZkwyP8ugVxt2HsFm5hdifTIxkf7?=
 =?us-ascii?Q?lF00V7qqwkIJ8XG6gVdrGjJcdp0uN/R+anmO5xhfdRDKx8J2BefXG2yLb4sV?=
 =?us-ascii?Q?AVFs/3obMZ2jldvOGEBhU1Q4i1Zta+dcnP0WVJNMfz9kMntZEJbI+3yHdIrv?=
 =?us-ascii?Q?WfzS1hzIbkHMr+13dId+2llM5Z7Ch0i2NMr9TfzwMUzevhcUDN7RetwW6SlT?=
 =?us-ascii?Q?HMm4TmxOl2dDdS4E/C1az+lDk1PsC+PBWwKajtBl8SX1nLRu4TL00XW9drZf?=
 =?us-ascii?Q?UEV1wD1Sa0+t5BHiSgKphsZFe9YirG7Wun7xNdntE6jGKvEiDZ6GHTNEnYtA?=
 =?us-ascii?Q?fVcw6gGbt8y5+bHh01Z/2oIVI0uhHDbucFA/9hmK9maS4UcsnShbhD/os+Iz?=
 =?us-ascii?Q?r3CBFQBp5nCec19hTSYUIGVCTtlkuiaTFUthOxqFpNvtu+/lLZnUL8TKwNBx?=
 =?us-ascii?Q?xJqn84NIfHQt0Jc+XLQspF3xVSLJgHweI1u/xkkbtJrhk/d9wvb8SuSy+mjX?=
 =?us-ascii?Q?DaW1x4diXaec78E4ow00RAkb3FmTyfjLoPT60Dg0WzxieN8Y1j4Gv+8AacQj?=
 =?us-ascii?Q?/NDXw+N70enaSbxm1ii4wdD6OuJoP7sEd85aSC3Hx3S1NYWYGn3lqLCy78dU?=
 =?us-ascii?Q?cZpuWxVpBfxkO5Ay2YKr0m5+eCXsfjuaiHPHu5zBIGi5fdvS/nZ7ien4QRUK?=
 =?us-ascii?Q?eaY29t8MRoUAu+OA4WQ3j39L5rXWCTOhpTVRC6zvEtx9E5Nl9ff/JpJWyhZl?=
 =?us-ascii?Q?qqC+bhLa4Lw5pxrRI42689BUVYX0M0pwubxdfDJgdZbNkHIGJ5QjhxiIm0/Q?=
 =?us-ascii?Q?67AzIZk/f9X+vIm8aiPp8Wkp1Fb/7lTs5tVBHyrOgA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hcY6AfL54yOAHSsFkDbwekL2Qe65chZFz3Bvq3JZRdKdbGgV3igkPsKyDK4/?=
 =?us-ascii?Q?Baaqn8ntsw4tpVjunw/lwXugSuRDxMtLKXSoc1OL9p3SX4kS8jqtWQXZfGf7?=
 =?us-ascii?Q?fX2z1aQOKX+Hc12S0+kYpvDIzLO6/P5z+eP2uVlria7EcPPqzpo+OnFqQq6X?=
 =?us-ascii?Q?iFQ4iS4gbdf+hxBivQMi0vFInm2c+g4bwJOB8o2MNv3Z47W6z3IsbXr8mxX6?=
 =?us-ascii?Q?AdBTxqnjUNOq4s2fFd1taJWz9RS3j+ThZWPw/n5XBweHWPWieiS79ruyBH5s?=
 =?us-ascii?Q?SBX8JwxGfANkt2JxoMA7FSo3K03DVVKxlN3Nr+PaSIVTmFtkBR+4DN/y5XCI?=
 =?us-ascii?Q?hGuVU95EoTDz6PUqKb58pRl6FXaF8a+9loYuLA+SpBV4VxGpaiVX0htZWAit?=
 =?us-ascii?Q?+6vcBHF+mo5A/U50/m95LxAZuRUkuJVQjuXX+HVc8mZpkksfz567GZWythDB?=
 =?us-ascii?Q?cs5t6uaqZkI25TwK6QkWSPmoJLzNQTDQXZcV36OZlWQOtvs+6mw7YPghHEpl?=
 =?us-ascii?Q?OAJs1B3N1LCd4w0votgjJjvM6YxRQ21/1kOdgEhgJIAhDfWV07pSOjOXE6D1?=
 =?us-ascii?Q?ov8WvKpRhVhUnRCa4qmFlxWrsli2OxCTAt3lvr3Zoxkz+iDi/zkqyFXqipth?=
 =?us-ascii?Q?lytKPtAUQX7uF0bnok9LmGMhChGciEhAKhc66SoeGxN5T9Zyglt0/5p/Vk5x?=
 =?us-ascii?Q?l9fxcXyV/pHR1uCA6ey6RovHjkZW5xkgmpXiscaCk3bOC+FRoEN7pc70jeiw?=
 =?us-ascii?Q?h99ufRdpccKuBoyxzQ1FJFCLi+wtqJHHCHosnLZF/pYnLSoVr0ZCUMrBN/wT?=
 =?us-ascii?Q?S4916DB+72LLtYbduBiao1959lvElsogLr/2QGqeStWIb4UsYvo+ptPjFxp2?=
 =?us-ascii?Q?4Dbq+0ZCFo31HQU9yOvgH7xf0vbB5K/+oCQkqZ4xFiPJ40bKD7DzB3npWVqu?=
 =?us-ascii?Q?Kmcd6FIEUUD67GIIrbsWcq6CAmlAsJHoGqg9MVh0QVng6CjRKPFmrqL1r/TB?=
 =?us-ascii?Q?m8gyxITLKnUUX7FvR38+hjrJgfMgpr6xFU9WDvUYSHUB/DBH+CY2mMo9aqpX?=
 =?us-ascii?Q?36Echs02j+HE6YHiMjP5o7wPyJu6nv/K78MPIv4L5LrKn8IIWXqjrqpPKZzq?=
 =?us-ascii?Q?7wn2YPxh5tDEjrsjqvOyLn+B2Xdv5SbFNGH69UqfE3IIWUZ3QUStxaC4qoPu?=
 =?us-ascii?Q?6O7KeVtbot+rbVF5DtWGx8yReQi5c6ZQEp7prqGmVFqyCeREa9Gus9JZeRtQ?=
 =?us-ascii?Q?UhHKlH+pyItuliT4MJJYfXwfPqqYzP1tI3jCNW7s48J1nE7+n1gm3BCTL3/a?=
 =?us-ascii?Q?1RvkJc9hxVjFJ4tYABHoYOonlHAdHDxmdrqxsvcoe+A7WjtLfhFhG/GbGaGc?=
 =?us-ascii?Q?kjBDmzqVXhwbtzGABK5lb0j4wZjkNcS/KABPnCh0SU6Bht7SL583xJizf5PG?=
 =?us-ascii?Q?XHoIo4YNLciqjfIN6lXAYSZT3rfw+OqokAJIvyrAGjbkLH4Bhv7x488PhU9k?=
 =?us-ascii?Q?W0IP5TjvuhFH6+SXCm2UuJ/zIeHmBqBWLAxfp7XqndQvtNzNG/dBQDxog0Sr?=
 =?us-ascii?Q?xe+kDK5H5vs62l8w7aNVXuF+11oAIE2Sbq59YTyQ2BDAzn0j+dcoTzTojUo6?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pLR7V7preYA/c0ZeEzQcmfrxrFSU4MgLS9mLAzgOJ6mFPh2U7AiVZd5r6D0J7xH75E3HfQnwHukhGRMFs5TaLw1pYGn+pVGK3vfG3K144C6DhA+OSokAh4t+n2vK8VXRuioDTQN0C570FfgclwS3M5vMEFD6SGHwbWxh8XZK+MlTsf1KsXu8lP10JHWsZlFNDh4Uuip0eXY8LLqwcuuamakwZlQ7th4h23Fmk9qCkdN8wSRFKbBGW1k2xkInoYABcsd+Cdet79r9FNNTcwZcvhsud4yww8bdv9QQ9ajoHbJP4G6TRB/DJqaoYuf1/fPBWiGJr/Q1I4aWMZuLT9rgbMaRDrWLYO1fNuq6MJwkKiaMfqInFBmx55N2Xo9cpoOyycmHJEon9+X8OCWb2rRj6Km+syTeGeKCuqcUdIAXvqyXtb0SiqSKDgKSs6oWGMbCUeVl8FVyfjVj02C6xQuPlq/W2WHQCIGor2qE0gGDHpruJaVbi4MB8o0UYbCu2jv52oP9+rDyvvv6o2u3ViwiDhLSVaZMYcKLFcQqumFcaWfdFpq8JGDvHBRpQGt7PDAW3d+CqtJwghtmBD8Hq86xkHHATDpZVDig2ylLBzH8oRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d354999-9872-4100-b782-08dc79b94435
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:13:00.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30qC5/oBzXLCkl12t0DhfgW/GJPW5zAMJtvVPQAXTJQZci32buwKsjH6hNQ6sP/8jh6HveiKBjxd9sVlmKu8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: MetBzkzvvXLlpWx4ZfCSeXUJxD4l_wx_
X-Proofpoint-GUID: MetBzkzvvXLlpWx4ZfCSeXUJxD4l_wx_

The variable err is the actual return value of this function, and the
variable ret is a helper variable for err, which actually is not
needed and can be handled just by err, which is renamed to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: Move ret = 0 under if (ret > 0)
    Title changed
v3: drop ret2 as there is no need for it.
v2: n/a

 fs/btrfs/root-tree.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 33962671a96c..c18915a76d9d 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -220,8 +220,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_root *root;
-	int err = 0;
-	int ret;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -235,18 +234,20 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		u64 root_objectid;
 
 		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			break;
-		}
+		if (ret > 0)
+			ret = 0;
 
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(tree_root, path);
 			if (ret < 0)
-				err = ret;
-			if (ret != 0)
 				break;
+			if (ret > 0) {
+				ret = 0;
+				break;
+			}
 			leaf = path->nodes[0];
 		}
 
@@ -261,26 +262,26 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		key.offset++;
 
 		root = btrfs_get_fs_root(fs_info, root_objectid, false);
-		err = PTR_ERR_OR_ZERO(root);
-		if (err && err != -ENOENT) {
+		ret = PTR_ERR_OR_ZERO(root);
+		if (ret && ret != -ENOENT) {
 			break;
-		} else if (err == -ENOENT) {
+		} else if (ret == -ENOENT) {
 			struct btrfs_trans_handle *trans;
 
 			btrfs_release_path(path);
 
 			trans = btrfs_join_transaction(tree_root);
 			if (IS_ERR(trans)) {
-				err = PTR_ERR(trans);
-				btrfs_handle_fs_error(fs_info, err,
+				ret = PTR_ERR(trans);
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to start trans to delete orphan item");
 				break;
 			}
-			err = btrfs_del_orphan_item(trans, tree_root,
+			ret = btrfs_del_orphan_item(trans, tree_root,
 						    root_objectid);
 			btrfs_end_transaction(trans);
-			if (err) {
-				btrfs_handle_fs_error(fs_info, err,
+			if (ret) {
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to delete root orphan item");
 				break;
 			}
@@ -311,7 +312,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	}
 
 	btrfs_free_path(path);
-	return err;
+	return ret;
 }
 
 /* drop the root item for 'key' from the tree root */
-- 
2.41.0


