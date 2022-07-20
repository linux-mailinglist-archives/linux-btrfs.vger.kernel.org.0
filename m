Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2C57BBF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiGTQvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiGTQv0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 12:51:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199B66AE1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 09:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A86C3B82154
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44891C3411E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658335882;
        bh=YvK2V8qSHzd1ABJ62Lfaatn+mGTtDwrXpAE+8uRr7bM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S6kW8mY4cYYHxdgZg9faSKv9aIvqT1zngoqm8it+xlxZhtLUGZxYjEr8tsyjya/61
         /ZQfWEAZEG+Y19M00uJ+LyDAWmaLeNCNtRssWjIo6OT6lGrZc71FPwKx7V+TDTHtKC
         mfHRFz+Viio2KMIq7OO5XlDNPF6sz8pP/oSgs70jhzwlK9dx10Q65G0nEbcoG26CaM
         mrx0+zhPi5eG1WXzJSA1V6MqMgq0L3sXqAh3BrqyTB+QhqE1c9o0r708p1G7CcHec/
         Mxx2CZ2eQU+9GIvyyD4J2eDXo8VEivzx7MMSXl4lZFuJlz30wu+BJnTTX4IfSX315G
         XZcf1RE7kOQRQ==
Received: by mail-qk1-f173.google.com with SMTP id b25so13330651qka.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 09:51:22 -0700 (PDT)
X-Gm-Message-State: AJIora8AZhcgFuDBH32R8wWhRa8qk7IcWxDE855xyIuQjZwueQBxxBSA
        iLxFSo+VA7TKLzjH1iN9n5t3pLdxrdq2TppGv2s=
X-Google-Smtp-Source: AGRyM1t9ey/6kc2KVTOhKLSe/FMv0ERQZsxIn/w4VLKttgWBxBeqosfHPXRHWFrlxhmKdndRNod9UA5Aih4VLJDAJp4=
X-Received: by 2002:a05:620a:2991:b0:6b5:e2be:1d02 with SMTP id
 r17-20020a05620a299100b006b5e2be1d02mr12716192qkp.9.1658335881201; Wed, 20
 Jul 2022 09:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com>
In-Reply-To: <2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 20 Jul 2022 17:50:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4EzE1Wc1siHtFQR4iMJ4ZaqWwi4AkXT9MpDCvR_PLxbQ@mail.gmail.com>
Message-ID: <CAL3q7H4EzE1Wc1siHtFQR4iMJ4ZaqWwi4AkXT9MpDCvR_PLxbQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not batch insert non-consecutive dir indexes
 during log replay
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 20, 2022 at 5:04 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> While running generic/475 in a loop I got the following error
>
> BTRFS critical (device dm-11): corrupt leaf: root=5 block=31096832 slot=69, bad key order, prev (263 96 531) current (263 96 524)
> <snip>
>  item 65 key (263 96 517) itemoff 14132 itemsize 33
>  item 66 key (263 96 523) itemoff 14099 itemsize 33
>  item 67 key (263 96 525) itemoff 14066 itemsize 33
>  item 68 key (263 96 531) itemoff 14033 itemsize 33
>  item 69 key (263 96 524) itemoff 14000 itemsize 33
>
> As you can see here we have 3 dir index keys with the dir index value of
> 523, 524, and 525 inserted between 517 and 524.  This occurs because our
> dir index insertion code will bulk insert all dir index items on the
> node regardless of their actual key value.
>
> This makes sense on a normally running system, because if there's a gap
> in between the items there was a deletion before the item was inserted,
> so there's not going to be an overlap of the dir index items that need
> to be inserted and what exists on disk.
>
> However during log replay this isn't necessarily true, we could have any
> number of dir indexes in the tree already.
>
> Fix this by seeing if we're replaying the log, and if we are simply skip
> batching if there's a gap in the key space.
>
> This file system was left broken from the fstest, I tested this patch
> against the broken fs to make sure it replayed the log properly, and
> then btrfs check'ed the file system after the log replay to verify
> everything was ok.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks, it looks good and it's what I would do if I weren't out the
next few days.
I'm unable to test until the end of next week, but the code looks fine
and you likely tested it.

> ---
>  fs/btrfs/delayed-inode.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 823aa05b3e38..0760578e0e86 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -691,9 +691,23 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>         int total_size;
>         char *ins_data = NULL;
>         int ret;
> +       bool need_consecutive = false;
>
>         lockdep_assert_held(&node->mutex);
>
> +       /*
> +        * We will just batch non-consecutive items for insertion while running,
> +        * because the dir index offset is continuously increasing.  If there is
> +        * a gap in the key.offset range we simply deleted that entry and that
> +        * key won't exist in the tree.
> +        *
> +        * The exception to this is log replay, where we could have any pattern
> +        * of keys in our fs tree.  If we're recovering the log we can only
> +        * batch keys that are consecutive and have no gaps in their key space.
> +        */
> +       if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
> +               need_consecutive = true;
> +
>         /*
>          * For delayed items to insert, we track reserved metadata bytes based
>          * on the number of leaves that we will use.
> @@ -715,6 +729,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>                 if (!next)
>                         break;
>
> +               /*
> +                * We cannot allow gaps in the key space if we're doing log
> +                * replay.
> +                */
> +               if (need_consecutive &&
> +                   (next->key.offset != curr->key.offset + 1))
> +                       break;
> +
>                 ASSERT(next->bytes_reserved == 0);
>
>                 next_size = next->data_len + sizeof(struct btrfs_item);
> @@ -775,7 +797,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>
>         ASSERT(node->index_item_leaves > 0);
>
> -       if (next) {
> +       /*
> +        * If we are need_consecutive we possibly stopped not because we batch
> +        * inserted an entire leaf, but because there was a gap in the key
> +        * space, so don't bother dropping the index_item_leaves here, simply
> +        * wait until we've run all of our items and release all of the space at
> +        * once.
> +        */
> +       if (next && !need_consecutive) {
>                 /*
>                  * We inserted one batch of items into a leaf a there are more
>                  * items to flush in a future batch, now release one unit of
> @@ -784,7 +813,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>                  */
>                 btrfs_delayed_item_release_leaves(node, 1);
>                 node->index_item_leaves--;
> -       } else {
> +       } else if (!next) {
>                 /*
>                  * There are no more items to insert. We can have a number of
>                  * reserved leaves > 1 here - this happens when many dir index
> --
> 2.26.3
>
