Return-Path: <linux-btrfs+bounces-4762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7658BC663
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 06:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D3FB2147C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 04:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F29446AC;
	Mon,  6 May 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxW81hud"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1233E462;
	Mon,  6 May 2024 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968373; cv=fail; b=E928EcYDvvCM49RHtYcQJ20gojAvs25/VVyxmOioLuYSX1K/Gb9UwIg75Jjh6DqfAo3QPUT1XDctp1wv8e7Tz1fy9SUwb01fsT91PdH7/CrixtFoNvlNVXudqYMTkDxy4VCjihly2v7RC6JaQw2KoiREzMCAgrXozkQwq16nUQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968373; c=relaxed/simple;
	bh=IN2sN9BXUcn9P2D/XOYHIPnVHAXkbXNosX3zQDUrbkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QA5XulD1AyB7x0ui3hd4FY1JRtfbgbPKdLayq4oZbIvzQWHxYlMZoJaGLcurEvmtRn5iE5psQc+hsSp6x95qjhe78cjMKdzeY+oIGifZKBr4C3rEjJ1bgH3w/aAUO78a3HIE6sxeTC38Eoyy/pYYpqhn7kYW6lyEXWZL5EiHhRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxW81hud; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714968371; x=1746504371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IN2sN9BXUcn9P2D/XOYHIPnVHAXkbXNosX3zQDUrbkc=;
  b=BxW81hudSAUovziyYSLphHMJgMiBy23O+5+C/Gsw2h+8zS009O6qPLoi
   KZqzcEPGwx+/HDddtUCQfZjKAUKv7D+L9Uqtim0mW+6fcEO033PKZumqI
   xPVOjIjZrVIqERjduxlZZ1JBMlxJkKIOFymyrISO5qp4a9DVUqB+vGdza
   fhllwNiH4C7UYV0nrQSUyJMVuh8dfEEO8K5sA+7dm7NL7agyBIVWRn3NW
   +JZkdpvj+ZriCL0/2+lKzkE2Gl2PoD1aoeOqqaBNw+kUXE5CDWmqJJ0xH
   7Ho7tkJXgTuat0UuDPkgWPZEK73gHQpO3TUzLpW0zZ0azpIH2XL4C+QAx
   g==;
X-CSE-ConnectionGUID: Vi5Om9xzSRO63vE59vfKFQ==
X-CSE-MsgGUID: /mqDMMJrRTK9CsiD77HPsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21376851"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="21376851"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 21:06:10 -0700
X-CSE-ConnectionGUID: IqvpCk/MQ6KQAG0rxM2oLA==
X-CSE-MsgGUID: qjlWm6prS7CZWHjNpnbZuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28122299"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 21:06:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 21:06:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 21:06:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 21:06:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 21:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP6ZOIIL4q0kXHJn4Yxrz2mp9NyeTCTm+kFbIZljwnAdW9WyZKt1F6QW8QEiJRt5myIMYx6ZQnxwTCEeRh3GRGk/0xtAdr1gF275+Qc+TzhF1yWCllxQgOD/WWUkggpGgDKPXdcj3tbnfXOeKA6/54LL00QRzvTrd4KTsXFrtNjri5QCytqY8OvHredvTtD499U6u/YPqLX4qNGOJlKV1emukWLA/687DT7rrme94PO602RitO3Y40WPXd+e4vrVgnrJDBjs1rauQsXustQ6TwIeVLXyiEyYw9Ie2PqhBrsfL3Zz/SfeN8kD8AIM+yuwrCfk38ESTDxuTO8/k4c0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfA+nK7jzD7qPTq/Cl0O4qpYq+Zx2M8NKR1sefNscz4=;
 b=JLq0Xw3fHA3DyK1Q5oK4XXvuHkdv6Oi1vRczTibK5kYT47X8wkVR4aXPVFjynVQ82QNdaiiprhHhAx5oY20q5+3RGAFdjj+X0Z1jZUMImnrElaTtKaYhbHYS5SMUz9ZfhK5UOZqq/nhm6clHswNjzKwZ5JSuPBFUgnwvNzOOKwY7ETqoPiRF3u4ZIl/GIauEfzsciNndW/hYOA5HZ89MYc0XOr5GemluqfAqMcBGbwEwJj09IO7SscfiEUAzxgPHsn7Db5ztOxspQxpTdlf7kSx6ZrdkSVnZdBCYN5X1aCIrQS1urlMP/czRILd1kyCPBH5okFoYPZUxcfQ5oUz/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 04:06:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 04:06:05 +0000
Date: Sun, 5 May 2024 21:06:02 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <6638572a2afd_258421294e0@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <ZhSPHvoTHl28GXt1@aschofie-mobl2>
 <6635366717079_e1f582941d@iweiny-mobl.notmuch>
 <66358d2dab5f9_1aefb294f1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66358d2dab5f9_1aefb294f1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 46845077-e973-4adb-3b50-08dc6d81d9c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dHe56Oxrh+GJVqQ0AOa5gqcBBfbaMFB7T1EOpn4LdkEp+NPPNWJK+rvFAVuQ?=
 =?us-ascii?Q?yOwf9CujElJRNSezrgsmBI58AtJz4zd7XuYJVzSa3MpPk/iBTNbv29MvFyet?=
 =?us-ascii?Q?sCgapWptCAgBQgpislWRBhiBUl0AHsyIyR90ibqty7tLtoW2npemnuGD109q?=
 =?us-ascii?Q?QHYprYfZ6/Y1zjsii449MabFT3jlZ66bAttEx6gwLywu4c0sXhaHy83GjHxs?=
 =?us-ascii?Q?kVw+gQYQrJ18q6rtX2t7/cSoKU8N3i6uK1nt/IODEjK40sB5s2EozIwZRS5z?=
 =?us-ascii?Q?Ge532AHdE67dEp6Ua/sF18s28C7px1lYi3zU+C9K6FAjVFxP/TLetvU+QBBI?=
 =?us-ascii?Q?vbZgKxHw5rzDTkFhwc1HiihMCkK34toy1KmLfiXMzfsxdA/noE1MGbSENZK0?=
 =?us-ascii?Q?t6mQxMJ5Veb3XpjXhGYja5e3umCq6/MzB1Lb74M+RmTveFX/h+qpCJ1dsZWm?=
 =?us-ascii?Q?Qk1QqUCLisyTOX0OfGuEtrpaV7IP5DY5Vvl1ZGI2Yxe6RFiJ4ePS/hR/13Hb?=
 =?us-ascii?Q?dOUjM/Cx96jm/oT4j57IuCnIhPzA8iMxHcSf76fvDtlptOX1E0D7P4KJRMIZ?=
 =?us-ascii?Q?tc4tSMjFYGWgjr2ROxjlkkYn6oaU8IgVmU0lIOrTjLD6/U4v9Kpy96hG8IQe?=
 =?us-ascii?Q?/hQizOx9MiUZPQ7D6APk0looEPNiGRZ/VzL3AQW+waD5oALYzxvEUn8PTrfe?=
 =?us-ascii?Q?GYnxGO/3XiVeIeUyLo2vLaIZw985pWwAN0r+ZHNT1iFUFsxt0dns1mFdPoRL?=
 =?us-ascii?Q?MQgCff3nV5b8e8olEsyYTZlkQHDEeeO1csh7BKG0eECMf8hM65MAhqLwbeg6?=
 =?us-ascii?Q?5CWDJVAJS9+Qk471UMrPX2ps2K/F7k6ATKQfeEAaWNACDYRA7FhxD9a5sk+7?=
 =?us-ascii?Q?ZPNXV0lSWFYCivBKOxhV9acw5Q47hbnMTbG4JvQWoC02egDsCjevDczuKBjm?=
 =?us-ascii?Q?b+17kbYxcnrkjNtc7nnBwUMv2wK1LfoFhsBmaOwW/T0OvO1hC2XEUpZNfYMa?=
 =?us-ascii?Q?JilhDcWkjLKFoPCzIgyMJ+ZLG+QCFA43d7DBQsb5MjkguXaeXzW4N7Id7tgP?=
 =?us-ascii?Q?KRMYO6KqZzxgY35Mup1lV6ga1u33jiwqaHgSpfpULez1r0l3z6FDXmA632TS?=
 =?us-ascii?Q?72a72mKLhAWez46OWpdpONn7IehtZM6ZCi3bj/tSmL8LjmFd6ehuuXVRmIk3?=
 =?us-ascii?Q?pZm5D98OOOTrAyY3gPY0mHihz/R271SybklQc9wmyjI4JEY0jeCnjY4iIK2O?=
 =?us-ascii?Q?sBzaeY3qXjRE9PFqa6ZBAMiqYKNhiAdfbUUt0EWhzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqyWkye/BJ5Cx50R8vUvYC6UkTxhnplxyrfRBAx7m9lN/KHTn/kmn5+N7rMO?=
 =?us-ascii?Q?zVi6z6rozC3jalx8uxUXDR5//0BjAhZTp/yLRDDts35iz5ZI3uK1P8RavkBz?=
 =?us-ascii?Q?HEgRHmizQ79eyk9E4P/oSXnUIEOCHaPcdbavEIkMvI0gafwvBGsDHw87lpBq?=
 =?us-ascii?Q?Zr7VLmT0CKwUctx3nTa+h2MFoHCMNAqtWsWNjliVbjYR0YQ9rre0DiNRknQC?=
 =?us-ascii?Q?96pKdwVFxXXXVZ+eFOTxD4MlBNDFEQJPLIRL1UbckAblC9164JsxE8g0qyZo?=
 =?us-ascii?Q?9djGSWST6W0eP5oxtRTfeFytuS+UG5FzWyJYKaZ+RERIrTLtWJKgFyOHNRHm?=
 =?us-ascii?Q?y7wqtagfYBfd8gIq0T3fRb8Df7/6BZTg6L4UWJel8BnDmiIDAHJjyDN/9M66?=
 =?us-ascii?Q?iGGiP5OFOEYf6XdFV708nwFjrJduUy+wI5OX5n2pyGvduonGxucPrhOqybZl?=
 =?us-ascii?Q?XON3lVymzVPiORsDsAeJKTv18iwRBTadjC5rIyzWSHSnoINAGwwaa6fGFzVp?=
 =?us-ascii?Q?DfVaXXEl2TUKtd7zhkEWcntU0lkmqgufmtjMkBN/RSEfDwxhqn9hIjZ9ps1D?=
 =?us-ascii?Q?X/9JlDQ5l/9RD8NlWS8lhODoUsXYWnjjzA/V4qzHmXGQMahAzKTVc2YM22ev?=
 =?us-ascii?Q?Gfx9cmG18mdeEGXL7XJsli6y1fNumeuSH6jhJ34CRrVuRerSbHmmcl1PK4NK?=
 =?us-ascii?Q?RDJxnu/g6vrLe9GqTQ5ILAL4/9kt1EezO+PcbsxC1ir+ZDhS/Il+SCMWhW0l?=
 =?us-ascii?Q?8v0Qn+DytXVwpzfrKZZkH8qJgv0qo+IJ8pdBjV0YcnNfPZCccRfPaZHUf++D?=
 =?us-ascii?Q?r35T3bIOHDQ59j1NdlU9RAvsePE+l2xEsA3NDcKfSNEgCfMaFcZbk8InSstd?=
 =?us-ascii?Q?9NrEJ5LoZMCQjp4Pm9M+LBbd1w8z+62e0U2usE5cgZmDVe8AnNfqaN2/Hrxd?=
 =?us-ascii?Q?Xwv75TEEhbgTC8ZuIgN8g5EM+ymxoIIEJwJPGZAPaj3GbgWB6MEb8V66bmrW?=
 =?us-ascii?Q?cbm0a2hrIuxnftD3RP3zUOQjRWVNFPP5iASeBFZztxK6/ln065suSXFIh/P3?=
 =?us-ascii?Q?XuT6qRZNMhmPRjsOL4jd/Xg/F2Bdxh6XT/rFsfQIffqry91IyMfE6ByOfcPh?=
 =?us-ascii?Q?/SsT1z/asW1DTUFLNKJr2AqVpc1siKUtaOpTR/S7scGYZHu8rzwt47buCmxC?=
 =?us-ascii?Q?wKCkaxmDzfYoTIZcG+uNKULiXAO664uoakSQFA7pYLLPNSOrRae/mCNr97mZ?=
 =?us-ascii?Q?ZuCOkvL8SoA83N76C7Oycrahvsx2EjR7Gpnvit74LwsaU3egveriptnbthqE?=
 =?us-ascii?Q?m6s+YQJVaAqSLze1oNfhn7HKcRrQUqS99W5AoWMrBoZdGffuNH/tfFQGUI1x?=
 =?us-ascii?Q?xawl/z8sMxj52Jny03LS8ECwq2Uu/oMWBUzNrTxo9Lp/ZXeoMnNYCzpNc1PV?=
 =?us-ascii?Q?MTwjUGbxYlQJUKPOvgL0y3MIWb82sffwIm+wO77iE6Of4OPNA72I8RUQgcW0?=
 =?us-ascii?Q?TaFh3B4WRIGhoLmiG4nodWrwLn/XWBncLz49lPd0rOY69CEqtarsENE8dYPc?=
 =?us-ascii?Q?ED2wsVwGH4otTlJAT2OYpi6h5TQJL44wTqgywGDA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46845077-e973-4adb-3b50-08dc6d81d9c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 04:06:05.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW7RiQGCX7tiqEXXROHq8ntY5SSmUs7QycMd4mrwG/+mfYTckNJsRxWkrPMdlCcNazWZ+AIWX27nPZkx5dNczA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Alison Schofield wrote:
> > > On Sun, Mar 24, 2024 at 04:18:08PM -0700, Ira Weiny wrote:
> > > > cxl_dpa_set_mode() checks the mode for validity two times, once outside
> > > > of the DPA RW semaphore and again within.
> > > 
> > > Not true.
> > 
> > Sorry for not being clear.  It does check the mode 2x but not for
> > validity.  I'll clarify.
> > 
> > > It only checks mode once before the lock. It checks for
> > > capacity after the lock. If it didn't check mode before the lock,
> > > then unsupported modes would fall through.
> > 
> > But we can check the mode 1 time and either check the size or fail.
> > 
> > > 
> > > > The function is not in a critical path.
> > > 
> > > Implying what here?  OK to check twice (even though it wasn't)
> > > or OK to expand scope of locking.
> > 
> > Implying that checking the mode outside the lock is not required.
> 
> The @mode check outside the lock is there to taking the lock when not
> necessary because the passed in mode is already bogus.

Sorry I meant to say 'is required'.

> 
> The lock is about making sure the write of cxled->mode relative to the
> state of the dpa partitions is an atomic check-and-set.
> 
> So this makes the function unconditionally take the lock when it might
> be bogus to do so. The value of reorganizing this is questionable.

Why would it be bogus?  I don't see that.  Regardless I dropped the patch as it
is not worth spending more time on.  There are bigger issues to resolve with
this series.

Ira

