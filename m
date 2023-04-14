Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98846E1E2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDNI1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Apr 2023 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjDNI0s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Apr 2023 04:26:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC08900C;
        Fri, 14 Apr 2023 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460789; x=1712996789;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C6gKsaMnjt9Z6VVDg/5W88aNiYFm1xLXhhYtnUp8NlQ=;
  b=JzSG5UG28zRhfsB15dbGWI6oty2+HrLQBdYiJZoXctrU3O+Gv57/b5X9
   +crSTVOFbsNNy94nNJoTI7jO716bAqH8MncDyIteRxhv2F4UqlBJmMv+H
   CaSZtEaJksPNRSV4PW6OUeMMJ9B7Ye75eQ9NtvjvfSVs0w6LjMXOtBEke
   GsAThncTHHPXukLLELbLxHe90b05vHNldLVNFUiq7A8DCj4P4swVT25id
   WfOUwDursDJZAqPFo/cx8diFOV8uL/0SWdmHUYv4glumiRX8M2WDIJuzY
   5V9uGCvChz2p6lHGJEbl24fjlpMK7rgpfMwQUAt8nMNTr0IhoUyCUj6vH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="409612194"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="409612194"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="864129448"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="864129448"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2023 01:26:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 01:26:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 01:26:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 01:26:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 01:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PookRThJOGV//TQvExcUtQUqzd9cFj/0aiwQeXeH63820DBCoEq74Bco8G20wJyaaMPL94GeBXUTGZxfS1wuMRsgsThe9MEeu4JsTIRXoj+NMYDebuhp/dnk7GX9fgJ8O3R+7vM6SPde8lXadMpMaHTuwf37u1fDkJkwUcfCi5segainbYv+xmxHO9d1srkH2feyoBiRKppfP9kh3aaxRZW/RszJAtNL+x6WnkU7GJGEFIwrIMnDkzSy/RnJ8Rpdlu+Kq1uvl/WQDGBUOjXAT83slnlehbSAFEn6SK5e3QQVcBfh+ATrJ1Dj/YVL1s/kwHK+ehadFMYylLl/8b9JTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5en4BeW5lBHEm2p/P99kuglGJT67eVd5f17zkOTGuY=;
 b=RZtGVUiv2VpY3cjOR5IMjnpbZTHPqSouZvREi7EtyawyOMTc8wex30cbXmV/RUeAXF+RS8q2zsHQ1Hj+6/cu+vy4+ywkahu/jZ3RzPE6QAsmQRoHOfyAGzYgeik2MoESqi5BdN2vppDmjS1ssLrhKcBEGtMfWEqdsaGfHUWmw5QTHP2YKtSeD1XieAikdyulxM8yp9JBYHO8oinISz6+un6b2DnpbJl/QfCF5JgcQ6VPf9CoJdgWDFGP+kyaX1oldY/l8aDUDQFAhzNZonY3Ft8eoRBmwWeBDMmVwreAQUpJHUi7pYbmbx65q4byw1nILNkAGKHoMiBPAQs9qbDCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB5392.namprd11.prod.outlook.com (2603:10b6:5:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 08:25:46 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0%8]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 08:25:46 +0000
Date:   Fri, 14 Apr 2023 16:22:36 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        <linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [btrfs] 4ae2edf12d: fio.write_iops -11.9%
 regression
Message-ID: <ZDkNTJfu83DrecW1@yujie-X299>
References: <202304140917.9e9f5c1-yujie.liu@intel.com>
 <20230414052458.GA11616@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230414052458.GA11616@lst.de>
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6a02bd-cc70-40df-8776-08db3cc1d832
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKPPaVGucAouDos48jPRRK7x5Zasq/NXRyX3axMGf4qhD4YowZgH44+rlMfRMrgn6XMa2EhyGd12HKWSJd7IxftR5iBg4bMHjxOyTNEPXhQRVBzjo/hT6YO2vV3shgJBkKlD2tKY7G9mrsyYhKThrfD+w7K00m3nf9LUOaPZES7xasqsWq32sjKveVbxUu92F9oX5kebA1L9Kl9Swh+7W5UhHIjuSG/UCsM6R9YeZHuViSgkn0ckrTD48yPViTnUK2vVB6J7PboVE0lua+2FgccEvhds+2Ie9B0QRivHIjFzKEUVWQdBXmudnhqDepw6GjiVGRAUqWUhjoF4Sss2NoO4uvG8UGTRXQemq4BGJ/SWbC/fpewLaEAx0Dnb+85iovEKsEdNtRFUVh8NfYb9jIfgTnSFiV3ACNhtTosrh1GKjg0SQJFMQbmL1hcPeup9Br8V8s/oyeTw2IzCYJLUeDkQ+GPiX+u+KeT09MqiAjdNfVXD4Os4HEYM6x1mgLZ0I1MaFe3eiUBPnBUvaa+T9KGNdJ/iTcR4QHMg6r4j+gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(83380400001)(107886003)(966005)(6666004)(6486002)(6506007)(26005)(54906003)(33716001)(186003)(478600001)(6512007)(9686003)(44832011)(38100700002)(5660300002)(2906002)(66556008)(4326008)(66476007)(82960400001)(41300700001)(6916009)(66946007)(316002)(8936002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdHFT8g/eNItamRT8gCPOibbNdMLqjRvofhvXYMvx48RhajKNJkYMwut5zAG?=
 =?us-ascii?Q?Dq36ya6yyeD6zTgO5/feio9AgDSuEpUdCauRuSkIuPlKxX0V8j0xNHjAln3/?=
 =?us-ascii?Q?9HWggmAQi1cFGHuXSsLsoc3CSME4gWeff5FaYezWTC+EET7gJR8MrMRV6gRP?=
 =?us-ascii?Q?yd9vhuu6Ac1zgjdQ30kHB4bTHpImj1y936mfapPkO+UPzMDMq2aliRi+S0ij?=
 =?us-ascii?Q?p+/K99cr35ffNeE/3Oj/Lp2m06oY9ttvy+c52gJwJ56DtwQI0C7acwocVf7G?=
 =?us-ascii?Q?21CAwT1F+455y/RIm+tx6Vlnd6a9cAjGnGyTWaD1cACucKwRkn2jhUAG4/TF?=
 =?us-ascii?Q?5ApZhHom18iAti+apJR3ry9yRPbqAttu1+iUbaF73CwzdkVOPx8LvEJ4Bxb2?=
 =?us-ascii?Q?ZwL3fmk0URmuH5W20Gc5aXw7UOD9hP7v+XzwS9SNqQjILNaF5leuQ5XJX9Rb?=
 =?us-ascii?Q?87mgU/35PGZ2cCd6rGKelmLB1uYsA+YmIrCK1B8VWFTbuPSfcSBevYbVCKDN?=
 =?us-ascii?Q?KqgDRQXakd5YS/HCobUKqeERKw0jV8fKloXHqxtF4l1wUeuIjM3u57JLnpgZ?=
 =?us-ascii?Q?tlHfrfMcNyvRVu0PyZkMter6UQRJxbqx6FnZdw3bN2ztpOzwMxkILCsGtupE?=
 =?us-ascii?Q?DWXOofrOUK7lrR1pFtlTk71bcd8vv+Yw57PpXdbnyHFNjwkjlsIc8Ajf09S9?=
 =?us-ascii?Q?end+mxaid2rl1mnDdllx+r+mlESmjrX2Mh9iy2hxoQYAq+PCdXOu8qFNLUNw?=
 =?us-ascii?Q?M9bPltFloX8tt8R3RhZM0q6oUiFuJapw4+/gBA73Zh4WPxUf2G6m+bPsOUlV?=
 =?us-ascii?Q?zrYklJ04/0ywU+js7verzcFiVJIs1Jik66qfFFycFlWR24HcK0nZyaUy6DcP?=
 =?us-ascii?Q?rwvwoOCBbqOH4eAl7eCwtRGIhFxrH1mPJ355/4Si76Uj+noIykC9RljE4IXC?=
 =?us-ascii?Q?zWMu/rqXXzwnEO5LmfYdT/IxaKVW5xqeZz80YCSxVDaAfqWpG1BWbnTjH1Jt?=
 =?us-ascii?Q?Otc6mulqCBlZUsJdHRYTawT13n5D3uslrKE7ddpw6xGYlZEohEuxYKK6/fFf?=
 =?us-ascii?Q?38eSHL4K40gv7BfNhmHVYqdN6lbZI1pHTncjv8hou4r4KI+CJLpKi7H+hpwe?=
 =?us-ascii?Q?2ipVeulKHl06BvtEMkBPJQou6WyQCbKsAOijt4IA9OYOQ2fiifKpw6REirV/?=
 =?us-ascii?Q?8v/cdPPs++ntnsEevkjfFDFNI8zN8EWEfSNogj9y2E+ZPmkVWoOG8Nx66zMJ?=
 =?us-ascii?Q?REwt65m+7nWpqiSUr/EkD0WBM+xK1YQTr+XXXyiLfTGw0im1mIfPJyqu77q5?=
 =?us-ascii?Q?vj21HvSbj3Bs7gUNJkAXVMvdlyszWSMsaBmNyu9VoLr6EvWZAKcIwCoxge9w?=
 =?us-ascii?Q?SFY+RdDrzDrZpx18j1w5WfY9sJ+F7ul7J7kPrDhyT8O5Y/rT/dzyIUeHhPeT?=
 =?us-ascii?Q?HWazNz3VEpztr1C20eqlqPoMCrByje1/7fqt6oaTLgHWU7Qx7QRp9Ljnzdwz?=
 =?us-ascii?Q?UPvptXfPXXKB5icGjOxnejEYMcEsmr9Dyhw3YrvMTapNwm6waP3obgYTh5ND?=
 =?us-ascii?Q?IhMhLojrLZF7pstWCoHKiR1oRILN7sC4Rw39o0d1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6a02bd-cc70-40df-8776-08db3cc1d832
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 08:25:45.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKZrS64CEp4jxKgK3XCZPLeWerdBiehHbQae2NmYLeisNviXe4T3+vwG3gtTwhIrEiMWIJnhKii3su0XJ/d06w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 14, 2023 at 07:24:58AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 14, 2023 at 10:01:51AM +0800, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed a -11.9% regression of fio.write_iops on:
> > 
> > commit: 4ae2edf12d49fdbaea2dfda0bb2ec06501bd3493 ("btrfs: simplify parameters of btrfs_lookup_bio_sums")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Can you revalidate this?  The patch is purely a parameter passing
> cleanup, so a large reduction in IOPS looks very suspicious.

Sorry this is a false positive report.

The environment was inconsistent when testing this commit and its
parent. We've revalidated under same environment and confirmed there is
no regression:

=========================================================================================
bs/compiler/cpufreq_governor/direct/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
  4k/gcc-11/performance/direct/1HDD/btrfs/io_uring/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/write/lkp-icl-2sp1/128G/fio-basic

commit:
  5fa356531e33e ("btrfs: remove the direct I/O read checksum lookup optimization")
  4ae2edf12d49f ("btrfs: simplify parameters of btrfs_lookup_bio_sums")

5fa356531e33e7c7 4ae2edf12d49fdbaea2dfda0bb2
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
      9370            -0.7%       9309        fio.write_iops


Sorry again for the inconvenience. We will improve our workflow to
reduce false positives.

--
Best Regards,
Yujie
