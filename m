Return-Path: <linux-btrfs+bounces-4537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39138B118C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE072873E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6459116D9A7;
	Wed, 24 Apr 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr4dl6qy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4613C672;
	Wed, 24 Apr 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981514; cv=fail; b=cCSYsGHvMLjaMEXXpzKYlAFZF8/5IWFPTW7YLYGfhA+hToUdiqTgXtewL3c097BCTYwvKBqDN5rwkfNlgWkh+5cPHxCmtiPpxdAQ8oF3ogNkGn6Jg4Fwl94Dl53dc3XWFcpScHtp4k985qBe4QrD1Rvj3HD77TXMNdyorzRaFP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981514; c=relaxed/simple;
	bh=P+Erg4LH0Vg2qrU0d1FpFUswEqIoIHv6e3JS6TpxwWw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HVsf6e+JPgwZ6E0czCEpfm/zD7w4Z8sfsf19KAhaFbdn6qWZ94LSy0CESqw8rojoDQiko62I+fZKo+xzXzKqa2cIQtDHsoD/PcmBwIL7Klt1UAsyfbha6QbGtJcYD0I0FK7qd4vyEazA2OJI3ZqYio6LF3DqRZiTy4RVKVF7wMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr4dl6qy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713981514; x=1745517514;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P+Erg4LH0Vg2qrU0d1FpFUswEqIoIHv6e3JS6TpxwWw=;
  b=Qr4dl6qyr1+ZbFzTGdlsai7kibv6ZoKbabSliEDAodtLFwpZ6sc4LGdq
   qEcZi3rXqyLS73lZIGLZufwEXk+NjEpqTrw1oJ4Frirpu1892fT/RaMda
   H9vkFekJ+FBMq0S3FZ6qjWyJbY+Z6oIAhQO7WmmzKZxNLu1//i6h5WYZG
   JjUUedxrl92dl38Ne2ezE6W7a9I4XTK2omXLym7hhsA6oZw1inmh51BZ2
   /72o5X6BH0YyvZMcvAQPSBVUfKCt2SqyeZXwu2nPJYU2VqRm2pWljLBIO
   gEoEZK5yPrluu39K51I79HRgQ9CbbgDTm1BKfLyqdbxa4MZ4ph2iZusTf
   Q==;
X-CSE-ConnectionGUID: 0YrhtA8DR62sKOXXxbdH5g==
X-CSE-MsgGUID: MP0L0K0xT6yO0lLRpmjRIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9752653"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9752653"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:58:33 -0700
X-CSE-ConnectionGUID: J4Yo+lPCQo243EpiIF9E/A==
X-CSE-MsgGUID: Q+yrf/nWRL6Bz1L8SrkUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24748867"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 10:58:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 10:58:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFwONPaAi1Fyhd00PhvseXbh5mUiBxt1dus13l3sGIWbnicd5MBN0/KHskB41imZnJ9mvCazl42aEp5ztN/nlBHzVsaYs63+5EQSnDswya+6ZyVyLoSjvQQtwb3f46NBqWnBGmVK6fWdQkE4r0JzSp/zYIqXXsV9fNSMKJIDdZDAHZeVWAzqYXo5pNv7sZySZeiKFsowwf5+3cz14wRb74RzeV9cvb2nfVUqxGF394sivhqbT9dJ7If0O/Bd7jUqucsTdGdM4xz2wbfcUqI1UpuyM4vuEcrRB6TKr9HEegjC4hsjDSkIpSHjq+BlnkQ1hKd+WmKrLPHMxXHEv7N5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lm7+3++QTpF1kw2F5oMhiRW60CI4UcrMzJ6tuIoYFg=;
 b=WonojiF2vAW6xUFht7ThR3kPielzC/9ktjnlPsbyvINtS8TZ8rjv3/WBjMDar4JBQ0dw375jNEjgAKx3BsH/J4A01eUwzM5zUGuZD9+kcOicUHBt6o+EqtedjTrmWgk2kn07hTnRAU/SXuKX0s6C1O87hiyL/Hp5oak5HCm9ZwuZqGzTG/K+yJulkmH7EYtPYOIK0q+YrJlnyUIlH4V6oJlVwHPuFRkFJWw9Q0CbED+y3MhiSV/pf2uGNGhDYLVfRz4Q8MtVjr6zBWnUS6rlT/PA9jBS3MUQWLwPpEbtiDGxgOUjjSl8fh/zBqlMbAY0gxOWL7h8Bmj0kLNev2rHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 17:58:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 17:58:28 +0000
Date: Wed, 24 Apr 2024 10:58:25 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
CC: Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <66294841a62a9_e1f58294e8@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
 <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
 <6604fe9e18eeb_20890294a1@iweiny-mobl.notmuch>
 <b6ff085c-8cdc-4867-83fd-9566d59d5946@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6ff085c-8cdc-4867-83fd-9566d59d5946@intel.com>
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: 506a4262-20da-4177-10b3-08dc64882500
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7MSxJHkqLtHpotPhCbzLENYw3yox52I0bSvhkErSmWAMEUHr6A64nKnXdoG3?=
 =?us-ascii?Q?NCNCsXW56/L9hIBQ3w5Hx53uOyxeLe/k7o9nvEZzzb3bq/1qabiphaZZfydR?=
 =?us-ascii?Q?Omzh2xusv/91DQoawqGK7OFLW0uKQgt6AQsrN9BXp1iZnvorxIhP50vMxvP/?=
 =?us-ascii?Q?jTOrTo1sKMO1tTffmwry6No6bnPeVxPEb14r4h0pD4Lgs4qW3148/tesUoBe?=
 =?us-ascii?Q?qFH6qjejTMpX1H3AYdR8N9f0bbKmnYQt73aRJf6/MzeIrHdsVuVQWvrikEZB?=
 =?us-ascii?Q?nCLLVVyHsCQQd9kUgxSO37eXXwHnGCdsHEXtNgdLCwhg6hMtdDFTXi9/zwA9?=
 =?us-ascii?Q?8/xReROGhZRUl2sXfaYHIH0IrXNbTpNLnGmXTTJHWUK+i2z4OvUW9D3MHNJe?=
 =?us-ascii?Q?Pv+BQB6aAo9ByoCrnY3tBN/qsK/bWrPwqVRnjjdJ4oPu0aoGQvyfo8vpUjs9?=
 =?us-ascii?Q?bfZTT41I9RZhJEgHV3az2V5bNYN4RB9mbKFrs1GASobr+oSaau/ZFwfhUqKE?=
 =?us-ascii?Q?NyB0k9UG+gJ42MF8FAVSFGLrg2z/xE/a2wyJHFUuqFHLietiRhb2bfLIJFnU?=
 =?us-ascii?Q?G5FFw/a6Hhd4Y+9mz9umuzdhKjxOMgS/MjpjjbeIoHeHwxyYWqh/3fmXkBDu?=
 =?us-ascii?Q?gyjgiKFWye0JV1tFfoM7OhPTrkG47E02PMcqzN4KA+WW9MEKwAzQ197QvTNB?=
 =?us-ascii?Q?pDqkoomJzgTevvTcL3fv2kJn1F60cnSQJVb87pqduWoI79dku+ikP3kkXuj9?=
 =?us-ascii?Q?ejBYnvRc4HnQSUUmPsuZX6pMEYUkIUDsO82W5V8n3pNPt1XmRp9RMLVmY8WS?=
 =?us-ascii?Q?7K8n8iYHwXPwsMAPkbJ2UTF+vSkpChPRUN2spXTyt279d9z623lbbeU0iJKx?=
 =?us-ascii?Q?zshlAX/uDusnsZLNF3q4CmV5wXzUMLyJFQnZYWsn3pVRvjl2qzybOKWTFF+Y?=
 =?us-ascii?Q?uevR4XzbQp1kByuDmIbqrHgOPl9Zjl20QUtgizRY0KxbSzuWg+iw5q6dGEE8?=
 =?us-ascii?Q?TZVCdg9Pvx9wYbXuonMuKjRdOolzfwAK2JCQZ89Z1rGaOmgxIBfdLucN52il?=
 =?us-ascii?Q?JQfjn4whIcaD1Ww6OzCU0ZYS9O1Dr3uc1YkHy1x1MQnf5sMgjJ0LS5YNQcMI?=
 =?us-ascii?Q?1iPXqH6lHT46q773mqiAuWjthCPXI1VaEhvQP7fbrZx2CnnDf2v9QmA3N1Uh?=
 =?us-ascii?Q?rUSc8wJKkIu2DGyxoODiW2AWcHYQaDAn/KpF1eBOP/HB06ODfPRsFxt8d6Bf?=
 =?us-ascii?Q?8hVoOZX95lIXvW+tEyMMykf9jOj0fc0MwY6tdoqTjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tp4OJ2NztcGD9d1o7EWdRSZL03WTm4bR3wYFkip3e4FGmNG4enYZluiT5wG5?=
 =?us-ascii?Q?8JYYPrAKTOyoqvWg9CLWrDgk1fR/jvbwIJxzYhP/2GpkDQSORR2j+6PwtAhF?=
 =?us-ascii?Q?IkaP7StXN2x+Z+V4dqbolRyhSSe8MdNSqk2+Gg/zxbDscK+xbMPrbeGI/x9C?=
 =?us-ascii?Q?DOjGTEG4NT5jMt9q6UAttbWTK0d5n5SiNE7KVwFGpmCHUyRlld6Rh83fngeL?=
 =?us-ascii?Q?i2EA+mQf4BmHsWXV/2NNHRKERNA89EpxiSZW5JlcRpe2kZfUmfSslwQ4tTwp?=
 =?us-ascii?Q?/pE/BiyyGhp/VbmgzK9vta8zUxU9sW+G+flwfP4IDT8wkJX3ByVMz+UBWYXv?=
 =?us-ascii?Q?1xCeYAqJZCS2U8IVbiqa1EWwt4W5sQW/kOe+NE31FTecnNMNrsECSdX2/iWP?=
 =?us-ascii?Q?gDOyDgDok6zPq5/yS8j1nWn9t8ELc+Br0u/XY3YdVzfvaNuM6pxxak+oy22A?=
 =?us-ascii?Q?wVIiWTXyIckRN3nQrCaGB28w5RFEEEy6JjTiFpbQRWQqnxoSVvcYs5GoGENN?=
 =?us-ascii?Q?+g1bmFDTSbD52RKScUvGJjsKsd96sbikyC+x3nA1Q16WS/aBujaD1UghRPsc?=
 =?us-ascii?Q?ioAYjcto8x609PljDrhZgA/4SjEvUMESDXUDb9t1c0LepZFLGWVOQ9EkSyyO?=
 =?us-ascii?Q?xqDAEdjetMl69hK+z3Yz5s6I9YLdAvEIUbjFTInjMaPoOzmNtgE8nJbKNOcr?=
 =?us-ascii?Q?43KqZOpEIRsNp8ncrt+EohTmls77uESh8vA6gP1nVkvqA08ydQa69I4PM66d?=
 =?us-ascii?Q?ctYaOlRs986Y2OyqjKGskHuxACTdGBJea36vvVlWGMppTsQ/t/RcjdvvkzQR?=
 =?us-ascii?Q?YT8h+jF/Wzle0yuYi7Yl6kqJPnbRhc2gkzwzeciWzOKqN7Y+2v868NUkuR6o?=
 =?us-ascii?Q?tXYbQbNedlX6BeZKSmQfHczg40EX5hINhce4lMNPu5XTyE9quHIZxr9vGN9P?=
 =?us-ascii?Q?D/FcLjbOM0nf3jc10i/SANSARupa9QNvSg/kLIvf0AM9LR1apUuAFGaZOy4y?=
 =?us-ascii?Q?GvHsbOUVUv2oj37vMHhIXULmZGvYIlw58TqiY/c4ulzujRb4xG4POf1UfhUE?=
 =?us-ascii?Q?Ru6jTKwS32PtzX7uS4Wx5dhuodm9YzSMDAMRBb60NIKjiOP6FMeb0VLLdfqL?=
 =?us-ascii?Q?OyU0Dh0WKmgDKFAmhev3SOZTcmz6xzJQ5Nn3KtnscR0F7oI2HXSQvGKcOsp1?=
 =?us-ascii?Q?cTTTaTR8jmk01P42Bv7EKNyuK7KzrUvsSx76qQ/ZQlGDWZR7wp1givNZ7EN4?=
 =?us-ascii?Q?yCual5xXR/KXhHJWxToR6xgI++E8GogbB5S43RjtCfD0TCCxB/b/ZPqoyV7x?=
 =?us-ascii?Q?jwhaPrqwRX8I0geoOQ3eq23SK00OB7jfziX9wu2rYfimCo5838PXYrNM/zgp?=
 =?us-ascii?Q?uu742SyzptbuC3Z8siMOiuwMGfCOoEZ+hWhzaa0nQ2A6nwdXpAyu8kknQEXj?=
 =?us-ascii?Q?QPe4M7dVXHs/rTWtrZ7M29wo0hhdxMlrBhJ2/cmGkb8sBzYAypDkg5CroO8A?=
 =?us-ascii?Q?DdcJpnb8OgG845iekWba3Jo1CvjFjZNhsEwaj8o5o4jXSa4UAEf+B3qNM+rp?=
 =?us-ascii?Q?YUM5jyvkslWR9tN3FUIrF4+BpO6rV+rR7ySGl0ba?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 506a4262-20da-4177-10b3-08dc64882500
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 17:58:28.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bp827Xu2jmlFT+E2Z2WDOHjVi8TBEqJeOEZQB293SLNjAbWHcSaIwhQJR+CvAEEfsR8bLy9zYu10PGOOW+TwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/27/24 10:22 PM, Ira Weiny wrote:
> > Davidlohr Bueso wrote:
> >> On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
> >>
> >>> From: Navneet Singh <navneet.singh@intel.com>
> >>>
> >>> Until now region modes and decoder modes were equivalent in that they
> >>> were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
> >>> regions (which will represent an array of device regions [better named
> >>> partitions] the index of which could be different on different
> >>> interleaved devices), the mode of an endpoint decoder and a region will
> >>> no longer be equivalent.
> >>>
> >>> Define a new region mode enumeration and adjust the code for it.
> >>
> >> Could this could also be picked up regardless of dcd?
> > 
> > It could but there is no need for it without DCD.
> > 
> > I will work on re-ordering the cleanups if Dave will agree to take them
> > early.
> 
> There's no reason for the change unless it comes with DCD right? And probably no urgent need to taking it ahead then?

No I don't think so.
Ira

> > 
> > Ira



