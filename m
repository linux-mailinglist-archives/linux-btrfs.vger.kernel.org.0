Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE20343519
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Mar 2021 22:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhCUVzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhCUVzD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 17:55:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D708C061762
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 14:55:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g15so8759635qkl.4
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8GR/pRxpW5eF/LotnQt5EqS0zEF7EhUF06NImNrpVwk=;
        b=sVjhcxejAm47gWIko97j1c96361VRPkK9dbLrTTaH84BG9rYGraYKzrJbImr83fnBF
         ilxH+f26kSittuWUX3V6pmCz1SzZdIgK999Kxleq4jrWnGhgWsPox9FJ8U9yr9hQ3UeL
         5pzGekqCkI0Z/K/TlgwLQKXpBZyhJzL6xXvhQBr3/xIr0LtEZxKlcuwUeDfvFtCGUXCw
         PHSjvsjrakS3/RU2ZAdj9alY4E31bXSphwMj42kRuJxFJADCuhCwdNbjvTQvA1M3hCpm
         KDa45JzqNOZBx/btg1YlbVeZ/fw2Qx+WJSvMaUii2tz+sYaIPD+tr00NQMjlmwN3KKaY
         N/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8GR/pRxpW5eF/LotnQt5EqS0zEF7EhUF06NImNrpVwk=;
        b=aKzbx6H78bn/2es2alMObMEc5ho1PoLVt3YiARFqnxTH39iOMPIlxiQ0K6n2nqzgkZ
         FVhA2g+lhE84VGKdYMm0+8BRUPyNNLEH41i+/XF9RiaFpQFZqWfOF2UxC4Eh+qfJGTM+
         KgarnTZciRsF8rs1D3qiR7kIk14OCBD1ISKsHsRConQMEQbOrGkQ3pM8lotYUf6b+43h
         y7HlIZqhS5VcwvyY57I+cBgi2kQ7sGk3rc4tlIYrk/vhhuLaeJm105xrh8gU9WeBO8Ae
         SZUFvCJde9N+rEJsROWg5AN0U5NTA2VvjCngUQjlgMuGRUh7Hfx3zj29vVf5VuabzNCW
         P61Q==
X-Gm-Message-State: AOAM530iUDWyl+AjKpYRwbcPazxAhTplqcWLxZULO0xUn8bbcPv4wvEV
        HUZmMmTqVT3FEMmA4JXWAporknEhBaoqbn2twl0=
X-Google-Smtp-Source: ABdhPJxmH4yxFJUaOwQvu6wQsuE8DAkQKLZtydzeQQ7gs079rlGVEFgnA7tQzMwxgVK17+Nq8GrRqMz36fbRRi3n7aE=
X-Received: by 2002:a37:596:: with SMTP id 144mr8572364qkf.387.1616363702662;
 Sun, 21 Mar 2021 14:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210317012054.238334-1-davispuh@gmail.com> <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com> <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
 <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com> <CAOE4rSwOLQY1JWr-Mdq06Y9nwU_WcQBnfXZx3VWhRQGnBThHUQ@mail.gmail.com>
 <f48c758a-39a3-c73e-fc50-5ab37d2280f9@gmx.com>
In-Reply-To: <f48c758a-39a3-c73e-fc50-5ab37d2280f9@gmx.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sun, 21 Mar 2021 23:54:50 +0200
Message-ID: <CAOE4rSzF3g4nA3sXkzEi9MJxFGZ+Sp+POAQHVsXV531y4CJTiA@mail.gmail.com>
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sestd., 2021. g. 20. marts, plkst. 02:34 =E2=80=94 lietot=C4=81js Qu Wenruo
(<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>
>
>
> On 2021/3/19 =E4=B8=8B=E5=8D=8811:34, D=C4=81vis Mos=C4=81ns wrote:
> > ceturtd., 2021. g. 18. marts, plkst. 01:49 =E2=80=94 lietot=C4=81js Qu =
Wenruo
> > (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
> >>
> >>
> >>
> >> On 2021/3/18 =E4=B8=8A=E5=8D=885:03, D=C4=81vis Mos=C4=81ns wrote:
> >>> tre=C5=A1d., 2021. g. 17. marts, plkst. 12:28 =E2=80=94 lietot=C4=81j=
s Qu Wenruo
> >>> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
> >>>>
> >>>>
> >>>>
> >>>> On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wrote:
> >>>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=
=81js D=C4=81vis Mos=C4=81ns
> >>>>> (<davispuh@gmail.com>) rakst=C4=ABja:
> >>>>>>
> >>>>>> Currently if there's any corruption at all in extent tree
> >>>>>> (eg. even single bit) then mounting will fail with:
> >>>>>> "failed to read block groups: -5" (-EIO)
> >>>>>> It happens because we immediately abort on first error when
> >>>>>> searching in extent tree for block groups.
> >>>>>>
> >>>>>> Now with this patch if `ignorebadroots` option is specified
> >>>>>> then we handle such case and continue by removing already
> >>>>>> created block groups and creating dummy block groups.
> >>>>>>
> >>>>>> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> >>>>>> ---
> >>>>>>     fs/btrfs/block-group.c | 14 ++++++++++++++
> >>>>>>     fs/btrfs/disk-io.c     |  4 ++--
> >>>>>>     fs/btrfs/disk-io.h     |  2 ++
> >>>>>>     3 files changed, 18 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >>>>>> index 48ebc106a606..827a977614b3 100644
> >>>>>> --- a/fs/btrfs/block-group.c
> >>>>>> +++ b/fs/btrfs/block-group.c
> >>>>>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs=
_info *info)
> >>>>>>            ret =3D check_chunk_block_group_mappings(info);
> >>>>>>     error:
> >>>>>>            btrfs_free_path(path);
> >>>>>> +
> >>>>>> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS=
)) {
> >>>>>> +               btrfs_put_block_group_cache(info);
> >>>>>> +               btrfs_stop_all_workers(info);
> >>>>>> +               btrfs_free_block_groups(info);
> >>>>>> +               ret =3D btrfs_init_workqueues(info, NULL);
> >>>>>> +               if (ret)
> >>>>>> +                       return ret;
> >>>>>> +               ret =3D btrfs_init_space_info(info);
> >>>>>> +               if (ret)
> >>>>>> +                       return ret;
> >>>>>> +               return fill_dummy_bgs(info);
> >>>>
> >>>> When we hit bad things in extent tree, we should ensure we're mounti=
ng
> >>>> the fs RO, or we can't continue.
> >>>>
> >>>> And we should also refuse to mount back to RW if we hit such case, s=
o
> >>>> that we don't need anything complex, just ignore the whole extent tr=
ee
> >>>> and create the dummy block groups.
> >>>>
> >>>
> >>> That's what we're doing here, `ignorebadroots` implies RO mount and
> >>> without specifying it doesn't mount at all.
> >>>
> >>>>>
> >>>>> This isn't that nice, but I don't really know how to properly clean=
 up
> >>>>> everything related to already created block groups so this was easi=
est
> >>>>> way. It seems to work fine.
> >>>>> But looks like need to do something about replay log aswell because=
 if
> >>>>> it's not disabled then it fails with:
> >>>>>
> >>>>> [ 1397.246869] BTRFS info (device sde): start tree-log replay
> >>>>> [ 1398.218685] BTRFS warning (device sde): sde checksum verify fail=
ed
> >>>>> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
> >>>>> [ 1398.218803] BTRFS warning (device sde): sde checksum verify fail=
ed
> >>>>> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
> >>>>> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:305=
4:
> >>>>> errno=3D-5 IO failure
> >>>>> [ 1398.218828] BTRFS: error (device sde) in
> >>>>> btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
> >>>>> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
> >>>>> errno=3D-5 IO failure (Failed to recover log tree)
> >>>>> [ 1398.229048] BTRFS error (device sde): open_ctree failed
> >>>>
> >>>> This is because we shouldn't allow to do anything write to the fs if=
 we
> >>>> have anything wrong in extent tree.
> >>>>
> >>>
> >>> This is happening when mounting read-only. My assumption is that it
> >>> only tries to replay in memory without writing anything to disk.
> >>>
> >>
> >> We lacks the check on log tree.
> >>
> >> Normally for such forced RO mount, log replay is not allowed.
> >>
> >> We should output a warning to prompt user to use nologreplay, and reje=
ct
> >> the mount.
> >>
> >
> > I'm not familiar with log replay but couldn't there be something
> > useful (ignoring ref counts) that would still be worth replaying in
> > memory?
> >
> Log replay means metadata write.
>
> Any write needs a valid extent tree to find out free space for new
> metadata/data.
>
> So no, we can't do anything but completely ignoring the log.
>

I see, updated patch. But even then it seems it could be possible to
add new ramdisk and make allocations there (eg. create new extent tree
there) thus allowing replay. I guess that's way too much work.
Anyway thanks for feedback!

Best regards,
D=C4=81vis
