Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B92F6EA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 23:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbhANWxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 17:53:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:53636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbhANWxE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 17:53:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D507AA6F;
        Thu, 14 Jan 2021 22:52:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3910DA7EE; Thu, 14 Jan 2021 23:50:28 +0100 (CET)
Date:   Thu, 14 Jan 2021 23:50:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     dsterba@suse.cz, kernel test robot <oliver.sang@intel.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [LKP] Re: [btrfs] e076ab2a2c: fio.write_iops -18.3% regression
Message-ID: <20210114225028.GF6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        linux-btrfs@vger.kernel.org
References: <20210112153614.GA2015@xsang-OptiPlex-9020>
 <20210112154529.GT6430@twin.jikos.cz>
 <979aee28-c603-a187-e03f-29957c7b94d6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979aee28-c603-a187-e03f-29957c7b94d6@linux.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 13, 2021 at 01:58:18PM +0800, Xing Zhengjun wrote:
> 
> 
> On 1/12/2021 11:45 PM, David Sterba wrote:
> > On Tue, Jan 12, 2021 at 11:36:14PM +0800, kernel test robot wrote:
> >> Greeting,
> >>
> >> FYI, we noticed a -18.3% regression of fio.write_iops due to commit:
> >>
> >>
> >> commit: e076ab2a2ca70a0270232067cd49f76cd92efe64 ("btrfs: shrink delalloc pages instead of full inodes")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>
> >>
> >> in testcase: fio-basic
> >> on test machine: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
> >> with following parameters:
> >>
> >> 	disk: 1SSD
> >> 	fs: btrfs
> >> 	runtime: 300s
> >> 	nr_task: 8
> >> 	rw: randwrite
> >> 	bs: 4k
> >> 	ioengine: sync
> >> 	test_size: 256g
> > Though I do a similar test (emulating bit torrent workload), it's a bit
> > extreme as it's 4k synchronous on a huge file. It always takes a lot of
> > time but could point out some concurrency issues namely on faster
> > devices. There are 8 threads possibly competing for the same inode lock
> > or other locks related to it.
> >
> > The mentioned commit fixed another perf regression on a much more common
> > workload (untgrring files), so at this point drop in this fio workload
> > is inevitable.
> 
> Do you have a plan to fix it? Thanks.

My plan is to find somebody who will fix it. Thanks.
