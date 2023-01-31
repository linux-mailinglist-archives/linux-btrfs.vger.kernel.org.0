Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBA68341D
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAaRn3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 12:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaRn0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 12:43:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F314577CD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 09:42:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC792615F5
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 17:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D1C4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675186969;
        bh=UIFP/oEZC/TASb+3uUlfhe1lSan8U8VlhUD76mB+qAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IUm77ySaI5KG/rjnaxOK6KaVjy3OLRDBMPoNq48R/DT16gekZRJyisnzI6oZjdgzX
         CHjRIKSFY22rf4kDlw4Svk1R1SxULUPg8Hs7/pRK1SSq2rwk4Xd30TcqU3E0AjEqu1
         QhAvCUFjN4eEkhnG5uCB1hOx+g1jhglk3cSP7wgHmWqsSI3v4NG14D27AF6oYaoxBJ
         sVxwi9UKXJAVmbfhD3eMa0UBmyKEn6/BzUA9n3WPPb8vh4WozxuwDhCTWnoGzwAgup
         H4JoEn5MVHxubLYBrD9wL2zYpW/VCYFJot6X6KLLlSEjxNbwtyD3nAZY2SX8vKm0Sb
         3U/7/M/cvCswA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-163ba2b7c38so8484907fac.4
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 09:42:49 -0800 (PST)
X-Gm-Message-State: AO0yUKUJFVut+r4oNitBYYKbAHR6tRKG0bYSlogCULcnz6F+dtTldvTR
        T1UpRcXJ0NUh4vCDKtJM4BFprdxw0fyTIqTuof0=
X-Google-Smtp-Source: AK7set+K/OYLsjjM56mGOxAlqQsLMfl/FEzfRHHRzgbucUZidOyCS3sOC2FUXLlN6cU1KKdIfmncn4303ARBhf44yIs=
X-Received: by 2002:a05:6871:204:b0:15b:945f:9102 with SMTP id
 t4-20020a056871020400b0015b945f9102mr26476oad.92.1675186968284; Tue, 31 Jan
 2023 09:42:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673361215.git.fdmanana@suse.com> <ff77f41924e197d99e62ef323f03467c87ef43a0.1673361215.git.fdmanana@suse.com>
In-Reply-To: <ff77f41924e197d99e62ef323f03467c87ef43a0.1673361215.git.fdmanana@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 31 Jan 2023 17:42:12 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6rUwk4XiEim6qwLZDLs2qtnZzuLWbDLUDJU361=7xRJA@mail.gmail.com>
Message-ID: <CAL3q7H6rUwk4XiEim6qwLZDLs2qtnZzuLWbDLUDJU361=7xRJA@mail.gmail.com>
Subject: Re: [PATCH 6/8] btrfs: simplify update of last_dir_index_offset when
 logging a directory
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 3:20 PM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When logging a directory, we always set the inode's last_dir_index_offset
> to the offset of the last dir index item we found. This is using an extra
> field in the log context structure, and it makes more sense to update it
> only after we insert dir index items, and we could directly update the
> inode's last_dir_index_offset field instead.
>
> So make this simpler by updating the inode's last_dir_index_offset only
> when we actually insert dir index keys in the log tree, and getting rid
> of the last_dir_item_offset field in the log context structure.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reported-by: David Arendt <admin@prnet.org>
Link: https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/
Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/Y8voyTXdnPDz8xwY@mail.gmail.com/
Reported-by: Hunter Wardlaw <wardlawhunter@gmail.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1207231
CC: stable@vger.kernel.org # 6.1+

David, can you please add the following tags to the patch?
It happens to fix an issue those users reported, all on 6.1 only.

Thanks.

> ---
>  fs/btrfs/tree-log.c | 23 +++++++++++++++++------
>  fs/btrfs/tree-log.h |  2 --
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index d43261545264..58599189bd18 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3576,17 +3576,19 @@ static noinline int insert_dir_log_key(struct btrfs_trans_handle *trans,
>  }
>
>  static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
> -                                struct btrfs_root *log,
> +                                struct btrfs_inode *inode,
>                                  struct extent_buffer *src,
>                                  struct btrfs_path *dst_path,
>                                  int start_slot,
>                                  int count)
>  {
> +       struct btrfs_root *log = inode->root->log_root;
>         char *ins_data = NULL;
>         struct btrfs_item_batch batch;
>         struct extent_buffer *dst;
>         unsigned long src_offset;
>         unsigned long dst_offset;
> +       u64 last_index;
>         struct btrfs_key key;
>         u32 item_size;
>         int ret;
> @@ -3644,6 +3646,19 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
>         src_offset = btrfs_item_ptr_offset(src, start_slot + count - 1);
>         copy_extent_buffer(dst, src, dst_offset, src_offset, batch.total_data_size);
>         btrfs_release_path(dst_path);
> +
> +       last_index = batch.keys[count - 1].offset;
> +       ASSERT(last_index > inode->last_dir_index_offset);
> +
> +       /*
> +        * If for some unexpected reason the last item's index is not greater
> +        * than the last index we logged, warn and return an error to fallback
> +        * to a transaction commit.
> +        */
> +       if (WARN_ON(last_index <= inode->last_dir_index_offset))
> +               ret = -EUCLEAN;
> +       else
> +               inode->last_dir_index_offset = last_index;
>  out:
>         kfree(ins_data);
>
> @@ -3693,7 +3708,6 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
>                 }
>
>                 di = btrfs_item_ptr(src, i, struct btrfs_dir_item);
> -               ctx->last_dir_item_offset = key.offset;
>
>                 /*
>                  * Skip ranges of items that consist only of dir item keys created
> @@ -3756,7 +3770,7 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
>         if (batch_size > 0) {
>                 int ret;
>
> -               ret = flush_dir_items_batch(trans, log, src, dst_path,
> +               ret = flush_dir_items_batch(trans, inode, src, dst_path,
>                                             batch_start, batch_size);
>                 if (ret < 0)
>                         return ret;
> @@ -4044,7 +4058,6 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
>
>         min_key = BTRFS_DIR_START_INDEX;
>         max_key = 0;
> -       ctx->last_dir_item_offset = inode->last_dir_index_offset;
>
>         while (1) {
>                 ret = log_dir_items(trans, inode, path, dst_path,
> @@ -4056,8 +4069,6 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
>                 min_key = max_key + 1;
>         }
>
> -       inode->last_dir_index_offset = ctx->last_dir_item_offset;
> -
>         return 0;
>  }
>
> diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
> index 85b43075ac58..85cd24cb0540 100644
> --- a/fs/btrfs/tree-log.h
> +++ b/fs/btrfs/tree-log.h
> @@ -24,8 +24,6 @@ struct btrfs_log_ctx {
>         bool logging_new_delayed_dentries;
>         /* Indicate if the inode being logged was logged before. */
>         bool logged_before;
> -       /* Tracks the last logged dir item/index key offset. */
> -       u64 last_dir_item_offset;
>         struct inode *inode;
>         struct list_head list;
>         /* Only used for fast fsyncs. */
> --
> 2.35.1
>
