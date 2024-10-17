Return-Path: <linux-btrfs+bounces-8987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04D9A2B66
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 19:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70211F23493
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991F1DFE18;
	Thu, 17 Oct 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXxw93e/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D21D95BE;
	Thu, 17 Oct 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187540; cv=fail; b=XxmFMwZxEAftkf5VZwZGlSTWFwxn+sffYHRyEt8tjAEddzyMgCW1XzEHOJgCMP93pMpb3CHDPeXFElnFqr30bpijfRn+bp+dTBMhoEHLQBO2YG5efHqqmKgVKnYB3cBnsmgN0c+ho8N8YYBz+6mxQt5j2qElcOILkLONebMWvbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187540; c=relaxed/simple;
	bh=QRALr8b7xvjmrr5tQEzmDi0KVAsKyrveZ+p9qN/722I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hMmObPx2imv+Nr4C+ll2NW1H1m9RGtMHyqly2F4HlYJEpZTTbT17SWGENXgOGwHdPkvGO1Mg2v85PcbxYo1T4fGI/9ytMa5JsakdwZYPEzbfY//gGzvl1kvtTPRYSauQ+Wogv0j2MHKgH7ePdxsCU6GYxGornpnjbXsRsrAFgnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXxw93e/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729187535; x=1760723535;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QRALr8b7xvjmrr5tQEzmDi0KVAsKyrveZ+p9qN/722I=;
  b=TXxw93e//D+PADIzsE+SLP5WK8f8qFy6p1KSAq77uHSddV/VnClHgK4E
   FU46Pcz6GMLyNn8qcz8ggdByWsuD2fcbnet9Y9jvI/WIosx6/z1UKRcOa
   HC5nFjICXrQpDfA7k11EiLRbixGxmfK2Y5q1nTCxEIzgu8N1HLkeKlpvu
   65Qirl3QjSWbOGEOmK0RG6eezBCICAV3P9aNAn3LnSsqahB08bZx/lsZv
   5JE3oecJ0+7w0QaZktG6oPC/E3+8Onuc5HG3T+S0quHQ/amt2Faardis8
   jjWFjBWqMLNLQJy/0TzkdPLYkQ5LM94iPUUqZsmx2n3KaAy/ikjpJlOE+
   g==;
X-CSE-ConnectionGUID: X4TKYOWiRE2TqvVYRtustQ==
X-CSE-MsgGUID: 6zB2xgGfSDmnQT9K8nKotQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28654703"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28654703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 10:52:12 -0700
X-CSE-ConnectionGUID: lSrnhBP0TXa9jDLjKK2cag==
X-CSE-MsgGUID: H1TvngDzQCexU2XjGDDswQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78515424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 10:52:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 10:52:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 10:52:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 10:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4nXmNzrdE37wyemowev+DFihUYCYxNUWZRjiTUQb/KdWdgYqSkAREWwVIZMsToW08a1vldzWEMxkvgDqMfkPL4miK1kcAm1jgHJipSoOPMTWDW1D9VAnHIIdlIEqo/QiIS2Hs/iGE/2jteKiiw9HbQy8OWl+PBJFhwogbWClus8RAYaD0T8o1U7VFEuhy6Lrg1KqyVpvvdSsafujXN843i4j7eq0HD+0Icckpf+OcW6tlwUoeI191wFtZHNZJoBFh9lnohOaVSw10CytnHOoWCJMOPQD8mRTcKICYiYlM8FCkv/6yYOHFAxGeKrPZMGCQQqWT6B9W54lixQ32xHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk7mgQJWRH26A5HdzysB2+8fRXcDesZwbk6XXGTxFLQ=;
 b=DInTsmG5mhQBEjcvskn/N9p0tFJTc7CZxqyYjSz9NsbK0FcQ9fVr+JH5RG8BiJ/VTYTeMKVssXxV504vtaHQ4eG3mPPQTZ8BZc5oYe4zxQNYa19cI7mAg5Yw5E2nYo3Un5P+aegT68W6og/JBK8eYp4mWnMb7aaLj1Xk2y8/WwIBEXBoiZSoC366idkwXKrGxEbGwS2cdXd5Wi8t1OsQ9Mcba7i5owYr4tgPNLHJWX5ybrQFs++jROjFqxJpN8ncZMb+8ayKsjqWlzpXNtsjClSnPugkrt+FH+mTOOPMPaEqgl6F6PhiE24NWdj5GM/pF58SHiQH0lcXtnqiMYck4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 17:52:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 17:52:05 +0000
Date: Thu, 17 Oct 2024 12:51:41 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/28] cxl/port: Add endpoint decoder DC mode support
 to sysfs
Message-ID: <67114ead9fc93_2cee29449@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-14-c261ee6eeded@intel.com>
 <20241010141408.000022d8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010141408.000022d8@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4665:EE_
X-MS-Office365-Filtering-Correlation-Id: 591d4465-1944-4e05-6cc0-08dceed469cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dvOZpRb7PdHfu29Cwn1yC5ao2VdAOKu6HOU3m/3dW8VSJBk/wpv53w8WKpl6?=
 =?us-ascii?Q?8GaowLA6AU00PNYWSMa7raA6jS7Yo3rSf+bLbxNKXJJbVFu/mWMUTMbfg4UJ?=
 =?us-ascii?Q?VsaiYJzSVRuNCA9CmA/N2uuTptJnjjeTFimuqAQRHGypWxgFbgkVSVI1XzLQ?=
 =?us-ascii?Q?orrPidDv60mrOLod1qIQv4z/Xddacw15k6hnoOneaT7zufhFcpePx6q41jaB?=
 =?us-ascii?Q?E2xncsnu0hDSegQIifnyeY3Xk3mVbxGR+7+3wNgshGz9bCIOvwUnCrC4gOyW?=
 =?us-ascii?Q?tXbl0gClsboFWTeqz9PENjbcY28wcYY3S93fhgQLaRuxg4LI6qRNODHfZrHJ?=
 =?us-ascii?Q?odCEFQF8Mh1iRlQyxcEathotKUc99JmEUyicNi0rAGYxECYpF4XN/fYe3i4R?=
 =?us-ascii?Q?jXO9lDqYnAeTmNCrnsaJ4jmqa8/gAXIHny/bZoORF9/eWDmfWZTlGXP7GOzY?=
 =?us-ascii?Q?D04Zs/5FN9oWvAY0iPjsjau1VmOVToHknQbd0pwFA8oWpjRqpHZ9vKpGUSEs?=
 =?us-ascii?Q?1qUcXLI6u6gKzuV0nHMKRi3hDizkh2y+tjtajo/H1Qlz7N/kNON1+SZr9QCQ?=
 =?us-ascii?Q?hEM5KJi4086LoydYWFEwddYVdA46C35Woy/nvzts64ua9NVA+P3fWHuC4A/e?=
 =?us-ascii?Q?GN7NAQqPZ3oU2z/66RmOxm6uDPyDl38hPV9yj126HXaLvlN5c2Xt1alCRMtY?=
 =?us-ascii?Q?8A+XNGd/jgUvqcIo8nWOkP/PkOagHqyMO1U10ajVzLV8HiXjVrmtInNDFb87?=
 =?us-ascii?Q?TxPrfZZ8LVZi4hryKyk316J5eG/ftG2bXa0WDSHpW4Px1Q2qAdoeciCoMTmO?=
 =?us-ascii?Q?B0pnMJrQ95pMKPKdf90QQZVw4DBNFgt173C/UQBiXRBzYjqYZSlVV5hZdV8M?=
 =?us-ascii?Q?HCpncFerzzH0nQ5Z/6H8Z3W36fa2T2Sk9hhBB83PzGzTni2+jWy39K7NRGuP?=
 =?us-ascii?Q?FRpJPrusB3T3YMUqU5RQxthLAC4hkvynNIEkrKJQYgOqjFQythOyMNx8zHJK?=
 =?us-ascii?Q?tBa99wSwJvjgMJ9SXGCBnApqsdXOH6W4QZnKMyUEWWBrqhKMmnU4sONgxE16?=
 =?us-ascii?Q?M5rQR+WAPjDtU0ZJUP/+OtKBnxSmBg4N1KWx1gnGI5E2ggxWD/1p0KEr4oZb?=
 =?us-ascii?Q?bIw6AwSDvGlcq/kbZDYqnRXfdj03MwsoKtef95Clq6B5a1hIcvoeH6N3Fwgy?=
 =?us-ascii?Q?6mSnwDl5aTHs99LWsUBU2kfPv1WvmdnpsfWrix3GGMcMbxxNhlj2yHtluq0F?=
 =?us-ascii?Q?GCUfDu/t2GgIBKLdC/yHST+XbbIuDu4WM+jCnfKblPxcL/bAUooi1EkVwehw?=
 =?us-ascii?Q?XiKaSGoibUAKw0ucmcH1qciH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5vtyPG9ehIfr8jgxxBMqzSKYsybTbSNomhzXfiCn26QvoBlN0Jj0MOVDwFu?=
 =?us-ascii?Q?Fe9g9DIkZ8eog/TK32sXNlvkhjOa9mA+XHPyuPK8Zc0zMZKmdtBDxkRucTX0?=
 =?us-ascii?Q?2mTHMdeuz2vDAR7Oa2j40hXw2Q00AkxOFzMhLE+JviCjN5ktorQeNR/snqVo?=
 =?us-ascii?Q?xZpwToSnVsw9se7JfV5v196sqo2RjKnAgVHzgsGyyc5XWcAXOG1K24x8egV0?=
 =?us-ascii?Q?gjAzWJXDZTamTCm5CMd5RJCnutmitNIIL1/dqZts9lAanP9Ki3Qe8RXhbuCt?=
 =?us-ascii?Q?2tGTNBLHGpC6Upd/R8K20wNTgzXtgdxYateq6ALXBcXDeF2jEybBqcsbg47v?=
 =?us-ascii?Q?OqfnAuoH5Gtz/Aa7F64vm4oAyyRRKgEervjqB82O4WIaFs0+7rEA8Xu2WuS5?=
 =?us-ascii?Q?S6/gykj1uSEfydF0BAbzvvzQgnknUCHZ/u8Tsf9X53n8qn0HT2sunBhd8RHs?=
 =?us-ascii?Q?GFIGevYP0BwFMiSb4eRbZktf2UVXT+PVyN640+Ke94xIwkVtb+Tu/6C9/tsD?=
 =?us-ascii?Q?qg96RsmbH8P/vELbTzD3oOtGPz8KBGi6f1PJSj0H/3441WEZ3BuMBhFXTxkT?=
 =?us-ascii?Q?Mj+LIOT2BdpBlEuIaYWli1EpX7mhrTwIMcCR/Wm/we73+WQiwJxguy0GwWvx?=
 =?us-ascii?Q?IIJirlJr3nuS/PFiNPPVbRmvXaq5flzBAwqEvZCybv6nE9Zpk3B5ZQzurvwQ?=
 =?us-ascii?Q?vzQGc52jwwPdhiPGZuOzsiFIk9CWH7f+FPo1TOfh+O4KV3A0/dgNtGkkwAze?=
 =?us-ascii?Q?ZNwHwwQcgPGUhrSy4SlUWergz5CKvNFJYu5Da0ehbV2gNK/+MhRruU+kf8Fb?=
 =?us-ascii?Q?nUosDFsVVvphjh4rOgCqoTBrbVmbNwnJmWbZRaF5gt9L4TcZu+BoJVLzfdvt?=
 =?us-ascii?Q?PYYDEsffrnaMbeh8VcgiI2k9UHiQS8Oc/H4DW3ViiL3YgwtqaCa36V9seU31?=
 =?us-ascii?Q?hH82xok3gwR5KTty18DPRTjYP6d5aLruvVS0sGSw1r6XeFRo7PPMOGubvM2F?=
 =?us-ascii?Q?ras3KepVT/qREttuOAuGVgvjpGP6hOv+5IIbvLmGbrabC73yfWbUw115IEKL?=
 =?us-ascii?Q?nMlNBpyRMxE9sbiaxyf+TBa56luhViCxmZkgKpHkT6juMhVtFwawyEQB4b0t?=
 =?us-ascii?Q?biRLyaHCpkOQ8dc9sh8qvY8LwbTWRkyPu6gkHdD4Y7Z1hEf/MRn1tKmf8dnL?=
 =?us-ascii?Q?RcOCauQRKfkb9p3vmPtGJO4s8GH5YWKvc6yuJCfZB47YaPa8sQWuhcu5y+lw?=
 =?us-ascii?Q?Qrcz68nPjZtSyBnPqtGAg0nSnP+y9XPdGi7iC2gjBrTLz6Pca/Erw/4tnjCi?=
 =?us-ascii?Q?x9BmwmfgTtPQc53rjWH3TuI+NEDJvPj4D9ij68uC9odZqODZ25T2KWH2aEtF?=
 =?us-ascii?Q?daeMOytMHsy6KwOFgXfCYrbeKJmOUYCTgHSn+keVWKUyo6QGIlsqzE+2wmnZ?=
 =?us-ascii?Q?t4suDsIXpv9kCeKsZNXuHCDMaeNykmVg0IC7DRbsHTKPVQ2LcnAXwnW2eJzp?=
 =?us-ascii?Q?wp977ADiknm72PydHMNAY7u7lrJJz731p8gB9J2NYCd1dHuJAqxKbwSNEUaZ?=
 =?us-ascii?Q?He7Un39G3GrW3oS5Kffny7lkOeiVc+iniCyxVUTA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 591d4465-1944-4e05-6cc0-08dceed469cb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:52:05.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aui4MA3oA+p4fM68Cf2hNf8NNOgA9IO4+2Z7LrPl6ft4zjc5rhx2HWzRWMpRNzUUBmCcEyDYgH7XPXsevXNGfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4665
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:20 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Endpoint decoder mode is used to represent the partition the decoder
> > points to such as ram or pmem.
> > 
> > Expand the mode to allow a decoder to point to a specific DC partition
> > (Region).
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> A few comments inline about ways that can make this a little tidier
> and less fragile.

All Done.  Yea good idea on the enum.

Ira


[snip]

> >  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> >  		translates from a host physical address range, to a device local
> >  		address range. Device-local address ranges are further split
> > -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> > -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> > -		'mixed', or 'none'. The 'mixed' indication is for error cases
> > -		when a decoder straddles the volatile/persistent partition
> > -		boundary, and 'none' indicates the decoder is not actively
> > -		decoding, or no DPA allocation policy has been set.
> > +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> > +		memory) range, or Dynamic Capacity (DC) range.
> 		memory) range, and Dynamic Capacity (DC) ranges.
> 
> (doesn't work with preceding text otherwise)
> 

[snip]

> > +	if (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7) {
> > +		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > +
> > +		rc = dc_mode_to_region_index(mode);
> > +		if (!resource_size(&cxlds->dc_res[rc])) {
> > +			dev_dbg(dev, "no available dynamic capacity\n");
> > +			rc = -ENXIO;
> > +			goto out;
> Probably worth adding a precursor patch that uses guard(rwsem_write) on
> the cxl_dpa_rwsem
> Allows for early returns simplifying existing code and this.

[snip]

> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 85b912c11f04..23b4f266a83a 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -205,11 +205,11 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> >  	enum cxl_decoder_mode mode;
> >  	ssize_t rc;
> >  
> > -	if (sysfs_streq(buf, "pmem"))
> > -		mode = CXL_DECODER_PMEM;
> > -	else if (sysfs_streq(buf, "ram"))
> > -		mode = CXL_DECODER_RAM;
> > -	else
> > +	for (mode = CXL_DECODER_RAM; mode < CXL_DECODER_MIXED; mode++)
> > +		if (sysfs_streq(buf, cxl_decoder_mode_names[mode]))
> > +			break;
> > +
> Loop over them all then do what you have here but explicit matches
> to reject the ones that can't be set.
> Add a MODE_COUNT to the end of the options.
> 
> 	for (mode = 0; mode < CXL_DECODER_MODE_COUNT; mode++)
> 		if (sysfs_streq(buf, cxl_decoder_mode_names[mode]))
> 			break;
> 
> 	if (mode == CXL_DECODER_MODE_COUNT)
> 		return -EINVAL;
> 
> 	if (mode == CXL_DECODER_NONE)
> 		return -EINVAL;
> 
> 	/* Not yet supported */
> 	if (mode == CXL_DECODER_MIXED)
> 		return -EINVAL;
> ...
> 
> > +	if (mode >= CXL_DECODER_MIXED)
> >  		return -EINVAL;
> >  
> >  	rc = cxl_dpa_set_mode(cxled, mode);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 8b7099c38a40..cbaacbe0f36d 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -365,6 +365,9 @@ struct cxl_decoder {
> >  /*
> >   * CXL_DECODER_DEAD prevents endpoints from being reattached to regions
> >   * while cxld_unregister() is running
> > + *
> > + * NOTE: CXL_DECODER_RAM must be second and CXL_DECODER_MIXED must be last.
> This is a bit ugly. I'd change the logic a bit to avoid it.
> The list of things we don't support is short so just check for them.
> See above.
> 

[snip]

