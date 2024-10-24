Return-Path: <linux-btrfs+bounces-9115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B329AD9F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 04:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CBF28372D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 02:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83E14D2B9;
	Thu, 24 Oct 2024 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMmSsJJ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108F433B9;
	Thu, 24 Oct 2024 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737219; cv=fail; b=DnRD+sENLIQVJveZk2D9HiYV+AD0EVHt1bznGJW1U4QFJA34yPPtJKUgVTiOV8vEnSxfAKvk3cRQkHk7gbyV5GuM9AMAxXsXOMD11KipoWX/9cHBW/azAnZJgSEjUlPueseUbES26qgCONZj6B7+UjxTS34nuu02gDbRKrbH07M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737219; c=relaxed/simple;
	bh=c9KDgjs6Ot5LtRGBuZme9QBwSm73v0h1gP7m1/KBfJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVpcYGSReaViLoYAk5Dn0nChRvPbt17jBtzIMQnCEFIQvlMaNQ5SaiQbpPDr5L/QArLyR2eoRdmYh9Ldx6nOQC8NeoSbUXd53sBdpGOhoRxN0jWPM1gah9VBGcttv0tzxiFx/9c5TGQ3uuOy2fv0Vwam8BsTSSnxzaRNmzXrkFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMmSsJJ8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729737217; x=1761273217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c9KDgjs6Ot5LtRGBuZme9QBwSm73v0h1gP7m1/KBfJI=;
  b=lMmSsJJ87SZ9ixFfoIz7WkVBfcmQ5A5dqI3BFTO0D0SDn6a6P0AX1vcJ
   ZAY+RZPsnuf6MBopr/nke2OQUf2ENI2pAJCtsp730D4SQF2RDSnpKCK12
   p2qrClkW5QcjRQdiuaOcshGKBJzWvohyovck6Mtf2R75mnUodYwmBWh6p
   HlXsuuhfyP/q13lRCphjNZ2JFZDwwRgwTr8TEGtXiS4tFtigcpQ5UFj6p
   oJxOCZ6VjbYDTMuPd4b7udOIzk4IiUu2kBoneNGWMQxHC+gDTrr+oQmb2
   MvMVoAQBHThfMk9XdVGtzeoOSuKFeQavWvjuiWyVIckO574p42leOQr8a
   Q==;
X-CSE-ConnectionGUID: V223TsqhTP68Iw6U5t6oCQ==
X-CSE-MsgGUID: qgaNPTR4Rpmv+zdm4NdCcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29213540"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29213540"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:33:37 -0700
X-CSE-ConnectionGUID: qQVKCF7WTXqQFq1HJKSdDw==
X-CSE-MsgGUID: 84EQjJjUQBGj7FCdp2Nrwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80026619"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 19:33:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 19:33:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 19:33:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 19:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hujaaPE9uDMVKpUPT7hGNAmy5dQ/kA2VpeLb6dXzXkJxOLwJu6a3axQALR7qJSLmS/xuD0aKZow95amVb212HTYRSALwuUduFwDFoI3CsCEAuVEscTDUs92sp2PBe42EpWXTgmQWEKtUYnmRNQqH6YD7zDu5mjJGoyXk284J4jZWL3w/i7nlals7yolo0RDEMuoYpxFiNKw/LMO8rFSIExnGzhz2iMxP3qZZVULly0ryhpuWrh0njL3e6HJM0S7oi4LuzSHN9dha81Zn2qxnjav16jSDtjCtFDakHgzywrb83faXtdJJNsLTedewggYz+asH+mj0bC8V1S8WRFY8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0R0B98r/vVY/RBHxZj6bwNdbCoJGdv7cgvh4/k9KrQ=;
 b=SmH9XWArqHMhf3yaj9bGZ6PObqb06urUxwcs4L3w2vvfEhF+H06Amsq/X9MBcU5ms6PSq05mXECu3RSzWqxfE0hGS/0yhTo75GT7OdlGZV4p4y4X+LYFKd88gGaSNVgmlGw0Mpq3/DJ270kZo1vsNUcT3amHf8caOCrUotsI7eMT9qnqddbETmecBqRYXixrerZOnOamsm/acAgcbJN5irVjw+h6e9O0r7WcQhAiHuatPlgDvblGq5YlppqBnjP1h7aF1zp9IaaV/Vni4HQVEy2WLwu3sKWO10kO25c4a3e6o6ypIoEQdZVhSoETU1eu++v6ZidYDz6SC+ttZuqDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 02:33:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 02:33:25 +0000
Date: Wed, 23 Oct 2024 21:33:21 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 17/28] cxl/events: Split event msgnum configuration
 from irq setup
Message-ID: <6719b1f1c7dd_da1f929462@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-17-c261ee6eeded@intel.com>
 <ZwgV4D9NmcC-SAYQ@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwgV4D9NmcC-SAYQ@fan>
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: a4816834-f4d9-4185-9e03-08dcf3d43cb6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G6/lWS1YA80UvMVH8yrn9eWT0y0+jGMLeDxdUZSW5V8Zai/WA4taQ1b70Jdw?=
 =?us-ascii?Q?q0becxwx4KwcWekdNjzOlzz2IeKZIZ6p1AsFg52q24//B+kiLskW11BDmFza?=
 =?us-ascii?Q?8UP1TK5aA0c0hwTxF/shERm1z3q0qketjxGe0WK2bjQOQ8b0EX7SOzrCXWJU?=
 =?us-ascii?Q?pFyNK9Ykm/Bd6dpKDemHWpa33j3btTgj+mR6ILjBD//jX0aMvgxP0K/X5TBf?=
 =?us-ascii?Q?IyoZ6k6ZP9P/Z9I34L406Gco5Qmm9LoU+dpsU6Fi8SKYq6wx/ZstvgH4Pnw3?=
 =?us-ascii?Q?AmFTm0nX2vdws8/EYvOHqvDI6UUz0okDOlTSxlOjLguyIEQokEXCqNAj9hH2?=
 =?us-ascii?Q?eNiV7bX3T2c09qEk8CIvcj7wl80NNmqBsAwfcKUq9ZbvSpVqXk/3ZlfqOX5i?=
 =?us-ascii?Q?ktuyIBsolQXNXEkrHmz1NKSSpllB7SntMyYwtyErNEHtvN5E/EK4ibR/5KV8?=
 =?us-ascii?Q?RgiQWBfB45ed5VvItNgaEJRPHbN1/LKSG6nkAbvKneepa2CfIvm0T7xkGPEd?=
 =?us-ascii?Q?6N5hzWKwA9jnoXMFdCZCTdAE/TdiNq8sOkr/iVcv0lqCHh14Nmb9obB47MdL?=
 =?us-ascii?Q?n4l2kaWXfcGwi6mp0ZxnjuWrjpwQWbYyU+6aO0/eph4WgKNdtq1po7VsTUHv?=
 =?us-ascii?Q?awAA7j5XupL0n/gfwA4E8ETvHdfvZ/YJ8YJNX8z+RBOZxb/DJh7Rvj323fsC?=
 =?us-ascii?Q?dV/3guZGhLfWLtrEBjW6WNuaNP5SkREurHZpilXycOTlZ6QpliOkP/ZYPO+L?=
 =?us-ascii?Q?JLgoy3I7M1mseSmkGCFIhcGVveX/YNxO/Si1pMtnH7OVLRGv1StkoBPteN6D?=
 =?us-ascii?Q?rO29FXlo9LoCr2MM/h7T4nMpiqGo5ib32v7p9B5YSAPYMQTRuahT3zqhXh/4?=
 =?us-ascii?Q?26SdMRSOIBahP7y0ZW9d+hwKgxGX23Dce9N9Tj02Ws7gdwUTdTXNCxIc00Z/?=
 =?us-ascii?Q?73M0RDDzxnS+0glwitNSxpqFAlIyytxd8RAAYv41ppGvHkbmBZxqiMcg9Mzz?=
 =?us-ascii?Q?e5nA7HuDH/BW9mJFv5It1DZ7m12ldza+/fz74EtMYNpbx6Ozk9jRkC82XX+X?=
 =?us-ascii?Q?9UWh8OYWv31JBr0O1pzlmotXi3wnQJBO5hq7H9ir15LDE7xIeHG0G7/TquJX?=
 =?us-ascii?Q?SJiADxrfWd42n8nkuSXdGseUMZIckEuxArxE8oK9ZPn558Xv8/KfqxnstZNA?=
 =?us-ascii?Q?cRhIZMbwsGTCQy5uf9EJPT+KgbpqpGSqkQMMbsioaBriAkyLFRWjjN4ODRls?=
 =?us-ascii?Q?mlMoKed6QMaFu4an9v832MzcvQ2JpgoKSNMvPCQ/BqQVcVPYXP+pwfi/G4uA?=
 =?us-ascii?Q?4toQ3ktKXX2sLv3qQg/8Hl8m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNv/ILSbH/y2fL5RijFtMOTd807sAfa/evZTzLqoslUNhziXoVrOwszRhLTY?=
 =?us-ascii?Q?OVpLRprnC78INvdpoqg1CISABibPVWtfaNT3VSlC2U2ioZ2rNXlMTeJJlvoT?=
 =?us-ascii?Q?j37SOP3uhtyqaEqKIwR2ffymix4xr/1EcixwS0Y99yweyz6USNQ0qDaTvwz/?=
 =?us-ascii?Q?AqqwxQtmTezhFDfWhbbJpnPNJGeN7bAksypWnfPc2RLp7QPpptEUXowUEns9?=
 =?us-ascii?Q?bSrZ+YuWKCpk4mCtlYyL48AtAo0EqawDfCpBfdLI8L/6ovA+LN0TB2jTTOft?=
 =?us-ascii?Q?BvMxkhmxC5v4z/BodkOKQPgxLwP6dFjnSWwcgpNIwdx60P/Yo93wAL0Zt8Qw?=
 =?us-ascii?Q?IeAW86xBFnTb6AWDvCXv+LTosSqdNQ7zNCt3n3CpOf/gKARSLzuUnDnJTups?=
 =?us-ascii?Q?C49CwlBDxPyF8B1QKt3c+xGO7pfRoh1U7Zo/eppMLNzWcrS06WYP+FVjJHXl?=
 =?us-ascii?Q?VK8m+mzMh3a5BzwVEde/lrG9Tqi9wfjosCFJGPtDV9WQsOvk5wnxXChMdQCf?=
 =?us-ascii?Q?GQsA3fx5f/NLAWiuAAAl/IavrB4cQYAa5XTlfrcKo5TQBu65LWg3s1oXexVs?=
 =?us-ascii?Q?fbqF5GMFPyUmPxLp4xyT6xheyCVxxFrvCeCMbnlCniIEcbAfInxWYKolDyxU?=
 =?us-ascii?Q?JEVuXslf/vWsdDCAKmNXSTPew41zlsr1Gpgz27CnSXTJ/zljLthlNfqg66/K?=
 =?us-ascii?Q?CBObsII6uD5QUak46jQ9cbgkmwhvLnfaobw63ImiCeLir7UJV2bNR5D5CQT8?=
 =?us-ascii?Q?HKasDxEOC97BPaEzFEVhfdfuo2GpRel5ail4gDxLUrWuR6g6QiAZm+5rpjK0?=
 =?us-ascii?Q?1wlQqgmlXsmU6s/wU+lfmXKBhXEd/+hKDcsjdCT0qbjsIQskIpKchk3kegqN?=
 =?us-ascii?Q?QBlwN22PA+Dm8nYpZxIOECrnun8JmlOUXFZeDhZ6UKDzguoTgDdZbM+BOBv6?=
 =?us-ascii?Q?7C0yjOuFVTTMGulAnzyvKJxHKL4WTMxGjcSyEDUQxRVn7ZJrJlwDL5VGOPn0?=
 =?us-ascii?Q?cDx5uLdUg10xaqLyaaFGqxFjzRof2+ifxUjm3OZChWF7QtkC2h/tSrHnv2gz?=
 =?us-ascii?Q?UIryo6MmXi5/WlDuOQ3WtOmYh1mVJ+3MSrJOCa1UNZgrntMhLz4bnIIOJZrt?=
 =?us-ascii?Q?ZnPTWzZZGmQHl7CwIT8+opDHOJg+WKF36fT4Ew3M80NkMTHxapD1Py/pjIl5?=
 =?us-ascii?Q?OFJHSKbvRBHD8ixzhPfMSVCh+4zfEzqvsL3J2gbD6yuuhDY0QAdvt32MLBbj?=
 =?us-ascii?Q?Ogl6KXKcW35rtdBiFUrLc8AA+Ne8ak5jc7bDGOk5xGcMZ2tQzGYTojvf6c7P?=
 =?us-ascii?Q?+nLApVfKbD0Us/6we+Ir8hbdXkED9kI2D9BPckJ/XMxcMGiTUxne+B/FYH/d?=
 =?us-ascii?Q?5dqZRMJoQEthGWic1UOBBsS6W+66553vyYEJvQkdxxZGmz1B618PgFKFxsqo?=
 =?us-ascii?Q?Y0rvENIi/eOxvjjp7eP77KXSb84uAal6C4kCHZYK61pGVfuykTrOJcnV36n+?=
 =?us-ascii?Q?qZZObGk2LrtP1Ii5jSWLZ/TithgzXnT19q5EeXgN1KbOhQZLluxqMDlKCU5y?=
 =?us-ascii?Q?VoX9QSB/wVy2cGVWXsf+VAoJdfOR9u5sIDBfdo/6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4816834-f4d9-4185-9e03-08dcf3d43cb6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 02:33:25.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m09yFnvhCHJ6M9TWlZP4FdMbQ4BN0b0rN4DYZo2vELHJcDOhYBpUDxPKprIhnuRncdV4UsAUm1aj8el87LPhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Mon, Oct 07, 2024 at 06:16:23PM -0500, Ira Weiny wrote:
> > Dynamic Capacity Devices (DCD) require event interrupts to process
> > memory addition or removal.  BIOS may have control over non-DCD event
> > processing.  DCD interrupt configuration needs to be separate from
> > memory event interrupt configuration.
> > 
> > Split cxl_event_config_msgnums() from irq setup in preparation for
> > separate DCD interrupts configuration.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> One minor comment inline; otherwise
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 

[snip]

> >  
> > -	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
> > +	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
> >  	if (rc) {
> >  		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
> >  		return rc;
> 
> There is a lot of duplicate code here, can we simplify it by
> iteratting all setttings in cxl_event_interrrupt_policy like 
> 
> for setting in policy:
>     rc = cxl_event_req_irq(cxlds, setting);
>     if (rc) {
>         ...
>     }
>

Do you mean by treating struct cxl_event_interrupt_policy as an u8 array?

I'm not sure that is super beneficial.

Ira

> 
> For DCD, handle the setup separately afterwards.
> 
> Fan

[snip]

