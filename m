Return-Path: <linux-btrfs+bounces-19467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58923C9C69D
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 18:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5485342ACC
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40A2C11E6;
	Tue,  2 Dec 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQvCFGiz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4D257AD1
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696953; cv=fail; b=lt11mwt9SBuhQUqCNSho5ZzbNG8tF9wtukqZlDv8UZeCR0rqopao34d3WXlB3AH9B7VA1daoKMa5KP0RV/r6Shmr1xj+R9M93B1z32SffSOdGJvls/FggLxqgPpN3bEe59MEe+jqUpXt19SwMbXM5CNAOxo0P1NJ2KfqwalwghY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696953; c=relaxed/simple;
	bh=cOP6i2HaP6rcQyeC69DWZx2RPJC3nJpH8RuuNP2VwCM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OCi9E7eYVv99LlIaSgRN6SMRoyqrufMByZJPw/4CkfrsX5fwHIZyXaTwF2biEsiUlh2psKj8H05c8UEZ+roRF/P8ujBjCCAc9Mirg5b7Lw/Dw1cJ0LNYftB6Xp3uk5mQuTrkrq3QXFtRGt8b8aOiGi0/ZTE0wXxsA16VbPSxs7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQvCFGiz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764696952; x=1796232952;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cOP6i2HaP6rcQyeC69DWZx2RPJC3nJpH8RuuNP2VwCM=;
  b=ZQvCFGizr8poqpfILrrITVFt4ovZl6ZQi76/a7lfS+6lkm9xBkOvtPUJ
   O4NS5qa3EUR9wuGwHoIw3Fk09ZIo+/E/7a0/tD0yxrHYanp7Wm1izkNY+
   6EayTYMTDxFj0jCgqbRu07Jcq/zAWpTrOPW1JOxm5r8ZSrr0Gchpcd70/
   aV9R9W9tbspv33E4qVdCcmQo1lHKeYUfw4H8tTOtFps7R1luKu4V11LBx
   36iRudlyAcknBawZV/10TsrUkN+jccFODzfWAA2kUVqGLh+23KJdy11XI
   cMlht/Jc6BQAjt/KPRHGorr78OUUr+uUoQD/kxRR+CpCDWNZGKA0t0NrK
   w==;
X-CSE-ConnectionGUID: yxE4EZffTQiUcB9gR+19iw==
X-CSE-MsgGUID: 3i3kuR8VR92JCo+R2iM2WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77782269"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="77782269"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 09:35:52 -0800
X-CSE-ConnectionGUID: 1CcZSlamSXuPFbHsH+5mqA==
X-CSE-MsgGUID: /AmyWuU4QbOyJBfX5KbN1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194672031"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 09:35:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:35:50 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 09:35:50 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:35:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpMrDMZEqlkpBC6x6mSEOm6UgysWa1jEpMKurQQIfVRvO0HqC8d4Wjqtmu29qcDOaKgv7PcWUjddmqhKLXgSNMEvSt3KSmQJZQSIHYCi/NVkNkw3OYkhj8Yz4d6v41s649cwAWTMbwPRQp62pgPeo/wsimUdajRruzSr3n+09f0RQB/HPaRGlrv2+ATCGbNoVDH/+bNYzOsJYR20qhTuuhUfSVT0n3iN0U1y7bnJot7gljdzxzp/MZlFavXhQVpEfgMieJm+P4F4Fs7ks3BxhC3h+FdiMgtSvLkgxoMYEUPb7jDbnlML2xnrkPQsgla0NDXiultcNMdCT0p/TiyG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TFsDtEdLNp150MMH8702G06yME4DTRmV2G2eqTNCs4=;
 b=REGA94vgpi8wiSsli+/dt6130qyGv3r8eIVofag5IGcCucoS/Y8ySuroZIrZq0af79nA3iTOTFWA9O14WN2oETee4HYkvpOX91OH0fI+dH4Aph/DR6iCrzVzAvPyksvFwQHWmzFd5wycWuIrvg/6D8FvEZiK37vaYgmus7OZdk8lEbbaq5Pm80lt572DQg4qa2xjIUBttcj7G4NKMjnrL0p+J80n+VMXW4zO9l442xKR1hGNRJFZ41FPhuZ5sDUZdegHE8nmsfMPp+q2BemMW7T7JulJFgf7ow/CegJJOohCKB16amIU1X56yg6J7l2K/X1ZocUJKKynMBdwRtWOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MW5PR11MB5788.namprd11.prod.outlook.com (2603:10b6:303:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 17:35:47 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 17:35:47 +0000
Date: Tue, 2 Dec 2025 17:35:37 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: <clm@fb.com>, <dsterba@suse.com>
CC: <linux-btrfs@vger.kernel.org>
Subject: [BUG REPORT] possible use-after-free in btrfs_get_delayed_node()?
Message-ID: <aS8jaaOK/JB5sAnZ@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB9PR02CA0002.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::7) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|MW5PR11MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ce4ed7-5c57-4875-dee9-08de31c93a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+S/EGquVvuw3NLHnaR75mXWW/IiqJT5UZU5e9+4WsI2+AUJ/h253W/FgNObA?=
 =?us-ascii?Q?0GxzKYmriarv11Q2KNZtENd416xvPQjk13fwsajE9SGOqiW3RixTm14Lq/BP?=
 =?us-ascii?Q?275VVixP5aahqpXXhegF6p63gPEWIl7n+HIxq5+qiXF4F7A6rqzzxdeQhhbm?=
 =?us-ascii?Q?MzYFnFaPBBgH2HVjrObRaSSsxtW1KXd42Q9qJQRA0W4u3UcLzdmp5fSashnB?=
 =?us-ascii?Q?yq8JJAuUO/DUhSfP0jLzE5jgz2HIqs2+E/IxhgbtLiQBhUk6WLAwv5TIkrsv?=
 =?us-ascii?Q?rLV+8/wZJLoAojih1uuJfCG8cdHlfHxAKxQQfwFultswDIgwGisOt5mwoyaq?=
 =?us-ascii?Q?wmUwdBOLsKqKzhzzHuduxqTd29UXTGrIXnL4Z9i+AirZr4pQu5rL+7PdO1Iq?=
 =?us-ascii?Q?SiOI+LfOyiaGWnKE8aY6LpIgwsNtP7Yy+Cpu2+KNQ8UyNarJUqCPgc0EitF1?=
 =?us-ascii?Q?sLpsjUgNyBrHb1mN1VfPemunDcOqLN+x1qOuUhF4w7XnDQ+qYlCEjzaPi1ch?=
 =?us-ascii?Q?DODvWE5gZbsjahvK1M1146Z+V+GbFW68VkkVPpk9v9NtL691FT9e/LiwWVcc?=
 =?us-ascii?Q?UDDzkpR/BVIPhsPoO8U0NEbFpZ5IkGsPKDLLQiG6NZkGRUX9HCGU2bF96ahS?=
 =?us-ascii?Q?qNDvtTGrRpm3FBCb6Zmo2SFbhS/IEOOckjvOLL/p84iSDn3jkuPPycXozw9i?=
 =?us-ascii?Q?roH50+q3ku7+8109BfdhMBAK2KZ4bTEVzTmM/FEP0qrGa50Tz7DejuizDxgp?=
 =?us-ascii?Q?UqJ4GnUA4iMcJfkhVXxfh0MorZvXy08PHJSVTlnWucXoQb6Dkcab41RWAwtl?=
 =?us-ascii?Q?dwmgn/H8Kmmgk4B3srrBf+clcTBCIszQTnkrEi/gIrCb7JZiYezw7c0TgMfz?=
 =?us-ascii?Q?5cPky4VBXx3SnBv7pO4V/4bkQdS0ERVgs+CmsQkd3TbbXIJC/Xf645maFZHC?=
 =?us-ascii?Q?+Cuq59JOhhDwI23CHaMGUrR8wclAc21rkYtqFThx7pIFXbv1/36qy+zLUqCN?=
 =?us-ascii?Q?q71LyykG4caQn70PxCCaGNkZxG3HTke9eB9/Hkdqu+JGw64xh4rhvFvKjoul?=
 =?us-ascii?Q?IupRPCXbfI2XGxXw8FU0Bcz03PwBMIb+fKJWFe/GW45JY2DwvRsUf/mqCBw4?=
 =?us-ascii?Q?esULjgU2TyncKj9bMZYUgOmIGEkDBWPP+An9xpu/TcfGHuqowYO/Vapx1OGU?=
 =?us-ascii?Q?lVlFp+YhBlJbQPqhdF64QrgnG4J4J+18Ukud1wF9XqowgML1d/qWcKK2tsv6?=
 =?us-ascii?Q?rixW18gQIlivd/l3/HXb148i0ygHqXiMREY/CVG8nvFLe6zBoNuKTnMrmPlc?=
 =?us-ascii?Q?kK0tajq2jhxWS6EDCpOWaHIClavim9RYSR7rzfWOkbFon8pG0uzpdTxlJWjd?=
 =?us-ascii?Q?mIMG8Cf5NRzfARMCWb8Sjs3XfRF0AK9AO/uFMJuONIBAKaktBDpTAjcQvmB2?=
 =?us-ascii?Q?m4mQI4spVnbupZCKItR6I8kuH3KAHP6zFOH81EO4te3hhnQxkauReA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cFlcpw6QrvUA0fYURh44NsUlXuj5j99hJQUcQjXJnJUYyT7MRuFIBWBbOrbW?=
 =?us-ascii?Q?Bt9Km46c4273pAhlX8CtLFdjYjKKlMhKiE7zcR0Lg2uvOHHpdcniI7u/bXZd?=
 =?us-ascii?Q?gq9ZC8MlYUQ/gmvy95U2adgDi/Ig13YVUnRjglWWnJNHuUrvc2BoXQzLXeuH?=
 =?us-ascii?Q?RWxIUkjtAlmFrzH3+hN+mJPjaMs0QjW3yA/VhHoRtda2lRjY39w56H1bfep7?=
 =?us-ascii?Q?2XjVIm4lq4YJCU5tlQWu6LYya69Zfdv0I04PnET0cYe4YkbBo/pQdTB8X4oM?=
 =?us-ascii?Q?2licQ7MjeRDpWuSnT5xXoTQ0mFKVw6wgA1sB+DcCbIeZ5ibpyjSvdL7wB3qN?=
 =?us-ascii?Q?eUSN2+81/wzxx8tJw8SBFRUEr5FQxzoL4Yw0AN0OEClidVKb8s8UCieCx6oz?=
 =?us-ascii?Q?1lxr2AbroQMyuYYukxiIsi2kI7egI62Mwb4reRkgbPbLbbMhicyPGqYKmB43?=
 =?us-ascii?Q?rzP1J1/oBpKhihotscz2PWLrXHkt8WMA55+78IiKrx8MH52fa2hJQQfJRYxK?=
 =?us-ascii?Q?o9Ncyu9OMhX0uJaiwwtb14QMbKItqQwqpBAOK2B8ZMq9r5fUtkVZNnnTmOWS?=
 =?us-ascii?Q?i+y7oyDgnE8oKhT2ahWv/DNr4Ax8E2Dy/Knnan3IP4ymY3ka+/ILDQhkN5sW?=
 =?us-ascii?Q?hFlPE61TaoHrT/uujcgr/dzg7SGhcboPc9GXKKbM3IUeaYqcQu6XEBcmtDiR?=
 =?us-ascii?Q?F/xa/TYbuDfyVeMBHKwfzavYjE1BCmDvggPJ14ZdkTBsOCMCdURY71fcQ06f?=
 =?us-ascii?Q?LflWDkl/DL+ICHttnldOuWM5itY8OrWJGtPiOkpNupY7g9kxwaFC3amn5b16?=
 =?us-ascii?Q?wTzoSyIrqkM2hllZNRbrb16+DBT6U/fFYavU29eRL4kddC7/QUH7xUi6Hckx?=
 =?us-ascii?Q?VKYIjOtIwOGwL7afAvtLxo+VcxqNo+Klusqee3S/Wa2SV4iCE8wqlv7ohII8?=
 =?us-ascii?Q?22V2tP4oYf8sc+OmTqRW1/8JJ5h9S+m3gz1zg7UFpr1DRhG56643eG70XvZ0?=
 =?us-ascii?Q?OY70ag4hXefUPBhp46NxPpi4FC27Q6dKP6cRxf7UWbAN7qgkniAujj8YELbE?=
 =?us-ascii?Q?URNwOWDQqifMO3Z7wgEkOxbL+Vb+8JqZXjsss+NLTrKbMjoZwvpQrEa5SAUY?=
 =?us-ascii?Q?feZuC6OUeW4dJQBn0GnXB6z50pVlcvkD3q3d4FDEAgaDptJ+N4kkQD+cQML4?=
 =?us-ascii?Q?H31Bnun9lN2/F9Kcz6V063kMc1833p3gkykfRW11qD4mo/ZP9N9adLgamntI?=
 =?us-ascii?Q?rv0eIMuXglv+wyQqg58/hlaaPSU+11im1NUWjLkQMdbDPyuGxCuCw/k/dYnF?=
 =?us-ascii?Q?ZLVAh1aj0NszDfbDlrf+Tal773JRqNdfyM+VZEStpayML5C+G395dMUkytTo?=
 =?us-ascii?Q?LJaGGt8ixja0eibiPMgSTVvvMdIySdXJc+luu2fS1yNUT/u95e4Xc+0cSgQo?=
 =?us-ascii?Q?Ee3QFnnTxX9OrfIGsbzl5nUrHxX888wE2ctH1yNv0ZOZoLz1KYOfM/UGQ+i0?=
 =?us-ascii?Q?94oDVSgmmUIUPMpXFYWVVIAlE+mND7N/dTKtQm+YZhcFLiCLypbvyVEqNe4J?=
 =?us-ascii?Q?ePyQAs90EaE6FsJL1kGhOv3PH5Xdnn2yR9N+1OAP6JYo47Edud3EHAcFOmmP?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ce4ed7-5c57-4875-dee9-08de31c93a89
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:35:47.4471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35+t+d01g1WEFMlUkcF/NKkqIG47ELZUqjD4KV+7qZpjxvnrAx6qXaq/LAJ2fz6Xbvi4TX07ZZTcAp8Z5R7/twxiRSalMMpC5k4Fq7Jm3I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5788
X-OriginatorOrg: intel.com

While developing this set [1] I got the following issue which seems
unrelated to the set:

    refcount_t: saturated; leaking memory.
    refcount_t: addition on 0; use-after-free.
    ...
    WARNING: CPU: 67 PID: 3156316 at lib/refcount.c:22 refcount_warn_saturate+0x55/0x110
    RIP: 0010:refcount_warn_saturate+0x55/0x110
    CPU: 77 UID: 0 PID: 3002837 Comm: kworker/u1153:6
    Workqueue: btrfs-endio-write btrfs_work_helper
    Call Trace:
     <TASK>
     btrfs_get_delayed_node.isra.0+0xe9/0x1b0
     btrfs_get_or_create_delayed_node.isra.0+0x134/0x1b0
     btrfs_delayed_update_inode+0x28/0x1e0
     btrfs_update_inode+0x59/0xc0
     btrfs_finish_one_ordered+0x5c6/0xa90
     btrfs_work_helper+0xc4/0x190
     process_one_work+0x192/0x350
     worker_thread+0x25a/0x3a0
     kthread+0xfc/0x240
     ret_from_fork+0xf4/0x110
     ret_from_fork_asm+0x1a/0x30
     </TASK>

Could this be a race between btrfs_get_delayed_node() and
btrfs_remove_delayed_node() where btrfs_get_delayed_node() reads
btrfs_inode->delayed_node and calls refcount_inc() without checking if
the node is already being freed?

    btrfs_get_delayed_node()
    ...
        node = READ_ONCE(btrfs_inode->delayed_node);
        if (node) {
            refcount_inc(&node->refs);  // node may already be freed?
            ...
        }

Thanks,

[1] https://lore.kernel.org/all/20251128191531.1703018-1-giovanni.cabiddu@intel.com/

-- 
Giovanni

