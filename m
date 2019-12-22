Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB2812903A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2019 00:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfLVXO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 18:14:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54033 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfLVXO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 18:14:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so14228708wmc.3
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2019 15:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sjZKV4JDEEKKvRkop4VFsXeaP+LxCGWibJr2DwkQAFg=;
        b=be15VeKGwNZjI0PTIfpRakJ8Du9KiKO8JE79Qw9fl1Irj7jOUTpzsYB4LnikXRjCSi
         yfnRr0DBFt3e37TLLBwWggHeaiVx9XpmwhHmYdxdEOP7ZKeiWeayXbaZwr1iiG9uk+6s
         mU7v9281GJkv6Cl5TSmPGp6ykAfO1R4iDmgd7MhFlQ3To05vdJHnVtvMwOTu6kK+IsJJ
         CfPBPhBsN7Sc3UqVpA8xme9KDahgo4Rp0ev/7AV9lJa1Gk19/ixzfXNbqMP223F13Qaa
         AQvm9hI7F+guYdD8N6EWYKlGsRO8mZpXOgbnqv9WptsVHcwIlLgCkgmqoBGMCXPfDIPx
         FrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sjZKV4JDEEKKvRkop4VFsXeaP+LxCGWibJr2DwkQAFg=;
        b=MvVKKWXXYTv2Y58i3h39IjmE3wc8+aqCOyS2J/KwoVhgW7TedrUsYxVl5L4fXPVLRG
         yqsIkYJiWLNiucGzTSqatx38DfNv2B+ig25rghoOQB0fHXE94zZaGNhubC1e6FBENqjg
         UW4w1/awVFPuFiKOXTT80ikPuBRcFd4soE6iVxN5ST013oYKkoQoohJGjhU7MQcdqabe
         LHZtqPvVFyH1PgCPgXIZrzLXzw2oqHOAODsX9TJ1RqNyMbnJaC7orMpDfnGugNDfrGs/
         7EINr/ec3LPDHEsA36egy3tEX0zzasFWrWCyzSaNK1uRwRGvN2Za8uZreH7n+42fZRW4
         EqRA==
X-Gm-Message-State: APjAAAWU7ebmf0OY7UE1PTdTsdEOCJ8Rd0lowgzUCZDNYtXIvLXaRKhP
        gj8s7l/heMY0nqyjBeQ3WBc2+ihgwCPssKAMHLZoXy8Qeka/hg==
X-Google-Smtp-Source: APXvYqxqTWFbUVhXZKsc1I52l7CSjYANl3sH7552M2cESZexAYTVsoZiqakl4+IydlY2aLcb2B6LAWNySMEh9uVQKSI=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr28476632wmh.164.1577056466783;
 Sun, 22 Dec 2019 15:14:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com> <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
 <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com> <a6488349-301f-1071-0d96-4970ca50c3cd@suse.com>
 <20191223001512.6477bd8f@natsu> <CAJCQCtSDxOa29cTNgr_cpJ5vT0boKRz2+nHLv2oUHiWYrGpkag@mail.gmail.com>
 <347063a8-d0d9-4fa9-564c-17f7e01121cb@suse.com>
In-Reply-To: <347063a8-d0d9-4fa9-564c-17f7e01121cb@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 22 Dec 2019 16:14:10 -0700
Message-ID: <CAJCQCtR_0sAw4EZGgfVe4YsV+XSgKefbpu3dANEkRp-YUSGZHQ@mail.gmail.com>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Roman Mamedov <rm@romanrm.net>,
        Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 22, 2019 at 3:29 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 23.12.19 =D0=B3. 0:11 =D1=87., Chris Murphy wrote:
> > On Sun, Dec 22, 2019 at 12:15 PM Roman Mamedov <rm@romanrm.net> wrote:
> >>
> >> On Sun, 22 Dec 2019 20:06:57 +0200
> >> Nikolay Borisov <nborisov@suse.com> wrote:
> >>
> >>> Well, if we rework how fitrim is implemented - e.g. make discards asy=
nc
> >>> and have some sort of locking to exclude queued extents being allocat=
ed
> >>> we can alleviate the problem somewhat.
> >>
> >> Please keep fstrim synchronous, in many cases TRIM is expected to be c=
ompleted
> >> as it returns, for the next step of making a snapshot of a thin LV for=
 backup,
> >> to shutdown a VM for migration, and so on.
> >
> > XFS already does async discards. What's the effect of FIFREEZE on
> > discards? An LV snapshot freezes the file system on the LV just prior
> > to the snapshot.
>
> Actually, XFS issues synchronous discards for the FITRIM ioctl i.e
> xfs_trim_extents calls blkdev_issue_discard same as with BTRFS. And
> Dennis' patches implement async runtime discards (which is what XFS is
> using by default).
>
> >
> >> I don't think many really care about how long fstrim takes, it's not a=
 typical
> >> interactive end-user task.
> >
> > I only care if I notice it affecting user space (excepting my timed
> > use of fstrim for testing).
> >
> > Speculation: If a scheduled fstrim can block startup, that's not OK. I
> > don't have enough data to know if it's possible, let alone likely. But
> > when fstrim takes a minute to discard the unused blocks in only 51GiB
> > of used block groups (likely highly fragmented free space), and only a
> > fraction of a second to discard the unused block *groups*, I'm
> > suspicious startup delays may be possible.
>
> If it takes that long then it's the drive's implementaiton at fault.
> Whatever we do in software we will only masking the latency, which might
> be workable solution for some but not for others.

The point of bringing it up is to drive home the point we don't even
understand the scope of the problem, especially if this behavior is
surprising. It's common hardware.

fstrim on this file system results in 53618 discards to be issued. 35
of these are + 8388607 in size, which I think translates to ~4G but
I'm not sure if these are 4K block size or 512 byte. Seems more
consistent with them being 512 bytes, but it doesn't come out to
exactly 4GiB if I assume that.

Those 35 large discard ranges takes only 0.016951402 seconds. The
remaining 53000+ discards take the overwhelming bulk of time, over a
minute. I have no idea if this delay is lookup/computation for Btrfs
to figure out what the unused blocks are. Or if it's a device delay.
And that comes to about 568 discards per second. That's really
unreasonable drive performance behavior?

Also...

259,0    3   127259    91.202441239  3057  A  DS 177594367 + 1 <-
(259,7) 54700031

A single 512 byte discard? That's suspicious. Btrfs doesn't work in
512 byte increments, minimum unit is 4k for (Btrfs) sector size, isn't
it?



--=20
Chris Murphy
