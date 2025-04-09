Return-Path: <linux-btrfs+bounces-12904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A5A81E95
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C336F885C6B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF025A34E;
	Wed,  9 Apr 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QRYFOb6u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k4DKE2OU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3925A625;
	Wed,  9 Apr 2025 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184695; cv=fail; b=LSozue4FzgY31t4v7fmb9xtTID88di4Yle5te2iksUwEh1Xff5JriQb1P7oD+xW2zRZ6Sdy2Myqx3kWvG6h1yAj84ldl302nYAH3cwNBb1CDWgMeXGzdzOGdR276+/kjtcpdsnBT1GEwJ5073nHOKsi2cTi0YwscvDsQV2ydPbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184695; c=relaxed/simple;
	bh=sbmoFw1Q5e7/W+u9C7gmi+IwUDhjwwQ0S5mXtUCzjHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VnXnoVaFS9bliBysDZP3MNJKn6bnhYyDl+LLmttMcvLK9Au50HL8yaJM7/fX3b0RpBiVs5eC79pM/JnctxuQJ7HC6+j3u6m2r18YhpYUdGaYych6jEQAaN7al8U1QCnuptUBp1kmd+39AF2d3QfiTkO0ehDH6H8ULTGr0AAaj3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QRYFOb6u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k4DKE2OU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538LA1Ld004252;
	Wed, 9 Apr 2025 07:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tmXCy6Ks7zkWrv1Jjwx1oInRgfD+cxh37IlVXLIoob8=; b=
	QRYFOb6u/fxuWqKCoXTS3qzOplKv9Cw6mF3U+W8JicCgaDmzqkrXvfffumEhBncN
	ZiS6Xyp9rUKdLIiA7GYEpbR98OCR8JW+PUGbaXXzuQcLNgE7wWc6Z+tNZkThsGIl
	W6WcrALQmzUCXUGnIjztWCXbjySiE14jo/l5MqQ5mrg7tXNietyvmlHypwbYjHru
	fFg1U28xZw7WJhEwlAjrPvndVPRC20YD1la6fytdDmv0CicoidrUEF5MuPmEWc14
	EV2JkMqXd0XREdPLDTg5I+CrWYi8Jgd+/jTTbvl7dQ62EyLhFuPohpxv1R/iAsFs
	vSBE+hB1WxvvNeU3sK/jTg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tpfye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5396WscU016144;
	Wed, 9 Apr 2025 07:44:41 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyaebef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaI8dOgI8HBt9ODdOIzbUl/qJTSQUtEUU7ye4dA0avpWsBHVK6mGm5pLFATubt+PvJrUfxBd1FVVSZBMoYCiCt11p4Z2h/BHdSDVRoquLbecVXykjw/lfectNhq4wd+gsu2DgOon0LKOQPzJzf3DyIuUGpKR6HP8wPG+3u4tH32L/DXTRRjnlNumseuU9fjqc46aNCHvxEUQv11bDTcJF6DRfczs+MvwauHzG89RTisdR2TLTY4sJx/Y89wiz6qR9uYAQA5wsD60iJTotJqzW7oTJGZFXZTdZ/X8PDJnzwmgpmBjs5YZycd+O/thocTKoTMaCFOf9hT7YKfnqqUfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmXCy6Ks7zkWrv1Jjwx1oInRgfD+cxh37IlVXLIoob8=;
 b=XR7+Klyr1HsYZPWc5/NcTkmqaTUvR7Ir0mDwBFrBhsuMHbHVBTspNLrg9YEU0R6AuhGT/jqwyhtF2WGcxUeZ+BfuVEn2gUVeNSXwpb85JczKQbcwY+OYP+OREFFdPeZPJ/vVN7YMmZDrRgrlfeRK3u6MMWfnWrT/CJF+EY6zEOcbGoDGj1N02F0qFhj9YK+hooku87WE5cYcXzrIOCOxAHwJs6aNkkJe96+kyaZT7HSgQ4gXycFJhtinF+vtddc9Z6+SqrWUkkoxH9hqvhoBi/nm+xU3tgb9CI5MheqH4wSg05O9ez7oRzuZCXP0iHYVT+D+tE/rEbJeepCuGARwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmXCy6Ks7zkWrv1Jjwx1oInRgfD+cxh37IlVXLIoob8=;
 b=k4DKE2OUi6SQSiMXrW82mVgEvDeINNZtRX6UoX06EhB6igXJWZgehq5thK4D0k1UoAGNDsS+dpheAZf9+ypwlUcWBDIBX3JWXECVh2j0GsfxRKObfxkk0PsqYtF2Nu2/yu+ejC8N0xtyGs14rcB0SqS6FBi1JNTvcWzcxnzfsro=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 07:44:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:44:38 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH v6 4/6] fstests: common/sysfs: add new file sysfs and helpers
Date: Wed,  9 Apr 2025 15:43:16 +0800
Message-ID: <10810a81ce8a15a95d3b4653f65ef2b0d57c442b.1744183008.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1744183008.git.anand.jain@oracle.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c07c04-5b41-481b-4d53-08dd773a6140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3jAeR/O0wWae4J5kAw3Cg9ex1/ZA50Kv3uq2Lp9471TRWUfASJCFDMogveOB?=
 =?us-ascii?Q?dkzeNeAu9/TrHHslYFvpIuGS1ypTi7F2IRneLThCuxS0jFaPvuUGr0NLvpWO?=
 =?us-ascii?Q?btS0iWwYNZzS40FmsobyDgP0eN+kW+9n8nv02QFzpDbpl+QaKqHHRLivh7ll?=
 =?us-ascii?Q?y74hUBOxt39u3V4S1s6EMj7bKFYC8A9DmbGpUm8/XiCOqc5A4ZqUfhfYBGGL?=
 =?us-ascii?Q?bYsLP0gu2KPaAvaRNpcXKH0mNz7YhdZrCtLb5TREZuNsSoWrfnTFRB+Dhzv2?=
 =?us-ascii?Q?cBk3lnVjXg+uv0J1ZuQMewEaXVA0YSXj7MPxQ1Fzxl5gffauIbbl57md2SQ8?=
 =?us-ascii?Q?8//o8ubmHTAcz49QZO2UYMyWPt26GnSKXw3rkwsEUZSX0N514sisyrMb7CbB?=
 =?us-ascii?Q?4Dc20gqAIs02LYOSIysBmCDS6+yF+u7HhLMvvgoP1JMNPLH8OQHYmQ8lSlrK?=
 =?us-ascii?Q?3yHmIlgCMmdLdbbRsd4412ZyKRbDo0IfLwm/98IxwpxXfskO4wc1gnsI1+Fe?=
 =?us-ascii?Q?TYKV6MwuLoyYdE88GUiZndMp1ylRalSEg3dtcquW5FCc9aqjVjXqrwiC+wSs?=
 =?us-ascii?Q?IOUc84cN2c9I6FsUerXGYAR1QO59l60Emsr3QQQuoiv1LijSjNZGlDYWVzNl?=
 =?us-ascii?Q?F0dt0H4p07xLgRYJflCgxPg+Gmx/Tos8pbvLA+E+glEBMrm1xJcGfyDdAYpo?=
 =?us-ascii?Q?l85CAXSfPvBaTwkfAv8LSWX7wI2yUe4ruMXTyXb49PNsVUHiCGfvpcerT6oV?=
 =?us-ascii?Q?0m86ATioAsojzW0nebj+NrtzsMG1dI6YxAGeLFX+7IAr3OD0zJdtSKq6nZhH?=
 =?us-ascii?Q?AO933jncpj1DG5z6PW4p+z1vLV2VQTB72thwyGsNlDEkPHsOxNVo/B/wF6tt?=
 =?us-ascii?Q?8axqwCM+Cdhg9TWzFlw9FXArLnHZRVHT4UQojIeVX7Rs57VfjzXzxxUwy1Z/?=
 =?us-ascii?Q?r0iNpF8kBp5Jfp+2b4LvOhS0gMkuDoLLbYOtzRIuaXEA8V9HHOAGk9jgo1D3?=
 =?us-ascii?Q?4LLDuOckCNo5KX1T0QJ5JGvWcv9UGa9vx+QwuWQacLLkMNSv7fvTfhmbgtgi?=
 =?us-ascii?Q?gTCPDG9+dCZYiyqPwzC4UJ99cQ4sjCT9gz2tQo+1PJv91j9OWWKdiyt7+Jv4?=
 =?us-ascii?Q?ku4jil/VdtwraBeS4W5H0PAMX8t13CNaqTU4fCwhclR4mEeCGcnQoQkuhWCH?=
 =?us-ascii?Q?0yzRJm2sU728sdeTDTd3OQJmGH380h2Fs9wP3OynF7jisa5UcwQa+HCT1Vq0?=
 =?us-ascii?Q?OAjGHEbeggEACEPhpMbGoKMdk93Zpbzft7GgEKSUGovffw4Uha+1sgisdYjz?=
 =?us-ascii?Q?0A2eU2shWqv5aA5KstLU6PzFUPYK7062ESYDiNRleV4E8NLCbNYkJrbzDQJ+?=
 =?us-ascii?Q?VvSq+jj+dBzUUArU05SeT4RA1yOu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBoU24gjwxTPWJ41vOXA8gxV1yeeRhqDDrRuro1J8ebBTUIzxdqzN3pub75f?=
 =?us-ascii?Q?cj3tYPHxP2Dd3lcbNXxN11ZCrq3x7gpMbSLuGHp2Piim9EArH0u3b2edG7As?=
 =?us-ascii?Q?saKYRYQXYV5UqRxnKo+TzUy5vmdMuVovoP5h7nRBiyFXF1ga+5J5+wOMJVWe?=
 =?us-ascii?Q?Le2/CbEgiFZQMpSDvTjL17fxZvbOHweBl15+JoZ4+aP+XD6oDzBECGdoGrgA?=
 =?us-ascii?Q?WoUzglCW2V8ChRZe6U0cENf74JHmqR2wrpJ4jpXxLIjR9asXTw3KTGlDPyGV?=
 =?us-ascii?Q?r4KmqH/91ZpEg3+qH06s/z/P8RBAtV9v0gOEaCJtfQ9lv4Tm2bT2on4r665i?=
 =?us-ascii?Q?3nFhEr4ZvemI6KhONzS8DwFgV22jANUhOoI0Kgb5RXwM3ojHCp2NEF3p+YT+?=
 =?us-ascii?Q?5QbpLPkaaI3n9iZZ6A/k8asGiNEfVcgRiZOgpliVIVcgz59kUnn0ZcSSDsYl?=
 =?us-ascii?Q?E5mLpOXNfTJA4Hkvh2F6/wOtq/ZNKQTL3ZtnI7PeqoI4JvPBef3FFdUNpR+W?=
 =?us-ascii?Q?XkSr/FPimAB38kpvbDzrF6GLpyAD78gJYep1RbhR06NhnNNDn37NUSCLLRvl?=
 =?us-ascii?Q?m+2mKJU39rWOkL3TeYlIVyHLyQjLXdKEqVTA4MUH3otR0Jr4eXf6yYTAdP3t?=
 =?us-ascii?Q?ZuRKLUu9Xq4nBZVP6h5DLMXuGx8lhoUQVes6q4IVelw0sR/1Ypjzg5HgJdpd?=
 =?us-ascii?Q?GnTnOU/qIi1hIXuab1PaFrFSB3Gs5W36R4ks0O6ug2g31/hgdkRjHhADNTi9?=
 =?us-ascii?Q?a7mN++xtDXqaMTvc+n4rQpuqf+P6a/wP4RkCr6ujloX/hW+cKxwT2jmpjqoY?=
 =?us-ascii?Q?a9UL9Cp4eL0TSB6OAqrM4RHpAB4G050FCv6OmTFrYpO37dmdWG6ddsKlfDft?=
 =?us-ascii?Q?62FH9J/xhNINqe0ksaMMrP5ty8HHrBd4TfkTv/goU3Km7xGuoyu+9woj64T2?=
 =?us-ascii?Q?u/4eugf6IbNqq7M+meUspbyFjHDOLRRsLmu+dUmEnGqv4bHs6e+qka0MQVcR?=
 =?us-ascii?Q?hxXPMqQTF419fE9mhmgxi7CeS10hCdHnDqMaggnnSRu0YB8hfdMaq1U9Buic?=
 =?us-ascii?Q?37BrKMzWKp/DCqoXzzW9t+VCtVV9u/eNh0a595BhbvpAkhaokGizg/Q2xUD2?=
 =?us-ascii?Q?fKdpBizztJynrxg+VDaHC8kdHrkHF1Cy8P7rUoOOjAlOu3TzZjBMMyjZxxEq?=
 =?us-ascii?Q?FplX5+r4CcmohBfVxIPsVWd5vf3k3sOLWlWU4/J8WgwvlATrexoBdiTXD7zi?=
 =?us-ascii?Q?XcotkOBVWiGN/sWwAvm0CpY7SCyO6DWKQrp4Pn8EQjvusfQjwUhUWH7leJ9y?=
 =?us-ascii?Q?MfDfPFNoor7PXx50ZkLThc8sL0OHLC6n667778syR/sCh21B25iz0o1sOeTl?=
 =?us-ascii?Q?CbJbxLdBWmNPO/Fw2xOzc4BQbv8j0XVlwtZdxF96PYNEDLrO0ULYGbSbG1Xj?=
 =?us-ascii?Q?XIQ8UIGEtcwOEzsvelfxJ1yJXJOuiYcNPDvboWR0uHe01puAvxOCSv69r9Qb?=
 =?us-ascii?Q?kaJ9qSgLolcJDpfCCwwfZ3AVAoriiGgPZr5HRKiXHA2qARWO6ZlN7yznmycI?=
 =?us-ascii?Q?G9imifHWl/66t7VSQGH4kAwRlVBcpIv2ILLphIq1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fiiOmJceofCXT+aMheiQXml7iR3nqicdrI0H84EDh4CayMfBco+wM5yD8dCDZrK/4cVif8GZd3MQN0O6v1Q53usNpISxPdeXD3QaZNN5Be9DIAVIiX8c+HUFsx4l+0YgKpyp19zf+oQw1Yl2Rm0xAuF0wCGBJX26QfpA6HtNvnWErOGQdEzFnv+4yEjyo/uNk2MxUP/TIKNMdjjQTyM672iGw9EUSmB0t/3o4PUTDVTizRiouRWfmRerYQVy+L22K3q2ngfQDfZrYdKGxJER6C0hpRY9elY9mU+G3yK2lmN2JTME8E0wbK1LTbc0iM1Ua6iyc50TX/PfyjXrwoNuiosx+Gz3USCiGBiGZvnGw+4Jl0ugGV6VaqUW0fdsgwWddnafpLpKeh4KUuxM8hwdTO3t6GacQwZC3KEWYWbBUohC10JbShcJO/VZX4o2jGB1EX2DOeSQd5ffjnHcH8zYjuMhNHfwm7KhJvwA1gGdq4NKFJ/urtltzbzHYRfTx76q0U9286IK4/1AJ/jtZsrXEy+CR6D68VXeWk9Df+ruZpbcERp+YAGq3nLfQvFDzNgJzFx3u2izwznAavgcDqymlWw1SdgB1SMZzFPKt1BUjD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c07c04-5b41-481b-4d53-08dd773a6140
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:44:38.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mF3fsbZXQjyRyV3aRj/DJQ2HA45dfx/me+5ffsctck1pp5Vvfjlp2bYVIRjTpqzUuleHdqSUd+2i14p7zWQ20A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090035
X-Proofpoint-ORIG-GUID: FHgMBOfeNPrT9HpmkBYmJ-LpXGI3WdwH
X-Proofpoint-GUID: FHgMBOfeNPrT9HpmkBYmJ-LpXGI3WdwH

Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()`
to verify whether a sysfs attribute rejects invalid input arguments
during writes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/sysfs | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 common/sysfs

diff --git a/common/sysfs b/common/sysfs
new file mode 100644
index 000000000000..16d4b482f9e9
--- /dev/null
+++ b/common/sysfs
@@ -0,0 +1,145 @@
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# Common/sysfs file for the sysfs related helper functions.
+
+# Test for the existence of a policy at /sys/fs/$FSTYP/$DEV/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#  - policy: policy within /sys/fs/$FSTYP/$dev
+#
+# Usage example:
+#   _has_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
+_has_fs_sysfs_attr_policy()
+{
+	local dev=$1
+	local attr=$2
+	local policy=$3
+
+	if [ ! -b "$dev" -o -z "$attr" -o -z "$policy" ]; then
+		_fail \
+	     "Usage: _has_fs_sysfs_attr_policy <mounted_device> <attr> <policy>"
+	fi
+
+	local dname=$(_fs_sysfs_dname $dev)
+	if ! test -e /sys/fs/${FSTYP}/${dname}/${attr}; then
+		return 1
+	fi
+
+	cat /sys/fs/${FSTYP}/${dname}/${attr} | grep -q ${policy}
+}
+
+# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
+# and value in it contains $policy
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#  - policy: mentioned in /sys/fs/$FSTYP/$dev/$attr
+#
+# Usage example:
+#   _require_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
+_require_fs_sysfs_attr_policy()
+{
+	_has_fs_sysfs_attr_policy "$@" && return
+
+	local dev=$1
+	local attr=$2
+	local policy=$3
+	local dname=$(_fs_sysfs_dname $dev)
+
+	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr} ${policy}"
+}
+
+_set_sysfs_policy()
+{
+	local dev=$1
+	local attr=$2
+	shift
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $dev $attr ${policy}
+
+	case "$FSTYP" in
+	btrfs)
+		_get_fs_sysfs_attr $dev $attr | grep -q "[${policy}]"
+		if [[ $? != 0 ]]; then
+			echo "Setting sysfs $attr $policy failed"
+		fi
+		;;
+	*)
+		_fail \
+"sysfs syntax verification for '${attr}' '${policy}' for '${FSTYP}' is not implemented"
+		;;
+	esac
+}
+
+_set_sysfs_policy_must_fail()
+{
+	local dev=$1
+	local attr=$2
+	shift
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $dev $attr ${policy} | _filter_sysfs_error \
+							   | tee -a $seqres.full
+}
+
+# Verify sysfs attribute rejects invalid input.
+# Usage syntax:
+#   _verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
+# Examples:
+#   _verify_sysfs_syntax $TEST_DEV read_policy pid
+#   _verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
+# Note:
+#  Testcase must include
+#      . ./common/filter
+# Prerequisite checks are kept outside this function
+# to make them clear to the test case, rather than hiding
+# them deep inside another function.
+#      _require_fs_sysfs_attr_policy $TEST_DEV $attr $policy
+_verify_sysfs_syntax()
+{
+	local dev=$1
+	local attr=$2
+	local policy=$3
+	local value=$4
+
+	# Test policy specified wrongly. Must fail.
+	_set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy t'"
+	_set_sysfs_policy_must_fail $dev $attr "' '"
+	_set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
+	_set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
+	_set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
+	_set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
+	_set_sysfs_policy_must_fail $dev $attr "'${policy} '"
+	_set_sysfs_policy_must_fail $dev $attr _${policy}
+	_set_sysfs_policy_must_fail $dev $attr ${policy}_
+	_set_sysfs_policy_must_fail $dev $attr _${policy}_
+	_set_sysfs_policy_must_fail $dev $attr ${policy}:
+	# Test policy longer than 32 chars fails stable.
+	_set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
+
+	# Test policy specified correctly. Must pass.
+	_set_sysfs_policy $dev $attr $policy
+
+	# If the policy has no value return
+	if [[ -z $value ]]; then
+		return
+	fi
+
+	# Test value specified wrongly. Must fail.
+	_set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
+
+	# Test policy and value all specified correctly. Must pass.
+	_set_sysfs_policy $dev $attr $policy:$value
+}
-- 
2.47.0


