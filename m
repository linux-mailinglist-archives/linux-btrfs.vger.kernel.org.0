Return-Path: <linux-btrfs+bounces-9108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0359AD971
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 03:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C671F22E17
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C013665B;
	Thu, 24 Oct 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh6sfiW1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AD1BDDF;
	Thu, 24 Oct 2024 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734746; cv=fail; b=PREF7sU6T2YLhqzW9r9H9rNahNdPl/aX8Fy8hGGnNLKkJhQ07EWctbqGJ/2X2WZKLUXjzX9TPvChxbGvMPo5iggW5kqE0HlSrTTj/LgZUfhIqwr8AcGonOe/41xmv+0PpEifPKf6ACEJndBwU7L9DJPSWpb/2n7qAB0/wbkrOws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734746; c=relaxed/simple;
	bh=BOoHKfypQDGWZsC30tcVC+7qzCW+UNHwgRO3HxSLZqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mL8TIcCZGVd24mO2FBi85ObO+o4hfsQ0a/s8MYZX36w7KU1pj8TjkPogLp6p3mkC9mtykAJfPZbBbm9GktNTebmq4PuEtWj03PIUj5KaUlQNBnx4ms9P8g15GIrVIpfDJuNYZxur9z9Ryhv86QEwQL5w3aOzIs+noNTkbQGAPsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh6sfiW1; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729734745; x=1761270745;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BOoHKfypQDGWZsC30tcVC+7qzCW+UNHwgRO3HxSLZqI=;
  b=Mh6sfiW1yb23gcWYwfEmy0nMW0R62oAC2TNsBoNmtLS2S7KXdo5h8AxV
   ZL5fyHCb6SzrCH372KkMLXOUUUCr/HYVXfxW0zTDyiG9ifHuabmDni397
   kdYfxA7kiNzdUx1oeEFcmUujBupAUJvHuUmo6d1KksNsO7lEfMQ0RfHZM
   aUSeUdddVxffLKVzzQwBxew1Rh8vK3TzApT0692kJNknRHGestUAKo+8g
   TLFWNxYa0NkiZNDmevDJPHZsnzMSotIcDuMzU5U/WUvyTs/sEoXfTgPsj
   +5Ib23codj3WcHOSddygaS9OjB/MOjlfnQkWHa6NMTYb6cRJmDxQyEWei
   w==;
X-CSE-ConnectionGUID: O6Ukh7bZTheGQwyFSChelw==
X-CSE-MsgGUID: /GAsYionT9OlzJ4RSyNkDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="54749263"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="54749263"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 18:52:24 -0700
X-CSE-ConnectionGUID: GwDY2nO/RP641l+f1za8CQ==
X-CSE-MsgGUID: 2qmkRgshQrSU9Wv8xrLrmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85554546"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 18:52:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 18:52:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 18:52:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 18:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KT+soN4ZBFYmZLlzBU+JXodxKAJ8ltB4V1EvtN6aB1l0LzHcR0D5h/mMl7iPLRRYjrXxxR1bUC7l/ukuvubnNOe5GthFQBk0p+Lr+r1b6q2YRlgxmbkPhqbQOUKySCF6JBJSbz1vb8+eA8kcv0TS/yN4EIFfErsOW/91liXZ7SlT5VKuS7a9g2Jyd1uOoi3N0cm+bicTPANCrd4wAJ0QDtu7V7T+8+rVCobh7FPDG/broBvi3WfHaNes9YRWtVYUKWBBLr5AbpSwgELwfwbR/qUA1eARVkUxzQriFrBx7UX8/BRUAa8JaYGLOIMhDdWe8k9e4yl7QlLPvnoCF07X7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymLoE8O/P0RM2sxU804E1XLbyhyYB+lkTGro+3K3ADs=;
 b=oNpavLUA+kqooRo/dcRU3usGZW8QPrsw32Pi9NHmboZ1xR84fTvI3OQSB0h0tD6Ep4YK32fnaNicMLqAHR5cddY6WPji/cI+37b31TJsgRgtEQ6AD6UE6gY50BG43UJy3qfT3o5Ibu+hc/yQzg395AEIVugWMQBHZhiEJ/sRIrAU+b1cyew88RtSkn9xzbtih3f9+R4H/OWv/CHK4iA5F7nBIOgoXtcj/Y68Eq5u09T7uY2mj223U27SZrXonsCCEBKm8QmEdvv/sxTdNSTAgqY/gX9HpgJU9adooMGwvDbasAs1hr7oErHT9y0s4+2F9hri8wJvxnc3wVhh2RyXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 01:52:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 01:52:21 +0000
Date: Wed, 23 Oct 2024 20:52:16 -0500
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
Subject: Re: [PATCH v4 26/28] cxl/mem: Trace Dynamic capacity Event Record
Message-ID: <6719a84fef9e6_da1f929450@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-26-c261ee6eeded@intel.com>
 <20241010164133.00005d53@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010164133.00005d53@Huawei.com>
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 3098ef0b-a97d-4f65-1abc-08dcf3ce7f72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B0/lJq7wc6fIZXsjf4w1zzOCHtY5QQNfefw5TlaydVCunyvibmVW5KVUuI0Y?=
 =?us-ascii?Q?KDZ/GTCpsepcf0l7elCwXZTZnDRcQDjewqthMEW6IVtq//5HN4iryMpT1VeM?=
 =?us-ascii?Q?ZDNsxWCQJw2oMFZSDgeLPREfgHjSa62pGiWcJD+2NuA7KXh9luUaCkQa3rZ/?=
 =?us-ascii?Q?tMgKPuWW76FQfZEtx+J8y+ZFlApFNWDO9DtlDc0CVnyomIai7wY1ihzAnK0l?=
 =?us-ascii?Q?9p9hvgroYNmIDGHGQy9W49fQ0ESVuXrpf7BSmygREmH4InRSxyWdVpMomDf/?=
 =?us-ascii?Q?pG0YRhMr26VBnhkgZtwTZCKKfcCNt9UHttgdRySelOsbSLzLW3wbSbN9/vON?=
 =?us-ascii?Q?/SubCGzapJn3rNsbzyWkm1wNursxBon3zPZib6TupUIkhMd+tgPnSDGvQjok?=
 =?us-ascii?Q?p23+Trv3Y9usbt7IKwXEl3Ii0IBlTFrMMd2poD7psdb7I9emFSi7PWCONpMk?=
 =?us-ascii?Q?1C1jIbTEMOU8hGjKkACH2sM6QKwcRXFoONFXyXy4184n522haaxBeuDZK+NP?=
 =?us-ascii?Q?3dMBTu7I+mhgju9m0h57KEFQKYlm2ER08WduOa4Mg7F031CK3PN6aHdVrrM6?=
 =?us-ascii?Q?5LOYrJzKEgNhi8Z2MxnLoR+8Zku7vBq0g67GfxreXotLTzEoBsI2jFdnDozq?=
 =?us-ascii?Q?R0xLrpnRtkBztubpf1L9et7I6uUMwasdeAqnM79UbHiU+Nb2eFhDVvMHHKnL?=
 =?us-ascii?Q?SMGnddHYxGU7gF/jUYFGNxDLENUfW8EV81BZDCst7srxNDc00o3YbZa0lnJp?=
 =?us-ascii?Q?DykQgAMQ77jgyuJnb9/jnuonyIkX8WPsKqZtpu2CZYGWDx+DGqIMyqjQVl8I?=
 =?us-ascii?Q?L/yK/PE9Z5cZpvuxp9JGCbmdKfLV+nboQSsIWvhHnmXmFjQLubgKakhpMXia?=
 =?us-ascii?Q?PNmkp115mQGLRfMqKzMnjRiEPkGsncXLoEaZH90FerVkq4uXEvURb9JpKs8l?=
 =?us-ascii?Q?rqzCnF6clyvMsTexT9kthiRbUQtX2F7BRphM5oC+Se4jT5sheRyeUPfBHOTH?=
 =?us-ascii?Q?TBhXSHBJFHYE3LnPy88BjahORD6XluPMRbEELeYGF9wSYzsWPt9B+yRMzSUi?=
 =?us-ascii?Q?KVLRVV2/HN/eiop0RwoAyA1+soLERwZVxTksji9lDHqDaIFy8NSzUOesdTUE?=
 =?us-ascii?Q?VcAybfDfSms7ur9k4HuIh3tTJyjaxdOrHGRW+V0srZ22MfLygZHUWsM2IsyR?=
 =?us-ascii?Q?D5obz9LTB0HVYvI6R4j3aol0DBdgE/G2XBLBbUEfwprWVUNDssssjrYPZmCi?=
 =?us-ascii?Q?BFByr1kLXDMkZunJDWr3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SmvhlC57STVj1HMXrydPBcDMtsazp1TxgDEdsPTWc/QkP3Y4whR8Kn0zgGKi?=
 =?us-ascii?Q?SEOBqF9zjtX4bjYcvKX+EdzOXlGncU+A4p1WWxl1Nq+hKHb1Eju8m1T73dU3?=
 =?us-ascii?Q?7Lid/mfomthj9OPOQ/YoXy1aHfaPDpEC4eLK1AihTi8gVIlCsJbq6G0IuNSn?=
 =?us-ascii?Q?GQJ75Y3vwU61J9F+dqldMpD9cfc3sOLt/dPjM3oIuBegCQED203quTnYatwt?=
 =?us-ascii?Q?UFFsUTNtU06EkVCkLvLeRhW/Iv+1atqa4pdzH9XJhAkpoV7GzDvTwDndsHxx?=
 =?us-ascii?Q?7NVXLtA+E7ifrw+31HWOGT1SNdjORBTB4oXy/cCQ0ZULxNviGAZA/jhuFpIF?=
 =?us-ascii?Q?58CNhMp4u6cAl5LYlkSx/WXKPuWDaEr8U+RQsiUPhcdhO5R29NTSkm6aB5zn?=
 =?us-ascii?Q?yKENCIKa+B/tfGYLjGwA70jUQcp+yf4mz77q33UgX/OtZwWEFNMwli8n4Jy9?=
 =?us-ascii?Q?ewrwWxavl88t6FEYxyPhsBJduTenVEISsMxvacjvbhkO3uksgI/JHqA5XNNk?=
 =?us-ascii?Q?a3O571/sT3fFItIIHsIFIwn8JWRRvMys9RJZIw2gbW6/TF+RMwV9kusfMJ4Z?=
 =?us-ascii?Q?dZqc2tFa5a+ozE5PMllOobezr5BW1H6xzxeK2nCxnG9939qx5ubVOqgiP3cK?=
 =?us-ascii?Q?vTRAFu32g8JSJy2dhHUJOXjcGQT9KF43V/S7RaX1UWogwP4Vo+Q2X+9j0Xas?=
 =?us-ascii?Q?R7ZuzmtP4VuKFQllUjgbBFzndU2fFA4HXVb9WGhx2MMplzWZLEaYq+YvKDq/?=
 =?us-ascii?Q?3q+2hjLbt/YfFue5SRrxT9vTv8j5cSz9VvpTcbFgTlpy04qun7AXS/dywe+C?=
 =?us-ascii?Q?e7hNwIGRyJvAis6VrBbvm2wD3kLcTQoyOwFhqiqNPb+o755x8aNzGha8kBzT?=
 =?us-ascii?Q?+CQbm0Fs2I5XnyoIhbgP0DYy4y+jdRtnhJ41VtrP7ulMnt8qyxJKL4DJZ2zz?=
 =?us-ascii?Q?JU6e8T8pP8oGin4Om27UbVtr48GmlrYrQXMWK1Hfw6BsbG+bhLJROatF2ORw?=
 =?us-ascii?Q?EOk4sxl3drm9Y7dhiR7Da8Ahl9S+sDNbTSYrjF0M5YrlW0ws1HgxrRZ2fqA6?=
 =?us-ascii?Q?xbwC82x78dQrcARRA2us23//XjzYM9ZszjLTgzLDqXqMJQyn59oJyuwZ3Dce?=
 =?us-ascii?Q?+Cm1gDQ2w4NhKAdcrc+sC1Cz+Mp1icKHrsKUo3tJyC4k2VHi06xny002xxcO?=
 =?us-ascii?Q?X3StNAV5Hxv73seXjWgzjduKIIHW3b0puP7pX13OKUV0q8wUY8F0k3X5kfr2?=
 =?us-ascii?Q?OunINMlvKbfwj5j1eSlL2qrFCHMD35GgrGXt95o5BsfxIfczFqgvPYq7RA3A?=
 =?us-ascii?Q?Hi77yBqjZ1g6a7+BZekZzzJfjS8/kzMF6oyL3cbPTQcE6psibkUJXvTXIJEr?=
 =?us-ascii?Q?OMGMb6uNom2glswV+QaK5ngrw8t6Xs+rZb4bZeZlgqe/UFIM8IuPa5IIjC9p?=
 =?us-ascii?Q?kZ8hVhDLhIq2IzioptIzfLHDLRez4tzikcISNT0quF6a00z0v7xxDRW7AmSM?=
 =?us-ascii?Q?Mc44WLmc3JsilODvYEuYbbRXiditEv8yAGnNGzDlWbIMQN10IkKw6EKpG9zq?=
 =?us-ascii?Q?wh88Am34SxUsZ0ZinluDYDhEvLfg4b6dr1hVd4QU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3098ef0b-a97d-4f65-1abc-08dcf3ce7f72
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 01:52:20.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMH19bJcI0wTJnxPJWt8PI78zs5ggX2uKGI8yJe4NfivUwpRPbAoZhpOkd9/cOIENS58Uu/+eo3tcxgY58Emng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:32 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL rev 3.1 section 8.2.9.2.1 adds the Dynamic Capacity Event Records.
> > User space can use trace events for debugging of DC capacity changes.
> > 
> > Add DC trace points to the trace log.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Minor comment inline about tag formatting.
> 
> Either way
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

[snip]

> > +
> > +	CXL_EVT_TP_printk("event_type='%s' host_id='%d' region_id='%d' " \
> > +		"starting_dpa=%llx length=%llx tag=%s " \
> > +		"shared_extent_sequence=%d",
> > +		show_dc_evt_type(__entry->event_type),
> > +		__entry->hostid,
> > +		__entry->region_id,
> > +		__entry->dpa_start,
> > +		__entry->length,
> > +		__print_hex(__entry->tag, CXL_EXTENT_TAG_LEN),
> 
> %pU maybe?
> https://elixir.bootlin.com/linux/v6.11.2/source/include/ras/ras_event.h#L248
> uses it for the GUIDs in CPER etc.
> 
> I guess it depends on how strongly we want to push John's vision of these
> always being UUIDs! (I'm in favor and here is just formatting a debug print
> so that shouldn't be a problem even for those who want for some odd reason
> to use something else for tags :)

I'm not pushing against the UUID idea any more.  Just forgot this print.

Changed.

Ira


[snip]

