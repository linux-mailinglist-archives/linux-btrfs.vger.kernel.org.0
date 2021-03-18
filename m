Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8314733FD50
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 03:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCRCjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 22:39:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:42913 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhCRCiw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 22:38:52 -0400
IronPort-SDR: M+/tCsqj12SFvB0pGqrmDLuIyztMbiwz0rGwT8VelPRbkxTX50sdfpx6P7KBqMcf3RQ+pe1KF4
 mB7tg2HaE+TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="177180910"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="177180910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 19:38:52 -0700
IronPort-SDR: sekA4qS1NWWjh9+u9VP2O4uKHjKSpobxFH/1mS4Lnfzy9ayOm2R/OK7nCZfsTJ9cOaX8PpEw8V
 utKjXGD/rLOw==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="450315247"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 19:38:50 -0700
Date:   Thu, 18 Mar 2021 10:37:03 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-btrfs@vger.kernel.org
Subject: Re: [btrfs] 5297199a8b: xfstests.btrfs.220.fail
Message-ID: <20210318023703.GB10304@xsang-OptiPlex-9020>
References: <20210309084953.GD12057@xsang-OptiPlex-9020>
 <5e0b9f39-9c4d-5b56-68ba-7a6283dc560d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e0b9f39-9c4d-5b56-68ba-7a6283dc560d@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

On Tue, Mar 09, 2021 at 10:36:52AM +0200, Nikolay Borisov wrote:
> 
> 
> On 9.03.21 г. 10:49 ч., kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 5297199a8bca12b8b96afcbf2341605efb6005de ("btrfs: remove inode number cache feature")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: xfstests
> > version: xfstests-x86_64-d41dcbd-1_20201218
> > with following parameters:
> > 
> > 	disk: 6HDD
> > 	fs: btrfs
> > 	test: btrfs-group-22
> > 	ucode: 0x28
> > 
> > test-description: xfstests is a regression test suite for xfs and other files ystems.
> > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > 
> > on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 2021-03-09 04:13:26 export TEST_DIR=/fs/sdb1
> > 2021-03-09 04:13:26 export TEST_DEV=/dev/sdb1
> > 2021-03-09 04:13:26 export FSTYP=btrfs
> > 2021-03-09 04:13:26 export SCRATCH_MNT=/fs/scratch
> > 2021-03-09 04:13:26 mkdir /fs/scratch -p
> > 2021-03-09 04:13:26 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
> > 2021-03-09 04:13:26 sed "s:^:btrfs/:" //lkp/benchmarks/xfstests/tests/btrfs-group-22
> > 2021-03-09 04:13:26 ./check btrfs/220 btrfs/221 btrfs/222 btrfs/223 btrfs/224 btrfs/225 btrfs/226 btrfs/227
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 lkp-hsw-d01 5.10.0-rc7-00162-g5297199a8bca #1 SMP Sat Feb 27 21:06:26 CST 2021
> > MKFS_OPTIONS  -- /dev/sdb2
> > MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
> > 
> > btrfs/220	- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/220.out.bad)
> >     --- tests/btrfs/220.out	2021-01-14 07:40:58.000000000 +0000
> >     +++ /lkp/benchmarks/xfstests/results//btrfs/220.out.bad	2021-03-09 04:13:32.880794446 +0000
> >     @@ -1,2 +1,3 @@
> >      QA output created by 220
> >     +Unexepcted mount options, checking for 'inode_cache,relatime,space_cache,subvol=/,subvolid=5' in 'rw,relatime,space_cache,subvolid=5,subvol=/' using 'inode_cache'
> 
> 
> Given that the commit removes the inode_cache feature that's expected, I
> assume you need to adjust your fstests configuration to not use
> inode_cache.

Thanks for information, we will change test options accordingly.

