Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA39655C0B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Dec 2022 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiLYAlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Dec 2022 19:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYAlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Dec 2022 19:41:11 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A337641
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Dec 2022 16:41:10 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a14so5457873pfa.1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Dec 2022 16:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgquTxVe8hxcW08HhgnOuSS/9MOj/zsfTqP3OfegaNA=;
        b=CkiLqh2LfTMsNHRqWcyXsgWWk2lYL/N5+jUHTbU1JW4WCSAgciq18PWAxJlSIiAsab
         g/Rum2bnQqRD/PRl2fJfk+mNyaHS771IsKd0PQA2Yy1t1JI8NQySbWmE8xL5CJW7STFN
         njwLVAo1VHy/25Th8g2JJtP+nxfezQ/MELcZT0l7UYSTE2vXyAZdRmCSy3wwSbbxSCah
         dg1Dl2bV4VQQAuprGq8w4FN0LrhXgQBp2Tf8T0UZ7MSs8Ptf855RJBF63tNdS3E5yN3p
         2saKdfUSsCuObgXI76jnOCzR8uOxAUMksCj2H3/dv3Xk74Mh1MAJdp1Er7lp07QnRl2Y
         UkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgquTxVe8hxcW08HhgnOuSS/9MOj/zsfTqP3OfegaNA=;
        b=s9u548HjpM6aGyjA8u4x7/LalbZd+G71rtuDubKxbuhxJPaOFkmk4H66uaL0HC/Q5r
         No/+III7rUpLes7IDR/L48DwObRltpxLBGygToyJ06nRb/CO33nTU6gygb2TYpE5Z+7O
         UJzxTO5xTBcOjKoGEy6XymXHgtX4SxJ+YK8tfsdHaulaUadoB9pwMu6zG2gHgDxzlfTr
         YB1howbfXgxR3vSgd1B3yuA1sJmz6xoP6oAs0P9ZAONlt0Kab3BHl6Qp5B0VZvHvyDsp
         V8UbpzPuRx8n5ReO4f5ug1rrdAQ+dtYJHaLIQG06w2jxCDQWok/xnysCoOWSKBtBcEyl
         Uo+Q==
X-Gm-Message-State: AFqh2kofBqvPpmYx8JO749P6gP2JNPFf3/ZfHwHNMXoGgLZlCJe/bUTp
        9NCAR0PabuaPylVp7PYYgxZsSixn+MKuLd6FNLGPtQ==
X-Google-Smtp-Source: AMrXdXvT2cDO6k5DCSdnwPnTYYVnSIJD9VrxAE9e8eQKlAc4l/Uq6LoLp5Ff7/8zS2GSEc23ZuyYHkDtdREKGb1POYw=
X-Received: by 2002:a62:f202:0:b0:576:d016:ace2 with SMTP id
 m2-20020a62f202000000b00576d016ace2mr787618pfh.45.1671928869401; Sat, 24 Dec
 2022 16:41:09 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBewVqdWU8O4jBqneexYKZGHLSDEhFCwKj+mL5+OjcWeYg@mail.gmail.com>
 <e4491c53-1869-9a85-f656-f2e35acd8b65@suse.com> <CAL3q7H5uWor=cWiVAvDtkQNa_OrDFe7eq89_RZroTD4Mn8r0wA@mail.gmail.com>
In-Reply-To: <CAL3q7H5uWor=cWiVAvDtkQNa_OrDFe7eq89_RZroTD4Mn8r0wA@mail.gmail.com>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Sun, 25 Dec 2022 03:40:58 +0300
Message-ID: <CAN4oSBc24UVkwRKbXV174dmJRd3gchJHa9mf2w0nrvUCbi6nGA@mail.gmail.com>
Subject: Re: Doing anything with the external disk except mounting causes
 whole system lockup
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since I didn't find the stable 6.0 kernel package in Debian
repositories, I downgraded the kernel to 5.19.0-0.deb11.2-amd64. This
solved the issue.

Thank you.

Filipe Manana <fdmanana@kernel.org>, 20 Ara 2022 Sal, 14:57 tarihinde
=C5=9Funu yazd=C4=B1:
>
> On Tue, Dec 20, 2022 at 11:52 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > On 2022/12/20 01:32, Cerem Cem ASLAN wrote:
> > > I've been using my scripts for mounting partitions, unmounting, btrfs
> > > send|receive etc. while I'm dealing with my external/backup hard
> > > disks.
> > >
> > > Recently I had trouble so I reformatted my external spinning disk and
> > > transferred all snapshots to it (~800GB).
> > >
> > > At the end of transfer, there was an error (I might have modified the
> > > bash script that is currently running) so after finishing the `btrbk
> > > ...` command, my script gave an error (that's normal), so I restarted
> > > it. From this moment on, I could mount my partitions but I never did =
a
> > > btrfs send|receive or scrub or unmount again because the system was
> > > simply getting locked up.
> > >
> > > I run `dmesg -w` command on another terminal but I didn't save it
> > > (because the system was locked), so I took a photo of it:
> > > https://imgur.com/LJfgjbY
> >
> > RCU stall, then it can be anything, I doubt if it's really btrfs causin=
g
> > the problem.
>
> Nop, it's a btrfs problem.
> This was caused by a bad backport to 6.0.3, which is what Cerem is
> running according to the screenshot.
>
> This has been reported before, for example at:
>
> https://lore.kernel.org/linux-btrfs/2291416ef48d98059f9fdc5d865b0ff040148=
237.camel@scientia.org/
> https://lore.kernel.org/linux-btrfs/1c531dd5de7477c8b6ec15d4aebb8e42ae460=
925.camel@scientia.org/
>
> This was eventually fixed in 6.0.5:
>
> https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.0.5
>
> by commit:
>
> commit 217fd7557896d990c3dd8beea83a6feeb504f235
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Wed Oct 26 12:24:13 2022 +0200
>
>     Revert "btrfs: call __btrfs_remove_free_space_cache_locked on
> cache load failure"
>
>     This reverts commit 3ea7c50339859394dd667184b5b16eee1ebb53bc which is
>     commit 8a1ae2781dee9fc21ca82db682d37bea4bd074ad upstream.
>
>     It causes many reported btrfs issues, so revert it for now.
>
>     Cc: Josef Bacik <josef@toxicpanda.com>
>     Cc: David Sterba <dsterba@suse.com>
>     Cc: Sasha Levin <sashal@kernel.org>
>     Reported-by: Tobias Powalowski <tobias.powalowski@googlemail.com>
>     Link: https://lore.kernel.org/r/CAHfPjO8G1Tq2iJDhPry-dPj1vQZRh4NYuRmh=
HByHgu7_2rQkrQ@mail.gmail.com
>     Reported-by: Ernst Herzberg <earny@net4u.de>
>     Link: https://lore.kernel.org/r/8196dd88-4e11-78a7-8f96-20cf3e886e68@=
net4u.de
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> So just upgrade the kernel in your distro, the latest 6.0 stable
> release is 6.0.14, so anything between 6.0.5 and that should be fine.
>
>
> >
> > In fact, I hit similar problems before, very randomly, sometimes when
> > playing some steam games, sometimes just random crash/lockup.
> >
> > At least if you can setup a netconsole, we can have better view of the
> > whole situation.
> >
> > In my case, netconsole also sometimes points to RCU, sometimes some
> > random generic protection error.
> >
> > I tried replacing my RAM, no help. Finally I brought a new mobo and CPU
> > (switched from 5900X + B450I to 13700K + B660I) and no crash anymore.
> >
> > Thus if you're hitting RCU stalls, I'd strongly recommend to test the
> > same fs on other systems.
> >
> > Thanks,
> > Qu
> > >
> > > I haven't lost any data and I still have another backup disk, so no
> > > worries. I'm just keeping the disk just in case you may require some
> > > more information this week.
> > >
> > > * Linux erik3 6.0.0-0.deb11.2-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> > > 6.0.3-1~bpo11+1 (2022-10-29) x86_64 GNU/Linux
> > > * btrfs-progs v5.10.1
> > > * mount options I'm using: rw,noatime
