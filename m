Return-Path: <linux-btrfs+bounces-4712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0908BA976
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB51C220A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 09:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AA14F10A;
	Fri,  3 May 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hSTVPztR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gZUPMc6q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201601367
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727369; cv=fail; b=h/DxJDmKE9pPm8Sa5N+lsleO/DcOY5/FoZNpIlIe3Hri9hn49qHJ73qvwfFRYfJWbCtGmhLsz7LfPNolt/REMB2HNed6OPWm7fyg058VBHwUYsPq54rRETC1/5ns8QqJzQRTtnWY3DEfGgoB2gJB/+rLGAIhOVpMrLek7Mys9P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727369; c=relaxed/simple;
	bh=B+/IdQJEObC1990NBhSgRtiJNbyZXSgsRCtDnd2i5W8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TnDHBTGxxTs6giagSHJxy4omb1c1XNu95jd+fCH9vQtgK13dqrkbBlvEwrZ+XO/lhR2OZONachB0QEbKLmWLDQlNj0LE+R4NTKw3S+mkj24BmHo9Jlla/ZgBKr1rnBEEaKkCXkznq3oQMuW8iTMHCPFv/6fxHaDSFos04rRhqz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hSTVPztR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gZUPMc6q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436hlsU010551
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=w7KW1k7kYYbr+5dbYoiz0wwCNe+rOkNs+MIKaiV4AkY=;
 b=hSTVPztRFMZW9nUBhfB2v3LNG/GFvqzY9M6EjRykD56HMmSeKmOmOVp6OliWFPjdROZF
 QbHCrZA8A+yiibJ7XURYrbrD+ndGcpvWwUwdWtuflSITKFPSzBM8NRAuQmZNuyXEQJYJ
 62VPT/Tl4LLQQBLqOhrIjo+Uo13Zx/HV7oasWmk1nf2txxCbnKmwjc0JIBWjvGx9EfqT
 9fBo6IYO0TGGTHlHQY4FQ5bp3/P+S/J9kXCBzcApg80p7eDQe/wgl/zW5Mbxb6CvHloY
 /V03oKbGoTz+XKfZ6MMXOMeA4bvds/qfy11WSAByvNU8UiRUJwEAErR8XSm4lTl2U5YS IA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54r6yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4438h2mu019872
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbjrj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amLnjTWrGMDZYe/ZY8e+wkbPSUheRawHl41145IGvT5Yrl7lk/gwQOihW2XcodyYteeJ9y18ra7PBDJvDhQsGvghOwdftf8pDyeUN6iHsULQsfe/0Nq7/V+wPHkhallIF9wrku1dNdXQ2Y3hHge+/YyfmI6Xpk6j2NYaj5pPcHVqorJInQvsNYXRNXntWGQzvqViYpvND+ebQG2aUsOoSOkIZ8HjdWuVocMf9nSUJt8KN65mJRFByJLm4IOF3UX0sa3XQ8nnCYLuFPXzrHDFs0l2eK6rECTvFZOvMVbMfs06AUCulY1PkFAzUEWhT7Ga9vlADgYRAvqINwQZx6TRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7KW1k7kYYbr+5dbYoiz0wwCNe+rOkNs+MIKaiV4AkY=;
 b=EKmSZ3Z/01MtAv16zxLGeIs13MZtLz5nqBI4zNfrdX6GV2c9hmmmd6XknKx6snIE2Z8Hwj5fqFlIZbyai8CcOKTwSiYHj6efWZvkPuIh02KxvuxfAkA+PZRPZs0ZpBnowcx0szKr39NBhUMThHyaG4O8OJHsLb2DwnseXogJ5hPbx3LcusK/vbZ9rzfpqQpoeg02UD+rvOjNnSIcVtB5OHZvuDedtOk8r5dhHjlG3gVQY4AOvUx5vm+JPa32x7JB0ufreXtBvmhFvsXagBmUG2KLk9GYzrjsm0HqDB9XOHLfTXHVs5Qa624oO+dCYcP0+WQCTi+vASX6swX45XxVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7KW1k7kYYbr+5dbYoiz0wwCNe+rOkNs+MIKaiV4AkY=;
 b=gZUPMc6qpX0v0rUmNaCSf03UKDyTyQBOzaGMEgfg2Bw1/sBfXcC/p8+w+tatY3C1fEEacfV4uVCiskpAxBJgBwq3QQbIA9hsmcjSvW295rhIIfaT02m8sg74kSbYRMwDJwFtm7NEed0gFrR4Cwd4zNuPdpBEfJKQNsFPG5Zxn6k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Fri, 3 May
 2024 09:09:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 09:09:22 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: add support ext4 unwritten file extent
Date: Fri,  3 May 2024 17:08:51 +0800
Message-ID: <cover.1714722726.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbabb8a-d41f-4be4-44f5-08dc6b50b926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6luovY/IvH8uBAsrGsv04iO/wZgRZXiVEae25b850ZNUpHwFRA53imc76OQh?=
 =?us-ascii?Q?UEEBJYTm3Y6DMjjeCiW93WhT3NDKfStr7uVUZJsAtMaCiVPgFhezPpNFKHqO?=
 =?us-ascii?Q?mBmE1mfarukjAXrKA9qTTbN0wIg5hWFaeyCyM1Lm8khdH+XB/U05kYoxuCgF?=
 =?us-ascii?Q?zbLJwiG+lUKOmpokzQNSGGqV2SO5+S99FaA/HXWFmMORWsgNnW+kCDfC4jRF?=
 =?us-ascii?Q?E5BTLPiQI9l9k3NL7decMhjManRTEoqx9Fo2urwOsLpNPIfUxzfakJi6pIV7?=
 =?us-ascii?Q?RMqc3Di245vI474RCwdTGLTWFAQyao8wjWehv4G71ovloSP3siUgp/4j0Smh?=
 =?us-ascii?Q?KXZOBb1MbjuANZsKLcGp2qGaRem/8nTd9eHA91kHgXA8d6S0M6P0JHPJauuV?=
 =?us-ascii?Q?VrGJZliuJjrkteJ2DPSdFkUYNkC2ZZlb3MqDMxoaacg35ynQ5BtdQX8KrxyZ?=
 =?us-ascii?Q?U6TN3rZDhLiUpLPSw3NE85dGsq5yyf4kYvNOCrm03H6J+IbTClykdv8lfS+S?=
 =?us-ascii?Q?VTwzGBpRUMC9S57DjZoXvtLmhEmes4c94/139iCzrF6FTHqo02d6mpfaFirm?=
 =?us-ascii?Q?3nPMg+neCvz10QIg3K8OCKDWS1O2Rfhft3AhQ4aXUzrLdKTG5DwqZeOsaLtD?=
 =?us-ascii?Q?8AYdQePEtoFcbknsBb1c40PUIV9O3QBTmGJfzzUFc8RecnhA72CUw0OaJKxq?=
 =?us-ascii?Q?CScHCGnCX67yHhfq0fVRqapGgfK1tJTJv42+zyan993aIzYzg5W/lFI01uSC?=
 =?us-ascii?Q?onyyCdK3dAoGKr3o4JCRI8Ma11rijj3OKQM0ZCo85xzsbr7aV3LhuhQeWhTl?=
 =?us-ascii?Q?J2FWW7GXIo6jSOzI6H9vY70s99AmkoUadhC3Sd9cwqHisbbdxkP6CKQEbzwi?=
 =?us-ascii?Q?cuZ2B/trjga3p5MAVHDayb4Ao3KYjYpqn5fej6ZHfhjjZLIghiWq+O42CjTc?=
 =?us-ascii?Q?TbLnSvzXfMcmnc5zHIhR4vdWI1nMa41F+B9EtD+Op25rVQF9fDP63KJZzlUH?=
 =?us-ascii?Q?L0wTcVllvTLtFP1U8J/CMyzoG2hOakiXK4L5ZCbK868NnJH8i9BtmnDr8dfM?=
 =?us-ascii?Q?hNJS+QhNJLS/v9T4iaGgLXwkJHE9YdhDbYIaNmCkXe+da4UIA7CesNejkH6k?=
 =?us-ascii?Q?IR09vPgyHDdmH52fEUIY7950JRTkl0PqKXeU25haJ/rPy5UResNvbkGw2r7P?=
 =?us-ascii?Q?wuwRSImzz6H/6g02XrZijNSfIVXLgfCvIZJr2c+1UfM4fkrEtAcLhef0wY3c?=
 =?us-ascii?Q?5jTfkxJyAlYrCYGyuObslMYaI6uSlo7Bykf8amau1w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TKjArVXEcao1mk81g4G15tLeN5RJ1mz21FjN60pCJq4RmXQHmbcr7tWp6arj?=
 =?us-ascii?Q?8iYl/Zmoy05m/KvsCrISQonXO5fOiTH3/OyIVTK2hrI7fMqt1YfZTsBwKvrv?=
 =?us-ascii?Q?vdxJlVhNKB/grMScxekrMnMYycvH7YLMtTt1vgk7kWsjcSxgMeg3R6k88uTv?=
 =?us-ascii?Q?+U2puUho2yJ2QCjFHjT1imlEHsU+kEC8RKTWfgIfC17ou1xTvn1BtSxJEA9k?=
 =?us-ascii?Q?+QE/kIip0hBrBh+o4uVVihn8LtNScK0y8pTdknTQwVmg4anKoPrmgATB3TaT?=
 =?us-ascii?Q?j5a9apmlBNHZ/0zZk2SFccqHk8MpzXRxRhCRUM66N2Y3JymlXAQgjtFowUyV?=
 =?us-ascii?Q?cxb/1XkDYwE9Ax4oexuNhUtt20RBB+y+vR0M9Pu23qKHxCWCcwUSeJJvp4wo?=
 =?us-ascii?Q?vBzc3sxB2kaADZrdhFYC1VAbZ/9SfI8Ba9IR2HfZ2PSH+LxaB2hih9Y4dcjw?=
 =?us-ascii?Q?MvYMzLuT9MNYa68IuQ6WFM3fON7R/eoNaclFHIvUY7UV93l1qNR7R8rsztni?=
 =?us-ascii?Q?31Npr91mHaARV5zV7vtUmU+S9WP0LsGTID8/dHubDFZxGQGXazM+eeSR4299?=
 =?us-ascii?Q?Ki94ClfVHmEMRqc6MxUGi0RZxLwduS/CLoigC1hcB9IwIrS0rDXymiFTj7SN?=
 =?us-ascii?Q?yDTV8FG+Vqn6ZFxxaknlbcOT/70YP5xa2eL5Xo93YGwummIZC5QLq2nRDDbG?=
 =?us-ascii?Q?sh2euFsTDy/H2ie4X6NutSh2s38tO0Pa0binkCGer4D4wRGrVNs2td7K/pH3?=
 =?us-ascii?Q?KWXkx1/g2y9QaGmww3Om35Ors/4QpiOzDC6S+FZzvNFKZYoOPCod2HLmS7LN?=
 =?us-ascii?Q?Dlr8Waq5/5kBCO+UaGcZ62icKm9wNQbTrofy/zMmFAGZTaTgwXao6N3nOyBV?=
 =?us-ascii?Q?Gfdrr+uyH4SZTtKVamyCmeEy9miGqoIpZD1O22+yYrQjXSTYjbW92QXa3viX?=
 =?us-ascii?Q?lBsqU1ut9r9V6K+CQkardnLcxeB6WFwEDqpZVZ/Y0O5uhYQKojE7FevfDvZw?=
 =?us-ascii?Q?TmF/WnVtKfDeSjUy4P/OCzx7FQxqJEDGSXgEWE7K9y9LYqzw2aXB5IcHVnD9?=
 =?us-ascii?Q?cr/rv/dAEd8YmqQIEFvXHU0wgnVDBxnGF4tk0mUnDJsN757Nck8XQydIly0P?=
 =?us-ascii?Q?uAvvWBJ8dtqXqDv1ZgAu+UQovCroV5PSrfFcgYWqxTld6r2RpNirg4kcdzkX?=
 =?us-ascii?Q?JoOGaznR6kn70jNCJ9UQM7XGItTFlMFRfrp3meACkgO4B0cspZIW5ghKrIRT?=
 =?us-ascii?Q?4iGue47iiql8atAqAvF/+y9V9NrpQdgcc9byQDHKIBmFgD/cqPQJkEP76qFY?=
 =?us-ascii?Q?zRTHlOPsQxlutVsvbh4CSae32D8sfCKVuZcQvfWzn7IiMAtCUD6Zgpeci744?=
 =?us-ascii?Q?M4lYV2whlpDSe9kijlMyHzpX62iP8XiFsKiSoPxm+ucMbEI2syBshrFohNE5?=
 =?us-ascii?Q?ms4vS0EjMcAqyFE/LXP/qZQebB3OrSJeFPWWLnES/DKoCXVWJkDZzGCVw87g?=
 =?us-ascii?Q?ZWD9bMIJ8lU2vATptHIYH8gha+VoFjPdX+fdddo894oJZq79FPYJOFeLlx7u?=
 =?us-ascii?Q?ESv4PSzGH9lRFt/uxkmrZbtWL57k+d0jG7W6M8SB3sf29sQi0yFYecVtzR+C?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s+aODBFcGBT1c3MM1H7PnI9dZ3nXYg9eLaqYzriCm4HotwqgoFoJWgCUugiOENmADC7176SpqhtddAlUKlhFR5sz0e0NhGDw+LMBq8qt/+V5UyN3PXqVUsXJ+q1ZwH1i1T9an5BaQnlHo1Kbu/KQTTk+GZ08XMfhq5hbaBFnpVgZMhsyo6c13t3IY6UrSd+PfNYqS7s6K0dOCS9OBVOdAoZrwNqouV9YLoOO2DKapLi9p0VQKDbwIRfn5Jnc/G/K/Ca0/ktbMDFsKR2mkzc6KTwZuYhm+G+3ctvf26eIulxKV2K4bgr2nWsznJwX6G81Fs2PA+LRrCpP0DWAwNknxYAL4ZEbGt+e0PXK66/VTbDYJtNYPks3S/hODgsu9lFnxYBg4PPb8lZ333Jia0Jxqa+GqGlyfPryODSTIsRM5ZacGIKJb0NWGNizqNuwDYnn9lbznHepqssx+iFt8NOKE2QAkkzuoJhrnuChjottBoJzFqTF/Wc9xCyt0InhPggYKTI6ts9a4GZRMr5fzSsU2Yp4fvxV3y9yRepqQ60XItR1NTBLmrfFWh1Sczd1gBD3RArEcKnepd1d61k/sQ20es9yG/a6tjHJ6hNxEDsWyuo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbabb8a-d41f-4be4-44f5-08dc6b50b926
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 09:09:22.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbKQ5oDWFEkBKrHSA7Rfr8ln/PF62mFFCI9zu1abtGIyQW0wudtzqLX8QU8e3WX8izz/GGJ5510O7eWQBLqbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030065
X-Proofpoint-ORIG-GUID: z1dLp2zzihFf84Ba7xtUwTaA99GF1MZD
X-Proofpoint-GUID: z1dLp2zzihFf84Ba7xtUwTaA99GF1MZD

These patches add support for the ext4 file data unwritten/preallocated
extents. Patches 1-3 are preparatory patches, and patch 4 adds the
missing feature.

Patch 4 is marked as RFC because this patch is tested with limited
variants of the file extents with unwritten flag.

Anand Jain (4):
  btrfs-progs: convert: refactor ext2_create_file_extents add argument
    ext2_inode
  btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file
    inode pointers
  btrfs-progs: convert: refactor __btrfs_record_file_extent to add a
    prealloc flag
  btrfs-progs: convert: support ext2 unwritten file data extents

 common/extent-tree-utils.c | 11 +++++---
 common/extent-tree-utils.h |  2 +-
 convert/main.c             |  9 ++++---
 convert/source-ext2.c      |  8 +++++-
 convert/source-fs.c        | 52 ++++++++++++++++++++++++++++++++++++--
 convert/source-fs.h        |  6 +++++
 convert/source-reiserfs.c  |  2 +-
 mkfs/rootdir.c             |  3 ++-
 8 files changed, 79 insertions(+), 14 deletions(-)

-- 
2.39.3


