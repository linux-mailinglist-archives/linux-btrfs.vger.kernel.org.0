Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8925B1A05
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIHKbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIHKbr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 06:31:47 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB64BC11D
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 03:31:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so12080413otu.3
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Sep 2022 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date;
        bh=FyAT2Ckq/CDmEzUy3GrtiPxx6Fd64iX1uK+iwVgMEO0=;
        b=LQiHZbuvVCClFxQy+IiisGoVQVZSExRna6dcaNuleTSr5fnXQfln8Fxt2i2cJ0YJs/
         i4922zwQVCXH8HpS2wJOfHVDR9fHf1xjYlTTUkPvFkkl9p6qPQq7zokTjI392PcyUKAb
         4dnHfSWLiq7jKqRILqjLH26KI6oQV4OzulXPFrsJ2LsXWodDQRpPgZN9lwyv8NXsK94A
         Cd+5p+ujaKsoD/Jqqn7Wr6YWBeFk3jAFY5jK1t9ZCy+4unAcyamwl5E/ab7KIQltILRF
         HKJPC9hWBRDxm0SoLjHTzYL4Mo2I8pn9XBsA0vLHx4O4Ewms78QV7vs5uKms3l6HMqO6
         ieiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FyAT2Ckq/CDmEzUy3GrtiPxx6Fd64iX1uK+iwVgMEO0=;
        b=2/tkDU7tPAxI8UDOwn6cND/THj+m3HVS01UQ7cw4up68+dyO/3c23QChsxaGQqq+OL
         ofWXgCqGNnotSjTm21McxCLQ/oiLqaLOvm6M0kPhCSUQrbDDzKs919H6PASgpF/InRI2
         m+Ga8AOfwJjHHk2teSYYoN2bJRgG3oDAXODOnkdKV7s/wSVGvsxGkIDeSVGFsqw2sDOk
         sgosifB4z2BgkQGaTU20YrM/zwlWcIgqiMkxpSr+/WeP7Td2HHZyixjHQ8a/K2F1D4YI
         4JSlPcowGldkcyLv/NAsSVnMK9XHRhnvfRJ9GD7OYAQJFbIKgfrW20JxhfuSPppXK91E
         Nnyw==
X-Gm-Message-State: ACgBeo39sd4+B2bLS7uRY6OWgmeJtZIWL4dFLPZTlwrQAO6vwjU6yGG/
        sgL1/kvb0+jy+PGKruBE9k2/f3aqjy0eDczGROjCAP+T
X-Google-Smtp-Source: AA6agR6PYuVx3r46HHWjezUHOqbNSUVUYALbPAgo4Jwl3O7JbbIk2nrYbO4oKpXVIZvAiOYhRheXAoTmS9eu9EUgO3Q=
X-Received: by 2002:a9d:6f08:0:b0:638:8a51:2e46 with SMTP id
 n8-20020a9d6f08000000b006388a512e46mr3194033otq.363.1662633105848; Thu, 08
 Sep 2022 03:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
In-Reply-To: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 8 Sep 2022 11:31:09 +0100
Message-ID: <CAL3q7H5d1mkMwfR-mfT8DydHbfys7_2kMg_xxS5yyrnTPvRHyA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: don't update the block group item if used bytes
 are the same
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 8, 2022 at 7:40 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BACKGROUND]
>
> When committing a transaction, we will update block group items for all
> dirty block groups.
>
> But in fact, dirty block groups don't always need to update their block
> group items.
> It's pretty common to have a metadata block group which experienced
> several CoW operations, but still have the same amount of used bytes.
>
> In that case, we may unnecessarily CoW a tree block doing nothing.
>
> [ENHANCEMENT]
>
> This patch will introduce btrfs_block_group::commit_used member to
> remember the last used bytes, and use that new member to skip
> unnecessary block group item update.
>
> This would be more common for large fs, which metadata block group can
> be as large as 1GiB, containing at most 64K metadata items.
>
> In that case, if CoW added and the deleted one metadata item near the end
> of the block group, then it's completely possible we don't need to touch
> the block group item at all.
>
> [BENCHMARK]
>
> To properly benchmark how many block group items we skipped the update,
> I added some members into btrfs_tranaction to record how many times
> update_block_group_item() is called, and how many of them are skipped.
>
> Then with a single line fio to trigger the workload on a newly created
> btrfs:
>
>   fio --filename=3D$mnt/file --size=3D4G --rw=3Drandrw --bs=3D32k --ioeng=
ine=3Dlibaio \
>       --direct=3D1 --iodepth=3D64 --runtime=3D120 --numjobs=3D4 --name=3D=
random_rw \
>       --fallocate=3Dposix

And did this improve fio's numbers? Throughput, latency?
It's odd to paste a test here and not mention its results. I suppose
it didn't make
a difference, but even if not, it should be explicitly stated.

In this case, less extent tree updates can result in better
concurrency for the nocow checks,
which need to check the extent tree.

>
> Then I got 101 transaction committed during that fio command, and a
> total of 2062 update_block_group_item() calls, in which 1241 can be
> skipped.
>
> This is already a good 60% got skipped.
>
> The full analyse can be found here:
> https://docs.google.com/spreadsheets/d/e/2PACX-1vTbjhqqqxoebnQM_ZJzSM1rF7=
EY7I1IRbAzZjv19imcDHsVDA7qeA_-MzXxltFZ0kHBjxMA15s2CSH8/pubhtml

Not sure if keeping an url to an external source that is not
guaranteed to be available "forever" is a good practice.
It also doesn't seem to provide any substantial value, as you have
already mentioned above some numbers.

>
> Furthermore, since I have per-trans accounting, it shows that initially
> we have a very low percentage of skipped block group item update.
>
> This is expected since we're inserting a lot of new file extents
> initially, thus the metadata usage is going to increase.
>
> But after the initial 3 transactions, all later transactions are have a

"are have" -> "have"

> very stable 40~80% skip rate, mostly proving the patch is working.
>
> Although such high skip rate is not always a huge win, as for
> our later block group tree feature, we will have a much higher chance to
> have a block group item already COWed, thus can skip some COW work.
>
> But still, skipping a full COW search on extent tree is always a good
> thing, especially when the benefit almost comes from thin-air.

Agreed, it's a good thing.

Were there other benefits observed, like for example less IO due to less CO=
W?
Or transaction commits taking less time?

Thanks.


>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [Josef pinned down the race and provided a fix]
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 20 +++++++++++++++++++-
>  fs/btrfs/block-group.h |  6 ++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e7b5a54c8258..0df4d98df278 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_inf=
o *info,
>
>         cache->length =3D key->offset;
>         cache->used =3D btrfs_stack_block_group_used(bgi);
> +       cache->commit_used =3D cache->used;
>         cache->flags =3D btrfs_stack_block_group_flags(bgi);
>         cache->global_root_id =3D btrfs_stack_block_group_chunk_objectid(=
bgi);
>
> @@ -2693,6 +2694,22 @@ static int update_block_group_item(struct btrfs_tr=
ans_handle *trans,
>         struct extent_buffer *leaf;
>         struct btrfs_block_group_item bgi;
>         struct btrfs_key key;
> +       u64 used;
> +
> +       /*
> +        * Block group items update can be triggered out of commit transa=
ction
> +        * critical section, thus we need a consistent view of used bytes=
.
> +        * We can not direct use cache->used out of the spin lock, as it
> +        * may be changed.
> +        */
> +       spin_lock(&cache->lock);
> +       used =3D cache->used;
> +       /* No change in used bytes, can safely skip it. */
> +       if (cache->commit_used =3D=3D used) {
> +               spin_unlock(&cache->lock);
> +               return 0;
> +       }
> +       spin_unlock(&cache->lock);
>
>         key.objectid =3D cache->start;
>         key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> @@ -2707,12 +2724,13 @@ static int update_block_group_item(struct btrfs_t=
rans_handle *trans,
>
>         leaf =3D path->nodes[0];
>         bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
> -       btrfs_set_stack_block_group_used(&bgi, cache->used);
> +       btrfs_set_stack_block_group_used(&bgi, used);
>         btrfs_set_stack_block_group_chunk_objectid(&bgi,
>                                                    cache->global_root_id)=
;
>         btrfs_set_stack_block_group_flags(&bgi, cache->flags);
>         write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>         btrfs_mark_buffer_dirty(leaf);
> +       cache->commit_used =3D used;
>  fail:
>         btrfs_release_path(path);
>         return ret;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index f48db81d1d56..b57718020104 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -84,6 +84,12 @@ struct btrfs_block_group {
>         u64 cache_generation;
>         u64 global_root_id;
>
> +       /*
> +        * The last committed used bytes of this block group, if above @u=
sed
> +        * is still the same as @commit_used, we don't need to update blo=
ck
> +        * group item of this block group.
> +        */
> +       u64 commit_used;
>         /*
>          * If the free space extent count exceeds this number, convert th=
e block
>          * group to bitmaps.
> --
> 2.37.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
