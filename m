Return-Path: <linux-btrfs+bounces-4622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9F8B5D7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC6F28547D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3682D86;
	Mon, 29 Apr 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRwd8EOM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56393745C5;
	Mon, 29 Apr 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404122; cv=fail; b=lKDVOyo2cZXmW+aNBOJgDtGAmaQzybtjC7fKvYsn5JdCGnHnDzPn+2ZIqRhlX25II+/E7HCchC5/IBfuY0TERDzCZYaFdKva7g8Hu8YgTvjl4LGFzhs8t9xgOyWgHGyajBR4j8vs1HaR+/BH2hrfdf2RQPdKwtRgzXuqZOkIehs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404122; c=relaxed/simple;
	bh=dknPQHKNQ2Vkr+pke/cSDozstUbPjYEwptM4JWteSC8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PmIIMdBQK64KKF5zNwClZKtm9MMXmgBlmi8Wma2BgHHaTLNRxdttXmRxACu4nx/WYfZxrqefnFaKNmkGBCgikhy6zkwGvDNROZ3iQunHhog4SD3ISMJQXQMvjirUfVjcDUde0JdL+aRNOUPX7+JFtuWyzum3hyvZy+f1u+c3JqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRwd8EOM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714404120; x=1745940120;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dknPQHKNQ2Vkr+pke/cSDozstUbPjYEwptM4JWteSC8=;
  b=iRwd8EOME1I7a7PM5o7CYsyOo+oJJgRwnB+8GOfrCZtdixeWajORN9lk
   x2/B06KuGBD+2t+W7wFNB8VLSPxSo38A3CbACaIri4lxDYcChKrAjIG6t
   1hnPBrNWSA22kPhYKK8wPtrvDVi4T130h1zhbYHV9LMYgoLqLMs1XXbyj
   Ne5Ia4XSMOynaP8NL/oS1FDESw9GJqtRILv8K8HC3ASYmzNSIt5HiqsV5
   PGYcL/+Vnvnzwc94ScmaxueKiSUNgidtB0giaomvNAaQibd8of45Ptu7/
   BUfjaZse7+hEI3Ifj66fqh+DfbqJg3vhgydkHPSY04jF4gbKJV6XQKIla
   Q==;
X-CSE-ConnectionGUID: LVjCQPqbQ7eZnoXTcuAmpQ==
X-CSE-MsgGUID: C7L+HY1aSRmtfWE5UkutWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13897087"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13897087"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 08:22:00 -0700
X-CSE-ConnectionGUID: r0psZAfNQZ2Ymb8dZHOpMA==
X-CSE-MsgGUID: OFQ6q5hsR+u74cL3Xn+CMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30829593"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 08:22:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 08:21:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 08:21:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 08:21:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG9XrTg+xPMthTj3WWgkPabHhpGtJlPKVBW3NgtZ5Br4JYElxvfxzVYY+JGa+xNPWPqwSMVXsvh5yDxpykjpei/g/nfirHPj1aodVQAgQwIegRosIXax9tqPrgu7tE6x+nYfTnnz5F1Zhp7djgqLpcTohhawS7XFChxpWz3Dy0Upa0ZN2QC0rjLBFU+4+17w+AfePZqH8218S1RboCtBdJ28QTQq3RQCaas1b4B7k09nzQponLt/PUzQ2356BshIZJMo3oqHEE4hPKV5dC6tuZMqUlFal4TJubOvxSp0c8XBGaOrUHva8ygv6bueUZ2iysxvljOWsU/edcXZaEETtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y9r3tL57Z19DEgME1mKP7yxvjyPkLZCKLd0TykmGPE=;
 b=DDVrebpwU1zCjZuEuP5QbOmh8oX7TshVeeARgxQORJ1PCE2/yekA5Mp5xLdJpVUUNGDOeT7gH33pWzEQWc2Rb4u1mRH2Al5xusZ1Y0pQJ8znl8Aw8hyr8slJuSJEyDXzGExwuOfF+zGGNBCzHn4SfJZnY3x5RNFDdGGWKctfTaKjZqco+v9ftnDnHtV2peK58uo+3Kmzo01zWAxlecTgV0gHa5qHLkZS9RBsZWhsML8K7rpCezMf4K/WOqXTq6S4qtP/CQ6WK5XZM1KlDvOqh7RQm6kZjKJ9+rrXVcNIlTa4Gco0UHETsGXCY24U9S8mlFbvtR5uDmRNHNPrkFk2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:21:55 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4%4]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 15:21:54 +0000
Date: Mon, 29 Apr 2024 16:21:46 +0100
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Josef Bacik <josef@toxicpanda.com>, <herbert@gondor.apana.org.au>
CC: <clm@fb.com>, <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <qat-linux@intel.com>, <embg@meta.com>,
	<cyan@meta.com>, <brian.will@intel.com>, <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <Zi+7CnWeF9+DUXpK@gcabiddu-mobl.ger.corp.intel.com>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429135645.GA3288472@perftesting>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|IA0PR11MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 0295e4e5-acfa-4b6d-76e3-08dc686019fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NnRUI8ubGLc/O4sn40ywcvAh+3TyDxxD7zSvdw7WF0IQZTpGSf3hOYfD3UWa?=
 =?us-ascii?Q?oWKdB8htjat2S9r/aqk4mUBW6se9exa7v0e7nPeqWrivzWyd79e0dSMN1zfd?=
 =?us-ascii?Q?SbuBhQklaqpwrpuYNTWeESE95PvVso3Pa/MVvjyaA2Ph5FhMbscMaWkcKHB/?=
 =?us-ascii?Q?/PIvSgLT9DoqIMltK9YpIBHfByHi08amQc6vj5jop35/1Y+LBpg0TT2P1KPs?=
 =?us-ascii?Q?ffuU/8CgNBXaluUerhTMWxGZcYRPSPslrJBmHsoBdZrIPMsUJ7zAiMGyxpT2?=
 =?us-ascii?Q?/GjuZ1UGta6AFLu8Ewz0U1Zxv9Jc34qjFkflnUKBccmGZyuNo6F7XrPJmgJp?=
 =?us-ascii?Q?Of6WVbfPUELi+x75S7wKkCGpi6XL19JsxPaqzLx7jkmcsSmJzDnYrbdmcMIN?=
 =?us-ascii?Q?6RCbOi8fT4AmcB0dX//TESL1ICxoSy54j6F/ZW1HvnebAQvdBpj3ZkLz/Fgy?=
 =?us-ascii?Q?ltITgJE24Tcq0Wt3MBNtlJakB/O+GHQFErlx6oYpt7FyrJ0fa4B8LoyWhXFY?=
 =?us-ascii?Q?asumh1vff8fBI0tYzxan3OZInBYZqYDeM59k+A0LhscvLfqpQcAUMNSp2c4m?=
 =?us-ascii?Q?AzjEBM0DrzLQU9t0bVj5SfsV2vOdcUNezMAq5XCRyymohUHeVS+2bGfgiV09?=
 =?us-ascii?Q?f58mv3X9FXEov5I1ZXpJTCwQxyzLtRFcQJjK2eZN3BkI1blfekzA6zW8nt/p?=
 =?us-ascii?Q?0YAwfORTG1P0TbZobQiboQNcnGn2x4rQiYwKq+1IEGb1TpqHg3+toPtBOBGs?=
 =?us-ascii?Q?/+P+SJnydfZVTUGq624lMAhs8Ic495QjRGRiI0Jg6FFwNMc1f2IZbgjfDIDs?=
 =?us-ascii?Q?3G7tDzOl6oARjh+hWRfbFoaXnH6JvsQUZjfMtyJcr7z0aBTp1wCJxLCcLYYi?=
 =?us-ascii?Q?tXepoWMNZ2XPhjoxULnpYmOuh2nM9urQvzy27TpEkqY5qCg4z1nlgUDzFzP/?=
 =?us-ascii?Q?gzPx74WvNNSF8igM6XABGZeQ64l1dTWpucUfPJ+vKFWvJNIqTRA1eMnd9WRx?=
 =?us-ascii?Q?0oQbJ86gCidl/pkwm0lj8DWK+AdAO4HDbM/efoWpUQ52QyMIbXVxmjqTTNVW?=
 =?us-ascii?Q?8EKb/h2cVNMg4DV4YfSGn1Ah9c3IyLo+3KTUXGOVwKpWBlW9Nrn8di1sveGd?=
 =?us-ascii?Q?+a7Gsl0ecEQhD8A7Xq6iMkE4O5n5hdp9LOmtyRONujOnmLOY9x9rjQoFRh5o?=
 =?us-ascii?Q?51IO3qOPSQCKN7wBVLyFWnI2OyIQB0FUOYpLVxmc1WZB+/xIs1PmED0q8otk?=
 =?us-ascii?Q?nbpBS+LoAP0TJNoarZk8PmWWgeUvwAWvMtlGFitDZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIJMhVqg9wugnbHP0w7ZN8JFDLDlPa08zKfuDTAdy63yh3wzuO7hMAaK9HJu?=
 =?us-ascii?Q?mts5bDGp5O9Oq9mXELTjaWmvCfxiMARps75QU447rHe0y4vhSO1cvCFIcnkO?=
 =?us-ascii?Q?nyMs2XAq4lsze17ZC4jXNUp6yXT4zgqgtaCad6yuq1pKHyi5hQDtz/EAYM9F?=
 =?us-ascii?Q?PpHsFY3f3JnzWtOnIW8X0qe5onEoewEVVUq3BZT0XIGvb5F9EY3wwmIqFGn5?=
 =?us-ascii?Q?jH/AZtcRVzLgGOWeFCGRbsTrhJopXPRfbGua210yzP31WmXJgT2rSfkB66Kq?=
 =?us-ascii?Q?XAlkbntxZa2InJxmxJKKG6ZOXzvh5W3ozKXXKMj6zaJ8W5EVx3WpopR+JveV?=
 =?us-ascii?Q?pEe3Q+Bu2mVpMXtz395ecO2LXchJDEyJGDNa8fyW4bU9rmQCG9fQktasAZOj?=
 =?us-ascii?Q?MVXwBvwmQStWZyKemiK++QhFwLRfgdhoSKXg7qUFYihI56c3d/isUNGhwdU3?=
 =?us-ascii?Q?jFfBC2/aZifF62aSALPmxJ+3hH5VbY3MY2HfKprT42VEyABxPsNdZ0Vv5qMU?=
 =?us-ascii?Q?zCXxS4wpOPuph5IUnHC4fC6wfpmo9kFKdmZ13NovK2medFHthN1x84a6KGqW?=
 =?us-ascii?Q?rJfnGiEyfbVgl5A3ZXf4/1RnH/VJqpkoFUwvNJ1YeLxbW4uLqsy3ElDvPCzZ?=
 =?us-ascii?Q?cOUmZsZ+I9z6qFluOHxOh0u/cYjbvwp/2Bq/R7otqODihN/20Od9HlY2/24O?=
 =?us-ascii?Q?kxEVC9mXPxTsariYVW1njb8pfur2s7XY2Pl4jFLa+VhAURCKQ0a09yO8fseN?=
 =?us-ascii?Q?dMtwKTwqVqcVRqZ1FZsORxwkCm2DR2bbyBSegmILg+dAZUPm2oFIDXeMEOEO?=
 =?us-ascii?Q?cX0a8uegUiqC2PKpo/zogTqD1FM4RPueW/kubiDwz8P4axvALtVYPw2guzHo?=
 =?us-ascii?Q?4mKI5/YlaBFDzP3epo/QERTQKF9dadLwhG0zWTqGbdzbqudLdlZFvzZO6lVp?=
 =?us-ascii?Q?v7gktHQaXilfqnUVnG6p61KREg0ZSB6f/N871KlCFBfws4mTonZC+VXFYLHH?=
 =?us-ascii?Q?iXC9JEwxhrzlDRs0FttpnniMAyOeOCzbYbNAPlPxULeEcp4K3k8bipkThFtg?=
 =?us-ascii?Q?eIVdG12BnyO2k6qxtILzDq03+dp3gblKrppMfuqysk5pLjam8HUB78avtYrN?=
 =?us-ascii?Q?uJkKzrxk+sSC1WceUlGzHy5yLxqjl1N3Ll6f4fYlSPbJuTLug4Y66CToYR7M?=
 =?us-ascii?Q?B9dPl/D+Dt1rmmYEP59d1auPfkA7LQR/bfMNgmjXynxYv9nveyD9Cl/q4Lyq?=
 =?us-ascii?Q?oqJTboESjuUcIDkCAmuEBgouQPk4WeC+YGOaYf1NczziCKhU3X/LGjR+qu6y?=
 =?us-ascii?Q?+dGVwLtTxVBliZCQzTfBALHeOg9mrhk5VdIanUvk4X85RPIpYcSksODjG9mA?=
 =?us-ascii?Q?ZRuU9ejK/XP8p8+qN3ILOdI1Or11r6cfdO3XEPBsoLX0RctFo39DwbQPPgn1?=
 =?us-ascii?Q?q0oczxpdM/Y2aK/3KYzlsFsoMwI0Hp3p6yKtl1sH9baAUPrTek2yLwlucK2M?=
 =?us-ascii?Q?uytpFHP3IO0atSbmpsJXNNmxsOHRPztAgIJyziI3uwzzN+3FQMKNDhyfsZs2?=
 =?us-ascii?Q?Ut5WubkrQ7nnrlcqBzvVt8cM4kIr+EeX1xNsbOZRjAL7XsLMTGygk9tCxx4M?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0295e4e5-acfa-4b6d-76e3-08dc686019fe
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:21:54.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdN3aa8j+i+VZignCGoQ+SsTssuvF1x0svGkX/N2w9SNhv5noFBOPUA/gvUPVtZDzNwBswTKVqb8MUr9MB/FKcM9YUN+kAEpM0NH62W0e78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com

On Mon, Apr 29, 2024 at 09:56:45AM -0400, Josef Bacik wrote:
> On Fri, Apr 26, 2024 at 11:54:29AM +0100, Giovanni Cabiddu wrote:
> > From: Weigang Li <weigang.li@intel.com>
> > 
> > Add support for zlib compression and decompression through the acomp
> > APIs.
> > Input pages are added to an sg-list and sent to acomp in one request.
> > Since acomp is asynchronous, the thread is put to sleep and then the CPU
> > is freed up. Once compression is done, the acomp callback is triggered
> > and the thread is woke up.
> > 
> > This patch doesn't change the BTRFS disk format, this means that files
> > compressed by hardware engines can be de-compressed by the zlib software
> > library, and vice versa.
> > 
> > Limitations:
> >   * The implementation tries always to use an acomp even if only
> >     zlib-deflate-scomp is present
> >   * Acomp does not provide a way to support compression levels
> 
> That's a non-starter.  We can't just lie to the user about the compression level
> that is being used.  If the user just does "-o compress=zlib" then you need to
> update btrfs_compress_set_level() to figure out the compression level that acomp
> is going to use and set that appropriately, so we can report to the user what is
> actually being used.
> 
> Additionally if a user specifies a compression level you need to make sure we
> don't do acomp if it doesn't match what acomp is going to do.
Thanks for the feedback. We should then extend the acomp API to take the
compression level.
@Herbert, do you have any objection if we add the compression level to
the acomp tfm and we add an API to set it? Example:

    tfm = crypto_alloc_acomp("deflate", 0, 0);
    acomp_set_level(tfm, compression_level);

> Finally, for the normal code review, there's a bunch of things that need to be
> fixed up before I take a closer look
> 
> - We don't use pr_(), we have btrfs specific printk helpers, please use those.
> - We do 1 variable per line, fix up the variable declarations in your functions.
I see that the code in fs/btrfs/zlib.c uses both pr_() and more than one
variable per line. If we change it, will mixed style be a concern?

-- 
Giovanni

