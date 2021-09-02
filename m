Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115BB3FF1E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346469AbhIBQ5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhIBQ5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 12:57:23 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263DC061575
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 09:56:24 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id d6so2084681vsr.7
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpXrJx3DD4mE2SiaRmTzwvAkvYHEAlZ0VMeFXoZm0WE=;
        b=aUMyBcowv96ZV1yP0CHLYCjlRKQ3Y5lVwzsJ5fp41//j3wzZqzvqV3BbqrnI25KTa/
         TA8pZIlsNWZhfbJj0tEd7Db19KZUCAFvicoi3udTMxs+zcyq+HK8oMTdw3DRQgSY+DCi
         nSSccpxdYvi8+R5Sijs2ni9P8wRxnFehbdytx4VFo5yPOlcLHlrqBgTtZeHxjc6bPfR4
         Yr/RnZ0K0otEJUKw81kVrXhws6w/KO1o0teGK3XBBt1G4KWlXC6nTXsuakYxhsehh+gb
         I3lhrhvzSes7mTWT/VezNTp7mdYlxuqY+U4as5NOr67xKEOJduHYKCiYSItAfm3PMBk3
         hKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpXrJx3DD4mE2SiaRmTzwvAkvYHEAlZ0VMeFXoZm0WE=;
        b=JucJDlKcniOjpfsT8qn+tG/lmxYQ5MoGmPx/t6JwbSwVASLnLsdWyo/jEuzF7J23Zn
         POyHxEIVBNUzoNkQwrv5ILot2jYTUgnXZzUx1S9Uam/PXZ5jZ5IaUXsjvULY5pVmboXN
         tJzn0mMRq97inHS5PIidNxkNHJgKdZJPx+tbe4Vuu/mbf6mvEEWC7nn/TVOjcFPcECST
         4YyBNdqhA7AOGruISQv//VFbK0G2ep84IsNTdrCEP90f7pWGZmqXrzhcET+fl0gFHzLP
         E+GhyqOEUQHOovoj5miaO0qMttAk0t+LPx0JnV6pTQvLylYS7MSrIvzMX9BN33B1Uax4
         /hxg==
X-Gm-Message-State: AOAM5323GfeRHK8IsORT5WMGZOWozz8QXphviHL8S38bZqPwndAsLtOZ
        +tI2c2JBdpSCtiFSOoVmQTy4dxnTSfDzI8rN5LQ=
X-Google-Smtp-Source: ABdhPJx0fEKO9FzxyDnb8ejmHDQu/TImj3GnqjfvPprrnkf+9zd2hX/vY6Gsxro2e+xpH9/+vLCkSvTvcnWehwpNR7E=
X-Received: by 2002:a67:f98d:: with SMTP id b13mr3297868vsq.58.1630601783941;
 Thu, 02 Sep 2021 09:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com> <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com> <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com> <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
 <a0990c37-0b94-53e7-051e-ee7667c4bc94@oracle.com>
In-Reply-To: <a0990c37-0b94-53e7-051e-ee7667c4bc94@oracle.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Thu, 2 Sep 2021 19:56:12 +0300
Message-ID: <CAOE4rSzkodTb0DFOS4C1tDU-7PVie9v5Sa=yTHHKS5YWQXnKMQ@mail.gmail.com>
Subject: Re: btrfs mount takes too long time
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Jingyun He <jingyun.ho@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ceturtd., 2021. g. 2. sept., plkst. 00:31 =E2=80=94 lietot=C4=81js Anand Ja=
in
(<anand.jain@oracle.com>) rakst=C4=ABja:
>
> On 02/09/2021 00:11, D=C4=81vis Mos=C4=81ns wrote:
> > pirmd., 2021. g. 30. aug., plkst. 16:08 =E2=80=94 lietot=C4=81js Anand =
Jain
> > (<anand.jain@oracle.com>) rakst=C4=ABja:
> >>
> >> open_ctree() took 228254398 us. And 98% of it that is 225418272 us
> >> was taken by btrfs_read_block_groups().
> >>
> >> -------------------
> >>    1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
> >>    1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
> >>    0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
> >>    0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
> >>    0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
> >>    0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
> >>    0) 0.865 us | btrfs_discard_resume [btrfs]();
> >>    0) $ 228254398 us | } /* open_ctree [btrfs] */
> >> -------------------
> >>
> >> Now we need to run the same thing on btrfs_read_block_groups(),
> >> could you please run.. [1] (no need of the time).
> >>
> >> [1]
> >>     $ umount /btrfs;
> >>     $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
> >> /dev/vg/scratch0 /btrfs"
> >>
> >> Thanks, Anand
> >>
> >>
> >
> > Hi,
> >
> > I also have a btrfs filesystem that takes a while to mount.
> > So I'm interested if this could be improved.
> >
> > $ ./ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/md127 -o
> > space_cache=3Dv2,compress=3Dzstd,acl,subvol=3DData /mnt/Data/"
>
>   It is better if we don't use the time prefix for the mount command
>   here. The ftrace, traces time syscall as well, which is unessential.
>   And we lose a lot of trace-buffer to it.
>
> > kernel.ftrace_enabled =3D 1
> >
> > real    1m33,638s
> > user    0m0,000s
> > sys     0m1,130s
> >
> > Here's the trace output https://d=C4=81vis.lv/files/ftracegraph.out.gz
> >
> > The filesystem is on top of RAID6 mdadm array which is from 9x 3TB HDDs=
.
>
>   So here is a case of a non-zoned device.
>
>   Again it is btrfs_read_block_groups() which is taking ~98% of the time.
>
>     3) $ 91607669 us |    } /* btrfs_read_block_groups [btrfs] */
>     3) # 9399.566 us |    btrfs_check_rw_degradable [btrfs]();
>     3)   0.922 us    |    btrfs_apply_pending_changes [btrfs]();
>     3) ! 186.540 us  |    btrfs_read_qgroup_config [btrfs]();
>     3) * 26109.92 us |    btrfs_get_root_ref [btrfs]();
>     3) + 23.965 us   |    btrfs_start_pre_rw_mount [btrfs]();
>     3)   1.192 us    |    btrfs_discard_resume [btrfs]();
>     3) $ 93501136 us |  } /* open_ctree [btrfs] */
>
>   Could we pls get this?
>
>   $ ./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount ..."
>
>   Hopefully, there won't be a trace-buffer rollover here, as we saw in
>   the other case so that we could account for all the time spent.

Sure, here https://d=C4=81vis.lv/files/ftracegraph_v2.out.gz

>   Also, let's understand how many block groups are there.
>
>   $ btrfs in dump-tree <dev> | grep BLOCK_GROUP_ITEM | wc -l

It's 22660
Also by the way `-t EXTENT_TREE` should be faster

Best regards,
D=C4=81vis
