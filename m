Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8226769C
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 01:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgIKXuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 19:50:55 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36846 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKXux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 19:50:53 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DFBCB7FC029; Fri, 11 Sep 2020 19:50:51 -0400 (EDT)
Date:   Fri, 11 Sep 2020 19:50:51 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Zhang Boyang <zhangboyang.id@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Not all deduped disk space freed?
Message-ID: <20200911235051.GF5890@hungrycats.org>
References: <66ea94f5-ba6b-da68-7d6b-c422b66f058d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ea94f5-ba6b-da68-7d6b-c422b66f058d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 12, 2020 at 01:51:12AM +0800, Zhang Boyang wrote:
> Hello all,
> 
> The background was I developed a btrfs deduplication tool recently, which
> was opensourced at github.com/zhangboyang/simplededup
> 
> The dedup algorithm is very simple: hash & find dupe blocks (4K) and
> ioctl(FIDEDUPERANGE) to eliminate them.

btrfs counts references to extents, not to blocks, and btrfs extents
are immutable (i.e. there is no support for splitting an extent in-place).
It is critical to understand these two points before designing a dedupe
tool for btrfs.

In order to recover any space, all of the blocks in the target extent
must be eliminated, even if they contain unique data.  btrfs will not
do this for you.  It will only remove the exact portion of the extent
reference(s) you supply in the ioctl arguments.  It is up to the dedupe
application to provide a solution that eliminates all references to any
block in the target extent.  The kernel will verify and implement it.

If a target extent contains both unique and duplicate data, any unique
data left over in the extent must be relocated (copied) to a new extent
so that the target extent can be completely replaced by dedupe operations.
If any block of the target extent remains referenced, the entire target
extent will remain on disk.

bees recovers about 50% of the potential space by making necessary data
copies.  (OK, it's more accurate to say bees recovers 90% of the potential
space, then wastes about 40% of what it gained by making poor choices
about which extent in a duplicate pair to keep and getting confused by
its own temporary data).

duperemove can (with some combinations of options) perform a partial
extent map, then only match extent pairs with the same size.  An extent
that contains a mix of duplicate and unique blocks is therefore not
deduped at all, because the entire extent would be unique.  This runs
quickly since it's not wasting iops on dedupe calls that will have no
effect, but it doesn't recover very much space.

Other dedupers work only at the file level, which is a valid solution
in many cases.  Since deduping an entire file necessarily removes the
entire file's extent references, it usually removes the target file's
extents too.  Exceptions would be files that have snapshots, reflinks,
or other dedupe applied to them--those parts of the file that were still
referenced from elsewhere would remain on disk.  A file-level deduper
is the least effective at freeing space, but it requires the least
examination of the filesystem structure to operate efficiently.

Deduping with a very large block size has a similar effect to deduping
entire files.  The larger the dedupe block size, the greater the
probability that two random matching dedupe blocks will cover an entire
random target extent.

> However, after I run my tool, I found not all deduped blocks turned into
> free space, and `btrfs fi du' [Exclusive+Set shared] != `btrfs fi usage'
> [Used], as below: 2932206698496+945128120320 is far lower than 4119389741056
> 
> 
> root@athlon:/media/datahdd# btrfs fi du --raw -s /media/datahdd
>      Total   Exclusive  Set shared  Filename
> 4369431683072  2932206698496  945128120320  /media/datahdd
> 
> root@athlon:/media/datahdd# btrfs fi usage --raw  /media/datahdd
> Overall:
>     Device size:             8999528280064
>     Device allocated:             4144710549504
>     Device unallocated:             4854817730560
>     Device missing:                         0
>     Used:                 4138705166336
>     Free (estimated):             4856449110016    (min: 2429040244736)
>     Data ratio:                          1.00
>     Metadata ratio:                      2.00
>     Global reserve:                  75546624    (used: 0)
> 
> Data,single: Size:4121021120512, Used:4119389741056 (99.96%)
>    /dev/sdc1    2559800508416
>    /dev/sdb1    1561220612096
> 
> Metadata,RAID1: Size:11811160064, Used:9657270272 (81.76%)
>    /dev/sdc1    11811160064
>    /dev/sdb1    11811160064
> 
> System,RAID1: Size:33554432, Used:442368 (1.32%)
>    /dev/sdc1      33554432
>    /dev/sdb1      33554432
> 
> Unallocated:
>    /dev/sdc1    2429196152832
>    /dev/sdb1    2425621577728
> root@athlon:/media/datahdd#
> 
> 
> That's quite strange. Is this an expected behaviour?
> 
> Thank you all!
> 
> 
> ZBY
> 
