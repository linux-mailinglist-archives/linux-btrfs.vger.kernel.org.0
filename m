Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B442D7764
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 15:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394888AbgLKOD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 09:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405381AbgLKODK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 09:03:10 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE00C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 06:02:30 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s11so10998328ljp.4
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0ZMCnj7mmuLTmuUGjVMsVTwlLDhU+txRna+qcVJDHbM=;
        b=dtERAuk65Afo+pgFPWw0nb40N8zVkxVp20jrBn6BFONEPgXOu++apY8Qy1tTPvwuHf
         xgRIosckclYw7oJcpY1gF2rMb+rnX1tueGUtFUbwkROTRGwzs+EGj1dUvP6n0ejoH1gG
         njDhogO+1lkW16DRyMNPaICrn0i+Xamjrp8Za+ymdYYqEH8iTCCqleSQrI2OmZojCOZI
         e4iwrSHa9LlFkZUsJCYK3EcncxZYuDACB49WM5f4xnO1nvUQKKb0UM1F8ZYT3hjAcQUC
         LHzz1qb5nhruG9k0RHoFSPt0s9C4HE0EJid+RvlWteOrdU77QlodwPf1PPb1HI5KQCZE
         ePxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0ZMCnj7mmuLTmuUGjVMsVTwlLDhU+txRna+qcVJDHbM=;
        b=sEAH7vp2ao/qHKl+8jV+Hb2ydn35GSfEkuKw+2w8C4LNODaWOB8PkMFvzkxlyUl+jv
         t3dWGyOZAvH9IWGFxhosVXXPGr/qwCg4D7IGCMLXMzZ+NkiXWzPjgJAKEzVTnkAQLFn3
         ROMqwyAFXT3UGVG29Izb8uCFX3OG47eRtX9c921E8NtAx8/M8h+ityhw4DLjwx7FO4vK
         Pm2uF4eTZCUP4IPU0tj+kS/QZ+hncCaqCNssvWEURZCYWrAGM3FgUOeQyZgnR1bkU0od
         OFsqKbo6oNbsYvVLe99BCJ2frLLF2x89Crk8dBxNtYBg++0l1o0H+rC8HkSlJgoFazyu
         SRng==
X-Gm-Message-State: AOAM532GMf6hdQi03IQGQ5rz56LBEK388hlcn8KPZB+QyH0wMs2DVDxH
        TSl8wLI+crJ7ogSu57PYq1b6W478XdiGsBWJef8MmrDx3UpXvQ==
X-Google-Smtp-Source: ABdhPJwImkF1Mq+qOYMb6n2JZoOZ1E4NbNrc5PHDUfKZ6edjEaZKTquXtaxDcM0H98BmoZuSsSG6+0OyPOMpNFV6pC4=
X-Received: by 2002:a05:651c:3db:: with SMTP id f27mr5216424ljp.494.1607695347119;
 Fri, 11 Dec 2020 06:02:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
 <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com>
In-Reply-To: <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com>
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Fri, 11 Dec 2020 19:32:15 +0530
Message-ID: <CAMaziXtPXvKS=FETe1pU7YecY8Tsxdf5k1Auretd0bFn6mLOag@mail.gmail.com>
Subject: Re: btrfs swapfile - Not enough swap space for hibernation.
To:     Chris Murphy <lists@colorremedies.com>,
        Community support for Fedora users 
        <users@lists.fedoraproject.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 12:32 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> If the journal doesn't have more information about why it says this,
> and if the error is reported in the journal by systemd-logind, enable
> debug logging for logind and reproduce and the try to figure out why
> logind is complaining:
>
> https://github.com/systemd/systemd/issues/15354#issuecomment-610385478
>

Yes.

I have finally found out the reason why logind is complaining, thanks to you.

Dec 11 18:45:05 localhost.HPNotebook systemd-logind[1222]: Failed to
open swap file /var/swap/fedora.swap to determine on-disk offset:
Permission denied
Dec 11 18:45:05 localhost.HPNotebook systemd-logind[1222]: Sent
message type=method_return sender=n/a destination=:1.57 path=n/a
interface=n/a member=n/a cookie=130 reply_cookie=49 signature=s
error-name=n/a error-message=n/a
Dec 11 18:45:05 localhost.HPNotebook systemd-logind[1222]: Got message
type=method_call sender=:1.57 destination=org.freedesktop.login1
path=/org/freedesktop/login1 interface=org.freedesktop.login1.Manager
member=CanHybridSleep cookie=50 reply_cookie=0 signature=n/a
error-name=n/a error-message=n/a
Dec 11 18:45:05 localhost.HPNotebook systemd-logind[1222]: Sleep mode
"disk" is supported by the kernel.
Dec 11 18:45:05 localhost.HPNotebook systemd-logind[1222]: /dev/zram0:
ignoring zram swap


My permissions are as follows:

Permissions of /var/swap directory:
drwxr-xr-x. 1 root root   22 Dec 11 15:06 swap

Permissions of the actual swap file:
-rw-------. 1 root root 9663676416 Dec 11 15:09 fedora.swap

Permissions of the swap subvolume:
drwxr-xr-x. 1 root root   22 Dec 11 15:06 swap

Mount options:
UUID=7d9dbe1b-dea6-4141-807b-026325123ad8 /var/swap
   btrfs   subvol=swap,rw,noattime,nosuid,x-systemd.device-timeout=0 0
0
/var/swap/fedora.swap none swap
defaults,x-systemd.requires-mounts-for=/var/swap 0 2

Output of /proc/swaps:
Filename Type Size Used Priority
/dev/zram0                              partition 4020220 0 100
/var/swap/fedora.swap                   file 9437180 0 -2


The only reason I can fathom is that systemd-logind is unable to
access the directory /var/swap. IIRC, you were the one who suggested I
mount in that directory.

Not blaming you, but the question is what do I do now ?

The bug that you have linked to is about /home not /var.

So where should I keep the swap for logind to access it without any problems ?

> There is a possibility there isn't enough contiguous space in the
> swapfile for the hibernation image. i.e. when you fallocate the
> swapfile, it may be comprised of one or even dozens of separate
> extents and if one of them isn't big enough for hibernation entry then
> it'll always fail.
>
> As far as I'm aware there isn't a way to ask fallocate for a minimum
> extent size. I've sometimes had to fallocate multiple files in a row
> to get a swapfile with few fragments and then delete the rest.
>

I don't think that is possible since the file was created with dd, not
fallocate.
Also the +C attribute was used.

> OK you're confused. You do not need both chattr +C on the file and the
> nodatacow option. You only need one of those. You should realize that
> the nodatacow option applies file system wide. It's non-obvious but
> really only the VFS mount options can apply separately to bind mounts.
> And on Fedora, since subvolumes are mounted to specific mounts points
> and are thus effectively bind mounts behind the scenes, it seems like
> you can apply some mount options to specific subvolumes as if they are
> separate file systems. But that's not what's going on, they're just
> bind mounts. So you can do atime for one mount point, noatime for
> another. And same for ro or rw. Those are VFS options. The Btrfs mount
> options apply file system wide, that includes nodatacow, compress, and
> so on.
>
> Further problem now that you're using nodatacow is that you have a
> bunch of nodatacow files that have been created in the meantime. And
> those do *not* have chattr +C so you have no easy way to find them.
> You'd have to parse 'btrfs inspect-internal dump-tree' for the
> nodatacow flag.
>
> nodatacow files are also no compression and no data checksums. So I'm
> betting this is not what you want.

Yes, I have removed the nodatacow option from my mount in fstab as it
clearly had no effect.
I am now using the +C attribute.

--
Regards,
Sreyan Chakravarty
