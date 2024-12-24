Return-Path: <linux-btrfs+bounces-10646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B881D9FBF23
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2024 15:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A116411C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2024 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0F1C5CC1;
	Tue, 24 Dec 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mB2g5EzI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5E1E4AD
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Dec 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050215; cv=fail; b=lp7/FFooNGdGKsKhDrFWqy1Dky1BviksYAalpZQ00xmC4PAC/XCQHepLvEXFeP4cBhbXiQ+5awQCCT15iEfeZwsvGFtc2yydXtyGR6dm1EmJIOOr0QYRUumyclpR/5RE/d7yy82CK3nc8NQoq3jwm45ufBp43jDSrkQNwRxjL3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050215; c=relaxed/simple;
	bh=N0fC7CHbCNLi6w2kqQSWVaP3WW5//w04GrBZKv3jj+o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4AKQ9xtysX2uPFJnugmtkG97X/9s9hX0ImOSBiLBl0OKsOJT8NEVl3UVnI6J+ibIg85QiyMUu+qXaM3xqHW8Q1IyBOSzHfS8DqEQgh/ejSFP5vr9uYd4gyVg2MpFoDYjA6JhBaG+I9dFPOMBjLSSc55T1nyhNnXG29a/qkr/RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mB2g5EzI; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735050211; x=1766586211;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=N0fC7CHbCNLi6w2kqQSWVaP3WW5//w04GrBZKv3jj+o=;
  b=mB2g5EzIKkJy0BYc41uqhy4wt3JcwOYxKbObmdhIvsAV6wvI89M4Rvyk
   Cv9zowNZ4ewIUETClStE2wcS4sAfwgr8WXy8J8Ha+tnXM3nCypwvrmXHj
   IGgUulPtAPj0gf5g0th4dkduH0huOfnat0Hmxwr5KyK5wsw/p2RBCHlAu
   Uxyh5ZMaErGEouniIn4+bPkrXhFiBrYx4C9jDwhLry12mTktyKIMcFhI4
   fUa++EBTNvHC3u1HPDpugy9xghWvTSLex/iizLqwUgSu7NcUTbKXsLwqC
   zGedBZk3s6R9eJsFCHht0kjBIvwrJ/5WcacoXdwC6S8cUo2Ooidf8j9/X
   w==;
X-CSE-ConnectionGUID: SyWr/4aqRsSSjE4wV1z3ZQ==
X-CSE-MsgGUID: koIjBnPGQB6v7FKjDdRePw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35682658"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="35682658"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 06:23:28 -0800
X-CSE-ConnectionGUID: jETAmJ1IQKuiv0QnHPrIjw==
X-CSE-MsgGUID: iYjltuA4SAqqRaMqKgyP9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104118542"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 06:23:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 06:21:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 06:21:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 06:21:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtRK52huKFBMMPQ/1+HbHiwhoVzBr84AXDSIVluv4n732ajLXr1yzemmWtlzBapQN6Ggsn8BYsImXa5NCy609Ghx2UnzlFobTz/rvb9dk0CV0HPs/+LE/2tASlGLEDOh9reQknNcgqEjdaSe2ufbENeIhvTkvvX64ZIUdoB+3qCsNENJ1gs6AxYqeuhtNg+p9wLPAwtl0nM1lTv+G3EBrw3nNgco2nWC2+ZjajYcW1VEzwL4RqBQi58gl+BzD5P2LGagJFbTkenEOza76nxo3ukjzqKaL3N0XsXWlLq+AaFduOsDcweiaZQrGphrTnEynPqr6Zdg58l/HOntG4ebXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfqryNC4xmn43ogQyNFgNHT4I9pSzrOv98LxHRSllns=;
 b=eMuXfN5zNDycyC5geT44tEZsbrWUZf0m4qviuzi7eNT1HtbNC3lPdHmxlP1jPKhmBRU0iR7LtZiURzfvSaHinNodFgGbsKo1nkDYhy5a6QPv1JaozUPW5UWvcC+igBhm3jfcrQuySy+wOII0NdpvPu164uABaWeIuqya/7yRIzkvB+a4yQSA4gFxdVSjanIMC0WOWTmOpLJVU8KUAfJCBKW6ETRrCDQJnajklm4HdhoOE6J3c8Mjd9qmOIx3T7i692hCtFT2qrYhBHU0EDy43jJHnmL+kXBu+vDWtbxde7I2Er+evI+RwoM57bDAlrQeOlSW3hvCyC8HIV6VSOdyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Tue, 24 Dec
 2024 14:21:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 24 Dec 2024
 14:21:43 +0000
Date: Tue, 24 Dec 2024 22:21:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 08/11] btrfs: introduce btrfs_space_info sub-group
Message-ID: <202412241603.d5f0c18f-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab8eb232d1acbf02af7352a2224a31b53ece01f5.1733384172.git.naohiro.aota@wdc.com>
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3594e269-b1b6-4773-8996-08dd242649fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?WxbphxZwW+n0hDkOoCCQONE/3SGtL+TXYuX+bMPVpc053QUaDSrGO7q0tg?=
 =?iso-8859-1?Q?FnmPKzi1UUA5VxqD4TGbsE64C+u3Lkmcw3BjgqkkxL7rzt+W9qbvavgM54?=
 =?iso-8859-1?Q?RshaRY2z6X5ktw0YgYSh6DIujCkaQYRho0aZPflo0eHGMZsP1crR7f1hkE?=
 =?iso-8859-1?Q?0fSONJ92dqeRO+U24GlVcFUKYUZiVc1aBikTM1LrndNqwAD+vUv3jzmP+l?=
 =?iso-8859-1?Q?zDiGsN3QMfUuurwA3+EfQEdVt9xtnhLooYRcOpjefFqpp0+9HYzUPeakA3?=
 =?iso-8859-1?Q?6xWQTRnjyhfTkl6uoP9JhLNsOKSMyvi4v8IJxMsDOh1AH9ft4wFEZ+lknM?=
 =?iso-8859-1?Q?yOY5dKZ3nXzolLmLfAIzpsHDtDQE2+L0d8yK/rVRKsv8JUGT8AwFmwfV/9?=
 =?iso-8859-1?Q?sW0Txr8zNU9hhMYFc0kVgX8o4wZgBk8XTB2XxhTdlRh7lYzkNGWj4sP0as?=
 =?iso-8859-1?Q?PRfTFjY11SN0aA8WV9MaUUzKyzcABq+7Vjt0vNjbJBFHuERskLgNJIUyHk?=
 =?iso-8859-1?Q?2kND/zrULod4wuoqADJUiHDJ+/Vibkh1YifNOfbUUzPAIcRZ0R0iak7a7J?=
 =?iso-8859-1?Q?13HLzmyYt9qRtzHqEQMZvvNqtpfvTTU6weL+4VgXN6KNkoCreTIfxGZ9SO?=
 =?iso-8859-1?Q?szyGKTacQ+Gt14nFjUdMR7Z5A2DY2NcrclIef9zFNUtzLLkEMg7If1fISc?=
 =?iso-8859-1?Q?eKCX2ecqrO0uYM1xOj9UFTl0vdt+lU29SruMv552rdGuF2T2pJM/XkaVTy?=
 =?iso-8859-1?Q?7mZqhidmVHCkRADzmUF78clRTGOEgAEX5hEMna1tvZozDRBoFyDAev+77e?=
 =?iso-8859-1?Q?zqYU2jMnTQLbpz44hHzTahpkeGKUordFcJXWQHZb0r2F6D7JZxAnwgARly?=
 =?iso-8859-1?Q?77TUHzmEkcCLHopv92PxLT6J4AUz/RBZRReEa230Mi4/UxHdGXtxYc1aKI?=
 =?iso-8859-1?Q?0z6Nrpfy+ueeMMP6zvVnf6s5J0j+EagWdhTFjLaZjERDSN3p+Rvx1+ViYb?=
 =?iso-8859-1?Q?yU6SAmbyv9Uvm9Zqa1gZyJqLgeno4Pqbmuv0WQdruU4DO655INm65zo/Kz?=
 =?iso-8859-1?Q?vB0BKUroJXxWTdqWOvxQ5shGVDS0/xQRtwb5n7yuigN5PZ5ICVJc0RLaay?=
 =?iso-8859-1?Q?hDr9xLdkCwwj+mBSCi+cYz6D2QzMNDI1wADzyqa4HXTAeTaa6BxCQjMEgi?=
 =?iso-8859-1?Q?MehJ/AK8fqwTkK4+npcva5GA8FDLIdCsmEXHS5UtjF2IF/cIDoIFA1FPG7?=
 =?iso-8859-1?Q?9tGBq2Fx8reXppd0UqvQjr211eCfXXXQ+CZYv0nn4sH96mgA6KbK01Iv7a?=
 =?iso-8859-1?Q?zZhvsYHkGi/eocdlk261+GOrk9gAqHw4HzFJrXrJIjl1zebwWz6lpJ+egU?=
 =?iso-8859-1?Q?wAVTx0GEJ5+s51Rh2/AXDOInwJKSNwYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wHC+fXTKhAE3z5yrPl8pHhfi0b40COagBYJcIO0QIXPRB28cPwAcw6MlKl?=
 =?iso-8859-1?Q?+FEJR/4uM8JVG0z+GIZdWoCUjY9tkoWiE4aaKWjD/HTmWWHsJiIZGuHhGP?=
 =?iso-8859-1?Q?Aj7eA6BUr7RHSqaQ0t9pgnlRBP4tyowLKbPlkXD8/ZTZVG/kHbiJEOwTaz?=
 =?iso-8859-1?Q?GoL5sOhTvUNb98/Mzdim5hhmDAvCjoAOlGSqjxQnMoSJZRsP35vn1ODzD1?=
 =?iso-8859-1?Q?xhUiYYF4sLtEe/tNByHigFilliIV6bAtN8zpSKmIcMCaPsfb8Xsp7TnXb3?=
 =?iso-8859-1?Q?KzaNSz5bsBhI9+pyNgdf7KNDK7Rg6YLdtFmtKNlOJ0gT1pNLYbdefJ7InD?=
 =?iso-8859-1?Q?13xq3HNlizA6OBfmKbYjJsRCNLiynkTV3zi8nXOjFT9MiGqK97uctsr9wS?=
 =?iso-8859-1?Q?mlSXpOqSkoIjxR/7CHCsTIt2nlyppbog2M4BtqCs8gwzV4iWzvkGTR0ENt?=
 =?iso-8859-1?Q?L05/JVzCZMdK/inhS2fAjgaNhAhqSFui/ovjH/0F3yYLqcolei9pliMsBK?=
 =?iso-8859-1?Q?65BA/222Dz6LNfs0t9n12zS1/fFr5l6kvwaPTQjWc7S3zRwK1PLU3qQQzS?=
 =?iso-8859-1?Q?skpDql6GxMmaqB4cqvjRX9F/mbdhaO4IBumESpe7dbz3MnpUm3yRGKpTzM?=
 =?iso-8859-1?Q?xK59zgW+T+OL0RXkDhMpYEoU3GFuXqHIEL7pUCFZRQCkeWplONjhUJAC1C?=
 =?iso-8859-1?Q?bMssyDsLso4lCg2pnq0ROdMUlFTwJDLj+Fj3+v+uqibAXJ90mE1kaVIobV?=
 =?iso-8859-1?Q?0QHOmnRcvTJCpicKBNxYCPgsdZZrn24RSWyhOWqX+0iv936Ss/uO+DiCD1?=
 =?iso-8859-1?Q?cokNWnTwQbiS9fZUn3qfRXrWk4gkmxu76uxtaEQfNAoIBmfte8uxq/b0hx?=
 =?iso-8859-1?Q?/hpE3gU4QP6l34xoCIL7V+RzG2yXmCsFj3XI4VCmUIi+V7fDsg1TBdh8XC?=
 =?iso-8859-1?Q?zNNBdem3PZBYnx8h8ZLFCawK1RghkUx6pKGIjHRfhu13SQmpwilzva68mR?=
 =?iso-8859-1?Q?nyNm//T27UOyF5W3+JEoT6fk9IxfgLLuCAtswEQfHAIKBLWrngZRzR7lpA?=
 =?iso-8859-1?Q?EZkiYN2M/6cW90tppc5SYTBpx5AqKtsmpEgMVCNdly7ysHXBaPFlkIEAQS?=
 =?iso-8859-1?Q?HPHOOER/M/qDruUjisEjDTlSsqHiiv5gJcdyc/fOGD3Nw6xGdOXSA96VMD?=
 =?iso-8859-1?Q?lRw/0XMeOSIH39JZjK9axVTaOVLX6yVAv+BsI1Bx7fkuq7Xrn5v04i/NqB?=
 =?iso-8859-1?Q?W02KkZy+dLXgIG6CtWeCs52g23Fu4AgXSpaIpJin46P04JZu63nekerFVd?=
 =?iso-8859-1?Q?0Nv/No+WQG+hhVvqQqA4i8rN9Ms3QDzACpCyf63cPvJJq4UKySrNn3vtAL?=
 =?iso-8859-1?Q?tTxO9SEcswCjciHWkzYpd2/l0ovfyZ6ubeIdvP986bsrYlgXaEhyM1ZSPZ?=
 =?iso-8859-1?Q?feD1HIYiNK+cr+PXRaa22JPxB8VvM6RHSahJdSp3RTqCf7zHi9Yr+Go5Le?=
 =?iso-8859-1?Q?3581R+TxSi284BmUIFPiQNKtuUkCFKY++xgC6U2bMpeT36cnb1BrVMpQdu?=
 =?iso-8859-1?Q?iJnCAbJcxPf8u03AuADyr0CcteavtPrvq7/3JJcf1uaFkncinxJwqtMdNc?=
 =?iso-8859-1?Q?GGgJHecNcCK+VmNO5xk10nx/Qbuhfo85otLxwbK5VRHVQIWT96gcFazw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3594e269-b1b6-4773-8996-08dd242649fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 14:21:42.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4EIoJr3WlT7MBDF/pAABGiDdIdmZhxVuNckCXsXzD+IutUMI0VMYKWyleeX0rXJz+TfQs3XBPE4ulAExv2cww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed a 13.0% regression of aim7.jobs-per-min on:


commit: 1d2d783b0ef24d58eae07a32493d1e1e78b4351c ("[PATCH 08/11] btrfs: introduce btrfs_space_info sub-group")
url: https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-take-btrfs_space_info-in-btrfs_reserve_data_bytes/20241205-195311
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/ab8eb232d1acbf02af7352a2224a31b53ece01f5.1733384172.git.naohiro.aota@wdc.com/
patch subject: [PATCH 08/11] btrfs: introduce btrfs_space_info sub-group

testcase: aim7
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	disk: 1BRD_48G
	fs: btrfs
	test: disk_cp
	load: 1500
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412241603.d5f0c18f-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241224/202412241603.d5f0c18f-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/btrfs/x86_64-rhel-9.4/1500/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/disk_cp/aim7

commit: 
  d437de1e3e ("btrfs: pass space_info for block group creation")
  1d2d783b0e ("btrfs: introduce btrfs_space_info sub-group")

d437de1e3ee21349 1d2d783b0ef24d58eae07a32493 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.914e+09 ±  2%      +9.0%  4.266e+09        cpuidle..time
     13.96            -5.6%      13.17        iostat.cpu.idle
      0.28 ±  3%      -0.0        0.24 ±  2%  mpstat.cpu.all.usr%
    283.52 ±  2%     +11.1%     315.09        uptime.boot
    145120 ± 40%     +51.6%     220066 ±  2%  meminfo.AnonHugePages
   9544499 ±  8%     +11.8%   10670421 ±  4%  meminfo.DirectMap2M
    124537            -7.6%     115017        vmstat.system.cs
    216746            -4.5%     207084        vmstat.system.in
    235158 ± 22%     +89.9%     446683 ± 20%  numa-meminfo.node0.Shmem
     92328 ± 88%    +138.0%     219719 ±  2%  numa-meminfo.node1.AnonHugePages
    906862 ±  6%     -25.2%     678748 ± 12%  numa-meminfo.node1.Shmem
     58803 ± 22%     +90.0%     111697 ± 20%  numa-vmstat.node0.nr_shmem
    163496 ±  2%     +12.8%     184425 ±  4%  numa-vmstat.node0.nr_written
     45.09 ± 88%    +138.1%     107.38 ±  2%  numa-vmstat.node1.nr_anon_transparent_hugepages
    226731 ±  6%     -25.1%     169747 ± 12%  numa-vmstat.node1.nr_shmem
    163188 ±  2%     +12.8%     184147 ±  2%  numa-vmstat.node1.nr_written
     39739 ±  2%     -13.0%      34581        aim7.jobs-per-min
    226.75 ±  2%     +14.8%     260.40        aim7.time.elapsed_time
    226.75 ±  2%     +14.8%     260.40        aim7.time.elapsed_time.max
    201270 ±  3%     +18.8%     239157        aim7.time.involuntary_context_switches
     24819 ±  2%     +15.8%      28731        aim7.time.system_time
  14211174            +5.9%   15052342        aim7.time.voluntary_context_switches
     20288            +1.0%      20501        proc-vmstat.nr_inactive_file
     30666 ±  2%      -5.6%      28940 ±  2%  proc-vmstat.nr_mapped
    326687           +13.2%     369933 ±  2%  proc-vmstat.nr_written
     20288            +1.0%      20501        proc-vmstat.nr_zone_inactive_file
   1098889            +6.7%    1172947        proc-vmstat.pgfault
   1317807           +13.2%    1492099 ±  2%  proc-vmstat.pgpgout
     69223 ±  4%      +8.5%      75099 ±  3%  proc-vmstat.pgreuse
 7.248e+09            -2.6%   7.06e+09        perf-stat.i.branch-instructions
      0.55 ±  2%      -0.0        0.51        perf-stat.i.branch-miss-rate%
  50144736 ±  8%      -7.5%   46399318        perf-stat.i.cache-misses
 2.114e+08            -7.4%  1.958e+08        perf-stat.i.cache-references
    125888            -7.9%     115986        perf-stat.i.context-switches
      8.96            +4.5%       9.36        perf-stat.i.cpi
      5667 ±  7%      +8.4%       6144        perf-stat.i.cycles-between-cache-misses
 3.119e+10            -3.1%  3.021e+10        perf-stat.i.instructions
      0.17            -7.4%       0.16        perf-stat.i.ipc
      0.71 ± 10%     -77.0%       0.16 ± 27%  perf-stat.i.metric.K/sec
      4337 ±  2%      -6.0%       4075        perf-stat.i.minor-faults
      4339 ±  2%      -6.0%       4078        perf-stat.i.page-faults
      5.59 ± 81%     +72.6%       9.64        perf-stat.overall.cpi
      3401 ± 82%     +84.6%       6279        perf-stat.overall.cycles-between-cache-misses
 4.276e+12 ± 81%     +84.2%  7.875e+12        perf-stat.total.instructions
   9128951           +37.9%   12584528        sched_debug.cfs_rq:/.avg_vruntime.avg
  19113988 ± 16%     +52.5%   29146821 ± 21%  sched_debug.cfs_rq:/.avg_vruntime.max
   7853850 ±  2%     +38.2%   10851391 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
   1473135 ± 16%     +60.2%    2360403 ± 24%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    577.10 ± 20%     -31.6%     394.77 ± 20%  sched_debug.cfs_rq:/.load_avg.max
    128.74 ±  9%     -26.2%      94.97 ± 14%  sched_debug.cfs_rq:/.load_avg.stddev
   9128951           +37.9%   12584527        sched_debug.cfs_rq:/.min_vruntime.avg
  19113988 ± 16%     +52.5%   29146821 ± 21%  sched_debug.cfs_rq:/.min_vruntime.max
   7853850 ±  2%     +38.2%   10851391 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
   1473135 ± 16%     +60.2%    2360403 ± 24%  sched_debug.cfs_rq:/.min_vruntime.stddev
    257.90           -19.0%     209.00 ±  3%  sched_debug.cfs_rq:/.removed.load_avg.max
    132.30 ±  3%     -19.2%     106.93 ±  3%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    131.35 ±  2%     -18.6%     106.93 ±  3%  sched_debug.cfs_rq:/.removed.util_avg.max
    506.87 ±  2%     +10.4%     559.52 ±  2%  sched_debug.cfs_rq:/.util_est.avg
      1264 ±  9%     +14.3%       1445 ±  4%  sched_debug.cfs_rq:/.util_est.max
     71296 ±  6%     +16.6%      83111 ±  6%  sched_debug.cpu.avg_idle.min
    131900 ±  8%     -14.7%     112551 ±  9%  sched_debug.cpu.avg_idle.stddev
    146287           +19.1%     174200        sched_debug.cpu.clock.avg
    146298           +19.1%     174211        sched_debug.cpu.clock.max
    146275           +19.1%     174187        sched_debug.cpu.clock.min
    145437           +19.0%     173116        sched_debug.cpu.clock_task.avg
    145601           +19.0%     173298        sched_debug.cpu.clock_task.max
    136631           +20.2%     164246        sched_debug.cpu.clock_task.min
      6491 ±  8%     +19.4%       7753 ±  4%  sched_debug.cpu.curr->pid.max
     84360           +24.8%     105323        sched_debug.cpu.nr_switches.avg
    112587 ±  3%     +25.5%     141314 ±  8%  sched_debug.cpu.nr_switches.max
     79225           +26.6%     100293        sched_debug.cpu.nr_switches.min
    146275           +19.1%     174187        sched_debug.cpu_clk
    145107           +19.2%     173021        sched_debug.ktime
    147232           +18.9%     175035        sched_debug.sched_clk
      0.03 ±100%    +707.4%       0.26 ±167%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_folio
      0.01 ± 47%    +265.2%       0.05 ± 74%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.00 ± 51%    +150.0%       0.01 ± 39%  perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter
      0.12 ± 53%     -55.6%       0.05 ± 32%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 14%    +111.5%       0.06 ± 67%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±136%   +1221.8%       0.08 ± 58%  perf-sched.sch_delay.avg.ms.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      0.14 ± 39%    +300.9%       0.56 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.btrfs_tree_lock_nested.btrfs_lock_root_node.btrfs_search_slot
      0.08 ±116%    +979.5%       0.90 ±156%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_folio
      2.45 ± 13%     +26.1%       3.09 ± 11%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1256 ± 80%     +98.2%       2490        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.07 ±  9%    +749.4%       0.57 ±121%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.38 ± 36%     -56.0%       1.05 ± 45%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.27 ±126%    +188.4%       0.77 ± 95%  perf-sched.sch_delay.max.ms.usleep_range_state.tpm_try_transmit.tpm_transmit.tpm_transmit_cmd
      0.02 ±139%   +5117.2%       0.98 ± 77%  perf-sched.sch_delay.max.ms.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      2092 ±  4%     +19.1%       2491        perf-sched.total_sch_delay.max.ms
    286268           -11.6%     253047 ±  2%  perf-sched.total_wait_and_delay.count.ms
      4111 ±  5%     +18.3%       4862 ±  4%  perf-sched.total_wait_and_delay.max.ms
    115.81 ±  5%     +32.9%     153.90 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    130.80           -19.1%     105.83 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    259644           -12.4%     227389 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
     10660 ±  2%      -8.6%       9745 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      1639 ±  3%     -16.8%       1364 ±  5%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      2784 ±  3%     -11.2%       2471        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      2977 ± 30%     +38.9%       4137 ± 27%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      2204 ±  2%     +49.8%       3301 ± 33%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      2158 ± 28%     +40.6%       3033 ± 16%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 52%     +60.1%       0.04 ± 12%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.extent_write_cache_pages.btrfs_writepages
    114.21 ±  5%     +31.8%     150.51 ±  5%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.22 ±122%    +180.9%       0.61 ±  6%  perf-sched.wait_time.avg.ms.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      1717 ± 50%     +44.7%       2484        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      2192 ±  2%     +13.0%       2476        perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.prepare_one_folio.constprop.0
      2186 ±  2%     +14.2%       2496        perf-sched.wait_time.max.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      2162 ±  3%     +14.8%       2482        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_map.btrfs_get_extent.btrfs_set_extent_delalloc
      2154 ±  2%     +15.7%       2493        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.set_extent_bit
      2207 ±  2%     +13.9%       2513        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      2204 ±  2%     +13.9%       2509        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      2204 ±  2%     +14.0%       2512        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      2206 ±  2%     +13.8%       2510        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.66 ±123%    +164.6%       1.74 ± 42%  perf-sched.wait_time.max.ms.usleep_range_state.tpm_try_transmit.tpm_transmit.tpm_transmit_cmd
      0.41 ±122%    +296.7%       1.63 ± 36%  perf-sched.wait_time.max.ms.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      1850 ± 19%     +55.3%       2873 ± 21%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     33.43            -0.2       33.19        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     33.43            -0.2       33.20        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
     33.33            -0.2       33.10        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_do_write_iter
     33.25            -0.2       33.02        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
     27.98            +0.1       28.11        perf-profile.calltrace.cycles-pp.btrfs_dirty_folio.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
     98.01            +0.1       98.15        perf-profile.calltrace.cycles-pp.write
     97.93            +0.2       98.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     97.87            +0.2       98.02        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.88            +0.2       98.04        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.92            +0.2       98.08        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.84            +0.2       98.00        perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.81            +0.2       97.97        perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
     34.96            +0.2       35.14        perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
     26.26            +0.2       26.44        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit
     26.20            +0.2       26.38        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit
     26.27            +0.2       26.45        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.btrfs_dirty_folio
     26.14            +0.2       26.32        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent
     34.86            +0.2       35.05        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
     35.29            +0.2       35.48        perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     35.29            +0.2       35.48        perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter
     35.41            +0.2       35.62        perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
     26.60            +0.3       26.90        perf-profile.calltrace.cycles-pp.__clear_extent_bit.btrfs_dirty_folio.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     26.55            +0.3       26.85        perf-profile.calltrace.cycles-pp.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.btrfs_dirty_folio.btrfs_buffered_write
     26.55            +0.3       26.86        perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.btrfs_dirty_folio.btrfs_buffered_write.btrfs_do_write_iter
      0.34 ±  5%      -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.read
      0.40 ±  3%      -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.down_write
      0.23 ±  5%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.ksys_read
      0.47 ±  2%      -0.0        0.43 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.18 ±  8%      -0.0        0.15 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.41            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.47 ±  2%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.common_startup_64
      0.47 ±  2%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.47 ±  2%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.do_idle
      0.19 ±  6%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.filemap_read
      0.39 ±  3%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.21 ±  5%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.vfs_read
      0.34 ±  3%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.09 ±  4%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.10 ± 11%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.filemap_get_pages
      0.37 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
      0.30 ±  2%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.31            -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.37 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.__x64_sys_creat
      0.37 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.creat64
      0.37 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      0.37 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.path_openat
      0.30            -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.31            -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      0.16 ±  8%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.osq_lock
      0.30            -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      0.09            -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.read_block_for_search
      0.24 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.18 ±  3%      -0.0        0.16        perf-profile.children.cycles-pp.__set_extent_bit
      0.13 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.set_extent_bit
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.__close
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.__dentry_kill
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.__fput
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.__x64_sys_close
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.dput
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.btrfs_space_info_update_bytes_may_use
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.kmem_cache_free
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.up_write
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.calc_available_free_space
      0.07 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.btrfs_folio_clamp_clear_checked
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.btrfs_drop_folio
     99.26            +0.1       99.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.25            +0.1       99.32        perf-profile.children.cycles-pp.do_syscall_64
      0.30 ± 19%      +0.1        0.40 ±  8%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.32 ± 17%      +0.1        0.42 ±  8%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.24 ± 16%      +0.1        0.36 ±  7%  perf-profile.children.cycles-pp.btrfs_free_reserved_data_space_noquota
     27.98            +0.1       28.11        perf-profile.children.cycles-pp.btrfs_dirty_folio
     98.05            +0.1       98.20        perf-profile.children.cycles-pp.write
     97.91            +0.2       98.07        perf-profile.children.cycles-pp.ksys_write
     97.89            +0.2       98.05        perf-profile.children.cycles-pp.vfs_write
     97.84            +0.2       98.00        perf-profile.children.cycles-pp.btrfs_do_write_iter
     97.81            +0.2       97.98        perf-profile.children.cycles-pp.btrfs_buffered_write
     35.43            +0.2       35.62        perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
     35.42            +0.2       35.63        perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
     26.73            +0.3       27.02        perf-profile.children.cycles-pp.__clear_extent_bit
     26.63            +0.3       26.93        perf-profile.children.cycles-pp.clear_state_bit
     35.67            +0.3       35.97        perf-profile.children.cycles-pp.__reserve_bytes
     26.59            +0.3       26.89        perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
     95.31            +0.3       95.62        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     95.80            +0.3       96.12        perf-profile.children.cycles-pp._raw_spin_lock
      0.66            -0.0        0.63        perf-profile.self.cycles-pp._raw_spin_lock
      0.09 ±  5%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.16 ±  6%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.osq_lock
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.btrfs_space_info_update_bytes_may_use
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.btrfs_block_rsv_release
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.btrfs_folio_clamp_clear_checked
      0.10            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.need_preemptive_reclaim
     94.52            +0.3       94.86        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


