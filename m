Return-Path: <linux-btrfs+bounces-8860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28AC99A935
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2CE1F21C9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53E19F411;
	Fri, 11 Oct 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0WkMtkL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAF19E980;
	Fri, 11 Oct 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665707; cv=fail; b=tSX8tzAzRqtpm58ZeE767IbZldiwys2dGNdcKTCJ4i+Q0O058AabPD0HwIcbAEO6QkEiOplWx3cVlkTdPDuE8rIrvbSRHTzbPHf1KqB3D+kKp7s1uXFRJN/iOF2FXWatnBbVvGeLAYVmhJxUTFyBUxT5UfCA3Pgcrrvz3l3SaP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665707; c=relaxed/simple;
	bh=bCV10SJEPWlmfU+AFR+v5vZIkB5mH88cxFIO+uRj1hs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tOsLxYvoCvUee7pISKUOqUApzuZ9O9GB0O3J+xI2KYyIluHgec+TrbvNwf4LzgSTRQfi97Ns3qA460vZ3bI7oSV4ws5ZLxYlmgya/eJxK0GY11JnmlD5hpEMDYqayQRd3jiNoM8RwUvhGM5AlBOKylhf7GneCZhpocNhfZdSzZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0WkMtkL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728665705; x=1760201705;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bCV10SJEPWlmfU+AFR+v5vZIkB5mH88cxFIO+uRj1hs=;
  b=A0WkMtkLbVMEJxqAhDOGMym3h2QMmBd0h9P/3gEU5KQ7OmpvY0fqjN1T
   G7BzJiZTh4O5UlS1zoVgWH5W/bDjBGakNUTyzuCoo/j4omiX4mlEHmkgb
   CdLXYr4JD6Q/9rpAlMpxwZk2aZfkN/1wTqDzsgVknabEV7e1fAVvTmbrs
   7ETdBi5O7fWZEViZ/zRiV/aLEeQasqNuukJrMjLyUbWCUFMAIsycQB+WT
   HOD4U6TR7KrzrI+6QE8KaKBT5JzXQNkjTkXXigNhVAHNyWIt8za923UeM
   j18r5aaVCizTt5QkpV0kJkynRVYENttmMr1IGXDMmpas7FCnZQRnDmYCx
   g==;
X-CSE-ConnectionGUID: bT36HhqPRCyJYjH7KoyYHg==
X-CSE-MsgGUID: Pll6Z6i0R5SrTZy2GCAnFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28200833"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28200833"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 09:55:04 -0700
X-CSE-ConnectionGUID: TjVyBPytR++6bDuPOnc7sg==
X-CSE-MsgGUID: 54r3lsHuTCqjctd33egRmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81782702"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 09:55:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 09:55:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 09:55:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 09:55:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 09:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnlXuZDArh5Qdi9e6bb+IS7PcaiWTz1NyWtqXx4AUCW6BxdCQHmf3j6AikwMkwJmZyaTBcNLJOrXEmVZbksqv6yWAWQiNPc3jOKV4BfAKM+8xZyj4hOZ3BTe4QncMVGENCKKEAgsdiQPjwTfZu3Tn3avVdxUeqim/2JsIx4LySZswYZrYH53FkeIP/fJePXlUgn2GI+2yZ9/eZAnYvfFodIqdHeN9FGwLeK35xVHIQNxt2f0cglwGbumRj23wHmzXdeVUOTBfpbNrlo2A9jYc3hjP1ywjPNQ+2QSrSLgrrvp7B+TFqrpC9uvOuAtkd3uiiiQjvN5OsRjzM456KR5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fghwayEcyPEUg9otDeExe1rVWi8nlwGwNfDBp1WDxo=;
 b=NqZOtX0AFFjf05QHfgqcLJ+B0B38dSu4PA4LmpWodYWn6RTxXaWcbJr1QVGYhixpb6mIC69FBltNeEgC79Klh1azf52oBVExY47DwG/cOfwMqKTsgYJU9RvhNAdxLCRzhdiXBfzShduRg4NKIl72FUWmJ4vHxUVXnMlRRhzztcwQbXJpOMsjkuPTGICS6LERrV/eGRaHwzCJ936Ma3ZGBqnEXjgEAO9nSQ0BmwXTbm75FM6+yt8CopQNwZRImqkFeI+BAZbkbS33wlIDcOCz3yMW5CMw8hjr7oAcZepSn5Wl4drtTqDBgadv1XHrmDwjg++DjcAV86AHQwYtMWcsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 16:54:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 16:54:57 +0000
Date: Fri, 11 Oct 2024 11:54:50 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
Message-ID: <6709585a8b9e6_9710f294bc@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
 <871q0p5rq1.fsf@prevas.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871q0p5rq1.fsf@prevas.dk>
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5495b024-2d1b-46d9-5b00-08dcea156fed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6gILLQJ+O+vHgiwGNFakTteYN22mWV/qn0XF1AUXJAHghr9eeYfDIcpjr3s/?=
 =?us-ascii?Q?9jefIYMfDyw6JTPl4Uko2NL3iS0YmH23M4U5jQiNYTtSmOJMsxkDHMLAgZKA?=
 =?us-ascii?Q?bVb9D4CmdshWdsUCDRYMm8oZf6f6aBqK+pgAHNxEr45AmZnnVvoMzFw7FnQ2?=
 =?us-ascii?Q?OY7iHoSI5P9JC2RmmMhdsPraDAFw0mHrj+F0fuZ4VpjotQxpmw6Kt0cdvAus?=
 =?us-ascii?Q?C7Qe+XLfBnpihprYKr9uuW1HkE5IXIhhhzcDIAaSyi6u0orhhy/+4oCqp00G?=
 =?us-ascii?Q?Nzv7+HsKPrsPNzLe91ym7d5ZXhYeyhU/kjtYc2a3vib6bN/ptZxgfSKiwZvw?=
 =?us-ascii?Q?/vZkXdwzB2B7hcRl75+40MeIIBlu0pWWEZZhPqjjEhOvXRPVoWdF+wH0L62S?=
 =?us-ascii?Q?9AC10lWB7CVJzwMb579Vzgdbrh33At6PzCA6kxtyIoFGQyClx3Tv2Wvf1uyR?=
 =?us-ascii?Q?oqJ24M3OA7MTo7GEkS2oYSJ9oF/3eF536ii+nnzG6xUK8aFxKq0twmvwyYal?=
 =?us-ascii?Q?ISO3JfR5X2BSkObBWGTQlcSFAjwYDrZsI7VPakrMD5RregbrrZdPD3celdZj?=
 =?us-ascii?Q?r4Tmt8E8x0FvMqvBY7TZrwMTZW2sgWj5NNLYecCj6T2SfZitju1E7tMEa01c?=
 =?us-ascii?Q?y93JIiTul6ErXuBs/AHznWOpMQj/a1bui5kJd3x4gBJ3UV6N7ltJWpVszpoD?=
 =?us-ascii?Q?XpPNYLy+uPGY0wNkxLpCdQzanHHj9c5nqtfA+i2r+blEEZHfjRnlWBG3+JjZ?=
 =?us-ascii?Q?L+XhjrMl/J+GoceOEzhrfVp0id/ruyvymL79jr9jObfm3e5/t/KAWv5u29S6?=
 =?us-ascii?Q?bqrjXgLGVavMVNYuZG2ySVqEn6I/A6W8MB2gY3HkbMvJ9TSB0uxB/O2HzI7n?=
 =?us-ascii?Q?h+VMURk5gFkwUSvTfJ1I1hOqsTEe4imyfsF5abVi4Jm+tma/lj6EskSoQssx?=
 =?us-ascii?Q?nsT2J55oYE0yfubzEsRHh/GNX83rAjhRp+Q7/x4KGhV8lNM02z5netVRocwq?=
 =?us-ascii?Q?RiJyiNHbkoMFgrCRwboT7Xp7mpRsyNcekhVnvKE/K2GLf1DmQyc0uCo67X+6?=
 =?us-ascii?Q?0S+uVnO3gzkHJHT+cs4WxZGATtS6swA/gDtd2I3BI/guxu92GgbcfudLx+3j?=
 =?us-ascii?Q?BDwefRSoS3wHCSvN+bYwI0P8wbzk0AHzKxZGkNVF61DctukK/LpRDWI0PU7B?=
 =?us-ascii?Q?jhKu0dYhSTwlH6UbmbacD4abzvqfl7Yn+BUnnaERK6bOu+pq6XirZu3Buanp?=
 =?us-ascii?Q?LRGdK0dXrtAFj4WJqA5uKnK9bsp96z3kOEGIRlXsEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FSnd2YfASxR0hNp8hHTy0lFYzg36kTWe5XRh4mmuoKZ+bY4KGlKKYuHcQ44c?=
 =?us-ascii?Q?CDJM9uf1c1kNiTF2MtKnWq18lVAdOefpqfiQY25v8N6jJWtrThkr/f0TghrK?=
 =?us-ascii?Q?4up5HulCof445zlub6Hos62QkNal6gyBEO/mwkZq0bjKGMZG8CzjyhDleOJa?=
 =?us-ascii?Q?dxd1sYtx0TwhYIobID1alR9hoOcmWLXPQA60BwMFY08PM0YhLZjZmzDPj4f1?=
 =?us-ascii?Q?KPbAephFONpp4UW2s6MNsK0wAs2kzMwLKLA8+r7Es4iWNqrcN+LuHDgaGil6?=
 =?us-ascii?Q?kp/vULjm+H9F1O1fXgxJ1MUzzA1UrYwMlRD2z5V1/0iAqz2ETeqpCbmdI2qM?=
 =?us-ascii?Q?NolwxdW1ohp0bi4OEKlL8EKCkDyebdSWEn+5ykOWXa8EJYkNgtuENYjOXv3z?=
 =?us-ascii?Q?n56fACm/DJLv8m8k5BmmLGHQhTAW5Mh9qgmcsOy78uNMCBnhVBgRMjVK/7m9?=
 =?us-ascii?Q?fM98r+5ajO4Vfni2x7yW6YWeqTKNVqlleX3hDsumaBRf5mwK39lNjrr0Ypl2?=
 =?us-ascii?Q?gCwoHqKGRdePv57c2N19O6HgX7OoGRHHHqCmI87eSZsVavywrjR0xnQXXF03?=
 =?us-ascii?Q?YKfcxmS13UGR3mmlQ1ivCf6phXR+J4SaBFzGQgvZD8VHdE8rB/0W6si83RME?=
 =?us-ascii?Q?Az+6vs2/sLckV5t1okH7M3vdgHZXtOHmw0PnKLf+R6v25fdTx7zTSo8Ywkah?=
 =?us-ascii?Q?khBVOyhYaPAwXFJ2Cva1O4UJjpLcJyJ+Isn6wvsbh1gOL6GcrndhDQ1O6OHr?=
 =?us-ascii?Q?TRuJ6lj3hayHWjwARWL15K6EZLLSEPEbaKSpuU7ceFRYJumIZU/RosPD95k6?=
 =?us-ascii?Q?0yofyRTAzAvqLyuoHWJyS2JHunCgFFwSnPIJARr0Uq9fqqlTHi6IJfqfe1Mv?=
 =?us-ascii?Q?UZZGHjj3QfkgS9oApl/omF5l6Br+5M3D3VLv8CdWxwVuRRiBwSaRcvs58pv6?=
 =?us-ascii?Q?AIBuuU3b/32Mixozn30no+H0CMlw0wUPLiAYW8LGSwH7ecHnhrVc6RydlVxN?=
 =?us-ascii?Q?nFkGSU95uEiGyMwBCYC3FkbmGa7X5gopoVFLiiPg5tZ2FOWl0X2TOhWLqOAs?=
 =?us-ascii?Q?XTIef2lmtEHK/mWY63SjzFY16O0ecQ9HU1NDAJewpCKGi4qA1cZffny//mYa?=
 =?us-ascii?Q?w5N1DUWp14g2y3fUuncJm4bqmiVi/ggPWOiS6PlxSOmwb8kYqwxp55pgH9xa?=
 =?us-ascii?Q?M8URyrA2lkxI/cnk/d6mnX7bxwcyy3m2zgEGX10jFeiNcvkMSXK157Uz04Sg?=
 =?us-ascii?Q?RRfa0KH2aMFM8UnrP2CvZ7qjy6sQnGz4TkZ8HqHicWyX7bt3YknEQ59ANElL?=
 =?us-ascii?Q?/V7f0QoD0dQgrrt1e+W3c4zncawOQpM5/58MuHz6ejv0Wpw97KBeqFIyN1kX?=
 =?us-ascii?Q?d45zO03xIUttd7EaZjhbUM5iU1XI/gjCsFkBH2goi/xyhazBM79RyI6FC/2S?=
 =?us-ascii?Q?oPCQo0uw4gDbWSat2Eg/6CaK9/TTt6t2enK54T7pocspfQtMoDSsF4MjqxUx?=
 =?us-ascii?Q?T+w803bQe49UGYLOMVqZdUl/f0aSso47QxrFmQEgm0VfRbaLaaTr+kRUEKRN?=
 =?us-ascii?Q?hUUEuVpSsgZXohILaTpCBV4+xcM85+I99//h2pe4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5495b024-2d1b-46d9-5b00-08dcea156fed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 16:54:57.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We0kEMAF3sUcoqz2htWPWnYPDKDnErn2JC75Wm8a602EFApkbeVXZWOumRHkxzV8rPa6LntBZaVFub3/1hVZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
X-OriginatorOrg: intel.com

Rasmus Villemoes wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > ---
> >  Documentation/core-api/printk-formats.rst | 13 ++++++++
> >  lib/test_printf.c                         | 26 +++++++++++++++
> >  lib/vsprintf.c                            | 55 +++++++++++++++++++++++++++----
> >  3 files changed, 88 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> > index 14e093da3ccd..03b102fc60bb 100644
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -231,6 +231,19 @@ width of the CPU data path.
> >  
> >  Passed by reference.
> >  
> > +Struct Range
> > +------------
> 
> Probably neither of those words should be capitalized.

I was following the format of the header of struct resource

	Struct Resources
	----------------

I can change it but I was trying to be consistent here.

[snip]

> > +static void __init
> > +struct_range(void)
> > +{
> > +	struct range test_range = {
> > +		.start = 0xc0ffee00ba5eba11,
> > +		.end = 0xc0ffee00ba5eba11,
> > +	};
> > +
> > +	test("[range 0xc0ffee00ba5eba11]", "%pra", &test_range);
> > +
> > +	test_range = (struct range) {
> > +		.start = 0xc0ffee,
> > +		.end = 0xba5eba11,
> > +	};
> > +	test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
> > +	     "%pra", &test_range);
> > +
> > +	test_range = (struct range) {
> > +		.start = 0xba5eba11,
> > +		.end = 0xc0ffee,
> > +	};
> > +	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",
> > +	     "%pra", &test_range);
> > +}
> > +
> 
> Thanks for including tests!
> 
> Rather than the struct assignments, I think it's easier to read if you
> just do

I'm using Andy's suggestion of DEFINE_RANGE()

> 
>   struct range r;
> 
>   r.start = 0xc0ffee00ba5eba11;
>   r.end   = r.start;
>   ...
> 
>   r.start = 0xc0ffee;
>   r.end   = 0xba5eba11;
>   ...
> 
> which saves two lines per test and for the first one makes it more
> obvious that the start and end values are identical.
> 
> >  static void __init
> >  addr(void)
> >  {
> > @@ -807,6 +832,7 @@ test_pointer(void)
> >  	symbol_ptr();
> >  	kernel_ptr();
> >  	struct_resource();
> > +	struct_range();
> >  	addr();
> >  	escaped_str();
> >  	hex_string();
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 09f022ba1c05..f8f5ed8f4d39 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1039,6 +1039,19 @@ static const struct printf_spec default_dec04_spec = {
> >  	.flags = ZEROPAD,
> >  };
> >  
> > +static noinline_for_stack
> > +char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
> > +		struct printf_spec spec)
> > +{
> > +	buf = number(buf, end, start_val, spec);
> > +	if (start_val != end_val) {
> > +		if (buf < end)
> > +			*buf++ = '-';
> 
> No. Either all your callers pass a (probably stack-allocated) buffer
> which is guaranteed to be big enough, in which case you don't need the
> "if (buf < end)", or if some callers may "print" directly to the buffer
> passed to vsnprintf(), the buf++ must still be done unconditionally in
> order that vsnprintf(NULL, 0, ...) [used by fx kasprintf] can accurately
> determine how large the output string would be.
> 
> So, either
> 
>   *buf++ = '-'
> 
> or
> 
>   if (buf < end)
>     *buf = '-';
>   buf++;
> 
> Please don't mix the two. 

Ah ok yea fixed building on Andy's comment.

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a7b5e4618f6a..7aa47f7d9d5b 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1048,7 +1048,8 @@ char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
                return buf;

        if (buf < end)
-               *buf++ = '-';
+               *buf = '-';
+       ++buf;
        return number(buf, end, end_val, spec);
 }

> 
> 
> 
> > +		buf = number(buf, end, end_val, spec);
> > +	}
> > +	return buf;
> > +}
> > +
> >  static noinline_for_stack
> >  char *resource_string(char *buf, char *end, struct resource *res,
> >  		      struct printf_spec spec, const char *fmt)
> > @@ -1115,11 +1128,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
> >  		p = string_nocheck(p, pend, "size ", str_spec);
> >  		p = number(p, pend, resource_size(res), *specp);
> >  	} else {
> > -		p = number(p, pend, res->start, *specp);
> > -		if (res->start != res->end) {
> > -			*p++ = '-';
> > -			p = number(p, pend, res->end, *specp);
> > -		}
> > +		p = hex_range(p, pend, res->start, res->end, *specp);
> >  	}
> >  	if (decode) {
> >  		if (res->flags & IORESOURCE_MEM_64)
> > @@ -1140,6 +1149,34 @@ char *resource_string(char *buf, char *end, struct resource *res,
> >  	return string_nocheck(buf, end, sym, spec);
> >  }
> >  
> > +static noinline_for_stack
> > +char *range_string(char *buf, char *end, const struct range *range,
> > +		   struct printf_spec spec, const char *fmt)
> > +{
> > +#define RANGE_DECODED_BUF_SIZE		((2 * sizeof(struct range)) + 4)
> > +#define RANGE_PRINT_BUF_SIZE		sizeof("[range -]")
> > +	char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
> 
> I don't think these names or the split in two constants helps
> convincing that's the right amount. I have to think quite a bit to see
> that 2*sizeof is because struct range has two u64 and we're printing in
> hex so four-bits-per-char and probably the +4 are for two time "0x".

Yea.

> 
> Why not just size the buffer directly using an "example" string?
> 
>   char sym[sizeof("[range 0x0123456789abcdef-0x0123456789abcdef]")]

Ok that is simpler.

> 
> > +	char *p = sym, *pend = sym + sizeof(sym);
> > +
> > +	struct printf_spec range_spec = {
> > +		.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * 8 */
> > +		.flags = SPECIAL | SMALL | ZEROPAD,
> > +		.base = 16,
> > +		.precision = -1,
> > +	};
> > +
> > +	if (check_pointer(&buf, end, range, spec))
> > +		return buf;
> > +
> > +	*p++ = '[';
> > +	p = string_nocheck(p, pend, "range ", default_str_spec);
> 
> We really should have mempcpy or stpcpy. I don't see the point of using
> string_nocheck here, or not including the [ in the string copy (however
> it's done). But yeah, without stpcpy() that's a bit awkward. 

Added '[' to the string.  The prevalent use of string_nocheck() seems
reasonable to me but it is pretty heavyweight for this case.

Ira

