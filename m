Return-Path: <linux-btrfs+bounces-18378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CAEC12EB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 06:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9F54084A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185842882B7;
	Tue, 28 Oct 2025 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja8nAXh9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF89226D1D;
	Tue, 28 Oct 2025 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628496; cv=fail; b=J0HZMTpJEcNKREWK1+wQwb11G1ZwrJXldf6GBRsCPQwEPQ22Nvxiu6RR5emMFGV65ekYC8hvzKfysSwqQDE9Q6dEM8STA5AnaO6nDsV8RwHQ6OO3HyP4txdMQ21ISqwMQfm+btd5ZrZyTpA6+Bh+X8CDF/Yb2OP17JQOw3X/Dn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628496; c=relaxed/simple;
	bh=yVhrSG9y7CvXlLsMR7dTL8x+aGIsE29gBqX1sr2yepE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dg1E5maDzwymDC1oAAJQc4CwViylmzQy5TbN5zL+lboK1tYW0/LxJBIgU+/bJjW7jRxf0obwCH82E4MQl6c8MkR93v+u+081UbyaKeyG0al10p7gY1GG6MAl9CkSIfk+nMZILKAqM/pHXHNz03HpwqHZ+nVZEzmynWSLTHQPUjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja8nAXh9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761628494; x=1793164494;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yVhrSG9y7CvXlLsMR7dTL8x+aGIsE29gBqX1sr2yepE=;
  b=ja8nAXh9WcQyf/U062vcEu3hIQ8jRqzyrtXC3flyqr6NrjbXWQ2SAO4z
   J1ezAQ313lrAp9egO+JXIomvAvoodt80A2cpJwTv+JTf3zRTnUASNH03d
   10oVJhlEJJYyNoCi65RoBGYQCqWSOFof2ej2weYgre+E+zh5nYsvRnDAh
   iaCrIx6rbT6/M0qmuZCCpeHfh5vsHwLHmUUUZ+evnQEuP9h4CnRBXEx6y
   xWqa+IaprxRhRcjiVB+MGjkgE4wAX9ikBLbGjjPryXzEaUMb+p9aYzM+m
   GRHBGJmENFq/ZGrP9RioHp7ZNNSrPWFUVzy39130y7hICm72x2RWHgTTG
   A==;
X-CSE-ConnectionGUID: vxp3tGAXRUuRlkAzRWrf+A==
X-CSE-MsgGUID: DkQM7y1zTn2LsBQzaruGVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63756102"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63756102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 22:14:53 -0700
X-CSE-ConnectionGUID: j0y/aywzQ/2Lpc4EUU0DKA==
X-CSE-MsgGUID: bvlnxujeSsKUidNOR0iYPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="186000064"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 22:14:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 22:14:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 22:14:53 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 22:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHQUqdqpkvUxWIFro+vMoVeFHrmc+rni9jEGL1tQNkRcW5q/QHXO5fnblQuTcNKytC5f0Y/ExymuBt45zCMtD/u4sTLJhRtZtSLZjdVxmxldNVQySwozjoXcFIHJIsg6J5WfK5oWxkJpXqSsb6PLBgvxsTsq06KYvBUZZ6m6bllwiaaZBooydFYbWgFxCsFfWudN/1GvXDzqkN4/400+pCy4ZwUyMTVePZDt9swUcPHmziGGAQbMle7r7u0Tu9C70qq8vXyoH/y+tfE2M4a72fnsoCpmz3GPRshMlljIf+AQnJHncA0A+W6pFkDZHPBlgPMDpWJpt8n3TfQio39KjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmZr6l1XxVWBIGrlAHM9EPWXKWn/vb1L/rrVrH8xINQ=;
 b=AnmIDIJEFoVdmnmepNQ7A2ZXSCSdZT4oozneqEHMARkVhDOk+88wQm37fyHR5dZpZH1Hx4cqLBSQ1fT+DA9YngFgewvxJb2G9ZZOLV9sJAn/WlHs9qWiYjiKf/LXRzao6MsPD7xPrM88AUtfDw6ZuLB4izb3ZSGtC3i5JdF4e4uRBnJ2sw7GlU99H3NtqijaiGpgzV4+msahUxM2NG3mVVSmFobrdks2YuS27d9iJ77hGQ1Zr8iq5ph6s9iCDWQdqEvblA826Ip8pRrPwSAAq8xfH1J2PWD1k3Czfd2p/vQMTjUGTPDEMi7iaJNWRDmuE1LpVfLt39YDXd0uCSmFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB9488.namprd11.prod.outlook.com (2603:10b6:806:465::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 05:14:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 05:14:46 +0000
Date: Tue, 28 Oct 2025 13:14:36 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: Qu Wenruo <wqu@suse.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>, HAN Yuwei
	<hrx@bupt.moe>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [btrfs] b7fdfd29a1: postmark.transactions 9.5%
 regression
Message-ID: <aQBRPF5taqdUE/zk@xsang-OptiPlex-9020>
References: <202510271449.efa21738-lkp@intel.com>
 <2adac975-01f1-4640-a073-715c804987d6@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2adac975-01f1-4640-a073-715c804987d6@gmx.com>
X-ClientProxiedBy: KU0P306CA0082.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8a283b-d104-445c-3df5-08de15e0e91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L09qNUd0SnFRdkNUS2RCc3U5dERrU2VnY3BqZDdDa2VkN1ljMDVLRnlMZXVX?=
 =?utf-8?B?YjFyWFFRaUs2Ryt5UVMyQkZBUExtRi9zYmsyVHFCWGpNc2NVOXkxK092dHUx?=
 =?utf-8?B?OC9uaXB0alArRWxDSEhqWENTbHI3bDliU0xOck55djZKQ1VnVi8yTUZobTNL?=
 =?utf-8?B?Yi8rQUtBeW9tWVRpeGdiOWhGK2NnZEVhZmcxZlVyZGlhU0ZZeUgxa3hxQ0d6?=
 =?utf-8?B?R0xwdXlUTlhEY2lMdnRFbk9FRk9OaTRpTVBNYTJDSEUxMjU3WVNJRjlXVEQ0?=
 =?utf-8?B?SWRzOVNseENyVXZ6YmYvd1d1VlBCWDRKbkhWZ0g1ZDd5aUNFN3JUR1VOZXZo?=
 =?utf-8?B?Z05ESFZJb3ZBSWtRbnovQkpyUk5ER0RLb09WTFByb2toWnJXek9Odlh4VkRX?=
 =?utf-8?B?WHJUL0Q5M01RL24wZ0JoWCs0aHdSN1FqTFk2cFRDM3M5QW05ZmRyeGgydm1h?=
 =?utf-8?B?VlRwMGN4UkhCU0pYV3lTRm9uakIrRnBDUmVLYUJVME9JRW94UWhLNnFkZ1Nt?=
 =?utf-8?B?R0JMMnorSVF5R0lsRkdsSmQ2R2RTZHdnOWgwN25yNWsrVlkzVlZ0YWtPbktl?=
 =?utf-8?B?UStxYzZtODZTajZnUStQK3hrQzdlWFFYdlQ3eFpVRVhXVnpJSlhydnNkUExJ?=
 =?utf-8?B?NE1Ud0FKQjg0TUF2ZU5aV0hDdEh5bVhzTmlmUGJPSjlDaG05c3Jld0ZyYjBv?=
 =?utf-8?B?MEMzNnc2MVo1Q0JHMEJ1YjlZWlJseVdGV0ZqMmZ3ZExnZFZZUVRMM3dGK2tD?=
 =?utf-8?B?ZW5VYndWcTNMVGdLTE0wRGdIV1hEWGNqaDVMcTROVVkrclNBNS9obElNNVRi?=
 =?utf-8?B?V3BlREVFdGVUQ2RMS3VVN0xoTnhGbXVGVkhBNFd6MWo1dXdJUkdXcUdQSy8x?=
 =?utf-8?B?UEVwR2U5TTlpdkowa3ZDQmRtSUFmSWJmdk9vOHpsSXd0OVJIOFV4a1dDTnRn?=
 =?utf-8?B?OVlsdVU3UG8vaWZUTHM0aHlnL3JRNzUzRXBMVEJyOG1GZHc1TDBWbUpZcDdR?=
 =?utf-8?B?ZDhBa3hPSFRzeUVDczV1a0ZDZVl3UUp6TC9US05sSDE4ZFV6N2FwTFdmcHI2?=
 =?utf-8?B?V1pKbWpGVEdKTUh5dm1PSDlTdWJTSnhNbFpZa1d5Sll4dVFIUmZUSEVzVkpQ?=
 =?utf-8?B?QTB0UGkvSnBXSmpUeC9BejVySmhzZTY1SE13ZU5NR2tZZENZSmJHaXAvcm9H?=
 =?utf-8?B?TDVJNXhIYkdIeGlCc3NobmhvWGh5NGphcjJKakx5TTlUYVVVVGV5bGJicElN?=
 =?utf-8?B?UmlHM2pYa2luOFlsekJDRzR0UENDdENnbXZpWTVxc0lWVFgvVnl4NllBUjJ5?=
 =?utf-8?B?V0cxL0FEMU9QV1BDS1dqeVNKRW8xZWtYV3F3b05RZkluNUVqcWpGRVBTYnJC?=
 =?utf-8?B?K0YxSFllcGZMSGVldzl6VmF2RFg5UVFVVzBjaElZWmFDOTU3VWs3NDFXR2pW?=
 =?utf-8?B?WS9ldFZnVGVxUXZNTDIxK0lyeGdSMmVCaXRjMzZyL2xpc0k4YmR1U2t2YjJi?=
 =?utf-8?B?cnplbHRzc1orVlMzNVAxNDlvTFQ0VzNxTWdQZFpWV2JqTC9KUFNZRXRtUzBH?=
 =?utf-8?B?UjZVcGhSdFNiMHpUUm5zcy81VlB3UGtobGhpaU9KUTVTamJYTnI4b08xK0oz?=
 =?utf-8?B?ckZ5U0JhczBMNDk5TVhUZjlJenR5SHErb05VY0ZVRVdLNTJxajZNT1BYU0ZT?=
 =?utf-8?B?aWVjWCtkR0JXVWl2azNyY0JGU1FOQlB1UDBLR3M2VFl4NU16VTBpWGdkeXJ3?=
 =?utf-8?B?UE5ja2lCcnBLUUtHOWt5Uk1CeTRMNmlaL3JreW4wT2w1aW1VdlhtMHhGWDNt?=
 =?utf-8?B?dkR0M2dUNUwrWUxmU3AzRkRhK0lUOVJRTGM3TjJCUjA4a3plWTRLbHZRNm5p?=
 =?utf-8?B?eE0xZzZVRVgwNHBpcE5vbUkxU3VQRjVmdWVYMmFsbnhnRmhCMmpzZGRXSlpp?=
 =?utf-8?B?VEhvRTYrYW9pWDZWVE1FcUdrVHVHZnpmaGcwYm4wekJFSEU3Si9TTkdaZ2tZ?=
 =?utf-8?B?a1U3MEVoZFJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdGMlRsaCt3MEdJT1h5R3M2bE1ja0VxZlJCMGRBR2p4eFU5WVl5ak1jZ0FT?=
 =?utf-8?B?M2w2VkxHenhRZTVvMS9idU1JSWNXdGZ3dGZiMUxSSUN4SmwvTThob0dUZ3I5?=
 =?utf-8?B?WW1lNUZaM1U1allSSmJsQWNJOVhpbURDdXZhbllrN1pacHVZd2JlT2ZvN2p5?=
 =?utf-8?B?TzNuOTJpbU0xVEEwbjJvdDhjbVcrdllYazBhK3RVTFd5KzJmWVdQd0k3Ni80?=
 =?utf-8?B?VmRDMTZWbEJkbElheHMxQkpyR1lYUVN2QnFJRUFQVEdmcXFaTHRlZ0hwMnlz?=
 =?utf-8?B?bzl0L3lQWWFpaUxjczhxaDZYQXh4ZDYvQlVyZHVOYWpmZzE5dExpUXNNbW1Y?=
 =?utf-8?B?SVM5MytORXR0UUw3Rkl3dGZlcnFudy9ZcmV5c2UvTE9HeGkvbHNqZy81RGJM?=
 =?utf-8?B?V1VTSUhaL3NvMVNYblhwdG0wMVRYRGU5Qy96QWo1bXJPcnQ4Z2oxZWdCKzJ0?=
 =?utf-8?B?YnVzcmcySWdJbGxjU2JJV2lBWWo3TlFNdjQ1RXpjY0NxV1VDeWE3NXpqRjU3?=
 =?utf-8?B?V3FnNmIzQ3l6dFMwZGZNNzZrVjBaTnJjUVppbTRVUGl5djVlZXkrVXBKdDdq?=
 =?utf-8?B?Z01WMnhSU1NkZGo5Q3NvejFyeUZ4WTErMUN1TDVTU2dnVTRZa2d4SHJOdTdK?=
 =?utf-8?B?Wlp5bUUxYTBDZ2RmdE5oaCtVd0xwR2xUU0M0SGZSbkdLbTJUc3FDNWhMUXB4?=
 =?utf-8?B?ZXRxVkNURWt6MXRaczVKTzZWWmZzQVFLcTVjcy9kSlNiUFJSbXdDYUhWQ254?=
 =?utf-8?B?Rnc5a1JXQTFQOU1ObXk5ZWxKczZvcEV4TGlUUDBWYzBNTXRuN0JReDRLQitw?=
 =?utf-8?B?WlRnbmlrMVdKaW9WUzZXRWw3OEtuWmdhTndmZUZ2MDRYZGRpQlF6KzI1RUhW?=
 =?utf-8?B?VTAzeVQyWXNQalF4empHTmd4Vk96NTEwSUpSdmVPSTZpOFVYQ09NK1B2Wk5K?=
 =?utf-8?B?TW9IUTdBOVRDdnNGaUhvblhZWGplVW9rcVR2UjZzeFpxdDBkQlpkMzZJL1hD?=
 =?utf-8?B?cVpXb1F3eUo4aFBBNnc1SjYwQ09rODVKRUZNTjhyZis3dysyTzBQVjdyRUNr?=
 =?utf-8?B?VG1nRTE3S2hsUXZkRk5tRndjM2ptSUNjeTlSRDUzaWViNzJjMi9nK0xRNVdU?=
 =?utf-8?B?WkVyWmZyM2JuWjRZYWg4ck5WT1NqTDI5TVp3VzJyeXBBd29xdXhnZjBzb2Rm?=
 =?utf-8?B?U0x1aWJKT3N4WFphcmVxNWdzWStOV3U0cEV5dEpBdm5PdFFsYmtrR3lHclls?=
 =?utf-8?B?NUJvQnJvUllVMGdUZmtXeTNFVUM2RCtuUjRWalZNWlB2dGwybUZjWVpXNzZQ?=
 =?utf-8?B?eVp6QTNkUWJXQnpadlErNEkycjdaaUtndktDTjYxeDdGcFMrNC9XeWdKVkQz?=
 =?utf-8?B?dUxhQy9UYlBJNkJrUExBNzdsYXRUKzdSNTRDWXpNNzRubW5mVkp1TTZOdmNz?=
 =?utf-8?B?SXpGeXR4cnV4bGV1RXpjWGUyN29SZXNHblVYVHdMYTdyaGpSaENtcWVRZzVU?=
 =?utf-8?B?NzlicHdtWlZuNU1uZVc4QWtiOU9ZQi8zbWVLMW14dXNtdjhIY01peng0UWFk?=
 =?utf-8?B?TVFoa1RxTHBIRDBqVWNueXFQVGhjTFh5dzU1L3paQ2IzYVB1OFpuVDloRFpT?=
 =?utf-8?B?T0JXMEZFWDNLbGxlUE9UZ0lhZjh2dTJOd29PY3IzWWFvL1VBRU9vclQvVWQ0?=
 =?utf-8?B?RjhOazhSNm4vYVVKbEdhZ00zSE9yOE50MFl1emdkZitRaDNTOG85aVZ1dUVY?=
 =?utf-8?B?bTQ3SXIrVm9zZ1dNZTg1b0RIWjI5enZBbXhzTkpGckRDQkZjTDhZU09GcW9w?=
 =?utf-8?B?TElOSE5kWHg3TDZ3cFZKQmhZc2xRUm9qVTNRdXVlajlTRkt1NzN4UGNJOW1o?=
 =?utf-8?B?UUtFVVJaYnV5TENidXM1QWUyclEvcm1mdjBiQXhJcUE4MDVJM2tTUTFLV0p1?=
 =?utf-8?B?UTF1cnRUSDl6L2tHcnI3U2JhY0txZVdoR1V5VDczNkRkeTdWQ2h4VFVTbDlv?=
 =?utf-8?B?VFZFb2lNbVE1YmNWYnU3aVlCQTNRQnpSQjcwUWN6VnpsQlJ1aDRmcjl3TExm?=
 =?utf-8?B?MGVwZUtSMXF0WjNXMUlMVmVMTVJEYVd4MWFLRUpCVzIvbXBtSU1wcGpMeVZV?=
 =?utf-8?B?RSt1RG5tSGVhaEh6NGNXMUE1WXZCcjlCTS9OMjBLRnNWaXM0dEN0QTRRcmpD?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8a283b-d104-445c-3df5-08de15e0e91b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:14:46.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVeKbkhkS4kg+0WGVqv0iXhd4/culKMh6uk0ye29C3XyhssjkMmf/QhzZuQtV6+EOKTOUG9KpfWC9Ut9WnTgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9488
X-OriginatorOrg: intel.com

hi, Qu,

On Mon, Oct 27, 2025 at 06:19:59PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/10/27 18:11, kernel test robot 写道:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 9.5% regression of postmark.transactions on:
> > 
> > 
> > commit: b7fdfd29a136a17c5c8ad9e9bbf89c48919c3d19 ("btrfs: only set the device specific options after devices are opened")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > we are in fact not sure what's the connection between this change and the
> > postmark.transactions performance. still report out due to below checks.
> > 
> > [still regression on      linus/master 4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d]
> > [regression chould be solved by reverting this commit on linus/master head]
> > [still regression on linux-next/master 72fb0170ef1f45addf726319c52a0562b6913707]
> > 
> > testcase: postmark
> > config: x86_64-rhel-9.4
> > compiler: gcc-14
> > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> > parameters:
> > 
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	fs1: nfsv4
> > 	number: 4000n
> > 	trans: 10000s
> > 	subdirs: 100d
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202510271449.efa21738-lkp@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20251027/202510271449.efa21738-lkp@intel.com
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/disk/fs1/fs/kconfig/number/rootfs/subdirs/tbox_group/testcase/trans:
> >    gcc-14/performance/1HDD/nfsv4/btrfs/x86_64-rhel-9.4/4000n/debian-13-x86_64-20250902.cgz/100d/lkp-cpl-4sp2/postmark/10000s
> > 
> > commit:
> >    53a4acbfc1 ("btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl")
> 
> This is definitely not related.

just want to make a clarification here. we report regression based on bisect
results. this report is upon b7fdfd29a1. 53a4acbfc1 is the parent of b7fdfd29a1,
it's a 'good' commit in bisect.

below table gives out the comparison between 53a4acbfc1 and b7fdfd29a1, such
like

      19.61            -9.5%      17.75        postmark.transactions

which means we run same tests upon 53a4acbfc1 and b7fdfd29a1.
the score of postmark.transactions for b7fdfd29a1 is 17.75 (average of at least
6 runs)
the score for 53a4acbfc1 is 19.61.

and this is the reason we report as in title
"b7fdfd29a1: postmark.transactions 9.5% regression"

> 
> >    b7fdfd29a1 ("btrfs: only set the device specific options after devices are opened")
> 
> But this may affect performance, because without this fix, btrfs always
> falls back to `ssd` mount option
> 
> Now it will properly detect rotating devices, and won't set `ssd` mount
> option by default.
> 
> But if this is causing performance drop, we should really consider if `ssd`
> should be the only mode we support.

thanks a lot for information!

> 
> Thanks,
> Qu
> 
> > 
> > 53a4acbfc1de85fa b7fdfd29a136a17c5c8ad9e9bbf
> > ---------------- ---------------------------
> >           %stddev     %change         %stddev
> >               \          |                \
> >        2010           +10.5%       2222        nfsstat.Client.nfs.v4.open_noat
> >       97983 ± 11%     +18.5%     116101        numa-numastat.node1.other_node
> >       97983 ± 11%     +18.5%     116101        numa-vmstat.node1.numa_other
> >       16001 ±  5%      -7.5%      14797 ±  5%  sched_debug.cfs_rq:/.load.avg
> >     1474354 ±  3%      +9.9%    1620281 ±  4%  sched_debug.cpu.avg_idle.avg
> >      756151 ±  3%     +10.0%     831539 ±  4%  sched_debug.cpu.max_idle_balance_cost.avg
> >        3585            -2.6%       3490        perf-stat.i.context-switches
> >        6141 ±  2%      +4.0%       6385        perf-stat.i.cycles-between-cache-misses
> >        5796 ±  2%      +3.9%       6024        perf-stat.overall.cycles-between-cache-misses
> >        3580            -2.6%       3486        perf-stat.ps.context-switches
> >   9.548e+11            +7.3%  1.025e+12        perf-stat.total.instructions
> >      136494            +4.3%     142419        proc-vmstat.nr_inactive_file
> >      136494            +4.3%     142419        proc-vmstat.nr_zone_inactive_file
> >     2784208            +4.8%    2917180        proc-vmstat.numa_hit
> >     2435763            +5.5%    2568673        proc-vmstat.numa_local
> >     3042276            +5.1%    3196281        proc-vmstat.pgalloc_normal
> >     2627503            +6.9%    2808220        proc-vmstat.pgfault
> >     2754381            +5.4%    2903034        proc-vmstat.pgfree
> >       97857            +6.3%     104058        proc-vmstat.pgreuse
> >        9.80            -9.4%       8.88        postmark.creation_mixed_trans
> >      112312            -7.0%     104473        postmark.data_read
> >      203502            -7.0%     189298        postmark.data_written
> >        9.80            -9.4%       8.88        postmark.deletion_mixed_trans
> >        9.73            -9.5%       8.80        postmark.files_appended
> >       12.59            -7.0%      11.70        postmark.files_created
> >       12.59            -7.0%      11.70        postmark.files_deleted
> >        9.87            -9.5%       8.93        postmark.files_read
> >      715.35            +7.5%     768.93        postmark.time.elapsed_time
> >      715.35            +7.5%     768.93        postmark.time.elapsed_time.max
> >       51508            -1.6%      50690        postmark.time.voluntary_context_switches
> >       19.61            -9.5%      17.75        postmark.transactions
> > 
> > 
> > 
> > 
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> > 
> > 
> 

