Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51671C2373
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgEBGAl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 2 May 2020 02:00:41 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42506 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgEBGAl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 02:00:41 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0DA6A69FB61; Sat,  2 May 2020 02:00:38 -0400 (EDT)
Date:   Sat, 2 May 2020 02:00:38 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Phil Karn <karn@ka9q.net>, Jean-Denis Girard <jd.girard@sysnux.pf>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200502060038.GK10769@hungrycats.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 02, 2020 at 04:48:42AM +0000, Paul Jones wrote:
> > -----Original Message-----
> > From: linux-btrfs-owner@vger.kernel.org <linux-btrfs-
> > owner@vger.kernel.org> On Behalf Of Zygo Blaxell
> > Sent: Saturday, 2 May 2020 1:35 PM
> > To: Phil Karn <karn@ka9q.net>
> > Cc: Jean-Denis Girard <jd.girard@sysnux.pf>; linux-btrfs@vger.kernel.org
> > Subject: Re: Extremely slow device removals
> > 
> > On Fri, May 01, 2020 at 01:05:20AM -0700, Phil Karn wrote:
> > > On 4/30/20 11:13, Jean-Denis Girard wrote:
> > > >
> > > > Hi Phil,
> > > >
> > > > I did something similar one month ago. It took less than 4 hours for
> > > > 1.71 TiB of data:
> > > >
> > > > [xxx@taina ~]$ sudo btrfs replace status /home/SysNux Started on
> > > > 21.Mar 11:13:20, finished on 21.Mar 15:06:33, 0 write errs, 0
> > > > uncorr. read errs
> > >
> > > I just realized you did a *replace* rather than a *remove*. When I did
> > > a replace on another drive, it also went much faster. It must copy the
> > > data from the old drive to the new one in larger and/or more
> > > contiguous chunks. It's only the remove operation that's painfully slow.
> > 
> > "Replace" is a modified form of scrub which assumes that you want to
> > reconstruct an entire drive instead of verifying an existing one.
> > It reads and writes all the blocks roughly in physical disk order, and doesn't
> > need to update any metadata since it's not changing any of the data as it
> > passes through.
> > 
> > "Delete" is resize to 0 followed by remove the empty device.  Resize requires
> > relocating all data onto other disks--or other locations on the same disk--one
> > extent at a time, and updating all of the reference pointers in the filesystem.
> > 
> > The difference in speed can be several orders of magnitude.
> 
> Delete seems to work like a balance. I've had a totally unbalanced
> raid 1 array and after removing a single almost full drive all the
> remaining drives are magically 50% full, down from 90% and up from
> 10%. It's a bit stressful when there is a missing disk as you can only
> delete a missing disk, not replace it.

Huh?  Replacing missing disks is what btrfs replace is _for_.

> It would be nice if BTRFS had some more smarts so it knows when to "balance" data, and when to simply "move/copy" a single copy of data. 
> 
> 
> Paul.
