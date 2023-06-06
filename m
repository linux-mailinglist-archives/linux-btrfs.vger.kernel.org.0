Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886D4723E78
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjFFJy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 05:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFFJyp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 05:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D283F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 02:54:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC1EB62FE5
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 09:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235FDC433EF
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686045283;
        bh=81845BfdGFI+Bs/7Y9FIwwQyoY0Kg4WGX/RgN+EhfXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fpyqrgilbH8psJhOWdHOELgvY5TvAoEFVWAqTptopvwr25DNmQW/bJ8npOldcDeGU
         PtaLHgGB6/hCHoh21EbXoZ2+mdP5M5FZJqSqrufqez5guOWG1nCj5B2jhPIi6bQO35
         nwSq8lmrebWzrY0042XdLVNXRrbGmekbQG/sFNSmXKB+nLXAzVCOGzk6ZOAvFfta2W
         JuOgJTANUJgsJtjJSgLrw1vvGFN4EumeTaQJd8u7UExYk+5qMg+EldMyMYt/xBfAVU
         MdHTmUWpINZq2seI6rPQ3+w/hFQXQLHzYn17STHHMRz7bFJwRmFR2JtGyIpe+PyQef
         rUd1QoifxnWNw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-19eab8bca4dso6583898fac.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 02:54:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDwH9FDMDVHM5/H4+vU/VCJNJmipj2bTc2jCKhfSHOUfjPuTLgPy
        FjxjqcsRlCydFOlw5Twvs/toNjB3GWYTQDEg1MM=
X-Google-Smtp-Source: ACHHUZ4vG9b6wVLbNNQjZfojxucLrJ8cUnAKxjX2jGYkbCKBK0W9vW+uMmSUy6LANJgbOqLn+Ci0we0ROpKwCVngJmI=
X-Received: by 2002:a05:6870:5b0b:b0:19e:8ab9:8f68 with SMTP id
 ds11-20020a0568705b0b00b0019e8ab98f68mr1789246oab.2.1686045282274; Tue, 06
 Jun 2023 02:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686028197.git.naohiro.aota@wdc.com> <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
In-Reply-To: <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 10:54:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H51ts45U08FfSMWcspBVB2NdwicOPYTqsVWhrS7WubTkg@mail.gmail.com>
Message-ID: <CAL3q7H51ts45U08FfSMWcspBVB2NdwicOPYTqsVWhrS7WubTkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: delete unused BGs while reclaiming BGs
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 6, 2023 at 7:04=E2=80=AFAM Naohiro Aota <naota@elisp.net> wrote=
:
>
> The reclaiming process only starts after the FS volumes are allocated to =
a
> certain level (75% by default). Thus, the list of reclaiming target block
> groups can build up so huge at the time the reclaim process kicks in. On =
a
> test run, there were over 1000 BGs in the reclaim list.
>
> As the reclaim involves rewriting the data, it takes really long time to
> reclaim the BGs. While the reclaim is running, btrfs_delete_unused_bgs()
> won't proceed because the reclaim side is holding
> fs_info->reclaim_bgs_lock. As a result, we will have a large number of un=
used
> BGs kept in the unused list. On my test run, I got 1057 unused BGs.
>
> Since deleting a block group is relatively easy and fast work, we can cal=
l
> btrfs_delete_unused_bgs() while it reclaims BGs, to avoid building up
> unused BGs.
>
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, great catch.

> ---
>  fs/btrfs/block-group.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 618ba7670e66..c5547da0f6eb 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1824,10 +1824,24 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
>
>  next:
>                 btrfs_put_block_group(bg);
> +
> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
> +               /*
> +                * Reclaiming all the BGs in the list can take really lon=
g.
> +                * Prioritize cleanning up unused BGs.
> +                */
> +               btrfs_delete_unused_bgs(fs_info);
> +               /*
> +                * If we are interrupted by a balance, we can just bail o=
ut. The
> +                * cleaner thread call me again if necessary.
> +                */
> +               if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
> +                       goto end;
>                 spin_lock(&fs_info->unused_bgs_lock);
>         }
>         spin_unlock(&fs_info->unused_bgs_lock);
>         mutex_unlock(&fs_info->reclaim_bgs_lock);
> +end:
>         btrfs_exclop_finish(fs_info);
>         sb_end_write(fs_info->sb);
>  }
> --
> 2.40.1
>
