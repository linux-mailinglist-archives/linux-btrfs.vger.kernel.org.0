Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648D035C85A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbhDLOIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241764AbhDLOIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 10:08:53 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929ECC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Apr 2021 07:08:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i3so750339qvj.7
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Apr 2021 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/5Okj5645cfZIWHPdH3BiA98n8He3li0+rIeWon1wXc=;
        b=AVVs3tvbj+5FPlfLSZNYUg4FR+mW8t9rzE7nC3L9VtSaU+A3oWmWlc0xfEsDADwHKB
         /iO1YWyn2qPOwDilZrV59oPj0kihcn3xzZLteBoqSr2D4+YBFwxLULve5YfEioRysIAl
         0tPqad4rM5zisH688y3VJT4Y4SCmBSvPA2ugx3WNv1TU2Bzy0HeYn9BrwqZ2EVfJBsO7
         M5PVffVEPs043ZrmUsrUMUkvkx1da9xaqK+nNoucoW1uffgBXiHcwPAn44a2xyw8+fLD
         3JEJ1VmR+Hwm89MQ3prGZFgkskAh+r64PwTdzJOrJsgqP8jItZJhJwj1bnf8VrlkJ+J0
         1A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/5Okj5645cfZIWHPdH3BiA98n8He3li0+rIeWon1wXc=;
        b=KQRRnOzZAUt4oCYMLjgm71Jqd4GgFatQq/mIIYglFLJeckAgR4HAhyeXBfG0get0wO
         so5VqEQVcVPxUc0ytpyJ11WZpB2L+rDFyLh00hV9GicKxfzfHR2swOv4v9c2sPSODmqL
         ba/nG7PZbjRUGnPusImvBlIiUX84doKoXu5aWxuH8bxYRNMlkbDbg3XOBuKjbsWM/na6
         +F2IuH/5ms3ABclvkzEgoywt6+yCkQ5gSa2kOcf7h7ZYFM3gmw2WSe39qegeVCdBNAhQ
         AjcMSe8vjFzMQt11YFvkBfRzZSyDODaD8/Ncv/OB2+tVlK9cco9GRnLvjFtrT/haPhy2
         LAZQ==
X-Gm-Message-State: AOAM530Syi9QLyQdC818U61Stbp14NqXYulrjfUKWdxfDPyjjkQcAEIk
        QoWpoQDE+s9dZsoBsUzQNY1TEIwtjTtcTh66CXo=
X-Google-Smtp-Source: ABdhPJzxgfecthDAfBMcinmo+st+5FuBgs0CswOTHf9pEpZby+2q6j9dCtFyJtm8dc8Rzwu0OJ5kF8j6r58Aif7CK9w=
X-Received: by 2002:ad4:52c2:: with SMTP id p2mr28135077qvs.45.1618236512572;
 Mon, 12 Apr 2021 07:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com> <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 12 Apr 2021 15:08:21 +0100
Message-ID: <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
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

On Mon, Apr 12, 2021 at 2:49 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 09/04/2021 13:37, Filipe Manana wrote:
> > On Fri, Apr 9, 2021 at 11:54 AM Johannes Thumshirn
> > <johannes.thumshirn@wdc.com> wrote:
> >>
> >> When relocating a block group the freed up space is not discarded. On
> >> devices like SSDs this hint is useful to tell the device the space is
> >> freed now. On zoned block devices btrfs' discard code will reset the z=
one
> >> the block group is on, freeing up the occupied space.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>  fs/btrfs/volumes.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 6d9b2369f17a..d9ef8bce0cde 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -3103,6 +3103,10 @@ static int btrfs_relocate_chunk(struct btrfs_fs=
_info *fs_info, u64 chunk_offset)
> >>         struct btrfs_root *root =3D fs_info->chunk_root;
> >>         struct btrfs_trans_handle *trans;
> >>         struct btrfs_block_group *block_group;
> >> +       const bool trim =3D btrfs_is_zoned(fs_info) ||
> >> +                               btrfs_test_opt(fs_info, DISCARD_SYNC);
> >> +       u64 trimmed;
> >> +       u64 length;
> >>         int ret;
> >>
> >>         /*
> >> @@ -3130,6 +3134,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_=
info *fs_info, u64 chunk_offset)
> >>         if (!block_group)
> >>                 return -ENOENT;
> >>         btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> >> +       length =3D block_group->length;
> >>         btrfs_put_block_group(block_group);
> >>
> >>         trans =3D btrfs_start_trans_remove_block_group(root->fs_info,
> >> @@ -3144,6 +3149,14 @@ static int btrfs_relocate_chunk(struct btrfs_fs=
_info *fs_info, u64 chunk_offset)
> >>          * step two, delete the device extents and the
> >>          * chunk tree entries
> >>          */
> >> +       if (trim) {
> >> +               ret =3D btrfs_discard_extent(fs_info, chunk_offset, le=
ngth,
> >> +                                          &trimmed);
> >
> > Ideally we do IO and potentially slow operations such as discard while
> > not holding a transaction handle open, to avoid slowing down anyone
> > trying to commit the transaction.
> >
> >> +               if (ret) {
> >> +                       btrfs_abort_transaction(trans, ret);
> >
> > This is leaking the transaction, still need to call btrfs_end_transacti=
on().
> >
> > Making the discard before joining/starting transaction, would fix both =
things.
>
> Note taken.
>
> >
> > Now more importantly, I don't see why the freed space isn't already
> > discarded at this point.
> > Relocation creates delayed references to drop extents from the block
> > group, and when the delayed references are run, we pin the extents
> > through:
> >
> > __btrfs_free_extent() -> btrfs_update_block_group()
> >
> > Then at the very end of the transaction commit, we discard pinned
> > extents and then unpin them, at btrfs_finish_extent_commit().
> > Relocation commits the transaction at the end of
> > relocate_block_group(), so the delayed references are fun, and then we
> > discard and unpin their extents.
> > So that's why I don't get it why the discard is needed here (at least
> > when we are not on a zoned filesystem).
>
> This is a good point to investigate, but as of now, the zone isn't reset.
> Zone reset handling in btrfs is piggy backed onto discard handling, but
> from testing the patchset I see the zone isn't reset:
>
> [   81.014752] BTRFS info (device nullb0): reclaiming chunk 1073741824
> [   81.015732] BTRFS info (device nullb0): relocating block group 1073741=
824 flags data
> [   81.798090] BTRFS info (device nullb0): found 12452 extents, stage: mo=
ve data extents
> [   82.314562] BTRFS info (device nullb0): found 12452 extents, stage: up=
date data pointers
> # blkzone report -o $((1073741824 >> 9)) -c 1 /dev/nullb0
>   start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x0799a0 reset:0 n=
on-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]

Not familiar with zoned device details, but what you are passing to
blkzone is a logical address, in non-zoned btrfs it does not always
matches the physical address on disk.
So maybe that is not a reliable way to check it.

>
> Whereas when the this patch is applied as well:
> [   85.126542] BTRFS info (device nullb0): reclaiming chunk 1073741824
> [   85.128211] BTRFS info (device nullb0): relocating block group 1073741=
824 flags data
> [   86.061831] BTRFS info (device nullb0): found 12452 extents, stage: mo=
ve data extents
> [   86.766549] BTRFS info (device nullb0): found 12452 extents, stage: up=
date data pointers
> # blkzone report -c 1 -o $((1073741824 >> 9)) /dev/nullb0
>   start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 n=
on-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>
> As a positive side effect of this, I now have code that can be used in
> xfstests to verify the patchset.

Ok.
Maybe the zone isn't reset properly because the default mechanism is
doing smaller discards, on a per extent basis, and perhaps the order
of those discards matters?

If it affects only the zoned case, I also don't see why doing it when
not in zoned mode (and -o discard=3Dsync is set).
Unless of course the default discard mechanism is broken somehow, in
which case we need to find out why and fix it.

Thanks.

>
> Byte,
>         Johannes



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
