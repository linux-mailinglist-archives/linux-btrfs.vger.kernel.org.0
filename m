Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98B2EAA96
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbhAEMZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 07:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbhAEMY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 07:24:59 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF911C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jan 2021 04:24:18 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id r17so28352898ilo.11
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jan 2021 04:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R2dWpa6TrrRcd0EmhzN2tQdAIUAAcY1KdZOrvRsRlfE=;
        b=rQYZkPVU0Lv3ZMDBvdTJYYtxzDdQV/So/V/wxHKSR+9N1wRq/bKAxhLpa7d+08urD8
         Lo8B2CcNTUje7ypIPkbZQMLyFV6m2ytAkRCFvbSEMpkvj+9tRRgYaAHFjqTRGRylehr8
         1iFL44BnoghU6RdneHepSnbtW0+1EPmRMzsuGVecLLosZc5Jj6rEQg25MQFyVSglsAeK
         52o0OkAaZYOvcgSk7qsyR9L/DI1ozcFG4UWN8NSFSDLbEuRgTOtO7jjbShdRHMsAqOEp
         xGhd9iKpL8LjVvqBp5cCbOH8vBtWkR3ZUQZTP5d/NeaUg5qh6uZjxfXcDVyaB/hlwKxU
         BhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R2dWpa6TrrRcd0EmhzN2tQdAIUAAcY1KdZOrvRsRlfE=;
        b=RbT/bp2GqY/562gYOTjMZBc2aeEEKnwBCb+8YbnaRgqc1DljpsW7OEROigyk7V8C8K
         ctXWqI6hOgSTxmhV02eJHEtGfn3cWAMtALI8WYlD7Z9qOldcxdJthbconoHxGLZJ0VdO
         omTetFH6jit+QAc73rNy+EWH3gdh7A6hlxHzv2ZvZLi5PBMYbNbRCl6i8X08YShkAZwi
         w1Zx1g9j8jeuhLDNGR3ASk22G2Gbcu1DMA+4TNgGomwLfGVLY6EKps27Mwvd82X0TB9Z
         6I2IkDQQ76ksgYjmOYPfihhEKDMhAnaXazVB0fW+mdohwbP+ahem1bUqTKx2j6nOkttG
         Cuiw==
X-Gm-Message-State: AOAM532dsqHc4p9reJ8ko7/e4mPafpwoXVK/z2udXUxnqaQbGp2UhLmO
        7OKA0pGInzjFob1ZX+hHAP2sCXrAGnonJx8l14cRhbPU0nwVajhI
X-Google-Smtp-Source: ABdhPJy7AraLWGHuNIgRBDU0H0ETsFCRuwFl9PYfO5YjA8RiZHtgglWRfC5BYddCd80SgDaF3Nm4jJQk6t+RKhAJyCs=
X-Received: by 2002:a92:cec4:: with SMTP id z4mr75278136ilq.217.1609849457911;
 Tue, 05 Jan 2021 04:24:17 -0800 (PST)
MIME-Version: 1.0
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
 <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net> <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
In-Reply-To: <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Tue, 5 Jan 2021 15:24:06 +0300
Message-ID: <CAN4oSBcL7ae_qwKDDoP=sbjkR4gcweTO8otEQv1Zh0YhStWZsw@mail.gmail.com>
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Forza <forza@tnonline.net>, Cedric.dewijs@eclipso.eu,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I also thought about a different approach in the past:

1. Take a snapshot and rsync it to the server.
2. When it succeeds, make it readonly and take a note on the remote
site that indicates the Received_UUID and checksum of entire
subvolume.
3. When you want to send your diff, run `btrfs send -p ./first
./second | list-file-changes -o my-diff-for-second.txt` if that
Received_UUID on the remote site matches with ./first. (Otherwise, you
should run rsync without taking advantage of
`my-diff-for-second.txt`.)
4. Use rsync to send the changed files listed in `my-diff-for-second.txt`.
5. Verify by using a rolling hash, create a second snapshot and so on.

That approach will use all advantages of rsync and adds the "change
detection" benefit from BTRFS. The problem is, I don't know how to
implement the `list-file-changes` tool.

By the way, why wouldn't BTRFS keep a CHECKSUM field on readonly
subvolumes and simply use that field for diff and patch operations?
Calculating incremental checksums on every new readonly snapshot seems
like a computationally cheap operation. We could then transfer our
snapshots whatever method/tool we like (even we could create the
/home/foo/hello.txt file with "hello world" content manually and then
create another snapshot that will automatically match with our new
local snapshot).

Graham Cobb <g.btrfs@cobb.uk.net>, 5 Oca 2021 Sal, 14:29 tarihinde =C5=9Fun=
u yazd=C4=B1:
>
> On 05/01/2021 08:34, Forza wrote:
> >
> >
> > On 2021-01-04 21:51, Cedric.dewijs@eclipso.eu wrote:
> >> =C2=ADI have a master NAS that makes one read only snapshot of my data=
 per
> >> day. I want to transfer these snapshots to a slave NAS over a slow,
> >> unreliable internet connection. (it's a cheap provider). This rules
> >> out a "btrfs send -> ssh -> btrfs receive" construction, as that can't
> >> be resumed.
> >>
> >> Therefore I want to use rsync to synchronize the snapshots on the
> >> master NAS to the slave NAS.
> >>
> >> My thirst thought is something like this:
> >> 1) create a read-only snapshot on the master NAS:
> >> btrfs subvolume snapshot -r /mnt/nas/storage
> >> /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m)
> >> 2) send that data to the slave NAS like this:
> >> rsync --partial -var --compress --bwlimit=3D500KB -e "ssh -i
> >> ~/slave-nas.key" /mnt/nas/storage_snapshots/storage-$(date
> >> +%Y_%m_%d-%H%m) cedric@123.123.123.123/nas/storage
> >> 3) Restart rsync until all data is copied (by checking the error code
> >> of rsync, is it's 0 then all data has been transferred)
> >> 4) Create the read-only snapshot on the slave NAS with the same name
> >> as in step 1.
>
> Seems like a reasonable approach to me, but see comment below.
>
> >> Does somebody already has a script that does this?
>
> I don't.
>
> >> Is there a problem with this approach that I have not yet considered?=
=C2=AD
>
> Not a problem as such, but you could also consider using something like
> rsnapshot (or reimplementing your own version by using rsync
> --link-dest) instead of relying on btrfs snapshots on the slave NAS.
> That way you don't need btrfs on that NAS at all if you don't want. I
> used that approach as the (old) NAS I was using had a very old linux
> version and didn't even run btrfs.
>
> > One option is to store the send stream as a compressed file and rsync
> > that file over and do a shasum or similar on it.
>
> I have looked into that in the past and eventually decided against it.
>
> My main concern was being too reliant on very complex and less used
> features of btrfs, including one which has had several bugs in the past
> (send/receive). I decided my backups needed to be reliable and robust
> more than they need to be optimally efficient.
>
> I had even considered just saving the original send stream, and the
> subsequent incremental sends (all compressed) - until I realised that
> any tiny corruption or bug in even one of those streams could make the
> later streams completely unrestorable.
>
> In the end, I decided to use a very boring (but powerful and
> well-maintained), widely used, conventional backup tool (specifically,
> dar, under the control of the dar_automatic_backup script) and I copy
> the dar archives (compressed and encrypted) onto my offsite backup
> server (actually, now, I store them in S3, using rclone). They are also
> convenient to occasionally put on a disk which I can give to a friend to
> put at the back of their cupboard somewhere in case I need it (faster
> and cheaper to access than S3)!
>
> In my case, I had some spare disks and plenty of bandwidth so I also use
> rsnapshot from my onsite NAS to an offsite NAS. But that is for
> convenience (not having to have dar read through all the archives) - I
> consider the S3 dar archives my "main" disaster-recovery backup.
>
> > btrbk[2] is a Btrfs backup tool that also can store snapshots as
> > archives on remote location. You may want to have a look at that too.
>
> I use btrbk for local snapshots (storing snapshots of all my systems on
> my main server system). But I consider those convenient copies for
> restoring files deleted by mistake, or restoring earlier configurations,
> not backups (for example, a serious electrical problem or fire in the
> server machine could destroy both the original disk and the snapshot disk=
).
>
> Your situation is different, of course - so just some things to consider.
>
>
