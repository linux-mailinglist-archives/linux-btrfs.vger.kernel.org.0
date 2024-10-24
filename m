Return-Path: <linux-btrfs+bounces-9116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BF9ADA46
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 05:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201E928365E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6516191B;
	Thu, 24 Oct 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nh751PUr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FC14F117;
	Thu, 24 Oct 2024 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739382; cv=fail; b=dPRqfB+PxiZ8+KabtCJQ9kpvsdOy7Wum7AxajT3Y+NQPsffXzN1+Q+GPgXhWRIap5hzYB46JJnDcmZp2Nz+eYB06AlFVQ3sEhXq+SqpGahnVVIVpw9eR/vFzvT/uUuCV1fHo1TOx/v1Cb4+j8RVw6cAiPnhl59FUe3IB8RfQjZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739382; c=relaxed/simple;
	bh=Rk5Jci48AK8ILKTpTihaFKuVUl52FpnG1VVSCPBdotI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwMB5159TbbZquiAx2fKDvBicm2wKOOzenz+SesKGLx/G2m25t8zyHwghUgeuwhFDDfgq9Oc2vMnqAbxEF/XILBYafh6yaNKSo7xfX7JIHwq7a7Fq6eVZi23FGclwVYizJAMYhf3ijlMsyJ00YUyhBU7in7h2QFCeIjNRHGqpIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nh751PUr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729739380; x=1761275380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rk5Jci48AK8ILKTpTihaFKuVUl52FpnG1VVSCPBdotI=;
  b=nh751PUrPEsUB7Gts63p2ZShTM2TK/cEyVWoO0BloouZnCJEoJoOWv8T
   oajdvQSgd2tYMqXixndtANmfEk0DM8flDElEbsSmnDsUeOC+E0v4vcePO
   bwE+YAxopXY623nSPhlmq0zLwyN+K2g3dHjU+Id4J+i7E0C+Om1MAnLO+
   EOEGStnwFnLx2KnxtpEcSQc2wwFnbUcSyLTRHn+6opVW4DOWGpm6H05Ml
   li1ndmNLJgw54ee+4clZyNg0oyap1bVo8IU0d/iZW+d08MudET8mN8n2Z
   NiT5F/R4SZzQbtitfh/bgfvabPi0lvn09j+0xcleb5EEqS5ZkBVZs+3Jq
   g==;
X-CSE-ConnectionGUID: Kk9AJE6zRM+YAUhMB4TWdA==
X-CSE-MsgGUID: Sz6gdJOnSeSCCyYl2jyVmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28795665"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="28795665"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:09:39 -0700
X-CSE-ConnectionGUID: XHpmI02yQbOq82/B5oa9tA==
X-CSE-MsgGUID: 9iznxJrgTC+YZ2TsEAx2Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="103779867"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 20:09:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 20:09:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 20:09:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 20:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnZPzWB1CxMDOSfvZ1ZVo4epzq43Hdm2jhT+OLLe7ZYjFEZvBV2LBAAKCDekYRc6ENYVVASykZkHZJlDQ9kKcDOCs0NGQiLYj2ztzgoG+2g1jUhsIOZMSUQCZ+NqHlSK2xD/iQytmBA4Emv7aRfxDgXTCbbfXDz/1+9HMrW86WyeUi1lqQzlXaOKtBofGIRN9Hne/X97tDeI3AFgR9T7nVHtSFyMgYdk0BCGCkQ/PzXsmgoEW9IQOVawgBNTdE/A+0ELwdVJsX4wo4HBurDMj2NYtqFiagv+p720l6gJ/48Nr5TmccvpjXcpmUkmP2DBBz7bP4wmGsSUXK4o9wBsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuV/TzC7H3z60LJXoRvdxWAQHPiZFxSicVmoNaBx2GY=;
 b=a100reNSRVAmmHrEjp5rPamk/4qp4+8Xh/CTdyZuD14ZYpr30UQDeUp72ZGjRQLhGahwEEQRnfLl1uHdjtQlhg6QiIiZ3dTW3RSEOWyi6NRWQfg8tAKtsbF5p63dQ/gQLpDg4M2eZ2yvbV+leIXJ4c8Z2iniU5m2nmffwaxFIpsPwDWQNsJXUKiXVDZ+J9/1TKASsuyr8+ee9FUTrLOY46ph2uy8dkXItIpipQZtLWQU75ld9S89ZfeYjSBAMlDxYeVGM8V+KpuHKHWArXZM9ircHuTEyk5C9PnXuKjIz5aQHHluIW2/En5sKpoSXyKFhDg7aXFagVA4+raHByeh/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 03:09:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 03:09:18 +0000
Date: Wed, 23 Oct 2024 22:09:13 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 19/28] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <6719ba59d20c_da1f929482@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-19-c261ee6eeded@intel.com>
 <ZwgcCRTl3x2H8Ze5@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwgcCRTl3x2H8Ze5@fan>
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: d073d3e8-f18e-4191-1cb2-08dcf3d93fd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ABdvNxuJCbl8cEzcg2IH9a9xjLc6LW4ioEhNWYxfFlPFtCyc40zL/Z12s+Le?=
 =?us-ascii?Q?kcjpVNaUfK8RPudPu5aMhtzrUBQEJj+6BDZEf7HdfVHSAYlYl8DasHnTXwWI?=
 =?us-ascii?Q?l6wX5H/LEHmttHCFD7f33KdFx/sHYnzyW0z9RefYdtEI9XogWjEIUFmqqvHt?=
 =?us-ascii?Q?igtCPHUnE/ZqxndUoaP0bNEG0kAxkmqEOK+dO9zQBVDKM31u2Bq03TvztXSk?=
 =?us-ascii?Q?YjRMAs0+Cm5DhfMln6eW4sqkPflemmR33iX+E6ZW2qImQcSQrl5GoL38EZ/4?=
 =?us-ascii?Q?+IhXuxB8vaTD3ffq1noiDnoPjZYsXOU8fgMD3w9ri+hQq6hphD8Cl4/DPxVv?=
 =?us-ascii?Q?hgOhxJ8QQxpq9g0do9H6G/ZezYZDMrpQL7FWAmp1fqM7Og4tkMdl9C+4YXUP?=
 =?us-ascii?Q?5Z+gNmQlw3dBvLHm2KwJDUWM9aW8nl1TB4hewW6G+R82y95TndzWiSmcbT/6?=
 =?us-ascii?Q?FydTKysiAysUzYseUtK5YwMBW6z2CHbHYXfuBW+DHIYeIzxmpGaBXFxm/T4E?=
 =?us-ascii?Q?t0deJrBCPmARy0QE9cEFdoNm+RAVlAjuBKE/oPQh0FpXCJWDcaXwNNcGr8j6?=
 =?us-ascii?Q?Ke4OfZkwTGUnzi7Mu0p3MnNObsFC1JX7XUQU5G7n5hjAAWB7I3b6Y7mXmxG3?=
 =?us-ascii?Q?G0uDvpcDzldzn9MuO2/BY0NLHLYgZcHMz28Iv39LyqtPEnl1LxUnm88Mt+iT?=
 =?us-ascii?Q?+WtPigUiKTC3hh07bScWl4dchDmv0ksAa2Hc+zLj40A0F+A7Gc8sM+5sobLN?=
 =?us-ascii?Q?+23r5IH4qRUGJa7l2f+jdF3dPYfPpKYT1K2Qd4Qj+OOqTajlhB/NzE5MNhZe?=
 =?us-ascii?Q?Kx6+92v4ft5XlxBsJQfQf4kSUqIDnXfDlLjH/2EQ1D12pBiKY78GTj9qxDOg?=
 =?us-ascii?Q?cb6u6q21YApyhbD4xU4tDEAyakLuYx05PflDFqppwjcSK6J2d3RNnQeWygSy?=
 =?us-ascii?Q?Hi/XIhyUbj9s+M9oC9rEpkfPVkF9Df06w1P6k5ioMfS00CM4wj/CS+Fz5oe7?=
 =?us-ascii?Q?P/Mx/ji+AyANwo5uHWc138pPIlZX0US1TfeUioDVYB5T7T76jQJ9gWlPIv1f?=
 =?us-ascii?Q?lIkmiOmF7FxlblQuEVSoHJhG27rViIjlzWPVJx+3YO033ME8QFa3E0wlb51g?=
 =?us-ascii?Q?HarXBt8RDCDejRd8LYe56gTeZUNnQK48yzfPrHtPjTdZB32RL+e88kzCAYtT?=
 =?us-ascii?Q?BePzijc+TM/Nd8ObdpxVCeOreLeYspPMeXthZAFbJs0XqlNKeb324K1MA9z0?=
 =?us-ascii?Q?oYgNAhHDwX5a0d6kU5cSBsALtzLUlbuzvChTSklMc1QfQfDJRkXkOAafzKZU?=
 =?us-ascii?Q?DmqIRR9QTdUIjG4Yp0MKguMd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6un9h3GuvBBb8khcggGhE9Exc7PXBc/a7esWJGIviAUTZxrkehpfyFBWRgAY?=
 =?us-ascii?Q?gyDdPUoyaz8rArHy9uFGqeoaPe8f4sSyg4pKT5iIL+7Bj4abAsV4M5URDTHw?=
 =?us-ascii?Q?QmJXUgJt4nW7XiYAX+2G1mA362KMYN6bb7huxOEwBLgZJkLXnth1wMP2UnbM?=
 =?us-ascii?Q?/1Ef8CAQd5AlIHB7+vlD3HVKs2ChYg5NA/79Lo6bvhCMUYwLdlpoUsGc3zKa?=
 =?us-ascii?Q?XkadaAd/kK7MssoofZEKC8w9HF9kizh0YYzzPDMnF+PGwDAK4qA8PmJAetHz?=
 =?us-ascii?Q?/X3CU2nYFXivPd/6wNDrj3FMExp8Sz+58SfapJJ2c4++IHFFwOZ3Jf/9H5IL?=
 =?us-ascii?Q?rCa4UAvPozmIH9P7pdIRowlOPRlFr7/odcZJ3vMsidbaLKAZbupWw66cZnq8?=
 =?us-ascii?Q?Cd/fHPVaPlsL/XjKARDcGXSbVLAngjHsd6f+UZEaZwXhv5+baelwq/9LWkEC?=
 =?us-ascii?Q?c3QJWWQrj2lqo///ZrAFatZQMHQi/dofoh7bsHfElD/wHDZQ9dW/WWhOj7zA?=
 =?us-ascii?Q?/W4CmMGNBef3paFqvJENoyejshaDsfA2wITh5PqlCO/TDciSaKGvXmYaB7Vf?=
 =?us-ascii?Q?GWXDshAdQt3ydqxQ/uH5aS5c0UF6KrTdt8fzfCn5AvV0XJTitgFsuPudC9IO?=
 =?us-ascii?Q?+W4fBnN9x7dss2KO8ARexoKcbW4QfSFNWvWZ3LcIjeA636oNpYeBZkQtb34o?=
 =?us-ascii?Q?+UuIi64BcpKnaYNtik+CpaVAQ5UuK+GzIxyzglUxfRcIndkogiyH4vTyLGLz?=
 =?us-ascii?Q?lNIeocKqB9AOnpgB9674tJN34OgQouvaLcEn8VWf+FK8ka+/ug0wBEZGtlnh?=
 =?us-ascii?Q?YqXOcePbsqy37Lafga7Bo4y5D/GEKwmWcEGjV4WoYLZJwSotch2Ua+AY+9jK?=
 =?us-ascii?Q?1/buPncUuETZVwHC9MUQt7QidrNHDwn1y207yFV1yiy6CAob8hD4XcUcxoZZ?=
 =?us-ascii?Q?y/NjR3qMdxm/i5f/KiBTzn6Vo4P5NWyKf8aqXGeLSwE4u4FMRnR7Q2QOpMv7?=
 =?us-ascii?Q?6xehN8lw3umtjNMN4lzoiaxowIIQ4rSUzdqOlmkaX3daTT7iMfny9ljaW2Zo?=
 =?us-ascii?Q?4Rjir0TQTF0F92xcfnksb1s/9zYueHWMIf56kqQ12Uydw513e8fDtBIHHN2Y?=
 =?us-ascii?Q?kcIYUWkVF2mQIrlbV7bJplu6wlhK4U13ssotRMNC5zFTdqk2yweVbhJjstHD?=
 =?us-ascii?Q?DLJOUjn0TLwKM4cywyBaXs8sXWH9c0nyxKdXC8PjOoiNvlOt1EqZs1N8sMiY?=
 =?us-ascii?Q?joSrPx4GWS+6ym3R+B5xyWq30Richu1k9OURrviOzUiGdoRQiBSp6+1xS14e?=
 =?us-ascii?Q?+dpZEegIwTDvFM3RCIeHwCl3H9jlnQ+hWTxV3328+HJVvuyofVlUKEQBHI3q?=
 =?us-ascii?Q?60yaqG9D0vEwiSrSSHf4cYkDjprXrSsxbeg9svrdb8mkG2e3Zf5QL8xpki8h?=
 =?us-ascii?Q?AF5T0dCsTgZMJ3RCtyA6AjzbeDRUbSg3MwkSFrxrRTbFgb0Y9r8t/bosxmxk?=
 =?us-ascii?Q?k6LkBJIOvVme9JsH4RJ3Y6hGMYY5efgPuBPyciqTpzol6U73Fpt7ofME9MTU?=
 =?us-ascii?Q?NpcFvRbvbrzG2cjSL4ttczM+3ZPVp7cPb8/popN9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d073d3e8-f18e-4191-1cb2-08dcf3d93fd1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 03:09:18.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dvc+rUTRk4eX+OzKJGKlhkNr/gFzKWNf88oMohgQvro2bkE3ucBdRyIKobNVU5hvEcm6eIp7um+wAxw7qezo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Mon, Oct 07, 2024 at 06:16:25PM -0500, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> >  
> > +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> > +			struct cxl_event_interrupt_policy *policy,
> > +			bool native_cxl)
> > +{
> > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	int rc;
> > +
> > +	if (native_cxl) {
> > +		rc = cxl_event_irqsetup(mds, policy);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	if (cxl_dcd_supported(mds)) {
> > +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> > +		if (rc) {
> > +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> > +			cxl_disable_dcd(mds);
> > +			return rc;
> 
> If the device has both static and dynamic capacity, return an error code
> here will cause cxl_event_config() return early, and
> cxl_mem_get_event_records() will not be called, will it be an issue?

Good catch as it was not my intent to fail the device probe.  Rather to
disable DCD.  In practice however, the device would be broken because it
should not be advertising DCD support without allowing for the proper irq
setup.

Current support will fail the probe if event configuration fails.  So the
error here is probably bothering to try to disable future DCD processing.

At this point I'm not sure which way to go...

Ira

