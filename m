Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC3322D05
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBWPA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 10:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhBWPA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 10:00:26 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102DC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 06:59:46 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id s24so17360118iob.6
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 06:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/I4hv0Lkd3p6/uGOOYRrIAtBdkkf59SsHTwvedQIB1k=;
        b=lkgHlxx/MOF7ZrEBC5Wi7K6BI7cTHl1YhMfgBfoLw6qtmybmD5xVpwBIpg+6P4QMOQ
         nro0ua7qTmXjxW4LmDTnTBfyo1G3TK1riSU4Sous9ACS3/blme/RXwEE+xphBcfzho78
         uhj1pu5Ot6lZrdBQ19Nh3YN49C6yysQnqXEwwN56vsWjq5PitBruXGTF8xj3I+zQAXis
         KwYe92UxqTyVx5PWdHPuoag/AJGtJPt7rP05ujgRfHDZEw3gCeqwkC69gLZJKm8mhZv1
         OW5m9Hr+viPS4HF5KEyaMmfTL0+CcfwY4C3UfRDcg0ZxE/2VNuvmi+JLbd0UP6cjkUrD
         nWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/I4hv0Lkd3p6/uGOOYRrIAtBdkkf59SsHTwvedQIB1k=;
        b=rfoB+uElels7gd39wHFwfJEr/rlmuaRvvNooHEzqYboCiUiEmh7hcFR7MJ6mi0zaHX
         hBZRA3CaHM18JB3EORVvzaZjc7eQ3IdygxazMKvJzYUbhVfo5u8Tlk0amVr1aQwaUbqS
         5cBvzXv9huCPCksY78pQE+VVE7mbGA8Yq8G68iWgYPloZW320NhSdYuWc3mj5Au3qVTN
         FiCPSfrgw3cgcu3255j/UipfG7RQkvIzDQ2GsyWHyKcWiwAw9k0SOfHHzBgJ0rl0HcgE
         8bEs27suQm/Tat2yrz7i8gv1kUEQkZZ2gR2SWWaB+rlvSFeRbZDYvEjeUu2QSkltLR01
         Bc0g==
X-Gm-Message-State: AOAM533b3WJTIUxjQ18hHum8EONQo8PYlnfr36YtziAJH3XYF2RyLuP5
        /epvpUlNMIDagAStn02Kxo5dZJbXMebOZNlZbNdTPg==
X-Google-Smtp-Source: ABdhPJzrji+kLgc6sJ/J95LsGYY+7GjWRxjspkK7JVmEy+6ldENTW3skoESCwEyiCFS1OtYRLWRqRQ/iHh43JsAJjo8=
X-Received: by 2002:a05:6638:44e:: with SMTP id r14mr9755642jap.138.1614092385977;
 Tue, 23 Feb 2021 06:59:45 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBftCwpZvm-96bvOQzCVCsWHW1e8r6hWjWOtMr9ntCDcxg@mail.gmail.com>
 <CAL3q7H64Y=nckuqz8a1+LFuR0AqDV2Gvu0+9k6Y-fNFj1ADx9g@mail.gmail.com>
In-Reply-To: <CAL3q7H64Y=nckuqz8a1+LFuR0AqDV2Gvu0+9k6Y-fNFj1ADx9g@mail.gmail.com>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Tue, 23 Feb 2021 17:59:35 +0300
Message-ID: <CAN4oSBfepq3WixmyOMiVU2sZ8OtEHK1JbwzxA7wWU53jqC-5mA@mail.gmail.com>
Subject: Re: btrfs receive started to fail constantly for a subvolume
To:     fdmanana@gmail.com
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the info. I upgraded the kernel to 5.10.0-0.bpo.3-amd64.

Filipe Manana <fdmanana@gmail.com>, 15 =C5=9Eub 2021 Pzt, 14:09 tarihinde =
=C5=9Funu yazd=C4=B1:
>
> On Sat, Feb 13, 2021 at 3:09 PM Cerem Cem ASLAN <ceremcem@ceremcem.net> w=
rote:
> >
> > Basically I'm using btrbk to create snapshots on main disk (MMM) and
> > send them 2 distinct disks (AAA and BBB). I have many nested
> > subvolumes (X, X/foo/Y, etc), so every distinct subvolume is
> > enumerated separately, like X.111, X.112, ..., X/foo/Y.111,
> > X/foo/Y.112, etc. Setup worked well for 100s of snapshots and backups
> > (send/receive) within the last 2 months.
> >
> > Currently there is one offending subvolume that couldn't be sent to
> > disk AAA (say X.111). I tried to send it a couple of times even though
> > the huge size (230GB, takes 4 hour for every test) but there was no
> > success.
> >
> > Error was like:
> >
> > ERROR: ... sh: btrfs send -p
> > /mnt/MMM-root/snapshots/erik3/rootfs.20210213T0356 -c
> > /mnt/MMM-root/snapshots/erik3/rootfs.20210213T0414
> > /mnt/MMM-root/snapshots/erik3/home/ceremcem.20210213T0356 | mbuffer -v
> > 1 | btrfs receive /mnt/AAA-root/snapshots/erik3/home/
> > ERROR: ... cannot open
> > /mnt/AAA-root/snapshots/erik3/home/ceremcem.20210213T0356/o10179316-137=
012-0:
> > No such file or directory
> >
> > I tried to issue `btrfs send
> > /mnt/MMM-root/snapshots/erik3/home/ceremcem.20210213T0356 | pv >
> > /dev/null` to see if there is anything wrong with the source snapshot,
> > but it succeeded.
> >
> > Skipping the other intermediate attempts, I tried to remove every
> > snapshot in AAA, BBB, reformat AAA and BBB with mkfs.btrfs, deleted
> > all snapshots and created a new set on MMM, tried to send everything
> > from scratch. It failed with nearly the same error (can't remember
> > now) on the same subvolume
> > (/mnt/MMM-root/snapshots/erik3/home/ceremcem.XXX).
> >
> > I ran a btrfs scrub on /mnt/MMM-root and there were no errors.
> >
> > Why do I keep getting this error?
> >
> > uname -a
> > Linux erik3 5.9.0-0.bpo.5-amd64 #1 SMP Debian 5.9.15-1~bpo10+1
>
> Assuming this is a 5.9.0 vanilla kernel, or something close enough,
> then you are missing some bug fixes that are likely to solve this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0b3f407e6728d990ae1630a02c7b952c21c288d3
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9c2b4e0347067396ceb3ae929d6888c81d610259
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D98272bb77bf4cc20ed1ffca89832d713e70ebf09
>
> These are all in recent stable kernels (the versions listed in kernel.org=
).
>
> > (2020-12-31) x86_64 GNU/Linux
> >
> > btrfs-progs v5.10
>
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D
