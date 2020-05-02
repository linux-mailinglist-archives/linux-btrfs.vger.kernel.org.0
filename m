Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EEF1C23D3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEBHU5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 2 May 2020 03:20:57 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35040 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgEBHU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 03:20:56 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E5EEF69FCB9; Sat,  2 May 2020 03:20:53 -0400 (EDT)
Date:   Sat, 2 May 2020 03:20:53 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Jean-Denis Girard <jd.girard@sysnux.pf>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200502072053.GL10769@hungrycats.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 10:25:44PM -0700, Phil Karn wrote:
> I'm still not sure I understand what "balance" really does. I've run
> it quite a few times, with increasing percentage limits as
> recommended, but my drives never end up with equal amounts of data.
> Maybe that's because I've got an oddball configuration involving
> drives of two different sizes and (temporarily at least) an odd number
> of drives. It *sounds* like it ought to do what you describe, but what
> I read sounds more like an internal defragmentation operation on data
> and metadata storage areas. Is it both?

btrfs balance is mostly used to _free_ space (its other major use case
is to convert raid profiles).  Some raid levels (the mirroring and single
profiles) allocate with the goal of equalizing free space on all drives,
others (the striping profiles) equalize occupied space on all drives.
raid10 does a bit of both. 

If you have a mixed striping and mirroring profile (e.g. raid5 data with
raid1 metadata) then two opposing allocation policies happen at once, and
the space used and free on each disk is determined by the two algorithms
fighting it out.

balance coalesces free space areas into larger contiguous chunks by
reallocating all the existing data as if you had copied the files and
deleted the originals in logical extent order.  Sometimes people call this
"defrag free space" but the use of the word "defrag" can be confusing.

balance is not btrfs defrag.  defrag is concerned with making data extents
contiguous, while balance is concerned with making free space contiguous.

> On Fri, May 1, 2020 at 9:48 PM Paul Jones <paul@pauljones.id.au> wrote:
> 
> > Delete seems to work like a balance. I've had a totally unbalanced
> raid 1 array and after removing a single almost full drive all the
> remaining drives are magically 50% full, down from 90% and up from
> 10%. It's a bit stressful when there is a missing disk as you can only
> delete a missing disk, not replace it.
> > It would be nice if BTRFS had some more smarts so it knows when to
> "balance" data, and when to simply "move/copy" a single copy of data.
> >
> >
> > Paul.
