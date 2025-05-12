Return-Path: <linux-btrfs+bounces-13944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10448AB435A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17488C5999
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84B929B216;
	Mon, 12 May 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/biePZA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQsW4pEA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544229711A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073548; cv=fail; b=Rx6B7X26dYie0pJTpMpifvQ2uEg5DAhLZQXFor82hTP3Fyk+0I2av9yblqLJSCBcTjtaoO3K1vJSUV0CXU+jWNyzQBbXezDTPgH3lNm4aW3Jo7AsyAPD5r5XcHBqcXib9iBQJ7mAADzxIMOURZFjfjpxUfIHIluuuNnZCMgWSys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073548; c=relaxed/simple;
	bh=kY7obzkVoQ/ylIcVHusBVU4M/FVbp03HW+lfsaY7BF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3qcPUyo57oCvtuJNp5+F+2XUAtxSCiPSiLDAdYCKKZbZShrP0VUOo9sIsEnf/kLWjYMGbFtZNEZoeIVOUg2in+0zmrk0nZQklLuupJbzpvz74Ezq2JCb0rN4aULuved7nFmzL+O9TvJ8yHF8XeKKr7WgfSkfe+7A3eMM7WMlBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/biePZA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQsW4pEA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0rZQ000508
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0iCb+dxQVinVrg3biC6x9ZnkVOzmvXICVxWkffSEFY8=; b=
	L/biePZAEiXKjmFWLG7XJuuWUUino2Eyaning4AXglxYsODNu6MkQGF0UNVu2/FU
	7b8Q/5AJkF7S+PGncSYXirnYT+otmxN+tQREbfi3XULDo8oGWYzqHIMLzWdHSfD2
	k0Zes5IBB6zky1QwsGVTPfL1p8RDAC61Ffdtevr1dXIGm1jFNH7RJOW32i2FTWEA
	PIYr2wAdobljv/ClBd0s8sFH7ZX5xRv7CYoUp21aXREWkROc9qfYsZDlqZY5DWHv
	/Q5ILfPBYF2k45V2QdxSCGhvfmAdIp9Dhl2zUDn4D/QrXDEdhr/hsEIW7ddRdPLx
	IMQvoNVhhna/1RxslIQ71w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnk6fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHFFNV036176
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:24 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87q8fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWNRV3sLT1i19CWxAi3728sroEgD7qzqysTzv7bAiYWPKf/5u+7SKV2HMl37RhqngNAhZy5CP+yFC3VICildevU2f+OHj6DPOLas4hLTwfboozQTKgo5IvvoJmtoWiazp7ARzS5lljQju5YPsllZRZlwOvC+HxnaasGrd5ZFJez2myuroD20dEhM1qw9nlerQpdLjkw3Bn2n6/UI5y6sHa8iAxcSzIgF2EEkelo8aOnX/Ess9iNCZeavFi0/QmlvBVKWcBait2n8E61G+u3mTmjwdgb6ULoWvAS1eEuXHKl8HPeUbreyZmmWdBCDzN0QU6/NAAna5hdety3oEoRo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iCb+dxQVinVrg3biC6x9ZnkVOzmvXICVxWkffSEFY8=;
 b=uMXKLkMQ+IVJouuCv0zhxNi0UgWQI5zbNSSo6PfN9AsyRNTlYoCm82f1b1pwQfwFdvsK/UpiumD0tjfAHjnAYyRXSiaZKGRAVVdFXWSvtaRo+/xn7M5AaP5jsnjmKRYMpS39b0Sv9JQIiXwEDpfgSJ+UPzye7Ex+DB8XbA90SbXYdiYSAWKgVTbIlbDz8wj4G/H6YXYhyMBX6LPpPLJgPplPgKo3PJaR6BTv2P0Ezb9zQmfYLC38OutwfmoFGfBnUUHr7x6wcWt7br0JErM3mSWy7BQNlC3dBoFiMH8QfAStlnIYI6RMZKJBY20+LcyWAyTd8KRDv2+IFxKrpcnZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iCb+dxQVinVrg3biC6x9ZnkVOzmvXICVxWkffSEFY8=;
 b=AQsW4pEAEvx/QOeMXrWb0GnTEc7HL0r6IXO+d6fasIhrSdZrWQda90EsEwM2Wwct+3gDjlRaoR2bWJTlNv/GKDfulZ0ffom+W4iuFkTZFSHDE503ViPA3I7Q5l28SsOFARIBS50xn1f38Ntg5QkKUin6TALw2gmwtQ1PfpDrfpQ=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 18:12:22 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:12:21 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: common/btrfs: add _require_btrfs_feature_device_roles
Date: Tue, 13 May 2025 02:11:40 +0800
Message-ID: <7fdf37215e33ad51b59fa7ed8216c940249a9da2.1747070864.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070864.git.anand.jain@oracle.com>
References: <cover.1747070864.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf75b7d-c1f0-4d5f-c502-08dd91808a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g2gb7hz37f0+HQpxaatjmmSDcX4JOYOhQvUKC75M/LFrZHQstxnUDzUs9BPX?=
 =?us-ascii?Q?XO+eTpvrXNnPm/fcZXxfugStD3myUdjCz5us45dVFVuCjunzfwPhfR98T8NC?=
 =?us-ascii?Q?IVPEA8HoBJbLN1MgIFqwXClhfc6eg1XClUW6Pno43vYu1sLw9vG+SIe/b1Me?=
 =?us-ascii?Q?sc5xT9WKuIuWrwQU7nwcwbrf/hg23dj6ywc7nopO7iPZATwRr8BrNpm70x0Z?=
 =?us-ascii?Q?DXlH9VWKIewbhD3PFwo+NZj4xNmiJZFYQlx/8EsQyHUdUtfRmAmTXUAErJ0B?=
 =?us-ascii?Q?thZof9mnwQQVOFwSMS4FS2/cB5PLyec+q5UTSEE3dsTAAZVW9yTL0pVq5/eF?=
 =?us-ascii?Q?PUc96+ZGWQIl+p9aHfVJLNFaKS/NCTIs9QgRTZOqexmBEfaO1tgzAXzsblRu?=
 =?us-ascii?Q?ohFmy+3QYPqe0G5aP6/Sdm7S8X1puB/ogFIZh6/u28xEnuN1MxtEGm8MEPtz?=
 =?us-ascii?Q?GkZVhcbpx0GTzrg13tRqLUMXcx8ZFnFFbK2h+U0jtJPtd3axuwzmPWXZ9KEy?=
 =?us-ascii?Q?uEXGQ31xjV2JIIaljuAOs1wvX4FmkROEc89N/k/M9kGzKY1OWVcg3cuNBCid?=
 =?us-ascii?Q?dOpbcx3o3LshH/pJQqYAGW94bDjtfkWTT6f5gHpYw93ZFP4E5gT/0pjP85E+?=
 =?us-ascii?Q?C8VS8IZZnqz4sIzjXR007iI1utYkkDwXbIdzXNwuTtdW16HyXV1bPfLXbXO9?=
 =?us-ascii?Q?+YlI8kWgfV3AZ5L0ncUcu8JJilsZtk++5nfsExhsRhKiBo3lRVW7XnsIJlV0?=
 =?us-ascii?Q?xQq69HVwDo1tKAbNlXwgcPNe4Wu6mC0PAbZnix2gngbiO3y1demPVGzE1Pga?=
 =?us-ascii?Q?is97zQ/CYldZbqJ+Y5bCLi3SzdC3rCwsrJvkwf9Ud0VL0sAqNMwuJkMwdbdx?=
 =?us-ascii?Q?dVG45aTMZnRVrcp3ptUJPkUPQoG9/PHT1eGsZ0N+SX03jUlKZhSpo9uvjVNM?=
 =?us-ascii?Q?l8BTKQ1B5/0846Lx7ROJqDpgWKyiTLLu83hQau6tst8zHDuOzCipyx0nooch?=
 =?us-ascii?Q?EQn5+dQyu9aEpfKvN1agAmuvbCxAc/SSCe8fJOmJ58nMFztuhzVSbVhSQ/Zb?=
 =?us-ascii?Q?Mv/QTyYbF0r8H1Z/KssHLqGW6xboS+F4gk/VbGY58tYh29uZNJFqHANi7ZQT?=
 =?us-ascii?Q?NLsSrK+KAT7HQpuREASCApRQ++H+PJaEAKvQiYQct1K3HXQERkbC6p4CKTxV?=
 =?us-ascii?Q?9qDwVbtQNw1GYY6EVO5AZkH8YMRfIKR4BFvz/klP+WE0moqLmGH0+XcOUQS1?=
 =?us-ascii?Q?Xph/LofsNPmmGPPcH8LVbYljBbWWvBui2rHUhhVTCx3T9zkguAl5AaCalAzr?=
 =?us-ascii?Q?RxddzlBuhO8j8tbX7pBHpt5hic9RJm93p2Cvpg9aS1Le8qCkNNFvinG4Od1C?=
 =?us-ascii?Q?pFmNEfHlgk6BPsisPZXy5s5A+rgie0dy2+B1MgDCuFWHQJJdHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SDzH7eBAB7th7NBmw6q02dcPvTQp3z1K0MhGUzsvPuoZVDAZI2XWt36sJeC?=
 =?us-ascii?Q?vNaKh9lF3Il070pXkhh7fhYyHohVABD9anL9QtsaW/PebL+W6UMFkAi7OSE+?=
 =?us-ascii?Q?+zf4xhxzuzDI2Ol5iLfWZNERCl4BsMJ3uhBTF56d49X52/dClVKLcDRoT81D?=
 =?us-ascii?Q?CSbqeErsm3twipX9Yu6ZbCnhFziZSn2/6I4cPnNOUSJcjdKhGvrUIgBxKWRU?=
 =?us-ascii?Q?xFBVPbT85r9jyHTHZQZ2sbA13d0EuwFi+YH3bFb19p4oeETkmWEH569kMmPl?=
 =?us-ascii?Q?8AvFzhotyAqG5ZtX26ezda2EUi27VPQGfqzCAh9J+jMz0nMIHMVTCfzq1OXG?=
 =?us-ascii?Q?/wcZv/L24BnQ4Sq1mct6fenkBR4vxD3/T5zWgrViJBuxO/JyLRhzxO+QvfcS?=
 =?us-ascii?Q?lDFJ+o+683b0o2lT9YXKSHLIJzIr6lp5+JE25lkXpNkLaFjhuvWuvborqYWl?=
 =?us-ascii?Q?qr8SgmIYDgdnKhY97BNU70DR+CJAh8BYlUPCRsONYXXLsbV5uc4nE4kk93M9?=
 =?us-ascii?Q?tUYwXjDht1AabtuYQ9ycLa+bCHA/PyvDy9mJhBOnPUJUFEpsONZFZ1kIgmO4?=
 =?us-ascii?Q?zWsGqTyRik3nYCvK1UOdO3wTKtyAHpHusstMubhE6OCJzkBEkiSG9I8+pxWn?=
 =?us-ascii?Q?jRAC8gTrduOr23WpH/ro5DT4q5DucZF0/QQI9d1IsoEiR8C39d5gX5MJqw+2?=
 =?us-ascii?Q?S57BFws8YGdOOYjqNdBy/0yw52Yr7mK499IFCMpyHBr5wlONxN2TjOhnIkd3?=
 =?us-ascii?Q?P0hykHI387sUuuKs7+rwmRosLp6oMc8VQ7adEzyBoWYaP2zTuZ7X4avij537?=
 =?us-ascii?Q?Nu7qQM/oruc8WOOb2FeAwREbfeeLYLKgj1zeVWGilFg3p0WncdH7gKJl0XC4?=
 =?us-ascii?Q?nykYjVMFwt306IK9LCtm2FP+BH6+3rPjHRcsHEtv2tDRnTPnrB7sQO+wI32F?=
 =?us-ascii?Q?HORssGxAtZRCHQGmz6MH9LHWhX6/T/vjwSodYXjbdeuxIsmk8Xqt/xAmh6AK?=
 =?us-ascii?Q?yDgw9yU6QFwM+OY9ibQpVa5Yd46mcXdeynTMonUQzAaU0G5PeyoOP4BlkyXo?=
 =?us-ascii?Q?7Cid407tGbG148JUBIFV0QFme6hfOYXjQFDFUdK7bRtClcLjdHJ6QyPb7TeX?=
 =?us-ascii?Q?Vk12DQ0unTIMlpxl/5lMBI41Ke+/scG3Mj9AjHU+muRpCgbU2SGd5anQ2XZ4?=
 =?us-ascii?Q?KDfQZfdd1iC9ULvn2fnQTl8jkwEJmEkc2moAK+IgRaF1gE49lvizUbBDwvEp?=
 =?us-ascii?Q?BISu4ULdQjbZK9KjyIInSNQe0ELCfTc83zig9a4A+KYsIzGX6lY2licX4HAU?=
 =?us-ascii?Q?hpxXOmhi07QbhMkdx2TlqtntDOcxoFL3CK0Ga6+CgvnB+AuV0xSWgqKUTY5v?=
 =?us-ascii?Q?uBCVcKWMn9gu9g3eg7O6xja9rzRmrmi5BfmmvsdrdnYlSrlUSYdhStkh2blw?=
 =?us-ascii?Q?8tjEX/kx0LqFDwvwP57ym+cn9b5BXiYVwLFy3mwwlrZGYWyERvGYMMh20EWT?=
 =?us-ascii?Q?ecO+QBcaV8AH35ghNvvqkOUrA/W016LUZtlH9u+ro0nakBnTpgCHWpj+J+jb?=
 =?us-ascii?Q?v2Byue+g568MVSRaluO0fch7CsS7dm3JQUN15KoU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UlAtwFWBcMsQXrk9507X+XFEnJNGypjtyEwFcsyBtEfFGeHLI0TzNPC411sB+suSSZyQZ8ax+b3tGM71FgMOz2o2ji99QWybWXbAJMHerh4vM00JnTzuBQgTDch4qLiSSiW94qfbL5tuDh/Bl7SIJCmTboNH7905bLksle2v+hpLTq9c+OpeKpZnlKEY9neKo2bwvGVVN+CHw+a6G2yZy0u6XoF1CndHs4yAps6TjKt/Bj22Evv6t7Zxd6ACusbx7FViySJNrnsdrp3B7NgCFxWTH7EuewRBAjCX7nmmLYTfQsn+ZTN+QHCEiXtSTnRjHXimaHltiOnIBdZCMcVy6x69NJze+XkLlnBJai0n7ncON3kAJgflVtOyzLfInCNqsqCB5kvk4lrFp+ODXRZWQf8ATXzbHA/6K6ieDfR2X1ZBRjmZ0rgsy5gnpEMnZ+Z48bj+mikRY/MZ1yacMAHJ21cqECapASokMyn0xQA/kl09a3CE3GXThVmjesZjzcJfVsMIt7avXGKARhNCz78i2p9hK+ufdynkzImkKgi/x78mnt15JRurAYAiLFOqILTs9UT2gwaJ3RvahWBHdgtqW1Oq6Ivc6d18nO0QUU0BS58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf75b7d-c1f0-4d5f-c502-08dd91808a39
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:12:21.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aArR+9QIhQNyedpuG5GpEM21ewpbjn+RK2hMRjhhT2n1DK/Cdlch8cMsuTCbWczXUGZVCDNfrHisz05t4FCr7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-GUID: NsC5gmGHxmlWeuQsBXSCleSl9X3owNeU
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=68223a09 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=HNV-wAe26yvVrFTaTX4A:9 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NyBTYWx0ZWRfX+zW3+2n4vps3 kgKqtWRUrWz7yaePPTUyM0ZcxUeeg1ctUmJJjNX3RVOxDnDt/XMDEet0b129reSuQIEjmccBLeU 1F7l9DS8b3UH+RqkAlr6gBDme4XRsU3MECI1F93jXXS+qies7bK+kJJG/8K/qowLPXmwqOn+oY2
 0pgl4fIwlcUvQTRgYNpPSpAszUx/7kNzQiO9aE1peCiCAexWALLgEXd97qMhvPaMj9nAp+iai0t cUtPTC4spWRxqTwXYLfvKAg3jJyD5TpyII1R1fiUEVf5RAj/7oIcTbsc9aJ8fs87QHGk5FmIG5w s8A7WtTGcYvcvqKyCWjwyhKYP7kRjKCa08+h1guDy9I4/n3nhF+qsvj+z8AqguHQ3SdfRaE/Yb/
 n64EnWHsJ15rPQ8RW9eLs1PUZxoX4tvGhEfpZbhVM+L9aVXo9YTDn+SdADUG/O2i+xWraPfH
X-Proofpoint-ORIG-GUID: NsC5gmGHxmlWeuQsBXSCleSl9X3owNeU

In order to test the new btrfs device role feature, check if btrfs-progs
and the kernel support it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 6a1095ff8934..ab75975e7711 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -1048,3 +1048,15 @@ _require_btrfs_iouring_encoded_read()
 		_notrun "btrfs io_uring encoded read failed with -EOPNOTSUPP"
 	fi
 }
+
+_require_btrfs_feature_device_roles()
+{
+	_require_btrfs_fs_sysfs
+	_require_btrfs_fs_feature device_allocation
+
+	$MKFS_BTRFS_PROG --help 2>&1 | \
+				grep -q "Device-specific roles or profiles"
+	if (($? != 0)); then
+		_notrun "Requires btrfs-progs device roles support"
+	fi
+}
-- 
2.49.0


