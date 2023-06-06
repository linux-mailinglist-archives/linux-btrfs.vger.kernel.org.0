Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0077E723F1D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjFFKR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjFFKR2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 06:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9EE5B
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 03:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C500361CE1
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393F1C433D2
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686046646;
        bh=fg2om0q4oN+/ePBo2rZS7VfEYvBs2jqjythVJBE0E+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eHFKc58avbzKewN6QJ6eQ3bejykMXHL0mWITmM4/+9f5MQuX5g2PGUjFgLm1vpdjO
         rL8cacvzYkC7HMUOgvqJhyFaD3UfCVpXNESpzM3I8NbP/PazB58F+CFo2/q7UhMZ1P
         VBdrdym0+aloJHFchfibP4abSHqWPQfm93CAeymwMUsq+pmNKjSFDWF542tSyvj74p
         W/Mf4gW1tMcAFNeKmJqvvc6Te6wZCp51TDCWPRfowlk4t3qsgE+sCxRAet84TxIJwZ
         BKfHUeUos1dvRV6XZzS6Y45JUJKsxO68G4pHmt66tf0Ff6RSvy72LOcraj1C7loK5X
         tOMAuYEpXgypQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-19f454bd2c8so6580810fac.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 03:17:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDxZdCJ0fVb0JJNAHFOAtMElN+KroguWNogk7mgNv6rMVhq99zp2
        wZZU1GF5LgINY/1K0/FXVEgtbHbtVhy+pxGf5Yc=
X-Google-Smtp-Source: ACHHUZ5ITnaeJYDjXAB8qHVPc5kh2OjUiliYhxlIjvURDMSJtvDqXyX+niK7Rz5Rbc/2EcWz0i8iLvIrrIOimtm12hs=
X-Received: by 2002:a05:6871:341:b0:19f:8fd5:3493 with SMTP id
 c1-20020a056871034100b0019f8fd53493mr1645519oag.7.1686046645362; Tue, 06 Jun
 2023 03:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686028197.git.naohiro.aota@wdc.com> <d0a60acec35353dd7ad535bdddec0907857f2dd6.1686028197.git.naohiro.aota@wdc.com>
In-Reply-To: <d0a60acec35353dd7ad535bdddec0907857f2dd6.1686028197.git.naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 11:16:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6k=ptvu3rhFHgOt-q3nhvQ2rFfsiV13O1VZhNE4Q8e-w@mail.gmail.com>
Message-ID: <CAL3q7H6k=ptvu3rhFHgOt-q3nhvQ2rFfsiV13O1VZhNE4Q8e-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: bail out reclaim process if filesystem is read-only
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 6, 2023 at 7:21=E2=80=AFAM Naohiro Aota <naota@elisp.net> wrote=
:
>
> When a filesystem is read-only, we cannot reclaim a block group as it
> cannot rewrite the data. Just bail out in that case.
>
> Note that it can drop BGs in this case. As we did sb_start_write(),
> read-only filesystem means we got a fatal error and forced read-only. The=
re
> is no chance to reclaim them again.
>
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index d5bba02167be..db9bee071434 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1794,8 +1794,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>                 }
>                 spin_unlock(&bg->lock);
>
> -               /* Get out fast, in case we're unmounting the filesystem =
*/
> -               if (btrfs_fs_closing(fs_info)) {
> +               /*
> +                * Get out fast, in case we're read-only or unmounting th=
e
> +                * filesystem. It is OK to drop block groups from the lis=
t even
> +                * for the read-only case. As we did sb_start_write(), "m=
ount -o
> +                * ro" won't happen and read-only FS means it is forced

I think here you mean "mount -o remount,ro", just to be more clear.

> +                * read-only due to a fatal error. So, it never get back =
to

get -> gets

> +                * read-write to let us reclaime again.

reclaime -> reclaim

Other than that, it looks good to me.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.
> +                */
> +               if (btrfs_need_cleaner_sleep(fs_info)) {
>                         up_write(&space_info->groups_sem);
>                         goto next;
>                 }
> --
> 2.40.1
>
