Return-Path: <linux-btrfs+bounces-7604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEE961D70
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 06:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902141F248F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 04:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0C13E03E;
	Wed, 28 Aug 2024 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCMaJ//y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411C42A8F;
	Wed, 28 Aug 2024 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818386; cv=fail; b=lBN4gGU/sxITjleuyzOx4ZxxV1OVbnqbyrsAcX0FgBW3EY1RqnDr+uECHUgLFyTjr5w48HMjwLaHzEHqri1yEgIuVPjhl58dWjtUgGFw3LUKcA0ZnhKW/GGYitkftsUyWSdwezdOmsXkn7sjeEvL7TkxjqsKogn3pZsQDPHPhqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818386; c=relaxed/simple;
	bh=ZzZs8r9t7hjCwNx7SDL1A1r81dJUHEtofpZKP3U4QFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cetY8+TY+sXcYEZ7vStyED9p51YwEXJHY6Fv0FwnoKImxFRZhN6roEU6B+n53fDqcxXg+P2Hdz10dDcoAsF5opuab9EBKxHXkrRz71zdc/uWa6wVfDgv801iQDxObJydNrRFn9/b0JsL7NMxT6zmwzZlz15iLqXoEjoDleh4fKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCMaJ//y; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724818384; x=1756354384;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZzZs8r9t7hjCwNx7SDL1A1r81dJUHEtofpZKP3U4QFU=;
  b=gCMaJ//y7Q7toFxZed0/PRmHYcX6eWHqm8UpspvkkDc3gyw7eIkIPhHN
   GGXu6rErFNNdsdVeG8xckKb+576ibp3BuCONGQkSJXky6uG7k35qjOE7C
   cO23zvEJjaeg8h2mv9PnptvdhUIWBLB7LqXZ1216q5rmEWpiku4Nn0GQS
   L/jwBnSKF23c7ZbPWBgWdV8eoxS3hf0G/GmAcGMj91luMFvlNnC/EZw7T
   nZF+so/XedeUhReEBfpsfRGRRP5CGglsx5h0Wr6w4P9vjWsnst91ocYn+
   PpOxOU0ryaByVpfQp1WDZI0knGeJsEmpN0cjkxjSHwY+NdC2qiFBF9CTn
   Q==;
X-CSE-ConnectionGUID: h3cseG7uSFCDYcIaoNTqyw==
X-CSE-MsgGUID: FnggiO2fTCqTByn4nGuQXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27208108"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27208108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 21:13:03 -0700
X-CSE-ConnectionGUID: joc585i7RRGUy7b/sANB8A==
X-CSE-MsgGUID: J92N1ammRMyPGmFi2/OYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63046884"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 21:13:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 21:13:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 21:13:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 21:13:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBnNVHFhM3VpW/bF7QzFZvZAhJQ7p+63FaMyH9DqrZzmvJWCgarvcNuusVi3qm27nVlF1+E56L+Nc/HpR9LXuGJdwbZZDVVTAWtPc4rHVtbjtodro85WtJGMg4kfuQS2Zka0TrAkIqZ5+2aCNT+nS5lFCEPZIfYPz5SADXkYJnOfg4d9vYkrHQbn0vtrJ7GoRr4+oEsLZGQLMW59s9V5GZWNNdIYaB4Br7ASL2mhpMNMZR/ZjWG9xFEzWiIpKcPIxA76wvdtEEbIx2vWRptFhqpNhpkO0IGfVolCsF3ptwS+XKHuPx3lzuRTv5FXePYuE5uc3YWdBt4Xgr5eFspj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEMrnLa6gUSafqO+UKBN+nlCujtKsfCUTzgLgnfzLyg=;
 b=GAzft9f6tJCRRa31D/Z1PbOqKZUoZhzelW2hmGyTh4kgCecq3PK+XbO9nNqnUCMnliS3iRXxBxgfES401Oz7rC2XqpLGHSGlN83qq4hxW9w71bogZ5Vm+iZFbKWLZ9EpmdVaaWwcQkaRWJK5/C9uhH9xqTQixlj8OzxPTNT4DIyHwXcvVIP3TUcaMj36fOURqtMXg+PELBTO6OYP/ohZXZxuT3SDMQs+tP2KRYwTBm955p6xlDeedO/CsPdxYLnwHSUfVPUNpznWoBzii3efjz+TMLA4O/Ormm0yDixKs//nZ3aKJKqPcTpJedElYyFV4KDjMMgmU5O8bvShUwHPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 04:12:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 04:12:54 +0000
Date: Tue, 27 Aug 2024 23:12:47 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Petr Mladek <pmladek@suse.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <66cea3bf3332f_f937b29424@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
 <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
 <Zsy6BbJiYqiXORGu@smile.fi.intel.com>
 <66ccf10089b0_e0732294ef@iweiny-mobl.notmuch>
 <Zs3SB48QdLmUEdzw@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zs3SB48QdLmUEdzw@smile.fi.intel.com>
X-ClientProxiedBy: MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f18032-49bf-4fda-b0cb-08dcc717b0e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4B73wEEN82gs4g82weII4M2A/+RFWyqNnpuBRHQabc0knX+wwr9vGJeIK+Wl?=
 =?us-ascii?Q?VX3ri0W5r0/VX8JhTO1358fnNwuLTFeffM3+YL5YkRMte77ztVWebRGGEyuA?=
 =?us-ascii?Q?Sy8bxH+OjhP/tmyLXhw/tZg0LeVMUPEeuqgqk59VNvvSU07jGSx5bYrmenGK?=
 =?us-ascii?Q?Da5W0a6cMbj9GpFhKBDQ8s/3hm+oSmSQBMZVWYygjHN6jFk0vMCCuPOsqj3a?=
 =?us-ascii?Q?6s0PfIzbpiuwP0RbmbImJ+XzzJqL/qWuX0Uzat+U54Iv4yCCsYoMdIxoyz0Q?=
 =?us-ascii?Q?lyHT9u8XA8b1ZNqg3e2lLFxcZH/PXElFsGxtnUedQQqzgST+MThfP4sA87gJ?=
 =?us-ascii?Q?DCH34gbTFT6BBvRxEsxdKWzFyVnm7qUKuzplHGHm2OVSHIYaGU5R1hKCgZSe?=
 =?us-ascii?Q?dBd0/qxRhyc9SQjSi4t0tgjVSlpwfgrQssZCTavTNve8ePoWo4WsCSFyNbPF?=
 =?us-ascii?Q?RSUtnqGB/ztlyqxcmAE244VMJGzzNPcBGXmXUDzR6Gxd9OWJzNfnxWfBuNiv?=
 =?us-ascii?Q?3N2op0XHqmnh3WL02sHjgTU1k27uTW+n8PQGF5JFTYw0qJT0Ju0sTh1Ec1RN?=
 =?us-ascii?Q?FwcHPJSPJslN6KuwBw86oci99GbyD5VjtG8QKxzazI8TAOCeSYkHrJRpWq8h?=
 =?us-ascii?Q?Z5tYyLPZFUMeTOpJoidSWnMz+IRS4OFXCoNcd2lsn6tKglkfA5cJS25xyuNA?=
 =?us-ascii?Q?xxOxVRo0DA5cjTsysvvFwrkfjsCkde/pUwO6xrKvEYY0i4O7UgJ0PKs3y8ve?=
 =?us-ascii?Q?FD0pMTF4OLcMmh7ifW6GP7n9tvSOGaKbkHKr4MiLZZXFmDjcN38ExkuJxaw6?=
 =?us-ascii?Q?lQ+yjQPMQbliJU4tjzH3nNeAx4blxqqbpFT4OZbWy1yKlV73tUxoi3Br6J5H?=
 =?us-ascii?Q?XlUV6aoAs+cCgCk+o+FYrLFRes0HY/i09ft6DGlHt2jqD1AldoqaZTslBeAl?=
 =?us-ascii?Q?DApPbJcmV7qCMhd0lwmiat3p1y/WP9NEknGYR07wLz16f83QStduAVmTiEpE?=
 =?us-ascii?Q?AxCia7il3w/S6vM6XBjvqTbCpjpaTJSSk73rta87OfvaLCBNRWja09h3yXUL?=
 =?us-ascii?Q?UJyy3/nAEZA7YrCIiNVf6j170nwM93W6yiKFXo05tlzPH0T4I57kVJXjyTF2?=
 =?us-ascii?Q?GWYURQey1keQNuct6M/l6VKP6O0+AkaBs1zrfvu/ENx2cT+ewZZIYmfqFlvT?=
 =?us-ascii?Q?oOQFbmP4SnCO1/A/sn9IG2os4vyeZqUeGynmjvcMpYnmO+dJhOfZG9qjgaC/?=
 =?us-ascii?Q?w63Z7Qa7K0hYeHvP2ki4lckXTk01pSTFA8rpxQtOhw3H8CE37gXxMK3P/m6T?=
 =?us-ascii?Q?+ZSsq7OVIES7yUUhPzssne+rD/RzXJsLzt3RmvFE0Jt51g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHdXD+6QgRylIHv1fSATW1FxMYyz4bEVrv/MNFPZQG7NXvodOTwyz88tS8po?=
 =?us-ascii?Q?4/Qavx+ezn/JOltj+lpiIe0j89BPEoznRji4e9D1C97RBS6Xx3n9gAURcNDz?=
 =?us-ascii?Q?Dz9Urj9RLf3eYeuUc8PxyN//eVq+Y3lS1bgCjp1ND7hK9KD9Q/tF3YvEhCW0?=
 =?us-ascii?Q?43s24eN3txgSXSB49T11wlIohhv6DgDENLWaJW63GxZEuQW2czR0UxlR1x00?=
 =?us-ascii?Q?qQnh66a91gA0rjv7nvUqRGb+c2Lk+yNtvKkAQlrK90Sc3I2bAt1nRT4me3eg?=
 =?us-ascii?Q?I7CTGoTErTQi7J/bFYqOayfW5dH6wKzpQQVbfD/Ao2DxzCLbekv2e7ZEPhFX?=
 =?us-ascii?Q?PKkG3ORpZZlRBHlO6DSgxFznPx6b7Tm1wSl617+DbAxKl8dN/yqEiKYJ2qTo?=
 =?us-ascii?Q?cxKI6Q1MmH7PYujhnCjIOHT+TUM8dLpHJo7OohLLolVb722sUYbHJ3l6NEGk?=
 =?us-ascii?Q?sx8qc2SJRr2Iq0+rJSy/brk3qnxn8EArDreYriYdEOrqRjl3mcRDr69bU0gO?=
 =?us-ascii?Q?g/7LyYEM3zCGtCEQbJW0jdtB8tcTJI5bfRPWfN/4px3J99ZS6j8lYpC3GVyv?=
 =?us-ascii?Q?9A2R7MA+sD3MwmKKQA1SkMViMHjmKTa8Ffn9eQaCalqj2WrhFqtO/25F4Syf?=
 =?us-ascii?Q?aFk/fccvLeflhNjdpbJqQyCzmJ1Qo4n84x4Y4uE1tAAAL3BPe8IKVlt5dexL?=
 =?us-ascii?Q?a5J46B6HIcDJstEcKytuVhPaVzetCFSujJ6br5ykiI+Cys87lKl7cfv2w3Ut?=
 =?us-ascii?Q?K0ToonSGsSLrO3YNsy8zGIvH906MNcQWmWEtvE7OUiRFApDmPFqRvIR7XsPK?=
 =?us-ascii?Q?a8zkUc1BfUA/2f5YyU6knxJA762KsfBIy4LljTbuJbhxLH88clkWMvMFW4ZV?=
 =?us-ascii?Q?C8Rlbgrfue/hKr7jAE5yw7zIbBFSHp8eN3kkVV9AHYQgamZ7N6+qWzidGgRK?=
 =?us-ascii?Q?xHLWBVo0k2G7a+37hDpxCJY1DJEPmH6k62qZszKh/DEu64a4ztMLOnGga7DX?=
 =?us-ascii?Q?guTy3tnmNK1WAn4rVjZD+SbWpQb2suWAqKk/qec7txmznUDlibucBsE+Kk8k?=
 =?us-ascii?Q?d1eJlhUk3mAoQa6fbqKxj0ZXl7l/z+Wjvmj57OkVXxcX9Yh28oP+06bfqlHf?=
 =?us-ascii?Q?PVdt0AggQqpRhrLt8AvkW7lQAQixMAc4RdMHOK07v+qLggUA7ebvZd01Rwgr?=
 =?us-ascii?Q?BwyXvydyitRhf8uRPo2iFYvEfedHblrDudpxYaxYr08kH6WZz9Q2iR8gHuwG?=
 =?us-ascii?Q?hXiK1PHJVgTCBu1ProCZrkmXJb82kcsNvqm1bJ0xm2kWS2sEGkxe1XOEGW0X?=
 =?us-ascii?Q?MXPkfvyYjJvmDNQWADj9pjBMuFwsg3G7HrX6DHTUFGOeVAJDT/iiLHB7t51E?=
 =?us-ascii?Q?Fip4gJ6i+K8A3DeApYjFwMWlGt7rkhTf77UTuceXty0PYMpWDJmEyzq9pLCk?=
 =?us-ascii?Q?fOIxh+zWg+/ZWHKkG5x9qpZv9U45Yt0jWLzITbbcQvNG3a4G8FMuUcMdxQ87?=
 =?us-ascii?Q?JR62vzWzm9yTuH5y8nQBsoRy94KhqwBtOWufC5mwGQDEO2qKCY4TCjo3+c0G?=
 =?us-ascii?Q?pon/1nWx70bdo5nMceKk1TZrHLWB66SOTV2dLW6Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f18032-49bf-4fda-b0cb-08dcc717b0e3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 04:12:54.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toTAbd4HLAnINOiR+KsOhIQ3Wp0O2NotLUErk0viZbvrjCbgxWB//86JB36QxHwoUBa6Asljr1FxOqCzlb9mIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Mon, Aug 26, 2024 at 04:17:52PM -0500, Ira Weiny wrote:
> > Andy Shevchenko wrote:
> > > On Mon, Aug 26, 2024 at 03:23:50PM +0200, Petr Mladek wrote:
> > > > On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> > > > > On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > > > > > Petr Mladek wrote:
> > > > > > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:
> 

[snip]

> > > > > 
> > > > > With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
> > > > > to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?
> > 
> > I'm speaking a bit for Dan here but also the logical way I thought of
> > things.
> > 
> > 1) %p does not dictate anything about the format of the data.  Rather
> >    indicates that what is passed is a pointer.  Because we are passing a
> >    pointer to a range struct %pXX makes sense.
> 
> There is no objection to that.
> 
> > 2) %pa indicates what follows is 'address'.  This was a bit of creative
> >    license because, as I said in the commit message most of the time
> >    struct range contains an address range.  So for this narrow use case it
> >    also makes sense.
> 
> As in the discussion it was pointed out that struct range is always 64-bit,
> limiting it to the "address" is a wrong assumption as we are talking generic
> printing routine here. We don't know what users will be in the future on 32-bit
> platforms, or what data (semantically) is being held by this structure.
> 
> > 3) %par r for range.
> 
> I understand, but again struct range != address.

Agreed.

> 
> > %p[rR] is taken.
> > %pra confuses things IMO.
> 
> It doesn't confuse me. :-) But I believe Petr also has a rationale behind this
> proposal as he described earlier.

%pra it is then.

> 
> > > > The r/R in %pr/%pR actually stands for "resource".
> > > > 
> > > > But "%ra" really looks like a better choice than "%par". Both
> > > > "resource"  and "range" starts with 'r'. Also the struct resource
> > > > is printed as a range of values.
> > 
> > %r could be used I think.  But this breaks with the convention of passing a
> > pointer and how to interpret it.  The other idea I had, mentioned in the commit
> > message was %pn.  Meaning passed by pointer 'raNge'.
> 
> No, we can't use %r or anything else that is documented for the standard
> printf() format specifiers, otherwise you will get a compiler warning and
> basically it means no go.

I was not thrilled with %r anyway.

> 
> > I think that follows better than %r.  That would be another break from C99.
> > But we don't have to follow that.
> > 
> > > Fine with me as long as it:
> > > 1) doesn't collide with %pa namespace
> > > 2) tries to deduplicate existing code as much as possible.
> > 
> > Andy, I'm not quite following how you expect to share the code between
> > resource_string() and range_string()?
> > 
> > There is very little duplicated code.  In fact with Petr's suggestions and some
> > more work range_string() is quite simple:
> > 
> > +static noinline_for_stack
> > +char *range_string(char *buf, char *end, const struct range *range,
> > +                     struct printf_spec spec, const char *fmt)
> > +{
> > +#define RANGE_DECODED_BUF_SIZE         ((2 * sizeof(struct range)) + 4)
> > +#define RANGE_PRINT_BUF_SIZE           sizeof("[range -]")
> > +       char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
> > +       char *p = sym, *pend = sym + sizeof(sym);
> 
> 
> Missing check for pointer, but it's not that I wanted to tell.

No it was not missing.  It was checked in address_val() already.  However, with
%pra I'll have to add it in.

> 
> > +       *p++ = '[';
> > +       p = string_nocheck(p, pend, "range ", default_str_spec);
> 
> Hmm... %pr uses str_spec, what the difference can be here?

str_spec is designed for variable length strings which are used based on the
struct resource flags.  Struct range does not vary so default_str_spec works.

> 
> > +       p = special_hex_number(p, pend, range->start, sizeof(range->start));
> > +       *p++ = '-';
> > +       p = special_hex_number(p, pend, range->end, sizeof(range->end));
> 
> This is basically the copy of %pr implementation.

Only at a very basic level.  struct resource has a variable spec while struct
range does not.  This causes complexity to make the code the same.

> 
> 	p = number(p, pend, res->start, *specp);
> 	if (res->start != res->end) {
> 		*p++ = '-';
> 		p = number(p, pend, res->end, *specp);
> 	}
> 
> Would it be possible to unify? I think so, but it requires a bit of thinking.

Not much thinking.  But the issue is that they are not close enough to justify
the extra complexity IMHO.

Making the outputs match with a common function takes 13 lines of code[1]
including the declaration of a print specification which, as this thread
already showed, is non-trivial to understand.

__Also__ this is currently crashing on me and I can't figure out why.

$ git diff --stat
 lib/vsprintf.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)


OTOH to force a unified output, only takes 2 lines of duplicated code.[2]  This
is a very minor expense of duplicate code which is much easier to follow.

$ git diff --stat
 lib/vsprintf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


> 
> That's why testing is very important in this kind of generic code.

Yep.  But the struct resource test was stubbed out.  I've added some basic
ones.  But there are many more variations of struct resource prints.  I'm not
sure I've not broken them.

> 
> > +       *p++ = ']';
> > +       *p = '\0';
> > +
> > +       return string_nocheck(buf, end, sym, spec);
> > +}
> > 
> > Also this is the bulk of the patch except for documentation and the new
> > testing code.  [new patch below]
> > 
> > Am I missing your point somehow?
> 
> See above.
> 
> > I considered cramming a struct range into a
> > struct resource to let resource_string() process the data.  But that would
> > involve creating a new IORESOURCE_* flag (not ideal) and also does not allow
> > for the larger u64 data in struct range should this be a 32 bit physical
> > address config.
> 
> No, that's not what I was expecting.

Good.

> 
> > Most importantly that would not be much less code AFAICT.
> 
> ...
> 
> > +       %par    [range 0x0000000060000000-0x000000006fffffff]
> 
> I still think this is not okay to use %pa namespace.

Agreed.  Lets go with %pra

> 
> ...
> 
> > +static void __init
> > +struct_range(void)
> > +{
> > +       struct range test_range = {
> > +               .start = 0xc0ffee00ba5eba11,
> > +               .end = 0xc0ffee00ba5eba11,
> > +       };
> > +
> > +       test("[range 0xc0ffee00ba5eba11-0xc0ffee00ba5eba11]",
> > +            "%par", &test_range);
> > +
> > +       test_range = (struct range) {
> > +               .start = 0xc0ffee,
> > +               .end = 0xba5eba11,
> > +       };
> > +       test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
> > +            "%par", &test_range);
> 
> Case when start == end?

Yes, that is the 1st case.

> Case when end < start?

I had no intention of having the output dictated by the values.

	test("[range 0x0000000000c0ffee-0x0000000000c0ffee]",
and
	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",

... are acceptable to me.

> 
> > +}
> 
> ...
> 
> > +       *p++ = '[';
> > +       p = string_nocheck(p, pend, "range ", default_str_spec);
> > +       p = special_hex_number(p, pend, range->start, sizeof(range->start));
> > +       *p++ = '-';
> > +       p = special_hex_number(p, pend, range->end, sizeof(range->end));
> > +       *p++ = ']';
> > +       *p = '\0';
> 
> As per above comments.


Thanks for the review,
Ira

[1] sample diff

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6be1ca13790c..84757e75e047 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1039,6 +1039,18 @@ static const struct printf_spec default_dec04_spec = {
        .flags = ZEROPAD,
 };
 
+static noinline_for_stack
+char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
+               struct printf_spec spec)
+{
+       buf = number(buf, end, start_val, spec);
+       if (start_val != end_val) {
+               *buf++ = '-';
+               buf = number(buf, end, end_val, spec);
+       }
+       return buf;
+}
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
                      struct printf_spec spec, const char *fmt)
@@ -1115,11 +1127,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
                p = string_nocheck(p, pend, "size ", str_spec);
                p = number(p, pend, resource_size(res), *specp);
        } else {
-               p = number(p, pend, res->start, *specp);
-               if (res->start != res->end) {
-                       *p++ = '-';
-                       p = number(p, pend, res->end, *specp);
-               }
+               p = hex_range(p, pend, res->start, res->end, *specp);
        }
        if (decode) {
                if (res->flags & IORESOURCE_MEM_64)
@@ -1149,11 +1157,19 @@ char *range_string(char *buf, char *end, const struct range *range,
        char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
        char *p = sym, *pend = sym + sizeof(sym);
 
+       struct printf_spec range_spec = {
+               spec.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * u64 */
+               spec.flags = SPECIAL | SMALL | ZEROPAD,
+               spec.base = 16,
+               spec.precision = -1,
+       };
+
+       if (check_pointer(&buf, end, range, spec))
+               return buf;
+
        *p++ = '[';
        p = string_nocheck(p, pend, "range ", default_str_spec);
-       p = special_hex_number(p, pend, range->start, sizeof(range->start));
-       *p++ = '-';
-       p = special_hex_number(p, pend, range->end, sizeof(range->end));
+       p = hex_range(p, pend, range->start, range->end, range_spec);
        *p++ = ']';
        *p = '\0';
 



[2] sample diff

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a754eefef252..e6870eb703a4 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1149,11 +1149,16 @@ char *range_string(char *buf, char *end, const struct range *range,
        char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
        char *p = sym, *pend = sym + sizeof(sym);

+       if (check_pointer(&buf, end, range, spec))
+               return buf;
+
        *p++ = '[';
        p = string_nocheck(p, pend, "range ", default_str_spec);
        p = special_hex_number(p, pend, range->start, sizeof(range->start));
-       *p++ = '-';
-       p = special_hex_number(p, pend, range->end, sizeof(range->end));
+       if (range->start != range->end) {
+               *p++ = '-';
+               p = special_hex_number(p, pend, range->end, sizeof(range->end));
+       }
        *p++ = ']';
        *p = '\0';

