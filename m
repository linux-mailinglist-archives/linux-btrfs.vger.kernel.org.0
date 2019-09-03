Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E34A5FC3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 05:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfICDbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 23:31:06 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33645 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfICDbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Sep 2019 23:31:06 -0400
Received: by mail-wm1-f51.google.com with SMTP id r17so13240022wme.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2019 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Cn0pdEh9PBV+j6oezVwXEGBTWC5tiFmFJ8iM06ltkrE=;
        b=SDNRDOheQyi4UofmRdMulXvFfLwwBFOzauh5NF9OHX+DYd5JhLMyaI4qwXpJCIMiE2
         ZWO4WUgthe7GiESuTlUG9pCKq8sEhwBv/QglqfFTMAyjK1Acw9rVFpj0ch+ugVexDSEv
         kx+v9K30BbRyqKdtSWe7Q6KO2qSR19mK2yzWg4UXJOL4eEBQb3kQ3IXHlccJkZowlNPw
         QZZ8Cpc+WfkGx17YXnHw7hjm+IZSsQFZbhewJaI+Y/c/NYLXz0znxfFmS3+0Z4prkQQY
         gDMYALx6xYfn1dkYJiDhZOi+GccbEDuv+GW09lGMBfdNOrpEMVmQSJFX64l/xi8o5MaB
         lOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Cn0pdEh9PBV+j6oezVwXEGBTWC5tiFmFJ8iM06ltkrE=;
        b=mgoK64hnsVLRQNob76tSP/wjLCcuAUBO4v4L1qmaEd1h9gMYx4s/8/SU63NADORUFq
         hOiyOXBetIqTt/x3G6QjJZJVAIxHlRw8w0LXHF6u4sPzFxLqlb7Wlt/2+FD/tYHMgCUk
         QtnYoza5DeLtEUxFJTK4Sbs+nAz0AJqMbI2bd6jQI+A1NU5UNExwgFv4+R6ZU5bvGvtp
         9dbRZIZaOEOAdDuyopeGakdG/soNOIfUM7QJleZSt7zMDOc0siR70Olnh4FrJ1mvw5fH
         pukdz5s822EzSBK/98U/NCLJjzJPGXdTAcJgqlWA8RtZzOtJONELTS0Hihp0hGMwbqqW
         cDQw==
X-Gm-Message-State: APjAAAVGb7/1fVAtYpTEDBkCWaYc5y0khrT26XzjgT8xIEOtU20ICYyS
        KL9d8dK7RjrwW6aPQdUZwEXuO9vJomXdLn7NmE3MSKaaBmg=
X-Google-Smtp-Source: APXvYqzk5UIW1VIpZ4VMy18GzYyhfCrlAvOal4S1O4tes6cRUJHBJHvXy7Z9dx79D8O4WZ43lEDyQnBDbfgiScfcgtY=
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr22702735wmj.106.1567481463151;
 Mon, 02 Sep 2019 20:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>
In-Reply-To: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 2 Sep 2019 21:30:51 -0600
Message-ID: <CAJCQCtR=6nw9Oin8b7ELfz41yPadFwwqFQQT_4pc36ykVTbmEw@mail.gmail.com>
Subject: Re: BTRFS state on kernel 5.2
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 2, 2019 at 11:21 AM waxhead <waxhead@dirtcellar.net> wrote:
> 2. DEFRAG: (status page)
> The status page marks defrag as "mostly ok" for stability and "ok" for
> performance. While I understand that extents gets unshared I don't see
> how this will affect stability. Performance (as in space efficiency) on
> the other hand is more likely to be affected. Also is is not (perfectly)
> clear what the difference is in consequence by using the autodefrag
> mount option vs "btrfs filesystem defrag" Can someone please consider
> rewriting this?

It needs "OK - see Gotchas" because shared extents becoming unshared
could be hugely problematic if you're not expecting it.

> 3. SCRUB + RAID56: (status page)
> The status page says it is mostly ok for both stability and performance.
> It is not stated what the problem is with stability, does this have to
> do with the write-hole ?

I think concerns need to be split out for metadata and data. The main
gotcha is if there's a crash you need to do a scrub, and there are no
partial scrubs.

In the case of data, at least there's still a warning on bad
reconstruction (from corrupt strip), because of data csums not
matching.


> 5. DEVICE REPLACE: (Using_Btrfs_with_Multiple_Devices page)
> It is not clear what to do to recover from a device failure on BTRFS.
> If a device is partly working then you can run the replace functionality
> and hopefully you're good to go afterwards. Ok fine , if this however
> does not work or you have a completely failed device it is a different
> story. My understanding of it is:
> If not enough free space (or devices) is available to restore redundancy
> you first need to add a new device, and then you need to A: first run
> metadata balance (to ensure that the filesystem structures is redundant)
> and then B: run a data balance to restore redundancy for your data.
> Is there any filters that can be applied to only restore chunks which
> are having a missing mirror / stripe member?

It is a bit boolean in that it depends on several variables, and is
another reason why a btrfsd service to help do smarter things that
depend on policy decisions would be a very useful future addition. But
sorta what you're getting to is we're not sure what the medium, long
term plans are.


>
> 6. RAID56 (status page)
> The RAID56 have had the write hole problem for a long time now, but it
> is not well explained what the consequence of it is for data -
> especially if you have metadata stored in raid1/10.
> If you encounter a powerloss / kernel panic during write - what will
> actually happen?
> Will a fresh file simply be missing or corrupted (as in partly written).
> If you overwrite/append to a existing file - what is the consequence
> then? will you end up with... A: The old data, B: Corrupted or zeroed
> data?! This is not made clear in the comment and it would be great if
> we, the BTRFS users would understand what the risk of hitting the write
> hole actually is.

If you do an immediate scrub, any corruption should be detected and
fixed by reconstruction, before there are any device failures. If a
device fails before scrub, it's possible data is corrupt, but last
time I tested this I got EIO with csum mismatches for affected files,
not corrupt data return to user space.  Worse is if metadata is
affected because nothing can be done, if a device has failed, and
there's corruption in raid5 metadata.

I'm not entirely clear on the COW guarantees between metadata and
data, even in the idealized case where hardware doesn't lie, does what
the file system expects, and all devices complete commits at the same
time. And then when any of those things isn't true, what are the
consequences. It's probably its own separate grid that's needed. But
if someone understood it clearly, someone else could make the
explanation pretty.


> 7. QUOTAS, QGROUPS (status page)
> Again marked as "mostly ok" on the stability. Is there any risk of
> dataloss or irrecoverable failure? If not I think it should be marked as
> stable - The only note seems to be performance related.

Pretty sure all the performance issues are supposed to be fixed by
kernel 5.2 or 5.3. But that probably needs testing to confirm it.

>
> 8. PER SUBVOLUME REDUNDANCY LEVEL:
> What is the state / plan for per subvolume (or object level) redundancy
> levels - is that on the agenda somewhere?

No one has started that work as far as I'm aware.

>
> 9. ADDING EXISTING FILESYSTEM TO THE POOL?:
> Is it somehow, or will it ever be possible to add a existing BTRFS
> filesystem to a pool?

I haven't hear anything like this, so I suspect no one is working on
it. Btrfs subvolumes are just a files tree. It's not a self contained
file system. All subvolumes share the extent, csum, chunk and dev
trees. So this would need some way to import it. Not sure.

> 10. PURE BTRFS BOOTLOADER?
> This probably belongs somewhere else, but has someone considered the
> very idea of a pure BTRFS bootloader which only supports booting up a
> BTRFS filesystem in a (as failsafe as possible) way. It is a pain to
> ensure that grub is installed on all devices and update as you
> add/remove devices from the pool and a "butterboot"-loader would be
> fantastic

Bootloaders are f'n hard. I don't see the advantage of starting
something from scratch that's this narrow purposed.

Realistically, as ugly as it is, we're better off with every drive
having a large EFI system partition or plain boot volume if BIOS, and
a daemon that keeps them all in sync. And use a simple bootloader like
sd-boot, to locate, load, and execute the kernel and let kernel code
worry about all the complex Btrfs device discovery, and how to handle
degradedness.

By the way, GRUB 2.04 should have Btrfs raid5/6 support. And I'm
guessing it supports degraded operation similar to mdadm raid 5/6,
which GRUB supports for a long time.

> 12. SPACE CACHE: (Manpage/btrfs(5) page):
> I have been using space cache v2 for a long time. No issues (that I know
> about) yet. That page states that the safe default space cache is v1.
> What is the current recommended default?

v2 expected default for a long time now. It'd be useful if someone
could benchmark v2 versus no space cache: run time performance with
various loads, mount time, and memory usage.

> 13. NODATACOW:
> As far as I can remember there was some issues regarding NOCOW
> files/directories on the mailing list a while ago. I can't find any
> issues related to nocow on the wiki (I might note have searched enough)
> but I don't think they are fixed so maybe someone can verify that.
> And by the way ...are NOCOW files still not checksummed? If yes, are
> there plans to add that (it would be especially nice to know if a nocow
> file is correct or not)

I think we're better off optimizing COW and getting rid of nocow. It's
really a work around for things becoming slow due to massive
fragmentation. There's a bug (or unexpected behavior) where NOCOW
files can become compressed when defragmented and compress mount
option is used. There's a fix that prevents this, I think in 5.2 or
5.3.


-- 
Chris Murphy
