Return-Path: <linux-btrfs+bounces-18816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99840C43A42
	for <lists+linux-btrfs@lfdr.de>; Sun, 09 Nov 2025 09:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F24D3AA2A3
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Nov 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2732C11F5;
	Sun,  9 Nov 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLBR7CPV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95413E41A
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Nov 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762677776; cv=fail; b=HJAz2L6UOHLz0jkKzEPIJTOSZDmOeriBKYKHxefxKSOF4GWoru/b953zWHZFseoq0Gqr4pttdJuSWqdo3r4WCQ/dzJaIpCeJAPwVuXpH2Dv3MQhi95eyq9cVo3ImWC/k8S60mkHeO9y+AGyVdE1PvFtiBxrnWqXC39n9G4wzECA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762677776; c=relaxed/simple;
	bh=+DQMJk1ctyddLk86QpjEMrVIdnx/mfr7CpdEbdg6SFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y2L1ngRwxlxB2qS0OC8YMSzFXGtgTuWvzrJGQ7x5T01Yk/n5b4SwKmNBTfYNW8lL8mFHUk5lDAq0UFCMbITyCg2WFy1ircuOOIywAU6IVC34cNy9tF2lCDCRhcaZ94AAp2qiXkEa7/l5lJZ9jB7IRIWnFXyFOR+9zTsg7NJwRGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLBR7CPV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762677774; x=1794213774;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+DQMJk1ctyddLk86QpjEMrVIdnx/mfr7CpdEbdg6SFM=;
  b=JLBR7CPVTfYAeZygcLDeguWN1UBh0gu+9948NoTgtKRA4b/JYofgbql3
   23sfjpRowj/q4yZf230GjnI1rmZ5BHyW9EyKgNIA5m5mXjERyGSPEeU6R
   6Shlt2mwB/Ve8xyZ7P3bzWT8fO7kQ22dFmyQnI5EQ3wGIqbjLvxZ37LvK
   rRk3gcnfJal0gHJKTrwinPF8R4m2KW13j49vr3zhYgGzHbDGvj0mQQHwz
   Z0Q81FJswtfo3dvcKffgnKRgeZi+lYMXtbLYzzInHhCKrBqnp623CbRUx
   SdWAN+xs/eLNgen3rAcHwgPWeKWt0hQo9+0hDTLpaoweznmYpvNFzNl7Y
   w==;
X-CSE-ConnectionGUID: gkMjK7XjRHyIRu+K0DgPBg==
X-CSE-MsgGUID: SWYEVhl6RRCm6OlifDrjZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="75871405"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="75871405"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 00:42:53 -0800
X-CSE-ConnectionGUID: Xv+irB++ThWZjju6Cu4BvQ==
X-CSE-MsgGUID: 9q2SR6m4RQWEJEeIvlFjXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188156814"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 00:42:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 00:42:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 9 Nov 2025 00:42:52 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 00:42:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/aU3oZ7mv+zTlio9lWHWnczk43QKlHSLqR1AH2h55Pfr+C8RuimoJrVoPQabPoHs/hWbrX+j/5Ihl71zEjqrHIQefkZEatACdhvGeyzNRbRlhg2LI0lFhW7ZJCZtXKpA+5nwY/Z93VnWbZOz7ExLE85Axvq1nsf6+bDTKBeic/1TyBztIRRvveZsFuhW7TWfI3sUVYGAuof3rgAQXx6KS8PvCUCxcKGNvMovoPwBKdbedYFLDA9id4gl1MTy+C8Inpc+43Mx200RxGvVJssyFHuHpEDBcw+o6j2ORmgX9ek0uIJOz1Eun3QU97MAg6nECAHOeVyNLwirk5l1VLdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPyh3BzYKaxmJ+EGLc11I5Gbi68rRIXSDyqKK8hQNEo=;
 b=l5WiWUSncB9X5qft47QbjnR8i+u3wnIgijisJn1/BNWJyS7thbOhNkHTRV/xNPHER5bLSPk8U/yQLMvvBd3HUukbSjtjBh/Lek0IQ/0XQsOe3BkX88kdubdnKtntpGYrPNLL9MpRMHteJi+DR1bSQc0Wvyz+2xpkbeQeC5bscjbwGTDLGAiqhs2qRrYVPzhhEtHI4aQr573GMCUoHn8vWbaReiiJfVKUMoYJc8Z3kJsLSVnIZxO0CMl4wTccBK1jRNII9twZMa+/8oEvJ/DiEywWBvhwhmo5ioppUFxaz69hYs+31z2RmA2ZetuJRKjtO3HBuhAXR6M/1EMy6IcK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 9 Nov
 2025 08:42:49 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Sun, 9 Nov 2025
 08:42:49 +0000
Date: Sun, 9 Nov 2025 16:42:41 +0800
From: Philip Li <philip.li@intel.com>
To: Mark Harmstone <mark@harmstone.com>
CC: Boris Burkov <boris@bur.io>, kernel test robot <lkp@intel.com>,
	<linux-btrfs@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <aRBUAUiaObMAS706@rli9-mobl>
References: <20251024181227.32228-16-mark@harmstone.com>
 <202510272322.N1S5rdDc-lkp@intel.com>
 <aQU0TJLSbEXcSX1s@devvm12410.ftw0.facebook.com>
 <475df362-2bf8-4cfd-b85d-df4579ddc8d3@harmstone.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <475df362-2bf8-4cfd-b85d-df4579ddc8d3@harmstone.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|SA1PR11MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0ee10d-a85c-426f-1b9a-08de1f6bf679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9S2EoSbnRv38CHtHRm1dBRATr4jdaZfXgiVdkd8EDwknGfIhgTf1zCpdLjqL?=
 =?us-ascii?Q?ry1/JF4Kvd2bfQgYW3GrrMxAG0xRaZDcmqJfUq8lGApytTtZEmqyl06Pfyiq?=
 =?us-ascii?Q?dpoUY8pK4VKKjk1ZCp0Hk4XZD7y09y7ruglJ4qKugc65o/eFOhAObuWlsgUn?=
 =?us-ascii?Q?j5+4Z443ceJTucyI9YXTOAIpvtyTnoptqmkD5EpZD9MNPXUrNkpasbZlbPAG?=
 =?us-ascii?Q?lUFE9fqWtmjvLXYElT4wyvbVSxuroIxI9KnlE/9aXcPWdWsoLuHcvCxSikbL?=
 =?us-ascii?Q?d90ESRp5BOIg5J7KI3SeFuT05eZEYPFf1LmgFZe0pNjdK3Nyl5N7ez34aoaM?=
 =?us-ascii?Q?wnsXhmxaJ8/eu04Wl0egUWef1xWhHytIwcXWAupINjUriwgF6gBAvRNtT0ux?=
 =?us-ascii?Q?n9j2lzNzXYPm0J7sJPmqG31VZUOt+6qQVftqNzeohGg029yRvn0l62y6MwPi?=
 =?us-ascii?Q?lGug7NPQluhMdiUPJgJlB9Ckq/a/53tA7NxT1mD4xnhW62doPuvp1zy70y5v?=
 =?us-ascii?Q?jWr+B5hoaUkHvrKX2jpWvjA8kAcN4mKdcV/+CPxkN1298qvlfRrl31ydDN6V?=
 =?us-ascii?Q?EM5BnZhMYSsqLm776/SspduA7AEevd3LNPEvM/S0EuWjifRYY7lfXYW06LTs?=
 =?us-ascii?Q?dI3cXyUk3KlJj88o+ugKB87KKn0ihRRDMJRzXdeVgz2tkcPc1KjCJ2QY76dP?=
 =?us-ascii?Q?hY7NwR9+pRtWFq8SvyC53Wk6ksGFuR6VihYxB8QQUOrx+uqb7w0y/kdZn9ZC?=
 =?us-ascii?Q?cMGkYfQUZ+YnaFPKuJkDa4rAGSBmroO5l/SeE1CBQI+euDVxPo8EDEtRv+DN?=
 =?us-ascii?Q?5aOYwrdzGtYsm3dV3xzvBQxXPt/u8WdjR6YV42T3WvxDRhnjwKXULajxRn7k?=
 =?us-ascii?Q?kwiMTfQOKTz+TmJONHUfGgfrire0PSoPOxpXStBXK+vrtEVRYThVV/ajnjGS?=
 =?us-ascii?Q?Yd19UifvCwcOXJKLygq7Jpjf8B0HweChjyVq6OxnQsLBUwa7pITXx/swIVWh?=
 =?us-ascii?Q?HfYm94fHNb29F96+k//BMmKKS3ouCtCNLf3E+Wg1m6qjr8zDrz7zZpJeNVlu?=
 =?us-ascii?Q?ndKnZpolToQR4kJDSN5z60eNKP2cFaTHMNF0BWDZCMN7a0UQZOIEIC8VFHGJ?=
 =?us-ascii?Q?I3wwYzMdNxXf50//LvNofIyrdgampJgPlW9lG9NlPgqJ4ExvlkOmetT/tTSp?=
 =?us-ascii?Q?SFA1c62EmdIsYW4qXJnypEtPeqXHXOnwMgWEdKteoRczUFXAp/bMpqzXZsm9?=
 =?us-ascii?Q?ntskU1J9/vYNqBC4NvQdx9j9ayPbzWTep1nJVB+q1Q7yUNm5ShwgoWof+Rak?=
 =?us-ascii?Q?1qCOXUZi3Ed1gS7fmG+hFECkiB6i26TbP/Fd5NJzMzTSjPNaNu/kKpqbZ5QA?=
 =?us-ascii?Q?iG2Scxwe4iLchM5qbfeOKSGB4myxqo3vJhZT9G06fY9OSAzsJZfJvr/YI+IS?=
 =?us-ascii?Q?xGXbCGoCQHLYYG3AjzzrXYwDHHyfVYK81XNBKPnDLrXiNm4HnGW5pA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YFn1fUTHht09rft6vpmsFKYnXffivtE0dbyocUq21nxo/zAlGr1mRNDKyDmo?=
 =?us-ascii?Q?R0zdMCemZCbsGe8qXm2+R8lMAzAsr3gHbpwiycgLpoA2CjPJAel0RAorBDEA?=
 =?us-ascii?Q?ys6VdMOq0ib9lE5HNwM2C8LD43QDu+nml6IXk3ZAfq+gkc061XHXEG3QXeB4?=
 =?us-ascii?Q?weJsbNIeBqn1+HVCiHhY8EJjAzyilojCzs3PlwiVOh6Rvk9HDVY1k6hVdbnb?=
 =?us-ascii?Q?8oxQmp+fFr4r246canYtYP4lE2iJOYsZxp1P/KNZz3s+uN0m81T65kbUSco4?=
 =?us-ascii?Q?rJT8h7ljUoWb7pF9eYhj7xRx/j43X3MCorQtOVx2XGtqQRqNkuvxVl5tSj4c?=
 =?us-ascii?Q?L9h/Y3E6B52o2serQJkvrUQCB1Y7LQxnFdBUJ7CTFPBmNsEUu1dD941WlfDy?=
 =?us-ascii?Q?XZ9sgQwXY7XFnYfRP6hMzBI5L0jtk99g/yzfXBfkWCVzeO5Otd9Cx190PY12?=
 =?us-ascii?Q?MSQ71MytxdH2KGyV0ToTeCvpwwbAdKXMsu5/3BRy6uWaSPe/mS3kwQgiwqRE?=
 =?us-ascii?Q?6s+8JciVnNHsdtaSHqPWvehMq8G0OPR7DTSuJckA+rTxoPkPzrXI5KFMrzR3?=
 =?us-ascii?Q?Kdr3tJ6xdB+7t69OWx2w4NMW7WAZzlUrfUky5GCUfgrwRkIAqZqeKwJbdSKG?=
 =?us-ascii?Q?lKt+od51v3NGiHB69A/KR/Gwo9JPes1n7WIPiCCafSIWkAv2IIjBrEDS5Ily?=
 =?us-ascii?Q?ePmiYJOTjsmXzS7PnQlie9Bpz7K0Ycy+eV0xKTeNhJ0YuLSpmr1FD09lnZHO?=
 =?us-ascii?Q?F+l6M06M89xpuJ1ivJgYFP9Aw+1zqoySNoOxNHyiHkSAnYyj7iVUoXxocUEc?=
 =?us-ascii?Q?fX2UOxD8NGU/udHQtAWTRJKE0Bug6XS4vXx+pJwGeTCgjULFNGNdTbj24iqr?=
 =?us-ascii?Q?frWVCPREXzJzJ1MhHPm4CGCwzocBvKEbaYWMCj5AmNm+jN52AY6LF4C6qjCf?=
 =?us-ascii?Q?5pdROrkRN7G4t6bUG7rUjQYQp+wRnr38fpoRyHKL7pSejglXTmXqig0Tsc8z?=
 =?us-ascii?Q?/RxdcOwlrX1SRs+qJMnwqaS36TFPk7KG0qnlTW6pWVmGrblbeber4Q6iwiMc?=
 =?us-ascii?Q?1nQo3kmKzI+0McBbcHc6ozYmdvw9ZXYYC8b4zFt+1xk/OC+lI84FuHQW/lTu?=
 =?us-ascii?Q?OCFtVuAjePNgSyudlpAD5Ua00Jj6uiVXuuXyJsUQKrOzlUfwk7MQSKvgF2LF?=
 =?us-ascii?Q?dGIwE09F74toDTfr3s2Kf/JSBEpe/mJ++tp802a+rGHw6W7nswyXAdOTHqQ3?=
 =?us-ascii?Q?yX9X5yKd2MWPlWM3JRxoCNsHBZSbVgcrtBDKdpWWaEcx85smKN2qZWDA9j5X?=
 =?us-ascii?Q?GO58rSc2ViMDARL3LFp4yx2Lea8Cmk8rFBY1RBQbsPJlWN19oMTQm+3PVFYg?=
 =?us-ascii?Q?HeyWiR2LnrhEdkuODI0SpkIaSQi08ZY9pQyhLQWhkCcbn5uQ/AVgfPRvYgYA?=
 =?us-ascii?Q?kjhMpoOatU94DtbF1oOr7ASCgesm6bm5b+Q0aGLM6ZP09gctc/umNEC3FsOQ?=
 =?us-ascii?Q?/imndaX2T6g9lZZJr/+QdnEZ2fXfOPQmM5vx5xPuJM/4WRgyTIo7HCIX3P84?=
 =?us-ascii?Q?JXcyr7jttfsj33nNWu9ewPKXYVDmz8i4MOuiHVPz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0ee10d-a85c-426f-1b9a-08de1f6bf679
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 08:42:49.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJE928VFu0e5A92Gw9hVy7+8aKDfin2DzDX7oj/65VRAEe1RBv5RpYKwCqJjmQDeKE8G2hVS0EIBdskUC/KaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

On Mon, Nov 03, 2025 at 04:49:26PM +0000, Mark Harmstone wrote:
> On 31/10/2025 10.12 pm, Boris Burkov wrote:
> > On Tue, Oct 28, 2025 at 12:04:11AM +0800, kernel test robot wrote:
> > > Hi Mark,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on kdave/for-next]
> > > [also build test WARNING on next-20251027]
> > > [cannot apply to linus/master v6.18-rc3]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20251025-021910
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> > > patch link:    https://lore.kernel.org/r/20251024181227.32228-16-mark%40harmstone.com
> > > patch subject: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block groups
> > > config: arm-randconfig-003-20251027 (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/config)
> > > compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202510272322.N1S5rdDc-lkp@intel.com/
> > > 
> > > Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> > > http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >     fs/btrfs/discard.c: In function 'btrfs_discard_workfn':
> > > > > fs/btrfs/discard.c:596:6: warning: 'discard_state' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >        if (discard_state == BTRFS_DISCARD_BITMAPS ||
> > >           ^
> > 
> > I think this gets set by peek_discard_list() so I don't think this is
> > a valid warning.
> 
> You are correct. discard_state gets initialized if the return value of
> peek_discard_list() is not NULL, and if it is NULL we return before we use
> it.
> 
> This is an ancient version of GCC, the warning doesn't trigger on GCC 15 -
> presumably it has better control flow analysis. I don't think the robot
> should be compiling with this warning turned on for old compiler versions,
> if it's prone to false positives.

Thanks for the suggestion, I will update the bot to avoid sending out this
directly. Sorry for the false positive.

> 
> > > 
> > > 
> > > vim +/discard_state +596 fs/btrfs/discard.c
> > > 
> > >     513	
> > >     514	/*
> > >     515	 * Discard work queue callback
> > >     516	 *
> > >     517	 * @work: work
> > >     518	 *
> > >     519	 * Find the next block_group to start discarding and then discard a single
> > >     520	 * region.  It does this in a two-pass fashion: first extents and second
> > >     521	 * bitmaps.  Completely discarded block groups are sent to the unused_bgs path.
> > >     522	 */
> > >     523	static void btrfs_discard_workfn(struct work_struct *work)
> > >     524	{
> > >     525		struct btrfs_discard_ctl *discard_ctl;
> > >     526		struct btrfs_block_group *block_group;
> > >     527		enum btrfs_discard_state discard_state;
> > >     528		int discard_index = 0;
> > >     529		u64 trimmed = 0;
> > >     530		u64 minlen = 0;
> > >     531		u64 now = ktime_get_ns();
> > >     532	
> > >     533		discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
> > >     534	
> > >     535		block_group = peek_discard_list(discard_ctl, &discard_state,
> > >     536						&discard_index, now);
> > >     537		if (!block_group)
> > >     538			return;
> > >     539		if (!btrfs_run_discard_work(discard_ctl)) {
> > >     540			spin_lock(&discard_ctl->lock);
> > >     541			btrfs_put_block_group(block_group);
> > >     542			discard_ctl->block_group = NULL;
> > >     543			spin_unlock(&discard_ctl->lock);
> > >     544			return;
> > >     545		}
> > >     546		if (now < block_group->discard_eligible_time) {
> > >     547			spin_lock(&discard_ctl->lock);
> > >     548			btrfs_put_block_group(block_group);
> > >     549			discard_ctl->block_group = NULL;
> > >     550			spin_unlock(&discard_ctl->lock);
> > >     551			btrfs_discard_schedule_work(discard_ctl, false);
> > >     552			return;
> > >     553		}
> > >     554	
> > >     555		/* Perform discarding */
> > >     556		minlen = discard_minlen[discard_index];
> > >     557	
> > >     558		switch (discard_state) {
> > >     559		case BTRFS_DISCARD_BITMAPS: {
> > >     560			u64 maxlen = 0;
> > >     561	
> > >     562			/*
> > >     563			 * Use the previous levels minimum discard length as the max
> > >     564			 * length filter.  In the case something is added to make a
> > >     565			 * region go beyond the max filter, the entire bitmap is set
> > >     566			 * back to BTRFS_TRIM_STATE_UNTRIMMED.
> > >     567			 */
> > >     568			if (discard_index != BTRFS_DISCARD_INDEX_UNUSED)
> > >     569				maxlen = discard_minlen[discard_index - 1];
> > >     570	
> > >     571			btrfs_trim_block_group_bitmaps(block_group, &trimmed,
> > >     572					       block_group->discard_cursor,
> > >     573					       btrfs_block_group_end(block_group),
> > >     574					       minlen, maxlen, true);
> > >     575			discard_ctl->discard_bitmap_bytes += trimmed;
> > >     576	
> > >     577			break;
> > >     578		}
> > >     579	
> > >     580		case BTRFS_DISCARD_FULLY_REMAPPED:
> > >     581			btrfs_trim_fully_remapped_block_group(block_group);
> > >     582			break;
> > >     583	
> > >     584		default:
> > >     585			btrfs_trim_block_group_extents(block_group, &trimmed,
> > >     586					       block_group->discard_cursor,
> > >     587					       btrfs_block_group_end(block_group),
> > >     588					       minlen, true);
> > >     589			discard_ctl->discard_extent_bytes += trimmed;
> > >     590	
> > >     591			break;
> > >     592		}
> > >     593	
> > >     594		/* Determine next steps for a block_group */
> > >     595		if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
> > >   > 596			if (discard_state == BTRFS_DISCARD_BITMAPS ||
> > >     597			    discard_state == BTRFS_DISCARD_FULLY_REMAPPED) {
> > >     598				btrfs_finish_discard_pass(discard_ctl, block_group);
> > >     599			} else {
> > >     600				block_group->discard_cursor = block_group->start;
> > >     601				spin_lock(&discard_ctl->lock);
> > >     602				if (block_group->discard_state !=
> > >     603				    BTRFS_DISCARD_RESET_CURSOR)
> > >     604					block_group->discard_state =
> > >     605								BTRFS_DISCARD_BITMAPS;
> > >     606				spin_unlock(&discard_ctl->lock);
> > >     607			}
> > >     608		}
> > >     609	
> > >     610		now = ktime_get_ns();
> > >     611		spin_lock(&discard_ctl->lock);
> > >     612		discard_ctl->prev_discard = trimmed;
> > >     613		discard_ctl->prev_discard_time = now;
> > >     614		btrfs_put_block_group(block_group);
> > >     615		discard_ctl->block_group = NULL;
> > >     616		__btrfs_discard_schedule_work(discard_ctl, now, false);
> > >     617		spin_unlock(&discard_ctl->lock);
> > >     618	}
> > >     619	
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> 
> 

