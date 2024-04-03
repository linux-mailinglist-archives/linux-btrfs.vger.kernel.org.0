Return-Path: <linux-btrfs+bounces-3896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D0897BB7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 00:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D775B1F28773
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970D156237;
	Wed,  3 Apr 2024 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ4qzDpw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB4692FC;
	Wed,  3 Apr 2024 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184099; cv=fail; b=RnL+bzT5fLG770NUKm+bewnQLLiUWTktfKsetu/BKRbzjER3k8Uci/oJ6RmyO6f2pgYb5zl4MekTah222x9kVUeTozC7IhiJhONbHsmkJc+7xGZYeDfIwzE1DBvEdJ4maQ+r10pwwLgCOs3nhDPTk8OEE6xDEiR8xd2r7FHT5NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184099; c=relaxed/simple;
	bh=PaGqip7Mt/pxJ+JJZDfzyjKmL/0O9aPHqdKz6vU1jqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nFaug4gOPf8CVEev4w9AOW4og8JjRcPuLEMYcJ0UCP7K4bQUBgpFJrXuWN1msK8MUGFg4uI4JN/9MP9oz+GJWUe4D6M5suMegAsUSTvj8qr0352PvQoFn/6HEFyNqEEnW+7HvpmPUt4KoFsVvsAKv6pn/C5+93QYWOYh6PDoZFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQ4qzDpw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712184098; x=1743720098;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PaGqip7Mt/pxJ+JJZDfzyjKmL/0O9aPHqdKz6vU1jqE=;
  b=NQ4qzDpwCCSjx4x7a4O8XTyQwLNQziPJ1DA74uI1DrbwyakfVQ2WFPPN
   vguxjn6qJ+zx5djJHkzOwLGxZfhHSxvcYLWCK6VUiSPienfJIi2uRS+ww
   p91zDxNKkNSWpmFpjYHr8fDZUpqM0z5anDvTxZBT2GoWoLJqfWEIr6v4f
   XbFS88JFRA+SuUTIV+QdFUV3pU9FisPrESdNQtvC2qDk6CQj3MTsv1O7K
   7/BPYXTASF4GQtgr2al8jiO6s8nKYLcPTQPEf9jYM4mTTrSVT+k/n+7gf
   0mqm+ji7V7O5O3bAhf7HLv2LBSE+35AFSdSF6MNEcFjpoVsd6uXW0xbWm
   A==;
X-CSE-ConnectionGUID: QuqDdTNxQVSx2tQHpPvErg==
X-CSE-MsgGUID: Cp0BwT3gSqGL+wSX0gthLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11273915"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="11273915"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 15:41:34 -0700
X-CSE-ConnectionGUID: h2hQefXJTYypYTxp0FFu+g==
X-CSE-MsgGUID: s2ju0SYnRVumN0vhbYpShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="23286128"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 15:41:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 15:41:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 15:41:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 15:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzzSNDl+oQZB3E+1+MJaq7Zbj6tpBxBBgTLvlsU43GII8p4xRQsNywjkUHnWmVtOMT1hRrWiUFeqhcM4pY73LjrTgmwN4SGHAP6KEG4i+r1VgjVnDppJw8jQGKpenEAWoq0UciGSgHyvnb02rtp/T7RrjQmCgznNVnGbzAmDTlEDxOsNudNchMzZ7Q5796mHtjIakLeDvc3qX7Y6Ah2FQw03LsHhtBtaj5YadqlFHzriG+40YtnPODDlHtD04HS1vOaRH8MwjOk6nZCJA88Nmdoif5JKHWqds5iEL9BYfk/Mxd35NmZsXTV2W4YyTpOKSO8J9BLZxKQ5l4ewe0HCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9i9dtOvlSuWFDIW5Kvi4a+yQ7l9BXrdhHPt9iBolWc=;
 b=jfCLCbdvEsSxnnRRXNJYjxG/LA39ECs3xbH5AkwWkbFI6nC84k8sPedLsM5a4SG7Ctfi9ZFXTRg5z+1Z/KPeboZ+Ar1Sl1CG1uPsuQJ9s4NpWH9Z2ubhGc3/xFYLyBMqp733KhMXLhStrAcQosaJy9OEHPAJFqSwGK2ke+WWVJeeg9qw6F4tJrgbIdk5KevAPlusE84lq575tTYAdhEA5yDu2q4cEyI60fsdj+uehUTLNA2+Qck7ilQZUrX6tgph+7dzDjBgrrzzvDERXvFY8gm1XywzmdSWdQRsoKKuOzVqKr1Q1Y6leinK3XnBDTTb/wGy7h+d3k2GNsC2vAl2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB6543.namprd11.prod.outlook.com (2603:10b6:8:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 22:41:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 22:41:31 +0000
Date: Wed, 3 Apr 2024 15:41:27 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Message-ID: <660ddb1752d75_8a7d02948c@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
 <ZgIKY27PVnlGce_m@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgIKY27PVnlGce_m@debian>
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB6543:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuCDXDGaYLXvhTSN0lMlIkKm/Axe8aNpd29nXLehtVNXeLicCMewb7jt4I03kSg3j4b1V5WtA2T7qKTs0Qk1lrcFwJrzU3gK8Z4+VDhGzhsJuVSN+BWYoWhYE/2IuvexRD7QzO3ULxeZrib8yNGyVNSo2WH2HLFcoYHk2bSOKLFLA6T/dCwoODMkarqdWKiXWzURl/c7kktx1FrwCUFZkKdNKL+gHw5OkLqquxYSliWunC42a1Dq2Fb/6kN/zeS7OlxqfXX2hLE6+XeJ0UBwp/CGkWIMiTxjHMgqgxpvmoXofztLt8bwhNLL8uJyUHsd647r+qubxMRfki1bPTd8C9aFtdaPfe2tejKfqOj6vU0k5UUdcP6Ka9bEhhClWjDVqDQrNe3JFhHRkf425qLrCPT/tPmR0+RmncyP1FbzM/3fF+5/sNOZCFMurdQclZymmh+Cp33++dD9xPVvivnrASHgmpbQLZedacGkoTmr5DiQyi5jQh+k569Yqf7MB0i+/9FPmkzuLZmbZV4HUZfsS3Qgv5u8KGMYyteZ+iWl9c1pQYY4z+nXnf7diCN9eY/dKkr/rSdCdJxr81YLkoqplZAz/CN5oZgA24fzyZUAatuEwPeWlNsgcwOIsjjaV4JoSCq4b/Lp69vvgKU75fary4rJCSYCLoivcIw/tkw+HnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OrRflA4M3/19D59BJRuCkp+Ssodiwc8VntN28Llq0E+HDt3fh1CB7qHWqMjT?=
 =?us-ascii?Q?nOL4I5ecw6BXiME1qMZKa6MnU0tCDGm3oZJlqaTgeNJTzGqhHMR/+La8Ykz7?=
 =?us-ascii?Q?WTRPI1MuniwQMhsXPovFFEbHhYxmJiVgIsRnhXW4v3vaFG/SUuaAF+X3ArCc?=
 =?us-ascii?Q?Q5v5mdOzlCn/BSY+JYbcIima2vO5AidrFgl65Wx6WxcGe7vfmvNWVSN7cjGR?=
 =?us-ascii?Q?4tR6ZE71NcgUrN1NlEJwYAwBrbz6BAFnaBEhyVg2qWZvJE902XE3ZT0pqXND?=
 =?us-ascii?Q?xN4rVwhlR/Oeq3yceIsl4o2w7V8MBgayKNWvCukSrSuPfeWDaxjlo2gN3xK6?=
 =?us-ascii?Q?FrwKILSMD0bxL2X1C73Vta8n+F3U4EQYb3gTgjudHUhH9RnPY7+9SZpaZU2d?=
 =?us-ascii?Q?ur9Usy2cBXBlLxAuJaERcKnT9gC2i/2vtWFMz+OdwmjT4bA8CZp5rdc1v0vr?=
 =?us-ascii?Q?MhBG5d+gK0HkPvUVg8Fel3aOXoeEI05EcLcmxalc/3a6KW94kGEYiqMD74Wd?=
 =?us-ascii?Q?3YLgdmYuL2Gcf+iQhWY2gE+Ygkgz09PbbQQ/+ZSlTgXdfxxuC4R2aFUoDCkI?=
 =?us-ascii?Q?mgELdMuY2y34AqUxoAUPZ9wRT/tXzyvMx4oNfz04wmBynBSwgwtK4+qCSj8b?=
 =?us-ascii?Q?wUPY3rdNHczrrIZRCIz/dcHD56U5jURNrlepXpg+aaFVWsRFlAjCpS3Iu08U?=
 =?us-ascii?Q?ba0Li3TJ+iwzpQwSJ8WGl7sQXu5eUGyLN+iYS9rh5/VOOdEozKJbBXumsZ83?=
 =?us-ascii?Q?Us7EDjZI1Dku9OEtt/JEii3YXmQG251c+FFVCdud/ZRmOt+9YA++5F4j1oKr?=
 =?us-ascii?Q?hvrSOKKfajuhBka/Q8JkHrMiWw6XVJR4fOPG51S9uBF6tgTwkP/LZOSsvrEH?=
 =?us-ascii?Q?Eo+sxk9zGqF1q5fLPOOKxa5U6azi15Ja+ugw9++vcunZoa5JG5D9cZN3Evjn?=
 =?us-ascii?Q?nuinNTyBDAtn6fd5SMgTMorPIYY+/t62l3Tuy+e5sKK8yNcAVKQ43E1us2h5?=
 =?us-ascii?Q?R8thve6UFOGsMcOxbS9Yh5Vl+3h21duRwxfmrnIuo+0tAbW1btPAkRUH1olU?=
 =?us-ascii?Q?Ebw1+8ydo/MuhrLme8q28FMOKVyfvWsXo3ooHcXnsiq7qa+HONrnFGCHQOKe?=
 =?us-ascii?Q?yzNfFbpmWB7/C3eBVnucPLXj0GPvCxgPpAT5qt1Efh4mlhC4Gw+SA1SWLk//?=
 =?us-ascii?Q?F209kw8tRFTWoMsRpXbwHnIJLWLdivZpOh04BTco62rJeyCTzzY71rtklBN6?=
 =?us-ascii?Q?L3O/6LnzhmzChBQeeDUXVCcE4YtvU2KDUZmDjnUQ8KmgJ2O5OqZg2NHeqmDi?=
 =?us-ascii?Q?4GK6w2HDA7D+LuNmP5CiQQZDVEmWuoS5RzI5RCjiQDUyU0+tjJcRSKf8ddPD?=
 =?us-ascii?Q?BgY8wjmtV57xH7moyaLUyV+iky8hW7WEmL75uIXf9+hI41BXj+bPa7h20z+p?=
 =?us-ascii?Q?WK4NxxwNqwHtUx8yNKdG5NnPqP/QwrQH3p5DPzRdO7kllLeUydmGfdp2iFOo?=
 =?us-ascii?Q?77bJ86HQSfx0wsm0qr8guAQnA/HoQz3WVPlXnQdqk5A7a/WuAE5R+Tk7ee6T?=
 =?us-ascii?Q?Etn6/KG/og+6NaetQqEj8krAqeLzX3y8HrRPyta2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f575c9-4eff-46df-1d64-08dc542f350d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 22:41:31.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baNgTM/PQfNdULX11Yjgz3sM6ZJpok9xIOJzZAg6AZfk2fDOWqFuvNuVerw19JIwsrmztPnvf33JJjX4jm/zaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6543
X-OriginatorOrg: intel.com

fan wrote:
> On Sun, Mar 24, 2024 at 04:18:06PM -0700, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> >  
> > +struct cxl_mbox_get_dc_config_in {
> > +	u8 region_count;
> > +	u8 start_region_index;
> > +} __packed;
> > +
> > +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_get_dc_config_out {
> > +	u8 avail_region_count;
> > +	u8 rsvd[7];
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[];
> > +} __packed;
> > +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> > +#define CXL_REGIONS_RETURNED(size_out) \
> > +	((size_out - 8) / sizeof(struct cxl_dc_region_config))
> 
> Although the result may be unchanged, but in cxl spec r3.1, there are four
> fields after the region configuration structure.

Yes.  This macro is not needed.

The fields after the structure are of little use to the host at this time.
So I'm going to leave them out until a use can be found for them.

Ira

