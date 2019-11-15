Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7BFDE54
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 13:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKOMv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 07:51:58 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42361 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKOMv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 07:51:58 -0500
Received: by mail-vs1-f66.google.com with SMTP id a143so6227620vsd.9
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2019 04:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=s6/ig5sYIlaTfr0Lzw0Vbw41xkCbQkylAy/1CfczJEg=;
        b=XINqVulW5ccw3IVakqmxC4Ngqrjuxv1o20yGPIGgCnfyNzC4f/WE44eR6plGN9+xIy
         yMdG6rtmsF9Dp47115YBa96LigYdYAw+QzPp64KZGnwebALkIeqZnikxvw3tqd/9gST6
         i0J6AfYyXwrAUnZQmHz5FScF0scBApjhpbsQ58+EZ3PJPyJCdYaz9TGmoXLLaR3XLQFp
         lKXzfUqHQ+kNslv/7/H5iYu1pJwwjegYzofAC/OvwRWH2P39Bt/63hAxs7ZBxcM9+aUg
         Fub9umYRDAFeszAq2osYbZ34UCGdXA8ehbXf26/jMhy1b7KeLlKQZvikQ8T9OHl2Gzky
         a5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=s6/ig5sYIlaTfr0Lzw0Vbw41xkCbQkylAy/1CfczJEg=;
        b=gDd9tsr0F4QpVHTiSZRjYEuf4Xv52n0n82rfPG+4bhE+soEyVpXCT1VmgSyn0GTwWX
         s4mrCzxgbpVas6rK0I0inxYEZ6IVBdhwKsR7PNQ+mVxaQvoQVxHRacK9i+WrEKqPV7Fn
         qPRDuE2KIxT9T/UnqFznTJbIV7M64/cUpbzM3TERbrt2vuJDeQ0IARK+WRz0YWf6DtiO
         MbM5kPSFJoC50ePoiSNeYJBkCJh+ejrxZBSbEUuZFDftjJtIc4n5F7UPKlG5YteRaCq4
         0LPmTdA2La706g459gSOk2/LvXTInaPdXvKrZwdYDh7MYdg2NyYDXpFKydGDRKesQv9J
         WOeg==
X-Gm-Message-State: APjAAAV7Pa2mXlSX+4ZqEFBLABUkPiIqzqE4dq6Tdtg61gZbHdg33B2d
        UBO+5HKilpdOF77luhs8jcxso2rZNBzLyH16R3M=
X-Google-Smtp-Source: APXvYqym4lZvzd1o3gpca5TdaKJQG/6vW2ehN0sk9at5Jr7Hk9pAoNiVxQtHbqXN5BOotZ29Zk6R6aLwZy496ZJI2xg=
X-Received: by 2002:a67:3258:: with SMTP id y85mr9074606vsy.206.1573822315552;
 Fri, 15 Nov 2019 04:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20191115020900.23662-1-wqu@suse.com>
In-Reply-To: <20191115020900.23662-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 15 Nov 2019 12:51:44 +0000
Message-ID: <CAL3q7H42s48RwwOVmQg7ARxTo0-2uPJwVnTGgP4tizNHsCuu1A@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: scrub: Don't check free space before marking a
 block group RO
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 15, 2019 at 2:11 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/072 with only one online CPU, it has a pretty high
> chance to fail:
>
>   btrfs/072 12s ... _check_dmesg: something found in dmesg (see xfstests-=
dev/results//btrfs/072.dmesg)
>   - output mismatch (see xfstests-dev/results//btrfs/072.out.bad)
>       --- tests/btrfs/072.out     2019-10-22 15:18:14.008965340 +0800
>       +++ /xfstests-dev/results//btrfs/072.out.bad      2019-11-14 15:56:=
45.877152240 +0800
>       @@ -1,2 +1,3 @@
>        QA output created by 072
>        Silence is golden
>       +Scrub find errors in "-m dup -d single" test
>       ...
>
> And with the following call trace:
>   BTRFS info (device dm-5): scrub: started on devid 1
>   ------------[ cut here ]------------
>   BTRFS: Transaction aborted (error -27)
>   WARNING: CPU: 0 PID: 55087 at fs/btrfs/block-group.c:1890 btrfs_create_=
pending_block_groups+0x3e6/0x470 [btrfs]
>   CPU: 0 PID: 55087 Comm: btrfs Tainted: G        W  O      5.4.0-rc1-cus=
tom+ #13
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/20=
15
>   RIP: 0010:btrfs_create_pending_block_groups+0x3e6/0x470 [btrfs]
>   Call Trace:
>    __btrfs_end_transaction+0xdb/0x310 [btrfs]
>    btrfs_end_transaction+0x10/0x20 [btrfs]
>    btrfs_inc_block_group_ro+0x1c9/0x210 [btrfs]
>    scrub_enumerate_chunks+0x264/0x940 [btrfs]
>    btrfs_scrub_dev+0x45c/0x8f0 [btrfs]
>    btrfs_ioctl+0x31a1/0x3fb0 [btrfs]
>    do_vfs_ioctl+0x636/0xaa0
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x43/0x50
>    do_syscall_64+0x79/0xe0
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   ---[ end trace 166c865cec7688e7 ]---
>
> [CAUSE]
> The error number -27 is -EFBIG, returned from the following call chain:
> btrfs_end_transaction()
> |- __btrfs_end_transaction()
>    |- btrfs_create_pending_block_groups()
>       |- btrfs_finish_chunk_alloc()
>          |- btrfs_add_system_chunk()
>
> This happens because we have used up all space of
> btrfs_super_block::sys_chunk_array.
>
> The root cause is, we have the following bad loop of creating tons of
> system chunks:
> 1. The only SYSTEM chunk is being scrubbed
>    It's very common to have only one SYSTEM chunk.
> 2. New SYSTEM bg will be allocated
>    As btrfs_inc_block_group_ro() will check if we have enough space
>    after marking current bg RO. If not, then allocate a new chunk.
> 3. New SYSTEM bg is still empty, will be reclaimed
>    During the reclaim, we will mark it RO again.
> 4. That newly allocated empty SYSTEM bg get scrubbed
>    We go back to step 2, as the bg is already mark RO but still not
>    cleaned up yet.
>
> If the cleaner kthread doesn't get executed fast enough (e.g. only one
> CPU), then we will get more and more empty SYSTEM chunks, using up all
> the space of btrfs_super_block::sys_chunk_array.
>
> [FIX]
> Since scrub/dev-replace doesn't always need to allocate new extent,
> especially chunk tree extent, so we don't really need to do chunk
> pre-allocation.
>
> To break above spiral, here we introduce a new parameter to
> btrfs_inc_block_group(), @do_chunk_alloc, which indicates whether we
> need extra chunk pre-allocation.
>
> For relocation, we pass @do_chunk_alloc=3Dtrue, while for scrub, we pass
> @do_chunk_alloc=3Dfalse.
> This should keep unnecessary empty chunks from popping up for scrub.
>
> Also, since there are two parameters for btrfs_inc_block_group_ro(),
> add more comment for it.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Now it looks good to me, thanks.

>
> ---
> This version is based on v5.4-rc1, for a commonly known commit hash.
> It would cause conflicts due to
> btrfs_block_group_cache -> btrfs_block_group refactor.
>
> The conflicts should be easy to solve.
>
> Changelog:
> v2:
> - Fix a bug that previous verion never do chunk pre-allocation.
> - Avoid chunk pre-allocation from check_system_chunk()
> - Use extra parameter @do_chunk_alloc other than new function with
>   "_force" suffix.
> - Skip unnecessary update_block_group_flags() call completely for
>   do_chunk_alloc=3Dfalse case.
> ---
>  fs/btrfs/block-group.c | 49 +++++++++++++++++++++++++++---------------
>  fs/btrfs/block-group.h |  3 ++-
>  fs/btrfs/relocation.c  |  2 +-
>  fs/btrfs/scrub.c       | 21 +++++++++++++++++-
>  4 files changed, 55 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bf7e3f23bba7..ae23319e4233 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2021,8 +2021,17 @@ static u64 update_block_group_flags(struct btrfs_f=
s_info *fs_info, u64 flags)
>         return flags;
>  }
>
> -int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
> -
> +/*
> + * Mark one block group ro, can be called several times for the same blo=
ck
> + * group.
> + *
> + * @cache:             The destination block group
> + * @do_chunk_alloc:    Whether need to do chunk pre-allocation, this is =
to
> + *                     ensure we still have some free space after markin=
g this
> + *                     block group RO.
> + */
> +int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
> +                            bool do_chunk_alloc)
>  {
>         struct btrfs_fs_info *fs_info =3D cache->fs_info;
>         struct btrfs_trans_handle *trans;
> @@ -2052,25 +2061,30 @@ int btrfs_inc_block_group_ro(struct btrfs_block_g=
roup_cache *cache)
>                 goto again;
>         }
>
> -       /*
> -        * if we are changing raid levels, try to allocate a correspondin=
g
> -        * block group with the new raid level.
> -        */
> -       alloc_flags =3D update_block_group_flags(fs_info, cache->flags);
> -       if (alloc_flags !=3D cache->flags) {
> -               ret =3D btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC=
_FORCE);
> +       if (do_chunk_alloc) {
>                 /*
> -                * ENOSPC is allowed here, we may have enough space
> -                * already allocated at the new raid level to
> -                * carry on
> +                * if we are changing raid levels, try to allocate a
> +                * corresponding block group with the new raid level.
>                  */
> -               if (ret =3D=3D -ENOSPC)
> -                       ret =3D 0;
> -               if (ret < 0)
> -                       goto out;
> +               alloc_flags =3D update_block_group_flags(fs_info, cache->=
flags);
> +               if (alloc_flags !=3D cache->flags) {
> +                       ret =3D btrfs_chunk_alloc(trans, alloc_flags,
> +                                               CHUNK_ALLOC_FORCE);
> +                       /*
> +                        * ENOSPC is allowed here, we may have enough spa=
ce
> +                        * already allocated at the new raid level to
> +                        * carry on
> +                        */
> +                       if (ret =3D=3D -ENOSPC)
> +                               ret =3D 0;
> +                       if (ret < 0)
> +                               goto out;
> +               }
>         }
>
> -       ret =3D inc_block_group_ro(cache, 0);
> +       ret =3D inc_block_group_ro(cache, !do_chunk_alloc);
> +       if (!do_chunk_alloc)
> +               goto unlock_out;
>         if (!ret)
>                 goto out;
>         alloc_flags =3D btrfs_get_alloc_profile(fs_info, cache->space_inf=
o->flags);
> @@ -2085,6 +2099,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gro=
up_cache *cache)
>                 check_system_chunk(trans, alloc_flags);
>                 mutex_unlock(&fs_info->chunk_mutex);
>         }
> +unlock_out:
>         mutex_unlock(&fs_info->ro_block_group_mutex);
>
>         btrfs_end_transaction(trans);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index c391800388dd..0758e6d52acb 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -205,7 +205,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *inf=
o);
>  int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_u=
sed,
>                            u64 type, u64 chunk_offset, u64 size);
>  void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)=
;
> -int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
> +int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
> +                            bool do_chunk_alloc);
>  void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
>  int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 00504657b602..fd6df6dd5421 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4325,7 +4325,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info=
 *fs_info, u64 group_start)
>         rc->extent_root =3D extent_root;
>         rc->block_group =3D bg;
>
> -       ret =3D btrfs_inc_block_group_ro(rc->block_group);
> +       ret =3D btrfs_inc_block_group_ro(rc->block_group, true);
>         if (ret) {
>                 err =3D ret;
>                 goto out;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f7d4e03f4c5d..7e48d65bbdf6 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3563,7 +3563,26 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>                  * -> btrfs_scrub_pause()
>                  */
>                 scrub_pause_on(fs_info);
> -               ret =3D btrfs_inc_block_group_ro(cache);
> +
> +               /*
> +                * Don't do chunk preallocation for scrub.
> +                *
> +                * This is especially important for SYSTEM bgs, or we can=
 hit
> +                * -EFBIG from btrfs_finish_chunk_alloc() like:
> +                * 1. The only SYSTEM bg is marked RO.
> +                *    Since SYSTEM bg is small, that's pretty common.
> +                * 2. New SYSTEM bg will be allocated
> +                *    Due to regular version will allocate new chunk.
> +                * 3. New SYSTEM bg is empty and will get cleaned up
> +                *    Before cleanup really happens, it's marked RO again=
.
> +                * 4. Empty SYSTEM bg get scrubbed
> +                *    We go back to 2.
> +                *
> +                * This can easily boost the amount of SYSTEM chunks if c=
leaner
> +                * thread can't be triggered fast enough, and use up all =
space
> +                * of btrfs_super_block::sys_chunk_array
> +                */
> +               ret =3D btrfs_inc_block_group_ro(cache, false);
>                 if (!ret && sctx->is_dev_replace) {
>                         /*
>                          * If we are doing a device replace wait for any =
tasks
> --
> 2.24.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
