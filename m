Return-Path: <linux-btrfs+bounces-13987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A54AB6087
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 03:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47A11B43206
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1E61D2F42;
	Wed, 14 May 2025 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eXtt1IYb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LQI98bzb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F53EA83
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187144; cv=fail; b=sKk2Cl5qpeyqxx7e1mP0n1rtx6fecNDSJIAlGgvrEqtgslEcOkl+pv+XWtZ//dNNAItE0uayCn05s7DYoX21cuDXDvSyK0n8T7G1y9i9uJzYx3XRrbfCysiFCc94RNqfEvNVoHMpnObeVbyBDyRu+5KzOCE1YoZiVJZYIHcbJAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187144; c=relaxed/simple;
	bh=UwtvNNlE0GJhYwIfCcAz4CXJz7tjOQBuu5JQW6l7BD0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mfNA7xCad3q0gmLaALs7wvcV57Zxk5uD/AjvjsxHGQDIkZT4EJ732s9whQsQPmyCrJA/ScgLOS9ajtcy6Vhxjv45VUw0/iPooR4N7GAacF2ojrnjRJGcodAWnDDC/KIGM7N3mIAvpzkTl1/DWz0xBu2meMTHa+ruKg/oUPjH8GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eXtt1IYb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LQI98bzb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fqXK026801
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 01:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=19tnrIfclTIot3OS
	arSy8L/yClDepOVxlfp1kC39g9s=; b=eXtt1IYbDkJA610JvXiiK3L7GeQBqKiw
	hunD+iGY+nR9oeUUTUiokRmtdJHHq/nBmbqljRT90RlckbbWHgftw2iN79docHSH
	nD/jF28RfNc+Xg78H+FYtASn+qWJ/rEuYv9NVzCtLId3IpFcpVonaYpi83BMYO26
	O4x2Nm0xS7KVVVkKf34kKzIpLizm0OD44x/QbiiqeeB0Kl7APNNBNT5jN48bNApo
	XUcIxGnyXmJtpDi4pJrWg1VajKxm91FX7V7ajpmzXvOMSWLJJ3wiJthh8ZiuruUr
	HfnB1LUPwEUZZpmv2uU+mp+pXTNhN+QDHZAmRRHu5XiU2H86QqX+kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccrktf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 01:45:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNefqE016177
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 01:45:40 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc32tyq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 01:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm6khX5hFH24bn0uUpm52vHEep/I+iiuOaZhw0gLtkaDY9WQyN0KCPK4oLrWaDNtN3AQrxfBwnaoKA3Bv3ZQlXZFL08+mzW8ZBP3g0MkPlMGg3MWZwi5QSbGi7i+o12cMvaQdvlB8tl9bbMiFd7w55O6smyQBNQ0IBZgcDcWDzcMZkM9UsdZ1WkFBzv0pcBZvEJLLHB64WG0tyOABeGYI3ZYgqGfD1Q6S46U0ppE0apQTFAGe1VDsS879ivl3q/GycCq6L+U/6pDhMRKjF0Yzt87hSP9ZsTZ2m7oY/7qplr12q1ZilMhbihhsAbUIVpeRP//IrmQYubnMUov3fVVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19tnrIfclTIot3OSarSy8L/yClDepOVxlfp1kC39g9s=;
 b=Qdr3myFjXgssgAufbot6tIdIlAPnkQv8Nmz8rVkTkx2KtdsO5zwrBBquB/8AjQOy0JZA2c/7PmyhF/XffH/qlyK4FgyaTCVgdaeubKMwNQDKu/mWAydCdAjKpvEBgzPs8R+elZSLcOM+6ARGxbmEH9NOCStPfsD5TDQLHNl39vXY1T1PN2nCF2mYRnCkRLSfNFsbBnxeKtr6lnH2QInSXGC8a/gQ6jVv6BQhkaKvKVrkM3PTuVntPaxOSpjNxYZGsUA9rf8jvRkmkwA5op/jfTmObJMYB7AvJnJbvmMMqckSYgLy5E8tM8ey6HiS1EiTbSO2D4Dh2EwL51BIymw2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19tnrIfclTIot3OSarSy8L/yClDepOVxlfp1kC39g9s=;
 b=LQI98bzbHTOW1JhCUGDN9oNiF3NCnkJA7HpCkFU5HKzgmUm4qYxTomFp2xewPjfuTerrK6c/lgH+AMTMyVVVQcogiVWx+RF6/bFRpMEV+j57qhT0d87ac5dxdQlpe2trP7IMA1ZcPHGGyxFzRjFl2Nwd60O7OaF3qqrTG/o74sc=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH0PR10MB4648.namprd10.prod.outlook.com (2603:10b6:510:30::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 01:45:38 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 01:45:38 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add prefix for the scrub error message
Date: Wed, 14 May 2025 09:45:32 +0800
Message-ID: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH0PR10MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: fea0f1b4-6033-4688-d267-08dd928906bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?32SqZIKPmYVeXdl05U4wzgj2+gRq+4xBTw74hu+vXtS7FKRcSVdzgHDFN4m+?=
 =?us-ascii?Q?gNcGCI3x8i/k0CmxLCQ/4SpQ5S9n0SJUS3Geb45CPUyLLqSREBqlxFRESi+H?=
 =?us-ascii?Q?bnDrDfqhgo0aifdRJSTAqclGSZfxyvEgkI6NrY3WfEO/ZJ5cnaR70AvtqJMx?=
 =?us-ascii?Q?IanUzclMtblm8EA4PXkjja7qflT9AzbvLnFVIz8OZj1EcnsGMcbSyrwt0i9L?=
 =?us-ascii?Q?myqjCiB2j4Dgd24/aLuysVlMOs8v7DvT8j0k/tFIZbi0e2yQ6VdpSNcUi8Ff?=
 =?us-ascii?Q?18F6NJGxQ4AowLaVQmzhHtD+MWwEzTvNBSfVOGGQEqvKvtUXUgBirJwjT+i3?=
 =?us-ascii?Q?rd9tXFZ2tq61BzIeC7MlvppTtspx3KJ/y9E8MlHrph6vSz2OHVO5JJ5O8xe7?=
 =?us-ascii?Q?CmEqe9xb5x7QRCfH1jO85MgGAissB+fYZwkPjVkE2VGe5YxV0LDysdpSBiBj?=
 =?us-ascii?Q?wlHI90BZFvhEiU0D+ub2UELaLAe54sb2kUMtUxLkT7oObkoif44PQPHrC1lG?=
 =?us-ascii?Q?fHsqv9h3uIBq4A1IZUL9bAgLQJCjHY7HEsCMGWMyCfc3gqke27K/W4UU/xaG?=
 =?us-ascii?Q?8eQx1ZuPi/IXbwDne9zUVoyHjO6C3hU4hV/blenteY6MUzz8xqQcIbY9aZfI?=
 =?us-ascii?Q?YYV+crDIwrR8IEr3O/BysFjxxeZnzCmup6p9gAqgOr3OE6Ax46goFyMEOJEZ?=
 =?us-ascii?Q?4+YT/V9cH45ck/7SLgiEfgZ6Vf3NTSygmOQaQKNeJ/PCjnQUhxFlBdM5/Zg9?=
 =?us-ascii?Q?PA2lUOU4HMjVaC45Cj7XK4BIoPfnIIOAYcO+P1FRp7cNeJdwtMybu8YNgVIH?=
 =?us-ascii?Q?2PYMNZy0B10lry0Dm7V54vpkCkNXT8WhnJ8UCTLpovvG8SYG3PRb+4kBwikC?=
 =?us-ascii?Q?6vrPy50trhmV8Ma6Ka/rGF57g9ArESOCmbyTsjVgEC1SWekY8DdI1ZJNQjDp?=
 =?us-ascii?Q?oG3BYi1aSMe5arjf9IJr+w7xN0xIjvQVi4jFjy4t5lxI2XabOk1g4gOKAzSZ?=
 =?us-ascii?Q?8Q7c0MbAG979uNm3UQG3/y0sQ0pZTKbE6GUXv/Vvn86N55eIPtlWx2VMeRdi?=
 =?us-ascii?Q?kfCu1xLi140WrNRbZBZ3KklSnqNoPP5pHfOOM8yLbxji6R8jAs96Z4l8YxYz?=
 =?us-ascii?Q?cv+STeJYwwyxOz1ojXah83pJ8HHvjSVruZbdjOOecTvIZvIjAh050QS6/ODc?=
 =?us-ascii?Q?h95Y/TFQrXHNUVRPP+p4RfFwREbZ53dn8zXqfcemacyfNXUM3IegF2gCyuxi?=
 =?us-ascii?Q?aY05cGzTgUgPEgoF8YD6HuYMFgr90PuE4SWft3ANCO/rPa857HD+7trfZtZq?=
 =?us-ascii?Q?y8zeu6aOW7mXIiIOORPkCQjgRCFbhvXKpVNPUE5YC4f+SB4LY7fMlhPf4A4h?=
 =?us-ascii?Q?JwxO2eFJc77mhSm1S4TbopofK2ReGtMvKUSNzEMPFFlCqTWh7ZwK/grSXsdB?=
 =?us-ascii?Q?HtiQ91qxQoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GA4fdrgb03RqOBmanluegUq0CV4/23jh/5HPF63DRdHGgRFT/CwPrMkN4art?=
 =?us-ascii?Q?hUaLhF5j2TYMSjV7YQ+J/rlmkjr07NSQvzvgV+qRHNkr2bBbUbuUajVj6W5r?=
 =?us-ascii?Q?JfMLlkDxz8ahxK8qfHzk3xlznitB8BZkLxLBOfdu35RC7OkQ1j2yj7fOt03r?=
 =?us-ascii?Q?KX+b/oodinDZ+ucwx3QNotYhRRHSF5G0kjX1S3JaiwW6FNwGuMJM1RKyVpLd?=
 =?us-ascii?Q?pKL87BpNTxSI6Me+NxvYbJe+8diMgfTyQp6TUaH616+/NZZmSk6TBfhJ9sv2?=
 =?us-ascii?Q?8yhRaJ7HaHQv50qEOUcY8SxST0y+WnbQNJyB6BWarQswxNp8HgVwqW7B9tS2?=
 =?us-ascii?Q?GK+/e0hDXU0sDutnew1ifvLzYnKwDxxWmHhDvX20qkFOJ3epGQGl7Sl1Mee7?=
 =?us-ascii?Q?hqxCjV3Sfyi0AnK4B3JVEXc5XAvjAKJ+0H6a8WnW/lIj9FwElxGkIjrpDsrL?=
 =?us-ascii?Q?e3981fTtIaAVztgRkcRo4EhmcKxCgrwDOos+C98dmCPl99KheK8akpvWFqow?=
 =?us-ascii?Q?5H9mDBtxuRqjd/nkSMBhV0XV9B3ZuEX39qqAcZ1UMkeT360r/hwlLmhQe33B?=
 =?us-ascii?Q?mzTJ+z+IHsFZNmVUEhFw+W5QM7d0A7eYMkrR75VukJmHA4a45+Kz86nFQ9Ek?=
 =?us-ascii?Q?rFwghtnUXD9ayueShxzDwV7eXS5TbP5WL9L4uWTyFhH3T/vnhmD/+9MbEkzZ?=
 =?us-ascii?Q?6VwN2SgD+ztlQj968+DnedZZihVHhHRZRWhaKMH2KtTu0+ySzpTHDwCe20g+?=
 =?us-ascii?Q?9t6IJJ0XEdYqBDbjsnxsIoG6aRiKPnTwqUnwA3YfR5ULKqQXxOkqOprUDHA/?=
 =?us-ascii?Q?Wp7HEey0C7Tazue78DobO3ghikM0ZANfQb1VhIjoiXNwbTcg6WjJgp3+eOsB?=
 =?us-ascii?Q?Vb5qBEddRbzbILqz23YJI8Ju6zkove/nRuaWcS72bpvdeKxofmn+MvjMFvNq?=
 =?us-ascii?Q?T8gKd+7CaaPBtF0bXI8hfi85vzvmpoQ4LzTHrpHREmYMIji/ML7PGtM/9EEh?=
 =?us-ascii?Q?bUXJmlxfaTqPQYDzie96Cw8+FIXmeFiNSg4aWzoDpcy/ClA+r7Hr4f1fD8ad?=
 =?us-ascii?Q?wEkMI/KXDu9nZVCAKREdxOGZQC7WouUntZ8qDZF8NB7RAwBUk/ATRR2yFMj9?=
 =?us-ascii?Q?Ku5rnuVymRKeMsDhnTU62Unf9sV9SiXHzbeUPcqtZNAMypun9R/rSDmshDVK?=
 =?us-ascii?Q?tSQ3Dw3WGLUEBqHsLIovcYuvR0rO6VvUAPnCveRl1blnkVkRYC7aoopg2976?=
 =?us-ascii?Q?45NiNaXcAIRx3SjHnYIPO076YZoIIjyn0AfwnGdAxdKtQ35c38dgPRBhfXl8?=
 =?us-ascii?Q?pmpVJ/KqLntyNS+zOrFPfPyKtjKBRVwnoPWwP8mR4wVkTHIN/OBsVV5sLjQ0?=
 =?us-ascii?Q?PNFGegwpgynBDj3yXQUxiyVZeZ8nNp2qeyY0MogEFkaipyrBY+/rfHqQPVfE?=
 =?us-ascii?Q?qkA/1kQ9WWQdbHCrOjhiSamw9PIDA7Nj82cnCxqfe0YL/jchCbLHA+AVQcg4?=
 =?us-ascii?Q?5EoovAlhityQ4JhO2VglTbpGFPmXPkeTciKSmW+FX7GLrzyVz4XtDsyPKCGZ?=
 =?us-ascii?Q?btiJvMBCnlJtFnvbLjME2xPYuH36iOXDAgHqMaN/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R0pODuTJCOOqCw5iTX3V7A6X5qFs9vBBCfsXXQVmaIubn5z6JwWM9FtRe5g4541BAItLiwnUgci0TNWTu510a5nH0VwT0Hg6Ggbkb6t3ltVAck3lnrUffqK0KU6fx191BFhwuXdMWa51PtZJfczEkE+HdQ9mzZtzBjDroWQY2GYByFobRzoEFATwO3PXMjd0C1YzIppPGBnJdQk3e4v2yv1E3Wz/krfqfawIvWP2Be/VWphG9Y5H2SsQC64v3La1PfwsOTA1BSS4o5xQwwI6WXL/kzPI0tyo1WVd+QyZkBbu0NLqPqw1oerKaVnnSFeGOFjyF+Y1v4XnMCOC+YijUS5iWN4xrMyUpDyDk1dLbwcsryk0Kw6+71Y4HhT5bw49dXRHD2aRShwlnY7s+JCDHLi7gzH/KSjWemkd/TRN4bKDBboVpxaxqdNVkbhRO5LAOZ3n7DshZEw0zUXfks7jBXRK4EeECUNTkwrQWnnphiHCmLnTKRps/Qb4lgw8tOGJXsF1Y++30vA52D+UZKvuKoTT96ENYFthDHhSjKYw00IG3rgh8GoWZpDKmPzURVt1DLBlpzQ+XGbqkMhST+krLBAJZ02oU4U3Py3rzUd10Ik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea0f1b4-6033-4688-d267-08dd928906bc
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 01:45:37.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LMi88fSrteUgD+QnBUTeXtMIsNFA1ezOnuIEPXfrU2NDLCSds/BgqyZC/61QKEFMetfonBChvGE9WOcWKE2gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140013
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAxMyBTYWx0ZWRfX4w1ALB98C+87 1XbfkCpsRGrFQB8kxbyWbPi7Jigf4S3WDmyeb6VQFP5cVIwcyktrkvx2Mf3bjb1eE1qPnxST5o7 0Bv5HGh8AOa2+v44CiflT45V3WbsRbF4rIbFxRsSWavNWIA38waydvsURuVTDe6HqvPHpWmowlW
 +PMFsYAYTGYedzoxXR7CtRsWlmXFmNReOUJz16YQ+Z7Fdzpvrwm3oS9qGfmYxYxRLUSzBLbcpyc 9SwdPaCTeKwzdpj37U9MBUqEg7b4HqidrYU+Xi5Bm4CI1laKLxfeiCIdOcCy+zc+y048+vD1Ilg ycU7Z5xj/72WBFQgtyHdU3Mu8vlMJSOJO20f2Oo6LbdY8xZBqNci06HiRbw/AhaLHG/EHCcdPLe
 naTW3l7JapK2ClCR137X+T4SDDg/N9rB8u2Tj2yXUXB5fQFFOYTeS92+jcJkt3dD85sRCx6n
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=6823f5c5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1uU4Mopmat8pwSrD-AEA:9 cc=ntf awl=host:13186
X-Proofpoint-GUID: W0WnNA4woQaWZF2xJ_nYlpb3XOgnRpQ9
X-Proofpoint-ORIG-GUID: W0WnNA4woQaWZF2xJ_nYlpb3XOgnRpQ9

Below is the dmesg output for the failing scrub. Since scrub messages are
prefixed with "scrub:", please add this to the missing error as well.
It helps dmesg grep for monitoring and debug.

[ 5948.614757] BTRFS info (device sda state C): scrub: started on devid 1
[ 5948.615141] BTRFS error (device sda state C): no valid extent or csum root for scrub
[ 5948.615144] BTRFS info (device sda state C): scrub: not finished on devid 1 with status: -117

Fixes: f95d186255b3 ("btrfs: avoid NULL pointer dereference if no valid csum tree")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/scrub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ed120621021b..521c977b6c87 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1658,7 +1658,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	int ret;
 
 	if (unlikely(!extent_root || !csum_root)) {
-		btrfs_err(fs_info, "no valid extent or csum root for scrub");
+		btrfs_err(fs_info,
+			  "scrub: no valid extent or csum root for scrub");
 		return -EUCLEAN;
 	}
 	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
-- 
2.49.0


