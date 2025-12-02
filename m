Return-Path: <linux-btrfs+bounces-19452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F0C9AB9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 09:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E00334622A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A8307AC4;
	Tue,  2 Dec 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLGpdGSm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52B3074AD;
	Tue,  2 Dec 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664822; cv=fail; b=L2uvWOs5EJez7kBm3S8zcywnbC+Koq94+Rmno4aGr4Fouj+hbK7mrOlz8CfrqZ8cL5KM2N9kjUQvMzHU3Q9Q1GpK2TKnnEdcCRoOJjcxNFBWjrFJmlGQMM/uq1rmcBTWIDgDJALpIcgqPC8V/O7GL5AmWLDwkESRQs+QtlLMbss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664822; c=relaxed/simple;
	bh=ipfok7xO5z95zZa9GNeWwm1gdbBxU/IuJJLMhVDjkOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGUyHWTisIPu4P0quVOP762Iy2gWgPdZPD3Gu7dhn1n2QWCaET3Bwz+dG05gnUXBk9kWUb0qcSWwQIkdsz+eOAHT3aKckZ6gt3yFmaA6L7KHQvI+hFn2tMbCO3h4/KCcbfeGAPImnmP5cY9AohAF8d4w16XxEchzeRDDQulHs6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLGpdGSm; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764664819; x=1796200819;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ipfok7xO5z95zZa9GNeWwm1gdbBxU/IuJJLMhVDjkOk=;
  b=TLGpdGSmih5D3J5DHP3fG9qXZYIxFZuKmfqw0iE2rFs285iCKTP7AzUs
   GF5drrJqwzgu19Ty2KuWCbIG3CxT/O9HxtTugCgKea/sGg9Y3DSRDqLfv
   N0oGYmgnWNThew79kX5VLoWn331+CwgKkqQJtByBOz7m9erANJri0r9le
   aFdcoHLuUyFwFtuuQAVckVBQyuBhDs5r0jz3yVJf4WmOjOb/2y/jer8hn
   M7evrAAjkUP/A/Pp8qI7JvY9vcqxxAwr6grTbmffuNeBMTqM8teizbuxd
   LGY0ZlcqIFMrVLM4xz9qQ3+me4Bapptcep+mj+xXWSCLPdBBv6Gxk4Wls
   g==;
X-CSE-ConnectionGUID: NX+U2LnxQYyb5Pp8ZOm3GQ==
X-CSE-MsgGUID: mX2MPB35TUWwJ0Lai00Iew==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66511008"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="66511008"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 00:40:17 -0800
X-CSE-ConnectionGUID: ll1suF8cS9uPKFGqCYqTIg==
X-CSE-MsgGUID: RTCO7pYURtqmS2jR1V+HMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="199445397"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 00:40:18 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:40:17 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 00:40:17 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:40:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUo2SQLSKE8ArAwJ9cizRsS1Iy1kUzORJrFsALOqkSL5Q+MypMiKp6Z3sQvrcsWZi4BcgfnmD5Eq2K5n67Bd2ohkMljAgOainLXRZ5jnxeJJl6RGAn88B1QTF5Qm4CYnrnIu2oBMC+fmS8IFKFkxKOhQrZkgnbiknnqw5rn6a96xuM+b+Kdl+ixg7U3Jdy3Y1wmMsq/IEs2rYc6rUuoUXdeYMgIA4yiwiZNP3I5Z33RTL1rgP5MyjhvtdQQ/YdtAoMRQxOpQNkl0R/Nt5VREbskZ+WRGv8YTlD37SfpUMgwR07ROrC1P3v1p6L5RBrXXZZN0v3EtCgIhUbysNXUfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJXO9vpVm0HBHWOv2IlRKgPk+yVlueUPnj/bh9kfOK0=;
 b=L7Y6dvcajxH5qn1O9iq9DtcugRT085Gzg+3NCe+s0upXjRhXxqhoAYbtaBTtawm77CySsOTxeu8ZEDV8QGya1esT98NGYszhTlx0qS7es9IlTo2rORQNz2z9tCE45ogD1GtuzLxr0adexdVov6KdHhYLBra/w7yI7PXVrPKBCCgb45VHzadtX36gALI6DhJLWBX8gNJd3jIdSDb2in33vTm7qivHoWgZHk6sKRyYN7wX+YR8eB57UOI7FA/JMX5fiTmcl1jj5ANn4ZdVqYwFTeLdcFaqOQfWl5zMxgUlbR7yPDyykzumw5+X+dOIOkI43sFGM5Zfz+rfsn78+cYBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6568.namprd11.prod.outlook.com (2603:10b6:806:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Tue, 2 Dec
 2025 08:40:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 08:40:15 +0000
Date: Tue, 2 Dec 2025 16:40:06 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Leo Martins <loemra.dev@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [btrfs]  e8513c012d: addition_on#;use-after-free
Message-ID: <aS6l5hildWAimd2f@xsang-OptiPlex-9020>
References: <202511262228.6dda231e-lkp@intel.com>
 <20251202005146.3723457-1-loemra.dev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251202005146.3723457-1-loemra.dev@gmail.com>
X-ClientProxiedBy: KUZPR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 68af53c9-14b1-4a4e-4122-08de317e6a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nnlshLNBJG00mc+ID2UPhrgN3p0cC6kiA7wqmtSXM+SoQ1x4ZR5VNw2gc5ff?=
 =?us-ascii?Q?715xRqwi6Um0xEWFmvSRbjSiQRIN1tp0EIMgqHH5hnWdNSS83T4X4Uz87550?=
 =?us-ascii?Q?3MUNeAD5awAjRPwvzKOxPZEsCI4U+GTBtUweroU998f6Eoyer0chN1UmvtwD?=
 =?us-ascii?Q?4LDJG9dYzZAgO5Mf5clq5rLUPr70wqif3Y3R8DuJVodZW2jtQPByYUU06ZNj?=
 =?us-ascii?Q?3ObPp5/NNqz7xE5DaMESkiPtT4PxXim9xjN9cyLNVMA6PYSizVbQ9J1PFxuT?=
 =?us-ascii?Q?+sPGK4Gy2ieyazvmEHIvcZCiq91gyHW1dPkSjHTgHkrZvmUwlaRxJEbKwXY3?=
 =?us-ascii?Q?p4ivI2WHkr0ikG/Et4eCSzO/2piYEBGPg68NsBBQSbmd3sLknzGpKOZH2WQV?=
 =?us-ascii?Q?nIraaGAumZU49C60WQhGgjSXVK0hvVvykx0qTRy4iLT9jlDlznaqBwqBVjif?=
 =?us-ascii?Q?iJgjHsJ+CnMil7PA1EY0OTYQmr9x6nBfqfDqGlOnuURa5BMQdv9sOarHiI6N?=
 =?us-ascii?Q?PXhXQb5kLY0IyF+V28S3iaQkJOFYioMP01Slk6C9SrBudUSy2izpBFlYFnlz?=
 =?us-ascii?Q?qI5QRXdriAJxs/3CBhjLqySJ4DDzJrSjHmjTNaeFubCu+1wt+plbiaLPS+J9?=
 =?us-ascii?Q?uHjOfGJpJNNxzFr6YrOyiHa0JchgpaCYR+JUMVFzeWU4kSYHB9BO0XmtDgUB?=
 =?us-ascii?Q?vFNbYMQjhreUWBxnK2VG0Tl+2i60LycrzsSpUD+yggvYFwQ1H5ZRoT9Dq35q?=
 =?us-ascii?Q?n0HlACmByCgWurxvKWZbocwltHPNCCPGWNviknOB/f850vlsaKW9nkM02Mr7?=
 =?us-ascii?Q?5Ekfm7W2zSbfPXoTjRwX81OTWsNWIwZg4SAHq4KuSGdAYIyxf+9Ir1/j6JTk?=
 =?us-ascii?Q?VhPuFbmZnSDLa64RkQ3zTlovMbER41SpZXjLUOxs+iMWIlL/pL6V7ezICWFb?=
 =?us-ascii?Q?Pc2dhCm6up5WfoKqxIxgsP8QDb/3VXJ9ZxTLCncpKnMfBlvW0zptzJReKVwp?=
 =?us-ascii?Q?+4p0Qnzia/JYCnemdRv2hfiK6jvdL/KTpAuXyFyW9/NRasAb4ZFGcnBDKMoZ?=
 =?us-ascii?Q?bMZWRceaTR75LD9IxIaG36EHmcBZ08IHICQLkbnshZMByYkP/WUCbqfhUIiP?=
 =?us-ascii?Q?9dy+C3WmFy6ZGCzrEoW6lNQgromQrNR7qSwHvhIVxW/WC6H+Pq3DtKIcwtJT?=
 =?us-ascii?Q?cgB8ac3NZQi6sEXFrWVe6AjSBFMr+M/4f4BA2TnYUTbe7WZGNVWsieZTQrMA?=
 =?us-ascii?Q?w+Yjon20INfKvce9+L0Cpu4LgOhFV867tKZnoI4Eo2I4oRa7NAi1LoXk7AkG?=
 =?us-ascii?Q?QxBRm5Ng1sCK7l5M9ZfwWzklc+du1g22MKP8skmHGMx5NLRf9m35rIo8eKtm?=
 =?us-ascii?Q?QxzMqTmosaSBuxz3T7UJWPPvZJ2hl274rYnDEx8jQzI058lsWgxOFw/+MaIB?=
 =?us-ascii?Q?pfhKyiY3inun48xMQzwucmt7q9ZVgdWAcUPWYvV+UZtat3NQtjCjrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsWXqZE/hioQU7X/jT3/vZSzF655CQox5e+HSEB41vXNxA+8RvFSrYQ62iCx?=
 =?us-ascii?Q?XZpW81RVaMYw10v6KlK9h7gdIUptLIUI8ylorq/FY9BsEMuc0pSz+dp+RXL1?=
 =?us-ascii?Q?ulLIoGe7fftcH1WIaS1O822RKWr4iupNqtpWhNs3v0NeUv+08gLeKn/4gL0N?=
 =?us-ascii?Q?/xZxX76oayYqIhkhcYncHMZEYTyq2YaxUFZj8MvuCgYH342Toj0P7GkW3O++?=
 =?us-ascii?Q?RAjG3Aw0j0PwhBP59/fzbRC+1WcZkcbJ2+kOUB6QaYCRGPA76/E235hfEHQ6?=
 =?us-ascii?Q?fyMEa2o5XkFVcwl4RrW0CfgLxsbl1Gf+H1A9fIjo57ehuVSOxQiGDiP8xP6A?=
 =?us-ascii?Q?5zq6IYfUNsCenz1UAkhuSUiiGqAhATR7z0mUCm079aJnm23hbQIUxjrAt3S1?=
 =?us-ascii?Q?QfDeFL04cslRNlUt4zQc3APMLYMFNZw2qXwicrYIIXMHAUfQgfAbTY1kfxr9?=
 =?us-ascii?Q?hcPb0jBMQhgDI9nal1W4sjoouE3fvMzVR1P++4323B8TTjifiRJxN0VqScq+?=
 =?us-ascii?Q?7CcSSpXRi8WDUKWBRUJIeXzJhtH/D/SyBEzGj7PGU9H9V1DcZHS5YsS5kYsK?=
 =?us-ascii?Q?NZgrQbbUx8bQGL2CfBgEKDJMuvJOrJ27uijcvb/e5PWlLBfcEnGiUlGiroER?=
 =?us-ascii?Q?xHLvgb6e9n+/Vb34ZQabDBx6U5jq4KLodOb9O98hAATnJkQBim6KJa7n49yQ?=
 =?us-ascii?Q?nSpk6dtD39kOl/zXeetPNfvGsOWC9g8CGlGr3UQs8Z9r4YFaD2/5Nkbx6bn2?=
 =?us-ascii?Q?033MZe/OIIkBvtL3mlNbA4ERECaZBJDq5WzxmLNXhFRNuzSfRq0iX+Y6VE4j?=
 =?us-ascii?Q?18yc+d1TdBf1Zcxi7eja3StdV4UsucB5wY4ZZmrLTRxdAJiZxwDYOPzAxSNQ?=
 =?us-ascii?Q?+RVaFODKnFCSKc5g0vX/YQTCkJU6JP8l5FGFqgPPDRUW3BotOKUtHGZUbNVQ?=
 =?us-ascii?Q?RbXCQ9Gkr+0ifZPDH9KuNCziVfQZb1nm6fkflXBPvpM/qxySlDMwrs1MIgnU?=
 =?us-ascii?Q?kSF+guCvN7KCzXtyhq37B4pHuNDZMHNO/CaOPGo6Rg3qUi4ggSE2QERpPwR+?=
 =?us-ascii?Q?ZsWFq9Ks5V3JO7ZMWM0F8oFDPGom+7g+Lu41RYBbT6BkTW1k8AEGAMOmoxAC?=
 =?us-ascii?Q?HSlrR+Am896oDAAYM7pqw9ZX5bXsDmiKHKUDaSGGVWz7CPW7EDxH+CEnLSIz?=
 =?us-ascii?Q?HJJMM+frxSLz/3JnQMCmUf4ki9+uXGlWg+9qJCrQay/LcKmuUNlIyDuhjU7Y?=
 =?us-ascii?Q?t0nJiS7poMgWx7TtAvbCTmHkxeU5zJyR/+Hvln5ytm6Mi1WqFh6Qe6fnRKWp?=
 =?us-ascii?Q?VELHn+C2hhZABXgJwGiNfzwfpGC/2aBAysXiD2ACH1DrkfFVNoUVjNJzPrr6?=
 =?us-ascii?Q?YPRSVtu86tdlihaKdSZvrWUNKS5iFuma68MVbt+maBP7EuDA5hqJqFwpUldg?=
 =?us-ascii?Q?TqDSQ2/BTYogLN/d1Kfm0k850sRjvjlmuouGce0aVQ8taSpztn96Qdt1sRGW?=
 =?us-ascii?Q?femx1TDj83wBToj0GkHsX28aBQv7DLYqFi8Af9xZBvWztpRTpLHW+DZNW1tc?=
 =?us-ascii?Q?XLbB0mM6b3oVPVaOXBWIcgMJmOsBLwg8PGsib1kRIq0Pg4fhN13XxJbiiimN?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af53c9-14b1-4a4e-4122-08de317e6a4e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 08:40:15.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekygYJaIzLhGKEou+xvhMxWv2QbFspgaamylrEwCDtRh2bMxFEaqGtYzklUGtPGEIurzwF0IaQgIpGoS2yrarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
X-OriginatorOrg: intel.com

hi, Leo Martins,

On Mon, Dec 01, 2025 at 04:51:41PM -0800, Leo Martins wrote:

[...]

> 
> Hello,
> 
> I believe I have identified the root cause of the warning.
> However, I'm having some troubles running the reproducer as I
> haven't setup lkp-tests yet. Could you test the patch below
> against your reproducer to see if it fixes the issue?

we confirmed your patch fixed the issues we reported in origial report. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> ---8<---
> 
> [PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delayed_node
> 
> Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> refcount before acquiring the root->delayed_nodes lock.
> Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> moves refcount_set inside the critical section which means
> there is no longer a memory barrier between setting the refcount and
> setting btrfs_inode->delayed_node = node.
> 
> This allows btrfs_get_or_create_delayed_node to set
> btrfs_inode->delayed_node before setting the refcount.
> A different thread is then able to read and increase the refcount
> of btrfs_inode->delayed_node leading to a refcounting bug and
> a use-after-free warning.
> 
> The fix is to move refcount_set back to where it was to take
> advantage of the implicit memory barrier provided by lock
> acquisition.
> 
> Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 364814642a91..f61f10000e33 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>  		return ERR_PTR(-ENOMEM);
>  	btrfs_init_delayed_node(node, root, ino);
>  
> +	/* Cached in the inode and can be accessed. */
> +	refcount_set(&node->refs, 2);
> +	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> +	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> +
>  	/* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
>  	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> -	if (ret == -ENOMEM) {
> -		btrfs_delayed_node_ref_tracker_dir_exit(node);
> -		kmem_cache_free(delayed_node_cache, node);
> -		return ERR_PTR(-ENOMEM);
> -	}
> +	if (ret == -ENOMEM)
> +		goto cleanup;
> +
>  	xa_lock(&root->delayed_nodes);
>  	ptr = xa_load(&root->delayed_nodes, ino);
>  	if (ptr) {
>  		/* Somebody inserted it, go back and read it. */
>  		xa_unlock(&root->delayed_nodes);
> -		btrfs_delayed_node_ref_tracker_dir_exit(node);
> -		kmem_cache_free(delayed_node_cache, node);
> -		node = NULL;
> -		goto again;
> +		goto cleanup;
>  	}
>  	ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
>  	ASSERT(xa_err(ptr) != -EINVAL);
>  	ASSERT(xa_err(ptr) != -ENOMEM);
>  	ASSERT(ptr == NULL);
> -
> -	/* Cached in the inode and can be accessed. */
> -	refcount_set(&node->refs, 2);
> -	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> -	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> -
> -	btrfs_inode->delayed_node = node;
> +	WRITE_ONCE(btrfs_inode->delayed_node, node);
>  	xa_unlock(&root->delayed_nodes);
>  
>  	return node;
> +cleanup:
> +	btrfs_delayed_node_ref_tracker_free(node, tracker);
> +	btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
> +	btrfs_delayed_node_ref_tracker_dir_exit(node);
> +	kmem_cache_free(delayed_node_cache, node);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	goto again;
>  }
>  
>  /*
> -- 
> 2.47.3

