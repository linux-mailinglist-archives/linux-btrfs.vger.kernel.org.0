Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3B7CEDA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 03:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjJSBlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJSBlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 21:41:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177159F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 18:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697679668; x=1729215668;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=2H+wvzwR5CAvgi5uMNvwXuMuVmnbx84rr+WMhQV5Wp4=;
  b=DyeIMt1M1DYzU9/+JQ4kUBoAuc+9I/t6ot7g1uCJ3TugGiy5VBEkBAwu
   AkOl8cQcYX69CAcaXBMOrvWNAD0RRXhHqDCgGhRawb2jz1mMMA7EcWZYs
   XCGvcqdlmK84ifaVeRoLQ/0hkC/FegNYAsXLLRYOSZvx8171d7jB5Ar3d
   pu8qtZuBhMpx4Qb/EKndny/p43Ka9VdB74ZzZJNFLZeY6Cw/3L5gSt26Y
   o30I6WtmipZ3zYW4ejjxbtrw5jCA6Gxvn+SzeZf2FYbWlv+lNitMCQUqD
   /mu9C3ihye1EtilldoZyYqQZscCWfiNKf1QGqNKxlFIHZFGifFe9GBWn0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452624409"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452624409"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 18:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900570186"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="900570186"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 18:39:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 18:41:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 18:41:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 18:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTcU61rV9igxaqU993Hbdn1ZYO90RVukVxIddLP79XWJNsm97SG7eHqTUBTj59YBGX6Xm8Si/D3nPDYCn4+2K8k5kKL+pTyhV9RlB2b8gErzgXIo8r8T0Rh/3yGxtJLl87w8E6ARMcChDo5jEu5JS1ZGZ4ZC0uXTrJ2a97v2QqTuTyPui4zQQBPAADcO3SXbQS520hol5aOmBa9pv0WziKSRc/WM0tzUz7sqh8Luq37abS4NTZpRIZuBZMW5D24cOk+3wxZYCWAeDJ0+lYKaqAjcN/6Ko8LnG4ZAxWEbMPnxzVf0I/tb2kBgpSINZDWr92+iT43Y85Zug/fB/kc2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhc6oPVv4DBwD3om7pqUyV4PW30wrzh9XxZNdkJRCUQ=;
 b=nYpdJLXq9/c5IRs/PcuEKR3pTAMfv0HmOgzXLS1l68V1uOyox03BlhNv3/XtxwxaaxEWS58dWScBPSOIihZDaah2BsvwW16xJO5AqZKyZSQ26yDTVCUBaPfVTB+ZYpq4J71pbhsXkQcp9Y5QdIcyjFR9H+/KhRwX40ThZRYWs1Miwzyov6VhsaX6c9oCNOaRr7CDC/TfsSLmm5SgQ1Q5TytdX05lN6CDF9SOTzEbEKI68GI7SBZS2KrXl6WvZdX2IJFFy9gXALqbineOqbRe8fgYYYVkV0uFu3ev5a4fGqu2dJMbt6Cz8k0vrG+sOPUGpg4eWvz7AXeWGThp03ifnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 01:41:02 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Thu, 19 Oct 2023
 01:41:01 +0000
Date:   Thu, 19 Oct 2023 09:40:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Qu Wenruo <wqu@suse.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [kdave-btrfs-devel:for-next] [btrfs]  c1ad4ede87:
 fsmark.files_per_sec 30.4% improvement
Message-ID: <202310190444.14ffb11-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM3PR11MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8a9fb2-6497-4274-254a-08dbd044730e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2jEMPLMBUuhlCJykWR+BLX8leE+P+O1NmxFkOAYG4hCPEKkfGUEEC8lS7HwqPHsol5RC3nDeb3NtihjAHqtKUIthSzfE+8wEqA3a/yCYyiLafaKg0OHF/FuUtfCGzbcDcZQnDi+MzCTwPpuzlpP11dMrJH5XfKMIMze8RL5BbBKvL/5KoSpdLWwoiZh42GZ+Rca3dqqH5q1LzFaaWZxLstpOtY6LQkjTbxmYPQpXatDG4HZU8jkoAEP5QGz/VHMp7SdhmSYIUpledNToI+Jy0IVmB6Y0CG9jwwwkki2Z/n367VnJqtYcYaqw0YH9vYnmCOZAjLNpJfrV9tZGr2psK1wWf8dPhMBAgK+4nOcFY3D1DuCYnfy175i9HYP8LrcYBLdyNwonhSmUOgWmBvaii0jo1U3AiZNhsSUOxjhtrQ8e9OBTWzFVL+yvjbIH81YeV9x7uiMXV9QWl6mj801uNat9KCPVkCBsuWAWNyiF1+McOrkt+0nxDm8AQpb7UspFIBoejbQptUlHrJIeCTLkjYGGpKTfCPNjzWL6FVsv48s/W3k+Iso8JYLfS+DqtjZL0BxCV6nVX7xPUaDTbQjHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(966005)(66476007)(6486002)(316002)(66556008)(66946007)(6916009)(26005)(107886003)(1076003)(2616005)(82960400001)(83380400001)(38100700002)(86362001)(36756003)(19627235002)(478600001)(6666004)(6512007)(2906002)(6506007)(5660300002)(41300700001)(30864003)(4326008)(8676002)(8936002)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YPsv1TbL/SvxGHYLnBj2Mm3mJokdNUy+dLpNlvlooOaF3ySplQubvfQUE1?=
 =?iso-8859-1?Q?cXF4cS2AL2F6nn035X1G759mBM4zKORyt/ouTPairaVZyCImBYhOFK2L+g?=
 =?iso-8859-1?Q?jj9cokj3Q/fxM9AjR1VsncfVqk6LoBGJQPujXzlXUBF3gAsgzSdJ1MrRed?=
 =?iso-8859-1?Q?eBkPPBqbaeVHMGt4PV4odEf2A9ZWhYg73jqLyhlbtmw225ze2qQcCdj+k3?=
 =?iso-8859-1?Q?xBMlj5oagj778PSxEYufo2ScaZG6lujqutNFAcB/MlYHhGMt2FBWZ6/JP3?=
 =?iso-8859-1?Q?sgfsDmZqqXj7EJDbKZOrp+zwtRFkjHqKx5F4M1LLQKQW/mehidnzKgy0hw?=
 =?iso-8859-1?Q?yE+9iLkeFXO5Vd26QaxjkXPaOkkJZLdexO551QcAVvnSM+b+jXQhK5us02?=
 =?iso-8859-1?Q?hzWWfmtTdamP6X31yF/tlVPu6iLHR0W81AZaLzp+uBrRe352bWVkWb/iVP?=
 =?iso-8859-1?Q?QmhoDXzQ32CpMVDEd4maX57wkSLkuRrLRy1FNk0XdCoIdw4j7EjAc3pUO2?=
 =?iso-8859-1?Q?QGNn/3nyfhlNIfaK5Et4EWuPbIJEKRAwmS6fj8u11dFQtOWx2ttxKydYfo?=
 =?iso-8859-1?Q?5Aqr1OhSIngdXDGEv2gM6y028YjMSjLzCVIc+KkFCewOD/+UOUVik3oUIh?=
 =?iso-8859-1?Q?BgTbOV7HKpjvTxdOZI26BD6k6TmtfROtBWL8NNbCK0ywTy6itVoTSkTXsM?=
 =?iso-8859-1?Q?W/rLx60DDqBGQHAimIIGWec7O0UMtUqTuvccNlk6F8awzUcaGEk4PR+W1t?=
 =?iso-8859-1?Q?0NBmjZhszObYmeVTXRneV/KvppQ59jNNOomnaJkEtfDW9wyRA8+m9kVLkk?=
 =?iso-8859-1?Q?3dPFeotB54UH/aLMFGD9469oTSRIyHQt+mrpulDQkza8kRYuxEcxi0OaKK?=
 =?iso-8859-1?Q?6It/kv9p1xIuB6GoMcgk0UIkswGnyzpNGM3ctsjJ/dUzLvzixXSYhBa6cO?=
 =?iso-8859-1?Q?PX0PYgP8h0kYvAQfUs5WOeWBAZ6976jBYRrPAeJw+HWMajanNehhsXhJ/1?=
 =?iso-8859-1?Q?WZPoFa2pBzqrwgYHjdipYecTgHesU6KFJ5pSbCkTjWLbDbl32rq2ceQQlE?=
 =?iso-8859-1?Q?2qApCCqcX4TqTbuTyjRp+HEJkSAS4STjWfl8oxQknwkFbwQe7+Sk8A6pmC?=
 =?iso-8859-1?Q?QjTJmZjYROEmjD3ZtCJ0lezO5VcD9Sn7CpH51HRI5R8hA+fax0CKexeCs6?=
 =?iso-8859-1?Q?067ZJJKg20M+hg72vU6pEcC6TQCUwQZWtr00qjHH2w9bgPXO/pEVQMqIbi?=
 =?iso-8859-1?Q?omDB+rXsECb+f8kHQ1wfWaDOc3P0vPhdnZ5n6e6Q4p0cKpqNeVCgQeox/0?=
 =?iso-8859-1?Q?mgL2L6uTxzl01Jz8RvfqCojsAePK0B3bRyn4x0gqSRO6O2iCNOMeZZxm36?=
 =?iso-8859-1?Q?PsdN81hLLCRzftfLg+7/qGWTFbCbyEkRKUl9fmDC+VQ4e6OQjXUB//yCzY?=
 =?iso-8859-1?Q?bsTJlFh+9+46bGGJ7keaVZgJMzqzh7lalr5IVBFGwISRaoms+RNOokFQHz?=
 =?iso-8859-1?Q?oWCo57NilJMcXXH+7o/gtrME3JNIoOKmKvVM0Cz6/vScHyUcm1O116DR9G?=
 =?iso-8859-1?Q?uzwiAsGEJAYgzeoGq7PBXrAu/KpBFjh2BeLAfXSn4BQTTUI7ddmy9QDhB8?=
 =?iso-8859-1?Q?DM7JVPa2iqHUZtOMj5vK1ICwwRWQTfD9lcnE3HFf26eMUnBqlwq6Wq0A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8a9fb2-6497-4274-254a-08dbd044730e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:41:01.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3jfFsIEEg0tO0VI6VK2mrnn/bpPENWTD5oRjvgwN+/oSCS9H7fPCNxLnE3yW5Di94oc7FTB0vn39JmLrK7CCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hello,

kernel test robot noticed a 30.4% improvement of fsmark.files_per_sec on:


commit: c1ad4ede8771bf666965ea9f35adc73cb85a1ddf ("btrfs: utilize the physically/virtually continuous extent buffer memory")
https://github.com/kdave/btrfs-devel.git for-next

testcase: fsmark
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1BRD_32G
	fs: btrfs
	filesize: 4K
	test_size: 4G
	sync_method: fsyncBeforeClose
	nr_files_per_directory: 1fpd
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 12.4% improvement                                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs2=cifs                                                                                       |
|                  | fs=btrfs                                                                                       |
|                  | test=webproxy.f                                                                                |
+------------------+------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231019/202310190444.14ffb11-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1BRD_32G/4K/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-11.1-x86_64-20220510.cgz/fsyncBeforeClose/lkp-icl-2sp9/4G/fsmark

commit: 
  28409dbb2d ("btrfs: map uncontinuous extent buffer pages into virtual address space")
  c1ad4ede87 ("btrfs: utilize the physically/virtually continuous extent buffer memory")

28409dbb2d3d30a0 c1ad4ede8771bf666965ea9f35a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.25            +1.9%       2.29        iostat.cpu.system
      0.12 ±  2%      +0.0        0.16        mpstat.cpu.all.usr%
     33025           +22.6%      40499        sched_debug.cpu.nr_switches.avg
 1.044e+10           -22.6%  8.084e+09        cpuidle..time
  12822157           -18.7%   10427778        cpuidle..usage
    203.61           -18.5%     166.00        uptime.boot
     12559           -18.8%      10201        uptime.idle
    473575           +28.8%     609923        vmstat.io.bo
     30255           +25.3%      37902        vmstat.system.cs
     79179            +5.2%      83262        vmstat.system.in
  12806491           -18.7%   10412766        turbostat.C1
     62.67 ±  3%      -7.7%      57.83 ±  5%  turbostat.CoreTmp
      0.36           +18.8%       0.42        turbostat.IPC
  13259471           -18.4%   10823160        turbostat.IRQ
     62.67 ±  3%      -7.7%      57.83 ±  5%  turbostat.PkgTmp
  14705932            -4.1%   14106580        fsmark.app_overhead
      6256           +30.4%       8161        fsmark.files_per_sec
    164.26           -22.8%     126.79        fsmark.time.elapsed_time
    164.26           -22.8%     126.79        fsmark.time.elapsed_time.max
    142.85           -23.9%     108.70        fsmark.time.system_time
   1137555            -1.2%    1123545        fsmark.time.voluntary_context_switches
     19100            +5.0%      20056        proc-vmstat.nr_active_anon
      7961            +2.0%       8124        proc-vmstat.nr_mapped
     20680            +5.7%      21867        proc-vmstat.nr_shmem
     19100            +5.0%      20056        proc-vmstat.nr_zone_active_anon
    492070           -15.1%     417953        proc-vmstat.pgfault
     20408           -17.9%      16753        proc-vmstat.pgreuse
   1368576           -20.9%    1082112        proc-vmstat.unevictable_pgs_scanned
      8.12 ±  5%     -19.5%       6.54 ±  3%  perf-sched.total_wait_and_delay.average.ms
     75514 ±  2%     +23.1%      92988        perf-sched.total_wait_and_delay.count.ms
      8.12 ±  5%     -19.5%       6.54 ±  3%  perf-sched.total_wait_time.average.ms
    286.95 ±  2%     -13.5%     248.22 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.58 ±  4%     -22.0%       0.45 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     30873           +26.0%      38885        perf-sched.wait_and_delay.count.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_file.__x64_sys_fsync
     44.83 ±  2%     +15.6%      51.83 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      5647 ±  5%     +15.2%       6504 ±  5%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     33845 ±  2%     +24.8%      42231        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±100%    +561.5%       0.03 ±150%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
    286.95 ±  2%     -13.5%     248.21 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.58 ±  4%     -22.1%       0.45 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.00 ±100%    +548.1%       0.03 ±146%  perf-sched.wait_time.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      1.71 ±  3%      +9.4%       1.87        perf-stat.i.MPKI
 1.061e+09           +25.3%   1.33e+09        perf-stat.i.branch-instructions
      0.38            +0.0        0.39        perf-stat.i.branch-miss-rate%
   5139980 ±  2%     +25.0%    6423420        perf-stat.i.branch-misses
   9922657 ±  3%     +33.6%   13252102        perf-stat.i.cache-misses
  42066859           +24.9%   52547837        perf-stat.i.cache-references
     30779           +26.1%      38825        perf-stat.i.context-switches
      0.90           -15.4%       0.76        perf-stat.i.cpi
 5.427e+09            +4.6%  5.678e+09        perf-stat.i.cpu-cycles
    115.90 ±  2%      +7.0%     124.02 ±  4%  perf-stat.i.cpu-migrations
    564.59 ±  2%     -22.3%     438.92        perf-stat.i.cycles-between-cache-misses
     85491 ±  9%     +40.3%     119914 ±  9%  perf-stat.i.dTLB-load-misses
 1.566e+09           +25.4%  1.965e+09        perf-stat.i.dTLB-loads
      0.00 ±  3%      +0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
     19093 ±  3%    +159.5%      49542 ±  3%  perf-stat.i.dTLB-store-misses
  7.79e+08           +27.6%  9.939e+08        perf-stat.i.dTLB-stores
 6.157e+09           +23.8%  7.625e+09        perf-stat.i.instructions
      1.12           +18.8%       1.34        perf-stat.i.ipc
      0.08            +4.7%       0.09        perf-stat.i.metric.GHz
    738.94           +21.1%     894.90        perf-stat.i.metric.K/sec
     53.22           +26.0%      67.04        perf-stat.i.metric.M/sec
      2317            +5.0%       2433        perf-stat.i.minor-faults
    703649 ± 11%     +35.3%     952373 ± 10%  perf-stat.i.node-loads
   3587811 ± 15%     +47.3%    5285458 ±  4%  perf-stat.i.node-stores
      2317            +5.0%       2433        perf-stat.i.page-faults
      0.88           -15.5%       0.74        perf-stat.overall.cpi
    547.45 ±  2%     -21.7%     428.63        perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      1.13           +18.4%       1.34        perf-stat.overall.ipc
 1.055e+09           +25.1%   1.32e+09        perf-stat.ps.branch-instructions
   5112795 ±  2%     +24.8%    6380770        perf-stat.ps.branch-misses
   9863756 ±  3%     +33.3%   13148433        perf-stat.ps.cache-misses
  41814498           +24.7%   52138684        perf-stat.ps.cache-references
     30593           +25.9%      38522        perf-stat.ps.context-switches
 5.395e+09            +4.4%  5.634e+09        perf-stat.ps.cpu-cycles
    115.19 ±  2%      +6.8%     123.04 ±  4%  perf-stat.ps.cpu-migrations
     84983 ±  9%     +40.0%     118990 ±  9%  perf-stat.ps.dTLB-load-misses
 1.557e+09           +25.2%   1.95e+09        perf-stat.ps.dTLB-loads
     18985 ±  3%    +159.0%      49164 ±  3%  perf-stat.ps.dTLB-store-misses
 7.743e+08           +27.4%  9.862e+08        perf-stat.ps.dTLB-stores
  6.12e+09           +23.6%  7.567e+09        perf-stat.ps.instructions
      2303            +4.8%       2414        perf-stat.ps.minor-faults
    699593 ± 11%     +35.1%     944912 ± 10%  perf-stat.ps.node-loads
   3566050 ± 15%     +47.1%    5243947 ±  4%  perf-stat.ps.node-stores
      2303            +4.8%       2414        perf-stat.ps.page-faults
 1.011e+12            -4.5%  9.662e+11        perf-stat.total.instructions
     24.55 ±  3%      -9.9       14.64 ±  3%  perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages
     30.24 ±  3%      -8.7       21.56 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages
     30.25 ±  3%      -8.7       21.56 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
     31.54 ±  4%      -8.0       23.53 ±  4%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
     31.57 ±  4%      -8.0       23.57 ±  4%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
     31.58 ±  4%      -8.0       23.58 ±  4%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.__x64_sys_fsync
     32.18 ±  3%      -8.0       24.18 ±  3%  perf-profile.calltrace.cycles-pp.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     32.56 ±  3%      -7.9       24.62 ±  3%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
     31.70 ±  4%      -7.9       23.77 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.__x64_sys_fsync.do_syscall_64
     34.87 ±  5%      -7.5       27.34 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_sync_log.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50.42 ±  5%      -5.9       44.49 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     50.43 ±  5%      -5.9       44.50 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     50.47 ±  5%      -5.9       44.56 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     50.47 ±  5%      -5.9       44.57 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
     50.54 ±  5%      -5.9       44.65 ±  4%  perf-profile.calltrace.cycles-pp.fsync
      5.87 ±  6%      -5.9        0.00        perf-profile.calltrace.cycles-pp.read_extent_buffer.__btrfs_check_node.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk
     16.11 ±  4%      -5.4       10.74 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
     15.58 ±  4%      -5.3       10.27 ±  2%  perf-profile.calltrace.cycles-pp.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      7.27 ±  4%      -5.0        2.24 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
      7.10 ±  4%      -5.0        2.10 ±  5%  perf-profile.calltrace.cycles-pp.__btrfs_check_node.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      5.00 ±  7%      -4.4        0.58 ±  8%  perf-profile.calltrace.cycles-pp.read_extent_buffer.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      4.86 ±  5%      -0.9        4.00 ±  5%  perf-profile.calltrace.cycles-pp.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      2.97 ±  7%      -0.8        2.15 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_get_32.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      1.13 ± 13%      -0.4        0.73 ±  6%  perf-profile.calltrace.cycles-pp.check_inode_item.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio
      0.58 ±  7%      +0.1        0.67 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_wait_ordered_range.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.65 ±  8%      +0.1        0.78 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.lookup_open
      0.66 ±  8%      +0.1        0.80 ±  8%  perf-profile.calltrace.cycles-pp.lookup_one_qstr_excl.filename_create.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      0.73 ±  9%      +0.2        0.88 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.lookup_open.open_last_lookups
      0.59 ±  4%      +0.2        0.74 ±  7%  perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
      0.59 ± 11%      +0.2        0.74 ± 12%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.submit_one_bio
      0.59 ± 11%      +0.2        0.75 ± 12%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.submit_one_bio.submit_extent_page
      0.83 ± 14%      +0.2        1.02 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_init_new_buffer.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot
      0.64 ±  2%      +0.2        0.83 ± 11%  perf-profile.calltrace.cycles-pp.__folio_start_writeback.write_one_eb.submit_eb_page.btree_write_cache_pages.do_writepages
      0.86 ±  8%      +0.2        1.05 ±  6%  perf-profile.calltrace.cycles-pp.filename_create.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ± 11%      +0.2        0.84 ± 14%  perf-profile.calltrace.cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.btrfs_buffered_write
      0.65 ± 10%      +0.2        0.85 ± 14%  perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.btrfs_buffered_write.btrfs_do_write_iter
      0.63 ± 11%      +0.2        0.83 ± 15%  perf-profile.calltrace.cycles-pp.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.68 ± 11%      +0.2        0.88 ± 13%  perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.52 ± 45%      +0.2        0.73 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      0.70 ± 10%      +0.2        0.92 ± 12%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.67 ±  8%      +0.2        0.91 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      2.03 ±  2%      +0.3        2.32 ±  4%  perf-profile.calltrace.cycles-pp.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
      0.96 ± 17%      +0.3        1.25 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      2.16 ±  3%      +0.3        2.46 ±  4%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      2.17 ±  3%      +0.3        2.48 ±  4%  perf-profile.calltrace.cycles-pp.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops
      2.18 ±  3%      +0.3        2.50 ±  5%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file
      1.00 ±  5%      +0.3        1.33 ± 10%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.extent_buffer_write_end_io.__submit_bio.__submit_bio_noacct
      0.26 ±100%      +0.3        0.60 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_lookup.lookup_one_qstr_excl.filename_create.do_mkdirat.__x64_sys_mkdir
      1.38 ±  7%      +0.3        1.71 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum
      1.80 ± 18%      +0.4        2.16 ±  5%  perf-profile.calltrace.cycles-pp.steal_from_bitmap.__btrfs_add_free_space.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction
      1.11 ±  6%      +0.4        1.47 ±  9%  perf-profile.calltrace.cycles-pp.folio_end_writeback.extent_buffer_write_end_io.__submit_bio.__submit_bio_noacct.btrfs_submit_chunk
      2.20 ±  3%      +0.4        2.55 ±  5%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file.__x64_sys_fsync
      1.60 ± 10%      +0.4        1.96 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_create_common.lookup_open.open_last_lookups.path_openat.do_filp_open
      1.16 ± 19%      +0.4        1.52 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      2.21 ±  3%      +0.4        2.58 ±  5%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file.__x64_sys_fsync.do_syscall_64
      1.19 ±  7%      +0.4        1.56 ±  8%  perf-profile.calltrace.cycles-pp.extent_buffer_write_end_io.__submit_bio.__submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio
      0.27 ±100%      +0.4        0.64 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items
      2.22 ±  3%      +0.4        2.60 ±  5%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±  9%      +0.4        1.85 ±  5%  perf-profile.calltrace.cycles-pp.copy_to_brd.brd_submit_bio.__submit_bio.__submit_bio_noacct.btrfs_submit_chunk
      1.92 ± 18%      +0.4        2.32 ±  5%  perf-profile.calltrace.cycles-pp.__btrfs_add_free_space.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space
      1.93 ± 18%      +0.4        2.34 ±  5%  perf-profile.calltrace.cycles-pp.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space
      0.18 ±141%      +0.4        0.60 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_lookup_dentry.btrfs_lookup.lookup_one_qstr_excl.filename_create.do_mkdirat
      1.95 ± 18%      +0.4        2.38 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      1.74 ±  6%      +0.5        2.20 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode
      1.75 ±  6%      +0.5        2.21 ±  7%  perf-profile.calltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common
      2.38 ±  6%      +0.5        2.87 ±  3%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      2.44 ±  6%      +0.5        2.94 ±  4%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.15 ±  5%      +0.5        2.66 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      1.02 ± 46%      +0.5        1.53 ±  8%  perf-profile.calltrace.cycles-pp.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
      2.14 ±  5%      +0.5        2.65 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.02 ±  5%      +0.5        2.54 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
      2.12 ±  5%      +0.5        2.63 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.vfs_mkdir.do_mkdirat
      2.12 ±  5%      +0.5        2.64 ±  4%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.04 ±  5%      +0.5        2.55 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.vfs_mkdir
      2.11 ±  5%      +0.5        2.63 ±  4%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.04 ±  5%      +0.5        2.56 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.17 ±  5%      +0.5        2.70 ±  3%  perf-profile.calltrace.cycles-pp.write
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.__memcpy.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_update_root
      2.79 ±  6%      +0.6        3.36 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.80 ±  6%      +0.6        3.38 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.94 ±  6%      +0.6        3.52 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      2.94 ±  5%      +0.6        3.52 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.92 ±  5%      +0.6        3.50 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.98 ±  5%      +0.6        3.56 ±  3%  perf-profile.calltrace.cycles-pp.open64
      2.91 ±  5%      +0.6        3.50 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.68 ±  6%      +0.6        2.26 ±  5%  perf-profile.calltrace.cycles-pp.write_one_eb.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
      0.00            +0.6        0.63 ± 15%  perf-profile.calltrace.cycles-pp.__memcpy.__btrfs_check_node.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk
      2.88 ±  7%      +0.6        3.51 ±  5%  perf-profile.calltrace.cycles-pp.brd_submit_bio.__submit_bio.__submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio
      2.85 ±  4%      +0.7        3.51 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.vfs_mkdir.do_mkdirat.__x64_sys_mkdir
      0.00            +0.7        0.71 ±  8%  perf-profile.calltrace.cycles-pp.__memcpy.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      0.00            +0.7        0.71 ±  8%  perf-profile.calltrace.cycles-pp.__memcpy.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items
      3.12 ±  5%      +0.7        3.86 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_create_common.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      0.00            +0.8        0.75 ± 11%  perf-profile.calltrace.cycles-pp.__memmove.setup_items_for_insert.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item
      3.40 ±  5%      +0.8        4.20 ±  7%  perf-profile.calltrace.cycles-pp.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.34 ±  5%      +1.0        5.34 ±  6%  perf-profile.calltrace.cycles-pp.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      4.40 ±  5%      +1.0        5.44 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      4.40 ±  5%      +1.0        5.45 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      4.41 ±  5%      +1.1        5.47 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mkdir
      4.43 ±  5%      +1.1        5.50 ±  5%  perf-profile.calltrace.cycles-pp.mkdir
      5.14 ±  6%      +1.1        6.28 ±  4%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
      4.67 ±  7%      +1.2        5.82 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      5.15 ±  6%      +1.2        6.30 ±  4%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages
      0.00            +1.2        1.20 ± 13%  perf-profile.calltrace.cycles-pp.__memmove.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      0.00            +1.5        1.46 ±  7%  perf-profile.calltrace.cycles-pp.crc_pcl.crc32c_pcl_intel_digest.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk
      0.00            +1.5        1.49 ±  8%  perf-profile.calltrace.cycles-pp.crc32c_pcl_intel_digest.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      0.00            +1.7        1.65 ±  4%  perf-profile.calltrace.cycles-pp.__memcpy.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum
     13.10 ±  5%     -11.7        1.42 ±  7%  perf-profile.children.cycles-pp.read_extent_buffer
     24.64 ±  3%     -10.0       14.65 ±  3%  perf-profile.children.cycles-pp.btree_csum_one_bio
     31.16 ±  3%      -8.6       22.59 ±  3%  perf-profile.children.cycles-pp.btrfs_submit_chunk
     31.16 ±  3%      -8.6       22.59 ±  3%  perf-profile.children.cycles-pp.btrfs_submit_bio
     32.18 ±  3%      -8.0       24.19 ±  3%  perf-profile.children.cycles-pp.submit_eb_page
     32.57 ±  3%      -7.9       24.63 ±  3%  perf-profile.children.cycles-pp.btree_write_cache_pages
     32.76 ±  3%      -7.9       24.88 ±  3%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
     34.78 ±  3%      -7.6       27.15 ±  3%  perf-profile.children.cycles-pp.do_writepages
     34.84 ±  3%      -7.6       27.25 ±  3%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     34.86 ±  3%      -7.6       27.30 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     34.88 ±  5%      -7.5       27.34 ±  4%  perf-profile.children.cycles-pp.btrfs_sync_log
      5.93 ±  4%      -5.9        0.00        perf-profile.children.cycles-pp.__write_extent_buffer
     50.42 ±  5%      -5.9       44.49 ±  4%  perf-profile.children.cycles-pp.btrfs_sync_file
     50.43 ±  5%      -5.9       44.51 ±  4%  perf-profile.children.cycles-pp.__x64_sys_fsync
     50.54 ±  5%      -5.9       44.66 ±  4%  perf-profile.children.cycles-pp.fsync
     16.20 ±  5%      -5.5       10.74 ±  3%  perf-profile.children.cycles-pp.__btrfs_check_leaf
     16.20 ±  5%      -5.5       10.74 ±  3%  perf-profile.children.cycles-pp.btrfs_check_leaf
      7.27 ±  4%      -5.0        2.24 ±  6%  perf-profile.children.cycles-pp.btrfs_check_node
      7.27 ±  4%      -5.0        2.24 ±  6%  perf-profile.children.cycles-pp.__btrfs_check_node
      5.61 ±  5%      -0.8        4.79 ±  4%  perf-profile.children.cycles-pp.btrfs_get_32
      5.31 ±  4%      -0.7        4.58 ±  3%  perf-profile.children.cycles-pp.check_leaf_item
      1.24 ± 11%      -0.4        0.81 ±  5%  perf-profile.children.cycles-pp.check_inode_item
      0.70 ± 11%      -0.4        0.32 ± 11%  perf-profile.children.cycles-pp.check_inode_key
      1.41 ±  4%      -0.2        1.23 ±  7%  perf-profile.children.cycles-pp.btrfs_get_64
      0.04 ± 45%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.11 ± 17%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.btrfs_reduce_alloc_profile
      0.05 ± 49%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.add_delayed_ref_head
      0.30 ±  9%      +0.0        0.34 ±  8%  perf-profile.children.cycles-pp.rcu_pending
      0.06 ± 49%      +0.0        0.10 ± 19%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.08 ± 10%      +0.0        0.12 ± 15%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.09 ± 14%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.find_first_extent_bit
      0.11 ±  6%      +0.0        0.16 ± 21%  perf-profile.children.cycles-pp.select_task_rq
      0.16 ±  6%      +0.0        0.21 ±  5%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.14 ± 16%      +0.0        0.18 ±  9%  perf-profile.children.cycles-pp.calc_available_free_space
      0.10 ± 23%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.work_busy
      0.02 ±141%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__strncat_chk
      0.30 ±  7%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.12 ± 18%      +0.1        0.18 ± 18%  perf-profile.children.cycles-pp.xas_clear_mark
      0.11 ± 18%      +0.1        0.17 ± 16%  perf-profile.children.cycles-pp.rb_next
      0.10 ± 12%      +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.alloc_reserved_tree_block
      0.30 ±  7%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.06 ± 47%      +0.1        0.12 ± 21%  perf-profile.children.cycles-pp.convert_extent_bit
      0.24 ± 12%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.unlock_up
      0.02 ±142%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.set_state_bits
      0.30 ±  6%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.18 ± 15%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.block_group_cache_tree_search
      0.14 ± 19%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.16 ± 14%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.21 ±  6%      +0.1        0.27 ± 13%  perf-profile.children.cycles-pp.__xa_set_mark
      0.00            +0.1        0.06 ± 21%  perf-profile.children.cycles-pp.__percpu_counter_compare
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.30 ±  6%      +0.1        0.36 ±  7%  perf-profile.children.cycles-pp.btrfs_alloc_from_cluster
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.32 ±  9%      +0.1        0.39 ±  6%  perf-profile.children.cycles-pp.__file_remove_privs
      0.34 ± 14%      +0.1        0.41 ± 10%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.35 ±  9%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.btrfs_write_check
      0.15 ± 17%      +0.1        0.22 ± 16%  perf-profile.children.cycles-pp.inode_tree_add
      0.18 ± 19%      +0.1        0.26 ± 12%  perf-profile.children.cycles-pp.__close
      0.15 ± 26%      +0.1        0.22 ± 14%  perf-profile.children.cycles-pp.__x64_sys_close
      0.36 ±  3%      +0.1        0.44 ± 14%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      0.23 ± 16%      +0.1        0.31 ± 15%  perf-profile.children.cycles-pp.btrfs_root_node
      0.35 ±  7%      +0.1        0.43 ±  9%  perf-profile.children.cycles-pp.__push_leaf_right
      0.14 ± 14%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.mark_page_accessed
      0.32 ±  5%      +0.1        0.40 ±  6%  perf-profile.children.cycles-pp.find_free_extent_clustered
      0.58 ±  7%      +0.1        0.67 ± 10%  perf-profile.children.cycles-pp.btrfs_wait_ordered_range
      0.30 ±  8%      +0.1        0.39 ± 12%  perf-profile.children.cycles-pp.__queue_work
      0.60 ±  4%      +0.1        0.69 ±  4%  perf-profile.children.cycles-pp.schedule
      0.44 ±  3%      +0.1        0.53 ±  5%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.40 ± 12%      +0.1        0.49 ±  7%  perf-profile.children.cycles-pp.filemap_get_entry
      0.39 ±  6%      +0.1        0.48 ± 15%  perf-profile.children.cycles-pp.down_read
      0.38 ± 11%      +0.1        0.48 ± 10%  perf-profile.children.cycles-pp.free_extent_buffer
      0.24 ± 15%      +0.1        0.34 ± 15%  perf-profile.children.cycles-pp.write_dev_supers
      0.12 ± 15%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.run_delayed_tree_ref
      0.45 ±  9%      +0.1        0.56 ±  8%  perf-profile.children.cycles-pp.start_transaction
      0.26 ± 18%      +0.1        0.37 ± 19%  perf-profile.children.cycles-pp.rcu_do_batch
      0.27 ±  9%      +0.1        0.38 ± 11%  perf-profile.children.cycles-pp.btrfs_free_path
      0.32 ± 17%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      0.85 ±  5%      +0.1        0.96 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.37 ± 14%      +0.1        0.49 ± 12%  perf-profile.children.cycles-pp.pin_down_extent
      0.39 ± 10%      +0.1        0.52 ± 12%  perf-profile.children.cycles-pp.try_to_wake_up
      0.42 ± 16%      +0.1        0.54 ± 16%  perf-profile.children.cycles-pp.end_bio_extent_writepage
      0.41 ±  6%      +0.1        0.54 ± 10%  perf-profile.children.cycles-pp.push_leaf_right
      0.60 ± 13%      +0.1        0.74 ±  8%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.51 ± 11%      +0.1        0.65 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.61 ± 12%      +0.1        0.75 ±  5%  perf-profile.children.cycles-pp.__btrfs_tree_lock
      0.66 ±  8%      +0.1        0.80 ±  8%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      0.45 ± 13%      +0.1        0.59 ± 13%  perf-profile.children.cycles-pp.btrfs_free_tree_block
      0.58 ± 16%      +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.btrfs_drop_extents
      0.37 ±  8%      +0.2        0.52 ± 20%  perf-profile.children.cycles-pp.kmem_cache_free
      0.62 ±  5%      +0.2        0.78 ±  9%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.37 ±  7%      +0.2        0.52 ± 13%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.39 ± 12%      +0.2        0.54 ±  9%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.61 ± 12%      +0.2        0.77 ±  5%  perf-profile.children.cycles-pp.down_write
      0.74 ±  7%      +0.2        0.90 ± 10%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      1.38 ±  6%      +0.2        1.54 ±  2%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.77 ± 10%      +0.2        0.93 ± 10%  perf-profile.children.cycles-pp.find_free_extent
      0.74 ±  8%      +0.2        0.91 ± 10%  perf-profile.children.cycles-pp.btrfs_lookup
      1.27 ±  5%      +0.2        1.43 ±  8%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.60 ±  5%      +0.2        0.77 ±  8%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.60 ±  9%      +0.2        0.77 ±  7%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.39 ± 12%      +0.2        0.56 ±  8%  perf-profile.children.cycles-pp.__reserve_bytes
      0.27 ±  8%      +0.2        0.45 ±  7%  perf-profile.children.cycles-pp.alloc_extent_state
      0.77 ± 10%      +0.2        0.95 ±  7%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.72 ± 11%      +0.2        0.89 ±  6%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.78 ±  9%      +0.2        0.97 ±  8%  perf-profile.children.cycles-pp.pagecache_get_page
      0.89 ±  8%      +0.2        1.08 ±  8%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.90 ±  5%      +0.2        1.09 ±  6%  perf-profile.children.cycles-pp.xas_descend
      0.78 ± 10%      +0.2        0.98 ±  5%  perf-profile.children.cycles-pp.__set_extent_bit
      0.86 ±  8%      +0.2        1.05 ±  7%  perf-profile.children.cycles-pp.filename_create
      0.64 ± 11%      +0.2        0.84 ± 14%  perf-profile.children.cycles-pp.do_flush_stats
      0.65 ± 10%      +0.2        0.85 ± 14%  perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.66 ± 12%      +0.2        0.86 ±  6%  perf-profile.children.cycles-pp.set_extent_bit
      0.63 ± 11%      +0.2        0.83 ± 15%  perf-profile.children.cycles-pp.cgroup_rstat_flush
      1.32 ±  5%      +0.2        1.53 ±  7%  perf-profile.children.cycles-pp.xa_load
      0.76 ±  3%      +0.2        0.97 ± 10%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.68 ± 11%      +0.2        0.88 ± 13%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.70 ± 10%      +0.2        0.92 ± 12%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      1.12 ±  3%      +0.3        1.38 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.86 ±  7%      +0.3        1.13 ±  7%  perf-profile.children.cycles-pp.filemap_dirty_folio
      1.17 ±  5%      +0.3        1.44 ±  6%  perf-profile.children.cycles-pp.btrfs_release_path
      1.03 ±  5%      +0.3        1.30 ±  5%  perf-profile.children.cycles-pp.split_leaf
      2.05 ±  2%      +0.3        2.34 ±  4%  perf-profile.children.cycles-pp.__extent_writepage
      0.96 ± 17%      +0.3        1.26 ± 13%  perf-profile.children.cycles-pp.btrfs_extend_item
      1.76 ±  4%      +0.3        2.06 ±  5%  perf-profile.children.cycles-pp.find_extent_buffer
      2.18 ±  3%      +0.3        2.48 ±  4%  perf-profile.children.cycles-pp.extent_write_cache_pages
      2.19 ±  3%      +0.3        2.50 ±  4%  perf-profile.children.cycles-pp.extent_writepages
      1.01 ±  4%      +0.3        1.33 ±  7%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
      1.30 ± 13%      +0.3        1.62 ±  5%  perf-profile.children.cycles-pp.alloc_extent_buffer
      1.17 ±  9%      +0.3        1.50 ±  4%  perf-profile.children.cycles-pp.btrfs_bin_search
      1.56 ± 11%      +0.3        1.90 ±  8%  perf-profile.children.cycles-pp.btrfs_init_new_buffer
      2.22 ±  3%      +0.4        2.60 ±  5%  perf-profile.children.cycles-pp.start_ordered_ops
      1.21 ±  7%      +0.4        1.60 ±  8%  perf-profile.children.cycles-pp.extent_buffer_write_end_io
      1.92 ± 18%      +0.4        2.32 ±  5%  perf-profile.children.cycles-pp.__btrfs_add_free_space
      1.11 ±  5%      +0.4        1.51 ±  7%  perf-profile.children.cycles-pp.__folio_end_writeback
      1.93 ± 18%      +0.4        2.34 ±  5%  perf-profile.children.cycles-pp.unpin_extent_range
      1.21 ±  6%      +0.4        1.62 ±  7%  perf-profile.children.cycles-pp.folio_end_writeback
      1.53 ±  8%      +0.4        1.94 ±  5%  perf-profile.children.cycles-pp.copy_to_brd
      1.95 ± 18%      +0.4        2.38 ±  5%  perf-profile.children.cycles-pp.btrfs_finish_extent_commit
      2.92 ±  8%      +0.4        3.36 ±  6%  perf-profile.children.cycles-pp.setup_items_for_insert
      2.38 ±  6%      +0.5        2.87 ±  3%  perf-profile.children.cycles-pp.lookup_open
      2.10 ±  6%      +0.5        2.60 ±  6%  perf-profile.children.cycles-pp.insert_with_overflow
      2.45 ±  6%      +0.5        2.95 ±  4%  perf-profile.children.cycles-pp.open_last_lookups
      0.10 ± 10%      +0.5        0.61 ±  7%  perf-profile.children.cycles-pp.memset_orig
      2.02 ±  5%      +0.5        2.54 ±  4%  perf-profile.children.cycles-pp.btrfs_buffered_write
      2.04 ±  5%      +0.5        2.56 ±  4%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      2.14 ±  5%      +0.5        2.66 ±  4%  perf-profile.children.cycles-pp.ksys_write
      2.13 ±  5%      +0.5        2.65 ±  4%  perf-profile.children.cycles-pp.vfs_write
      1.10 ± 41%      +0.5        1.62 ±  7%  perf-profile.children.cycles-pp.csum_tree_block
      2.18 ±  5%      +0.5        2.70 ±  3%  perf-profile.children.cycles-pp.write
      2.27 ±  5%      +0.6        2.82 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      2.85 ±  5%      +0.6        3.43 ±  3%  perf-profile.children.cycles-pp.do_filp_open
      2.84 ±  5%      +0.6        3.42 ±  3%  perf-profile.children.cycles-pp.path_openat
      2.98 ±  5%      +0.6        3.56 ±  3%  perf-profile.children.cycles-pp.__x64_sys_openat
      2.98 ±  5%      +0.6        3.57 ±  3%  perf-profile.children.cycles-pp.open64
      2.97 ±  5%      +0.6        3.55 ±  3%  perf-profile.children.cycles-pp.do_sys_openat2
      1.14 ± 46%      +0.6        1.73 ±  6%  perf-profile.children.cycles-pp.crc_pcl
      1.71 ±  6%      +0.6        2.34 ±  4%  perf-profile.children.cycles-pp.write_one_eb
      2.56 ±  7%      +0.6        3.20 ±  7%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
      2.69 ±  5%      +0.6        3.34 ±  4%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      2.85 ±  5%      +0.7        3.51 ±  4%  perf-profile.children.cycles-pp.btrfs_add_link
      2.83 ±  5%      +0.7        3.52        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      3.27 ±  6%      +0.7        3.99 ±  5%  perf-profile.children.cycles-pp.brd_submit_bio
      3.40 ±  5%      +0.8        4.20 ±  7%  perf-profile.children.cycles-pp.vfs_mkdir
      2.06 ± 11%      +0.8        2.86 ±  3%  perf-profile.children.cycles-pp.__memmove
      6.35 ±  5%      +0.8        7.17 ±  2%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      4.28 ±  5%      +0.9        5.21 ±  5%  perf-profile.children.cycles-pp.btrfs_create_new_inode
      4.34 ±  5%      +1.0        5.34 ±  6%  perf-profile.children.cycles-pp.do_mkdirat
      4.40 ±  5%      +1.0        5.44 ±  5%  perf-profile.children.cycles-pp.__x64_sys_mkdir
      4.44 ±  5%      +1.1        5.51 ±  5%  perf-profile.children.cycles-pp.mkdir
      4.72 ±  6%      +1.1        5.82 ±  5%  perf-profile.children.cycles-pp.btrfs_create_common
      7.67 ±  2%      +1.2        8.90 ±  3%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      5.89 ±  5%      +1.4        7.30 ±  5%  perf-profile.children.cycles-pp.__submit_bio
      5.91 ±  5%      +1.4        7.32 ±  5%  perf-profile.children.cycles-pp.__submit_bio_noacct
      0.18 ± 57%      +1.6        1.80 ±  7%  perf-profile.children.cycles-pp.crc32c_pcl_intel_digest
     14.52 ±  5%      +1.8       16.37 ±  3%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.10 ± 19%      +5.5        5.64 ±  3%  perf-profile.children.cycles-pp.__memcpy
     12.72 ±  5%     -11.5        1.24 ±  7%  perf-profile.self.cycles-pp.read_extent_buffer
      5.04 ±  5%      -0.8        4.24 ±  2%  perf-profile.self.cycles-pp.btrfs_get_32
      0.88 ±  9%      -0.4        0.49 ± 13%  perf-profile.self.cycles-pp.btrfs_force_cow_block
      1.29 ±  3%      -0.2        1.14 ±  6%  perf-profile.self.cycles-pp.btrfs_get_64
      0.44 ± 17%      -0.1        0.32 ± 17%  perf-profile.self.cycles-pp.__btrfs_check_node
      0.34 ± 10%      -0.1        0.26 ± 13%  perf-profile.self.cycles-pp.__set_extent_bit
      0.11 ±  8%      +0.0        0.14 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.09 ± 14%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.filemap_get_folios_tag
      0.08 ± 10%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.btrfs_verify_level_key
      0.11 ± 11%      +0.0        0.15 ±  9%  perf-profile.self.cycles-pp.random_r
      0.09 ± 15%      +0.0        0.14 ± 18%  perf-profile.self.cycles-pp.write_one_eb
      0.02 ±141%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__strncat_chk
      0.03 ±100%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.add_delayed_ref_head
      0.16 ± 15%      +0.0        0.20 ± 11%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.14 ± 11%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.btrfs_release_path
      0.12 ± 12%      +0.1        0.17 ± 14%  perf-profile.self.cycles-pp.inode_tree_add
      0.14 ± 14%      +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.06 ± 51%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.check_dir_item
      0.09 ± 21%      +0.1        0.15 ± 19%  perf-profile.self.cycles-pp.rb_next
      0.25 ± 14%      +0.1        0.31 ±  7%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.23 ±  5%      +0.1        0.29 ± 10%  perf-profile.self.cycles-pp.down_write
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.20 ± 15%      +0.1        0.27 ±  9%  perf-profile.self.cycles-pp.xas_load
      0.12 ± 15%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.mark_page_accessed
      0.12 ± 24%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.check_inode_key
      0.32 ±  9%      +0.1        0.40 ± 11%  perf-profile.self.cycles-pp.release_extent_buffer
      0.22 ± 13%      +0.1        0.30 ± 16%  perf-profile.self.cycles-pp.btrfs_root_node
      0.46 ±  5%      +0.1        0.55 ±  4%  perf-profile.self.cycles-pp.xa_load
      0.33 ±  8%      +0.1        0.44 ± 11%  perf-profile.self.cycles-pp.kmem_cache_free
      0.25 ± 10%      +0.1        0.37 ±  6%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.58 ± 10%      +0.1        0.73 ±  8%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.50 ±  5%      +0.2        0.65 ±  4%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.66 ± 11%      +0.2        0.81 ±  8%  perf-profile.self.cycles-pp.btrfs_set_token_32
      1.17 ±  5%      +0.2        1.34 ±  3%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.84 ±  4%      +0.2        1.01 ±  7%  perf-profile.self.cycles-pp.xas_descend
      0.02 ±144%      +0.2        0.20 ± 15%  perf-profile.self.cycles-pp.alloc_extent_state
      1.05 ±  9%      +0.2        1.24 ± 11%  perf-profile.self.cycles-pp.brd_submit_bio
      0.95 ±  2%      +0.2        1.17 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.90 ± 12%      +0.3        1.23 ±  6%  perf-profile.self.cycles-pp.copy_to_brd
      1.12 ±  9%      +0.3        1.47 ±  3%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.09 ± 14%      +0.5        0.60 ±  7%  perf-profile.self.cycles-pp.memset_orig
      1.98 ±  7%      +0.5        2.51 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      1.08 ± 45%      +0.6        1.66 ±  4%  perf-profile.self.cycles-pp.crc_pcl
      2.04 ± 11%      +0.8        2.84 ±  3%  perf-profile.self.cycles-pp.__memmove
      0.10 ± 21%      +5.3        5.38 ±  3%  perf-profile.self.cycles-pp.__memcpy


***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/btrfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/webproxy.f/filebench

commit: 
  28409dbb2d ("btrfs: map uncontinuous extent buffer pages into virtual address space")
  c1ad4ede87 ("btrfs: utilize the physically/virtually continuous extent buffer memory")

28409dbb2d3d30a0 c1ad4ede8771bf666965ea9f35a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.92            +9.5%       5.39        iostat.cpu.system
     67.33 ±  2%     +20.3%      81.00 ± 15%  perf-c2c.DRAM.local
      2.11            +0.5        2.61        mpstat.cpu.all.sys%
      0.39            +0.0        0.44        mpstat.cpu.all.usr%
     30.00 ± 14%     +72.3%      51.68 ± 39%  sched_debug.cfs_rq:/.avg_vruntime.min
     30.00 ± 14%     +72.3%      51.68 ± 39%  sched_debug.cfs_rq:/.min_vruntime.min
      1915            +6.4%       2038        vmstat.io.bo
      3.43 ± 13%     +39.9%       4.79 ±  2%  vmstat.procs.r
     31588           +14.2%      36064        vmstat.system.cs
    386538 ± 11%     +25.0%     483075 ±  5%  numa-numastat.node0.local_node
    103085 ±  9%     -60.5%      40668 ±  8%  numa-numastat.node0.other_node
    532316 ±  8%     -12.9%     463505 ±  6%  numa-numastat.node1.local_node
     32460 ± 29%    +194.6%      95640 ±  3%  numa-numastat.node1.other_node
    219479 ±  5%     +53.6%     337217 ± 27%  numa-meminfo.node0.AnonHugePages
     20272 ±  4%     +10.4%      22378 ±  5%  numa-meminfo.node0.KernelStack
   2386844 ± 46%     +43.5%    3424168 ± 30%  numa-meminfo.node0.MemUsed
   1032828 ±111%     +86.2%    1923343 ± 62%  numa-meminfo.node0.Unevictable
   3662930 ± 30%     -26.7%    2684133 ± 39%  numa-meminfo.node1.MemUsed
   1742560 ± 65%     -51.1%     852027 ±141%  numa-meminfo.node1.Unevictable
    136.33           +13.2%     154.33        turbostat.Avg_MHz
      2125            +4.5%       2222        turbostat.Bzy_MHz
   1348070            +9.7%    1478314        turbostat.C1E
      4.26            +0.4        4.69        turbostat.C1E%
     11.95           +10.2%      13.16        turbostat.CPU%c1
    219.78            +1.8%     223.66        turbostat.PkgWatt
     55452 ± 15%    +212.6%     173330 ± 40%  numa-vmstat.node0.nr_foll_pin_acquired
     55434 ± 15%    +212.6%     173293 ± 40%  numa-vmstat.node0.nr_foll_pin_released
     20273 ±  4%     +10.4%      22378 ±  5%  numa-vmstat.node0.nr_kernel_stack
    258207 ±111%     +86.2%     480835 ± 62%  numa-vmstat.node0.nr_unevictable
    258207 ±111%     +86.2%     480835 ± 62%  numa-vmstat.node0.nr_zone_unevictable
    386324 ± 11%     +25.1%     483163 ±  5%  numa-vmstat.node0.numa_local
    103085 ±  9%     -60.5%      40668 ±  8%  numa-vmstat.node0.numa_other
    435640 ± 65%     -51.1%     213006 ±141%  numa-vmstat.node1.nr_unevictable
    435640 ± 65%     -51.1%     213006 ±141%  numa-vmstat.node1.nr_zone_unevictable
    532137 ±  8%     -12.9%     463483 ±  6%  numa-vmstat.node1.numa_local
     32460 ± 29%    +194.6%      95640 ±  3%  numa-vmstat.node1.numa_other
     13.83            +9.9%      15.20        filebench.sum_bytes_mb/s
    237321           +12.4%     266717        filebench.sum_operations
      3955           +12.4%       4444        filebench.sum_operations/s
      1040           +12.4%       1169        filebench.sum_reads/s
     25.23           -11.0%      22.45        filebench.sum_time_ms/op
    208.00           +12.5%     234.00        filebench.sum_writes/s
    506317            +6.0%     536552        filebench.time.file_system_outputs
   1028478            -2.0%    1007814        filebench.time.maximum_resident_set_size
     64782            +7.5%      69671 ±  3%  filebench.time.minor_page_faults
    176.00           +32.6%     233.33        filebench.time.percent_of_cpu_this_job_got
    133.48           +27.7%     170.51        filebench.time.system_time
    342211           +10.8%     379321        filebench.time.voluntary_context_switches
     20985            +3.6%      21748        proc-vmstat.nr_active_anon
     19805            +2.3%      20251        proc-vmstat.nr_active_file
    306004            +3.1%     315456        proc-vmstat.nr_anon_pages
    132728            +5.9%     140566        proc-vmstat.nr_dirtied
     13744            +3.0%      14150        proc-vmstat.nr_dirty
    222039 ±  9%     +67.0%     370845 ± 11%  proc-vmstat.nr_foll_pin_acquired
    221988 ±  9%     +67.0%     370758 ± 11%  proc-vmstat.nr_foll_pin_released
    320223            +2.9%     329594        proc-vmstat.nr_inactive_anon
     28658            -4.0%      27505        proc-vmstat.nr_inactive_file
     25780            +1.2%      26083        proc-vmstat.nr_mapped
     35154            +2.3%      35963        proc-vmstat.nr_shmem
     98583            +4.9%     103385        proc-vmstat.nr_written
     20985            +3.6%      21748        proc-vmstat.nr_zone_active_anon
     19805            +2.3%      20251        proc-vmstat.nr_zone_active_file
    320223            +2.9%     329594        proc-vmstat.nr_zone_inactive_anon
     28658            -4.0%      27505        proc-vmstat.nr_zone_inactive_file
     13764            +2.9%      14165        proc-vmstat.nr_zone_write_pending
     21589 ±  4%     +21.5%      26226 ±  8%  proc-vmstat.numa_hint_faults
     15255 ±  9%     +34.3%      20491 ±  4%  proc-vmstat.numa_hint_faults_local
   1056823            +2.7%    1085262        proc-vmstat.numa_hit
    772.00 ± 12%     +30.0%       1003 ±  7%  proc-vmstat.numa_huge_pte_updates
    921285            +3.0%     948940        proc-vmstat.numa_local
    495830 ± 10%     +26.3%     626033 ±  6%  proc-vmstat.numa_pte_updates
     89171            +6.0%      94520        proc-vmstat.pgactivate
   1734683            +2.2%    1772993        proc-vmstat.pgalloc_normal
   1619325            +1.3%    1641053        proc-vmstat.pgfree
    152597            +2.8%     156926        proc-vmstat.pgpgout
    752640            -3.4%     727040        proc-vmstat.unevictable_pgs_scanned
      7.84 ± 14%      -3.9        3.94 ± 32%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.88 ± 18%      -3.8        3.12 ± 26%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.88 ± 18%      -3.8        3.12 ± 26%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      7.84 ± 14%      -3.4        4.41 ± 34%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      7.84 ± 14%      -3.4        4.41 ± 34%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      7.84 ± 14%      -3.4        4.41 ± 34%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      7.84 ± 14%      -3.4        4.41 ± 34%  perf-profile.calltrace.cycles-pp.read
      5.75 ±  7%      -2.6        3.12 ± 26%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      5.01 ±  4%      -2.2        2.76 ± 13%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.17 ± 23%      -2.1        3.12 ± 26%  perf-profile.calltrace.cycles-pp.proc_pid_status.proc_single_show.seq_read_iter.seq_read.vfs_read
      0.68 ± 73%      +0.9        1.58 ± 32%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      1.02 ± 12%      +1.0        2.05 ± 35%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.74 ± 71%      +1.2        1.91 ± 47%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.63 ± 71%      +1.3        1.91 ± 47%  perf-profile.calltrace.cycles-pp._dl_addr
      0.00            +1.6        1.56 ± 26%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +1.7        1.67 ± 48%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.81 ± 67%      +1.8        3.59 ± 25%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      1.81 ± 67%      +1.8        3.59 ± 25%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      2.49 ± 64%      +2.3        4.79 ± 20%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      8.82 ±  8%      -4.1        4.67 ± 26%  perf-profile.children.cycles-pp.vfs_read
      8.19 ± 12%      -3.8        4.41 ± 34%  perf-profile.children.cycles-pp.ksys_read
      6.88 ± 18%      -3.8        3.12 ± 26%  perf-profile.children.cycles-pp.seq_read
      7.55 ± 18%      -3.6        3.94 ± 32%  perf-profile.children.cycles-pp.seq_read_iter
      7.84 ± 14%      -3.4        4.41 ± 34%  perf-profile.children.cycles-pp.read
      5.46 ± 15%      -2.3        3.12 ± 26%  perf-profile.children.cycles-pp.proc_single_show
      5.46 ± 15%      -2.3        3.12 ± 26%  perf-profile.children.cycles-pp.proc_pid_status
      2.33 ±  9%      -1.5        0.85 ± 71%  perf-profile.children.cycles-pp.__x64_sys_close
      0.74 ± 71%      +0.8        1.56 ± 26%  perf-profile.children.cycles-pp.step_into
      0.74 ± 71%      +0.8        1.58 ± 32%  perf-profile.children.cycles-pp.release_pages
      1.02 ± 12%      +1.0        2.05 ± 35%  perf-profile.children.cycles-pp.wp_page_copy
      0.74 ± 71%      +1.2        1.91 ± 47%  perf-profile.children.cycles-pp.load_elf_interp
      0.63 ± 71%      +1.3        1.91 ± 47%  perf-profile.children.cycles-pp._dl_addr
      0.00            +1.6        1.56 ± 26%  perf-profile.children.cycles-pp.vm_area_alloc
      3.07 ± 12%      +1.8        4.90 ± 31%  perf-profile.children.cycles-pp.exit_mmap
      0.34 ±141%      +2.1        2.43 ± 41%  perf-profile.children.cycles-pp.dentry_kill
      3.07 ± 12%      +2.2        5.28 ± 23%  perf-profile.children.cycles-pp.__mmput
      2.49 ± 64%      +2.3        4.79 ± 20%  perf-profile.children.cycles-pp.exit_mm
      0.63 ± 71%      +1.3        1.91 ± 47%  perf-profile.self.cycles-pp._dl_addr
      0.46 ±  2%      -4.4%       0.44 ±  2%  perf-stat.i.MPKI
 2.137e+09           +18.1%  2.523e+09        perf-stat.i.branch-instructions
      1.35 ±  2%      -0.2        1.19 ±  2%  perf-stat.i.branch-miss-rate%
  27931271            +3.8%   29004269        perf-stat.i.branch-misses
      2.17            +0.1        2.30        perf-stat.i.cache-miss-rate%
   4217451           +10.8%    4672796        perf-stat.i.cache-misses
 1.915e+08            +4.6%  2.003e+08        perf-stat.i.cache-references
     32140           +15.0%      36946        perf-stat.i.context-switches
      1.66            -1.3%       1.64        perf-stat.i.cpi
 1.555e+10           +15.3%  1.792e+10        perf-stat.i.cpu-cycles
    883.71           +13.7%       1004        perf-stat.i.cpu-migrations
      0.27            -0.0        0.24        perf-stat.i.dTLB-load-miss-rate%
   6177823            +4.4%    6450964        perf-stat.i.dTLB-load-misses
 2.466e+09           +16.0%  2.861e+09        perf-stat.i.dTLB-loads
      0.06            -0.0        0.05        perf-stat.i.dTLB-store-miss-rate%
 1.159e+09           +14.2%  1.324e+09        perf-stat.i.dTLB-stores
 9.473e+09           +15.8%  1.097e+10        perf-stat.i.instructions
      0.61            +2.3%       0.63        perf-stat.i.ipc
      0.12           +15.3%       0.14        perf-stat.i.metric.GHz
     24.13            +7.6%      25.97        perf-stat.i.metric.K/sec
     46.49           +16.0%      53.94        perf-stat.i.metric.M/sec
      4029            +3.7%       4179        perf-stat.i.minor-faults
    220371 ±  9%     +24.1%     273439 ±  8%  perf-stat.i.node-loads
    444063 ±  3%      +9.4%     485797 ±  2%  perf-stat.i.node-store-misses
    779660 ±  2%      +9.3%     852063 ±  2%  perf-stat.i.node-stores
      4029            +3.7%       4180        perf-stat.i.page-faults
      0.45 ±  2%      -4.3%       0.43        perf-stat.overall.MPKI
      1.31            -0.2        1.15        perf-stat.overall.branch-miss-rate%
      2.20            +0.1        2.33        perf-stat.overall.cache-miss-rate%
      3688            +4.0%       3836        perf-stat.overall.cycles-between-cache-misses
      0.25            -0.0        0.23        perf-stat.overall.dTLB-load-miss-rate%
      0.06            -0.0        0.05        perf-stat.overall.dTLB-store-miss-rate%
 2.108e+09           +18.0%  2.488e+09        perf-stat.ps.branch-instructions
  27545498            +3.8%   28590050        perf-stat.ps.branch-misses
   4160934           +10.7%    4607859        perf-stat.ps.cache-misses
 1.889e+08            +4.5%  1.975e+08        perf-stat.ps.cache-references
     31718           +14.9%      36440        perf-stat.ps.context-switches
 1.534e+10           +15.2%  1.768e+10        perf-stat.ps.cpu-cycles
    872.32           +13.6%     991.24        perf-stat.ps.cpu-migrations
   6095596            +4.4%    6361893        perf-stat.ps.dTLB-load-misses
 2.434e+09           +15.9%  2.821e+09        perf-stat.ps.dTLB-loads
 1.144e+09           +14.2%  1.306e+09        perf-stat.ps.dTLB-stores
 9.346e+09           +15.7%  1.082e+10        perf-stat.ps.instructions
      3968            +3.7%       4115        perf-stat.ps.minor-faults
    217462 ±  9%     +24.0%     269699 ±  8%  perf-stat.ps.node-loads
    438250 ±  3%      +9.3%     479117 ±  2%  perf-stat.ps.node-store-misses
    768957 ±  2%      +9.2%     840056 ±  2%  perf-stat.ps.node-stores
      3969            +3.7%       4115        perf-stat.ps.page-faults
 7.167e+11           +11.6%  8.001e+11        perf-stat.total.instructions
      0.01 ± 14%     +34.3%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__flush_work.isra.0.__cancel_work_timer
      0.02 ± 13%     -33.8%       0.02 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.cifs_strndup_to_utf16.cifs_convert_path_to_utf16
      0.00 ± 81%    +866.7%       0.01 ± 56%  perf-sched.sch_delay.avg.ms.__cond_resched.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      0.02 ±  2%     +12.1%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet_recvmsg
      0.03 ±  4%    +331.2%       0.13 ±107%  perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      0.06 ±  3%     +19.9%       0.07 ±  2%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ± 75%     -68.9%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±106%    +215.1%       0.08 ± 37%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.07 ±  3%     +13.7%       0.08 ±  5%  perf-sched.sch_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.01 ± 19%     -38.5%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.02            -8.5%       0.02 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.02 ± 16%    +124.7%       0.05 ± 27%  perf-sched.sch_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_lease_break
      0.11 ± 41%     -44.1%       0.06 ± 27%  perf-sched.sch_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
      0.29 ± 16%    +148.8%       0.72        perf-sched.sch_delay.max.ms.__cond_resched.dput.cifsFileInfo_put_final._cifsFileInfo_put.process_one_work
      0.09 ± 10%     +27.8%       0.12 ±  8%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.42 ±110%     -93.0%       0.03 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.cifs_do_create.isra.0
      0.13 ± 30%     +60.1%       0.20 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ± 98%   +1511.1%       0.05 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      0.05 ± 36%    +114.2%       0.11 ± 26%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.08 ± 65%     -84.6%       0.01 ± 35%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.44 ± 31%     -36.3%       0.28 ± 13%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cifs_call_async
      0.41 ±  2%     -21.8%       0.32 ±  7%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.03 ±  8%    +288.4%       0.11 ± 96%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.45 ± 47%    +100.8%       0.91 ± 29%  perf-sched.sch_delay.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_lease_break
    247.81 ±  9%     -41.3%     145.44 ± 70%  perf-sched.sch_delay.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
    357.24 ± 10%     -17.0%     296.58 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__flush_work.isra.0.__cancel_work_timer
     32.30 ± 10%     +21.4%      39.22 ±  6%  perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      1.07           -21.0%       0.85        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
     90.92 ± 25%     +61.6%     146.94 ± 15%  perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
    359.76            -8.3%     330.05 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.06           -15.5%       0.89        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     23.91 ± 13%     -28.7%      17.04 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.21           -10.0%       0.19        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    223.90 ±  2%     -11.2%     198.88 ±  3%  perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      2.65           -24.5%       2.00        perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.query_info
     21.95           -13.2%      19.05        perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
      5.77 ±  9%    +190.7%      16.78 ±  6%  perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
      3.67 ± 46%     -90.9%       0.33 ±141%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.cifs_do_create.isra.0
      1019           +15.2%       1174        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     54.67 ± 29%     -39.6%      33.00 ± 17%  perf-sched.wait_and_delay.count.kthreadd.ret_from_fork.ret_from_fork_asm
     46.67            +9.3%      51.00 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     10143           +21.9%      12365        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1659 ±  8%     +28.9%       2139 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.compound_send_recv
    970.33           +14.7%       1113        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1039           +16.7%       1212        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
     57.67 ± 33%     -42.8%      33.00 ± 16%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
     22455           +11.1%      24957        perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      1004           +15.9%       1164        perf-sched.wait_and_delay.count.wait_for_response.compound_send_recv.cifs_send_recv.query_info
      1007           +15.3%       1161        perf-sched.wait_and_delay.count.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
      2409 ± 11%     -46.9%       1279 ± 30%  perf-sched.wait_and_delay.max.ms.__cond_resched.__flush_work.isra.0.__cancel_work_timer
    260.91           -70.6%      76.58 ±141%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.cifs_do_create.isra.0
      2.79 ±  4%     -22.7%       2.16 ±  7%  perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet_recvmsg
      1171 ± 27%    +118.4%       2558 ± 33%  perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      2025 ± 39%     -50.6%       1000        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4.64 ± 15%     +50.0%       6.95 ± 23%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    292.05 ±  3%     -15.3%     247.30 ±  4%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    286.18 ±  3%     -12.9%     249.36 ±  5%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    292.95 ±  3%     -13.8%     252.51 ±  4%  perf-sched.wait_and_delay.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
    291.77 ±  3%     -13.7%     251.77 ±  5%  perf-sched.wait_and_delay.max.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
    357.23 ± 10%     -17.0%     296.57 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__flush_work.isra.0.__cancel_work_timer
      1.78 ±  9%     -13.6%       1.54 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.dput.cifsFileInfo_put_final._cifsFileInfo_put.process_one_work
     32.27 ± 10%     +21.1%      39.09 ±  6%  perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      1.03           -21.9%       0.81        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
     89.03 ± 25%     +65.0%     146.89 ± 15%  perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
    359.75            -8.3%     330.05 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.03           -15.8%       0.87        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.00 ±  4%     -14.7%       0.86 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cifs_call_async
      1.29 ± 71%    +139.6%       3.09 ± 53%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     23.89 ± 13%     -28.8%      17.02 ± 10%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1.15 ±  6%     -24.3%       0.87 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__cifs_readv
      0.20           -10.9%       0.18        perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      2.18 ± 68%     -58.0%       0.92 ±  6%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_lease_break
    223.71 ±  2%     -11.1%     198.85 ±  3%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      2.58           -25.3%       1.92        perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.query_info
     21.91 ±  2%     -13.3%      19.00        perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
      5.73 ± 10%    +191.9%      16.74 ±  6%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
      2409 ± 11%     -46.9%       1279 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.__flush_work.isra.0.__cancel_work_timer
      2.96 ±  7%     -40.3%       1.76 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
    260.88           -70.7%      76.55 ±141%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.cifs_do_create.isra.0
     21.15 ±138%   +1309.8%     298.20 ± 70%  perf-sched.wait_time.max.ms.__cond_resched.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      2.68 ±  3%     -25.8%       1.98 ±  4%  perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet_recvmsg
      1171 ± 27%    +118.4%       2558 ± 33%  perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      2.51 ±  3%     -23.5%       1.92        perf-sched.wait_time.max.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      2025 ± 39%     -50.6%       1000        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.19 ± 19%     +46.4%       0.28 ± 10%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     13.47 ±  8%     +11.8%      15.06 ±  9%  perf-sched.wait_time.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      4.59 ± 15%     +43.1%       6.57 ± 29%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    291.96 ±  3%     -15.3%     247.19 ±  4%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    286.05 ±  3%     -12.9%     249.28 ±  5%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      7.89 ± 40%     -46.1%       4.25 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__cifs_readv
      8.94 ± 60%     -46.1%       4.81 ±106%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     56.62 ±131%     -94.2%       3.26 ± 10%  perf-sched.wait_time.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_lease_break
    292.89 ±  3%     -13.8%     252.44 ±  4%  perf-sched.wait_time.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
    291.71 ±  3%     -13.7%     251.71 ±  5%  perf-sched.wait_time.max.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

