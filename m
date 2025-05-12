Return-Path: <linux-btrfs+bounces-13928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B3AB42F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51CC1B61BA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B203629A33B;
	Mon, 12 May 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M0C9GyBG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H03OvMBD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20C29A30B
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073420; cv=fail; b=tDRu3SeMRMrjzu+Hbp0Hw3drso9GNADKwmNxqIi3X2u5oPrrNcCP3WivekDQO+HS/S1wKnEql8JTNZsCcJ3US0CN1OV0hXzF3+jtOsCWHR07lN2Fn3p4pC57mk/8PCVelp1IFtmmy4I2zm2g101OjL0/XoVFCPn6XIzs6b9G/f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073420; c=relaxed/simple;
	bh=M+m00I+Uskz962PIi/KArQSTMo7BATDCbmmMJx9cjBM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IpxEoZaGqWz54CHp1RgQBXm+nDB2kFsP76hJzF2Y9+HZ/sYytuC1JFfL+efWtxMzEwnWD7AcVI75LPybw7WuGcuBKdBztyAEzf+npwKSIP/IZenekeekejK9QXgYfqGuvDvD0wtUyt2pmbqfWQPGSNoJ+3Gb4bsoC8rnIPE1Yfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M0C9GyBG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H03OvMBD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0tsI008000
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yXSSI54dTMHeDPfUAJ7fY7GBrG8XeoQ+mudqjCMLwyk=; b=
	M0C9GyBG6vJA7seHNrvGGC8tTc1wJl/p8933qg4f3nUaTK8nFA2Sh/uYb5wpziu/
	mCSe0nnkKE7eO7sZ4eKo9YaS1V/lYBMgybGWGEvsXu3JnFm+b9Ur2BbMVkdnmnnS
	mJvUHvXEk0N3Cjge0qTymk2XYHnlzF0mlSt5zArffJoZUdNFIplc2viXTwJYb0iG
	NS/gDavfRsyWGT+R0cIdkKtFfIVGouPN02zxTY369HDmXSz8h0oSxAlkfbFKvWv4
	TMUj+4klJpo6XZy9Bzxf8ylO1MnDJSEMuLYK5mdyq8sRQ2/XMAaMPahAunQaIgG4
	wC2OvACKR0cPtOCd5z9JmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2b3k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHd1eY001970
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:17 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8e78m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP7X8GqKi4DVKlTrvZu3Xt2dmECooVWTXO63wU0Jrd9WTqLh90RFdnjiafd8sEGCtUIJsbi7oQ7hRXIvvqY2i+NxjvkcVx6scvM9pQMGIQt6rmwirp9FbeGTGQOj183rDJwVlFbvV3E3GC8k2bJSqXZClzIvKOv2uKL8nt/tFc7eRSeh5aVc+BhdW0Q6q6UvTCJg/4bF3olTpVwXUIkfJisXbFdR/h5HZ51wzol4fNYq2em5rG5sleq+f/jtmgJdBhRC76Xvm6RgKG4psEoUQFnP0iqSJAtUgbQEz4/MZngNSqfKu7qe9k0I9rhKvr7YjK8k9ZayQ+aEbey3XB02rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXSSI54dTMHeDPfUAJ7fY7GBrG8XeoQ+mudqjCMLwyk=;
 b=F6FirOyLECwi4xUZWwi3csixeOIXgkkP9m0Kb5qOucTn+RRftWn4ueg86+KuGPRzkpoiUvdsFK9L+AoByArB5C+43YOBRCpKoUYVXgClnZhGhQhV6u/4cVpBCdDGbvMEuKkDckFwheX96s236yNOCDz1b427K8IXKF5pqE2x9hIk4qUJ/s9NdHo6+2ylO+WN/RRrK4u/1IRC8yunu2ZCXHiu8JiGBWveyworXufGMpWtol8bUurWpzO4HzqRRqqErP5w228FAARNZWiMIMCwpJDj5BxxyI6/GDWhVUMAO3XvGVEWMLsFG4CluKKHP9X1/Ve5TdxNN95EbuhntXvUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXSSI54dTMHeDPfUAJ7fY7GBrG8XeoQ+mudqjCMLwyk=;
 b=H03OvMBDjp50U8Sb6TC+jUvVk1RBEKhgs2RAv2N1CBjIaMgJfQQGyUPUKQ4eX9/IUmYWX6xJcQh3M1OZpB2Be0/0xTVkQGM5v7cLZhje4eQHE2jQrAtFL78oBiKDVLyLqq2BBD7yuvcpFx9RXCaml1XUJsPiTxzNrsuuqz/N1nQ=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:15 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:14 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 00/14] btrfs-progs: add support for device role-based chunk allocation
Date: Tue, 13 May 2025 02:09:17 +0800
Message-ID: <cover.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: b287af90-8b10-4061-bd16-08dd91803e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZS//krRDamwLkxhI3QAVCzorBFi9YAnxyZK9PA8RBCgLw+g0Q6NdZZxOisU?=
 =?us-ascii?Q?9CR80EBb+oEvcil/MzWJl8fvOIGnF9QDPpw+xPqThmM7KMKcFSzfTgDwtCGH?=
 =?us-ascii?Q?hw/pDqEaTrdT2KnpZRnGm0lWsM4Ts89CrwAm97DwZ8XTyAuUDKGL6SI+vt79?=
 =?us-ascii?Q?E0ztn1CllWbJOqDvwu668zlweQvN4oo6T6XVWz6+wlf9aW7aEPYdk9D5XIBH?=
 =?us-ascii?Q?7NPlJgMOl3D04QhICbOyntRn5gqvPKG5GoScrFpn73cHazES9HaeJzSm8RxP?=
 =?us-ascii?Q?pHJvGHGl3irKmt/eHVeF3dWR5I9PwFvyl89clPuaixb/Ux1hu2toiDRekH+N?=
 =?us-ascii?Q?ALGaQvonbiwwFh42lb8MHJLPaQUXurTrVaKlCtB9QrV736WO4UBaLnGjue1P?=
 =?us-ascii?Q?WDiWeq0S9mm73jJN7g7gdzUygrUjyrvtN42mSaJ/mJIkDhj8Ak2fq+tuZn1J?=
 =?us-ascii?Q?tntC/B7hpd4o3Oz0mLRczuYhEIGX2QqlAKY/D1fqC7hG43rHja6PXZI8Dzgf?=
 =?us-ascii?Q?2vovrkmjfEdbSvjvBTI6y6ZvX0UqKHcoToqTBzE+VfUQo2BRVIFdAcA878TR?=
 =?us-ascii?Q?Nzby2fHgSgZs+Uzswx/2vEoduz+H54573mMvlme3DDzkvAjn765BQVU5oRWf?=
 =?us-ascii?Q?6MRjmW0TizK4HMEAdvkI4GC+4TUQ1rSVKrrloSRdwJasCSZLieTu5BXBNpbe?=
 =?us-ascii?Q?nSttM2WU2U81feEl4bie9x9DvC+saYPx0sww21YPiZKiQgf5Gu7iarsPsHfo?=
 =?us-ascii?Q?y9f/m6X5y28uN3mtyAKzJ4Nu3JT9JTlCSZz+e7IaKHT1cjBE5yAYlD21uatJ?=
 =?us-ascii?Q?6Tz5GxaNB+vIKdtTA3F9E2m2UQPFlv2pCVOQtJrXCA2SMjo8XNrB66md9Kq6?=
 =?us-ascii?Q?dPiNDLth16QwdmV4L+zOv4pqdeEYu9vht2rK3C6ERwbXBMaKIucy8waEWWRC?=
 =?us-ascii?Q?utyJtVQA2scFFVaFYukespR51cYAUSUBQlFMH9o9uI0y+LK56gbh3FqWvzUO?=
 =?us-ascii?Q?we9n+0kWIqzzadVKhjzk6GOGxdYcRhgkC3ygQAjBWvhLByy134yPc5r4GhZv?=
 =?us-ascii?Q?Cj7gFbKKzJOuevyYn5N35d6K9ncSshJPhlZeEVEt9nm3xtFVk4Q2hWVf0A5x?=
 =?us-ascii?Q?URBDWa2IXxfModQG1CjZIk8lRcglLHPg1eiTGGPdMeVtmuB0mCPTwZ+HgDEr?=
 =?us-ascii?Q?1OT/vJxqSDuNT6fXTWgu3UaN1aDQpolgutwB82X+HxcZDq1yza4pnPtZyc2H?=
 =?us-ascii?Q?q7wErEziotXVkMJ6G/Ycabd4jYwuK6YFDOLVfnidQogb4sOrigQsGrj0Yrcv?=
 =?us-ascii?Q?RQKqSrVeyYr8Tjy3DgDk7yl7qYKow06O/lNazvdT065tNudwcf4m8p1N0no5?=
 =?us-ascii?Q?88jPI/o/ClsER5Oq2uR9+0UG1K24u24A8yd6wxulqIlE+qzRKnv0TzKO9+aE?=
 =?us-ascii?Q?iC8XEozOKnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pij5uI5YfwlK7blq6hMR+f72up/wS0Y16lMXkJdCddkH72J4vLNjzL1yLajy?=
 =?us-ascii?Q?NUBMOOmoj8WrKZKHZtecZioGCaGaXwN5WhxujI4fv78Mc5OOyPCfg3wTx/Sp?=
 =?us-ascii?Q?z7svphznSI9hQpxgTtGiZ7b6+7PEkuZ7WOzzR7sAvMOZozHMHjLYEr+BK0tj?=
 =?us-ascii?Q?+lPvJJ6sHL66ZYaFNMqcs5jemuAyTZA0hHF/3tU07fNamqTLV+eq/N4+VFTd?=
 =?us-ascii?Q?uDhG77N1ERH/Rn8i1ttYt1cKK1lK/hDyhr2zSWVXhhrTytz4cHpFUB0qqaT5?=
 =?us-ascii?Q?o2FHKJcYtQDx78EzxDnGjaeXDBhYaAHHYO51QNYuPnVGdWO/Z2dlxT+/tvY6?=
 =?us-ascii?Q?nX8qJddFVenP5FeMlCMAJVf7UotPD1huQBZKKfP1sTQwnzvtM+lI+m8BzeYP?=
 =?us-ascii?Q?h9GXC/+oH6UFdYBgHRj+JLA3lu6MuWbuR5NKVEn6Q6dGa7guZYTug1Obx3o6?=
 =?us-ascii?Q?XOWVqcwVOVhY/8deb9RYx2/5IttSfsJsOsx8+ARczAS7JTLX/N1j9aO4SNTQ?=
 =?us-ascii?Q?p9Acv3ZcnYyKJriGp0+MF8V++n144ghJWE1ECX9ysvzI/8jbOaeiqDCnUgLA?=
 =?us-ascii?Q?LpwSSOj03y4yJYdEpbsMaw52vcKuACFb5DfeES2SHPh8OnwCfF4HKR3zl9eD?=
 =?us-ascii?Q?GJ26gBO5W7y3meTVVf1SM7JMFEnJ1oyfxJB4nXjw6HgV0Rv5lVvX3zQJ30Fy?=
 =?us-ascii?Q?e1aPSnu9h18BUiSd84q0A+CbwVuM7NnaewSXDiCF/8g6UYvfbzts/aMNVXtO?=
 =?us-ascii?Q?8JNSMOF4F83gp0M3k2+/DsdmILB4Z18TDG5Kq6JXrppHpNC1Iuq1sEGvwQqe?=
 =?us-ascii?Q?RtjTXTRWbvD9zPt7vSLFNnGzCqaUVqHKEJ78FRc3Uo11OJBhBmib7JQSGZN/?=
 =?us-ascii?Q?EB+Ql82fHqWIACdMZJ4Y1UFUUkBUCAZ5YdNiVin+LoPTs9pzKN8SGPkRfwlm?=
 =?us-ascii?Q?93jM4YM6fMsQKSUjif9wrQ5oiX79e2hPyd/1sn9YcYHJuYRHD4QHJAqYImz/?=
 =?us-ascii?Q?iixBZk2/wCb4r1NMRp9SJxZY7n0GcVs4j1EX5MjLlrHso3qbczY4QBTCHDgC?=
 =?us-ascii?Q?BC4EA6XvcAaBbd9LDJJfM0Os5vTMGcRcSL6TbD1UxrQplaUsx2iaso06AQ6M?=
 =?us-ascii?Q?1/M/myneFzScZw3MiCvqvblN7XBnMhvXkyNcZgUCI4NSSGe3UwXTlcgcd/bo?=
 =?us-ascii?Q?XEjmnWWr854zat/dFMrHOJpJrIOi7zUkNgB37e5ttzix7HoKPx8FQTc75Qj0?=
 =?us-ascii?Q?tZbYLPpYk1RLOqMVDxp3o/MaTtK/TGCfl6PcpKX62raWLSPOcc3IwN7nzd5y?=
 =?us-ascii?Q?hhuPCFiuxdv4dcx1RRADIiyAdGl8bo2H3YaF6E9gucr451OsieZnRJaEjstD?=
 =?us-ascii?Q?PrPm3/S7dSVmaR+GPstRy/JrIT4941GH92251Zuly8JALHoknhZn2IzDALlK?=
 =?us-ascii?Q?JmG4PIw299zCOPdyWIskpZrOYmbhbk8dJ26Ibh6yFrKbl0xWKL6TTGD1M2xB?=
 =?us-ascii?Q?uBtzaw4w02LVSgdvPUzTO3EaXl3tG80sThBDCGN5phBqNyPR9HV+c92lb6nW?=
 =?us-ascii?Q?BhrgGiIACzWgk5yGaeNs9nIeH0SY465Q+mg+xcmW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lwcw9x45Jbkdg/j+ulr5dU2He/GHsqme/mtIjVMGpyEzI/enF2IA/W1RiYxFdBAI5oXB8kVUZDrXiUIEwm5wecXVttr/pyXmKQR8cG+gC4rS54Pc4n/gxZLnHsSmIDcyVDIa9v4ENzxd6u3bmVWvlSDaPnBrjX2W7x5KgeZCyO948k6ubKcbliy6vmch6ukJOL7jPHVXhNQlDH0bwYcGBZgBrYk8bW3yNVtcbZ+OGIBrm86HADg2HmyeGhg78vgYufg3OUytOpCeBSk1kANq3eggn7ie/1mf3qD+6oIAxR47T5ywghX6As4Na02a20nRbPxxBpB2xRy2akuolN0a5R+pCQfFU0Lom4pmsNSivpICJDOalOSDgDqdWhFuvLWbNtcVlk7llbZMyTmxaXaCS17/dE/8tuWYiMywspKQrDcy6jmLt9kQqbuDod6UwqXI07/jLt1XaGZAoRaZvN2+nUMx1odzhH3G4VFUP5mfp0E3louinwKvINfgH43AEaUbHHT12tFF/3Fv+qpihJGIPKmPP678yIWiQ5Lcc53U1f1zFB4Oz9YcQScoftBZzb9c8zKmTEEhr2IG6ehuwp0qC+hQcT3Fzrcurw1nHGECS8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b287af90-8b10-4061-bd16-08dd91803e6e
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:14.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0gXHtEfgjZzcSLiQZf+tuk4cJ1glTQW1N2VI9Ougd/smhywUpWfzAlZ3EROc5qBY+UQC6BmIN3BSwdOXPA1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120187
X-Proofpoint-ORIG-GUID: 0Dx3IvNnh5iKj19n8N2q5Z3Foih1hm87
X-Proofpoint-GUID: 0Dx3IvNnh5iKj19n8N2q5Z3Foih1hm87
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=68223989 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=6E2YmehwaeY4gP5raYUA:9 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfXxKkAhT2n1y12 DDfuBU94qyaJU0bjzdXRyQskkbnI3iKNY7hUegzoki3LUyCiogWNy459RGzjkxuHGyddHvBhUhu KwRNrdrbxNQ6OfVcSmhdlOu12LCu4Q+yZLZh9DXgfmD5PV5yH7BUtodUp4p6pMU8xLW/knneZBr
 0A6evssC+VaPEdjQ85NQ+bavHqYI+JWxpResd6CIX5MSG0BwoBKPoEiDgttCee/p3vfT3dRCJCw 02X/MJRoqE2VCqgqlWhMkEwXe92T/NDnJNZPIWVzaPhModH6bBVVyW/wOA94vn9kXrtpT+/jW6F yN87gRr+URRn/p+0T3CxOx4sjQfqzSdXlL+EU0lHGQRKeW67nBYcRC7Mw11L9jM5mHA7PgZfC7/
 Vyt+83UGoM6ZMo8Mz1yveRfSGSiztKzSbF8tQAfWMUYDTHvpLRzpP83RJ0j7p/5LyZfbglSx

Adds cleanup, fixes, and device role support to enable more efficient
kernel chunk allocation based on device perforamnce.

Anand Jain (14):
  btrfs-progs: minor spelling correction in the list-chunk help text
  btrfs-progs: refactor devid comparison function
  btrfs-progs: rename local dev_list to devices in btrfs_alloc_chunk
  btrfs-progs: mkfs: prepare to merge duplicate if-else blocks
  btrfs-progs: mkfs: eliminate duplicate code in if-else
  btrfs-progs: mkfs: refactor test_num_disk_vs_raid - split data and
    metadata
  btrfs-progs: mkfs: device argument handling with a list
  btrfs-progs: import device role handling from the kernel
  btrfs-progs: mkfs: introduce device roles in device paths
  btrfs-progs: sort devices by role before using them
  btrfs-progs: helper for the device role within dev_item::type
  btrfs-progs: mkfs: persist device roles to dev_item::type
  btrfs-progs: update device add ioctl with device type
  btrfs-progs: disable exclusive metadata/data device roles

 cmds/device.c           |  57 +++++--
 cmds/filesystem.c       |  15 --
 cmds/inspect.c          |   2 +-
 common/device-scan.c    |   4 +-
 common/device-scan.h    |   2 +-
 common/device-utils.c   |  46 ++++++
 common/device-utils.h   |   3 +
 common/utils.c          |  30 ++--
 kernel-shared/volumes.c |  40 ++++-
 kernel-shared/volumes.h |  26 ++++
 mkfs/common.c           |   2 +-
 mkfs/common.h           |   6 +-
 mkfs/main.c             | 324 +++++++++++++++++++++++++++++++---------
 13 files changed, 430 insertions(+), 127 deletions(-)

-- 
2.49.0


