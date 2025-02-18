Return-Path: <linux-btrfs+bounces-11541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD7A3ABC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 23:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2143A86CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD71D934B;
	Tue, 18 Feb 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="boML8xWl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p6F8eVJK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3331C3F1C;
	Tue, 18 Feb 2025 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918201; cv=fail; b=cUc+TiqH8Vds13b1vkLhhhv4omwvTEBRz3Nm46JhWUVdgiaSzeW7rUMX1xKS/hxaZq8oo2NY2wwbwSA6155ZhiDR8AALHdrBzYC9vEgmiHJW43D7B0OoQZ9cRfzLLUJ+rNzI+TuXTDS8o6d6z140OpNnXPnetTTGD23srWPZ4fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918201; c=relaxed/simple;
	bh=rJENLeM48YZRmVoV/AvdrdXOavVWnxmnj6y4YaP8Iu0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V0B7V+vicuu5M16BnCVzKOx2zOBhdNza+WEGrsJzMaEKzy3R1EmX3SHDuLHIcvKUSO3LY7N64E2lrSkuVhodlzX2meaMvUELC7+Ym7cKNitMltmOqtVPfNeq/pK2slX4ei0yo6CS2FXcYGPtjCYxCECqqBCWzlF1HsAbdU6y8N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=boML8xWl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p6F8eVJK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IMYwgP010212;
	Tue, 18 Feb 2025 22:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=vuWA6/LORJxlt0/j
	mFL/L9WHl19rS3b+o4GwjlZEaS8=; b=boML8xWlFLDy5Xd69gbocJVdaBgbtref
	sWaD2Iw/VJg/o/4WNejD35V2HZUQkunMG1Atz4pKBCcUSSeMPcq4684txztl8Mn9
	dm0YqFugjpAeg/EmmNGdja2eOqN6zs6PkRktb96YNdVnEPXwXcUsgkCeItRMD1YI
	XRKpi2soJ0K718ijSiPPCgstPX19ZWtIg9e5biRnyM0Zd8no1F3bZk8aPoEtdQZX
	PqnFAHjfiRRQVKW0cLyFRInd4eNAuHmB8THdorDoQfnNcU8V8B1yrBGOsJNIZSON
	clp+g4WiOHyu/9RXOYfCg/idODRptnFq3kMdgQODJ2vy+aeo5ZE3+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kgdde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 22:36:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ILAEjD012093;
	Tue, 18 Feb 2025 22:36:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b1pnt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 22:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJKLmogUQNE1FLMyQSyZPNJ9DfHdbOFmQEDbETm6KQlsxGYKKhn1OAPI8bG4jeEOJzuE2+2/qg+6E20o2YWbwqEmyz6+3GCL+5d1WX9ghcu+ks+9Q6WHMRQm9BZ97DGGi/n3dhhjbcxwYbPdGpvzU8bMjyXaHU+wwm04RpZqKwjmUBJYCVJx30f0ETjO4sWkdpzrTPjN5cTkLWT/cFaeMXT+LznJzJf1KAy7uFPXqC8R2P9EWbGs8lRUA0CwS1++48sbnrrU3M81J/jEda5LR1vNNi1uEO1eYk2AK2YC29QLMiNOz4viiMHkWII9lomEzp8UVmvdSxajZPR66pUsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuWA6/LORJxlt0/jmFL/L9WHl19rS3b+o4GwjlZEaS8=;
 b=pJLnosQ+q0DSBMCzwm0Vu4xzY7JEDV6Jo1ivQ6stVq6Fg/DG4eCd7Y92q/dbI8qS3Zmy/Jn5D9fGc5AtZySqCEP2ThYCHXa0Rx8fue1YxGzEQnQGmHXrfyzmysSSRgjwdndo3PhjySt6cnkcMJ9GWnx7YfIwVZDagGWsiqyMp+hmUs06stiMWAn60VkHblJ5Wvsc+IzjLxxzAf1Wqi6oGbgYHs6uEA2pnkVMphTyTgIhpkvgy4ZSGSakrW16M0oLhNBp9OVhbx1u8flq8MnetaacvLN4jfLjqjNU5hq97wLh0m7EyfS/GR4qPZlGuP3JNScS9LlaKnLhrsJ+QgJIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuWA6/LORJxlt0/jmFL/L9WHl19rS3b+o4GwjlZEaS8=;
 b=p6F8eVJKxf8mEWEef0DyySvtnZlsJ5B89k3FlDo0V9JVVUQNlqfT6d8ShFJatjiUWdhzhgnLZ7FU7s8BbYvnsNJ7O5gpDLAH8wLUwEekierbt4HBW2bj2KAp2r9aVEWszvOcxjm6k0vWJJVwaIU+CO/qlkMAosQLJaXUAkQ18ww=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 22:36:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8445.020; Tue, 18 Feb 2025
 22:36:32 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/226: fill in missing comments changes
Date: Wed, 19 Feb 2025 06:35:44 +0800
Message-ID: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad9ce91-1028-4978-76f5-08dd506cb177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0/rOcrSF3gGZ07ySuN9pBdXBnQKPgjURaBh9d/uORDnrmSemnOFFTSzURFzP?=
 =?us-ascii?Q?gN//gxL9Xp+FY2kDfIrRMVeG08VB8gBc8tKcmXMP6U4t7kPNbAnPC5JRcomQ?=
 =?us-ascii?Q?0hPggi2OfecfwOnonhmcmDZNFd1pCYvOPCezeMOOtV3jJWOIu33F512c5mHy?=
 =?us-ascii?Q?AHUHfAda5lgN7KdQlloIDwHWXoO6YQJB/9HckQ9Yhmh6cRzvsl4qG42bBLnj?=
 =?us-ascii?Q?kvmQLZFSKekqqVIP2tJ1/XXWPGWwV1bZW7gq/PVG9uHMHF0QgwTHlI81TDoI?=
 =?us-ascii?Q?f+wzl8a0A/XgdWKXwq3pEt9VQ0yMvoC5/XYUBSx7N1CwLLr/aibcTH/QSbTF?=
 =?us-ascii?Q?KkRjEhfETLz6PIq0RiOd1JbzxfN7kJRtx2ksz2W08u6StsQGXf+HjmtQndwW?=
 =?us-ascii?Q?3wQvG+rw7J8px7JnNxagtovY4VhGN/QI1JBkIFqTzyb6zcun1Tad4ksMSPL1?=
 =?us-ascii?Q?A4YXO8qmqIAMaQtnkpi7wt5j8usvWqe+l8gBNfYRuKUy2bZSkQNWzU3fVe8E?=
 =?us-ascii?Q?NULl86F/WTc+iEnsFu5ApWW2mvN8dNWuE+GraBYZKe0lfM7BwutIe1idbx2g?=
 =?us-ascii?Q?WTdaFYrpQQMdFkIltma4wI48P2cFuWDUTG4NarbWSFzRnWELEPLP/sKw1WH4?=
 =?us-ascii?Q?xrEGNobKVYwj9QBrTorE3wh1VV8vKG8ELj/10/V36ic7wX45zlEG4dZNeFZh?=
 =?us-ascii?Q?oZzlmZygQF41cYwztxIidWRAhzLV9mg/eI8Jd/dt3zEpojV/vL8Uqt86a0vZ?=
 =?us-ascii?Q?pgKm2k4yxIPJGd93WblkEQbkQYrm6SIFpuMWBKQ7BfwZD3j1as5OGf8f5M2L?=
 =?us-ascii?Q?qzbNz9zS3R+dX6fu9ZxoNVuPh+S0jesni2KinIwow+8MYd8g9w7ghYq807Sh?=
 =?us-ascii?Q?+PPZuGVtWDB/0rwBGREK9LjdQ5B2aobFF/s+6nBWi0DB2L+YiXWbQly9LO7r?=
 =?us-ascii?Q?lFkF2XjNDTRR1pV6hm0dui3EMVEnVgVz4wSBnfmOa6dMT6ABsOTXIJA3L9yu?=
 =?us-ascii?Q?NyTQvt/luIpIapCvNGwQzULgStm+CiXUcND32DG1qK5tJV0EdtEKM6CeSnhF?=
 =?us-ascii?Q?Yt0lv+o3KEYnTRRNW58rsUBWenALuyGaB/6ejt9+nZX8NA4KF6co0LEnt6WY?=
 =?us-ascii?Q?iTufg46geaRMq6UjS0C+vstAodPTJwBGZELL6974+L4L1+26msiXOV5y8UU3?=
 =?us-ascii?Q?C4Qd98al0pVTGeJRFCQF1/1NeRrgAvSPhH3ygSe6bnyVhZoeM+SfZtVvlWdE?=
 =?us-ascii?Q?VSZtuW/nESNAo/e0H4XP36T2SyjD9JSwevhIcYbYZ1+YTZU4HkRvdLHCkfbT?=
 =?us-ascii?Q?3Z0/UwpREQo/oLOUIcCoYJdKRTE/Pqz/caq88l8o+axTd6Qn4sJNTLfnb3GN?=
 =?us-ascii?Q?eMib+wjsyATlS0vgbSCN9b35pRik?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUNxrz6Ewz6B6/SQDKc19DpHGpXR4DZC5cul39YscV2SlMRyGmo7QeX914Pg?=
 =?us-ascii?Q?AFZys3sUXylZ9m8A5ZCMsCwgv85Vh3Q+tXbDebljf11R4/TDgRO4iQDQIAmr?=
 =?us-ascii?Q?vJRJHEKgtfOH4BXT7cwA3CLqDsoNRHh+E/ig6PjbPnad7I2Pj0dzOeBgLyQY?=
 =?us-ascii?Q?XLr7dPmFY5+ekkxzvwhIErTlrcNkeQ5AuRZ3cVTfQKiuZ8BBGcF0+EH006ID?=
 =?us-ascii?Q?Mxf6RywXG6ov1MMxypNsLxgBR/UBG/O9Kp51CKjo7jfd2Euwdte5C6DpIc31?=
 =?us-ascii?Q?5HVPyIYtwhmRPjRxUza3rr4OHzJS554ptpgqZyopK4OZ2IsOE0NylMmMPSEK?=
 =?us-ascii?Q?/0p2I2pdorUSMiwvSLtj/1UAYXrP5+d0Zye5UsOYwh3rysTpn4MJb+YVezy+?=
 =?us-ascii?Q?pfZL95Y+t6CtEHg/GFE4q1CPm4QwZhYdaJwNSqSOzBtnBH139tKM4/LGFgX5?=
 =?us-ascii?Q?AauyudiPwIUBFzuTfjVIgKW+5gtIfe9uKFUqxdUm5VMDlUhVBFNva7d+8Na2?=
 =?us-ascii?Q?xHmH4xcPOfp2xg9ktd4UGEops0GOfV84kF+PNAIwcOM//nAjbtwoRekar8y3?=
 =?us-ascii?Q?BaAXn1Xks6otPX0I99BJ3UOIlfd70ht3Du6APR4EalHulI5tpR17QAsNAoGY?=
 =?us-ascii?Q?rYJACujqOItdcJftyJxUPjG+aMmETDvpEFqtitQRyF87jLwdb0jV/HEMEF+l?=
 =?us-ascii?Q?7pKVszmxX86MYh+hSWP5J908se+3remPSvGyA4x+pgcWLevrKdX+vx+68DHC?=
 =?us-ascii?Q?HzU2DZmdatzvS6FVw7zt5yei2T+k9L0HnTNNyR4l4t3MItjrBxkbrktLKYMv?=
 =?us-ascii?Q?k6im3zWMouauwnz3jXtNxwVyUBX7fDyxhkeVqMLFP5XYk22swcrBsSu4VZZM?=
 =?us-ascii?Q?UoWc4sS2P6amdm252dj2/zEE16b/D/waJhJUiqPB5S4ykHzw2/VWQv8VK/SH?=
 =?us-ascii?Q?o/g1il5ROZXKQMiA0817XEWRq1tyJiMxIi/Vdwt4Qkzs/cyqcLH37upunD5b?=
 =?us-ascii?Q?eJny/8LFiVU8nhPsvMVhOO2TJXqv260D0hsb5sSEBf2g6dDNxS7vzXWn5tRg?=
 =?us-ascii?Q?jn6wZnxEkIHAEtSNbLeTZ5K91D6rNHnKH0IJFjDaSkcYDKwuQb+eVTszH7As?=
 =?us-ascii?Q?y+P+N1G+RH4VSAmBLEhQSsKhRfuK42shTElD0dWeE12A2EfHXOmYOoi1gJ3V?=
 =?us-ascii?Q?OPrhTzT71xX2MlOSV/A3Gf/VjJOWyvMBzbzKGv7IrJu1XJcknllPVLEwKuC3?=
 =?us-ascii?Q?80uJWZFpSOt7YfxPDynKmQMmIik+pNIZl25Oqb39hJTLyzEJNCKxw9UTX5vq?=
 =?us-ascii?Q?IR0g8ChuJ+KTuoQNVQl36DZeNNCWjMjfy3ksAdMb/XxXCX/Xm+6K0UmxsK0C?=
 =?us-ascii?Q?EWgpcribLHulcO6kwrf+cutEpWQdmMFeXACRd8vLoaAFKpMcJExvg6strgFL?=
 =?us-ascii?Q?/sSzp6X1YsXqTSzMlFn2qcy0E2BC+E49T2Jl66R9f/jDr0I/Q9v6P4fjjcbl?=
 =?us-ascii?Q?1RI/OV6Q1CycHumn8zZOLs8I9uPkd2K5WDHBp55JRVUFVfa/gXh1pFJfdutD?=
 =?us-ascii?Q?NIShy+YqHNiCkn179ebmBg1ePk3fR/JmCqrRy+nQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L98azdldIJOZRTVVUizyJdCOLS8YKJ1PglkIirXQt7B/JWBTb9PIBOcs6ISohicKD33ol3apwr7WeGXnOcZd9YfFXJYP3T+f5ibhblK2bvXB403tient1uOkfqDQ5UsN+LalMX4XVH/VIjPYrwvsJkkubQ09EXsz+IIDqhcy6Dtr7z18fHFwJFvOTW0XcYyqF9i9czHjfrP+dr2rMx6y42agkDIf+webSrgyd002CCOtXTNN/O6OUbJes0F7h8PQhiFBvNJlAnJmU9NRe0XEwrPZ4EEkKsCYphuCFZBlz2JU58Q7yQqUDsYVw1iiYYqnA4g3pxozslRVD9pdvzyff8gUdYO4d74KgObVaXe9kKbXP4uU2ts93mvA7pEzK3nBEqVUsIOmunT7bwrSHWiQot7RcUv6GcLovHu7U76C4Ugg+m12iwezpGDtiLiisalMMw6NBELQXCW2A/wILJ+tVZGXOmqaCWqSB0C92ZtMb2P8WTYLp5PeyIeygtXggSE/jUaN889FquuqPxXs82sF8jIgGrELzjgSqm0PObAC3CL9uLNmSyjdLDC3BOpZoUPoSkHubY7Nz7EXgylKPsZTfuLzKeCgPFR3mZCzNvj2joI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad9ce91-1028-4978-76f5-08dd506cb177
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 22:36:32.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw+CZf/vlwviA54y9StMhVXYA1I4yStlzKXVXq9LsjunkOvhXpjpONGn6Mz8otLcqG97SrwQPjfZFp4/lmhwTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_10,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502180150
X-Proofpoint-ORIG-GUID: KPMuBFLvQ9KYhxK3hSqcVAbwZSmSyB6L
X-Proofpoint-GUID: KPMuBFLvQ9KYhxK3hSqcVAbwZSmSyB6L

From: Qu Wenruo <wqu@suse.com>

Update comments that were previously missed.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/226 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 359813c4f394..ce53b7d48c49 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
 
 _scratch_mkfs >>$seqres.full 2>&1
 
-# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
-# btrfs will fall back to buffered IO unconditionally to prevent data checksum
-# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
-# So here we have to go with nodatasum mount option.
+# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
+# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
 _scratch_mount -o nodatasum
 
 # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
-- 
2.47.0


