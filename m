Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B06723F57
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjFFK0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjFFK0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 06:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DABE6B
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 03:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F89261DA0
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0447C433A4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686047160;
        bh=axwZA4qlnpA4vGnV+XjKEaEguDI7Udp7uLk6RRVohk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lsw9yVgkQiAQMbLwV95ugy4PZtKnvGa2kM0g1VXVm6RO5WciCvPnKa14vMgDFxRnc
         nVr370L/K/Q0p/f/+zoc6SEmFkiGp/GDE3E69FX+4p7r/imBQbXvsNxypHff0YrXLX
         OESpZm8b3oRw+DSpEWqHtsZ8cBKrg9BJNLQEgBeH0Ss++VitZzAcewHijM9oowdJzD
         0MdQMNdFOLcco9ect8H4O3nKrLWzf4ioI7feVFovn7ZUgbB4uyNLTu9qMby+nWaG3I
         nn5yucEh6dELHddcF5n/M6VXkK+4kLjyjSpf4e5hPmYXVupx3FSpte7UiN98+E8ZPi
         RYPtJTWSwEEZA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5585f2f070bso4357658eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 03:26:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDySq7ysYjJp3gdD61lU1Zj2tIRmGmnCVyjRW064Sycd5917OLKe
        vyR/00XyJRs/O1eYzRG7GMEItI044FivMWd13jk=
X-Google-Smtp-Source: ACHHUZ5bGbGbvHTimCjY9cJkzYmPjMosTlVRmJq4sa9QDYRZnb4yojvV/I4AKnOuE1kvTBPWU4O5oxPQNId1aY7quUk=
X-Received: by 2002:a4a:dec2:0:b0:558:b7e5:1dd0 with SMTP id
 w2-20020a4adec2000000b00558b7e51dd0mr1347272oou.3.1686047159763; Tue, 06 Jun
 2023 03:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686028197.git.naohiro.aota@wdc.com> <e8acfcfefeb3156e11e60ea97dcd2c6ecf984101.1686028197.git.naohiro.aota@wdc.com>
In-Reply-To: <e8acfcfefeb3156e11e60ea97dcd2c6ecf984101.1686028197.git.naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 11:25:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5=dxzeGELzge_wJQJuRF8gzd_1SAm3O6QxcMB7HpSJkw@mail.gmail.com>
Message-ID: <CAL3q7H5=dxzeGELzge_wJQJuRF8gzd_1SAm3O6QxcMB7HpSJkw@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: reinsert BGs failed to reclaim
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
> The reclaim process can temporally fail. For example, if the space is

temporally -> temporarily

> getting tight, it fails to make the block group read-only. If there are n=
o
> further writes on that block group, the block group will never get back t=
o
> the reclaim list, and the BG never get reclaimed. In a certain workload, =
we

get -> gets

> can leave many such block groups never reclaimed.
>
> So, let's get it back to the list and give it a chance to be reclaimed.
>
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index db9bee071434..36e0d9b5d824 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1833,7 +1833,18 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>                 }
>
>  next:
> -               btrfs_put_block_group(bg);
> +               if (!ret) {
> +                       btrfs_put_block_group(bg);
> +               } else {
> +                       spin_lock(&bg->lock);

Why do we need to take bg->lock?
The ->bg_list is protected by fs_info->unused_bgs_lock alone.

> +                       spin_lock(&fs_info->unused_bgs_lock);
> +                       if (list_empty(&bg->bg_list))
> +                               list_add_tail(&bg->bg_list, &fs_info->rec=
laim_bgs);
> +                       else
> +                               btrfs_put_block_group(bg);
> +                       spin_unlock(&fs_info->unused_bgs_lock);
> +                       spin_unlock(&bg->lock);
> +               }

Also, this is very similar to btrfs_mark_bg_to_reclaim(), so we should
use that, and simply have:

btrfs_mark_bg_to_reclaim();
btrfs_put_block_group(bg);

Thanks.

>
>                 mutex_unlock(&fs_info->reclaim_bgs_lock);
>                 /*
> --
> 2.40.1
>
