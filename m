Return-Path: <linux-btrfs+bounces-14578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB86AD2DB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 08:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5A116FF91
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1597625F97E;
	Tue, 10 Jun 2025 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHvAIbmK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0625F976;
	Tue, 10 Jun 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535493; cv=fail; b=MR1xNY4QSE6wlsjnpGB7/IacvnXjrSwRMWVZuHJQpwgdMmJGUVqQjWxYuv9nTPUAQLtyy8wO/+BDhOmXnyPPvzyPjOA8LP7KQFi4uC3eT89aVGFRCXx/h2QZAoYvD0Jmqv0lYO7dcXuwInp31DLG3yoSpP+8vydoyhgpdgp9nbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535493; c=relaxed/simple;
	bh=R7uQp0uB6kNZHJwzpLS5eO+SlJWdWvfVFgaof193G8A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VdlJfxOiFOfgf/oO2kfu6ExsRws3lpgcI5fy1vXB8SdRJT8alZiD7+ex5iGoFp9EwNSREbvHi+/3l/HvKmFZLFsDm3Hq4vmm60GMB6o1o8BTtP1RXukiVkqmJMziOL/5KB7PIEkc7oCx20SzqAiFx4gp8G53cLyEdCmm0K3sItk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHvAIbmK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749535490; x=1781071490;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=R7uQp0uB6kNZHJwzpLS5eO+SlJWdWvfVFgaof193G8A=;
  b=lHvAIbmKgbj/GxOQsrulfoFCekhESm6NTlTxpFr3+bkrZFjv3DUKDKHu
   CKNMraPZ4LHNT3zpuxuBM0MHIhidmJHcSS1MPPrKF/wa/RlwZysEiRbbn
   qCo9puZ+SnjcTCR8a4SWch8CyEq3gKftbHKXeFDzxXP8UzMuEm4PXA6IX
   2MOlrG5Whe+xSLMCE1VFYeGXUxeLuXgzNo8ymE5+FO9buhB+t6DcmBhSs
   rjhdElXvMkAa9fdr+t+26uyE6mLnEJM2dudYOAMP3gjveaAKGZuxPlmpy
   9YdOT2NGLW/MOtj92CHxRPeHyFu0lQqgAxzsnXgBWQB6M8NgezqrdBsVD
   w==;
X-CSE-ConnectionGUID: Yl1EBXZRSomQaikbPY2yoA==
X-CSE-MsgGUID: M2hdVk1MQTSw6HBJV/woJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51769424"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51769424"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 23:04:49 -0700
X-CSE-ConnectionGUID: mI94Dm1sSpi4+W6lhF47Fw==
X-CSE-MsgGUID: rJdexgIvTT2FujFAEIuYdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146652004"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 23:04:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 23:04:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 23:04:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.55)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 23:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+Ta9t9bQL+a2SgyBz7Ki8a4oOx4PSYDQ18SWMchcpF3IpMcfDqQGZoO66Epv4qkUStNr4jTo6CmAtvyx6zcD5GLHJjO8OpgJIKidhuHdgVlrX6pVqT8MhjYIq6KSKxAzGIt+XO1MsIYfx46+97/pZdh+QkOWQN3h1AO9UvNEkgtwKZO4n/xTdu5zs+zNBubTuKDT/0PYW5TmHilwgrPiUKelt0MYGRd7lHhUAOjnIxRgz7QngsoeIctDg66tCQJjPqTipGmJEsI7xhr7xqpCgm7yPEQb0Kv9BlSWPPUJLSc945xhZwJgw8ZA9DCU12IchwSJ0wTOuBoj751vlwfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIIXN2EXD9xR9VkzI9jBCqupx7VQewggVolkazUtNXI=;
 b=bucwgXg71q8J1VbgtcOuT40Y9sM5WLVas29bF9UP+cH606wTuqdbu6DzPhr4TwbCQzzbzsSMIiLTVUHEhBuooNL2PEFk/oKgGPWYFh8+bFGqhnHdXOfMNTVsnQDCNsiVvElLt9foSk8yZ2of1nbgUtIQDuIVBA/J1SavGMqFVCan5e2GRK+YgoQRvr8n73ydJRqrf65515cuelZ1ZOVFUTFapaRqvgEh7bcbrag7sGjrjiMuBiztMOfNC3MXIoQV6Un3YTBJXWQfoF8rykdmY570VmmmIavHznVgg3TER/mFvloAoRTwkK0xE3v328xO8lSyjBXsdAbxSBjOe93eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8307.namprd11.prod.outlook.com (2603:10b6:930:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 06:04:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 06:04:20 +0000
Date: Tue, 10 Jun 2025 14:04:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Filipe Manana <fdmanana@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
	<linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  5e85262e54:  stress-ng.fallocate.ops_per_sec
 40.7% regression
Message-ID: <202506101357.7ada85f6-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb88ec6-e75d-4c23-68b2-08dda7e4a411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?SjFuYo3CEHIpu52NMCzcqYSgisu6CCiGTFb/pKqHxnld5HkWK50AdP6oDL?=
 =?iso-8859-1?Q?6NuN7dXha3yp0dprP122uc26sWhGHOT8EaEe6Faas0k7o6SC88G3F72ipP?=
 =?iso-8859-1?Q?o9OIAiaNT/xzu5Lh/DEj131SH/jbpOa/gBeoEBZ5xI4vhfQBgWlP4A02re?=
 =?iso-8859-1?Q?R8gLfR5iKdsbc1WxfuKcwLFuQfqGl07ek2u0TGzON/yT+hJrxW6hdnFjpp?=
 =?iso-8859-1?Q?TgFaBWzQJRkhijkG6DsU/yqRavevMw3IEkGo2xvUXo/lpOuf3rBk2LQvBk?=
 =?iso-8859-1?Q?kuBtrFY6vhzDGbiH3XhI+cNg5/5WyF8DCVWNt9JFWBYu+Trnuw7ihElVDM?=
 =?iso-8859-1?Q?GGSNoXxdSBTiAal/yANtw87L+S9Mh3WT3niU/vY9DchtrJrmprJFxvv2iL?=
 =?iso-8859-1?Q?YoO3JPsYjCeMa4Y1w2jgwoM6Ibg1xUr9F9LRhnzPgKD7HebbEU3kqXHgII?=
 =?iso-8859-1?Q?voH80psleelvXhHNdXxSXAX5NkZ4bgs2rzWz27iYKCGTUCFLt5FEcsM/1t?=
 =?iso-8859-1?Q?JLsdeoC6JAVOXqV6cutRAaiV5QQnYmOO0qvj6pQqmIXSETBXDvig1JtSfg?=
 =?iso-8859-1?Q?NyNOXJnScpRqoIh2D+Ya5Bv5+5PIGrtc/iqTnF2x0hPXdiQtfa8InVzm41?=
 =?iso-8859-1?Q?wHwG+iHsQeYkMOYjIssjUp6Qa+WqJfGuJ8Oyz8bFnEc6j1SxIVkZoUmj0d?=
 =?iso-8859-1?Q?0ou4aRlsLboN8UL/YmLVAiZ3VlVhKOjl6oG6rt4uIRUnzgLrYd3z/PWZlW?=
 =?iso-8859-1?Q?pN7j6ueQOUJULsKQOPMIMe8R0CYdf+Dj9MOocNuQusy+PrkrT6Aa0NiDZp?=
 =?iso-8859-1?Q?XVoE1Dw3c+Xf33br+sKF2iGoysNZwaMtjjBJJyUl9ppTn9EWp32o6c1wyo?=
 =?iso-8859-1?Q?amgdoWOaonhkiTyfdMiWrRm7I33iTDgfcW6FPnxa+oO7MocFavma04x/7T?=
 =?iso-8859-1?Q?aVXtI+wl1pPKdydI6SpmkIElcdURKEVy/vXOel++okDG+7tHUW1Vd1q9ip?=
 =?iso-8859-1?Q?YL1p0YYBXn1wV1TNq/sn46OflGDfHQEFDBKwhjGI5NI2UmhSzWbSF2IhS1?=
 =?iso-8859-1?Q?I5lFPb0OoKpqLwSSoCMGAxV/krIBNpLrUJDVlVjCD4S2bCKYRx4MXu11ZY?=
 =?iso-8859-1?Q?G6ikTfSEOr4tTrqmDtJf1SAOlQmgwUmtnLbTA5YYCq7xCtVE0lnwTLSCQX?=
 =?iso-8859-1?Q?bn+QD/uT+/k7QzT+FbDL0GghiaEDlZ4czGVj7QYm4/4eKmTjqQjZd7alKY?=
 =?iso-8859-1?Q?iIB1ZIgI9+CxKZfWJAbwKmozuwqoiwGE5x3dAvPrgdw+rUpqgAcW1dmwj3?=
 =?iso-8859-1?Q?vvc73rDxU/VQtgWNY3GfieR9CI6OjR/d3AYxBqLoQiRqSV+ZQ9Dyq/H1xC?=
 =?iso-8859-1?Q?X7cuYpe9JCPnE1ZGvaYIUyYMMV9Y8LjsuyAUdmJTND+5OAcOeCJyNl9r/w?=
 =?iso-8859-1?Q?FWhC5cGTsEfiR/fC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5uxhQIWDS2tM4y1XjsoakiFeSWC8C81JZ8MrCk781BXXGW0xiiGS0jVcbd?=
 =?iso-8859-1?Q?75TnAsYMnKM91PDzLmlcV9cebh3C6fkg9DjLf8LeSGNUm/Wzv6VD7bO5gt?=
 =?iso-8859-1?Q?V8ZS7fb6d7ofzaM4s/YrymFs2bbRLWdXxJTSJ6DCthK26LU5QO+TmBnsm2?=
 =?iso-8859-1?Q?/1nwL9Q6VbMCG+FAIIhkq7j+3K1fYaDkCeTBRs4m/49OcY7vf9cZJBXY09?=
 =?iso-8859-1?Q?yoe2hNwFM8kk5GeKDaT7E1LlBqdSxF5wAEtx9D7lVS/rKmUgihpEq25E/2?=
 =?iso-8859-1?Q?6Ulfv7+lr7NRQLw/w5V4XbrM8fhAG94MXpi4tW1cymW8aJT8NfNxuvdYQM?=
 =?iso-8859-1?Q?7XdEbVq7Ix44u7Dk6wEiVAC6r/wO1K85OWBsF0j0l6mzJRq5XoHlOKNr5L?=
 =?iso-8859-1?Q?KVQKAMPJmQ3s/9WfWoDElthwubiKhysSmKqX514DMzbA0Of5XV7ZzAHxqD?=
 =?iso-8859-1?Q?ptkS4T6Uj315lifLdCndXpcxrwZnWJsOIM/A6HrsJ+KANZOeLrIXgc2Fli?=
 =?iso-8859-1?Q?6NfudKpr1xwgf09a/mhk1TxndtyT/xBetV0KxV4WSC+o8+0qvnMVWoL8iG?=
 =?iso-8859-1?Q?2IU5j3XCYcTGYqjflEZIiownOFfC5CmWuDWkZZkZYLw9qeSyB2qve5AuTB?=
 =?iso-8859-1?Q?x7T6EX0Se1U3sQr9S6J0hS3s5j9X6eOek75n155TfdbMgfWTrNb15osq88?=
 =?iso-8859-1?Q?kSy48Kc+q9aXWH1RYIHNb/9nA8UCfd7LX0sBafYpZRSXpZ04k+O3wgBAop?=
 =?iso-8859-1?Q?beeyeeqQ2iV4cKk9CdUdC33/l8S7ZCKVNFmkZ8LHCB1rPLxP0N0dBqJ6lT?=
 =?iso-8859-1?Q?onVJbCNGkncFluWVucDq3iCJVBsaN671XgnRapZ9UVpzULbaoda53zKC01?=
 =?iso-8859-1?Q?1OhqBH0+VWivezuu024CcKkQm90PD7Z77x+juf4mEdTwCt8FgfJNTDSMsR?=
 =?iso-8859-1?Q?u9MSSeCqgCWMtjAnhc1RdxPHZcVgmCTxpTjbYQ2iTzTb9JHA/Ys92bd18X?=
 =?iso-8859-1?Q?oPbUTcTSd/QxdpLyaTuO9POeUhAi7AsAV5edvB75awg5PaTdp95LFun2wj?=
 =?iso-8859-1?Q?Cs5MkibkFbx7LSSBjylvC6fBLMvw3dNL6Zg1V9XlrtGTtmRQWMvXGDZK5T?=
 =?iso-8859-1?Q?EXr95ztB2lAR+m/l5qVQT8XVOYFaa2OnQiOz6cv4e4ej0Yu7I4j3Jxw6Jh?=
 =?iso-8859-1?Q?VKAf+6x8nrnRhlUl3P9TVY53XBAs/eULnb2VJvH/VfbjrWMhYJCx24EB/x?=
 =?iso-8859-1?Q?YHraOMU8B6aZb7NoCqAea1XoJGfQjgui/vBTRJKFaGudaiNqEEmnueOf4h?=
 =?iso-8859-1?Q?cHpcbsG6ujTJ8EWseksPAKjxgJVlAkQdFU8dchDNp5It/SWcd2TXbwKws9?=
 =?iso-8859-1?Q?dlNOUVddurHSaF/FSj/43LWBnLx6XG4fZCFplGkfjrErfpqSlCDnbwwxB5?=
 =?iso-8859-1?Q?h1Iht9AuCxlUlvSF0V8BKMsYhfK+BQSYtKmPAb4uI/Bc1l0Zr+zHYun+hI?=
 =?iso-8859-1?Q?Vs6xIzymBfkWeXhoGGxejdfQ83JPKEDT/v8VybWpuA8Zz9RHiDYLwQbAiS?=
 =?iso-8859-1?Q?SbhztzSA0ty16WJGyubF/iaiEt85WdO1ItuAopdK2Zs5B8o8xXkjSqNrcT?=
 =?iso-8859-1?Q?wqFmtTPHlRLaelPWwLAWGSNNv6GjsqXg2h2tcqaWIt0JiV+QCN0JhU6A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb88ec6-e75d-4c23-68b2-08dda7e4a411
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:04:20.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXYRl5AsT1Iu/irPgbHf08/qC6aIOT2b1UC53dHVfpfGiI9cpoJoPU8+i/+1fG4TL+lYrKnEdr5uNK1AxXE9Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8307
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 40.7% regression of stress-ng.fallocate.ops_per_sec on:


commit: 5e85262e542d6da8898bb8563a724ad98f6fc936 ("btrfs: fix fsync of files with no hard links not persisting deletion")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      4cb6c8af8591135ec000fbe4bb474139ceec595d]
[still regression on linux-next/master 3a83b350b5be4b4f6bd895eecf9a92080200ee5d]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: fallocate
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.copy-file.ops_per_sec  33.6% regression                                   |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs=btrfs                                                                                       |
|                  | nr_threads=100%                                                                                |
|                  | test=copy-file                                                                                 |
|                  | testtime=60s                                                                                   |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506101357.7ada85f6-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250610/202506101357.7ada85f6-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp4/fallocate/stress-ng/60s

commit: 
  846b534075 ("btrfs: fix typo in space info explanation")
  5e85262e54 ("btrfs: fix fsync of files with no hard links not persisting deletion")

846b534075f45d5b 5e85262e542d6da8898bb8563a7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      6816 ±  3%     +54.4%      10526 ±  4%  uptime.idle
 8.564e+09            -8.8%  7.813e+09        cpuidle..time
    358855 ±  2%     +40.2%     503142        cpuidle..usage
     36.53            +3.3%      37.75        boot-time.boot
     27.16            +3.6%      28.15        boot-time.dhcp
      4346            +3.3%       4489        boot-time.idle
     26.69 ±  8%    +173.5%      72.99 ±  8%  iostat.cpu.idle
     72.51 ±  3%     -65.0%      25.36 ± 22%  iostat.cpu.iowait
      0.47 ±  4%    +170.8%       1.27 ± 17%  iostat.cpu.system
   1260573 ±  8%     -36.7%     798065 ±  4%  numa-numastat.node0.local_node
   1333347 ±  7%     -35.6%     859241 ±  5%  numa-numastat.node0.numa_hit
   1310625 ±  8%     -43.1%     745116 ±  4%  numa-numastat.node1.local_node
   1370277 ±  7%     -40.4%     816368 ±  5%  numa-numastat.node1.numa_hit
     72.60 ± 10%     -36.6%      46.00 ± 22%  perf-c2c.DRAM.local
     76.80 ± 11%    +328.5%     329.10 ± 30%  perf-c2c.DRAM.remote
     36.50 ± 19%    +864.1%     351.90 ± 29%  perf-c2c.HITM.local
     31.00 ± 15%    +522.3%     192.90 ± 31%  perf-c2c.HITM.remote
   4718134           -11.1%    4195454        meminfo.Cached
    325934           -84.9%      49200 ± 24%  meminfo.Dirty
    977794           -54.8%     442223 ± 15%  meminfo.Inactive
    977794           -54.8%     442223 ± 15%  meminfo.Inactive(file)
    114582           +16.1%     133034        meminfo.Shmem
    414480           -53.3%     193720 ± 23%  meminfo.Writeback
     26.65 ±  8%    +173.9%      72.98 ±  8%  vmstat.cpu.id
     72.54 ±  3%     -64.9%      25.47 ± 23%  vmstat.cpu.wa
    107799           -37.1%      67824        vmstat.io.bo
    117.81           -72.1%      32.92 ± 23%  vmstat.procs.b
      3650 ±  2%     +78.2%       6506        vmstat.system.cs
      6900 ±  3%     +70.7%      11777 ±  7%  vmstat.system.in
     24.55 ±  9%     +47.7       72.22 ±  8%  mpstat.cpu.all.idle%
     74.66 ±  3%     -48.5       26.12 ± 22%  mpstat.cpu.all.iowait%
      0.02 ±  5%      +0.0        0.03 ±  4%  mpstat.cpu.all.irq%
      0.02 ±  2%      +0.0        0.03 ±  5%  mpstat.cpu.all.soft%
      0.41 ±  5%      +0.8        1.22 ± 18%  mpstat.cpu.all.sys%
      0.34            +0.0        0.38 ±  2%  mpstat.cpu.all.usr%
      2.00          +445.0%      10.90 ± 59%  mpstat.max_utilization.seconds
    158860 ±  7%     -85.3%      23387 ± 26%  numa-meminfo.node0.Dirty
    474882 ±  5%     -52.9%     223821 ± 14%  numa-meminfo.node0.Inactive
    474882 ±  5%     -52.9%     223821 ± 14%  numa-meminfo.node0.Inactive(file)
    201670 ±  5%     -52.3%      96112 ± 20%  numa-meminfo.node0.Writeback
    166889 ±  6%     -84.6%      25642 ± 28%  numa-meminfo.node1.Dirty
    502047 ±  5%     -56.4%     218867 ± 17%  numa-meminfo.node1.Inactive
    502047 ±  5%     -56.4%     218867 ± 17%  numa-meminfo.node1.Inactive(file)
    212352 ±  5%     -54.0%      97712 ± 29%  numa-meminfo.node1.Writeback
    906.60           -43.5%     512.00        stress-ng.fallocate.ops
     14.30           -40.7%       8.48        stress-ng.fallocate.ops_per_sec
     65.75            -8.0%      60.48        stress-ng.time.elapsed_time
     65.75            -8.0%      60.48        stress-ng.time.elapsed_time.max
  14854172           -42.8%    8502297        stress-ng.time.file_system_outputs
    750.40 ±  5%    +130.1%       1727 ±  9%  stress-ng.time.involuntary_context_switches
     40.40 ±  6%    +263.4%     146.80 ± 20%  stress-ng.time.percent_of_cpu_this_job_got
     26.79 ±  6%    +231.8%      88.89 ± 20%  stress-ng.time.system_time
     46451 ±  4%    +190.9%     135122 ±  2%  stress-ng.time.voluntary_context_switches
    197148            +2.7%     202432        proc-vmstat.nr_active_anon
   1859510           -42.8%    1064284        proc-vmstat.nr_dirtied
     81387           -84.9%      12287 ± 26%  proc-vmstat.nr_dirty
   1179517           -11.0%    1049203        proc-vmstat.nr_file_pages
    244166           -54.7%     110697 ± 15%  proc-vmstat.nr_inactive_file
     43062            +1.4%      43664        proc-vmstat.nr_mapped
     28656           +15.9%      33198        proc-vmstat.nr_shmem
    103481 ±  2%     -53.2%      48448 ± 23%  proc-vmstat.nr_writeback
   1855961           -42.8%    1062406        proc-vmstat.nr_written
    197148            +2.7%     202432        proc-vmstat.nr_zone_active_anon
    244166           -54.7%     110697 ± 15%  proc-vmstat.nr_zone_inactive_file
    184834           -67.1%      60733 ± 23%  proc-vmstat.nr_zone_write_pending
   2705223           -38.0%    1677261        proc-vmstat.numa_hit
   2572798           -40.0%    1544833        proc-vmstat.numa_local
   2754538           -37.3%    1726600        proc-vmstat.pgalloc_normal
   2722111           -39.5%    1645913 ±  3%  proc-vmstat.pgfree
   7427330           -42.0%    4306316        proc-vmstat.pgpgout
    908534 ±  5%     -40.5%     540322        numa-vmstat.node0.nr_dirtied
     39714 ±  7%     -85.3%       5835 ± 26%  numa-vmstat.node0.nr_dirty
    118740 ±  5%     -52.7%      56112 ± 14%  numa-vmstat.node0.nr_inactive_file
     50433 ±  5%     -52.3%      24033 ± 20%  numa-vmstat.node0.nr_writeback
    906619 ±  5%     -40.5%     539353        numa-vmstat.node0.nr_written
    118740 ±  5%     -52.7%      56112 ± 14%  numa-vmstat.node0.nr_zone_inactive_file
     90132 ±  5%     -66.9%      29866 ± 21%  numa-vmstat.node0.nr_zone_write_pending
   1333077 ±  7%     -35.5%     859486 ±  5%  numa-vmstat.node0.numa_hit
   1260303 ±  8%     -36.7%     798310 ±  4%  numa-vmstat.node0.numa_local
    950974 ±  5%     -44.9%     523966        numa-vmstat.node1.nr_dirtied
     41787 ±  6%     -84.6%       6454 ± 29%  numa-vmstat.node1.nr_dirty
    125464 ±  5%     -56.2%      55001 ± 17%  numa-vmstat.node1.nr_inactive_file
     52957 ±  5%     -53.9%      24413 ± 29%  numa-vmstat.node1.nr_writeback
    948799 ±  5%     -44.9%     523041        numa-vmstat.node1.nr_written
    125464 ±  5%     -56.2%      55001 ± 17%  numa-vmstat.node1.nr_zone_inactive_file
     94729 ±  5%     -67.4%      30867 ± 28%  numa-vmstat.node1.nr_zone_write_pending
   1369690 ±  7%     -40.4%     815898 ±  5%  numa-vmstat.node1.numa_hit
   1310039 ±  8%     -43.2%     744646 ±  4%  numa-vmstat.node1.numa_local
      2.21            -8.8%       2.02 ±  4%  perf-stat.i.MPKI
   6.4e+08           +15.0%  7.358e+08 ±  3%  perf-stat.i.branch-instructions
      2.82            +0.9        3.76        perf-stat.i.branch-miss-rate%
  28372748           +15.8%   32852598        perf-stat.i.branch-misses
     13.29            -3.9        9.40 ±  2%  perf-stat.i.cache-miss-rate%
  22292540           +32.9%   29636364        perf-stat.i.cache-references
      3470           +84.5%       6402        perf-stat.i.context-switches
      0.96          +106.4%       1.99 ±  4%  perf-stat.i.cpi
 3.473e+09 ±  2%    +100.3%  6.957e+09 ± 14%  perf-stat.i.cpu-cycles
    176.57           +32.0%     233.00 ±  2%  perf-stat.i.cpu-migrations
    885.32 ±  3%    +109.0%       1850 ±  8%  perf-stat.i.cycles-between-cache-misses
 3.127e+09           +13.2%  3.541e+09 ±  3%  perf-stat.i.instructions
      1.17           -32.0%       0.79        perf-stat.i.ipc
      4118            +6.8%       4398        perf-stat.i.minor-faults
      4118            +6.8%       4398        perf-stat.i.page-faults
      0.96            -7.9%       0.88 ±  3%  perf-stat.overall.MPKI
     13.47            -2.9       10.56 ±  2%  perf-stat.overall.cache-miss-rate%
      1.11 ±  2%     +77.0%       1.96 ± 11%  perf-stat.overall.cpi
      1153 ±  2%     +92.8%       2225 ± 13%  perf-stat.overall.cycles-between-cache-misses
      0.90 ±  2%     -42.8%       0.52 ± 11%  perf-stat.overall.ipc
 6.293e+08           +14.9%  7.231e+08 ±  3%  perf-stat.ps.branch-instructions
  27913642           +15.6%   32280223        perf-stat.ps.branch-misses
  21928606           +32.8%   29130512        perf-stat.ps.cache-references
      3413           +84.3%       6292        perf-stat.ps.context-switches
 3.407e+09 ±  2%    +100.9%  6.847e+09 ± 14%  perf-stat.ps.cpu-cycles
    173.70           +31.8%     229.01 ±  2%  perf-stat.ps.cpu-migrations
 3.075e+09           +13.2%   3.48e+09 ±  3%  perf-stat.ps.instructions
      4028            +6.6%       4295        perf-stat.ps.minor-faults
      4028            +6.6%       4295        perf-stat.ps.page-faults
      0.04 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_folio
      0.09 ± 10%     -90.6%       0.01 ±299%  perf-sched.sch_delay.avg.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bbio.submit_one_bio
      0.17 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
      0.03 ± 53%    +311.8%       0.11 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.01 ±286%   +1043.8%       0.11 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      0.12 ± 15%     -91.4%       0.01 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
      0.07 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_folio
      0.14 ± 24%     -93.7%       0.01 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bbio.submit_one_bio
      0.91 ± 29%    -100.0%       0.00        perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
      0.09 ± 46%   +3267.9%       3.02 ±230%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.01 ±277%   +6419.2%       0.65 ±123%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      0.18 ± 11%     +40.1%       0.25 ± 13%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    311.05 ±  4%     -79.9%      62.61 ±  2%  perf-sched.total_wait_and_delay.average.ms
      6694 ±  3%    +331.4%      28884 ±  2%  perf-sched.total_wait_and_delay.count.ms
    310.98 ±  4%     -79.9%      62.51 ±  2%  perf-sched.total_wait_time.average.ms
    258.61 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
     31.59 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.25 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    517.55 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
     61.81 ± 21%     -96.4%       2.24 ± 62%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      4.06          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.85 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     16.81 ±  7%     -40.1%      10.06 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.08 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     71.10 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
    124.00          -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     93.80 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    816.00 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
    896.30 ± 20%     -53.8%     414.40 ± 31%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     44.40 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     87.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    283.50 ±  6%     +59.7%     452.70 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     36.00          -100.0%       0.00        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      2195 ±  2%     -42.3%       1266 ±  6%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1312 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
      1503 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.93 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1775 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
      1699 ± 13%     -92.7%     123.85 ± 56%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      5.24 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.94 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.18 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    520.63 ± 38%     -99.6%       2.04 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
     12.11 ±297%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_folio
    550.61 ± 26%     -99.8%       0.86 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bbio.submit_one_bio
    258.43 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
    517.46 ±  4%     -98.8%       6.46 ±116%  perf-sched.wait_time.avg.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
     61.80 ± 21%     -96.4%       2.22 ± 62%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      6.98 ±198%    +503.0%      42.09 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.11 ±298%   +5798.7%       6.59 ± 16%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
     16.72 ±  7%     -40.3%       9.98 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1160 ± 36%     -99.8%       2.04 ±300%  perf-sched.wait_time.max.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
     36.11 ±298%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_folio
      1344 ± 25%     -99.9%       0.86 ±300%  perf-sched.wait_time.max.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bbio.submit_one_bio
      1312 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
      1775 ± 14%     -96.5%      62.99 ±153%  perf-sched.wait_time.max.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
      1699 ± 13%     -92.7%     123.76 ± 56%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     87.05 ±203%    +562.4%     576.63 ± 58%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.11 ±297%  +2.5e+05%     276.17 ± 46%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested


***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp4/copy-file/stress-ng/60s

commit: 
  846b534075 ("btrfs: fix typo in space info explanation")
  5e85262e54 ("btrfs: fix fsync of files with no hard links not persisting deletion")

846b534075f45d5b 5e85262e542d6da8898bb8563a7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    823946           -46.9%     437583 ±  2%  cpuidle..usage
      8144 ±  5%     +24.5%      10135 ±  2%  uptime.idle
   2739200 ± 13%     -35.9%    1754761 ±  4%  numa-numastat.node0.local_node
   2802155 ± 12%     -35.3%    1811817 ±  4%  numa-numastat.node0.numa_hit
     45.55 ± 11%     +52.7%      69.54 ±  3%  iostat.cpu.idle
     53.51 ±  9%     -47.1%      28.33 ±  8%  iostat.cpu.iowait
      0.58 ±  2%    +205.6%       1.76 ±  8%  iostat.cpu.system
    214.90 ± 10%     -33.1%     143.70 ±  9%  perf-c2c.DRAM.local
    309.50 ± 17%     +44.9%     448.40 ± 17%  perf-c2c.DRAM.remote
    141.70 ± 19%     +79.3%     254.00 ± 21%  perf-c2c.HITM.remote
   4909242 ± 16%     -38.3%    3030044 ±  5%  numa-meminfo.node0.Inactive
   4909242 ± 16%     -38.3%    3030044 ±  5%  numa-meminfo.node0.Inactive(file)
     14849 ± 14%     -77.3%       3372 ± 19%  numa-meminfo.node0.Writeback
      4951 ± 24%     +55.6%       7704 ±  5%  numa-meminfo.node1.Dirty
      8065 ± 24%     -58.9%       3316 ± 21%  numa-meminfo.node1.Writeback
     45.59 ± 11%     +52.6%      69.57 ±  3%  vmstat.cpu.id
     53.47 ±  9%     -47.1%      28.30 ±  8%  vmstat.cpu.wa
    112259           -32.6%      75701        vmstat.io.bo
    119.44           -68.2%      37.98 ± 15%  vmstat.procs.b
      6317           -13.9%       5436 ±  2%  vmstat.system.cs
     14212           -14.9%      12092 ±  3%  vmstat.system.in
  11915567           -21.0%    9413763        meminfo.Cached
     13350 ±  2%     +22.6%      16366 ±  3%  meminfo.Dirty
   8170490           -30.6%    5668142        meminfo.Inactive
   8170490           -30.6%    5668142        meminfo.Inactive(file)
  14292973           -15.2%   12125438        meminfo.Memused
     22993           -70.2%       6859 ± 19%  meminfo.Writeback
  14412570           -14.6%   12307953        meminfo.max_used_kB
     43.84 ± 12%     +24.8       68.62 ±  3%  mpstat.cpu.all.idle%
     55.23 ±  9%     -26.0       29.23 ±  8%  mpstat.cpu.all.iowait%
      0.05 ±  3%      -0.0        0.03 ±  2%  mpstat.cpu.all.irq%
      0.05 ±  6%      -0.0        0.03 ±  5%  mpstat.cpu.all.soft%
      0.45 ±  2%      +1.3        1.72 ±  9%  mpstat.cpu.all.sys%
      1.00         +6100.0%      62.00        mpstat.max_utilization.seconds
      3.66 ±  2%     +94.2%       7.10 ± 30%  mpstat.max_utilization_pct
      0.59          +217.1%       1.87 ±  7%  stress-ng.copy-file.MB_per_sec_copy_rate
     18179           -33.4%      12113        stress-ng.copy-file.ops
    302.23           -33.6%     200.60        stress-ng.copy-file.ops_per_sec
  14350748           -33.0%    9617412        stress-ng.time.file_system_outputs
      1420 ±  8%    +484.5%       8300 ±  6%  stress-ng.time.involuntary_context_switches
     41.30 ±  2%    +407.0%     209.40 ±  9%  stress-ng.time.percent_of_cpu_this_job_got
     24.57 ±  2%    +415.4%     126.64 ±  9%  stress-ng.time.system_time
     89786 ±  2%     -17.3%      74281 ±  5%  stress-ng.time.voluntary_context_switches
   1160907 ± 13%     -45.0%     638139 ±  3%  numa-vmstat.node0.nr_dirtied
   1213548 ± 16%     -37.3%     761371 ±  5%  numa-vmstat.node0.nr_inactive_file
      3666 ± 14%     -76.8%     852.16 ± 15%  numa-vmstat.node0.nr_writeback
   1156044 ± 13%     -45.0%     635340 ±  3%  numa-vmstat.node0.nr_written
   1213551 ± 16%     -37.3%     761371 ±  5%  numa-vmstat.node0.nr_zone_inactive_file
      5755 ± 13%     -47.1%       3041 ±  5%  numa-vmstat.node0.nr_zone_write_pending
   2803191 ± 12%     -35.4%    1810577 ±  4%  numa-vmstat.node0.numa_hit
   2740236 ± 13%     -36.0%    1753521 ±  4%  numa-vmstat.node0.numa_local
      1244 ± 24%     +56.9%       1953 ±  5%  numa-vmstat.node1.nr_dirty
      1981 ± 24%     -59.4%     804.96 ± 14%  numa-vmstat.node1.nr_writeback
   1799013           -32.9%    1206900        proc-vmstat.nr_dirtied
      3360 ±  2%     +21.6%       4086 ±  3%  proc-vmstat.nr_dirty
   2971433           -20.8%    2353137        proc-vmstat.nr_file_pages
  29348580            +1.8%   29883631        proc-vmstat.nr_free_pages
  29282199            +1.9%   29836480        proc-vmstat.nr_free_pages_blocks
   2034863           -30.4%    1416458        proc-vmstat.nr_inactive_file
     38408            -6.3%      36004        proc-vmstat.nr_slab_reclaimable
      5706           -70.1%       1708 ± 15%  proc-vmstat.nr_writeback
   1790881           -32.9%    1201249        proc-vmstat.nr_written
   2034863           -30.4%    1416458        proc-vmstat.nr_zone_inactive_file
      8998           -35.6%       5795 ±  2%  proc-vmstat.nr_zone_write_pending
   4444162           -23.1%    3416163        proc-vmstat.numa_hit
   4311404           -23.8%    3283749        proc-vmstat.numa_local
    566.30 ± 89%   +1255.8%       7678 ±247%  proc-vmstat.numa_pte_updates
   4505726           -22.8%    3477149        proc-vmstat.pgalloc_normal
   7184379           -32.4%    4859319        proc-vmstat.pgpgout
      2.68 ±  2%     -25.7%       1.99 ±  4%  perf-stat.i.MPKI
 7.342e+08            +6.6%  7.826e+08        perf-stat.i.branch-instructions
      3.45            -0.7        2.77 ±  2%  perf-stat.i.branch-miss-rate%
  33462192            -4.2%   32070836        perf-stat.i.branch-misses
     10.22            +3.1       13.35        perf-stat.i.cache-miss-rate%
   5043813 ±  2%     -14.9%    4291664        perf-stat.i.cache-misses
  50234628           -34.5%   32914395        perf-stat.i.cache-references
      5523 ±  3%      -8.1%       5077        perf-stat.i.context-switches
      1.15          +236.5%       3.88 ±  6%  perf-stat.i.cpi
 3.417e+09          +149.6%  8.527e+09 ±  6%  perf-stat.i.cpu-cycles
    196.17           +12.1%     219.94 ±  2%  perf-stat.i.cpu-migrations
    615.76          +229.7%       2030 ±  7%  perf-stat.i.cycles-between-cache-misses
      0.97           -58.0%       0.41 ±  5%  perf-stat.i.ipc
      1.39 ±  2%     -18.2%       1.14        perf-stat.overall.MPKI
      4.56            -0.5        4.10 ±  2%  perf-stat.overall.branch-miss-rate%
     10.03            +3.0       13.04        perf-stat.overall.cache-miss-rate%
      0.94          +140.0%       2.27 ±  6%  perf-stat.overall.cpi
    677.89          +193.3%       1988 ±  6%  perf-stat.overall.cycles-between-cache-misses
      1.06           -58.2%       0.44 ±  6%  perf-stat.overall.ipc
 7.214e+08            +6.6%  7.691e+08        perf-stat.ps.branch-instructions
  32880299            -4.1%   31516354        perf-stat.ps.branch-misses
   4956935 ±  2%     -14.9%    4218155        perf-stat.ps.cache-misses
  49395581           -34.5%   32356624        perf-stat.ps.cache-references
      5429 ±  3%      -8.1%       4992        perf-stat.ps.context-switches
 3.359e+09          +149.7%  8.387e+09 ±  6%  perf-stat.ps.cpu-cycles
    192.84           +12.1%     216.24 ±  2%  perf-stat.ps.cpu-migrations
      0.09 ± 14%    +156.9%       0.23 ± 61%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
      0.11 ± 30%   +1780.8%       2.08 ±170%  perf-sched.sch_delay.avg.ms.__cond_resched.__filemap_get_folio.prepare_one_folio.constprop.0
      0.09 ± 28%   +4092.1%       3.64 ±235%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.set_extent_bit
      0.11 ± 37%     -71.8%       0.03 ±153%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_dirty_inode.touch_atime
      0.23 ± 68%     -60.2%       0.09 ±  3%  perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_remap_file_range.vfs_copy_file_range
      0.22 ± 85%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
      0.04 ± 17%    +268.7%       0.15 ±175%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      0.16 ± 24%     -79.4%       0.03 ±154%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_dirty_inode.touch_atime
      0.11 ± 38%  +44277.4%      48.59 ±284%  perf-sched.sch_delay.max.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.writepage_delalloc.extent_writepage
     80.59 ±124%    -100.0%       0.00        perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
    154.78 ±  4%     +15.1%     178.11 ±  4%  perf-sched.total_wait_and_delay.average.ms
    154.67 ±  4%     +15.1%     177.96 ±  4%  perf-sched.total_wait_time.average.ms
     41.27 ±207%    +533.8%     261.54 ± 17%  perf-sched.wait_and_delay.avg.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.writepage_delalloc.extent_writepage
    200.09 ±  3%     -68.0%      64.08 ± 14%  perf-sched.wait_and_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_remap_file_range.vfs_copy_file_range
    198.42 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
     37.96 ± 14%    +150.7%      95.16 ± 22%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     18.02 ± 24%    +270.4%      66.75 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      8.29 ± 68%    +438.3%      44.64 ± 25%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      7.15 ± 11%    +199.9%      21.45 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    170.75 ± 10%     +46.2%     249.63 ± 10%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.50 ±204%  +26480.0%     132.90 ± 28%  perf-sched.wait_and_delay.count.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.writepage_delalloc.extent_writepage
      1243 ±  5%     -35.0%     808.80 ±  7%  perf-sched.wait_and_delay.count.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_remap_file_range.vfs_copy_file_range
      1210 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
      3079           -30.7%       2134        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    379.00 ± 22%    +107.1%     784.90 ± 11%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
     83.70 ± 60%    +349.1%     375.90 ± 10%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
    673.70 ± 11%     -67.7%     217.30 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     74.87 ±216%    +687.0%     589.20 ± 10%  perf-sched.wait_and_delay.max.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.writepage_delalloc.extent_writepage
    422.52 ± 20%     -45.8%     229.04 ± 12%  perf-sched.wait_and_delay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_remap_file_range.vfs_copy_file_range
    501.20 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
     28.77 ± 66%   +1173.7%     366.39 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
     43.62 ± 74%    +685.2%     342.46 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.prepare_one_folio.constprop.0
     38.14 ± 71%    +829.9%     354.72 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
     36.28 ± 66%    +515.5%     223.32 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
     38.49 ± 69%    +694.7%     305.87 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.set_extent_bit
     53.67 ±110%     -96.4%       1.94 ±297%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_dirty_inode.touch_atime
     52.47 ±158%    +397.0%     260.79 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.writepage_delalloc.extent_writepage
    199.86 ±  3%     -68.0%      63.99 ± 14%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_remap_file_range.vfs_copy_file_range
    198.21 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync
     37.86 ± 14%    +150.9%      94.99 ± 22%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     17.94 ± 24%    +271.5%      66.66 ± 16%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
     10.87 ± 37%    +309.3%      44.50 ± 24%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      7.06 ± 11%    +202.8%      21.37 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    170.68 ± 10%     +46.2%     249.55 ± 10%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    225.30 ± 43%    +146.1%     554.37 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
    179.96 ± 58%    +225.3%     585.39 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
    243.25 ± 38%    +140.0%     583.77 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.set_extent_bit
    108.35 ±100%     -98.2%       1.98 ±297%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_dirty_inode.touch_atime
    119.47 ±140%    +393.1%     589.11 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.writepage_delalloc.extent_writepage
    422.43 ± 20%     -45.8%     228.95 ± 12%  perf-sched.wait_time.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_remap_file_range.vfs_copy_file_range
    501.11 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


