Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6DD9A60
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfJPTmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 15:42:38 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35822 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJPTmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 15:42:38 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4A0C14789BA; Wed, 16 Oct 2019 15:42:37 -0400 (EDT)
Date:   Wed, 16 Oct 2019 15:42:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
Message-ID: <20191016194237.GP22121@hungrycats.org>
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 16, 2019 at 05:40:10PM +0200, Edmund Urbani wrote:
> Hello everyone,
> 
> having recovered most of my data from my btrfs RAID-6, I have by now migrated to
> mdadm RAID (with btrfs on top). I am considering switching back to btrfs RAID
> some day, when I feel more confident regarding its maturity.
> 
> I put some thought into the pros and cons of this choice that I would like to share:
> 
> btrfs RAID-5/6:
> 
> - RAID write hole issue still unsolved (assuming
> https://btrfs.wiki.kernel.org/index.php/RAID56 is up-to-date)
> + can detect and fix bit rot
> + flexibility (resizing / reshaping)
> - maturity ? (I had a hard time recovering my data after removal of a drive that
> had developed some bad blocks. That's not what I would expect from a RAID-6
> setup. To be fair I should point out that I was running kernel 4.14 at the time
> and did not do regular scrubbing.)

That only really started working (including data reconstruction after
corruption events) around 4.15 or 4.16.  On later kernels, one can
destroy one byte from every block on two disks in a raid6 array and
still recover everything.  This is a somewhat stronger requirement than
degraded mode with two disks missing, since a pass on this test requires
btrfs to prove every individual block is bad using csums and correct the
data without errors.  With degraded mode btrfs always knows two blocks
are missing, so the pass requirement is weaker.

The one thing that doesn't work yet is turning the system off or reset
while writing, then dropping two disks, then reading all the data without
errors.  If a single write hole event occurs, some data may be lost,
from a few blocks to the entire filesystem, depending on which blocks
are affected.

> btrfs on MD RAID 5/6:
> 
> + options to mitigate RAID write hole

Those options _must_ be used with btrfs, or the exact same write hole
issue will occur.  They must be used with other filesystems too, but
other filesystems will tolerate metadata corruption while btrfs will not.

The write hole issue is caused by the interaction between
committed/uncommitted data boundaries and RAID stripe boundaries--the
boundaries must be respected at every layer, or btrfs CoW data integrity
doesn't work when there are disk failures.  The reason why btrfs
currently fails is because the boundaries at the different layers are
not respected--committed and uncommitted data are mixed up inside single
RAID stripes.  mdadm and btrfs raid6 use _identical_ stripe boundaries
(btrfs raid6 is a simplified copy of mdadm raid6) and write hole causes
the same failures in both configurations if the mdadm mitigations are
not enabled.

> - bitrot can only be detected but not fixed
> + mature and proven RAID implementation (based on personal experience of
> replacing plenty of drives over the years without data loss)

I've replaced enough drives to lose data on everything, including mdadm.
mdadm is more mature and proven than cheap hard disk firmware or
bleeding-edge LVM/device-mapper, but that's a low bar.

> I would be interested in getting your feedback on this comparison. Do you agree
> with my observations? Did I miss anything you would consider important?

Single data dup metadata btrfs on mdadm raid6 + write hole mitigation.
Nothing less for raid6.

If you use single metadata, you have no way to recover the filesystem if
there is bitflip in a metadata block on one of the drives.  So always
use -mdup on a btrfs filesystem on top of one mdadm device regardless
of mdadm raid level.  Use -mraid1 if on two or more mdadm devices.

For raid5 I'd choose btrfs -draid5 -mraid1 over mdadm raid5
sometimes--even with the write hole, I'd expect smaller average data
losses than mdadm raid5 + write hole mitigation due to the way disk
failure modes are distributed.  Bit flips and silent corruption (that
mdadm cannot repair) are much more common than bad sectors (that mdadm
can repair) in some drive model families.

> Regards,
>  Edmund
> 
> 
> 
> 
> 
> -- 
> *Liland IT GmbH*
> 
> 
> Ferlach ● Wien ● München
> Tel: +43 463 220111
> Tel: +49 89 
> 458 15 940
> office@Liland.com
> https://Liland.com <https://Liland.com> 
> 
> 
> 
> Copyright © 2019 Liland IT GmbH 
> 
> Diese Mail enthaelt vertrauliche und/oder 
> rechtlich geschuetzte Informationen. 
> Wenn Sie nicht der richtige Adressat 
> sind oder diese Email irrtuemlich erhalten haben, informieren Sie bitte 
> sofort den Absender und vernichten Sie diese Mail. Das unerlaubte Kopieren 
> sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet. 
> 
> This 
> email may contain confidential and/or privileged information. 
> If you are 
> not the intended recipient (or have received this email in error) please 
> notify the sender immediately and destroy this email. Any unauthorised 
> copying, disclosure or distribution of the material in this email is 
> strictly forbidden.
> 
