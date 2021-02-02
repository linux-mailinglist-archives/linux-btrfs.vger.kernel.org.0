Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86F30B796
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 07:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBBGDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 01:03:30 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55860 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231912AbhBBGD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Feb 2021 01:03:27 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D1237841372;
        Tue,  2 Feb 2021 17:02:23 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l6olR-005AGn-A0; Tue, 02 Feb 2021 17:02:13 +1100
Date:   Tue, 2 Feb 2021 17:02:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210202060213.GU4662@dread.disaster.area>
References: <20210121222051.GB4626@dread.disaster.area>
 <20210202021421.GA7181@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202021421.GA7181@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=mdF17258fPvSunSwwLsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 01, 2021 at 06:14:21PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 22, 2021 at 09:20:51AM +1100, Dave Chinner wrote:
> > Hi btrfs-gurus,
> > 
> > I'm running a simple reflink/snapshot/COW scalability test at the
> > moment. It is just a loop that does "fio overwrite of 10,000 4kB
> > random direct IOs in a 4GB file; snapshot" and I want to check a
> > couple of things I'm seeing with btrfs. fio config file is appended
> > to the email.
> > 
> > Firstly, what is the expected "space amplification" of such a
> > workload over 1000 iterations on btrfs? This will write 40GB of user
> > data, and I'm seeing btrfs consume ~220GB of space for the workload
> > regardless of whether I use subvol snapshot or file clones
> > (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
> > wondering if this is expected or whether there's something else
> > going on. XFS amplification for 1000 iterations using reflink is
> > only 1.4x, so 5.5x seems somewhat excessive to me.
> > 
> > On a similar note, the IO bandwidth consumed by btrfs is way out of
> > proportion with the amount of user data being written. I'm seeing
> > multiple GBs being written by btrfs on every iteration - easily
> > exceeding 5GB of writes per cycle in the later iterations of the
> > test. Given that only 40MB of user data is being written per cycle,
> > there's a write amplification factor of well over 100x ocurring
> > here. In comparison, XFS is writing roughly consistently at 80MB/s
> > to disk over the course of the entire workload, largely because of
> > journal traffic for the transactions run during COW and clone
> > operations.  Is such a huge amount of of IO expected for btrfs in
> > this situation?
> 
> <just gonna snip this part>
> 
> > FYI, I've compared btrfs reflink to XFS reflink, too, and XFS fio
> > performance stays largely consistent across all 1000 iterations at
> > around 13-14k +/-2k IOPS. The reflink time also scales linearly with
> > the number of extents in the source file and levels off at about
> > 10-11s per cycle as the extent count in the source file levels off
> > at ~850,000 extents. XFS completes the 1000 iterations of
> > write/clone in about 4 hours, btrfs completels the same part of the
> > workload in about 9 hours.
> 
> Just out of curiosity, do any of the patches in [1] improve those
> numbers for xfs?  As you noted a long time ago, the transaction
> reservations are kind of huge, so I fixed those and shook out a few
> other warts while I was at it.

I'll give it a spin, but my initial reaction is "I don't think so".
The workload is does not have the concurrency necessary to be
sensitive to log reservation space running out...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
