Return-Path: <linux-btrfs+bounces-10664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9BE9FF4B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAE53A2827
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE41E32C6;
	Wed,  1 Jan 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHfRhZna";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PpQHAOcT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D933EC
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735754998; cv=fail; b=Ry2xBpCESjKvMz+egQz+sxunK3Oee7FlUHr9EuzmhKNKwCbhaQvX/eN85gO/Lk3oNEWYAY47A/00gjdvdmAU9MmKJwZwnQ+tXedFda92JQjT7PINfE1OYLvETIFMtPJClzrNnbuo00uhSIQyI5bC1jo+N1jJtRiyx0QaOnH36OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735754998; c=relaxed/simple;
	bh=R2BCkGML/AqEr1qSZ5unJxjAVDJLl0H8bnfTWh2ttlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZ4s60Zzie0DnkheGIqGu5EDWUAUPlOFYUkuq49e717wCAaQ3VrLoklDvmvCImmRe8CD6TcVQ7QMVa2FQdnPyUqagvjvQv3iBk33op8cZw0yvH6l7dLCKY2LKYMjkdlhkcodQFEj38IJzUVqNnLHVxc1K2QGGnvgxUvDAtbmgMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MHfRhZna; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PpQHAOcT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501FlJc1004980;
	Wed, 1 Jan 2025 18:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8MT7Fpd09X6igMXb/b14ECG46Fa7rDsL6SkenwXXXEA=; b=
	MHfRhZnaTTHc2P9zyE3JJ6TJOWzhkR7/OqW6sfpQZzof64/fPWRj9Ba5SgD5hlhQ
	SFNt3rmw366dfW8EU5eF3TFf+KO0Lld4dsTJjk2yJEd4GYI57BIl56zeO8pvjG5F
	np6GfgWiBV04kTf2FPxEqkKzCHmJhS6ZbFSNLlpK4KlQVrLwBcASKehkcahz8tXG
	/Tuml86lQgLLbMQQhd6SgX0B88Vjw+gQxkVx5+h360QOiKZv65v0gNKPDno3XivI
	cG4+w0inuosPvgQPjpvYTs3P/lMuLUIMbwV14oEU3LfWJwzyWyBsOZITcoExJfuI
	NMi/wBVjbIzdHN/vTy2y+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t841vg6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501G3hss012965;
	Wed, 1 Jan 2025 18:09:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s7x1yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+AsbEuiW6+GrQB4D7jCRivFPjAzx+rCxjTMTHKC7OP6B9ZXqrk2hcv8sYEHWeXJB+NOfviSA3T+jRgDaQXVltKDtwkfsQIn3vLmWDRDxn62GdoOm+3LR+waNBb33UUc4OfmvSSJz2aw6JtbATNn7/A60NPJ4G8RiL7TBXeOHuPetXVhy0Sh8151AD+/xhgVy/UyLb9yM7jX6f99GLUP5QvDlY59AI37/QbnA1zor+qTJ75nv2ZAxFvF5VFmgxs0GRHZf8Fo+1S9OPM+SYJ/V3560IznN9cpPEKtnOYzB1SvMXUErWvBBcn4QEtM418nkWjgacX3y8O9gkwet0N55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MT7Fpd09X6igMXb/b14ECG46Fa7rDsL6SkenwXXXEA=;
 b=pHQBf/uxwbdkYAKE5P+pt7dsudIdmxs6TCJgE7IDxIl+HMvalk6pH4DtNz8CyGjJdY7qGswR0M5NCn4alWqN1JjW4C35A7PNFIh7h3ZnxjK8uZMbXwo0b4Rg3NawIdavLoLQ/JMcbVZK957xfoeAHQvrEdx1OjL67YFQcVUd9q9TtUQMS9hv45LWXww014K8ZY6ZKNBCtIHOd99TJpEXEIk0Poq+rXYJLl2UHN8GfMR5Yl0/MbJH3WnHbh6ecgrO/flrLyDg/fiY+jDdDKLGLg2ALryjDV5QKEjTM0HXDPwNKjnCTC8/AVzmLNnRQzMK5bgslFJhTfDSYaDgd6tqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MT7Fpd09X6igMXb/b14ECG46Fa7rDsL6SkenwXXXEA=;
 b=PpQHAOcTbY8vDbbOIGEGReiIUMR5GZ1PtEaljDo+tjv9fSN3EoZDoNIqA/AO91w3nKQDC5tY0TdJvwbdiIsNEaOGuWa5iF9gyvYXzZQp0Io62DH/8hZfuBD+7jzV/usOAJzAZl5kbwl+1mKDu1Jm8KkzXgCxWJIkidz4fRO+I8o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:09:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:09:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 01/10] btrfs: initialize fs_devices->fs_info earlier
Date: Thu,  2 Jan 2025 02:06:30 +0800
Message-ID: <3256aeb56d180e3becaf5d05735cd2fa06d634c5.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b31b90-8161-42d0-e971-08dd2a8f71f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMJq/6C38M1xVrQA4eT7GvFv5EqB4WPZuy9BzYCHHR/7mm6CTWo3hzi/lfKb?=
 =?us-ascii?Q?abaJ7ZVjGXe70pL26TS8FkyobxlQjMdSV3QNkF2sSa9z19E0KO4IiqkP6zoS?=
 =?us-ascii?Q?tmMG1eR6kEf2c1XSNeGvKxWXCdXIvXl/BnMSFCQSYOqYLDEcLSjqJBNL8gsc?=
 =?us-ascii?Q?shCg31bVFskCAOkuRVJ2MoM/WDsvWUu7t5Z/zBFT4nRnz7R/X3nx2FL/KDv3?=
 =?us-ascii?Q?PWgilU1hT2cQiIHC3ZW3zgQ5IVTbfKtBNb8ECQvANBMYleoG7uXJJ78//k3N?=
 =?us-ascii?Q?SoUi0ARM86Us+YALN67631K7wdXuZNvvIHOqqycT3BeJ6q03W5PkioCetOzZ?=
 =?us-ascii?Q?8YLAicMHCIMGL8KNz+4vymZbs+YOPT8bGj3K6vDIkIm6OmrgrvD4n6n53uab?=
 =?us-ascii?Q?6YeuMiNqYRhldwlxM353/zb5ZlvciA3BM9UKMO0RNB01uoMApwduXvhM5aAY?=
 =?us-ascii?Q?XYUVy4Aq7a5Kf7iJjuN+ybCbZ5Pf9p3zJaF9/jmtILXPUInXpzMFWBSaFANc?=
 =?us-ascii?Q?IR+23ISlsbMirJCcQt7Dlk/Ygg+gBFN3phq3W9g1RSnLTKyk+Q8A1XRWiQTX?=
 =?us-ascii?Q?JaQb+BPodIutXwRGlqxvhh2m13UHHXo80zkSwe4R7tHm2Ewl2f9gfNCBBlG4?=
 =?us-ascii?Q?Ea5Wp3bv9KVheLaw+t7vjfDmBokPZQEOTfM+kT4gfFVHFmItlNDhuooU1tZg?=
 =?us-ascii?Q?NkINgt/02qjSA3e3C7vO8xYzwoJV77vydz5MU3HpFgCGF9MYoOv3nI+s/hMn?=
 =?us-ascii?Q?LC3yXdrciNhRPZ3Uq92TZKaprvArDCgt5IFmIXRfRnjgZBgZ9xuiG52zHeCZ?=
 =?us-ascii?Q?TGkGvSwfupmn4xREWdFAAT+XeH8q+619vpTIqpgGufMfSjZw7275BBO/aXF0?=
 =?us-ascii?Q?gEv+/Yl+YgDHpi34VpKPi4WzCGqe8meJAxBbMQvsXUVv2fMO3XJb0EW7mJzA?=
 =?us-ascii?Q?fBIUMhiKR4dflO9E0lh1g0n0QsijOB3EyuHwuL1SFhU8J0IxW60ziOe2zzg8?=
 =?us-ascii?Q?Q4sVcQSBdjXdL03rCRPikLK76fjAC6RNJRjWZ3o9mXPWo6VLWI7wcNdE6w25?=
 =?us-ascii?Q?V/ec2fHPKhe4w/gwG3JhQ+q7TJ8HQlk7sVcRC28CSp36C/fv4MM04VupBwFN?=
 =?us-ascii?Q?VAhb7D304n2iNTieGoTGh4Hn2CqjXxlk3gd6NJCW4jw6WX/Z67YPf/3+Q6Cr?=
 =?us-ascii?Q?cRveXaTo3EEBOGlQLlV1TWec3teC1paQTdY+xiBsP6GQGYXW8Im2cUu92OSK?=
 =?us-ascii?Q?7nVC9/vDEQrDOk14INQbeRiCbb9z5wfSF/u1qcEq51rIYAPr2yvAnS+wsob1?=
 =?us-ascii?Q?yJbQ0LCFslOBkcAEABHu0F2paWu5L66U7QvdqHe7pmtmoXDCqiztp0+iFhnI?=
 =?us-ascii?Q?+jE36F+jGb6+kHQ+TxGsPAFWbpBV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bu/x1IhS1SSfDRuhhNStGJUx3ByS3SlSaHxPxUaXud/Lsl9JWfOnLBa1wUb8?=
 =?us-ascii?Q?4DTTPiSzz4ybQRMlG3RoAG/jc9fGLin3kcxxDq5d/soBht45z3OlXze9ucyj?=
 =?us-ascii?Q?R5x7X1N7iSx785nbsF7lk462oLtNPiqb5QLCFD/arQCPD8Ud63Z2hszvala1?=
 =?us-ascii?Q?xt6yIFSc19palFcZ9BomycM4LyegnOzUaIfs2MfGjhLyYrr9YivexUwUPjPD?=
 =?us-ascii?Q?8Ekraqt2Qv6X6joEmeUG3QZuFcfsFxIVZvkujvHHS0+4Maml2TsYEHtlprTY?=
 =?us-ascii?Q?FBlPj4fBiFH1qSQ+WdKYiBakrGdeIa8qZo6WjEBfyM/PWMXyLq5Os5iwO4qn?=
 =?us-ascii?Q?zy0R1vtGokigLZfQcIpVNW/oN09x/ujqJzXlsOGJNedn7f1/wBVqnw5JS9XX?=
 =?us-ascii?Q?qInPX2bj9dts2+2gsTSPePorHsHgqL7zNKPbpe49Cb/JPVd5xYtPHfWEMFrd?=
 =?us-ascii?Q?ijpJQq++Qfrs43HCF6d+PXtqZNudQ8d2IotMg0mMLZAIRkDSkZvn4gDgvX2n?=
 =?us-ascii?Q?GsMdFlvKutr1gFZj1KbmDpBQbnIFNKoiml2kf6VsvfLXVL39RhoOG8qgE+Nn?=
 =?us-ascii?Q?sV7TC+06QrHX3P9zNUs/R89/3q93F+tw9KHXEfDuNkXZf7rug8AlgP04HUwh?=
 =?us-ascii?Q?XS0InbOGlCQTRrJQLSY7pBuky7hrXTSgzeMN1r0WhjcFTRKp/8rl4f5XIhJ2?=
 =?us-ascii?Q?FNZl46kOKpU4F8Z4uqXpK0QQq2BDBag+w//+1cTQjWSpkD5+uCZsrcuIeceI?=
 =?us-ascii?Q?oSTIusxiIda5uxCHAaVb33urNPYaPFuDASFxdPwMoI2HRg4PnuqmCteNYLDA?=
 =?us-ascii?Q?PloNNFaRCEHJxjtnE/J+9fWC5ngykcmuP5HMcChMd4dv1pYsilzrsAqlO8g3?=
 =?us-ascii?Q?5/9KJ/m2+NcyNFfeTyBCimp0MPYL5GYZa5SnJc1b7AWdwvaruI7Rphnmoay/?=
 =?us-ascii?Q?0wqT2FKZbRvX5IFKGPUxDPNfVYvJqeXDqRiEEMU+Cr/aVne6GfcFCeLMcUFy?=
 =?us-ascii?Q?/WrMh8WNJ92ev1wj4ZHs1o6JJvfVWFHhULCsNBELcmbSOjI9jebICyQnquSm?=
 =?us-ascii?Q?J5k6goCDOVmlOoQWXvDY+0CtkHn2tHYecOQkRtw4dMDXKzurK0ddnugDukTC?=
 =?us-ascii?Q?zXtMVtmVTFD1mNkiA06IxzpXEVZA5B++MIey0NyFMBOZsekyPrWZW9ipby3Q?=
 =?us-ascii?Q?HsQFprCCyzLS/g9ktXyd68og2znOYNufa2Zjrvaj2yCHnsp69Ida0H0FRe/Q?=
 =?us-ascii?Q?mh0/bx7YzIxm7vU93V+bTnvC5NRERkJNzmA+sffCVFMdPzca+47wSjIwf3Fn?=
 =?us-ascii?Q?sgi7ONyWs99hHWRjWLrFFuWrvonBUNx2k94VI/LG3Ohcr2B3ylX7CcpG/4gP?=
 =?us-ascii?Q?7mcbmkzl2Y65Dx7kWGsGMvKxT3ehTFJlxWA6rsMzB9nnOg/bR+tqpSJ85paA?=
 =?us-ascii?Q?C73rR4TgVDfiA7XRPeTlrFQzhoQIc87DEzVt9TbCRuSb7tuU08wnhVAzMdep?=
 =?us-ascii?Q?37DlIuNacQc4o5RlXGZ+e87R9UhkMlYGuz6Xfw1RNwLJGLMPy9HtBx6i19SQ?=
 =?us-ascii?Q?6LIRT55yjSyvIVdL2SA59TRc1osbAB353Fzul2NO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gOxA2+VMwCgqR0NE4CzGVM4ZJ5Uiop7cCbbekBd27xoW9xv07uj07ZsZFpOE/Gx15M7wBu4VoKIC5bV8Lr961I8UbENWsgg7Scu/iDACILBygP2Acr37UFtkRRv5rE4umf5mhI2f5Rc1lHNKrznhGDhBT8n3aYgqDR5PJbhR8fh8wmY+VtlNhJpo1gmx25bfHl3BVRrakOCu/ValCHJmVTf0XcRMal1xco/tQH2RVOIAHWpllZZMoc9NpmcO91YdoP8nmx749+ZA/yFELdza4wG/Zh7/gzVPZ2A1BkuXGjGynPaKFbUTQT9hl5vWN7Qet67WN4L5PMNdZdnfoaiDPJz0tHkzkDF/lCELYg4QauCNX0+DMVLXIMN8kkrDIDOaCMaA2iI7f1ZOjwFIhgD+BcB87ScBq4og8kV9abPjy82b5OxleSV48SNsgyQpHPJbU7ub1dyH99CB9UxEF4Y0jno1nqDxxa+WfqhA2UDyiK9yGP58yDp8rbWAt29XfQovr2iQeGgF0afbSmxNy/PJU+7G07jIPR2sJ8DeKl4pTmQo2envNm9RjSI2YB5ktkB3HtC7ZKcSayueYqIjbwwPx3N8ZOKyAKUiEeuDdp9l59Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b31b90-8161-42d0-e971-08dd2a8f71f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:09:34.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFdbmE16P+0m4E4Q/wWLAF01MS3p8yuGTNMqOjSIsBSHJYC1bxZog8OJSlmg5ODtGbwPr6UYxlZMYe+iKJX9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-ORIG-GUID: JTY-3ufcZw2ToFENiAbSbsmH5j8BGNkG
X-Proofpoint-GUID: JTY-3ufcZw2ToFENiAbSbsmH5j8BGNkG

Currently, fs_devices->fs_info is initialized in btrfs_init_devices_late(),
but this occurs too late for find_live_mirror(), which is invoked by
load_super_root() much earlier than btrfs_init_devices_late().

Fix this by moving the initialization to open_ctree(), before load_super_root().

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/volumes.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 814320948645..ab45b02df957 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3321,6 +3321,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->sectors_per_page = (PAGE_SIZE >> fs_info->sectorsize_bits);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
+	fs_info->fs_devices->fs_info = fs_info;
 
 	/*
 	 * Handle the space caching options appropriately now that we have the
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..fe5ceea2ba0b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7568,8 +7568,6 @@ int btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 	struct btrfs_device *device;
 	int ret = 0;
 
-	fs_devices->fs_info = fs_info;
-
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list)
 		device->fs_info = fs_info;
-- 
2.47.0


