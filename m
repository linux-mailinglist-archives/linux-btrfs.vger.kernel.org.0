Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAA3301733
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 18:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhAWR23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 12:28:29 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37488 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAWR21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 12:28:27 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DD0EB9514BA; Sat, 23 Jan 2021 12:27:43 -0500 (EST)
Date:   Sat, 23 Jan 2021 12:27:43 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     =?iso-8859-1?Q?H=E9rikz?= Nawarro <herikz.nawarro@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Recover data from damage disk in "array"
Message-ID: <20210123172743.GP31381@hungrycats.org>
References: <CAD6NJSxNmWQ42HrC5oUyZtS+MgEn7b=kmV46qx40x9=v6SMwAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD6NJSxNmWQ42HrC5oUyZtS+MgEn7b=kmV46qx40x9=v6SMwAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 18, 2021 at 09:00:58PM -0300, Hérikz Nawarro wrote:
> Hello everyone,
> 
> I got an array of 4 disks with btrfs configured with data single and
> metadata dup

OK, that's weird.  Multiple disks should always have metadata in a raid1*
profile (raid1, raid10, raid1c3, or raid1c4).  dup metadata on multiple
disks, especially spinners, is going to be slow and brittle with no
upside.

> , one disk of this array was plugged with a bad sata cable
> that broke the plastic part of the data port (the pins still intact),
> i still can read the disk with an adapter, but there's a way to
> "isolate" this disk, recover all data and later replace the fault disk
> in the array with a new one?

There's no redundancy in this array, so you will have to keep the broken
disk online (or the filesystem unmounted) until a solution is implemented.

I wouldn't advise running with a broken connector at all, especially
without raid1 metadata.

Ideally, boot from rescue media, copy the broken device to a replacement
disk with dd, then remove the broken disk and mount the filesystem with
4 healthy disks.

If you try to operate with a broken connector, you could get disconnects
and lost writes.  With dup metadata there is no redundancy across
drives, so a lost metadata write on a single disk is a fatal error.
That will be a stress-test for btrfs's lost write detection, and even
if it works, it will force the filesystem read-only whenever it occurs
in a metadata write.  In the worst case, the disconnection resets the
drive and prevents its write cache from working properly, so a write is
lost in metadata, and the filesystem is unrecoverably damaged.

There are other ways to do this, but they take longer, in some cases
orders of magnitude longer (and therefore higher risk):

1.  convert the metadata to raid1, starting with the faulty drive
(in these examples I'm just going to call it device 3, use the
correct device ID for your array):

	# Remove metadata from broken device first
	btrfs balance start -mdevid=3,convert=raid1,soft /array

	# Continue converting all other metadata in the array:
	btrfs balance start -mconvert=raid1,soft /array

After metadata is converted to raid1, an intermittent drive connection is
a much more recoverable problem, and you can replace the broken disk at
your leisure.  You'll get csum and IO errors when the drive disconnects,
but these errors will not be fatal to the filesystem as a whole because
the metadata will be safely written on other devices.

2.  convert the metadata to raid1 as in option 1, then delete the missing
device.  This is by far the slowest option, and only works if you have
sufficient space on the other drives for the new data.

3.  convert the metadata to raid1 as in option 1, add more disks so that
there is enough space for the device delete in option 2, then proceed
with the device delete in option 2.  This is probably worse than option
2 in terms of potential failure modes, but I put it here for completeness.

4.  when the replacement disk arrives, run 'btrfs replace' from the broken
disk to the new disk, then convert the metadata to raid1 as in option 1
so you're not using dup metadata any more.  This is as fast as the 'dd'
solution, but there is a slightly higher risk as the broken disk might
disconnect during a write and abort the replace operation.

> Cheers,
