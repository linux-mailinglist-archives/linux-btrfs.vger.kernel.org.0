Return-Path: <linux-btrfs+bounces-12511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA251A6D55D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 08:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BA9167F63
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6B18DB34;
	Mon, 24 Mar 2025 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie5HGhp4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016725C6FB
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802351; cv=fail; b=MK3jxMo+ncLYz2CSwlGfnDFhEje8nFFAnscXXEPMNi2O6E20qEVGJnakfyj4fYQ0ZWbDK9FqXewmElA0BfiF1JGT6aEFn+R55IHC6HOv0Q9zR8EVcI6bKHBWJVaXOyWMfLaeB4J2eHlmV5HfXO+UwdwLYn8jUqtjAML/NDVo1iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802351; c=relaxed/simple;
	bh=mvNJYTQ7aHiNFHg2RcRz3eifjlvxkmPt3Q8NEQnF1Ao=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JeEAyFXpvrfbIyX+2OXZ2C91D6Wmc+jXZGHIKfcszB4/YZ2DYPssZjkiNyUWMPor1FvAxcRUjNF4WMx/i2ppkOBMQM492FKHuneeujvsAiDx86CAWI8/nNtcbp554tC6g8+KryaDJMbQ1tBO7wi/VK0L16FUUZCdwhyN/F8NZes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie5HGhp4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742802350; x=1774338350;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mvNJYTQ7aHiNFHg2RcRz3eifjlvxkmPt3Q8NEQnF1Ao=;
  b=Ie5HGhp4nTTWz7sGrsC++LjJW/9BxIBLipkmkTCcdbOk6X3KpbNRkeAM
   +xooPYXfnNZfQPWIBjvcR6sXr9DBOqc15q6IaxGsAfCEup+qKkH7gXVtB
   3r9Nzq8ER5JbqTsYhqwjMiufGUFTAuAzl1QFjTT6I4N+vYbD/T04BxvZa
   naK9a0y6E9h5uInErLIu/fYuzBEjZ+fSLu0TBj6P3WYNMH7JMv4znMHdy
   YSdn4/T8CY6n+COaR8UpELp9hfvklkhgBSU8Eu3taDgJC3odw8tAM+ym3
   qV2yXb6LMue+aHDbRdraZlEgcH1fMqbgxgKjP+mCi95ye9Noi6gUbvWHQ
   w==;
X-CSE-ConnectionGUID: vVzp7eUwS9i01Uw8TBFmlg==
X-CSE-MsgGUID: 58nC6zFSQASxkV8+twCdAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="47646914"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="47646914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 00:45:49 -0700
X-CSE-ConnectionGUID: eWZDoIE5T2Sh+/o3oEMbBw==
X-CSE-MsgGUID: Cd2dPZneTRSqaR1tahNW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="129074006"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 00:45:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 00:45:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 00:45:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 00:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzyGSCLPE2Tm89iiBkOchdxlg67jxozqgYvmiLPttXd7r4FjWmJ9CZgxrQX3Cc2Zw7TeWqnLM/hHr6JnkGVO9kOE9hexSNpKk5l8mncsgIcUDpQ/HPxrL//8RledK9TiR/EQ3Vf/yTxh1pUtAgxaeoxmsEKR6pEI8JuhZ3evtwr1W3qNoaJvcp6kUvGbgmKHlNyQlJpMZowue9+zUf8GI7rUeu/aq8AAeDwariwtNTgbiVFTnn83TtaD1yy5DTkvMDO0qGA1/HlRPpExqgKtN9364OZjZTX7F3BXxwSD3eYU2GHGYCf8wC2o8mJiOoGTo/Oy/1ASSLGN1pGttfKmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=896EwZk6HrJxQ3PRl7J9NFgLJYxuVc7I7tf5MvmT7VI=;
 b=P+5iuDtVqYwEFy8KgPhMd1Jw95fvawl+wIBUyc10A9nEdiSG70Yhc3TPEkjBjmsZ8XFPnnSvzw3a5BEekrFWe+o8ZyNoSwMCXZLgQ3fYv2CYkuKPG8CaemKrKds1Ijre1qks9mSezByvMyi2m8aLxfuKS952x+2WJtefKtQoMvgpGZpdhV7OuZBtCLzujTWxJQogol8g4fZsSQGhz/19hjWZaoJMNHIMCktYIa8picxe+5vj0/tOvGgQzlQcK6aLMwchGQ4317CQx16DLGA/HOm1i1Zira6zPvSKkP+NiRBHKZ8DrptcAtPHjdnSr7AvRxPAtrK+WhPJ/Jq/OwYTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:45:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:45:40 +0000
Date: Mon, 24 Mar 2025 15:45:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, Christoph Hellwig <hch@infradead.org>, Filipe Manana
	<fdmanana@suse.com>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  968f19c5b1: xfstests.btrfs.226.fail
Message-ID: <202503241538.dbc17bf9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e73aa8c-9271-4bfc-9950-08dd6aa7df97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yyf1waTLwHYf6IbXbofQ44nmVaydi/fKEIjW0dKV+21L2UwKsalScDl0HqCu?=
 =?us-ascii?Q?HLBBDB7bdx4ghdjFzH1ahgaPIWS+aDgomQDswIwleQCHMgVkP6VT0OhznrRZ?=
 =?us-ascii?Q?eK/xm/7MZ+DAmmkqZ0HM+Zx2dp7JgHW3hFBAqUGr6v/ED27jCRiYbwqRcozU?=
 =?us-ascii?Q?nGkSewZtkRkymC2ZLdiWj67qwyvzy/6fAXxsXEYwmHG2TM4QASrvK4N8RKAL?=
 =?us-ascii?Q?8Y4qNPpdKIArJUmC+9S2I8eM2G2q8w5aGZbctJDnuypo2fzt4P8MfzoNzuUq?=
 =?us-ascii?Q?59GxJBZMKVvfOlhbAJ93V6o3ZmgmyNTIgXEaZJIQciB0KeWljyPbuO3ConoH?=
 =?us-ascii?Q?4oCdhwjqgMGXBG1V0lFltfV0DrYp71wGOtK/yE97H5AtFdhp8kjeijnd6o/f?=
 =?us-ascii?Q?D+gPn2FV9CMxnYMe5GBTRDT53XPEJibWXXwUKsIZyWGhLPF8iEOKkOHdj7uB?=
 =?us-ascii?Q?wF4nITz5QTiQD54HZMzgL522lOAhTfRL6h7v2KPost3lEyBZiaMZFwXE9Yqu?=
 =?us-ascii?Q?J4gtzbp0xlF7/lYAoh8CmrL9S0Ek9hTYchWXeW9D2IZnHua10m2UAc7azSlS?=
 =?us-ascii?Q?w1oEaIj9oMNVztH7jpbWOmJEXwOJbdsOzC4IcuSUpZz0ByVP7PPzMlhlrhak?=
 =?us-ascii?Q?ryIwZejONRexBcAqlXVL/1Gspx+BXfRQggDnQBLesJnuK0SZQlhhR7CZ1kRe?=
 =?us-ascii?Q?Oyy/g1ZD/moA/vtUnovtbx/oBIh2I0Vv04muQK8ybKCViFc1BLOa8XQTsbyQ?=
 =?us-ascii?Q?egveQr/qTpMtVooK+iboBSG7E9wtThjHuIvk1T7SBUk6WXoQHVOSVMcJy/Iq?=
 =?us-ascii?Q?05J3Qm67RKJpdqtrEQGlXnNJ8ad5F1DU/bUjJJGPHrf7D6NIZpTCcSKcPJl4?=
 =?us-ascii?Q?BaDJ8i3LowjZ34FdysyfBFec3qo9fn5skvilf4y1yVsuAm9P8JUQ8Z56uY7t?=
 =?us-ascii?Q?CthbMROpScc/tePKzrhtZNAyHlmHkcPwJSbl9fX8BaVU5M31vQ1XqL2a2h2E?=
 =?us-ascii?Q?1AyHrVGsH+MU6//7H97H5jAePT1oxqgJHKN9WQp7XyXgNggaBRuRa4CEXYCV?=
 =?us-ascii?Q?cFU9nhX5Zx2ey4M/gkZk3UWpHgjoBW3Qs3U6U/Egnpyu1AON8LlejfL9d7mY?=
 =?us-ascii?Q?ZEZeMOVT4x+d5mm/leVjQe1K/2fAEhh932PhQhWZV0e65bxDgdMCHK/j8+nl?=
 =?us-ascii?Q?uGyeORjUq4TdG1D3HYhfm7v10T+hMx3vHOpq6mMA2TKAVH/7C5XgtiSY5CE2?=
 =?us-ascii?Q?kTbQgrkNHjvT0E3DpWq6H9PaX10IhF9e88zqxhTfUnhGkJvUSNTxFkHj2kYh?=
 =?us-ascii?Q?WXwbQsn7595H7dAy1GgjPkU6uGYKq4ag7yKqRzIxcOQGRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZBl/eaiP6t/Ip+N7LRIjT55mej1eHpZn6ajecj7FmAABSNm6eo+bMNri7TzP?=
 =?us-ascii?Q?nMy+B2j2JhHFIdCKEVehysL+V4EOcCWnyw/JtKw+VyV8JLsZauxIWggQCRZP?=
 =?us-ascii?Q?LtX3H/Ka1V5MsXcYE6qTxgMWJHVTUDGdqrFhhTT6EMF4eZikiPryXCWSnPJj?=
 =?us-ascii?Q?t34QkYBFapnCU3GbZtCH89JMtqIkJrCZ+nLOOWzMwapcjgRy3gNRl3+fN4d0?=
 =?us-ascii?Q?nHkx6JV8DF/oIKbfwwnLptKORZLduhQ8EZka4UNHnLi6FxyIkTNVBwiKIVSo?=
 =?us-ascii?Q?2SQoLxqpch70UZmuIaqNQcmCr5hm/p1Ut/W01U+HtHb+pKi8pGs10j2xKCoQ?=
 =?us-ascii?Q?ogMOhc2iTmSfirq9I3CuY7x1vVcecjJsJRkus0loPnhAuph8sS3ZYsTmmLMO?=
 =?us-ascii?Q?U1unB8JdGHssHauutxDUEO9bTyjz/z1P92ZGI+/hCmWxN/zbUdV6abUs9UEF?=
 =?us-ascii?Q?Kegk6pL2aSHg7FIOtDUhxvydvWuucoh0YJUgn1nqr17Tkq3EM6y/wWvbvSKw?=
 =?us-ascii?Q?EzRI6F16zSQXgShtroiBpIMuLfximxVn3t+xONXeVKsyB9kSWpZrya33I/De?=
 =?us-ascii?Q?zEL+uzlwA6K61/qLbxOxr85xirdHmm4OCnml6yBOUxSCqc95gR3hZs/1e2uR?=
 =?us-ascii?Q?Laot6pLObwMRyzRCmeUCwcXpKVXHdjNKlUx3dxq3n8zpPVcI6eDT/PFZIXZO?=
 =?us-ascii?Q?fD3+KbXhiwlTcBLjK/j9hk+ZcQwpvrHahKwb/9M0kGmC1V5pvvC7wjyblrqu?=
 =?us-ascii?Q?qzzTjsLG1srrZzWJVOo/d0doH5Mq+BcdX507kR3CcV1rw/koERfMiP7TENRM?=
 =?us-ascii?Q?kiOT1OK8BL2Xc4/E2BX3LCHsrMrUfIZml12JXQMWtljoBap2nL6yiTFNJlhC?=
 =?us-ascii?Q?Qu9r37rx0h60k625E7vlZ+NOwjklRMf/Um+jjrdcUJzZ1sLlv5mU7sm8G3fh?=
 =?us-ascii?Q?2dAmnmeCeWPwjNFDFNvqwqWLbfDeA/EeMAmYqwsn3dsElxZdIHUh1STYOf6Y?=
 =?us-ascii?Q?8oDrPQXz4HHqRSQYxK2BlRn3cxHxPDWixQl7zVrG/5BhfrI8onn79k288WbQ?=
 =?us-ascii?Q?6M/+vUojsvWAn3caMW+y9UVZI32XYNIeSf3MDXDWTp+RlwoMqwcXAURBsjfT?=
 =?us-ascii?Q?S6q9zvxnt0sJkHEf6ccQXKI2TC3biQQX6H+rOG00BqHhk+VGaAuRpzOYJ7BK?=
 =?us-ascii?Q?+yQm4Xn3NE/v+R7IfKqSaX82J+n3o0ZJ7v0uCUAs+Tz/9yyEHvfNAfBT5XMe?=
 =?us-ascii?Q?TmjcLv9andbJUoO6eIbTbpXVhEIAj11nXQPm1KbEoy+zZKFH/MAPADAVm3Ic?=
 =?us-ascii?Q?599THUc/BTb4ftHl+x4tXTHzGsIee3pbOBrsEJQltp88xNswRlMiofvDivum?=
 =?us-ascii?Q?xjln2MQvg+wlRPIec7sigOcYLPEtEQGY6n36025EOW7K802DlFzNZDcxx0IG?=
 =?us-ascii?Q?mRS1GI/TFGZOWdpwdb273kbHMDPlvdckC2uDHPCAvA1QP923WiA7M6IwXTbu?=
 =?us-ascii?Q?LG01njZHv1tk3ys4xEezvg/xh0y8ZcY+POTeCRSMVNCxjv+8bJo6lAKFWa6Z?=
 =?us-ascii?Q?6CY7iIvV+ud6wzPD3W/tZqi9vqdk7mXok6h7EAw0HuVo6Jgrz+vxGnkk0cvv?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e73aa8c-9271-4bfc-9950-08dd6aa7df97
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:45:40.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuRpeiyipiJ4Ysl7bb/x9iIlbz61i8VZgcpwSHL+p6m5iEnjtzpnm7mCUlRH2JdNeR/FQbT9q5wlblbUY2RyRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.226.fail" on:

commit: 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5 ("btrfs: always fallback to buffered write if the inode requires checksum")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 9388ec571cb1adba59d1cded2300eeb11827679c]

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-226



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503241538.dbc17bf9-lkp@intel.com

2025-03-22 11:44:50 export TEST_DIR=/fs/sdb1
2025-03-22 11:44:50 export TEST_DEV=/dev/sdb1
2025-03-22 11:44:50 export FSTYP=btrfs
2025-03-22 11:44:50 export SCRATCH_MNT=/fs/scratch
2025-03-22 11:44:50 mkdir /fs/scratch -p
2025-03-22 11:44:50 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
2025-03-22 11:44:50 echo btrfs/226
2025-03-22 11:44:50 ./check btrfs/226
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.14.0-rc7-00005-g968f19c5b1b7 #1 SMP PREEMPT_DYNAMIC Sat Mar 22 19:24:48 CST 2025
MKFS_OPTIONS  -- /dev/sdb2
MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch

btrfs/226       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/226.out.bad)
    --- tests/btrfs/226.out	2024-12-15 06:14:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/226.out.bad	2025-03-22 11:44:56.303230706 +0000
    @@ -39,14 +39,11 @@
     Testing write against prealloc extent at eof
     wrote 65536/65536 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 65536
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +pwrite: Resource temporarily unavailable
     File after write:
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/226.out /lkp/benchmarks/xfstests/results//btrfs/226.out.bad'  to see the entire diff)
Ran: btrfs/226
Failures: btrfs/226
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250324/202503241538.dbc17bf9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


