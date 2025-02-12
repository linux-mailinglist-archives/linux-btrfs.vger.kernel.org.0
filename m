Return-Path: <linux-btrfs+bounces-11394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05AA31D88
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 05:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDD4188BC25
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 04:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7E1E8850;
	Wed, 12 Feb 2025 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVLP0S3P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E433271834
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335505; cv=fail; b=PtOzIlofekQY3F1mAzCuQ4mzCsVS0LP3R5frDmEL/AnPB+dIsBbr7OuUuCaQSKdGbcBjp9TWK0iQcTxvC+U9KDxwjQcZl/zADIjyppIhDXIt9ZPtkVowvXrDVCRFvwWu/21JikPUL0oyRIqQZ1kkBwmzegXmh08yB4FwZSUWveE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335505; c=relaxed/simple;
	bh=rXXpaInRYxahMIKke7Szsxo48ThoZ+LnI9VV2H0PRVo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=js/4J1L1MwGCbHipxA3vE6qVchU5fxmVZWrR2vTeSdOtljnAi2PyehdbJbtwuegSZujHdloTx19ocYpTseEYrT+86eT3xhdu2PYnTAkePyikhARUmP6hiS0gEMg5m+d5u1tW93HtkRB34wbvVBeFt0F+YOAXOJOf80FDcOrFqE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVLP0S3P; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739335504; x=1770871504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rXXpaInRYxahMIKke7Szsxo48ThoZ+LnI9VV2H0PRVo=;
  b=iVLP0S3PA8WCEhQN3sCZhUamaYne1F/tTMIViceBGKprLFG0/CDJAJv+
   j/LmpkLI6k4htOyzQOmCOVzl2pKpm2vVoz7hkX3C3JlqdUPyY5xy5P3fS
   fiq/3oHQessczC08ml6S5jSEwVdX8E3dwqk24m+t7B8eGAAlcGCg6G4zM
   wi1vBLTY8GMqxJE4CcehBVVhYTkTn7J74ekzF9+pOLQnB91PthV50bGpA
   cOB62xhmxTpOulXgoaDxfyMI+MsX1Ejpkey07plC3qYe4PFAkXkbr+MD4
   ow96ujQuB+pz9HMcw5HPSXDoyaXpPKsDdzD+gkwNmUcayrCZsFdw5OyI6
   A==;
X-CSE-ConnectionGUID: W2Ga7CyGRoeBkhxQdq9S5Q==
X-CSE-MsgGUID: gbcU9aU2SIWz2g8C/xcsRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40098465"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40098465"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 20:45:03 -0800
X-CSE-ConnectionGUID: fYYwc6JoSHWPfU61eW/OiA==
X-CSE-MsgGUID: FR4VGkuOTJa6fsfdFsPcIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116793235"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 20:45:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 20:45:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 20:45:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 20:45:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/TXKTmyC5nRDgHAiCdlQjJ1iwfyMwVg+FmacbAe3Ow0Tgr0oIWWLq4Nvke8hEsd1tKeTIvr6TUo/e07a0rj+sBcKUmUQmDycUb77Hzm3yLS3YhUmWWdjUM9xzNqUX0+O6xCZWpz1+PkHzOWozl2la2FOv4CUk190EgEN5Suqn/olMFfKklr+/4c/crfJaILrwM7OJZr/Z5RmTlpFKEDxiovr4SXHCHSXOYyGtqiIU6IjgBhBEO8jYh6nXtkiq60GclStGqRfYgub385WUrByZQS/ar5LSq0plJMBCTnb/HvLuNXQnaRihbaIwSjd+fJ/3poEskVqQPeX0Quw2idtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ALsSFr16w+zr56Mt6SZDzTKAA78Bq9/k1KvxlzZ1No=;
 b=jrVCWNyqRovhgeOOYyVsfhNPtOUSIWrje3svDg7IWHk/dFZH8quWhInP2rWmDH5EwnzWDL/Y5H8rxGtpvSMZkmwA/63TXdknBE/Uw2KFUYVMUDZFnInip73ajpjJ89W0yYmTnCxCWsp6lFE8hMSTd9esALukenHMNrD54Y+ThecFIDoHops8Ub200Z5Ru+m9gOFFVhHFMdGwwULRiLZTwRjf44xgjdhHlZd3NcsU+D7bDWSHqTldOyV5glAxRHXNpEHtd9x4V8swWbM15Heu0ut2+hFNuIAQGxxDjwlfisNWWoi28EYi9NfXhcZkVV9EN60mBjgi5OUi44SNxphO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6970.namprd11.prod.outlook.com (2603:10b6:806:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 04:44:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 04:44:53 +0000
Date: Wed, 12 Feb 2025 12:44:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, "hch@infradead.org" <hch@infradead.org>, Filipe Manana
	<fdmanana@suse.com>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  92a6e5b713: xfstests.btrfs.226.fail
Message-ID: <202502121035.e70df273-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f24e86-58a9-460f-663f-08dd4b1ffe1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1YmL8u6xxTkotM4eKNTibok6HwLsJJ9D987PQCBRIzjnYBRE789EojCetshC?=
 =?us-ascii?Q?cVEDeSLNL8bxklyaZDlwKIOoLTAwQhw2vCsMMyF3paKjTnb2mkde6sc0TUP8?=
 =?us-ascii?Q?IpAYRYjznx2Rt4ad7uLYtWptzIOeqMPUYKOGpYolMr7vc15hh0ckL2XRrNzP?=
 =?us-ascii?Q?afFoWwsbp1FNp3iqHmuyMTwb2ZXd86YUNI1nkC0MbWoLgW5Sss9eDRATg0/l?=
 =?us-ascii?Q?ByKmdP9NCAxZKhRCzzpLkeLI1axo5XtMe09Es1+6O0kZjTGLoA9t4po3VOyl?=
 =?us-ascii?Q?Afe8CKKVgXO8dR9prYAbon+Fj2bwP/ePwp7R8kD12wztgspvVvboXlo04KgI?=
 =?us-ascii?Q?t9nUFPmsKfV08lF+K/gPRc3Lw3aMOYClBb1Z773iVfFpAOGPdTT5/tuFUFfz?=
 =?us-ascii?Q?bk2l79RuUkzf8CEhXi2FhOEjOaLPQrAVVIFrIJkQJnDvw3j1InNvmVw74iKW?=
 =?us-ascii?Q?25sdI2doYUEf+CvRWC6C4I7rMInvB2s6AnW5CtsrNezQtOX5VAbhrD4ElLfb?=
 =?us-ascii?Q?MfPq5a9Ra0NLzUqir7Y5ysgx0jIYhkHeksbm3cu5pe5r8c+4EFo/7ugw5Mt9?=
 =?us-ascii?Q?fwe7Hsu6CuGc3Z5U48Ve6mVIKB8pl8jTXzycEkwLo3US6r2/UcL4tMgNKk3f?=
 =?us-ascii?Q?GuFS4W7uzo5ReAyFjNglKiuFqNiJyozhePvEOMtQJ2Dwh+wfgLJdonIE3fIL?=
 =?us-ascii?Q?qFWuHLaO/gIrBfVpKgdUaaFI17KixjUkFSg1hpCRwBaG3HbuwSROHyMOliiT?=
 =?us-ascii?Q?VaNcNzeq892NTcJbVwOoTJHfICafz8h5PxTVQmw7/oXaENz+ww7P79PBZ7Ii?=
 =?us-ascii?Q?lz0+g31gZK3yvtrCyTL1cAjL/iR9xpfk4tZK/stINmKDjSCWsLBGH8vURN8k?=
 =?us-ascii?Q?cserUUkEdzg79OdzFBqwJFGeJZWM+1ky2da1rjEvR9S9hw4MmVComKjAaWja?=
 =?us-ascii?Q?wv9zsnB9uFASPjQacWyz/0l6AeTWg04ISyUP8+Fodk+ND7G85Xh7p/8+1xon?=
 =?us-ascii?Q?ZJnTt4rrPVWfUCNRil+bXWovrvXTtgqqXrkJQNgx+4weg7kYTkHHthH1Jte+?=
 =?us-ascii?Q?i/XO02/p5PeeiD6xNRJ2sfbFPKzYahswQv5TZkF25XeBX+Nwv0lwLpFvvQy6?=
 =?us-ascii?Q?NtuZMTkxemoGcDBVwrOxpm9B4ZXib2fvIZGySc++3M0G3PIxbQLbt4mY/Bib?=
 =?us-ascii?Q?GS4qcEDWKnaYJEuT+CGfbI6PZXhXZLdnKp52Dqz+YSfmD/gO4HITNdtS1DDb?=
 =?us-ascii?Q?nYTmDUKrUxjgecuFlbI/I3bspkDJC5bxGe8w3lcKkd6gtzbzZdh1lGKrOZQg?=
 =?us-ascii?Q?yL47tUyHx3Qsz3x6xz8VN6WWebwI9qC60UWUu653UNop7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x/VrlwEn1MqsJqrfUE/40/nbfHLgHF4UC7/Mj+hdQDTts9pCC2BKqz7bfluw?=
 =?us-ascii?Q?tbLujCo8cbuUW17a9BEJcy68jlLZfy4oP0lP4WkzrkWFOpZRSxB9LBH3M6Yf?=
 =?us-ascii?Q?vCMI+rRwb/iDhW9iT6uEmmR1wqJYS+5UGgmS5k9WskBMzTVvF3Rc2Dquhv+m?=
 =?us-ascii?Q?9oIKimTL/Qgw4G+ZR1Yd2ow7ZqL7etG66YmuZwzbV+McZjbrvr5o2mFVHl/m?=
 =?us-ascii?Q?qi4xLFmWXRRuAEl25sGXMulBS4YvtmtP4d2Sa5Xzav90stZ8Xe60RqSq20ke?=
 =?us-ascii?Q?UPAiR7D0zQUpkzOZGNN4ZYjxQBvc4um3kXOs9jeVypLCBzooWZQR50Cna6ow?=
 =?us-ascii?Q?+I2VuG7Bpj1pbyez83mVBp//urKI7NdKZx72DnaQGCsamyjHv1WGwzJBdqc7?=
 =?us-ascii?Q?MmS64LEW2hFK1+tqBo71C1PjA0YMU5dzqse3Npbh3rUc0n1OXGT/MXr0kwYB?=
 =?us-ascii?Q?ThjiWe8ABXmI2/XUNJX/X5ttWGVBrV1ziRzMauzKPxq10wqHQVg62n6XlP6t?=
 =?us-ascii?Q?JgNjmlYoEPVqVBGncRR8QtfyZQxQ7z4lADiTN2U31VTwmEqa9zd4OyYJju14?=
 =?us-ascii?Q?l9PWJQruDXEHFtt+JR5taf0uumWkxloJSPxosKPFHsyxNTdiBlOak5dHvP8y?=
 =?us-ascii?Q?4rHPgxCX44c1XTj/95g8NT6S9af1iST5vGVj5tfz9KLuJ3/qlxHqeT8oM+1m?=
 =?us-ascii?Q?o3y+1t/uXiBRw6t9thMhfFPfDhQAfP4zlpLqOyjRAFQ3kAec6DFdb+zTwx8Z?=
 =?us-ascii?Q?WoKgmsP20aVnpc1Tqrb92mjW8EEJ8tKfWCS1NbwD7buXtG6sQ5wj6ORBR8MI?=
 =?us-ascii?Q?jiosDuI29kIsoHhr3u+zL61iUC4MCQEHJ6+05r/QBd7/SXPaOttd6WxqLWuT?=
 =?us-ascii?Q?a/QUQFTlrlu7FtCQhv5TAT7Edz47HKN5lUtLRiwhKirDdWfMTLJm6/TSUFMJ?=
 =?us-ascii?Q?arglwbB7bll81EK7oI8QXrwS+IR8gSSOOncBHnk16dTRCVsvQKbtHOV1Z3E8?=
 =?us-ascii?Q?Xb7jpZniRig6V8FGcfWVBSVY/LJTP1Srh1v1HGBiYznGUZ/WKfsuykIRl2W0?=
 =?us-ascii?Q?MQIBJYgRAbVb508t9Hj/Ynn0DOJjKVHgnUIWru+gVSJxBmQg5MrXInqLy9iP?=
 =?us-ascii?Q?3IYEuGFmMKejqLBsJ8EXMe3wlK9ANBYHtGgAlar6PlhMxiuO3RccHuWQbHHi?=
 =?us-ascii?Q?/KdlHj0h+qijDpi7WGFCgQY3l0Y/pc1okN6OTW4EFNc3hT5WzQCCe+xm/16O?=
 =?us-ascii?Q?SIMxhjBNBsakjCP09Zx9UuUcbVdSz6zylxBUPxN9W2l+Sz4ng0h8jjygyUZL?=
 =?us-ascii?Q?wUDmCX8U6Y0ErKtlYGkTgKFVPU7nKeVtQK47NRjZkZ7qjisjIqglKMY2ZZf8?=
 =?us-ascii?Q?KZXgVhbl3ZhLnA9ftlSrsGPtOx46wuQCVuCgub0+RLHg8NhIdNHdLzZWNcWO?=
 =?us-ascii?Q?a7tPAaZcOl7cSfcdMSzPlMnfbR0mWCZRgpgzRfijLZN+nOP1R0J6UKH9652E?=
 =?us-ascii?Q?yv96D2GEOLutkh134m9vNrNBpVxJbG/yy3/rPKBRLufqsKEuz8nayp/8ETb1?=
 =?us-ascii?Q?UcWGpEt6H69TI2yWG+oMtg3PCQ3/k1tNUInT3dIxcUY1HjbRSh6wnun6e8Ew?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f24e86-58a9-460f-663f-08dd4b1ffe1a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 04:44:53.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3oI6aDQHRBwPK9/1lL2hma1bRNNPY+873AxmsY8bQx2hf+/6pGGbFc/2zd68oEbDLvjX+U3M1zvVYsd4b3wIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6970
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.226.fail" on:

commit: 92a6e5b7138df60388f43065b22d0fd846ab8802 ("btrfs: always fallback to buffered write if the inode requires checksum")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master df5d6180169ae06a2eac57e33b077ad6f6252440]

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
| Closes: https://lore.kernel.org/oe-lkp/202502121035.e70df273-lkp@intel.com

2025-02-11 13:28:35 export TEST_DIR=/fs/sdb1
2025-02-11 13:28:35 export TEST_DEV=/dev/sdb1
2025-02-11 13:28:35 export FSTYP=btrfs
2025-02-11 13:28:35 export SCRATCH_MNT=/fs/scratch
2025-02-11 13:28:35 mkdir /fs/scratch -p
2025-02-11 13:28:35 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
2025-02-11 13:28:35 echo btrfs/226
2025-02-11 13:28:35 ./check btrfs/226
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.14.0-rc1-00040-g92a6e5b7138d #1 SMP PREEMPT_DYNAMIC Tue Feb 11 21:13:29 CST 2025
MKFS_OPTIONS  -- /dev/sdb2
MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch

btrfs/226       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/226.out.bad)
    --- tests/btrfs/226.out	2024-12-15 06:14:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/226.out.bad	2025-02-11 13:28:41.437083025 +0000
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
https://download.01.org/0day-ci/archive/20250212/202502121035.e70df273-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


