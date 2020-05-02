Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1270A1C23EE
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 09:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEBHwf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 2 May 2020 03:52:35 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39824 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgEBHwf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 03:52:35 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D5EFC69FD92; Sat,  2 May 2020 03:52:33 -0400 (EDT)
Date:   Sat, 2 May 2020 03:52:33 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Jean-Denis Girard <jd.girard@sysnux.pf>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200502075233.GN10769@hungrycats.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>
 <20200502072053.GL10769@hungrycats.org>
 <CAMwB8miVfp_vpJaak=W_PK-xYtb=Py1zqqVYXWo_3NN4a9Dk7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMwB8miVfp_vpJaak=W_PK-xYtb=Py1zqqVYXWo_3NN4a9Dk7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 02, 2020 at 12:27:27AM -0700, Phil Karn wrote:
> > deleted the originals in logical extent order.  Sometimes people call this
> > "defrag free space" but the use of the word "defrag" can be confusing.
> >
> > balance is not btrfs defrag.  defrag is concerned with making data extents
> > contiguous, while balance is concerned with making free space contiguous.
> 
> Got it. I actually would have understood "defrag free space" and that
> it differed from file defragmentation (btrfs defrag, xfs_fsr,
> e4defrag, etc).  "Balance" confused me.
> 
> How do you balance free space when you've got drives of unequal sizes,
> like my (current) case of a 4-drive array consisting of two 16-TB
> drives and two 6-TB drives?

Depends on the RAID profile.  For single, dup, raid1, raid1c3, and raid1c4,
the drives with the most unallocated space are filled first, using devid
to break ties.  For raid0, raid5, and raid6, drives with free space are
filled equally.  raid10 fills disks in even-numbered groups of 4 or more
drives at a time, filling disks with the most unallocated space first.
There are some other rules (e.g. at most 10 disks are used in a single
block group) but they're not relevant at this scale.

raid1 and single profiles would fill the 16TB drives first, until there
was only 6 TB remaining.  At this point all the drives would have equal
free space, then all drives fill equally until they are all full.

raid0 and raid5 would fill all the disks at first, until the 6TB drives are
full and the 16TB drives have 10TB of free space, then they'd fill the
16TB drives the rest of the way.

raid1c3, raid1c4, raid6 and raid10 would fill all the drives at first,
then stop with ENOSPC when the 6TB disks are full and the 16TB disks
have 10TB of free space.  These profiles have a minimum of 3 or more
disks, and you don't have that number of the largest size disks.
Once all the smaller disks are full no further allocation can be done.

> Phil
