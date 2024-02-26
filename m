Return-Path: <linux-btrfs+bounces-2772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49601866DF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 10:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EC11F28920
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD50433B9;
	Mon, 26 Feb 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdXR6Zzl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460641E516
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936317; cv=fail; b=qLzyDVVpmjJut4Ye+PiPijxS3FaeOAu0e3heY4EPEWBuIKcJ0VUoMUgtFyM4sn53QCe+4k9HxzwP7dKR56tDx6WQQ+LgHeWRjPcbFw+H5RFescooCLKa3oke+jFfnFVeRn7caDH87Drtr7N+/vBA0ECAiy3DksGbCfL3fwODbYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936317; c=relaxed/simple;
	bh=xkPN6yI8UnG9GAkA2NRdQzIWo0vi8fWrSLGRU92MmkA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IfLM4fSSA54ARXYdWVRcJNabUlsGhSCjJ72k69wgBLo3pLjG8yDh+u0PjYP2k/yBXXlmnmPMA+DO4790sripUl+BVUUr3mVobMHoWlyIgZub44eOUsRZCdiPG6C+d9TKWIHkChTg44B7s1CnzdqtpSil6Ds6M3Az/gR1bMv+zBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdXR6Zzl; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708936315; x=1740472315;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=xkPN6yI8UnG9GAkA2NRdQzIWo0vi8fWrSLGRU92MmkA=;
  b=GdXR6ZzlLkw5A3yra4Uis4LjxOK6Oen2rEtU0DCdhCU7lKzed3adWOSB
   Q41wHPEQ7UTrSTZSXmnmSxTh9T9sMlDE9jBUkUWIfQ6SDFw0EWF5lfAL5
   VG3KHEl2Iw43HotEtQzjcGxsBpcXY5h5ggiOifJX0eizJDHXMlvL/BuUQ
   T7Qt9dKWFX3C8hNyopmsBbFgeYbmTtRUVxTz2vVPR4LYgZKAAsWl1V+gj
   my1jNaRfhNrfuTOPGEduqs+VJEiIJ6YVK8RYnpKQXSBSt7pyKg+DhQTFp
   iGk2UdqN6F76TDcW61VMNI1MWoeMLJ+qiysVDmDby919rK+EuC5HJNsU+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20751780"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="20751780"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6737378"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 00:31:53 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 00:31:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 00:31:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 00:31:51 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 00:31:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn0Hb3fpCI46Xj+qDo09DIQkX+vmoICCotMCMQVaMdb2fdUwqDcPju+ih0BfuIphgGpZXs85i/h7h9VCsIpTe0ARzFUT9JC6NwVh9n6R2we+Q8tywF812JMlUf6PlpD8jRW/SXeXtVidZzc0z+XEpNL9Zkvg6HQxq/5cYeRARAyJ2Fh/BYLh98JVSlxUAWXYjxZ2PXEXbojY01TgHvjRzLD+U9bpqIC27GibvB2tSch8oYCtIAPRWypx/oWEnskKXXjzl1rYZeknqDKNxoKYrB6cc0frCF+1LBYHu5wRYa1rNRmA+UvGfblCrzgKY8h6czEgHPfvb7VQpoK9+avX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c50PrSuE7CEBZ08AK8WrtQjP6fCbScvb1HFoqJGCXJk=;
 b=FO58IFIAgZ8r/sQjfnVQ6igmtHz0/A4tY+5Ovnvmq3LJULNKotaUf7iJO39Mbh0gtDUqZ6/GXVX/cQcuy4YtFB16g8TodMBa0YM8h1LfaB7rNZvERZ2d1LhnIZojY+F7RupMc0N97E6MZwNpC6I3zjl+V1uE4mKoxCKX1jfaYMRvpspFhWKa6LhYHBkOjELrVbAczL8iRCdR392gZM8U71ykf3dYBUbPt7wqgfTsnggB99sBrEKik12Pls7CiVPSWdzi8ssck8b2ThNQrAg2gQ5gIoc4kyHP0Pjjkfv05TBjCsZHfXaYxRRGGiq6pxPSD6lhJZCekX+wnwnifsdb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 26 Feb
 2024 08:31:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 08:31:42 +0000
Date: Mon, 26 Feb 2024 16:31:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Sterba <dsterba@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 08/10] btrfs: simplify conditions in
 btrfs_free_chunk_map()
Message-ID: <202402261652.bcd6d27d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd9ae501762221ffca5408ffb59f1a3b990de14e.1708339010.git.dsterba@suse.com>
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e7c397-9c96-4731-3ca2-08dc36a55beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0afoxEGqNiDfQc68AmkktgTqt/94DvVtd/u8Uubza+cOQbvJIjuzeeZk0epNIWuuDKDobjvqvS54p3Jdqn8TOrrorYwyy/lL3PKL0iy9c/obDUdFEz+DE6mBYyxpDulzAQnXtYu0TUNlSMuZkx7nfMZxjiPYjs5Z+dxBEpq7Fz063M+73GXfmEaEsAJTb/X90C26Wh8pdPXYEQDWpNi3AtJ+u6BGxJ6jNfeFZo9UD2x1JRVKEYQXRR1AInfVpjQeeBM71rYoHUqi9ytFkfX4LcCvpEGpRLCfm+a8bHmsK7R0N2V1+C5ipYsaQgR5LqiFxdU7HyM37X/4r1Ihgowhyzo74mSO5Msz39oYGy60ZfPMYw6//FRdfHa6zU9FJ6jE5aoyTFdaoBANlJ7094rd6yRGuvdVMszkBm35yV5kKN5XdMlTgQwjSKa0gifO0/0QtbJ1wJG9n2r7ewSXg6O+gvoB7Ojttl167HOJyz92yhywSHmM8oNht5JEX2AXNovaLI7rX7Niieqtji2zQCYc/0MKpa9IFF7Txey9/VCfAtr7jlxF/RN2hcxndyxWyv3YEAGt4S09vwr4V/FvpvgX1sPeX8DaEmkAsB4Hem48ROxvgSJWA1vEHLQ0vM3U0A4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/iQbMyfNi5hF6vymZb7OYy2pKrOhbYhm9m1K8FpGNO6GBz5wTVuqr7k5o4jd?=
 =?us-ascii?Q?j680cTzdGVnAHO/7FIEZq4p+IvmOWg6pJ976EPcMJvuGvyFnPp36S/+gRjaa?=
 =?us-ascii?Q?/dbCjFlT1N91boKCQniiiAVr28snSyofMoobjPUdfEVAZ/nhEnlen3oTSNcc?=
 =?us-ascii?Q?YIdOXTtdbBYfFNZNE6YnjJEicVcAaE6MAs/PEJJSxcbbhoNMHXjq4s7QlTpp?=
 =?us-ascii?Q?bqAgY4F48nXuLz1FFtA96V/rIUPGfW6isF7wKEvsMJWxHIJmXeZAUBJtyy+D?=
 =?us-ascii?Q?aZsC7Z0Ak12Yiy1RDcH4BpRqzI5O2XDMWtxrBnmnjjhFqV7fyCiU1GqYcemn?=
 =?us-ascii?Q?kjoui8pLzpNoAWOK+tke008UBCWAD9LdIq9wsqchtXNWNNxNR1d1Ap/5m+eP?=
 =?us-ascii?Q?XH4HJ+8HqR5y0LYL+TAxXQZT/WFwX03g6DtkmNwm5iZyEfL7SQApKc4EL+Fc?=
 =?us-ascii?Q?dhVm93hNu0tDD0dzDytM+tivOaOBuncJKXHZdy6DByQTbllJVskTsIOPde6l?=
 =?us-ascii?Q?DSqhNspYF3/oEvwRpQsSFzx2B1YYIYBh5xdkSXuFikrOlFmONKPogkR+Dndf?=
 =?us-ascii?Q?5tjhXMqc0F2OMMpzSQxXc8kiR5BXvmAaSs+XGrFBx4eL69g5L/FBvrT3fSmh?=
 =?us-ascii?Q?ET8WUIjRI8UL7LsUFZts+Fr8mYJWeGH5kVcgkgeEmIIR4gbm1zaEwTWRq4gl?=
 =?us-ascii?Q?/O+dB+mh1YvsY1CaFgXyt9hnaU3Sb6Dpf/AuThz1Yj/GPeqdSWazPqa5AAOl?=
 =?us-ascii?Q?9QJFuyAGmlki4waV08qxYQ+sPRm9wl8l2sCp9zdYcL3Z2knXJu9xBJycIQFC?=
 =?us-ascii?Q?FVw83TsrIu7C7vg7gEEYOJwiXzardl8+zWf9dn/WCfFllj5FxEkMyfZrQgl4?=
 =?us-ascii?Q?rEBrtNUuiO/V/5JASwZK5t8aguXwxbx9k18sXWyQr4awIDNUSs/Gzm9yb3Vf?=
 =?us-ascii?Q?6EExbC9tySTU4nRkZG6ivz9dezHKMJyG1eGMBu4XOZDrlu6Kt/mg2hD76fre?=
 =?us-ascii?Q?T9qoxFblI8CdsUshfWHRb+ThX3fFvj/bbQQy3+49xXnGka9X2NMaQIXhndET?=
 =?us-ascii?Q?i4j2ZzQNEKFcsYSiUQ6B8WR5b/isA/WvCZji0Sx1sPjc99HBq34PsQv32sR/?=
 =?us-ascii?Q?TQAyNoiA1xMVs8tzrr0S/eiuBPGNfJqpYs72DXhFsXZtWZXYFdBrlwT7TefV?=
 =?us-ascii?Q?T6o8fvNlW49r20r+2sAFD8d5a3UZBBmjXg1F7jDbV+0NtuNCkSiuKTDQkaI2?=
 =?us-ascii?Q?ThL7RTm0dhCUu9liBUzK67hb4LM4HzLiMji1tzvaEFkv5qv1nzBzJjANOFcM?=
 =?us-ascii?Q?fZzlBAgoZXeSe5/QUntXkN7EvuDkvVpKNF/gk86b9WNDq6QcMC9SePO+K4wL?=
 =?us-ascii?Q?socgXxZXSddS12QpXz75EoO+hs0aLGjokfxpm3W53CR+Goa+wm6WlT03O9B3?=
 =?us-ascii?Q?YBPAusfypoeua3Q9J8/Wc2Nh3/Gdlwqzsh1J5hid+sBOGab9XSYO7Q9pUmof?=
 =?us-ascii?Q?oxUNFxWfSfQvfIdvlPJTaEFXvQKMJ+x5gl3gw0Y1WeBRhi9k99xwOq6YMqbx?=
 =?us-ascii?Q?aXBj3IVudMwvOc49/ibTwpmxZ4rSXhBgsNuCTS0CXjQOjz4k88Zu03n81elG?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e7c397-9c96-4731-3ca2-08dc36a55beb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 08:31:42.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogRSQiSU6JtswY6x++v4lxYhnGPj6pISWwjQpe4WRWJQjaYmwt5+fk4qAjSQoVIsnJsOoJhOKii5DxVEoMtuUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "dmesg.BUG:KASAN:null-ptr-deref_in_btrfs_put_block_group" on:

commit: 1511810d056bc04fc0aed7a2b20d09b170da3e86 ("[PATCH 08/10] btrfs: simplify conditions in btrfs_free_chunk_map()")
url: https://github.com/intel-lab-lkp/linux/commits/David-Sterba/btrfs-move-balance-args-conversion-helpers-to-volumes-c/20240219-191714
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/cd9ae501762221ffca5408ffb59f1a3b990de14e.1708339010.git.dsterba@suse.com/
patch subject: [PATCH 08/10] btrfs: simplify conditions in btrfs_free_chunk_map()

in testcase: xfstests
version: xfstests-x86_64-c46ca4d1-1_20240205
with following parameters:

	disk: 4HDD
	fs: btrfs
	test: generic-group-34



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402261652.bcd6d27d-lkp@intel.com



[   55.292606][ T1454] BTRFS info (device sda1): last unmount of filesystem b71ba2d6-b44f-48b2-b855-8d320c026d64
[   55.376758][ T1454] ==================================================================
[   55.384644][ T1454] BUG: KASAN: null-ptr-deref in btrfs_put_block_group+0x15a/0x2c0 [btrfs]
[   55.393037][ T1454] Write of size 4 at addr 000000000000001c by task umount/1454
[   55.400400][ T1454] 
[   55.402575][ T1454] CPU: 1 PID: 1454 Comm: umount Tainted: G S        I        6.8.0-rc4-00127-g1511810d056b #1
[   55.412614][ T1454] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[   55.420665][ T1454] Call Trace:
[   55.423806][ T1454]  <TASK>
[   55.426586][ T1454]  dump_stack_lvl+0x36/0x50
[   55.430927][ T1454]  kasan_report+0xc7/0x100
[   55.435178][ T1454]  ? btrfs_put_block_group+0x15a/0x2c0 [btrfs]
[   55.441237][ T1454]  kasan_check_range+0xfc/0x1a0
[   55.445928][ T1454]  btrfs_put_block_group+0x15a/0x2c0 [btrfs]
[   55.451831][ T1454]  btrfs_free_block_groups+0x7fd/0x10f0 [btrfs]
[   55.457992][ T1454]  ? free_root_pointers+0x759/0xa10 [btrfs]
[   55.463785][ T1454]  close_ctree+0x87c/0xcf0 [btrfs]
[   55.468842][ T1454]  ? _btrfs_printk+0x1e8/0x430 [btrfs]
[   55.474214][ T1454]  ? preempt_notifier_dec+0x20/0x20
[   55.479245][ T1454]  ? btrfs_cleanup_transaction+0xae0/0xae0 [btrfs]
[   55.486236][ T1454]  ? fsnotify_sb_delete+0x2ab/0x420
[   55.491265][ T1454]  ? fsnotify+0x14d0/0x1550
[   55.495604][ T1454]  ? dispose_list+0x1b0/0x1b0
[   55.500118][ T1454]  generic_shutdown_super+0x13f/0x370
[   55.505320][ T1454]  kill_anon_super+0x3a/0x90
[   55.509745][ T1454]  btrfs_kill_super+0x3b/0x50 [btrfs]
[   55.515033][ T1454]  deactivate_locked_super+0xa2/0x190
[   55.520235][ T1454]  cleanup_mnt+0x1e5/0x3f0
[   55.524487][ T1454]  task_work_run+0x119/0x200
[   55.528911][ T1454]  ? task_work_cancel+0x20/0x20
[   55.533592][ T1454]  ? __x64_sys_umount+0x119/0x140
[   55.538447][ T1454]  ? __ia32_sys_oldumount+0xf0/0xf0
[   55.543475][ T1454]  syscall_exit_to_user_mode+0x1fa/0x200
[   55.548936][ T1454]  do_syscall_64+0x6f/0x170
[   55.553272][ T1454]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   55.558994][ T1454] RIP: 0033:0x7fcb7e405a67
[   55.563244][ T1454] Code: 24 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f9 23 0d 00 f7 d8 64 89 01 48
[   55.582617][ T1454] RSP: 002b:00007ffd2ff1b1d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   55.590846][ T1454] RAX: 0000000000000000 RBX: 00007fcb7e53a264 RCX: 00007fcb7e405a67
[   55.598639][ T1454] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000564579779b90
[   55.606431][ T1454] RBP: 0000564579779960 R08: 0000000000000000 R09: 00007ffd2ff19f80
[   55.614225][ T1454] R10: 00007fcb7e498fc0 R11: 0000000000000246 R12: 0000000000000000
[   55.622019][ T1454] R13: 0000564579779b90 R14: 0000564579779a70 R15: 0000000000000000
[   55.629829][ T1454]  </TASK>
[   55.632697][ T1454] ==================================================================
[   55.640659][ T1454] Disabling lock debugging due to kernel taint
[   55.646643][ T1454] BUG: kernel NULL pointer dereference, address: 000000000000001c
[   55.654266][ T1454] #PF: supervisor write access in kernel mode
[   55.660162][ T1454] #PF: error_code(0x0002) - not-present page
[   55.665971][ T1454] PGD 0 P4D 0 
[   55.669189][ T1454] Oops: 0002 [#1] PREEMPT SMP KASAN PTI
[   55.674565][ T1454] CPU: 1 PID: 1454 Comm: umount Tainted: G S  B     I        6.8.0-rc4-00127-g1511810d056b #1
[   55.684619][ T1454] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[   55.692684][ T1454] RIP: 0010:btrfs_put_block_group+0x15f/0x2c0 [btrfs]
[   55.699363][ T1454] Code: c1 ea 03 80 3c 02 00 0f 85 31 01 00 00 48 8b ab 28 02 00 00 be 04 00 00 00 4c 8d 65 1c 4c 89 e7 e8 86 cc e6 bf b8 ff ff ff ff <f0> 0f c1 45 1c 83 f8 01 74 7e 85 c0 0f 8e 9b 00 00 00 48 89 df 5b
[   55.718754][ T1454] RSP: 0018:ffffc90001317b78 EFLAGS: 00010246
[   55.724647][ T1454] RAX: 00000000ffffffff RBX: ffff8881eae12000 RCX: 0000000000000001
[   55.732455][ T1454] RDX: fffffbfff0c59f01 RSI: 0000000000000008 RDI: ffffffff862cf800
[   55.740260][ T1454] RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff0c59f00
[   55.748054][ T1454] R10: ffffffff862cf807 R11: 0000000000000001 R12: 000000000000001c
[   55.755848][ T1454] R13: ffff88818c5da090 R14: ffff8881eae12100 R15: ffff8881eae120d8
[   55.763642][ T1454] FS:  00007fcb7e1c8840(0000) GS:ffff8887ee280000(0000) knlGS:0000000000000000
[   55.772406][ T1454] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.778826][ T1454] CR2: 000000000000001c CR3: 00000001e5a68006 CR4: 00000000003706f0
[   55.786620][ T1454] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.794416][ T1454] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   55.802223][ T1454] Call Trace:
[   55.805352][ T1454]  <TASK>
[   55.808132][ T1454]  ? __die+0x23/0x70
[   55.811871][ T1454]  ? page_fault_oops+0x136/0x240
[   55.816655][ T1454]  ? show_fault_oops+0x780/0x780
[   55.821426][ T1454]  ? exc_page_fault+0x5c/0xc0
[   55.825938][ T1454]  ? asm_exc_page_fault+0x26/0x30
[   55.830797][ T1454]  ? btrfs_put_block_group+0x15f/0x2c0 [btrfs]
[   55.836867][ T1454]  ? btrfs_put_block_group+0x15a/0x2c0 [btrfs]
[   55.842937][ T1454]  btrfs_free_block_groups+0x7fd/0x10f0 [btrfs]
[   55.849077][ T1454]  ? free_root_pointers+0x759/0xa10 [btrfs]
[   55.854884][ T1454]  close_ctree+0x87c/0xcf0 [btrfs]
[   55.859891][ T1454]  ? _btrfs_printk+0x1e8/0x430 [btrfs]
[   55.865252][ T1454]  ? preempt_notifier_dec+0x20/0x20
[   55.870283][ T1454]  ? btrfs_cleanup_transaction+0xae0/0xae0 [btrfs]
[   55.877277][ T1454]  ? fsnotify_sb_delete+0x2ab/0x420
[   55.882308][ T1454]  ? fsnotify+0x14d0/0x1550
[   55.886645][ T1454]  ? dispose_list+0x1b0/0x1b0
[   55.891156][ T1454]  generic_shutdown_super+0x13f/0x370
[   55.896358][ T1454]  kill_anon_super+0x3a/0x90
[   55.900785][ T1454]  btrfs_kill_super+0x3b/0x50 [btrfs]
[   55.906047][ T1454]  deactivate_locked_super+0xa2/0x190
[   55.911249][ T1454]  cleanup_mnt+0x1e5/0x3f0
[   55.915516][ T1454]  task_work_run+0x119/0x200
[   55.919957][ T1454]  ? task_work_cancel+0x20/0x20
[   55.924651][ T1454]  ? __x64_sys_umount+0x119/0x140
[   55.929522][ T1454]  ? __ia32_sys_oldumount+0xf0/0xf0
[   55.934575][ T1454]  syscall_exit_to_user_mode+0x1fa/0x200
[   55.940044][ T1454]  do_syscall_64+0x6f/0x170
[   55.944391][ T1454]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   55.950115][ T1454] RIP: 0033:0x7fcb7e405a67
[   55.954369][ T1454] Code: 24 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f9 23 0d 00 f7 d8 64 89 01 48
[   55.973758][ T1454] RSP: 002b:00007ffd2ff1b1d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   55.981985][ T1454] RAX: 0000000000000000 RBX: 00007fcb7e53a264 RCX: 00007fcb7e405a67
[   55.989779][ T1454] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000564579779b90
[   55.997574][ T1454] RBP: 0000564579779960 R08: 0000000000000000 R09: 00007ffd2ff19f80
[   56.005367][ T1454] R10: 00007fcb7e498fc0 R11: 0000000000000246 R12: 0000000000000000
[   56.013160][ T1454] R13: 0000564579779b90 R14: 0000564579779a70 R15: 0000000000000000
[   56.020959][ T1454]  </TASK>
[   56.023826][ T1454] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress intel_rapl_msr libcrc32c intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic kvm crc64_rocksoft crc64 irqbypass crct10dif_pclmul sg crc32_pclmul crc32c_intel ipmi_devintf ipmi_msghandler ghash_clmulni_intel sha512_ssse3 i915 mei_wdt rapl ahci wmi_bmof intel_cstate drm_buddy intel_gtt drm_display_helper libahci intel_uncore ttm libata mei_me mei drm_kms_helper intel_pch_thermal video acpi_pad wmi drm fuse ip_tables
[   56.073766][ T1454] CR2: 000000000000001c
[   56.077761][ T1454] ---[ end trace 0000000000000000 ]---
[   56.083048][ T1454] RIP: 0010:btrfs_put_block_group+0x15f/0x2c0 [btrfs]
[   56.089714][ T1454] Code: c1 ea 03 80 3c 02 00 0f 85 31 01 00 00 48 8b ab 28 02 00 00 be 04 00 00 00 4c 8d 65 1c 4c 89 e7 e8 86 cc e6 bf b8 ff ff ff ff <f0> 0f c1 45 1c 83 f8 01 74 7e 85 c0 0f 8e 9b 00 00 00 48 89 df 5b
[   56.109089][ T1454] RSP: 0018:ffffc90001317b78 EFLAGS: 00010246
[   56.114983][ T1454] RAX: 00000000ffffffff RBX: ffff8881eae12000 RCX: 0000000000000001
[   56.122778][ T1454] RDX: fffffbfff0c59f01 RSI: 0000000000000008 RDI: ffffffff862cf800
[   56.130571][ T1454] RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff0c59f00
[   56.138364][ T1454] R10: ffffffff862cf807 R11: 0000000000000001 R12: 000000000000001c
[   56.146158][ T1454] R13: ffff88818c5da090 R14: ffff8881eae12100 R15: ffff8881eae120d8
[   56.153955][ T1454] FS:  00007fcb7e1c8840(0000) GS:ffff8887ee280000(0000) knlGS:0000000000000000
[   56.162715][ T1454] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.169149][ T1454] CR2: 000000000000001c CR3: 00000001e5a68006 CR4: 00000000003706f0
[   56.175890][  T271] result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/xfstests/4HDD-btrfs-generic-group-34/lkp-skl-d02/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/1511810d056bc04fc0aed7a2b20d09b170da3e86/3, TMP_RESULT_ROOT: /tmp/lkp/result
[   56.176952][ T1454] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   56.176953][ T1454] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   56.176955][ T1454] Kernel panic - not syncing: Fatal exception
[   56.204637][ T1454] Kernel Offset: disabled


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240226/202402261652.bcd6d27d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


