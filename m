Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DEB31840B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 04:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBKDkL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 22:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBKDkK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 22:40:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6CEC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 19:39:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y134so3866009wmd.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 19:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/y4t9duXKkwNjcTFH6V/dVTcM6SEGqjv/aJ1XuP8yw=;
        b=k40Yo1THLcWVDGxMQO1oUtNQ6oTEdDjLBPyYnO2bZhnrP4XS4G0EN/6Dgj6H36QsRI
         UkISjeTEiYV+tmicmhb6XL/YgRwjQyA7aWJlNlOmNGOr+rqobDZ2ypEotHXVfE9IAWG0
         ngG5zI1v7Mg7HwxYXmv1NUgivw2JiR5/Bx1Q2PIMZ+ljNVCOidbl6Pp/9Vy5rRDx9RFG
         MYIcttAIAj+jqYkDSMO647EDGBY4xL2ktFcHYIU8wcSSr/2csC+ymaDsNyBauvgU4qtj
         dITw+Z9NDxFOYURPWS+nU60d2hTsS1E7nMrDvpTRfPfNxpuWKvqGdgp8h9SYL/yzU+WI
         ebmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/y4t9duXKkwNjcTFH6V/dVTcM6SEGqjv/aJ1XuP8yw=;
        b=qXKDQv7q3HmhqMnE5rZy+oombNHAjEfPTkTF6hVfKMZ2m1TPd+6zfYg6HXKyPGuV+H
         WC33gmnXZnszwGhKva1zt+RJdv7v4+ws+QltuSWz7bqaST5oeqOaRqvecwT0YvpOO5LN
         kOkQLIEUgtkiwnA5uamuyNmB4IrXQiOXBaz04sTHYG8mmJ5zZ3JT3UMTucxzKnjNt34W
         G5rT3lysav5cjPro16zBvv/wCbnu1AkpbFWQ/YDHITWyeoVzYdbBcs0vt7l1cwZ8yxiz
         TmriOR8h3Cl+Yg0J0tG2qdkf2Tz6J3uNjaHgYLElDeB+gKoSE/qQ/CovxGObnWJtJL74
         fd6w==
X-Gm-Message-State: AOAM533nqR0TbNEyFNCW+iIIaqnehiaC3PvQGmCF/tfhrNoqTLNv0et+
        T3gbr/gHAzolVqBVqgUHJq4d9Qivyex6JXg5AC3xxw==
X-Google-Smtp-Source: ABdhPJwUyI7Yd8U48LLWc3mzAp+PX0ob5dj2fVGQnDYjvsE546xfMzAjlyIjHetduTsqeg5xiHaYhx6K0CZswROz4Og=
X-Received: by 2002:a1c:e245:: with SMTP id z66mr2628253wmg.168.1613014768993;
 Wed, 10 Feb 2021 19:39:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it> <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it> <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it> <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
 <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it> <20210211030836.GE32440@hungrycats.org>
 <20210211031306.GL28049@hungrycats.org>
In-Reply-To: <20210211031306.GL28049@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 10 Feb 2021 20:39:12 -0700
Message-ID: <CAJCQCtQ48Vy+FxoqDseu=bAsna5gMo8mc8Fo+ybRG3v_SYFbjg@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 8:13 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> Sorry, I busted my mail client.  That was from me.  :-P
>
> On Wed, Feb 10, 2021 at 10:08:37PM -0500, kreijack@inwind.it wrote:
> > On Wed, Feb 10, 2021 at 08:14:09PM +0100, Goffredo Baroncelli wrote:
> > > Hi Chris,
> > >
> > > it seems that systemd-journald is more smart/complex than I thought:
> > >
> > > 1) systemd-journald set the "live" journal as NOCOW; *when* (see below) it
> > > closes the files, it mark again these as COW then defrag [1]
> > >
> > > 2) looking at the code, I suspect that systemd-journald closes the
> > > file asynchronously [2]. This means that looking at the "live" journal
> > > is not sufficient. In fact:
> > >
> > > /var/log/journal/e84907d099904117b355a99c98378dca$ sudo lsattr $(ls -rt *)
> > > [...]
> > > --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd4f-0005baed61106a18.journal
> > > --------------------- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000bd64-0005baed659feff4.journal
> > > --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd67-0005baed65a0901f.journal
> > > ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cc63-0005bafed4f12f0a.journal
> > > ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cc85-0005baff0ce27e49.journal
> > > ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cd38-0005baffe9080b4d.journal
> > > ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cd3b-0005baffe908f244.journal
> > > ---------------C----- user-1000.journal
> > > ---------------C----- system.journal
> > >
> > > The output above means that the last 6 files are "pending" for a de-fragmentation. When these will be
> > > "closed", the NOCOW flag will be removed and a defragmentation will start.
> >
> > Wait what?
> >
> > > Now my journals have few (2 or 3 extents). But I saw cases where the extents
> > > of the more recent files are hundreds, but after few "journalct --rotate" the older files become less
> > > fragmented.
> > >
> > > [1] https://github.com/systemd/systemd/blob/fee6441601c979165ebcbb35472036439f8dad5f/src/libsystemd/sd-journal/journal-file.c#L383
> >
> > That line doesn't work, and systemd ignores the error.
> >
> > The NOCOW flag cannot be set or cleared unless the file is empty.
> > This is checked in btrfs_ioctl_setflags.
> >
> > This is not something that can be changed easily--if the NOCOW bit is
> > cleared on a non-empty file, btrfs data read code will expect csums
> > that aren't present on disk because they were written while the file was
> > NODATASUM, and the reads will fail pretty badly.  The entire file would
> > have to have csums added or removed at the same time as the flag change
> > (or all nodatacow file reads take a performance hit looking for csums
> > that may or may not be present).
> >
> > At file close, the systemd should copy the data to a new file with no
> > special attributes and discard or recycle the old inode.  This copy
> > will be mostly contiguous and have desirable properties like csums and
> > compression, and will have iops equivalent to btrfs fi defrag.

Journals implement their own checksumming. Yeah, if there's
corruption, Btrfs raid can't do a transparent fixup. But the whole
journal isn't lost, just the affected record. *shrug* I think if (a)
nodatacow and/or (b) SSD, just leave it alone. Why add more writes?

In particular the nodatacow case where I'm seeing consistently the
file made from multiples of 8MB contiguous blocks, even on HDD the
seek latency here can't be worth defraging the file.

I think defrag makes sense (a) datacow journals, i.e. the default
nodatacow is inhibited (b) HDD. In that case the fragmentation is
quite considerable, hundreds to thousands of extents. It's
sufficiently bad that it'd be probably be better if they were
defragmented automatically with a trigger that tests for number of
non-contiguous small blocks that somehow cheaply estimates latency
reading all of them. Since the files are interleaved, doing something
like "systemctl status dbus" might actually read many blocks even if
the result isn't a whole heck of alot of visible data.

But on SSD, cow or nocow, and HDD nocow - I think just leave them alone.

-- 
Chris Murphy
