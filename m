Return-Path: <linux-btrfs+bounces-13986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB533AB607E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 03:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B81D86224F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEE818859B;
	Wed, 14 May 2025 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VoSn5uS+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lzpddG2O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C635150980;
	Wed, 14 May 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747186565; cv=fail; b=Jm5enD6JpNlN6jsvsDCOloanENrYCwPvJcrDjleCEu2Ksk2kzkS+CG2tGwM9PaPVCNEXfJsDx2d/NN+ySaB8plcCdqOjuxwe3QU6WwZPUuTVto605sbsP/eeF8TDhQlDLOwDH5NhVMRgcjL+BBLHyFHhhONblbTcIZ9Xr6XVf7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747186565; c=relaxed/simple;
	bh=RNv8Or9xVmdPKrUiFwNf752+yBvj6SecP7ea0gAPFDw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pX5X/okntDjUK8Ull70RcgEtSn227LMbzfMW7yfLJuJD+3JkwkRGHu2jeMHuTVMSqrhShdyQiILhtMnllFGD6gA0ZTt4Q8g0LWN1em7ueXgJe2Tew0+4RGryIMIKiKhde8Im8neclMXqvQCeN1eBY05mQ2nnGSZVEgK1d94Z7EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VoSn5uS+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lzpddG2O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0furJ025341;
	Wed, 14 May 2025 01:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=rEKMkNpIFiaodwsK
	NeMZau8Iayt2oNkOXCXVPDnyBus=; b=VoSn5uS+s5Ie3uVGF3KshHWFj8tj/fOF
	YJygL2UJC+VFWR/1s1+PATIRGOkPZMSeI0FQy/7+gNLHYYSXLlbydIYDvPvK6pgg
	keBAQQoZbPrE06i3LhYcQNcoqn0D12g9aqRwT2zIJ0FNfydxm96vr6HE7NeUekyS
	XmSmQQ3yRsFJRVoL/Hdq54relmpyCtbtj38EI2M1LzihIxnZZ78/otHTeDGQQweR
	MRiUwgVX+ZilUS42qseM8Z0kOvsk72lI+5rBwtlYvaA4wLN/Mc3loMJdA+JQ2Bap
	rqud0uHHKCq1YyflwiF8H/umSiabdKVBnM9aYDW+7XseRS5xVqeUNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchrjgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 01:35:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E1W8UI033195;
	Wed, 14 May 2025 01:35:52 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbs8kghm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 01:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1ODVrDm6O/oRa6ha7p9HHbdH2ReB1hmVnoTUN7YGE9g9QW/fF2ARwR1K2CNzW8ZO+uXANZ28gwal+CCIILFnj/n2OE75SPpvfQ0azTJ5yBO/aeI2cGVEEsEzJ5ZKPuCBnofHu9uFxPF8wyV9pPPM0oZdaFDNyNbsc28NVVtxdzfAmkz8xlGsNPScfKmyvo7JfBGIsW02hxQz8S7dpuJJwxFkssMOyQKBSo7PUsd5m0GSfrPkKfKBQbhnc3s37lkrW0P1nen6TUynBmuWfF8h1LLsZwOLkyNF2cdTUbE+awk8i/LWZ0VprPb8y+WndYi+a53nWEuo+o5g5EDyBXH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEKMkNpIFiaodwsKNeMZau8Iayt2oNkOXCXVPDnyBus=;
 b=RPMw9N3cVnVmVyLq1z/QsWyTagWcPVz6GOzNJdUoMwz7+F8d02MxcMhl5zyKb9GWCq6m5zkWaG5wnPWBxwlapADDTmkFT2gvFQX3bCWrsaKbQcB0lW3wI4NcahzcLljzSBAouqzjqpv56QB1VQEmvUpyqAVDw4HB1T3LhiotAj5D7yLaRsWDpSElVp45FKfVldQXNwgMF5jFZW7K3dldNvJCfOCbfaCp9uygpXlssWFHQXXmHqeEGN/VGHvCT9dR0FtXXzD2/2KUjIgz/HeC9qiOcEPMsDN9GBVs7TI+qZ4COJvR15PbDwXKjgPwQvT+YdGWAZLeFHQC92dWsDAYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEKMkNpIFiaodwsKNeMZau8Iayt2oNkOXCXVPDnyBus=;
 b=lzpddG2OAH8NU0f3EC6uykJoTkIdcvW5NMA2JMBvxVYk2kaoZy7I1FkOMHQ7eqdlp0h7rzhHa5+B0nB3EoDl3bp0262ZRoThiZidsheWyg+/A8t6hYULXxdABVjKBtnZ7yS0nWX4vyDZY6cpiwoW7VjdfNwbSC5S/3g1+SMyhk0=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CY8PR10MB7194.namprd10.prod.outlook.com (2603:10b6:930:77::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 01:35:50 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 01:35:49 +0000
From: Anand Jain <anand.jain@oracle.com>
To: quwenruo.btrfs@gmx.com
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/336: misc extra fixes for the testcase
Date: Wed, 14 May 2025 09:35:28 +0800
Message-ID: <9c9683df7928397142cb345ac5bbef2456972bf7.1747185899.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CY8PR10MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dc92a9-c5ac-4305-b645-08dd9287a7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJcImz2csJNTrFYrBNB4CFsE6aX6x1LdT+KxxQcCzLAzIVsSC0EOJdcB7hc5?=
 =?us-ascii?Q?jjkqozug4xfqWbFz36TF7dvcB0/FLC9ZBTb4E4WsnIusNKgvwPSSCpULqses?=
 =?us-ascii?Q?Wx1UGlDM4/lxc32aWGbAt2EaPjN6D8VzDxBgYxuLnJ8AtIZ0cjuRxUlGXnO4?=
 =?us-ascii?Q?5ag7hg9YyqjiA/VwKOTOMqaLhbdKQnuvrGHg9hwNBSvwohpYFF/w1ORuCi4k?=
 =?us-ascii?Q?ZLVNosCQvJeNKFmN/LpUpBupYUXx3eBxljuu6A2ISEG+b7qb+5zLjIRQT2Rq?=
 =?us-ascii?Q?tqNwCMaSqQ74m/SkTNtGCP/nH5jMFrCBYPdWqVui8u7zMWq3bChNiRPHtkgU?=
 =?us-ascii?Q?I68PMBmnsZcmvCprkl3vLekFwIkoez8tkvNGU6aZEp2ez9/JVtRUtvbtGhAx?=
 =?us-ascii?Q?q8rPwxLEtyHMTC3W7GNin4cgTrPQTHyXIN7qnw1yf9tS0BZgLWjkYOv86vA7?=
 =?us-ascii?Q?qm/BjlfOcyJ6Y2r9yCVyQEZ6eRvwZ5uMHnyhreJUgVCn4PbpO3ocKC9GhJ2r?=
 =?us-ascii?Q?l2PdqK1JRQp74q2GPVeiAnwhbyzb/z1NrJuvUTqrfnTQNWTFmzfHjvkm46km?=
 =?us-ascii?Q?w3LFbxQlaaWDrah5UPlKwzu4VgarkbpET2rTELaWQ2eRZrfOXvcZp0oAM/Ch?=
 =?us-ascii?Q?Mql7m4cYUdA9auVs0Nv3k36eg7bcDjqxjXnxKZPkhXnCGQ5xOjpX7s5gXYSC?=
 =?us-ascii?Q?PJ1yUVGgQDYJvhtMvDgCvwtpm8FYheDxMgN+e7WTUeO1wbjNRdm7qUSps8FA?=
 =?us-ascii?Q?tpo3aGKnuxesiOlAr78A4+XsJ5jr8b4YgdwAlQmgSzZauVmetQfFGcX6wXNH?=
 =?us-ascii?Q?vvwNNErrKOzWRO01T2cbo8mF9SZLUJy9yD/KxtReDaY2XbgkZXeYD2cEndB/?=
 =?us-ascii?Q?v25R+DRBzQ6MPHW549Z6ECXuivUuJKzqwlpvBKfjiUEMH6dya9/y6Zq0TIX5?=
 =?us-ascii?Q?PnrOcGGlp6WdWNvWinJAzZTnm+uwiq8Wx9oyQfbl0QHJPki3D6RJD6HkQUXj?=
 =?us-ascii?Q?jD+OJMf2H/MmP+bTa0nYIA1J9fqB+PNml1M5yzzKPfoCm/KQRHQvkVLHKj02?=
 =?us-ascii?Q?OZvjFuA18RN7jswZ/WmYHkXc7McctjfHlREyfuA8d9IDzapyvp5RyERPCDfN?=
 =?us-ascii?Q?zgtGfEHbR0LVCWa04Y8pETG+RNElFSCh3+HxtSS5fnJhiDHxNKG0IHmd0X88?=
 =?us-ascii?Q?8vn1C7miPE9wslD5JvVIgClKKswS/+KzHixg+dZIk1HFpyxTjUTb+307AuYP?=
 =?us-ascii?Q?nG4QQ94pZigRG9Yb4bP+aq0F7htet8+1pGaKK6uFQr0JByJYwvgIAgMmK5Du?=
 =?us-ascii?Q?31rhbS5zckHcS1VigpLal6A0ZRNSnPXDMG2yITr668KNvlmBF3eZSj+nF05h?=
 =?us-ascii?Q?LZ2AMV8TCWBcS0sUM3qp92RQS3e6k4qcHU2U7vf0R98jYzC+wtEIFZrJoe4N?=
 =?us-ascii?Q?5M3NLhBMchY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2TK/ty+IF3lb2ZJkQuFhuJQBRe8kFY3Lf6v34F4n5kRj23MsnwPr0XWUfd8+?=
 =?us-ascii?Q?sibav/0wpBAPmlHLHAErHpSeAO5D2T5C6otg4B6vdGrXVfd2XfwwHYgqR7ks?=
 =?us-ascii?Q?3DcpX+iKr3BM6I4pNAB9Kjj1CFMbDXL8KSnsMg33FvJChxmz/Wi8T6OK3ODQ?=
 =?us-ascii?Q?1wCl8FeVeWL3D38H1UaoATOMHYsIysSjGcYyfWMTv9UOe+Au9Nmbhl5/Lsam?=
 =?us-ascii?Q?ZwQeQm3S3Da6VU967EimUK+CXXmVTqWXBAAus80kjIBYTTV1pOmnc3ZuX4ze?=
 =?us-ascii?Q?YYtSWWbigphmO5hySkoOc/1AhafOxrmNQS2jJeEvCqWtcQsRt3QJcCSfhyRY?=
 =?us-ascii?Q?VaHUSxlM275I0tIcEHityfAvf1SHjQTqDRB+5ZiZHEbTjrygcgaI4yx+xzm+?=
 =?us-ascii?Q?FmZoCC/4TnlOEdlK6I7kPGGKr69uHpIjvSRhzljrFXlfHmyIizslLnuT0lCg?=
 =?us-ascii?Q?0BJ3vMxuzQ/V1BTskB8hzelC+9sSELocvRcRd69YuoU9gFBcgWO7V3zNmGzu?=
 =?us-ascii?Q?OJgaEgYEv3tgK9lGWpFp03Xh6tSjeBmFvZ+buwKLH/pybpzeUT1lxJyRPyg2?=
 =?us-ascii?Q?D1CMWVkCN+PAQg7E/A6ue5zzIUrXFoEiqitta/jygreNWUHGbHW/Ivpy7kac?=
 =?us-ascii?Q?Uh8FLrllQ6sJViGzpRxG2BnWf2fXoTQkGph9jRP3NQosD7tBS8h5xm1T+3+W?=
 =?us-ascii?Q?zceIgpDO5LPKroK6tcCLaH4rLTNP9/SA78SRZ05y/QOCAjEwnE4fuwB7YI37?=
 =?us-ascii?Q?Zfx9xXGCS7Ym6uBqHkuKibrCSTh6X/0qoWdfCR0KVs+6v8LM9vHWcdekBRbY?=
 =?us-ascii?Q?Qb7GgzertcxDKpemFAvU9y7oCjLkRk7UCBK8edyEpIdFtdxKBfCsBxwchzAe?=
 =?us-ascii?Q?Q+9Hpn613HSRsgwG9qnFQIMaeXTiR9B7I3vZ8LdpayRnnTET0oXeqO8QsCLi?=
 =?us-ascii?Q?EnU+0GDyI61keCV1HVVxrShdo3nzr6PiLn57zlHArphAhPci68ayBLRY1vW6?=
 =?us-ascii?Q?hh7RFE1eKt5xgdvisJ4DqYOV+gVJj9SrSZ75MGSu/IfbJSixcq1y2vBTOC3s?=
 =?us-ascii?Q?EG1THYYkhxDDvoiOafo0O07Fk5URM9jkGyri9eQS6E5EPmM6jX3a7s9z0AWO?=
 =?us-ascii?Q?dgktFn1SnR2t0ShGHU6s+szqt8UeG4oA9owQCmlvMZtNLEuS/KE8+Nk6410L?=
 =?us-ascii?Q?FTOtRVP5M12TD9GwOJ7tXluCfGNYGsK90y+/70E+LY2/UF2BBVu7BqjT3y2E?=
 =?us-ascii?Q?ZQiakwHFZC8HuSrh0wfWCI6QbLJSJDezKNAyqmW8rHHX5zPT0anowyWop/Of?=
 =?us-ascii?Q?PRkkTSasj/1JT9Qu9eZBlC/f4ylqevRiGVqd3n4YfVw2+xthMwkmjW4Fp+hW?=
 =?us-ascii?Q?1waT43kSMzmb7pSLh/Co2212oL9FwCmzaMVPKjlsG18l+ksbTJ+E4j+IJb95?=
 =?us-ascii?Q?kk0B4kpzQQFRfi457OTlmwcfENAP9E4V3266Oh701ol/LwxqtiM9tmNZ2ECT?=
 =?us-ascii?Q?HeU/90KFkLPQM7QsWT1+LUNzn8pasHoZOw96U4WXlU+9GqRXdaJ5fCg9H0Qc?=
 =?us-ascii?Q?1si3ilaiKgVeorICtv42iFURrvDrXXDOX3o6Gq+c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C3v+OYUhK0KGlI6NTLcE3zltmjxOsxIrl4T5LdJhST6oOazAwF6ZEVTYIwMQ8AGVXLg7iG6REqnDQG8OjQJYlmuQmGBaGAMEo6mjkHnM5/RHPAJgkWoZZr9XI7Rkhpaup0zY+U1uTyDZH5PoXZlH/ilqXqoQpFLUaS/3dDrRsC0ewQe06mSsWQLZTfY0VVRzY0wZqAQPMd5UdSWgsYJEE1jCofI96xaBLrXbEgo1WNCvg9Ce/vbCsJO5vu9d57MaVNFlpfiMXMBrv+p4actimAcxNU413MM/os+7Tat0+KJIbqnBeKpGJ4WU6BrJLd6zaF+YuxeWu2znucytp1ntvWFaR5UqXckFgXJSLS7+OCp8zrky932s64j2YUqBxJu7jrU8QAwdWjQAJ6J6QXragdb3w1qpFyaL73Ls4Yww6kSRJ+RyQUY92w8bYGhoN0oLmdw4bWBXs/JpW238uggkFGZ9A8zROfLoR7ds5Pkb1BD5/O5DPe3nippugekb4PXJrMjHAiQmc+yoReH/1PBl0/5glM1P5QeQLFsjtAUkoa4omC6nsuzjHBQZoQZMMRnrumZ41K9nlwGip4lUecLpCvNhEDZRiySvwJjefnfItG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dc92a9-c5ac-4305-b645-08dd9287a7ff
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 01:35:49.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVDiJQemCFQcm+TeNBmsWe4yxG0I2hrR9ntFBCGPnVcwFgsdf5w5gy34K/RL3b8NclHnG1YrKLQ3EYSRBxTDfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140012
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAxMSBTYWx0ZWRfX/l71twsGY6hZ BQ69yb2w27h2Dj7zJCGoJLOpg1z0/4XDc+CjXAagE9Y8kkitHa7P9ukP55oxmQ33HKdAuS8K15t FrvBFxi+ENn+ppfouFg0YiO5EsWZI1chlBY7yySJuV9iRABb/cmQleJXrcy9jdNJ7s2aA7PC2mn
 8GUaFX4u7h8ZmZskXcf0KWb/mtTYx49YmbCK5EI4T2h4tv+kn53amuVD+2O+CdqeupGio9AHCOQ VRmsVbJv/X/Txw0i95lwjgti/qIE0BJNaRzM8NkHFiRwGjj5ZMZBCnzBj1M9AbWQmM9Z3cJ7Ebm PAdqpqwfGTmpSFNfOfekvs0qgqno2LP6L/hhkQ3BxKuli7enge4faifuSrKbCTHoZuQieBNKBTM
 YvxengB07TUDUUJOBgczCwoGJBy4UZsPvxynsOzUsVe694MEvyvvtn3hyoLE0MHW+xn6IRRA
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=6823f379 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=SkDXy_5g3aDK5u79EiYA:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: rPmdbv5y0yXV41CXaRT2Hls4lWfR_yR6
X-Proofpoint-GUID: rPmdbv5y0yXV41CXaRT2Hls4lWfR_yR6

  Along with adding group dangerous..
  Fix the fixed_by_kernel_commit with the correct commit.
  Use the golden output to check for the expected error.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Qu, This change is big for the last minute merge time fixes for the
testcase with rbs. Pls review.

 tests/btrfs/336     | 25 +++++++++++++------------
 tests/btrfs/336.out |  3 ++-
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/btrfs/336 b/tests/btrfs/336
index f6691bae6bbc..503ff03b377a 100755
--- a/tests/btrfs/336
+++ b/tests/btrfs/336
@@ -8,10 +8,12 @@
 # rescue=idatacsums mount option
 #
 . ./common/preamble
-_begin_fstest auto scrub quick
+_begin_fstest auto scrub quick dangerous
 
-_fixed_by_kernel_commit 6aecd91a5c5b \
-	"btrfs: avoid NULL pointer dereference if no valid extent tree"
+. ./common/filter
+
+_fixed_by_kernel_commit f95d186255b3 \
+	"btrfs: avoid NULL pointer dereference if no valid csum tree"
 
 _require_scratch
 _scratch_mkfs >> $seqres.full
@@ -19,16 +21,15 @@ _scratch_mkfs >> $seqres.full
 _try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
 	_notrun "rescue=ignoredatacsums mount option not supported"
 
-# For unpatched kernel this will cause NULL pointer dereference and crash the kernel.
-$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
-# For patched kernel scrub will be gracefully rejected.
-if [ $? -eq 0 ]; then
-	echo "read-only scrub should fail but didn't"
-fi
-
-_scratch_unmount
+filter_scrub_error()
+{
+	grep -E "ERROR|Status" | _filter_scratch
+}
 
-echo "Silence is golden"
+# For a patched kernel, scrub will be gracefully rejected. However, for
+# an unpatched kernel, this will cause a NULL pointer dereference and
+# crash the kernel.
+$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT 2>&1 | filter_scrub_error
 
 # success, all done
 status=0
diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
index 9263628ee7e8..63b53ef43650 100644
--- a/tests/btrfs/336.out
+++ b/tests/btrfs/336.out
@@ -1,2 +1,3 @@
 QA output created by 336
-Silence is golden
+ERROR: scrubbing SCRATCH_MNT failed for device id 1: ret=-1, errno=117 (Structure needs cleaning)
+Status:           aborted
-- 
2.49.0


