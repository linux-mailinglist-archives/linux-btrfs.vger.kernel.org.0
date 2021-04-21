Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7A366FA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbhDUQBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244164AbhDUQBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 12:01:37 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD002C06174A;
        Wed, 21 Apr 2021 09:01:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id m16so30942292qtx.9;
        Wed, 21 Apr 2021 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IZX0f4l29NX/01aOrqPfZSbd0Re69bnUWgeaZTOG6n8=;
        b=o6ZStsWKClgUKYeiAudSs0S4iegwa10djaCsrD0H1i/sVg3CH37ojWeJGWsaqjBNix
         fg4qq8UtjTiyYBHRHdhfzGVBeu60+ANyg0e6zfv/f2eEEkVCWegv312mtIfGQSMAUa1Y
         rGr8+H9yh/E5oO3CAH6rPqeuF8S75Rn1nLeoF7reuqGBG8ZNbRub8J8Ql97IYlVcSSrj
         JuVNOjy5o3PrdHKLn9Ix1yKaUEZX39wcmQwGOf63y8jmIedlt0vUieq9KFBgvfYfnEJz
         ddz6Ikj7ARk+gjuBYBN4auAphwkWWndTidZuF2IfdF7ok9j+y210jKxZMNDbiZ8IykVw
         g8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IZX0f4l29NX/01aOrqPfZSbd0Re69bnUWgeaZTOG6n8=;
        b=m8GfmeCGEZErVcaz8jSKJ4IOazyaavQv6YIAcZqa76ccgr4MkGG8x1SF1OvUw+nEWX
         CkPiELVZCO9cAdmlmgce8eKEiZ2ecdBvaj1HWIUztbm9foCq9ubJ0vgx16vYo33s4OFK
         ZJ78Cu0dmkaMmERIiVwh8nnngZx10L8le4zc62fuNA6csH2Z4QBJN1tQ4nGgEko2xHAj
         M68bxmo3/uHlAdmLGiFKpJ0sZY2WX3Jy1NEaz3cAUwaRvLGf9lZ4rhxoVY6vZt/aXb+k
         m6GJ12zpCP7caCdCOnYkM20QPIzT3Yl576FS1XNTVh8noudrDB0u4wfhPgUxT8A8OwKh
         3Dwg==
X-Gm-Message-State: AOAM532k9GlvLwPpREX3JYOz9Fy5ZZEmrIkL64QCdx/SXBq2RLLlJ8qT
        ECnj606bADHSZfVrLP9/pou4WbRUYUkfs+3EeOYG7H/BYdw=
X-Google-Smtp-Source: ABdhPJz/AkuXc+OhH2STai27k2AjCowcdJgOGN5BmBlmK48LFuPiREhp3bYkoIvSCb/7p7c7gembzxKuDg2BBH4ejx0=
X-Received: by 2002:ac8:b45:: with SMTP id m5mr22366004qti.56.1619020862693;
 Wed, 21 Apr 2021 09:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210317012054.238334-1-davispuh@gmail.com> <20210321214939.6984-1-davispuh@gmail.com>
In-Reply-To: <20210321214939.6984-1-davispuh@gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 21 Apr 2021 19:00:51 +0300
Message-ID: <CAOE4rSySx3fcRkvSMHEwpGVMFTOCeirw9owCu+9YDcLPzhsV9A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Allow read-only mount with corrupted extent tree
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sv=C4=93td., 2021. g. 21. marts, plkst. 23:46 =E2=80=94 lietot=C4=81js D=C4=
=81vis Mos=C4=81ns
(<davispuh@gmail.com>) rakst=C4=ABja:
>
> Currently if there's any corruption at all in extent tree
> (eg. even single bit) then mounting will fail with:
> "failed to read block groups: -5" (-EIO)
> It happens because we immediately abort on first error when
> searching in extent tree for block groups.
>
> Now with this patch if `ignorebadroots` option is specified
> then we handle such case and continue by removing already
> created block groups and creating dummy block groups.
>
> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> ---
>  fs/btrfs/block-group.c | 20 ++++++++++++++++++++
>  fs/btrfs/disk-io.c     |  4 ++--
>  fs/btrfs/disk-io.h     |  2 ++
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 48ebc106a606..f485cf14c2f8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2048,6 +2048,26 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info)
>         ret =3D check_chunk_block_group_mappings(info);
>  error:
>         btrfs_free_path(path);
> +
> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) {
> +
> +               if (btrfs_super_log_root(info->super_copy) !=3D 0) {
> +                       btrfs_warn(info, "Ignoring tree-log replay due to=
 extent tree corruption!");
> +                       btrfs_set_super_log_root(info->super_copy, 0);
> +               }
> +
> +               btrfs_put_block_group_cache(info);
> +               btrfs_stop_all_workers(info);
> +               btrfs_free_block_groups(info);
> +               ret =3D btrfs_init_workqueues(info, NULL);
> +               if (ret)
> +                       return ret;
> +               ret =3D btrfs_init_space_info(info);
> +               if (ret)
> +                       return ret;
> +               return fill_dummy_bgs(info);
> +       }
> +
>         return ret;
>  }
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 07a2b4f69b10..dc744f76d075 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1955,7 +1955,7 @@ static int read_backup_root(struct btrfs_fs_info *f=
s_info, u8 priority)
>  }
>
>  /* helper to cleanup workers */
> -static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
> +void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>  {
>         btrfs_destroy_workqueue(fs_info->fixup_workers);
>         btrfs_destroy_workqueue(fs_info->delalloc_workers);
> @@ -2122,7 +2122,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info =
*fs_info)
>         mutex_init(&fs_info->qgroup_rescan_lock);
>  }
>
> -static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
> +int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
>                 struct btrfs_fs_devices *fs_devices)
>  {
>         u32 max_active =3D fs_info->thread_pool_size;
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index e45057c0c016..f9bfcba86a04 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -137,6 +137,8 @@ int btrfs_find_free_objectid(struct btrfs_root *root,=
 u64 *objectid);
>  int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid);
>  int __init btrfs_end_io_wq_init(void);
>  void __cold btrfs_end_io_wq_exit(void);
> +void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info);
> +int btrfs_init_workqueues(struct btrfs_fs_info *fs_info, struct btrfs_fs=
_devices *fs_devices);
>
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  void btrfs_set_buffer_lockdep_class(u64 objectid,
> --
> 2.30.2
>

Ping? Could anyone take a look?
