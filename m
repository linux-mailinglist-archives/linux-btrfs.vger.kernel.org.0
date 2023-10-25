Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC47D65E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjJYIzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 04:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjJYIzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 04:55:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF043B0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698224149; x=1729760149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=osXsHfUfDnGrNVSWp0PNXWmx2bwHb1RPwXIeG7S3hk0=;
  b=BjfpOHg+Ahi6QiyTGsjSPbp9N7vy4ZwdKLypv1fWOUlvJbQyU56oapGy
   vb2G0osfl5RyXRqfF9GOsxmCHu3tr8EFoxb41oYEi7FgTzxhDe+RZi48s
   ljH1UHKwPtQA52fz7rEL4JqYDCBN8nj8DU8aaw55HBK07K8Iu2Ez0oA4+
   evEOj4WOBF+VkdoThG62UH+sEUqkYRXNNefH8XRf4+tdivpIUxDAae88w
   5O8DzZ9q9/v0dWpju+O2wLan2Y0rgIQ7rO6WNwrUk5aTq5mTkYH6WI42O
   8e/qRsRUdIdq+Mb+BwhuVrPk5OpPqLWsLRpmb6s7CWb0y7OwmbI3mB+DK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="366617010"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="366617010"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 01:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="33015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 01:55:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:55:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 01:55:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 01:55:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 01:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7ZFQZGzmY9uUZT3z/2kwOrTIE4CENv20HU4cpGZOF2KHHV6XqhjI2+S9pxsOPdMO1LzTxoppmGDID6A67xsv/ehyt7QYpWca/fIKu69vsSMCsGac9kTuU0CpvpPH6/GbVIy/QzKD4U981c1ZeVLNRBDdq4d5pHmzDB4SncAm2PTFJsl4m7/CHMFM1PMgBWb5DHyiVVYfDRJptOz9z6iUhBQfbBnuuDOteZP7BYR4Shqw/8S2ZS3q68/PHTtM5K106cQ0zTUOn7NLdDdeKHTgO/sDREsDmIEqX7ZTTv60pWumo33yp6UpyumAHwGT8A5Nq7z8fqvz4kqB6cPSnIMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wtutg77JTiDz32pbjGNM0oTrHN7VMuvG4CCIsHro98=;
 b=m6pr8b9Og6Wp2QuuX+IsiENirK33OfuY/nce9+NPdsVbYhKNxq5Prjgb3AUuzBWuu8+IYVXf8girmWJPPhCmuIhx6iMDRJI9WvkSSBqz0Rjs4wr2wWLi10aHJ+ZXMenPqVLdIaZnxGDH/8JZQsks0SJFMbLcLiR/stedVp2YFiZat+A8+UmRXVXIVBQvnC7RktNGolJRKk/DrjqvEEYmLvhestwffSTQlt4AM3w9oqMB3tooCmBDptLWQxGo9HrZ8xeUtu9pRpML9fSZmftTdJiwMLiD/+802rdIy/jpLZ4nHEn/mm4i1qeglcfiGdbA3+CBvB8ca39DHVDdaEWTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 08:55:43 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 08:55:43 +0000
Date:   Wed, 25 Oct 2023 16:55:35 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Anand Jain <anand.jain@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Sterba <dsterba@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  a5b8a5f9f8:  xfstests.btrfs.219.fail
Message-ID: <202310251645.5fe5495a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a88b005-6d7f-43c5-6c06-08dbd5382b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POY+o2OUzL2XhdtfwMuMyEYSBWdubVOZ3pw716J3VNRiV0NUFX5bHZ+hbVZ52fvssyvnY7clX376KiPqE7t1gwzcAAIJXy3PoWZm520PNgZdMQVH32TnXgw8etspVVUbieK6Jh+shSbHKfnnuc0Uhd57pVcRk4X2Ubcg61T1U6eEsMb3/rb5/dbEefbVD7xZt7Q/4czRTaLvKLfwi/FYlk4Q6CAi6BIVFoxReFfepdlVMeCy5WKQSs/HBX+KcbNfwqCTKIgHG8cwr/SJ3KpPu6gMrrV5kIxn/7mFM0jHBASpoxY7UvICsLW9mBIldHK20DcR6gnKnxn8Mk1yZxt7ZB+3QcN8N2HG178R/sGmfez4UFwq6QZfAqtx6xXbaKNH64+innKFGHQDdTvzqpbBZL7n+2p4IrRCCjpSBtQK6ImGjRHyblSWIT9+zZIVqo1Ej+ToW9V1vee8zJz0OEwagdiv3Yaa52Dj4MkOyHo9O2OPgmZSzYuuvedoGEKHcC0SBQkMu4RR0TDrgMFvNuBtwq4s/pgvyWRmlyBSbH3xvUAJzkTWYQEoDvdkg3cjCmP6iF2s55D+mgP4CdtSABEqWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(36756003)(2906002)(38100700002)(82960400001)(2616005)(316002)(66556008)(6666004)(6506007)(1076003)(478600001)(54906003)(6916009)(6486002)(966005)(6512007)(83380400001)(5660300002)(86362001)(4326008)(107886003)(8676002)(41300700001)(8936002)(66476007)(26005)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwbKkcHGeAgycJzPETBm26x5OVywTUtrJaJWOIsx4BlDVa9v8lEHHRUdAP3F?=
 =?us-ascii?Q?VRxSzg2HNX9rC57gBl86Ief5kcpBjqqGasxMKkzwJUOwD5qd93/KdbvqvUpa?=
 =?us-ascii?Q?uZ8AbMTM+DJXGRDvW8fTm4TtppqKzTwrJH7XnOaTkMTzOY8hHFBZuvD5/ooS?=
 =?us-ascii?Q?XTTyToEGQMqVQIFi4KVK+ItxPU5ztShbX2e5BMCG9xNSErgO+LaDqM8lcY56?=
 =?us-ascii?Q?FaxDYFxgsqCCvhAtemwYkd0Z6vQd4hbS0RgM0ajfKJLHsz8PYmcr0MrlijK3?=
 =?us-ascii?Q?bcTGcRiMbK0ApMXEVbHvkUauHtK0u1IS1bdilV0sTmNDoeeTBU/eBqEyGDhN?=
 =?us-ascii?Q?1DH5GEbMTmS3ZQIETQXPuLRCInM1FT3/WVTSiuuDMFlmxCRsMUTzmmIGgJQ8?=
 =?us-ascii?Q?BKlXMrLefg/SkOUacKS5tyEvpratXa2y/YIiYXoM2yhWq31DVBAhlY8ZK+DS?=
 =?us-ascii?Q?Mzh4WH4eE4BBesorJv2pyigB6gaLVkefZ1Fp9Ymiu/qmrqQPcrOhJ2ONnXt2?=
 =?us-ascii?Q?Kp/mdrbblgY21XwMMchp4TYp/DFgDHFGJb/3JNg9Xp873APpkeqTAlg01HrB?=
 =?us-ascii?Q?fnJUYWxp61kWaxRQYhti8vYJlY4lzB7R0S4vxXpp8kpaKoGt1g+coi7MlWw3?=
 =?us-ascii?Q?GRvq9OkLkxBRzDF7J1qVCaqrwrBnhVEZLONNeV3TO8zC2uHncFEyqfbcBtpp?=
 =?us-ascii?Q?mBqzijrkuGu/8Bv2TN/gUNCaUhoWJMKg8KokkDiC7C2KUefdFL5Cv1AAa9E8?=
 =?us-ascii?Q?NQcGqnql6cZfiBraZ/Z5mcEBCXQ1MVaSF4cOLzRToYTPS/KVG73jzmWpr805?=
 =?us-ascii?Q?1/h3+FQ2GlosMge9+IXtMvpknJUOsmeHpMqyJlyzJ75TdEZCR0Umkqyw/uSo?=
 =?us-ascii?Q?CBIWmckZDdD3nosUbeODDZ9cswiYJNB/mEyeJQAXnwsYqv2grS12x+HI5qCX?=
 =?us-ascii?Q?+uSfLqtq1X33YI6y7Sv6HKAHkAMiPJMNDdSRvIrtwi4ZgrJmDSk3Ij4tIl3w?=
 =?us-ascii?Q?9T7A7OCungBcxfAUKPsIBWJ5pqNm53T/PhhImu6hBwgN9EHyJ4s0JPr51scM?=
 =?us-ascii?Q?THicd19AlYpfqqJWmz8uZZ2iVoxZZsnpfCgKCyPxza/kioqNKTY9bpKE7sgE?=
 =?us-ascii?Q?X9F44/QTxstdNAkgOepGmR5NNjfzNiFRWQ6TAlPgDPG6IP1nqaQcZlMME68z?=
 =?us-ascii?Q?qCMdk5il7LiZMR9kNmYQhPrEkseZQfPp92f7erOW+BguIVaXFyZ1yy6t2D4w?=
 =?us-ascii?Q?V5/SkftdMmFH/ahttt0ECsduxJGsj1b2AYm6wR20m8/ivWIWLOt60DxEJVwL?=
 =?us-ascii?Q?qH4mMTphXlTJWpzLtU9IlSr1hN0O1S3PrTjF2Tk/78fCMpsd/t7I+vfXyFOz?=
 =?us-ascii?Q?6WwRQecMkxnnQlvIe7dgNe5GTKR7H7PaYUsncEIB3TZsEpRuTLiEH4bBPqtD?=
 =?us-ascii?Q?p7q2sQXmSRpKUIuh8FPH9r8xLnC6I2QBaoo7rxgGabzWj+ezvCGetUAXYwRR?=
 =?us-ascii?Q?vOfSOMwQT4luikCXMWeATxCIDyIP3mtplo5WRWvfUeM6mBHcv7aZg8LlG2rw?=
 =?us-ascii?Q?mDxHdAY5KrEdGX45izsH0kQ6b9LluQL3Issp+NozIi5rsJcuGbyZqZPt5h4C?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a88b005-6d7f-43c5-6c06-08dbd5382b83
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:55:42.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGiwOwXgIViNuGBAErP52FUM98OicYmAtFUXAkY8R6Ibt+D4ftKKTS5FJeS3bLHNxyoBMv2w+sxoPlIHVm2BDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hello,

kernel test robot noticed "xfstests.btrfs.219.fail" on:

commit: a5b8a5f9f8355d27a4f8d0afa93427f16d2f3c1e ("btrfs: support cloned-device mount capability")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 2030579113a1b1b5bfd7ff24c0852847836d8fd1]

in testcase: xfstests
version: xfstests-x86_64-4d811ae-1_20231009
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-219



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@intel.com



2023-10-21 19:53:10 export TEST_DIR=/fs/sda1
2023-10-21 19:53:10 export TEST_DEV=/dev/sda1
2023-10-21 19:53:10 export FSTYP=btrfs
2023-10-21 19:53:10 export SCRATCH_MNT=/fs/scratch
2023-10-21 19:53:10 mkdir /fs/scratch -p
2023-10-21 19:53:10 export SCRATCH_DEV_POOL="/dev/sda2 /dev/sda3 /dev/sda4 /dev/sda5 /dev/sda6"
2023-10-21 19:53:10 echo btrfs/219
2023-10-21 19:53:10 ./check btrfs/219
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.6.0-rc5-00214-ga5b8a5f9f835 #1 SMP PREEMPT_DYNAMIC Sun Oct 22 03:34:58 CST 2023
MKFS_OPTIONS  -- /dev/sda2
MOUNT_OPTIONS -- /dev/sda2 /fs/scratch

btrfs/219       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/219.out.bad)
    --- tests/btrfs/219.out	2023-10-09 16:50:26.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/219.out.bad	2023-10-21 19:53:35.090528975 +0000
    @@ -1,2 +1,4 @@
     QA output created by 219
    -Silence is golden
    +We were allowed to mount when we should have failed
    +(see /lkp/benchmarks/xfstests/results//btrfs/219.full for details)
    +rm: cannot remove '/fs/sda1/219.mnt1': Device or resource busy
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/219.out /lkp/benchmarks/xfstests/results//btrfs/219.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      5f58d783fd78 btrfs: free device in btrfs_close_devices for a single device filesystem

Ran: btrfs/219
Failures: btrfs/219
Failed 1 of 1 tests



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231025/202310251645.5fe5495a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

