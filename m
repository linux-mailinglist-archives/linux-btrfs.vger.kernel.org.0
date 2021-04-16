Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE47A361D64
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbhDPJbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbhDPJbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 05:31:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1663C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 02:30:35 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d15so15179298qkc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8o7n1cu9JPmHK76RqpBjv2xoO4OyP4KSi3fhCXllayE=;
        b=U3RkNuTldvSSWQM4ViG7QQqFgk7XviJxq5oCnglPUAtQI5kD1PJjrJXR9ktHJVBZk+
         G+b2joJfrLnJDXzkjXReX0+zKQiR/SVPAVt7p8/fyIKmIxJYXkCZDE19tEWhLeHtEfoR
         vZz/wP/sfzrzfG/JgXpEmbid/pnxNzB12jBorAK84pFM2QJt/DLjIbxb9r1deKNi/tKh
         ndmwS4SWq6rfQAibDAWxG4bL2C0JSMaxc2pthPusWFTB7nwm+TCv5eUhi/DSGZmGX1bT
         8yYEj4V/xVH+iDeQ3ANESCFHzz+Li8uUISr5ZiUCqrCyr92QsIF4pHOgBT3cnnR2B7Bh
         0peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8o7n1cu9JPmHK76RqpBjv2xoO4OyP4KSi3fhCXllayE=;
        b=Jd/Mu38dcTrXvlEN9XeWdDi5edgci9Ypw8yFywU0ipGP1mHm1a8r/Divlgf5t7A8yZ
         KlKnyfdPsiieCGU1LlQpk0U2l03iw1uZQ/LqdmEuH3/3tIVW/BZ1OMV5Iyaj4bgN4agn
         BFoUsyKeAE9Y3sLSu0R/zZnRR5XoCCsRHxWL0Q/2ro1g19/2aXbA3VzkgKVQTpL0LxwE
         lAiP1cZjM1tCcAa5RyAIMm1/8uDbApGPoB5bMjd+uEb7ORHK1kgFyH8AEcWfB1WJAUKR
         ZA4yX4zDC+hOLhyN2VAl62KSwTrCWyL7f+g1Q6lkALOuq9VX2tQdqtLvGSxooh1VeWdt
         Kq9g==
X-Gm-Message-State: AOAM532BHi8c2LxkA29NltmrANAt13lhlUwMdQRbcMHP+XQDbSJVz5AC
        oUJqYPiqvuCe5YxLURDFoYlmOCcJTtXX/XyKQWg=
X-Google-Smtp-Source: ABdhPJzDBbWxPPlx0xfr31vGGno81fDlbaaBS9IWSxA7F566ki2C6Xjwo8j1WtzeUZlg0jVgLCNAkNRaHmHKW9ApdBE=
X-Received: by 2002:a05:620a:65d:: with SMTP id a29mr7815642qka.0.1618565434941;
 Fri, 16 Apr 2021 02:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4WKR4bamLij43gDL9RA9gREi_zNFME7LRqj7ex-YBLaw@mail.gmail.com> <PH0PR04MB741694A4912A97C6CC5365EF9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB741694A4912A97C6CC5365EF9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 16 Apr 2021 10:30:23 +0100
Message-ID: <CAL3q7H5dDxQf0YvnOFSOHLOnk=yuUQEO2na0Pg-hzfUri2etbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block groups
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 16, 2021 at 10:14 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 16/04/2021 11:12, Filipe Manana wrote:
> > On Thu, Apr 15, 2021 at 3:00 PM Johannes Thumshirn
> > <johannes.thumshirn@wdc.com> wrote:
> >>
> >> When relocating a block group the freed up space is not discarded in o=
ne
> >> big block, but each extent is discarded on it's own with -odisard=3Dsy=
nc.
> >>
> >> For a zoned filesystem we need to discard the whole block group at onc=
e,
> >> so btrfs_discard_extent() will translate the discard into a
> >> REQ_OP_ZONE_RESET operation, which then resets the device's zone.
> >>
> >> Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda82=
8d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>  fs/btrfs/volumes.c | 21 +++++++++++++++++----
> >>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 6d9b2369f17a..b1bab75ec12a 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -3103,6 +3103,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_=
info *fs_info, u64 chunk_offset)
> >>         struct btrfs_root *root =3D fs_info->chunk_root;
> >>         struct btrfs_trans_handle *trans;
> >>         struct btrfs_block_group *block_group;
> >> +       u64 length;
> >>         int ret;
> >>
> >>         /*
> >> @@ -3130,8 +3131,24 @@ static int btrfs_relocate_chunk(struct btrfs_fs=
_info *fs_info, u64 chunk_offset)
> >>         if (!block_group)
> >>                 return -ENOENT;
> >>         btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> >> +       length =3D block_group->length;
> >>         btrfs_put_block_group(block_group);
> >>
> >> +       /*
> >> +        * Step two, delete the device extents and the chunk tree entr=
ies.
> >> +        *
> >> +        * On a zoned file system, discard the whole block group, this=
 will
> >> +        * trigger a REQ_OP_ZONE_RESET operation on the device zone. I=
f
> >> +        * resetting the zone fails, don't treat it as a fatal problem=
 from the
> >> +        * filesystem's point of view.
> >> +        */
> >> +       if (btrfs_is_zoned(fs_info)) {
> >> +               ret =3D btrfs_discard_extent(fs_info, chunk_offset, le=
ngth, NULL);
> >> +               if (ret)
> >> +                       btrfs_info(fs_info, "failed to reset zone %llu=
",
> >> +                                  chunk_offset);
> >> +       }
> >> +
> >>         trans =3D btrfs_start_trans_remove_block_group(root->fs_info,
> >>                                                      chunk_offset);
> >>         if (IS_ERR(trans)) {
> >> @@ -3140,10 +3157,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs=
_info *fs_info, u64 chunk_offset)
> >>                 return ret;
> >>         }
> >>
> >> -       /*
> >> -        * step two, delete the device extents and the
> >> -        * chunk tree entries
> >> -        */
> >
> > This hunk seems unrelated and unintentional.
> > Not that the comment adds any value, but if the removal was
> > intentional, I would suggest a separate patch for that.
>
> It's moved upwards
>
> +       /*
> +        * Step two, delete the device extents and the chunk tree entries=
.
> +        *
> +        * On a zoned file system, discard the whole block group, this wi=
ll
> +        * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
> +        * resetting the zone fails, don't treat it as a fatal problem fr=
om the
> +        * filesystem's point of view.
> +        */
>
> 'cause technically the "delete extents" step starts with the discard now.=
 But I
> can leave it where it was.

The comment refers to deleting the device extent items from the device
tree, not really extents on disk.
I.e. it's all about the items from the block group in the chunk and
device trees.

>
> > Other than that, it looks good, thanks.
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
>
> Thanks



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
