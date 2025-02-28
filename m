Return-Path: <linux-btrfs+bounces-11925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7FA49133
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A133016F1B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C391C3BEB;
	Fri, 28 Feb 2025 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LEoO0T7X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m0dNatAC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0B1C2DB4;
	Fri, 28 Feb 2025 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722148; cv=fail; b=QqEBiSMOBXlBv0ZO9TG0HuNT+NZ8q05ldMQtoFVvvlbL/SUuZ6c7n8w6k4Nk37zWOBNdaKwT54+shWPG4AtcpeAe8xuSyYsRwlbLS+f/hhqmQ5W3mcqRTCheVn/ruY92/cDy9I/a89w81312nCWFssRDuTVbSoDp88u9cXlfNLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722148; c=relaxed/simple;
	bh=ErF8doko4d+Y3sL8YqsVZyXsx/T+N70oxatyDhYAS0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQZv6l+lOM0H5q46NtFwRmuANmbS8viZIvXUUD5SFzo3e6FiyKgGe2SwIGC/dT0RV78kPGybBk1gGNCoLikVg7601HsP2i3bAgX48t8yo+rTfc9YAYv7YhkHXfL3MG55Zlz1yW9/gcqEjqXvyM6+BOT4UFUI/zsw1/N0QXSioPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LEoO0T7X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m0dNatAC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1BxSA032624;
	Fri, 28 Feb 2025 05:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j0ffyTcjNQhNFfSShK1YjsKY+zStln0ETEBYAdRxiJE=; b=
	LEoO0T7XDaxpZ4AUNQY5+nkrUOVJwqOLof8uMGrix0YydTTa95qq4W24c0Ruug7Q
	O1qeNks+ZAabEGnF6TeXbGai8ATHtx7MeSpWRrR1JRt+yGIYSWQEZnwqTcKfCSkF
	FLpbiQSLLJzj4mwfk+rr7pVPSUNZXEuPpmzSvLp69HTl4HZTl8ca8E4bhyaP7uqt
	qeZYLQ5S94EKtwkemJK4Tne2UefTz7OOWPZA1E6Rc2pvyW8mhQwGyUCjeYko9mbh
	hRBcGGO3ew1tTeDS7bo1CTAEtxTV+sbxFky8Pd7NnFNM5U8CsEQJEDZ053MrXG+t
	qGWASEKZ1HZVRDjgfHW2vw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfvv7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S4F2Hq012602;
	Fri, 28 Feb 2025 05:55:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51eechu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVW2Lnnb8OJbnhKCjbWpLTYd/61ksnUFYvFviinb5sZPflKwDdLr9BE5chr9N6nCSbx0QAc4fLdSUc5csArpKYxsUx/KPLyeBUentH4rfeIKFENApoeC+Fkl3z9NqJHkbHpTVEuxccvV2LBElVkj8ubwYguK5J/0nNBrbb0xJdLdSKxPhs0MzKrWq/T6AY2o2swrixP7AOp3ymIP00seHiTSpgMXisGg8LeZoYgFxLZ5rG/X5LIRztk7lQGPUsitx0rtdVqI51Q/+cmnFSPLN0e7YiVYXvm6Bg0PgUYRgDlYUdRdVs0aMhKwV6rhHOGM1soAUO1k7R2/iXDR5IrAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0ffyTcjNQhNFfSShK1YjsKY+zStln0ETEBYAdRxiJE=;
 b=y0qu9IhNNhW7VwxV+6iiJtiT99FHtdEe0z7Fnsyj0ic3Ily0/9WxvbD3TDVqxYTYsS/ErEiRralwlHENhtx5D/6YfreYcqz6FWKFJG6tGSuZe4YNuKRYsSRHnL9J/GlUBjT8ABSJGjlRyyAqeSeTstGy2yGRKnepAGH5DJHSQ/7hB8bjLIJQZxyH0XmDof/eUUQniRWgn3neSSthwx8ftg5rs6LW4BHr5S15a4PKHltnolxhC+uahZ0WcQ8Glo3MdNyarka5Sg+7eA0a/hjEE/OBcj0WE64hVoM2NHPLBB4n16krx4DVqqRaWVKY8nDLXR6gnqm6z9ZpyIq6Z5QxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0ffyTcjNQhNFfSShK1YjsKY+zStln0ETEBYAdRxiJE=;
 b=m0dNatACoPTcuoYAbnNg9hNjNFH5EjIJS2VLyoMGySLTFsdM6Q/od/woJqRR2Oxt2M+JZNR0MyDx/crSnxahfmym4jqXnIsDjWVmTNjoRndObhPnPzHREqdskD+TFDShn8qRgLY/z/eR2cb296+/EDuANRUGxHdPgbmoSlDnds0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6618.namprd10.prod.outlook.com (2603:10b6:806:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 05:55:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:55:40 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v4 1/5] fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
Date: Fri, 28 Feb 2025 13:55:19 +0800
Message-ID: <cb5e54259bcd2bd6cd310ffa2411a79370698f61.1740721626.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1740721626.git.anand.jain@oracle.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 499219e4-944a-4f06-6bd7-08dd57bc8844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?McoHvEgf5aRO6LBsOB9z8HdnJ+RZsr60BynFcFG3NmpG9bMJZrIsYKb4copy?=
 =?us-ascii?Q?v5x6gc0A1z1mKge1TAZwLS9oS3rnQYQK+BdYAqgmzvIKIEyix7Gc+f0BeB5J?=
 =?us-ascii?Q?6+0rxmkpQ0ApRDqqdkwM/ROq1lMTwjQzMtqWCLH+JbrpONCkTEUFVAR7wS60?=
 =?us-ascii?Q?ygotHZEyJFJlqOjKqe+sjDNBve5D/bm3HQmuP7iqbpCfWDrnidOcb2om4R7z?=
 =?us-ascii?Q?JvXCgT6E7SVKbMuee0QUs5h9fxr2caWmVfy00RNjgx4kXjlHpulZ/mtkVxgs?=
 =?us-ascii?Q?nTthfhu2vMk/sCO0Uij0jOsH2WJg7cPhKig1aYhtUYBRYd08unNz51c5jCVJ?=
 =?us-ascii?Q?Pl2DHsO2u80baCFjWzNVnjaiQLBb9RHFXoc9MAHlAFxIPytrpRGUdk3HwSUG?=
 =?us-ascii?Q?lDjLeu9nsCXoeb3vk2Wr5Olyf1LO2HHiizNujlBy12T0dRXm0frcklV3Cpxs?=
 =?us-ascii?Q?Hd7xSqJdoxqp9ur2cgLvldCywUkI4x1Y2jW5ZCLs7BJzGveQD6J9xsphvZvG?=
 =?us-ascii?Q?PiiFkoQikTMjwdcFZs8gMqVB0CN400AUP1DrgS2q70mruetzFod1avzm7BmN?=
 =?us-ascii?Q?dpCQdbaLaMfnBTq0JaUz1DT/VbN7KVoWV9hGSKaDphSlB5PCXdxxJ6EM2qnJ?=
 =?us-ascii?Q?9YxeKm7L25luTf/2Ib6hSeWbGNxIivllcujNgmRaoR0/u4Rv2mGPgi4Dn/mX?=
 =?us-ascii?Q?MJhOotQiPyttyYrUA+qb9JpmKnwkQtGoNgZbvNnNvtGWls25XA1OFihoFafi?=
 =?us-ascii?Q?6KOp6M8rpdrGbbkqgAedm25P9wvv9RdzURmRC8zD85h5eRavpeUrHltynmGV?=
 =?us-ascii?Q?rKejCudffxxGFzL5YIzUfmeEErYKV5rxpeLRLKkR/h3Fco6QwsYZT5ZVQCSe?=
 =?us-ascii?Q?hFSO58gkM2P2BWmlJFoRjv+UGn7Tbp9mQTRxWZTtFeMWBh2bK1S9hbF/ESn1?=
 =?us-ascii?Q?ioiD61mhBOmwYMfRXwnUK2l1kR5Z/Rk0+qVzvjGI1LVlIkpz1gwILshd2nkW?=
 =?us-ascii?Q?QCG2+SDe+HJCIfjulot18B4KObUTujrfU9R876SlRQCGvcy0p6I6+kAYl64I?=
 =?us-ascii?Q?1nqZDZyJ9iY67qlR1Thys5hAxgCD/QSKz3GihFtnETdHCkKS/GW5MmbPTzIQ?=
 =?us-ascii?Q?aLIQLZXUgdmD+29pcP6j8BxMwIr9uPxEo6oH0Siqm1ITSqN373mq2oyqIuik?=
 =?us-ascii?Q?rWh1Vi+6BozXe17M+87i0fwOKE/v/VieDcM8W15xQjh9nuM7hUeUEqBt+gAO?=
 =?us-ascii?Q?jZC7vZ6CaCGokTlPecKLC+F1Fg8fR/Z1YD8oV8wfvuBqJE+O5Sgyzfg0JxE0?=
 =?us-ascii?Q?aernIO/rP4zWEAun80pNzGVvEdG1s3xPnyRTRbECPfhK6BaGAcDCCmIQFoQt?=
 =?us-ascii?Q?gPzjHdlKQSuTU20aDmG025rIpva9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+TYMXAf8u1Vi/cPph32cCgmbYrlgwt8+19//RIatYInyiYy7duVD/+bxGOm7?=
 =?us-ascii?Q?RqvVYfryQE1AvSe3AouF5zaGW8fS39jXdRwsL7nR4mcytYuHl3Zuy7i6/TTj?=
 =?us-ascii?Q?Ipu2/SZ924KXR+G9S3Kt6WriWzS6i4b97VhvlUHjOTN2oWLCsKEJbrDwUCfY?=
 =?us-ascii?Q?FcdHAzdl6hEu9oEYathPOjgFwXdXFfKQSvfMd7wlRqaRhguf4QWHDt20tHE7?=
 =?us-ascii?Q?3pdz0K9PmW7t9auPxz7kVSk1/YKx5697Yk6biHjLz1Jg+L3Gk5q7AFl/X4YY?=
 =?us-ascii?Q?49rh91sSnjTHcve9RRd6tZXS6LAU4rAP9B70RKgh/2PkujzKtrL6RCUvR9f1?=
 =?us-ascii?Q?8aQBGIdkgm9CP/nNYr3R/od8K1BGjAGcdnnP/o5q8ahKN25MOKRwbmIZqnon?=
 =?us-ascii?Q?fEDUzloscXF9Mp8+/4VqPbgFm8CVEOI9kofCZ4VbOcAJcOAx18wL0yWghGJ0?=
 =?us-ascii?Q?V5A/OsLL+R5wADnDFL72Bf9fbASo9sLBgW/4WHG57Nlj9h+iTiUK8vS5WE8B?=
 =?us-ascii?Q?WNgkWljdEbslC3cohxAgchEJ89WgD3hmp4JBZVg0UYWwoJcuS4n4ATtWMpzz?=
 =?us-ascii?Q?U7WwsNF5T3eVOeAYwWa0JpOemcdABs9pnSe9nwgDImM4SvYiTnljhcGpXaZu?=
 =?us-ascii?Q?a3lZ1SkjPANR9lWbwXp0wKq/OnugKTg2uoKWwIdUpSb8B3Emgb+Lgn4Qt1O1?=
 =?us-ascii?Q?siQT5z9uyikp0Y4QMmcCdDLThirOYBaGUzaX2SdmNoaEzPeIHQELv5UUcRRO?=
 =?us-ascii?Q?AC46DYuQ6QHpnGWoTyUl0bWetwxvnI/c1Enl4lIf1mGrsS3iaVhJeNueAQT2?=
 =?us-ascii?Q?RIqaAb9MoDj9QT9uUgLXuFpwze+dpxaH0UJ5t5nRWS164wQtQtjwCPF80H9v?=
 =?us-ascii?Q?NIc0qL9ULwVa3UDSK6FCet09ko7g9YOHA5SWezQ+st1JoR+EvqUJBlIviPfQ?=
 =?us-ascii?Q?OBZtQ/vyWF6B2D/8T6zOlq4oxk7843w//dEifCQ/p5znK0wzH8WEfGllcHG4?=
 =?us-ascii?Q?fqJGspB8SFkoWlzk/ebFWOCbEB5PX1+GZck2StNOV3mWbQvByDtsIU9TGniE?=
 =?us-ascii?Q?HSgqRMj3ZxyPSscnp5VYAwKXH/9tXxvi1vZfkXCC2PD/h4S0Ha0g2fUsfvtn?=
 =?us-ascii?Q?GYzYn0nt+5sGMpwqLLSu/ksAHyvuipClNnTSL+261k698hqQlj07QlBOVgHF?=
 =?us-ascii?Q?SoeZXdt2rGe/u4JUjM0yBRjN6zO64GE/6jFPD/qyV0HgmcX2LUdlk74UsxDv?=
 =?us-ascii?Q?noawUTklTlQn+6jdw/2oR/Sh4upilX8ZWwB66RxqVU3RUG6x0WxsKOCG2pgd?=
 =?us-ascii?Q?FkO69NVjyzrUhzs6McBYK20NLl3hQfHiG74Lze9TGL5G4tx9L2WS9Zp6tE/E?=
 =?us-ascii?Q?Q7Tr1fz4juSbK9be/qoKVbtslZ0jruH/vd253YeSZSqoQf7suPmhmEqoADia?=
 =?us-ascii?Q?PcXb9NoWo2SEBXI8cUFTBQq7zkOSgsTc8giKIw21bnqubwTXyJux6SSbCjkO?=
 =?us-ascii?Q?Rr3Xsg02vKKZq4gXeAgNO8KKENl23kUP6Gk+7I9HLmVU9ho8DGK3R2yXMu/R?=
 =?us-ascii?Q?6r5gJTNVCPBpLSVc+g5QYLI+5S+DCDfeao27ds9W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P1zDeEjjmb4I4kbDVBueWx39MuAHAMF7qxNNO0Frjl2sGCawIpOvHx5qYSnDehPplY0Bw4084IX8QH32LKEZXE8xYHzm7y1KK5sLUUi0qU/eGDFHWMQd3T0tCaY4GHMmfmAdF2FnWvATladTKVrZux8rEUwXLoMeB0IQhrx8lEdvn1yE9+0KklrBbiFp9iVc77IXrzG+cQ/qZa+qZ/TYysbKfweESFSTh7n0FE4Qe5LcSH5cqMbDWlamhMS7HZjIY+bKGHXw3Ud61qsUnModDQpZCtNwIYcSmN6OUJAiU/OdtDgHq5OiQpajwqomaNCRrPM8mHSmLikxKNDOvblIv7og79De06wcTr79K4Tga7uRDTKBl0DFtvhaxDBOguZp5oCWX3N1s1TNZwUzUiyX1QMTMBHStlhjaOIYAQtIbyPiknVly+A1JvC8fSA521BXD3aRFLZCQx/Vi/rg3A7YJg0rN9z9QLDHK3l05emYiaCoNPMOw6QdtNBnd8rx7cH9vow82qt3YTeuNOFUsBPWRsTXGjWDdDmJ85GU4LtQfpZ+a6j3C1WorTwGpgs35tY0IrKnj8r0/rF/em1+xmZmpLJC8wBdMpZ1iw2AbK4Y6B8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499219e4-944a-4f06-6bd7-08dd57bc8844
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:55:40.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl+782J6bqQvep1a1V3CJDoHQ5ynNvvNgRDULbkY635xfT9dDZnf5iv/H9iQMhxgpT7UQhaWBKGbvLu4xaTDKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280040
X-Proofpoint-ORIG-GUID: OB4VKaplCMLk5h2GCPhtVG6_Z0RFlb_B
X-Proofpoint-GUID: OB4VKaplCMLk5h2GCPhtVG6_Z0RFlb_B

Redirect sysfs write errors to stdout as a preparatory patch to enable
testing of expected sysfs write failures. Also, log the executed
sysfs write command and its failure if any to seqres.full for better
debugging and traceability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index c7d7dbb8e93b..59af83a01e3a 100644
--- a/common/rc
+++ b/common/rc
@@ -5181,7 +5181,8 @@ _set_fs_sysfs_attr()
 
 	local dname=$(_fs_sysfs_dname $dev)
 
-	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
+	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
+	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
 }
 
 # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
-- 
2.47.0


