Return-Path: <linux-btrfs+bounces-9107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C09AD95E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 03:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751CA1F2333A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 01:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D974068;
	Thu, 24 Oct 2024 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mI2tJu9a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62304C9F;
	Thu, 24 Oct 2024 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734080; cv=fail; b=shjgw7hpz8TLJGJSSNRCrIcfX0CiExd8/xy111BwMdf1NBGdRE7W3otRLLH38JuDDKrcsqB7AZHHEhFUzWuwhB7AJHQcykQr9S/s+uPvAr1kQIrIjlVIORQnYrbmvgRB2D5qrWy77stEPSw5W0l4jPLdvRr88BiEK0AmEpD+aps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734080; c=relaxed/simple;
	bh=gmMFi0iTvGTITCwSRI1gom2pyWxLZ3zizdQWMPeRfzQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DD2L6obMBxX9tqcnzjAjWIRlEXoH67Sv5ogyUY4Ap0IWF2FF7yF9hOGGOm4g2+kQWkmr1iKjr1CVoJoMHpNru+8jb3un+iJWzu23jOqU2eVcQuVYUJFqId6rIpr+1xF/ua4dYf9u5NJTzZ7No8uVjfZOEtyoULyja1sELxuaJE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mI2tJu9a; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729734078; x=1761270078;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gmMFi0iTvGTITCwSRI1gom2pyWxLZ3zizdQWMPeRfzQ=;
  b=mI2tJu9aFD0rFWLlm6Ay+O4jq+5fP41uAMzPHT+4oy0F4RZQUjRGxng9
   eGl6R09ni5LqA+7tjP13wiH20os+55TyqlWGhpBUxi41qaBgc9OH0PQzS
   mpjkuMHPDyu4XGnSa7D2GvD3QfuVcKd3R5wyhdc9Oz6qBQ4S8Wld4eNB9
   BW2olQwH85Sh92v5axICsBYwaagOjevfb5NziJHL0lObUz2r9/3JhiyrO
   BSuAkFBUSQZwBDJNlU09wLXTsAsYXxY0vDR5sBI2jUTs+26WOWD+DCDZh
   Nd4d8FwVAwcRvMRAaqmLFcuM5iH4xsPOfgv6frBG0CULZ5XTXPfXMbT32
   g==;
X-CSE-ConnectionGUID: WJJc9kZWTWKeSFJxvq+7Ow==
X-CSE-MsgGUID: XXrBtpnxS161dKaw5kxvqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28790357"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="28790357"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 18:41:17 -0700
X-CSE-ConnectionGUID: tTeXP+WHRkKgW++1qrO7VA==
X-CSE-MsgGUID: ccIKtq6sS5SKEaY8Hg/HNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80105020"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 18:41:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 18:41:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 18:41:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 18:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L59aEhsRRENxyaPsw7uZnsNaGcOQV9SUWA80mPknxXZOrelUgbopl8A1rFGi2RBf66ieSL4GZlCzID2v/kF+al29v48wuHa5mpEnX+VXTgYjmC3JN9/PxLwyWcyV3PW82rxYQzDaiR3p5YTIJfAaNsjnCfq4cQDOSAd9dehx3BKDMm5KS5exWFQS9GQkz+EK8vTrzCVfz1yVUIiw+6S9peo5bYgOVwHtYgQgte1Aj0VyD4HkV91VG8WlTfNp3l3Jp4N5QCSFwYejO2GrfdaZOTHGSSgeBR7Q9l4WyEBEkTn1Y8p1UpneTP4PYxQAusHBSF2HkVCRFoDQS3wZdOgOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9boclwTPeTWmHnOnrCu3dHO/SkIvH/QQObWja8A2lM=;
 b=sVXp99vV7gTPV/cDhrX6R29W9fJLG4mt7Z8cU+U/kZZmmgRpyeIv2LvWY0hzs5sbwAlI2ARhzeN2Rfvlzqifo0ECPcMQFQQVQTKvpJA/jYob0nDQH2Z5K48BgQGVy41YQCWk/TNcsqKPn9riC2ihJQ1aVNwyIqbmkvcJWgwUSH9Jhs2r2lynfihGc20B7trT+3ESdOjxPi6lozbQQwQNiPBn6AOfNfAsyDb6tqV48I7Ua5qHtYgP39gh8CKz/yThTSXVZAgbz/hfGDy8yONMBVoj2QCJwrAEEeTeE2iz6ygU8szAj6nUSS9NH2epgQKNFCZ0ukRws1Ec44rWhl25Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 01:41:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 01:41:13 +0000
Date: Wed, 23 Oct 2024 20:41:07 -0500
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
Subject: Re: [PATCH v4 25/28] cxl/region: Read existing extents on region
 creation
Message-ID: <6719a5b3d3d02_da1f929497@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-25-c261ee6eeded@intel.com>
 <20241010163359.000001f7@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010163359.000001f7@Huawei.com>
X-ClientProxiedBy: MW4PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:303:16d::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: a206ad72-baea-4834-d1d2-08dcf3ccf185
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KrrnlLVwUW/QNiRznTsEe2jl0iXSzoPm2ZjnRdr4HUt1w6Mvq2XQqiWFyuSm?=
 =?us-ascii?Q?ObopV8+AKsuA9OmfQdv72/nG3dYE0Gdtv2ceCoU8GWsHQydyGWmx8IITYIfO?=
 =?us-ascii?Q?G5wcV9iSPJh+fNxFDuFlJV3hBSzKZaQP8V9eycKZpOgBmOhq0ljhJ39RzxIc?=
 =?us-ascii?Q?Y1hQOXNWQ+ojAr0iFaJVGzpKc5epTiMQL5R3tc/QultMIV2eggEaBHDy38Kt?=
 =?us-ascii?Q?vkPLXu68f1LU84HDm50y7YmhMM2hFLZO6fMeVNw/w0ptqAvNqc/vKMZOrHBZ?=
 =?us-ascii?Q?NJ/XKNOqkvq0XT4P64DCB1DrL0ZBJN+RbJZyYxmtWpyPJvVdeBdnX/QFr8nY?=
 =?us-ascii?Q?0omEEWEtaJWsSKJ0WS5K7IhTimGTXLXl5NP1tV1/+AOQrHSIDxLz6uT0ZUTN?=
 =?us-ascii?Q?7QA5II2viNAQmUZXa5Y1Mc19uu1qXy8YCteRmqdua7vWHEKr8nmycZuhLVQ3?=
 =?us-ascii?Q?joCawkMunELMZgdYUNqGcfjtNj7Q2/T1tlvZPdxxnBKrIl4VCylq4Jad8TUQ?=
 =?us-ascii?Q?3m9OJUw3oFpn69D0PekrnOzadrZlDjYq1U9vjhKhG19yUDnsIENdPsQbIait?=
 =?us-ascii?Q?/G9jY+4pCP1N0ZoZlHvoj86rOzHpldxTkynVr0twlXdyBcvSCwcnk5ZQTKrL?=
 =?us-ascii?Q?2k5MOh32p/fh50kJEwAuUTsL/83yjKgQz7ULqU80y6bFWJFkPGUVxRjrug9k?=
 =?us-ascii?Q?niXoKjP/vmQORfVpePhWFhsF+MEoV4lo65kqTEiN0Ex+vY+z2x4QUEK4fwAw?=
 =?us-ascii?Q?iOKQ7urKbQzFWUFOTGfhDC3U96Mgv7hvdifmY7W7Sjrvu/p0KDmwAEd+Z11i?=
 =?us-ascii?Q?u+mTzx5J56CShGfE31VX4LLgMZNCWZIaZDJizB6io9ff9Icf1MiD7e9LFNaG?=
 =?us-ascii?Q?47wsMaBI81ySHo/MNk6AMG/QZFaHP8+CmYNIYu0DMs5kRL6ocnmAyWvMzl+m?=
 =?us-ascii?Q?uHYurDwX8tmTR2YuApVF5Kcealjpzt3Xyxh+bOfAKh70km50lTD1R92eXx1G?=
 =?us-ascii?Q?drzzXmkc6kAoV0ljy7rKrxsMUhd/SqaSMO7/NgJ9BHB+UbX8kb/AKjHvuxZq?=
 =?us-ascii?Q?uP+vpdr9VQ4uwFBLQprwS1FV0CKYr247pbPQi7XfyuJxhtasUBHRCEtQ0EJ7?=
 =?us-ascii?Q?SsQviYMBkmrOYMmO27mYuf5EsUFPL6b9A+KZyIAwo8uAw1bKSct89BR2WcK/?=
 =?us-ascii?Q?khyVnw2X28n3hmrfYLpG0/5Z8U94N0tb6HfBSWY3ZBlxp8i9aa6BTokUXECk?=
 =?us-ascii?Q?HO4CCPUSaawwbQ1iFqonYQsc84ESEniro84x54Cl6vzQy4mtEfKlC+KRYUMw?=
 =?us-ascii?Q?ntEz+7N0Dz8pK71yPf+ANGmt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NK4tJd6bCOGfxaw1Eg17hNCFO1Y65mj6pRUpp0WiJbdR/USudSbeD/6s6Dye?=
 =?us-ascii?Q?VTLHKE00V/4Nby7v15VRial8txZLFQepjfcAgYTKMlQd0wg8la+Skpm0yddT?=
 =?us-ascii?Q?0oAkYnQ4i6KMNotYPSMJyAXxUcbRKyYS9HGxW2hnDK3Z39f72c027qpNaWRZ?=
 =?us-ascii?Q?Ork8n31CT+M+MLA7Ptw/lFzt3lbKxq4nhgpAnSWv91UjLOV43a9Na12DiL4U?=
 =?us-ascii?Q?nTYsUIsYDsGPFMUA2Aet+mBbm6ePfIIqj1Muemm1Pn+L9nStZKujYENAXYXH?=
 =?us-ascii?Q?JEzAbTeWCUJz5BoyYOP/1seSF0dWh+1C0b/GqE1hVnJE9neXOSY4tTMtAy+L?=
 =?us-ascii?Q?PfM5SJb81JcidYfqXD2rFINqEv42Ns4bqnHMR7XjpMAoM0Cdpxpj3eQDsncA?=
 =?us-ascii?Q?wFuuWcUlgKetxXZ6YY5VUiM0upM3YTBVxCEBS27vCYzT1lJ8cwiP3OnaIhal?=
 =?us-ascii?Q?lpHu4gOOxFCRFdXMpqp1KjS+iu6u6yJJSyPrH+hc98EME7lhQXT/jTB8842i?=
 =?us-ascii?Q?CYCNlT9FLyaYxhDHzbw0YmOnifQwcCKYMLppyRkUWj2uaePClXQYv/D4IAly?=
 =?us-ascii?Q?Qr2Onuzr5o+kr18DGZtCXw3FmYTB3BByUjcU5Sah3Lphs0fguayAkaq77R3d?=
 =?us-ascii?Q?7IKxPiKQ0jXJ8pZvBKizvKU3SlFNGhynshNKHkAyRN/TcP05Dd0Tre9cNzf6?=
 =?us-ascii?Q?bxJjsm9fFznpzaC0wemklBP66ZXVtDMnmLlt3dx0iNbMK7Ds4Xy25n/CNdBq?=
 =?us-ascii?Q?cjIKISVa85mApo78jQjQBMNx5M6MX5xSnE+ZYGqY+Q9QT/WCk0HOPvfyUzYM?=
 =?us-ascii?Q?JaLz8OopgIdCp5klCyoBrxriPAxFf58F79I326NSDpCx62N9DFgp+erdYHhr?=
 =?us-ascii?Q?I/OmyFSe3HEgpDnpnI4XEDcZwKlRu0hZsCqdKpyJF7DS4gd1LVn/hIIm3Bkz?=
 =?us-ascii?Q?rEYk/VmsNFf/lJp9FSSQB0ZvHOiDjNG4818fTQqH1NE6TDhvp/mu0CcO/AbO?=
 =?us-ascii?Q?yYWivLE5qzjTRuAiWX/CalN7y9GYKUGRjgUIqLIGql1i0grFvpTZgrjol2Pl?=
 =?us-ascii?Q?JQirVhJ/i5JWycw/6IGAW4uP5IgLnIyzrw3cqDrMNkMzQiePityOHLIrcB3s?=
 =?us-ascii?Q?3gP3KZpxgxRsq+f/sI0/QktDcW8VYbX5/nU/bXmHoM0b9oH5Yke2+ODMBFP6?=
 =?us-ascii?Q?iqLkcDIK9I2dejm93a4NeMx0Z3BeJSNL4DijE+CGpbVqoRkxhGN+hnFSVZXi?=
 =?us-ascii?Q?AejueTB2yI3pxrw57jZpKX9LpI48PGDLt7mafi+Mxt12DZm1yUgj9Mawf3Xm?=
 =?us-ascii?Q?+PG7qQBxYwvP99goPPPTRZzzW6uDK67Y4BsPRg+PRsxXS4qL8j5xbOy2R1U/?=
 =?us-ascii?Q?DPEfVsEaCiVDBot+z36F8CvoSP/vqY7ewnux3Y3L331G/JEiL8VFgs4LJNJ7?=
 =?us-ascii?Q?VjI5JKyLCGz0Ji+QDL+znK8jDOTO0mp2FM+SMQbC2dPrAZJ1kk5lAHNdqgPF?=
 =?us-ascii?Q?njJkspjVuVfFdYuExijoxXQ+skamL4iQNVA/K3tEHt4KjeAOetf35mSr015x?=
 =?us-ascii?Q?ar1ViTFPZgBV7cICoQAmfusnnBOydHgTUABdtwK4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a206ad72-baea-4834-d1d2-08dcf3ccf185
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 01:41:13.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DP3WBYESxl1L/35Asujn78pRVMIjZACLnFlBUv0eUi64ZYjhJEaBeCovU1BAqlAlN1yn04nYT5gbB/DH75uFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:31 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > 
> One buglet, and a request for an error message.
> With those.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.

> 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index d66beec687a0..6b25d15403a3 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1697,6 +1697,111 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> >  
> > +/* Return -EAGAIN if the extent list changes while reading */
> > +static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	u32 current_index, total_read, total_expected, initial_gen_num;
> > +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u32 max_extent_count;
> > +	bool first = true;
> > +
> > +	struct cxl_mbox_get_extent_out *extents __free(kfree) =
> 
> __free(kvfree)

Yep fixed

> 
> > +				kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> > +	if (!extents)
> > +		return -ENOMEM;
> 
> ...
> 
> 
> > +}
> 
> >  static void cxlr_dax_unregister(void *_cxlr_dax)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> > @@ -3224,6 +3233,9 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> >  		dev_name(dev));
> >  
> > +	if (cxlr->mode == CXL_REGION_DC)
> > +		cxlr_add_existing_extents(cxlr);
> 
> Whilst there isn't a whole lot we can do if this fails, I'd like an error
> print to indicate something odd is going on.  Probably pass any error
> up to here then print a message before carrying on.

Bubbled up an error and added some dev_err() calls.  I don't think they
need to be rate limited since regions are not created very often.

Ira

[snip]

