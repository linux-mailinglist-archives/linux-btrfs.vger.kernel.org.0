Return-Path: <linux-btrfs+bounces-7411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8AE95BDC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 19:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703251C21ED7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F41CE718;
	Thu, 22 Aug 2024 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnGNyDAT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6C1CF283;
	Thu, 22 Aug 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349226; cv=fail; b=ghKw0elJRXi2IIPyCTqV5zJFnkD110dO6qX58vDMZTobaSOGqpSbRDxBnJsd3J43IwTqvxu7THPWANmTixeFy8GK0rzXWaV5Tts8s7KE7oMH1cy6bg1a5IbReSVH+xRctFt6cv4B1Kv1r61yZ+GRUcmv7vjpF7JIjA0RCi5/zSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349226; c=relaxed/simple;
	bh=jglLrmzjP+qwksAOOrxSnUzj5G6e8ZSj6F+hp797yV8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f2IN5D5xk1kLYYEjd1YXaIzB9JrB/WI9zyGM19LaFAz4N+XGH1be0y06apgGl9NZ8K5ntTkCkhHi4xpLqtEIdZHOtRLr4CJ9J0QmNu6TXnwYjSi0qy7s0RuXow8JBMRM/zFQGv6IuQCkzaSYzD/BXSO3JBgwGN3eahGYpaOTLBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnGNyDAT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724349225; x=1755885225;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jglLrmzjP+qwksAOOrxSnUzj5G6e8ZSj6F+hp797yV8=;
  b=bnGNyDAThCgmq8lkqSslOfalCzkS19rleUGAo8ndThaOUHeejYp5bIfY
   pC+3E1tj2booYMpGiZ+gCnrD9xj6SXicrrNZnnVKONjfP2W3fBIwRsLYt
   2E/xRrcHJwMUjApC+g5fVF6gitVcrbylUCwD+LIjx8mo/1TYxWzSxjzpK
   1bX6Yl8xVEOXZRPNgq1FVW+QF2mDmLgbDseFeEjBhJjmQ+JCECNMGd+XL
   ceDCVXewGkT5EIpgs37ty93zXnnn3Ff5Qq2Jj6cnaiR0c1hyU7WH9Tvc6
   evUgn/ajzafCudmg3phSPwNuwk7nvb1g00ZFjF5C1m49lyr2LgvXtjb9v
   g==;
X-CSE-ConnectionGUID: WostxNnoTl64e4s1mN+wyg==
X-CSE-MsgGUID: 0mEiOGX0R1eLKxNUzqMNeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26538861"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="26538861"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 10:53:44 -0700
X-CSE-ConnectionGUID: 2ulwNFZZSIK946rH5KRLeQ==
X-CSE-MsgGUID: +8FZhZIpQvG0IGcxDDRrog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61240244"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 10:53:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 10:53:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 10:53:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 10:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkX4LCgeQ4os5PDyvGNpGaXIv8/gtrLwTA7bMU0xcWh+iAb48R2rs9eOmXuE5qo+fRuhhYyFBSLz0+SuF9pQfRNuvpobiEqijiQSR15pweL43nRwoKwfyP7AzcXebwehdSf8LXlmFX0alM4wLoG6YD1uV50p/RzePUB+EIwoB9dt6BLxnFrAmbkBgfU8TyQW9T8ivotkMr+FSI4jyKoAMB3ynSel9/fi644K76NDUobw7RNUhKPb12cVESLHZro7hGkIlW1xTWVxfRF0QT4vg9EMmJhCz+YfWn66ymjPbmLMY5e6XigmkCtKN+7GpDI9jHVAZF90cFHR3CQsWSdgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxT62GXyKXO3UF8QoxJMLavN0gHqBUbO8rojBCbaSHQ=;
 b=RmiOACeIHPy8SnSMGltdljMTUyyI5E3+5Uzyfhq3bMhc3Ad/ZZIoDRPeqhOz+83TEeEHx0PmtmYSWM1U5cZ8JSZ2S7p1Ba4IHgOaooOml/YDvBKUwSENSizD1RHc9/Qk/VN5FUihIr2QMYK2r44xuxvPDy2GBCBfXcfeEXKRKieeUsNObkw66F//rHbS0BdfhjoGjIlnv1lwm9HmipcY0dYKlz7SpYf5cdUF5K6+lJwZM6v9UT1kURotl+T6ffRZA+sJ4rCVyah03+rL3MhCmqI8DpvEEWl1W7ChJckHzKe/uLXc978nVKA3aPKv4nNh1RdMhzGNSJcR+rZSAMn2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 17:53:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 17:53:39 +0000
Date: Thu, 22 Aug 2024 12:53:32 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Petr Mladek <pmladek@suse.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsSjdjzRSG87alk5@pathway.suse.cz>
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 166a6925-e840-4760-0795-08dcc2d35a69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tq4aNYU6AwbJ7rJxkGKWkJ9Yn+q4nfnvMW0A+ULlFkAYA9Ps/LgPHJRohgIZ?=
 =?us-ascii?Q?P4+7MXwpRqjsPBCVeM0LpG3VDRc6DJf3RQCtkEj6YUEq34Gf5IICLuqUExfN?=
 =?us-ascii?Q?d/C+IIV0JBGT44NJrHm83TWAwz5/hIT6hZbqmVhZTYCCD9ya3o5PgfCzyQPi?=
 =?us-ascii?Q?vcDouXShKct8VQbzwY246SY4LDI/3V1VxRZ/AxJzCK5pFiAY1pBcOpX3A3w2?=
 =?us-ascii?Q?wI9Fkri2vsqBV/tqeTo9a2FAFIBvglhK28ZKUuPc4cqLjUJ/i0Rro6IkEH9p?=
 =?us-ascii?Q?1HSVcwojK6H/zas/d1X/zlF9uu1mQrDFDVPD6o9xYZy0HZOTqz04lOKI1+AC?=
 =?us-ascii?Q?tENVeJGx4qSPvbvwMf14TOA5T0aXEhfjUQZuvU/ayU5nOQk0uev7Tf2Z87dl?=
 =?us-ascii?Q?PNL+676URdLDYI3B3QO2KfnftxdaQ76QOK5CGt3k7NWlW/S0FKqz95fLHanb?=
 =?us-ascii?Q?ICk4PwUWnerAorGDLXRomYCm0k1h/ggDA99U5rcnBvMUzY04Ihs6pktoCwPT?=
 =?us-ascii?Q?MRP/sr42Z6qSmZZhUOv/CJvq7RnU8TI5/ol9C2cVksy4YtbUd/TKtE4N/4iJ?=
 =?us-ascii?Q?cQEnW0CdZvWAQqnsa/o/WPh0Eu/eyOT6CqRHvBmY8k3RphxNQlL7z8d6WzjJ?=
 =?us-ascii?Q?3F15tUqTl6OMjt7QvdfZa2RVo3L4xP4BZLj/G1qcsuL7voGQpBJ0PMWgaSox?=
 =?us-ascii?Q?ssn3hz9muUVuIpXjSpSp54bskfkel9rwJHXJNm2hJoW++tZRNBH6pMMqQL6v?=
 =?us-ascii?Q?8wgYD4d/j6xLTp97SvC/TFr0cnr5tGDq3wRJKmnj/7I/EcsAqVMGt2g3zdXz?=
 =?us-ascii?Q?nPal5fC4DoZAyRh76Bq8c+zJN6i2WTU2V6Viqb5tl36cxTfSrQNm/L6Y+oi5?=
 =?us-ascii?Q?OV1I7eUcGA7MOTu3ke2ZZo3tPVR2kEvDFP6RUkONRCugVSkVYyhzD+87cB4W?=
 =?us-ascii?Q?TKdGRUt72nQq0oZdz77Tt3zGFJYPgP1C9ldUnvwuK5wTVtRuHlkDsAkksMUe?=
 =?us-ascii?Q?01GUW2oaFAAK2BIhE0M56Ao/VGlnM55sgOBdu7HvSjqU0W/3OAImdFhbx+Tk?=
 =?us-ascii?Q?PsjpZYK88NLEUHJ8mlWaTkGUnELPCC6okihS0zSNvtt63gPw8yr0IQga4r3a?=
 =?us-ascii?Q?5AokaYh2PoWfw0jD5hILhPu4RR3jdl8VsH+Uw/5BSxdW9rqCyCfDQxRKU1aX?=
 =?us-ascii?Q?i1r+CaBFohvzGWBlyLj7OqrU0gzYG21oVzQBEDQlaNK0NXGrIWLhtCnHH8zf?=
 =?us-ascii?Q?7gMltkHJ9QE/Hm89ija7Dd2NXTuoTIm1eO0pEcmBjDLwHM2Ovc/G9myfvl5d?=
 =?us-ascii?Q?UEn3ef/QJZ6ssXpQiKBcT6LIQDO90Dwp1+rDpZP/KSZeHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zi9HAm4GI6guYvUfoW8magcY6zHKWauI+a/pZHnIzxk6jCearioiTPSvqoxt?=
 =?us-ascii?Q?BCouZ/iRNOuvGAwz/Zrr/MujBJaJh2pNRFtoVX1f3YNxh5dFWDvW4QcB6r8b?=
 =?us-ascii?Q?d38S24ophGjN+meWAvMnvvuli7hxctR49z29TkSYL3/Qj954MZoaSwJF+Yjg?=
 =?us-ascii?Q?TGxQj1XK5GaYwaKsjSY17YQCza7nEvYZDsreQxwr+OCdxp6W/ys+ODD9aVJ7?=
 =?us-ascii?Q?PilTiPG/G6hP6DdGk41dCfxzpsdH7fIdjUBv2q7vV1F6N4hj06to7wsox8iK?=
 =?us-ascii?Q?Tcu9G/6nuXfjFvZDXH+ga06BXBlIYt4Ary4Nr2sxoAfzp1/A+FgaRl6hncPm?=
 =?us-ascii?Q?pSzXY9mXGvSYsRqCOsDKKllwe+GQdXqJyMF0xksZ6S1NhqDIUOi7sVl3+zHF?=
 =?us-ascii?Q?XrdzVOYGfrUeZf3BppsPg0c1Vnz8uyRaMWDdI7LHNsyPwTOD/V6QAp3pHUsH?=
 =?us-ascii?Q?uTwQ8QhTlP2fNfmUDC4gcDRBprIAlXaiC3RWUefC+mNk9Zjiieq2vvUMHbmF?=
 =?us-ascii?Q?tEA7zKNqMViXiCseMYtsDJxXrbZDTu+m96cPJAHIa/SqkXpoPNnBQ8RBOLO+?=
 =?us-ascii?Q?XunNXBnx5tJMOMm2ysOgWY0RI+u6NS5ZSYsrilSlZGTRxBJhI1IVmhSFDWze?=
 =?us-ascii?Q?WGUv7vYwWsaIiaw1K1UCXMxIOqUqvjFiyA09SJqeZD1oI/h3eFBQJiq9vdtm?=
 =?us-ascii?Q?2kwsTDWbowM/S2a16CiHHv8ThP6gJvEea9Vzc+ZtINwHXskkjfMKMRuOCeD1?=
 =?us-ascii?Q?kUNcldVf1NiurTWB2lnDiaKkhU+8SpmrkMNeyg7iDJfZgLDunCM90iW/gOHW?=
 =?us-ascii?Q?UHua3TBvG02yoGqGTq6XWVBrtbI3zS85ohl7nK/YECKW4/gVBOtEK25+c2TX?=
 =?us-ascii?Q?DO6qrNTuEPKF2HsJMlSIYXAuLBCSpdb7ptquhbLvCTYQIoAiZGHbbXb7iTqR?=
 =?us-ascii?Q?XOB3xMU6pes4W+I6Q6Iy1y8qNlsF1towmEIUsGA1o9pL3J9ya2rF6X/KlAtq?=
 =?us-ascii?Q?GopQel0w9q+G6cwRfixeof62mC2E+BNs6BlESKwWzZqiEc5UdZZv8+SnfqtE?=
 =?us-ascii?Q?7JGgKMk2yNlHxLq5hQD5TmSD6uh3t6oIirRmKtawcVLseqALu8XWEetYB6/k?=
 =?us-ascii?Q?8v9eUFRF4QVb1ivOjNE5cViUeuOa47Qvd8bSR1+w127mw2nXHU2UCRtalAlK?=
 =?us-ascii?Q?Imt/9/nOvqI5VLIUatB9iNI8MOZScCP/RZ4Qgk2qw0oODdAQ8tsGjrRxU6pV?=
 =?us-ascii?Q?ZmO2z/0XECmgxuqexXTb5o7jg+JJg4qY4Cw5R+3XLgqoJjgQef98Qrc7j07i?=
 =?us-ascii?Q?/c9w2WySneDsfcWe7/UrC9/UTOwSqLCwx/pkYMmVD/cadE8+veJZ/rljGbTw?=
 =?us-ascii?Q?bxPF4En03bVJGwpAe1oKL47/+57nGp3RqNJPhaXSdJVfcVIZCdH3qJ0T+xkS?=
 =?us-ascii?Q?m+ywIRvCHBO5LehBn0h26kv/mSsQdZpyudhec4BRc76CaIfJdN61RCaA518d?=
 =?us-ascii?Q?yYVv4vH4veM189+Fl1/SZ/JLX5EMd+LET8+Yx31ZKMkR/OiPx4w49vC69Ajn?=
 =?us-ascii?Q?wnVwEEqAwoFIbkmUzb6dSxd948svWJBGn/eHMABF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 166a6925-e840-4760-0795-08dcc2d35a69
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:53:39.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmroZx04pGhoEt5nn0TNwnTVjwfWfJvRWPyTkvJBfnm+dylOWfRNMVLTj/nM5uxXBY6xk9ll82U5+aZD2mfOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7643
X-OriginatorOrg: intel.com

Petr Mladek wrote:
> On Fri 2024-08-16 09:44:10, Ira Weiny wrote:
> > The use of struct range in the CXL subsystem is growing.  In particular,
> > the addition of Dynamic Capacity devices uses struct range in a number
> > of places which are reported in debug and error messages.
> > 
> > To wit requiring the printing of the start/end fields in each print
> > became cumbersome.  Dan Williams mentions in [1] that it might be time
> > to have a print specifier for struct range similar to struct resource
> > 
> > A few alternatives were considered including '%pn' for 'print raNge' but
> > %par follows that struct range is most often used to store a range of
> > physical addresses.  So use '%par' for 'print address range'.
> > 
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -231,6 +231,20 @@ width of the CPU data path.
> >  
> >  Passed by reference.
> >  
> > +Struct Range
> > +------------
> > +
> > +::
> > +
> > +	%par	[range 0x60000000-0x6fffffff] or
> 
> It seems that it is always 64-bit. It prints:
> 
> struct range {
> 	u64   start;
> 	u64   end;
> };

Indeed.  Thanks I should not have just copied/pasted.

> 
> > +		[range 0x0000000060000000-0x000000006fffffff]
> > +
> > +For printing struct range.  A variation of printing a physical address is to
> > +print the value of struct range which are often used to hold a physical address
> > +range.
> > +
> > +Passed by reference.
> > +
> >  DMA address types dma_addr_t
> >  ----------------------------
> >  
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 2d71b1115916..c132178fac07 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1140,6 +1140,39 @@ char *resource_string(char *buf, char *end, struct resource *res,
> >  	return string_nocheck(buf, end, sym, spec);
> >  }
> >  
> > +static noinline_for_stack
> > +char *range_string(char *buf, char *end, const struct range *range,
> > +		      struct printf_spec spec, const char *fmt)
> > +{
> > +#define RANGE_PRINTK_SIZE		16
> > +#define RANGE_DECODED_BUF_SIZE		((2 * sizeof(struct range)) + 4)
> > +#define RANGE_PRINT_BUF_SIZE		sizeof("[range - ]")
> 
> I think that it should be "[range -]"

Sounds good.

> 
> > +	char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
> > +	char *p = sym, *pend = sym + sizeof(sym);
> > +
> > +	static const struct printf_spec str_spec = {
> > +		.field_width = -1,
> > +		.precision = 10,
> > +		.flags = LEFT,
> > +	};
> 
> Is this really needed? What about using "default_str_spec" instead?

Because I got confused and was coping from resource_string().

Deleted now...

> 
> > +	static const struct printf_spec range_spec = {
> > +		.base = 16,
> > +		.field_width = RANGE_PRINTK_SIZE,

However, my testing indicates this needs to be.

                .field_width = 18, /* 2 (0x) + 2 * 8 (bytes) */

... to properly zero pad the value.  Does that make sense?

> > +		.precision = -1,
> > +		.flags = SPECIAL | SMALL | ZEROPAD,
> > +	};
> > +
> > +	*p++ = '[';
> > +	p = string_nocheck(p, pend, "range ", str_spec);
> > +	p = number(p, pend, range->start, range_spec);
> > +	*p++ = '-';
> > +	p = number(p, pend, range->end, range_spec);
> > +	*p++ = ']';
> > +	*p = '\0';
> > +
> > +	return string_nocheck(buf, end, sym, spec);
> > +}
> > +
> >  static noinline_for_stack
> >  char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
> >  		 const char *fmt)
> 
> Also add a selftest into lib/test_printf.c, please.

Yes of course...  Makes testing easier too.

Thanks,
Ira

> 
> Best Regards,
> Petr

