Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99995AD710
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIEQFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 12:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIEQFw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 12:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D03DF24
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 09:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB5A561366
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 16:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA7C433D6
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662393951;
        bh=vHwRGRcqb+tc0liFiFfo8iEkiGvL3Acz3jzXbbr6KDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EK3N5ci6g1L/CECnzVxmc6s3fORu9SYaNQfWlvCYPZXaUCsQfYINt4gS8oFZln0UV
         7TeA2TBZ3Z21Ffw8j/vLGD/OLtRyt/GWSPNooq4+4nEOP+Esx6c9XvjYk32ywnE1HS
         rOMoPRP+xx7g34OwidPJalqB1SlR3PXBxYgf9zjBmUJczAGH+x9i8N71QMFUge8epk
         mfjq75bXHEjac0jB73pmYUEuDWyAxkGS0kZWLCxSSFP+eBUZ4dlI04/xzW57oqW5sr
         JRuajfmkp4tMMdyR62tHFjHwMUxLXzJRNv1eNSTwUeyptpzOI3Zo7wvh3ktdYbTwyW
         J9+q01vEvFdxQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1278624b7c4so4088604fac.5
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Sep 2022 09:05:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo3hlfpzHVhQz+rDjnpmWE4xcCx+aUFjaRlSs3v/ljbaJNornT8X
        PDeWVjkF7q/zkkXuK5rgdcqUhIfClyt/TbzbB90=
X-Google-Smtp-Source: AA6agR7r6hQJ33TgSiGc+Cm0//FXeT24fIQ3dfDVl6sFiEYAxc5qThbHERqlEMLcbsPDskw8bM7/YY9ay1C7DxTyCHc=
X-Received: by 2002:a05:6808:f14:b0:343:5f65:a540 with SMTP id
 m20-20020a0568080f1400b003435f65a540mr7558508oiw.92.1662393950220; Mon, 05
 Sep 2022 09:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <YvHU/vsXd7uz5V6j@hungrycats.org> <CAL3q7H7XCZnsCfiz9yAgfSP8rekx7YntVKphdDu8LLSehJ1EAQ@mail.gmail.com>
 <20220905154203.GJ13489@twin.jikos.cz> <20220905155054.GK13489@twin.jikos.cz>
In-Reply-To: <20220905155054.GK13489@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 5 Sep 2022 17:05:14 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7=hsCxEHE=Y4xXYuLgZDtm5RGUw3J=XAKV_rLC7U7=Wg@mail.gmail.com>
Message-ID: <CAL3q7H7=hsCxEHE=Y4xXYuLgZDtm5RGUw3J=XAKV_rLC7U7=Wg@mail.gmail.com>
Subject: Re: for-next: KCSAN failures on 6130a25681d4 (kdave/for-next) Merge
 branch 'for-next-next-v5.20-20220804' into for-next-20220804
To:     dsterba@suse.cz
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 5, 2022 at 4:56 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Sep 05, 2022 at 05:42:03PM +0200, David Sterba wrote:
> > On Tue, Aug 09, 2022 at 08:35:42AM +0100, Filipe Manana wrote:
> > > On Tue, Aug 9, 2022 at 4:33 AM Zygo Blaxell
> > > <ce3g8jdj@umail.furryterror.org> wrote:
> > > >
> > > > Some KCSAN complaints I found while testing for other things...
> > > >
> > > > Here's one related to extent refs:
> > >
> > > It's about the block reserves, nothing to do with extents refs.
> > >
> > > These get reported every now and then like here:
> > >
> > > https://lore.kernel.org/linux-btrfs/CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com/
> > >
> > > It's actually harmless, but if we keep it like this, we'll keep
> > > getting reports in the future.
> >
> > Can we add some kind of annotation so KCSAN understands that? The ->full
> > member would be accessed using a helper when outside of the lock so the
> > annotation can be there.
>
> Something like (only compile-tested):

I was just seeing that at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

(linked from Documentation/dev-tools/kcsan.rst)


>
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 6ce704d3bdd2..ec96285357e0 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -286,7 +286,7 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
>          */
>         if (block_rsv == delayed_rsv)
>                 target = global_rsv;
> -       else if (block_rsv != global_rsv && !delayed_rsv->full)
> +       else if (block_rsv != global_rsv && !btrfs_block_rsv_full(delayed_rsv))
>                 target = delayed_rsv;
>
>         if (target && block_rsv->space_info != target->space_info)
> diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
> index 0c183709be00..a1f40b88fa82 100644
> --- a/fs/btrfs/block-rsv.h
> +++ b/fs/btrfs/block-rsv.h
> @@ -91,5 +91,9 @@ static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
>         btrfs_block_rsv_add_bytes(block_rsv, blocksize, false);
>         btrfs_block_rsv_release(fs_info, block_rsv, 0, NULL);
>  }
> +static inline bool btrfs_block_rsv_full(const struct btrfs_block_rsv *rsv)
> +{
> +       return data_race(rsv->full);
> +}
>
>  #endif /* BTRFS_BLOCK_RSV_H */
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a0a2652962ec..eb0ae7e396ef 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2426,7 +2426,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>          * still can allocate chunks and thus are fine using the currently
>          * calculated f_bavail.
>          */
> -       if (!mixed && btrfs_block_rsv_full(block_rsv->space_info) &&
> +       if (!mixed && block_rsv->space_info->full &&
>             total_free_meta - thresh < block_rsv->size)
>                 buf->f_bavail = 0;
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index d9e608935e64..9d7563df81a0 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -594,7 +594,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>                  */
>                 num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
>                 if (flush == BTRFS_RESERVE_FLUSH_ALL &&
> -                   delayed_refs_rsv->full == 0) {
> +                   btrfs_block_rsv_full(delayed_refs_rsv) == 0) {
>                         delayed_refs_bytes = num_bytes;
>                         num_bytes <<= 1;
>                 }
> @@ -619,7 +619,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>                 if (rsv->space_info->force_alloc)
>                         do_chunk_alloc = true;
>         } else if (num_items == 0 && flush == BTRFS_RESERVE_FLUSH_ALL &&
> -                  !delayed_refs_rsv->full) {
> +                  !btrfs_block_rsv_full(delayed_refs_rsv)) {

Looks good to me, thanks.

>                 /*
>                  * Some people call with btrfs_start_transaction(root, 0)
>                  * because they can be throttled, but have some other mechanism
