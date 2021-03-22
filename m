Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C810344AB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 17:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhCVQKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhCVQKX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 12:10:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAC0C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 09:10:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r14so12710366qtt.7
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YEpkk5sK455DARIOweEXLxPzsKa9rLlFhVNPcWB7ayo=;
        b=lBiy0wR4UiTBa1UW052w3kJJKHiGPYkYN2tP5Rxn1n2cSc2augYyVFarA9tIFJEYis
         iatteXngTJACfgfuh/vTAmM/XI6NZw4wAsjYhZDTdhd+w9GUFC6HOoeqkUov3e/5h/vi
         7m0IdpHpkud/kRLb8t+n9EGsx+tzMFpd4JpqrSoZDnT1KqWUwmvB1nkeCteRaWsD4N5i
         7eFhdB5wiwOjsm24nRzy1zuqWjmCKS57LsiCm/Q4wnesN87z8SAuLF0xgmLjcbGV4hhN
         utoWXTSbO5XduRPPBFR+ZbC4UiwO4DjaZ86SgXerZNNYLYh/6bsX2tEqjr7zXiADdwfX
         ZaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YEpkk5sK455DARIOweEXLxPzsKa9rLlFhVNPcWB7ayo=;
        b=hp3wtcrWbkf4n+c7B7N+M3puNEkOSj+ldG4snLD8gStQoe9w4OSwtSSzmnPTAcZAA/
         AYYZASRn2cdK78nLhrvaXa4F22wNWxjNDo2aaK2WbaykSDHG2MQfNspZuHatS/xJNVoJ
         SAN8ZrP81K0e30ob2Dly7UPAkn+Y22Awb/PXv7ZJMTfgEixVBK9oNxvahdFM28LgXQBK
         KWP7oHju8Q4iW1S+MzWSy5j51o/MpxtKOhfdpPdVKr8wGv+C+PBKO6Ra4fXFWQqw/RGJ
         PFCb1oMrfOqD7Z7ybdIYbZC88zbLBr26+zFjHeoUrQAhpc22m7ZBCymXLUqek0TqQ64h
         uAbg==
X-Gm-Message-State: AOAM533PcmBbatVUyNOc3BvpZ6jd0o6vnfrTiQ5wHW9QIGTClv3ARItw
        KHblAsyKtz4br1NJoGW0Hq/qxDLTRgBL5NWMiPw=
X-Google-Smtp-Source: ABdhPJxX7JvoRu3YlEOWh21+wRW0nzcPyemqslBO1Oe4Nujyekl8PPQVZ4htMOk69wEc9H+RZ86jmUaHPXPF0HK6w5M=
X-Received: by 2002:ac8:57cf:: with SMTP id w15mr600912qta.336.1616429422230;
 Mon, 22 Mar 2021 09:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210317012054.238334-1-davispuh@gmail.com> <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com> <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
 <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com> <CAOE4rSwOLQY1JWr-Mdq06Y9nwU_WcQBnfXZx3VWhRQGnBThHUQ@mail.gmail.com>
 <f48c758a-39a3-c73e-fc50-5ab37d2280f9@gmx.com> <CAOE4rSzF3g4nA3sXkzEi9MJxFGZ+Sp+POAQHVsXV531y4CJTiA@mail.gmail.com>
 <7db8f3ca-785b-e985-99eb-474aba82281f@gmx.com> <CAOE4rSzy645eDZZEsdDrdTGtfePPrPgnU3XrW+xBToU3fUzr8g@mail.gmail.com>
 <20210322044830.GV28049@hungrycats.org>
In-Reply-To: <20210322044830.GV28049@hungrycats.org>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Mon, 22 Mar 2021 18:10:09 +0200
Message-ID: <CAOE4rSwGX+y2dz07eSszWXgxzgYNoSvDwTnL9sKbK2Lq+VGthA@mail.gmail.com>
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

pirmd., 2021. g. 22. marts, plkst. 06:48 =E2=80=94 lietot=C4=81js Zygo Blax=
ell
(<ce3g8jdj@umail.furryterror.org>) rakst=C4=ABja:
>
> On Mon, Mar 22, 2021 at 05:13:13AM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > pirmd., 2021. g. 22. marts, plkst. 02:25 =E2=80=94 lietot=C4=81js Qu We=
nruo
> > (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
> > >
> > >
> > >
> > > On 2021/3/22 =E4=B8=8A=E5=8D=885:54, D=C4=81vis Mos=C4=81ns wrote:
> > > > sestd., 2021. g. 20. marts, plkst. 02:34 =E2=80=94 lietot=C4=81js Q=
u Wenruo
> > > > (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
> > > >>
> > > >>
> > > >>
> > > >> On 2021/3/19 =E4=B8=8B=E5=8D=8811:34, D=C4=81vis Mos=C4=81ns wrote=
:
> > > >>> ceturtd., 2021. g. 18. marts, plkst. 01:49 =E2=80=94 lietot=C4=81=
js Qu Wenruo
> > > >>> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> On 2021/3/18 =E4=B8=8A=E5=8D=885:03, D=C4=81vis Mos=C4=81ns wrot=
e:
> > > >>>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 12:28 =E2=80=94 lietot=
=C4=81js Qu Wenruo
> > > >>>>> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wr=
ote:
> > > >>>>>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lieto=
t=C4=81js D=C4=81vis Mos=C4=81ns
> > > >>>>>>> (<davispuh@gmail.com>) rakst=C4=ABja:
> > > >>>>>>>>
> > > >>>>>>>> Currently if there's any corruption at all in extent tree
> > > >>>>>>>> (eg. even single bit) then mounting will fail with:
> > > >>>>>>>> "failed to read block groups: -5" (-EIO)
> > > >>>>>>>> It happens because we immediately abort on first error when
> > > >>>>>>>> searching in extent tree for block groups.
> > > >>>>>>>>
> > > >>>>>>>> Now with this patch if `ignorebadroots` option is specified
> > > >>>>>>>> then we handle such case and continue by removing already
> > > >>>>>>>> created block groups and creating dummy block groups.
> > > >>>>>>>>
> > > >>>>>>>> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> > > >>>>>>>> ---
> > > >>>>>>>>      fs/btrfs/block-group.c | 14 ++++++++++++++
> > > >>>>>>>>      fs/btrfs/disk-io.c     |  4 ++--
> > > >>>>>>>>      fs/btrfs/disk-io.h     |  2 ++
> > > >>>>>>>>      3 files changed, 18 insertions(+), 2 deletions(-)
> > > >>>>>>>>
> > > >>>>>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > >>>>>>>> index 48ebc106a606..827a977614b3 100644
> > > >>>>>>>> --- a/fs/btrfs/block-group.c
> > > >>>>>>>> +++ b/fs/btrfs/block-group.c
> > > >>>>>>>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct bt=
rfs_fs_info *info)
> > > >>>>>>>>             ret =3D check_chunk_block_group_mappings(info);
> > > >>>>>>>>      error:
> > > >>>>>>>>             btrfs_free_path(path);
> > > >>>>>>>> +
> > > >>>>>>>> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBA=
DROOTS)) {
> > > >>>>>>>> +               btrfs_put_block_group_cache(info);
> > > >>>>>>>> +               btrfs_stop_all_workers(info);
> > > >>>>>>>> +               btrfs_free_block_groups(info);
> > > >>>>>>>> +               ret =3D btrfs_init_workqueues(info, NULL);
> > > >>>>>>>> +               if (ret)
> > > >>>>>>>> +                       return ret;
> > > >>>>>>>> +               ret =3D btrfs_init_space_info(info);
> > > >>>>>>>> +               if (ret)
> > > >>>>>>>> +                       return ret;
> > > >>>>>>>> +               return fill_dummy_bgs(info);
> > > >>>>>>
> > > >>>>>> When we hit bad things in extent tree, we should ensure we're =
mounting
> > > >>>>>> the fs RO, or we can't continue.
> > > >>>>>>
> > > >>>>>> And we should also refuse to mount back to RW if we hit such c=
ase, so
> > > >>>>>> that we don't need anything complex, just ignore the whole ext=
ent tree
> > > >>>>>> and create the dummy block groups.
> > > >>>>>>
> > > >>>>>
> > > >>>>> That's what we're doing here, `ignorebadroots` implies RO mount=
 and
> > > >>>>> without specifying it doesn't mount at all.
> > > >>>>>
> > > >>>>>>>
> > > >>>>>>> This isn't that nice, but I don't really know how to properly=
 clean up
> > > >>>>>>> everything related to already created block groups so this wa=
s easiest
> > > >>>>>>> way. It seems to work fine.
> > > >>>>>>> But looks like need to do something about replay log aswell b=
ecause if
> > > >>>>>>> it's not disabled then it fails with:
> > > >>>>>>>
> > > >>>>>>> [ 1397.246869] BTRFS info (device sde): start tree-log replay
> > > >>>>>>> [ 1398.218685] BTRFS warning (device sde): sde checksum verif=
y failed
> > > >>>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
> > > >>>>>>> [ 1398.218803] BTRFS warning (device sde): sde checksum verif=
y failed
> > > >>>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
> > > >>>>>>> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_exte=
nt:3054:
> > > >>>>>>> errno=3D-5 IO failure
> > > >>>>>>> [ 1398.218828] BTRFS: error (device sde) in
> > > >>>>>>> btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
> > > >>>>>>> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:=
2254:
> > > >>>>>>> errno=3D-5 IO failure (Failed to recover log tree)
> > > >>>>>>> [ 1398.229048] BTRFS error (device sde): open_ctree failed
> > > >>>>>>
> > > >>>>>> This is because we shouldn't allow to do anything write to the=
 fs if we
> > > >>>>>> have anything wrong in extent tree.
> > > >>>>>>
> > > >>>>>
> > > >>>>> This is happening when mounting read-only. My assumption is tha=
t it
> > > >>>>> only tries to replay in memory without writing anything to disk=
.
> > > >>>>>
> > > >>>>
> > > >>>> We lacks the check on log tree.
> > > >>>>
> > > >>>> Normally for such forced RO mount, log replay is not allowed.
> > > >>>>
> > > >>>> We should output a warning to prompt user to use nologreplay, an=
d reject
> > > >>>> the mount.
> > > >>>>
> > > >>>
> > > >>> I'm not familiar with log replay but couldn't there be something
> > > >>> useful (ignoring ref counts) that would still be worth replaying =
in
> > > >>> memory?
> > > >>>
> > > >> Log replay means metadata write.
> > > >>
> > > >> Any write needs a valid extent tree to find out free space for new
> > > >> metadata/data.
> > > >>
> > > >> So no, we can't do anything but completely ignoring the log.
> > > >>
> > > >
> > > > I see, updated patch. But even then it seems it could be possible t=
o
> > > > add new ramdisk and make allocations there (eg. create new extent t=
ree
> > > > there) thus allowing replay.
> > >
> > > The problem here is, since the extent tree is corrupted, we won't kno=
w
> > > which range has metadata already.
> > > While metadata CoW, just like its name, needs to CoW, which means it
> > > can't writeback (even just in memory) to anywhere we have metadata.
> > >
> > > The worst case is, we choose a bytenr for the new metadata to be (in
> > > memory), but it turns out later read needs to read metadata from the
> > > exactly same location.
> > >
> >
> > The idea is if we add new disk then we would put it after last bytenr
> > (which isn't mapped to any existing disks) thus there wouldn't be any
> > overlap.
>
> I wonder if that idea can be turned into an online recovery tool.
> Rebuild the metadata by more or less reflinking the old filesystem's data
> into a new filesystem created in the unallocated spaces between the old
> filesystem's block groups (building new subvol trees in the process).
> It would need the device and chunk trees to be intact, but you have to
> have those for rescue=3D to work at all, and it's relatively rarer for th=
ose
> to get damaged.  There's a complicated dance that has to be done to flip
> a block group from the old filesystem to the new one, but maybe that can
> be done by just making the entire old filesystem into a giant file image,
> then making ordinary reflinks to it, then finish by deleting the old
> image and running defrag to discard the unreferenced blocks that remain.
> Think "btrfs-convert" but using a busted btrfs as source instead of ext4.
>

That does sound pretty cool and could be doable, but it's way outside
of my knowledge about this all to even attempt anything like this.

>
> The log tree will only contain things that were fsync()ed after the
> last completed transaction commit.  Unless you're hitting a delayed
> refs latency issue or have non-default mount options, that's data from
> only the last 30 seconds before the filesystem failed.
>
> It might be desirable to replay the log tree if you had very high-value
> data there, but it's the last 0.001% of the filesystem that requires
> the last 99% of the development effort to recover.

Yea for me there was only some XATTR_ITEMs and single INODE_ITEM so
nothing that useful. Also I think easier way would be to parse it
offline and then apply those changes on data that's copied to new
filesystem. That doesn't seem that complicated if someone really needs
it.
