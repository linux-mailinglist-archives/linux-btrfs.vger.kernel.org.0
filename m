Return-Path: <linux-btrfs+bounces-9985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627B9DF130
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29C31623A7
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01319DF4D;
	Sat, 30 Nov 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtxAnuA8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E922066;
	Sat, 30 Nov 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977405; cv=fail; b=YkXrDdZjZdj19dUgspgpo04T/EciESbeS5KUcf/cxspWNWDJkUQd0A0IY0Lu9+RPUNlzcrU/oLlNnYRpAEydTX57LP+I7cif26fhWpwOXfDBXfG2agBo0zrYzpyZYUfPaDwODQWQc6bgC6jpIsW1jsnGOeHDZB/ZVR4xTXcxAIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977405; c=relaxed/simple;
	bh=Eg2iDbQvKY87s85t1RRt0bCDmobBPg32mGqMeLH0Zgc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IgO/KeB+ssyYXUAto9BwJnRjA1gakns4VskBdYB4wjQMeeZ4BNICeWi43mtQ4nkgzyx/dkN6hF1eJgvrsbFBYqyAmTui9atGbsb4zjW+/BNxATjBGgq+ie6S8Wp/Odpg8tAIm3QiekW3H9zXPhYL/JHLfegyFe+h4I8sPLNEzeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtxAnuA8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732977402; x=1764513402;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Eg2iDbQvKY87s85t1RRt0bCDmobBPg32mGqMeLH0Zgc=;
  b=gtxAnuA84wiM8h8r4MmBSdNuBmD/PQFL9S9qYWIVw1VCbGrW48OsZOnK
   /WcDcKvGieWkmI4lf7HLymqb8fFQHiPCE350dzwxdp1ekkSC23IH63hUJ
   ovZTLLh+Q7wiakSgendWd5mm5sUiQfDJKFEoAuWrpS/DXbiplr+ON2P3G
   iMNSpyEMhXXWsIYBTq81L3EyglqttVPRnCRZoUsxfT8I0mEAFz6cHhcvd
   H97tQ/ufqCkXSrLb/Q8VQmEmvIgWvaecdizY/f/xLlav+tiiSa++YncDR
   pLe+GvoSVC6Kgt+bWeownaAmOfYmRvn+yF3UjSr4LuAQMRzJ7N1uD1Ql9
   g==;
X-CSE-ConnectionGUID: kpLy8sD2RXe+fLHkMCF/Xw==
X-CSE-MsgGUID: aIufAWhVQEa/tJV8Seswzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33045151"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="33045151"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 06:36:41 -0800
X-CSE-ConnectionGUID: hmHxnYhaTT+LaP4q+xuZjw==
X-CSE-MsgGUID: gz6hiu7MQc+dEZYT7lpV3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="93524167"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2024 06:35:19 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 30 Nov 2024 06:35:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 30 Nov 2024 06:35:18 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 30 Nov 2024 06:35:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsbSAqTlFyZ6ffj+fGieeJ3UtdQqFeu4wyC/AOtrYBL85qtX34ZxhRrHwMT0qygaclK1PXHsT8e8I8nhAL0HAn4Fc4V8AzurGaAIV7cHMAWWeUCbm+tlrGjcbwgf6/aSafbn50JLfbmpoLCKQLacB29VKew2gF633mccgsD69QtC6+2eqz+ZyyAXNeZ3Rdypzem/UY2KqzplYWEE1dgWR5AosOe+52okGhHKBWJFzR5GktNgQmcABOpaUqLeR787Chh6Rt8ZZNj5Fl5b62CcZ/aFfyVLEcO01UZH1rROuXL6Jrh1i3y77yTWx49sDTNpSdRywhWsicb3rQzo5N/o4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaxYA6pxCvJkaLCMcomLQn7Nll89+wOOZBWuWEvCssI=;
 b=bldgSkJBslGpp/uX0D1J5+BYIsf6L4i3LOoNIcwMtTgOgJCFK1o+bdVAHlhe9Bi3n8y3PJXNC9gQxsy8N6GM2NpLUMUEIeiImaEISbuBVpnDjhlhvPDygNwlKEcuxmBn2nlpicKmRhX5ECd9fbGZiIiN/RWsacuge5yFWMiaFduLWWdxYfdl4u2O+LhwFmDLt7VlD3L748x+0hlZ1fgthAd8MRZtFEQ3FaP/HmuOihjWLDFfee1n9mgBeXC3Nv/uIBYa40+TwnpweQOpUut7rLNvULL49tEzopD8L0uEUJneHQri8kOKVwDxqyZGm8rT7liDi4eFpqv8nYJGXfgL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:35:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 14:35:08 +0000
Date: Sat, 30 Nov 2024 22:34:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  c87c299776:  iozone.average_KBps 18.5%
 regression
Message-ID: <202411302252.67284087-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 531c51f9-ffc3-49b9-4546-08dd114c3056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?68z+PO5otCOvnL9U9gyJdxm6Fzyl6jyWdTYhXSoiMXqyM+u3chotwNcOKL?=
 =?iso-8859-1?Q?sMA/b1U8AbHQJur9ValSuvKYBySpNSNzKeyqmbP39Yr5h60nnl0gS27tos?=
 =?iso-8859-1?Q?afYw50Rn9Ay7vZ8MHN9Tzxs3HgzXOI2AH6wB8h5r/oxrvBeVjOD+QVm1g7?=
 =?iso-8859-1?Q?7/ZdZXquWPq9CH9hIeFytpUoCuLCGFr6VjsXiBtZdGdqeca0LDfBu22+Dj?=
 =?iso-8859-1?Q?WJe4/3H2S/E/+7c13ehb4vw9dCx8kBYZYOtbEtzN+KmlQVj1bG8mvWeTBh?=
 =?iso-8859-1?Q?sdVy7egT0WCPKV2HJHA10174ZyJ0tawi6GJ6pZ3FV7txzAwrzW14WBP3Ye?=
 =?iso-8859-1?Q?kJ7Bine+4Deor5NDwfyu4t0xWp6NdkvVW4MjkW0LalnaJWtndpPaIGGRmu?=
 =?iso-8859-1?Q?zjnS+DLjs+sjXWCT02ivWrVrnBVHfNh8fotHVsnoDYYs5aohV+dffwbipq?=
 =?iso-8859-1?Q?SP7a/4JYSV5tet5OtSIBMSNZAtJcO07Pn+SHGhJpUBhMdocoJTxqGgOibT?=
 =?iso-8859-1?Q?Ly632J1Vy141YHTbwG19uLn+gUhf2Pnd4NzUX/8WohOdN8+qhqBoN2k8Cx?=
 =?iso-8859-1?Q?BRAHpE79T/6F3yRKWWqpogPSLKAGalhqKKjcYhSNunJkjjmwhV+Qyz2FCR?=
 =?iso-8859-1?Q?u/zI/SKJtaoy2LL4i1cEjSku/PPg+KaV0G3d+jkN0Zc4CXaWVhwYgVs+3Y?=
 =?iso-8859-1?Q?mCD3BbZwCRJ5TLqvnukBxAjOel376z5N7kYM2EkjS973koM4jz+j3mIlyU?=
 =?iso-8859-1?Q?+gJNeF7QXKxh+tgT+WMVRgWjEBzbA+s6X4/Ev+AFoxSzteL9FVpLO51AW5?=
 =?iso-8859-1?Q?NECHvgWnnONGeJ7w3rftGGurMr45626p6X2NUr7WnBTkowmxbZUrM66S0V?=
 =?iso-8859-1?Q?dK448ZRvevAIrQbbdoq8teVDc0eevJnbwdb7GHspuhVmZi9FtZuwy5H1Mv?=
 =?iso-8859-1?Q?e+5z0Ua58DbDP75e7wDwXVdAnidJWv7RV2JQ43FzvXTvW9CdJIQgx+GLnb?=
 =?iso-8859-1?Q?Wkn8sgyW1qDICVGGonLfNlHaXvMyUlKSoi9JuGYy7G/wZHGxNNNYENLx9/?=
 =?iso-8859-1?Q?eoNVVZ03B8+Nj+rqRfFpFYbVZZVTMEXAT6Tf0/d3ia316o0pa4vA9gbyrw?=
 =?iso-8859-1?Q?foV22bXv1CtgODLUx1Cdlk9kwWqrs75AVOcHCw0Xk4xgMWkAreyFiHMEXY?=
 =?iso-8859-1?Q?SWRWZkgg8lVlZwnLntykLgRXw+dmvN3ODUfuu0f/YLtckgJa3x4LIFHhm4?=
 =?iso-8859-1?Q?d9MIR4YpPpPvPHdZa4db3CFtYVu10vpvV1B2pUrBvwzVMydDO0YXOHCguK?=
 =?iso-8859-1?Q?DFqwVbQxj86YzfELZFpnRpgrtp1jO78qlGn2r9Z3NMa6d3SGFjrEFRP28q?=
 =?iso-8859-1?Q?/PJnUTcpEL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8p/TZ6lSJDkFcVKip72EnskxqVj88Q7dR1nJ9KbkDe+1YV6LERbiKdTQzR?=
 =?iso-8859-1?Q?nAh4dpgDEP/FoOk2SLNRlHKm5pbccIKijksDsNKiZqcu/qCC4cxLDgf++w?=
 =?iso-8859-1?Q?5OA5fmgdOXoWIZ7SWghoTyXKxVYUbc+jJfq27cwbSgF3yOaCmynl1SvK6T?=
 =?iso-8859-1?Q?IYjzTxw1k/C1DGDYgzMZueKDOULPA8eXeeh6KuI/JJgmHpk/2iGamiCnYq?=
 =?iso-8859-1?Q?fhwY6pCfAWsGaxMzKrORJGLmYs1edr8OYMB3WagFFo5TeHekBLP3BGbXWP?=
 =?iso-8859-1?Q?/8X0p+GAAPgPH5wORcEHxu+fs5lVV0z0qe+WVqUuInmX8k+GZwir4fYnWJ?=
 =?iso-8859-1?Q?+1Qis+558wwpdvtthYgwoCvW31NUH1OdxXMQrsRNesBenY9q1eL6Y7x94x?=
 =?iso-8859-1?Q?9oo/OOLb5od1Nf3UWi4BX1pkzXA8HSpJm0tF527NMKwDNjkK4BQn+r4Ghs?=
 =?iso-8859-1?Q?/tmeIbsSnrnaXQd1gylfcLm6Zmyg0UFkAeCIfP06WHq4UK/Sp0Pvof73Vb?=
 =?iso-8859-1?Q?qusR29bIn6XthHCFErCZDmltA+TXNFOjNDtuwyrT/vzcsP8yUeNYwvGhJi?=
 =?iso-8859-1?Q?1o4cK8Mw3M85waGwtoX9TJ5/QxgtzhrfR6XIZmNidqJq2TPCI2amaY+6LW?=
 =?iso-8859-1?Q?ld33FaB/TE6dK8Wg4WsSEwLNc6YhwrphSr9gpK+QIUQTiBvmrJC4t8wFY+?=
 =?iso-8859-1?Q?Jcj3ViNwJ1wYCFvdlvc4hE5Yh2y/mvCRxJAamHhewu3HBd/M49NPwkb8w9?=
 =?iso-8859-1?Q?yvUw2MsGzHdRCDECFimvjC7Ab5NXDqe67yKaMFTtXWvYL0DYy76z3dkF2a?=
 =?iso-8859-1?Q?sdq98ucJXRTRTGzHpyADNYtR8bbEEYP2fYJdedRrOL7yeWWOGjY2jX7ywz?=
 =?iso-8859-1?Q?3H/qGOBMWtSkJSC5Ru/xgvbxcbhLIc8F1J2xOhAe+pGMujCtmTCfliaGso?=
 =?iso-8859-1?Q?hOcoI7y+JBYrL0HWsvxAUhIQmU3j96iIcLLtlVqqKTlnr/gp1ZUrq+rYS5?=
 =?iso-8859-1?Q?UR25uL2z4B9k36Oe/sETk9i4lt3Qr9rBsjR46Cntj/9rKvMhoaQjzZz3Hh?=
 =?iso-8859-1?Q?tG1zB/yrMnW63wJg46OjZOtuDVCfs3Z3NYV5LMHJId5d2r5KkmNmAz3e04?=
 =?iso-8859-1?Q?dmlHd5C13pZToJC/TblVezJr5OVq3Ykpso2u5Jn0DFJp0gouyyHzpciS6A?=
 =?iso-8859-1?Q?syW2TgOayyotER98ZOLdvn1FxenIk+wneYTkFvUGN6XJzN76DRsmeJaOch?=
 =?iso-8859-1?Q?kMxg6X7uzPkhdxStxfNJN6jFy9d+qvUgPbRSHNGidR6qUYJNy+NVAwm8xS?=
 =?iso-8859-1?Q?LdmroDG3FIsiV6Er3jFoB/gf3+eqL98JIwHqo1fTrRYHRvjbZwe0SynqXP?=
 =?iso-8859-1?Q?hgYHdOrSsxhhosJ9w0C/H5sV58QgdOdlFbcyGqdqyQ+HfPOVqDz2aZxL4p?=
 =?iso-8859-1?Q?uFQdnXsJpV88WdhV72SvSwX2VPXBoYG1mMZ6jYCFOzF4bYJH1d5U6Iz/fa?=
 =?iso-8859-1?Q?+wQb0UFosHU+diHd/u/oOL9HYooBiCTTVtufPhLrx+Mz8g79ISojT+11q8?=
 =?iso-8859-1?Q?Nqja/ol8ErNZS7+bSaL+58QUIWmC/OTfokIXUj0zj7EreHN9NZLZtcb48W?=
 =?iso-8859-1?Q?Dc8AdRElxf4zxraAZQfaV8LHieqs6SUyyrwqc+IzmshiTM4Rg4XVeh2Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 531c51f9-ffc3-49b9-4546-08dd114c3056
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:35:08.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG6M98pqPZjqlxav7PqKBsSnGuZI8tNekKHtBSj4Jo5q5N0w/QYoBC1ihD0hxkOA3Fw/04v/buU/YQ/yGK4YIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 18.5% regression of iozone.average_KBps on:


commit: c87c299776e4d75bcc5559203ae2c37dc0396d80 ("btrfs: make buffered write to copy one page a time")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      2ba9f676d0a2e408aef14d679984c26373bf37b7]
[still regression on linux-next/master f486c8aa16b8172f63bddc70116a0c897a7f3f02]

testcase: iozone
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
parameters:

	disk: 2HDD
	fs: btrfs
	iosched: kyber
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411302252.67284087-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241130/202411302252.67284087-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/iosched/kconfig/rootfs/tbox_group/testcase:
  gcc-12/performance/2HDD/btrfs/kyber/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-kbl-d01/iozone

commit: 
  b1c5f6eda2 ("btrfs: fix wrong sizeof in btrfs_do_encoded_write()")
  c87c299776 ("btrfs: make buffered write to copy one page a time")

b1c5f6eda2d024c1 c87c299776e4d75bcc5559203ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.05 ±  3%      +0.3        1.35        mpstat.cpu.all.sys%
      0.39 ± 10%     +17.3%       0.46 ± 11%  sched_debug.cfs_rq:/.h_nr_running.avg
     23.55            -1.2%      23.26        iostat.cpu.iowait
      1.23 ±  3%     +23.8%       1.52        iostat.cpu.system
      0.03 ±  5%     +16.8%       0.04 ± 12%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 32%     -88.8%       0.00 ±173%  perf-sched.sch_delay.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
      0.04 ± 24%     -84.4%       0.01 ±191%  perf-sched.sch_delay.max.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     24.46 ± 45%     -71.5%       6.97 ±144%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.sync_inodes_sb
     12.63 ± 83%     -99.7%       0.04 ±217%  perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     18.59 ± 72%     -99.7%       0.05 ±218%  perf-sched.wait_time.max.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     40.90           -26.7%      30.00        perf-stat.i.MPKI
  94960381           +25.6%  1.193e+08        perf-stat.i.branch-instructions
      1.67            -0.2        1.47        perf-stat.i.branch-miss-rate%
      1.49 ±  2%     -11.9%       1.31        perf-stat.i.cpi
 6.076e+08 ±  2%     +14.4%  6.953e+08        perf-stat.i.cpu-cycles
 4.902e+08           +28.1%   6.28e+08        perf-stat.i.instructions
      0.73 ±  2%     +11.0%       0.81        perf-stat.i.ipc
      0.06 ± 11%     -22.9%       0.05 ± 14%  perf-stat.i.metric.K/sec
     35.24 ± 44%     +38.6%      48.83        perf-stat.overall.cycles-between-cache-misses
      0.67 ± 44%     +33.8%       0.90        perf-stat.overall.ipc
  78962447 ± 44%     +50.8%  1.191e+08        perf-stat.ps.branch-instructions
 5.036e+08 ± 44%     +37.9%  6.945e+08        perf-stat.ps.cpu-cycles
 4.076e+08 ± 44%     +53.9%  6.272e+08        perf-stat.ps.instructions
 2.992e+11 ± 44%     +56.0%  4.667e+11        perf-stat.total.instructions
      0.28 ±100%      +0.6        0.86 ± 31%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.00            +0.7        0.69 ± 13%  perf-profile.calltrace.cycles-pp.__set_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter
      0.00            +0.7        0.72 ± 13%  perf-profile.calltrace.cycles-pp.__lock_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +0.7        0.72 ± 11%  perf-profile.calltrace.cycles-pp.filemap_dirty_folio.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +0.8        0.83 ± 15%  perf-profile.calltrace.cycles-pp.__set_extent_bit.set_extent_bit.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter
      0.36 ±100%      +0.8        1.19 ± 21%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.00            +0.8        0.84 ± 14%  perf-profile.calltrace.cycles-pp.set_extent_bit.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.00            +1.1        1.10 ± 20%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.prepare_one_page.btrfs_buffered_write.btrfs_do_write_iter
      0.00            +1.1        1.12 ± 21%  perf-profile.calltrace.cycles-pp.pagecache_get_page.prepare_one_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +1.2        1.25 ± 19%  perf-profile.calltrace.cycles-pp.prepare_one_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      9.26 ± 16%      +2.6       11.81 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      9.01 ± 16%      +2.6       11.59 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.84 ± 15%      +2.6       11.45 ±  9%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.92 ± 16%      +2.6       11.55 ±  9%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.60 ± 16%      +2.7       11.26 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.7        2.66 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      8.50 ± 15%      +2.7       11.19 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
     25.33 ± 45%      +7.9       33.20 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.18 ±  7%      -1.0        7.13 ±  8%  perf-profile.children.cycles-pp.do_writepages
      7.96 ±  7%      -0.9        7.02 ±  8%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      7.96 ±  7%      -0.9        7.02 ±  8%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      0.80 ± 11%      -0.2        0.58 ± 12%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.54 ± 13%      -0.2        0.35 ± 27%  perf-profile.children.cycles-pp.find_lock_delalloc_range
      0.52 ± 16%      -0.1        0.38 ± 16%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.72 ± 12%      -0.1        0.60 ± 15%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.19 ± 24%      -0.1        0.11 ± 45%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.14 ± 33%      -0.1        0.08 ± 31%  perf-profile.children.cycles-pp.xas_set_mark
      0.02 ±141%      +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.do_dentry_open
      0.02 ±141%      +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.vfs_open
      0.02 ±143%      +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.11 ± 67%      +0.1        0.25 ± 13%  perf-profile.children.cycles-pp.slab_show
      0.05 ±107%      +0.1        0.18 ± 46%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.08 ± 57%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.seq_printf
      0.10 ± 76%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.vsnprintf
      0.10 ± 57%      +0.2        0.25 ± 14%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.30 ± 18%      +0.2        0.46 ± 26%  perf-profile.children.cycles-pp.kmem_cache_free
      0.13 ± 53%      +0.2        0.30 ± 20%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.11 ± 32%      +0.2        0.30 ± 34%  perf-profile.children.cycles-pp.free_extent_state
      0.00            +0.2        0.19 ± 41%  perf-profile.children.cycles-pp.btrfs_drop_page
      0.12 ± 54%      +0.2        0.31 ± 31%  perf-profile.children.cycles-pp.btrfs_delalloc_release_extents
      0.16 ± 57%      +0.2        0.37 ± 35%  perf-profile.children.cycles-pp.set_state_bits
      0.09 ± 72%      +0.2        0.32 ± 30%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.19 ± 52%      +0.3        0.45 ± 40%  perf-profile.children.cycles-pp.__reserve_bytes
      0.08 ± 95%      +0.3        0.34 ± 28%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.40 ± 25%      +0.4        0.77 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.37 ± 55%      +0.4        0.73 ± 24%  perf-profile.children.cycles-pp.clear_state_bit
      0.36 ± 37%      +0.4        0.78 ± 12%  perf-profile.children.cycles-pp.alloc_extent_state
      0.27 ± 51%      +0.5        0.72 ± 14%  perf-profile.children.cycles-pp.__lock_extent
      0.40 ± 50%      +0.5        0.88 ± 30%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.38 ± 49%      +0.5        0.87 ± 16%  perf-profile.children.cycles-pp.set_extent_bit
      0.35 ± 46%      +0.6        0.92 ±  9%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      1.17 ± 20%      +0.6        1.79 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
      0.64 ± 46%      +0.9        1.54 ± 11%  perf-profile.children.cycles-pp.__set_extent_bit
      1.05 ± 42%      +0.9        1.96 ± 19%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.00            +1.2        1.25 ± 19%  perf-profile.children.cycles-pp.prepare_one_page
      8.87 ± 15%      +2.6       11.47 ±  9%  perf-profile.children.cycles-pp.vfs_write
      8.96 ± 15%      +2.6       11.57 ±  9%  perf-profile.children.cycles-pp.ksys_write
      8.60 ± 16%      +2.7       11.27 ±  9%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      0.00            +2.7        2.70 ± 16%  perf-profile.children.cycles-pp.btrfs_dirty_page
      8.52 ± 15%      +2.7       11.23 ±  9%  perf-profile.children.cycles-pp.btrfs_buffered_write
     25.45 ± 45%      +7.8       33.20 ±  6%  perf-profile.children.cycles-pp.intel_idle_ibrs
      0.13 ± 36%      -0.1        0.08 ± 31%  perf-profile.self.cycles-pp.xas_set_mark
      0.13 ± 56%      +0.2        0.28 ±  8%  perf-profile.self.cycles-pp.btrfs_delalloc_reserve_metadata
      0.10 ± 30%      +0.2        0.28 ± 32%  perf-profile.self.cycles-pp.free_extent_state
      0.28 ± 40%      +0.3        0.60 ± 13%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      1.01 ± 22%      +0.5        1.49 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock
     25.42 ± 45%      +7.8       33.20 ±  6%  perf-profile.self.cycles-pp.intel_idle_ibrs
    404026 ±  8%     -20.1%     322736 ±  5%  iozone.1024KB_1024reclen
   5779343 ±  8%     -46.0%    3120020 ±  4%  iozone.1024KB_1024reclen.frewrite
   5520470 ±  8%     -47.4%    2902678 ±  8%  iozone.1024KB_1024reclen.fwrite
   7595960 ± 23%     -60.3%    3018802 ±  5%  iozone.1024KB_1024reclen.random_write
   7268453 ± 15%     -56.1%    3187394 ± 10%  iozone.1024KB_1024reclen.record_rewrite
   6148488 ± 12%     -49.5%    3107881 ±  8%  iozone.1024KB_1024reclen.rewrite
   3887031 ± 10%     -28.6%    2775959        iozone.1024KB_1024reclen.write
    480379 ±  3%     -18.1%     393482 ±  5%  iozone.1024KB_128reclen
   6443434 ±  3%     -47.5%    3385255 ±  3%  iozone.1024KB_128reclen.frewrite
   6286942 ±  6%     -47.0%    3329021 ±  4%  iozone.1024KB_128reclen.fwrite
   8220107 ± 11%     -56.1%    3607230 ±  3%  iozone.1024KB_128reclen.random_write
  10884743 ± 16%     -70.5%    3214497 ± 15%  iozone.1024KB_128reclen.record_rewrite
   6539228 ±  4%     -52.4%    3113754 ± 12%  iozone.1024KB_128reclen.rewrite
   4379578 ±  8%     -40.0%    2626472 ± 12%  iozone.1024KB_128reclen.write
    299421 ±  5%     -10.7%     267395        iozone.1024KB_16reclen
   3996999 ± 11%     -30.0%    2798786 ±  2%  iozone.1024KB_16reclen.frewrite
   4292405 ±  9%     -32.3%    2905607 ±  3%  iozone.1024KB_16reclen.fwrite
   4301482 ±  7%     -36.8%    2717189 ±  3%  iozone.1024KB_16reclen.random_write
   5666753 ± 11%     -51.8%    2729481 ± 16%  iozone.1024KB_16reclen.record_rewrite
   4481831 ±  7%     -33.0%    3004970 ±  6%  iozone.1024KB_16reclen.rewrite
   3477849 ± 12%     -23.6%    2655911 ±  3%  iozone.1024KB_16reclen.write
    476237 ±  3%     -22.0%     371524 ±  9%  iozone.1024KB_256reclen
   6810247 ±  8%     -45.2%    3731155 ±  7%  iozone.1024KB_256reclen.frewrite
   6581797 ±  7%     -46.4%    3528219 ±  4%  iozone.1024KB_256reclen.fwrite
   8923106 ±  7%     -63.8%    3225985 ± 14%  iozone.1024KB_256reclen.random_write
  11411063 ±  8%     -74.4%    2920507 ± 23%  iozone.1024KB_256reclen.record_rewrite
   6677329 ±  9%     -53.1%    3133697 ±  6%  iozone.1024KB_256reclen.rewrite
   4742314 ±  5%     -43.8%    2665096 ± 11%  iozone.1024KB_256reclen.write
    387624 ±  8%     -18.9%     314517 ±  3%  iozone.1024KB_32reclen
   5275639 ± 10%     -44.6%    2921319 ±  4%  iozone.1024KB_32reclen.frewrite
   5133958 ± 13%     -41.8%    2990409 ±  6%  iozone.1024KB_32reclen.fwrite
   6099796 ±  6%     -47.9%    3180923 ±  4%  iozone.1024KB_32reclen.random_write
   8251223 ± 15%     -60.1%    3293523 ±  2%  iozone.1024KB_32reclen.record_rewrite
   5514773           -45.3%    3018489 ±  4%  iozone.1024KB_32reclen.rewrite
   4085563 ±  7%     -33.1%    2733760 ±  7%  iozone.1024KB_32reclen.write
   8121273 ± 11%     -39.7%    4894208 ±  4%  iozone.1024KB_512reclen.frewrite
   4559484 ± 10%     -25.2%    3410930 ±  4%  iozone.1024KB_512reclen.fwrite
   8155517 ± 14%     -60.2%    3243802 ±  8%  iozone.1024KB_512reclen.random_write
   8781751 ± 20%     -63.3%    3224865 ±  3%  iozone.1024KB_512reclen.record_rewrite
   6229116 ± 16%     -48.6%    3198827 ±  5%  iozone.1024KB_512reclen.rewrite
   4347573 ±  8%     -32.7%    2923786 ±  5%  iozone.1024KB_512reclen.write
    472615 ±  5%     -19.0%     383049 ±  5%  iozone.1024KB_64reclen
   5744325 ±  8%     -45.3%    3140431 ± 10%  iozone.1024KB_64reclen.frewrite
   5722211 ±  8%     -44.4%    3180853 ±  7%  iozone.1024KB_64reclen.fwrite
   7092470 ±  6%     -53.5%    3296493 ±  4%  iozone.1024KB_64reclen.random_write
  10932587 ± 12%     -68.8%    3411418 ±  3%  iozone.1024KB_64reclen.record_rewrite
   6410689 ± 13%     -48.4%    3308809 ±  3%  iozone.1024KB_64reclen.rewrite
   4686039 ± 10%     -36.7%    2964454 ±  5%  iozone.1024KB_64reclen.write
   3176666 ± 13%     -26.0%    2350845 ± 13%  iozone.1024KB_8reclen.frewrite
   3260613 ± 10%     -25.4%    2430999 ±  5%  iozone.1024KB_8reclen.fwrite
   3027211 ± 16%     -25.8%    2245006 ±  5%  iozone.1024KB_8reclen.random_write
   3467121 ± 14%     -31.9%    2361237 ±  7%  iozone.1024KB_8reclen.record_rewrite
   3238895 ± 13%     -19.5%    2608521 ±  4%  iozone.1024KB_8reclen.rewrite
   2967947 ±  6%     -20.2%    2367737 ±  7%  iozone.1024KB_8reclen.write
   5972578 ± 17%     -48.0%    3106248 ± 11%  iozone.128KB_128reclen.frewrite
   6234234 ± 16%     -48.4%    3214381 ±  6%  iozone.128KB_128reclen.fwrite
   6367969 ± 18%     -47.4%    3350240 ±  3%  iozone.128KB_128reclen.random_write
   6485048 ± 16%     -49.1%    3302444 ±  2%  iozone.128KB_128reclen.record_rewrite
   5871537 ± 16%     -50.3%    2917168 ± 23%  iozone.128KB_128reclen.rewrite
   4188255 ± 10%     -32.4%    2829753 ±  7%  iozone.128KB_128reclen.write
   4246115 ±  6%     -31.6%    2904229 ± 15%  iozone.128KB_16reclen.frewrite
   4294051 ±  8%     -31.6%    2938769 ± 17%  iozone.128KB_16reclen.fwrite
   3953683 ±  5%     -34.3%    2598443 ± 16%  iozone.128KB_16reclen.random_write
   4874725 ±  4%     -44.8%    2688912 ± 15%  iozone.128KB_16reclen.record_rewrite
   4427850 ±  8%     -35.7%    2845297 ± 13%  iozone.128KB_16reclen.rewrite
   3447668 ±  9%     -25.9%    2555642 ± 15%  iozone.128KB_16reclen.write
   5363997 ± 10%     -36.1%    3428810 ± 15%  iozone.128KB_32reclen.frewrite
   5213895 ± 14%     -31.9%    3551187 ± 15%  iozone.128KB_32reclen.fwrite
   5070545 ± 10%     -42.8%    2900559 ± 13%  iozone.128KB_32reclen.random_write
   6108263 ± 11%     -52.0%    2931575 ± 13%  iozone.128KB_32reclen.record_rewrite
   4891011 ±  7%     -43.1%    2783075 ± 15%  iozone.128KB_32reclen.rewrite
   3720260 ± 10%     -28.1%    2673930 ± 15%  iozone.128KB_32reclen.write
   8113389 ± 21%     -42.7%    4652126 ± 22%  iozone.128KB_64reclen.frewrite
   5894858 ± 16%     -44.2%    3287762        iozone.128KB_64reclen.random_write
   6703523 ± 16%     -51.2%    3272488 ±  2%  iozone.128KB_64reclen.record_rewrite
   3325282 ±  8%     -24.9%    2498270 ± 15%  iozone.128KB_8reclen.fwrite
   2858073 ± 11%     -25.9%    2118973 ± 16%  iozone.128KB_8reclen.random_write
   3332162 ± 11%     -29.8%    2337539 ± 15%  iozone.128KB_8reclen.record_rewrite
   2790298 ±  7%     -18.1%    2285025 ± 15%  iozone.128KB_8reclen.write
    556595 ±  2%     -24.9%     418035        iozone.131072KB_1024reclen
   7283879 ± 10%     -53.7%    3375992 ±  3%  iozone.131072KB_1024reclen.frewrite
   7603171 ±  7%     -54.8%    3440316 ±  2%  iozone.131072KB_1024reclen.fwrite
   9011412 ±  5%     -59.8%    3619676        iozone.131072KB_1024reclen.random_write
  16871237 ±  3%     -77.8%    3751658        iozone.131072KB_1024reclen.record_rewrite
   8768236 ±  5%     -57.7%    3705171        iozone.131072KB_1024reclen.rewrite
   5576785 ±  6%     -39.2%    3390303        iozone.131072KB_1024reclen.write
    540004 ±  3%     -24.5%     407855 ±  3%  iozone.131072KB_128reclen
   7567260 ±  4%     -53.8%    3497294        iozone.131072KB_128reclen.frewrite
   7543641 ±  4%     -53.8%    3483685        iozone.131072KB_128reclen.fwrite
   8214156 ±  5%     -57.6%    3483198 ±  3%  iozone.131072KB_128reclen.random_write
  15791699 ±  6%     -76.3%    3749820        iozone.131072KB_128reclen.record_rewrite
   8530694 ±  3%     -56.1%    3741683        iozone.131072KB_128reclen.rewrite
   5440759 ±  6%     -37.8%    3384168        iozone.131072KB_128reclen.write
    355415 ±  6%     -14.9%     302352 ±  5%  iozone.131072KB_16384reclen
   5293019 ±  4%     -40.1%    3170551 ±  2%  iozone.131072KB_16384reclen.frewrite
   5102705 ±  8%     -38.2%    3154449        iozone.131072KB_16384reclen.fwrite
   6085033 ±  9%     -48.0%    3161684 ±  2%  iozone.131072KB_16384reclen.random_write
   6714005 ±  7%     -56.4%    2924415 ±  2%  iozone.131072KB_16384reclen.record_rewrite
   5912564 ±  4%     -45.4%    3229169        iozone.131072KB_16384reclen.rewrite
   4361256 ±  4%     -31.3%    2995716        iozone.131072KB_16384reclen.write
    524466 ±  4%     -20.9%     414665 ±  2%  iozone.131072KB_2048reclen
   5642668 ± 13%     -46.8%    3004614 ±  4%  iozone.131072KB_2048reclen.frewrite
   6069745 ± 13%     -49.3%    3075768 ±  2%  iozone.131072KB_2048reclen.fwrite
   7818775 ± 10%     -55.6%    3472227 ±  3%  iozone.131072KB_2048reclen.random_write
  16255595 ±  6%     -77.6%    3647697        iozone.131072KB_2048reclen.record_rewrite
   7549840 ± 13%     -53.6%    3503649 ±  3%  iozone.131072KB_2048reclen.rewrite
   5063081 ± 16%     -34.3%    3325803 ±  2%  iozone.131072KB_2048reclen.write
    543287 ±  2%     -23.5%     415738        iozone.131072KB_256reclen
   7525988 ±  4%     -53.7%    3486107        iozone.131072KB_256reclen.frewrite
   7551370 ±  4%     -54.9%    3405302 ±  4%  iozone.131072KB_256reclen.fwrite
   8775926 ±  4%     -58.7%    3622848        iozone.131072KB_256reclen.random_write
  16089046 ±  4%     -76.7%    3741974        iozone.131072KB_256reclen.record_rewrite
   8961286 ±  5%     -58.1%    3753775        iozone.131072KB_256reclen.rewrite
   5329259 ±  3%     -36.2%    3398000        iozone.131072KB_256reclen.write
    467257 ±  6%     -20.9%     369445 ±  5%  iozone.131072KB_4096reclen
   5344053 ± 10%     -45.8%    2894013 ±  3%  iozone.131072KB_4096reclen.frewrite
   5178859 ± 11%     -44.2%    2888296        iozone.131072KB_4096reclen.fwrite
   7091453 ±  8%     -53.9%    3267343        iozone.131072KB_4096reclen.random_write
   9958856 ± 23%     -69.0%    3089468 ±  8%  iozone.131072KB_4096reclen.record_rewrite
   6790908 ±  9%     -52.0%    3257618 ±  3%  iozone.131072KB_4096reclen.rewrite
   4657075 ±  6%     -33.3%    3104395 ±  2%  iozone.131072KB_4096reclen.write
    550746 ±  2%     -24.2%     417706 ±  2%  iozone.131072KB_512reclen
   7643592 ±  4%     -54.3%    3492423        iozone.131072KB_512reclen.frewrite
   7622635 ±  4%     -54.9%    3434029 ±  3%  iozone.131072KB_512reclen.fwrite
   9038913 ±  4%     -59.4%    3665678        iozone.131072KB_512reclen.random_write
  16159032 ±  3%     -77.0%    3721799        iozone.131072KB_512reclen.record_rewrite
   9021758 ±  4%     -58.6%    3732833        iozone.131072KB_512reclen.rewrite
   5550664 ±  6%     -39.9%    3337160 ±  4%  iozone.131072KB_512reclen.write
    495904 ±  4%     -21.7%     388115 ±  2%  iozone.131072KB_64reclen
   6944981 ±  4%     -50.3%    3452635        iozone.131072KB_64reclen.frewrite
   6941633 ±  5%     -50.4%    3443365        iozone.131072KB_64reclen.fwrite
   7083196 ±  6%     -53.3%    3311192        iozone.131072KB_64reclen.random_write
  13356791 ±  8%     -72.4%    3689259        iozone.131072KB_64reclen.record_rewrite
   7656280 ±  5%     -52.0%    3675163        iozone.131072KB_64reclen.rewrite
   4889990 ± 14%     -31.2%    3364128        iozone.131072KB_64reclen.write
    375509 ±  5%     -18.4%     306526 ±  5%  iozone.131072KB_8192reclen
   5144601 ±  8%     -42.1%    2979704        iozone.131072KB_8192reclen.frewrite
   4994124 ±  9%     -40.5%    2973687        iozone.131072KB_8192reclen.fwrite
   5966882 ±  7%     -47.6%    3128779 ±  3%  iozone.131072KB_8192reclen.random_write
   6897733 ± 12%     -55.5%    3068179        iozone.131072KB_8192reclen.record_rewrite
   6166392 ±  7%     -48.4%    3179624 ±  3%  iozone.131072KB_8192reclen.rewrite
   4547664 ±  4%     -34.3%    2985575        iozone.131072KB_8192reclen.write
    502575 ±  3%     -26.1%     371228 ±  9%  iozone.16384KB_1024reclen
  10293176 ±  6%      -9.5%    9320083 ±  6%  iozone.16384KB_1024reclen.bkwd_read
   6646368 ±  3%     -49.2%    3376676 ±  6%  iozone.16384KB_1024reclen.frewrite
   6339526 ±  6%     -47.3%    3339024 ±  6%  iozone.16384KB_1024reclen.fwrite
   8911501 ±  7%     -61.4%    3442980 ± 14%  iozone.16384KB_1024reclen.random_write
  16155159 ±  3%     -78.0%    3546393 ±  7%  iozone.16384KB_1024reclen.record_rewrite
   7372124 ±  8%     -54.3%    3369335 ±  9%  iozone.16384KB_1024reclen.rewrite
   5245926 ±  6%     -42.3%    3029117 ± 14%  iozone.16384KB_1024reclen.write
    500856 ±  2%     -25.0%     375560 ±  2%  iozone.16384KB_128reclen
   6866695 ±  6%     -51.8%    3308318 ±  5%  iozone.16384KB_128reclen.frewrite
   7195384 ±  2%     -55.9%    3173530 ± 12%  iozone.16384KB_128reclen.fwrite
   8774656 ±  4%     -58.5%    3640393        iozone.16384KB_128reclen.random_write
  15591161 ±  6%     -75.9%    3754231        iozone.16384KB_128reclen.record_rewrite
   7949451           -55.1%    3568843 ±  5%  iozone.16384KB_128reclen.rewrite
   5252802 ±  6%     -37.5%    3281669 ±  6%  iozone.16384KB_128reclen.write
    396193           -24.2%     300141 ±  8%  iozone.16384KB_16384reclen
   6388871 ±  4%     -50.1%    3189918        iozone.16384KB_16384reclen.frewrite
   6534523 ±  4%     -51.8%    3151340 ±  5%  iozone.16384KB_16384reclen.fwrite
   6456084 ±  5%     -52.7%    3053804 ± 11%  iozone.16384KB_16384reclen.random_write
   6672258           -54.2%    3057919 ± 10%  iozone.16384KB_16384reclen.record_rewrite
   6171950 ±  5%     -49.0%    3148548 ±  3%  iozone.16384KB_16384reclen.rewrite
   4441138 ±  5%     -37.0%    2797259 ± 11%  iozone.16384KB_16384reclen.write
   4823195 ±  4%     -37.8%    2998684 ±  3%  iozone.16384KB_16reclen.frewrite
   4601430 ±  7%     -32.9%    3087716        iozone.16384KB_16reclen.fwrite
   4180916 ±  8%     -33.1%    2798844 ±  2%  iozone.16384KB_16reclen.random_write
   5667637 ±  5%     -44.9%    3122971 ±  2%  iozone.16384KB_16reclen.record_rewrite
   4955347 ±  5%     -35.1%    3214593 ±  2%  iozone.16384KB_16reclen.rewrite
    473227 ±  7%     -21.4%     371728 ±  6%  iozone.16384KB_2048reclen
   5739847 ± 15%     -43.7%    3233427 ±  7%  iozone.16384KB_2048reclen.frewrite
   6333846 ±  3%     -47.4%    3333479 ±  2%  iozone.16384KB_2048reclen.fwrite
   8062496 ± 11%     -58.0%    3389775 ±  9%  iozone.16384KB_2048reclen.random_write
  14684802 ±  9%     -74.8%    3698168        iozone.16384KB_2048reclen.record_rewrite
   6685406 ± 10%     -48.8%    3425186 ±  3%  iozone.16384KB_2048reclen.rewrite
   4783654 ± 10%     -36.9%    3017283 ±  9%  iozone.16384KB_2048reclen.write
    501522 ±  2%     -24.6%     378391 ±  2%  iozone.16384KB_256reclen
   6882929 ±  3%     -50.8%    3387288 ±  4%  iozone.16384KB_256reclen.frewrite
   7052407 ±  6%     -53.1%    3310175 ±  7%  iozone.16384KB_256reclen.fwrite
   9032840 ±  4%     -59.6%    3650079 ±  5%  iozone.16384KB_256reclen.random_write
  16000820 ±  4%     -77.4%    3615234 ±  7%  iozone.16384KB_256reclen.record_rewrite
   8093572 ±  3%     -55.8%    3577186 ±  4%  iozone.16384KB_256reclen.rewrite
   5364208 ±  6%     -38.6%    3294480 ±  3%  iozone.16384KB_256reclen.write
    399141 ±  5%     -18.6%     325048 ±  3%  iozone.16384KB_32reclen
  10066483 ±  3%      -8.9%    9165856 ±  7%  iozone.16384KB_32reclen.fread
  10168580 ±  3%      -8.3%    9327535 ±  4%  iozone.16384KB_32reclen.freread
   5723442 ±  8%     -46.5%    3061356 ± 12%  iozone.16384KB_32reclen.frewrite
   5547324 ± 11%     -43.2%    3148213 ±  6%  iozone.16384KB_32reclen.fwrite
   5623221 ± 11%     -43.8%    3158882 ±  5%  iozone.16384KB_32reclen.random_write
   8720163 ±  7%     -62.1%    3303932 ±  9%  iozone.16384KB_32reclen.record_rewrite
   6067131 ± 10%     -44.4%    3370477 ±  5%  iozone.16384KB_32reclen.rewrite
   4440172 ±  9%     -31.0%    3063071 ±  7%  iozone.16384KB_32reclen.write
    421223 ±  5%     -13.4%     364901 ±  2%  iozone.16384KB_4096reclen
   6166229 ±  8%     -39.7%    3715837 ±  2%  iozone.16384KB_4096reclen.frewrite
   6007088 ±  9%     -39.0%    3665450 ±  3%  iozone.16384KB_4096reclen.fwrite
   7077043 ± 13%     -50.6%    3493249 ±  3%  iozone.16384KB_4096reclen.random_write
   9964873 ± 11%     -65.1%    3482055 ±  3%  iozone.16384KB_4096reclen.record_rewrite
   6184702 ±  5%     -47.1%    3269031        iozone.16384KB_4096reclen.rewrite
   4538005 ±  8%     -33.3%    3027051 ±  2%  iozone.16384KB_4096reclen.write
   2049020 ±  8%      +8.4%    2220129 ±  2%  iozone.16384KB_4reclen.frewrite
   1789750 ±  6%      +8.0%    1933158        iozone.16384KB_4reclen.record_rewrite
    494259 ±  3%     -22.7%     381984 ±  5%  iozone.16384KB_512reclen
   6748999 ±  5%     -50.7%    3328128 ±  6%  iozone.16384KB_512reclen.frewrite
   6687674 ±  4%     -52.1%    3203532 ± 13%  iozone.16384KB_512reclen.fwrite
   8480038 ± 15%     -57.1%    3635705 ±  6%  iozone.16384KB_512reclen.random_write
  15766929 ±  5%     -77.0%    3631363 ±  6%  iozone.16384KB_512reclen.record_rewrite
   7773133 ±  2%     -54.9%    3502963 ±  6%  iozone.16384KB_512reclen.rewrite
   5301780 ±  3%     -38.8%    3242233 ±  6%  iozone.16384KB_512reclen.write
    465431           -24.3%     352331 ±  6%  iozone.16384KB_64reclen
   6370739 ±  8%     -47.4%    3350737 ±  2%  iozone.16384KB_64reclen.frewrite
   6523478 ±  3%     -49.8%    3271535 ±  6%  iozone.16384KB_64reclen.fwrite
   7573757 ±  4%     -56.8%    3270565 ± 13%  iozone.16384KB_64reclen.random_write
  12463547 ±  4%     -70.8%    3642499        iozone.16384KB_64reclen.record_rewrite
   7391311 ±  2%     -54.1%    3391977 ±  7%  iozone.16384KB_64reclen.rewrite
   5008942 ±  7%     -41.0%    2954378 ± 17%  iozone.16384KB_64reclen.write
    391993           -15.1%     332951 ±  2%  iozone.16384KB_8192reclen
   8341214 ±  5%     -39.4%    5058416 ±  5%  iozone.16384KB_8192reclen.frewrite
   5672835 ±  7%     -29.8%    3983885 ±  7%  iozone.16384KB_8192reclen.fwrite
   6224158 ±  6%     -46.2%    3346580        iozone.16384KB_8192reclen.random_write
   6748212 ±  5%     -52.9%    3175726 ±  2%  iozone.16384KB_8192reclen.record_rewrite
   6137617 ±  5%     -48.1%    3185708 ±  2%  iozone.16384KB_8192reclen.rewrite
   4332394 ±  9%     -34.2%    2848563 ± 11%  iozone.16384KB_8192reclen.write
    236378            -8.3%     216744 ±  7%  iozone.16384KB_8reclen
   3537772 ±  7%     -22.8%    2730676        iozone.16384KB_8reclen.frewrite
   3389032 ± 11%     -19.7%    2721082        iozone.16384KB_8reclen.fwrite
   3686254 ± 13%     -28.7%    2626627 ±  2%  iozone.16384KB_8reclen.record_rewrite
   3748926 ±  8%     -23.0%    2886966        iozone.16384KB_8reclen.rewrite
   6836731 ±  9%     -28.6%    4884626 ± 15%  iozone.2048KB_1024reclen.frewrite
   8202740 ±  8%     -55.6%    3644862 ±  2%  iozone.2048KB_1024reclen.random_write
   6719919 ± 20%     -50.6%    3319142 ±  8%  iozone.2048KB_1024reclen.record_rewrite
   5154945 ± 17%     -43.7%    2900878 ±  4%  iozone.2048KB_1024reclen.rewrite
   6855424 ± 11%     -53.8%    3170377 ±  4%  iozone.2048KB_128reclen.frewrite
   6667708 ±  6%     -49.1%    3395053 ±  5%  iozone.2048KB_128reclen.fwrite
   8305700 ± 16%     -56.9%    3577221 ±  5%  iozone.2048KB_128reclen.random_write
  13050534 ± 13%     -73.4%    3466133 ±  5%  iozone.2048KB_128reclen.record_rewrite
   7308813 ± 14%     -55.0%    3290657 ±  3%  iozone.2048KB_128reclen.rewrite
   4992493 ±  3%     -39.6%    3016190 ±  5%  iozone.2048KB_128reclen.write
    306815 ±  4%     -13.0%     266929        iozone.2048KB_16reclen
   4236894 ±  7%     -33.1%    2834252 ±  5%  iozone.2048KB_16reclen.frewrite
   4446168 ±  7%     -38.6%    2728494 ±  3%  iozone.2048KB_16reclen.fwrite
   4123681 ±  5%     -31.8%    2812183        iozone.2048KB_16reclen.random_write
   5747492 ±  8%     -52.2%    2744589 ± 12%  iozone.2048KB_16reclen.record_rewrite
   4667894 ±  7%     -35.4%    3013487 ±  4%  iozone.2048KB_16reclen.rewrite
   3702137 ±  7%     -21.1%    2919899 ±  3%  iozone.2048KB_16reclen.write
   5910897 ± 11%     -52.9%    2785979 ± 13%  iozone.2048KB_2048reclen.frewrite
   6013474 ± 14%     -52.1%    2878111 ± 16%  iozone.2048KB_2048reclen.fwrite
  10690202 ± 13%     -64.9%    3756371 ± 14%  iozone.2048KB_2048reclen.random_write
   6212344 ± 20%     -50.2%    3091598 ± 16%  iozone.2048KB_2048reclen.record_rewrite
   5276785 ± 13%     -47.7%    2760399 ± 13%  iozone.2048KB_2048reclen.rewrite
   3998119 ±  8%     -29.1%    2836278 ± 11%  iozone.2048KB_2048reclen.write
   6633759 ±  9%     -51.5%    3218824 ±  8%  iozone.2048KB_256reclen.frewrite
   6329173 ±  8%     -46.3%    3398214 ±  4%  iozone.2048KB_256reclen.fwrite
   7819350 ± 19%     -55.2%    3501850 ±  6%  iozone.2048KB_256reclen.random_write
  11989233 ± 14%     -71.4%    3424885 ±  6%  iozone.2048KB_256reclen.record_rewrite
   7056075 ± 17%     -53.6%    3272935 ±  5%  iozone.2048KB_256reclen.rewrite
   4733134 ± 19%     -35.5%    3051341 ±  6%  iozone.2048KB_256reclen.write
    375013 ±  4%     -20.6%     297592 ± 12%  iozone.2048KB_32reclen
   5269739 ±  9%     -45.7%    2858907 ± 12%  iozone.2048KB_32reclen.frewrite
   5178543 ±  7%     -44.5%    2871717 ± 12%  iozone.2048KB_32reclen.fwrite
   5138533 ±  4%     -42.1%    2972723 ± 11%  iozone.2048KB_32reclen.random_write
   8859050 ±  5%     -64.9%    3105152 ± 13%  iozone.2048KB_32reclen.record_rewrite
   5481755 ± 14%     -47.3%    2890654 ± 11%  iozone.2048KB_32reclen.rewrite
   4133954 ±  4%     -32.8%    2777714 ± 12%  iozone.2048KB_32reclen.write
   5935222 ± 18%     -41.0%    3503137 ±  6%  iozone.2048KB_512reclen.frewrite
   5755516 ± 14%     -40.4%    3432196 ±  3%  iozone.2048KB_512reclen.fwrite
   7882965 ± 13%     -55.4%    3518040 ±  6%  iozone.2048KB_512reclen.random_write
   9812967 ± 27%     -69.2%    3023544 ± 16%  iozone.2048KB_512reclen.record_rewrite
   6668951 ± 10%     -52.4%    3173521 ±  6%  iozone.2048KB_512reclen.rewrite
   4387223 ± 16%     -32.3%    2971535 ±  4%  iozone.2048KB_512reclen.write
    452484 ± 11%     -20.8%     358435 ±  9%  iozone.2048KB_64reclen
   5940340 ± 12%     -48.7%    3048096 ±  4%  iozone.2048KB_64reclen.frewrite
   6047329 ±  4%     -48.5%    3114050 ±  3%  iozone.2048KB_64reclen.fwrite
   6736254 ±  8%     -51.0%    3299184 ±  4%  iozone.2048KB_64reclen.random_write
  11611764 ±  8%     -70.8%    3394295 ±  4%  iozone.2048KB_64reclen.record_rewrite
   6392041 ± 11%     -50.1%    3188337 ±  3%  iozone.2048KB_64reclen.rewrite
   4636089 ±  4%     -33.3%    3091914 ±  3%  iozone.2048KB_64reclen.write
   3081425 ±  7%     -25.0%    2309660 ±  7%  iozone.2048KB_8reclen.random_write
   3470896 ± 16%     -30.0%    2429657 ± 14%  iozone.2048KB_8reclen.record_rewrite
   3476842 ± 12%     -25.7%    2584243 ±  8%  iozone.2048KB_8reclen.rewrite
   2896290 ±  7%     -13.1%    2517752 ±  2%  iozone.2048KB_8reclen.write
   9446659 ± 19%     -49.8%    4740773 ± 19%  iozone.256KB_128reclen.frewrite
   7603751 ± 19%     -52.2%    3638190 ±  2%  iozone.256KB_128reclen.random_write
   8755883 ± 17%     -61.4%    3383990 ±  4%  iozone.256KB_128reclen.record_rewrite
   6438162 ± 21%     -51.5%    3123611 ±  9%  iozone.256KB_128reclen.rewrite
   4297120 ± 18%     -36.8%    2716274 ± 14%  iozone.256KB_128reclen.write
   4559373 ±  4%     -39.9%    2739746 ± 15%  iozone.256KB_16reclen.frewrite
   4647079 ±  5%     -33.3%    3101322 ±  4%  iozone.256KB_16reclen.fwrite
   4386424 ±  8%     -36.9%    2767743 ±  2%  iozone.256KB_16reclen.random_write
   5309170 ±  7%     -49.1%    2704335 ±  8%  iozone.256KB_16reclen.record_rewrite
   4649650 ±  6%     -37.2%    2921374 ±  9%  iozone.256KB_16reclen.rewrite
   6300156 ± 18%     -52.8%    2972816 ±  6%  iozone.256KB_256reclen.frewrite
   6706970 ± 16%     -52.9%    3160789 ±  9%  iozone.256KB_256reclen.fwrite
   7540355 ± 18%     -54.4%    3436809 ±  5%  iozone.256KB_256reclen.random_write
   7477530 ± 13%     -53.8%    3451828 ±  8%  iozone.256KB_256reclen.record_rewrite
   6516052 ± 14%     -53.2%    3051536 ±  5%  iozone.256KB_256reclen.rewrite
   4441003 ± 14%     -36.4%    2826469 ± 11%  iozone.256KB_256reclen.write
   5352524 ± 16%     -40.9%    3161312 ± 13%  iozone.256KB_32reclen.frewrite
   5358245 ± 15%     -39.6%    3235923 ± 12%  iozone.256KB_32reclen.fwrite
   5690762 ±  2%     -45.2%    3120219 ±  4%  iozone.256KB_32reclen.random_write
   7748557 ±  4%     -59.1%    3172741 ±  4%  iozone.256KB_32reclen.record_rewrite
   5649007 ± 10%     -46.7%    3009095 ± 12%  iozone.256KB_32reclen.rewrite
   6259857 ± 16%     -43.4%    3542430 ±  9%  iozone.256KB_64reclen.frewrite
   6914597 ± 17%     -48.2%    3583163 ± 10%  iozone.256KB_64reclen.fwrite
   6646532 ± 18%     -49.1%    3381439 ±  8%  iozone.256KB_64reclen.random_write
   8821271 ± 16%     -63.1%    3258484 ±  6%  iozone.256KB_64reclen.record_rewrite
   6218666 ± 16%     -54.0%    2857628 ± 12%  iozone.256KB_64reclen.rewrite
   4063725 ± 16%     -34.2%    2675796 ± 11%  iozone.256KB_64reclen.write
   3309908 ±  6%     -20.3%    2637427 ±  2%  iozone.256KB_8reclen.frewrite
   3387771 ±  6%     -23.0%    2607782 ± 10%  iozone.256KB_8reclen.fwrite
   3449324 ±  9%     -21.5%    2709361 ±  4%  iozone.256KB_8reclen.rewrite
   2940894 ±  5%     -17.1%    2436701 ±  7%  iozone.256KB_8reclen.write
    565917 ±  3%     -24.7%     426394        iozone.262144KB_1024reclen
   7426604 ±  4%     -53.6%    3447449        iozone.262144KB_1024reclen.frewrite
   7465832 ±  7%     -54.1%    3426029        iozone.262144KB_1024reclen.fwrite
   9241493 ±  4%     -60.5%    3646617        iozone.262144KB_1024reclen.random_write
  16705624 ±  3%     -77.8%    3710189        iozone.262144KB_1024reclen.record_rewrite
   9117761 ±  4%     -59.0%    3739487        iozone.262144KB_1024reclen.rewrite
   5658804 ±  6%     -41.1%    3333708        iozone.262144KB_1024reclen.write
    548834 ±  2%     -24.2%     415789 ±  3%  iozone.262144KB_128reclen
   7580407 ±  4%     -53.9%    3496669        iozone.262144KB_128reclen.frewrite
   7599726 ±  4%     -54.1%    3491630        iozone.262144KB_128reclen.fwrite
   8254162 ±  5%     -58.6%    3419671        iozone.262144KB_128reclen.random_write
  15674857 ±  5%     -76.0%    3757127        iozone.262144KB_128reclen.record_rewrite
   8578160 ±  4%     -56.7%    3716083        iozone.262144KB_128reclen.rewrite
   5455478 ±  6%     -38.4%    3362617        iozone.262144KB_128reclen.write
   5122765 ±  8%     -41.8%    2979344 ±  3%  iozone.262144KB_16384reclen.frewrite
   5043992 ±  9%     -42.0%    2924477 ±  2%  iozone.262144KB_16384reclen.fwrite
   6495456 ±  8%     -51.1%    3175821 ±  2%  iozone.262144KB_16384reclen.random_write
   6973977 ± 10%     -58.0%    2927753 ±  2%  iozone.262144KB_16384reclen.record_rewrite
   6455402 ±  8%     -50.1%    3223833        iozone.262144KB_16384reclen.rewrite
   4302269 ±  4%     -32.8%    2890933 ±  2%  iozone.262144KB_16384reclen.write
    542367 ±  2%     -22.9%     418397 ±  4%  iozone.262144KB_2048reclen
   6322086 ±  6%     -52.1%    3028214 ±  3%  iozone.262144KB_2048reclen.frewrite
   6134575 ± 10%     -50.6%    3028663 ±  3%  iozone.262144KB_2048reclen.fwrite
   8308015 ± 11%     -58.1%    3484881 ±  2%  iozone.262144KB_2048reclen.random_write
  16212043 ±  2%     -78.2%    3529138 ±  3%  iozone.262144KB_2048reclen.record_rewrite
   7969765 ± 10%     -54.8%    3604916 ±  3%  iozone.262144KB_2048reclen.rewrite
   5300877 ± 14%     -39.8%    3192843 ±  3%  iozone.262144KB_2048reclen.write
    554017           -26.2%     408919        iozone.262144KB_256reclen
  13019165            -6.0%   12236091 ±  2%  iozone.262144KB_256reclen.fread
  12622409 ±  2%      -7.1%   11731982 ±  4%  iozone.262144KB_256reclen.freread
   7704530 ±  2%     -54.8%    3482335        iozone.262144KB_256reclen.frewrite
   7812833 ±  4%     -55.9%    3446681 ±  2%  iozone.262144KB_256reclen.fwrite
   8835487 ±  5%     -60.1%    3523916 ±  4%  iozone.262144KB_256reclen.random_write
  15997491 ±  4%     -76.7%    3730589        iozone.262144KB_256reclen.record_rewrite
   9008693 ±  4%     -58.9%    3699947 ±  2%  iozone.262144KB_256reclen.rewrite
   5557851 ±  5%     -39.2%    3378939        iozone.262144KB_256reclen.write
    474514 ±  4%     -23.1%     364705 ±  9%  iozone.262144KB_4096reclen
   5309234 ±  9%     -45.8%    2878750 ±  3%  iozone.262144KB_4096reclen.frewrite
   5093529 ±  5%     -44.3%    2834589        iozone.262144KB_4096reclen.fwrite
   7364778 ±  7%     -55.6%    3267439 ±  2%  iozone.262144KB_4096reclen.random_write
  10366266 ± 20%     -69.5%    3156979 ±  4%  iozone.262144KB_4096reclen.record_rewrite
   7365247 ±  5%     -54.8%    3330171 ±  2%  iozone.262144KB_4096reclen.rewrite
   4798280 ±  7%     -38.1%    2968182 ±  7%  iozone.262144KB_4096reclen.write
    563088 ±  3%     -25.9%     417441        iozone.262144KB_512reclen
   7752515 ±  5%     -55.0%    3488123        iozone.262144KB_512reclen.frewrite
   7707353 ±  5%     -55.0%    3465149 ±  2%  iozone.262144KB_512reclen.fwrite
   9122558 ±  7%     -60.3%    3619515        iozone.262144KB_512reclen.random_write
  16131006 ±  4%     -76.9%    3723603        iozone.262144KB_512reclen.record_rewrite
   9178400 ±  4%     -59.1%    3751173        iozone.262144KB_512reclen.rewrite
   5645649 ±  6%     -40.0%    3384873        iozone.262144KB_512reclen.write
    504017 ±  3%     -21.9%     393712 ±  2%  iozone.262144KB_64reclen
   6978079 ±  3%     -52.7%    3299284 ±  5%  iozone.262144KB_64reclen.frewrite
   7041202 ±  3%     -51.8%    3391815 ±  2%  iozone.262144KB_64reclen.fwrite
   7114665 ±  7%     -54.6%    3231979        iozone.262144KB_64reclen.random_write
  13278679 ±  8%     -72.3%    3672374        iozone.262144KB_64reclen.record_rewrite
   7586597 ±  2%     -52.0%    3644015        iozone.262144KB_64reclen.rewrite
   5143061 ±  5%     -35.8%    3304019 ±  2%  iozone.262144KB_64reclen.write
   5066711 ±  9%     -43.8%    2845739 ±  2%  iozone.262144KB_8192reclen.frewrite
   4851138 ± 10%     -40.9%    2865015        iozone.262144KB_8192reclen.fwrite
   6278072 ± 11%     -49.0%    3198761 ±  4%  iozone.262144KB_8192reclen.random_write
   7316116 ± 13%     -59.0%    2998594 ±  2%  iozone.262144KB_8192reclen.record_rewrite
   6450681 ±  6%     -50.0%    3228542 ±  2%  iozone.262144KB_8192reclen.rewrite
   4436484 ±  5%     -33.3%    2960325        iozone.262144KB_8192reclen.write
    520469 ±  2%     -22.5%     403395 ±  2%  iozone.32768KB_1024reclen
   6865305 ±  7%     -50.5%    3401362        iozone.32768KB_1024reclen.frewrite
   7344207 ±  2%     -52.8%    3464329        iozone.32768KB_1024reclen.fwrite
   8864633 ±  4%     -60.4%    3513828 ±  9%  iozone.32768KB_1024reclen.random_write
  16492032 ±  4%     -78.0%    3628653 ±  5%  iozone.32768KB_1024reclen.record_rewrite
  11235546 ±  2%      +4.9%   11791425 ±  2%  iozone.32768KB_1024reclen.reread
   8292466 ±  5%     -57.5%    3523443 ±  5%  iozone.32768KB_1024reclen.rewrite
   4828682 ± 20%     -37.0%    3042222 ± 13%  iozone.32768KB_1024reclen.write
    520358 ±  3%     -26.5%     382529 ±  6%  iozone.32768KB_128reclen
   7345834 ±  2%     -53.2%    3440812        iozone.32768KB_128reclen.frewrite
   7129775 ±  7%     -54.6%    3238633 ± 12%  iozone.32768KB_128reclen.fwrite
   8363525 ±  5%     -59.5%    3387573 ± 13%  iozone.32768KB_128reclen.random_write
  15671110 ±  7%     -76.4%    3705583 ±  2%  iozone.32768KB_128reclen.record_rewrite
   8327280 ±  4%     -58.5%    3451855 ±  9%  iozone.32768KB_128reclen.rewrite
   5254021 ±  3%     -35.4%    3394572        iozone.32768KB_128reclen.write
   8066011 ± 14%     -37.1%    5071119 ±  2%  iozone.32768KB_16384reclen.frewrite
   6501615 ±  8%     -33.0%    4358118 ±  5%  iozone.32768KB_16384reclen.fwrite
   6098219 ±  9%     -47.8%    3183470 ±  2%  iozone.32768KB_16384reclen.random_write
   6585067 ± 10%     -53.5%    3061524        iozone.32768KB_16384reclen.record_rewrite
   6353925 ±  5%     -49.5%    3206168        iozone.32768KB_16384reclen.rewrite
   4210893 ±  5%     -29.3%    2977793        iozone.32768KB_16384reclen.write
    522544 ±  2%     -23.6%     399333        iozone.32768KB_2048reclen
   5825805 ±  4%     -46.8%    3099754 ±  5%  iozone.32768KB_2048reclen.frewrite
   5988705 ±  7%     -47.7%    3131337 ±  5%  iozone.32768KB_2048reclen.fwrite
   7737310 ± 13%     -54.7%    3506923 ±  5%  iozone.32768KB_2048reclen.random_write
  16280549 ±  3%     -78.4%    3515026 ± 11%  iozone.32768KB_2048reclen.record_rewrite
   7342137 ±  9%     -53.4%    3422572 ±  4%  iozone.32768KB_2048reclen.rewrite
   4608264 ±  8%     -35.2%    2985182 ± 14%  iozone.32768KB_2048reclen.write
    514576 ±  3%     -24.1%     390757 ±  2%  iozone.32768KB_256reclen
   7237739 ±  4%     -52.7%    3423888        iozone.32768KB_256reclen.frewrite
   7300628 ±  4%     -52.6%    3458449        iozone.32768KB_256reclen.fwrite
   8901040 ±  4%     -59.2%    3631801        iozone.32768KB_256reclen.random_write
  16048341 ±  4%     -78.5%    3445786 ± 11%  iozone.32768KB_256reclen.record_rewrite
   8280876 ±  3%     -57.1%    3555933 ±  8%  iozone.32768KB_256reclen.rewrite
   5120802 ± 15%     -37.3%    3208182 ± 13%  iozone.32768KB_256reclen.write
   5646923 ±  7%     -42.2%    3265200        iozone.32768KB_4096reclen.frewrite
   5116212 ± 18%     -39.5%    3095721 ±  8%  iozone.32768KB_4096reclen.fwrite
   6684645 ± 10%     -50.6%    3301571 ±  4%  iozone.32768KB_4096reclen.random_write
  10282683 ± 24%     -65.8%    3515692        iozone.32768KB_4096reclen.record_rewrite
   6857545 ±  3%     -51.2%    3348852        iozone.32768KB_4096reclen.rewrite
   4366899 ± 12%     -35.0%    2839282 ± 11%  iozone.32768KB_4096reclen.write
    529392 ±  3%     -25.9%     392508 ±  3%  iozone.32768KB_512reclen
   7040580 ±  5%     -51.0%    3453327        iozone.32768KB_512reclen.frewrite
   7364648 ±  2%     -53.5%    3425392 ±  2%  iozone.32768KB_512reclen.fwrite
   8918336 ±  6%     -59.6%    3603100 ±  3%  iozone.32768KB_512reclen.random_write
  15612101 ±  7%     -76.0%    3741355        iozone.32768KB_512reclen.record_rewrite
  11511261            -7.9%   10602443 ±  7%  iozone.32768KB_512reclen.reread
   8402000 ±  4%     -58.6%    3482441 ±  6%  iozone.32768KB_512reclen.rewrite
   5168215 ± 15%     -40.1%    3097976 ± 13%  iozone.32768KB_512reclen.write
    480712 ±  6%     -20.3%     382907 ±  2%  iozone.32768KB_64reclen
   6825879 ±  3%     -50.2%    3401691        iozone.32768KB_64reclen.frewrite
   6690195 ±  6%     -48.8%    3427805        iozone.32768KB_64reclen.fwrite
   7198635 ± 10%     -52.0%    3457655        iozone.32768KB_64reclen.random_write
  13214747 ±  7%     -71.9%    3707938        iozone.32768KB_64reclen.record_rewrite
   7547549 ±  4%     -52.2%    3608505        iozone.32768KB_64reclen.rewrite
   4935168 ±  9%     -32.0%    3353703        iozone.32768KB_64reclen.write
    393804 ±  4%     -21.0%     311208 ±  5%  iozone.32768KB_8192reclen
   6301898 ±  5%     -44.5%    3499366 ±  4%  iozone.32768KB_8192reclen.frewrite
   6295064 ±  7%     -41.5%    3680383        iozone.32768KB_8192reclen.fwrite
   9535662 ±  2%     -21.0%    7533567 ± 15%  iozone.32768KB_8192reclen.random_read
   6543055           -52.3%    3121724 ±  2%  iozone.32768KB_8192reclen.random_write
   7549220 ±  8%     -60.0%    3016909 ±  2%  iozone.32768KB_8192reclen.record_rewrite
   6235066 ±  5%     -49.2%    3166141 ±  2%  iozone.32768KB_8192reclen.rewrite
   3951810 ± 13%     -27.2%    2878694 ±  6%  iozone.32768KB_8192reclen.write
    410587 ±  7%     -18.8%     333504 ±  8%  iozone.4096KB_1024reclen
   5581206 ± 14%     -36.4%    3551408 ±  6%  iozone.4096KB_1024reclen.frewrite
   4963156 ± 11%     -32.6%    3346141 ±  6%  iozone.4096KB_1024reclen.fwrite
  10197657 ± 15%     -60.9%    3984266        iozone.4096KB_1024reclen.random_write
   9292095 ±  4%     -65.2%    3237748 ± 16%  iozone.4096KB_1024reclen.record_rewrite
   6008436 ± 12%     -48.7%    3083516 ±  4%  iozone.4096KB_1024reclen.rewrite
   4580562 ± 14%     -34.7%    2990265 ±  5%  iozone.4096KB_1024reclen.write
    446062 ±  7%     -19.2%     360512        iozone.4096KB_128reclen
   6407111 ±  3%     -49.6%    3230105 ±  4%  iozone.4096KB_128reclen.frewrite
   6033084 ±  8%     -47.1%    3193901 ±  2%  iozone.4096KB_128reclen.fwrite
   8353476 ± 13%     -55.7%    3699894        iozone.4096KB_128reclen.random_write
  13371492 ± 17%     -72.8%    3632717 ±  3%  iozone.4096KB_128reclen.record_rewrite
   6698376 ±  8%     -49.4%    3388864        iozone.4096KB_128reclen.rewrite
   4758658 ± 13%     -33.5%    3163675 ±  3%  iozone.4096KB_128reclen.write
    317419 ±  3%     -15.3%     268982 ±  2%  iozone.4096KB_16reclen
   4412358 ±  5%     -32.8%    2964307 ±  2%  iozone.4096KB_16reclen.frewrite
   4482749 ±  9%     -34.9%    2917748 ±  2%  iozone.4096KB_16reclen.fwrite
   4844116 ±  9%     -38.9%    2961492 ±  3%  iozone.4096KB_16reclen.random_write
   5829791 ± 12%     -47.0%    3090613 ±  2%  iozone.4096KB_16reclen.record_rewrite
   4799124 ±  3%     -36.5%    3048105 ±  3%  iozone.4096KB_16reclen.rewrite
   3680378 ±  4%     -23.9%    2802502 ±  2%  iozone.4096KB_16reclen.write
    400116 ±  6%     -15.0%     340096 ±  2%  iozone.4096KB_2048reclen
   7868614 ±  8%     -40.9%    4654236 ±  8%  iozone.4096KB_2048reclen.frewrite
   3987532 ±  9%     -19.5%    3209474 ±  4%  iozone.4096KB_2048reclen.fwrite
   9991875 ± 19%     -60.2%    3977591 ±  5%  iozone.4096KB_2048reclen.random_write
   9042388 ±  8%     -61.9%    3444073 ±  2%  iozone.4096KB_2048reclen.record_rewrite
   5365959 ±  6%     -43.4%    3034539 ±  3%  iozone.4096KB_2048reclen.rewrite
   4099336 ± 10%     -27.4%    2975606 ±  3%  iozone.4096KB_2048reclen.write
    473068 ±  6%     -17.5%     390054 ±  4%  iozone.4096KB_256reclen
   6284695 ±  9%     -49.4%    3177255 ±  2%  iozone.4096KB_256reclen.frewrite
   6025809 ±  9%     -46.8%    3206110 ±  2%  iozone.4096KB_256reclen.fwrite
   8872736 ± 13%     -57.9%    3735368        iozone.4096KB_256reclen.random_write
  12166515 ± 14%     -70.5%    3587021        iozone.4096KB_256reclen.record_rewrite
   6906230 ± 13%     -51.6%    3342769 ±  2%  iozone.4096KB_256reclen.rewrite
   4802214 ± 13%     -32.9%    3222318 ±  2%  iozone.4096KB_256reclen.write
    392538 ±  6%     -20.0%     314015 ±  3%  iozone.4096KB_32reclen
   5166220 ± 12%     -41.5%    3022049 ±  4%  iozone.4096KB_32reclen.frewrite
   5287356 ± 13%     -43.4%    2993166 ±  2%  iozone.4096KB_32reclen.fwrite
   6648671 ±  5%     -49.9%    3332904 ±  2%  iozone.4096KB_32reclen.random_write
   8724643 ± 13%     -60.9%    3415035        iozone.4096KB_32reclen.record_rewrite
   6000969 ±  8%     -46.1%    3234179        iozone.4096KB_32reclen.rewrite
   4412112 ±  5%     -30.6%    3064044        iozone.4096KB_32reclen.write
    407911 ±  6%     -14.1%     350231        iozone.4096KB_4096reclen
   5645033 ± 10%     -47.3%    2977074 ±  5%  iozone.4096KB_4096reclen.frewrite
   5443644 ±  3%     -45.7%    2956973        iozone.4096KB_4096reclen.fwrite
   9344545 ±  8%     -58.4%    3883484        iozone.4096KB_4096reclen.random_write
   7819624 ± 10%     -56.3%    3413703 ±  2%  iozone.4096KB_4096reclen.record_rewrite
   5468720 ± 11%     -44.6%    3029332 ±  2%  iozone.4096KB_4096reclen.rewrite
   4997122 ±  7%     -37.3%    3132483        iozone.4096KB_4096reclen.write
   5504982 ±  9%     -42.3%    3178736 ±  3%  iozone.4096KB_512reclen.frewrite
   5520488 ±  7%     -42.5%    3173812 ±  6%  iozone.4096KB_512reclen.fwrite
   9231637 ± 13%     -58.9%    3792217        iozone.4096KB_512reclen.random_write
  10670349 ± 16%     -67.6%    3453684        iozone.4096KB_512reclen.record_rewrite
   6376172 ± 13%     -49.2%    3237695 ±  2%  iozone.4096KB_512reclen.rewrite
   4817759 ±  6%     -35.1%    3127697        iozone.4096KB_512reclen.write
    421961 ±  5%     -19.9%     338058 ±  2%  iozone.4096KB_64reclen
   5633467 ±  7%     -44.1%    3147447 ±  2%  iozone.4096KB_64reclen.frewrite
   5660179 ±  5%     -44.8%    3124977 ±  3%  iozone.4096KB_64reclen.fwrite
   7673862 ±  7%     -53.0%    3605881        iozone.4096KB_64reclen.random_write
  11265069 ± 15%     -68.4%    3559151 ±  2%  iozone.4096KB_64reclen.record_rewrite
   6544015 ±  5%     -49.2%    3322831        iozone.4096KB_64reclen.rewrite
   4506577 ± 10%     -28.6%    3217752 ±  2%  iozone.4096KB_64reclen.write
    236006 ±  4%     -13.9%     203254 ±  7%  iozone.4096KB_8reclen
   3321733 ±  5%     -24.6%    2504197 ±  5%  iozone.4096KB_8reclen.frewrite
   3436964 ±  6%     -22.2%    2674833        iozone.4096KB_8reclen.fwrite
   3140234 ± 12%     -27.0%    2293239 ± 16%  iozone.4096KB_8reclen.random_write
   3692256 ± 11%     -28.6%    2637149        iozone.4096KB_8reclen.record_rewrite
   6484428 ±  2%     -11.9%    5711723 ± 12%  iozone.4096KB_8reclen.reread
   3633536 ±  3%     -29.3%    2567758 ± 13%  iozone.4096KB_8reclen.rewrite
   3079501 ±  5%     -19.3%    2483867 ± 14%  iozone.4096KB_8reclen.write
    476193 ±  7%     -22.5%     369196 ±  8%  iozone.512KB_128reclen
   6530898 ± 17%     -46.2%    3514641 ±  3%  iozone.512KB_128reclen.frewrite
   6822052 ±  8%     -48.1%    3543008 ±  9%  iozone.512KB_128reclen.fwrite
   8081924 ± 13%     -62.1%    3060587 ± 12%  iozone.512KB_128reclen.random_write
   9905588 ± 14%     -66.8%    3286321 ± 12%  iozone.512KB_128reclen.record_rewrite
   6311295 ± 10%     -55.1%    2831485 ± 14%  iozone.512KB_128reclen.rewrite
   4269431 ±  5%     -34.2%    2811007 ± 15%  iozone.512KB_128reclen.write
   4279482 ± 15%     -36.4%    2719661 ±  2%  iozone.512KB_16reclen.frewrite
   4415628 ± 13%     -36.5%    2802469 ±  9%  iozone.512KB_16reclen.fwrite
   4095069 ± 13%     -34.8%    2669395 ±  5%  iozone.512KB_16reclen.random_write
   5485427 ± 17%     -50.2%    2732355 ±  3%  iozone.512KB_16reclen.record_rewrite
   4150782 ± 22%     -35.0%    2697202 ±  7%  iozone.512KB_16reclen.rewrite
    460266 ±  4%     -17.0%     381794 ±  3%  iozone.512KB_256reclen
   8556758 ±  8%     -43.8%    4810503 ±  9%  iozone.512KB_256reclen.frewrite
   4821544 ±  8%     -29.7%    3389921 ±  6%  iozone.512KB_256reclen.fwrite
   8131467 ± 11%     -55.6%    3612634 ±  2%  iozone.512KB_256reclen.random_write
   9058008 ±  9%     -64.8%    3190513 ±  8%  iozone.512KB_256reclen.record_rewrite
   6719047 ± 10%     -56.8%    2904750 ± 11%  iozone.512KB_256reclen.rewrite
   4373093 ±  6%     -40.7%    2592783 ±  5%  iozone.512KB_256reclen.write
    393424 ±  7%     -13.3%     341171 ±  2%  iozone.512KB_32reclen
   4895953 ±  7%     -42.6%    2811812 ± 13%  iozone.512KB_32reclen.frewrite
   5181996 ±  8%     -42.1%    3001102 ±  8%  iozone.512KB_32reclen.fwrite
   6088473 ± 17%     -47.9%    3170840 ±  7%  iozone.512KB_32reclen.random_write
   8043848 ±  8%     -61.2%    3123743 ±  6%  iozone.512KB_32reclen.record_rewrite
   5180448 ±  5%     -43.3%    2936157 ± 10%  iozone.512KB_32reclen.rewrite
   3782107 ± 13%     -28.2%    2713878 ±  7%  iozone.512KB_32reclen.write
   6285151 ± 17%     -50.6%    3107107 ±  3%  iozone.512KB_512reclen.frewrite
   6338153 ±  9%     -53.6%    2940734 ±  8%  iozone.512KB_512reclen.fwrite
   7737841 ±  8%     -52.8%    3654890 ±  5%  iozone.512KB_512reclen.random_write
   7350493 ± 16%     -55.0%    3304559 ±  4%  iozone.512KB_512reclen.record_rewrite
   6702196 ±  7%     -55.6%    2975296 ±  7%  iozone.512KB_512reclen.rewrite
   4282814 ± 10%     -38.4%    2637095 ±  7%  iozone.512KB_512reclen.write
    461038 ±  4%     -21.9%     360197 ±  4%  iozone.512KB_64reclen
   5976515 ±  4%     -48.3%    3089257 ±  5%  iozone.512KB_64reclen.frewrite
   6215990 ±  5%     -48.7%    3190509 ±  3%  iozone.512KB_64reclen.fwrite
   7028609 ± 10%     -51.9%    3378061 ±  5%  iozone.512KB_64reclen.random_write
  11056059 ±  5%     -12.0%    9732466 ±  6%  iozone.512KB_64reclen.read
   9887177 ± 14%     -66.7%    3288094 ±  8%  iozone.512KB_64reclen.record_rewrite
   6086083 ±  4%     -49.6%    3065835 ±  8%  iozone.512KB_64reclen.rewrite
   4121861 ± 10%     -33.8%    2729029 ±  6%  iozone.512KB_64reclen.write
   5478377 ±  8%     +10.9%    6076595        iozone.512KB_8reclen.freread
   3144247 ±  5%     -23.4%    2407541 ±  7%  iozone.512KB_8reclen.frewrite
   3264788 ±  8%     -22.0%    2546212 ±  3%  iozone.512KB_8reclen.fwrite
    546111 ±  3%     -21.6%     428357 ±  2%  iozone.524288KB_1024reclen
   7147373 ±  8%     -51.7%    3453896        iozone.524288KB_1024reclen.frewrite
   7619267 ±  7%     -54.3%    3479943        iozone.524288KB_1024reclen.fwrite
   8971485 ±  4%     -59.7%    3618266        iozone.524288KB_1024reclen.random_write
  11472240 ±  6%      +7.7%   12360252 ±  4%  iozone.524288KB_1024reclen.read
  16359250 ±  4%     -77.2%    3723122        iozone.524288KB_1024reclen.record_rewrite
   8956596 ±  3%     -58.8%    3692978        iozone.524288KB_1024reclen.rewrite
   5561660 ±  5%     -39.8%    3349116        iozone.524288KB_1024reclen.write
    544356 ±  3%     -24.1%     413231 ±  2%  iozone.524288KB_128reclen
   7586281 ±  4%     -54.3%    3468246        iozone.524288KB_128reclen.frewrite
   7799627 ±  4%     -55.6%    3460094        iozone.524288KB_128reclen.fwrite
   8203000 ±  5%     -58.8%    3375607        iozone.524288KB_128reclen.random_write
  14847756 ± 14%     -74.7%    3761943        iozone.524288KB_128reclen.record_rewrite
   8675467 ±  5%     -57.2%    3714167        iozone.524288KB_128reclen.rewrite
   5444683 ±  7%     -39.0%    3321742        iozone.524288KB_128reclen.write
   4804260 ± 10%     -39.9%    2886096 ±  3%  iozone.524288KB_16384reclen.frewrite
   4932218 ± 13%     -41.0%    2910119 ±  2%  iozone.524288KB_16384reclen.fwrite
   6144575 ±  9%     -48.1%    3186721 ±  3%  iozone.524288KB_16384reclen.random_write
   6068686 ±  9%     -52.3%    2891868        iozone.524288KB_16384reclen.record_rewrite
   6144818 ± 10%     -47.9%    3202812 ±  2%  iozone.524288KB_16384reclen.rewrite
   4393484 ±  4%     -33.1%    2939119 ±  2%  iozone.524288KB_16384reclen.write
    531931 ±  6%     -20.6%     422173 ±  3%  iozone.524288KB_2048reclen
   5305317 ± 10%     -43.0%    3025608 ±  4%  iozone.524288KB_2048reclen.frewrite
   5693440 ±  9%     -45.9%    3082446 ±  3%  iozone.524288KB_2048reclen.fwrite
   7698042 ± 11%     -55.0%    3462543 ±  2%  iozone.524288KB_2048reclen.random_write
  15532439 ± 10%     -77.3%    3527035 ±  3%  iozone.524288KB_2048reclen.record_rewrite
   7919782 ± 15%     -54.8%    3582221 ±  4%  iozone.524288KB_2048reclen.rewrite
   5033940 ± 12%     -36.7%    3186813        iozone.524288KB_2048reclen.write
    551674 ±  3%     -25.1%     413284 ±  3%  iozone.524288KB_256reclen
   7720443 ±  5%     -55.4%    3440267 ±  2%  iozone.524288KB_256reclen.frewrite
   7697144 ±  2%     -55.1%    3454789        iozone.524288KB_256reclen.fwrite
   8736880 ±  4%     -59.9%    3503065        iozone.524288KB_256reclen.random_write
  16137422 ±  5%     -77.1%    3703151        iozone.524288KB_256reclen.record_rewrite
   9146274 ±  5%     -58.9%    3759435        iozone.524288KB_256reclen.rewrite
   5495525 ±  6%     -39.3%    3338003 ±  2%  iozone.524288KB_256reclen.write
   5118402 ± 12%     -44.7%    2831910 ±  3%  iozone.524288KB_4096reclen.frewrite
   5225137 ± 10%     -44.5%    2897829 ±  4%  iozone.524288KB_4096reclen.fwrite
   6682671 ±  9%     -50.9%    3282453 ±  2%  iozone.524288KB_4096reclen.random_write
  10213606 ± 19%     -69.7%    3092221 ±  3%  iozone.524288KB_4096reclen.record_rewrite
   6601112 ± 13%     -49.0%    3365783 ±  2%  iozone.524288KB_4096reclen.rewrite
   4543441 ±  5%     -34.3%    2982887 ±  3%  iozone.524288KB_4096reclen.write
    563145 ±  2%     -24.3%     426078 ±  3%  iozone.524288KB_512reclen
   7877345 ±  4%     -55.8%    3482088        iozone.524288KB_512reclen.frewrite
   7911042 ±  3%     -56.0%    3480149        iozone.524288KB_512reclen.fwrite
   9103372 ±  6%     -60.4%    3603133        iozone.524288KB_512reclen.random_write
  16296711 ±  3%     -77.2%    3712815        iozone.524288KB_512reclen.record_rewrite
   9176768 ±  6%     -59.3%    3732033        iozone.524288KB_512reclen.rewrite
   5593247 ±  6%     -40.3%    3341511 ±  3%  iozone.524288KB_512reclen.write
    505113           -21.1%     398547        iozone.524288KB_64reclen
   7015773 ±  4%     -50.9%    3446298        iozone.524288KB_64reclen.frewrite
   7106825 ±  2%     -51.4%    3451915        iozone.524288KB_64reclen.fwrite
   7018984 ±  3%     -54.3%    3207930        iozone.524288KB_64reclen.random_write
  13071765 ± 10%     -71.8%    3692656        iozone.524288KB_64reclen.record_rewrite
   7791774 ±  3%     -53.2%    3646300        iozone.524288KB_64reclen.rewrite
   5080218           -35.4%    3282308 ±  2%  iozone.524288KB_64reclen.write
   4473639 ±  6%     -38.0%    2772538 ±  3%  iozone.524288KB_8192reclen.frewrite
   4665490 ± 13%     -38.2%    2885216 ±  3%  iozone.524288KB_8192reclen.fwrite
   5959551 ±  9%     -46.4%    3194100 ±  2%  iozone.524288KB_8192reclen.random_write
   6651150 ± 16%     -56.5%    2894310 ±  2%  iozone.524288KB_8192reclen.record_rewrite
   5990381 ±  9%     -45.7%    3253373 ±  3%  iozone.524288KB_8192reclen.rewrite
   4124475 ±  5%     -28.9%    2931933 ±  2%  iozone.524288KB_8192reclen.write
    366230 ± 11%     -23.1%     281729 ± 20%  iozone.64KB_16reclen
   4199734 ± 11%     -37.5%    2626023 ± 19%  iozone.64KB_16reclen.frewrite
   3822917 ±  9%     -33.1%    2558035 ± 16%  iozone.64KB_16reclen.fwrite
   3601543 ± 13%     -40.6%    2139824 ± 17%  iozone.64KB_16reclen.random_write
   4056590 ±  9%     -47.7%    2120903 ± 16%  iozone.64KB_16reclen.record_rewrite
   3459658 ± 13%     -39.8%    2083160 ± 18%  iozone.64KB_16reclen.rewrite
   8427164 ±  4%     -20.1%    6732788 ± 13%  iozone.64KB_16reclen.stride_read
   6120260 ± 12%     -36.5%    3889010 ± 10%  iozone.64KB_32reclen.frewrite
   4801505 ± 15%     -47.0%    2545830 ± 14%  iozone.64KB_32reclen.record_rewrite
   3263725 ± 16%     -34.9%    2124296 ± 10%  iozone.64KB_32reclen.write
   4880991 ± 17%     -43.0%    2784004 ± 15%  iozone.64KB_64reclen.fwrite
   5292359 ± 17%     -44.7%    2928253 ± 12%  iozone.64KB_64reclen.random_write
   5648278 ±  7%     -48.1%    2930218 ± 14%  iozone.64KB_64reclen.record_rewrite
   4698367 ± 18%     -42.1%    2719953 ± 12%  iozone.64KB_64reclen.rewrite
    256272 ±  8%     -20.3%     204300 ± 19%  iozone.64KB_8reclen
   3018760 ±  5%     -28.6%    2154883 ± 17%  iozone.64KB_8reclen.fwrite
   2589554 ±  9%     -30.9%    1790083 ± 20%  iozone.64KB_8reclen.random_write
   2776391 ±  5%     -34.0%    1831472 ± 20%  iozone.64KB_8reclen.record_rewrite
   9689106 ±  6%     -24.4%    7325245 ± 22%  iozone.64KB_8reclen.reread
   2780070 ±  8%     -26.5%    2044117 ± 19%  iozone.64KB_8reclen.rewrite
    523517 ±  5%     -21.4%     411517 ±  3%  iozone.65536KB_1024reclen
   7309716 ±  6%     -52.8%    3449150        iozone.65536KB_1024reclen.frewrite
   7136170 ± 10%     -51.8%    3436908        iozone.65536KB_1024reclen.fwrite
   8589516 ±  8%     -57.5%    3653446        iozone.65536KB_1024reclen.random_write
  16522904 ±  3%     -77.4%    3740756        iozone.65536KB_1024reclen.record_rewrite
   8237647 ± 13%     -55.2%    3693916        iozone.65536KB_1024reclen.rewrite
   5028003 ± 15%     -32.8%    3379528        iozone.65536KB_1024reclen.write
    532763 ±  3%     -25.6%     396335 ±  3%  iozone.65536KB_128reclen
   7333316 ±  2%     -52.8%    3461546        iozone.65536KB_128reclen.frewrite
   7291372 ±  6%     -52.5%    3461086 ±  2%  iozone.65536KB_128reclen.fwrite
  11653668 ±  2%      -7.9%   10737854 ±  5%  iozone.65536KB_128reclen.random_read
   8279730 ±  4%     -58.6%    3425741 ±  6%  iozone.65536KB_128reclen.random_write
  15784970 ±  6%     -77.4%    3564663 ± 13%  iozone.65536KB_128reclen.record_rewrite
   8209229 ±  4%     -57.6%    3480549 ± 10%  iozone.65536KB_128reclen.rewrite
   5385626 ±  7%     -38.9%    3292029 ±  7%  iozone.65536KB_128reclen.write
    364555 ±  5%     -14.9%     310230 ±  3%  iozone.65536KB_16384reclen
   6121630 ±  8%     -43.7%    3444762 ±  5%  iozone.65536KB_16384reclen.frewrite
   5977371 ± 11%     -39.8%    3600389 ±  2%  iozone.65536KB_16384reclen.fwrite
   5875081 ±  7%     -46.1%    3168819        iozone.65536KB_16384reclen.random_write
   6547127 ± 12%     -55.1%    2937757 ±  2%  iozone.65536KB_16384reclen.record_rewrite
   6309500 ±  6%     -49.4%    3194181        iozone.65536KB_16384reclen.rewrite
   4280168 ±  9%     -30.3%    2981202        iozone.65536KB_16384reclen.write
    523194 ±  3%     -24.7%     393917 ±  3%  iozone.65536KB_2048reclen
   6033279 ±  7%     -47.9%    3140454 ±  4%  iozone.65536KB_2048reclen.frewrite
   5694042 ± 10%     -45.9%    3078205 ±  3%  iozone.65536KB_2048reclen.fwrite
   8145174 ± 12%     -59.9%    3266812 ± 11%  iozone.65536KB_2048reclen.random_write
  15342282 ±  6%     -76.6%    3590795 ±  2%  iozone.65536KB_2048reclen.record_rewrite
   8223228 ±  8%     -56.4%    3581365 ±  2%  iozone.65536KB_2048reclen.rewrite
   4780028 ± 13%     -32.8%    3211311        iozone.65536KB_2048reclen.write
    533351 ±  3%     -24.5%     402890 ±  4%  iozone.65536KB_256reclen
  12079128 ±  2%      -6.9%   11241418 ±  5%  iozone.65536KB_256reclen.bkwd_read
   7334735 ±  8%     -52.5%    3480491        iozone.65536KB_256reclen.frewrite
   7534682 ±  3%     -53.8%    3481345        iozone.65536KB_256reclen.fwrite
   8373364 ± 10%     -58.8%    3453897 ±  9%  iozone.65536KB_256reclen.random_write
  15885493 ±  5%     -76.3%    3761757        iozone.65536KB_256reclen.record_rewrite
   8576540 ±  5%     -58.7%    3543897 ± 12%  iozone.65536KB_256reclen.rewrite
   5497339 ±  5%     -41.8%    3201097 ± 12%  iozone.65536KB_256reclen.write
    447161 ±  7%     -11.7%     395001 ±  5%  iozone.65536KB_4096reclen
  10988607 ±  3%      +7.3%   11794894        iozone.65536KB_4096reclen.bkwd_read
   5013257 ± 15%     -39.4%    3039515 ±  2%  iozone.65536KB_4096reclen.frewrite
   4813077 ± 13%     -36.3%    3064406 ±  3%  iozone.65536KB_4096reclen.fwrite
   6399770 ± 10%     -46.8%    3407474 ±  2%  iozone.65536KB_4096reclen.random_write
  10205662 ± 19%     -66.2%    3454282 ±  4%  iozone.65536KB_4096reclen.record_rewrite
   6482710 ±  9%     -48.2%    3357054 ±  2%  iozone.65536KB_4096reclen.rewrite
   4401916 ± 11%     -30.4%    3065639        iozone.65536KB_4096reclen.write
    535125 ±  3%     -23.3%     410409        iozone.65536KB_512reclen
   7295801 ±  9%     -52.2%    3487131        iozone.65536KB_512reclen.frewrite
   7315293 ±  5%     -52.5%    3476743        iozone.65536KB_512reclen.fwrite
   8838896 ±  5%     -59.8%    3555162 ±  4%  iozone.65536KB_512reclen.random_write
  16004485 ±  5%     -76.7%    3725394        iozone.65536KB_512reclen.record_rewrite
   8725959 ±  5%     -58.4%    3632000 ±  5%  iozone.65536KB_512reclen.rewrite
   5498540 ±  7%     -40.1%    3291327 ±  6%  iozone.65536KB_512reclen.write
    493180 ±  2%     -22.4%     382816        iozone.65536KB_64reclen
   6810831 ±  6%     -50.0%    3407101        iozone.65536KB_64reclen.frewrite
   6441149 ± 15%     -47.1%    3406167        iozone.65536KB_64reclen.fwrite
   7150939 ±  4%     -53.0%    3361410        iozone.65536KB_64reclen.random_write
  13342191 ±  8%     -72.4%    3680370        iozone.65536KB_64reclen.record_rewrite
   7346364 ±  4%     -50.4%    3644451        iozone.65536KB_64reclen.rewrite
   5059274 ±  5%     -34.1%    3333866        iozone.65536KB_64reclen.write
    367800 ±  8%     -13.0%     319920 ±  4%  iozone.65536KB_8192reclen
   5130108 ± 13%     -38.7%    3144695 ±  2%  iozone.65536KB_8192reclen.frewrite
   5282928 ± 14%     -43.3%    2993237 ±  4%  iozone.65536KB_8192reclen.fwrite
   5864239 ± 13%     -44.5%    3255758 ±  2%  iozone.65536KB_8192reclen.random_write
   7447215 ± 12%     -60.8%    2921843 ±  9%  iozone.65536KB_8192reclen.record_rewrite
   6015508 ± 11%     -46.1%    3240985        iozone.65536KB_8192reclen.rewrite
   4093019 ± 10%     -26.5%    3007445        iozone.65536KB_8192reclen.write
    475130 ± 12%     -17.0%     394591 ±  8%  iozone.8192KB_1024reclen
   6130421 ± 12%     -42.9%    3498269 ±  2%  iozone.8192KB_1024reclen.frewrite
   6337955 ± 16%     -45.0%    3486354 ±  5%  iozone.8192KB_1024reclen.fwrite
   9934170 ±  7%     -61.8%    3796260 ±  3%  iozone.8192KB_1024reclen.random_write
  15509021 ±  5%     -76.1%    3701585 ±  3%  iozone.8192KB_1024reclen.record_rewrite
   6870785 ± 13%     -49.9%    3442812 ±  2%  iozone.8192KB_1024reclen.rewrite
   4989329 ± 12%     -35.6%    3210789 ±  2%  iozone.8192KB_1024reclen.write
    465061           -21.4%     365480 ±  3%  iozone.8192KB_128reclen
   6065060 ±  8%     -45.0%    3337027 ±  2%  iozone.8192KB_128reclen.frewrite
   6493273 ±  5%     -49.8%    3259540        iozone.8192KB_128reclen.fwrite
   9439549 ±  5%     -59.4%    3833701        iozone.8192KB_128reclen.random_write
  14670770 ±  2%     -75.0%    3674591        iozone.8192KB_128reclen.record_rewrite
   7314592 ±  4%     -51.4%    3557764 ±  2%  iozone.8192KB_128reclen.rewrite
   5108572 ±  7%     -34.4%    3349232        iozone.8192KB_128reclen.write
    314148 ±  5%     -13.1%     272915 ±  2%  iozone.8192KB_16reclen
   4553655 ±  7%     -34.4%    2984927 ±  2%  iozone.8192KB_16reclen.frewrite
   4576435 ±  2%     -35.0%    2975972        iozone.8192KB_16reclen.fwrite
   4601444 ± 11%     -37.3%    2883163 ±  6%  iozone.8192KB_16reclen.random_write
   6059685 ± 12%     -47.8%    3164798        iozone.8192KB_16reclen.record_rewrite
   4987759 ±  3%     -36.2%    3183789        iozone.8192KB_16reclen.rewrite
    462578 ±  8%     -20.2%     368979 ± 11%  iozone.8192KB_2048reclen
   6306206 ± 10%     -43.2%    3580659 ±  7%  iozone.8192KB_2048reclen.frewrite
   6659820 ± 16%     -44.3%    3709375 ±  6%  iozone.8192KB_2048reclen.fwrite
   9498869 ±  8%     -62.0%    3614123 ±  5%  iozone.8192KB_2048reclen.random_write
  14512262 ±  5%     -75.4%    3574411 ±  5%  iozone.8192KB_2048reclen.record_rewrite
   6602412 ± 11%     -49.9%    3304954 ±  4%  iozone.8192KB_2048reclen.rewrite
    466781 ±  5%     -20.2%     372625 ±  4%  iozone.8192KB_256reclen
   6386508 ±  8%     -47.9%    3325742 ±  3%  iozone.8192KB_256reclen.frewrite
   5820585 ± 11%     -43.1%    3314745 ±  3%  iozone.8192KB_256reclen.fwrite
   9800951 ±  6%     -61.3%    3789649 ±  3%  iozone.8192KB_256reclen.random_write
  14772982 ±  8%     -75.3%    3642014        iozone.8192KB_256reclen.record_rewrite
   7350256 ±  5%     -51.3%    3580211        iozone.8192KB_256reclen.rewrite
   5247001 ±  4%     -36.6%    3328082        iozone.8192KB_256reclen.write
   5460768 ±  8%     -43.4%    3091787 ±  4%  iozone.8192KB_32reclen.frewrite
   5534873 ±  5%     -42.6%    3179338        iozone.8192KB_32reclen.fwrite
   6216039 ± 17%     -47.5%    3263073 ±  7%  iozone.8192KB_32reclen.random_write
   8438285 ± 22%     -59.2%    3443608        iozone.8192KB_32reclen.record_rewrite
   5910033 ±  6%     -44.6%    3274775 ±  5%  iozone.8192KB_32reclen.rewrite
    430569 ±  6%     -17.9%     353551 ±  4%  iozone.8192KB_4096reclen
   8002703 ± 11%     -36.7%    5069052 ±  6%  iozone.8192KB_4096reclen.frewrite
   4862899 ± 12%     -27.2%    3538752 ±  8%  iozone.8192KB_4096reclen.fwrite
   8342306 ± 11%     -57.6%    3541294 ±  3%  iozone.8192KB_4096reclen.random_write
  10085813 ±  5%     -67.3%    3297639 ±  4%  iozone.8192KB_4096reclen.record_rewrite
   6381708 ±  9%     -49.2%    3240446        iozone.8192KB_4096reclen.rewrite
   4568275 ±  9%     -35.5%    2948307 ±  2%  iozone.8192KB_4096reclen.write
    490409 ±  2%     -19.8%     393423 ± 10%  iozone.8192KB_512reclen
   6399076 ± 11%     -47.9%    3335299 ±  4%  iozone.8192KB_512reclen.frewrite
   5784862 ±  8%     -42.4%    3332431 ±  4%  iozone.8192KB_512reclen.fwrite
   9010939 ± 16%     -57.8%    3800958 ±  2%  iozone.8192KB_512reclen.random_write
  15187696 ±  3%     -76.0%    3652068 ±  2%  iozone.8192KB_512reclen.record_rewrite
   6918403 ±  6%     -48.8%    3545527 ±  2%  iozone.8192KB_512reclen.rewrite
   4858375 ± 10%     -33.5%    3232714 ±  4%  iozone.8192KB_512reclen.write
    434205 ±  6%     -19.5%     349456 ±  2%  iozone.8192KB_64reclen
   6063804 ±  4%     -45.6%    3297539        iozone.8192KB_64reclen.frewrite
   6053168 ±  3%     -47.7%    3164408 ±  6%  iozone.8192KB_64reclen.fwrite
   8298214 ± 12%     -55.4%    3702040        iozone.8192KB_64reclen.random_write
  12308732 ±  9%     -70.3%    3651140        iozone.8192KB_64reclen.record_rewrite
   6862988 ±  6%     -50.1%    3426635 ±  6%  iozone.8192KB_64reclen.rewrite
   4552180 ± 13%     -30.0%    3186567 ±  6%  iozone.8192KB_64reclen.write
    387354 ±  4%     -15.3%     328219 ±  2%  iozone.8192KB_8192reclen
   6174265 ±  7%     -49.0%    3149477        iozone.8192KB_8192reclen.frewrite
   6270247 ±  3%     -49.3%    3180202        iozone.8192KB_8192reclen.fwrite
   6440330 ±  8%     -50.0%    3219047 ±  4%  iozone.8192KB_8192reclen.random_write
   6417631 ±  7%     -49.6%    3233756 ±  2%  iozone.8192KB_8192reclen.record_rewrite
   6213176 ±  6%     -48.9%    3174174        iozone.8192KB_8192reclen.rewrite
   4263827 ± 11%     -32.8%    2866624 ±  4%  iozone.8192KB_8192reclen.write
    238775 ±  8%      -8.6%     218130        iozone.8192KB_8reclen
   3470213 ±  6%     -21.4%    2727307        iozone.8192KB_8reclen.frewrite
   3492178 ±  8%     -21.7%    2734116        iozone.8192KB_8reclen.fwrite
   3088507 ± 11%     -22.7%    2385914        iozone.8192KB_8reclen.random_write
   3794719 ± 12%     -29.6%    2673377        iozone.8192KB_8reclen.record_rewrite
   3626974 ± 11%     -20.3%    2890733        iozone.8192KB_8reclen.rewrite
   4092925 ±  2%     -18.5%    3337298        iozone.average_KBps
  55650360 ±  3%     -44.2%   31052398        iozone.frewrite_KBps
  53439424 ±  3%     -43.6%   30144851        iozone.fwrite_KBps
  64647843 ±  5%     -52.7%   30607658        iozone.random_write_KBps
  94823016 ±  5%     -67.5%   30823219        iozone.record_rewrite_KBps
  59841456 ±  3%     -48.9%   30554034        iozone.rewrite_KBps
    733.66            +1.3%     743.16        iozone.time.elapsed_time
    733.66            +1.3%     743.16        iozone.time.elapsed_time.max
      6.83 ±  5%     +31.7%       9.00        iozone.time.percent_of_cpu_this_job_got
     52.33 ±  3%     +34.3%      70.29        iozone.time.system_time
  41427226 ±  5%     -32.2%   28071504        iozone.write_KBps




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


