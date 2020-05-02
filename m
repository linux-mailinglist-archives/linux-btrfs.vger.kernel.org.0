Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6863F1C23E6
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEBHmk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 2 May 2020 03:42:40 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38014 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgEBHmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 03:42:39 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0608D69FD4C; Sat,  2 May 2020 03:42:37 -0400 (EDT)
Date:   Sat, 2 May 2020 03:42:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200502074237.GM10769@hungrycats.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org>
 <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 02, 2020 at 12:20:42AM -0700, Phil Karn wrote:
> So I'm trying to figure out the advantage of including RAID 1 inside
> btrfs instead of just running it over a conventional (fs-agnostic)
> RAID subsystem.
> 
> I was originally really intrigued by the idea of integrating RAID into
> the file system since it seemed like you could do more that way, or at
> least do things more efficiently. For example, when adding or
> replacing a mirror you'd only have to copy those parts of the disk
> that actually contain data. That promised better performance. But if
> those actually-used blocks are copied in small pieces and in random
> order so the operation is far slower than the logical equivalent of
> "dd if=disk1 of=disk2', 

If you use btrfs replace to move data between drives then you get all
the advantages you describe.  Don't do 'device remove' if you can possibly
avoid it.

Array reshapes in btrfs are currently slower than they need to be, but
there's no on-disk-format reason why they can't be as fast as replace
in many cases.

> then what's left?

If there's data corruption on one disk, btrfs can detect it and replace
the lost data from the good copy.  Most block-level raid1's have a 50%
chance of corrupting the good copy with the bad one, and can only report
corruption as a difference in content between the drives (i.e. you have
to guess which is correct), if they bother to report corruption at all.

This allows you to take advantage of diverse redundant storage (e.g.
raid1 pairs composed of disks made by different vendors).  In btrfs
raid1, heterogeonous drive firmware maximizes the chance of having one
bug-free firmware, and scrub will tell you exactly which drive is bad.
In other raid1 implementations, a heterogeneous raid1 pair maximizes the
chance of one firmware in the array having a bug that corrupts the data
on the good drives, and doesn't tell you which drive is bad.

btrfs does not rely on lower level hardware for error detection, so you
can use cheap SSDs and SD cards that have no firmware capability to detect
or report the flash equivalent of UNC sectors as btrfs raid1 members.
I usually can squeeze about six months of extra life out of some very
substandard storage hardware with btrfs.

> Even the ability to use drives of different sizes isn't unique to
> btrfs. You can use LVM to concatenate smaller volumes into larger
> logical ones.
> 
> Phil
