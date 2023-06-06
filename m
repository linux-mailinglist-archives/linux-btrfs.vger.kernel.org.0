Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B634723EE7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjFFKHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFFKHL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 06:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7A196
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 03:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC61F626A4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16296C433A7
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686046029;
        bh=dc80pbCdbqAoxLyduVBLyBPJ+qrDgJorPmjkqsZD1Qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SgHDLTGyhZonWwkDcQokddjMP06+nG2uAk+WTsDJa5TVvatdesVxI0R/lHyiWtX8h
         bVnc4t5g3eYfqL/YYX2fms9voydteLFYJB2z2tRoZrWLPJoFmpKzLYAhjkhSGmzfb3
         9cjN4ZgfNy0eX3ReNb/a5RCqi6qjfd+rQw1aV/C1c/fqT51mxjgJeNy4KW4U88BRAE
         hKQuIMq5CElJlGwCafm9ChQWE6z4Slp4iasucxv2sQ9A57ms7i/tuQSVerUEvZmcSE
         X9trUt3tQBUN1ne3aMPQziS2D2EEG6LPUymzMkWp9pXzAwsiPTQuSN+dTymZQB/oMB
         xuyi2Izj57JfQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-394c7ba4cb5so4053182b6e.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 03:07:09 -0700 (PDT)
X-Gm-Message-State: AC+VfDyYMRXJ+9fpo3IjgLcueyheFrI9VX1HhOQxB5fjlDA7q6FTJNaO
        iDqpbJkfRaLghsCAzi153U0zwlvJuxyCJeS4PDs=
X-Google-Smtp-Source: ACHHUZ6rULQHYA82cS0ye52primKTx+XiuDeEWkSTsQxKK2uYAvw+aN16fenG1e9xyg/HIhEhFCDNgoFy31axXjyRkU=
X-Received: by 2002:a05:6808:293:b0:398:4a82:76e1 with SMTP id
 z19-20020a056808029300b003984a8276e1mr1627673oic.36.1686046028139; Tue, 06
 Jun 2023 03:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686028197.git.naohiro.aota@wdc.com> <6a25b9266b8fb08ff990214aae9efd04fed6b549.1686028197.git.naohiro.aota@wdc.com>
In-Reply-To: <6a25b9266b8fb08ff990214aae9efd04fed6b549.1686028197.git.naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 11:06:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6-0i+edxb6-x4hw0VdbMbC58HnMtW+5_Vy98sLTMw7MA@mail.gmail.com>
Message-ID: <CAL3q7H6-0i+edxb6-x4hw0VdbMbC58HnMtW+5_Vy98sLTMw7MA@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: move out now unused BG from the reclaim list
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

On Tue, Jun 6, 2023 at 7:06=E2=80=AFAM Naohiro Aota <naota@elisp.net> wrote=
:
>
> An unused block group is easy to remove to free up space and should be
> reclaimed fast. Such block group can often already be a target of the
> reclaim process. As we check list_empty(&bg->bg_list), we keep it in the
> reclaim list. That block group is never reclaimed until the file system i=
s
> filled e.g, 75%.
>
> Instead, we can move unused block group to the unused list and delete it
> fast.
>
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c5547da0f6eb..d5bba02167be 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1633,11 +1633,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_grou=
p *bg)
>  {
>         struct btrfs_fs_info *fs_info =3D bg->fs_info;
>
> +       trace_btrfs_add_unused_block_group(bg);
>         spin_lock(&fs_info->unused_bgs_lock);
>         if (list_empty(&bg->bg_list)) {
>                 btrfs_get_block_group(bg);
> -               trace_btrfs_add_unused_block_group(bg);
>                 list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
> +       } else {
> +               /* Pull out the BG from the reclaim_bgs list. */
> +               list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
>         }
>         spin_unlock(&fs_info->unused_bgs_lock);
>  }
> --
> 2.40.1
>
