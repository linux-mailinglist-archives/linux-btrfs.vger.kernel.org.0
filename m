Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30951635FAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiKWNbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 08:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiKWNbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 08:31:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579612082
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 05:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D28D7B81FDA
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 13:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D412C433D7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669209173;
        bh=sbIU5Jf0AdXwybyL/PliXzJRLAfLa4MoUn6VVAzzPIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQjwtt9Y/2/Sg8YCKr7echcKHnGNXrFR0oVQUOeBzK05Ko9zsi4APSYEfv0ugCMLe
         OwZpBpejp5xCUROlhMCKCSwuvRtim+AI2aKRVcz+RgMCw+ayru1xAeWmdSAnz7wpHt
         OMDLBfxqsYxYeLYdvKSwUeJgA6S8q3TEkTwgEu+USlhGFEOrmqAyITVzuKhBOyz+vs
         R06c7E7rPFesnL1o1HgjFOci7VD7Sv8MwaDX2au2eZHCA3IboIsBMsZp2yXk7Af1p7
         qh7bGEN03coPe9q6Bhiq7ys2mf1V+XYppgDPIhtVXJh6fC0johYmXoXY/vzR4i9SD+
         /trxv79/bvnxA==
Received: by mail-oo1-f43.google.com with SMTP id v7-20020a4aa507000000b00496e843fdfeso2697261ook.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 05:12:53 -0800 (PST)
X-Gm-Message-State: ANoB5pmO7qN3OgLsfJ9xxXQIy2dZZQBoE/NR+BjQSjpuEvtgXUfA24qM
        lQ+kxEKMeRqk2DsRWyur+aT+OhtsUh1wxpqzZtY=
X-Google-Smtp-Source: AA0mqf5HtprKNyELeG7eHqD3Rmep5TVvh61DPPol7YOIvVnJxKuRaUAnevBjAmj5Kq8EHeNbRviaQlgwcVzb0NRx/00=
X-Received: by 2002:a4a:e9ac:0:b0:49f:d98d:81b with SMTP id
 t12-20020a4ae9ac000000b0049fd98d081bmr4675185ood.15.1669209172703; Wed, 23
 Nov 2022 05:12:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668530684.git.rgoldwyn@suse.com> <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
In-Reply-To: <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 23 Nov 2022 13:12:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7F-7njGV4tZJ8arcqwfzMO3_0_7qvpaWRCw1AhH6-55g@mail.gmail.com>
Message-ID: <CAL3q7H7F-7njGV4tZJ8arcqwfzMO3_0_7qvpaWRCw1AhH6-55g@mail.gmail.com>
Subject: Re: [PATCH 01/16] btrfs: check for range correctness while locking or
 setting extent bits
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 6:13 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> Since we will be working at the mercy of userspace, check if the range
> is valid and proceed to lock or set bits only if start < end.

At the mercy of user space, how? Can you be more detailed about what you mean?

Is this something you ran into, or is this just to prevent such cases
from happening?

>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/extent-io-tree.c | 6 ++++++
>  fs/btrfs/ordered-data.c   | 3 +++
>  2 files changed, 9 insertions(+)
>
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 21fa15123af8..80657c820df4 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -557,6 +557,9 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>         int wake;
>         int delete = (bits & EXTENT_CLEAR_ALL_BITS);
>
> +       if (unlikely(start > end))
> +               return 0;

Having a start > end indicates a bug somewhere else, which should be
fixed in the caller.

That happened a few times in a distant past, one example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccccf3d67294714af2d72a6fd6fd7d73b01c9329

And that leads to nasty side effects much later on (inode eviction),
as described in that changelog.

If anything, we should assert here, and if assertions are disabled,
trigger a warning and return an error, not silently ignoring it.
Something like:

ASSERT(start < end);
if (WARN_ON(start >= end))
     return -WHAT_EVER_ERRNO;

Thanks.

> +
>         btrfs_debug_check_extent_io_range(tree, start, end);
>         trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
>
> @@ -979,6 +982,9 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>         u64 last_end;
>         u32 exclusive_bits = (bits & EXTENT_LOCKED);
>
> +       if (unlikely(start > end))
> +               return 0;
> +
>         btrfs_debug_check_extent_io_range(tree, start, end);
>         trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4bed0839b640..0a5512ed9a21 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1043,6 +1043,9 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
>         struct extent_state *cache = NULL;
>         struct extent_state **cachedp = &cache;
>
> +       if (unlikely(start > end))
> +               return;
> +
>         if (cached_state)
>                 cachedp = cached_state;
>
> --
> 2.35.3
>
