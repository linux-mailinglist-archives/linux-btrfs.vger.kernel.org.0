Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142B73203AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 05:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBTE3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 23:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBTE3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 23:29:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D321C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 20:28:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n10so9432064wmq.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 20:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=okIbLDRpIsOmH2wPAbQG9YxHcYVuuy+QDO3zZienUCw=;
        b=Tl6JpyfLAO9HievTsNyKMZyH7MOUuLUEfqwrlzrJnck7IsiiG3VnSeC6ORlel+618o
         W/mAS1L1sgTxFkB5qaQrHubVL7iZJEeSoumr+kylBqNc8ZO/wcQz/PhaqaEWAqJPyG+g
         sc9UPUcQhM5QAFgd9GxSx8Lxxtinh7nes01tvz0ZZX3mKZhcMXDF5My+hMk3waoSXoHV
         CZgdobQ/RL9/ONme1wHAt/xnxylt7NTai0zzST+77NZKKJr+Fzi/03izhs+gJASGoNC3
         zkjHSi5G4N1dFELMRK4EeTBA/V71Bv2QIAgUwNw7mErtxUHx28fm2sTazNrkKnJZYVvj
         5cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=okIbLDRpIsOmH2wPAbQG9YxHcYVuuy+QDO3zZienUCw=;
        b=VVeH8jApNtj13kIofhwKaaseNxJuCy2VPVKd7fhiUD9LtTi78CquOgO4jYlWKOtaQp
         1f1WEuwnBAtpKUJan7SypaHhC7X1VxNrCLu3D5vIdEJGymm8YtOSPf2AgDMSe2ZWP9li
         tOSelFZkZRtoecFX2dpvwAyDWYDDoWuvBccl0Bx4LJH1PnH8LI4wZ1ouDfelCYS1EiYD
         hAIZ/BHveKkYz4vrd1r41vzIbnlMY2luLdxJ3BzdOCF8cVo15k9XjvDJYAGB0Izu8+FC
         jCZBK2dKBuMRWbPlhoux/5laNx3XrhaDQm2MuoLXFLphvAzB9skj8TY+ehHixB4dgzKw
         Evzw==
X-Gm-Message-State: AOAM533i99CtdqO5mML54dONloI/GLHKmyo21JPIz9NF97mSG07Fiu5J
        piJ81wWvDPjgAZQN/u8Sw/7BSI321IqcGYprbI8tWgZL7Jvvl+8/
X-Google-Smtp-Source: ABdhPJzdKnKFowOmnivBYSWuLj0y+PeqjIGSUy6vay3gfaVsjYq6FuZzmSiWQNUQddta4tDLrcePyj2VLriYiNFlz4o=
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr3644172wmc.12.1613795307187;
 Fri, 19 Feb 2021 20:28:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com> <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com> <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com> <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com> <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com> <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
 <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com> <CAMj6ewPGbkxH-OdsRt+xKQyLUUgR3J7dV7Xcf9XMq2-E=n3-tA@mail.gmail.com>
 <b040e855-c0a6-cd75-c26a-4ed73ffeb08d@gmx.com> <CAMj6ewOJpH_Lo3JcL540-ACwvbFNr33XS0LixEt+wAzf-T4vag@mail.gmail.com>
 <707ded00-c6e1-ba27-c12a-3ed7111620d8@gmx.com>
In-Reply-To: <707ded00-c6e1-ba27-c12a-3ed7111620d8@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Fri, 19 Feb 2021 20:28:16 -0800
Message-ID: <CAMj6ewON-ADoVKRL8yhy+vYaKoxGd=YwdpZkrDRRRG_8aOMjeA@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 7:16 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2021/2/20 =E4=B8=8A=E5=8D=8810:47, Erik Jensen wrote:
> > Given that it sounds like the issue is the metadata address space, and
> > given that I surely don't actually have 16TiB of metadata on a 24TiB
> > file system (indeed, Metadata, RAID1: total=3D30.00GiB, used=3D28.91GiB=
),
> > is there any way I could compact the metadata offsets into the lower
> > 16TiB of the virtual metadata inode? Perhaps that could be something
> > balance could be taught to do? (Obviously, the initial run of such a
> > balance would have to be performed using a 64-bit system.)
>
> Unfortunately, no.
>
> Btrfs relies on increasing bytenr in the logical address space for
> things like balance, thus we can't relocate chunks to smaller bytenr.

That's=E2=80=A6 unfortunate. How much relies on the assumption that bytenr =
is monotonic?

Brainstorming some ideas, is compacting the address space something
that could be done offline? E.g., maybe some two-pass process: first
something balance-like that bumps all of the metadata up to a compact
region of address space, starting at a new 16TiB boundary, and then a
follow up pass that just strips the top bits off?

Or maybe once all of the bytenrs are brought within 16TiB of each
other by balance, btrfs could just keep track of an offset that needs
to be applied when mapping page cache indexes?

Or maybe btrfs could use multiple virtual inodes on 32-bit systems,
one for each 16TiB block of address space with metadata in it? If this
were to ever grow to need more than a handful of virtual inodes, it
seems like a balance *would* actually help in this case by compacting
the metadata higher in the address space, allowing the virtual inodes
for lower in the address space to be dropped.

Or maybe btrfs could just not use the page cache for the metadata
inode once the offset exceeds 16TiB, and only cache at the block
layer? This would surely hurt performance, but at least the filesystem
could still be accessed.

Given that this issue appears to be not due to the size of the
filesystem, but merely how much I've used it, having the only solution
be to copy all of the data off, reformat the drives, and then restore
every time filesystem usage exceeds a certain thresholds is=E2=80=A6 not ve=
ry
satisfying.

Finally, I've never done kernel dev before, but I do have some C
experience, so if there is a solution that falls into the category of
seeming reasonable, likely to be accepted if implemented, but being
unlikely to get implemented given the low priority of supporting
32-bit systems, let me know and maybe I can carve out some time to
give it a try.
