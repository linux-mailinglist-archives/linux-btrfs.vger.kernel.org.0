Return-Path: <linux-btrfs+bounces-13936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0499FAB4339
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E388C4FD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA882C2FDC;
	Mon, 12 May 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L+3k+fhu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rh+UWEO+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DD29AAF7
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073455; cv=fail; b=HX1LLmErODso7xp9yo18oHDAu4hITEpRLCO9mKMubei6ABuOZdnzdxe3QTkxnRFFCK5EnNbr6HppAyVyn++TNGesci7eaCsRV0zn5PwRPINSq3YYp2uqlbkKaPwxX4V9Ltldgvz+4rdrYh+lbKGD69KaBaKCD0FktWLzhDKecvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073455; c=relaxed/simple;
	bh=VEHZbfRhbU9cjZs8xd3rkb1xqyuzLb6jMQ/bprKamcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/VV7GlzZTr/VZa0/QUMcZI3jbrs/2snYCOZtwrEF0BMQXNT8PpcY0/UPhNX9hiQ6DxLc7opSVjZSzP9r0SJRn5gp1AYe71xY5w5h3SVH+pvbyOVinwHHGXdjNJRLh4AfRBA8SfngqRr9lnt7pqexGfDghhBmiVyAisDCytFV24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L+3k+fhu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rh+UWEO+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0utM015452
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=R9aQx4pk+zJJGnizjog4rsmqrrGgZvVzLKZdNB4Ypfo=; b=
	L+3k+fhuIGNYudhmJAlGZPtWyMPawHpBu0OuyGtz76KmkF2t0Ybf3bWRtErndG1k
	9XwgAWFEKrhUBiOMplYI6SKeaOAqa9XXgCYQtJu19m4fx/4zK/J5PY/pksmPSFrX
	olUhBUdbikCioecpGR1uswBRg+kJ3TG9XyQK4xMVCyCnScs/FQD7Rr2u6GibbR8S
	4X984g6zV2070OUXrfXMip96IPnZleM1wDEeiWYqAtWFmZHlHUwe3pdOgZPHiHro
	V2HgzDTH/DSHvV4nxSdlWegQAAYW324n5Bg7Y0oKDrHp5LHPScZo8RnWuDhx1UEQ
	5X4GRR/52IiONLYPxm8teA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059u8gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CI0Z3e033182
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:51 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8dq76v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9LofhwUfDMicI9l6sGT1kj7gUaB+Xx217rZXAsVVoJvMxyv5HijKXe0R8X2qLp19rwNFcf/4X7g2tnUAD7R3jsDk4mdEKE4J14MyLkgeFrDduIOY7tX3CKnPVrvcBUtdPkY+EIYfNbhrvVHxuwCdR6YoK24KKFURXusR7wH/Utv08gi2ZQknK3X+UNFT0pTpG6vAToZhA2YNuc4Yiypm7jbXhElaOWxTe2kxwMYS2Tgr7DkqknRMcOvZ0pGqRB3yffByuzbxfRc3UFBvuTNX/RnP+u8Mk20OIlCJNUf56hkEDtzKE8vfkPs74A73RwwUDiXZe81QGAUmqg9FtBD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9aQx4pk+zJJGnizjog4rsmqrrGgZvVzLKZdNB4Ypfo=;
 b=r4qWpHV/rmjyuKfIq8QYRnEmCmuXrc5Q+9hNqeD9IqLRtJckFhMwhargCdzmrlCoPHitEAAyScAliGGsUzI6DyjQb73UILGIk5swlHMvF51Oxz7BxU4IZyt3Cktdh0shQI3YLDKIjllpM02ksW5est+R8uUWOB1GbcewCfsMBZ53T741ss2K9UcIAxtwxiPyol1zLbgKXg186l4xQI0hOCBtf95cfPe6ljsGArJgsTRoUGpudAIXuzQ/J8MYtEKGfoSqRWhrrJW6GcxJuE4bZHbvF8jo6zDuO9HBfkH7iwk36EArWXhBZLIXDMuoBfXNwGKJMYShjzPaql2s39+zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9aQx4pk+zJJGnizjog4rsmqrrGgZvVzLKZdNB4Ypfo=;
 b=Rh+UWEO+xTTifPyL9QOWgTMS7P4HyDzs/KBYX7HAb2+J4Jih9u/y9iC1yUo2qncvPtinxLu1ajMhjakdHsTzuIC2TapuutsDOYTz5Yn6AvB3Kze64z4CitSO+ucjXXexIR0QMq16Xzx2xunproAi6bq3miYzuC9/V2g9TgCpyWw=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:49 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:49 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/14] btrfs-progs: import device role handling from the kernel
Date: Tue, 13 May 2025 02:09:25 +0800
Message-ID: <6afa58fca26d05c2fdcf741dc5229256e22f141d.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: e42a5e1f-ea72-47cf-dd26-08dd918052f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8EXxKTHVeDj7U6U0lRLKy53I3bdPdLhq1/+W8QcDumZkBp9I7SqsQkATESa?=
 =?us-ascii?Q?DP0SGmcipekcWxx5bW8OlmcaPBa15DEZy1E+oIBpiOV1ASEafYiUePsWjhuC?=
 =?us-ascii?Q?a405Q2O3wOnYEw11ogGj7qZEA3tHZ0q5jIeQan/kENJRC7g/T0T4AM88sKvX?=
 =?us-ascii?Q?vnwrJqng6LiO0JPZpuqN3kdiQFCiN5WRpoh3+U1uLYIRWThTnJOWlq323O/2?=
 =?us-ascii?Q?d5FDfJd0VAm/Of1OmmL0pRMHJ7KO61chripk16qCN8arENcdo+w8l5kcjCrI?=
 =?us-ascii?Q?aDJ/LPbUzKwtXYe02YYf6eoj6f9oewIJSHt+LHOUjMP9VjgOe1xpWnfZABYg?=
 =?us-ascii?Q?TwkRJL/cFbPpttj7J/J9UWXetIATk8YzSPMF1ALsVDFCTsEqD6eXhSo7lF8n?=
 =?us-ascii?Q?obJgFYvUtG2w+UX7bqulVK2neY7ups1MJxWCI640T32c2r7sg03IoREMMrl6?=
 =?us-ascii?Q?V855ObmSkBiCPuyRgE0JNB3Dzo7d800k7h07RV9VXH1hxBGKaIgs7+r+OmcG?=
 =?us-ascii?Q?4CrYFsbu0XX4J8ZY7gJU8HN9B3TATCmPZhZV9kaoj7rwl1nbtnmv45E4cOnO?=
 =?us-ascii?Q?vJQNjfqWxdvna1kuDKu1wDhDepF3A6mWpGy7+hQVfSkMXBoRMhbNwJuI9H0+?=
 =?us-ascii?Q?Z+M97t7Jq8hUv4IZFh9nYGdocXiPmBLcknmw15HDr1FELJ5ujSeBuY30Lx04?=
 =?us-ascii?Q?KgeA2xN6zXj1hcWaHCsPykktQmi4i/sIEBgRUinlYDhhwaOV62prKFIhwecY?=
 =?us-ascii?Q?e/ccN7QuiFnoj0L9zx+0kSAhJrp8XT22h9/VHqk/xxBISxdVHeop76oa1O6K?=
 =?us-ascii?Q?iu8CNDqzHtPHkdkVfPs3j5dG1FZoVNbrk7DuXiVILw35tIkVW7IeqV7VNuzr?=
 =?us-ascii?Q?3jaUylusSsdcr51zu2ge8ynyCGRXV6BVPB9t17xKHOQiz1E3VFKfdS/xlbxk?=
 =?us-ascii?Q?ZesUBDimo0l3Tr0h1V6Cus4j8c0FlP2Z3cSpuvxAOOPAS3jGmVtBHtZ96quu?=
 =?us-ascii?Q?Tq5cSyjrMXstH6qku9rYdEXpde4WsL4519yIA01JBLjf4bRYdBYhojgT+Mpy?=
 =?us-ascii?Q?stqkTB0zf72QZo4LkWj126JuuzPMTxQkzePetnmowu8B9WVQRNZKOaAaEoPF?=
 =?us-ascii?Q?OmRfhQKEtD3oCdYKKwSVbeqV2R3/58aE5E+bU3VbRLXs/+plxAWCQZeh+V/U?=
 =?us-ascii?Q?BKwRVXkk9DTvBkNaBQOIaaG6v1xtkL02jshbQVei8cK+Vh+FA0A6ZhG8xH3o?=
 =?us-ascii?Q?5vqEnI1NdTf1NuBL/sR4UECbM21NNZrPGbRT8VMa9gNDfWKyDQV+OrZZ0QFP?=
 =?us-ascii?Q?8L5Yp+vHXc1Jxp2qAnjHg5hqbNXKLEhnHDi4wPTllqhb1pHUJXoyZvQsP3Sk?=
 =?us-ascii?Q?mD9nw9Nq4fkwAre9TP6PJbaAombV/aXAoZtKn/ne9U3ZOkgLv4mO3oLICgDL?=
 =?us-ascii?Q?6W0e5ZIbQxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RLmV8E9lAorcBCWO9v4O3dADfL0Jvf19wiBzhsrR0KPl0ITyr7WNOLv4vrue?=
 =?us-ascii?Q?SDzIZzWiEdBO+prCVeNdXYkUxyaJd/c4jbRQRjABf1PTCt1jXKT9/pV4ieR/?=
 =?us-ascii?Q?24neEQdG/g1n5HvIUXeT/uudobr5RPxaoStNBj9dRjWtRe10zzJe5QdNJPS6?=
 =?us-ascii?Q?Hkd4a9qBpROMEmfB0Kk3Xs+Uq9hPE7v+jXE7ocqHv8vJoRbydGo1YxNZj3Py?=
 =?us-ascii?Q?NySPYBI3s94JZ5uhJdn7ravUpdPYbQNaQSdDVeiAvMST7dbdi0a6F6b4nCpl?=
 =?us-ascii?Q?YMa2in/te016oPD+BJzegZcJF0kh6dT8NDeOLpMaKg53noPqA6IzQn6DVX49?=
 =?us-ascii?Q?MBEJPxcX172DW3XBCiUq39Ps8/noXE3iRmO0iYXc1KmoHxDFGQIcSZykbCu4?=
 =?us-ascii?Q?eMVQsRGnX7vvPjVHZdr7JancsOcZSnS3/6C5wQGARJKwIRqk02Ux7mbQnJkL?=
 =?us-ascii?Q?9UiTDqmHr3QEz3A4dI/TNy7kJPz29DB6mHFYM3ecfBWiK8gLKGlr63x5l4ni?=
 =?us-ascii?Q?YHFu9DyRB77McvzWeV70q6Na8aCwCQueaYKpCoxILkdY9EN7DSTnFCvYEgI+?=
 =?us-ascii?Q?bmBEW4inB9ckHDzuzyAy6IAd4ZK2N+/BpfP9ddEEkUsgxzIs6uxULsU3hrmZ?=
 =?us-ascii?Q?EnFC200/d6RvWio35tXWrOCNLq4RMaOBgguHzg3SQbuM2ZOxzFXpQd6arbVz?=
 =?us-ascii?Q?Hr68pcQRhvjvfrDMtw3nL3zztrsX+svGfR2cjQlFFIvzKLxqLcj0hH+G74mQ?=
 =?us-ascii?Q?6HYvkrPfLCitcsjA1nnamDh0rfSlI+qU+2hjevnNJOEkS+0W4W9ItT1i+B60?=
 =?us-ascii?Q?hBykK1tT2VKzCk+apwuFOdo6nl9+cGhGom0QdwkoNmD6O2a4ur4uVWyzVa4V?=
 =?us-ascii?Q?j+B3PQaeG29csHxn3jT192mY0sRwXeHA4z3IUyyQib8P3dmADRO8XerEmHr2?=
 =?us-ascii?Q?/w7zCpdc5AcgK60z8Bp7CfwIJthXX3l5uHFFeqDl2x4NumIcucOGoeWztyDL?=
 =?us-ascii?Q?XIGCJqz/QM2HkHJvPNL1lUCrhUISbEXGRWHcgJ0pSi1T5x4Kr4ubjsNdgHoa?=
 =?us-ascii?Q?c+8CyUzZOtxdjuZr2OREk56O6zO2zcS0Lck1xCJQY64rwcYNSpg+/vVMcxKg?=
 =?us-ascii?Q?6sn1KPDpnvPThWF3efdURLzphAPDYarWje6Kd/jqr6J5MewZ6Qe8Xp/q5hj5?=
 =?us-ascii?Q?Z+PJjER5SOGjgCeDzmMzWxrE9gS/a3eVi1O7ZnU0L/MdMhH2BwzvGdb5oiEO?=
 =?us-ascii?Q?LLp8fErA1mNEJ5LmnW59B7wUIUqSPtyOdyUvAPA2DtdnsYJMroqPmFKlFcS1?=
 =?us-ascii?Q?fFmRZRqmE6ZglqxTbWycc/RcMOX+yWR0IEzH9taOaAypFBITuALMgVI77s09?=
 =?us-ascii?Q?WKvTq739vQp2uAtk+/p5rwcxT3BISQ2kSacE+BpiHIa6lJfHrVhz8YnWVRhq?=
 =?us-ascii?Q?3FgSzWZmqKj91BwxMxcbAxIJkjSTDidd6tBhOp2Kl9icRAfdjd7IURKitGGA?=
 =?us-ascii?Q?OpckDQ/zq2epfj4EL/AdjSpf9Ts0PxLYkpD+azeCB1Kk6vkDhlZNDSlqB8P9?=
 =?us-ascii?Q?X74sodM8UsU2DEob00T+uZLaa1OhRgVX6Ja/uZFF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DpMf/Vzy0XA0eggOmlWymvtL7bv88ZCFs/g0mTLeYwKWTnzpNVvvPVLj109v2T9Hrp2y8xl35kN6nFDyczlHbepvnGvvS42PgxWd17oL5zHndDclTNIRmOreb5ssoPlAmqcWnWiDtz5bxTfIeO82VdozZkECppzKdYuebutju0U+3hj6IUpyFIIZE9xNJyQ2eUwlN4xyydrvj371pxC1dBvl9jszkZjbLTnGy1Q37d3FYZvVZL4ra+7H/511BYaG/YOz0IEgtv908WjtB8CWzQO6xilbGwPzmvtXvaYf/auKuVnoIpQe6w95Z9fquFLf1cAYRfkSWVBwbrBLqx4OivWFBsiTbeyvuFEtwaGTw06GqbmTh1Wp6X9SBGC5pk1D7A3WPgltkdtMG/WDNHNaY/0wxOuaFaikMrQGHdqiB7U7mrG07yVN3Efzc3jI0bihPZ6/VeQZbyyu6aFP57VUJ0f3hTXmVpq8EDzVhw1kIgKgyfDWayjx0Cb//Ofh7klXnB1pzMJF3a28WT5ux9SrHvmeuyi8TqfF+xSb3dF1VEfGik4RgEdF63X7LSmr1rQWy0D0/+ILuiupT9x1nLZ4g+xN+Idbn3+bqE+qS1KMDvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42a5e1f-ea72-47cf-dd26-08dd918052f4
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:49.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdCOnASsCcTXCJ3G6Y/U82vDR3KWGVvHaUuzM8PGzGuYock4visOrmrHDiA9FdBgYwQGj53/fWoUgoPahZ4TrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX1D8YkJudxQy8 +u0kFrfVQ3KJRX8Q7TQi9kjziI4UyjHdYI1XsIxa8sft0YjDmeI8+rzRkaawT0naMnBXc0DHQIR S4sD3ScEgTsPREVEpat2MYLi1KaGBJ/UUA3MsBg3GiKijHvHPgdC3e0d9dczW7xk5+gzg+85h7p
 iaota9Na0Ggru2VgHL5J6+Yn5G91Axk2cfAIZ1a7IDGLW50QRfG8O3v7GixPNXoQMMkh3cUHKrZ kdXzwPKRofU3URpy6YO6GM3iSA4YW46jcxMt1SW9got/z76lbZlk4Om2s8QAxoml08TYFunNT/b DQufJnbXw4wo7lv6h2sxO29H2bxJlAQX60POee17SlYjmKdA1B0wK1NhOQ76J+5Dq0OL0pR6yrv
 LVO12QOsyaL0rrrqsZf6dI+oIUBbNc5tqHvm0zAo09O7QCxYVux+x3/2fF5oX5MgJ7d0F32i
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682239ad b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wXwm8Qw6VlNf2VQ6B3EA:9 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: KdwDCysuJ5odHB9tVj4RhER5gPgtvP2U
X-Proofpoint-GUID: KdwDCysuJ5odHB9tVj4RhER5gPgtvP2U

Imports the kernel's defines and code to device roles and related
utilities to ensure consistency between btrfs-progs and the kernel.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 21 +++++++++++++++++++++
 kernel-shared/volumes.h | 24 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index be01bdb4d3f6..b5b1a53a4a90 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1258,6 +1258,27 @@ out:
 	return ret;
 }
 
+int parse_device_role(char *str, enum btrfs_device_roles *role)
+{
+	if (strncmp(str, "m", strlen(str)) == 0 ||
+	    strncmp(str, "metadata", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_METADATA;
+	} else if (strncmp(str, "d", strlen(str)) == 0 ||
+	    strncmp(str, "data", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_DATA;
+	} else if (strncmp(str, "monly", strlen(str)) == 0 ||
+	    strncmp(str, "metadata-only", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_METADATA_ONLY;
+	} else if (strncmp(str, "donly", strlen(str)) == 0 ||
+	    strncmp(str, "data-only", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_DATA_ONLY;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 			   struct btrfs_chunk *chunk, int item_size)
 {
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 74fccd147d82..2bb299eead8c 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -33,6 +33,30 @@ struct extent_buffer;
 #define BTRFS_STRIPE_LEN	SZ_64K
 #define BTRFS_STRIPE_LEN_SHIFT	(16)
 
+#define BTRFS_DEVICE_ROLE_MASK	0xff
+/*
+ * device_role value and how it will be used.
+ * 	      0: Unused
+ *	   1-20: Metadata only
+ *	  21-40: Metadata preferred
+ *	  41-80: Anything|None
+ *	 81-100: Data preferred
+ *	101-128: Data only
+ * Declare some predefined easy to use device_bg_type values
+ */
+enum btrfs_device_roles {
+	BTRFS_DEVICE_ROLE_METADATA_ONLY = 20,
+	BTRFS_DEVICE_ROLE_METADATA      = 40,
+	BTRFS_DEVICE_ROLE_NONE          = 80,
+	BTRFS_DEVICE_ROLE_DATA          = 100,
+	BTRFS_DEVICE_ROLE_DATA_ONLY     = 120,
+};
+
+/* Device role value range (0 to 128) */
+#define BTRFS_DEVICE_ROLE_MAX 128
+
+int parse_device_role(char *str, enum btrfs_device_roles *role);
+
 struct btrfs_device {
 	struct list_head dev_list;
 	struct btrfs_root *dev_root;
-- 
2.49.0


