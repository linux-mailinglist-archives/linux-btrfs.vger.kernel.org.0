Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCB158CBFF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbiHHQSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiHHQSJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 12:18:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0CCE32;
        Mon,  8 Aug 2022 09:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE57B80EEA;
        Mon,  8 Aug 2022 16:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE4DC433D7;
        Mon,  8 Aug 2022 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659975485;
        bh=j5Vxyp9unzDd6ThGzjU7MwVOZaw5WpnTrrBw+0fLs74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gBegz5UvZmVOJ5fGFxEEJqBw46W0Xwj/SKajPFc7hC8t5WlYrWJXEW3vEY1/OPV3N
         uzawl7s79MeCBSyhGtBOM8ckFQgPvZlb/iKsZc+x0//dcwZmMbg/nizrYB/LWIpR7b
         eF1eMGKBXH/RInjQX+WGQKyeQhdkYT4GHjCfOGaHwmarEvoSC5+WrnDAul21wmmKjb
         Wu8DcI1Bw5xpqA7HmSNrt/6AGdf97LaPsMdC5b2n8ZK4scjEIcKJEMhJryO7Av/k5x
         ACziOl+a5nVe6NLLOFGv+lgcnJIQGsATiUWYzBZt4vxMzvuHeBWSC0EFGSSu+WU5bW
         yrRXH6bWzLyyA==
Received: by mail-ot1-f42.google.com with SMTP id f3-20020a9d0383000000b00636d99775a2so3135810otf.2;
        Mon, 08 Aug 2022 09:18:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo316oaBXII0Z52K4PfEFrgJkV1Pj6B7URV+g/ltyUezAiYdNV7W
        xCvjIX4Nso1oD+jFLogN/SWs6zls11n4aHiMTP4=
X-Google-Smtp-Source: AA6agR6bfPSaEQ+QcRZQmtk5G8i4uW4FxRSLTvs92nHH+yQbVEepq7fqldZpOAIvI2IRkMrj/tmH2Hhgm4EdVBsrJqk=
X-Received: by 2002:a9d:6d8c:0:b0:636:b96a:990f with SMTP id
 x12-20020a9d6d8c000000b00636b96a990fmr5233112otp.270.1659975484355; Mon, 08
 Aug 2022 09:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220808102735.4556-1-bingjingc@synology.com> <20220808102735.4556-2-bingjingc@synology.com>
In-Reply-To: <20220808102735.4556-2-bingjingc@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 8 Aug 2022 17:17:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Wqw1CNSpRrFkfFN5q3HjY34OSVv-xsnJbog=O6Rcj0Q@mail.gmail.com>
Message-ID: <CAL3q7H5Wqw1CNSpRrFkfFN5q3HjY34OSVv-xsnJbog=O6Rcj0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: send: refactor get_inode_info()
To:     bingjingc <bingjingc@synology.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robbie Ko <robbieko@synology.com>, bxxxjxxg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 8, 2022 at 11:27 AM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> Refactor get_inode_info() with request flags and output structure supports.
> Besides, also introduce a helper function called get_inode_gen(), which
> is majorly used.
>
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  fs/btrfs/send.c | 176 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 102 insertions(+), 74 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index e7671afcee4f..84b09d428ca3 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -842,17 +842,41 @@ static int send_rmdir(struct send_ctx *sctx, struct fs_path *path)
>         return ret;
>  }
>
> +enum inode_field {
> +       INODE_SIZE = 0x1,
> +       INODE_GEN = 0x1 << 1,
> +       INODE_MODE = 0x1 << 2,
> +       INODE_UID = 0x1 << 3,
> +       INODE_GID = 0x1 << 4,
> +       INODE_RDEV = 0x1 << 5,
> +       INODE_ATTR = 0x1 << 6,
> +};

0x1 is a bit odd, we normally define flags like: "1U <<  ..."

> +
> +struct inode_info {
> +       u64 size;
> +       u64 gen;
> +       u64 mode;
> +       u64 uid;
> +       u64 gid;
> +       u64 rdev;
> +       u64 attr;
> +};

The name of the structure and enums should ideally have a "btrfs_" and
"BTRFS_" prefix, as those names
are a bit too generic, prone for future conflicts.

> +
>  /*
>   * Helper function to retrieve some fields from an inode item.
>   */
> -static int __get_inode_info(struct btrfs_root *root, struct btrfs_path *path,
> -                         u64 ino, u64 *size, u64 *gen, u64 *mode, u64 *uid,
> -                         u64 *gid, u64 *rdev, u64 *fileattr)
> +static int get_inode_info(struct btrfs_root *root, u64 ino, unsigned int flags,
> +                         struct inode_info *info)
>  {
>         int ret;
> +       struct btrfs_path *path;
>         struct btrfs_inode_item *ii;
>         struct btrfs_key key;
>
> +       path = alloc_path_for_send();
> +       if (!path)
> +               return -ENOMEM;
> +
>         key.objectid = ino;
>         key.type = BTRFS_INODE_ITEM_KEY;
>         key.offset = 0;
> @@ -860,47 +884,49 @@ static int __get_inode_info(struct btrfs_root *root, struct btrfs_path *path,
>         if (ret) {
>                 if (ret > 0)
>                         ret = -ENOENT;
> -               return ret;
> +               goto out;
>         }
>
> +       if (!info)
> +               goto out;
> +
>         ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
>                         struct btrfs_inode_item);
> -       if (size)
> -               *size = btrfs_inode_size(path->nodes[0], ii);
> -       if (gen)
> -               *gen = btrfs_inode_generation(path->nodes[0], ii);
> -       if (mode)
> -               *mode = btrfs_inode_mode(path->nodes[0], ii);
> -       if (uid)
> -               *uid = btrfs_inode_uid(path->nodes[0], ii);
> -       if (gid)
> -               *gid = btrfs_inode_gid(path->nodes[0], ii);
> -       if (rdev)
> -               *rdev = btrfs_inode_rdev(path->nodes[0], ii);
> +       if (flags & INODE_SIZE)
> +               info->size = btrfs_inode_size(path->nodes[0], ii);
> +       if (flags & INODE_GEN)
> +               info->gen = btrfs_inode_generation(path->nodes[0], ii);
> +       if (flags & INODE_MODE)
> +               info->mode = btrfs_inode_mode(path->nodes[0], ii);
> +       if (flags & INODE_UID)
> +               info->uid = btrfs_inode_uid(path->nodes[0], ii);
> +       if (flags & INODE_GID)
> +               info->gid = btrfs_inode_gid(path->nodes[0], ii);
> +       if (flags & INODE_RDEV)
> +               info->rdev = btrfs_inode_rdev(path->nodes[0], ii);

To make things more simple, we can get away with the flags.

Just populate all the fields of the structure unconditionally.
Less code, it also makes the call sites more readable by avoiding long
bitwise oring expressions,
and it's really cheap to get all the fields anyway.

>         /*
>          * Transfer the unchanged u64 value of btrfs_inode_item::flags, that's
>          * otherwise logically split to 32/32 parts.
>          */
> -       if (fileattr)
> -               *fileattr = btrfs_inode_flags(path->nodes[0], ii);
> +       if (flags & INODE_ATTR)
> +               info->attr = btrfs_inode_flags(path->nodes[0], ii);
>
> +out:
> +       btrfs_free_path(path);
>         return ret;
>  }
>
> -static int get_inode_info(struct btrfs_root *root,
> -                         u64 ino, u64 *size, u64 *gen,
> -                         u64 *mode, u64 *uid, u64 *gid,
> -                         u64 *rdev, u64 *fileattr)
> +static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
>  {
> -       struct btrfs_path *path;
>         int ret;
> +       struct inode_info info;
>
> -       path = alloc_path_for_send();
> -       if (!path)
> -               return -ENOMEM;
> -       ret = __get_inode_info(root, path, ino, size, gen, mode, uid, gid,
> -                              rdev, fileattr);
> -       btrfs_free_path(path);
> +       if (!gen)
> +               return -EPERM;
> +
> +       ret = get_inode_info(root, ino, INODE_GEN, &info);
> +       if (!ret)
> +               *gen = info.gen;
>         return ret;
>  }
>
> @@ -1644,8 +1670,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
>         u64 left_gen;
>         u64 right_gen;
>
> -       ret = get_inode_info(sctx->send_root, ino, NULL, &left_gen, NULL, NULL,
> -                       NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->send_root, ino, &left_gen);
>         if (ret < 0 && ret != -ENOENT)
>                 goto out;
>         left_ret = ret;
> @@ -1653,8 +1678,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
>         if (!sctx->parent_root) {
>                 right_ret = -ENOENT;
>         } else {
> -               ret = get_inode_info(sctx->parent_root, ino, NULL, &right_gen,
> -                               NULL, NULL, NULL, NULL, NULL);
> +               ret = get_inode_gen(sctx->parent_root, ino, &right_gen);
>                 if (ret < 0 && ret != -ENOENT)
>                         goto out;
>                 right_ret = ret;
> @@ -1816,8 +1840,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
>         btrfs_release_path(path);
>
>         if (dir_gen) {
> -               ret = get_inode_info(root, parent_dir, NULL, dir_gen, NULL,
> -                                    NULL, NULL, NULL, NULL);
> +               ret = get_inode_gen(root, parent_dir, dir_gen);
>                 if (ret < 0)
>                         goto out;
>         }
> @@ -1874,6 +1897,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
>         int ret = 0;
>         u64 gen;
>         u64 other_inode = 0;
> +       struct inode_info info;
>
>         if (!sctx->parent_root)
>                 goto out;
> @@ -1888,8 +1912,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
>          * and we can just unlink this entry.
>          */
>         if (sctx->parent_root && dir != BTRFS_FIRST_FREE_OBJECTID) {
> -               ret = get_inode_info(sctx->parent_root, dir, NULL, &gen, NULL,
> -                                    NULL, NULL, NULL, NULL);
> +               ret = get_inode_gen(sctx->parent_root, dir, &gen);
>                 if (ret < 0 && ret != -ENOENT)
>                         goto out;
>                 if (ret) {
> @@ -1916,13 +1939,15 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
>          */
>         if (other_inode > sctx->send_progress ||
>             is_waiting_for_move(sctx, other_inode)) {
> -               ret = get_inode_info(sctx->parent_root, other_inode, NULL,
> -                               who_gen, who_mode, NULL, NULL, NULL, NULL);
> +               ret = get_inode_info(sctx->parent_root, other_inode,
> +                                    INODE_GEN|INODE_MODE, &info);

In the future, for bitwise OR, please add a space before and after the
operator, it makes things
easier to the eyes (INODE_GEN | INODE_MODE vs INODE_GEN|INODE_MODE).

Otherwise, it looks good. get_inode_info() definitely has too many
optional arguments.
Thanks.

>                 if (ret < 0)
>                         goto out;
>
>                 ret = 1;
>                 *who_ino = other_inode;
> +               *who_gen = info.gen;
> +               *who_mode = info.mode;
>         } else {
>                 ret = 0;
>         }
> @@ -1955,8 +1980,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
>                 goto out;
>
>         if (dir != BTRFS_FIRST_FREE_OBJECTID) {
> -               ret = get_inode_info(sctx->send_root, dir, NULL, &gen, NULL,
> -                                    NULL, NULL, NULL, NULL);
> +               ret = get_inode_gen(sctx->send_root, dir, &gen);
>                 if (ret < 0 && ret != -ENOENT)
>                         goto out;
>                 if (ret) {
> @@ -1978,8 +2002,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
>                 goto out;
>         }
>
> -       ret = get_inode_info(sctx->send_root, ow_inode, NULL, &gen, NULL, NULL,
> -                       NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->send_root, ow_inode, &gen);
>         if (ret < 0)
>                 goto out;
>
> @@ -2645,6 +2668,7 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
>         int ret = 0;
>         struct fs_path *p;
>         int cmd;
> +       struct inode_info info;
>         u64 gen;
>         u64 mode;
>         u64 rdev;
> @@ -2656,10 +2680,13 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
>                 return -ENOMEM;
>
>         if (ino != sctx->cur_ino) {
> -               ret = get_inode_info(sctx->send_root, ino, NULL, &gen, &mode,
> -                                    NULL, NULL, &rdev, NULL);
> +               ret = get_inode_info(sctx->send_root, ino,
> +                                    INODE_GEN|INODE_MODE|INODE_RDEV, &info);
>                 if (ret < 0)
>                         goto out;
> +               gen = info.gen;
> +               mode = info.mode;
> +               rdev = info.rdev;
>         } else {
>                 gen = sctx->cur_inode_gen;
>                 mode = sctx->cur_inode_mode;
> @@ -3359,8 +3386,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
>                 /*
>                  * The parent inode might have been deleted in the send snapshot
>                  */
> -               ret = get_inode_info(sctx->send_root, cur->dir, NULL,
> -                                    NULL, NULL, NULL, NULL, NULL, NULL);
> +               ret = get_inode_info(sctx->send_root, cur->dir, 0, NULL);
>                 if (ret == -ENOENT) {
>                         ret = 0;
>                         continue;
> @@ -3534,12 +3560,10 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
>                 goto out;
>         }
>
> -       ret = get_inode_info(sctx->parent_root, di_key.objectid, NULL,
> -                            &left_gen, NULL, NULL, NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->parent_root, di_key.objectid, &left_gen);
>         if (ret < 0)
>                 goto out;
> -       ret = get_inode_info(sctx->send_root, di_key.objectid, NULL,
> -                            &right_gen, NULL, NULL, NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->send_root, di_key.objectid, &right_gen);
>         if (ret < 0) {
>                 if (ret == -ENOENT)
>                         ret = 0;
> @@ -3669,8 +3693,7 @@ static int is_ancestor(struct btrfs_root *root,
>                                 cur_offset = item_size;
>                         }
>
> -                       ret = get_inode_info(root, parent, NULL, &parent_gen,
> -                                            NULL, NULL, NULL, NULL, NULL);
> +                       ret = get_inode_gen(root, parent, &parent_gen);
>                         if (ret < 0)
>                                 goto out;
>                         ret = check_ino_in_path(root, ino1, ino1_gen,
> @@ -3760,9 +3783,8 @@ static int wait_for_parent_move(struct send_ctx *sctx,
>                      memcmp(path_before->start, path_after->start, len1))) {
>                         u64 parent_ino_gen;
>
> -                       ret = get_inode_info(sctx->parent_root, ino, NULL,
> -                                            &parent_ino_gen, NULL, NULL, NULL,
> -                                            NULL, NULL);
> +                       ret = get_inode_gen(sctx->parent_root, ino,
> +                                           &parent_ino_gen);
>                         if (ret < 0)
>                                 goto out;
>                         if (ino_gen == parent_ino_gen) {
> @@ -4441,8 +4463,7 @@ static int record_new_ref_if_needed(int num, u64 dir, int index,
>         struct recorded_ref *ref;
>         u64 dir_gen;
>
> -       ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
> -                            NULL, NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->send_root, dir, &dir_gen);
>         if (ret < 0)
>                 goto out;
>
> @@ -4472,8 +4493,7 @@ static int record_deleted_ref_if_needed(int num, u64 dir, int index,
>         struct recorded_ref *ref;
>         u64 dir_gen;
>
> -       ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
> -                            NULL, NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->parent_root, dir, &dir_gen);
>         if (ret < 0)
>                 goto out;
>
> @@ -5056,8 +5076,7 @@ static int send_clone(struct send_ctx *sctx,
>         TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
>
>         if (clone_root->root == sctx->send_root) {
> -               ret = get_inode_info(sctx->send_root, clone_root->ino, NULL,
> -                               &gen, NULL, NULL, NULL, NULL, NULL);
> +               ret = get_inode_gen(sctx->send_root, clone_root->ino, &gen);
>                 if (ret < 0)
>                         goto out;
>                 ret = get_cur_path(sctx, clone_root->ino, gen, p);
> @@ -5536,6 +5555,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
>         struct btrfs_path *path;
>         struct btrfs_key key;
>         int ret;
> +       struct inode_info info;
>         u64 clone_src_i_size = 0;
>
>         /*
> @@ -5565,12 +5585,12 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
>          * There are inodes that have extents that lie behind its i_size. Don't
>          * accept clones from these extents.
>          */
> -       ret = __get_inode_info(clone_root->root, path, clone_root->ino,
> -                              &clone_src_i_size, NULL, NULL, NULL, NULL, NULL,
> -                              NULL);
> +       ret = get_inode_info(clone_root->root, clone_root->ino, INODE_SIZE,
> +                            &info);
>         btrfs_release_path(path);
>         if (ret < 0)
>                 goto out;
> +       clone_src_i_size = info.size;
>
>         /*
>          * We can't send a clone operation for the entire range if we find
> @@ -6259,6 +6279,7 @@ static int process_recorded_refs_if_needed(struct send_ctx *sctx, int at_end,
>  static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
>  {
>         int ret = 0;
> +       struct inode_info info;
>         u64 left_mode;
>         u64 left_uid;
>         u64 left_gid;
> @@ -6301,11 +6322,15 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
>                 goto out;
>         if (!at_end && sctx->cmp_key->objectid == sctx->cur_ino)
>                 goto out;
> -
> -       ret = get_inode_info(sctx->send_root, sctx->cur_ino, NULL, NULL,
> -                       &left_mode, &left_uid, &left_gid, NULL, &left_fileattr);
> +       ret = get_inode_info(sctx->send_root, sctx->cur_ino,
> +                            INODE_MODE|INODE_UID|INODE_GID|INODE_ATTR,
> +                            &info);
>         if (ret < 0)
>                 goto out;
> +       left_mode = info.mode;
> +       left_uid = info.uid;
> +       left_gid = info.gid;
> +       left_fileattr = info.attr;
>
>         if (!sctx->parent_root || sctx->cur_inode_new) {
>                 need_chown = 1;
> @@ -6317,10 +6342,15 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
>                 u64 old_size;
>
>                 ret = get_inode_info(sctx->parent_root, sctx->cur_ino,
> -                               &old_size, NULL, &right_mode, &right_uid,
> -                               &right_gid, NULL, &right_fileattr);
> +                                    INODE_SIZE|INODE_MODE|INODE_UID|
> +                                    INODE_GID|INODE_ATTR, &info);
>                 if (ret < 0)
>                         goto out;
> +               old_size = info.size;
> +               right_mode = info.mode;
> +               right_uid = info.uid;
> +               right_gid = info.gid;
> +               right_fileattr = info.attr;
>
>                 if (left_uid != right_uid || left_gid != right_gid)
>                         need_chown = 1;
> @@ -6790,13 +6820,11 @@ static int dir_changed(struct send_ctx *sctx, u64 dir)
>         u64 orig_gen, new_gen;
>         int ret;
>
> -       ret = get_inode_info(sctx->send_root, dir, NULL, &new_gen, NULL, NULL,
> -                            NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->send_root, dir, &new_gen);
>         if (ret)
>                 return ret;
>
> -       ret = get_inode_info(sctx->parent_root, dir, NULL, &orig_gen, NULL,
> -                            NULL, NULL, NULL, NULL);
> +       ret = get_inode_gen(sctx->parent_root, dir, &orig_gen);
>         if (ret)
>                 return ret;
>
> --
> 2.37.1
>
