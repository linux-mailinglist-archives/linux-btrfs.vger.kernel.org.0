Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553FA31B7D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 12:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhBOLKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 06:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBOLKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 06:10:15 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3D2C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 03:09:35 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id dr7so2969781qvb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 03:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wOkNA0YO8xoB/svPHY413Dur0QFus5bTjiqa7dy3v7M=;
        b=qyURo5+5aYZlK8FtoABZE4MA//AMkxGXqT16tT76CHxZhTvRBK7KxB56wA7uwZun07
         K48feWgItTYIAuc11dztTpJRomkBGWjJ2KtyN1gRlth4KalXhMU5nspV+qzJ+OXfSiqX
         CZ4rEf5Os+KQyYxFZzcUihjy5lytxpDtFbz2HTVZSfHIUiPTbSnDsL73Y6huwJpugj1c
         /7EXw/5oCi+YzVT6gOrTAvuIAplq34fGshWTBHx55iV4FQfs6iZsnnTstB/1lqjqxSfh
         xG8ji0rCbOL5KufxAOYpkdw/Jl32+5kc0c2qHzefEumGIFNz7uJXaXGMpm7RacemjlFx
         0Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wOkNA0YO8xoB/svPHY413Dur0QFus5bTjiqa7dy3v7M=;
        b=mhz/GDHX/QZFTulN7Gm6zkGu+sk2vNe2Y/jP/CjqvfiIukvHbEZTUVve/VbyvGAVH4
         R1RFrIgtp1iuYXsXBc1zo0LQ9hBjSRYXqRBLDZrTl8YhpNawBEmtyw9rIZj99hbL88Cu
         qrSNr4ADqZa5+758BvDLPqykgbKXPei28SU048zO4IILKu6v1fAJ0FLS4YovyYT8IlAd
         dzNvzmUD8Q8FHVj4lm4W1ZHZ2S/x0YBSw8GlC6RHcfbFdbZKMf/cMhhVOIssEfTXHkjc
         qEjsefjIAKn62OUmCQ9m94/PxxeHLD6xf+slmB/GRLJ9LmPbKIqM5Mwl5uKF8TxAs45I
         nAIA==
X-Gm-Message-State: AOAM533mzssbxl2KV3ier8xm+Hhi+jYGfx/furDyFodqlmP4X2npLWcn
        5mXOsS0Fm5Yo7slIzPjK4a9OwyyBb2mlhIv6E14KHv0Wam119g==
X-Google-Smtp-Source: ABdhPJxKlBNbtM1q12HKOBY2iHGKFjcnDQ176swW7OQRCSyc0XP5lq0Ns09pYSKND6hCqmJi1+NMC/iIsFgpaVGHiiY=
X-Received: by 2002:a05:6214:b84:: with SMTP id fe4mr14235065qvb.45.1613387374612;
 Mon, 15 Feb 2021 03:09:34 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBftCwpZvm-96bvOQzCVCsWHW1e8r6hWjWOtMr9ntCDcxg@mail.gmail.com>
In-Reply-To: <CAN4oSBftCwpZvm-96bvOQzCVCsWHW1e8r6hWjWOtMr9ntCDcxg@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 15 Feb 2021 11:09:23 +0000
Message-ID: <CAL3q7H64Y=nckuqz8a1+LFuR0AqDV2Gvu0+9k6Y-fNFj1ADx9g@mail.gmail.com>
Subject: Re: btrfs receive started to fail constantly for a subvolume
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 13, 2021 at 3:09 PM Cerem Cem ASLAN <ceremcem@ceremcem.net> wro=
te:
>
> Basically I'm using btrbk to create snapshots on main disk (MMM) and
> send them 2 distinct disks (AAA and BBB). I have many nested
> subvolumes (X, X/foo/Y, etc), so every distinct subvolume is
> enumerated separately, like X.111, X.112, ..., X/foo/Y.111,
> X/foo/Y.112, etc. Setup worked well for 100s of snapshots and backups
> (send/receive) within the last 2 months.
>
> Currently there is one offending subvolume that couldn't be sent to
> disk AAA (say X.111). I tried to send it a couple of times even though
> the huge size (230GB, takes 4 hour for every test) but there was no
> success.
>
> Error was like:
>
> ERROR: ... sh: btrfs send -p
> /mnt/MMM-root/snapshots/erik3/rootfs.20210213T0356 -c
> /mnt/MMM-root/snapshots/erik3/rootfs.20210213T0414
> /mnt/MMM-root/snapshots/erik3/home/ceremcem.20210213T0356 | mbuffer -v
> 1 | btrfs receive /mnt/AAA-root/snapshots/erik3/home/
> ERROR: ... cannot open
> /mnt/AAA-root/snapshots/erik3/home/ceremcem.20210213T0356/o10179316-13701=
2-0:
> No such file or directory
>
> I tried to issue `btrfs send
> /mnt/MMM-root/snapshots/erik3/home/ceremcem.20210213T0356 | pv >
> /dev/null` to see if there is anything wrong with the source snapshot,
> but it succeeded.
>
> Skipping the other intermediate attempts, I tried to remove every
> snapshot in AAA, BBB, reformat AAA and BBB with mkfs.btrfs, deleted
> all snapshots and created a new set on MMM, tried to send everything
> from scratch. It failed with nearly the same error (can't remember
> now) on the same subvolume
> (/mnt/MMM-root/snapshots/erik3/home/ceremcem.XXX).
>
> I ran a btrfs scrub on /mnt/MMM-root and there were no errors.
>
> Why do I keep getting this error?
>
> uname -a
> Linux erik3 5.9.0-0.bpo.5-amd64 #1 SMP Debian 5.9.15-1~bpo10+1

Assuming this is a 5.9.0 vanilla kernel, or something close enough,
then you are missing some bug fixes that are likely to solve this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0b3f407e6728d990ae1630a02c7b952c21c288d3
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D9c2b4e0347067396ceb3ae929d6888c81d610259
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D98272bb77bf4cc20ed1ffca89832d713e70ebf09

These are all in recent stable kernels (the versions listed in kernel.org).

> (2020-12-31) x86_64 GNU/Linux
>
> btrfs-progs v5.10



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
