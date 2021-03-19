Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5801134210B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 16:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCSPfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCSPe6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 11:34:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101AC06174A;
        Fri, 19 Mar 2021 08:34:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y2so4577421qtw.13;
        Fri, 19 Mar 2021 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1wToAptgvmx1pP3W3ajbBz+OQPaL9E12cpuwf2DkE1Y=;
        b=FcKIp5MUMsntTvqGYoWiWNhtlY1Ky+/4+hKwKgoT52yg00EU7YBmAJBvHvuWdE83rn
         2pySaZPCS5hFnCATk5INZwAIX4q2MgbmTZJCLioozM21jeAHDdhG87z93OF9gp+oE/oa
         rhx3cqzkPmpci+0fxTqz6E2QiGAl5WPwq01t29tfy6ESgudm+T5HIWs3nO3ISe5mOHLI
         nv+IaQZGJwn1zuNitQzdNE/I9U+6A/nMSQgaGZB8NwIhMT3aHBXAyiETVtV3dgxXO4Se
         XroqPFfYLerZaXq4DhpNXJH4WN5OLFXpFfNJVKVa/+ek/sOklUP6Znfk2UZ1nsbaypae
         LSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1wToAptgvmx1pP3W3ajbBz+OQPaL9E12cpuwf2DkE1Y=;
        b=l25aw0fdd2QNEfcUewZipBrfaznq7yu54SSRRu+e7l/rlMh7fdjAQ44mlpqa2VWeaJ
         4hONrOLrVGQgMsvROhlYmLYLICwjOv5NEoIqqesEang7igLi5neEcXNbMi926iQx2lqW
         3F9awby4SVQ8v5Tnpt+uw1XI44hy5E0LPQiYYsZAwEIizMuVJdBwbDEhPpDXYUu6QXtT
         HVgNSea3WlX28AeDMI3jl1+KSTLv0H+/ch9AHIMvYIFDAgfUFFUJ4cXQy3PQ1ZWfC9La
         iwBOUpte+Ktyg6ly/rjR6XBSAKAe+jQJUKhtkb28/zyHOXy5r+vgKb8Zv85QKndICsTo
         i9Xg==
X-Gm-Message-State: AOAM530DOgvBFaiivTcSKc1GTk3LH6c6w8hAvvs1JiwYq40IJrwQ0+cV
        RkDtoEiIzyg7e6ZD3seuXU/hkjr96usiCoWRHOU=
X-Google-Smtp-Source: ABdhPJwHsSx5PwzChJ/Z6OOE1z7Kcl1SoVN80Zxwhhg845SFYRTatt3lo3KhLXiY/8pe4sWk6KUdKk1HWHc035PUYk8=
X-Received: by 2002:ac8:57cf:: with SMTP id w15mr8735375qta.336.1616168097075;
 Fri, 19 Mar 2021 08:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210317012054.238334-1-davispuh@gmail.com> <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com> <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
 <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com>
In-Reply-To: <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Fri, 19 Mar 2021 17:34:45 +0200
Message-ID: <CAOE4rSwOLQY1JWr-Mdq06Y9nwU_WcQBnfXZx3VWhRQGnBThHUQ@mail.gmail.com>
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

ceturtd., 2021. g. 18. marts, plkst. 01:49 =E2=80=94 lietot=C4=81js Qu Wenr=
uo
(<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>
>
>
> On 2021/3/18 =E4=B8=8A=E5=8D=885:03, D=C4=81vis Mos=C4=81ns wrote:
> > tre=C5=A1d., 2021. g. 17. marts, plkst. 12:28 =E2=80=94 lietot=C4=81js =
Qu Wenruo
> > (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
> >>
> >>
> >>
> >> On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wrote:
> >>> tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=81j=
s D=C4=81vis Mos=C4=81ns
> >>> (<davispuh@gmail.com>) rakst=C4=ABja:
> >>>>
> >>>> Currently if there's any corruption at all in extent tree
> >>>> (eg. even single bit) then mounting will fail with:
> >>>> "failed to read block groups: -5" (-EIO)
> >>>> It happens because we immediately abort on first error when
> >>>> searching in extent tree for block groups.
> >>>>
> >>>> Now with this patch if `ignorebadroots` option is specified
> >>>> then we handle such case and continue by removing already
> >>>> created block groups and creating dummy block groups.
> >>>>
> >>>> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> >>>> ---
> >>>>    fs/btrfs/block-group.c | 14 ++++++++++++++
> >>>>    fs/btrfs/disk-io.c     |  4 ++--
> >>>>    fs/btrfs/disk-io.h     |  2 ++
> >>>>    3 files changed, 18 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >>>> index 48ebc106a606..827a977614b3 100644
> >>>> --- a/fs/btrfs/block-group.c
> >>>> +++ b/fs/btrfs/block-group.c
> >>>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_i=
nfo *info)
> >>>>           ret =3D check_chunk_block_group_mappings(info);
> >>>>    error:
> >>>>           btrfs_free_path(path);
> >>>> +
> >>>> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS))=
 {
> >>>> +               btrfs_put_block_group_cache(info);
> >>>> +               btrfs_stop_all_workers(info);
> >>>> +               btrfs_free_block_groups(info);
> >>>> +               ret =3D btrfs_init_workqueues(info, NULL);
> >>>> +               if (ret)
> >>>> +                       return ret;
> >>>> +               ret =3D btrfs_init_space_info(info);
> >>>> +               if (ret)
> >>>> +                       return ret;
> >>>> +               return fill_dummy_bgs(info);
> >>
> >> When we hit bad things in extent tree, we should ensure we're mounting
> >> the fs RO, or we can't continue.
> >>
> >> And we should also refuse to mount back to RW if we hit such case, so
> >> that we don't need anything complex, just ignore the whole extent tree
> >> and create the dummy block groups.
> >>
> >
> > That's what we're doing here, `ignorebadroots` implies RO mount and
> > without specifying it doesn't mount at all.
> >
> >>>
> >>> This isn't that nice, but I don't really know how to properly clean u=
p
> >>> everything related to already created block groups so this was easies=
t
> >>> way. It seems to work fine.
> >>> But looks like need to do something about replay log aswell because i=
f
> >>> it's not disabled then it fails with:
> >>>
> >>> [ 1397.246869] BTRFS info (device sde): start tree-log replay
> >>> [ 1398.218685] BTRFS warning (device sde): sde checksum verify failed
> >>> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
> >>> [ 1398.218803] BTRFS warning (device sde): sde checksum verify failed
> >>> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
> >>> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:3054:
> >>> errno=3D-5 IO failure
> >>> [ 1398.218828] BTRFS: error (device sde) in
> >>> btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
> >>> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
> >>> errno=3D-5 IO failure (Failed to recover log tree)
> >>> [ 1398.229048] BTRFS error (device sde): open_ctree failed
> >>
> >> This is because we shouldn't allow to do anything write to the fs if w=
e
> >> have anything wrong in extent tree.
> >>
> >
> > This is happening when mounting read-only. My assumption is that it
> > only tries to replay in memory without writing anything to disk.
> >
>
> We lacks the check on log tree.
>
> Normally for such forced RO mount, log replay is not allowed.
>
> We should output a warning to prompt user to use nologreplay, and reject
> the mount.
>

I'm not familiar with log replay but couldn't there be something
useful (ignoring ref counts) that would still be worth replaying in
memory?
