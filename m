Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C37DC792
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 08:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjJaHqn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbjJaHqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 03:46:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2ECFA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698738399; x=1730274399;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+I7MJfrDSrlWPuliA1tdEITtShmNym5QuTB2OMm1B7Y=;
  b=ZS3gnszU44AzqS17LtXfm8lSQDMknEfRQr8wXE3g14WYg9kxCgcbHszK
   J4X/AIWpRu3GbXvA+l6fnjUdVc2aeNwoiGTQ2V7he4jZYsrgmhmN54lBc
   X2ENtxRzcR4NquFzLK8vgxCc+Rl+NyRPmFgzNLs2MFpYoKxalYF89KuKh
   xkGZHK0bc8kF+WWNPEHNyuQ9ZpKE3Mo985Hm5SmVL88FyelBrY52FRTJL
   2uY75f4vvOk04KixoqKS7dJRwuhDusR1kT1YpXEmipH9b/jg1iYNll03W
   6rgZuhrfgDnlC85S0ds9bv+0ZJ8Y9bumICX/lZlTmhsOL9JKlkT9jJfLG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="391107304"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="391107304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 00:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877422140"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="877422140"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 00:46:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 00:46:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 00:46:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 00:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRD5/qpGKFkK0QEymFNUohPy6oThRkAnGXkrwPqtcPtP4K+f2jCR06xRrWDNGoBiLPsnquDySgrQbliCDC+gGgK3QgI8jzg3HHW/KwB28vFy1JhoP+S3fCPZrV2k2sYa2uzneAXFYEUPHlMPTetE0GkSj2SDDYSDdbEOU5RHDjYjfwqUwRQQdspcvh+0pQsPPxEjwX6Ae8zE/8jbO5TtRssmMNKozqVYUKs6uU1TfWoOw3oGNiD+C2RM8SHIwySfXwU5v8576x2OcUch8c1VXXLTtkvggEuDrVjEhVizPsG3yxeYmVTi9LTNSfRUSBSBvYYItVIZcoECGILYC+UP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrgHfw73PnSaE56A4xvQE0EQhD+x6KTA30XpCSCJ3Wo=;
 b=Y8cKsjHeTHrlpGURBB9FoC3uurdQ17VA5t8oJ/9aDyl6Ws1XqnGg0wVlKPDuOrDm2buMgwZJii1xDqpDMTIbI5uyAtmXyNov9Ged/AtCJSu1yHdrPyQZM1/qysADqAQIXeCaHcdQRKFVYpfTPFAqCKL2a7dO1uSoy4LCRJBX/i7tAzrbFR5G1lSksGHKdYaTAC5tIHDakImRZTL+h2CL5GaPKDIVmbte0MFcPy0rCdC4CJNsO4OatoEc6Mte8CYYTXqhpE1u73cqlGuglMKRfr5nyGUPB5L1szN7Szx5GpAspq9M13DIS1s3OYcqEYdEsdaMi+/sktY6SbEpm/s0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 07:46:30 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 07:46:30 +0000
Date:   Tue, 31 Oct 2023 15:46:23 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Anand Jain <anand.jain@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [kdave-btrfs-devel:dev/guilherme/temp-fsid-v4] [btrfs] 479361d32b:
 xfstests.btrfs.185.fail
Message-ID: <202310311425.c2e34aef-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0098.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cd1e6c-eb84-4af1-7c3c-08dbd9e57ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Av3p4zFpEOts+sMzdU055DaMn2eG5S8u3RzBEhlH1Jhgrf+aR12UT7QrczZ50SIR49pbiQHPKcYGF2ImPDow4Hxy33Y46hkmVNbXfpCIcJj6m/5mnSBncdxJMlDNN4lyxcTX8WSG+rshxUHtmjGBtHQUAuw/sQNTs8gazzKuDpFN1UMEM2cvcL1ieJVaVFjbTcv09IHKytZS9AM+SnQ4FF+nTnL1C8aBa5RiwlpLIu1Krvi5mKZITukxkx4IaQeEcn0DJs256kdBf5UN83Syl2OXsd8eD5Qwwauy2Leq5D+9MZMVpVsVMM9lcDg8BWHPB8huFJaFDLPsbt2xXOlnGdqJ5PV0de98qEc/mn7vMzQXEWDELlzCIUeOuniGZS9Ct6MI4SZCfHblDYYz2Og/lqYCDYxnrj8qyIJQJGMFT8MNC1XwvjbZLi0NmeNm9Q0oSZgRho1XEYjMsnQOu+LNe6291CUb+z6z64gSkfHQH4lPr5o1oiD0BbyFH3tq5LMBpeY9CBb54nR9XvvV5ts4AXvgY9Gvys+fF/Q4SZMyffutUTyC5zUQ2b/9YVkG1RDPqoPJEiCzxHQPl6qKoBlh6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(2906002)(8936002)(66476007)(66946007)(66556008)(966005)(6486002)(8676002)(4326008)(316002)(6916009)(478600001)(38100700002)(83380400001)(107886003)(86362001)(36756003)(6506007)(6666004)(6512007)(26005)(1076003)(82960400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CR21UnINveb1eeiWKFaVJxUWkdIjV4Tq3o/UwVPfz1fjFBmfD54uAs96rrvO?=
 =?us-ascii?Q?Pp0yVyh9rWOMwSwJtp/120opRKeKQHIAjcWFB2pOWC7Nd3Zp68ByWckypooo?=
 =?us-ascii?Q?XV1WRkS9K7sQwkeXvGS43SUaZ1GgqOx2D3FUajyt7+5yVUzADQJRqShFlKSy?=
 =?us-ascii?Q?RJOVasmjky6S86X9PCu1E8TKPRNa4nP/a2tcih6dcvjg17T4P74jl6B5Nxbb?=
 =?us-ascii?Q?Y6ucEB8SzGgz4JB6oxsSkFAAjPJ68cfR4HdHxjw9GjytoEftAz8ToVeoeCCt?=
 =?us-ascii?Q?7RHVCFruzlCi73rMQ90DltVgffZwShT+hA0sUa0Bd5Ip/zW4rTAnmK9yWtNt?=
 =?us-ascii?Q?fXh9LQRv2+CSPTlHd0M/xfsRPYjXHw+Fc8+5xG/Tv7biyKZLDBm2OcbTChKU?=
 =?us-ascii?Q?qiifU8dHcGqY0gtVA11ve/Embp0nV5vEr5IC2Q8L9x9lgX4K8y+34y8Hm7C9?=
 =?us-ascii?Q?ygoGh4IejEV+M261xafv4TBMdfLSjoyRXt+WTMvwz1X0aOx1z9v0bth4iW3p?=
 =?us-ascii?Q?CZN1+Vbic+cueC0vqk5zWZ+PwGMhc1AQ6cg15GL8LwwxVNStGGgyxCWxapoL?=
 =?us-ascii?Q?m0kyjFzHELVfQxmgrGugoFL4M16EDMyPVUnvUWJtWXB4274ZEoe2Qzv9livb?=
 =?us-ascii?Q?9bLAoxJPBQ3SvYizXvdCW3VKjbsXUKJDIxf+edixoz2vZV6FnSwcaX0i3uA4?=
 =?us-ascii?Q?QZkY9Bt4WylJckCl4JLKCQqXMWTPVVxIryrF096q3WuNVUC4aKMPdqsEnV4S?=
 =?us-ascii?Q?ocaLClvKDIAwYM2Wiu6YN4th8u9GTEtYA6WqOgRYAXKnH6YUIEIWLOtympaA?=
 =?us-ascii?Q?7McGSxAqKI+9mzQDHr56jYJiM2fy6ofk/LCNNBSEQniCTejZ/8Zi5dSog62x?=
 =?us-ascii?Q?kTsmCZWp0QEmVzglD7xqqwm6e8Y3mnEYJq59EpyerOmlAqriK3XOdxUIg9V7?=
 =?us-ascii?Q?koU9XZiGPN65OEVxou7O1o99aQ0yNWe+f7kQtcmJo9L6SsbZlB1foTZe8gF7?=
 =?us-ascii?Q?wWUMG5QKHprH2u9sEoQw0CG2vm2zNIRgR868jQjgdSrnIz8K5bIWRlcFraoq?=
 =?us-ascii?Q?Lcc9RgXo6jU23c6Tr0FhuJyG/rmJDAyJbFeXm6EodL0qLC+B3t2hvxJThaDY?=
 =?us-ascii?Q?Bpew8lVTHRdtofsnwI0KzaEDjIBai6Pbag5hpDyODDmL3vcMzasRpp8f6lmu?=
 =?us-ascii?Q?2zS+QoHXK4BXKAtvHgJj/QQFLwQZeT16M1X6kdwBa4Uc2z0N+uKvKaRuIAah?=
 =?us-ascii?Q?lvbehagLvM2wQbZi73rnyJBE6GG6MhJh+exLtoVkcRMbsWNpMTZeI9a+zlPr?=
 =?us-ascii?Q?BzbVeGdk8MMWaqoBwdFr2WjG1J7ZupxGb26a3OnfPzZ1bu2DFqLItrvgiUVQ?=
 =?us-ascii?Q?I50KRyKmJ2W08Pjb2pV2U+9KMqj6N+uSGuG/a/M/X140IO4y4u+QcuySG+nB?=
 =?us-ascii?Q?RhAPNvJ5RlvLtnBcQeiUwUFM2XM4ZC2UTg80WgRzqJ0DhbYLmmE+yT+3AlHn?=
 =?us-ascii?Q?AfQDQvL/FRur3ibbHryTKhCiLPwKFKblavifW53zFw9ZORVoUwErG9RW69uv?=
 =?us-ascii?Q?dxlSySjomaju9vv2lkj+bWA8hVEuwYN1HuQjOniC4tq2/3Nr0UJy9IPZw09M?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cd1e6c-eb84-4af1-7c3c-08dbd9e57ee2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:46:30.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpJEouXB6Z2Bi8NJr2DKU4JInE/NVZngi5aAs1CbtSezW1ge1DPSzdGafPcW8uCD9Sa4X0OGUd6zd7uJUnuy7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hello,

kernel test robot noticed "xfstests.btrfs.185.fail" on:

commit: 479361d32be2d93c5fe727cc5cd2ea2c187635a8 ("btrfs: scan but don't register device on single device filesystem")
https://github.com/kdave/btrfs-devel.git dev/guilherme/temp-fsid-v4

in testcase: xfstests
version: xfstests-x86_64-b15b6cc-1_20230925
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-185



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310311425.c2e34aef-oliver.sang@intel.com



btrfs/185       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/185.out.bad)
    --- tests/btrfs/185.out	2023-09-25 16:30:56.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/185.out.bad	2023-09-27 11:53:55.152939282 +0000
    @@ -1,2 +1,3 @@
     QA output created by 185
    -Silence is golden
    +cloned device scan should fail
    +(see /lkp/benchmarks/xfstests/results//btrfs/185.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/185.out /lkp/benchmarks/xfstests/results//btrfs/185.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      a9261d4125c9 btrfs: harden agaist duplicate fsid on scanned devices

Ran: btrfs/185
Failures: btrfs/185
Failed 1 of 1 tests



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231031/202310311425.c2e34aef-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

