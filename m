Return-Path: <linux-btrfs+bounces-10962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B7A100EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 07:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC21C167A41
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DD1C1AB4;
	Tue, 14 Jan 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeOmmTTw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AC23D3CE;
	Tue, 14 Jan 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736837146; cv=fail; b=qhkbWHWemXTUfWc1HDIqnnqZm+HJETFgYafc0GFjVn2DXrIYXekb/oCnq1a+vTqYptWz9zOISkdbKHgUyuooAJla8FiiIV2gH1wjOC1kNGadWzeXuyxMEvOwheVV6ODi83KOoDFhkhia+ZUbULB1HxH5U/FfuaJUeC4GfxN1m+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736837146; c=relaxed/simple;
	bh=G3Z3jM9u2oXxP94TQc0+kwrXYOY2jXkccdOojDPJUOE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IkdImBqyJE90L69zZtr7tmvhzF3md5RGLGSRhqNODbmtFLxfUiweXdMgxiev8G7yf3EmALtdQD5I1q4viDPgrJrQj25RYgPSdooFiEGm3cru3mozK6uX4G7vf+v18wZEJn6GiHgBtTAIAOBuDP0Mn8ztEeYoPe8hGiBxzZpqpz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeOmmTTw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736837145; x=1768373145;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=G3Z3jM9u2oXxP94TQc0+kwrXYOY2jXkccdOojDPJUOE=;
  b=FeOmmTTwBaJyURWjv3OVNJ08rh3RQsVOn1vOFLJu7pw++lTOwv7kyPAL
   ubAZxoSmBOg/u8Dnb1KybrcKpA6dgmIJh8tst8pXMuG6ZYSX1NUp3d/S9
   TGg7c8GeOp6vs1jADAH0r4WnuhSkFDiwgfKNFgMzFBVppgyNnzWAtAybK
   a20dv/z6VcpJjKDzqWVIdblN7ggjHKfQVNViAgD/eSRR7z7ZdftS6fvFB
   wOeJLEpM7a2E6CEjhTnRgw+cNoPaNmc+emY7/SFDzy2Go8gEQZqzziA9R
   X/kLvUo4l3SHqB+3HipXqrU+mDWnY9jgAXzJA1wv4GAPmJRDKJq0I2YzR
   g==;
X-CSE-ConnectionGUID: wHbYb0FQTa2CES77rarUcw==
X-CSE-MsgGUID: u7OR2SmzQ3mXzWmo0oNaxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37233446"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37233446"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 22:45:42 -0800
X-CSE-ConnectionGUID: LSdR8CPjRWWkmzgF1UQhTA==
X-CSE-MsgGUID: ehaGWJjISWOe/BzvXlQXxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104534137"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 22:45:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 22:45:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 22:45:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 22:45:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biLbtOqR3UtDeHSPXzuCm31PmZcqN/F8Hp0BC/TvGoEtCFlbwNhnz3/iTT80rZsT5FJE36MEETSPcO9w9/qkeUjcdHg0y6e6IrvqoKM5xcTjjEUeVTebqc9W/kvbOFvlKwpqP687JLE+/SCG1p7HTlWWjREovEM4ZWVn8wjQ3TdjQG4yV4WPh9SUbTGy7z8wYNA9G2VSsLyhY82HWiCbAR2w8NTd4bl19KW4ETipP4eHofnaJ8nZq2lGF54PQ1EXx+p7hsueRX2oTkeFJwktjTvRsbTYrsTRoiFnXG2ea2Ha1vua6J/ge2oOl4R/U5otxrgKYQ2c3j5iyn23iISzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRxyI4SossMXe+zkrYLhCHKbzviLDtXQCHUfUn9e5/A=;
 b=EVIR7m94lPr/4Sjxlp07BlA3jz4az2+4CgIHmc+uJ9aN93UpLmzcfzNZtA+o5D66xfb+xUpjbQSTJhnCCW+jYtKwkSwzd2QZAtqFaPpB7gQsJx4X/evMUr9bmFeByXJtKxJG3w1su1Us1RKIdFigLT/bKyQAkXlcDdUp4X7IraK/2KXnfetpUKalPmX43/lTqe38IFxCPUhAXgyMRlHD4JCVBaGR9E0yJrMNWUtxsDBRTLu02fyKBIWknwb3kD0H1BE/jqnczet3QgAO6ZkL9mYBPWuJuc9U24+7Ntu6HR1VCA4QV2yNL1XJ2k3PZ8ce1xNHRf4g9NEOcTdVQ2VGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 06:45:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 06:45:33 +0000
Date: Tue, 14 Jan 2025 14:45:22 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-nvme@lists.infradead.org>, Damien Le Moal <dlemoal@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-aio@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z4YIAqonpBNuB9nJ@xsang-OptiPlex-9020>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
 <Z35VVvuT0nl0iDfd@ryzen>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z35VVvuT0nl0iDfd@ryzen>
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdcceab-7894-47b4-e9c1-08dd34670b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?xoBS0kVUlqZFprjhBGz+1Ylbqd03uVDaj5rLyKDXVbu3eS6rrSWT45oHED?=
 =?iso-8859-1?Q?EMdGGq8Dgd2tq83knH5KRlUYmdbrKAbtzPOZ2Be4InTd3AnGOJOc4cUZAN?=
 =?iso-8859-1?Q?c5HiCSKgSYBOpIZ8voyQF/9bAP97I3P2n7nJzUGqrQ3VhdPtQChbBUItPT?=
 =?iso-8859-1?Q?X3D3pXkONKYdB17oZ2MYO2zagOKVLT1yjZFO+2GcabOHGbm+QZCoDjfN2i?=
 =?iso-8859-1?Q?85jMMxe/FLihKKe3RNSyjOZGJm2umpxY5ot0rUd7h9tBFSv/X34we7X861?=
 =?iso-8859-1?Q?1+T/JJ2+puZsZBF/pfpwJrfCkZjZWOrNxWmcS5fmXzIcuANERTBNAQbTon?=
 =?iso-8859-1?Q?8TJLbLqyFFp96Qf+xh/viacNnImfnkhgWwqYJRD6Ja28s6DQv9hHU7NPG4?=
 =?iso-8859-1?Q?pyv5zARZTRytw0C5qgkoJzZhdUrkx22utK8eWByCRQvCa0GNGp7y+4CNM5?=
 =?iso-8859-1?Q?ZsZcFZCL+W5Aj6UODy9WzIdlhbHyXZ7+9J7NGzYc5MJ8E8I2DEtvDuVNvR?=
 =?iso-8859-1?Q?EY9h0cVcbqHbfXDpRN7e/Qn+ZleVqhpXI+8mhgIynPLPD/AKtdBTz5+/C3?=
 =?iso-8859-1?Q?R8lfD1ywrBNcPB9RmnKe52afsGNnCfsmIdXCJmH24ukpDQ8Ul3wI0C8Eng?=
 =?iso-8859-1?Q?z+F63hFBkeV8bu2U/2czUs6tAKV80d3IPMUDowQzQ5eheWIiHoejhox79R?=
 =?iso-8859-1?Q?0ps8u+QCsc88w12GqvjjXbK/837guN+g2zKooYQskqMv3efsPkpE5XKtQW?=
 =?iso-8859-1?Q?GFty2aWiZmiJgvGvAfmHhIjmwju7upKidASYIJKt8yb9f3K/jY75US9sXB?=
 =?iso-8859-1?Q?7MsVG86Y+YT68YLFp6WkTxiNZkSKj3MTGkAzMqEGAX1aop2yFoJPvXK+FC?=
 =?iso-8859-1?Q?6IW29roWKB6qfw/sSNHbBs3em3iXM/LEzHgTYwk5JqIHLViwN2L7YDPhHK?=
 =?iso-8859-1?Q?4oc9o2cq3mhSxsxYuw9PXmorEAPjbJcywN+TMweyjKOf0bm3TUP7XYRSaT?=
 =?iso-8859-1?Q?+y/nRnLB40XaW+fHZHaCkfvXhm96CRCKn/7anhr91Y2EK2oOj6b+s5ILz4?=
 =?iso-8859-1?Q?/kdfBQ4NsBhnBz/jcwqvuKl8gPjMMuRL94hWonzXJveRp7bKsoLMGLWZ3a?=
 =?iso-8859-1?Q?rtbMMgRDQPUn8U8NPqfeevMSctq164PdfjTcMJYzAXZb4DuoolDfSHZZ+f?=
 =?iso-8859-1?Q?qUtLjIoTN9+SaGGJz56kUumj1w2cMBSb6UCrvxiPoy1Ze/P1ftv5lSQvfD?=
 =?iso-8859-1?Q?02yLVXKRzzMbCpJ09oCAMg2HFKDqaPTCEWTTFvn0+u5ThyXYcp3gie5tzL?=
 =?iso-8859-1?Q?uR2oGM3PRgG7qRD3KlQRWpKt0n58ekbpmDTA7F0wmHe267fo6NxEXZFqMv?=
 =?iso-8859-1?Q?uheynAjW9UxnWQwWxZQWgs/17rODkdzVj0c7v0MQxCuAF4sxDYPpqzaE4c?=
 =?iso-8859-1?Q?5eL/FVCATrEBt9i/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YED/rtmlwVcFAZ2uXGEfPF7xWiQk8mi4chWlsEbCjY0j0lXbce7gTChE0j?=
 =?iso-8859-1?Q?I7GVG9C42o+jC89arEFKxG6Idh8S9eu49vkZn2chtm2ROO4KMo9fdVmKpC?=
 =?iso-8859-1?Q?CwnPlEs/9gfNkmI/+uJnrvX0F0FgdFJqStT53RpD4zt2QngC4oiQzuywY3?=
 =?iso-8859-1?Q?yi7E43x/V2+Nc877Z+BxoxqlbZsA3oG6X/7xMdgFVhMAbiVEPiCYiI30YA?=
 =?iso-8859-1?Q?47oF3G74dzhSheMKAYm6LIEHNUZjpAYDbFWalZ9STIu5u+wfN0YhHa3HSR?=
 =?iso-8859-1?Q?QP94N0ByccixTMrv07lt8d7J36LHnJvLvdA/We5TGOuZlGWKVfIajS6JI+?=
 =?iso-8859-1?Q?Ogd/Tkubfp7eH3uz+03F2ssCbaCy0RQb7GRkI3kaY5YzbEF/Dgbc5+8HIF?=
 =?iso-8859-1?Q?SeLuuR2DWmDX0q5ucfuDcTXPLZ+209iVxgosLj0ORGgifWF03RhN3i7aF9?=
 =?iso-8859-1?Q?5dd/BOUXPD+T78GT6VEd2DjIpbsH/95yK5qt2N42/2eRJlrPV3MhS9xCXf?=
 =?iso-8859-1?Q?XBavBewKkyB52YKbUx851U89xGWvBuGFBAfMOMezkonHzwO6N8l8SuL/Ad?=
 =?iso-8859-1?Q?XbtqH2YuhDCHpcz/CcvlPEX/P7O5/CpOxRhBeF7l23H55BnSC5AJMWJPqo?=
 =?iso-8859-1?Q?Tfs6Mkn1t1SVwO4p29ijPndSOpBy6nUqXfJxRe+WYBtxs6898IWeXVmUZM?=
 =?iso-8859-1?Q?QE9+yZqmSiA/sc7dFfhXXLZh7+GNa3H4QtrRqOgXK4eeolaV83rnQLmFnJ?=
 =?iso-8859-1?Q?wGutDDC+tdCoQUKXVjbpmY9LihmhzhqATbr4qVGz+NZAj6LC1GzmrRH2ad?=
 =?iso-8859-1?Q?y1LMVexligEZkjFCZwqJpBK9VsSMqzQLrh27xvOM0gSZU5PmqrQwViSHCu?=
 =?iso-8859-1?Q?WBGY7La4QAOsxHq+H7FLJ0A9Uukq2rYsJucaQ1g2r+J2hHn2Ozo1ipvT4M?=
 =?iso-8859-1?Q?EdglosfLJABQXyj8jmXJcj2aRS6tuxTl8pQ1F2XNyh1X9/ZoaVLwOroJek?=
 =?iso-8859-1?Q?KjyQO1PaqzdSvh9K/geDQKsShbaALtfTWWXI4WXPJp7jHLoFSzXuzS0ZJK?=
 =?iso-8859-1?Q?xKJt6dkppdY/ARjevxf2Co8wMOtvcMv+xxefPlkmlTFFrWK4WjFiQGajRN?=
 =?iso-8859-1?Q?NEqBRAwy+vOO61LyP5d5fb4SH4zWbNc/rBG6gG97ZoY2Qr7xbzo3YaBEpG?=
 =?iso-8859-1?Q?sJC1chhuNvcVXjxE1ZiTo1RYOqot1Hh7uGYl7oFw1AY5ZAXNv7UAtjKm3p?=
 =?iso-8859-1?Q?jbNoXqbn0avISWnMqQypsW93rHL33ETN73Ao79Fic3fDGsVgG9fpicW0rg?=
 =?iso-8859-1?Q?fGr+gCYdPIlLEU39YxbAtweeB+aK8lwnDAZe1KLi7jHnYyk6bFMpO3mq/S?=
 =?iso-8859-1?Q?T+OPctLv67mo7rv8QENf4CgWDG7LcJJqph7ww5+pRkmxORq6+Hl6qUWcHV?=
 =?iso-8859-1?Q?QdcIFZH/lOc67rxOzWBtwlxHBKzJqmSVBjVix2pK3b2nowS4+bJkMvuXha?=
 =?iso-8859-1?Q?AUDUyqN5nY0/ifRowhCdKbBCSh6Kzd4TQ7GJprXDfnvxecwzfb6XRnR2Sy?=
 =?iso-8859-1?Q?uoGpUPsaAXtzdL56wqDNYDtO64/ftow3ULpR1beyR68EXj/gNsVGlnk/ov?=
 =?iso-8859-1?Q?jZj2YwEpTrnyfapH7T/V9fuzszUWkomyDlGggq7yKHdIFnlZqWxK7L5A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdcceab-7894-47b4-e9c1-08dd34670b5f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 06:45:33.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyBaGB0ve7OzszMPf8SFp0rn+GvaQtf1iS7+YiI+nvh3PUJzSj6KexMM2wTcYnzE1NuSj4wBkOlwmx9Kp5FlgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

hi, Niklas,

On Wed, Jan 08, 2025 at 11:39:28AM +0100, Niklas Cassel wrote:
> On Tue, Jan 07, 2025 at 04:27:44PM +0800, Oliver Sang wrote:
> > hi, Niklas,
> > 
> > On Fri, Jan 03, 2025 at 10:09:14AM +0100, Niklas Cassel wrote:
> > > On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> > > > On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > > > > please let us know. thanks a lot!
> > > > > > 
> > > > > > Yes, this looks like ahci.  Thanks a lot!
> > > > > 
> > > > > Did this ever get resolved?
> > > > > 
> > > > > I haven't seen a patch that seems to address this.
> > > > > 
> > > > > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > > > > reordering when issuing a batch of commands, my guess is that the problem
> > > > > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > > > > or block layer.
> > > > 
> > > > I started looking into this before the holidays.  blktrace shows perfectly
> > > > sequential writes without any reordering using ahci, directly on the
> > > > block device or using xfs and btrfs when using dd.  I also started
> > > > looking into what the test does and got as far as checking out the
> > > > stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> > > > submission does simple reads and writes using increasing offsets.
> > > > So if the test result isn't a fluke either the aio code does some
> > > > weird reordering or btrfs does.
> > > > 
> > > > Oliver, did the test also show any interesting results on non-btrfs
> > > > setups?
> > > > 
> > > 
> > > One thing that came to mind.
> > > Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
> > > the I/O scheduler to BFQ for single-queue HDDs.
> > > 
> > > It could very well be the I/O scheduler that reorders.
> > > 
> > > Oliver, which I/O scheduler are you using?
> > > $ cat /sys/block/sdb/queue/scheduler 
> > > none mq-deadline kyber [bfq]
> > 
> > while our test running:
> > 
> > # cat /sys/block/sdb/queue/scheduler
> > none [mq-deadline] kyber bfq
> 
> The stddev numbers you showed is all over the place, so are we certain
> if this is a regression caused by commit e70c301faece ("block:
> don't reorder requests in blk_add_rq_to_plug") ?
> 
> Do you know if the stddev has such big variation for this test even before
> the commit?
> 
> 
> If it is not too much to ask... It might be interesting to know if we see
> a regression when comparing before/after e70c301faece with scheduler none
> instead of mq-deadline.

we also finished the test for scheduler none, run v6.12-rc4, before/after
e70c301faece 15 times for each. it seems the data is not stable enough under
scheduler none, only can say there is a regression trend if comparing
e70c301faece to its parent.

=========================================================================================
compiler/cpufreq_governor/debug-setup/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/none-scheduler/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/aiol/stress-ng/60s

commit:
  v6.12-rc4
  a3396b9999 ("block: add a rq_list type")
  e70c301fae ("block: don't reorder requests in blk_add_rq_to_plug")

       v6.12-rc4 a3396b99990d8b4e5797e7b16fd e70c301faece15b618e54b613b1
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    114.62 ± 19%      -1.9%     112.49 ± 17%     -32.4%      77.47 ± 21%  stress-ng.aiol.ops_per_sec


raw data is as below:

v6.12-rc4/matrix.json:  "stress-ng.aiol.ops_per_sec": [
v6.12-rc4/matrix.json-    108.03,
v6.12-rc4/matrix.json-    108.4,
v6.12-rc4/matrix.json-    109.11,
v6.12-rc4/matrix.json-    109.58,
v6.12-rc4/matrix.json-    194.21,
v6.12-rc4/matrix.json-    111.53,
v6.12-rc4/matrix.json-    107.99,
v6.12-rc4/matrix.json-    115.29,
v6.12-rc4/matrix.json-    105.75,
v6.12-rc4/matrix.json-    113.62,
v6.12-rc4/matrix.json-    96.51,
v6.12-rc4/matrix.json-    110.53,
v6.12-rc4/matrix.json-    108.71,
v6.12-rc4/matrix.json-    98.06,
v6.12-rc4/matrix.json-    121.95
v6.12-rc4/matrix.json-  ],


a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json:  "stress-ng.aiol.ops_per_sec": [
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    116.65,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    106.51,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    119.23,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    108.91,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    111.79,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    111.81,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    114.94,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    99.49,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    106.13,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    124.99,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    174.15,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    92.65,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    113.05,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    75.97,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    111.05
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-  ],


e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json:  "stress-ng.aiol.ops_per_sec": [
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    85.2,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    72.6,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    73.49,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    69.03,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    66.9,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    90.24,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    66.88,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    71.53,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    56.86,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    63.49,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    97.99,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    69.28,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    58.52,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    114.23,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    105.79
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-  ],


since not sure if it's valuable, I didn't list the full comparison table here.
if you want it, please let us know. thanks!

> 
> 
> Kind regards,
> Niklas
> 

