Return-Path: <linux-btrfs+bounces-8866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E0399ADA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 22:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218E51F241D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C10E1D1500;
	Fri, 11 Oct 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFaK/2k7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276521991DB;
	Fri, 11 Oct 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679271; cv=fail; b=p2h1auA9jyiIpuHcvNeJk41Wa0FVUyzwNOvL6DbMK77RSG5I/YvO5kFQYJ9wiuW/OkNk/oY/2aqcxorZTBuBVwZ3Z5xTGN5u7PeQzAO/jSWmYsUC3Ia5SO9GBLJW//VFpEYNP9sGo8UNzpXR32qPNI4Oe50avs+rpLAYR1QYz3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679271; c=relaxed/simple;
	bh=B+f7YjAY68khL67s8m2mkyffEYRPntIoLJmgk8qa0/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qEpssH0jSp4UNZcleXqxIQZGWK8SbtrjJYSxko7yMkqfFmVJUn8LUf9n7xeyN8LLUdSasj+G21NxkbfNxwSe9HcBfspI+qLHeeihJWRRKEBIlL7WRQ3SLD/9vndOGyyKeOhqldbaJIuqrK/EsSShc0VfnbVZYlTE/txV67x+VQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFaK/2k7; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728679269; x=1760215269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B+f7YjAY68khL67s8m2mkyffEYRPntIoLJmgk8qa0/o=;
  b=eFaK/2k7TwHs0muAB6jb7m9wh54B1Ex/Es7X7Q/MFJfUmMBE8hwF2vYD
   yhnn76KEy7+GLREGas1GgRmi59mBQlR3AU3O9KkJmBPoJP1GDOvKqLAIl
   fjHvtOjo7nu0plc6gLj3KeJr+tAzPA9i78muHSxB7idGrqKZQhP8HGIid
   qQaeCYOQxQpP4rSzjXH7VR0qEmJi4CGyyo8QHJ/1/DUKEfdYuzn2QhxP+
   z9XEPFGTkwOVrs+sfpZWMzWju6zNwEmpgCzyDIzJlpTR8NwMv6ZZEjM4c
   QkvHplV3cxEG3coW4vRTB3ru6oNT1GeKncePq/hivBu7h65u7flU6H4hk
   w==;
X-CSE-ConnectionGUID: ksIO/O9RT06G0JofGETEDg==
X-CSE-MsgGUID: h5+g6w9uSkKqitDLDL4DpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39464069"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="39464069"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 13:41:09 -0700
X-CSE-ConnectionGUID: 44s0NX8NSmCbkXgFQeZIXg==
X-CSE-MsgGUID: l5NUQZfBT+qYGEDLP77myQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81015496"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 13:41:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 13:41:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 13:41:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 13:41:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 13:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p071uHw95wQGbZCvvpDnVNqV33nQmBlA63VHwGfjzvrVQm92bvBl4F+N6u0M+kqnusDKe1LA0JuSA0WoaGlSVY69Efcqnp+TPof7b7wxqiG5VybKTsSz1hpgpE2Mk38NwLjN8dJBCHQQMsj+w8Kv/6ItTWU0DuX//w9Fta8V8Prwiq0yckK608/AMdjigMj1A/Gwz5tyzYaGvEokWJWe4/QImKbplLA05vscYTKOKWzCqOEaWHdvcKOhU8ZAM9aQHjsQeAAfH8RQob1hh1TAnJkFt7jNYHlmNd3ZK6yVUFWdjw/HePFpKhojlC9/HfZ74KdrInVrh1w51U03yjnxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/x9OHu+6SLPqsenG705gUINx6cFHEvFEltwULT/qA8=;
 b=heyzyn2MtPeVfQBqlfiNXrMThzdNwUOsZWH7Ti9yeUzlbq1YqYbAsZmLY9aoHTbnGMCNEC1ZsgRwCj5GHn0CO0ShLVG2SHlwe16Ei0QL+626s01/y76oNwGTBj87QCg8DxEu4Aqnlp/PBqbwydG60v+O54JodzGpWBzyYm5CMs1US+XdK0+uMsqEEWSm4Zlbsk+DvI0+STkmmS6jW5VoQkkLB1uNMGKisfwfhNpcQMDLXN7WPZHGaUYFdy93vkpWJUyE6bENFigmYp0/gz6AA7781V28ybB9/WlIZ8NmgSEamhYZFP0cdbvS3jbgHSe73c2sSgUwaZ9qKs8wBvzv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV2PR11MB6071.namprd11.prod.outlook.com (2603:10b6:408:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 20:41:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 20:41:03 +0000
Date: Fri, 11 Oct 2024 15:40:58 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/28] dax: Document dax dev range tuple
Message-ID: <67098d5a946b8_9710f29462@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-5-c261ee6eeded@intel.com>
 <20241009134201.000011b4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241009134201.000011b4@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV2PR11MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: cee8b328-3254-40c8-1ac0-08dcea3505da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hcAB+I8NXIAl5Ew87AEE+D/GAVhff7FzfMIGwGPxELt1XyH+EqVJDT6+H0/3?=
 =?us-ascii?Q?r+nfWJDmYc7TATGaSoZ32D2VuvF3I+qXFrQ9+MuVHo/jMvEEskJwn9AeDj5l?=
 =?us-ascii?Q?swAt36OxIsZGcHdV91AflAMRsRZCMLB/jacV5KFNGjD8sNJNA2wjudBK1oc1?=
 =?us-ascii?Q?rngRy9XsHPUqCDy6lvuvM6HtxIxcMuGTlg/Ncy7Ikq94Gp9IhfCmdtDnvujJ?=
 =?us-ascii?Q?ONIELdinUIAdh5wiT11rDqpE2pB/iDNQUV6mAhEMOfsHQIEl4dXhRqd1IS80?=
 =?us-ascii?Q?jzUiRTjCQU8Ihcm3opWtwbbAfc5qlZXOvPdsHumKFe4QSVo0APYWfSOsOBSe?=
 =?us-ascii?Q?ySWH+GtgjGJ0vX1DBC4uB6njzy8n7fYTNBlP4HElHthnzPuMU39KFCjcn+V9?=
 =?us-ascii?Q?8hYSHvrRGMLy9YridY8jPO7HqmRiz4E9F9frKRQY1L0rkwVxyrsqsepDbJ3p?=
 =?us-ascii?Q?Fi+aSwDn4gZMsq6u0RVwYpJG3b28EhpG5JbjZ9PulMCm+L9SkrhO5QgMML2r?=
 =?us-ascii?Q?i0NPzodu8qYgkLl5dJNYHBYmezDH5dxvDJ4CH8Xw1PHw15FyCuxmXBpwgDct?=
 =?us-ascii?Q?SngStwyULWIoW6U2Nh1Fogfu5MJNEagp0jybdbiAPNSk97PqB43f9Hc5QBRy?=
 =?us-ascii?Q?6oPohKn2LMhs6+T+4byBZfXEjODnLcv7kWbdvvvVYHJdXh7n5bXNXHD9r2Mg?=
 =?us-ascii?Q?getjhe5lkNR5DSESgFUXtN3o3VE2U7D0+ua5h/NmqUHz4UiKCX3zxtOFtIlS?=
 =?us-ascii?Q?Ne94wCW33YYRN5yCpWgKmR0i6gFjZop94g1k9phNMUgooFyhxQAxTN+PPKLA?=
 =?us-ascii?Q?p/u3LIOSCuWgTld/SfOzVFVHkIXey8sCoSZ1M9MwXIC9pfouxCaNO4fZyxFo?=
 =?us-ascii?Q?nK3dJwCpqW+BGYXixfCueb1cManiE6RUvvJzU47JRyT9VrXtDY0soLYBwzri?=
 =?us-ascii?Q?Iw84usy7w0SkChyQHEN37Z4KFKxVzxHIhPFz02LCNXSfmwHYDBmugh2WpBfi?=
 =?us-ascii?Q?kLYZC2TSeaWMWTdfA6BwnTgJtl9SXMrfQamXZ/yijlLnYJlq1HG7pUCPZF/r?=
 =?us-ascii?Q?LMMycoqsRNWWk4v1fzA/G0E9ZcFww2VPdi+qobqeNhITHHZpGaVHK5Mf4yAv?=
 =?us-ascii?Q?HKkUS6qKre8I+l+7vNKGasu2dDKGRE5LUuod1o2XAkJZYSLGi4hr6zTuDGOs?=
 =?us-ascii?Q?MykcpHll8wIhUn9/nsEE2n+/6QjjTqQYdwxGCbL62VIroCteiEyjiO6bDEQY?=
 =?us-ascii?Q?KcE9Ki87r+qalnC+FvdkpO84wvukqypVuC0rSDCbSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HhzPpjoWu86d1wlz/tV0CrPFQs/pvFN09NDStp3WHFIvVI/CJR6whAIeAXoY?=
 =?us-ascii?Q?NNR4A2xbKd/72Q4FcnmMX6pc5/gkcWEKX89VcU4/DrSHQ0Ms6L2dF1QhW4l3?=
 =?us-ascii?Q?LIsXv/5w+WmHIkCEdidgAuTWzJ6uWEKQc5uIq6ayrLO20G/NaBlmTGjMbGWC?=
 =?us-ascii?Q?Uw4Ca/Q/1Esd4XdxE21ZTKX61mSC7pNM1WucIjItNX/G0D/d6k8q9OyA58u+?=
 =?us-ascii?Q?Dw9D/qh7G+6bQ+0D9+ZI985XRQYMB4kDHXXlYq4PdT7dXR7MGUEROKUJSi1y?=
 =?us-ascii?Q?W9a3evldgS4/FLi1OcSYT41ONlzLvS0u+91MpOnQEPDnisC20yWYWsF5umXH?=
 =?us-ascii?Q?u7vwukTCpcXRJ8SCNHD7i5FguKnCmozXpkTud9C1kD3tMJiUiyhkGGWcPvTZ?=
 =?us-ascii?Q?FcRZm1ubB2UnejVtZSEVmX5x0GolQJMRhjjI3T46JhQbA8Pm8ndPkcq7WSkS?=
 =?us-ascii?Q?pzmjdSjd1uPpG40KTOtV9D2CKtuaFjgJYXOFfI7Wiq61OZYn4ZHyXR/OHvqJ?=
 =?us-ascii?Q?pTJthZtZ1b2fNOuOCvj4OIcfHS0soJ5P4zYQwX78nV7pV36/PETDMPDXpw8C?=
 =?us-ascii?Q?UDlEugg1K9MZ3pfalC6geHBp7qaVW7hR9oiLN6kuXmB4mZ9yIPD+Y9yBwo5b?=
 =?us-ascii?Q?G80wGHzb6pp0Uz37AN9fYS4A4aymql0XqhZ8eK/kQmgm4reI/O+32kIoni/8?=
 =?us-ascii?Q?0mwztUbxbs6M0A31DWpQit2gTc43yrlp3pQC/RoUqcqdODa7Acmnq6nSjU7S?=
 =?us-ascii?Q?D7pp7p8P91p7TeD4ipQXs29EdPIs6Tj6TT9OXW0ASeRilTEphyfBQVPotR6L?=
 =?us-ascii?Q?2VNIQvVRPD4H+TGbWS4huguBepJpnUQRTTDE3gqk2KKWUqA7OcCQ+hwt/KgB?=
 =?us-ascii?Q?9ju1lMErjqNZej+VlqSnRBm952LmQFtEVmAd0l+2D/Miio730/fgr66OyI03?=
 =?us-ascii?Q?2MCUJolAP2BUoaUweOr/YKW+fFSpDHWx5LP6bYGD5yBMzha9gKHatOliOQPI?=
 =?us-ascii?Q?i+pPTtSJWGNYkMsgiEVE97DDWsNzl7jA4p6N/8E4Sq/hhQjkV618hcOY5IlX?=
 =?us-ascii?Q?5Wtlkbh6sKLbXs1SqvTm5byCuG9ryqwrCADu7Q6kpaDTG0bUX5E2xkNpPG5f?=
 =?us-ascii?Q?BNZhD4Fj9j0UYlkZbszMDbyA8vV2JsF5h7G6yYUbYSJwK/734wS2Zn2taykU?=
 =?us-ascii?Q?zT8oKx+JOYRNqjPRuXRE4Ta7a3fTksYUjf2Y6oy4Z7+Rwbhr0Grwy1cW2yE7?=
 =?us-ascii?Q?bI1QyowpeP2QFrJ+34Rez5SNRoVYeMNIFRNv5q9pSqQsHXRrCN41CticsZU7?=
 =?us-ascii?Q?mKbHSMjWmC3jayJ46poAySa41QswHlv+TlWHUSQpoWhy0j/IcWP8BDREVfWk?=
 =?us-ascii?Q?1wxdCMHYjBX7/Bs4+B/NgRxAJeYsC3Ig7Po4nnauwrasW5un77+byaEVaZfz?=
 =?us-ascii?Q?YlQBdoiV9SE5WO1o2mC2Akpks8jz74kUTNVAi0s0lLR6NCFqJTzrpHQGbzj/?=
 =?us-ascii?Q?OIDR/C2A59yGe646RBLuKwokDBTRxyHjbR7OwWWqQgfD//chhexayT3Zg2a7?=
 =?us-ascii?Q?PyHoi8nBunXUb/1wJqQliKnq1y2HfjkuF+PagnLI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cee8b328-3254-40c8-1ac0-08dcea3505da
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:41:03.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkARHZmZeP76zmj4o4qKg6zqk2r3nnaz26wrcoQtdT3tB4tOvC0PYw2OmmCcEqGpZnsHKwwgCLkDXFbvhDMQtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6071
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:11 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The device DAX structure is being enhanced to track additional DCD
> > information.
> > 
> > The current range tuple was not fully documented.  Document it prior to
> > adding information for DC.
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Isn't this a nested struct?
> https://docs.kernel.org/doc-guide/kernel-doc.html#nested-structs-unions
> 
> I'm not quite sure how we document when it's a nested pointer to a
> a structure.  Is it the same as for a 'normal' nested struct?

In this case I think it best to document the struct and just document the
reference.  See below.

>   
> > ---
> > Changes:
> > [iweiny: move to start of series]
> > ---
> >  drivers/dax/dax-private.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index 446617b73aea..ccde98c3d4e2 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> > @@ -58,7 +58,10 @@ struct dax_mapping {
> >   * @dev - device core
> >   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> >   * @nr_range: size of @ranges
> > - * @ranges: resource-span + pgoff tuples for the instance
> > + * @ranges: range tuples of memory used
> > + * @pgoff: page offset
>       @ranges.pgoff?
> etc

Ok yea.

As for the pointer to a structure.  I think the best thing to do is simply
document that structure.

Something like this building on this patch:


diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index ccde98c3d4e2..b9816c933575 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -40,6 +40,12 @@ struct dax_region {
        struct device *youngest;
 };
 
+/**
+ * struct dax_mapping - device to display mapping range attributes
+ * @dev: device representing this range
+ * @range_id: index within dev_dax ranges array
+ * @id: ida of this mapping
+ */
 struct dax_mapping {
        struct device dev;
        int range_id;
@@ -59,9 +65,9 @@ struct dax_mapping {
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
  * @ranges: range tuples of memory used
- * @pgoff: page offset
- * @range: resource-span
- * @mapping: device to assist in interrogating the range layout
+ * @ranges.pgoff: page offset
+ * @ranges.range: resource-span
+ * @ranges.mapping: reference to the dax_mapping for this range
  */
 struct dev_dax {
        struct dax_region *region;

