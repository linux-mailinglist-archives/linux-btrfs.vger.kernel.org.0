Return-Path: <linux-btrfs+bounces-3965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0589A3E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE28D1F23AF6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F7171E76;
	Fri,  5 Apr 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMNUUjVu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A31D530;
	Fri,  5 Apr 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340576; cv=fail; b=e/wDK70S140/lZ5eg81KQtem2uOQ83OGSvH+oX09TReyIk3XPW0DtQgKbJaEMdEB3ZLo7s2AEA8LsTOVdDNvKuofWIbf3Yj25cAjpl7WVJJR3AVKK+pPx+pKHyxbafRDiBLt4gesEWOn2EjCVJZBGnGJeGTy5Yi2HQx2RLVkSik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340576; c=relaxed/simple;
	bh=G6eZWPGdC5ngoxlCOmVTh4SvlCMUybIODKMgon1wgAQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0ct8wtxrZqv++i6ZVWAvkwL+eRrm4kpoCJHXcoAkH1xyp+EzazyYq9G2EKUdMtt1WW+4QE+hbCYjCjBmD8e/1mLHGy2AsyaJokJfLrx50d2FRCHH7fzfWZGR86k0x/XJzWAZUC09Uauv6x3522+yCQPc8Ak9cIGhXDDkRAEmuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMNUUjVu; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712340575; x=1743876575;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=G6eZWPGdC5ngoxlCOmVTh4SvlCMUybIODKMgon1wgAQ=;
  b=FMNUUjVu4VCZ0KCiGc/Kd65dTFhfBkDVH6X31lWEOpPT9fEYjeJ1Obs0
   XrqIUpDwnoTKQIaKh6e4fmIfDEhy7Wt64vUmMkpABvyQoUjFArs8LTCTP
   VXEo1p7GsfhEueDdlYM3SvYnNOstacR8qY2BWssZWg4XrhIY6Ustud+oc
   hKUNukxvOn5228IcmkO34JDO7aCgIp411Cj8DvSw8ZubrVzgCGM7DeWiz
   B1fd9RRmBWPWfCnZmgrm54d50sCXRHIrb6k7fhuQrTz1P3qzXwhHUg96n
   mOeEB6sBj8Y1g+32LcVGLX2Cw4izQsgJDwcQZcS7EWuvmIfZCxbQigTT8
   Q==;
X-CSE-ConnectionGUID: /0TREOiKR1eXUvw6wrUtdw==
X-CSE-MsgGUID: 02TbXa36QfqWh3uvcNSRBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19116580"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19116580"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 11:09:33 -0700
X-CSE-ConnectionGUID: KDYUzzsZTOicmHEL3UPuDg==
X-CSE-MsgGUID: OaWr9XNkSL2h9ijNRBu+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23739763"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 11:09:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 11:09:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 11:09:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 11:09:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfhLDru1U6+kAbXiiWTT4/krkowmU23/4Zk/3xZi7fxZsSy3QvBvwmNfB4aNtKidMbHnbLzbzTLWzvXOL4Rk601C3BnTkJvMs0YLBh8CJY/1VlM4YDjIJxi7W3TwL3dnqgA2dpIcrMEKMw6L8MyC9JXUpmX5+bWONe8zLl58ZMbsTcgoicn5Btk/LNSo2dHyd7vvWeOz/XAn6uAMqIORc0pXrMSgpBHthYT/Tj5YnYGz3IdThDrcfIS19lG4SdnZoTNxsxbFsLdr7roZsVAYkQL4iU1mefBD77faSIfYaQ/VVsNysO+dJ3BxXAh/UoiBGphvZ45/Xxeu0fL9doOEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3IfNraDyGSjmAntnBVBy9F7gPi7K+CIvm1D7mxA9yw=;
 b=YzXNZop3OCvSjvkzl4oDxUgZVnJhuXBhOOMult8MPC+OS1MyPhsYRWRpn9lYjKWDxYltIYyPzTc5fQRS+NTzSDYhB1iunnNOvUfLPLxcTSrxbBCKIW1kxK9PawVEWEl02+GPMFDtFPq8HPui6Unp0DfiVf9JYxyzhotlbDgbPdOR04v5n8GwXo1iXBTxPCyxhpYWBTbNr+gvIUoVsW3/NzETy5XnjUxZlntt49LDP35RfaKniThSKr5yv1N6fnKjTI9ngSf5IwZMtIGG2upfLBDZjoC0hJTTm/fBniFeLMgxde3dLGitEvYJ9ktKkW/rpWnVYGa4JnOrXE2XUEvPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 5 Apr
 2024 18:09:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 18:09:29 +0000
Date: Fri, 5 Apr 2024 11:09:20 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Message-ID: <66103e5045e1c_e9f9f2941@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
 <79ebeecc-1650-4fcc-a5c5-db64ac16316d@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79ebeecc-1650-4fcc-a5c5-db64ac16316d@wdc.com>
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8537:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Fby75vxprpYEqU+S7YYBjsSsnt7gAOmBWjcFJXxrVmslRgbYdCKVj4iDn8jM6AUKBbWcsqejhvw2Wt1rnh/SN95hLJhmEVsBSFGO0iSQjTAaJ74GH0o4kmddjBrcCSrBLp5hVFet/uwDApCJxEQtCPQzBtbHstH4su3SSbHzdlZSVKv04dwnoVfaGFplNDaE4oNU2Iynap5s05y/iQw+mU8eOr1AiaEx39SufOasy4wyycOh3AyPMxSph4/Qc8eoGZEs2j9I2KeXean9BWq6jRJg1k22Qv/2TKXvGAT/IE5J8WB5ZMWM3gi6f6KtcZorhIMFbN23zGt5Xxl0oH1ExSP0XWx2vVPhLSVHO+Q7tHMWChDZwX3OOm1p+Ec34pEhPfrwEfKVys80oWYkaQEgkmvE6hItcP6nL3WbQt81MY4MceGUkbYxyb7N4t7xCIvczIqAzxVe73JHrV1PXWoveFfzNKrcn0Hb9EDYaAlVQ+sF5WK7dIIFIhyme7gL+ITvShRaaV9xv3N//Oe2vaRXroS+6QtmilAwa7rkY3Yr+8AceqUD0eKp7gFIWj3QI+RikvlRkOpdlm7sEdqJmmy6QXJhz4EyxUmbe9XUXpMxvwLCkPmBXhc3vVSbW7dZ0Z1ZocZBXaZ9ihoqBbTwSPmkAw2LM6XKkTWXWb8hKimeNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rnhZ8J1Uhd2xJJgBKXyBkkD9siLu29bfmBUymUq1CWb4yGcgk7Y4QpE7OO?=
 =?iso-8859-1?Q?olxDT7SChfAO5uRq7qECXBbhjMrteNS8ImdKd88kdGnO2PEI2nlHgkwZne?=
 =?iso-8859-1?Q?tZ3RENMx6eQ8siflYIEnieF5+jp7E1F+5r2O4bp0/NIkOy/tEfVyAKo71/?=
 =?iso-8859-1?Q?ZSPLT1NjUE+w/hYv0JuAuWc7vt3SIKZ1O9duPBfSA7W4edj6oF78NohZ7u?=
 =?iso-8859-1?Q?dYKq1XDrEB71GlMH11su0y1guM+JeFAaxWg1LONOujCb/LMh+yZKuvEmTj?=
 =?iso-8859-1?Q?ws4im7E2OEqKP59hWv602EYU05Q4IT0UO+9dVq3GgDVCtv0N2810lZsmkX?=
 =?iso-8859-1?Q?Ha3btWXi57AGigdjXIQ5TxOtyHJ2Vhr0Tfxq2t06ergjWnb5eN6fO2YMuv?=
 =?iso-8859-1?Q?Ocg9aJHno/E0i70w23xCGVe2Kw/A8IvKdg61g/rLgXcu29bvZqTDcuDQpu?=
 =?iso-8859-1?Q?ScM4LrsCtKK7ym5cgX/T4vIN2frxMKVi8Tir2zj5yvq5CCJ8Xv79ioJRfQ?=
 =?iso-8859-1?Q?5HEZW3Fofz/4t+dHOFQiUcIgG3lc84Zd6rIaGJzl2vQZzSr8v5URWWdP8R?=
 =?iso-8859-1?Q?1D9PQi5TO9s1lCLhbCvJweXIu9ZtQU7UxzAMofZrgGtTI9mNK/JET/jZDv?=
 =?iso-8859-1?Q?0xN3vS1nELE0Au8gnvZMbuHFa9GV+DTiBNzI5c2eHXaC0A3ectcs3zluJW?=
 =?iso-8859-1?Q?dRZLZsH60EsDTZk4y940qeeJ7gZ59Wwjr/cPDfp40Jfph5t1TJeSRJNPiD?=
 =?iso-8859-1?Q?OhY7n5vCByJMQ9YQQTxKhQtI4E8IBGe5JERhdnANGW4/AGIpFBMLVETXVn?=
 =?iso-8859-1?Q?yR056S0aKEm6k1g7V6X6FXH/t2LYfUp/BE6OUiuImq7qEUcHz2JZ7XYoo0?=
 =?iso-8859-1?Q?48SZehQUm94xcPWL7ocuknoSVQ5xpqjUNRUIPLaghVA+BclHKojBFDdsZ+?=
 =?iso-8859-1?Q?6Mo7rkl5jjQjRu6TdaXZvsbV37G1aSHUpgeuerrXe4B/yW9INIRIGVbmQE?=
 =?iso-8859-1?Q?6U82yuSk3iSJC2dMMZ7AV900mWA771FN4Z+77jkF0cJajW+WZtdLs3ngYW?=
 =?iso-8859-1?Q?06TrhzqM5NJnfTzS1VVAzgIc9/+H/5tCy8eKyJThyfdv6II/1983m2qK6H?=
 =?iso-8859-1?Q?RA/ZodP0Irffyu+VzBjK/yXLwtrgdARgfJtghfdyl23ATsO8tLHvIhyLUa?=
 =?iso-8859-1?Q?//oFeiuaP3l0+3+RqouABI/5QEyevxGVlpvaK94sQJc2vAeid8bf/vQSQ6?=
 =?iso-8859-1?Q?DKDJS8NisJCKcSm17HSFCja92QXQ4AM8fAvEbLKG309GNV/X0fbsFzX3+a?=
 =?iso-8859-1?Q?BnjQDtMqoyfocoY2xoA3cbcu0BB04/fwH+/oPzoRzPQrl4n19swu5qVRX2?=
 =?iso-8859-1?Q?hpq1ZNfRQQN70AVNpCCHLQGqy8PMr4TBiM1BT4pgH3vTf6OXN2DX7XKPv3?=
 =?iso-8859-1?Q?GULExCZh6OEVZSubtcznhwi+iRGDde49ZQu9OnAhUn6RMoqhbjffAVvFgK?=
 =?iso-8859-1?Q?cHTj7urD4HteWlCy5IjkuXaou+ff4AHEQTKNTTcRkNam0cVNNRcBUotCwW?=
 =?iso-8859-1?Q?oRMXxmHSA6S6Tvsr1QVxEhIg2qi7ImCtT8JtWjn6PEPIAv3I46zqSyp76u?=
 =?iso-8859-1?Q?KsvP75IGSmGs92WaTKaHsCwpEuOx0pGNu9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e496445a-bb31-474e-4f5e-08dc559b892b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 18:09:29.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FwFnN6PpqDql5p37Ea+2tD1/tNB9rKbJ3TyMaequSeePZ5F452pxSHgjjmfTa48+5RvsJbhuJ6Ykd4+vVmqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

Jørgen Hansen wrote:
> On 3/25/24 00:18, ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> >   /**
> >    * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> >    *
> > @@ -467,6 +482,8 @@ struct cxl_dev_state {
> >    * @enabled_cmds: Hardware commands found enabled in CEL.
> >    * @exclusive_cmds: Commands that are kernel-internal only
> >    * @total_bytes: sum of all possible capacities
> > + * @static_cap: Sum of static RAM and PMEM capacities
> > + * @dynamic_cap: Complete DPA range occupied by DC regions
> 
> How about naming these total_range, static_cap and dynamic_range to make 
> it clear that the DPA range occupied by DC regions isn't necessarily 
> usable capacity (as opposed to the static_cap where the spec defines it 
> as usable capacity).

I thought this was a good idea but on second thought these are not range
variables at all.  They really represent the various lengths of the
resources.

For total_bytes the documentation already says 'sum of all __possible__
capacities'.

I think you have a point for the new fields though.  They should all be
named in some consistent manner and documented as such.

So I propose:

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 94531af018f8..9c18b229f69a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -481,9 +481,9 @@ struct cxl_dc_region_info {
  * @dcd_cmds: List of DCD commands implemented by memory device
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
- * @total_bytes: sum of all possible capacities
- * @static_cap: Sum of static RAM and PMEM capacities
- * @dynamic_cap: Complete DPA range occupied by DC regions
+ * @total_bytes: length of all possible capacities
+ * @static_bytes: length of possible static RAM and PMEM partitions
+ * @dynamic_bytes: length of possible DC partitions (DC Regions)
  * @volatile_only_bytes: hard volatile capacity
  * @persistent_only_bytes: hard persistent capacity
  * @partition_align_bytes: alignment size for partition-able capacity
@@ -515,8 +515,8 @@ struct cxl_memdev_state {
        DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 
        u64 total_bytes;
-       u64 static_cap;
-       u64 dynamic_cap;
+       u64 static_bytes;
+       u64 dynamic_bytes;
        u64 volatile_only_bytes;
        u64 persistent_only_bytes;
        u64 partition_align_bytes;

