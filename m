Return-Path: <linux-btrfs+bounces-9080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981169ABAED
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC46284991
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D087C2AD20;
	Wed, 23 Oct 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TODHtv2f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A112F34;
	Wed, 23 Oct 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646433; cv=fail; b=DZktMX7I7c0qGcR4FrH6S+nBZzdUVPIPjcxuLO3uCAmGE7/SziNS/9LVUo5NjwWc7l/LodrStS59i+ITmK1WW7StehKOPSYyK/yrPLayWhZZ/WT1TrEWJuLj3cdu6xWSnaQ4pEtN2jwBvU9YG5anJxVF8f9ttNe3cYedYjmgmAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646433; c=relaxed/simple;
	bh=2mwTI+Biijn06FS/HGc+1vaK8hKe7gyeX20034URdFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ixdRtmZHsmLoc8BAzXqIL0/oBXRh+/NyNQemnu+f/oLzZQzYuvfV8mp018hD2zMBbwyqeoE8JXU0K0N1+zBK0MKntyT/gRgIfVJNq6QA1QeJK13G0zX6tgbnMN+rgHvwGSOX/Mq7AkxhbiZXCECWmlSNRXJBtNIS5oSfqN5pVjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TODHtv2f; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729646431; x=1761182431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2mwTI+Biijn06FS/HGc+1vaK8hKe7gyeX20034URdFo=;
  b=TODHtv2fzdkclmbrTOb5wTx6W0xbwtOLHf9Zo/caxQ1AmHvVmlnCIbyd
   a5YFb6V38pv5jS+5r336i3VTACZ0NLFVwS4NWc3f088z+R5dihWeqVRlS
   V+01OUGH3FKEU90mC2oUSbtpLdlhj+/dvn/OQ0yl7OHwEZLk62Hn5amAy
   ulIPMf9Vv3WCdl8WSQlrd1MoTHw7UCIzDvlWv+U4FvuA4k9ROqL89Gby7
   gZlRu5DrrAKdA85HLbWgHMOHmxIEFak8IkObBhbzcI+Kkxa1P8MSl8TMh
   IgCebV9un1hDULLH0TSSUgH+ZoQGtX+Wfr5f6hEZIK5JwSvvRdW0kyb6a
   Q==;
X-CSE-ConnectionGUID: f0R4hl3nQji3R5U/iaxFhA==
X-CSE-MsgGUID: FhRALd3LQUWGq2/ZubfK2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="16837132"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="16837132"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:20:31 -0700
X-CSE-ConnectionGUID: Gi0JjMj4QUa1XaDd3DSzpg==
X-CSE-MsgGUID: lF7S2iLRRvGEOvCAomQG/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110838628"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 18:20:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 18:20:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 18:20:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 18:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K650E4mtCDRNL4bPn5RBS/FCIXUzLKQDeEOwFKCVjusFxCKKygiVjAYadPX8aOfGb7jfIMyZrESo7/Rvzc0xr07ZAzG8S++WfJHs0G6eXUHA/4fonseX8q/8R+Wx0gFw6EkgJ9fx7MFH042Mda2ZN3SqjX8ckDreatBnc5TT0ajRmXyiyYZdC/T4IwG9TCn87uYb6KiEKkOnkT8cPF6+9k+eFSDhWPa0UiePOjhUIFZ0pxpXRacBM8lKW7i6vFbO3v+eBEOkeOl7QLYDDEczS0p2pvZ8MCJVV7IcS+ja0QyUty7B9kZPUTBrC08+dlcx1Dahw/AabSQMV9/HYH7LCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsW0sXq/t+TKbQhjq6E7hlQXNLGoRdeGC+zQAkrMQa0=;
 b=JLPG7qqexgXlfXb5Iz5vF5hyIYfy4y/HaSRThYZ61LqMO8nt1X+w9k4omR85APVXsQM+zJqC50wG3KgXbbeYvX80XC2goiKAjXbCTTtkotRqDTKwIVdDxLW8OlY15po65a2PUa78jeiLDarvbt2E8Qcmv1LiXWxOOXDLTPApcuSh0Wi04GexbLIAZEj62nkFCZowwDV76eaOcYW70ulaoZMmSGVZD8YB+YUqFw5QwBDvvpr/g6gBEle1wTIjKL6tAAztwVu/KIXFKuXk9fd/gWA0e8U9O9cH26pC5tq9NHgyBZCqetZZYe98zfs7JzJ4IOOA1QH53WMN/KQZjsQsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 01:20:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 01:20:21 +0000
Date: Tue, 22 Oct 2024 20:20:14 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 24/28] dax/region: Create resources on sparse DAX
 regions
Message-ID: <67184f4ef593_7253d294d5@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-24-c261ee6eeded@intel.com>
 <20241010162745.00007b31@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010162745.00007b31@Huawei.com>
X-ClientProxiedBy: MW2PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:302:1::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cab8bd9-a899-42df-821a-08dcf300dcf7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BBxTZmUwZfBFakDQCrBYRgh1Alcr9nJyLtIZQNpQ1NlFvQ8ClqRVX4R2wHwa?=
 =?us-ascii?Q?l03YAkvQeAYr3S3YAyDPLGEgs1vJL9gGGvbZpTkMyn9ENJMZ2eFxFdiXcnSs?=
 =?us-ascii?Q?aM+Jh1ch2SbdwsMl8hfq1+CeOUl0zpYGME3A+ormwmv91qJ/2kQslI9dsD3N?=
 =?us-ascii?Q?ioty1iM+eWk8orNnjxZEjsh7/FzXdRhMbdV/NvfwFBu3kGMcNtJhBOuatI6U?=
 =?us-ascii?Q?TkjHfA5iXRTYrIj8VNxyNMxCcYzzbC/VRHDWW2bU98rlxyglw0O2l2zk7PGY?=
 =?us-ascii?Q?wCSLn6ThWMnFmxMnExof8CPwZaPRfcNibYieawHNZifQLrnj2BkGpYOmLpIt?=
 =?us-ascii?Q?f88TEmXq7WaQ+uICsxzVHYR9GEySMHjYMiCa1Xz+Np21N3edJkYnlsU42w1D?=
 =?us-ascii?Q?IgVx3OmUxz9xLa8UHIt+nCfwpOl9bNDLhD/djPYkcYyXsU8Ux7LsQy2B9pwn?=
 =?us-ascii?Q?B68nEeOxXT6hFAk1eaAcMVSaxUovkXM0+0+t60Zi3asg6qJ6JuwqByB+07Nc?=
 =?us-ascii?Q?6T4pjlckAXTw1fq84JqUagrdpxtvxAD14XryuqJSNT5DGQ4Jp1vweXhCCq3o?=
 =?us-ascii?Q?SExDyxorIkW/zoznc6T1MwhOGHqkOvbNNGoN7NBi6y+fIECMNAtW7wVQWSe6?=
 =?us-ascii?Q?0MuXOdmcq+vNN8XKIGRoYsfeMZfskyLbBoFp641atx5IxHplF4HBHAj4kc9o?=
 =?us-ascii?Q?IhG0NnyNu2dwHuSOSlNeMKPfpT8nynD9lmFQCO8DUkjsTEpnEtgCHBtsDHvs?=
 =?us-ascii?Q?kjh8WVHdoHk/Z7QmLZVap3StLM1j3SkJ4lI2WZcxndZ9BekKgS5w8wS/tEUv?=
 =?us-ascii?Q?ACOClvBL22Rxf01V7NLsLjXv/U0yT9a+Xo/and353RKB1Kc+WjLEs6/0kmW0?=
 =?us-ascii?Q?b94hLHfk+a68bhPBgYfsZPazfwJGXvAamze7s14oQUZgiZpygogFlzGhRQBG?=
 =?us-ascii?Q?2977j9OaeWJ11q8TRmNywNQgzT2EJJkPRj1Jup2o913cQ0e2tAP5JxYD4X85?=
 =?us-ascii?Q?qCMICd7/Qk0belwK2hEZiGl+AP+wzbF0LAm9L4O08/UlkzWvMVUUlGQ0Pxni?=
 =?us-ascii?Q?4YeBj2e1dHAHILxIQQPcQZAzUX7Ty/bAF8fVTerfje4ZQTUn6PJnoKI5vcfx?=
 =?us-ascii?Q?Vm6/dl7PFD4svjW3l4RJ5i2bJzXxSwtfSMd8uQJHVbLQqpfH/kSvLhBq0pkH?=
 =?us-ascii?Q?Tyz2vuGKCWSEjZGrW7clYbm0Sb1DqxxwSeMLhpgpeu4V9dROQTl8dIGPt67X?=
 =?us-ascii?Q?bdHG3u0DE3bQXaeZh0MQmtx0EE5UlYYqenPFn+9CmtzkVSbwo7K8sWXya3Dn?=
 =?us-ascii?Q?HWpTCTbYO2EMxAyyc8MK2QDu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7To7+3ZUoOM/38aMre0un8AFXXxQvHFeyycwQIjzsIYg/nySTn+eRab3RWq?=
 =?us-ascii?Q?rDk6K0FnP9Y0hUHZoPV0yiu9z9Q2JlvbJMekTjdVw8bsehPDYzIPNv575Bj9?=
 =?us-ascii?Q?URRoDKCJJOGq34CF+7a3/J5XiOppNzPK2ihWjOSuPeNOZrvDdxcA5kd6UuQ2?=
 =?us-ascii?Q?NDokl2hBtG3Kyeul26hHySdJXQs5eS6oH3bCs+SYEjLgSYW1K16zajwRv6d+?=
 =?us-ascii?Q?w/pwgH8xwNajFy27fpn+T7AOamWLBZsUNBRTQVEi8pFNotuCZ+pZ1vQI7n4b?=
 =?us-ascii?Q?rIoJ0msl+mjlBnzNNfDV3bBkgi8/EqSgpA1GmTTT0AoIabMGfJBIHWF8fMdQ?=
 =?us-ascii?Q?tI4rbMBbvik8r4CXGIUymWu9lchyheruOY9yaSfM5U9A7EVmRlKiCFMADoqZ?=
 =?us-ascii?Q?H7Rtaa4Xd0YIUWTl/jn5fEsfE3ctfJwEyXpoi4LaK/+D9/lUw3q0begAdvtF?=
 =?us-ascii?Q?VTru4WdWRmXiXT2pbx1OFFpevSzAwYeCdY+C6R9qYxij6/ztcA7WdG91+IbC?=
 =?us-ascii?Q?BCj0/jp/iRCnfBaTg92NMGYoxn//w9dtvX4VxlQxRS8/bwjaUXh6sCFHP8Xa?=
 =?us-ascii?Q?ai9Brw066VZ2UQ3QIGvtxoYqhDcHrEfq2eNaRjg+FoYIrjzJs05cY+5eBGkR?=
 =?us-ascii?Q?At4VuXUKsdN/PInUhl2TpQzJ/M2+1eHJneOThfomq5IDxo//ilU9OrL4EKCu?=
 =?us-ascii?Q?+YaPCTO5cnhQQcict/OHcVswCRd2h6w1xJIMo4UCeiKg1BG1hklEzmBVnQlX?=
 =?us-ascii?Q?5rmwKRTUrOaWXLSqKKZvS7ViYrQPbr08xKgsKmXGCDxHHV+eS9EoIpUFmJMD?=
 =?us-ascii?Q?lkbAoEEEkt//48vOthDK26bv92ie+Fhtx6Bo7QBq7r6OaxRyJG1Rav/+kiJy?=
 =?us-ascii?Q?ZRMz/kiUXRr2tK13pnW/rGuAYpBCYqosOzMhVth1QuOAyudDAMxNWeqBX8D0?=
 =?us-ascii?Q?XCNbEHROl93p2LKkVakNOObxn2up9yXR9owt5mDe1ax4/Jmy+5LVk/al4TIg?=
 =?us-ascii?Q?wG4FpHxnFqbdCu509NoZAI/qnAPR8WG0rDP/2WbeM+aCo3OdkG/ecL2Q+79K?=
 =?us-ascii?Q?JNiM4RqfW8hZ9AyrXsV6qxqUjWWkB/2vgJ8eN0RFjp4OF/kzw6vqLncGXQqS?=
 =?us-ascii?Q?EAgUL6ulrckIXbYX+UyAewJ33Tojm1dDu7YiGrYqVcv1trNsdN83vQV76omz?=
 =?us-ascii?Q?Mc/vxL3TBVosP88EKNd0DLVhFwp/00oznq9+4joon/IEyRdtYHbffIo3Sy8q?=
 =?us-ascii?Q?WvC9ZBIBYoOejEExWzDksP9GnwKVKChjTeC+/xKf/vif+KPUbTr9B2bwM+qr?=
 =?us-ascii?Q?dHzCzzDz/PsfrjaXVjoGbmQUFnGreRQUU6yeQFwbuP5dO50iJGljJDo5fH4I?=
 =?us-ascii?Q?0+tIvwTXiH3BC9btvDxGajASMgFtIJEGhd0YZo0nUeUu8leRjglJLd6/CUwf?=
 =?us-ascii?Q?0Vl2sg8zUezhcUsg1MZVKhe+OypnlXXp5iEsMOEyuUk4qP95t+WryLuJ/unf?=
 =?us-ascii?Q?0d+ZMIuunFMYNpffFy5he+oBoWssRJgHfSZ3hdk6kHUet5wSzRy1Wb9WEbie?=
 =?us-ascii?Q?lYE3kmjAbgWpGUFI7dnlrQStYhgVSJiQ0MDTocuE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cab8bd9-a899-42df-821a-08dcf300dcf7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 01:20:21.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TmAZSR6xxNbkxOf1CLKqRrb0mfQB0SLOeVV8LyF4uhUS9e8o2HEPnzZ/UjQagi9aIPK6EgZjDGjxBYiaRFnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:30 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>

[snip]

> > +static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
> > +			      struct region_extent *region_extent)
> > +{
> > +	struct device *dev = &cxlr->cxlr_dax->dev;
> > +	struct cxl_notify_data notify_data;
> > +	struct cxl_driver *driver;
> > +
> > +	dev_dbg(dev, "Trying notify: type %d HPA %pra\n",
> > +		event, &region_extent->hpa_range);
> > +
> > +	guard(device)(dev);
> > +
> > +	/*
> > +	 * The lack of a driver indicates a notification has failed.  No user
> > +	 * space coordiantion was possible.
> spell check.
> coordination

Done.


[snip]

> > +
> > +int dax_region_add_resource(struct dax_region *dax_region,
> > +			    struct device *device,
> > +			    resource_size_t start, resource_size_t length)
> > +{
> > +	struct resource *new_resource;
> > +	int rc;
> > +
> > +	struct dax_resource *dax_resource __free(kfree) =
> > +				kzalloc(sizeof(*dax_resource), GFP_KERNEL);
> > +	if (!dax_resource)
> > +		return -ENOMEM;
> > +
> > +	guard(rwsem_write)(&dax_region_rwsem);
> > +
> > +	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
> > +	new_resource = __request_region(&dax_region->res, start, length, "extent", 0);
> > +	if (!new_resource) {
> > +		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
> > +			&start, &length);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	dev_dbg(dax_region->dev, "add resource %pr\n", new_resource);
> > +	dax_resource->region = dax_region;
> > +	dax_resource->res = new_resource;
> > +	dev_set_drvdata(device, dax_resource);
> > +	rc = devm_add_action_or_reset(device, dax_release_resource,
> > +				      no_free_ptr(dax_resource));
> > +	/*  On error; ensure driver data is cleared under semaphore */
> 
> It's not used in the dax_release_resource callback (that I can
> immediately spot) so could you just not set it until after
> this has succeeded?
> 
> > +	if (rc)
> > +		dev_set_drvdata(device, NULL);
> i.e. move
> 	dev_set_drvdata(device, dax_resource);
> to here.

Oh boy...  I probably needed a better comment on this one.  No we can't do that
as written because no_free_ptr() was used to flag that the pointer was handed
off.  Thus at this point dax_resource is always NULL.

That said, I realize now this code has an issue with using
devm_add_action_or_reset() because on error dax_region_rwsem will be taken for
write recursively.

So I have to re-write this using devm_add_action() with a manual reset using
__dax_release_resource()...  in that case no_free_ptr() can be moved to a
better place.

All that results in something much nicer:

...
        /*
         * open code devm_add_action_or_reset() to avoid recursive write lock
         * of dax_region_rwsem in the error case.
         */
        rc = devm_add_action(device, dax_release_resource, dax_resource);
        if (rc) {
                __dax_release_resource(dax_resource);
                return rc;
        }

        dev_set_drvdata(device, no_free_ptr(dax_resource));
        return 0;
}

> 
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_region_add_resource);
> Adding quite a few exports. Is it time to namespace DAX exports?
> Perhaps a follow up series.

Perhaps.  The calls have a dax_ prefix.  In addition, I thought use of the
export namespaces were out of favor?

> 
> 
> 
> >  bool static_dev_dax(struct dev_dax *dev_dax)
> >  {
> >  	return is_static(dev_dax->region);
> > @@ -296,19 +376,44 @@ static ssize_t region_align_show(struct device *dev,
> >  static struct device_attribute dev_attr_region_align =
> >  		__ATTR(align, 0400, region_align_show, NULL);
> >  
> > +#define for_each_child_resource(extent, res) \
> > +	for (res = (extent)->child; res; res = res->sibling)
> > +
> Extent naming in here is a little off for a general sounding macro.
> Maybe for_each_child_resource(parent, res) or something like that?
> 
> Seem generally useful. Maybe move to resource.h?

I could (with the name change).

I guess the self review process ended up with something generic except for the
'extent' name.

> 
> > @@ -1494,8 +1679,14 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
> >  	device_initialize(dev);
> >  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> >  
> > +	if (is_sparse(dax_region) && data->size) {
> > +		dev_err(parent, "Sparse DAX region devices must be created initially with 0 size");
> > +		rc = -EINVAL;
> > +		goto err_id;
> 
> Right label?  This code doesn't have side effects and the next error path is goto err_range
> Looks like you fail to reverse the alloc_dev_dax_id() in this error path.

Yea.

Worse yet I think this check could be done much earlier before dev_dax
allocation.

Let me work on that.

> 
> > +	}
> > +
> >  	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> > -				 data->size);
> > +				 data->size, NULL);
> >  	if (rc)
> >  		goto err_range;
> >  
> > diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> > index 783bfeef42cc..ae5029ea6047 100644
> > --- a/drivers/dax/bus.h
> > +++ b/drivers/dax/bus.h
> > @@ -9,6 +9,7 @@ struct dev_dax;
> >  struct resource;
> >  struct dax_device;
> >  struct dax_region;
> > +struct dax_sparse_ops;
> >  
> >  /* dax bus specific ioresource flags */
> >  #define IORESOURCE_DAX_STATIC BIT(0)
> > @@ -17,7 +18,7 @@ struct dax_region;
> >  
> >  struct dax_region *alloc_dax_region(struct device *parent, int region_id,
> >  		struct range *range, int target_node, unsigned int align,
> > -		unsigned long flags);
> > +		unsigned long flags, struct dax_sparse_ops *sparse_ops);
> >  
> >  struct dev_dax_data {
> >  	struct dax_region *dax_region;
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index 367e86b1c22a..df979ea2cb59 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -5,6 +5,58 @@
> >  
> >  #include "../cxl/cxl.h"
> >  #include "bus.h"
> > +#include "dax-private.h"
> > +
> > +static int __cxl_dax_add_resource(struct dax_region *dax_region,
> > +				  struct region_extent *region_extent)
> > +{
> > +	resource_size_t start, length;
> > +	struct device *dev;
> > +
> > +	dev = &region_extent->dev;
> Might as well do
> 	struct device *dev = &region_extent->dev;

sure.

> 
> 
> > +	start = dax_region->res.start + region_extent->hpa_range.start;
> > +	length = range_len(&region_extent->hpa_range);
> > +	return dax_region_add_resource(dax_region, dev, start, length);
> > +}
> 
> 
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index ccde98c3d4e2..e3866115243e 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> ...
> 
> > +/*
> > + * Similar to run_dax() dax_region_{add,rm}_resource() and dax_avail_size() are
> > + * exported but are not intended to be generic operations outside the dax
> > + * subsystem.  They are only generic between the dax layer and the dax drivers.
> > + */
> > +int dax_region_add_resource(struct dax_region *dax_region, struct device *dev,
> > +			    resource_size_t start, resource_size_t length);
> > +int dax_region_rm_resource(struct dax_region *dax_region,
> > +			   struct device *dev);
> > +resource_size_t dax_avail_size(struct resource *dax_resource);
> > +
> > +typedef int (*match_cb)(struct device *dev, resource_size_t *size_avail);
> Why is this here?
> 

Left over from a bygone implementation...  :-/

Deleted

Ira

