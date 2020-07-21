Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7A228A5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 23:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgGUVJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgGUVJ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 17:09:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9ECC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 14:09:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w3so4216247wmi.4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhfXzMdPJeeqJGAGP+OqZZzTBxe/VXn+tLAEwuMDxD0=;
        b=ca+kb6AS7EmMGJhM54maC7h5oN/WJDrEdDFJcmlkqgKmeig+xggbrggfGsZEB6hgmb
         1ipAGC6DAGIJ/XyTvbBs05R/ZQlN78okCNk0n+RJeFPSWtgnD2809Ge2YU4c2x4AhC63
         bccPkEaz96dpvnUILUzDpQIrjfrAK0SDudt+rgMJqP+DEFyb7RfaXOlBmBtdNAKx5JKR
         4R7/UvHCDpR3x4OAAML4kuQ9Z7TEoeKaniy3Mp42jeZJ4s5uPOAoqEnq5dJDyeLd0LLP
         eP2a1frVugKpkWgh3GIjtik2JOaYCvN4KaTTOQuhs8pCewqNs0/wkbu583ac8UockIIS
         3VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhfXzMdPJeeqJGAGP+OqZZzTBxe/VXn+tLAEwuMDxD0=;
        b=etxmwCHbE39CeguKjUVyOcvw9voHKD2XPodhjER+4gBoXsaft7aXn37XYvy306WkGP
         n9wdEOod4WK66lKDv7tIZZpkAJHejW70cnctokPzQR2svSar/woh2hIKaNHEvRYPJDKi
         TzGVRqObH39sQ9oKRhKVxcVg/I89VbtW3PICoHBaSkb9ghqNsWvWj7ZTqj+7yoL7ZWLB
         QKKtWNhnyYhLIvlzKrW49oCk4zrwLWrzqRxGKtaY8aysIaaP1a+QGs7TZTRCeIOsuwNc
         bGXxn1pTeXZjES41PeZZr/fgfXBE2NZ8BqZLvUNPiHcNwXLQ1MCVrQN5kLyjGLyMcbFJ
         bAQQ==
X-Gm-Message-State: AOAM532cmsnmDY8IgZjEysjo7tL6udR0+5OuBLr7b1yQtiMjWuUF7yyh
        d0Pq5wdRhjGT6cHSOVbq+8XKTQJPp8XgtuPVZ1YcA0ZH
X-Google-Smtp-Source: ABdhPJyusctAkofEDMMKbnHBcPmcfKamjqVo9wxi9RcslkaafRsBmCTvP8CS1yFmbj82UIK0Cl3bFH16dYhIp6gmAfc=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr1268507wmh.11.1595365764532;
 Tue, 21 Jul 2020 14:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200721203340.275921-1-kreijack@libero.it>
In-Reply-To: <20200721203340.275921-1-kreijack@libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Jul 2020 15:09:07 -0600
Message-ID: <CAJCQCtSqvxhah8ub=N=17dAKoyYxNZWpQJ817ijw0NsgCpyBoQ@mail.gmail.com>
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 2:33 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
>
> Hi all,
>
> this is an RFC to discuss a my idea to allow a simple rollback of the
> root filesystem at boot time.
>
> The problem that I want to solve is the following: DPKG is very slow on
> a BTRFS filesystem. The reason is that DPKG massively uses
> sync()/fsync() to guarantee that the filesystem is always coherent even
> in case of sudden shutdown.
>
> The same can be useful even to the RPM Linux based distribution (which however
> suffer less than DPKG).
>
> A way to avoid the sync()/fsync() calls without loosing the DPKG
> guarantees, is:
> 1) perform a snapshot of the root filesystem (the rollback one)
> 2) upgrade the filesystem without using sync/fsync
> 3) final (global) sync
> 4) destroy the rollback snapshot
>
> If an unclean shutdown happens between 1) and 4), two subvolume exists:
> the 'main' one and the 'rollback' one (which is the snapshot before the
> update). In this case the system at boot time should mount the "rollback"
> subvolume instead of the "main" one. Otherwise in case of a "clean" boot, the
> "rollback" subvolume doesn't exist and only the "main" one can be
> mounted.
>
> In [1] I discussed a way to implement the steps 1 to 4. (ok, I missed
> the point 3) ).
>
> The part that was missed until now, is an automatic way to mount the rollback
> subvolume at boot time when it is present.
>
> My idea is to allow more 'subvol=' option. In this case BTRFS tries all the
> passed subvolumes until the first succeed. So invoking the kernel as:
>
>   linux root=UUID=xxxx rootflags=subvol=rollback,subvol=main ro
>
> First, the kernel tries to mount the 'rollback' subvolume. If the rollback
> subvolume doesn't exist then it mounts the 'main' subvolume.
>
> Of course after the mount, the system should perform a cleanup of the
> subvolumes: i.e. if a rollback subvolume exists, the system should destroy
> the "main" one (which contains garbage) and rename "rollback" to "main".
> To be more precise:
>
>         if test -d "rollback"; then
>                 if test -d "old"; then
>                         btrfs sub del "old"
>                 fi
>                 if test -d "main"; then
>                         mv "main" "old"
>                 fi
>                 mv "rollback" "main"
>                 btrfs sub del "old"
>         fi
>
> Comments are welcome
> BR
> G.Baroncelli
>
> [1] http://lore.kernel.org/linux-btrfs/69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it/
>
> P.S.
> I am guessing if an idea like this can be applied to a file. E.g. a sqlite
> database that instead of reling to sync/fsync, creates a reflink file as
> "rollback" if something goes wrong.... The ordering is preserved. Not the
> duration.

One way:
btrfs sub snap main rollback
change bootloader rootflags=subvol=rollback and /etc/fstab (or use
btrfs sub set-default)
do the update to main
- if it blows up at anytime, rollback is what's used, delete main and
rename rollback to main
- if it succeeds, revert the bootloader changes so main boots, but
keep rollback in case booting main fails

Another way:
btrfs sub snap main update
lock the /var /etc /boot for main from changes: no configuration
changes, no package changes, but user can keep working on user space
things
use bwrap/nspawn/podman to load up and assemble the update tree and
perform the update out of band
- if update blows up, just delete the update snapshot, and then unlock
the system from disallowed changes
- if update succeeds, main can be renamed mainold and update can be
renamed main, update bootloader stuff; everything still stays locked
and the user can keep working on user space things until they're ready
to reboot; nice thing about containers is you can apply cgroupsv2
controls to make sure the update has no resource control impact on the
user's current work

Personally I prefer the latter, doing the update out of band rather
than applying the update either on a running sysroot or having to do
an offline (reboot to a minimal environment) update. I think locking
the user out of system changes is acceptable for such an out of band
update. The alternative is something like the merge of /etc /var
things that have changed during the time the update was initiated - I
think it's not worth that complexity but if someone wants to build
that, OK.


-- 
Chris Murphy
