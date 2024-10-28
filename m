Return-Path: <linux-btrfs+bounces-9189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058019B28A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 08:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289001C2160E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 07:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC269190051;
	Mon, 28 Oct 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtcauTEi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52402154444
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2024 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099971; cv=fail; b=ue4nbvYZMiTn9cQYLWNCl2wQ4kq5cJ9hZRwkR3/pk0pqC6Eaur20GLftqi5aqf/6NDL41WeGP62jaFOrIrjuX9e/NuKKJbLKmvwssDy6ADO3GMZBo+j442EeB1Xqsj5ZV7TXSd5rkqmU8w5OUk86VPxl7il5qYO6f75N5atluww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099971; c=relaxed/simple;
	bh=B3hEuGkwE+g34ZpS8dqSgmr6ylMAp1yetb4QZJubkh4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZgFCjj2F96LrHCyN1wTY2BS3R6dBIxcWmcBpdL3X353S8Ptd7JDRyrXo8YhAwzSx9axvW2RE/V0jkmlbSag1w/I+d6wZDpX6UXWYANND3kvr3qG5VF+8Kz1ZaRAh5FxrrvGZo0kGJp0R0l1cI3a8MC0djZDLdn2hICh2NGr7dXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtcauTEi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730099969; x=1761635969;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=B3hEuGkwE+g34ZpS8dqSgmr6ylMAp1yetb4QZJubkh4=;
  b=TtcauTEix1Mki2UUT8zzKOtDs87TJY5jmVMyWIxaiKnMisnad8jaBjFs
   s+0g3RHDhUeHThChgk6S+CixQWXbPvdjwE0FGQ23NN8gvaCNluz0bh0xb
   SdmRV1oFKV69k1hzBJywFVUUP7J2SEF6V47CH4gU7GePGXIzmkEafHJmJ
   QyMGSCp/X4s6F3C9HLzr4AbrZdih0xeik/hIZgJ3VHgsF4SmcaNuIX2cR
   USi8/d2IBI5hwaTfR4Qe48wPAJjavDFMabkENyjLIR68R7YPtH2LmHp/U
   gQoeMEWfBVLTt/pKszqwMiqGXRkji+bEipeCFqBcUIvfEmGeLQRqvRk1Q
   w==;
X-CSE-ConnectionGUID: UPd+3yQKRaSCVmk9LESpFw==
X-CSE-MsgGUID: L4Qq4ld/TeeDqWWaHRsxlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29797287"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29797287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:19:28 -0700
X-CSE-ConnectionGUID: UbPKX7TcT8+QGESZmii36w==
X-CSE-MsgGUID: vXgyWsEVRpiZC3UvdVceOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81639586"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 00:19:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 00:19:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 00:19:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 00:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/bjZXSGYYTADyN49Gf+SLXWofQkDpwjGJPGRRVcUEQ08NtcTBAYgD1OD0n/gRNNCGwftsu4Aeqtn8LbVXNCNEIufmQQm99fBgHjM05k4NKzNVeVH4zbG4DPoIJvTBjRu8Ntix7jfzYXhj9BM6UT+lXRuAkt8GawneSb0ClN9QUWSnbtWNA/ghlymToBfAC4buNTXLwlEim/SQ6vgEhzoY1SZwGGr7nLeUh//bl6DWQHajSLKLIrWxbMll/C7oEk7WnK5lB+CYCHM2oVMoq5x6rs8mbR9aXs0jsbONIEFV/qNozayi1/g/4wI1aWVA4cai+/+T56dx26EhwUm8Cvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crrTexoKjnqo8kofI/sgHJxr1DTpwVXv54Oaph3fpWE=;
 b=xGp7mZNKBJOL/N65n6ZJ99CgGFV+et/YpG5w+DJ80q2bejg15w+Q/hJEQmvqx8R552KXSvaAPPo5NYq0XJ1RXLtDeBpHFLIwWKI0ni0JutEBPsuLlx9JJWjbKUbYo1asPshKFX98Bu3oxuQmYX65dPv/H0XeDTRm/OfMQyGsmrvBgsmO1QGpFhuIYQu6cr5ktfSqWS7HeepKxNMs7rWIt9ep+5cah+0AIKpBWlJgv/e3v5suezpsT9WEDRRSfBB7fs3LDqAf9ebo+5vG/dSNMILr5DdNhjoW1TQ+w0kWZekfMyIhOprC1599cNPVqe2dYidtiih2Hu9ftNXDp7wCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 07:19:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 07:19:26 +0000
Date: Mon, 28 Oct 2024 15:19:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, <linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  b0d710f69d:
 sysbench-fileio.write_operations/s -5.2% regression
Message-ID: <202410281550.86216b8b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 97661381-caa0-45db-604e-08dcf720da86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7yN6WaWC2xvnN/lNGigBbxt7CQDz9iE7uAAVX310c+EUDtjDS6kD29RcUG?=
 =?iso-8859-1?Q?mIxmb+HhZHSkoxAfJKwxBZ3jJ7NlkU7WDBiMYUnuQQjpMduer7QLM4b8s5?=
 =?iso-8859-1?Q?ZkBti4ju7/Pd6vcctYmGabYzgPLzEd7tdUBcvpEn5kd8+No9MWtk38RSd4?=
 =?iso-8859-1?Q?RskPvhybpBXYDIgflVSo4ZsPkZ9/ZzFYAfi7qibLAgPPJGE6YZzI31ypxI?=
 =?iso-8859-1?Q?vXd6Y6RqeC5UDjhh/tOPtfoSVXEjrosYTncNXwr55Z1F1oGgKNM0LkFxEl?=
 =?iso-8859-1?Q?fNTlA4sYBW0enDP+k0bWqWnw+ZaCooULssVrqVxE7VBu467PYs49N5LA0z?=
 =?iso-8859-1?Q?Thr+BOPkBYgfmW8uUcT0KBApAgPxz1d/VogjdBZEGmYjy7DN4YsDPlTWlx?=
 =?iso-8859-1?Q?FUirU5CBENR9EKMvKZf2GJcoGD2syM2gHCzRbzJ+xz4rxavVZzsTjRrvYS?=
 =?iso-8859-1?Q?dZE9G7ttN9PTrXFaBGJuoefTaxpzP0fcf4aLsoAY0S1xURkBw9P03s90jk?=
 =?iso-8859-1?Q?mefP+ZRFaufHHzFLh6Y/92PKKgXzQ+6GIgOpiQZmfcXZa6yX4DmQhcXZiM?=
 =?iso-8859-1?Q?oAuTQdsO4x8S1aT0TfHc3VOqqQmjXHiUg1Kgr3bBFnrhOKSDoKOHBVXsYi?=
 =?iso-8859-1?Q?ZHu5MfTG5QF3eo0SIg9MiZ0HajpTXmk8p27BQHH11ZrjVBIIKXqJEnD9CO?=
 =?iso-8859-1?Q?RRpwugDIWGn8g7rDCIUsawx2XK1vVtgUjCvGmeOxNIQqTQHxIvOLe+j9Q5?=
 =?iso-8859-1?Q?/QoKK0pMQtTkbTI27UbsEiNpNyoiSZz7yoYv6/AbwUBZgOa/p+bbARoMBl?=
 =?iso-8859-1?Q?Np8Go3VB0kjiS75lq2Fda7lrfHtWS9wars4gfNUqffENDtlTEj6Pmtr+FZ?=
 =?iso-8859-1?Q?kYrJvDIUQ9Kh24wEeu5KOwmeyt7KRctgWPVNLsyP4HSpEX7PcHzrNp/gTG?=
 =?iso-8859-1?Q?Bg/wsXHUX6MIdDiWElBsh0CssYWROnk+zOB7njcdmOHSXyOz6X2SFyovml?=
 =?iso-8859-1?Q?q6IxFRDQGOOJVXA3TZL3tB3j0G/Ap3/snl4lFbgsOdh8UHZt6XJo4kqF1l?=
 =?iso-8859-1?Q?jni60Ilx6Vh9fu86Ow23H6O+P++rN3St6m5gmcKEG1diNwif4dDhwNiSi1?=
 =?iso-8859-1?Q?jzScT7a7/rSVJaG7qnBvRP9WiG+OkJzddhNHthS9c14AtmpoyTnv1ZKGKn?=
 =?iso-8859-1?Q?ERIEyOu4+cFcs2D/abxAk3T2KFIq76TzInlewDduF+NZQ6uQDLYzJQSICK?=
 =?iso-8859-1?Q?nwKLW3knacpJ4BMCYgH06RB8fDY28/+BWXDpfdvOSBP+SoY+BalbpGgoLa?=
 =?iso-8859-1?Q?fvCERziT7+ofx62huGnuFcJ7SA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?euH4E3M9tIHC9qkjdGrgB4wG8YhSXn+JG+Q/13IRqX+aVp7K52QKg1bHqE?=
 =?iso-8859-1?Q?Q7Q94l5p2k1FbpZ0hIokQ5xMUCzGhzvlxgPN6WkQK8/ecKM7MB+d4cKnkO?=
 =?iso-8859-1?Q?UsKM6NaYJMjgY0wg8SL7ee3z48jcg8FdsM/ygBZREItfn7dBvyzpGjOBRQ?=
 =?iso-8859-1?Q?1R7fYuQupYzB09ihDWupA+eDMPLQEZKeCzV1C2dnFDnkKJNFJUhNarm7nX?=
 =?iso-8859-1?Q?Ye5KHQgrNZEYOZzT7Or+IgxbPe1hI2GnEzgxgl43J5TUR4Tc4myavQdmd4?=
 =?iso-8859-1?Q?oZH8N3n2H8V+lrFvYt5mFfIyNmW1kmPSAI18n7xUuR3WiL+rLyAGFJjXns?=
 =?iso-8859-1?Q?pq+162cNCVEaubugdw76UHsVWyUBZIaT4XBAmWLHIU5rl/PSNkvTx56dRF?=
 =?iso-8859-1?Q?EZAMJglvUBoBMsKYoFzLBvo6XtY92+RNB1o7RsE2ohxKppsxA4S4xLdsXX?=
 =?iso-8859-1?Q?Ywc1zeNPcAKd1nj6nVKLPm5v4kovDQkQbHwj3CJuCIHhSpKnmtkcMbjYYp?=
 =?iso-8859-1?Q?XXLo0ifraw2U3rSAhljcb2lH5uXI2NTrf2oVr8Bj5ZBLa7zwUFJurR9IDf?=
 =?iso-8859-1?Q?mWyZTr2XxkyLpGkXex4LuYLRCVKqJg3PqrhIu1LJa53rc1TSfUTghGw4i5?=
 =?iso-8859-1?Q?f8CdJyWD6Y3Pj/KmehTWnwhHXaKgolQQu83/uAHIXAEnnzEtTCQS499BnA?=
 =?iso-8859-1?Q?7/giMf0Wn6BvsDJgVW7H32ElmPLJ7rYqvdOkJ2oGng3waK3wXgN+LhgK2Q?=
 =?iso-8859-1?Q?vZShRyrDoFH0W3fauA/CXlYFEAEHm23vPvH6kU7XlxPke2NMILi8Ranow1?=
 =?iso-8859-1?Q?xVkXr+Mlk7ytXzI7QTS7iL78jLfrBNOinl/smuXGbLOvWDEg4M1P8j5m28?=
 =?iso-8859-1?Q?X2DzaCxS6mowtHLHCTiGx8rwqMshTSYW3GQmLod1sU0sK/ik3ireAN8jsB?=
 =?iso-8859-1?Q?NeVIsH149LKlT3spLrbPcdPZIowFMucT6nBet9no6sMN8CnhSF6eyw8mvc?=
 =?iso-8859-1?Q?jAWnEFQ0RWZmmsxB0KK0HtWjaixuCBD+aFZ9pEqnKAmt15G/W+kM/6dn4L?=
 =?iso-8859-1?Q?IO+k8or6hnKexaM0q2EOZV0U2Mop9YvGfv+j3dPOF8B1KKMKEgFZwP4wHj?=
 =?iso-8859-1?Q?fUlJNsIK0tlgSjM+3MhnHudrKbOmAuCRIblo99YiJ4J5gUeA8nlgPlP9wK?=
 =?iso-8859-1?Q?ESoIgY6dPoxF5YfOUelKuFvNrzmxpvIELmpQhV1KznEiko6NhCeGCgEL6G?=
 =?iso-8859-1?Q?81+IXbKKEWZPIrGIjX6NYK6yS9II/Lrn39cHLO9cDZbwf0U26XQ7EdGh3X?=
 =?iso-8859-1?Q?KxHE2HpMhsHsqTXyCSFJASKeUuMqVHcd7RBJPx5BbpsHTd74Zr3JlHYyFu?=
 =?iso-8859-1?Q?NesVnU2Xw8fuCIrO8+uGFYEoVGpQKGYC8eT5DIyEt7xdgCn3hXqeh47xF5?=
 =?iso-8859-1?Q?M3u3yNk/dRYlgO58ZGeFOb7zrp+Zj/K9WPXCOwtWvYQax/+0UPgNbYZzWN?=
 =?iso-8859-1?Q?5H0en+faapz9xUvwUIkohgbpbZFxVT3X8N2IDzjAMbKaUmb9NxXZ3HZgQd?=
 =?iso-8859-1?Q?9IhvRCP2DaoKR6ai7FcLo/IkVfnSYuEvd0qAqObqlAd8fkgaJat1pk2x/u?=
 =?iso-8859-1?Q?JKyzwwXZvpShT6mKx2JbrrfsekxlYNivQBuHo7fT7BYJm0CKxQ0LQVYQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97661381-caa0-45db-604e-08dcf720da86
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:19:26.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMbk1LdSPTbwIy42WwaDpps0dJ84+81gzU/gTxwVqq+KgVS/IqbKl+Y9jEu2G5mGvWa9qbvSsOwoMSOUUMfkvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -5.2% regression of sysbench-fileio.write_operations/s on:


commit: b0d710f69d36be968fafde3cee3337cfde2b0e62 ("btrfs: make buffered write to copy one page a time")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: sysbench-fileio
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	period: 600s
	nr_threads: 100%
	disk: 1SSD
	fs: btrfs
	size: 64G
	filenum: 1024f
	rwmode: rndrw
	iomode: sync
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410281550.86216b8b-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241028/202410281550.86216b8b-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filenum/fs/iomode/kconfig/nr_threads/period/rootfs/rwmode/size/tbox_group/testcase:
  gcc-12/performance/1SSD/1024f/btrfs/sync/x86_64-rhel-8.3/100%/600s/debian-12-x86_64-20240206.cgz/rndrw/64G/lkp-spr-2sp4/sysbench-fileio

commit: 
  d08f714f5e ("btrfs: fix wrong sizeof in btrfs_do_encoded_write()")
  b0d710f69d ("btrfs: make buffered write to copy one page a time")

d08f714f5e089d0f b0d710f69d36be968fafde3cee3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     85.00 ±  8%     -22.0%      66.33 ±  7%  perf-c2c.DRAM.local
     76.91            +1.9%      78.34        iostat.cpu.idle
     22.77            -6.2%      21.36        iostat.cpu.system
   4319018 ±  2%     -12.8%    3764429        sched_debug.cfs_rq:/.avg_vruntime.min
   4319018 ±  2%     -12.8%    3764429        sched_debug.cfs_rq:/.min_vruntime.min
    768102            -3.6%     740091        vmstat.io.bo
    253881            -2.5%     247609        vmstat.system.in
     21.61 ± 50%     +15.8       37.45 ± 27%  perf-profile.calltrace.cycles-pp.fput.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      1.25 ± 20%      +0.3        1.56 ± 12%  perf-profile.children.cycles-pp.perf_sample_event_took
     12.42 ± 47%      +8.2       20.58 ± 24%  perf-profile.children.cycles-pp.fput
     22.08 ± 31%     +11.4       33.44 ± 24%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      0.22 ± 28%      +0.2        0.40 ± 26%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      1.25 ± 20%      +0.3        1.56 ± 12%  perf-profile.self.cycles-pp.perf_sample_event_took
      0.00 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
      0.01 ± 56%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
      0.02 ± 29%     -77.4%       0.01 ±109%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      0.03 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
      0.04 ± 46%     -84.3%       0.01 ±118%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      0.06 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
  12431357            -2.1%   12170266        proc-vmstat.nr_active_file
  85224440            -2.9%   82744217        proc-vmstat.nr_dirtied
   4485178            +5.1%    4711975        proc-vmstat.nr_inactive_file
  84991512            -2.9%   82508900        proc-vmstat.nr_written
  12431357            -2.1%   12170266        proc-vmstat.nr_zone_active_file
   4485178            +5.1%    4711975        proc-vmstat.nr_zone_inactive_file
 5.151e+08            -2.9%  5.003e+08        proc-vmstat.pgpgout
 5.613e+09            -4.0%  5.388e+09        perf-stat.i.branch-instructions
      0.51            +0.0        0.52        perf-stat.i.branch-miss-rate%
  52850157            -1.8%   51876154        perf-stat.i.cache-misses
      5.15            -2.8%       5.00        perf-stat.i.cpi
 1.558e+11            -6.0%  1.465e+11        perf-stat.i.cpu-cycles
      3651            +6.9%       3903 ±  2%  perf-stat.i.cpu-migrations
      2810            -4.7%       2677        perf-stat.i.cycles-between-cache-misses
 2.803e+10            -3.8%  2.697e+10        perf-stat.i.instructions
      0.26            +5.1%       0.27        perf-stat.i.ipc
    262032            -5.2%     248467        sysbench-fileio.fsync_operations/s
      0.62            +8.1%       0.66        sysbench-fileio.latency_avg_ms
 1.061e+08            +2.3%  1.085e+08        sysbench-fileio.latency_sum_ms
    251.19            -5.2%     238.16        sysbench-fileio.read_bytes_MB/s
    239.55            -5.2%     227.13        sysbench-fileio.read_bytes_MiB/s
     15331            -5.2%      14536        sysbench-fileio.read_operations/s
 6.221e+08            -3.6%  5.995e+08        sysbench-fileio.time.file_system_outputs
      4964            -6.4%       4649        sysbench-fileio.time.percent_of_cpu_this_job_got
     32726            -5.7%      30867        sysbench-fileio.time.system_time
    367.04 ±  2%      -6.5%     343.14        sysbench-fileio.time.user_time
    167.46            -5.2%     158.78        sysbench-fileio.write_bytes_MB/s
    159.70            -5.2%     151.42        sysbench-fileio.write_bytes_MiB/s
     10220            -5.2%       9690        sysbench-fileio.write_operations/s




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


