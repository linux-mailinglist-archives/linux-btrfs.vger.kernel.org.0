Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B5595706
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiHPJts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 05:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiHPJtZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 05:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B72CCE44E
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 01:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA586121E
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 08:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2516BC433D7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660639780;
        bh=gRhHNZSafxMdhjM7qdUvyLyMabhlJbFxoByZmbaLdcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=alt0KOCfK1IameSqjx3+SJSWTApiY5LeCsOfgJ3cN7vs4ar9A5PzhJ2Z+hG7lrO5w
         S2egFTG3UYcjwQxP/ahjz/NmB/Xe6hzDKppdQW96IvkLJypKnY+huxsxEOmbWoECU2
         KaLbTk9HAuBMBcywZ9TFhlUDYotzhm+qxiamn85yNetUelTAL1ICscMFpnfG+1Xvby
         GG7zRVNvkjnyjeAXc+yqptTKPMVFf2VxFYyxAylls84dHUp9/1uWIPvTWO2zYILcoV
         f7QOxC3IudIrvuuSdC8+mvlnWPq5213Rz0qaVTT6yK3moYRaKgM/NLfnRHiYOhws3Q
         EXyDpJOiMod6w==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so5799503fac.12
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 01:49:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo0x+1InVzOiG0oXmZmAOUGIjCKPviSEEfU3VKgUnT+Zpp2YivJp
        YQqr/7sLIxRNEyITVMcsWfLK45oimIUl2N/VNxE=
X-Google-Smtp-Source: AA6agR6hVxbcc4+xKBzeT/U3TBbQmwf9V7EsJ9c2qlJyRN+exlHwtREAMXYmog1c/IHyV91sWYdHIAHccqfW1uJrCcg=
X-Received: by 2002:a05:6870:42cb:b0:10f:530:308 with SMTP id
 z11-20020a05687042cb00b0010f05300308mr8910903oah.294.1660639779144; Tue, 16
 Aug 2022 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220815024209.26122-1-ethanlien@synology.com>
In-Reply-To: <20220815024209.26122-1-ethanlien@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Aug 2022 09:49:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6DkF-tJA2K8beUg93o851-2tqxyD7LtJwoirO060EOLQ@mail.gmail.com>
Message-ID: <CAL3q7H6DkF-tJA2K8beUg93o851-2tqxyD7LtJwoirO060EOLQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove unnecessary EXTENT_UPTODATE state in
 buffered I/O path
To:     ethanlien <ethanlien@synology.com>
Cc:     linux-btrfs@vger.kernel.org, cunankimo@gmail.com
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

On Mon, Aug 15, 2022 at 4:16 AM ethanlien <ethanlien@synology.com> wrote:
>
> From: Ethan Lien <ethanlien@synology.com>
>
> After we copied data to page cache in buffered I/O, we
> 1. Insert a EXTENT_UPTODATE state into inode's io_tree, by
>    endio_readpage_release_extent(), set_extent_delalloc() or
>    set_extent_defrag().
> 2. Set page uptodate before we unlock the page.
>
> But the only place we check io_tree's EXTENT_UPTODATE state is in
> btrfs_do_readpage(). We know we enter btrfs_do_readpage() only when we
> have a non-uptodate page, so it is unnecessary to set EXTENT_UPTODATE.
>
> For example, when performing a buffered random read:
>
>         fio --rw=randread --ioengine=libaio --direct=0 --numjobs=4 \
>                 --filesize=32G --size=4G --bs=4k --name=job \
>                 --filename=/mnt/file --name=job
>
> Then check how many extent_state in io_tree:
>
>         cat /proc/slabinfo | grep btrfs_extent_state | awk '{print $2}'
>
> w/o this patch, we got 640567 btrfs_extent_state.
> w/  this patch, we got    204 btrfs_extent_state.

Did fio also report increased throughput?

>
> Maintaining such a big tree brings overhead since every I/O needs to insert
> EXTENT_LOCKED, insert EXTENT_UPTODATE, then remove EXTENT_LOCKED. And in
> every insert or remove, we need to lock io_tree, do tree search, alloc or
> dealloc extent states. By removing unnecessary EXTENT_UPTODATE, we keep
> io_tree in a minimal size and reduce overhead when performing buffered I/O.

The idea is sound, and I don't see a reason to keep using
EXTENT_UPTODATE as well.

>
> Signed-off-by: Ethan Lien <ethanlien@synology.com>
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/extent-io-tree.h | 4 ++--
>  fs/btrfs/extent_io.c      | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index c3eb52dbe61c..53ae849d0248 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -211,7 +211,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
>                                       struct extent_state **cached_state)
>  {
>         return set_extent_bit(tree, start, end,
> -                             EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
> +                             EXTENT_DELALLOC | extra_bits,
>                               0, NULL, cached_state, GFP_NOFS, NULL);
>  }
>
> @@ -219,7 +219,7 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
>                 u64 end, struct extent_state **cached_state)
>  {
>         return set_extent_bit(tree, start, end,
> -                             EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
> +                             EXTENT_DELALLOC | EXTENT_DEFRAG,
>                               0, NULL, cached_state, GFP_NOFS, NULL);
>  }
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bfae67c593c5..e0f0a39cd6eb 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2924,9 +2924,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
>          * Now we don't have range contiguous to the processed range, release
>          * the processed range now.
>          */
> -       if (processed->uptodate && tree->track_uptodate)
> -               set_extent_uptodate(tree, processed->start, processed->end,
> -                                   &cached, GFP_ATOMIC);

This is another good thing, to get rid of a GFP_ATOMIC allocation.

Why didn't you remove the set_extent_uptodate() call at btrfs_get_extent() too?
It can only be set during a page read at btrfs_do_readpage(), for an
inline extent.

Also, having the tests for EXTENT_UPTODATE at btrfs_do_readpage() now become
useless too, don't they? Why have you kept them?

Thanks.

>         unlock_extent_cached_atomic(tree, processed->start, processed->end,
>                                     &cached);
>
> --
> 2.17.1
>
