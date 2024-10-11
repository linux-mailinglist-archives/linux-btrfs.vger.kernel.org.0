Return-Path: <linux-btrfs+bounces-8855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD399A65B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2671C21D01
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F9F21A6EB;
	Fri, 11 Oct 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYpZh3U/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A35219CB0;
	Fri, 11 Oct 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656973; cv=fail; b=QfvEGHew9XTPfc7tbnCLX+EpdYIv7TXhFdg7y3QpmUQhbIBbtY9NAikOLh5If8b98GSgY/+AD7lroi6g2NpI3yz5mQiIh58ehTh2ozW/qrOzqqE5oCcqJS+W/8gpGmYLv+raAOQA7e6UKTgO3VcaGLXL4KGJorQe4sRIhpn4npM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656973; c=relaxed/simple;
	bh=7xthBl2WXmMq/FPFOMv0L1Cq/yt6j8xPmg5RtVlBS3g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VWjFWv/Dvzqzb8a2Wqvs7xVleU1GMIjb0Zbwgma+R1fXZEjOc0a11025urqpLnPsFpdbue3Ov5ntCqGclv+ULpfelrRbVh5QY7kmFhH/bPflP0PhadVUAm1HRJ5gXuMUjXllEOrwlUR3SEOUpnnsf1seNa7HM0PrFISxkZF0hyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYpZh3U/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728656971; x=1760192971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7xthBl2WXmMq/FPFOMv0L1Cq/yt6j8xPmg5RtVlBS3g=;
  b=UYpZh3U/dL8WGYt1vCHFkh1WHl0QCu734udt7rWq7aWv3mn1LqgaKAeJ
   Dk7WGfOVaka5od7SA7+xRpc5tYoVI90c0lKH/AgSDqkiHASFYOtFJYyX2
   VWUZxHruZuLW/tp4J8h96uvcNOGldqDvF4o0mm6h2Yz3nfruRxFtq7gYs
   tNmUn/KiKVEJriQEwJx274+tnyeDUMt2QcyO1wApKQYBN2UDyRCkooBIw
   Qqy175m1hVZj9SWd8wGysfOhNPfOgIOuE6BSQ9yuqpVhi2joGanNbN9R0
   zOTNRDs8nNJmuZNHhvnrofXRqaiH4qk1SaHUsA+2HK2Sdj/HWBtsGoC3Y
   A==;
X-CSE-ConnectionGUID: huc5IXDRQT2tC9sj/vKhsQ==
X-CSE-MsgGUID: enWEpvpST52ClocabX6XAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="15680517"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="15680517"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:29:30 -0700
X-CSE-ConnectionGUID: vhROcjlTSZSuzEI7RakEWg==
X-CSE-MsgGUID: 9PQbGxLRSi6O4hfQKYSfTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81712205"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 07:29:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:29:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 07:29:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 07:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sry3V2eYtbXR6q2+WjqVU/cQbIgnpAdsYjPAS1Sd14gbBAxFMM2ltEW0u+MbsCXoIOPr/j1a0GeLCvfF/EOxO4HbOMHCM9dOmfWzJ8IIOWdpSQ5qmhaocaCNcBplkoi4UBF6brQ6s5Q+YjG1j6qanundKLiOVUBggSMl/DQdLPwxLcRqVUii3mbbBzralIrahZFOoGTErSSWEZ7Ue9yueOAHPjLU+aJaq0YK38zyE+I3CLY6xXjshuV4tjDFZQEG5Tpd/3fCrqGNWFo0Q7aat35RkQHviC+2CsdUt47Mt+PtzUD2q9u14VcRf/vnVT4t4LbUH8h/ZVNnQ2Hfc4E9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf4LEq6n2e34j2oruLbYRS3s+DGs6tu2kzEsMKcN7dw=;
 b=PxvlRr6j5CMe0IC7Tz9AgViGXvhKOnF4T6RCkrZmzdVfK+FNw25Vw1cf6UHU9hsXjOtLP40H5t6JXGxtIdLJ5m/fR9dKYU4wo1Q+lG+UNGzE5hz/5OSQBLwSfVDz3fNNrNzExhXHhNxZhqHLCYM+o6rD1NnDBvOmvgzyT052USpU1l/I0ZOTWLHOVizKzh0qaHFUS96AP2feCqMtHPER2PQvIa9E2dlxtRLlBBVVQYa/SorbrLGtG89HkytOpwC9Z74hpW3d5U2g3RTmcuuYI5cUmGj4KyoEsz/u5eJ6mLo4frSo4DRXB4FjaUKpb1kHhQCEObmWh/rt1LKrDAPzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 14:29:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:29:26 +0000
Date: Fri, 11 Oct 2024 09:29:21 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: David Sterba <dsterba@suse.cz>, Ira Weiny <ira.weiny@intel.com>
CC: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Sterba
	<dsterba@suse.cz>
Subject: Re: [PATCH] kernel/range: Const-ify range_contains parameters
Message-ID: <67093641c8654_9533f29461@iweiny-mobl.notmuch>
References: <20241010-const-range-v1-1-afb6e4bfd8ce@intel.com>
 <20241010203852.GU1609@twin.jikos.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010203852.GU1609@twin.jikos.cz>
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b84f249-f04a-4b26-8438-08dcea011bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j27x1PAS5a9D09Jt6bU0+gsQJeUAUaPG/XeTRg7mQN+GzBBkz1WZfssv0L/x?=
 =?us-ascii?Q?Gxu19DQS3TUe3hcd1qSCcI9ezUbJ3NKvayM9x1XBkj0Yb1tFOv2bbV9T4fHu?=
 =?us-ascii?Q?bzTpNDCbTa+8J1md++F4CDtY4TUchOzH+vRLBShaITwIdR/Th8XFu1TTN902?=
 =?us-ascii?Q?SnhgL+C8blP36MCPFahO6jvM/pOCLL3WNCJwCRLAcgP3q6RMwlRMT5kcaN+r?=
 =?us-ascii?Q?UX2njHvUhDF3m67pi9fR5Ogj8k/ceUO6zEOiVk0LCN7LfEAWyl77OzxsUAbf?=
 =?us-ascii?Q?xGQLJXaJlWerWQst2J/peKQERjIy+sVsKvR+WU7DQj77hzcv2EXyTHbADzdg?=
 =?us-ascii?Q?9BKu6E+sHO2LhdbFtMEA7JoynechFjNZ1mBdnLbRL7tTmJwdi65DUn1d8kKc?=
 =?us-ascii?Q?Im66nfqoh2VAU3n6xH5N8rWlvAlqe4HVPYlYn4soBes9VOYOaaietKjUFcdW?=
 =?us-ascii?Q?/UKI4pFSgpu9uKZ5FNxsJ/A/AwyggnaE+uKy/dXCKsgaKYG2w1+0ehD81qGt?=
 =?us-ascii?Q?I5cB9WEEwlsGNerE00/ccN1+X4PPF3bLxUbD4gF1JjGasyXtjTmzLn+cGuKF?=
 =?us-ascii?Q?MDtVnG1l0IrgHg2qG6Edyf+GvyL1dmAjyLDra/1RiyrS33OeEaPc0qWU6yFV?=
 =?us-ascii?Q?nBKRw38Y9OQ5fRV88E1gL8LvrUMMqm59HG3sTwA5IxFLoSvRivQ2rQlgvdFc?=
 =?us-ascii?Q?s29PEBjfKYZ1oNgeYidFmkibPkSO631gUm51SQXOWvAz3AObWr1Sj7zlXPfV?=
 =?us-ascii?Q?qeJjBQrhFPBBiz6Ex2VtNzTfpbnMSArx/NVQv9UFwQaMeKW55R8xwj2pe2Uy?=
 =?us-ascii?Q?u1vPjaJ+WGKrMChi/Jaj70Cbz82XARKS2xARBopy9eHgbRQTq0yx13SUAfP1?=
 =?us-ascii?Q?STr/yRWRj1b/ZGuK42eMKX/OpPyTSyLlO9XA67MXgg71vLI8VIZOZSM55qa8?=
 =?us-ascii?Q?uzZG70HDjQTZHZOoiLs+nlJA/Dj0hhr1hkDP8Kb6XlmVOn+xb0PbQdsCQ3XY?=
 =?us-ascii?Q?ncDrB4JsTtY2OVGZZrQ9kWZpLZv3IUDbCrBeM/k1ZUJS2fYfe3dAY7w7VTW1?=
 =?us-ascii?Q?YbRFnhGIVT/xIsHSOoZTIGNRkw8Jhf571OKPdCYSyhubUyf4hZzJO/XkkGpi?=
 =?us-ascii?Q?MfphH+J+kYI+EuICe1/QLH2+fhBVRPvV7EfjnHpiUBnSlJX/NMdeKhIaD7/d?=
 =?us-ascii?Q?TldUpCLFjLp76bFXqq7+MyisyxwYcJ8xq4qRtayNhvUGhNO8y2lRviMGRkav?=
 =?us-ascii?Q?hSooV4RFUroCGq15Sj2X25Evf1kdxV7sllynaw5JxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KGWIauRXcCfOx3Ziwyon7k1Tjb8yxLjQxy/lWJusLLIfOd98BvfqrxUH/IEG?=
 =?us-ascii?Q?MmJxjx2XzWJEZ/QtD5VigUeUYAX4+k0pvCNiHoA8iUUAg6p6G5H9Wxmym9CP?=
 =?us-ascii?Q?fXwSor+p33PtMdZDj9jKdPujBsgLe7RF+QwHaqRV4aRq7q1nUqm2j5g16stP?=
 =?us-ascii?Q?flcDhHYAStxrdQTTyNY2a307tWuC2ONwbeh2rJlwDeSwoWXd5uBuKIXn0WGN?=
 =?us-ascii?Q?7LldlSpFRAni3M4f7wVF9c8M5Cfgaws/S7q6eHSyTVR4o0qYSKaBTd0N+NwD?=
 =?us-ascii?Q?piQbk43K1CJCjCAxEGoh0DkkW0QG89YNtXggeNTViUaHpJq9Ng+Olf2fcN9O?=
 =?us-ascii?Q?/aSm3kqVeAsWbpJ7Z7/226laKMKpYk4AUTqXwm2E//Pr33zVn7kMOenRSxf6?=
 =?us-ascii?Q?aO6/8+vpYNgRG8HBpM+kziDgfcPd1IS/PjFJfzBuHewREWxXeUvsncBsmh/N?=
 =?us-ascii?Q?QsjmtUFuTScOdW5DLMxlTRZZdtu6Iuk+a4BYcd8TXm6e2VA8dc9Eu8+JurvI?=
 =?us-ascii?Q?fBKzS4KkUpa3KNC9bJOBgCE7BR5d1aR97dUj72NmoLECaiO0AKvfeTOTQa6c?=
 =?us-ascii?Q?flpS5gWb3ULaJlUmnFaCCjt5u8CupWlViyDpa0wW7fvKkvr/w0tKzglf9SVp?=
 =?us-ascii?Q?sN5SguifAJfsDbKjYDDnB+EQ90CnS2eiHU4rIU40IPcrceqE68WXUTTYBHQI?=
 =?us-ascii?Q?MkOaJBuJ1RHTd+qBa0ciLcEvOXu63kXGb+1KWWujMdBS9OI0bbCFWwX5zd1K?=
 =?us-ascii?Q?/NvqdZicDvPxXSBqu2fVhaDHJuoZajt7XaHeBeQc+CZOuOY1VaOh9dZqULHR?=
 =?us-ascii?Q?FN9HJsHs+wg6bhChq/MX1jHxg/EeJZPB2serZYTDGYT/047NCsCBQHOmfYir?=
 =?us-ascii?Q?zzijcdCizUBvf9Uvq5tzwROAYfiVsgDvkB938udRI5FCcgvwQ/mzRhGa2eUu?=
 =?us-ascii?Q?92TOIrKzEj/6DTVe2TS9ytueSooVoCe5if4OU6A1zonqDNYtdX+krANx8goT?=
 =?us-ascii?Q?BFiCNFcg0nan5P133GWao17bL8LsDLHTz6Ohg+0Cxj/CWXVUWxA23szGU16Q?=
 =?us-ascii?Q?fmtyCiKS7weU/En5WvcwPP64lwN0uT4J/bNA/kYd5VuoeIfLxlOCa+7Hokg4?=
 =?us-ascii?Q?BPcQHq6w4yBms/iDnc0vgg4RvTCeraEz7U0wWLtvvqg6m6spqWZR7MOiYJwP?=
 =?us-ascii?Q?m79D6Ss23TfCzN7BEHrL2G1OPpF8t7xTDPGMh28cInAkqQEh++spmh3scJCQ?=
 =?us-ascii?Q?jzE30w7YCJt6xbDpQst7abTWXvHOgISZbtyBbRkAYKQ1/i9aIo7VadqoLCQm?=
 =?us-ascii?Q?rw6ZkmeZybBL9+6KEJ1hrNiQK40WAo/LehNZIyS6BQn1byKbAkH+KSSagjHZ?=
 =?us-ascii?Q?Dq0n5VKRKHLo3EfNFBtaS9zxt9ocTbWWs2E1Ra8Cq4x8yHm67Uf92a/X6Hs6?=
 =?us-ascii?Q?ZN+rPDdy5tYWXZbsEWAO4r33ZjpQHnbw0BJWjG4Qe12fvQbEL3LIWQkLLZer?=
 =?us-ascii?Q?fBoogknCIXIXU8JB0SI0Q9x5Oc0mCU2mfmpSa3LmZvk/7RiDqzouDQ9f4Kzl?=
 =?us-ascii?Q?XOkbgEJNq26p+o73A5n264PHCuXXWjyadH08ek/L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b84f249-f04a-4b26-8438-08dcea011bca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:29:26.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ag++Bn8YTo/SEJBUKgo2/HGJHatshLpNMkwZyLiwYghPKRUUIwrkFv+0Zv49xqIWghiIkYIuvXvO0kRBAivJ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com

David Sterba wrote:
> On Thu, Oct 10, 2024 at 10:24:42AM -0500, Ira Weiny wrote:
> > range_contains() does not modify the range values.  David suggested it
> > is safer to keep those parameters as const.[1]
> > 
> > Make range parameters const
> > 
> > Link: https://lore.kernel.org/all/20241008161032.GB1609@twin.jikos.cz/ [1]
> > Suggested-by: David Sterba <dsterba@suse.cz>
> 
> You can drop the above line.

Done.


> 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>

Queued in the cxl-next tree.

Thanks!
Ira

