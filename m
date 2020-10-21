Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03718294DD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441924AbgJUNqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 09:46:38 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33906 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441890AbgJUNqi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 09:46:38 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EBCE1866E70; Wed, 21 Oct 2020 09:46:35 -0400 (EDT)
Date:   Wed, 21 Oct 2020 09:46:35 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed: Fixed but re-appearing
Message-ID: <20201021134635.GT5890@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 09:04:36AM +0000, Hendrik Friedel wrote:
> Hello,
> 
> I have a re-occuring issue with my btrfs volume.
> I am using dduper (https://github.com/Lakshmipathi/dduper/issues/39).
> When running it, I get:
> parent transid verify failed on 9332119748608 wanted 204976 found 204978
> (reproducable when running the same dduper command)

Were there any other symptoms?  IO errors?  Inaccessible files?  Filesystem
remounted read-only?

> I cured that by unmounting and
>   mount -t btrfs -o nospace_cache,clear_cache /dev/sda1 /mnt/test

That command normally won't cure a parent transid verify failure if it
has been persisted on disk.  The only command that can fix ptvf is 'btrfs
check --repair --init-extent-tree', i.e. a full rebuild of btrfs metadata.

> After that, I was able to run that dduper command without a failure.
> But some days later, the same command resulted in:
>   parent transid verify failed on 16465691033600 wanted 352083 found 352085
> 
> again.
> 
> A scrub showed no error
>  btrfs scrub status /dev/sda1
> scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>         scrub started at Mon Oct 19 21:07:13 2020 and finished after
> 15:11:10
>         total bytes scrubbed: 6.56TiB with 0 errors

Scrub iterates over all metadata pages and should hit ptvf if it's
on disk.

> Filesystem info:
>  btrfs fi show /dev/sda1
> Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>         Total devices 2 FS bytes used 6.56TiB
>         devid    1 size 7.28TiB used 6.75TiB path /dev/sda1
>         devid    2 size 7.28TiB used 6.75TiB path /dev/sdj1

If you have raid1 metadata (see 'btrfs fi usage') then it's possible
only one of your disks is silently dropping writes.  In that case
btrfs will recover from ptvf by replacing the missing block from the
other drive.  But there are no scrub errors or kernel messages related
to this, so there aren't any symptoms of that happening, so it seems
these ptvf are not coming from the disk.

> The system has a USV. Consequently, it should not experience any power
> interruptions during writes.
> 
> I did not find any indications of it in /var/log/*
> (grep  -i btrfs /var/log/* | grep -v snapper |grep sda)
> 
> What could be the reason for this re-appearing issue?

What kernel are you running?  Until early 2020 there was a UAF bug in tree
mod log code that could occasionally spit out harmless ptvf messages and
a few other verification messages like "bad tree block start" because
it was essentially verifying garbage from kernel RAM.  This happens a
lot while running LOGICAL_INO ioctl calls, but can also happen during
any long-running metadata write operations, including dedupe.

My original bug report was:

	https://www.spinics.net/lists/linux-btrfs/msg87425.html

This was ultimately fixed by several commits.  These are the four "tree
mod log" issues listed at:

	https://github.com/Zygo/bees/blob/master/docs/btrfs-kernel.md

Kernels after 5.4.19, 5.5.3, 5.6 and later should be OK.  4.19.103 has
3 of the 4 fixes so it should happen much less often there.

> Regards,
> Hendrik
> 
