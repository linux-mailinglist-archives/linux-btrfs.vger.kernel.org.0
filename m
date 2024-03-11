Return-Path: <linux-btrfs+bounces-3175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75843878056
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E721F221E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3393DBA8;
	Mon, 11 Mar 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TU7wTQew"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6C38394;
	Mon, 11 Mar 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162806; cv=fail; b=mWDvKhyG4ZGZ2hrtlmEtD5vKHVyprzS7/7bUpoS/unVlMmbsr/l8owt1Ewf8FvguUGavointigwvzlKAGxJz835eMTqdEc6R2wigCdWrwBALEwrcS1vKy0E4UIGTHd1oQXUrgI57TL2mEsHoExuQMQmdguulbrY828s/3fCTWZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162806; c=relaxed/simple;
	bh=QI+S7SSaEsOSSe48HwUgXAt3AQWamm952cGeuZf2f78=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=F3WD65R4nmfdHAMn05bqi/gH6ukbx9GaJWiHsAcizVDDzwZykWT2rVdbunId93cdfw+/bR3HMpyDf2A7dVYJpjd3jQpJ8xrPDPes0BWQvkFq1QywOYySiGec6aHhrj4JDEF29V5bzdfh1Fs8+ZEzc1BDGXGAqy1N7ubDtfPCaaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TU7wTQew; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710162803; x=1741698803;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=QI+S7SSaEsOSSe48HwUgXAt3AQWamm952cGeuZf2f78=;
  b=TU7wTQewPvUWCybBopXyZn0Gnjp2ZmWFUS1OwBwG1GAV3XqKAHqImPHz
   Pai/2tTlKwmWZXjmHLtVIPcRU32CAovkooZVltnX1VR/hMpr4RKKUIzLC
   FItapjh9OJ6S0M7ELuCeKbOLrZGtmFt1JuNcvMC2eIRsj03g1iDKl+aHH
   EHlZ5N2tQZKyuZbuT57cGSQBYL4Ida1p1F0F2LajkIBj7/UxA76/oLf6R
   kWyQ6ujTdyM3Cbb/N361Gb3iuu95u2jm27zbkZF4aoFvf3QXcRqfYTDjg
   +4p3kes0d2vxKHoCi5TTZ2G6hHMSLUV+WFPaE8nRqZV7qt0RfBPlTYt8b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8580193"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8580193"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11255316"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 06:13:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 06:13:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 06:13:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 06:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFQaZUz4VLWLZNVDQtjK2CmSeVh1bucFolExUVzqCnp0J4iC2PdpXj+wAR9de38kD5Agci+JA8AyNVKA6s99tpS+ATcUONxhdINq9ofsholAHszzoJm4nOjoa1E9xTWslWIuLyjyLKzwwrZDZc8Y/CDlXAvazzcQz6YxVzHsCqn0UY2ctWZtt741ny55prslkIxGhpj+6e7i3VDzb35STByh4OO4RCgwBkcg/PegEC0L7QAoRoVRGre+FNMcpQQKhi5F/h+LUefYmRJEsnOej8Ra7YNBu5+qgontnWhN56o8lKZEobxyllVk0L5XqiggjyX0NjrQxLuzoKYwLZgdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgigj4F6MdR0FSG92PzhsEXA5jjknMHiQgdRamnE/LA=;
 b=buHb6jSw0a3QzGbvY416d5TP/bjUsgxYJK0LxsBoQdLxYmAX4CUZReIi0a/XSAuJNdW4Ffy+As3YQxfUf3DuFyxov+Kzu2u1IWLDFyQC1uTo4giXumVZLDgfJEva5IoVKeB9nX1GqxNsZP2l7o0smH2m1cep6RMcxXBCb+Tnvf2sWlRAdmdD6mjwFr1EgHfmyNy8h7RxWTdqag9+gbAR88sGtIdzCXHHhdXO3C5e9RzY3Fspetav58/lSJqvluaW7SNOJiYrAUxltortorICm+i1pHissC6+0MG0K28UlfoJSPdkAZPq1lYsToW2RBueJrq0JRvpEQN45SMeVlL3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 13:13:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7362.019; Mon, 11 Mar 2024
 13:13:05 +0000
Date: Mon, 11 Mar 2024 21:12:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Filipe Manana <fdmanana@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  e06cc89475:  aim7.jobs-per-min -12.9%
 regression
Message-ID: <202403112002.cc4b1158-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3977de-1549-453f-5877-08dc41ccfd13
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DtjEUbq14o6zieWRHmY9FsI0OZ7v3d4E/TE+CblcWfIY4LxXFvnvRi5f6URlM88nQOWVuMU3kCILIObrka+40rdhGkUg4Y1FowaqHS+GBlsCa2TzjVhs0LSsrwu27tml4ZFZ9ycp7MSRX0i9cDfDW3AZ+4QB/t68lnVCe57mugBkQnYfcjwZQjtCMUTXiHSuladK2Wp/+AxsnkVUBq2grnTpUtIILFsYN/Tme1eRFmV5N0vlEXDfLTBe+JMylO48yUJj3kHIv9YvOwmqaKc1RBNo/VXDiv7hXEebgfa0ygZO181dhil7ut51pWC3uOftWG1kc4Gty80i+1P1LzHvS3CPn3WbnKXto1ViuWe4LrZPWwCm/VGQxINub5CL36PW2U92qr8noPw1b5ob/zBTrxRfVjaVz6B4bSk5xfCJvv8HydvqzzcivYWo/AZ0W54ejG3m7HAReDd+MaI56dgMPxa9PqPA5jhPrJ3QbdEL4s8qruTiRWfX25/PcmmX8REwj7A+/wCbYfmHoYkJHh/7DGXFxNDBj2Od5aCvvLS1ohrucsjZzkDwkN+OHcHoebsasnlQ1AdD5NmmlUfgFuELIEcXZGW1NjjnPaaxSgLrr6rCiEgCdGq6NsGmUtvQOCn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YhftwKN0kHVzXHlGL1Lm8xge+2Lv32+8DxWB5ATi8DDQ25K7OROmLIrzgz?=
 =?iso-8859-1?Q?W81+tRMQ5Ris5YlTA7QlHw3yFRPCzq6IaHfMOb7Qfuwl7xwwnnukBVisD0?=
 =?iso-8859-1?Q?urhWs2UFL8whSeX7OYKzv/PHZe/sXGv4OkQlVHC7Prlr8NvKvWrJXmQILi?=
 =?iso-8859-1?Q?k07zFTY4EnOj2gjpfHfZgZXbyfS50MhWVZdr/01ThenxMq7aXsl/MeEFom?=
 =?iso-8859-1?Q?ak/i996daNUPRMEcbfG/2X2TTVpNAee1uh03xIWbe65/sEyCkAse290Uo7?=
 =?iso-8859-1?Q?MxHi+wzynaEUnfDFEelIUEgnZlo4S3BM6KIH9Sh+zsenejZmbe3udcNzz6?=
 =?iso-8859-1?Q?DN6A7/m3qK8fW7KVr76GLIp2SleP1lzo0M4So/M/eLVNd8Zh0kI12Fd8Xn?=
 =?iso-8859-1?Q?XRCg9nslMHN2lnR38FOzo0nm0oP1Kzgs/gAasIXtr8Z3zmqDvRG87YNHZ9?=
 =?iso-8859-1?Q?qkkuI/WQZWEXJsADurlSJRvzwaK8oO93EJE1Kqat962HGNrq0UuwXgirBj?=
 =?iso-8859-1?Q?ISVmyK7e+JF6K/WzaCiDfAIB/vIwVW1qKy+FtVj9jcNeEFOKy6fj/3/fkB?=
 =?iso-8859-1?Q?WVh4pkc+hxnSikY/UHWIwhxckYs0ir+T/TwoDCS261VsQ96WDC8l77iOyw?=
 =?iso-8859-1?Q?OyZGpQAou8j/2Dec6tImLMdYbO14mCUDEyhhdVm0/sDbb7b5QQoNfIN+3J?=
 =?iso-8859-1?Q?HyiOQquNtwnrmp64X7UpOeHhfmH5SRefXy3M2Xw67IiQDz7LKOlGKFO8B3?=
 =?iso-8859-1?Q?C3gfLQHvp2Ie6S5XOOpCG5pCO98yPlzNVFCtpDiJtGBa5njIPNfXGvaUvr?=
 =?iso-8859-1?Q?MDx6jkKGA9fsYp0EhOni60R4F+ff8S/nzqfth8ZTn/L1ZWDLuqditHAM3y?=
 =?iso-8859-1?Q?fiRnTsKB+c7zDFnTxiniqnClzUxrstiAQLs/ofHZIPzjA/XFrjxlF2xFZB?=
 =?iso-8859-1?Q?dF2S3aPRU8DlvvcUVCLa6bPRleX4m4ULsAAIpb0fX7iaCSyD1c87sVUyGw?=
 =?iso-8859-1?Q?NIGjdA/VwTssHfEwioFnfCdrIUHumszzbFx78vQW5QBSoE4oCa+UnBYYLe?=
 =?iso-8859-1?Q?ukhhRfvdaNgJTtR6RBa2Ldhpnm6x/Rv3Oj23OdPpEnpCAY47pJzRQzyd3g?=
 =?iso-8859-1?Q?Q0GM0yg4Kbzt4nxjbHeKmXLHU0FqXvaCtaxH2Aq+dpMkDbbhGcqeNDdHAb?=
 =?iso-8859-1?Q?tRYf9r0ZAShckFQwNh4rIzLM6Sw32d7hTME7w2TbpEIADMn1sd3J+tihw3?=
 =?iso-8859-1?Q?kS4h59ie0rRVBIxTGVc+goM9IA07EorFNvy/zrfHAWp65wYPQrcby4XQNi?=
 =?iso-8859-1?Q?SJr+/DHmMckpVUDDhruFeMhcJRUogdeQ4neymd3qoaxLPejwJhz+wnhwQU?=
 =?iso-8859-1?Q?MreYf5e/1REaIrp9HRcsbpy70y3IEdGI69sPRcnP49JUL4EGWxm3bT97aD?=
 =?iso-8859-1?Q?2e+Mpt7hi7bH88TG1597v5G6oQFGhhrSvax6UNaorBTNFsj9Nh4sZo/S6X?=
 =?iso-8859-1?Q?7ITJrxyMjAYROe4oNVv5U246LiYmWYy1L8DUoWwWb4sbAkin3ZopB4DSGF?=
 =?iso-8859-1?Q?wzbJr/qGgOoVwq8g7vFWdtAzBSUQ/ejXMNktKB6f4Q3GDaHUGyCU3dQZcF?=
 =?iso-8859-1?Q?0ZMdlkVDugvHlRLpz7N6TsmzWZRftbit7O9gUlRxo63C/R8VwkhG50kA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3977de-1549-453f-5877-08dc41ccfd13
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 13:13:05.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRsQqiB9NpVOlnfiqf9s7xuBzxKhlm6ftFHrR9potodVoiWsJbYamGqVpIFiMBHLNiKcmCh2xXpfgZX8Acsv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -12.9% regression of aim7.jobs-per-min on:


commit: e06cc89475eddc1f3a7a4d471524256152c68166 ("btrfs: fix data races when accessing the reserved amount of block reserves")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 09e5c48fea173b72f1c763776136eeb379b1bc47]


testcase: aim7
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
| Closes: https://lore.kernel.org/oe-lkp/202403112002.cc4b1158-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240311/202403112002.cc4b1158-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/btrfs/x86_64-rhel-8.3/1500/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/disk_cp/aim7

commit: 
  5897710b28 ("btrfs: send: don't issue unnecessary zero writes for trailing hole")
  e06cc89475 ("btrfs: fix data races when accessing the reserved amount of block reserves")

5897710b28cabab0 e06cc89475eddc1f3a7a4d47152 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     13.71            -6.3%      12.84        iostat.cpu.idle
     86109 ±  5%     -10.3%      77204 ±  2%  meminfo.Mapped
      0.29 ±  2%      -0.0        0.25 ±  2%  mpstat.cpu.all.usr%
    249.60           +12.6%     280.99 ±  2%  uptime.boot
    148704 ±  3%     +11.9%     166363 ±  3%  numa-vmstat.node0.nr_written
    148026 ±  4%     +10.5%     163536 ±  3%  numa-vmstat.node1.nr_written
     83929            -8.8%      76554        vmstat.system.cs
    202906            -4.6%     193642        vmstat.system.in
     21940 ±  5%     -10.2%      19706 ±  2%  proc-vmstat.nr_mapped
    296731 ±  4%     +11.2%     329900 ±  3%  proc-vmstat.nr_written
    971976            +6.8%    1037759        proc-vmstat.pgfault
   1190113 ±  4%     +11.2%    1323358 ±  3%  proc-vmstat.pgpgout
     61472 ±  3%      +9.8%      67507 ±  3%  proc-vmstat.pgreuse
     45149           -12.9%      39308 ±  2%  aim7.jobs-per-min
    199.49           +14.9%     229.19 ±  2%  aim7.time.elapsed_time
    199.49           +14.9%     229.19 ±  2%  aim7.time.elapsed_time.max
    106461 ±  3%     +20.1%     127873 ±  2%  aim7.time.involuntary_context_switches
    153317            +4.7%     160598        aim7.time.minor_page_faults
     22001           +16.1%      25542 ±  2%  aim7.time.system_time
   8341344            +4.7%    8730263        aim7.time.voluntary_context_switches
      1.52           +10.0%       1.67        perf-stat.i.MPKI
 7.428e+09            -2.7%  7.229e+09        perf-stat.i.branch-instructions
      0.62 ±  2%      -0.1        0.56        perf-stat.i.branch-miss-rate%
  27712058           -10.6%   24784125 ±  2%  perf-stat.i.branch-misses
     24.15            +1.3       25.40        perf-stat.i.cache-miss-rate%
  51305985            +5.9%   54318013        perf-stat.i.cache-misses
     84790            -8.9%      77275        perf-stat.i.context-switches
      8.56            +5.1%       9.00        perf-stat.i.cpi
      3464            -3.4%       3346        perf-stat.i.cpu-migrations
      5494            -4.1%       5271        perf-stat.i.cycles-between-cache-misses
 3.253e+10            -3.4%  3.141e+10        perf-stat.i.instructions
      0.18            -7.5%       0.17        perf-stat.i.ipc
      4301 ±  3%      -6.5%       4022 ±  2%  perf-stat.i.minor-faults
      4303 ±  3%      -6.5%       4024 ±  2%  perf-stat.i.page-faults
      1.58            +9.6%       1.73        perf-stat.overall.MPKI
      0.37            -0.0        0.34        perf-stat.overall.branch-miss-rate%
     24.56            +1.3       25.83        perf-stat.overall.cache-miss-rate%
      8.90            +4.6%       9.31        perf-stat.overall.cpi
      5642            -4.5%       5386        perf-stat.overall.cycles-between-cache-misses
      0.11            -4.4%       0.11        perf-stat.overall.ipc
 7.412e+09            -2.6%  7.216e+09        perf-stat.ps.branch-instructions
  27605707 ±  2%     -10.4%   24743238        perf-stat.ps.branch-misses
  51201807            +5.9%   54221492        perf-stat.ps.cache-misses
     84459            -8.8%      77008        perf-stat.ps.context-switches
 2.889e+11            +1.1%   2.92e+11        perf-stat.ps.cpu-cycles
      3468            -3.4%       3349        perf-stat.ps.cpu-migrations
 3.246e+10            -3.4%  3.135e+10        perf-stat.ps.instructions
      4534            -6.7%       4228        perf-stat.ps.minor-faults
      4537            -6.8%       4230        perf-stat.ps.page-faults
 6.503e+12           +11.0%  7.221e+12        perf-stat.total.instructions
     33.78            -0.2       33.57        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_do_write_iter
     33.84            -0.2       33.66        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     33.84            -0.2       33.66        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
     33.66            -0.2       33.49        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
      1.00 ±  4%      -0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.94 ±  4%      -0.1        0.83 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write.btrfs_do_write_iter
      0.77 ±  4%      -0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages
      0.77 ±  4%      -0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write
      0.57            -0.1        0.52 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc
     27.57            +0.1       27.71        perf-profile.calltrace.cycles-pp.btrfs_dirty_pages.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
     98.02            +0.2       98.16        perf-profile.calltrace.cycles-pp.write
     97.96            +0.2       98.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.96            +0.2       98.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     97.92            +0.2       98.08        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.82            +0.2       97.98        perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
     97.90            +0.2       98.07        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.85            +0.2       98.02        perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.80            +0.3       35.06        perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
     34.69            +0.3       34.96        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
     26.02            +0.3       26.31        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit
     26.39            +0.3       26.68        perf-profile.calltrace.cycles-pp.__clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     26.34            +0.3       26.63        perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_do_write_iter
     35.09            +0.3       35.38        perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter
     35.09            +0.3       35.38        perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     26.33            +0.3       26.63        perf-profile.calltrace.cycles-pp.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write
     26.07            +0.3       26.37        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit
     26.08            +0.3       26.38        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.btrfs_dirty_pages
     35.18            +0.3       35.50        perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
     25.94            +0.3       26.26        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent
      1.01 ±  4%      -0.1        0.88 ±  2%  perf-profile.children.cycles-pp.btrfs_set_extent_delalloc
      0.94 ±  4%      -0.1        0.83 ±  2%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.83 ±  4%      -0.1        0.74 ±  2%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.77 ±  4%      -0.1        0.68 ±  2%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      0.36 ±  3%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.read
      0.58            -0.1        0.52 ±  3%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.56            -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      0.56            -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.down_read
      0.54            -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.11 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.calc_available_free_space
      0.28 ±  4%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.ksys_read
      0.36 ±  2%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.prepare_pages
      0.26 ±  4%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.vfs_read
      0.45 ±  2%      -0.0        0.42        perf-profile.children.cycles-pp.__schedule
      0.43 ±  2%      -0.0        0.40        perf-profile.children.cycles-pp.schedule
      0.23 ±  3%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__set_extent_bit
      0.14 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.btrfs_space_info_update_bytes_may_use
      0.42 ±  2%      -0.0        0.40        perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.19            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.pagecache_get_page
      0.36 ±  2%      -0.0        0.34        perf-profile.children.cycles-pp.load_balance
      0.19 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.37 ±  2%      -0.0        0.35        perf-profile.children.cycles-pp.newidle_balance
      0.31 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.cpu_startup_entry
      0.31 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.do_idle
      0.31 ±  3%      -0.0        0.29        perf-profile.children.cycles-pp.find_busiest_group
      0.31 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.38 ±  2%      -0.0        0.35        perf-profile.children.cycles-pp.pick_next_task_fair
      0.30            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.start_secondary
      0.29 ±  3%      -0.0        0.27        perf-profile.children.cycles-pp.update_sg_lb_stats
      0.35            -0.0        0.33        perf-profile.children.cycles-pp.__close
      0.27 ±  2%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.btrfs_evict_inode
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.btrfs_read_folio
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.evict
      0.15 ±  2%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.prepare_uptodate_page
      0.35            -0.0        0.33        perf-profile.children.cycles-pp.__x64_sys_close
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.34            -0.0        0.33        perf-profile.children.cycles-pp.__dentry_kill
      0.35            -0.0        0.33        perf-profile.children.cycles-pp.__fput
      0.34            -0.0        0.33        perf-profile.children.cycles-pp.dentry_kill
      0.35            -0.0        0.33        perf-profile.children.cycles-pp.dput
      0.31            -0.0        0.29        perf-profile.children.cycles-pp.update_sd_lb_stats
      0.20            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.alloc_extent_state
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.15 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.set_extent_bit
      0.21            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      0.21            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.btrfs_folio_clamp_clear_checked
      0.11            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.btrfs_do_readpage
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.btrfs_drop_pages
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.btrfs_write_check
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.btrfs_create_new_inode
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.lock_extent
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.kmem_cache_free
      0.15            -0.0        0.14        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     99.48            +0.0       99.52        perf-profile.children.cycles-pp.do_syscall_64
     99.49            +0.0       99.53        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.21            +0.1        0.26        perf-profile.children.cycles-pp.need_preemptive_reclaim
     60.25            +0.1       60.37        perf-profile.children.cycles-pp.btrfs_block_rsv_release
     59.96            +0.1       60.07        perf-profile.children.cycles-pp.btrfs_inode_rsv_release
     27.57            +0.1       27.71        perf-profile.children.cycles-pp.btrfs_dirty_pages
     98.06            +0.1       98.21        perf-profile.children.cycles-pp.write
     97.95            +0.2       98.11        perf-profile.children.cycles-pp.ksys_write
     97.83            +0.2       97.99        perf-profile.children.cycles-pp.btrfs_buffered_write
     97.94            +0.2       98.10        perf-profile.children.cycles-pp.vfs_write
     97.86            +0.2       98.02        perf-profile.children.cycles-pp.btrfs_do_write_iter
     26.57            +0.3       26.84        perf-profile.children.cycles-pp.__clear_extent_bit
     26.44            +0.3       26.72        perf-profile.children.cycles-pp.clear_state_bit
     35.50            +0.3       35.79        perf-profile.children.cycles-pp.__reserve_bytes
     26.37            +0.3       26.67        perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
     35.23            +0.3       35.52        perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
     35.19            +0.3       35.50        perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
     95.80            +0.4       96.18        perf-profile.children.cycles-pp._raw_spin_lock
     95.21            +0.4       95.60        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.70            -0.0        0.67        perf-profile.self.cycles-pp._raw_spin_lock
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.btrfs_space_info_update_bytes_may_use
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.btrfs_folio_clamp_clear_checked
      0.08 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.memset_orig
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.btrfs_block_rsv_release
     94.48            +0.4       94.88        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


