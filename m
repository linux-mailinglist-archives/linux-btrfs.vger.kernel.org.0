Return-Path: <linux-btrfs+bounces-10777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16841A04328
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 15:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EC41634D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904F11F2C41;
	Tue,  7 Jan 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmHeJ6+N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D91F2364
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Jan 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261411; cv=fail; b=UdyWvGwHfu5Ccd7Grjsy1ENMudikHvUAVebHG4ukMvr2xoGOF7nEoVF9qvaYrIbw8dDRE5PO4TkE70bL9bD2AxO0xac2V6D5fC2tiL8O/BeTxHzLstDky3vNJVnRDpTkz5hEnEekJVTSfJVfAG9fZXK62xCkchC57JHwimFoMxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261411; c=relaxed/simple;
	bh=wQsEhL+bE3blWL+vLpW2cgT69/3AqXlao5+dK/XrOjs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F11FU8YHcY/ULk28VS064bhGq2g5mTP1p5nWEz0iZTVNmvt0XONFwgJbwqb+7kDhOlIjv9U1In5IJtNrS4Qr50+5SFzsEX4vvfRn3ghQU3AXx6pANB1U2A4l3b2cRgzaLBZ8LVGbbNf4qfylUDMO7wwixLSSVBFwS2CpkbvldP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmHeJ6+N; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736261406; x=1767797406;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=wQsEhL+bE3blWL+vLpW2cgT69/3AqXlao5+dK/XrOjs=;
  b=nmHeJ6+Ng9QRR3DC6yvrQ4TyIZG9ehkW6rB0QhyS7LzFOSXAspSJE+1e
   sLiDaB6UxGUBDLdahoFkKsUcBmSuBOnowk+bqXHDTPJIG+dK+uKG1b1A1
   VcXggwq9VMeFZQom6hF+XXmkvCiYJAeC5yhqxh4e9hcSQ/IdFxipBFHOT
   HXwbUEWu3lIsUCFPoNWiLlhw3VzE6h7AOb3MWcbsU9+WbVdva7o+k7kQG
   sPpG65W4NX4d/GTztr3IbHCfM9DrD9CaV7wRj/YVv7XZ+6z5FQfiMXSWf
   djQRKw5SJiH36oizcBei9ZK0pv7hDZ/xR6u+G6ppK99oNV9crub6EieDa
   A==;
X-CSE-ConnectionGUID: 8MrJzBYFQeqg8o9Y7EkVwg==
X-CSE-MsgGUID: cA2g+MFYQkWCnNCb3JICbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="46942891"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="46942891"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 06:50:05 -0800
X-CSE-ConnectionGUID: 7D0GQM6vRDmNW/JPR1ObsQ==
X-CSE-MsgGUID: N8yqUIcZRSKrRFgMG6Wmyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106809635"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 06:50:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 06:50:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 06:50:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 06:50:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTdB+WNwoEoFN4Ing2m59EfIfPER6XgVHOjhKS0RTCqB8npzKRy7iE8jhnCOnJUnO9g+zjgAXvbnH3GPrdhLKbYOOoIkybB2nukJaiaODXIVUuzJyYDJZcIfHMHFKJuGOTxBhHJprW98VSyIh+DnvK01LI+JaJNKFF9oLh+wDuIXF8uZVvmTLgCxVo9FdriTomSLncj0BUkMGYEwqs3PiAwircvSdCsYz2uVoQ0/coa4aZZ1pJgxlZIqJF8GLyqfint1njSfDtXs0nIEmQGO+MEcT1XHR+2gUYA/vkavo6LhAqKguLPiJTCwG0Fk73NYrqj+GLQ15z0r8kQUwU9E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qplIjePaKzXYIfW5MVq9b5aIfVF9OJN8ztKt+c5+nI=;
 b=VL2Y55WFZmTq7x8VRRjCdaWDkj6UN7TTwMu5EikLM9GWHiiOMYVEyLJYk7L3w+SfRZ/yl52k9AS0TsPpxS7E+Z41BXPTHk0RpfSxn4xOaTe8as6AzS3HiljT+WFYaaOSyh5b1rrag4QKxRn65naM09nS7rwt54A0wyQU71MmeOIpTQtCHQqQzgLdBRi4mIPCjKDCvNcVSo81WIlBWW+P2VKQQ7AT+f9F1qvlFOq98bHqLXTvB6w8ds0L97nwHiBxO8moXYo5QYKHb+Wet0VacCPv5us0k1GlbRHiLQ1MxXR8ARH42CXX72nXSM5lexyUuXsoG7Cr4KTV4W0v3tjftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:50:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 14:50:00 +0000
Date: Tue, 7 Jan 2025 22:49:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] btrfs: implement percpu_counter for ENOSPC rework
Message-ID: <202501072208.959f0962-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55bd9fed5b767365c633bf9aeaed49d335c9498e.1735508254.git.beckerlee3@gmail.com>
X-ClientProxiedBy: TYCP286CA0161.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3f5067-c715-4cf2-8656-08dd2f2a8f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JtHue15zqIRwLBlozlX38G2g5dDk0SSK+yCGtstLWsHeDsT+zI4AHUosvnWy?=
 =?us-ascii?Q?Jkv0IhSkNWNFKIIXOon/ukAPKc8ni06G2PSZ1FWUx0I+kWzvwxcz9UVC1ocz?=
 =?us-ascii?Q?odvOloOmVeUBRT3H7qrkiO6bOz1rCf0hMBfqPqUGXh1mqbGqf1Q8Y4hiAwgZ?=
 =?us-ascii?Q?3m4BBkWYmXFYv1fjJbT2TeVXjnOIIN1Ly9CP1XghENZ29rtzNTfaEPAcsUu+?=
 =?us-ascii?Q?7QK8cykSDsFMnolr6HV7nfv9ZXvMMoyzWp1d/OlMS8IuLptgfn8JZ1cQgSPp?=
 =?us-ascii?Q?oArEwih6igfzWO0Xcx3Ir+RypPAu38P5qcbVjCmWKqtvqDgUkeKfy+kxVLpi?=
 =?us-ascii?Q?fr6vbWmdsuVr+7YG+3raM/HHSfCxLS34qAYBinKo/iaDbv7RW8GO+GOZX79h?=
 =?us-ascii?Q?pl0CdwlZOqk3uQFseJ0mu1k9Mm5eOolShARwvwvQyWfC2jHhERdb54Qys2Y1?=
 =?us-ascii?Q?F94F0R5pg7KFGbvpHN+oIgC79GrcoKkyp7qCjBEU2O4BorbJ4tFX2BL6inXg?=
 =?us-ascii?Q?K1whlWNfA5vPnTOiuNoe3ZaWgdCEasHS5TUN6NynLjmf3nuviWKv9XrJ6E8+?=
 =?us-ascii?Q?f0Msp4Lmy/sFbT/xzUoy8KXebJelL+r4OkoUddtUFw8CPHeeLQFrKHH/nmO2?=
 =?us-ascii?Q?7X7+Lx16RieDRjzH0G03KVsg0qOdH4DSq2UVCRTmLNOsHTI5/5cwvF+Jlc+V?=
 =?us-ascii?Q?JbgBi5VbealHZC4MQ+UVky75DrTAjVWXf85GeNLElqqyyFuaPxP1SbpQxcL3?=
 =?us-ascii?Q?cpTDJY0nY04D3pPWATfGYU9QNp2z/6VPvhNgUG2ZnjSlKg1N8YFGSarDpR5/?=
 =?us-ascii?Q?OYtU1X5a/nI9bWMCYAdgPyiorW8TJ7xZCoo0DUgHYbuJFwKLl8GQZW/a35dx?=
 =?us-ascii?Q?7kjwAJKFdUv7z4X9uTNhY40k6wcN91pIp54Tv1ySrSEKQDa4XfsKjITxE6jZ?=
 =?us-ascii?Q?utwJgp1B4TvewC9sb0ljDKRslSkRojyHAPCnNap8SOwWyHSH9gk2Bua/5vYe?=
 =?us-ascii?Q?52uw1wq8ZHUlcMg7syxOUIoDq8zlTLJBVA5E2MKjJQPNhoZNpUAOxbVgZEo4?=
 =?us-ascii?Q?t8gx+sB/+hKfbKtHqEQxuf85M0I7dQm2aBqbsxHaXnFibGs60YMIyg3bCcMz?=
 =?us-ascii?Q?uokWkhX5Hk3gX7zODNLMDzQwXA/4CyocWg0WQt/7vLhD32w3hXq9rDLdwkRT?=
 =?us-ascii?Q?K7mPg8gpU+YiCCdQCCZbopK/9k3BL+QYAC8QKgozwMdI96UZuL/7wHsatZlz?=
 =?us-ascii?Q?0ahRGCBVpSh7dxyQl0LBaAo4zzzYF1u/f+x0/9BZ2XZHwtLAaPlvE1GshS8a?=
 =?us-ascii?Q?XnE8jqHsPu1TYzJ9cvdfivDumi7VsYB36DSzfyIm5ry8fQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7Dc1haCL6pu+oSIzxXoeLn1adeeZPAiY7W1+oK4t7YcfuPtzj98Qq5IcGQv?=
 =?us-ascii?Q?6GKwGkgGWtJCDKJQARfsGOZzTyLxM4jqC+Cy9IAdWl7CbmHYs4DH5tyZzJNY?=
 =?us-ascii?Q?IpnWMAS2o/1UnBgMytbTJyfovX4z6YrVfu94tOmZsyB8yppe6AtJ6E5GasCH?=
 =?us-ascii?Q?6w1uliy6+9BgnH2EOuDatgGCBRCUZjL91RDwWwZS8453PSn3rlqbK06vB9Rv?=
 =?us-ascii?Q?wWvkkAVGfiQbFcox0ZK//63YRS0aJe6z3wgZEgbVvC1AnO8KEUwSsYQMbehy?=
 =?us-ascii?Q?YnRDHlhfY0ALQwbMKiK+bKTWveq4sCzQKc32rgFEdjAJDjmfLyGtgdsDPWde?=
 =?us-ascii?Q?xPizZZ9mQcJ12cGokhD9fiWkCGUZHDUIfjpAe/WXYGexzshXPjio3UEBLNBA?=
 =?us-ascii?Q?NPfjhhX0a1Hu0coVNPmxmZ+HEKgI3G4AIBliwGdqDYlB1ia3KS35nSGEnQDY?=
 =?us-ascii?Q?Je9CMnJrcWTZ9SMMqEiZ9jkcbFO8Ez/r+DPm1SkjOmCKTlONtmBoL4smqr7h?=
 =?us-ascii?Q?fVRKUEKPuKxQr9z1N580ucD34MMwdlwyDL+XR0VHjyMwOcNQPDqsfQwO9txn?=
 =?us-ascii?Q?xfmHVVfdYNLfQmXDU71B/0V0Xf59rVA2LOi9njX+xzvLBJGNTuOcmkQEoAB3?=
 =?us-ascii?Q?x8E4PUInd5SfIf3C0Bj1y4EC8qumKENpWw6Br8lD+uoaMI99kAQdKqGZ8cEY?=
 =?us-ascii?Q?EO6XAvjyZgRWapV4Ra32NL7oRr6EcuRDU9lBkEZszwunIR2FOWS76y1BDb0O?=
 =?us-ascii?Q?rA4w4F45OGEXo9F6pp/GQZFBS8T0FI8BOqPYrnB38WGH8mxGjTbqXMVtKbUd?=
 =?us-ascii?Q?e5hErL6s3vttZKh0KBnqBCTC1wuyWPRr08qi20z0lciYahELoZFzeahsDZ0I?=
 =?us-ascii?Q?LbGKvxDEHLsITDZLQ37vM3Ph5ShJCU8ImN7xtr9qw9fCDD68Zmx5L1pMM65F?=
 =?us-ascii?Q?vAYOypaeEpaWS0jXbll/YpnRC9hET2UnAfQbwwx76Bv0keZhduL13F4Qpatx?=
 =?us-ascii?Q?GLnXpQIdQCqhSSJI6TVe/c9muAKkfnLAvAwrFfoYGQEUT6yRKNq20cb+JIe6?=
 =?us-ascii?Q?T806T4Ft3GKir15opwRZ6tTh2QhjY3dR1v3HNHyaz/8aaJh4Zd8aw8FOYEdm?=
 =?us-ascii?Q?Kk1xD3T/eddN5oEC91rD/o9mO2T/1qnwzIsHmg+JFN5pgLN37tvO1Z5j9w94?=
 =?us-ascii?Q?H1zq1sRUKPeqOqOEtWE79VlY4PaY+r+4kxvoKnjEYA8NZlpazTja2bVKwDMl?=
 =?us-ascii?Q?eCBRN4uaH+kDziV7v5wE1poUF/Xhp9C55jwho4dA5y2IRoPX3ABpXFpqhWuK?=
 =?us-ascii?Q?xQnxQUOeVkCs4Mnzh/luoY/djfP5//KKCFXMj/47Om8Ksm5874pdnAHngbsv?=
 =?us-ascii?Q?m8jPz3rG97vkAhUPgS2s67H6pKJ5/rNn2OpBoHm3qkrYMq8e87B+qFkqYaEI?=
 =?us-ascii?Q?X2x7Z7vn5LgcxmiW0zpW2DdBi0JoPiUdu0yH8z4PFVGXTaPt4zY9h+H5xvrY?=
 =?us-ascii?Q?OW+PRDZhcNDzcxG62ZZiNQCVSBt5y2hXCGwJKlVUvY8YwzJhpGK/ImIrkUVM?=
 =?us-ascii?Q?A80ExlkHYvuYWMJ/pV+4uBiKOalYi3fYUQAmvdl9GgMy0xea28pm9hGBi/WD?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3f5067-c715-4cf2-8656-08dd2f2a8f99
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:50:00.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swtDER22Ahe0C11jSvHSEBeVs8jgEIuApMbFJ2kUOgKlElj3C2ayBduf62YFjt1Yhp010tOwIo60ECTK3H0nFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: ca86543fc7c3ad8c0844f43fff664a52ffcb058b ("[PATCH] btrfs: implement percpu_counter for ENOSPC rework")
url: https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-implement-percpu_counter-for-ENOSPC-rework/20241230-054344
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/55bd9fed5b767365c633bf9aeaed49d335c9498e.1735508254.git.beckerlee3@gmail.com/
patch subject: [PATCH] btrfs: implement percpu_counter for ENOSPC rework

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7503345ac5f5-1_20241208
with following parameters:

	group: sgx



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501072208.959f0962-lkp@intel.com


[   55.925845][ T1785] INFO: trying to register non-static key.
[   55.931528][  T487] Unpacking libpython3.11-stdlib:amd64 (3.11.2-6+deb12u4) over (3.11.2-6+deb12u2) ...
[   55.936332][ T1785] The code is fine but needs lockdep annotation, or maybe
[   55.936334][ T1785] you didn't initialize this object before use?
[   55.936335][ T1785] turning off the locking correctness validator.
[   55.936337][ T1785] CPU: 4 UID: 0 PID: 1785 Comm: mount Not tainted 6.13.0-rc4-00108-gca86543fc7c3 #1
[   55.936342][ T1785] Hardware name: Intel Corporation Mehlow UP Server Platform/Moss Beach Server, BIOS CNLSE2R1.R00.X188.B13.1903250419 03/25/2019
[   55.936343][ T1785] Call Trace:
[   55.936344][ T1785]  <TASK>
[ 55.936346][ T1785] dump_stack_lvl (lib/dump_stack.c:124)
[ 55.936352][ T1785] register_lock_class (kernel/locking/lockdep.c:982 kernel/locking/lockdep.c:1295)
[ 55.936358][ T1785] ? validate_chain (kernel/locking/lockdep.c:3915)
[ 55.936361][ T1785] ? __pfx_register_lock_class (kernel/locking/lockdep.c:1282)
[ 55.936365][ T1785] __lock_acquire (kernel/locking/lockdep.c:5102)
[ 55.936369][ T1785] ? __lock_acquire (kernel/locking/lockdep.c:5226)
[ 55.936372][ T1785] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[ 55.936375][ T1785] ? percpu_counter_add_batch (lib/percpu_counter.c:106)
[ 55.936379][ T1785] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5817)
[ 55.936382][ T1785] ? btrfs_update_global_block_rsv (fs/btrfs/block-rsv.c:380) btrfs
[   55.945877][  T487]
[ 55.952842][ T1785] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5817)
[ 55.952846][ T1785] ? __pfx___lock_release+0x10/0x10
[   55.959912][  T487] Preparing to unpack .../python3.11_3.11.2-6+deb12u4_amd64.deb ...
[ 55.965155][ T1785] ? __lock_release+0x103/0x440
[ 55.965158][ T1785] ? btrfs_reduce_alloc_profile (fs/btrfs/block-group.c:93) btrfs
[   55.974392][  T487]
[ 55.987521][ T1785] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[   55.991671][  T487] Unpacking python3.11 (3.11.2-6+deb12u4) over (3.11.2-6+deb12u2) ...
[ 55.993503][ T1785] ? percpu_counter_add_batch (lib/percpu_counter.c:106)
[ 55.993507][ T1785] percpu_counter_add_batch (lib/percpu_counter.c:106)
[   55.997892][  T487]
[ 56.002961][ T1785] ? trace_btrfs_space_reservation (include/linux/preempt.h:481 include/trace/events/btrfs.h:1118) btrfs
[   56.008549][  T487] Selecting previously unselected package openvswitch-switch.
[ 56.013200][ T1785] btrfs_update_global_block_rsv (include/linux/percpu_counter.h:105 fs/btrfs/space-info.h:240 fs/btrfs/space-info.h:280 fs/btrfs/block-rsv.c:384) btrfs
[   56.017775][  T487]
[ 56.022582][ T1785] ? btrfs_reduce_alloc_profile (fs/btrfs/block-group.c:93) btrfs
[   56.028152][  T487] Preparing to unpack .../openvswitch-switch_3.1.0-2+deb12u1_amd64.deb ...
[ 56.032467][ T1785] btrfs_read_block_groups (fs/btrfs/block-group.c:2585) btrfs
[   56.037373][  T487]
[ 56.044176][ T1785] ? __pfx_kobject_init_and_add (lib/kobject.c:450)
[ 56.044180][ T1785] ? __pfx_btrfs_read_block_groups (fs/btrfs/block-group.c:2489) btrfs
[   56.047168][  T487] Unpacking openvswitch-switch (3.1.0-2+deb12u1) ...
[ 56.051296][ T1785] ? __ia32_sys_delete_module (kernel/module/main.c:732)
[ 56.051300][ T1785] ? static_obj (kernel/locking/lockdep.c:842)
[   56.056986][  T487]
[ 56.064822][ T1785] ? lockdep_init_map_type (kernel/locking/lockdep.c:4969)
[ 56.064826][ T1785] ? btrfs_sysfs_add_space_info_type (fs/btrfs/sysfs.c:1959) btrfs
[   56.070893][  T487] Selecting previously unselected package uuid-runtime.
[ 56.076610][ T1785] ? create_space_info (include/linux/list.h:150 include/linux/list.h:169 fs/btrfs/space-info.c:268) btrfs
[   56.078870][  T487]
[ 56.083932][ T1785] open_ctree (fs/btrfs/disk-io.c:3551) btrfs
[   56.092979][  T487] Preparing to unpack .../uuid-runtime_2.38.1-5+deb12u2_amd64.deb ...
[ 56.097457][ T1785] ? __pfx_open_ctree (fs/btrfs/disk-io.c:3271) btrfs
[   56.102798][  T487]
[ 56.105003][ T1785] ? sget_fc (fs/super.c:804)
[ 56.105008][ T1785] btrfs_get_tree_super (fs/btrfs/super.c:973 fs/btrfs/super.c:1898) btrfs
[   56.113427][  T487] Unpacking uuid-runtime (2.38.1-5+deb12u2) ...
[ 56.120107][ T1785] ? __raw_spin_lock_init (kernel/locking/spinlock_debug.c:27)
[ 56.120110][ T1785] vfs_get_tree (fs/super.c:1814)
[   56.126756][  T487]
[ 56.128968][ T1785] ? security_fs_context_dup (security/security.c:1359)
[ 56.128972][ T1785] fc_mount (fs/namespace.c:1232)
[   56.136352][  T487] Selecting previously unselected package python3-openvswitch.
[ 56.143883][ T1785] btrfs_get_tree_subvol (fs/btrfs/super.c:2051) btrfs
[   56.149929][  T487]
[ 56.152133][ T1785] vfs_get_tree (fs/super.c:1814)
[ 56.152136][ T1785] do_new_mount (fs/namespace.c:3508)
[   56.158851][  T487] Preparing to unpack .../python3-openvswitch_3.1.0-2+deb12u1_amd64.deb ...
[ 56.164276][ T1785] ? __pfx_do_new_mount (fs/namespace.c:3462)
[ 56.164280][ T1785] ? security_capable (security/security.c:1142)
[   56.170831][  T487]
[ 56.176243][ T1785] path_mount (fs/namespace.c:3834)
[ 56.176246][ T1785] ? kmem_cache_free (mm/slub.c:4613 mm/slub.c:4715)
[   56.181245][  T487] Unpacking python3-openvswitch (3.1.0-2+deb12u1) ...
[ 56.182666][ T1785] ? __pfx_path_mount (fs/namespace.c:3761)
[ 56.182670][ T1785] __x64_sys_mount (fs/namespace.c:3848 fs/namespace.c:4057 fs/namespace.c:4034 fs/namespace.c:4034)
[   56.188008][  T487]
[ 56.194807][ T1785] ? __pfx___x64_sys_mount (fs/namespace.c:4034)
[ 56.194809][ T1785] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5872)
[   56.202588][  T487] Selecting previously unselected package python3-sortedcontainers.
[ 56.207299][ T1785] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 56.207304][ T1785] ? __pfx_do_faccessat (fs/open.c:460)
[   56.209516][  T487]
[ 56.214586][ T1785] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[ 56.214589][ T1785] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[   56.223646][  T487] Preparing to unpack .../python3-sortedcontainers_2.4.0-2_all.deb ...
[ 56.228027][ T1785] ? do_syscall_64 (arch/x86/entry/common.c:102)
[   56.230249][  T487]
[ 56.234362][ T1785] ? __pfx_from_kuid_munged (kernel/user_namespace.c:456)
[ 56.234366][ T1785] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[   56.240802][  T487] Unpacking python3-sortedcontainers (2.4.0-2) ...
[ 56.246245][ T1785] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[ 56.246249][ T1785] ? do_syscall_64 (arch/x86/entry/common.c:102)
[   56.251421][  T487]
[ 56.255706][ T1785] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[ 56.255709][ T1785] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[   56.258892][  T487] Selecting previously unselected package python3-netifaces:amd64.
[ 56.263250][ T1785] ? do_syscall_64 (arch/x86/entry/common.c:102)
[ 56.263253][ T1785] ? from_kuid_munged (kernel/user_namespace.c:460)
[   56.267032][  T487]
[ 56.274439][ T1785] ? __pfx_from_kuid_munged (kernel/user_namespace.c:456)
[ 56.274442][ T1785] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[ 56.274445][ T1785] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[   56.281287][  T487] Preparing to unpack .../python3-netifaces_0.11.0-2+b1_amd64.deb ...
[ 56.282505][ T1785] ? do_syscall_64 (arch/x86/entry/common.c:102)
[ 56.282509][ T1785] ? __do_sys_prctl (kernel/sys.c:2474)
[   56.286810][  T487]
[ 56.291178][ T1785] ? __pfx___do_sys_prctl (kernel/sys.c:2469)
[ 56.291181][ T1785] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[   56.300469][  T487] Unpacking python3-netifaces:amd64 (0.11.0-2+b1) ...
[ 56.304622][ T1785] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[ 56.304625][ T1785] ? do_syscall_64 (arch/x86/entry/common.c:102)
[   56.309443][  T487]
[ 56.311651][ T1785] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539)
[ 56.311654][ T1785] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539)
[   56.316850][  T487] Selecting previously unselected package openvswitch-common.
[ 56.320762][ T1785] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539)
[ 56.320765][ T1785] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   56.327404][  T487]
[   56.332123][ T1785] RIP: 0033:0x7fed86229dca
[ 56.332126][ T1785] Code: 48 8b 0d 39 80 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 06 80 0c 00 f7 d8 64 89 01 48
All code
========
   0:	48 8b 0d 39 80 0c 00 	mov    0xc8039(%rip),%rcx        # 0xc8040
   7:	f7 d8                	neg    %eax
   9:	64 89 01             	mov    %eax,%fs:(%rcx)
   c:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  10:	c3                   	ret
  11:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  18:	00 00 00 
  1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 a5 00 00 00       	mov    $0xa5,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 06 80 0c 00 	mov    0xc8006(%rip),%rcx        # 0xc8040
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 06 80 0c 00 	mov    0xc8006(%rip),%rcx        # 0xc8016
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250107/202501072208.959f0962-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


