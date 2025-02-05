Return-Path: <linux-btrfs+bounces-11287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92FA288F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8043A3A80DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54B22B8DB;
	Wed,  5 Feb 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WKBT5oQc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uRhjF6DI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF041519AA;
	Wed,  5 Feb 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753629; cv=fail; b=E2DJmfjjMHYbakz3Rh5k4M/WI42JssgoL7E/ls/ETwooo74/MAGHe7PtJD4rOQML7L3hm8K/FX48ECLHvTlEmE3TRQFM+n9y9OtgnM5P0gMwJlL11D3Ype5cxBPW91dCxNNULedvp3/xfD63OrwIt/oolSWhEjMH5dPyXDezLQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753629; c=relaxed/simple;
	bh=yj0pYqZJEVUKE8vbBIRlHL50SMANXyZXTflGZlV0qqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5YOso8rAWnfvJFAbYnMkgeLcfegW7+bJQFCwMxin7W8+Z2YwiMwpnKtXiE+bnY+3MWJRfY5KcxnfX4/C6AotjI7tkBS5qJsnC09cpRhOCdaszdbIfmXi8eQf371H7bbP45/0CQ27k0iMoAAx3ZDfDC7eg4ikl2iPgZR8d+0MCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WKBT5oQc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uRhjF6DI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5158MrgH003329;
	Wed, 5 Feb 2025 11:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OH3OqySjvbaN6pL5QL56wyWK4i67FQaqaDIAB48FV2A=; b=
	WKBT5oQcMRnhbC64DdvFmAQXWkA6ankeG8dbDbgfYsKmuVovRkiAAoPSqsAOoY+M
	OwEi4L1go1tB2/0Jp7lZCf3R5touoLX1VxIqBfruEjxSOjlhmNUOB3i9+kOnOeRc
	OUotn5Ghd3u8Eo+XSJTiWHb3vDv+btZioIWLVqySTLBayuL5/EQL01uL/JRjHmQK
	HFeFRdWqPtUKc+C5xujeBjM0EGQ9ke4O0akn5+cWhHO5FsFGBn67wvYwWHI7yw0I
	REGhiWDxEpfr5yEXiMwxhznTaq6jkgxtsCv6NOTuGP1C40VFYm9cw6h0DeFWkn22
	FsBKRC6DE4mFp83yzwCR7Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgy1q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Ar6Eu037744;
	Wed, 5 Feb 2025 11:07:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gj6xsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icYSeH0QoQcFem+du2UTqs3M2At5jB7DKQDaDZTYbz7lzixWj+WQrklQNpgZd48a3eW/BI3gEKL4NP+S/lff4g5RFeDXG/MRorB1vQgrnaLobpb1ak5tm70cHJhU2ywtZm5+2cCqtWWgI7UJp22udeWLHAZywDjCeTlY1x+HmUuFZJnK3TB9x5GJgALwzrNfw8jUq6z78WvxNvDi9PVC3GnJLhah08r7DYmFQQmDu58P7s2PqsbUK29bqnfl4Pc/a8BqmmesdXY65W/36UwkrsCZR8y5wMDbMUXXN1gBPSbNuyqOi5G50qzeCSlZGy3keXR38UM9m5Y4zaH5tnsj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH3OqySjvbaN6pL5QL56wyWK4i67FQaqaDIAB48FV2A=;
 b=WS4GmOA0dATAy2PP05DbL9vb7E+lFAy3rlWX+Q2sWcEwNBy8En1ebBmEGlH09LyHxrgKGocjJkvJ0bYzFe+BpybGketLKRkC0yBrnvC3zN03oG9kN3RyOXqId+X+8rvhUR8HJE8lOWq/psfYyEx36m4nOGoPQ82dGZFqseG3IGmQ5H+/hl2Lc6A7m8pm03HhINuAniv65i3MJ8Ae+CGVcFaU7Lm6fPbYmwUObxXmTlHBOQ3kt/JTLnUsr4tHxAN5ebMF53Ed9CY0YhDfW6Cd8zJ/4OwuSLCUNoIJSsVwtykCn7xpskN1U7UbswULUtMX8RvuuBH7H35jXVi0/G3K2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH3OqySjvbaN6pL5QL56wyWK4i67FQaqaDIAB48FV2A=;
 b=uRhjF6DIUBLwMAK68vq7DFULlERKrwN+33ckhm5BuM4GEiBM5lyKjxiX/JHS25/5l+k2LC2aH1C5kRDp8aHFWaTDoyhBsHKQmOsGIVdqT9NqblPtsTeJ66BOoAXN4vCNZzUZzW0hm2l2r33l1C69LtuuDyUW/XJOVV/8AGd/nfo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6439.namprd10.prod.outlook.com (2603:10b6:303:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 11:07:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:07:03 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v2 2/5] fstests: filter: helper for sysfs error filtering
Date: Wed,  5 Feb 2025 19:06:37 +0800
Message-ID: <e8d0f7410e2f5cdd5e2265f63ebd6dddf65360b7.1738752716.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738752716.git.anand.jain@oracle.com>
References: <cover.1738752716.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 3faf1543-ac15-4fa9-2f6b-08dd45d5381f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlFf99qWZmzm1+BshQL5x4sOX9k9fkpD0vI7h0qzmo6IXs/cAPSU+bPzJJa9?=
 =?us-ascii?Q?Zng7FWgYE3Qj/r+kRcuR5T2EMDKcF8WEu2jEBR+pmydL92vAhDso4l2lGzOh?=
 =?us-ascii?Q?kdZLmn2heUyYAevwoEeadVgeB8KiXVpdgurrP3SoQNx3Zx3x/phNCmR1t1aJ?=
 =?us-ascii?Q?PhXr6CdFk0SF6lKbF6zeuniLkSMiXP4mHUgG/jp4og8hat34Xt8WGqLkK/zw?=
 =?us-ascii?Q?M84LqFgQEkX0JchinFZ000R1Zxw3E3sRWyGdJw9a81WxNl9iLZXrPoXO0Rmc?=
 =?us-ascii?Q?V4LHcN+ZRNEBp8+qariISCD6Wq4QSSBDGs7G15RoZs16Y2XYR5fBvAB6HX2D?=
 =?us-ascii?Q?+sCBRrH0Cn1WodDEmCLkCPEI9pK3PcngnC6GixPdkz3I0Y6xox1pLtT0DwNF?=
 =?us-ascii?Q?U611eG5Dl9c4r0Dr45stHjZP1wnUJrEpJ593kA5+2z7UcarAJ7uBgj0Ic2qj?=
 =?us-ascii?Q?FLGqTkpovlySJDxgrrJ+mnwES2qj7V29JqsGzkru3gOvn5Nu+SZrlCXsGqU+?=
 =?us-ascii?Q?Zh5/SvmQnQHXmO89jTYtPN/WBFIYv02yNlmsTnWr+oWNKpCE1zkvyxcmQqII?=
 =?us-ascii?Q?ig3dvo49kQ2GvsUVZ8mslGDyIk5iuXxQ4aEDpUPsX0xKWuZQXN/waP4iKYOe?=
 =?us-ascii?Q?D8m8tn3ST4vYoXzKV+lsuiaemZjFJlTlLETeIRjD50J81JRrGlLIruLXBAbM?=
 =?us-ascii?Q?+bfu/XPrr9t1KJEam/C/TbA5kSANux7yVq2ILTEH+xTygp5IGpumFRXJuAZF?=
 =?us-ascii?Q?OJK1I7B7JvpRmmQBwtrdw81EhGIGM0LlKLxwUj3zPKbA6+4WzuIMJQV5stXz?=
 =?us-ascii?Q?3QkirbhNZ1GLoRzFDiw5W9mx7U7MWa+CF+6EWtNisXHFvMtq5KdubxGGsyJG?=
 =?us-ascii?Q?Y+g4RdB/BDXtzXMXGy2X+q6GnJIf7hQIHw1i4KtS1hiAwKTTmUEAJ68a7oxy?=
 =?us-ascii?Q?Mrhi7xRWosQXgh6+WMFXPDFARVcSBGeVNFCjJct8nEb0cG5TXNgXT4j7uXbt?=
 =?us-ascii?Q?CDMnER4HFGA4j/KU9qm2B8Ea4j46i3xbE8KNU6DY0yIDRfVpDcKEAfgE95Cu?=
 =?us-ascii?Q?8BsWK8G38b9Sp1EuH9kHamGhp5+RK/a+DeQcLG53fehY8Kdr6/sMLBUNk2v6?=
 =?us-ascii?Q?o2KBTYUrqUhTXmBWcjLR5W8LsJzGF0t1Y0Le6WlExiCmSVNyjbZt22wr+1Zj?=
 =?us-ascii?Q?akDFwo3UQxmySNoWA3erAhHcSrFYj93Qb7dfUbCs0lu0OTrpRsTz6oajIihu?=
 =?us-ascii?Q?t2KPeoj8rZNiXbcbjZqydTkWifPAH3+woD7nQNcfyyl0pkj6wNuzKIK+s6Vb?=
 =?us-ascii?Q?GbEwLQSOHlSwwBSuTDYOMOwosM6Kr0zaAoXJpIxIFxgsk+4ZbsulbMq+nosu?=
 =?us-ascii?Q?ewEXC7YVLo4s1fRjoPboQ6zasqA9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EoezhlGw8myukAdqT0aTtdF7tNmatXxgiu//VAX9Nricx9ynkNlPP2ONIE/+?=
 =?us-ascii?Q?DDPoB9oWjYFIbc4sYhPPYx9xSE0t/xGg+qVHfUpJ8IwFrSVym/81rBOXzHjw?=
 =?us-ascii?Q?812TyenXg3upqWdN5JEjOr0LsJLWqVEggm2A2EM/J4S0NYaYAh4xvw8gmM97?=
 =?us-ascii?Q?myafLp3PI19QSD6mDXBP6r9vnEDXbdqXjh4y57Yr8XHBVcTlLqlTdP8xZBUS?=
 =?us-ascii?Q?vnufEAJAmUEK9a6fdqDbODNmEVVTQDpEUPQ7GTcoGDkg28vHTDOKoQusf8k7?=
 =?us-ascii?Q?K39BB9TkrpqHhgJurQXlUFAF02jhc9fqIR8AfbV4Nfm7tSMDxRaDIso5jAWY?=
 =?us-ascii?Q?ZIrXLx1vcXM7CkNYESu/KXHR7A7hSEcLyfEsy8CL5AJWVDMzJYRv+yM17ZMc?=
 =?us-ascii?Q?RSfavun6L/0I3XxshxrvUew8SGJ57PxYsDnKWyiPfH9v5j+RsTHR9/kKXUfu?=
 =?us-ascii?Q?WjYj5a6hl6DFduJJmWTFPHf+j5a6O5yEdWgZ1MYWE8XxQpGDaCQI+BMmv828?=
 =?us-ascii?Q?F3gwNAWayJdGw1lTHfJtKml8e+5ic0vi1qUkEztL/pCWxdR5IkZi55s8C+Vd?=
 =?us-ascii?Q?IpKb2VpCPDgTfjDMuzxEZhA86//C6u8l6szJJIP3TTgo0Rn+1kPkzD73rniY?=
 =?us-ascii?Q?BhTQ/8g3q8ei3+BZLUdx1fNkGG0QBYofi36Awy6hD3rahKlnDPB/aLC3sbGU?=
 =?us-ascii?Q?+C58tq+fGQincePH3Ta9M8rG3jVL9F7ZoJyourqMHb4xKPyrcaU6z0WTxFF4?=
 =?us-ascii?Q?jqYX0m1FVvOKU6lirPmqBrwckCFlDUp88st32onjjku3uz8WIi+/BtRH2efN?=
 =?us-ascii?Q?jFBuEsU1ZcAxflXPN5Q26If9e6c5HBPXCepRR/M+4Q0I7PgnEszFwaKnaWbE?=
 =?us-ascii?Q?UEemUmtRvz2JQNwlS7BdXtWNwLLLWtEAbcuClNh+YhJg6V0Tb4chaW566Y8B?=
 =?us-ascii?Q?PTxZ2i8/w71u0W+J1UWcAwuWj/xXuNd5I+hdTFT/8vjOL+aC5AUMuHzTgPUT?=
 =?us-ascii?Q?NalLjKJyaGZvZAK2o2EU9nIjf5ikMMa/foRvf5Db1xkEfuSuvs2T9bfVHx99?=
 =?us-ascii?Q?AWMGnJUaPCEMdoLJv0Q480bcW8d+r2ZGTa2hD2PjrVjh/seZeCHsVIvTVKPB?=
 =?us-ascii?Q?4mCfIGVtdUA1K1XO6SnOrD/j+8xgiYc6B0/RxpUwBDIkxu3ETC2qB+ilcSS5?=
 =?us-ascii?Q?3y4HnInEPgtETnycwAYLNgv4uzBpzU0oe6oq894Ih7nt3pXc9kwIFleSfNUf?=
 =?us-ascii?Q?MeuT2pKL3qXqk2M3gw4AVlZCjddxFCOT0VM7OOPMOddv26ntHMXKGDrw89yF?=
 =?us-ascii?Q?1csIChWIq10gg+xXnYJxgJmHxc+wbGunhdFvvBqZt0Xj0hGSqxNthNZevdi5?=
 =?us-ascii?Q?yUBFHdFQsdRsLwME4yr73Z+pKwkvgkPT5QZi8dPYXIFRrrbDLMBr+ki2PBl7?=
 =?us-ascii?Q?fcDcF5eO76DUocZ0fryeuVWdgie7+iLXkkd0HsRV4QCHzY79o5uf9y40gef9?=
 =?us-ascii?Q?ivEtOq0Z4uG9XFO1kRGBku8y0wIrB9JQMQbpk5uPh2pnALJk//5oAWdW2phX?=
 =?us-ascii?Q?htUxFA6vSa7GWW6Z41OFHStTXK0hXxeRY1AZNxG3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RUEywJXRfJb15fQCohDasGT00cIv9V7vly4iGXOJ6x2B9+bVyQDsrWb9D9E5GXZTBFQS98/K6X0IZcl1TtkRKri1mxbNSsCLI3CBnUxlcMAGX81DMHSYFJuEHu832o/GokN/CP1OYdIwjHEdYdQxPq0XmretE1ZoPpSRJsFCR4q9UWgjDTAnQajtvRqlGnZ6aG0m9USEjrlkmxcg0yN6Tx5UofwfY/ib2C4so94E1NZbx1RNFPUsSBtTH8uc1lrwIfFmuIFgFQ9IxzNecuqKTrrSvcrddmHlqhG0dH7Mb0zc4k2zS0p3j8r0/dbbGz0nE7GCdjj2qI+naD5a+HEo6C36RaMYJ2EA+jJ86ZkXNbagk9c52PVVZho9lNBNDwR/M858812sMlXpxR+FSFkz0bYPTRpHbYGDF2Vb+LTZuD/9KW9Dzn6QLswt4BrmXEFIT7Mekkm3mkbDrr/yQaIOX7kE8oHGN55ZWIunM9U1R+NZQEoPrriVBJCJ4uQLXcbES+TDDAyhw+0W7W18MC5QRchF47NpUb7836YSbeqqOIqF8GLuMXdNCyMpHd3s02V5OMf69eLjSfZoScY9f33YyN/2I2hddYTGxlE3f8h7/gI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faf1543-ac15-4fa9-2f6b-08dd45d5381f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:07:02.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJJVtBfXRtv/vXUEDvfAhg/U/NWRQ6ac5dDTmVmd1xAdHOX73qvj4pYJjMt8amhTwvrnnS7Cei2jKFZAmZa3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050089
X-Proofpoint-GUID: mCCKC07Y978yDAxUr48O7SYU-cfLaunK
X-Proofpoint-ORIG-GUID: mCCKC07Y978yDAxUr48O7SYU-cfLaunK

Added filter helper to filter sysfs write errors, retain only the
error part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/filter b/common/filter
index 7e02ded377cc..44ba2b38c21d 100644
--- a/common/filter
+++ b/common/filter
@@ -671,5 +671,14 @@ _filter_flakey_EIO()
 	sed -e "s#.*: Input\/output error#$message#"
 }
 
+# Filters
+#      +./common/rc: line 5085: echo: write error: Invalid argument
+# to
+# 	Invalid argument
+_filter_sysfs_error()
+{
+	sed 's/.*: \(.*\)$/\1/'
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.47.0


