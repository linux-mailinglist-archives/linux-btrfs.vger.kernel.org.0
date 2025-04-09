Return-Path: <linux-btrfs+bounces-12899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C33A81E86
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD86C1B87D5F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572725A334;
	Wed,  9 Apr 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HP4ijqRY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DeW2gCYL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AF82899;
	Wed,  9 Apr 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184675; cv=fail; b=urXbgG3TFItTrgI6RIoZfjst8vAcmIajhuMCmi8OLHUmH0ZGZ5SY+cp9vpt7LhvlXG78O9ypexACU3yMON7NFT1GymdtRojtVQr418XwQFpwd5KH53+GH44qIdp6F3qV1wgYQuBHw+FJH7nADYA2KxslyCaGzip3bOeKN4RghV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184675; c=relaxed/simple;
	bh=SqiB8d4rti/+pleOCMNS8hKoo9Ya+juNu9Y9V5hjPZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JR2PPRDCD3oTbWDM2GFvDHUFoohsIQYBE9UnufXh6xAMHJjHdIA2T6NsumXGjvVHZ4iw7eDLd6s6fUWGsooAYucc9d0nS+DBSxCu585tfN4+678Tk6uB1nIXrF+tzj4mJ7HPcpGj1bKN4aCwLBoxE6XV+/hxLJu5U4B7h1DLc4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HP4ijqRY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DeW2gCYL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9moC005736;
	Wed, 9 Apr 2025 07:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/QGeqF9X2MNsvLQ8t49xLkX7UFSoJiA2Dv6VcLp+xL8=; b=
	HP4ijqRY4K1QGhQeWLcaJnJ1hcpXbNOc/aeKyZRN0iojfT9wJNLDY4EvSiBJSOF9
	VOK2KfKMVO/OA4UVbKDiW5Elfx/Gq9hHjYWBvoMYlx2wA02eawFjeKcCfI8Aa2Az
	v6heY0Tqgm5ZQshAohIfq7JNvH7idt0KD5qtbCcbDaNyepjfZkI1YIi1uG03Rv6L
	DdO+GdBAZAM3ag7PmTlocgxy6UsiCUn8NxJaEDF5d3QIBFtohOs9eoTUCwf9xIk3
	ZP9FjexTEnEXDEbcApQzh9aw9J/pNoQJet4IcFklwphxajR3CiFX5uToNkx7InL7
	y2mPC7ESuvm1rvXGChW8kQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvjcxgvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5395ktfO023885;
	Wed, 9 Apr 2025 07:44:28 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttygrpk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syV7t3WFf+259ddKPdDfWM9z+VUMgP67IbDcEoNsik5mi7+z33Nb0K4zLnwvO37f3W1fQbvKFI20eLylUfa7YO9nkO7y/TEQSp4In9NaKPWY3/ZsPud5IMSS4Ja81Gk66YiplaOSzW6U3Q+9JQUeA5oGmxi8qPBQikzqzpq2cfF4J7JjwDJN8z00GQjB2Yn4pfMEN8IH370eZPiKfaqDv0sPWvgJ3vX2xnmNJIDNmDsCyHEd9hfW84B85L0XBaKm4vTE28CGjjkm7MVx2IWP2EJUS+6o0xgrnsPy9Gtg96Gc+Zzqugvv7UzX35QwcDftY14Xv6K+dZk+bcrp+4CPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QGeqF9X2MNsvLQ8t49xLkX7UFSoJiA2Dv6VcLp+xL8=;
 b=r6vf/MN1suMw+LcBDEmaglbKbTsX54gy+5diC+0QwDQbWAUKGnUHnYrUL1QimfAPFUpNBzb/papEPGxLvR8kOlMf8mBMFCKfPU0ofOMOuW4ToJE1cjh5ZI9EctDlrTepMFG+B1TIsn9+Tg2CqRBPQEvnfZURQuCKWGPH25zFbs4As8y+4yHSMNJ25MIaPN/6HcPzrkfwa0Dkfvci3/DJsrHdFKB0j+X4DlSS6AeNx8rYEDnzKVHmw8fh6izlVaRxdPqPga7cD3OYVY8u4b7R/ZFxmo/IJWUd5vvikDBwNoNkLtnXrdgYH6lj6XDHVQioOUhQWhwVCm5jt5rPfqo1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QGeqF9X2MNsvLQ8t49xLkX7UFSoJiA2Dv6VcLp+xL8=;
 b=DeW2gCYLvMrwmVWfw6tSmigJ5If2/zgUWQDgmWVED/7bUwo99Tny+iJD4IywZw+VZybNXYuV8QOzCXh7PhSeF5rQwDroFBGioB81TQLIF9b4Z/BBfj143B8PO9Jabyy8rKyPS5uPdkQb7PdGVbwFoxPwEFmfQHL6m+CqUvLZy20=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 07:44:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:44:26 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH v6 1/6] fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
Date: Wed,  9 Apr 2025 15:43:13 +0800
Message-ID: <46c6b0e273a28234670734f5a78a9185897c53e2.1744183008.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1744183008.git.anand.jain@oracle.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f8dac0-d31e-421d-ed7d-08dd773a5a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bg+9NTaDpkNbuJrN2DtGj78/I61ScZid+X7nHehKS6dMoXP8bMWTOFt+1C6L?=
 =?us-ascii?Q?Md0h/96UjvmFbcsR65ycuM5dunp/AlvsXwEjQV/gQA3yK+ebgmmpcQhT5LIe?=
 =?us-ascii?Q?gDENGij5JlgVTCJRNxowSTfYdK3SPF1f1f7uGErcW9oSWiMw1QJTMNrmX/dx?=
 =?us-ascii?Q?lvqC1zzCgu3pYx63YRofHUYHC2QcUm1Qn8r1uquuLg4LzZfk4KSAYc7vnc9w?=
 =?us-ascii?Q?Tg+biYLaUNlHbi/PopXnZ3vSozCn4n8uvmtm505TN6I7UNg/8hu6+cgegK+8?=
 =?us-ascii?Q?q1o5auUzkPftvpQhV7vQ2PjwVmnTYDnhHEuGMpVBP9tw4mpjfOreZDwCg+IK?=
 =?us-ascii?Q?eKaG6GMNZuwbRPn9S19jdTg6GYFkd8FmOAXIu76pzZsJO4vJQOZb86rAfd14?=
 =?us-ascii?Q?0ZvSpo2ivLz9c4XrmFyzq5d2TrBWkFiJNfN8wMn9Oxa+DEG3r94mIn8q/TYD?=
 =?us-ascii?Q?ktari6K0MeRKWWGmkkyUGXk5UeKomyz/6foLYO9ZJ9EnVH7+nM1+REiLgd+9?=
 =?us-ascii?Q?2c/HzbQ5w3KhHLfqz4sXoxglgDjpu6bbi4zL6KXKZu6yQM/hGxjJRTAKLlRa?=
 =?us-ascii?Q?oohE11ixGERvByXWGbVuP8yawzjmGOmgSxXLwEgUCWjft2mPohP9azn3FAGe?=
 =?us-ascii?Q?NAfUoWUMbODgPJu7h6KO8tzDS4RdJ54BAI4GHtNvWz9kTK63fRIPxs6iu74P?=
 =?us-ascii?Q?1AcgAtygG5WQkGmEctAwqY2kJ5CJ94c+p51eY53ZHb8ilbDs1Lrggr7O3dC2?=
 =?us-ascii?Q?VowqXry+UefVdyDWsXAgPTMUnlCQV3MFwaXXkvw8XSFpqETu+HimWk5Nzu4p?=
 =?us-ascii?Q?zax/FC1M/lDcn39zz75H8/ODzvPCWhL1x4L/W2gp+8M4RD2pYzqzlro76YRV?=
 =?us-ascii?Q?KcAtQ1fkz7Mzv1EL0HVCG4ZUmvm/KTNDp/Wiupdq4+Wz+7pjm5IAI3RefLmH?=
 =?us-ascii?Q?rYcyf1ZksBx3+ya8yI6Es0jJTM5GWxoS1mgrkMtvJ0Z0Z2b51gUs5J81WgYr?=
 =?us-ascii?Q?lhCMqqaX8VYf34qT1fA3LHry3a9WTNW8np53vt+kq7sTr7PzITah2tph93kr?=
 =?us-ascii?Q?Wb5X/XaDcSbrD/L6yWasSDqxfgxGZ4aKBI6+CWIcgp1kxNOCjAxhWFPNSEvz?=
 =?us-ascii?Q?6vN5PtHFtuOyIWUjOrl2R1JpIDuxkkfXQXRlJkeiBJgHA8a7tvpHJvS6LO5K?=
 =?us-ascii?Q?HaGZijG+H7gA8Vhdp+vBMavfyAxFu0zxE60/+rpq0FqNH748IxPefKu3NQO7?=
 =?us-ascii?Q?4jploclWLip4gzid28G8ZEI75tWZmz5fSdZzAaUv4kJGvERFyNbEjrfOze2/?=
 =?us-ascii?Q?YXfyKnqW+Chv/Vk+Zq0coRXOzIqZkP0HJn9H9roHPMbhMYq/Ib9F29xk07Iw?=
 =?us-ascii?Q?3u2zocgeOscOVK5EVCqQjpryUGsD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dScKWrSKq7g7stLhyLRd/W9KHiVmTS44ZhqfG0VzJybI+K1u1Nrk/KXa7eW+?=
 =?us-ascii?Q?MTFywzgO/bXdUSUt9ASZU/ApmqSzxzRwayfTKP4+aHurP2qMuKiJMHun4Hrs?=
 =?us-ascii?Q?nyb4uE2ucZ79HE2364S41wLYhwmnSd40ryivuuSN0kggOJT071GMlO3oxfuS?=
 =?us-ascii?Q?WYTAX415RUEeMq2PWEFsSbXm5cYXKpueDWOaxwv7oTu9s/iv7pTAdxpm9sVl?=
 =?us-ascii?Q?/peCnBnOsletoOykPzEznLY40NcCVp0lSCV25j7p3KyX4QcBQIEzo5XlUT9b?=
 =?us-ascii?Q?2m6HwhZtc1M0e+VZmIwEDgpgqOZ0Mri8iEIT1s++WmYmJ97+0l1fYQvVSh/K?=
 =?us-ascii?Q?BA65jIPGdxlk2t4XStSMMthhI2cUWzHWbSvjyPKrHZ/1W+uhbl09KMqIPheL?=
 =?us-ascii?Q?vO+OHEGHUGFfds0MiH22k7KDUdzLmsz/+hpVmJa8mQG5Z+EMEFyFgJk55xQe?=
 =?us-ascii?Q?4/VhghbfWiP50hhT6PBI53gyg1pYlSk3Xd4NCd4lr9IXnR4JJa5/tVVwy/8v?=
 =?us-ascii?Q?uMzSBP8FcbRA2xf+/zAHyHEqpwp9Uw5DFrUMpj0Esv9IDxjDmxSLuEePUjKw?=
 =?us-ascii?Q?UPyOafZMur4KGKaIonU01KZj8+k7mZ4mtvSgnkDEC0BFGvBQVm2Vlw9cKt/2?=
 =?us-ascii?Q?9Fpjhvc5vcV/CqjimUkKHTKrKj5yOl7ys1oQFLgOa0fKCeiQkT78WZgR35uZ?=
 =?us-ascii?Q?wgFQXhiuBeh3EVd4Fbn+RXbhy37+sxT+qzHAOcZy+inkAryXGvB+ex3XVfwb?=
 =?us-ascii?Q?L9ZXOipmC2iidAVz/6GpFBMYvlJSlo2gDeoCySIFzthlqorWwiHpbpkKue3D?=
 =?us-ascii?Q?6aNi4Gz7A3A2N69dNfYO9EI1YjhFaZHxPgh1SXZEeLIUpoIygIR5IZl++HBq?=
 =?us-ascii?Q?FbyLvDWx7B5omnCR0SWvdz2Wrs/HG0TvBFLZaYMeGohWRe8/dlPWQKo8EQ+R?=
 =?us-ascii?Q?Ih2kGtdh8cMf8X/cSYycxgN1nW1O8xG5fBNDOo9gBL6IoEg9wmffzSTQtPn0?=
 =?us-ascii?Q?/FfszIkjWynbxtURuwIZ3ZmwRGA0RKlFVYPR3OtpTLefW2onNBOSYZ9nxcNa?=
 =?us-ascii?Q?khD0ZEYpDHeS0Vb9ZeuIPlPtvScirt8/cQPBcDYXA+T1TvsJo86H4c6QxzBm?=
 =?us-ascii?Q?/53CRIakdTxpaCRhJC0yWeyvFJrkx/4RNGIsp90l2KA1Jwap0fLy84HumRGZ?=
 =?us-ascii?Q?4tSfRYrpD2lVImm2XQ5nI34DWF7l/lg40mN4xA0hRQFDIaU5rsj1Tcw6XUU4?=
 =?us-ascii?Q?P/RvosUiNGJanRKwmbkZCSVwioN8CeF01PSopOq2CgY0FI71S1t0eNkgiY2h?=
 =?us-ascii?Q?acEUYC1xs+VGWsLcTkVOf/fntrtlTnwYjCSRMXlBr5iryXM6wCdtiVdNCIeY?=
 =?us-ascii?Q?hHyH3GTcWWrUM/yHyukapFp6JcJJs/x6ZiL4JrraeMMIqQ+RZQ97fViWjP3f?=
 =?us-ascii?Q?oKtIJiJcoMjXhbf51TRS+87734BqyZ8draVRt47F1mv7JGDQsdJPuqB3Vsmg?=
 =?us-ascii?Q?uwLDU9o3pH/cbt0mmi3VV6fh5DiZpAQy+eNiXfjtL4oaZhaMwf3exI+r/Kko?=
 =?us-ascii?Q?mONzENGCzt6vZSZPQTAf0bBEYcGQZpx2SyGHvxak?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PAgGleJUDHMptSVmaT0zo6mEBWvarmtIgKyWOxkdjOcxCoWb/ul5LfRBxIWnUNaINtthwMvR4mJmLYF7AzhB6eIxypiNUDUgzHabzG8JUOOvvx9f0P4JM1R0Vb2XLis7sSKj8uXQw0seOdHUI7Vfb2AXOevM7d54n0CSGLBUQpY7jbP1PDp9aKiUlAPvZKtfPwm5VXDhNdYzYzYjtnC5ThbkcEE85P9o864hH8R2Rc89+N8oing6gY6C/plSgc+wR05yMsi5fHy8C0IpCOarzTYhfcbH5CRZ1WWHl8ZiIapVvcLCsIw+YJ7wI0p79xSIn8/zFY8IGlDK4+uBgh+vmOMjwWdlbZNYBiOjPFmJXAcsph3C0hnpw08aUlDGjEOuNhoSqBYmLGd97ReDyT3y6LK/iBsJlG3cigPc2xPLzAgJivKKc5zTOoJMShokSfPqHXe3z+L1fyHBii9NaXHhNs41F+UJXRM9cLZKRDa5znglOc3kHDo2CgnU8o6tQ4X3JYrXobFFiSrcFfNDrLHNRC4HlPwgytOmzqSAM/kzb6ao5w0hrbO3FINjwlMuOMe6QrkybQp9h9sv/EY8K14nP+2GEXJryjgTwdy/FhmRzdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f8dac0-d31e-421d-ed7d-08dd773a5a62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:44:26.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6MBN3TNmsaoh9uSV/hfJ3bIuIgH7DrdzrFK6pIM8rXxaAX5V4vajUbAnqoJZdn9R09qZFkzC6TOU0mlAMGK4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090035
X-Proofpoint-ORIG-GUID: G5SJjfepOK2rJ5UT7JpUtImVTHDbk5VN
X-Proofpoint-GUID: G5SJjfepOK2rJ5UT7JpUtImVTHDbk5VN

Redirect sysfs write errors to stdout as a preparatory patch to enable
testing of expected sysfs write failures. Also, log the executed
sysfs write command and its failure if any to seqres.full for better
debugging and traceability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 16d627e1bdd4..e89eee5de840 100644
--- a/common/rc
+++ b/common/rc
@@ -5208,7 +5208,8 @@ _set_fs_sysfs_attr()
 
 	local dname=$(_fs_sysfs_dname $dev)
 
-	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
+	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
+	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
 }
 
 # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
-- 
2.47.0


