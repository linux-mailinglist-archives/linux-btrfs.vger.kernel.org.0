Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8652E7064
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 12:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbfJ1LaN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 07:30:13 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42807 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbfJ1LaN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 07:30:13 -0400
Received: by mail-vk1-f195.google.com with SMTP id r4so1921689vkf.9
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2019 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kBE+rffRjyE01fuPKJNIWsB2jSHyNRRzTtA/N3s98JY=;
        b=N2+rAVBL5ieUWo9UVGhS4sktrAfRtlQ9OXgUOxncPgGzhcadT9l4ze2Vyg7SP/JzAy
         iaoaGkTfNZs2BenSMoLshmEWKvUapGLfGO51LZ2mE28AcwF0/vZ66+Ob85rR5AMO+Tze
         pzR41RzaED5uzoouS9zwWnqLTpppbr4+M24BacMm6vKf/kihsVhtTcs3Q87uugfg1xDe
         2ik3wukJxLuzwrgbOS1M+he9RX7N29Kp6JztvortfzuK0JLkBSNY0hDSrks+cyStDh66
         /yl5evyKsVVvF7MVopdZNEiPi3iJVThIynXv5W3hgc6IcaPBRIDhNncxWhVRF+MKMGl6
         W9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kBE+rffRjyE01fuPKJNIWsB2jSHyNRRzTtA/N3s98JY=;
        b=D2AvH0I06LXce6atSdM+9nhKlIkaWzj1JTV/pdSz28KzuDCABSAX75v6GhwKEWa3zt
         f35BO7j6oJX9Kw/L8W51u+8Hw2+DK7pQcnpM4XYGmLLY2rcRMUlhZH8biIIB2m8vMD6u
         fOiDpNqyW5ttSkEUZNTWVKKYKiItAnKnqRdl3rCsK60ExFnMGkl7LI8dwMxk15IwL2aC
         aJbVljC9Oo0cMPxpcvYj9hsN/MGFqfHAA2rVFZdHzR27xphwDmuzxheMC7w9LImNwPBA
         6ukXOxO8lmh9RlXyCseouzw1F6z1UV7ZBd8rH/qYcVBm7GX/vBHqxrFlG0upO/aV87lG
         0Plw==
X-Gm-Message-State: APjAAAXQKhheQdAs3/9uum5pUWGoIy6kOsmRgFhUPUcyIv+Sa7F3v7B8
        ggJjA6wI1YSMfsSDAtsVrnn3BZQBQypUU6Cpm3U=
X-Google-Smtp-Source: APXvYqxpJT9VJAoBzTI6eJdRIWqrj3Fwj5dfRmhvkqFQVzMwEbm6rQcDtk7aZY24pdnwL6W2xCh20QJUH1tzXtj/BlU=
X-Received: by 2002:a1f:5847:: with SMTP id m68mr8206593vkb.24.1572262212496;
 Mon, 28 Oct 2019 04:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
In-Reply-To: <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 28 Oct 2019 11:30:01 +0000
Message-ID: <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Atemu <atemu.main@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 27, 2019 at 4:51 PM Atemu <atemu.main@gmail.com> wrote:
>
> > It's really hard to determine, you could try the following command to
> > determine:
> > # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
> >   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
> >
> > Then which key is the most shown one and its size.
> >
> > If a key's objectid (the first value) shows up multiple times, it's a
> > kinda heavily shared extent.
> >
> > Then search that objectid in the full extent tree dump, to find out how
> > it's shared.
>
> I analyzed it a bit differently but this should be the information we wan=
ted:
>
> https://gist.github.com/Atemu/206c44cd46474458c083721e49d84a42

That's quite a lot of extents shared many times.
That indeed slows backreference walking and therefore send which uses it.
While the slowdown is known, the memory consumption I wasn't aware of,
but from your logs, it's not clear
where it comes exactly from, something to be looked at. There's also a
significant number of data checksum errors.

I think in the meanwhile send can just skip backreference walking and
attempt to clone whenever the number of
backreferences for an inode exceeds some limit, in which case it would
fallback to writes instead of cloning.

I'll look into it, thanks for the report (and Qu for telling how to
get the backreference counts).

>
> Yeah...
>
> Is there any way to "unshare" these worst cases without having to
> btrfs defragment everything?
>
> I also uploaded the (compressed) extent tree dump if you want to take
> a look yourself (205MB, expires in 7 days):
>
> https://send.firefox.com/download/a729c57a94fcd89e/#w51BjzRmGnCg2qKNs39UN=
w
>
> -Atemu



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
