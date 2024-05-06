Return-Path: <linux-btrfs+bounces-4765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6128BC691
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 06:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDA828159E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 04:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD345944;
	Mon,  6 May 2024 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkvXXdEu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54C1EB36;
	Mon,  6 May 2024 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714970149; cv=fail; b=pry7Hq3QqOp8fK7cb5kp110vXk3idSDhvuGk5V5Oc3zy+RUieomycuP0UsLqQs0j4Afe0C21G56rPIga5ZiEv6nCICWVM+Iyf3GLluMnmmsJz/aJzD98c2b13Z6aID5vOyPhQvKIl4iO06/Blomryf24qiR6FyBj1UOq9uQzumI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714970149; c=relaxed/simple;
	bh=ItI1xlddnTgbSoLUEY4MvvGr0OHvzj7tAGC/MOI7JOo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5AojmTTp0sYStM1uNjaDoXM252gC6lGyToAzcLnvPNiZ+8RyRpxXLpGeQjtGlWRym0F6GuvVMPUuf3W+SXNMgQ5gOzGd6KCUbVhjIMvsH/WjrBKSkbaW7vPSQh/28X1lUU0sWeSnRWzACEFNACXgMef1dA7esssrWvInfqw5fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkvXXdEu; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714970147; x=1746506147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ItI1xlddnTgbSoLUEY4MvvGr0OHvzj7tAGC/MOI7JOo=;
  b=XkvXXdEuCA1qXivLnEM5PS7Wb8LBqD3ZSqT3+cVewEJ62f72/3H5B/76
   Hv6Wp7cM6P9kkojtFaWqRa9KU6GUhjY28z7ugqAYuzX6ocZz8ZqZOks3I
   d8Dowjm9IDu5iItx+u8ajD2TW3S+dgjFujVeeFw7PSwKI8N2mpUOnA8LM
   9yzQgp2UC+03ev3LmsWEn2m75ZiZ3Oqvk6fugKupiXBtnatLQpXZwdJlB
   hPmn4vtFTAFdiWOSg/GXN4gGawRShWh9uC3CMvRRY39zcxZciP8ajodys
   salxtU3IBWeP5PAN94d/by4Ce3wvccFI+g75u22hxguquIyw6wLp3RxtK
   w==;
X-CSE-ConnectionGUID: 8e0W9w5uSXOxl55Y6T15JQ==
X-CSE-MsgGUID: dQ9on6I2T0a91nqfQ0iZ7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21253952"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="21253952"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 21:35:46 -0700
X-CSE-ConnectionGUID: BKVfxM99RQSZVtmS6Yowog==
X-CSE-MsgGUID: dIJEq91QTYmkeQJeV6VVBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32516608"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 21:35:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 21:35:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 21:35:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 21:35:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 21:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbQEmkLr5lXXb3WVPh+QzC2clZ+yMESyRqcyIklt4+7mUGH+MGXB51WMjUOSwcxCo+xP9ukl8i1eQiq7DOPz7nyTe+NGOkXM9w5XTkL76+tSQuJti05C1WZLVgN1tt/3O1xuiQfFAA1EKceciM5bKZRYUu2Xl3rnu3EDrqi5ywRmVEeuPEHqSH9eNcE4D/oVNVEzXZpfldPSrKZzpOaRNzepdO7GmVRdJidK4zrQv2P0tWDXAnHEwZeb6EtyQ6gks75pon7BhLHI/YIBwJnAM7NawossbeSfp6mEofRRqHuwznFOI7Gq+LjN445bFPaz6u3G07PLhl6cKLOj6Ns97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy+LdVj2mPIvgBCWtMG2XwuX50IgtB98CLP9CboWVik=;
 b=dZaQl3mlegoXa0wyfSY6AO/TOI9S9NaaemiKwh/gc1ZStjVXM3Z9aTnAzfI6tmao2JPSMkYZPkncn53xa1ylUwy9Cj5grBWCgziMkyXC5bF0tKAXXgkUaIzqiSd8TQoSqeIpN8HoKj0M5Wxa12bcUlfCUTWO5/UyUL+/6SQWgMxswWyT5cLlui4zUquN7tIERZhErp4nYJ4RToYxyAnFs36NpCwGvWALscXOruaq/qWvOqbnKI3LIscmu9qeAE/qSGM5l/+XCRwsQ0UcBwVFSrxqhZ88LFZBfkZjF1Rjih/BkfcMtfIXf4UIsNBeiRLCru2li4/kc2gKIcLrOzpCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Mon, 6 May
 2024 04:35:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 04:35:42 +0000
Date: Sun, 5 May 2024 21:35:39 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/26] cxl/extent: Realize extent devices
Message-ID: <66385e1b63173_25842129417@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
 <20240404173241.00003a6f@Huawei.com>
 <6630641e5238e_e1f5829431@iweiny-mobl.notmuch>
 <663401ba2e237_1384629438@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <663401ba2e237_1384629438@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: c4199748-39a3-480a-f51c-08dc6d85fd0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VT8KlVhwtB5f7yGbI8FuntIWZhd3dKpE7GTsVULSgbMoLX1wToQk5qVpP8N4?=
 =?us-ascii?Q?EhHBzcOKwN7NSIpXvfqrpor6BerqfTrBdi58+M2pGmzqq1sSBM6eaxMQ7lsY?=
 =?us-ascii?Q?REoH2wcyljG5De4dr1OeZdPNzg2xPFfvhfmNThaqzx80bydex2uYDBZI5fvc?=
 =?us-ascii?Q?qhK0fqn8hfKFcM5S6/ta7w3116iORzfGYtkXRvzs0S2hDPEbWfjBYxideJPT?=
 =?us-ascii?Q?h8Lhvs08mjIHbqm772OfLgLdVfRPIP19wrfoM0dQmksY/Izvy58kx6iMe1rp?=
 =?us-ascii?Q?lBo84+i2+yaQoTYa068xzj6kvzBweLtRg5Inquec2x6FysE9qsSap0O1T1pv?=
 =?us-ascii?Q?nGzFoPhNtHnWvordvJF/R0+lL287MaEpEvKUxeqn9EWnvKG3Lm9B5GKBDaEb?=
 =?us-ascii?Q?hn6W1gI2M0Pb1OkKGKICJrnWGmQcTcYlJxtxlPUNdJ35J0Pa8f9hsJNTQIOS?=
 =?us-ascii?Q?JUKRA6g/j9yx2lE+Dwi6Wc+B4LCUn4CoOrPDyBKMonfmeGWBmI+6ashq2Z1d?=
 =?us-ascii?Q?O8HapBGNce2ntpYhj3uuyx6dBIM8h2fjsm2fLer3TYh0Jkd3LM3ZA4zJowuv?=
 =?us-ascii?Q?7y4ZS6qTbrVIKVAF19jLZ0vElICDYlSQQU43aFc/X5rQyfuNdLqNq2IpmdQd?=
 =?us-ascii?Q?qZgyNnFZd+xyXdS1m4T5JIp3YYLiv2uHH0wEZw6QenuY5yjNs6/zYZyULwf5?=
 =?us-ascii?Q?TBm5JuC77v0Y9JZdGkBJ+0LN4UDHizHTYq+Xu6Bxt2p+Abhs+rgrZgTgOpd2?=
 =?us-ascii?Q?KmkN603J7gBce05/xhZwFAWLcSddmDfadGmc1Ms4qCsUJWHd3WEEQY+ulNbF?=
 =?us-ascii?Q?GvqNZFq7uNVLkBNANb8QfwMEPshxdGjUGroBgO8SyY385usXqB3Gcw0VsJvX?=
 =?us-ascii?Q?TxuzVuw8tYBwWPhy+39d6b0n5montmkKGxLcXe4zTHVQjIxqHaiesl6KmxFc?=
 =?us-ascii?Q?7wvA8q9yhttZAaB5oSYkSyWn86h7q5TzPDlLC5afGSGSjUp0Z8z6lGurtvDz?=
 =?us-ascii?Q?n4NsHoovdYazwRhfySOSYzzOSK8Ps5fDpjsu2VGwRgRogNJEM08+ofRyEe2a?=
 =?us-ascii?Q?IkYncCa0IB0H8/LmYbpb/Uu7M0IzdUUYS8Vv2GnLEPB26P8OXWBVGgNzSyWQ?=
 =?us-ascii?Q?vsyrG8Bt6sQt5IOIPe9C5nqOFcJylajXSmcIzptcc6jY18ZUjsMox8HHZklL?=
 =?us-ascii?Q?YuHe09pHDoGXSp5gp+LlCTmjcVSY1bgkAzNEDbHRYNRcuUv2crYG0raMZiTA?=
 =?us-ascii?Q?KbcFjAxBNu6UlXplt9cyU5e3uh+FOPRyIwlNuFXPvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nG9qRyJaou7ar+qXHNLyuX9trYCc8USk3lcV6WvFF8/Q3QInNvJa6t/1QgA8?=
 =?us-ascii?Q?5skLiEFM0XSMmF5QmQ0h+Bs+h4FxtDKMbyQwf+SlT3zcUtVJhiBOXRjgaddB?=
 =?us-ascii?Q?12DvvQWZpgGDKLUVdNhKcp6qlV0Q1HlmllQvQn+7NksnlGASDIUfU759rMDp?=
 =?us-ascii?Q?fToS3aHxMbFbNqd1EE0ZB50OZjWsAIAJqS4NQJFXn0pNN/0ca9pIfmojmvhF?=
 =?us-ascii?Q?haCjcWhoPFsqQvr0HI/K11WUfgIem2u5WXEx5pEvvAe7KQKLKmWxn+NWHk6l?=
 =?us-ascii?Q?zt4IXNqNaLnOPsqyPlxv4+1QET5Zegmf1ETlI+x9C/D3g9WxrrIj2zSwY3R6?=
 =?us-ascii?Q?zl5BFIYpEmw4nVeJot4JcG79c1tIzmXF71EykNgyI6np4vJLxqBGX4xLeVtB?=
 =?us-ascii?Q?Jxyoo1+w5kz51aAnv6E7E2MJRyOoApREu3utafhDlYbQfatVMiu8kgnDCEo+?=
 =?us-ascii?Q?tp8oor3zy1D9GTij1x+VXnbaDARH37MF92ufHUJSA3/4dlHpuTlFQSHgWTUy?=
 =?us-ascii?Q?sTDsYn6fhJlQmGzmeU0BzI/lV8wF+GUb/wnA/NWk6uzH5RV6F3D6lTUrPOEI?=
 =?us-ascii?Q?8RTxVKfA9Bo+3XEawQsXeP4KVKgUbpNOJPMHBfEw1b9YVQKux5FHA1IGznCz?=
 =?us-ascii?Q?t/CT5bYNY+Ukj2u8Q2NRDh1WCQ8DOvxMp70fDFHxSxkPJ/7ibrWdsBSYO1S0?=
 =?us-ascii?Q?oNtkDiBcyjaySutFJnGiDbm8GhO5hjqLZ1/jL/4FBKFmhnoPJb/sHHnY+Pxe?=
 =?us-ascii?Q?KPnzzO3y3J1j5elUAG2/imS8ziLPf99vgFdtvPQ8azCSbgip7ccMwURs38AL?=
 =?us-ascii?Q?3pGWszrHXyW2Ihn/FUSG3T3kX8NV+tA3eM6g+2Unra2UU79VoB6Hzc51myXE?=
 =?us-ascii?Q?oAATd9b+5Mep9DAVKp7oR5FY18N32jYvWi09V4tCGN1zoBFwmGBx1laIL6xu?=
 =?us-ascii?Q?8e4Wrtv26GqAkcF7dGOQPhd7SYyM04pCYICEDYPgTHojdj4r/UmzZ1ExOwJx?=
 =?us-ascii?Q?g0rUAoRckKguyenjyYl9jMyfw5zxYSo6MFMp2CE8fSecPubLRHTANfegcA0B?=
 =?us-ascii?Q?zxxQk1EliN1DnWGVLRFjiMS4Zpei6z/HnFwi+qn2z3mpUHM/VMSuKVxDM3xV?=
 =?us-ascii?Q?o1yW+TGURoP/sbaxrR7z6J1paUBN5FhvRDwokbahesb92yQd44HSMP3ocTfo?=
 =?us-ascii?Q?S9EuDO4o+JYrAHQ8F0qLju/nEIpms5uU0b4Vfdf2mvd/goAYCANbdMaThji+?=
 =?us-ascii?Q?cxPW2fcW0iZw0AGc7X8TpI/ppTIz1mcoQZqSiWE+y3yTdyoL8Vbt/a3Gk+/f?=
 =?us-ascii?Q?u9KL93topSyKRN9dYvkBaN2vCdGjZMRrL5wQ8phAbMidpmtmwv7lgvIa4vLi?=
 =?us-ascii?Q?xqXgNIucvHBmuxFLuMdYQRdruKtKyCGeaA/Mfp7ZJ6TbCWsWpll+TUd+XnXf?=
 =?us-ascii?Q?9rPRISQJj2iTIskZps55x8j1PDh8juZlOEHv9Vr9G/5zJWz7SCMuRGMD1H8A?=
 =?us-ascii?Q?2qVs5GH7tDjjzxH6Wx/KNuMAIa1RFHTC+ASR3rXVTXzQvUPu6ffSVrzIfjED?=
 =?us-ascii?Q?zfrPpcTIeJzhagAe8DG+uw1L7JOLtUvG4ZWQEXfo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4199748-39a3-480a-f51c-08dc6d85fd0d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 04:35:42.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qG0/TxZ+LKoCyXgtDIPx75xFiFle49ngt+zKgbIXy/uXJ9TrJEzP8Ms1yNez1xjPV9lmVO9bHLqdN9mrVQXPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Jonathan Cameron wrote:
> > > On Sun, 24 Mar 2024 16:18:19 -0700
> > > ira.weiny@intel.com wrote:
> > > 
> > > > From: Navneet Singh <navneet.singh@intel.com>
> > > > 
> > > > Once all extents of an interleave set are present a region must
> > > > surface an extent to the region.
> > > > 
> > > > Without interleaving; endpoint decoder and region extents have a 1:1
> > > > relationship.  Future support for IW > 1 will maintain a N:1
> > > > relationship between the device extents and region extents.
> > > > 
> > > > Create a region extent device for every device extent found.  Release of
> > > > the extent device triggers a response to the underlying hardware extent.
> > > > 
> > > > There is no strong use case to support the addition of extents which
> > > > overlap previously accepted extent ranges.  Reject such new extents
> > > > until such time as a good use case emerges.
> > > > 
> > > > Expose the necessary details of region extents by creating the following
> > > > sysfs entries.
> > > > 
> > > > 	/sys/bus/cxl/devices/dax_regionX/extentY
> > > > 	/sys/bus/cxl/devices/dax_regionX/extentY/offset
> > > > 	/sys/bus/cxl/devices/dax_regionX/extentY/length
> > > > 	/sys/bus/cxl/devices/dax_regionX/extentY/label
> > > 
> > > Docs?
> > 
> > That is a good idea.
> > 
> > > The label in particular worries me a little as I'm not sure what
> > > is in it.
> > 
> > I envisioned a pass through of the tag.
> > 
> > >
> > > If it's the tag one possible format is a uuid (not a coincidence
> > > that it is the same length) and interpreting that as characters isn't
> > > going to get us far.  I wonder if we have to treat it as a binary attr
> > > given we have no idea what it is.
> > 
> > In thinking about this more (and running some experiments): none of these are
> > strictly necessary in this initial implementation.  No code currently uses
> > them directly.
> > 
> > I questioned these in the past and I've done so again over the weekend.
> > 
> > I was about to rip them out entirely when I remembered Gregory Price's
> > comments on Discord.  There he indicating a desire to very carefully place
> > dax devices.  Without at least the offset and length above (and to a
> > lesser extent the label) this can't be done.
> 
> Careful placement of dax-devices physically requires an entirely new
> allocation ABI. There is the mapping_store() interface that was added
> for a specific kexec / VMM fast restore use case, but that never
> envisioned the sparse region case. So I do think it is worthwhile to
> punt on that question to a later add-on feature.

Agreed.

>  
> [..]
> > I don't think this is exactly what the user is going to expect.  This can
> > be resolved by by looking at the dax device mappings though.[0]  So I'm going
> > to leave this for now.  But I expect some additional porcelain is going to
> > be required to fully meet Gregory's requirements.
> 
> Not sure what the exact requirement is, but if it's the typical, "I want
> to allocate by tag",

I'm extrapolating that it will be.  I want to allocate on the first extent.
Tags were removed from the series a while ago.

> then I think there is another potential coarse
> grained solution that probably covers most cases. Allow multiple
> dax_regions per cxl_dcd_regions, where each dax_region manages an
> exclusive set of tags.

I'll have to think on that because don't dax regions map to specific dpas on
creation?

> 
> The host negotiates a dax_region tag layout with the orchestrator and
> can then trust that all of the extents that show up in a given dax_region
> belong to a given tag or set of tags.
> 
> This is not something that needs to be considered in the initial
> enabling, but is potentially a way to avoid bolting-on a new fine grained
> allocation api after the fact.
> 

The point is I'm not trying to bolt anything on.  Just trying to explain what
can and can't be done.   The purpose of these entries was to give the user the
ability to see what extents existed and by correlating the dax mappings could
see where their dax mappings landed.  Careful allocation of dax devices could
result in the use of some extents and not others.  But this was __not__ at all
intended to be done initially.  Just use the space as it come available without
any tag use at all.

> 
> > [0]
> > 	/sys/bus/dax/devices/daxX.Y/mapping[0..N]/start
> > 	/sys/bus/dax/devices/daxX.Y/mapping[0..N]/end
> > 
> > Back to the label field:  It is currently just the 'tag' of the individual
> > extent (because no interleaving).  My vision for the interleave case would
> > be for the kernel to assemble device extents into a region extent only if
> > the tags match and export that.
> > 
> > Thinking on it more though we should leave label out for now.  This is the
> > second time it has been questioned.
> 
> I don't understand the issue. That is a critical piece of information
> and it is at the cxl device level
> 
> /sys/bus/cxl/devices/dax_regionX/extentY/label
> 
> ...now I would just call that "tag" and UUID format it (to Jonathan's
> point), but I see no rationale to hide what is most likely the most
> useful information about an extent.

The rationale is that the user was not going to use it.  So no use case == no
reason to have it...  yet.  I had code a while back to allocate dax devices on
specific tags.  But that was deemed to different from the current dax
allocation mechanism so it was scrapped...  for now.

I can add it back...  But I'm just getting a bit testy about who wants what and
how this is all going to get used.

Ira

