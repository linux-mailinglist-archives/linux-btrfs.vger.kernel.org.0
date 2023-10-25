Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452417D65B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjJYItD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjJYItA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 04:49:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2E19D
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698223733; x=1729759733;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=z6Xv7NYFixQjy6nPxLbBFubI7Ak1b0nQEPawjJLyvsk=;
  b=auaXtCoKxmtWKKBiemklT240SaJWY05VlZqPk3WC8dTIgcqqy0Ue4COc
   OnHJyE+RnIh3U2sqWEYONg4eTw9YchpZt+SiLz67lhnx4rCRxJC+47aQM
   hYHsPsbAFA603Um281SZ4Xu7XSM368nnEUuHraY25yHhUl/b+SdVlKTRV
   5jSsf9eETmIkOUzC/4x7vUE+m8uxaH80Ag16cHWazzEpD40zKvr8EaK3C
   J92furzhdOPaBsGjJe4YkGiGInSSwpWLb5bUFppBuRhf2eVPinI+03c3Z
   MsCtho2IKx6xa0p67WpwEioAxa73ktrOQI3eYXgMp49A6ZBV4ukuTfAbH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="390120968"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390120968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 01:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="27125"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 01:48:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:48:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:48:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 01:48:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 01:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frBQ6jqZpBd2A1G1dejWqshn0CdKdM8gnNRJIxZ4owX7UKTjLHsrmMOQlD5cOa13e3mDtxkNjzr29GcSv4cXhQ3Jka0+noW5JHTjYLFPmRfnmjDWZCZgxk+UFCsYQWCs4JHkwufIDA4aNkv08UReVgkW1fBofWUTGrCO3FdvSs4OjZ85O50IbLYuakbaQLYJjKFp40pYeBsSynXrSCjRXK3U3WNHIfTajxUYhVCVZ0S0NZWFWtTaLJ29j350sz3A3GU5lSmXJvDVsNGBydaLJ+fHSk8J0WJ3lJkXwgl7TurU64bO3U5zZQCYyN99pOM/rBEmtqcVMY6QOmXHidBKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs5vWxDBGMZr0iCUPtmktI/75MPKRn67tx/P8Zps7HA=;
 b=CiIvk73jVuEURJxI1p/Rl0ckhwSTOMrVXAmfy6qhcXW412r8zx2xvZcX7CVgeOh22O5i25idjkXEX2/+5sSe9wYwEY7p6J1lkwLppSu4Cki1eRkVXCTdDiSxycjmIKB1It5MqHZPj6ttybizaXyJ4sNUy9OkrkrrtfbcRywH4DZh1qDhx2vos2NLB7aGtN+KofdlolUx2e5rHISDT46TPZK8z4jalz7PcXmAME34lB5wZdnR4JCBCJtaXmG+gOcXVYRDgwawY74cc6mRjr9ccCR2AaFVNVlTTYzH6ktqxpE2WyBYlQYguTaKVOavYjPegiavNG/pEiprybJfqrxBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:48:40 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 08:48:39 +0000
Date:   Wed, 25 Oct 2023 16:48:31 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Filipe Manana <fdmanana@suse.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  28270e25c6:
 fxmark.ssd_btrfs_MWUM_72_bufferedio.works/sec -90.4% regression
Message-ID: <202310251607.fb6746aa-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CYYPR11MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: fa578a5b-3ba5-42d6-4349-08dbd5372ee0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaWUE5byLSbLUr2vrvUB3srTG7H88gQdrOUh3J8b5ALR11rV6plx54vb4kVH1QhA4Uxfjw/vAftPsTPvC+HzB7AhxkvesVipQG+2hvMXckZSU4zpshDwI8o/9ou9oLgATbf6dsyQZ2TggUgCIgcemLCNR5343awDY4IeCPJagGxR0a/Ddn5OmVx8UNtyrKGEF0dSLrgUqLuTUsB/oyEKCz6lVr4h4Q7fVCooPwwAe/9/sPysKu2YEvbLinOFpsA8efag1Nnyko63IWw0g7L5Pr0Kc7TBpPW4hWXpKHeeHymfJHt0gNda2dBadtiqUjLLrjJyeXLB3jw+NIYB3mq2GByFHeKxgYEJvmASs6LGbyUZscSgmc9Wd/wPhF5iXIFHnyObatac5xtncLKLUYGEKGUFuGDLLAOsmF8AqH1aDtv7qN0YBkTtDaIB+PJCWlzqjfZzkuCrYI6eun5yM1opt2LNkVrpIwEEDVrC6rYhAevJsmxjH9HCWBjFCqWYfp099SoJMVKwrJ1Lm3GJ5I+sYhRNBYRrXmXPpC2Vk/4E90APhT/vF6LbJF910B55bjXH35YSEiefrPyYPAb/Y9gq7/uKZEHhJmH1HfXDpZWNZYS1dODI4GrDCQQcwNBgwii0bRwIQ9ir/5smjUDytzOGMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(36756003)(38100700002)(2906002)(30864003)(41300700001)(5660300002)(86362001)(316002)(8936002)(8676002)(4326008)(107886003)(478600001)(6506007)(1076003)(66476007)(82960400001)(66946007)(6916009)(66556008)(54906003)(2616005)(83380400001)(966005)(6486002)(6512007)(6666004)(579004)(559001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TEmjiQWtvK9fSGpu//x9SE4yWYBPaxtDQ6tnb7gGhZWKsaV2XCwdFkz1F3?=
 =?iso-8859-1?Q?/mroGsLUrO9unye5ZJHK0+hD5LtdJbVPjcYgJepWbtOL7LUpODN7eCeGe0?=
 =?iso-8859-1?Q?0PdvJlS50IJrb8GBsB3B0s+hRFiPu29Y2/QjbIoilzwtg65slD2JdLlJ7C?=
 =?iso-8859-1?Q?PyR/dMnNpkOdpQMDk+Dnf8N2jJLl1qomGqhhx5FcDAoD54HBt1xVaWnvlo?=
 =?iso-8859-1?Q?11R6KPa12QTbGAeHuJicTSyU4Q9RBuIeu7NKx/sFihAC+MJLQ1rEiDt5Cl?=
 =?iso-8859-1?Q?rDPU4R4b6ti4W8/BZCjHbzgV8h1uGRWjHdu0tZ8zFlG01nDxETin3cyHe4?=
 =?iso-8859-1?Q?LHNv8Ehof6poxpftx6UAdCO6bwWYhBUjfaZbS5H1RAFlwxRTfW/YkEMugD?=
 =?iso-8859-1?Q?pSI+4/0w46UyreSy0avKQ6E3RP6xnU2B7WXovncaivKbot1OZv06oyCTh/?=
 =?iso-8859-1?Q?An5gGbk6czUS6KxdVlqc7tC/HXb0JT8J8oSR6sCqNIK5bNCKx/J7FTo7Qy?=
 =?iso-8859-1?Q?vfBI+vjltIWaW050ctZhxPiLllTBqYTSVjebrf2wAHxkk0xtxMydHZtbNL?=
 =?iso-8859-1?Q?vmRk5gutVRXa8jfr28HnJb+BPmKkZUv+Jgd5tZxYjYgTfgyrDLYZi8Kqpv?=
 =?iso-8859-1?Q?ee9gnLFPJd0UKxLuSybk89ESoZ9InmRB0JuVvtgKkHgwzwT68iqdk7cktr?=
 =?iso-8859-1?Q?2+qVhJEGV4WE7dSMTsTzzZv1NkDbiHW5u0TOkpouMyOZs9xwZcarW/vXSl?=
 =?iso-8859-1?Q?ca2SzgPZG17F2YfDPWz0yZJyzA6MCfFK3zDCiqFITdpTfaALfm8MesDcMJ?=
 =?iso-8859-1?Q?4urxqD/FLFzwEebdC6v5MS4ftavkJBn/Tnr0tQ0RgWqvZCUUd/HESw/fGj?=
 =?iso-8859-1?Q?QG5ClVUavtt7oPm5wYV6caiA9ryXqAZvNBzUDXjuvF6MZyH839auwgeQnl?=
 =?iso-8859-1?Q?qlnA0dx3TY/Qwgwn46iDb7kzmzASBS5AjFohUhC4Xv9xXD00BvHnYQhWRN?=
 =?iso-8859-1?Q?IykHhDRF3Dv4rBhkN/aexa3P3srOb/OE6PXyqmrPtE1BDXDEBGYwW8euMn?=
 =?iso-8859-1?Q?Y9CjE3qtrkrgKAJbd44b1GIRTKwy3i9ZF1x4I9Ne57/kxWLqWgk7/NlH6B?=
 =?iso-8859-1?Q?SSUA1lrgA3YXusScU8XzXsYnaEwYfXYBn6h6rzFHQNRVlNPXjTWQO2i4IU?=
 =?iso-8859-1?Q?vbGmgyFKFEeepp18ub3YWcVB6jn+Ml2SP7nG/L9x+ZnDYOQvp3PNgaKC//?=
 =?iso-8859-1?Q?yGyTYmXMbGeWhT2hQvsoECVDWTcJy9Pr1JQc494QeHt+BwvX6noRM8gz+K?=
 =?iso-8859-1?Q?y9iwF9LNDw8Dcui9nBUzGzYhKPjoR99g1TfWRwcAu5G5QOYtroNGw1F1tU?=
 =?iso-8859-1?Q?wNoCfkgnia0VvEHX6AGaAdCPmqf/eXE5fILglj3j2kTEtbzAYu6VtC6oh5?=
 =?iso-8859-1?Q?Kg4+HiIy2oWWmUvqIavdy425nMcSnO1t6bRq4l25Nh6I6ue+F+iR0ROSVh?=
 =?iso-8859-1?Q?9WYcAHO0KA9HyjU8W6L1u/sL3w94CNadbUQ/pPAW3FtOpmA9zynA0+/pcG?=
 =?iso-8859-1?Q?OBZJeqpdeSkhDTXs9I37MY6NUToJlyV5FSp26a55QPrOsqvXWLkZirz8+r?=
 =?iso-8859-1?Q?69I4s8FS29yknUnjn/051asvQyI6RyOjE63DpM4yE7KMyT/x+Nn2c0Zw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa578a5b-3ba5-42d6-4349-08dbd5372ee0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:48:39.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w91NPSG9N65o6PTMRHlONzB0zhYioUyPiArmpOpDEijmQTCw8nLNOAE2LIVh0QieXS2J7NzxLeXM5jnJibF3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


hi,

we reported
"[kdave-btrfs-devel:dev/guilherme/temp-fsid-v4] [btrfs]  6c9131ed0d: stress-ng.sync-file.ops_per_sec -44.2% regression"
in
https://lore.kernel.org/all/202309261552.a03eeb4c-oliver.sang@intel.com/
when this commit is:
commit: 6c9131ed0d644324adeeaccd2feeef8d04950b2d ("btrfs: always reserve space for delayed refs when starting transaction")
https://github.com/kdave/btrfs-devel.git dev/guilherme/temp-fsid-v4

we also noticed from
https://lore.kernel.org/all/20230927174741.GB13697@twin.jikos.cz/
the decision is to keep this patch, the performance issue will be addressed
later.

now this commit is in linux-next/master, we captured the regression from fxmark
tests. below fomal report FYI.


Hello,

kernel test robot noticed a -90.4% regression of fxmark.ssd_btrfs_MWUM_72_bufferedio.works/sec on:


commit: 28270e25c69a2c76ea1ed0922095bffb9b9a4f98 ("btrfs: always reserve space for delayed refs when starting transaction")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: fxmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1SSD
	media: ssd
	test: MWUM
	fstype: btrfs
	directio: bufferedio
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_btrfs_MWUL_72_bufferedio.works/sec -28.2% regression                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | directio=bufferedio                                                                            |
|                  | disk=1SSD                                                                                      |
|                  | fstype=btrfs                                                                                   |
|                  | media=ssd                                                                                      |
|                  | test=MWUL                                                                                      |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310251607.fb6746aa-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231025/202310251607.fb6746aa-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase:
  gcc-12/performance/bufferedio/1SSD/btrfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/MWUM/fxmark

commit: 
  adb86dbe42 ("btrfs: stop doing excessive space reservation for csum deletion")
  28270e25c6 ("btrfs: always reserve space for delayed refs when starting transaction")

adb86dbe426f9a54 28270e25c69a2c76ea1ed092209 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.182e+10           +49.2%  1.765e+10        cpuidle..time
  18434083           +41.5%   26079717        cpuidle..usage
     66.37            -6.6%      62.02        iostat.cpu.idle
     11.56 ±  5%     +46.8%      16.96 ±  3%  iostat.cpu.iowait
    402.88           +69.2%     681.86        uptime.boot
    868.42           +25.6%       1090 ±  2%  uptime.idle
     11.55 ±  5%      +5.4       16.95 ±  3%  mpstat.cpu.all.iowait%
      0.77 ±  2%      +0.1        0.90        mpstat.cpu.all.soft%
      0.79 ±  3%      -0.3        0.46 ±  4%  mpstat.cpu.all.usr%
   3689063           +78.6%    6587203 ±  4%  numa-numastat.node0.local_node
   3761439           +76.8%    6649880 ±  4%  numa-numastat.node0.numa_hit
    671523 ±  9%     +28.8%     864720 ± 12%  numa-numastat.node1.local_node
    732654 ± 10%     +27.7%     935498 ±  8%  numa-numastat.node1.numa_hit
     82.83 ± 27%     -59.0%      34.00 ± 12%  perf-c2c.DRAM.local
    324.00 ± 24%     -51.9%     155.83 ±  9%  perf-c2c.DRAM.remote
    626.67 ± 10%     -18.3%     512.17 ±  4%  perf-c2c.HITM.local
    179.50 ± 25%     -50.0%      89.67 ± 13%  perf-c2c.HITM.remote
     11.70 ±  4%     +46.5%      17.14 ±  3%  vmstat.cpu.wa
    222118            +4.7%     232540        vmstat.io.bo
   4263747           +25.5%    5351763        vmstat.memory.cache
      0.93 ±  3%     +29.2%       1.20 ±  2%  vmstat.procs.b
      1.60 ±  9%     -18.3%       1.31 ±  8%  vmstat.procs.r
     43764           -28.1%      31478        vmstat.system.cs
     37899           -11.8%      33430        vmstat.system.in
    746274 ±  3%    +112.3%    1584111        numa-meminfo.node0.Active
      8242 ±  6%     +16.9%       9636 ±  2%  numa-meminfo.node0.Active(anon)
    738031 ±  3%    +113.3%    1574474        numa-meminfo.node0.Active(file)
      3834 ±  5%     -44.4%       2131 ±  3%  numa-meminfo.node0.Dirty
    198877 ±  2%     +73.2%     344459 ±  6%  numa-meminfo.node0.Inactive(file)
    142005 ± 18%     +44.9%     205816 ±  3%  numa-meminfo.node1.Active
    631.60 ± 11%    +188.8%       1823 ± 23%  numa-meminfo.node1.Active(anon)
    141374 ± 18%     +44.3%     203992 ±  3%  numa-meminfo.node1.Active(file)
      6462 ±  5%    +105.3%      13264 ± 31%  numa-meminfo.node1.Shmem
    888005          +101.5%    1789513        meminfo.Active
      8922 ±  6%     +28.7%      11481 ±  5%  meminfo.Active(anon)
    879083          +102.3%    1778032        meminfo.Active(file)
   3968054           +26.8%    5032116        meminfo.Cached
      4131 ±  3%     -42.7%       2366 ±  4%  meminfo.Dirty
    650849           +22.9%     799954 ±  2%  meminfo.Inactive
    232627 ±  2%     +64.5%     382619 ±  6%  meminfo.Inactive(file)
   5525347           +18.0%    6517497        meminfo.Memused
    319.28 ± 12%    +283.0%       1222        meminfo.Mlocked
    104363 ±  3%     +14.5%     119546 ±  2%  meminfo.Shmem
   6630855           +15.6%    7665904 ±  2%  meminfo.max_used_kB
     46.83          -100.0%       0.00        turbostat.Avg_MHz
      2.16            -2.2        0.00        turbostat.Busy%
      2169          -100.0%       0.00        turbostat.Bzy_MHz
   1256790          -100.0%       0.00        turbostat.C1
      0.43            -0.4        0.00        turbostat.C1%
   6717871          -100.0%       0.00        turbostat.C1E
      3.35            -3.4        0.00        turbostat.C1E%
  10106419 ±  2%    -100.0%       0.00        turbostat.C6
     21.39           -21.4        0.00        turbostat.C6%
     10.04          -100.0%       0.00        turbostat.CPU%c1
     87.80          -100.0%       0.00        turbostat.CPU%c6
     51.33 ±  2%    -100.0%       0.00        turbostat.CoreTmp
      0.24          -100.0%       0.00        turbostat.IPC
  13761622          -100.0%       0.00        turbostat.IRQ
    322513 ±  7%    -100.0%       0.00        turbostat.POLL
      0.02            -0.0        0.00        turbostat.POLL%
     25.72 ±  9%    -100.0%       0.00        turbostat.Pkg%pc2
      0.66 ±  2%    -100.0%       0.00        turbostat.Pkg%pc6
     51.33 ±  2%    -100.0%       0.00        turbostat.PkgTmp
    192.18          -100.0%       0.00        turbostat.PkgWatt
     46.32          -100.0%       0.00        turbostat.RAMWatt
      2594          -100.0%       0.00        turbostat.TSC_MHz
      2060 ±  6%     +16.9%       2409 ±  2%  numa-vmstat.node0.nr_active_anon
    184319 ±  3%    +113.7%     393808        numa-vmstat.node0.nr_active_file
  17488408 ±  3%     +85.0%   32354171 ±  2%  numa-vmstat.node0.nr_dirtied
    959.01 ±  4%     -44.6%     531.35 ±  3%  numa-vmstat.node0.nr_dirty
     49699 ±  2%     +73.3%      86144 ±  6%  numa-vmstat.node0.nr_inactive_file
  17359798 ±  3%     +86.2%   32322542 ±  2%  numa-vmstat.node0.nr_written
      2060 ±  6%     +16.9%       2409 ±  2%  numa-vmstat.node0.nr_zone_active_anon
    184319 ±  3%    +113.7%     393808        numa-vmstat.node0.nr_zone_active_file
     49699 ±  2%     +73.3%      86144 ±  6%  numa-vmstat.node0.nr_zone_inactive_file
    955.08 ±  2%     -46.3%     512.71 ±  4%  numa-vmstat.node0.nr_zone_write_pending
   3761742           +76.8%    6649779 ±  4%  numa-vmstat.node0.numa_hit
   3689366           +78.5%    6587101 ±  4%  numa-vmstat.node0.numa_local
    157.90 ± 11%    +188.8%     456.09 ± 23%  numa-vmstat.node1.nr_active_anon
     35327 ± 18%     +44.4%      51013 ±  3%  numa-vmstat.node1.nr_active_file
   2656957 ± 24%     +63.3%    4339586 ± 16%  numa-vmstat.node1.nr_dirtied
    131.58 ± 16%     -52.8%      62.04 ± 25%  numa-vmstat.node1.nr_dirty
      1615 ±  5%    +105.2%       3315 ± 31%  numa-vmstat.node1.nr_shmem
   2641902 ± 24%     +64.2%    4337407 ± 16%  numa-vmstat.node1.nr_written
    157.90 ± 11%    +188.8%     456.09 ± 23%  numa-vmstat.node1.nr_zone_active_anon
     35327 ± 18%     +44.4%      51013 ±  3%  numa-vmstat.node1.nr_zone_active_file
    129.79 ± 15%     -55.7%      57.47 ± 16%  numa-vmstat.node1.nr_zone_write_pending
    732720 ± 10%     +27.6%     934969 ±  8%  numa-vmstat.node1.numa_hit
    671589 ±  9%     +28.7%     864190 ± 12%  numa-vmstat.node1.numa_local
     76429 ± 10%     +36.5%     104306 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
     59671 ± 16%     +54.7%      92311 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
     76429 ± 10%     +36.5%     104306 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
     59671 ± 16%     +54.7%      92311 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
    311.60 ± 19%     -40.5%     185.41 ± 29%  sched_debug.cfs_rq:/.util_est_enqueued.max
    160769 ± 13%     -30.3%     112046 ± 15%  sched_debug.cpu.avg_idle.min
    216746           +55.4%     336897        sched_debug.cpu.clock.avg
    216749           +55.4%     336898        sched_debug.cpu.clock.max
    216744           +55.4%     336895        sched_debug.cpu.clock.min
      1.53 ± 21%     -41.9%       0.89 ±  8%  sched_debug.cpu.clock.stddev
    211867           +54.8%     328069        sched_debug.cpu.clock_task.avg
    213052           +54.6%     329409        sched_debug.cpu.clock_task.max
    205379           +57.1%     322611        sched_debug.cpu.clock_task.min
      1980 ± 35%    +139.3%       4739 ±  8%  sched_debug.cpu.curr->pid.avg
     10451           +29.4%      13525        sched_debug.cpu.curr->pid.max
      2742 ± 10%     +27.9%       3506 ±  7%  sched_debug.cpu.curr->pid.stddev
      0.39 ± 13%     -26.5%       0.29 ± 12%  sched_debug.cpu.nr_running.stddev
    414763 ± 28%    +109.7%     869822 ±  4%  sched_debug.cpu.nr_switches.avg
    875135 ±  4%     +30.1%    1138538 ±  2%  sched_debug.cpu.nr_switches.max
    353928 ± 36%    +126.1%     800081 ±  5%  sched_debug.cpu.nr_switches.min
    338.37 ± 47%    +154.2%     860.19 ± 41%  sched_debug.cpu.nr_uninterruptible.stddev
    216745           +55.4%     336895        sched_debug.cpu_clk
    216023           +55.6%     336172        sched_debug.ktime
    217565           +55.2%     337700        sched_debug.sched_clk
      2230 ±  6%     +28.4%       2863 ±  4%  proc-vmstat.nr_active_anon
    219981          +102.1%     444537        proc-vmstat.nr_active_file
     80751            -4.1%      77405        proc-vmstat.nr_anon_pages
  20145272           +82.1%   36693776        proc-vmstat.nr_dirtied
      1056           -44.1%     591.10 ±  3%  proc-vmstat.nr_dirty
    992283           +26.8%    1258069        proc-vmstat.nr_file_pages
     58212 ±  2%     +64.3%      95661 ±  6%  proc-vmstat.nr_inactive_file
     23392            -1.2%      23101        proc-vmstat.nr_kernel_stack
      8661            -1.6%       8523        proc-vmstat.nr_mapped
     79.58 ± 12%    +284.3%     305.81        proc-vmstat.nr_mlock
      1231            -6.2%       1155        proc-vmstat.nr_page_table_pages
     26089 ±  3%     +14.6%      29887 ±  2%  proc-vmstat.nr_shmem
     74588            +6.7%      79574        proc-vmstat.nr_slab_reclaimable
     60946            -2.0%      59704        proc-vmstat.nr_slab_unreclaimable
  20001585           +83.3%   36659964        proc-vmstat.nr_written
      2230 ±  6%     +28.4%       2863 ±  4%  proc-vmstat.nr_zone_active_anon
    219981          +102.1%     444537        proc-vmstat.nr_zone_active_file
     58212 ±  2%     +64.3%      95661 ±  6%  proc-vmstat.nr_zone_inactive_file
      1046           -45.2%     573.71        proc-vmstat.nr_zone_write_pending
   4496293           +68.7%    7587435 ±  3%  proc-vmstat.numa_hit
   4362786           +70.9%    7453980 ±  3%  proc-vmstat.numa_local
   1529156          +121.6%    3388654 ±  2%  proc-vmstat.pgactivate
   5169049           +58.3%    8182975 ±  3%  proc-vmstat.pgalloc_normal
     54245 ±  6%    +153.0%     137232 ±  5%  proc-vmstat.pgdeactivate
   1234304           +45.6%    1797509        proc-vmstat.pgfault
   5064118 ±  3%     +60.7%    8137212 ±  3%  proc-vmstat.pgfree
  80904601           +84.2%  1.491e+08        proc-vmstat.pgpgout
     87890           +30.8%     114978        proc-vmstat.pgreuse
     80369 ±  8%    +116.1%     173706 ±  3%  proc-vmstat.pgrotated
   2445156            +2.6%    2507708        proc-vmstat.slabs_scanned
   3508096           +58.7%    5565696        proc-vmstat.unevictable_pgs_scanned
  17591497 ±  3%     -46.2%    9462438 ±  5%  perf-stat.i.branch-instructions
      0.09 ±  8%      -0.0        0.05 ±  9%  perf-stat.i.branch-miss-rate%
    643421 ±  4%     -45.4%     351191 ±  6%  perf-stat.i.branch-misses
      0.01 ±  4%      -0.0        0.01 ±  8%  perf-stat.i.cache-miss-rate%
     22121 ±  4%     -42.4%      12743 ±  8%  perf-stat.i.cache-misses
   2157156 ±  3%     -43.2%    1224665        perf-stat.i.cache-references
     43652           -28.2%      31341        perf-stat.i.context-switches
      0.04 ±  9%     -42.3%       0.02 ± 11%  perf-stat.i.cpi
     32901           -14.6%      28099        perf-stat.i.cpu-clock
 1.149e+08 ±  3%     -45.0%   63242987 ±  3%  perf-stat.i.cpu-cycles
    122.60 ±  2%     -38.1%      75.91 ± 11%  perf-stat.i.cycles-between-cache-misses
      0.02 ±  7%      -0.0        0.01 ± 12%  perf-stat.i.dTLB-load-miss-rate%
     83680 ±  3%     -45.7%      45477 ±  2%  perf-stat.i.dTLB-load-misses
  19409742 ±  3%     -45.5%   10573554 ±  4%  perf-stat.i.dTLB-loads
      0.00 ±  6%      -0.0        0.00 ± 10%  perf-stat.i.dTLB-store-miss-rate%
      8864 ±  3%     -44.2%       4942 ±  3%  perf-stat.i.dTLB-store-misses
   6670676 ±  3%     -45.3%    3649805 ±  4%  perf-stat.i.dTLB-stores
  86859690 ±  3%     -46.2%   46744024 ±  5%  perf-stat.i.instructions
      0.01 ±  3%     -45.0%       0.00 ±  4%  perf-stat.i.ipc
      0.43 ± 18%     -58.1%       0.18 ± 10%  perf-stat.i.major-faults
      0.00 ±  3%     -45.0%       0.00 ±  3%  perf-stat.i.metric.GHz
     14.27 ±  2%     -24.2%      10.82 ±  5%  perf-stat.i.metric.K/sec
      0.35 ±  3%     -45.6%       0.19 ±  4%  perf-stat.i.metric.M/sec
      2652           -11.3%       2353        perf-stat.i.minor-faults
      0.96 ±  5%      -0.4        0.55 ±  9%  perf-stat.i.node-load-miss-rate%
      2267 ±  5%     -45.0%       1245 ± 10%  perf-stat.i.node-load-misses
      0.45 ± 13%      -0.2        0.26 ± 17%  perf-stat.i.node-store-miss-rate%
      1815 ± 25%     -40.2%       1086 ± 14%  perf-stat.i.node-store-misses
      3707 ±  8%     -37.9%       2300 ± 27%  perf-stat.i.node-stores
      2652           -11.3%       2353        perf-stat.i.page-faults
     32901           -14.6%      28099        perf-stat.i.task-clock
  17663899 ±  3%     -46.1%    9512720 ±  5%  perf-stat.ps.branch-instructions
    646905 ±  4%     -45.3%     353633 ±  6%  perf-stat.ps.branch-misses
     22175 ±  3%     -42.3%      12798 ±  8%  perf-stat.ps.cache-misses
   2178201 ±  3%     -43.2%    1238088        perf-stat.ps.cache-references
     43484           -28.1%      31280        perf-stat.ps.context-switches
     32937           -14.5%      28172        perf-stat.ps.cpu-clock
 1.159e+08 ±  3%     -44.9%   63806296 ±  3%  perf-stat.ps.cpu-cycles
     84532 ±  3%     -45.6%      45996 ±  2%  perf-stat.ps.dTLB-load-misses
  19494155 ±  3%     -45.5%   10631524 ±  4%  perf-stat.ps.dTLB-loads
      8948 ±  3%     -44.2%       4996 ±  3%  perf-stat.ps.dTLB-store-misses
   6704292 ±  3%     -45.2%    3672341 ±  4%  perf-stat.ps.dTLB-stores
  87211948 ±  3%     -46.1%   46988284 ±  5%  perf-stat.ps.instructions
      0.43 ± 18%     -58.2%       0.18 ± 10%  perf-stat.ps.major-faults
      2646           -11.2%       2351        perf-stat.ps.minor-faults
      2278 ±  5%     -45.0%       1253 ± 10%  perf-stat.ps.node-load-misses
      1828 ± 25%     -40.1%       1095 ± 14%  perf-stat.ps.node-store-misses
      3726 ±  8%     -37.9%       2315 ± 27%  perf-stat.ps.node-stores
      2647           -11.2%       2351        perf-stat.ps.page-faults
     32937           -14.5%      28172        perf-stat.ps.task-clock
      0.01 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_commit_transaction
      0.00 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
      0.00 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      0.07 ± 39%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space.handle_reserve_ticket
      0.03 ± 35%     -89.9%       0.00 ±223%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  9%     -41.1%       0.02 ± 18%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.28 ± 94%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.04 ±  7%     -24.2%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_current_trans.start_transaction.btrfs_unlink.vfs_unlink
      0.02 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_current_trans.start_transaction.evict_refill_and_join.btrfs_evict_inode
      0.05 ± 78%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_current_trans.start_transaction.flush_space.btrfs_async_reclaim_metadata_space
      0.01 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_commit.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
      0.07 ±107%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_commit.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space
      0.01 ± 58%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_commit_transaction
      0.00 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
      0.04 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      0.18 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space.handle_reserve_ticket
      0.06 ± 52%     -93.6%       0.00 ±223%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    197.58 ±138%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.11 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.btrfs_unlink.vfs_unlink
      0.08 ± 48%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.evict_refill_and_join.btrfs_evict_inode
      0.12 ± 81%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.flush_space.btrfs_async_reclaim_metadata_space
      0.06 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_commit.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
      1.00 ±180%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_commit.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space
    110.17 ±  8%     -57.5%      46.78 ± 28%  perf-sched.wait_and_delay.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
      0.27 ± 18%    +114.0%       0.58 ±  9%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      2.77 ±  7%     -30.0%       1.94 ±  7%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      0.78 ± 27%    +175.9%       2.16 ± 19%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    186.74 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     12.66 ±  6%     -11.1%      11.26 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1034 ±  6%     +31.1%       1355 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_sync_log
      1080 ±  6%     -57.3%     461.17 ±  5%  perf-sched.wait_and_delay.count.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
      1061 ±  6%     +30.4%       1383 ±  5%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      2119 ±  6%     +30.5%       2766 ±  5%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_log
     11689 ±  7%     -28.7%       8337 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      6928 ± 12%     -73.8%       1816 ± 27%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      1088 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      3180 ±  6%     +30.5%       4150 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
      5265 ± 10%     +20.9%       6365 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     28092 ±  5%     +23.0%      34561 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    721.47 ±  5%    +111.1%       1523 ±  4%  perf-sched.wait_and_delay.max.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
    190.75           -95.6%       8.45 ± 18%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      1296 ± 20%     -44.5%     719.14 ± 34%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      1102 ± 37%     -65.0%     386.03 ± 66%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    721.81 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.22 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_commit_transaction
      0.12 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
      0.54 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      2.05 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space.handle_reserve_ticket
      0.26 ± 84%    -100.0%       0.00        perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_file.loop_process_work
    110.01 ±  8%     -57.6%      46.69 ± 28%  perf-sched.wait_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
      0.26 ± 18%    +117.1%       0.57 ±  9%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      2.77 ±  7%     -30.1%       1.94 ±  7%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      0.77 ± 27%    +179.0%       2.15 ± 20%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    186.45 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      5.21 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.btrfs_unlink.vfs_unlink
      4.25 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.evict_refill_and_join.btrfs_evict_inode
     46.63 ±137%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.flush_space.btrfs_async_reclaim_metadata_space
      2.37 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
      7.99 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space
     12.64 ±  6%     -11.1%      11.24 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.31 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_commit_transaction
      0.13 ± 93%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
      1.94 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      5.87 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space.handle_reserve_ticket
      0.31 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_file.loop_process_work
    721.40 ±  5%    +111.2%       1523 ±  4%  perf-sched.wait_time.max.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
    190.74           -95.6%       8.44 ± 18%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      1296 ± 20%     -44.5%     719.06 ± 34%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      1102 ± 37%     -65.0%     385.96 ± 66%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    721.71 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     85.02 ±203%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.btrfs_unlink.vfs_unlink
      8.34 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.evict_refill_and_join.btrfs_evict_inode
    221.59 ±157%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.flush_space.btrfs_async_reclaim_metadata_space
     13.26 ± 75%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_commit.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
    183.98 ±136%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_commit.btrfs_commit_transaction.flush_space.priority_reclaim_metadata_space
    536.98 ±  4%     +45.7%     782.42        fxmark.ssd_btrfs_MWUM_18_bufferedio.idle_sec
     36.70 ±  6%     +69.4%      62.18 ±  3%  fxmark.ssd_btrfs_MWUM_18_bufferedio.iowait_sec
      5.90 ±  2%     +16.7%       6.88 ±  3%  fxmark.ssd_btrfs_MWUM_18_bufferedio.iowait_util
      8.23 ±  7%     +68.9%      13.90 ±  3%  fxmark.ssd_btrfs_MWUM_18_bufferedio.irq_sec
      1.32 ±  3%     +16.3%       1.54 ±  3%  fxmark.ssd_btrfs_MWUM_18_bufferedio.irq_util
     34.48 ±  4%     +45.2%      50.08        fxmark.ssd_btrfs_MWUM_18_bufferedio.real_sec
     34.38 ±  4%     +45.6%      50.07        fxmark.ssd_btrfs_MWUM_18_bufferedio.secs
      1.71 ±  4%     +42.8%       2.45 ±  5%  fxmark.ssd_btrfs_MWUM_18_bufferedio.softirq_sec
      6.06 ±  3%     -22.8%       4.68 ±  8%  fxmark.ssd_btrfs_MWUM_18_bufferedio.sys_util
      0.06 ±  4%     -30.4%       0.04 ±  3%  fxmark.ssd_btrfs_MWUM_18_bufferedio.user_util
    197497           -94.7%      10545 ±  6%  fxmark.ssd_btrfs_MWUM_18_bufferedio.works
      5754 ±  4%     -96.3%     210.61 ±  6%  fxmark.ssd_btrfs_MWUM_18_bufferedio.works/sec
      9.27 ± 12%     +98.9%      18.44 ±  3%  fxmark.ssd_btrfs_MWUM_1_bufferedio.iowait_sec
     30.82 ±  7%     +21.0%      37.30 ±  3%  fxmark.ssd_btrfs_MWUM_1_bufferedio.iowait_util
      0.62 ±  5%     +88.7%       1.17 ±  2%  fxmark.ssd_btrfs_MWUM_1_bufferedio.irq_sec
      2.06           +14.5%       2.36 ±  2%  fxmark.ssd_btrfs_MWUM_1_bufferedio.irq_util
     30.56 ±  4%     +63.8%      50.04        fxmark.ssd_btrfs_MWUM_1_bufferedio.real_sec
     30.52 ±  4%     +63.8%      50.01        fxmark.ssd_btrfs_MWUM_1_bufferedio.secs
      0.91 ±  4%     +71.1%       1.55 ±  3%  fxmark.ssd_btrfs_MWUM_1_bufferedio.softirq_sec
     18.98 ±  3%     +47.6%      28.02 ±  2%  fxmark.ssd_btrfs_MWUM_1_bufferedio.sys_sec
     63.39 ±  3%     -10.6%      56.68 ±  2%  fxmark.ssd_btrfs_MWUM_1_bufferedio.sys_util
      0.21 ±  4%     +23.0%       0.26 ±  6%  fxmark.ssd_btrfs_MWUM_1_bufferedio.user_sec
      0.70 ±  7%     -25.6%       0.52 ±  6%  fxmark.ssd_btrfs_MWUM_1_bufferedio.user_util
    191796           -85.8%      27265 ± 49%  fxmark.ssd_btrfs_MWUM_1_bufferedio.works
      6298 ±  4%     -91.3%     545.21 ± 49%  fxmark.ssd_btrfs_MWUM_1_bufferedio.works/sec
      8.10           +68.8%      13.67 ±  5%  fxmark.ssd_btrfs_MWUM_2_bufferedio.idle_sec
     22.48 ±  8%    +106.9%      46.50 ±  8%  fxmark.ssd_btrfs_MWUM_2_bufferedio.iowait_sec
     39.69 ±  4%     +18.8%      47.16 ±  7%  fxmark.ssd_btrfs_MWUM_2_bufferedio.iowait_util
      0.86 ±  4%     +91.2%       1.64 ±  4%  fxmark.ssd_btrfs_MWUM_2_bufferedio.irq_sec
     28.67 ±  4%     +72.7%      49.52 ±  2%  fxmark.ssd_btrfs_MWUM_2_bufferedio.real_sec
     28.61 ±  4%     +73.0%      49.49 ±  2%  fxmark.ssd_btrfs_MWUM_2_bufferedio.secs
      1.22 ±  4%     +64.8%       2.01 ±  3%  fxmark.ssd_btrfs_MWUM_2_bufferedio.softirq_sec
     23.66 ±  2%     +45.4%      34.41 ±  6%  fxmark.ssd_btrfs_MWUM_2_bufferedio.sys_sec
     41.90 ±  3%     -16.6%      34.96 ±  7%  fxmark.ssd_btrfs_MWUM_2_bufferedio.sys_util
      0.23 ±  3%     +23.4%       0.28 ±  9%  fxmark.ssd_btrfs_MWUM_2_bufferedio.user_sec
      0.40 ±  5%     -29.2%       0.29 ± 10%  fxmark.ssd_btrfs_MWUM_2_bufferedio.user_util
    194804           -52.8%      92028 ± 72%  fxmark.ssd_btrfs_MWUM_2_bufferedio.works
      6819 ±  4%     -72.4%       1882 ± 73%  fxmark.ssd_btrfs_MWUM_2_bufferedio.works/sec
     47.58 ±  9%     +29.8%      61.76        fxmark.ssd_btrfs_MWUM_36_bufferedio.iowait_sec
      2.91 ±  3%     +17.7%       3.42        fxmark.ssd_btrfs_MWUM_36_bufferedio.iowait_util
     45.54 ±  3%     -16.5%      38.02 ±  5%  fxmark.ssd_btrfs_MWUM_36_bufferedio.sys_sec
      2.80 ±  4%     -24.6%       2.11 ±  5%  fxmark.ssd_btrfs_MWUM_36_bufferedio.sys_util
      0.60 ±  3%     -15.7%       0.51 ±  2%  fxmark.ssd_btrfs_MWUM_36_bufferedio.user_sec
      0.04 ±  3%     -23.8%       0.03 ±  2%  fxmark.ssd_btrfs_MWUM_36_bufferedio.user_util
    196012 ±  3%     -95.1%       9691 ±  4%  fxmark.ssd_btrfs_MWUM_36_bufferedio.works
      4342 ±  8%     -95.6%     193.19 ±  4%  fxmark.ssd_btrfs_MWUM_36_bufferedio.works/sec
     51.31 ±  6%     +98.4%     101.80        fxmark.ssd_btrfs_MWUM_4_bufferedio.idle_sec
     22.79 ± 10%    +149.4%      56.84 ±  4%  fxmark.ssd_btrfs_MWUM_4_bufferedio.iowait_sec
     22.27 ±  4%     +28.0%      28.49 ±  4%  fxmark.ssd_btrfs_MWUM_4_bufferedio.iowait_util
      1.08 ±  9%    +127.6%       2.47 ±  3%  fxmark.ssd_btrfs_MWUM_4_bufferedio.irq_sec
      1.06 ±  2%     +16.7%       1.24 ±  3%  fxmark.ssd_btrfs_MWUM_4_bufferedio.irq_util
     25.74 ±  6%     +94.4%      50.04        fxmark.ssd_btrfs_MWUM_4_bufferedio.real_sec
     25.67 ±  6%     +94.8%      50.01        fxmark.ssd_btrfs_MWUM_4_bufferedio.secs
      1.14 ±  5%     +90.5%       2.16 ±  5%  fxmark.ssd_btrfs_MWUM_4_bufferedio.softirq_sec
     25.52 ±  3%     +40.7%      35.92 ±  6%  fxmark.ssd_btrfs_MWUM_4_bufferedio.sys_sec
     25.06 ±  3%     -28.1%      18.01 ±  6%  fxmark.ssd_btrfs_MWUM_4_bufferedio.sys_util
      0.23 ±  5%     +25.5%       0.29 ±  7%  fxmark.ssd_btrfs_MWUM_4_bufferedio.user_sec
      0.22 ±  5%     -35.9%       0.14 ±  7%  fxmark.ssd_btrfs_MWUM_4_bufferedio.user_util
    196164           -89.8%      20104 ± 91%  fxmark.ssd_btrfs_MWUM_4_bufferedio.works
      7673 ±  6%     -94.8%     402.05 ± 91%  fxmark.ssd_btrfs_MWUM_4_bufferedio.works/sec
     45.84 ±  5%     +32.0%      60.49 ±  2%  fxmark.ssd_btrfs_MWUM_54_bufferedio.iowait_sec
      1.85 ±  2%     +20.7%       2.23 ±  2%  fxmark.ssd_btrfs_MWUM_54_bufferedio.iowait_util
     48.22 ±  4%     -16.7%      40.15 ±  6%  fxmark.ssd_btrfs_MWUM_54_bufferedio.sys_sec
      1.95 ±  2%     -23.9%       1.48 ±  6%  fxmark.ssd_btrfs_MWUM_54_bufferedio.sys_util
      0.89 ±  3%     -27.0%       0.65 ±  3%  fxmark.ssd_btrfs_MWUM_54_bufferedio.user_sec
      0.04 ±  4%     -33.3%       0.02 ±  3%  fxmark.ssd_btrfs_MWUM_54_bufferedio.user_util
    197957           -95.1%       9607 ±  5%  fxmark.ssd_btrfs_MWUM_54_bufferedio.works
      4322 ±  3%     -95.6%     191.07 ±  5%  fxmark.ssd_btrfs_MWUM_54_bufferedio.works/sec
    106.27            -9.1%      96.55        fxmark.ssd_btrfs_MWUM_72_bufferedio.irq_sec
      2.95            -9.7%       2.67        fxmark.ssd_btrfs_MWUM_72_bufferedio.irq_util
     50.04 ±  5%     -25.3%      37.40 ±  3%  fxmark.ssd_btrfs_MWUM_72_bufferedio.sys_sec
      1.39 ±  5%     -25.7%       1.03 ±  3%  fxmark.ssd_btrfs_MWUM_72_bufferedio.sys_util
      1.44 ±  3%     -27.7%       1.04 ±  2%  fxmark.ssd_btrfs_MWUM_72_bufferedio.user_sec
      0.04 ±  3%     -28.2%       0.03 ±  2%  fxmark.ssd_btrfs_MWUM_72_bufferedio.user_util
     95492 ± 48%     -90.4%       9208 ±  5%  fxmark.ssd_btrfs_MWUM_72_bufferedio.works
      1911 ± 48%     -90.4%     182.60 ±  5%  fxmark.ssd_btrfs_MWUM_72_bufferedio.works/sec
    365.01 ±  2%     +76.4%     643.71        fxmark.time.elapsed_time
    365.01 ±  2%     +76.4%     643.71        fxmark.time.elapsed_time.max
     13452 ± 10%     -39.5%       8145 ± 23%  fxmark.time.involuntary_context_switches
      6.00           -50.0%       3.00        fxmark.time.percent_of_cpu_this_job_got
    620218 ±  2%     -51.7%     299524 ± 17%  fxmark.time.voluntary_context_switches
     49.59 ±  3%     -32.0       17.58 ± 43%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     44.37 ±  2%     -31.5       12.86 ± 54%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     44.37 ±  2%     -31.5       12.86 ± 54%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     44.37 ±  2%     -31.5       12.86 ± 54%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     48.72 ±  3%     -31.5       17.24 ± 43%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     48.72 ±  3%     -31.5       17.24 ± 43%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     48.66 ±  3%     -31.4       17.22 ± 43%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     43.40 ±  2%     -31.2       12.23 ± 57%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     42.74 ±  2%     -30.7       11.99 ± 57%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     46.40 ±  3%     -30.1       16.26 ± 44%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     42.14 ±  3%     -27.4       14.79 ± 43%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     41.39 ±  3%     -27.1       14.29 ± 43%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     22.38 ±  3%     -14.5        7.87 ± 42%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     18.32 ±  4%     -13.4        4.96 ± 59%  perf-profile.calltrace.cycles-pp.loop_process_work.process_one_work.worker_thread.kthread.ret_from_fork
     14.90 ±  5%     -11.0        3.93 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.loop_process_work.process_one_work.worker_thread.kthread
     14.95 ±  4%     -10.7        4.20 ± 59%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
     14.72 ±  4%     -10.6        4.14 ± 60%  perf-profile.calltrace.cycles-pp.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     15.08 ±  6%     -10.4        4.64 ± 57%  perf-profile.calltrace.cycles-pp.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
     15.08 ±  6%     -10.4        4.63 ± 57%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread
     15.53 ±  4%     -10.3        5.23 ± 50%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     13.67 ±  5%     -10.0        3.70 ± 67%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages
     13.67 ±  5%      -9.9        3.78 ± 63%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
     13.32 ±  6%      -9.7        3.62 ± 67%  perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages
     12.69 ±  5%      -9.1        3.58 ± 61%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
     13.09 ±  4%      -8.6        4.51 ± 46%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     10.96 ±  4%      -8.0        2.94 ± 59%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space
     10.95 ±  4%      -8.0        2.94 ± 59%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction
     10.93 ±  4%      -8.0        2.94 ± 59%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction
     10.50 ±  6%      -7.5        3.00 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
     10.53 ±  6%      -7.5        3.04 ± 68%  perf-profile.calltrace.cycles-pp.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
     10.37 ±  5%      -7.4        2.96 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
     10.31 ±  6%      -7.3        2.98 ± 68%  perf-profile.calltrace.cycles-pp.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      8.82 ±  7%      -6.8        2.04 ± 66%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
      8.83 ±  7%      -6.7        2.16 ± 61%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      9.18 ±  4%      -6.0        3.18 ± 47%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      9.07 ±  5%      -5.9        3.14 ± 47%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      7.55 ±  4%      -4.9        2.62 ± 48%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      6.09 ±  9%      -4.7        1.38 ± 66%  perf-profile.calltrace.cycles-pp.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      5.56 ± 10%      -4.5        1.09 ± 91%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      5.75 ±  7%      -4.1        1.68 ± 73%  perf-profile.calltrace.cycles-pp.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      5.60 ±  6%      -4.0        1.56 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.loop_process_work.process_one_work.worker_thread
      5.60 ±  6%      -4.0        1.56 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.loop_process_work.process_one_work
      5.59 ±  6%      -4.0        1.56 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.loop_process_work
      5.13 ±  7%      -3.8        1.38 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      5.00 ±  7%      -3.7        1.34 ± 59%  perf-profile.calltrace.cycles-pp.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
      4.63 ± 10%      -3.1        1.48 ± 60%  perf-profile.calltrace.cycles-pp.btrfs_sync_log.btrfs_sync_file.loop_process_work.process_one_work.worker_thread
      4.66 ±  5%      -3.0        1.64 ± 49%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      4.30 ±  5%      -2.8        1.50 ± 48%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      4.05 ± 11%      -2.8        1.28 ± 60%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.loop_process_work.process_one_work
      4.04 ± 12%      -2.8        1.27 ± 60%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.loop_process_work
      4.03 ± 12%      -2.8        1.27 ± 60%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
      4.03 ± 12%      -2.8        1.27 ± 60%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
      3.76 ±  5%      -2.4        1.32 ± 48%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      3.13 ±  5%      -2.4        0.70 ± 88%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.loop_process_work.process_one_work.worker_thread
      3.32 ±  3%      -2.4        0.94 ± 71%  perf-profile.calltrace.cycles-pp.lo_write_simple.loop_process_work.process_one_work.worker_thread.kthread
      2.94 ±  6%      -2.4        0.56 ±111%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file.loop_process_work.process_one_work
      2.94 ±  6%      -2.4        0.56 ±111%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file.loop_process_work
      2.93 ±  6%      -2.4        0.56 ±111%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file
      2.93 ±  6%      -2.4        0.56 ±111%  perf-profile.calltrace.cycles-pp.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops
      2.92 ±  6%      -2.4        0.56 ±111%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      3.13 ±  3%      -2.3        0.78 ± 88%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.do_iter_readv_writev.do_iter_write.lo_write_simple
      3.25 ±  3%      -2.3        0.91 ± 71%  perf-profile.calltrace.cycles-pp.do_iter_write.lo_write_simple.loop_process_work.process_one_work.worker_thread
      3.21 ±  3%      -2.3        0.90 ± 71%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.do_iter_write.lo_write_simple.loop_process_work.process_one_work
      3.18 ±  3%      -2.3        0.89 ± 71%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.do_iter_readv_writev.do_iter_write.lo_write_simple.loop_process_work
      2.64 ±  6%      -2.1        0.51 ±111%  perf-profile.calltrace.cycles-pp.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
      3.26 ±  9%      -2.1        1.14 ± 46%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.73 ±  3%      -2.1        0.64 ± 86%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent
      2.19 ± 12%      -1.8        0.42 ±111%  perf-profile.calltrace.cycles-pp.log_extent_csums.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent
      2.10 ± 11%      -1.7        0.41 ±111%  perf-profile.calltrace.cycles-pp.log_csums.log_extent_csums.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode
      2.10 ± 11%      -1.7        0.41 ±110%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.log_csums.log_extent_csums.log_one_extent.btrfs_log_changed_extents
      2.04 ± 11%      -1.5        0.52 ±111%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
      2.04 ± 11%      -1.5        0.52 ±111%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      2.00 ±  5%      -1.5        0.50 ±109%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      1.98 ± 12%      -1.5        0.50 ±111%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space
      1.44 ±  8%      -1.1        0.34 ±104%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.9        0.89 ± 18%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      0.00            +1.6        1.58 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode
      0.00            +1.6        1.58 ± 18%  perf-profile.calltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common
      0.00            +2.1        2.10 ± 19%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.lookup_open
      0.00            +2.3        2.25 ± 19%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.lookup_open.open_last_lookups
      0.00            +3.4        3.44 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.lookup_open.open_last_lookups.path_openat
      0.00            +3.9        3.93 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_create_common.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.00            +4.1        4.12 ± 21%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.00            +4.9        4.94 ± 17%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00           +58.3       58.30 ± 21%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.00           +62.6       62.59 ± 21%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
      0.00           +63.0       63.00 ± 21%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
      0.00           +63.0       63.02 ± 21%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00           +68.2       68.23 ± 21%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00           +68.5       68.53 ± 21%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.00           +68.5       68.54 ± 21%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +68.6       68.62 ± 21%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00           +68.6       68.62 ± 21%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00           +68.7       68.66 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00           +68.7       68.67 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.00           +68.7       68.71 ± 21%  perf-profile.calltrace.cycles-pp.open64
     49.59 ±  3%     -32.0       17.58 ± 43%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     49.59 ±  3%     -32.0       17.58 ± 43%  perf-profile.children.cycles-pp.cpu_startup_entry
     49.58 ±  3%     -32.0       17.58 ± 43%  perf-profile.children.cycles-pp.do_idle
     44.38 ±  2%     -31.5       12.86 ± 54%  perf-profile.children.cycles-pp.ret_from_fork_asm
     44.38 ±  2%     -31.5       12.86 ± 54%  perf-profile.children.cycles-pp.ret_from_fork
     44.37 ±  2%     -31.5       12.86 ± 54%  perf-profile.children.cycles-pp.kthread
     48.72 ±  3%     -31.5       17.24 ± 43%  perf-profile.children.cycles-pp.start_secondary
     43.40 ±  2%     -31.2       12.23 ± 57%  perf-profile.children.cycles-pp.worker_thread
     42.74 ±  2%     -30.7       11.99 ± 57%  perf-profile.children.cycles-pp.process_one_work
     47.31 ±  3%     -30.7       16.61 ± 43%  perf-profile.children.cycles-pp.cpuidle_idle_call
     42.92 ±  3%     -27.8       15.08 ± 43%  perf-profile.children.cycles-pp.cpuidle_enter
     42.70 ±  3%     -27.7       15.02 ± 43%  perf-profile.children.cycles-pp.cpuidle_enter_state
     22.69 ±  3%     -14.7        8.03 ± 41%  perf-profile.children.cycles-pp.intel_idle
     18.32 ±  4%     -13.4        4.96 ± 59%  perf-profile.children.cycles-pp.loop_process_work
     18.05 ±  3%     -13.1        4.98 ± 59%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     18.04 ±  3%     -13.1        4.97 ± 59%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     18.01 ±  3%     -13.0        4.97 ± 59%  perf-profile.children.cycles-pp.do_writepages
     17.23 ±  5%     -12.6        4.63 ± 57%  perf-profile.children.cycles-pp.flush_space
     15.03 ± 10%     -11.4        3.58 ± 61%  perf-profile.children.cycles-pp.btrfs_commit_transaction
     15.21 ±  4%     -11.0        4.24 ± 60%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
     14.90 ±  5%     -11.0        3.93 ± 59%  perf-profile.children.cycles-pp.btrfs_sync_file
     15.06 ±  4%     -10.9        4.21 ± 59%  perf-profile.children.cycles-pp.btree_write_cache_pages
     14.84 ±  4%     -10.7        4.14 ± 60%  perf-profile.children.cycles-pp.submit_eb_page
     14.68 ±  4%     -10.6        4.09 ± 60%  perf-profile.children.cycles-pp.btrfs_submit_bio
     14.68 ±  4%     -10.6        4.08 ± 60%  perf-profile.children.cycles-pp.btrfs_submit_chunk
     15.08 ±  6%     -10.4        4.64 ± 57%  perf-profile.children.cycles-pp.btrfs_async_reclaim_metadata_space
     13.49 ±  5%      -9.7        3.78 ± 60%  perf-profile.children.cycles-pp.btree_csum_one_bio
     15.14 ±  3%      -9.6        5.56 ± 42%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     13.67 ±  3%      -8.7        4.94 ± 43%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     11.31 ±  3%      -8.3        3.00 ± 59%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
     10.75 ±  5%      -7.6        3.18 ± 61%  perf-profile.children.cycles-pp.btrfs_check_leaf
     10.75 ±  5%      -7.6        3.18 ± 61%  perf-profile.children.cycles-pp.__btrfs_check_leaf
      8.82 ±  7%      -6.8        2.04 ± 66%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
      8.83 ±  7%      -6.7        2.16 ± 61%  perf-profile.children.cycles-pp.btrfs_work_helper
      8.30 ±  7%      -6.3        1.99 ± 64%  perf-profile.children.cycles-pp.btrfs_drop_extents
      9.61 ±  4%      -6.1        3.49 ± 43%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      9.52 ±  4%      -6.1        3.46 ± 43%  perf-profile.children.cycles-pp.hrtimer_interrupt
      8.58 ±  6%      -5.1        3.45 ± 29%  perf-profile.children.cycles-pp.btrfs_search_slot
      7.92 ±  4%      -5.0        2.89 ± 44%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      5.84 ± 22%      -4.8        1.06 ± 66%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      5.83 ± 22%      -4.8        1.06 ± 66%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      6.09 ±  9%      -4.7        1.38 ± 66%  perf-profile.children.cycles-pp.insert_reserved_file_extent
      6.70 ±  6%      -4.2        2.49 ± 33%  perf-profile.children.cycles-pp.__write_extent_buffer
      6.03 ±  6%      -4.2        1.84 ± 61%  perf-profile.children.cycles-pp.check_leaf_item
      5.60 ±  6%      -4.0        1.56 ± 59%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
      5.60 ±  6%      -4.0        1.56 ± 59%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
      5.59 ±  6%      -4.0        1.56 ± 59%  perf-profile.children.cycles-pp.btrfs_log_inode
      5.13 ±  7%      -3.8        1.38 ± 59%  perf-profile.children.cycles-pp.btrfs_log_changed_extents
      5.00 ±  7%      -3.7        1.34 ± 59%  perf-profile.children.cycles-pp.log_one_extent
      5.02 ±  7%      -3.6        1.44 ± 53%  perf-profile.children.cycles-pp.read_extent_buffer
      4.55 ± 10%      -3.5        1.02 ± 67%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
      5.17 ±  6%      -3.3        1.91 ± 30%  perf-profile.children.cycles-pp.__memmove
      4.63 ± 10%      -3.1        1.48 ± 60%  perf-profile.children.cycles-pp.btrfs_sync_log
      4.92 ±  4%      -3.1        1.83 ± 44%  perf-profile.children.cycles-pp.tick_sched_timer
      4.52 ±  4%      -2.9        1.66 ± 43%  perf-profile.children.cycles-pp.tick_sched_handle
      4.64 ±  6%      -2.9        1.78 ± 30%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      3.88 ±  8%      -2.8        1.12 ± 65%  perf-profile.children.cycles-pp.btrfs_cow_block
      3.87 ±  8%      -2.7        1.12 ± 65%  perf-profile.children.cycles-pp.__btrfs_cow_block
      3.56 ± 11%      -2.6        0.92 ± 59%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      3.25 ±  7%      -2.5        0.73 ± 61%  perf-profile.children.cycles-pp.btrfs_del_items
      4.00 ±  4%      -2.5        1.50 ± 42%  perf-profile.children.cycles-pp.update_process_times
      3.32 ±  3%      -2.3        1.00 ± 59%  perf-profile.children.cycles-pp.lo_write_simple
      3.13 ±  5%      -2.3        0.82 ± 58%  perf-profile.children.cycles-pp.start_ordered_ops
      3.25 ±  3%      -2.3        0.97 ± 59%  perf-profile.children.cycles-pp.do_iter_write
      3.22 ±  3%      -2.3        0.96 ± 59%  perf-profile.children.cycles-pp.do_iter_readv_writev
      3.19 ±  3%      -2.2        0.95 ± 59%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      2.90 ± 13%      -2.2        0.68 ± 69%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      3.16 ±  3%      -2.2        0.94 ± 59%  perf-profile.children.cycles-pp.btrfs_buffered_write
      2.93 ±  6%      -2.2        0.76 ± 59%  perf-profile.children.cycles-pp.extent_writepages
      2.93 ±  6%      -2.2        0.76 ± 59%  perf-profile.children.cycles-pp.extent_write_cache_pages
      3.34 ±  9%      -2.2        1.18 ± 46%  perf-profile.children.cycles-pp.menu_select
      2.20 ± 52%      -2.1        0.05 ± 48%  perf-profile.children.cycles-pp.handle_reserve_ticket
      2.41 ± 47%      -2.1        0.31 ± 14%  perf-profile.children.cycles-pp.__reserve_bytes
      3.02 ±  5%      -2.1        0.92 ± 51%  perf-profile.children.cycles-pp.btrfs_get_32
      2.73 ±  3%      -2.1        0.63 ± 58%  perf-profile.children.cycles-pp.btrfs_setup_item_for_insert
      2.36 ± 48%      -2.1        0.29 ± 15%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      4.02 ±  4%      -2.0        2.02 ± 18%  perf-profile.children.cycles-pp.setup_items_for_insert
      2.56 ±  5%      -2.0        0.61 ± 67%  perf-profile.children.cycles-pp.check_extent_item
      2.65 ±  6%      -1.9        0.70 ± 59%  perf-profile.children.cycles-pp.__extent_writepage
      2.32 ± 13%      -1.8        0.49 ± 66%  perf-profile.children.cycles-pp.__btrfs_free_extent
      2.30 ± 12%      -1.8        0.49 ± 66%  perf-profile.children.cycles-pp.run_delayed_tree_ref
      2.62 ±  4%      -1.7        0.90 ± 49%  perf-profile.children.cycles-pp.__do_softirq
      2.10 ± 14%      -1.7        0.39 ± 65%  perf-profile.children.cycles-pp.__btrfs_tree_lock
      2.05 ± 11%      -1.7        0.40 ± 60%  perf-profile.children.cycles-pp.btrfs_check_node
      2.05 ± 11%      -1.7        0.40 ± 60%  perf-profile.children.cycles-pp.__btrfs_check_node
      2.19 ± 12%      -1.6        0.58 ± 59%  perf-profile.children.cycles-pp.log_extent_csums
      2.09 ±  7%      -1.6        0.50 ± 68%  perf-profile.children.cycles-pp.alloc_reserved_tree_block
      2.16 ±  9%      -1.5        0.62 ± 60%  perf-profile.children.cycles-pp.btrfs_get_64
      2.10 ± 11%      -1.5        0.57 ± 57%  perf-profile.children.cycles-pp.log_csums
      2.06 ±  5%      -1.3        0.74 ± 41%  perf-profile.children.cycles-pp.__irq_exit_rcu
      1.56 ± 16%      -1.3        0.26 ± 66%  perf-profile.children.cycles-pp.btrfs_lock_root_node
      2.11 ±  5%      -1.3        0.84 ± 43%  perf-profile.children.cycles-pp.scheduler_tick
      1.69 ± 13%      -1.2        0.45 ± 59%  perf-profile.children.cycles-pp.btrfs_extend_item
      1.70 ±  5%      -1.2        0.49 ± 63%  perf-profile.children.cycles-pp.blk_complete_reqs
      1.78 ± 13%      -1.2        0.58 ± 58%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
      1.46 ±  6%      -1.1        0.40 ± 60%  perf-profile.children.cycles-pp.blk_update_request
      1.58 ± 11%      -1.0        0.54 ± 60%  perf-profile.children.cycles-pp.check_extent_data_item
      1.42 ±  8%      -1.0        0.38 ± 56%  perf-profile.children.cycles-pp.__extent_writepage_io
      1.97 ±  6%      -1.0        0.95 ± 22%  perf-profile.children.cycles-pp._raw_spin_lock
      1.42 ±  8%      -1.0        0.43 ± 58%  perf-profile.children.cycles-pp.asm_common_interrupt
      1.42 ±  8%      -1.0        0.42 ± 58%  perf-profile.children.cycles-pp.common_interrupt
      1.50 ±  7%      -1.0        0.52 ± 42%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      1.42 ± 12%      -1.0        0.46 ± 49%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.17 ±  4%      -0.9        0.30 ± 65%  perf-profile.children.cycles-pp.writepage_delalloc
      1.22 ± 17%      -0.9        0.34 ± 57%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      1.30 ±  7%      -0.9        0.44 ± 49%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.26 ±  7%      -0.8        0.43 ± 49%  perf-profile.children.cycles-pp.tick_irq_enter
      1.34 ± 12%      -0.8        0.51 ± 26%  perf-profile.children.cycles-pp.btrfs_set_token_32
      1.59 ±  6%      -0.8        0.78 ± 31%  perf-profile.children.cycles-pp.__schedule
      0.99 ± 14%      -0.8        0.18 ± 72%  perf-profile.children.cycles-pp.lookup_extent_backref
      0.99 ± 14%      -0.8        0.18 ± 72%  perf-profile.children.cycles-pp.lookup_inline_extent_backref
      1.28 ±  7%      -0.8        0.48 ± 25%  perf-profile.children.cycles-pp.btrfs_get_token_32
      1.28 ± 16%      -0.8        0.48 ± 56%  perf-profile.children.cycles-pp.check_dir_item
      1.13 ± 13%      -0.8        0.36 ± 57%  perf-profile.children.cycles-pp.btrfs_dirty_pages
      1.08 ±  7%      -0.8        0.32 ± 55%  perf-profile.children.cycles-pp.crc_pcl
      1.17 ±  9%      -0.7        0.44 ± 40%  perf-profile.children.cycles-pp.ktime_get
      1.02 ± 11%      -0.7        0.29 ± 59%  perf-profile.children.cycles-pp.__clear_extent_bit
      1.00 ± 10%      -0.7        0.28 ± 68%  perf-profile.children.cycles-pp.copy_extent_buffer_full
      1.08 ±  3%      -0.7        0.37 ± 47%  perf-profile.children.cycles-pp.perf_rotate_context
      0.94 ±  6%      -0.7        0.23 ± 62%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
      0.94 ±  6%      -0.7        0.23 ± 62%  perf-profile.children.cycles-pp.cow_file_range
      0.95 ± 14%      -0.7        0.26 ± 54%  perf-profile.children.cycles-pp.submit_extent_page
      1.00 ± 10%      -0.7        0.31 ± 61%  perf-profile.children.cycles-pp.scsi_io_completion
      1.00 ± 10%      -0.7        0.31 ± 61%  perf-profile.children.cycles-pp.scsi_end_request
      1.00 ± 15%      -0.7        0.33 ± 27%  perf-profile.children.cycles-pp.memmove_extent_buffer
      0.87 ± 16%      -0.7        0.21 ± 67%  perf-profile.children.cycles-pp.btrfs_add_delayed_data_ref
      0.92 ± 15%      -0.7        0.26 ± 69%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.78 ± 14%      -0.7        0.13 ± 57%  perf-profile.children.cycles-pp.poll_idle
      1.24 ±  5%      -0.6        0.60 ± 36%  perf-profile.children.cycles-pp.schedule
      0.93 ± 11%      -0.6        0.29 ± 45%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.87 ±  4%      -0.6        0.23 ± 60%  perf-profile.children.cycles-pp.folio_end_writeback
      0.97 ± 14%      -0.6        0.35 ± 55%  perf-profile.children.cycles-pp.btrfs_init_new_buffer
      0.73 ±  6%      -0.6        0.11 ± 95%  perf-profile.children.cycles-pp.btrfs_start_dirty_block_groups
      0.82 ±  8%      -0.6        0.21 ± 63%  perf-profile.children.cycles-pp.__set_extent_bit
      0.83 ± 15%      -0.6        0.23 ± 69%  perf-profile.children.cycles-pp.find_free_extent
      0.82 ± 14%      -0.6        0.22 ± 55%  perf-profile.children.cycles-pp.submit_one_bio
      0.84 ± 11%      -0.6        0.24 ± 56%  perf-profile.children.cycles-pp.write_one_eb
      0.81 ±  8%      -0.5        0.28 ± 47%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.84 ± 13%      -0.5        0.30 ± 35%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.86 ± 26%      -0.5        0.34 ± 27%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.86 ± 26%      -0.5        0.34 ± 27%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.86 ± 26%      -0.5        0.34 ± 27%  perf-profile.children.cycles-pp.start_kernel
      0.86 ± 26%      -0.5        0.34 ± 27%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.86 ± 26%      -0.5        0.34 ± 27%  perf-profile.children.cycles-pp.rest_init
      0.70 ±  4%      -0.5        0.18 ± 58%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.83 ±  6%      -0.5        0.34 ± 45%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.66 ±  7%      -0.5        0.18 ± 59%  perf-profile.children.cycles-pp.extent_buffer_write_end_io
      0.66 ±  8%      -0.5        0.17 ± 67%  perf-profile.children.cycles-pp.blk_mq_end_request
      0.68 ± 13%      -0.5        0.20 ± 59%  perf-profile.children.cycles-pp.btrfs_copy_from_user
      0.88 ± 22%      -0.5        0.40 ± 37%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.74 ±  5%      -0.5        0.27 ± 48%  perf-profile.children.cycles-pp.find_busiest_group
      0.67 ± 13%      -0.5        0.20 ± 59%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.66 ±  7%      -0.5        0.18 ± 59%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.73 ±  5%      -0.5        0.26 ± 47%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.66 ±  5%      -0.5        0.19 ± 56%  perf-profile.children.cycles-pp.csum_tree_block
      0.67 ±  4%      -0.5        0.21 ± 54%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.59 ±  4%      -0.5        0.13 ± 80%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.68 ±  9%      -0.5        0.22 ± 61%  perf-profile.children.cycles-pp.__common_interrupt
      0.61 ±  9%      -0.5        0.16 ± 63%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.67 ±  9%      -0.4        0.22 ± 61%  perf-profile.children.cycles-pp.handle_edge_irq
      0.67 ±  3%      -0.4        0.22 ± 43%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.67 ±  8%      -0.4        0.22 ± 60%  perf-profile.children.cycles-pp.handle_irq_event
      0.64 ± 13%      -0.4        0.20 ± 56%  perf-profile.children.cycles-pp.__memcpy
      0.61 ± 12%      -0.4        0.16 ± 60%  perf-profile.children.cycles-pp.__btrfs_bio_end_io
      0.48 ± 37%      -0.4        0.04 ±112%  perf-profile.children.cycles-pp.btrfs_finish_extent_commit
      0.69 ± 13%      -0.4        0.26 ± 51%  perf-profile.children.cycles-pp.pagecache_get_page
      0.64 ±  8%      -0.4        0.22 ± 58%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.80 ±  5%      -0.4        0.38 ± 44%  perf-profile.children.cycles-pp.load_balance
      0.56 ± 18%      -0.4        0.13 ± 79%  perf-profile.children.cycles-pp.add_delayed_ref_head
      0.71 ± 14%      -0.4        0.28 ± 45%  perf-profile.children.cycles-pp.alloc_extent_buffer
      0.64 ±  9%      -0.4        0.21 ± 59%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      0.68 ± 14%      -0.4        0.26 ± 51%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.66 ±  6%      -0.4        0.24 ± 47%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.64 ±  3%      -0.4        0.22 ± 43%  perf-profile.children.cycles-pp.native_sched_clock
      0.60 ±  8%      -0.4        0.20 ± 49%  perf-profile.children.cycles-pp.rcu_pending
      0.60 ±  7%      -0.4        0.20 ± 46%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.54 ± 12%      -0.4        0.14 ± 67%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.54 ± 12%      -0.4        0.14 ± 60%  perf-profile.children.cycles-pp.end_bio_extent_writepage
      0.54 ± 14%      -0.4        0.15 ± 55%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
      0.52 ± 12%      -0.4        0.13 ± 52%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      0.52 ± 12%      -0.4        0.14 ± 53%  perf-profile.children.cycles-pp.set_extent_bit
      0.42 ± 42%      -0.4        0.03 ±103%  perf-profile.children.cycles-pp.unpin_extent_range
      0.58 ± 12%      -0.4        0.20 ± 31%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
      0.59 ± 11%      -0.4        0.22 ± 33%  perf-profile.children.cycles-pp.clockevents_program_event
      0.53 ± 17%      -0.4        0.16 ± 59%  perf-profile.children.cycles-pp.alloc_extent_state
      0.57 ±  5%      -0.4        0.20 ± 36%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.46 ± 10%      -0.4        0.11 ± 65%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.50 ± 15%      -0.4        0.15 ± 57%  perf-profile.children.cycles-pp.crc32c_pcl_intel_digest
      0.69 ±  5%      -0.4        0.34 ± 50%  perf-profile.children.cycles-pp.newidle_balance
      0.43 ± 14%      -0.4        0.08 ± 31%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.50 ±  7%      -0.4        0.15 ± 65%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.48 ±  5%      -0.3        0.14 ± 45%  perf-profile.children.cycles-pp.xas_load
      0.50 ± 16%      -0.3        0.16 ± 47%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.48 ±  9%      -0.3        0.13 ± 61%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.53 ±  7%      -0.3        0.19 ± 47%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.50 ± 11%      -0.3        0.16 ± 63%  perf-profile.children.cycles-pp.ahci_handle_port_intr
      0.56 ±  8%      -0.3        0.22 ± 41%  perf-profile.children.cycles-pp.read_tsc
      0.46 ± 13%      -0.3        0.13 ± 56%  perf-profile.children.cycles-pp.btrfs_get_8
      0.49 ± 10%      -0.3        0.16 ± 47%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.50 ± 16%      -0.3        0.18 ± 48%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.43 ±  8%      -0.3        0.11 ± 53%  perf-profile.children.cycles-pp.rb_erase
      0.47 ±  7%      -0.3        0.16 ± 43%  perf-profile.children.cycles-pp.sched_clock
      0.42 ± 13%      -0.3        0.11 ± 38%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.39 ± 12%      -0.3        0.08 ± 65%  perf-profile.children.cycles-pp.down_read
      0.46 ± 10%      -0.3        0.16 ± 51%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.46 ±  4%      -0.3        0.16 ± 50%  perf-profile.children.cycles-pp.ct_idle_exit
      0.95 ± 11%      -0.3        0.65 ± 10%  perf-profile.children.cycles-pp.read_block_for_search
      0.40 ±  7%      -0.3        0.10 ± 46%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.46 ±  9%      -0.3        0.16 ± 49%  perf-profile.children.cycles-pp.timerqueue_add
      0.42 ± 12%      -0.3        0.13 ± 67%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.44 ±  6%      -0.3        0.15 ± 52%  perf-profile.children.cycles-pp.timerqueue_del
      0.43 ± 14%      -0.3        0.15 ± 55%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.48 ±  6%      -0.3        0.20 ± 54%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.42 ±  9%      -0.3        0.14 ± 49%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.40 ± 19%      -0.3        0.13 ± 50%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.49 ± 10%      -0.3        0.22 ± 32%  perf-profile.children.cycles-pp.try_to_wake_up
      0.40 ± 10%      -0.3        0.13 ± 47%  perf-profile.children.cycles-pp.irqentry_enter
      0.35 ± 12%      -0.3        0.08 ± 75%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.32 ± 13%      -0.3        0.06 ±103%  perf-profile.children.cycles-pp.btrfs_alloc_reserved_file_extent
      0.32 ± 15%      -0.3        0.06 ± 91%  perf-profile.children.cycles-pp.clear_state_bit
      0.32 ± 10%      -0.3        0.07 ± 96%  perf-profile.children.cycles-pp.lock_extent
      0.32 ± 10%      -0.2        0.06 ± 65%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      0.37 ±  9%      -0.2        0.13 ± 28%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.35 ± 15%      -0.2        0.11 ± 53%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.34 ± 17%      -0.2        0.10 ± 72%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.35 ± 10%      -0.2        0.12 ± 40%  perf-profile.children.cycles-pp.rb_next
      0.34 ± 23%      -0.2        0.10 ± 51%  perf-profile.children.cycles-pp.filemap_get_entry
      0.40 ± 10%      -0.2        0.18 ± 42%  perf-profile.children.cycles-pp.kmem_cache_free
      0.32 ± 17%      -0.2        0.09 ± 48%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.30 ±  9%      -0.2        0.07 ± 54%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.32 ± 13%      -0.2        0.10 ± 67%  perf-profile.children.cycles-pp.check_cpu_stall
      0.36 ± 17%      -0.2        0.14 ± 45%  perf-profile.children.cycles-pp.check_inode_key
      0.32 ± 18%      -0.2        0.10 ± 58%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.41 ±  5%      -0.2        0.20 ± 21%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.72 ± 11%      -0.2        0.50 ± 12%  perf-profile.children.cycles-pp.find_extent_buffer
      0.32 ±  9%      -0.2        0.10 ± 34%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.32 ±  9%      -0.2        0.10 ± 74%  perf-profile.children.cycles-pp.write_all_supers
      0.35 ±  7%      -0.2        0.13 ± 43%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.27 ± 23%      -0.2        0.06 ±108%  perf-profile.children.cycles-pp.btrfs_find_space_for_alloc
      0.26 ± 11%      -0.2        0.05 ±111%  perf-profile.children.cycles-pp.btrfs_set_extent_delalloc
      0.33 ± 11%      -0.2        0.12 ± 51%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.33 ± 11%      -0.2        0.12 ± 51%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.32 ±  9%      -0.2        0.11 ± 53%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.38 ±  7%      -0.2        0.17 ± 31%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.32 ± 18%      -0.2        0.11 ± 61%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.31 ±  9%      -0.2        0.10 ± 32%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.30 ±  8%      -0.2        0.09 ± 34%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.34 ± 44%      -0.2        0.14 ± 69%  perf-profile.children.cycles-pp.do_softirq
      0.30 ± 15%      -0.2        0.10 ± 50%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.26 ± 10%      -0.2        0.06 ±121%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.24 ± 11%      -0.2        0.04 ±112%  perf-profile.children.cycles-pp.blk_mq_get_new_requests
      0.31 ± 19%      -0.2        0.11 ± 59%  perf-profile.children.cycles-pp.blk_finish_plug
      0.28 ±  8%      -0.2        0.08 ± 68%  perf-profile.children.cycles-pp.btrfs_set_range_writeback
      0.33 ± 14%      -0.2        0.13 ± 15%  perf-profile.children.cycles-pp.btrfs_release_path
      0.26 ± 25%      -0.2        0.07 ± 72%  perf-profile.children.cycles-pp.filemap_fdatawait_range
      0.27 ±  7%      -0.2        0.08 ± 62%  perf-profile.children.cycles-pp.xas_descend
      0.26 ± 25%      -0.2        0.07 ± 72%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.32 ±  9%      -0.2        0.12 ± 49%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.24 ± 12%      -0.2        0.05 ±110%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.28 ± 17%      -0.2        0.09 ± 38%  perf-profile.children.cycles-pp.get_cpu_device
      0.40 ± 14%      -0.2        0.20 ± 29%  perf-profile.children.cycles-pp.schedule_idle
      0.27 ± 13%      -0.2        0.08 ± 64%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      0.23 ± 12%      -0.2        0.04 ±107%  perf-profile.children.cycles-pp.create_io_em
      0.54 ±  4%      -0.2        0.35 ± 10%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.22 ± 12%      -0.2        0.04 ±106%  perf-profile.children.cycles-pp.block_group_cache_tree_search
      0.27 ± 11%      -0.2        0.09 ± 34%  perf-profile.children.cycles-pp.irq_work_tick
      0.29 ± 15%      -0.2        0.11 ± 46%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.37 ±  7%      -0.2        0.20 ± 32%  perf-profile.children.cycles-pp.rcu_core
      0.29 ± 12%      -0.2        0.11 ± 50%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.24 ±  9%      -0.2        0.06 ±109%  perf-profile.children.cycles-pp.ahci_qc_complete
      0.21 ± 12%      -0.2        0.04 ±105%  perf-profile.children.cycles-pp.btrfs_replace_extent_map_range
      0.30 ± 17%      -0.2        0.13 ± 23%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.22 ± 15%      -0.2        0.05 ±114%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      0.28 ± 13%      -0.2        0.11 ± 42%  perf-profile.children.cycles-pp.__cond_resched
      0.26 ± 10%      -0.2        0.09 ± 66%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      0.27 ± 11%      -0.2        0.10 ± 41%  perf-profile.children.cycles-pp.release_extent_buffer
      0.25 ± 18%      -0.2        0.08 ± 40%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.23 ± 13%      -0.2        0.07 ± 84%  perf-profile.children.cycles-pp.scsi_queue_rq
      0.31 ± 10%      -0.2        0.14 ± 29%  perf-profile.children.cycles-pp.activate_task
      0.21 ± 19%      -0.2        0.05 ± 84%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.24 ± 28%      -0.2        0.07 ± 30%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.30 ± 12%      -0.2        0.14 ± 29%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.25 ± 15%      -0.2        0.09 ± 40%  perf-profile.children.cycles-pp.kick_pool
      0.20 ± 12%      -0.2        0.04 ±100%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
      0.20 ± 12%      -0.2        0.04 ±114%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.20 ± 21%      -0.2        0.05 ± 72%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.45 ± 14%      -0.2        0.30 ±  9%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.24 ± 20%      -0.2        0.09 ± 56%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.21 ± 19%      -0.2        0.05 ± 82%  perf-profile.children.cycles-pp.__slab_free
      0.24 ±  8%      -0.2        0.08 ± 82%  perf-profile.children.cycles-pp.btrfs_update_root
      0.20 ± 10%      -0.2        0.05 ±102%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.20 ± 17%      -0.2        0.05 ± 76%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.19 ± 15%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.io_schedule
      0.24 ± 11%      -0.1        0.09 ± 36%  perf-profile.children.cycles-pp.rebalance_domains
      0.20 ± 13%      -0.1        0.06 ±105%  perf-profile.children.cycles-pp.error_entry
      0.19 ± 18%      -0.1        0.05 ± 84%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.22 ± 23%      -0.1        0.08 ± 36%  perf-profile.children.cycles-pp.update_rq_clock
      0.21 ± 10%      -0.1        0.07 ± 57%  perf-profile.children.cycles-pp.note_gp_changes
      0.18 ± 12%      -0.1        0.04 ±115%  perf-profile.children.cycles-pp.btrfs_free_tree_block
      0.18 ± 22%      -0.1        0.04 ±114%  perf-profile.children.cycles-pp.prepare_pages
      0.18 ± 13%      -0.1        0.04 ±103%  perf-profile.children.cycles-pp.cpu_util
      0.17 ± 14%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.menu_reflect
      0.17 ± 16%      -0.1        0.04 ±108%  perf-profile.children.cycles-pp.__xa_set_mark
      0.16 ± 15%      -0.1        0.04 ±109%  perf-profile.children.cycles-pp.insert_delayed_ref
      0.17 ± 21%      -0.1        0.04 ±128%  perf-profile.children.cycles-pp.update_block_group_item
      0.19 ± 28%      -0.1        0.06 ± 91%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.25 ± 14%      -0.1        0.12 ± 33%  perf-profile.children.cycles-pp.enqueue_entity
      0.18 ± 12%      -0.1        0.06 ± 87%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.16 ± 18%      -0.1        0.03 ±106%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.16 ± 29%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.btrfs_map_block
      0.19 ± 12%      -0.1        0.07 ± 56%  perf-profile.children.cycles-pp.execve
      0.19 ± 12%      -0.1        0.07 ± 56%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.19 ± 12%      -0.1        0.07 ± 56%  perf-profile.children.cycles-pp.do_execveat_common
      0.24 ± 16%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.23 ± 11%      -0.1        0.11 ± 38%  perf-profile.children.cycles-pp.__queue_work
      0.16 ± 16%      -0.1        0.04 ±104%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.19 ± 15%      -0.1        0.07 ± 58%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.15 ± 13%      -0.1        0.03 ±108%  perf-profile.children.cycles-pp.idle_cpu
      0.15 ± 18%      -0.1        0.04 ±102%  perf-profile.children.cycles-pp.cmd_stat
      0.15 ± 18%      -0.1        0.04 ±102%  perf-profile.children.cycles-pp.dispatch_events
      0.15 ± 19%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.process_interval
      0.22 ±  9%      -0.1        0.11 ± 40%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.21 ± 17%      -0.1        0.10 ± 28%  perf-profile.children.cycles-pp.dequeue_entity
      0.22 ± 16%      -0.1        0.11 ± 15%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.14 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.18 ± 10%      -0.1        0.07 ± 85%  perf-profile.children.cycles-pp.ksys_read
      0.16 ± 20%      -0.1        0.05 ± 48%  perf-profile.children.cycles-pp.exc_page_fault
      0.16 ± 20%      -0.1        0.05 ± 48%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.14 ± 16%      -0.1        0.03 ±106%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.18 ± 15%      -0.1        0.07 ± 23%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.14 ± 19%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.read_counters
      0.16 ± 10%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.free_extent_buffer
      0.20 ± 22%      -0.1        0.09 ± 46%  perf-profile.children.cycles-pp.filemap_add_folio
      0.17 ±  7%      -0.1        0.06 ± 88%  perf-profile.children.cycles-pp.vfs_read
      0.22 ± 16%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.leaf_space_used
      0.14 ± 20%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.btrfs_root_node
      0.14 ± 19%      -0.1        0.04 ±118%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.28 ± 22%      -0.1        0.18 ± 17%  perf-profile.children.cycles-pp.rb_insert_color
      0.14 ± 23%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.14 ± 23%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.14 ± 16%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.check_inode_item
      0.13 ± 17%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.leave_mm
      0.15 ± 10%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.handle_mm_fault
      0.13 ± 18%      -0.1        0.03 ±106%  perf-profile.children.cycles-pp.bprm_execve
      0.14 ± 24%      -0.1        0.04 ±111%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.12 ± 22%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.15 ± 12%      -0.1        0.05 ± 88%  perf-profile.children.cycles-pp.read
      0.22 ± 17%      -0.1        0.12 ± 22%  perf-profile.children.cycles-pp.update_load_avg
      0.12 ± 11%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.__folio_batch_release
      0.18 ± 13%      -0.1        0.09 ± 25%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.21 ± 17%      -0.1        0.12 ± 22%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.13 ± 14%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.__wake_up_common
      0.12 ± 26%      -0.1        0.04 ±107%  perf-profile.children.cycles-pp.select_task_rq
      0.15 ± 13%      -0.1        0.07 ± 30%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.12 ± 16%      -0.1        0.04 ± 74%  perf-profile.children.cycles-pp.prepare_task_switch
      0.16 ± 20%      -0.1        0.09 ± 30%  perf-profile.children.cycles-pp.queue_work_on
      0.14 ± 25%      -0.1        0.07 ± 17%  perf-profile.children.cycles-pp.btrfs_free_path
      0.10 ±  7%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.___perf_sw_event
      0.11 ± 14%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.11 ± 26%      -0.1        0.04 ± 80%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.21 ± 10%      -0.1        0.15 ± 17%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.09 ± 20%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.update_curr
      0.12 ± 23%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.wake_up_q
      0.07 ± 18%      +0.0        0.10 ± 18%  perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.workingset_activation
      0.03 ±102%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.alloc_empty_file
      0.06 ± 50%      +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.allocate_slab
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.inode_permission
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.fill_inode_item
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.do_open
      0.08 ± 26%      +0.1        0.16 ± 25%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.push_leaf_left
      0.00            +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.__d_alloc
      0.00            +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.__fput
      0.00            +0.1        0.12 ± 30%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.1        0.15 ± 22%  perf-profile.children.cycles-pp.btrfs_alloc_inode
      0.00            +0.2        0.15 ± 23%  perf-profile.children.cycles-pp.d_alloc
      0.00            +0.2        0.16 ± 22%  perf-profile.children.cycles-pp.dput
      0.00            +0.2        0.17 ± 20%  perf-profile.children.cycles-pp.alloc_inode
      0.00            +0.2        0.18 ± 19%  perf-profile.children.cycles-pp.__close
      0.00            +0.2        0.19 ± 19%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.00            +0.2        0.19 ± 20%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.21 ±  9%      +0.2        0.41 ± 13%  perf-profile.children.cycles-pp.start_transaction
      0.00            +0.2        0.20 ± 28%  perf-profile.children.cycles-pp.__btrfs_add_delayed_item
      0.00            +0.2        0.22 ± 20%  perf-profile.children.cycles-pp.new_inode
      0.00            +0.2        0.23 ± 22%  perf-profile.children.cycles-pp.btrfs_create
      0.00            +0.3        0.26 ± 26%  perf-profile.children.cycles-pp.__push_leaf_right
      0.01 ±223%      +0.3        0.32 ± 19%  perf-profile.children.cycles-pp.push_leaf_right
      0.00            +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.inode_tree_add
      0.00            +0.3        0.34 ± 18%  perf-profile.children.cycles-pp.btrfs_insert_delayed_item
      2.48 ±  6%      +0.4        2.87 ±  5%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      0.00            +0.4        0.43 ± 24%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.06 ± 24%      +0.5        0.52 ± 18%  perf-profile.children.cycles-pp.split_leaf
      0.00            +0.5        0.47 ± 14%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      0.00            +0.5        0.47 ± 14%  perf-profile.children.cycles-pp.btrfs_lookup
      0.00            +1.6        1.58 ± 18%  perf-profile.children.cycles-pp.insert_with_overflow
      0.00            +2.1        2.10 ± 19%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      0.00            +2.3        2.25 ± 19%  perf-profile.children.cycles-pp.btrfs_add_link
      1.50 ± 13%      +3.0        4.55 ± 17%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.00            +3.4        3.44 ± 17%  perf-profile.children.cycles-pp.btrfs_create_new_inode
      0.00            +3.9        3.93 ± 17%  perf-profile.children.cycles-pp.btrfs_create_common
      0.00            +4.9        4.94 ± 17%  perf-profile.children.cycles-pp.lookup_open
      0.56 ± 24%     +57.8       58.40 ± 21%  perf-profile.children.cycles-pp.osq_lock
      2.50 ± 13%     +60.5       62.98 ± 21%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      2.78 ± 12%     +60.6       63.42 ± 21%  perf-profile.children.cycles-pp.down_write
      2.58 ± 13%     +60.8       63.34 ± 21%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      5.44 ± 27%     +63.8       69.26 ± 20%  perf-profile.children.cycles-pp.do_syscall_64
      5.45 ± 27%     +63.8       69.26 ± 21%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00           +68.2       68.24 ± 21%  perf-profile.children.cycles-pp.open_last_lookups
      0.08 ± 21%     +68.5       68.56 ± 21%  perf-profile.children.cycles-pp.path_openat
      0.08 ± 21%     +68.5       68.57 ± 21%  perf-profile.children.cycles-pp.do_filp_open
      0.09 ± 13%     +68.6       68.66 ± 21%  perf-profile.children.cycles-pp.do_sys_openat2
      0.09 ± 13%     +68.6       68.66 ± 21%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00           +68.7       68.72 ± 21%  perf-profile.children.cycles-pp.open64
     22.68 ±  3%     -14.7        8.03 ± 41%  perf-profile.self.cycles-pp.intel_idle
      4.94 ±  7%      -3.5        1.42 ± 53%  perf-profile.self.cycles-pp.read_extent_buffer
      5.14 ±  6%      -3.2        1.90 ± 29%  perf-profile.self.cycles-pp.__memmove
      2.76 ±  6%      -1.9        0.86 ± 51%  perf-profile.self.cycles-pp.btrfs_get_32
      1.98 ±  9%      -1.4        0.56 ± 60%  perf-profile.self.cycles-pp.btrfs_get_64
      1.78 ±  5%      -1.1        0.64 ± 48%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.76 ±  6%      -1.0        0.81 ± 24%  perf-profile.self.cycles-pp._raw_spin_lock
      1.41 ± 10%      -0.9        0.55 ± 44%  perf-profile.self.cycles-pp.__write_extent_buffer
      1.30 ±  9%      -0.8        0.49 ± 49%  perf-profile.self.cycles-pp.menu_select
      1.23 ± 10%      -0.8        0.46 ± 26%  perf-profile.self.cycles-pp.btrfs_set_token_32
      1.08 ±  7%      -0.8        0.32 ± 55%  perf-profile.self.cycles-pp.crc_pcl
      1.13 ±  7%      -0.7        0.43 ± 25%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.76 ± 14%      -0.6        0.12 ± 57%  perf-profile.self.cycles-pp.poll_idle
      0.81 ±  6%      -0.6        0.19 ± 66%  perf-profile.self.cycles-pp.check_extent_item
      0.76 ± 11%      -0.5        0.22 ± 63%  perf-profile.self.cycles-pp.__btrfs_check_leaf
      0.58 ±  5%      -0.5        0.13 ± 80%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.64 ± 13%      -0.4        0.20 ± 55%  perf-profile.self.cycles-pp.__memcpy
      0.67 ± 13%      -0.4        0.25 ± 36%  perf-profile.self.cycles-pp.ktime_get
      0.62 ±  5%      -0.4        0.22 ± 44%  perf-profile.self.cycles-pp.native_sched_clock
      0.55 ± 15%      -0.4        0.19 ± 36%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.47 ± 16%      -0.4        0.10 ± 82%  perf-profile.self.cycles-pp.add_delayed_ref_head
      0.45 ± 12%      -0.4        0.10 ± 88%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.50 ± 16%      -0.3        0.16 ± 47%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.54 ±  7%      -0.3        0.21 ± 39%  perf-profile.self.cycles-pp.read_tsc
      0.42 ±  8%      -0.3        0.11 ± 51%  perf-profile.self.cycles-pp.rb_erase
      0.46 ± 10%      -0.3        0.16 ± 51%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.43 ±  2%      -0.3        0.14 ± 48%  perf-profile.self.cycles-pp.perf_rotate_context
      0.47 ± 11%      -0.3        0.19 ± 20%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.48 ±  6%      -0.3        0.20 ± 54%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.40 ± 18%      -0.3        0.13 ± 48%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.36 ±  9%      -0.3        0.09 ± 48%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.38 ± 16%      -0.3        0.11 ± 53%  perf-profile.self.cycles-pp.btrfs_get_8
      0.40 ±  9%      -0.3        0.14 ± 56%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.52 ± 14%      -0.2        0.27 ± 37%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.37 ±  9%      -0.2        0.13 ± 28%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.36 ± 13%      -0.2        0.12 ± 71%  perf-profile.self.cycles-pp.check_leaf_item
      0.29 ± 11%      -0.2        0.05 ±111%  perf-profile.self.cycles-pp.btrfs_del_items
      0.37 ± 15%      -0.2        0.13 ± 58%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.36 ± 19%      -0.2        0.12 ± 48%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.38 ±  8%      -0.2        0.15 ± 47%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.34 ± 15%      -0.2        0.11 ± 58%  perf-profile.self.cycles-pp.check_extent_data_item
      0.34 ± 10%      -0.2        0.10 ± 56%  perf-profile.self.cycles-pp.rb_next
      0.32 ± 13%      -0.2        0.10 ± 69%  perf-profile.self.cycles-pp.check_cpu_stall
      0.37 ± 13%      -0.2        0.16 ± 45%  perf-profile.self.cycles-pp.kmem_cache_free
      0.31 ± 17%      -0.2        0.10 ± 61%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.30 ±  7%      -0.2        0.09 ± 34%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.30 ± 10%      -0.2        0.10 ± 52%  perf-profile.self.cycles-pp.timerqueue_add
      0.30 ± 14%      -0.2        0.11 ± 54%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.32 ±  9%      -0.2        0.12 ± 49%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.23 ± 11%      -0.2        0.04 ±107%  perf-profile.self.cycles-pp.__set_extent_bit
      0.28 ± 18%      -0.2        0.09 ± 38%  perf-profile.self.cycles-pp.get_cpu_device
      0.28 ±  9%      -0.2        0.10 ± 35%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.34 ± 10%      -0.2        0.16 ± 17%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.25 ± 14%      -0.2        0.06 ± 74%  perf-profile.self.cycles-pp.irq_work_tick
      0.29 ± 15%      -0.2        0.11 ± 46%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.26 ±  6%      -0.2        0.08 ± 62%  perf-profile.self.cycles-pp.rcu_pending
      0.53 ±  4%      -0.2        0.35 ± 10%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.26 ± 16%      -0.2        0.08 ± 65%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.24 ±  7%      -0.2        0.06 ± 79%  perf-profile.self.cycles-pp.do_idle
      0.27 ±  6%      -0.2        0.09 ± 43%  perf-profile.self.cycles-pp.scheduler_tick
      0.30 ± 17%      -0.2        0.13 ± 23%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.24 ±  7%      -0.2        0.07 ± 61%  perf-profile.self.cycles-pp.xas_descend
      0.22 ± 12%      -0.2        0.06 ±109%  perf-profile.self.cycles-pp.__btrfs_cow_block
      0.25 ± 12%      -0.2        0.10 ± 47%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.21 ±  5%      -0.2        0.06 ± 53%  perf-profile.self.cycles-pp.cpuidle_enter
      0.21 ± 19%      -0.2        0.05 ± 82%  perf-profile.self.cycles-pp.__slab_free
      0.24 ± 20%      -0.1        0.09 ± 67%  perf-profile.self.cycles-pp.update_process_times
      0.20 ± 11%      -0.1        0.05 ±104%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.20 ± 17%      -0.1        0.06 ±109%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.19 ± 23%      -0.1        0.06 ±108%  perf-profile.self.cycles-pp.check_dir_item
      0.17 ± 14%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.20 ± 11%      -0.1        0.06 ±105%  perf-profile.self.cycles-pp.error_entry
      0.18 ± 20%      -0.1        0.05 ± 84%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.17 ± 30%      -0.1        0.04 ±118%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.17 ± 15%      -0.1        0.04 ±104%  perf-profile.self.cycles-pp.cpu_util
      0.19 ± 25%      -0.1        0.06 ± 51%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.17 ± 13%      -0.1        0.04 ± 77%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.16 ± 19%      -0.1        0.03 ±111%  perf-profile.self.cycles-pp.irqentry_enter
      0.17 ± 19%      -0.1        0.04 ±109%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.16 ± 34%      -0.1        0.04 ±104%  perf-profile.self.cycles-pp.filemap_get_entry
      0.16 ± 15%      -0.1        0.03 ±106%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.16 ± 22%      -0.1        0.04 ±105%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.16 ± 10%      -0.1        0.04 ±104%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.16 ± 22%      -0.1        0.04 ±118%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.16 ± 14%      -0.1        0.05 ± 84%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.25 ± 13%      -0.1        0.14 ± 13%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.16 ± 18%      -0.1        0.05 ± 54%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.14 ± 12%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.14 ± 17%      -0.1        0.03 ±106%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.16 ± 15%      -0.1        0.05 ± 76%  perf-profile.self.cycles-pp.__cond_resched
      0.20 ± 11%      -0.1        0.10 ± 44%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ± 14%      -0.1        0.04 ±107%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.13 ± 21%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.btrfs_root_node
      0.28 ± 22%      -0.1        0.18 ± 16%  perf-profile.self.cycles-pp.rb_insert_color
      0.14 ± 17%      -0.1        0.04 ±115%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.14 ± 23%      -0.1        0.04 ± 75%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.14 ± 20%      -0.1        0.04 ±100%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.14 ± 17%      -0.1        0.04 ±102%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.12 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.16 ±  7%      -0.1        0.07 ± 23%  perf-profile.self.cycles-pp.down_write
      0.14 ± 32%      -0.1        0.05 ± 50%  perf-profile.self.cycles-pp.up_write
      0.12 ± 22%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.__schedule
      0.10 ± 33%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.update_rq_clock
      0.14 ± 28%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.set_extent_buffer_dirty
      0.01 ±223%      +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.mutex_lock
      0.04 ± 72%      +0.1        0.11 ± 31%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.00            +0.2        0.18 ± 29%  perf-profile.self.cycles-pp.__btrfs_add_delayed_item
      0.00            +0.3        0.26 ± 18%  perf-profile.self.cycles-pp.inode_tree_add
      1.38 ± 15%      +3.1        4.48 ± 18%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.55 ± 23%     +57.7       58.24 ± 21%  perf-profile.self.cycles-pp.osq_lock


***************************************************************************************************
lkp-icl-2sp5: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase:
  gcc-12/performance/bufferedio/1SSD/btrfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/MWUL/fxmark

commit: 
  adb86dbe42 ("btrfs: stop doing excessive space reservation for csum deletion")
  28270e25c6 ("btrfs: always reserve space for delayed refs when starting transaction")

adb86dbe426f9a54 28270e25c69a2c76ea1ed092209 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10.92 ±  8%      +2.5       13.38 ±  2%  mpstat.cpu.all.iowait%
    293.17 ± 10%     +15.8%     339.50 ±  6%  perf-c2c.DRAM.remote
 2.131e+10 ±  2%     +42.8%  3.042e+10 ±  5%  cpuidle..time
  32307754           +35.6%   43819741 ±  4%  cpuidle..usage
     71.62 ±  2%      -4.0%      68.78 ±  4%  iostat.cpu.idle
     10.96 ±  8%     +22.3%      13.40 ±  2%  iostat.cpu.iowait
   5693588 ±  8%     +33.0%    7574795 ±  2%  numa-numastat.node0.local_node
   5767288 ±  7%     +32.2%    7623787 ±  2%  numa-numastat.node0.numa_hit
    640.05           +51.9%     972.15 ±  3%  uptime.boot
      1118 ±  6%     +20.8%       1351 ±  2%  uptime.idle
     41634           -22.2%      32380        vmstat.system.cs
     41713 ±  2%      -4.7%      39745        vmstat.system.in
   1578377 ±  2%     +26.7%    1999423 ±  2%  meminfo.Active
   1551429 ±  2%     +27.4%    1976864 ±  2%  meminfo.Active(file)
      1731 ±  7%     -33.8%       1145 ±  8%  meminfo.Dirty
      1140           +39.5%       1589        meminfo.Mlocked
   1257431 ± 14%     +47.2%    1851234 ±  7%  numa-meminfo.node0.Active
   1231250 ± 14%     +48.6%    1829051 ±  7%  numa-meminfo.node0.Active(file)
      1702 ±  5%     -30.1%       1189 ±  6%  numa-meminfo.node0.Dirty
     50665 ± 31%     -69.5%      15466 ± 72%  numa-meminfo.node1.Inactive(file)
    307874 ± 14%     +48.5%     457079 ±  7%  numa-vmstat.node0.nr_active_file
  30692931 ± 13%     +81.7%   55756941 ±  4%  numa-vmstat.node0.nr_dirtied
    421.23 ±  5%     -29.4%     297.38 ±  7%  numa-vmstat.node0.nr_dirty
  30589363 ± 13%     +82.2%   55721572 ±  4%  numa-vmstat.node0.nr_written
    307874 ± 14%     +48.5%     457079 ±  7%  numa-vmstat.node0.nr_zone_active_file
    416.36 ±  6%     -31.9%     283.59 ±  6%  numa-vmstat.node0.nr_zone_write_pending
   5767412 ±  7%     +32.2%    7624455 ±  2%  numa-vmstat.node0.numa_hit
   5693712 ±  8%     +33.0%    7575464 ±  2%  numa-vmstat.node0.numa_local
     12657 ± 31%     -69.4%       3867 ± 72%  numa-vmstat.node1.nr_inactive_file
     12657 ± 31%     -69.4%       3867 ± 72%  numa-vmstat.node1.nr_zone_inactive_file
      0.01 ± 53%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction
      0.06 ± 33%     +48.3%       0.09 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction
      0.25 ± 13%     +20.9%       0.31 ± 12%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.08 ± 16%   +1639.3%       1.33 ±204%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
     12.55 ±  3%      +8.4%      13.60 ±  3%  perf-sched.total_wait_and_delay.average.ms
    100127            -8.3%      91846 ±  4%  perf-sched.total_wait_and_delay.count.ms
     12.49 ±  3%      +8.4%      13.54 ±  3%  perf-sched.total_wait_time.average.ms
      4.08 ±  7%     +49.4%       6.09 ± 21%  perf-sched.wait_and_delay.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
     41.17 ±  2%      -8.5%      37.67 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     36687 ±  4%     -18.3%      29959 ± 10%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     10864 ±  5%     -25.7%       8069 ±  6%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    590.17 ±  6%     +40.0%     826.00 ± 25%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
      1147 ±  6%     -51.0%     562.67 ± 30%  perf-sched.wait_and_delay.count.wait_current_trans.start_transaction.btrfs_create_common.lookup_open.isra
    175.11 ± 49%     -54.9%      79.04 ± 82%  perf-sched.wait_and_delay.max.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
      0.03 ± 58%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction
      0.06 ± 20%    +137.8%       0.15 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__btrfs_run_delayed_items.flush_space.btrfs_async_reclaim_metadata_space
      0.07 ±  9%     +61.5%       0.11 ± 13%  perf-sched.wait_time.avg.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      4.01 ±  8%     +49.9%       6.02 ± 21%  perf-sched.wait_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
     11.71 ±  7%     -25.3%       8.75 ± 20%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      0.04 ± 65%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction
      0.21 ± 41%    +324.0%       0.89 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__btrfs_run_delayed_items.flush_space.btrfs_async_reclaim_metadata_space
      0.70 ± 28%    +175.9%       1.92 ± 92%  perf-sched.wait_time.max.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
    175.00 ± 49%     -54.9%      78.94 ± 82%  perf-sched.wait_time.max.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
    387846 ±  2%     +27.4%     494065 ±  2%  proc-vmstat.nr_active_file
     78012            -2.8%      75839        proc-vmstat.nr_anon_pages
  39103842           +56.7%   61257592 ±  4%  proc-vmstat.nr_dirtied
    427.65 ±  7%     -33.1%     286.12 ±  7%  proc-vmstat.nr_dirty
   1183128            +8.5%    1283777        proc-vmstat.nr_file_pages
    107770            -2.0%     105641        proc-vmstat.nr_inactive_anon
      8565            -1.3%       8456        proc-vmstat.nr_mapped
    284.93           +39.5%     397.55        proc-vmstat.nr_mlock
  38996089           +57.0%   61219034 ±  4%  proc-vmstat.nr_written
    387846 ±  2%     +27.4%     494065 ±  2%  proc-vmstat.nr_zone_active_file
    107770            -2.0%     105641        proc-vmstat.nr_zone_inactive_anon
    423.55 ±  6%     -34.9%     275.68 ±  7%  proc-vmstat.nr_zone_write_pending
   6886064 ±  4%     +20.9%    8323748 ±  2%  proc-vmstat.numa_hit
   6752443 ±  4%     +21.3%    8190101 ±  2%  proc-vmstat.numa_local
   2805075 ±  2%     +38.3%    3878866 ±  2%  proc-vmstat.pgactivate
   7654398 ±  4%     +18.8%    9096012 ±  2%  proc-vmstat.pgalloc_normal
    109042 ±  2%     +56.6%     170715        proc-vmstat.pgdeactivate
   1760564           +38.1%    2431174 ±  2%  proc-vmstat.pgfault
   7602048 ±  4%     +19.0%    9045420 ±  2%  proc-vmstat.pgfree
 1.576e+08           +57.3%   2.48e+08 ±  4%  proc-vmstat.pgpgout
    113538 ±  2%     +33.0%     150975 ±  4%  proc-vmstat.pgreuse
    128054           +43.9%     184244        proc-vmstat.pgrotated
   2584365            +2.7%    2653450        proc-vmstat.slabs_scanned
   5260928           +46.6%    7711232 ±  3%  proc-vmstat.unevictable_pgs_scanned
      2776 ± 88%   +4950.0%     140187 ±191%  sched_debug.cfs_rq:/.left_vruntime.avg
      8759 ± 74%   +2704.6%     245662 ±199%  sched_debug.cfs_rq:/.left_vruntime.max
      0.00        +6.9e+12%      69459 ±167%  sched_debug.cfs_rq:/.left_vruntime.min
     26654 ± 66%   +3809.0%    1041910 ±192%  sched_debug.cfs_rq:/.load.min
      8994 ±  4%     -51.9%       4322 ± 59%  sched_debug.cfs_rq:/.load_avg.max
    136.12 ± 90%    +159.8%     353.63 ± 20%  sched_debug.cfs_rq:/.load_avg.min
      1383 ± 25%     -52.3%     659.96 ± 69%  sched_debug.cfs_rq:/.load_avg.stddev
      0.25 ± 32%     +74.8%       0.45 ± 23%  sched_debug.cfs_rq:/.nr_running.avg
      0.11 ± 75%    +166.3%       0.29 ± 31%  sched_debug.cfs_rq:/.nr_running.min
      2776 ± 88%   +4950.0%     140187 ±191%  sched_debug.cfs_rq:/.right_vruntime.avg
      8759 ± 74%   +2704.6%     245662 ±199%  sched_debug.cfs_rq:/.right_vruntime.max
      0.00        +6.9e+12%      69459 ±167%  sched_debug.cfs_rq:/.right_vruntime.min
    331836 ±  3%     +48.2%     491782 ±  4%  sched_debug.cpu.clock.avg
    331838 ±  3%     +48.2%     491784 ±  4%  sched_debug.cpu.clock.max
    331834 ±  3%     +48.2%     491780 ±  4%  sched_debug.cpu.clock.min
    324098 ±  3%     +48.1%     480145 ±  4%  sched_debug.cpu.clock_task.avg
    325647 ±  3%     +48.1%     482151 ±  4%  sched_debug.cpu.clock_task.max
    317444 ±  3%     +49.0%     472900 ±  4%  sched_debug.cpu.clock_task.min
      1782 ± 10%     +20.9%       2154 ±  8%  sched_debug.cpu.clock_task.stddev
      2812 ± 38%     +93.8%       5449 ± 15%  sched_debug.cpu.curr->pid.avg
     13615 ±  2%     +29.4%      17623 ±  2%  sched_debug.cpu.curr->pid.max
      3295 ±  5%     +21.3%       3997 ±  6%  sched_debug.cpu.curr->pid.stddev
      0.09 ±113%    +210.6%       0.29 ± 36%  sched_debug.cpu.nr_running.min
    572738 ± 26%     +46.8%     840748 ± 11%  sched_debug.cpu.nr_switches.avg
   1015120 ±  8%     +49.2%    1514833 ±  5%  sched_debug.cpu.nr_switches.max
    488863 ± 34%     +45.4%     710610 ± 14%  sched_debug.cpu.nr_switches.min
    103554 ± 27%     +69.9%     175978 ± 12%  sched_debug.cpu.nr_switches.stddev
    331835 ±  3%     +48.2%     491780 ±  4%  sched_debug.cpu_clk
    331110 ±  3%     +48.3%     491056 ±  4%  sched_debug.ktime
    332640 ±  3%     +48.1%     492581 ±  4%  sched_debug.sched_clk
      0.00 ±  5%     -28.8%       0.00 ±  3%  perf-stat.i.MPKI
  10644874 ±  2%     -36.0%    6816867 ±  4%  perf-stat.i.branch-instructions
      0.06 ±  9%      -0.0        0.04 ±  8%  perf-stat.i.branch-miss-rate%
    392260 ±  5%     -35.8%     251874 ±  4%  perf-stat.i.branch-misses
      0.01 ±  9%      -0.0        0.01 ±  8%  perf-stat.i.cache-miss-rate%
     13152 ±  9%     -33.3%       8768 ±  8%  perf-stat.i.cache-misses
   1312474 ±  3%     -35.2%     850360 ±  4%  perf-stat.i.cache-references
     41587           -22.3%      32310        perf-stat.i.context-switches
      0.02 ±  3%     -34.4%       0.02 ±  9%  perf-stat.i.cpi
     36292 ±  2%      -4.9%      34509        perf-stat.i.cpu-clock
  69738382 ±  3%     -35.8%   44806637 ±  3%  perf-stat.i.cpu-cycles
    866.56 ±  2%     -24.4%     655.46 ±  5%  perf-stat.i.cpu-migrations
     79.99 ±  4%     -40.7%      47.41 ±  9%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  2%      -0.0        0.01 ±  9%  perf-stat.i.dTLB-load-miss-rate%
     49226           -35.0%      31996 ±  5%  perf-stat.i.dTLB-load-misses
  11740986 ±  2%     -35.6%    7559227 ±  4%  perf-stat.i.dTLB-loads
      0.00 ±  2%      -0.0        0.00 ±  8%  perf-stat.i.dTLB-store-miss-rate%
      5278 ±  2%     -34.1%       3479 ±  5%  perf-stat.i.dTLB-store-misses
   4025905           -35.4%    2599180 ±  4%  perf-stat.i.dTLB-stores
  52599699 ±  2%     -36.0%   33668295 ±  4%  perf-stat.i.instructions
      0.00 ±  2%     -35.9%       0.00 ±  4%  perf-stat.i.ipc
      0.39 ± 10%     -33.6%       0.26 ± 15%  perf-stat.i.major-faults
      0.00 ±  3%     -35.7%       0.00 ±  3%  perf-stat.i.metric.GHz
      9.86 ±  3%     -20.6%       7.82 ±  3%  perf-stat.i.metric.K/sec
      0.21 ±  2%     -35.7%       0.14 ±  4%  perf-stat.i.metric.M/sec
      2458            -7.0%       2285        perf-stat.i.minor-faults
      0.60 ±  4%      -0.2        0.37 ±  6%  perf-stat.i.node-load-miss-rate%
      1387 ± 10%     -38.9%     848.51 ± 10%  perf-stat.i.node-load-misses
    843.40 ±  8%     -34.3%     554.36 ± 11%  perf-stat.i.node-loads
      0.32 ± 13%      -0.1        0.18 ± 21%  perf-stat.i.node-store-miss-rate%
      1201 ± 22%     -36.8%     759.43 ± 20%  perf-stat.i.node-store-misses
      2233 ±  9%     -31.7%       1525 ±  9%  perf-stat.i.node-stores
      2458            -7.0%       2286        perf-stat.i.page-faults
     36292 ±  2%      -4.9%      34509        perf-stat.i.task-clock
  10690177 ±  2%     -35.9%    6850545 ±  4%  perf-stat.ps.branch-instructions
    394327 ±  5%     -35.7%     253381 ±  4%  perf-stat.ps.branch-misses
     13185 ±  9%     -33.3%       8797 ±  8%  perf-stat.ps.cache-misses
   1323672 ±  3%     -35.1%     858445 ±  4%  perf-stat.ps.cache-references
     41475           -22.2%      32269        perf-stat.ps.context-switches
     36350 ±  2%      -4.9%      34579        perf-stat.ps.cpu-clock
  70207395 ±  3%     -35.7%   45152617 ±  3%  perf-stat.ps.cpu-cycles
    862.03 ±  2%     -24.3%     652.79 ±  5%  perf-stat.ps.cpu-migrations
     49666           -34.9%      32313 ±  5%  perf-stat.ps.dTLB-load-misses
  11793427 ±  2%     -35.6%    7598311 ±  4%  perf-stat.ps.dTLB-loads
      5322 ±  2%     -34.0%       3511 ±  5%  perf-stat.ps.dTLB-store-misses
   4046732           -35.4%    2614464 ±  4%  perf-stat.ps.dTLB-stores
  52819929 ±  2%     -35.9%   33832570 ±  4%  perf-stat.ps.instructions
      0.39 ± 10%     -33.5%       0.26 ± 15%  perf-stat.ps.major-faults
      2455            -7.0%       2284        perf-stat.ps.minor-faults
      1394 ± 10%     -38.8%     853.03 ± 10%  perf-stat.ps.node-load-misses
    844.08 ±  8%     -34.1%     555.86 ± 11%  perf-stat.ps.node-loads
      1210 ± 22%     -36.8%     764.72 ± 19%  perf-stat.ps.node-store-misses
      2244 ±  9%     -31.6%       1534 ±  9%  perf-stat.ps.node-stores
      2455            -7.0%       2284        perf-stat.ps.page-faults
     36350 ±  2%      -4.9%      34579        perf-stat.ps.task-clock
     56.96 ±  3%     +17.1%      66.70 ±  4%  fxmark.ssd_btrfs_MWUL_18_bufferedio.iowait_sec
      6.40 ±  2%     +15.4%       7.39 ±  4%  fxmark.ssd_btrfs_MWUL_18_bufferedio.iowait_util
     11.63 ±  3%     +18.1%      13.74 ±  5%  fxmark.ssd_btrfs_MWUL_18_bufferedio.irq_sec
      1.31 ±  2%     +16.4%       1.52 ±  5%  fxmark.ssd_btrfs_MWUL_18_bufferedio.irq_util
     62.05 ±  3%     -41.5%      36.31 ±  6%  fxmark.ssd_btrfs_MWUL_18_bufferedio.sys_sec
      6.98 ±  3%     -42.4%       4.02 ±  6%  fxmark.ssd_btrfs_MWUL_18_bufferedio.sys_util
      0.48 ±  4%     -21.1%       0.38 ±  5%  fxmark.ssd_btrfs_MWUL_18_bufferedio.user_sec
      0.05 ±  5%     -22.3%       0.04 ±  5%  fxmark.ssd_btrfs_MWUL_18_bufferedio.user_util
    201721 ±  7%     -94.9%      10290 ±  8%  fxmark.ssd_btrfs_MWUL_18_bufferedio.works
      4089 ±  8%     -95.0%     205.50 ±  8%  fxmark.ssd_btrfs_MWUL_18_bufferedio.works/sec
     10.45 ± 15%     +84.5%      19.28 ±  5%  fxmark.ssd_btrfs_MWUL_1_bufferedio.iowait_sec
     31.25 ±  8%     +25.3%      39.16 ±  5%  fxmark.ssd_btrfs_MWUL_1_bufferedio.iowait_util
      0.66 ±  7%     +80.5%       1.20 ±  2%  fxmark.ssd_btrfs_MWUL_1_bufferedio.irq_sec
      2.00           +21.9%       2.44 ±  2%  fxmark.ssd_btrfs_MWUL_1_bufferedio.irq_util
     33.84 ±  6%     +47.9%      50.04        fxmark.ssd_btrfs_MWUL_1_bufferedio.real_sec
     33.81 ±  6%     +47.9%      50.00        fxmark.ssd_btrfs_MWUL_1_bufferedio.secs
      0.96 ±  4%     +58.9%       1.52 ±  4%  fxmark.ssd_btrfs_MWUL_1_bufferedio.softirq_sec
     20.94 ±  2%     +28.7%      26.96 ±  3%  fxmark.ssd_btrfs_MWUL_1_bufferedio.sys_sec
     63.15 ±  4%     -13.3%      54.77 ±  3%  fxmark.ssd_btrfs_MWUL_1_bufferedio.sys_util
      0.24 ±  5%     +11.3%       0.26 ±  4%  fxmark.ssd_btrfs_MWUL_1_bufferedio.user_sec
      0.71 ±  4%     -25.0%       0.53 ±  3%  fxmark.ssd_btrfs_MWUL_1_bufferedio.user_util
    203274           -95.0%      10117 ±  5%  fxmark.ssd_btrfs_MWUL_1_bufferedio.works
      6035 ±  6%     -96.6%     202.34 ±  5%  fxmark.ssd_btrfs_MWUL_1_bufferedio.works/sec
      9.91 ±  9%     +32.1%      13.09        fxmark.ssd_btrfs_MWUL_2_bufferedio.idle_sec
     28.74 ± 12%     +74.8%      50.25        fxmark.ssd_btrfs_MWUL_2_bufferedio.iowait_sec
     40.39 ±  3%     +25.0%      50.49        fxmark.ssd_btrfs_MWUL_2_bufferedio.iowait_util
      1.13 ± 10%     +49.8%       1.69        fxmark.ssd_btrfs_MWUL_2_bufferedio.irq_sec
     35.98 ±  9%     +39.1%      50.04        fxmark.ssd_btrfs_MWUL_2_bufferedio.real_sec
     35.94 ±  9%     +39.1%      50.00        fxmark.ssd_btrfs_MWUL_2_bufferedio.secs
      1.50 ±  7%     +36.3%       2.05 ±  2%  fxmark.ssd_btrfs_MWUL_2_bufferedio.softirq_sec
     41.56 ±  2%     -22.2%      32.34        fxmark.ssd_btrfs_MWUL_2_bufferedio.sys_util
      0.37 ±  5%     -29.7%       0.26 ±  5%  fxmark.ssd_btrfs_MWUL_2_bufferedio.user_util
    209379           -94.5%      11564 ±  4%  fxmark.ssd_btrfs_MWUL_2_bufferedio.works
      5887 ± 11%     -96.1%     231.27 ±  4%  fxmark.ssd_btrfs_MWUL_2_bufferedio.works/sec
     42.16 ±  5%     -22.9%      32.49 ±  8%  fxmark.ssd_btrfs_MWUL_36_bufferedio.sys_sec
      2.34 ±  5%     -23.1%       1.80 ±  8%  fxmark.ssd_btrfs_MWUL_36_bufferedio.sys_util
      0.54 ±  3%     -10.1%       0.49 ±  4%  fxmark.ssd_btrfs_MWUL_36_bufferedio.user_sec
      0.03 ±  3%     -10.3%       0.03 ±  4%  fxmark.ssd_btrfs_MWUL_36_bufferedio.user_util
     22832 ± 10%     -59.5%       9239 ± 10%  fxmark.ssd_btrfs_MWUL_36_bufferedio.works
    456.46 ± 10%     -59.7%     184.11 ± 10%  fxmark.ssd_btrfs_MWUL_36_bufferedio.works/sec
     76.16 ±  6%     +33.7%     101.80        fxmark.ssd_btrfs_MWUL_4_bufferedio.idle_sec
     38.08 ± 14%     +48.7%      56.64 ±  2%  fxmark.ssd_btrfs_MWUL_4_bufferedio.iowait_sec
     24.25 ±  6%     +17.1%      28.39 ±  2%  fxmark.ssd_btrfs_MWUL_4_bufferedio.iowait_util
      1.72 ± 11%     +38.4%       2.38 ±  3%  fxmark.ssd_btrfs_MWUL_4_bufferedio.irq_sec
     39.45 ±  7%     +26.8%      50.04        fxmark.ssd_btrfs_MWUL_4_bufferedio.real_sec
     39.46 ±  7%     +26.7%      50.01        fxmark.ssd_btrfs_MWUL_4_bufferedio.secs
      1.74 ±  4%     +27.2%       2.21 ±  4%  fxmark.ssd_btrfs_MWUL_4_bufferedio.softirq_sec
     24.61 ±  5%     -26.2%      18.15 ±  4%  fxmark.ssd_btrfs_MWUL_4_bufferedio.sys_util
      0.19 ±  5%     -27.3%       0.14 ±  7%  fxmark.ssd_btrfs_MWUL_4_bufferedio.user_util
    209529           -93.5%      13535 ± 12%  fxmark.ssd_btrfs_MWUL_4_bufferedio.works
      5338 ±  7%     -94.9%     270.67 ± 12%  fxmark.ssd_btrfs_MWUL_4_bufferedio.works/sec
     43.44 ±  6%     -25.6%      32.32 ±  3%  fxmark.ssd_btrfs_MWUL_54_bufferedio.sys_sec
      1.61 ±  6%     -25.7%       1.19 ±  3%  fxmark.ssd_btrfs_MWUL_54_bufferedio.sys_util
     15869 ± 13%     -42.1%       9186 ±  2%  fxmark.ssd_btrfs_MWUL_54_bufferedio.works
    317.08 ± 13%     -42.4%     182.76 ±  2%  fxmark.ssd_btrfs_MWUL_54_bufferedio.works/sec
     35.21 ±  2%     -12.0%      30.99 ±  5%  fxmark.ssd_btrfs_MWUL_72_bufferedio.sys_sec
      0.98 ±  2%     -12.1%       0.86 ±  5%  fxmark.ssd_btrfs_MWUL_72_bufferedio.sys_util
      0.99 ±  4%     -22.8%       0.77 ±  7%  fxmark.ssd_btrfs_MWUL_72_bufferedio.user_sec
      0.03 ±  4%     -22.9%       0.02 ±  7%  fxmark.ssd_btrfs_MWUL_72_bufferedio.user_util
     12308 ±  6%     -28.0%       8866 ±  4%  fxmark.ssd_btrfs_MWUL_72_bufferedio.works
    245.35 ±  6%     -28.2%     176.13 ±  4%  fxmark.ssd_btrfs_MWUL_72_bufferedio.works/sec
    601.76           +55.2%     934.17 ±  3%  fxmark.time.elapsed_time
    601.76           +55.2%     934.17 ±  3%  fxmark.time.elapsed_time.max
   9933258 ±  3%     -18.5%    8097312        fxmark.time.file_system_outputs
     39526 ± 14%     -51.9%      19032 ± 22%  fxmark.time.involuntary_context_switches
     24.43           -32.3%      16.54 ±  2%  fxmark.time.system_time
    668771           -67.9%     214780 ±  7%  fxmark.time.voluntary_context_switches
     43.69 ± 68%     -43.7        0.00        perf-profile.calltrace.cycles-pp.worker_main
      4.40 ± 67%      -4.4        0.00        perf-profile.calltrace.cycles-pp.unlink
      4.39 ± 67%      -4.4        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      4.39 ± 67%      -4.4        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.37 ± 67%      -4.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.36 ± 67%      -4.4        0.00        perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.29 ±100%      +0.4        0.67 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_governor_latency_req.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.20 ±141%      +0.5        0.66 ±  9%  perf-profile.calltrace.cycles-pp.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent
      0.10 ±223%      +0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.timerqueue_del.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.09 ±223%      +0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.local_clock_noinstr.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.19 ±141%      +0.5        0.70 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_del_items.btrfs_drop_extents.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode
      0.09 ±223%      +0.5        0.61 ± 12%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_insert_empty_items.alloc_reserved_tree_block.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs
      0.09 ±223%      +0.5        0.62 ±  5%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.42 ±100%      +0.5        0.96 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.log_extent_csums
      0.22 ±142%      +0.5        0.76 ± 14%  perf-profile.calltrace.cycles-pp.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer
      0.42 ±100%      +0.6        0.98 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.log_extent_csums.log_one_extent
      0.11 ±223%      +0.6        0.66 ± 12%  perf-profile.calltrace.cycles-pp.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.log_one_extent
      0.10 ±223%      +0.6        0.66 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.40 ±101%      +0.6        0.97 ±  9%  perf-profile.calltrace.cycles-pp.cow_file_range.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage.extent_write_cache_pages
      0.32 ±101%      +0.6        0.91 ±  6%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.41 ±101%      +0.6        1.01 ± 11%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.42 ±105%      +0.6        1.04 ± 21%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.09 ±223%      +0.6        0.73 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_extend_item.btrfs_csum_file_blocks.log_csums.log_extent_csums.log_one_extent
      0.00            +0.6        0.65 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.lookup_open.open_last_lookups.path_openat
      0.42 ±101%      +0.7        1.08 ± 10%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.log_one_extent.btrfs_log_changed_extents
      0.44 ±103%      +0.7        1.10 ±  5%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.45 ±104%      +0.7        1.13 ± 21%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.43 ±101%      +0.7        1.11 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_setup_item_for_insert.btrfs_drop_extents.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode
      0.46 ±104%      +0.7        1.15 ± 21%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.46 ±104%      +0.7        1.15 ± 21%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.46 ±104%      +0.7        1.15 ± 21%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.46 ±104%      +0.7        1.15 ± 21%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.46 ±104%      +0.7        1.15 ± 21%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.46 ±104%      +0.7        1.15 ± 21%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.46 ±104%      +0.7        1.15 ± 21%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.46 ±108%      +0.7        1.16 ±  6%  perf-profile.calltrace.cycles-pp.__extent_writepage_io.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages
      0.00            +0.7        0.71 ± 17%  perf-profile.calltrace.cycles-pp.check_dir_item.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio
      0.56 ±101%      +0.7        1.28 ±  6%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.8        0.75 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_create_common.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.11 ±223%      +0.8        0.88 ± 25%  perf-profile.calltrace.cycles-pp.blk_update_request.scsi_end_request.scsi_io_completion.blk_complete_reqs.__do_softirq
      0.00            +0.8        0.80 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_get_64.check_extent_item.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf
      0.09 ±223%      +0.8        0.90 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_get_64.check_extent_data_item.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf
      0.00            +0.8        0.82 ± 19%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.8        0.82 ± 19%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.54 ±100%      +0.8        1.38 ±  8%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.09 ±223%      +0.8        0.93 ± 26%  perf-profile.calltrace.cycles-pp.btrfs_get_32.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      0.00            +0.9        0.85 ± 31%  perf-profile.calltrace.cycles-pp.__btrfs_check_node.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      0.00            +0.9        0.87 ± 18%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.00            +0.9        0.87 ± 31%  perf-profile.calltrace.cycles-pp.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
      0.00            +0.9        0.87 ± 18%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.89 ± 18%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +0.9        0.89 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +0.9        0.90 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +0.9        0.90 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.84 ± 81%      +0.9        1.75 ±  7%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.9        0.92 ± 18%  perf-profile.calltrace.cycles-pp.open64
      0.30 ±155%      +1.0        1.28 ±  9%  perf-profile.calltrace.cycles-pp.__memmove.__write_extent_buffer.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert
      0.31 ±155%      +1.0        1.30 ±  9%  perf-profile.calltrace.cycles-pp.__write_extent_buffer.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents
      0.79 ± 82%      +1.1        1.86 ±  7%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.94 ± 81%      +1.1        2.01 ±  8%  perf-profile.calltrace.cycles-pp.log_extent_csums.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent
      1.37 ± 54%      +1.1        2.45 ±  5%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      1.51 ± 53%      +1.1        2.59 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.do_iter_readv_writev.do_iter_write.lo_write_simple
      0.85 ± 81%      +1.1        1.94 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.log_csums.log_extent_csums.log_one_extent.btrfs_log_changed_extents
      0.70 ±101%      +1.1        1.79 ±  5%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.85 ± 81%      +1.1        1.94 ±  8%  perf-profile.calltrace.cycles-pp.log_csums.log_extent_csums.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode
      1.43 ± 52%      +1.1        2.57 ±  5%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      1.44 ± 52%      +1.1        2.58 ±  6%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file
      1.43 ± 52%      +1.1        2.57 ±  6%  perf-profile.calltrace.cycles-pp.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops
      1.44 ± 52%      +1.1        2.58 ±  5%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file.loop_process_work
      1.44 ± 52%      +1.1        2.58 ±  6%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.start_ordered_ops.btrfs_sync_file.loop_process_work.process_one_work
      0.55 ±105%      +1.2        1.74 ± 31%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.55 ±105%      +1.2        1.75 ± 31%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.45 ±100%      +1.2        1.68 ± 16%  perf-profile.calltrace.cycles-pp.check_extent_data_item.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio
      1.28 ± 52%      +1.3        2.55 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent
      1.53 ± 52%      +1.3        2.84 ±  5%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.loop_process_work.process_one_work.worker_thread
      0.46 ±115%      +1.5        1.94 ±  7%  perf-profile.calltrace.cycles-pp.read_extent_buffer.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      0.66 ±103%      +1.5        2.18 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space
      0.70 ±103%      +1.6        2.25 ± 10%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      0.70 ±103%      +1.6        2.26 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
      2.10 ± 54%      +1.9        4.04        perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.56 ± 55%      +2.1        4.67 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      2.39 ± 53%      +2.2        4.64 ±  8%  perf-profile.calltrace.cycles-pp.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
      2.44 ± 53%      +2.3        4.77 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      2.88 ± 54%      +2.4        5.33 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      3.87 ± 53%      +2.4        6.32 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      3.86 ± 53%      +2.5        6.32 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
      3.10 ± 55%      +2.6        5.73 ±  5%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      2.66 ± 53%      +2.6        5.30 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.loop_process_work
      2.66 ± 53%      +2.7        5.32 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.loop_process_work.process_one_work.worker_thread
      2.66 ± 53%      +2.7        5.32 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.loop_process_work.process_one_work
      2.30 ± 77%      +2.8        5.10 ±  5%  perf-profile.calltrace.cycles-pp.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      1.92 ± 48%      +3.1        5.02 ± 14%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.loop_process_work
      1.92 ± 48%      +3.1        5.02 ± 14%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
      1.92 ± 48%      +3.1        5.02 ± 14%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
      1.93 ± 47%      +3.1        5.04 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.loop_process_work.process_one_work
      2.23 ± 49%      +3.5        5.70 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_sync_log.btrfs_sync_file.loop_process_work.process_one_work.worker_thread
      5.07 ± 54%      +4.4        9.43 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.70 ± 58%      +4.5        9.24 ±  6%  perf-profile.calltrace.cycles-pp.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      4.90 ± 56%      +4.5        9.44 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
      2.84 ± 53%      +4.8        7.60 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
      2.88 ± 53%      +4.8        7.71 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      6.10 ± 54%      +5.2       11.27 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      6.18 ± 54%      +5.2       11.40 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.60 ± 53%      +5.5        9.07 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
      5.66 ± 56%      +5.5       11.16 ±  6%  perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages
      5.81 ± 56%      +5.6       11.44 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages
      5.81 ± 56%      +5.6       11.45 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
      6.34 ± 56%      +6.0       12.33 ±  6%  perf-profile.calltrace.cycles-pp.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      6.47 ± 56%      +6.1       12.53 ±  6%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
      4.55 ± 54%      +7.0       11.60 ± 10%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread
      4.55 ± 54%      +7.1       11.60 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
      8.84 ± 54%      +7.6       16.39 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.82 ± 52%      +8.0       14.84 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.loop_process_work.process_one_work.worker_thread.kthread
      8.47 ± 52%      +9.3       17.74 ±  7%  perf-profile.calltrace.cycles-pp.loop_process_work.process_one_work.worker_thread.kthread.ret_from_fork
     10.28 ± 57%      +9.3       19.57 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     14.28 ± 54%     +12.9       27.16        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     17.23 ± 52%     +19.0       36.18        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     17.60 ± 52%     +19.3       36.91        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     18.12 ± 52%     +19.8       37.97        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     18.12 ± 52%     +19.8       37.97        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     18.12 ± 52%     +19.8       37.97        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     27.70 ± 54%     +23.6       51.25        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     27.20 ± 55%     +23.6       50.80        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     30.44 ± 54%     +26.1       56.56        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     31.72 ± 54%     +26.8       58.56        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     31.76 ± 54%     +26.9       58.62        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     31.76 ± 54%     +26.9       58.63        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     32.37 ± 55%     +27.4       59.78        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     43.70 ± 68%     -43.7        0.00        perf-profile.children.cycles-pp.worker_main
      4.40 ± 67%      -4.4        0.00        perf-profile.children.cycles-pp.unlink
      4.37 ± 67%      -4.4        0.00        perf-profile.children.cycles-pp.__x64_sys_unlink
      4.36 ± 67%      -4.4        0.00        perf-profile.children.cycles-pp.do_unlinkat
      5.42 ± 49%      -3.7        1.71 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.42 ± 49%      -3.7        1.70 ± 10%  perf-profile.children.cycles-pp.do_syscall_64
      3.88 ± 66%      -3.7        0.22 ± 18%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      3.90 ± 66%      -3.6        0.26 ± 20%  perf-profile.children.cycles-pp.__reserve_bytes
      0.07 ± 18%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.free_extent_buffer
      0.03 ±100%      +0.0        0.07 ± 16%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.04 ± 72%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.do_mmap
      0.01 ±223%      +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.01 ±223%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.rb_prev
      0.04 ± 72%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.02 ±144%      +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.04 ±102%      +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.crc32c
      0.03 ±103%      +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.call_cpuidle
      0.03 ±103%      +0.1        0.09 ± 20%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.09 ± 61%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.btrfs_bio_alloc
      0.02 ±141%      +0.1        0.08 ± 31%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.03 ±100%      +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.mmap_region
      0.02 ±142%      +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.ct_idle_enter
      0.03 ±143%      +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.02 ±142%      +0.1        0.08 ± 34%  perf-profile.children.cycles-pp.io_schedule_timeout
      0.04 ±103%      +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.folio_wake_bit
      0.03 ±103%      +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.blk_mq_requeue_work
      0.06 ± 76%      +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.merge_state
      0.04 ±101%      +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.02 ±141%      +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.blk_mq_run_hw_queues
      0.04 ±105%      +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.schedule_timeout
      0.04 ±104%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.04 ±101%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.___slab_alloc
      0.03 ±144%      +0.1        0.11 ± 31%  perf-profile.children.cycles-pp.__wait_for_common
      0.05 ±100%      +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.rcu_needs_cpu
      0.04 ±100%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.rcu_preempt_deferred_qs
      0.05 ±100%      +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.08 ± 63%      +0.1        0.18 ± 15%  perf-profile.children.cycles-pp.ahci_scr_read
      0.04 ±102%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.task_tick_idle
      0.04 ±108%      +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.08 ± 81%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.check_tsc_unstable
      0.08 ± 63%      +0.1        0.18 ± 15%  perf-profile.children.cycles-pp.sata_async_notification
      0.06 ± 79%      +0.1        0.16 ± 18%  perf-profile.children.cycles-pp.leave_mm
      0.04 ±104%      +0.1        0.14 ± 17%  perf-profile.children.cycles-pp.btrfs_wait_tree_log_extents
      0.05 ± 82%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.11 ± 53%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.08 ± 65%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.prepare_pages
      0.10 ± 69%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.btrfs_replace_extent_map_range
      0.06 ±102%      +0.1        0.17 ± 15%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.15 ± 57%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.update_rq_clock
      0.11 ± 51%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.cpu_util
      0.08 ±102%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.menu_reflect
      0.01 ±223%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.ct_nmi_exit
      0.08 ± 61%      +0.1        0.19 ± 15%  perf-profile.children.cycles-pp.start_transaction
      0.12 ± 53%      +0.1        0.24 ± 15%  perf-profile.children.cycles-pp.error_entry
      0.10 ± 50%      +0.1        0.22 ± 25%  perf-profile.children.cycles-pp.xas_descend
      0.10 ± 56%      +0.1        0.22 ± 21%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.12 ± 52%      +0.1        0.23 ± 13%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.11 ± 51%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.create_io_em
      0.12 ± 51%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ± 48%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.io_schedule
      0.08 ± 73%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.idle_cpu
      0.10 ± 38%      +0.1        0.22 ± 16%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.btrfs_insert_delayed_item
      0.11 ± 41%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.12 ± 54%      +0.1        0.25 ± 12%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.09 ± 65%      +0.1        0.21 ± 12%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
      0.06 ±102%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.11 ± 63%      +0.1        0.24 ± 15%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.18 ± 49%      +0.1        0.31 ± 12%  perf-profile.children.cycles-pp.schedule_idle
      0.05 ±101%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.irqentry_exit
      0.12 ± 55%      +0.1        0.25 ±  7%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.13 ± 55%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.update_blocked_averages
      0.16 ± 52%      +0.1        0.30 ± 12%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.09 ± 79%      +0.2        0.25 ±  7%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.18 ± 49%      +0.2        0.34 ± 14%  perf-profile.children.cycles-pp.get_cpu_device
      0.16 ± 53%      +0.2        0.32 ± 13%  perf-profile.children.cycles-pp.irq_work_tick
      0.12 ± 39%      +0.2        0.29 ± 13%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.22 ± 58%      +0.2        0.39 ± 12%  perf-profile.children.cycles-pp.rcu_core
      0.12 ± 39%      +0.2        0.30 ± 14%  perf-profile.children.cycles-pp.filemap_fdatawait_range
      0.21 ± 61%      +0.2        0.39 ± 22%  perf-profile.children.cycles-pp.check_cpu_stall
      0.16 ± 47%      +0.2        0.34 ±  8%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.18 ± 58%      +0.2        0.37 ± 23%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.16 ± 57%      +0.2        0.34 ± 11%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.19 ± 57%      +0.2        0.38 ± 11%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.24 ± 48%      +0.2        0.42 ±  5%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.18 ± 55%      +0.2        0.38 ± 11%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.24 ± 55%      +0.2        0.43 ± 11%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.24 ± 57%      +0.2        0.44 ±  4%  perf-profile.children.cycles-pp.irqentry_enter
      0.16 ± 53%      +0.2        0.37 ± 11%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.16 ± 56%      +0.2        0.37 ± 10%  perf-profile.children.cycles-pp.blk_finish_plug
      0.20 ± 56%      +0.2        0.41 ±  9%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.21 ± 49%      +0.2        0.42 ±  6%  perf-profile.children.cycles-pp.rb_next
      0.24 ± 53%      +0.2        0.46 ±  8%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.25 ± 53%      +0.2        0.48 ± 29%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.21 ± 53%      +0.2        0.44 ± 13%  perf-profile.children.cycles-pp.xas_load
      0.28 ± 53%      +0.2        0.52 ± 18%  perf-profile.children.cycles-pp.__memcpy
      0.26 ± 53%      +0.2        0.49 ± 27%  perf-profile.children.cycles-pp.pagecache_get_page
      0.18 ± 75%      +0.2        0.41 ± 14%  perf-profile.children.cycles-pp.crc32c_pcl_intel_digest
      0.21 ± 54%      +0.2        0.45 ± 12%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.28 ± 46%      +0.2        0.53 ± 13%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.19 ± 74%      +0.2        0.43 ± 16%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
      0.28 ± 53%      +0.2        0.53 ± 17%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.20 ± 58%      +0.2        0.46 ±  9%  perf-profile.children.cycles-pp.btrfs_get_8
      0.28 ± 54%      +0.3        0.54 ± 16%  perf-profile.children.cycles-pp.btrfs_copy_from_user
      0.00            +0.3        0.26 ± 20%  perf-profile.children.cycles-pp.insert_with_overflow
      0.32 ± 58%      +0.3        0.58 ±  8%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.01 ±223%      +0.3        0.28 ± 22%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      0.28 ± 50%      +0.3        0.56 ± 13%  perf-profile.children.cycles-pp.sched_clock
      0.29 ± 52%      +0.3        0.57 ±  8%  perf-profile.children.cycles-pp.blk_mq_end_request
      0.29 ± 50%      +0.3        0.57 ± 11%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.28 ± 52%      +0.3        0.56 ±  9%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.01 ±223%      +0.3        0.29 ± 23%  perf-profile.children.cycles-pp.btrfs_add_link
      0.33 ± 55%      +0.3        0.61 ±  5%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.29 ± 57%      +0.3        0.57 ± 10%  perf-profile.children.cycles-pp.rebalance_domains
      0.33 ± 60%      +0.3        0.63 ± 15%  perf-profile.children.cycles-pp.ct_idle_exit
      0.38 ± 46%      +0.3        0.69 ±  5%  perf-profile.children.cycles-pp.clockevents_program_event
      0.39 ± 54%      +0.3        0.69 ±  4%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.31 ± 57%      +0.3        0.62 ±  5%  perf-profile.children.cycles-pp.timerqueue_del
      0.42 ± 60%      +0.3        0.74 ± 17%  perf-profile.children.cycles-pp.check_dir_item
      0.28 ± 54%      +0.3        0.61 ±  6%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.34 ± 54%      +0.3        0.68 ± 10%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.36 ± 52%      +0.3        0.70 ± 11%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.32 ± 50%      +0.4        0.68 ± 16%  perf-profile.children.cycles-pp.extent_buffer_write_end_io
      0.39 ± 51%      +0.4        0.76 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.43 ± 54%      +0.4        0.82 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.33 ± 54%      +0.4        0.72 ± 22%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.41 ± 58%      +0.4        0.80 ± 13%  perf-profile.children.cycles-pp.rcu_pending
      0.42 ± 49%      +0.4        0.84 ±  7%  perf-profile.children.cycles-pp.newidle_balance
      0.64 ± 42%      +0.4        1.08 ±  8%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.45 ± 52%      +0.4        0.90 ±  2%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.44 ± 49%      +0.5        0.91 ±  6%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.41 ± 54%      +0.5        0.90 ± 22%  perf-profile.children.cycles-pp.folio_end_writeback
      0.56 ± 57%      +0.5        1.06 ± 11%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.52 ± 52%      +0.5        1.02 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.46 ± 47%      +0.5        0.96 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.53 ± 52%      +0.5        1.04 ±  3%  perf-profile.children.cycles-pp.find_busiest_group
      0.64 ± 54%      +0.5        1.17 ±  7%  perf-profile.children.cycles-pp.__extent_writepage_io
      0.60 ± 57%      +0.6        1.15 ± 21%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.60 ± 57%      +0.6        1.15 ± 21%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.60 ± 57%      +0.6        1.15 ± 21%  perf-profile.children.cycles-pp.start_kernel
      0.60 ± 57%      +0.6        1.15 ± 21%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.60 ± 57%      +0.6        1.15 ± 21%  perf-profile.children.cycles-pp.rest_init
      0.76 ± 56%      +0.6        1.32 ±  7%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      0.62 ± 56%      +0.6        1.19 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.54 ± 57%      +0.6        1.13 ± 24%  perf-profile.children.cycles-pp.scsi_io_completion
      0.54 ± 57%      +0.6        1.12 ± 24%  perf-profile.children.cycles-pp.scsi_end_request
      0.75 ± 54%      +0.6        1.33 ±  5%  perf-profile.children.cycles-pp.perf_rotate_context
      0.61 ± 52%      +0.6        1.20 ±  4%  perf-profile.children.cycles-pp.load_balance
      0.47 ± 52%      +0.6        1.08 ± 16%  perf-profile.children.cycles-pp.__btrfs_check_node
      0.47 ± 52%      +0.6        1.08 ± 16%  perf-profile.children.cycles-pp.btrfs_check_node
      0.02 ±146%      +0.6        0.65 ± 18%  perf-profile.children.cycles-pp.btrfs_create_new_inode
      0.68 ± 50%      +0.7        1.35 ±  3%  perf-profile.children.cycles-pp.schedule
      0.73 ± 59%      +0.7        1.40 ±  9%  perf-profile.children.cycles-pp.btrfs_extend_item
      0.04 ±109%      +0.7        0.75 ± 18%  perf-profile.children.cycles-pp.btrfs_create_common
      0.87 ± 51%      +0.8        1.62 ± 14%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      0.73 ± 54%      +0.8        1.48 ± 20%  perf-profile.children.cycles-pp.blk_update_request
      1.03 ± 51%      +0.8        1.82 ±  6%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.04 ±112%      +0.8        0.82 ± 18%  perf-profile.children.cycles-pp.lookup_open
      0.04 ±112%      +0.8        0.83 ± 19%  perf-profile.children.cycles-pp.open_last_lookups
      0.84 ± 50%      +0.8        1.63 ±  5%  perf-profile.children.cycles-pp.__schedule
      0.08 ± 60%      +0.8        0.93 ± 17%  perf-profile.children.cycles-pp.path_openat
      0.08 ± 60%      +0.9        0.93 ± 17%  perf-profile.children.cycles-pp.do_filp_open
      0.88 ± 57%      +0.9        1.74 ± 18%  perf-profile.children.cycles-pp.blk_complete_reqs
      0.08 ± 58%      +0.9        0.95 ± 17%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.08 ± 58%      +0.9        0.95 ± 17%  perf-profile.children.cycles-pp.do_sys_openat2
      0.04 ±107%      +0.9        0.92 ± 18%  perf-profile.children.cycles-pp.open64
      0.94 ± 55%      +0.9        1.86 ±  5%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.08 ± 56%      +0.9        2.01 ±  8%  perf-profile.children.cycles-pp.log_extent_csums
      0.98 ± 56%      +1.0        1.95 ±  8%  perf-profile.children.cycles-pp.log_csums
      0.98 ± 53%      +1.0        2.02 ±  8%  perf-profile.children.cycles-pp.btrfs_get_64
      1.26 ± 54%      +1.1        2.32 ±  8%  perf-profile.children.cycles-pp.btrfs_setup_item_for_insert
      1.46 ± 51%      +1.1        2.58 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      1.43 ± 52%      +1.1        2.57 ±  6%  perf-profile.children.cycles-pp.extent_write_cache_pages
      1.43 ± 52%      +1.1        2.58 ±  6%  perf-profile.children.cycles-pp.extent_writepages
      0.69 ± 46%      +1.1        1.83 ± 16%  perf-profile.children.cycles-pp.check_extent_data_item
      0.84 ± 52%      +1.2        2.00 ± 35%  perf-profile.children.cycles-pp.common_interrupt
      1.42 ± 52%      +1.3        2.68 ±  7%  perf-profile.children.cycles-pp.btrfs_get_32
      1.53 ± 52%      +1.3        2.84 ±  5%  perf-profile.children.cycles-pp.start_ordered_ops
      1.75 ± 56%      +1.5        3.20 ±  6%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      1.86 ± 55%      +1.5        3.34 ±  2%  perf-profile.children.cycles-pp.setup_items_for_insert
      1.66 ± 55%      +1.6        3.28 ±  9%  perf-profile.children.cycles-pp.__do_softirq
      1.88 ± 52%      +1.7        3.55 ±  5%  perf-profile.children.cycles-pp.read_extent_buffer
      1.31 ± 49%      +1.7        3.04 ± 18%  perf-profile.children.cycles-pp.__irq_exit_rcu
      2.07 ± 56%      +1.8        3.83 ±  4%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      2.37 ± 53%      +1.8        4.19 ±  4%  perf-profile.children.cycles-pp.__memmove
      2.14 ± 54%      +2.0        4.13 ±  2%  perf-profile.children.cycles-pp.menu_select
      2.72 ± 54%      +2.2        4.91 ±  3%  perf-profile.children.cycles-pp.update_process_times
      2.39 ± 53%      +2.2        4.64 ±  8%  perf-profile.children.cycles-pp.log_one_extent
      2.44 ± 53%      +2.3        4.77 ±  8%  perf-profile.children.cycles-pp.btrfs_log_changed_extents
      3.87 ± 53%      +2.4        6.32 ±  4%  perf-profile.children.cycles-pp.btrfs_work_helper
      3.86 ± 53%      +2.5        6.32 ±  4%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
      3.03 ± 53%      +2.5        5.51 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      2.69 ± 54%      +2.5        5.17 ±  5%  perf-profile.children.cycles-pp.check_leaf_item
      2.66 ± 53%      +2.6        5.30 ±  8%  perf-profile.children.cycles-pp.btrfs_log_inode
      2.66 ± 53%      +2.7        5.32 ±  8%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
      2.66 ± 53%      +2.7        5.32 ±  8%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
      3.49 ± 52%      +2.7        6.17 ±  6%  perf-profile.children.cycles-pp.btrfs_drop_extents
      2.23 ± 49%      +3.5        5.70 ± 13%  perf-profile.children.cycles-pp.btrfs_sync_log
      5.32 ± 53%      +4.4        9.77 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.96 ± 54%      +4.5        9.45 ±  6%  perf-profile.children.cycles-pp.btrfs_check_leaf
      4.96 ± 54%      +4.5        9.45 ±  6%  perf-profile.children.cycles-pp.__btrfs_check_leaf
      6.41 ± 53%      +5.3       11.67 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      6.49 ± 53%      +5.3       11.79 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.72 ± 54%      +5.4       11.16 ±  6%  perf-profile.children.cycles-pp.btree_csum_one_bio
      6.25 ± 54%      +5.9       12.13 ±  6%  perf-profile.children.cycles-pp.btrfs_submit_bio
      6.25 ± 54%      +5.9       12.13 ±  6%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      6.42 ± 54%      +5.9       12.34 ±  6%  perf-profile.children.cycles-pp.submit_eb_page
      6.56 ± 54%      +6.0       12.54 ±  6%  perf-profile.children.cycles-pp.btree_write_cache_pages
      6.63 ± 55%      +6.0       12.65 ±  6%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
      4.55 ± 54%      +7.1       11.60 ± 10%  perf-profile.children.cycles-pp.btrfs_async_reclaim_metadata_space
      7.99 ± 54%      +7.1       15.12 ±  5%  perf-profile.children.cycles-pp.do_writepages
      8.01 ± 54%      +7.1       15.14 ±  5%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      8.01 ± 54%      +7.1       15.15 ±  5%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      9.29 ± 53%      +7.8       17.05 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      6.82 ± 52%      +8.0       14.84 ±  8%  perf-profile.children.cycles-pp.btrfs_sync_file
     10.25 ± 53%      +8.6       18.89 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      8.47 ± 52%      +9.3       17.74 ±  7%  perf-profile.children.cycles-pp.loop_process_work
     14.47 ± 54%     +12.8       27.32        perf-profile.children.cycles-pp.intel_idle
     17.24 ± 52%     +19.0       36.19        perf-profile.children.cycles-pp.process_one_work
     17.61 ± 52%     +19.3       36.91        perf-profile.children.cycles-pp.worker_thread
     18.12 ± 52%     +19.8       37.97        perf-profile.children.cycles-pp.kthread
     18.12 ± 52%     +19.9       37.98        perf-profile.children.cycles-pp.ret_from_fork_asm
     18.12 ± 52%     +19.9       37.98        perf-profile.children.cycles-pp.ret_from_fork
     28.12 ± 54%     +23.9       52.07        perf-profile.children.cycles-pp.cpuidle_enter_state
     28.26 ± 54%     +24.0       52.30        perf-profile.children.cycles-pp.cpuidle_enter
     31.06 ± 54%     +26.7       57.78        perf-profile.children.cycles-pp.cpuidle_idle_call
     31.76 ± 54%     +26.9       58.63        perf-profile.children.cycles-pp.start_secondary
     32.37 ± 55%     +27.4       59.78        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     32.37 ± 55%     +27.4       59.78        perf-profile.children.cycles-pp.cpu_startup_entry
     32.36 ± 55%     +27.4       59.78        perf-profile.children.cycles-pp.do_idle
     43.60 ± 68%     -43.6        0.00        perf-profile.self.cycles-pp.worker_main
      0.02 ±141%      +0.0        0.06 ± 28%  perf-profile.self.cycles-pp.process_one_work
      0.02 ±141%      +0.0        0.07 ± 21%  perf-profile.self.cycles-pp.memmove_extent_buffer
      0.01 ±223%      +0.1        0.06 ± 21%  perf-profile.self.cycles-pp.__reserve_bytes
      0.03 ±103%      +0.1        0.09 ± 19%  perf-profile.self.cycles-pp.call_cpuidle
      0.03 ±101%      +0.1        0.09 ± 18%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.01 ±223%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.rb_prev
      0.02 ±142%      +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.03 ±143%      +0.1        0.09 ± 20%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.btrfs_reduce_alloc_profile
      0.02 ±142%      +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.___slab_alloc
      0.03 ±102%      +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.sched_clock_noinstr
      0.02 ±141%      +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.rebalance_domains
      0.07 ± 62%      +0.1        0.14 ± 25%  perf-profile.self.cycles-pp.down_write
      0.01 ±223%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.02 ±141%      +0.1        0.09 ± 22%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.03 ±141%      +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.04 ±102%      +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.__do_softirq
      0.05 ±100%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.clockevents_program_event
      0.04 ±101%      +0.1        0.12 ± 16%  perf-profile.self.cycles-pp.__schedule
      0.05 ±101%      +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.05 ±100%      +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.rcu_needs_cpu
      0.04 ±100%      +0.1        0.13 ± 17%  perf-profile.self.cycles-pp.rcu_preempt_deferred_qs
      0.05 ±104%      +0.1        0.13 ± 22%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.04 ±102%      +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.04 ±101%      +0.1        0.12 ± 10%  perf-profile.self.cycles-pp.task_tick_idle
      0.06 ±100%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.check_tsc_unstable
      0.08 ± 63%      +0.1        0.18 ± 15%  perf-profile.self.cycles-pp.ahci_scr_read
      0.10 ± 47%      +0.1        0.20 ± 13%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ±101%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.10 ± 48%      +0.1        0.21 ± 14%  perf-profile.self.cycles-pp.cpu_util
      0.06 ±102%      +0.1        0.17 ± 15%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.06 ± 86%      +0.1        0.17 ± 10%  perf-profile.self.cycles-pp.xas_load
      0.01 ±223%      +0.1        0.12 ± 18%  perf-profile.self.cycles-pp.ct_nmi_exit
      0.06 ±101%      +0.1        0.17 ± 23%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.09 ± 65%      +0.1        0.20 ± 23%  perf-profile.self.cycles-pp.xas_descend
      0.12 ± 53%      +0.1        0.24 ± 14%  perf-profile.self.cycles-pp.error_entry
      0.07 ±107%      +0.1        0.18 ± 22%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.10 ± 71%      +0.1        0.22 ± 33%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
      0.10 ± 66%      +0.1        0.23 ± 16%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.16 ± 50%      +0.1        0.29 ± 11%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.12 ± 55%      +0.1        0.25 ± 15%  perf-profile.self.cycles-pp.do_idle
      0.06 ± 95%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.idle_cpu
      0.06 ±102%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.15 ± 52%      +0.1        0.28 ± 15%  perf-profile.self.cycles-pp.irq_work_tick
      0.08 ± 82%      +0.1        0.22 ± 21%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.16 ± 52%      +0.1        0.30 ± 11%  perf-profile.self.cycles-pp.scheduler_tick
      0.06 ±104%      +0.1        0.21 ±  9%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.19 ± 53%      +0.1        0.34 ± 16%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.09 ± 81%      +0.2        0.24 ±  9%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.17 ± 61%      +0.2        0.33 ± 12%  perf-profile.self.cycles-pp.update_process_times
      0.18 ± 51%      +0.2        0.34 ± 14%  perf-profile.self.cycles-pp.get_cpu_device
      0.18 ± 55%      +0.2        0.35 ±  9%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.21 ± 61%      +0.2        0.38 ± 23%  perf-profile.self.cycles-pp.check_cpu_stall
      0.15 ± 46%      +0.2        0.32 ±  8%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.18 ± 51%      +0.2        0.35 ±  7%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.19 ± 56%      +0.2        0.37 ± 14%  perf-profile.self.cycles-pp.timerqueue_add
      0.24 ± 48%      +0.2        0.42 ±  5%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.20 ± 52%      +0.2        0.39 ±  9%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.17 ± 56%      +0.2        0.36 ±  8%  perf-profile.self.cycles-pp.rcu_pending
      0.20 ± 56%      +0.2        0.40 ±  9%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.20 ± 49%      +0.2        0.41 ±  7%  perf-profile.self.cycles-pp.rb_next
      0.21 ± 53%      +0.2        0.42 ± 15%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.30 ± 56%      +0.2        0.52 ± 10%  perf-profile.self.cycles-pp.perf_rotate_context
      0.17 ± 56%      +0.2        0.39 ± 11%  perf-profile.self.cycles-pp.btrfs_get_8
      0.15 ± 47%      +0.2        0.38 ± 18%  perf-profile.self.cycles-pp.check_extent_data_item
      0.28 ± 55%      +0.2        0.51 ± 18%  perf-profile.self.cycles-pp.__memcpy
      0.27 ± 58%      +0.2        0.51 ±  2%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.28 ± 47%      +0.2        0.52 ± 14%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.25 ± 53%      +0.2        0.50 ±  5%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.25 ± 56%      +0.2        0.50 ±  4%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.29 ± 50%      +0.3        0.57 ± 10%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.22 ± 52%      +0.3        0.51 ±  7%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.39 ± 52%      +0.3        0.72 ± 10%  perf-profile.self.cycles-pp.__btrfs_check_leaf
      0.38 ± 51%      +0.4        0.75 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.58 ± 41%      +0.4        0.99 ±  8%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.79 ± 54%      +0.7        1.50 ±  4%  perf-profile.self.cycles-pp.menu_select
      0.89 ± 52%      +0.9        1.82 ±  8%  perf-profile.self.cycles-pp.btrfs_get_64
      1.15 ± 57%      +1.0        2.20 ±  4%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.30 ± 52%      +1.2        2.46 ±  9%  perf-profile.self.cycles-pp.btrfs_get_32
      1.84 ± 52%      +1.7        3.50 ±  5%  perf-profile.self.cycles-pp.read_extent_buffer
      2.36 ± 54%      +1.8        4.17 ±  4%  perf-profile.self.cycles-pp.__memmove
     14.47 ± 54%     +12.8       27.32        perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

