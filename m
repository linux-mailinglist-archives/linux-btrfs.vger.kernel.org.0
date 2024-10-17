Return-Path: <linux-btrfs+bounces-8991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33469A2F1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C1E1F23351
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A7822910D;
	Thu, 17 Oct 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFx/sK4T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC71DF26C;
	Thu, 17 Oct 2024 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198690; cv=fail; b=s9qPcEEDjL1hYrfWEcViqEUEqjzmvPgE9BpePi7mwx24WUMXnC0f7EJrIjAmBYIv1Y1VH7lK/osJbScUZEziKdJ4ydEwjK0PuJZRn8r5DQo13RvYXE/l65NdH1yO3Eax9zA0yoe15hNUDro2awJfU5ZQcp/vkzoGI5wiOTx2Q0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198690; c=relaxed/simple;
	bh=2UdQuPQh0VqIr/StTGq474Zuhaxme61GRDJk1A5rPAE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nJv404i/U88mwGw9x9AMIl8mYHRpHitjRY99uENGarJ4zEYE25zt0uQLrqSf49Es/M95R5dBffScAnjEM7LoyxKHCqGDnYcntNpsrxeU0Ky8ZKB5Mc17TA+u3/0NK+w9WfFsiVmeVrq1D4zvO4iC5/eQySho7Xh+uV4mebDv+2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFx/sK4T; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729198688; x=1760734688;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2UdQuPQh0VqIr/StTGq474Zuhaxme61GRDJk1A5rPAE=;
  b=XFx/sK4T42vsnfwwlGGMiJP0uszO5y2D1kWIrMpkNB25ddCpQV0xZJTP
   LCeg8eJysSF80Cq1N07eyHhQOBreKqz0mnQsT7u9eLwW0fgR6Lu2daXuz
   I6auIQiRB7TCl5NwfMM5fotkMig2L7eIgfK3Wzu4X79lYdt+niUg1Ek0j
   CKtgmMJV4DH6w8s1meimmHbvY+hvF6U1aW7PT2ziL82Jgdak9Vl7k0Ull
   wsraziYJU2paOATUk94kWDMihWLCbdNU6RKiaHIsiSIARmWTnWqRKGyBS
   qXkzEifNOvjkXRB6crJifOhigNG1AV/d/MrGqxYU1vX7Wnrrgeu8WLLQ3
   g==;
X-CSE-ConnectionGUID: AFjDOtdLREWEqpIHB0I3rA==
X-CSE-MsgGUID: 5R0QlsIJQeKD75GptYgx4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32639228"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32639228"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 13:58:07 -0700
X-CSE-ConnectionGUID: D5pADGvnT6a046rn4LGL5w==
X-CSE-MsgGUID: iW170gKVQdy66X36oHoULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83440174"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 13:58:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 13:57:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 13:57:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 13:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFsiq3sCUx3d4eDRQdNP/5Ac/8f4SQRVhbmhhqOtu13n+He94IcQ+kb50MI84gPXVwpM4002Z3dfp7ueD1G+gKu6MB5ITmUdBiqvBnSgTQuIU2wStUvs5bs0fcEl9JQ1viv/Jl1A7gN4vPE5/64KBfSaOdHiu8qY3u6Lhc9qPJbJBz7FOE7+Ks8bjTrNNLPpkCGxe1GFJ5By5gxsPHgoUxraJdDPHuEbpfAPycQG7IzQrObZW+r0S51398dC6EWPFqwTuqaf/bjawiem2UXyvAlih0UIONkP1gGUp0UsPOJVRVc0JLhxuXPEQW8HlT0WeqBBY3qhF6jaAarET1Sz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fih7C9NtAII2lQtnI/vV+ETfvUwLmBqN+IX+HvkSrlE=;
 b=GoVEgqLxK8wbwJotY04/W3Cd80EewT3m/braNu3zWBjf3rHQsn2IU3z8QxKuh6jQpRrDCG3WSF2NVyTuH3AR4a5Z7jFu0dAMia9aB9jzm0WpL3mvYufVq82nCRTgI2AuuZqk0MtKZUzkPhr9s9hq4h0uu46cuW7IAux5H2DvhOMU76yUAT/fHrTWHNXAYTxsXBRniw+o/gRgW8FQYo1T4YnDoWyU56lPmmeTNftrQmHyCyeamFMiRErXstLN0IwEoISwC8rg8s1V+Hdol5VArAo0kQ88ZCgGZicXQMfOGPHOmTFpGy32dz7ABySLxVv0HXW4D+Nsos3+ozt8FeKynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 20:57:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 20:57:55 +0000
Date: Thu, 17 Oct 2024 15:57:50 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
Message-ID: <67117a4de6083_37703294fb@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
 <ZwiIy-pIo_BPLtua@archie.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwiIy-pIo_BPLtua@archie.me>
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ead08b9-2c5d-45fa-3115-08dceeee5fb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MpbDFhwCr82576Bo42pC6Ot5MAAM9Bv5+jBFvozvA+LwGNq2uwLGuJZT7dLU?=
 =?us-ascii?Q?oayX/LknefXMPnqqimU/CKcpMo5vT05nM9Q5VlBy9TFNSkOSHJw0S5kUWsa0?=
 =?us-ascii?Q?1wkNTOncOhmKqY0nHK6JlHF6i8eJJfZr3XdfS7+4u4Tctf8OFEEbmbk5WwEp?=
 =?us-ascii?Q?nkxci6VzxvHCRZzjD8AUZPPtHwkBhmXUYHz83AeBX87BUReSp3KmnchOj+Ji?=
 =?us-ascii?Q?u2w6eJEo9mG3t80vjROG5ZTva2fZoeKjbbULds9APKpezcKxNwXGUu5g3Xai?=
 =?us-ascii?Q?Zgtg3YkHKAvfmW8gB/4U+xjk08s47KotGJQRKu4BEeGFaDKMN3dzBvW07PuE?=
 =?us-ascii?Q?9r4rAhMpqB5+LdfzWbIGIY4IqjQFYVryOXT0//GVk6tcjgGgKKjok7hxyoC9?=
 =?us-ascii?Q?fdFlY/jsqCcW1hUg+fBngoADNBJhGFDVbdCCAS/yXm/qwqHb0LfEcgMUi7R9?=
 =?us-ascii?Q?TzCtvkyXcJqKp3WnVgFmoMvpRiCBoH0U60dER7ha4SoxB3mIaQncMf1gNVus?=
 =?us-ascii?Q?pfwuf4BJ4DnPzNYmDpFs4Vhjr3tdnchXekfX7o56sJ/CSSr5yX2Mun4U2ufb?=
 =?us-ascii?Q?MbFxHpEyILnu4zhDv4R3FEZNkPZRWTj74VFoPcLaHOTm2Tbc4PtcQB0IeWg2?=
 =?us-ascii?Q?dmhkaZ/qPxqfCvfjqr4JjWPq/yyGNdRJ7566U6d4I0G0IaNcDUsvs5nGEKdZ?=
 =?us-ascii?Q?kAAftf/LrOxfAlOYXo9zPIQJLSvB6HvDFycy3uHxevEdY8LjHbL4za06KCgL?=
 =?us-ascii?Q?w7fUvV8N8Ou68vM3Cn+jg0Iu/U7RQZgFsHSQreRngoBqopKpgvdQDv8XcE3Y?=
 =?us-ascii?Q?vcxtRp5j3dfRHZZ5C1T082pXyWrIH76pJ7v48dr5lsUUE/IMk9RN99xKEaqZ?=
 =?us-ascii?Q?9ZuWjC03OfZofGb68J582HpIWwvVWsJnQhglz/Ty/s3871QgMriQqGvCyalt?=
 =?us-ascii?Q?5o+98UErI04uITAvXuf0DKU+JJV5XbRWVLXbJO63fVw9BogCDJEAsLdnq1q2?=
 =?us-ascii?Q?do+0A20M3DhmwsXtI0efUTZf6Z45XN+7YeqSkyv+3gHt3csVUFrQRCo76RT8?=
 =?us-ascii?Q?Mc9tyqq2kMXxhj+bcUfr6blcWBQFUKYbJKQnjrGgkEqv2FRRDxOooWlv9L+E?=
 =?us-ascii?Q?yxZ4UzhtEwdoTsehDXIcOhc3kCbu3AKsBL7ujSLSh+Spqt/ozuq5c98uxdvi?=
 =?us-ascii?Q?YctJX0EUzAMzTQDOaSbZEkHTjhL0oIDrB+JwDDMV8C70quLTr108ucQmA8Aq?=
 =?us-ascii?Q?lWnSuzfPNBIPPEEdSryyRtLMd1YzSDXVsXnU9pqj8Qz7LDCS0KHWP+moaKkB?=
 =?us-ascii?Q?D+IFMV9SneKEkZHVZU0J1FAo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fHruF6+UZ8fCzst6FhPB72rpOqL2jgwWBlW0ML0dwWc+77a/bCn1gnSWlft1?=
 =?us-ascii?Q?kGIpw1eXW07HEzB+yneIceragk8B2zf6L2EfVK6yonAJxHCns0iW9MKruugy?=
 =?us-ascii?Q?lTmFDghVEyUKdD8hl1b1Qlmg0xiAJNUUDdQXfI7xgXeWalKzclXOkiilFAfQ?=
 =?us-ascii?Q?3PD8RP4ma/2nN3n6/BBCkbDl+RdnAQGyVwHAp3bO9uCpFTCBoR4N9+W9VCuh?=
 =?us-ascii?Q?xdSkDqj2ZHIWNmWSl7ss7wIW+2opohiX60vTgQUYvNhAA8MmAX00HwcMtNV4?=
 =?us-ascii?Q?uyOzce4yf5OnwjDddDRHzry7kOgAdacA8YP2WwtsoDGQvB3fEY3xdMFGAl+y?=
 =?us-ascii?Q?Pt4XWyoeIEQ6VHtDejAVS8FTYp4/ov1VN0O9XEXT4Wg3H0h8gzBxyDqdIyT9?=
 =?us-ascii?Q?7laV76O4IBA+jswnA4iX6bl37RILaI7cOF0YiD+XyKK8FQZc1kM0r9Ynncto?=
 =?us-ascii?Q?RQ1T+v0Hm8sW7olGWsSgR5bieFiSciOGWB4sTy46OrXHPThPSnkQ0tYz41AY?=
 =?us-ascii?Q?6yMKxPaE8C1l5fEqD3p+c42ofW1w+4FVnzpeY3+43RnKEHfv/Vrsswzg1xef?=
 =?us-ascii?Q?o0EtoAp4ntW3QyIjp/tHjPyOYfJ+dHS95FYu9mkC0qgA51gK/RJuZhFdTzHA?=
 =?us-ascii?Q?uEEZ3CGx+j21V0GN9GAkav9//QTk/EiL6X9Vr0gwhs26qsJCDZcnIPh2wT0n?=
 =?us-ascii?Q?U+ee7IIT0qFiojCUVSky+UG+GG8oZ7WFbvpyPBfm8h5slFqDJisFg42Dscxl?=
 =?us-ascii?Q?RkLxxUrAX8Re6AeTPzs1YM4OSf3oBGQbr8q6xi1EHgrU/UQpDL4a8W+6qG+p?=
 =?us-ascii?Q?RgHZ3v4/1d4HVaDgdlludq0eEPML2TQTqhWMv+rr/mDLAhzffCmXGjcJc287?=
 =?us-ascii?Q?YXN78IMZy2tfZH5zRaVTDL+L18vU8PKJEPgnWoqGOAxUKlRA9OgqdjpINa8H?=
 =?us-ascii?Q?7jRnqJWN6VcwMEZS1eGTbhOnQLi6rgaAUmdv2/IFDPAPIt0C+VTHCzP8PwFD?=
 =?us-ascii?Q?YNtRl+ZDYzH21aG0hh4fLdrL1pETUZsVB9+SrFPCemeIUyhOWgaCUW/wjS6v?=
 =?us-ascii?Q?8wxbQTWIs0yPtbkBCHsml8KNF21L7Br/U6DZt5j+RBrNABcusgJ1vFeORVNP?=
 =?us-ascii?Q?+2eP7X6ze3k4pfdmZQsZghj5+KGaWO3awAj23a2btZ+3OQZVIwcG+Hw1b61F?=
 =?us-ascii?Q?L1QcvD6FRTOZYbFVYdgtj/C5a9oZ7EUN5RfelV2/QWUB0l3kjQ8vXAFEbo5t?=
 =?us-ascii?Q?+R/q9tFXy24scD4MTOSiQVHkX+xZ4IMIyUkZZd7A1L5Uy5KwxHwfazRZHmV7?=
 =?us-ascii?Q?JeZ7qA+/hxcA4BfVQkA3QuUvqQIaVBw+Q8rNrVeJ7eWHLAasNstNih0F2bkD?=
 =?us-ascii?Q?XzGG6U6xUXH08hSIjgPpYHZVF0Mg2KQyN6kUz6fKr77K6iLU+KwF/1m7Iy1k?=
 =?us-ascii?Q?fqn7alZ/EMpKh81BmFYdYp7y4SzEfy/GSArJZAW21hrZuMZWSnwxDvDIrSUl?=
 =?us-ascii?Q?vbC2ZISX+aFEOP7/JG5bpAf+XBWzPOSZPVD6rhu6iLJmnnyIq6yQPx/4oedM?=
 =?us-ascii?Q?JmKJnW/Q5B9RgWCPUBEClC48gHgWmcDn1f9R7Imi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ead08b9-2c5d-45fa-3115-08dceeee5fb1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:57:55.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02FHESz9U5OxO0026szpRuZjyGAh3bKGaTY1mQeIRGISnt2Drp6Nn2zcA3MYoese8d9SdAvb77v8Ph3CIb1ViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com

Bagas Sanjaya wrote:
> On Mon, Oct 07, 2024 at 06:16:08PM -0500, Ira Weiny wrote:
> > +Struct Range
> > +------------
> > +
> > +::
> > +
> > +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> > +	%pra    [range 0x0000000060000000]
> > +
> > +For printing struct range.  struct range holds an arbitrary range of u64
> > +values.  If start is equal to end only 1 value is printed.
> 
> Do you mean printing only start value in start=equal case?

Yes I'll change the verbiage.

Ira

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 03b102fc60bb..e1ebf0376154 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -240,7 +240,7 @@ Struct Range
        %pra    [range 0x0000000060000000]

 For printing struct range.  struct range holds an arbitrary range of u64
-values.  If start is equal to end only 1 value is printed.
+values.  If start is equal to end only print the start value.

 Passed by reference.

