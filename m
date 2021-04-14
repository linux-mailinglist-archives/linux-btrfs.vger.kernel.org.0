Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6069A35F20C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhDNLRG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 07:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhDNLRF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 07:17:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA268C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 04:16:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f19so3268618qka.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PJm6jNppXla7x5V70xDxXhtw8j2BG4CxNrr+LIWe8R4=;
        b=XX6VnaCZDUj0Uce6/dxnh2G4kf8uwycepeRDX1vWRJUJdOVwUc/+tKwFeXa+2kt4x0
         OCsnabYKu6b7ZQpChxURdHbgOEYYv4DHXigG5bDGl2kYiRSljLiXiR+3Ri6OldeC8J16
         ndRr1lJ52QbOUzwatH5YGU0UNKw/QgTBjAh1GJ58namZCyZHb4DhIQcVRJm5Ztt3p5vj
         5K1GT6CUsKovi0fw9qcN6tDrebXkz9Thsf8b25SGMi2BNT0XVwu4zaj5fa/8BuCbgLVL
         b29HsQVEIY9SFBNbDJnqbv61xdEqlYlJXL7nUl9jeVTTTx+cnLrZC6GA1M1zh1ZxinxZ
         WQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PJm6jNppXla7x5V70xDxXhtw8j2BG4CxNrr+LIWe8R4=;
        b=BM7FbFHZ6UUhALMi3LE6cVAfONui7mGTzocOzhosW3tiCaLTnQF+ey+tyvY/qHZv8b
         aAPR/36ODUF7m51Q2o8z4XDiBVeEyAoFa1TnnSAq9imH6btzNMDqiMGuN3mXErZd9MRL
         /IsuKGFLhtQkGpFO/yBpJ12AMYPsMzy9G56Qxpx8DwgqSQ59nvrdea981aBytBcKUKSJ
         ZQplEOErJbCb5Ef+U1GKqfSEpc+ohaEZ6/ZKph7FON1fEmf8s3Vssr7enI3ICtJtaqVz
         UNrTU//PcPxYkDG1VrUpr/vtp3IjYnsG9mzWDgfIFLy+9E//piabpMlGtkGEKl4nUs61
         4BNQ==
X-Gm-Message-State: AOAM533i9Ybe6lDG6hdvD+vgWcU9HZphrPqrOM/Nuk6haLZ5iRneiL4B
        D66K17h1RWUTPsfxMug9o8f1crVhc4oFUMLk/UfeTcJxHXbnjg==
X-Google-Smtp-Source: ABdhPJyU4Kuhnzehtwwm9govsoVX4xhs5gZnCydTbvAQq/hnrQDOIYnYvPWqiDKYCYJ1wQIkYXAc2A1NmAnVUM1qk98=
X-Received: by 2002:a37:6290:: with SMTP id w138mr27664886qkb.479.1618399002919;
 Wed, 14 Apr 2021 04:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5xZLhHrBPJb5jwe8ZxAv=XfFC05kcw5-WqBySQP4uTBg@mail.gmail.com> <PH0PR04MB74167FB19522DBEB1F70E80D9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB74167FB19522DBEB1F70E80D9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 14 Apr 2021 12:16:31 +0100
Message-ID: <CAL3q7H6Bgqkdf8Z+xRBH8C=XxtrGzXyNUf6BHaLw54LZb3Agsg@mail.gmail.com>
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

On Tue, Apr 13, 2021 at 6:48 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 13/04/2021 14:57, Filipe Manana wrote:
> > And what about the other mechanism that triggers discards on pinned
> > extents, after the transaction commits the super blocks?
> > Why isn't that happening (with -o discard=3Dsync)? We create the delaye=
d
> > references to drop extents from the relocated block group, which
> > results in pinning extents.
> > This is the case that surprised me that it isn't working for you.
>
> I think this is the case. I would have expected to end up in this
> part of btrfs_finish_extent_commit():
>
>
>         /*
>          * Transaction is finished.  We don't need the lock anymore.  We
>          * do need to clean up the block groups in case of a transaction
>          * abort.
>          */
>         deleted_bgs =3D &trans->transaction->deleted_bgs;
>         list_for_each_entry_safe(block_group, tmp, deleted_bgs, bg_list) =
{
>                 u64 trimmed =3D 0;
>
>                 ret =3D -EROFS;
>                 if (!TRANS_ABORTED(trans))
>                         ret =3D btrfs_discard_extent(fs_info,
>                                                    block_group->start,
>                                                    block_group->length,
>                                                    &trimmed);
>
>                 list_del_init(&block_group->bg_list);
>                 btrfs_unfreeze_block_group(block_group);
>                 btrfs_put_block_group(block_group);
>
>                 if (ret) {
>                         const char *errstr =3D btrfs_decode_error(ret);
>                         btrfs_warn(fs_info,
>                            "discard failed while removing blockgroup: err=
no=3D%d %s",
>                                    ret, errstr);
>                 }
>         }
>
> and the btrfs_discard_extent() over the whole block group would then trig=
ger a
> REQ_OP_ZONE_RESET operation, resetting the device's zone.
>
> But as btrfs_delete_unused_bgs() doesn't add the block group to the
> ->deleted_bgs list, we're not reaching above code. I /think/ (i.e. verifi=
cation
> pending) the -o discard=3Dsync case works for regular block devices, as e=
ach extent
> is discarded on it's own, by this (also in btrfs_finish_extent_commit()):
>
>         while (!TRANS_ABORTED(trans)) {
>                 struct extent_state *cached_state =3D NULL;
>
>                 mutex_lock(&fs_info->unused_bg_unpin_mutex);
>                 ret =3D find_first_extent_bit(unpin, 0, &start, &end,
>                                             EXTENT_DIRTY, &cached_state);
>                 if (ret) {
>                         mutex_unlock(&fs_info->unused_bg_unpin_mutex);
>                         break;
>                 }
>
>                 if (btrfs_test_opt(fs_info, DISCARD_SYNC))
>                         ret =3D btrfs_discard_extent(fs_info, start,
>                                                    end + 1 - start, NULL)=
;
>
>                 clear_extent_dirty(unpin, start, end, &cached_state);
>                 unpin_extent_range(fs_info, start, end, true);
>                 mutex_unlock(&fs_info->unused_bg_unpin_mutex);
>                 free_extent_state(cached_state);
>                 cond_resched();
>         }
>
> If this is the case, my patch will essentially discard the data twice, fo=
r a
> non-zoned block device, which is certainly not ideal.

Yep, that's what puzzled me, why the need to do it for non-zoned file
systems when using -o discard=3Dsync.
I assumed you ran into a case where discard was not happening due to
some bug bug in the extent pinning/unpinning mechanism.

> So the correct fix would
> be to get the block group into the 'trans->transaction->deleted_bgs' list
> after relocation, which would work if we wouldn't check for block_group->=
ro in
> btrfs_delete_unused_bgs(), but I suppose this check is there for a reason=
.

Actually the check for ->ro does not make sense anymore since I
introduced the delete_unused_bgs_mutex in commit
67c5e7d464bc466471b05e027abe8a6b29687ebd.

When the ->ro check was added
(47ab2a6c689913db23ccae38349714edf8365e0a), it was meant to prevent
the cleaner kthread and relocation tasks from calling
btrfs_remove_chunk() concurrently, but checking for ->ro only was
buggy, hence the addition of delete_unused_bgs_mutex later.

>
> How about changing the patch to the following:

Looks good.
However would just removing the ->ro check by enough as well?

Thanks Johannes.

>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6d9b2369f17a..ba13b2ea3c6f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3103,6 +3103,9 @@ static int btrfs_relocate_chunk(struct btrfs_fs_inf=
o *fs_info, u64 chunk_offset)
>         struct btrfs_root *root =3D fs_info->chunk_root;
>         struct btrfs_trans_handle *trans;
>         struct btrfs_block_group *block_group;
> +       u64 length;
>         int ret;
>
>         /*
> @@ -3130,8 +3133,16 @@ static int btrfs_relocate_chunk(struct btrfs_fs_in=
fo *fs_info, u64 chunk_offset)
>         if (!block_group)
>                 return -ENOENT;
>         btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> +       length =3D block_group->length;
>         btrfs_put_block_group(block_group);
>
> +       /*
> +        * For a zoned filesystem we need to discard/zone-reset here, as =
the
> +        * discard code won't discard the whole block-group, but only sin=
gle
> +        * extents.
> +        */
> +       if (btrfs_is_zoned(fs_info)) {
> +               ret =3D btrfs_discard_extent(fs_info, chunk_offset, lengt=
h, NULL);
> +               if (ret) /* Non working discard is not fatal */
> +                       btrfs_warn(fs_info, "discarding chunk %llu failed=
",
> +                                  chunk_offset);
> +       }
> +
>         trans =3D btrfs_start_trans_remove_block_group(root->fs_info,
>                                                      chunk_offset);
>         if (IS_ERR(trans)) {



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
