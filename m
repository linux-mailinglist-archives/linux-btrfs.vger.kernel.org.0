Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD433FA43
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 22:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhCQVEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhCQVDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 17:03:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217FC06174A;
        Wed, 17 Mar 2021 14:03:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a11so2532694qto.2;
        Wed, 17 Mar 2021 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tTumWXKPeirhih82vHznyEMQk5Ce5y7T8VwAjdW2rck=;
        b=ULJSbzvSp3lAK8KFEC2FYoyxm69IHXmIJw7sepUgvC9EJcKa08CasMwgmLxHTtRpe8
         9dgklWrWwxQHY/bhVE3zMDHxls23888cxRZtsgn785MKaS3Jude6twOPs0cxvqo6MKsh
         IWiUa9DLfc0zv22dBhexoNvpquxvtoXM7GSdDMdPqZbxbAdBoyjlid+aZC9S7bwOFSrW
         sdaIaQdxBH+mH3KTqReqbPkqOlBdVi2Fo9oxnNoXK90wwKV/RJbzZKX/tuWBDpYLAKxJ
         2AEeB/LoamYa9KCb8+r1twE1DaAkGicMds+d25eixoRM6DwoB4nMiuLwOH7sShpxiyJT
         wj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tTumWXKPeirhih82vHznyEMQk5Ce5y7T8VwAjdW2rck=;
        b=ptAjExRH6wmCVRMaDBFUZtvol3Nxv+FgsA1mQbK2DUS5GFVua4Qctt9g+e2DmgcR6H
         pp4Fq4hDsWkbav/2tEk4dcGFuwZNCgRfv+EbHFgmoYoD0qyIDJ8SGornODGKggEqLXhM
         KcEg7W9wwQ6ifcLQVIt1jeSDsCtCAV/9pTa5+L3GFGIXxrKWlIzufQnnhlpvvN/KXKpV
         8Y/mCbx60UO2qpl+7dofH0VQn9prpUR4KzrZOrHNCtC8sR3atz9qYxXU8JlNZjN/nN/p
         ZphjRPu/GwBR38mZqkKmtARE3BxU9uhoj4XAc5mqUAOpE4sYrpoDxq1bS6DR8tKvOHDQ
         gohw==
X-Gm-Message-State: AOAM533Cvoud3Vb9QaqkUwuQahdI6pG7u3lLV8qo9CwcUCy0AIevUxBs
        v9dqmHkMXXnx4wds0K/P/5I6kKTZSh5/7bLAwwg=
X-Google-Smtp-Source: ABdhPJwm4YvE1JcC4KfXSPzAnKJUBMfzQq22eckkZK6VJ1P9qKUWPqTKUDP/DQPj9k0Z66fn2QxQbFjcAfG5alIeZL0=
X-Received: by 2002:ac8:66d6:: with SMTP id m22mr926873qtp.56.1616015021448;
 Wed, 17 Mar 2021 14:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210317012054.238334-1-davispuh@gmail.com> <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com>
In-Reply-To: <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 17 Mar 2021 23:03:30 +0200
Message-ID: <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

tre=C5=A1d., 2021. g. 17. marts, plkst. 12:28 =E2=80=94 lietot=C4=81js Qu W=
enruo
(<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>
>
>
> On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wrote:
> > tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=81js =
D=C4=81vis Mos=C4=81ns
> > (<davispuh@gmail.com>) rakst=C4=ABja:
> >>
> >> Currently if there's any corruption at all in extent tree
> >> (eg. even single bit) then mounting will fail with:
> >> "failed to read block groups: -5" (-EIO)
> >> It happens because we immediately abort on first error when
> >> searching in extent tree for block groups.
> >>
> >> Now with this patch if `ignorebadroots` option is specified
> >> then we handle such case and continue by removing already
> >> created block groups and creating dummy block groups.
> >>
> >> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> >> ---
> >>   fs/btrfs/block-group.c | 14 ++++++++++++++
> >>   fs/btrfs/disk-io.c     |  4 ++--
> >>   fs/btrfs/disk-io.h     |  2 ++
> >>   3 files changed, 18 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index 48ebc106a606..827a977614b3 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_inf=
o *info)
> >>          ret =3D check_chunk_block_group_mappings(info);
> >>   error:
> >>          btrfs_free_path(path);
> >> +
> >> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) {
> >> +               btrfs_put_block_group_cache(info);
> >> +               btrfs_stop_all_workers(info);
> >> +               btrfs_free_block_groups(info);
> >> +               ret =3D btrfs_init_workqueues(info, NULL);
> >> +               if (ret)
> >> +                       return ret;
> >> +               ret =3D btrfs_init_space_info(info);
> >> +               if (ret)
> >> +                       return ret;
> >> +               return fill_dummy_bgs(info);
>
> When we hit bad things in extent tree, we should ensure we're mounting
> the fs RO, or we can't continue.
>
> And we should also refuse to mount back to RW if we hit such case, so
> that we don't need anything complex, just ignore the whole extent tree
> and create the dummy block groups.
>

That's what we're doing here, `ignorebadroots` implies RO mount and
without specifying it doesn't mount at all.

> >
> > This isn't that nice, but I don't really know how to properly clean up
> > everything related to already created block groups so this was easiest
> > way. It seems to work fine.
> > But looks like need to do something about replay log aswell because if
> > it's not disabled then it fails with:
> >
> > [ 1397.246869] BTRFS info (device sde): start tree-log replay
> > [ 1398.218685] BTRFS warning (device sde): sde checksum verify failed
> > on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
> > [ 1398.218803] BTRFS warning (device sde): sde checksum verify failed
> > on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
> > [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:3054:
> > errno=3D-5 IO failure
> > [ 1398.218828] BTRFS: error (device sde) in
> > btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
> > [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
> > errno=3D-5 IO failure (Failed to recover log tree)
> > [ 1398.229048] BTRFS error (device sde): open_ctree failed
>
> This is because we shouldn't allow to do anything write to the fs if we
> have anything wrong in extent tree.
>

This is happening when mounting read-only. My assumption is that it
only tries to replay in memory without writing anything to disk.
