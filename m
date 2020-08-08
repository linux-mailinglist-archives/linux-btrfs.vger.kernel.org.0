Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0913C23F81B
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Aug 2020 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgHHP6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Aug 2020 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgHHP6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Aug 2020 11:58:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF424C061756
        for <linux-btrfs@vger.kernel.org>; Sat,  8 Aug 2020 08:58:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 9so4115911wmj.5
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Aug 2020 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uzyTMtxrb49gbboKI9iCrfCROoJ/llkvD+q3HxhSnLk=;
        b=Uy3y/2djCqd6pQyOG3t38DVIzNkk6pERVXbVUo+OTeSwJLnyKObIpqa2fz/ONcW/iW
         YbxxrKgKxU8OE5wJDRepPqZj3hZ6Ow9NNyc/5A4UfrlmWE1MyAZs56iaAYH1zWPY7orj
         WdNBDz5AdvmpmPQ/3RGOvZBgVsr6DQCZ4VuC+Ah3c3FpY9K0+/ZaZ/7n9AwFJqHPlwz0
         tgNx7tOGVFTZL++c4f2rJACbhtgrvoCPtyoBogFC71XO3+8oQP6spurETdGeOY6lPPa9
         BGa3APXPvmCQRVFtXyyyhBl23j9miyKlUXME6/0vMsC97mXF6oUKCly75ZhdVO92nEoU
         v4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uzyTMtxrb49gbboKI9iCrfCROoJ/llkvD+q3HxhSnLk=;
        b=T2S491m7M9h+9OPKGlka9OAq42MZZ9LbVWUGtP4WVmzZYLLYkWBOb7EdlacaUoPvn/
         T4cC9dG6ovh4evj27VvARZXCUGLEfnM/e6ezya5V9gHEJjAQmHAge3+29Ck0l5Swn+Rz
         UE4QWN1EI6DAi4RjyJ42Nkc8BBWh7iBfsFe4kCRU6Z9KHj6iqsBMDrUDHJI+1C91mCjM
         POwZPUJASIeUzGvCl3DhZIsATeLZT3P9eZ3BkuCTVkRk+A2vu86UQK+pJHQotXsX54C3
         IpB2ikhfM/AQYPKn79xnhkb9F333B0ZsAKGp2RSvHtawUya1uIVgD/irLax0lDgjfzsE
         bVdw==
X-Gm-Message-State: AOAM5305hAS7IFtG3igxvBtJBDd6NzRoPPxqlgnWwvRePSEtBFtFe1cm
        FQrKHEVtJlxBMr6/U4TysrjegANOreL/YXQkSnjlYQ==
X-Google-Smtp-Source: ABdhPJxMlWQT+T/MZ5VPDo0iWRCevyPLekvh/qTeC+ROJfGm2M+cnX4l1u5ELwc253l7+XwjAyvJU9jZmsXr6aJHeXk=
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr17229519wmj.105.1596902311227;
 Sat, 08 Aug 2020 08:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEYyJDyMkOBjhhVFbX_CCG0bnWC1i7OGLvPj8tFhntgxYjkRGg@mail.gmail.com>
 <e194deb8-4126-0ac6-becd-890939c99275@gmx.com>
In-Reply-To: <e194deb8-4126-0ac6-becd-890939c99275@gmx.com>
From:   Lu Pi <lp.contact2@gmail.com>
Date:   Sat, 8 Aug 2020 17:57:53 +0200
Message-ID: <CAEYyJDzojVnOqh3+egwm0FPNEhazj6idzj0YxWNr_K77Fj0UPA@mail.gmail.com>
Subject: Re: fails to boot with "BTRFS critical (device sda2): corrupt leaf: ..."
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 8 Aug 2020 at 13:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/8/8 =E4=B8=8B=E5=8D=885:57, Lu Pi wrote:
> > Hi,
> >
> > I have a system that fails to boot, with "BTRFS critical (device
> > sda2): corrupt leaf: " error, and open an "initramfs" shell.
> >
> > I did backup /home with 'btrfs restore'. There were a few errors,
> > though only on cache files (Google Chrome cache files).
> >
> > Now considering 'btrfs check --repair'.
> >
> > I'm contacting you as recommended here:
> >    https://btrfs.wiki.kernel.org/index.php/Tree-checker
> >    "Please report to btrfs mail list <linux-btrfs@vger.kernel.org> firs=
t."
> >    "Please *NOT* use btrfs check --repair until instructed by a develop=
er."
> >
> >
> > Can you advice?
> >
> >
> >
> >
> > BACKGROUND
> >
> > - the system is Linux Mint 17
> >
> > - a week ago or so, after a kernel update, the system was remounting
> > read-only after about 1 minute after boot. Downgrading the kernel
> > solved the issue.
> >   - 4.15.0-112-generic brought the issue
> >   - 4.15.0-107-generic was OK
> >
> > - a few days ago, something else happened, though I'm unsure, as I'm
> > not the user of the system. Possibly any of these,
> >   - another kernel update (now I can see that 4.15.0-112 is back)
>
> The kernel update is the direct cause, we added a lot of extra selftest
> to ensure we detect problems before it crash the kernel.
>
> The root cause is some even older kernel, which writes some
> uninitialized data to disk.
>
> >   - maybe the system was shut down by cutting electricity (?)
> >   - could it be also that the SSD drive is failing (?)
> >   - or?
> >   - though as a result the system fails to boot and the drive is not mo=
untable.
> >
> >
> >
> > SYSTEM INFORMATION
> > ---
> > When reporting errors or asking for support always supply the output
> > of the following commands:
> >   uname -a
> >   btrfs --version
> >   btrfs fi show
> >   btrfs fi df /home # Replace /home with the mount point of your
> > btrfs-filesystem
> >   dmesg > dmesg.log
> > ---
> >
> > See below, and dmesg log enclosed
> >
> >
> > ---
> > (initramfs) uname -a
> > Linux (none) 4.15.0-112-generic #113~16.04.1-Ubuntu SMP Fri Jul 10
> > 04:37:08 UTC 2020 x86_64 GNU/Linux
>
> This is a little old, considering how many enhancement and bug fixes are
> in recent kernel releases.
>
> Thus it's recommended to use newer kernel, *after* your problem been fixe=
d.
>
> >
> >
> > (initramfs) btrfs --version
> > btrfs-progs v4.4
>
> Btrfs-progs is too old to even detect the problem, not to mention fix it.
> It should only report the fs as healthy, if there are no other problems.
>
> >
> >
> > (initramfs) btrfs fi show
> > Label: none  uuid: f813bbe2-0bff-4923-822b-d3f6d6ebbb9e
> >     Total devices 1 FS bytes used 55.22GiB
> >     devid    1 size 107.98GiB used 85.02GiB path /dev/sda2
> >
> >
> > (initramfs) btrfs fi df /home
> > ERROR: can't access '/home': No such file or directory
> >
> > (initramfs) btrfs fi df /
> > ERROR: not a btrfs filesystem: /
> >
> >
> >
> > (initramfs) mount -t btrfs /dev/sda2 /mnt/sda/
> > [70391.973518] BTRFS critical (device sda2): corrupt leaf:
> > block=3D353828864 slot=3D148 extent bytenr=3D242073600 len=3D16384 inva=
lid
> > generation, have 9367487224930631680 expect (0, 458036]
>
> The generation is mostly garbage, it's 0x8200000000000000L, just some
> random number not really initialized.
>
> This is a pretty old bug in older kernels.
>
> It's the recently added extra self check detecting them.
>
> This can be detected by "btrfs check --repair" after btrfs-progs v5.4.1,
> but not yet repairable. (Haven't got a real world report before this one)
>
>
> There is a way to workaround this, by locating the offending extent, and
> delete it manually.
>
> Firstly, you need to mount the fs with older kernel.
>
> Then run the following command (maybe you need latest btrfs-progs):
> # btrfs ins logical-resolve 242073600 <mnt>
>
> Where the 242073600 is the "extent bytenr" in the dmesg output.
>
> There are two possible output patterns:
> - The path of the offending file
>   Then just delete it.
>
> - No such file or directory
>   This means it's a tree block, it's going to be a little trikcy.
>   You need to use btrfs ins again:
>   # btrfs ins dump-tree -t 402653184 <device>
>
>   Then search thing like this "EXTENT_DATA":
>         item 6 key (257 EXTENT_DATA 0) itemoff 15813 itemsize 53
>                 generation 3 type 1 (regular)
>                 extent data disk byte 138424320 nr 1048576
>                                       ^^^^^^^^^
>   Then use that "138424320" to logical-resolve command again, then
>   to remove all offending files.
>
> I'll work on the btrfs check repair ability soon, before that, please
> use the above workaround.

I will do that, and report back

Thank You so much for your fast and detailed answer


>
> Sorry for the inconvenience and thanks for the first real world report.

No worry, I'm glad to contribute information for a better kernel,

Thank You again, very much


>
> Thanks,
> Qu
>
> > [70391.975504] BTRFS: error (device sda2) in __btrfs_free_extent:7000:
> > errno=3D-5 IO failure
> > [70391.977490] BTRFS: error (device sda2) in
> > btrfs_run_delayed_refs:3083: errno=3D-5 IO failure
> > [70391.979490] BTRFS: error (device sda2) in btrfs_replay_log:2369:
> > errno=3D-5 IO failure (Failed to recover log tree)
> > [70391.980588] BTRFS error (device sda2): pending csums is 475136
> > [70392.023935] BTRFS error (device sda2): open_ctree failed
> > mount: mounting /dev/sda2 on /mnt/sda/ failed: Input/output error
> >
> >
> >
> > (initramfs) dmesg |grep 70391
> > [70391.723717] BTRFS info (device sda2): disk space caching is enabled
> > [70391.723721] BTRFS info (device sda2): has skinny extents
> > [70391.763253] BTRFS info (device sda2): enabling ssd optimizations
> > [70391.763256] BTRFS info (device sda2): start tree-log replay
> > [70391.973518] BTRFS critical (device sda2): corrupt leaf:
> > block=3D353828864 slot=3D148 extent bytenr=3D242073600 len=3D16384 inva=
lid
> > generation, have 9367487224930631680 expect (0, 458036]
> > [70391.975504] BTRFS: error (device sda2) in __btrfs_free_extent:7000:
> > errno=3D-5 IO failure
> > [70391.977490] BTRFS: error (device sda2) in
> > btrfs_run_delayed_refs:3083: errno=3D-5 IO failure
> > [70391.979490] BTRFS: error (device sda2) in btrfs_replay_log:2369:
> > errno=3D-5 IO failure (Failed to recover log tree)
> > [70391.980588] BTRFS error (device sda2): pending csums is 475136
> >
> >
> > full dmesg log enclosed.
> > ---
> >
>
