Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B417A6EC9FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Apr 2023 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDXKPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Apr 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDXKPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Apr 2023 06:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6F359F
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 03:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2AC36148C
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7C9C433D2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682331288;
        bh=aajb8Fpypw0wKw8texx/1f8YrBP914bglL0riVpjGO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mbu80/pvJs496fQmfR7ZGvHvzPoguG9ZDlnF/dC8bPLp7w/3XVqotAzIElwI5dvT1
         ne78oHDXH0nVtyx4r93MMtMIBgrjFiwsAQXjCmVAMHlkvGbd6hkacPJmEIz8hKV0hg
         H/wWl4Pzpy/YKudULIbSPu1HEqGnF+H62H238SLFFSdN/gjIMOUmxwHZPrCAByyTcJ
         Mb+MCPSABye6tvuqNjmv61yTB+8ZuKfZxJIhThJ6IMp2e0dNCfOxzHIkBRrWtlrW23
         LuV09sRABgw5T30tknx973gqmgvJQ/FIfT3bzwGwl2I4n1askZEjgTpqIv8KudMhRM
         3eKiNtnM2CT9Q==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-541fb831026so1418257eaf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 03:14:47 -0700 (PDT)
X-Gm-Message-State: AAQBX9dMpR8wn9AykgtAgspQljxIFZSte/EsVVR0GX68ml1QHa+SV7x5
        qIN86/KY7Tpuk6v6Kp9TjqhTe4SYzvM8cafnfg0=
X-Google-Smtp-Source: AKy350Yatflh76EgM+EfHTgZkaP2GG1ke0zCoNt6vNe4atYPje6pgUfzkFpU9DiSU40sX0Yeh4S1csGg5uVEBIRyLMc=
X-Received: by 2002:a4a:a584:0:b0:546:d2db:ff9d with SMTP id
 d4-20020a4aa584000000b00546d2dbff9dmr5090193oom.1.1682331287093; Mon, 24 Apr
 2023 03:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <ef0c22ce3cf2f7941634ed1cb2ca718f04ce675d.1682296794.git.wqu@suse.com>
In-Reply-To: <ef0c22ce3cf2f7941634ed1cb2ca718f04ce675d.1682296794.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 24 Apr 2023 11:14:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6vXB9up96vvW2ODccWTWUD5_yqkDip4FWfzz-dGrnXDQ@mail.gmail.com>
Message-ID: <CAL3q7H6vXB9up96vvW2ODccWTWUD5_yqkDip4FWfzz-dGrnXDQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: make dev-scrub as an exclusive operation
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 24, 2023 at 2:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [PROBLEMS]
> Currently dev-scrub is not an exclusive operation, thus it's possible to
> run scrub with balance at the same time.
>
> But there are possible several problems when such concurrency is
> involved:
>
> - Scrub can lead to false alerts due to removed block groups
>   When balance is finished, it would delete the source block group
>   and may even do an discard.

So, I haven't taken a look at scrub after the recent rewrite you made.
But some comments on this.

Scrub has to deal with block groups getting removed anyway, due to the
automatic removal of empty block groups. The balance case is no different..=
.

You seem to have missed the fact that  before balance relocates a block gro=
up,
it pauses scrub, and then after finishing the relocation, it allows
scrub to resume.
The pausing happens at btrfs_relocate_chunk().
It only removes the block group  when it's empty...

Furthermore, transaction commits pause scrub, do the commit root switches w=
ith
scrub paused, and scrub uses (or it used) commit roots to search for
allocated extents.

Also, how is that discard problem possible?

If a block group is deleted, the discard only happens after the
corresponding transaction
is committed, and again, the transaction commit pauses scrub, the
discard happens while
scrub is paused (at btrfs_finish_extent_commit()), and scrub uses commit ro=
ots.

At least this used to be true before the recent scrub rewrite...

I would like to see a corrected changelog or at least updated to detail exa=
ctly
how these issues can happen.

>
>   In that case if a scrub is still running for that block group, we
>   can lead to false alerts on bad checksum.
>
> - Balance is already checking the checksum
>   Thus we're doing double checksum verification, under most cases it's
>   just a waste of IO and CPU time.

So what? If they're done sequentially, it's the same thing...
Multiple reads can also trigger checksum verification, both direct IO
and buffered IO.

Thanks.

>
> - Extra chance of unnecessary -ENOSPC
>   Both balance and scrub would try to mark the target block group
>   read-only.
>   With more block groups marked read-only, we have higher chance to
>   hit early -ENOSPC.
>
> [ENHANCEMENT]
> Let's make dev-scrub as an exclusive operation, but unlike regular
> exclusive operations, we need to allow multiple dev-scrub to run
> concurrently.
>
> Thus we introduce a new member, fs_info::exclusive_dev_scrubs, to record
> how many dev scrubs are running.
> And only set fs_info::exclusive_operation back to NONE when no more
> dev-scrub is running.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>
> This change is a change to the dev-scrub behavior, now we have extra
> error patterns.
>
> And some existing test cases would be invalid, as they expect
> concurrent scrub and balance as a background stress.
>
> Although this makes later logical bytenr based scrub much easier to
> implement (needs to be exclusive with dev-scrub).
> ---
>  fs/btrfs/disk-io.c |  1 +
>  fs/btrfs/fs.h      |  5 ++++-
>  fs/btrfs/ioctl.c   | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 59ea049fe7ee..c6323750be18 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2957,6 +2957,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
>         atomic_set(&fs_info->async_delalloc_pages, 0);
>         atomic_set(&fs_info->defrag_running, 0);
>         atomic_set(&fs_info->nr_delayed_iputs, 0);
> +       atomic_set(&fs_info->exclusive_dev_scrubs, 0);
>         atomic64_set(&fs_info->tree_mod_seq, 0);
>         fs_info->global_root_tree =3D RB_ROOT;
>         fs_info->max_inline =3D BTRFS_DEFAULT_MAX_INLINE;
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 0d98fc5f6f44..ff7c0c1fb145 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -335,7 +335,7 @@ struct btrfs_discard_ctl {
>  };
>
>  /*
> - * Exclusive operations (device replace, resize, device add/remove, bala=
nce)
> + * Exclusive operations (device replace, resize, device add/remove, bala=
nce, scrub)
>   */
>  enum btrfs_exclusive_operation {
>         BTRFS_EXCLOP_NONE,
> @@ -344,6 +344,7 @@ enum btrfs_exclusive_operation {
>         BTRFS_EXCLOP_DEV_ADD,
>         BTRFS_EXCLOP_DEV_REMOVE,
>         BTRFS_EXCLOP_DEV_REPLACE,
> +       BTRFS_EXCLOP_DEV_SCRUB,
>         BTRFS_EXCLOP_RESIZE,
>         BTRFS_EXCLOP_SWAP_ACTIVATE,
>  };
> @@ -744,6 +745,8 @@ struct btrfs_fs_info {
>
>         /* Type of exclusive operation running, protected by super_lock *=
/
>         enum btrfs_exclusive_operation exclusive_operation;
> +       /* Number of running dev_scrubs for exclusive operations. */
> +       atomic_t exclusive_dev_scrubs;
>
>         /*
>          * Zone size > 0 when in ZONED mode, otherwise it's used for a ch=
eck
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 25833b4eeaf5..4be89198baed 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -403,6 +403,20 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_inf=
o,
>         spin_lock(&fs_info->super_lock);
>         if (fs_info->exclusive_operation =3D=3D BTRFS_EXCLOP_NONE) {
>                 fs_info->exclusive_operation =3D type;
> +               if (type =3D=3D BTRFS_EXCLOP_DEV_SCRUB)
> +                       atomic_inc(&fs_info->exclusive_dev_scrubs);
> +               ret =3D true;
> +               spin_unlock(&fs_info->super_lock);
> +               return ret;
> +       }
> +
> +       /*
> +        * For dev-scrub, we allow multiple scrubs to be run concurrently
> +        * as it's a per-device operation.
> +        */
> +       if (type =3D=3D BTRFS_EXCLOP_DEV_SCRUB &&
> +           fs_info->exclusive_operation =3D=3D type) {
> +               atomic_inc(&fs_info->exclusive_dev_scrubs);
>                 ret =3D true;
>         }
>         spin_unlock(&fs_info->super_lock);
> @@ -442,7 +456,12 @@ void btrfs_exclop_start_unlock(struct btrfs_fs_info =
*fs_info)
>  void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
>  {
>         spin_lock(&fs_info->super_lock);
> -       WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
> +       if (fs_info->exclusive_operation =3D=3D BTRFS_EXCLOP_DEV_SCRUB) {
> +               if (atomic_dec_and_test(&fs_info->exclusive_dev_scrubs))
> +                       WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EX=
CLOP_NONE);
> +       } else {
> +               WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NON=
E);
> +       }
>         spin_unlock(&fs_info->super_lock);
>         sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_op=
eration");
>  }
> @@ -3172,9 +3191,17 @@ static long btrfs_ioctl_scrub(struct file *file, v=
oid __user *arg)
>                         goto out;
>         }
>
> +       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_SCRUB)) {
> +               ret =3D BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> +               if (!(sa->flags & BTRFS_SCRUB_READONLY))
> +                       mnt_drop_write_file(file);
> +               goto out;
> +       }
> +
>         ret =3D btrfs_scrub_dev(fs_info, sa->devid, sa->start, sa->end,
>                               &sa->progress, sa->flags & BTRFS_SCRUB_READ=
ONLY,
>                               0);
> +       btrfs_exclop_finish(fs_info);
>
>         /*
>          * Copy scrub args to user space even if btrfs_scrub_dev() return=
ed an
> --
> 2.39.2
>
