Return-Path: <linux-btrfs+bounces-4763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193BC8BC664
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 06:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A61280F48
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 04:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E1446A9;
	Mon,  6 May 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2iaCZHM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A43E462;
	Mon,  6 May 2024 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968472; cv=fail; b=H9g8U4foqy+HkWcFmh6dxGpr1pV6GUd1LDMi8t+db79pvs+FMwcleq86P7gv2jvsa2zM3DAlFMcStHNUBimCJ+hUhMMky67VibDOPwFAGCwVSdqDv/QN1RBkrgFvVqTZXxtmnWqV47x2bytpVuWJ6dIVidkMPMExQAX7tTGqg8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968472; c=relaxed/simple;
	bh=C4zLONW9DVaaHZTlLf46saRncqG9DeeWZOBTLhBCZyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvAI4S+oV/AjRasEXR9cjMOATQS42Hh7KEHsTP6w/hjFmvaoaNhCwToXBrnOigyGCJDVUBxG+zZzJika1Pmm7i9UYzo1K29OzO4XDjMtkZfcxEpbj1xfJzR0qf9wfppABpCPUuiNn84/5XcVyhZ62C7oc19q9Q4HWDCGeCaqPoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2iaCZHM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714968470; x=1746504470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C4zLONW9DVaaHZTlLf46saRncqG9DeeWZOBTLhBCZyA=;
  b=n2iaCZHMardpopBFokw59SCNBkTwdjLklZre7+l82jgiCMRS4aK94Qjv
   IZm6nqXObbxCpX0ZO5INs6SNgKlPH57lFUMZkYo3KpWO2bhc/XONknT85
   bB8nCevd350zkHjLciaLRlMVBa1LEvlnJBLj7Ms6CRi6+rXKXYNTWyTQa
   tKmo6Q7rP0LhNsLCxrGD68zE4FGJeMv2iMjHg8+yRqxbDNQEPGHlOjtlE
   23aFyHd28z3VDpjY4Vlz/JPchoB+93/NoGNxm8joUU5zViRhJfN28aihG
   dQJrMkSt/XWagGG1kL1QTLzMOnc0WyFSrf8SzzOR2gD5sg7xoUFr+tV+A
   w==;
X-CSE-ConnectionGUID: ++boTB1wQzmboS1HnPFTXw==
X-CSE-MsgGUID: LchX2XdjR7WnqMc5tn0b6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="13643549"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="13643549"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 21:07:49 -0700
X-CSE-ConnectionGUID: le7qhsERQKGUN1nNK4c//g==
X-CSE-MsgGUID: CDecEVtQTD6xqCb9px7PcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32707671"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 21:07:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 21:07:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 21:07:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 21:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+yLXIF1AUZZEfCTyqdniJL+2YPX+zW5GsoGBa+W44wcIfJXo6e6JeSW1iOgo9u3Rmz9cBK1YU0NmJYwECLFH61bdc3gZBSyCJWRdNXVh7pfiO9NqRRxOZwg1xCL3JBdELSKjS07kWaxp3htd3UGnDGfumwzwCz1imrziac31NdO8gONTlDya3J7gT35uIoFdZPkIvhP2/fgmmxjc4bhRiXs22q9dlj1pH80pEec6ncpAi3avNjoI6fhqKCF4J7SpxlBk1Xcubf+jNAgq0sQXaFLH09GgWaCuqjeMdSPMHw5v29VwQgW1kUcIVcEKztWcC0zZV7j1bzlDMi9yFACgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcaImz/6a8oI3I8omYxA0juWJMEmbrvboRjUrZt97gE=;
 b=SDyHdDrw22QNlL81bwdL0N5A8autNY3hP6v5xccSAfeRPbwzVtz4fpnT+qS56lyZP+VElwuopPrl46sWIYGVCXFy8V8faxicNDCDXZpIZ60h5xrCgG5pXRHhXuiNOf/PKDp+0STp/MUD6xH+SO3J+Jg8GJqvlOf8f7ejoU4i2fb5PicSEeTMBDGCLiC3LwIixKgAAjOUf72UISOX+rYJWUPG8Jk9sW2WZkzv5YkolSzMH7xDwYAUM/Zt1v7ZE2JyahyPvEThoRFIis+mX7QKgWgJ1WcvOz+UTkaNbHVxNhMOayNIjYryieA9V8eCHNGXzMcPzDP/CW8U1uapdSEKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 04:07:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 04:07:45 +0000
Date: Sun, 5 May 2024 21:07:42 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/26] cxl/port: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <6638578e2d7ed_258421294f@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-7-b7b00d623625@intel.com>
 <20240405145444.0000437f@Huawei.com>
 <66351a55a38db_e1f58294ce@iweiny-mobl.notmuch>
 <66351d0f9ac2e_1aefb29492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66351d0f9ac2e_1aefb29492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: f438d348-c21d-4dfd-7ca1-08dc6d821550
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2LNhq7A/mzL0sE7+lDldAau2ppd8hQirlyRM86MxYG3p00FNiJ8y8NnSfA3w?=
 =?us-ascii?Q?Btu2WcjblKqgkI5C4UTzW5DdomXzarvUYAu5TxFaZfucjqMq/nYj4r/EdJVQ?=
 =?us-ascii?Q?5rifgQrzMGBX3Bo17/MUq/+W4m8SxeWV5ZnCR9fduQo6JBx8x4GuUxJX4U+l?=
 =?us-ascii?Q?5W3I7oNhkbezHVpe/lqLyUc+QaTn6xssbdoejJu6BVB+LiVDI4FZjbtnkUtr?=
 =?us-ascii?Q?LDjSIgzZWe0ODcof+SpCPZ3LkCrzkYNzbFTo8MtnI0oX7yl0XTkh9c05hHe4?=
 =?us-ascii?Q?hmplCC68aN7A6Dc0UyjyASKfdxY7GfrwN2R38VzMnge+I0rwuNdm1vXRjekc?=
 =?us-ascii?Q?LgfBD23VAfQrvw5ulBphOz48uTtwfS87IfdfkMq0OU2eoh6/+WtalWo1A37X?=
 =?us-ascii?Q?I0WPX1brHX+5O8piMAXXfxHUsG7h4ddpv7s0m/IlImTQ1TR/3+JTaAmrZpr9?=
 =?us-ascii?Q?VXscEVccr6x76fBt8hqVKtwCwUAn67Xx+Uhzus8kzv5vjVNdvfJ0ZUVmnPE3?=
 =?us-ascii?Q?v4cl8Fga/9LXRywfsigkBmP3/XJ4QiwbaYFgo8xRxK5tzI4cdZxZoJ2w4UUE?=
 =?us-ascii?Q?XqzHYOE074IRTE09ILZ84VxXBi+hI4gaBddBPLhenjoZzIZFmc0+xAflMqts?=
 =?us-ascii?Q?imFm5P4RBrjimb8MJFUNf2ns2PK7cQqfPAMhzHCZrR26sZcD+VIPknKFoZCA?=
 =?us-ascii?Q?ROH4mqJIcQc0w4T6WkzxUDp7iGADoCgWs4nAu4W29HXbg+mYJnECHxgttvaO?=
 =?us-ascii?Q?JbBK+oZH5Jfm4tddlXvq1Z1wrMfTE+XhmvVob/1rRDC80txZ/7cRWXuhWu/c?=
 =?us-ascii?Q?OS+50XWG9WNYbQFdKvxfIgp4vUkhyFUoB5aPG3QyHBojD9an9C9TyzfRiGpn?=
 =?us-ascii?Q?U2G9Od6y6jHy+RC/IH6uKJaJPf2ZuawgbWB14NLZR6TCN2+qXqkHYOFBFDhN?=
 =?us-ascii?Q?WH8vEjdyOP0CARt6aWzPSRQK8re6jZhc0Yb0rFGAg0TRk8QbdWW5DH/b+k/O?=
 =?us-ascii?Q?eVCSlUUplyK8nktXniYTo7IAEGyIVZ6iDPc9mPgti5xiXAi83ULHhe5DQKgd?=
 =?us-ascii?Q?QUlKV5Anpr/k4Sq7RxaQ6eK/s8MdfWukdUK96riow5qcoknTUqW89/4Ai8hC?=
 =?us-ascii?Q?olGhjSnBrIJKMXGqZ92QldhCpJUSmf8v2mAnf4ZZt4HS42VJnu23kPRWELC5?=
 =?us-ascii?Q?uMi6npgh18X0zNyxhg9+dhtFi6FllmJy2K7LPf7NlvhRfz5osGkPKOW4MePT?=
 =?us-ascii?Q?JPXYlXNYp4Qp2jDcdmDMegjzSx8+suhCpdf2aYGXlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xBbcKnQvGICUMtMlP+seQXA/LfzVvbR1uSKq16g/pY60m046pIUrjiTfpJW+?=
 =?us-ascii?Q?khiwrypf5zW87v0hytqz9dLSn6XvmCtvqDgg6VtsYxPC0DLSjfCTg1Gw/Y2t?=
 =?us-ascii?Q?HKEtzimcXqtWF7MaKz93ueTR3Rs4hCaP5HroxY42sTRW+6BRAg6tlrDnpQ+U?=
 =?us-ascii?Q?9Ni1lOz2VvUhlrVtG3wcNOC+Mn1P8ud/nrBbuFMmmWac1R9z01iOPpG3HcvI?=
 =?us-ascii?Q?V/2Q/HQpeMV1wLXM8C2KK5rVjlaKGBOpQZoqn1xy3/sij6WwHNH1B6Bq2px8?=
 =?us-ascii?Q?217S5CkFVv7TbFRzFq1WSlD0VbwZsNs9wyc+S9Jnd2Rp2HJEtah61lMpOTkW?=
 =?us-ascii?Q?fE7MMfwuP5HJ4MCn3812MAcxh4ve7nnd/rCrAfdgQzHYeKLMF15iZNghqDHA?=
 =?us-ascii?Q?gxN7qu8nj2qRKd93krsoj6ANNA2KI/Y+U1Nay8Wdl2lIn53apa5/2UOhJUha?=
 =?us-ascii?Q?6uH8weKqjpA1JpegRijIqZ0Clfjf3nC56B/XqFAA6/j0aLihIALGIDS10lQ2?=
 =?us-ascii?Q?KTheTpouZI5xjJRawzA+yyzZXygPSlSkXZG/P++jyn7xkge1+Y5ftZ+DjEqz?=
 =?us-ascii?Q?iP/axndCs4aL5clurL1FmRXSasolXuwUaZJ574Y6gvFGsqj0F1xJcJPiI44F?=
 =?us-ascii?Q?lJBhv66RA293c3JOVcHPXwjCcwXUHg05kqT0ObQuK3/GFjtsr15rmnCv7grz?=
 =?us-ascii?Q?KD23zwAoAsw/veXJTMN64wfaZDk9t13DF82aY70FkVkT+8QD/qNHE8sFELtu?=
 =?us-ascii?Q?GJIS6Hc86LjpfJtI6/kDPhd/g5HKa++kcjWMuAe3IBx3zdZ7brka5n0jUYHs?=
 =?us-ascii?Q?93bF/4AURHZkugP6/U5gL5QcRDq0/9ASNUp13ceuTdSjVQwH+EnE0rbdQlG7?=
 =?us-ascii?Q?1DQQ/85dSxN4an4+V4CfH45swydRULPTabMCFpGi2IvKbRJoeF/ef3E31pRD?=
 =?us-ascii?Q?4Mv8+AeCIvWGA+lKJKzntG21pW8IesSZVdy8D62M8+cfweu7eEnXs7mI5B1T?=
 =?us-ascii?Q?o+VpYJx+/0BF5GRdm+rUwq9cWXsqRPlHC9Iz4S1kABCLnnSDj1xXMULWiTVS?=
 =?us-ascii?Q?0L6kdvx6Z2Z0AW/h5yyOW4u7Qx3E28lHmJla8JrwPC2uLxvfFQlw75IVwT9Z?=
 =?us-ascii?Q?vaWmVXJTJ6ITP9tQalZF+sX3xxNWPaTrW0amr1HU2RLtYYqu2PJ1BzSHSFl/?=
 =?us-ascii?Q?pE4Ut4YkCTjfgrXJ7HzMtyt4KQTWJaYfd7pSd21Za+OamBwtLYBxbL26orBF?=
 =?us-ascii?Q?NizGgESfeX6f4w84P9UdgUiXKgDbO4cT52csWVCJhgy8cZHwal0DuYgPA5Ro?=
 =?us-ascii?Q?Q9WJTii/oJg7U/CznGs8zCMrUvqtaHTu81qP8gcH2/bpltEVfgBYyMoCFM4d?=
 =?us-ascii?Q?J55vMfMbsNcGrhWCec2ZVHFjQJn/2X1d9+3znifTn8L97f2YzYSKBcz/cLM9?=
 =?us-ascii?Q?g1whoHsS54HCjxXW3Ww6PkuhEdAEk+29XMCsvBs0udQjA4PUb4I3IK2Git3/?=
 =?us-ascii?Q?ABnf0H93iGYAbkp6GSr6g0SUpe0OmfRgVoPTrrabh1feMb+4D7rOq60nqlqp?=
 =?us-ascii?Q?pV6/v1fjGNO4tryyAevlcv4nTN0UloiOEB59NGtI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f438d348-c21d-4dfd-7ca1-08dc6d821550
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 04:07:45.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VODxQLe9x8GKZkw8Vq8fPbEgz165v8avaFA90S9+OTZlh4q70SmEa7QGuT3ykQm0dIO8TDytWByzUfNtnTdyzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > > >  	else
> > > >  		free_pmem_start = cxlds->pmem_res.start;
> > > >  
> > > > +	/*
> > > > +	 * Limit each decoder to a single DC region to map memory with
> > > > +	 * different DSMAS entry.
> > 
> > This prevents more than 1 region per DC partition (region).
> 
> Why? Multiple regions per partition is the current status quo for other
> partition types.
> 
> > > I notice in the pmem equivalent there is a case for part of the region already mapped.
> > > Can that not happen for a DC region as well?
> > 
> > See above check.  Each DC region (partition) was to be associated with a
> > single DSMAS entry.  I'm unclear now why that decision was made.
> 
> The limitation of one DSMAS per partition makes sense otherwise that
> would indicate performance across different spans of the partition.
> 
> > It does not seem hard to add this though.  Do we really need that ability
> > considering dax devices are likely going to be the main boundry for users
> > of a DC region?
> 
> It seems like extra work to make DCD a special case compared to the
> other partition types, so the burden of proof is the other way. Why
> tolerate DCD divergence from the status quo?

I don't remember the details.  But this was discussed before in a call.  I'm ok
adding this support.  I have a test for it now.  Just need to tweek a couple of
things.

Ira

