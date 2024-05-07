Return-Path: <linux-btrfs+bounces-4795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A318BDA7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 07:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC671C23045
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 05:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF66CDB4;
	Tue,  7 May 2024 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWWjwwge"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4ED6A8A7;
	Tue,  7 May 2024 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715058272; cv=fail; b=hXqDFa7YuIIfpCDGsyIXgHxwLgXoxY+Nqi+soZHM6Kp1uyYPWg/gSHrP4O6Po1p3xOTuA4PK3ycE+S7GSG3ZX1CExbpB2WkPz2BEqcmCkNAAU2/bUVj7lbGEB+9EyPu8JPYMCUrly7ZK669A/smFUCKRQnHjpwb+MPO01MptGfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715058272; c=relaxed/simple;
	bh=EkdeLRCixEH1ebVb6R4wCtpmDmP6nkPP9uKrp4VffzY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMe5EJzY7EPNW99AEO+Rus2IxhI+9on8nPJ5bZBV6H2qXoDz39Q4CJvr0/A8x5IgU0+k3hzENiPaXQa8jlNUPDM1wdtEbFW8EgkZ5oc2XLKF/XhnashnkeJ52uI4gVrwM+ABeS+cnq41bLfSbXX/n8DV/mIt3ZyJatDcJPoVoTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWWjwwge; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715058270; x=1746594270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EkdeLRCixEH1ebVb6R4wCtpmDmP6nkPP9uKrp4VffzY=;
  b=XWWjwwge2A7tgpo1nfDy/BKXJIzSc1W01LBZcE9fS3eEDwKocZisPX5G
   zJuWNhxU77r1wdo17vusmRj7j59KJ6aO8ZHUOUBIB2o7hug+juPysCgm8
   WzzSlCEpRvgiCm1RsZINhHElWsWQHQSOJUz9omAVLnAqza41jxCejXFBR
   k22UagCPD82h1CZUZqgoReKqF0aPVqx/eZ+/1J3BXu4e7kbpcxB00OqEb
   d0dbnsiIGZDtWcUA9q0cvVauPj2NIt5k0xmh7ldBw9l1pDOZDxbypPPnO
   qyDi5/jueI43gKw5s1gCZr/+IF4B84f898rAQsYla8JmWELJMcNzzRabI
   Q==;
X-CSE-ConnectionGUID: 0TyriBR9ToG6Lr7ZllkEGA==
X-CSE-MsgGUID: dqv+jLH/TGmWCURyIM8Ilg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22232857"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="22232857"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 22:04:29 -0700
X-CSE-ConnectionGUID: zF7u1rzDRICkgC3LEDKqqA==
X-CSE-MsgGUID: U7h30fGCTp+FKf/ZN0LUfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28915100"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 22:04:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 22:04:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 22:04:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 22:04:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOq695N9ISq2c33V0X6BNyU22jUSpmQBwJyzkFqjTzRJBX+T2ONdwGjjIlSFZaCJQEILnoDlUM99gAmYTlK3IR3ax0talGWpqgukz/UQGFGetiS+hnReVI/YNHCy7hYMvUcP6glCaxEyI0WLMVGNVuHWJcpx4CjCCSUmFEKamnlZD1rzq1l6tS8RYt2ZFMtru4ZLFIDM/OT+OknP98BctD2Arh1kvvN1N3ROidhFEXtPg1pOX6cnCi+U4AcBvHl8GGB6uwcYtO/MlBCSkhUjil94rCGsNbnvMV/0Sgui0PiXzRlBH7lq5GNyoeqD7mmILYHT4G33D7llZnPObpnZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go+lD7Lsz9hzReNUBRFUGWC+YYeeMesSb+L4b/xrBN0=;
 b=kwshRHeZwl5qLLxT06y0Q+PPi/2VarTOcHBEjXdgTxLwAw77bWK4m3n54ocQ+/xkkFTdieYp3Wbug70TYd+GLIqWNqYCrIeLAb27wq/r92MdMUenZfyzIRfF/MuJh0gD60V1x4HPuMU4MX1V4ejRle8Ng//DuCFKLcQNvqe7FsHbQMYbKRYytMPOlKN4WE6Jw2awdvwmMC0DfxN+YAYNDi3dBVzyn8R1mumRqpdlq44IgF0EtIcwuRBABxZSKwFJYrGwHLRBkokq1J8X1uZohaM+FRKHWJpnR+OYR42WS3noi2H+bqzYdN7EgkbDSJ99FUal7mEsRMyBR54ZRRpddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Tue, 7 May
 2024 05:04:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 05:04:27 +0000
Date: Mon, 6 May 2024 22:04:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/26] cxl/mem: Handle DCD add & release capacity events.
Message-ID: <6639b657da437_2f63a29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-18-b7b00d623625@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-18-b7b00d623625@intel.com>
X-ClientProxiedBy: MW4PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:303:b4::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bd929c-734c-4f40-4ab0-08dc6e532b49
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vu6lwpxtUKEuRIPCE8MXO3GSnkTHXYhVWVvlvQdS+zOGHTgf8IE5cjdQxM2M?=
 =?us-ascii?Q?aCsLksSQl0dmNlLU4qAvRy0rnN4BteGEOhKfCV5d09iN2I24oj4i9N53xUyH?=
 =?us-ascii?Q?iobPu3MgyUWdDLIRscUYInirIx1J2LAx7TXNBNp+NEHhgj4VZvtjWPqeZUbh?=
 =?us-ascii?Q?PZKQqTEvBB+CqbxXjilRP7AslNtrz6KFpQGMxFeaU1ZGteV7zdRWVCHfJuF1?=
 =?us-ascii?Q?Ur2S1SVAC8wj7NG6O5vsHTKu6p9B9Z/apFmfamXZ5mMdyZpdHY7guveVq78L?=
 =?us-ascii?Q?DTWzj9WH/fyATRb2AMHv93pzE+QgV6LybOsKOO4WdhwQhEX3I8NlDUTL50Jf?=
 =?us-ascii?Q?NAH1RJYdYyPqtukWpy26gXn3yfsueTkv5v2m74FLol7W8Lzi21daySqjw1QZ?=
 =?us-ascii?Q?rvM78psi7xf+54b/OspqaSANqX3EEJc134M57leiVJyyGMDr8g9zwMPRjinF?=
 =?us-ascii?Q?RwNMPDYcoVw+wMDBP809PLtLDhbp2GFBwsKB6eJ7RztpUw6fo09yVsMTGIZ2?=
 =?us-ascii?Q?i6kq2f/RGlmTcAmB+Qjj0RL5HG1tFacCdApQg1wpMokKsUXBAXvGWtEMsXyY?=
 =?us-ascii?Q?fv7e+5oZ0lWp0G/qYNrEc9xlThheVhqZn+1iXUBvPbeWlcVciik4xhoXJjfY?=
 =?us-ascii?Q?k1j1XL5lmdV3QAbYsBxgjH9zEJHhufsVPHKxrQi4uS6+4Ux9cvH+YkBtzJ7w?=
 =?us-ascii?Q?7vW5lfkuSaQsK8Tty1SJy/CVk5cQG8ehQMBnN9yEyiWpB1Mbbzr0o8uSMrl+?=
 =?us-ascii?Q?/7nME0J2S18qGPlIJ+TD6j0upwbebgS303W/Vr3FdQu3sI7dXqVuz8QLmXwG?=
 =?us-ascii?Q?SCvYhrDencghJTTTVg8/qr6NDH6GIEAQ/wT5jnqXTvhurhditUcuCWlH6xhg?=
 =?us-ascii?Q?A/DTP73TqIW1QrKupCNG5lc1/+3pBA1NBmzxBLWW6Nt8HbZ6fGphEPudptho?=
 =?us-ascii?Q?Ob3xQfuLcxITGhbU9xvlp5n/2zvTbiQ6jpbNmva4d66D2+eStv2B+Bg35o2H?=
 =?us-ascii?Q?ruUIdbDTs1TSbGCcKJkI/wEppL+AZ9bH1nOJB2TjpUYAJIkJWikKNMOljkdP?=
 =?us-ascii?Q?YwM4rTAUWoDIZHGMBvXFriIOp7z+FKwbDX608/arWn/WNDTcUsaF1ZLUF5ri?=
 =?us-ascii?Q?SnsaXusAZnbzBkG2dNcU/6hH4leGVWhSwe5sEsImbG+FE+2a46wnzrRUA7e8?=
 =?us-ascii?Q?ftGKiEEnoOCTuG0PFQ2vqC5gV0FEBuwQ4Iw08u6sb6ZpZiL5DIEzd4WWr+Ut?=
 =?us-ascii?Q?+tPE/+kUSXhHhZNyMG2cOjQQiWeqBNffBZyVSKduSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4AKbG4czHcHRFCOXTdxEgSML1etujCmtq7zWb+y3ZY7c19mYFUeI5k57vpv?=
 =?us-ascii?Q?mKafpgSjLJ9tHkJykWPTvioN+fAjZQP3FDx7qvEcHpjhVM5OwnV7YDkzX2Tf?=
 =?us-ascii?Q?7dBxfNxpR8lUJCO0XkBIEf91DPItX28kU1ch5fhU8SxjqjRX5PjztGNO75Z2?=
 =?us-ascii?Q?Zya2VZZVuW7owA2agMJ8v6pMQbB3GFIok4+fEFyEbl0i+6bH5sk7a9+uM8vN?=
 =?us-ascii?Q?SVz3jSt0Z+LdrYrrN7FSbz7T3358yvLr0FBY32MRN1uYgOUEmW7D6u8B/3ft?=
 =?us-ascii?Q?cmhDry5iNJ1CDKD6wmK9yQ37b6onDL+Xv5AFuhmJgX+Nrg9803Wu0N6Bkmih?=
 =?us-ascii?Q?q5iFpi6bZKYyhUPTPymhgRhRYjUbWEHVdFKZYXFql+DM+HOdejEYq8A7zc7D?=
 =?us-ascii?Q?gtG83s1eKZW+dbebGfAjM3tLXS7kAoFZimMyloLJXCeaMD0rgAUDbu4NPUIx?=
 =?us-ascii?Q?mRvnJgN6Qxq3Q58oxESL8EmyPWm3pWO+n+tBylsIl9whfQAPEhvHx5hCRZE9?=
 =?us-ascii?Q?fzCCFueSyX2vWRuF0nXtr1a1dlaB7swVlpISn+yJ4vHw9w85EsDGqPrUxOut?=
 =?us-ascii?Q?Zu3bbiR0GwNl2X3llXFQi2v7lJLIx0G9Vnbby+YS9at7twsA6Tid0UKfWaHl?=
 =?us-ascii?Q?Ss6MdLkx5eARkYgLVpZnOCVje1l0RXOyaitIZ/YFWoxpaZlYSSKS0lPbhEtH?=
 =?us-ascii?Q?dy+rJxrBQsVRmqptCJQc3klLLTec5bfo7Y75i56eDXzMp/t41Oi5qHd4LuCQ?=
 =?us-ascii?Q?hCI4ZISHXliL1zUhjGbFoVNg6XOuzFRh9Dbdl6L7HAlLfNnZ68MULexjCbi4?=
 =?us-ascii?Q?X8Ocf8H8hknUVuDvdBmcEoZ9kT6a9ge0eoO0wS+z8HfeMfell8NUcgpkC/Jd?=
 =?us-ascii?Q?oHyzgJajTa7kDCGnPVBQwRAKv9UzN1NUSIyMUi03cyaGQECnbxXiB02/NAFK?=
 =?us-ascii?Q?mlu3aKgrZxOL6KCdn3sxBcHHvuikx8P8FRWb7kQemvwZQlfVpPIE+GJH9R+U?=
 =?us-ascii?Q?jomLVui1/g/aO7yrkO5eOebzpqySrEP8ocvm/UIpXtnqfFbYRW+G1SndzTBi?=
 =?us-ascii?Q?TqOzzbHTSyGyjDmmUQG3gdgxpczxXjKcwie7QljLs/mJlQtLhfCsut5nQvxd?=
 =?us-ascii?Q?iSc+QAQx1q9NEUsD3Lkpb8SmTrzq3Zs5LIGzXqWfTfT8njscn+k5Iq7nuXQZ?=
 =?us-ascii?Q?BhjG/sBL3I5AgfHE6Eeh7Cq+hs0SABUUaUecW7n35iN7lCZ9V4zYJqkLtUli?=
 =?us-ascii?Q?QsdZeb7hDk2QXC6QIwToR9M2wBAoeH6hufiUMZvshwlt0XocXLcPkDJY+REW?=
 =?us-ascii?Q?Z47+wHECenWZaE6CO0tPF5AvxN5cLSmuDqc+mYWeND/sVHkG7O9eLsiTkmPY?=
 =?us-ascii?Q?kDMeHDDDVkQf73FxPJO4BY6gpz3kqmGhKz4arnrVxUi5nsupUTpQREg2mJEH?=
 =?us-ascii?Q?PdbT/nBfrycLSonw/EGOv4MK0cfWbYUrTkZ0XiUVkmUsZFwPLioYuRrzTaDn?=
 =?us-ascii?Q?b2GRRogxkLyPeYbiQ0onFezkQU4rv8s48oOwXYC2c7dW1YgzzwOGn6HCHDy1?=
 =?us-ascii?Q?W5J9cJ+oHYsrHdLwotpq2OxAIyJ5ddmLu/d04u+v29ejPoYzFbwhUSFyPWuF?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bd929c-734c-4f40-4ab0-08dc6e532b49
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 05:04:26.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecNnTZB8KrNeN/B1h43KSHt/AdBoHVhSmy1k9OX5T5Ikp0lLkyuAEtSQJM10RM33nRr9yAKjPO8/+qnEfJDUU8VEbyqqoTPiTeBm1kY0E2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com

ira.weiny@ wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> A dynamic capacity devices (DCD) send events to signal the host about
> changes in the availability of Dynamic Capacity (DC) memory.  These
> events contain extents, the addition or removal of which may occur at
> any time.
> 
> Adding memory is straight forward.  If no region exists the extent is
> rejected.  If a region does exist, a region extent is formed and
> surfaced.
> 
> Removing memory requires checking if the memory is currently in use.
> Memory use tracking is added in a subsequent patch so here the memory is
> never in use and the removal occurs immediately.
> 
> Most often extents will be offered to and accepted by the host in well
> defined chunks.  However, part of an extent may be requested for
> release.  Simplify extent tracking by signaling removal of any extent
> which overlaps the requested release range.
> 
> Force removal is intended as a mechanism between the FM and the device
> and intended only when the host is unresponsive or otherwise broken.
> Purposely ignore force removal events.
> 
> Process DCD extents.
> 
> Recall that all devices of an interleave set must offer a corresponding
> extent for the region extent to be realized.  This patch limits
> interleave to 1.  Thus the 1:1 mapping between device extent and DAX
> region extent allows immediate surfacing.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> [iweiny: remove all xarrays]
> [iweiny: entirely new architecture]
> ---
>  drivers/cxl/core/extent.c |   4 ++
>  drivers/cxl/core/mbox.c   | 142 +++++++++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/region.c | 139 ++++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h         |  34 +++++++++++
>  drivers/cxl/cxlmem.h      |  21 +++----
>  drivers/cxl/mem.c         |  45 +++++++++++++++
>  drivers/dax/cxl.c         |  22 +++++++
>  include/linux/cxl-event.h |  31 ++++++++++
>  8 files changed, 405 insertions(+), 33 deletions(-)
> 
[..]
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7635ff109578..a07d95136f0d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[..]
> @@ -1502,18 +1552,7 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
>  	dev_dbg(dev, "Adding DC extent DPA %#llx - %#llx\n",
>  		ext_dpa_range.start, ext_dpa_range.end);
>  
> -	/*
> -	 * Without interleave...
> -	 * HPA offset == DPA offset
> -	 * ... but do the math anyway
> -	 */
> -	dpa_offset = ext_dpa_range.start - cxled->dpa_res->start;
> -	hpa = cxled->cxld.hpa_range.start + dpa_offset;
> -
> -	ext_hpa_range = (struct range) {
> -		.start = hpa - cxlr->cxlr_dax->hpa_range.start,
> -		.end = ext_hpa_range.start + range_len(&ext_dpa_range) - 1,
> -	};

Please don't refactor code that just got added in the same series. Upon
seeing that this wants a common helper in this patch, go back to the
original patch and put it in a helper from the beginning.

[..]
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5379ad7f5852..156d7c9a8de5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
[..]
> @@ -891,10 +900,18 @@ bool is_cxl_region(struct device *dev);
>  
>  extern struct bus_type cxl_bus_type;

I skipped ahead here in the review since notification organization feels
wrong.

> +/* Driver Notifier Data */
> +struct cxl_drv_nd {

I never would have guessed that cxl_drv_nd meant cxl driver notifier
data, it might be able to be jettisoned.

> +	enum dc_event event;
> +	struct cxl_dc_extent *dc_extent;
> +	struct region_extent *reg_ext;
> +};
> +
>  struct cxl_driver {
>  	const char *name;
>  	int (*probe)(struct device *dev);
>  	void (*remove)(struct device *dev);
> +	int (*notify)(struct device *dev, struct cxl_drv_nd *nd);

First, this feels an overly DCD specific mechanism to inflict on the core
generic 'struct cxl_driver'. Most 'struct cxl_driver' instances do not
need any 'notify' callback and 'struct cxl_drv_nd' makes this even less
relevant to the core 'struct cxl_driver' definition.

Second, it leads to 2 anonymous ->notify() callbacks wht too deep of a
stack. It feels as if the resulting code is being actively evasive.

Given that the event handling code already knows how to lookup a 'struct
cxl_region', as Alison demonstrated in her DPA->HPA series, it should be
straightforward to lookup a 'struct cxl_dax_region' without a notifying
the cxl_mem driver.

So my expectation is just enough DCD event parsing to determine when the
payload applies to given cxl_dax_region. Then define a:

struct cxl_dax_region_driver {
        struct cxl_driver driver;
        void (*notify)(struct cxl_dax_region *cxlr_dax, ...);
};

...to send the payload over for further processing. If a cxl_dax_region
device instance cannot be found, just drop the event record.

