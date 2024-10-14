Return-Path: <linux-btrfs+bounces-8886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A999BCDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 02:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455CD1F216CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 00:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306A4A2F;
	Mon, 14 Oct 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPaQ46bh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71A196;
	Mon, 14 Oct 2024 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728864782; cv=fail; b=EyPQ5KnOOuCtljfjgMFTCLUm1ESrR4jc+4ipHap4roDN2be3BP5BsB16Nz9ysmjnQTb8QYgCTQi84LEsjFrHE/bZBBti8+mnJUzTmdSLzoPKpuVf62kzIgBO9+aKfff+t5nFcGfC8ZkzKoRoKsxrGlNCDq8Mmr/cqQk1bMAX/aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728864782; c=relaxed/simple;
	bh=7VQMRTCNX4zVf1VBM4jjrrP2KwPbaL22An1Smdh7Ozk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFpM2CH3C5NN7BitORohlR2LfXaOpfOvY0XxK0y4OPPoAZuP7r9nHQPh6d31DWxOMCax7SHNI4cUm58xJXACcdntUEqJiBsuHZDbh/HYrNAJ1c8DxPXplczps6zu0WvJDhDKmeX3tdJ9k/bHHEHGrKElEFnwetxsiepEw5B8KKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPaQ46bh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728864781; x=1760400781;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7VQMRTCNX4zVf1VBM4jjrrP2KwPbaL22An1Smdh7Ozk=;
  b=VPaQ46bhfEAAwMo4r5ojCfl3JptcY1KAS3vsS42/UqBNdMoFfji0VmvE
   JqcoHcXCrJg9koKdv+tzz2FDB7wKMPAw1bemPKSNDYQZk9a0A1qAjeHOj
   PSCNbgdLgtyI51xHCfbEIaOfAdsdhSfkS6XaaJ8X2jjg/DKLlBT1gX5Dz
   5ckyauPwbwD3Tu+LkaCqrsGPBtxDcv9k2kNHfTKJlEkOoCtTIquNQvwLy
   p2ChDQ6EtTy/FsgYF8oPCGtJ55eOc20BDuhF07Sib30h3lN3G0xXWn19h
   AKye60lbO0bVgJgilUQje3X0wpXwKni8NGQjIO/ekORMSE+Q8c856occx
   w==;
X-CSE-ConnectionGUID: IsEmYuxvSsOE3wMd1mfBBQ==
X-CSE-MsgGUID: E9477rf1Q0Ok1e7a36COww==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38844012"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="38844012"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 17:13:00 -0700
X-CSE-ConnectionGUID: fiVWi6SkSCSf+ThScomsPw==
X-CSE-MsgGUID: VxgRMqIkRoGf8p3oRfpiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="82433916"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 17:13:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 17:12:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 17:12:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 17:12:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 17:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riCphOWZJyhZGqYrR6+rtb2l3x31BqbrSbAlSHAqqC6vCQUcuOzVETgEJi6gUvh04tRsicO2CpHBS7OgUi1Pjj3R2CbOzqXvZle9ddBxQ7QjuNc3SjxagQBwlmFm+nL9cvPgjqocoS6iIXW28BDhHqQ3woZUAP96OaMewpbVhQ0wMUKSgNmaL8I1pg1mkprjGS31WOJGLDi+z7B44uDOp+/A4og9Z3zvRmSmNhmgCw3pL7D9OiG1k8cIzhxDTTE1JQSMkf+wdL5uh26gS1bcxevks9coPdAeQGRdnFFCJ14ypqKUXIbq4JHgB1sRKJVJQfygqwSghoXlurkgHT/DzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUSi57lfvv7+sZkuz8S+ewsjKRGdXTrLm9ncNLM3K04=;
 b=enLGHg+i/NTmXPTb0l5rsz+a4IMxku4ITTjLT7u/tMPjP0XDU9fro6XLC/orHEV3I1PX4rdIrcB12YqxJeq+b8X1liDR6iladcFKLwhus44w2tlr0wpsynRRJbABBND5rm3KUFYdA/I3Ytx0V5IKiEgKy9RT1nXRRogCVuv0TfbRR0jy8w2yVwoUC37s7SNp2BHXsBtZXu3grwWllgHBMZ1Kl+senO5qjH1IgpuWJk1PHdyLidi1CLhwbFkutlsQdxa7eS1p/l+iPseIWfSBkztnUOJWIABpNfS7uqosELo5G8D7wk6qmNnGXM0hY2UwpKakfZep5uOQQBq+h0Y9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 00:12:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 00:12:57 +0000
Date: Sun, 13 Oct 2024 19:12:51 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, David Sterba
	<dsterba@suse.cz>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 04/28] range: Add range_overlaps()
Message-ID: <670c62035d39b_9710f294f4@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
 <20241008161032.GB1609@twin.jikos.cz>
 <ZwaW9gXuh_JzqRfh@black.fi.intel.com>
 <ZwaXPm5WrzLVoUuw@black.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwaXPm5WrzLVoUuw@black.fi.intel.com>
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a90781-065a-4440-8219-08dcebe4f490
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zpSKviw0zapU8b910W1zPU7CPclK/WyuDtXkpk7uZjXXg1mphKczQ4yNGyn?=
 =?us-ascii?Q?TWKdyN2iOiDvYHmQ9c2q7mQuMlRi7kWCQQaY12VvLBWWpQ1yahb4qkRdroi4?=
 =?us-ascii?Q?N76JWHzqOTl2Yx6CXc4dF2jS8a1+9pP0RK3ZTnSmetAmyBFuZEjSTWgp2ArH?=
 =?us-ascii?Q?arLPtZs5niRIezcVsXLi90F/vMTPkm2c0ikT9NacJXDh0WBCIpvyA2TGOAei?=
 =?us-ascii?Q?2fsqI4YUpRzHiUZ4QAYNIQhvPNstjWPtwf4AS8Y2lVvJ42SWEHInVWrcJrkl?=
 =?us-ascii?Q?wPmpP8qLW1s18qWE7EGhSs6wOiXbjPxrak6B0AulqzqXtViJ/7rM/bvx357s?=
 =?us-ascii?Q?waj0rhlygXydA4wngqm/9q4MHxhSSGdXtz3n5YouXzpaqbPHcVQO1129zzHv?=
 =?us-ascii?Q?ibSIkY5NVOJr11o40ZUY4fv7wtu7yQcjeqZ6XaW5tZ42KTpsyxqvFOjS41fj?=
 =?us-ascii?Q?0tzb0eXxZuGgx9MbTiNFMUvXd398pZqFVX/rDZjbBx164IwYxpTrBD+wl7fR?=
 =?us-ascii?Q?DBZ0Hq4UxMcGlLpsE/zBd4uOmIBQlbW1jhzVzQ2EbSStm+P9MMYH5IBeNB3E?=
 =?us-ascii?Q?YYfJ6vrCgtC0g6TZH3Luyr+JTh+y/6HNxwB/HiVjYhyKmJ1Ksj4Y19zQ1t+w?=
 =?us-ascii?Q?+Q8OR/P1zbfPqku67MTtaqecml7OrKU0/hmz47O9JTVwW3+WBLXWY40rKABQ?=
 =?us-ascii?Q?C8fGAChjMamPwhe5zaKwFI07LhSCYOQsjXMecW9h25SsyaZXpoLc6X/fRzEi?=
 =?us-ascii?Q?qWYncJaJeotCK2X+3LGMMVYo0iIsfT1M2gG0h8g13ppdIp/IX6fbsZVKoVeT?=
 =?us-ascii?Q?J/aGVnDyepRJBJV2bzT3ZApJyxWU4WaSO0uRoIO4bVjgD9xSieqYwWhGDjRE?=
 =?us-ascii?Q?urKUMO/cOLLOBw7bzmhB5wmz+kS+97IthyuiYq9c1eXQvTEO3yC/4D64hMBb?=
 =?us-ascii?Q?QnLfHyQdm6e4cDMMQHiraCl5Y5ZqdHZBJpqjBhuWnL7tvNT4AmwMlC5Hufi4?=
 =?us-ascii?Q?dYpfb8HhlML62NA/VaGhBpFA8YoZNBKHIXYjlllvs8mT4i7oaqeq30DzIfB0?=
 =?us-ascii?Q?z73HxHv0Ce5OFWZ6UGvxdcpfJyFluN8pXYM4j6749zepR8b6YyUj2Z4L0/zB?=
 =?us-ascii?Q?VtXEClZ/r1zG+gsFVuoQyRQZ05edaHX9jf6nraUJxM5QYpMSBzpCDMEyQDfJ?=
 =?us-ascii?Q?J9Qr2XGDDKhQeqCwlbwl0a3S2jPnBrw4IDryPkiPwYmAUzv+soeDulcmwbP8?=
 =?us-ascii?Q?W3ozHYbtg20bA2D2ZazacPxiNn76FxEX+tHAKzA27g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQ7pWZ/cdyQVM1adI/4LEAXkBcWCeYKe3ytONeVC8nVtFmhBUw6l+audaLMa?=
 =?us-ascii?Q?MgR+cx6VT8wYkMQiU8oiRkhsRqmzIi0wgjTOrfGYwwZmczy3MvMs7Tpui4Qb?=
 =?us-ascii?Q?2q4hCIp7KzTFDDfK5zfq2+kcbAxLcNXMn/XND5gtFT1cW/IDdvR2vsWGMbxW?=
 =?us-ascii?Q?m0jTZO7QSbUjyStuMLFNXHiYcLiu58abrOzcfIZWjGpgncvtpfMbwF//iSys?=
 =?us-ascii?Q?XXn7Za3QiTAinfOgiGg6+ST+Bc7vHRgHBd9c3yfTqyKJAFmxwpJjWD8q+lfv?=
 =?us-ascii?Q?qabo61RbzBvzL/tMn9sti1CK7rDbhmrGqs1whFJh6tZY29o43BXV43pB+A7Y?=
 =?us-ascii?Q?Q8Wp+s+sL7BLEgY+WT8jmrW+kuVsrNGiWm+I8YL3daWk9SX/E/5TqLkbdpO/?=
 =?us-ascii?Q?woYh93GIDkDStRsMR0jqcaLSPwoJR5/aabHlQN9llolqnTZzi/WV8RubiHJx?=
 =?us-ascii?Q?EZt6S2fizZ9HjlUmPRsIl9o0A0xLZamNmA2Xoxb//LIdb+ZFdcq+aoCvf+aI?=
 =?us-ascii?Q?2ew4911HsMOuE4Wk0IPy9z2aUPPRLfQC7E5DaGnf6vi8w2/5ykBHSGoKC0Mq?=
 =?us-ascii?Q?9dy1OkHvMIzSb0/tNK+esakX3vwjES6iRBkkIpgMQKt3MXAHcui+6GPiLzkE?=
 =?us-ascii?Q?vXQh2iRQpZkpf298xflM+ZmbONSX+e1dHD/rlKio8ush6gnCpERfRljDfaL4?=
 =?us-ascii?Q?k5AZQdPn6Xz9NRhA2y2ahebZls/b/XphPKfwVPfxk3TVck5ZTWJZIrAqmiaL?=
 =?us-ascii?Q?ojEb3rTMuMtNByWkTxnsmUqFYuQrHiwUD9knwH5ePtA2lbMuEuP/bHQJ5rYV?=
 =?us-ascii?Q?3MzeZ0TO50Zvgnqtn5n6WAaTa9N4ag13mLZSzYt22FVxZk57tV4Ss9EbNsJ8?=
 =?us-ascii?Q?p8Hdh8DXeGVu/60SSr33AoAM7mpZwbBB3hLYgOnWcg7QDbxXoLOkDb6K6Y8+?=
 =?us-ascii?Q?6D2LA52uAlp2IOMJlW3k8JoYJyriNVVCVf7oFf7x0xGoYhCKGFnDZCUqTLQY?=
 =?us-ascii?Q?A3gU0u2PKJJlxOigrAdBOzuMB09DoSTsMR3qudT9VGkdmyfNNQjiNhPaJyHj?=
 =?us-ascii?Q?a9ybrUmmvuR3//tvwkj89TRfGjAsb4Smz8sKZ1NhH6cGE6lHCuuYmTbxd4Gv?=
 =?us-ascii?Q?0j327uKgI6km6U9ofzciwP9wOMqeFEM7rqZnfFPXqGDKMWHgJ+Nxtj0EJIds?=
 =?us-ascii?Q?GiW+fkCfM+p3WFX6UrvrYBWs7r8Frr1JI6TCGZs2eAE53EdMllf2OY3aDG88?=
 =?us-ascii?Q?Do42yFi8+SpZkLi+noJNPFZFA0YSRAgjxAxaxVajVkBHyZGWEg7h3eE7b7Jr?=
 =?us-ascii?Q?ZKpU6za10XaNL/Y4GVCURj+EleB5fB7AshZS5mAv4oZkAJ/56NM3XeX0tIsL?=
 =?us-ascii?Q?8sxDPI6au7CncVN2g5XiVF94NWJ/VhF8OV9WtNsbJTBFjwEh5AhDPhLVC73a?=
 =?us-ascii?Q?oWF3ld6Hd72RvNsjwtTeU9eYoCPEp/ObPUkqKLENHovUYx/7RIN8+dgV5cSV?=
 =?us-ascii?Q?NLC6tqlNwO9uFv/cqEWVsN0Iu4bNTZA5t0bgYtXqHzBAJH5WwkUssR0gK+ea?=
 =?us-ascii?Q?eOfkQUY0jfIs6wY5CYD/ZYLtQMipjAAy14SzXJyV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a90781-065a-4440-8219-08dcebe4f490
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 00:12:56.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+KyRRanwASAQWA/3Nmsn6yRumC/z9qbHs7GFPPm0vs0ywBgMoNCNoY8nHIwSw4H1I71X6/c8Y44KoK010T31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Wed, Oct 09, 2024 at 05:45:10PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 08, 2024 at 06:10:32PM +0200, David Sterba wrote:
> > > On Mon, Oct 07, 2024 at 06:16:10PM -0500, Ira Weiny wrote:
> 
> ...
> 
> > > > +static inline bool range_overlaps(struct range *r1, struct range *r2)
> > > 
> > > I've noticed only now, you can constify the arguments, but this applise
> > > to other range_* functions so that can be done later in one go.
> > 
> > Frankly you may add the same to each new API being added to the file and
> > the "one go" will never happen. So, I support your first part with
> > constifying, but I think it would be rather done now to start that "one
> > go" to happen.
> 
> Alternatively there is should be the patch _in this series_ to make it
> happen before extending an API. I leave the choice to Ira.

I'm not sure I follow what you are saying here but I think you are saying to
make those calls const prior to adding new ones.

I agree see:

https://lore.kernel.org/all/20241010-const-range-v1-1-afb6e4bfd8ce@intel.com/

Hopefully this is what you meant and closes this issue.
Ira

