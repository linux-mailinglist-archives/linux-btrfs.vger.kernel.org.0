Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C730B520
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 03:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBBCPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 21:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhBBCPD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 21:15:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C13F564EE0;
        Tue,  2 Feb 2021 02:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612232061;
        bh=+ZRvQlcK8Bf3QyDyR755TqYz7atQMiQIefWvaXw7Gb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYHlHd/Zs7iiqJ8rbWLFBPcBOQuTavvhiXHfBsmE5hJtfPeESgCyTKptT9BiQflhx
         Sl/Ph6t1FQXKcuFF1ugb1/5p/lwrd2dwh54M4RC+llxb2utYYvHPmZqVFHAis0OJrS
         DLxTRFBRndkw6bkfo54LGojv0D1QWqDOyIL83ZC1EJQDCFblL9ux6cBm2SdNWv5UJl
         1pCwTb1MzEmsIZfUaoa2mSCF9f2awDd8zR9E27X8jb1Gwo1Va0Hn2nxhJaY0Pf2TJ+
         EJ0oBfUhd9IHx+CN4Z/Ww9zKlWXoe8cNe0tzb3ziZA0F4rjVPBsZ0HiL32hy5xbVmS
         NYGQEyF3yR+Zw==
Date:   Mon, 1 Feb 2021 18:14:21 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-btrfs@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210202021421.GA7181@magnolia>
References: <20210121222051.GB4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121222051.GB4626@dread.disaster.area>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 22, 2021 at 09:20:51AM +1100, Dave Chinner wrote:
> Hi btrfs-gurus,
> 
> I'm running a simple reflink/snapshot/COW scalability test at the
> moment. It is just a loop that does "fio overwrite of 10,000 4kB
> random direct IOs in a 4GB file; snapshot" and I want to check a
> couple of things I'm seeing with btrfs. fio config file is appended
> to the email.
> 
> Firstly, what is the expected "space amplification" of such a
> workload over 1000 iterations on btrfs? This will write 40GB of user
> data, and I'm seeing btrfs consume ~220GB of space for the workload
> regardless of whether I use subvol snapshot or file clones
> (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
> wondering if this is expected or whether there's something else
> going on. XFS amplification for 1000 iterations using reflink is
> only 1.4x, so 5.5x seems somewhat excessive to me.
> 
> On a similar note, the IO bandwidth consumed by btrfs is way out of
> proportion with the amount of user data being written. I'm seeing
> multiple GBs being written by btrfs on every iteration - easily
> exceeding 5GB of writes per cycle in the later iterations of the
> test. Given that only 40MB of user data is being written per cycle,
> there's a write amplification factor of well over 100x ocurring
> here. In comparison, XFS is writing roughly consistently at 80MB/s
> to disk over the course of the entire workload, largely because of
> journal traffic for the transactions run during COW and clone
> operations.  Is such a huge amount of of IO expected for btrfs in
> this situation?

<just gonna snip this part>

> FYI, I've compared btrfs reflink to XFS reflink, too, and XFS fio
> performance stays largely consistent across all 1000 iterations at
> around 13-14k +/-2k IOPS. The reflink time also scales linearly with
> the number of extents in the source file and levels off at about
> 10-11s per cycle as the extent count in the source file levels off
> at ~850,000 extents. XFS completes the 1000 iterations of
> write/clone in about 4 hours, btrfs completels the same part of the
> workload in about 9 hours.

Just out of curiosity, do any of the patches in [1] improve those
numbers for xfs?  As you noted a long time ago, the transaction
reservations are kind of huge, so I fixed those and shook out a few
other warts while I was at it.

--D

[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=reflink-speedups
> 
> Oh, I almost forget - FIEMAP performance. After the reflink test, I
> map all the extents in all the cloned files to a) count the extents
> and b) confirm that the difference between clones is correct (~10000
> extents not shared with the previous iteration). Pulling the extent
> maps out of XFS takes about 3s a clone (~850,000 extents), or 30
> minutes for the whole set when run serialised. btrfs takes 90-100s
> per clone - after 8 hours it had only managed to map 380 files and
> was running at 6-7000 read IOPS the entire time. IOWs, it was taking
> _half a million_ read IOs to map the extents of a single clone that
> only had a million extents in it. Is it expected that FIEMAP is so
> slow and IO intensive on cloned files?
> 
> As there are no performance anomolies or memory reclaim issues with
> XFS running this workload, I suspect the issues I note above are
> btrfs issues, not expected behaviour.  I'm not sure what the
> expected scalability of btrfs file clones and snapshots are though,
> so I'm interested to hear if these results are expected or not.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> JOBS=4
> IODEPTH=4
> IOCOUNT=$((10000 / $JOBS))
> FILESIZE=4g
> 
> cat >$fio_config <<EOF
> [global]
> name=${DST}.name
> directory=${DST}
> size=${FILESIZE}
> randrepeat=0
> bs=4k
> ioengine=libaio
> iodepth=${IODEPTH}
> iodepth_low=2
> direct=1
> end_fsync=1
> fallocate=none
> overwrite=1
> number_ios=${IOCOUNT}
> runtime=30s
> group_reporting=1
> disable_lat=1
> lat_percentiles=0
> clat_percentiles=0
> slat_percentiles=0
> disk_util=0
> 
> [j1]
> filename=testfile
> rw=randwrite
> 
> [j2]
> filename=testfile
> rw=randwrite
> 
> [j3]
> filename=testfile
> rw=randwrite
> 
> [j4]
> filename=testfile
> rw=randwrite
> EOF
> 
