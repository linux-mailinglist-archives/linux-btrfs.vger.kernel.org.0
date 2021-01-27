Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CAA306588
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 22:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhA0U55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344101AbhA0U51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 15:57:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64328C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 12:56:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g10so3348376wrx.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7TZDTb6c4tGmbvARVeatkYD/GiuyK/RGCOlRzCVAibE=;
        b=uag3DprCtxesM6ABM6IQQod58IM4FkeBVN0mBjxcO5JJmsTn670swQ0kQwrur5gfpw
         uOSLvd1LM1Ea9h6gvQYqY+I7sfSUyQswBvaQUO/es5KYZPhADTFALPaf11UUGZc8AVHw
         J8PcVAVJpeDjgqTqvdGBMSiFveAnetE+cQ9s0T4ks5OkLC39vMYCvipTIRCakAnairQn
         o0Sc4zIbQDHaovrVPnl2BEfuQQ5NgjrrIdYPkdmIhIEj7nf839Xa1HppfgkcPN6fOSpV
         XPw22kliLJ1CLP+dCZ05GtQp0wSdUopeOLxVJ0YKzOvF9ftaqYE4hTa0meorjYJ5T+wR
         cyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7TZDTb6c4tGmbvARVeatkYD/GiuyK/RGCOlRzCVAibE=;
        b=cnyAhSeGoBHvOgmYvfLXLgwBf2wKR7RhYAF8gfxh4xn2bw9A1+iUrIOeUHcJ8lr8UY
         QiCGJOiWmevcty/nIe2uZw9o1UWfYhLoF3u806h1W2Bco1LvfuJ1X1Vu2+AIVTo7+215
         5+LhFo+PhB9ndPMJkGaC2t9AD5zVuzHEjELxdL+OHYLUMpf8Rcksu1RKUTXVjvfY4+Uh
         dwYVK+mNKGDUEcAZkQwgTsdiGdrO8xNdMwnF52kOIgURjU4U0B8ryi/ZP2zYDE+OC9ia
         sRtMDt8Fzes0mVrPhvouNwj3Tf7IDe+fADLbq9y8hHpviKwb+eqbe9vFl9OS+V140uiI
         dIhw==
X-Gm-Message-State: AOAM533IUeDroURROIeDsziTS3T2qI8VRHW+GporlB4ppaH0pp0Yw/38
        cyBO6VqAmJ2LdRAmOy9C1kRmQWcRc+SG9kbUEFt3zGb5fu8Yyw==
X-Google-Smtp-Source: ABdhPJzsaEjbbUyAKb7h6Hp6+Gi8iY3XKxD8taxvG8VsPjH2qhasB4v5nUna3NFt+QYpgVBtBaYaP3Fr16ohvhJmSKw=
X-Received: by 2002:a5d:6686:: with SMTP id l6mr12910361wru.236.1611781006164;
 Wed, 27 Jan 2021 12:56:46 -0800 (PST)
MIME-Version: 1.0
References: <b693c33d-ed2e-3749-a8ac-b162e9523abb@gmail.com>
 <CAJCQCtSwC--k1agUzBcGgdCZZu426fVoUw-V3m8C4XjeN7yQaA@mail.gmail.com> <bfbe313c-4f4d-eeab-1a6b-10d58b5b4b91@gmail.com>
In-Reply-To: <bfbe313c-4f4d-eeab-1a6b-10d58b5b4b91@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Jan 2021 13:56:30 -0700
Message-ID: <CAJCQCtS21qjWuJLr_xdEnPiqcnuUa05JT1iEPrGxNVVTmOV5pQ@mail.gmail.com>
Subject: Re: Only one subvolume can be mounted after replace/balance
To:     =?UTF-8?Q?Jakob_Sch=C3=B6ttl?= <jschoett@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 6:10 AM Jakob Sch=C3=B6ttl <jschoett@gmail.com> wro=
te:
>
> Thank you Chris, it's resolved now, see below.
>
> Am 25.01.21 um 23:47 schrieb Chris Murphy:
> > On Sat, Jan 23, 2021 at 7:50 AM Jakob Sch=C3=B6ttl <jschoett@gmail.com>=
 wrote:
> >> Hi,
> >>
> >> In short:
> >> When mounting a second subvolume from a pool, I get this error:
> >> "mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda,
> >> missing code page or helper program, or other."
> >> dmesg | grep BTRFS only shows this error:
> >> info (device sda): disk space caching is enabled
> >> error (device sda): Remounting read-write after error is not allowed
> > It went read-only before this because it's confused. You need to
> > unmount it before it can be mounted rw. In some cases a reboot is
> > needed.
> Oh, I didn't notice that the pool was already mounted (via fstab).
> The filesystem where out of space and I had to resize both disks
> separately. And I had to mount with -o skip_balance for that. Now it
> works again.
>
> >> What happened:
> >>
> >> In my RAID1 pool with two disk, I successfully replaced one disk with
> >>
> >> btrfs replace start 2 /dev/sdx
> >>
> >> After that, I mounted the pool and did
> > I don't understand this sequence. In order to do a replace, the file
> > system is already mounted.
> That was, what I did before my actual problem occurred. But it's
> resolved now.
>
> >> btrfs fi show /mnt
> >>
> >> which showed WARNINGs about
> >> "filesystems with multiple block group profiles detected"
> >> (don't remember exactly)
> >>
> >> I thought it is a good idea to do
> >>
> >> btrfs balance start /mnt
> >>
> >> which finished without errors.
> > Balance alone does not convert block groups to a new profile. You have
> > to explicitly select a conversion filter, e.g.
> >
> > btrfs balance start -dconvert=3Draid1,soft -mconvert=3Draid1,soft /mnt
> I didn't want to convert to a new profile. I thought btrfs replace
> automatically uses the same profile as the pool?

Btrfs replace does not change the profile. But you reported mixed
profile block groups, which means conversion is indicated to make sure
they're al the same. Please post:

sudo btrfs fi us /mnt

Let's see what the block groups are and what you want them to be and
then see what conversion command might be indicated.


--=20
Chris Murphy
