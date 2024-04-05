Return-Path: <linux-btrfs+bounces-3967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D5989A410
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 20:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6264828C31E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF41172BA5;
	Fri,  5 Apr 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWWRQnqU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2101171E5B;
	Fri,  5 Apr 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341172; cv=fail; b=L7Oay6rrbKP7z2cMqlHBacM8vQjxYu5hadJv6ARoLwEsf4AvW4K1iZ3Y8v0C3t+4STfukDDnOg00tvNoxyd4KONLnbDYaeDdi6RhsenBiYu4m/4jNC0bc6mEpNmC1PGD43hNXmuM2VAjm4YqgW3qJxmZ5c06Rdi71dzFI3l8P9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341172; c=relaxed/simple;
	bh=lc1SYyTik6aUAm22/N8o7HbxBW7EkmW9oKPY7xupobE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iO2u9jZpAMQSdhxP9IN9mgHVvzAe6mGme616eKndgjtXbMuVU29gMCXwCuUigfvQzgqJMDBVrzI8pQtC4WeVxReJBKZyYrZiZmAyhIMGF8rHluSFeMt6Aln8tGZhy4CJ5Hrfc/urmddEorsBjKjXZr08cQe1ew5oYn+F4/1VJT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWWRQnqU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712341171; x=1743877171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lc1SYyTik6aUAm22/N8o7HbxBW7EkmW9oKPY7xupobE=;
  b=EWWRQnqUx78GUYO4Y9PyWtEu6r7mO5V1f5sME2TmJqTGTF9AUlQZDjYG
   KdZWXljRTiw8Tqf1tvJIw8GE4EEmISRTF4lhkzV5Om+odXSmk1GUC+c8O
   w/CZTvmkNlYzpsDMBj1YAvl4qcEEg7L4h2Mc+t9+aFYlbHLv2HBLO0Yhi
   g/yxrSQkIZxTHULEwOR8o45qM+dJN8RSSGL6QZMAVnEz6sp61UHQAZHDn
   V6z5lZOTLoVBfuIqr5Bj8Kfe+TRvStyMYjhNX58MXvJ1i0OQ8ifveNl+8
   Klqam3sRCFpn5+XvtdfgCoK2YFUFEZpjh9c2O2td83Lzj9Q3MjkopgmJZ
   A==;
X-CSE-ConnectionGUID: wsD2YhBeQ2a28SA1RZp1GA==
X-CSE-MsgGUID: /pDudTtFSqm/5hHXs0UnGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19038241"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19038241"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 11:19:30 -0700
X-CSE-ConnectionGUID: 56LUwg6JSuWjyXR5dU237g==
X-CSE-MsgGUID: dkZQjLFWS6a+Lex6btmsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19685446"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 11:19:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 11:19:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 11:19:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 11:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKAh4QzEAz7VG91ML7Z2w18Q74b3HelwGdIg9+qZIFi1ktPhlkhukG6B4e2DBF/W2qXPIrUVezFtv6Jon2h7IA7bkiUvn5FYVTsZGIqb+V9TuMwtJB2FzeL99UZFyUBfB2i6jG4NTzJ6TLY/5GNpn+zukPpvlNsXhOX7//q2rtns0c4hdzBInfsqArTaKV2ZZcS3Vamin67JBGrxPjm0dYF4F1hkSPg9d9496TsUAfOhaRTkWqTWEs4+u9VUKpbZX9K4SYcZz/IWkeN/f9oPi69Edm4+X+jCrKkLalBJNofgPpYvpwWpkTtpHo+lf0A4EKlEox17TMR68pHuRRwZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/8KuFyicCLb3DUz1SUxzQcIhnjxsw76UEd4dXD61A0=;
 b=AcML0r2ZQ5nVb+ZRN3R2DGiWtP8QhBxAd5AA69BohE1BWXAj7WjpgS9RTafENkwZGpryYnjMvEos+JzlGvb06/X2FZuHPm1TouO+EwwU1jjgLDZQTLi0grd8Ds62D4R3I8WBoqS6e2pBZwdAOdTB4CmISFAfzDFFSqZslqcPU8VtP7UV9n3UIixn6nAg8xrQfD/jKqA8bO7L9rWpu7x1tqmOKO0sEISfyOHyuHuWmxRZza7NsS8J/QU/JQl8pqTKEhtg9JiTjZDHzBM62LUYBm7nJg2v8/RqfAmkh9lJFtzHxdyKQoKrnRyqY6rWl9eCAGfhBJjk1QKvP06cPBjutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 18:19:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 18:19:26 +0000
Date: Fri, 5 Apr 2024 11:19:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/26] cxl/region: Add dynamic capacity decoder and
 region modes
Message-ID: <661040ab52a14_e9f9f2943c@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>
 <1c7f63c5-1b7a-4f7b-9d48-4dd8b017d7de@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c7f63c5-1b7a-4f7b-9d48-4dd8b017d7de@intel.com>
X-ClientProxiedBy: SJ0PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW6PR11MB8440:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOZoAgftldyIPEueSkys492H+IZQLON5Mi3jNl67TmRjAf/+tMFFDQebJ6D6v4hHyArHqYC3p6QawZwx+1rE9s/HrCsMQlExTKBNDtGQkQVlR7sgLoWUaDDo8C14zAAcU40r4psBp/yZfilDxvM7p0CBIjn8xDcCfxsuMaLucVwS5B3WA9QchsYsXMZTbMgEHg2leiAvXiyvfl9OuaTVcRH26zCTbDjvN7fHnS750wvHPnb9eooeeO9TWU0uCsWOZEKTyfS/XesOujz7raa9hwo1l94UveaF2GakzK8a7bdVw9BWh9O26Hw/lYy12EaeedqdE1+mMT0iQmNQkYN4m/Gyw80Fu1s2iwN8THJnhPgtAgyJ8TXMTlZREvVGWBiKYBrFL2I0RpUTT2BNu0JTA9IsouCZcxKSmDI5P5x7Uxeb9lSJPVys6sZedjONov7ABtabHxcTi4/3V/GUYBzUULjrjnuWfl4kn2Mm8GWSnpKQiISEaED9Mc7Q2/FnDmvwyMciIVUB9wCTNphWs9XgsI7SYa+tq10CMLLLUSqq9B6G92zIlch82DLQnDSMSQ7DBkgU+1fP9Y4+dbi63ztxvA022LxuHX715PhB6O23FzJCT6qhn6MB+lj2oppf+L9TLjJ+TnjW0F9R5mX52czv1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGHeAvT3y4qjprQAFzsj14BKPWba+AJyhZK2GqBGjRBZXhDAC4dTiVlc6YYt?=
 =?us-ascii?Q?m62ofL9yGkj5B6c8tWXJc88+h8iyAb1qs3sXSpz8Z47YQqGxDvo0J9wG39yu?=
 =?us-ascii?Q?CA0xwttu9dTDjjn6WV89ypwVzTaT4bmOFcOAAjZ9ycHfRRiLujUqJE8cclwA?=
 =?us-ascii?Q?k97Xv+YcJAGxyhszF417adTZu5d5F+KZYkWNyd9cVpFzNw5/KTPUsVY03tDx?=
 =?us-ascii?Q?zrfPRXlHLzPqoHR5lM8HrXmLWAiyHhsXOYjJrstQ0UwEvXvgzBTBo/0x3JG+?=
 =?us-ascii?Q?M0V0YGHh/sMn27lmNeBUAAMVoqllX9+cryPEWvM5wz6K/uUW2JTF5qUTwGCg?=
 =?us-ascii?Q?D3yz4GxEfikLo8ZDD1s/a52J9cxJR2yYUoQFMWgpTRSRntyEmG1njIu43eoH?=
 =?us-ascii?Q?VFhUzRB8yI4Ok6w3ZbWzDPYBvWssQ/8fVALpN4sQbJKPDSJPLIbXdKpFh/D+?=
 =?us-ascii?Q?GWSS/Y4wcRdkULzIRe4Gz66pVSPVR1QTEqWwjFEpuHfx7YSpZYvk6AGUT4mw?=
 =?us-ascii?Q?VwviAfaeGL1voKkxvU/uNwdeGnRNfhDJk6e8lP256JbIMpMVPdz2Mt+/SSzK?=
 =?us-ascii?Q?DiQgjnyhLn6L7qSgFKIWpSpzDEahiAbsvIJ6NF6RMq3JdCfnR6G3+OLshkwF?=
 =?us-ascii?Q?+JWsRZWdTyBFvSIpFc5m5m/1W3dqc81Bf3Ypi4YJU3Gxc/5ZsexPeNzduDSG?=
 =?us-ascii?Q?v9X5HsryzPwydQz1pL/beohT0Rvwn6CUgWIOfRUam4zsaNdknYBqvB2UEonb?=
 =?us-ascii?Q?1X6uo4n1Xj4xiOQNAPgfi49eks4LEBXMWS2KYANkXxnOp4iGF3cXDqh7mn8B?=
 =?us-ascii?Q?EDclHgy8Y/v39IDdzaR1Vva8X490ksg6qtTn+NHo1UzUnlZ+soKuR8qdGfPh?=
 =?us-ascii?Q?zWy2eyRG2f0e4enn/1LkCGeLObFVB4N6T+q7QhTWOcv/kGnPRVqI4M+1Prq2?=
 =?us-ascii?Q?tiWanOLo4NVXlb58jA0MFMajtvGloWpwmtTCMeM4KNFot4c3ofOWmi5sQZF3?=
 =?us-ascii?Q?5DflXdHS7V/42WqAKyS9MsKW/WojD/5o/Vw88PYmzAvfYvifQLhe8zTkl8No?=
 =?us-ascii?Q?fnSAS9/Tkp15SwgZpwsQf8n73rK6ipu7u2jakw9H79PJbW8SRvIB9u0t0klS?=
 =?us-ascii?Q?SCtYgJ6vpoqnKBkHI6D36OYX+i1nO8Rg3hBzGn/sAyp7m2OvT49Cp00/hV/Z?=
 =?us-ascii?Q?K6P/V/j//HWnNXA1kc6/Vm06rHZLsuh/LlKSfUl/cgZA8Y44c0RQq/rHPmx0?=
 =?us-ascii?Q?r08+bytZBJ77am/P9KZVaUxUQS0bUcL38jOnmT+/yqAy3bEAWttabUUYCyYP?=
 =?us-ascii?Q?67ihgmq+WW1w17szheqXuS8+5Rlb1RQ70Y0S1YyaDZKTB29xeSXDByegzf8+?=
 =?us-ascii?Q?Vz42licssiqR2s70kB2s/iO9gDhOKCySC7szgvAmLz5ZAJcjIXiOrDI8LY6N?=
 =?us-ascii?Q?mfBXvqh+BcXVQTx/UlWfDx1eyMfi+J0lipSp2UV1ZF31d+Gn9e4VUGE67K0c?=
 =?us-ascii?Q?heb2eO63N1chgMMGs6rxZjxTrPl7RfR8Q+3r8t3xr03HokS+mSBpK67YGcUW?=
 =?us-ascii?Q?V76osaoXqiqN2N2qE4a8hSBYSx6fdbqiNWUpFX22?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e51b4dff-1901-471b-9702-08dc559ced59
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 18:19:26.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi2+hedl5S8JYR0M4sCGXGNOOjmlGueEsh5enRTiQAYSlivDfZmigLCIwcA23SiW6rFD/YQSBby6poVoFhZDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Region mode must reflect a general dynamic capacity type which is
> > associated with a specific Dynamic Capacity (DC) partitions in each
> > device decoder within the region.  DC partitions are also know as DC
> > regions per CXL 3.1.
> 
> This section reads somewhat awkward to me. Does this read any better?
> 
> One or more Dynamic Capacity (DC) partitions (and decoders) form a CXL
> software region. The region mode reflects composition of that entire software
> region. Decoder mode reflects a specific DC partition. DC partitions are also
> known as DC regions per CXL specification r3.1 but is not the same entity as
> CXL software regions.

Yea that does sound better but I think this builds on your text and is even
more clear.

<commit>
cxl/region: Add dynamic capacity decoder and region modes

One or more decoders each pointing to a Dynamic Capacity (DC) partition form a
CXL software region.  The region mode reflects composition of that entire
software region.  Decoder mode reflects a specific DC partition.  DC partitions
are also known as DC regions per CXL specification r3.1 but they are not the
same entity as CXL software regions.

Define the new modes and helper functions required to make the association
between these new modes.

</commit>


Ira

