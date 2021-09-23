Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE1415BC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbhIWKMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 06:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 06:12:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EB1C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:10:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z24so24939400lfu.13
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YfWgtYBZfZ7VQLyWoNcqB1U6F7z5AbrkbIFX2fTGzj4=;
        b=ZrAUm60kfiyyCj3F+ybKeasqT86ZVQNQgB+VmNPIs+JlDabJSufFuYAcdu2wTeHPVn
         uqYokLd+33ir1LXuEr0BQZnULBv+N/GO8bT9xpTEVyvkcVPzY0soGJ4zqCJpnM4kcclO
         DvanaslcK+oUDSHRmxpUKtxAxxJI1LBEM8Jv7ydVGr4uBw+qnxbHkZMD+X8J/uJIz5V4
         dmoXG7idvaLRZIx1I+FVRaRbmGQXTw7wbOpzeqCZR7gLF+xgU4/zJxL7NrOFgUk0fqM8
         //7TV7KsPtC2S2ShwpC34Zz+nex6YYZNthaOKbLmsjwSJqe6G6Yvuk8BoAgFAro/p1ko
         b4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YfWgtYBZfZ7VQLyWoNcqB1U6F7z5AbrkbIFX2fTGzj4=;
        b=WwTwlStWYs4MpTh3cnQ8Y1EVbVrh5utGgg84ExsatK2cvmKkK/VD7gV33hjI06Kfqi
         WYw1nTxOZ9pEw259UzaST30rWdSUovIyTZiSc/3J4gU8A+lF73NPlruMH7buMF7zNG13
         jc8gY9rtvTbdNmqGB+j7Ii7T9Yd8ACqVjZflY782NnksgtnsNBRQBYiONmpLVc38KEgX
         a4pl7Tu8ty8siKKEvbhC3L6nmWI92x9cOGbd+4BcujsAVRgNjYYx/AqHpPfbM3V0c6A4
         nKQYPGGEVjAJg4WPqRmkalNFiGJHZIBAgIE7Toub71J6Cz373uch8M3DBcTVKtivllqC
         5r9Q==
X-Gm-Message-State: AOAM531ubz2N7OUmnRo5N2QZb78yeYzsi32l2Rzt3fP9XgJVPnHPtx3J
        tJMBkrzyA43HcgHAbBEeoHsn10Fpogo+oH2h9DU=
X-Google-Smtp-Source: ABdhPJyLHoihi21Y1dfB60d3kjwWt8ySl8aE9keXXNwaBbGKF7GO76rSt1EQvFUS+qq3mzmRdyp6i1GG/yw115x6vAw=
X-Received: by 2002:ac2:54a3:: with SMTP id w3mr3564000lfk.369.1632391827970;
 Thu, 23 Sep 2021 03:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <1632330390-29793-1-git-send-email-zhanglikernel@gmail.com> <5679da1e-2422-69c5-b4f8-326802363f7c@suse.com>
In-Reply-To: <5679da1e-2422-69c5-b4f8-326802363f7c@suse.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Thu, 23 Sep 2021 18:10:15 +0800
Message-ID: <CAAa-AGmnKSDm=9my5+qi3OqOaB7BZqmGrGjoctm60Cfs6-9agg@mail.gmail.com>
Subject: Re: [PATCH] clear_bit BTRFS_DEV_STATE_MISSING if the device->bdev is
 not NULL During mount.
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sure, I would love to do it.

To avoid ambiguity, Should I and write a test
case to detect whether clear the BTRFS_DEV_STATE_MISSING
if filesystem found a device, but it was marked to
BTRFS_DEV_STATE_MISSING.

Nikolay Borisov <nborisov@suse.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:41=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 22.09.21 =D0=B3. 20:06, Li Zhang wrote:
> > reference to:
> > https://github.com/kdave/btrfs-progs/issues/389
> > If a device offline somehow, but after a moment, it is back
> > online, btrfs filesystem only mark the device is missing, but
> > don't mark it right.
> >
> > However, Although filesystem mark device presented, in my
> > case the /dev/loop2 is come back, the generation of this
> > /dev/loop2 super block  is not right.Because the device's
> > data is not up-to-date.  So the info of status of scrubs
> > would list as following.:
> >
> > $ losetup /dev/loop1 test1
> > $ losetup /dev/loop2 test2
> > $ losetup -d /dev/loop2
> > $ mount -o degraded /dev/loop1 /mnt/1
> > $ touch /mnt/1/file1.txt
> > $ umount /mnt/1
> > $ losetup /dev/loop2 test2
> > $ mount /dev/loop1 /mnt/1
> > $ btrfs scrub start /mnt/1
> > scrub started on /mnt/1, fsid 88a3295f-c052-4208-9b1f-7b2c5074c20a (pid=
=3D2477)
> > $ WARNING: errors detected during scrubbing, corrected
> >
>
> THis seems it can be turned into an fstests rather easily, care to send
> a patch for it as well ?
>
> > $btrfs scrub status /mnt/1
> > UUID:             88a3295f-c052-4208-9b1f-7b2c5074c20a
> > Scrub started:    Thu Sep 23 00:34:55 2021
> > Status:           finished
> > Duration:         0:00:01
> > Total to scrub:   272.00KiB
> > Rate:             272.00KiB/s
> > Error summary:    super=3D2 verify=3D5
> >   Corrected:      5
> >   Uncorrectable:  0
> >   Unverified:     0
> >
> > And if we umount and mount again everything would be all right.
> >
> > In my opinion, we could improve this scrub in the following
> > way, i personally vote the second method
> >
> > 1) Sync all data immediately during mounting, but it waste IO
> > resource.
> >
> > 2) In scrub, we should give detailed information of every device
> > instead of a single filesystem, since scrub is launching a number
> > of thread to scanning each device instead scan whole filesystem.
> > Futher more we should give user hint about how to fix it, in my
> > case, user should umount filesystem and mount it again. But if
> > data is corrupt, the repair program might be called,  in case of
> > further damage, user should replace a device and reconstruct
> > ata using raid1, raid6 and so on.
> >
> > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> > ---
> >  fs/btrfs/volumes.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 464485a..99fdbaa 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -7198,6 +7198,11 @@ static int read_one_dev(struct extent_buffer *le=
af,
> >                       set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_sta=
te);
> >               }
> >
> > +             if (device->bdev && test_bit(BTRFS_DEV_STATE_MISSING, &de=
vice->dev_state) && device->fs_devices->missing_devices > 0) {
> > +                     device->fs_devices->missing_devices--;
> > +                     clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_s=
tate);
> > +             }
> > +
> >               /* Move the device to its own fs_devices */
> >               if (device->fs_devices !=3D fs_devices) {
> >                       ASSERT(test_bit(BTRFS_DEV_STATE_MISSING,
> >
