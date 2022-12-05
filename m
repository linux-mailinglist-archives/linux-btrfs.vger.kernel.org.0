Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7D6426E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiLEKpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 05:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 05:45:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA654DF5E;
        Mon,  5 Dec 2022 02:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98D2CB80E9C;
        Mon,  5 Dec 2022 10:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25013C433D6;
        Mon,  5 Dec 2022 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670237100;
        bh=x0dL013fJAgeF/jujKI7430NVHO0hswW/W9LQgRn5FM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EXTNj0ggksv6L22rmrrpAI3J4B5C6S3QkAvuZXiHg8WA3ynBlTEgyV/MTBDgJDsU4
         UnuKdgTVgReaOaX47PojMQxDENf/IDvMRUs8mTjby2Q+Txo16tqnOYc4qpX6R2so0T
         4Y9u0fovv5DCO+u2t/EpBV3GSoedibNgk+Fu0tOlFfINrtC2tkbX+reE7ImO0E429x
         l8gQU8wK+qYJWXlz4iKyB2kT/0zLWUCjRqnyMRWSyAQalEhq6BDXkPSSA6sVXbkBGC
         ktBbIF5J9nLWG1CSvGIDQner1pbs0SOnyG2Ttto0STFAdgCCNJojR5X+9Ahhm9Gy2Z
         HETu79FrFAeaQ==
Received: by mail-ot1-f44.google.com with SMTP id v19-20020a9d5a13000000b0066e82a3872dso4946253oth.5;
        Mon, 05 Dec 2022 02:45:00 -0800 (PST)
X-Gm-Message-State: ANoB5pkb1vcCIReMTmjOO9vYdpo9Zh/pzom0T9EXOoo0URWTyde6BFFT
        Ao0qHZ9Fyk79u5l9jpQ/1ZqgqBmx5oY6aLG2PHo=
X-Google-Smtp-Source: AA0mqf4RKdHq0D/ZMyKI/ZZFhGNRj6pR+++/gX1w+CZopKJkck7AchHhPSyitBYjsxMO9kcutpVW1JYWrR3/Gyf3AsI=
X-Received: by 2002:a9d:5d04:0:b0:66b:85b7:ac37 with SMTP id
 b4-20020a9d5d04000000b0066b85b7ac37mr34465693oti.363.1670237099254; Mon, 05
 Dec 2022 02:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20221201160724.2593341-1-cccheng@synology.com>
In-Reply-To: <20221201160724.2593341-1-cccheng@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 5 Dec 2022 10:44:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5oet2P9XijTtzPo3joZWdoa3OuD9L-wK9nTEFya2PY8w@mail.gmail.com>
Message-ID: <CAL3q7H5oet2P9XijTtzPo3joZWdoa3OuD9L-wK9nTEFya2PY8w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: refuse to remount read-write with unsupported
 compat-ro features
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Johnny Chang <johnnyc@synology.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 1, 2022 at 5:07 PM Chung-Chiang Cheng <cccheng@synology.com> wrote:
>
> btrfs with unsupported compat-ro features can only be mounted as
> read-only, but we can make it read-write indirectly through remount.
> Just add the missing check to refuse it.
>
>   mount -o ro /dev/vdb /mnt
>   mount -o remount,rw /mnt
>
> Reported-by: Johnny Chang <johnnyc@synology.com>
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/btrfs/super.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 5942b9384088..45836a426499 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1991,6 +1991,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>         unsigned old_flags = sb->s_flags;
>         unsigned long old_opts = fs_info->mount_opt;
>         unsigned long old_compress_type = fs_info->compress_type;
> +       u64 compat_ro = btrfs_super_compat_ro_flags(fs_info->super_copy);
> +       u64 compat_ro_unsupp = compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP;
>         u64 old_max_inline = fs_info->max_inline;
>         u32 old_thread_pool_size = fs_info->thread_pool_size;
>         u32 old_metadata_ratio = fs_info->metadata_ratio;
> @@ -2107,6 +2109,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>                 if (ret)
>                         goto restore;
>         } else {
> +               if (compat_ro_unsupp) {
> +                       btrfs_err(fs_info,
> +                               "cannot remount read-write because of unknown compat_ro features (0x%llx)",
> +                               compat_ro);
> +                       ret = -EINVAL;
> +                       goto restore;
> +               }

Wasn't this already done by the following commit?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81d5d61454c365718655cfc87d8200c84e25d596

Thanks.


>                 if (BTRFS_FS_ERROR(fs_info)) {
>                         btrfs_err(fs_info,
>                                 "Remounting read-write after error is not allowed");
> --
> 2.34.1
>
