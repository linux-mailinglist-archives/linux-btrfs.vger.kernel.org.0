Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215D914105A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 18:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgAQR7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 12:59:21 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37703 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQR7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 12:59:21 -0500
Received: by mail-vs1-f66.google.com with SMTP id x18so15376122vsq.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 09:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Nm+gSugX3M6UKRt+GNzfm4hZ7H8x63ohzPdu+Sqbu/0=;
        b=tdGCxlXxBqN6mIDgmMuFMdtWe5d2RkW+m5lKLOzyZLT3lc7qFxC+i7a77h/6YfLh1t
         JnD4+m0hSeXkBLE6C1a6lj5kSlToCO/m5/XHKpDr0XFVtdjmdFuBTaSA+ycrCFevp5vd
         nZSvIysVmY25mISs9AsXUsYjMVnvdVFVT8uBhulfSxfhmsnVHxMB/CPYWC8mCOC8YWYD
         02glRBJZBcddb+clKJ8iUby8fykIImcpNzcM/Svsz6replaI6BDGimr+fONc0s9xX/eF
         D+1CjG/VY+ZM3n9xIaJGm+TWl20ed1tB4nunVexHu1cgIjQpKFopU6Bf0i5fi249XQeI
         OSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Nm+gSugX3M6UKRt+GNzfm4hZ7H8x63ohzPdu+Sqbu/0=;
        b=K/FJW9iQ1w4pzfPDVT7ITyhLinzRsTpDl0fpgd7FG6qdSeqWL0Tm1d6QV2hZwHNuOB
         7oDHg9c52MrvSTDasp+zrSdU4uSuJ4tcuNU+5ekJhGPO8i+ECEAwyVKSA8xbSuilpLCu
         kTwjK54r+hyXeUt5M+67SO/Va4NfIsatp74RbR+pSOfmMPV0lf9+XO6IL21dMrNLyzFl
         LPWsNgqDvse9ZA8Uzs/9UVAnPBhjUA6Eqz8vY6gLHkCDKA86CXtjxn9cHalkw1/TnTk+
         Mq+EOy4mIt058rxApfw0dzLJ7H2hHstJP8kPUd3vLW9TRcexzCMlRELKk/Au4iJw29yb
         srBg==
X-Gm-Message-State: APjAAAVq6dg3v8PKQCIcqP/fdPppR1JFrKy2HoDerssjDVR9DBw5esAM
        h3cwRuW5ip8G7lEa3jC8i3rwwwlWfnhCY3tsXFY=
X-Google-Smtp-Source: APXvYqzb5/vyzdWDaw4Zogy7gIO0WuovG3vHMFrsqXcEfENvexTlcBl0l4G3mF2Q72BMVtMjCg5d/g9zGvmPhtZSntU=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr5324795vsa.95.1579283959272;
 Fri, 17 Jan 2020 09:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20191115020900.23662-1-wqu@suse.com>
In-Reply-To: <20191115020900.23662-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 17 Jan 2020 17:59:08 +0000
Message-ID: <CAL3q7H6jrMYXcLVJ4nYjVXWDxz_Lb-49zD=sq++68ZywL7dKEg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: scrub: Don't check free space before marking a
 block group RO
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
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

Qu,

Strangely, this has caused some unexpected failures on test btrfs/071
(fsstress + device replace + remount followed by scrub).

Since I hadn't seen the issue in my 5.4 (and older) based branches,
and only started to observe the failure in 5.5-rc2+, I left a vm
bisecting since last week after coming back from vacations.
The bisection points out to this change. And going to 5.5-rc5 and
reverting this change, or just doing:

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 21de630b0730..87478654a3e1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3578,7 +3578,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
                 * thread can't be triggered fast enough, and use up all sp=
ace
                 * of btrfs_super_block::sys_chunk_array
                 */
-               ret =3D btrfs_inc_block_group_ro(cache, false);
+               ret =3D btrfs_inc_block_group_ro(cache, true);
                scrub_pause_off(fs_info);

                if (ret =3D=3D 0) {

which is simpler then reverting due to conflicts, confirms this patch
is what causes btrfs/071 to fail like this:

$ cat results/btrfs/071.out.bad
QA output created by 071
Silence is golden
Scrub find errors in "-m raid0 -d raid0" test

$ cat results/btrfs/071.full
(...)
Test -m raid0 -d raid0
Run fsstress  -p 20 -n 100 -d
/home/fdmanana/btrfs-tests/scratch_1/stressdir -f rexchange=3D0 -f
rwhiteout=3D0
Start replace worker: 17813
Wait for fsstress to exit and kill all background workers
seed =3D 1579455326
dev_pool=3D/dev/sdd /dev/sde /dev/sdf
free_dev=3D/dev/sdg, src_dev=3D/dev/sdd
Replacing /dev/sdd with /dev/sdg
Replacing /dev/sde with /dev/sdd
Replacing /dev/sdf with /dev/sde
Replacing /dev/sdg with /dev/sdf
Replacing /dev/sdd with /dev/sdg
Replacing /dev/sde with /dev/sdd
Replacing /dev/sdf with /dev/sde
Replacing /dev/sdg with /dev/sdf
Replacing /dev/sdd with /dev/sdg
Replacing /dev/sde with /dev/sdd
Scrub the filesystem
ERROR: there are uncorrectable errors
scrub done for 0f63c9b5-5618-4484-b6f2-0b7d3294cf05
Scrub started:    Fri Jan 17 12:31:35 2020
Status:           finished
Duration:         0:00:00
Total to scrub:   5.02GiB
Rate:             0.00B/s
Error summary:    csum=3D1
  Corrected:      0
  Uncorrectable:  1
  Unverified:     0
Scrub find errors in "-m raid0 -d raid0" test
(...)

And in syslog:

(...)
Jan  9 13:14:15 debian5 kernel: [1739740.727952] BTRFS info (device
sdc): dev_replace from /dev/sde (devid 4) to /dev/sdd started
Jan  9 13:14:15 debian5 kernel: [1739740.752226]
scrub_handle_errored_block: 8 callbacks suppressed
Jan  9 13:14:15 debian5 kernel: [1739740.752228] BTRFS warning (device
sdc): checksum error at logical 1129050112 on dev /dev/sde, physical
277803008, root 5, inode 405, offset 1540096, length 4096, links 1
(path: stressdir/pa/d2/d5/fa)
Jan  9 13:14:15 debian5 kernel: [1739740.752230]
btrfs_dev_stat_print_on_error: 8 callbacks suppressed
Jan  9 13:14:15 debian5 kernel: [1739740.758600] BTRFS error (device
sdc): bdev /dev/sde errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
Jan  9 13:14:15 debian5 kernel: [1739740.908263]
scrub_handle_errored_block: 2 callbacks suppressed
Jan  9 13:14:15 debian5 kernel: [1739740.929814] BTRFS error (device
sdc): unable to fixup (regular) error at logical 1129050112 on dev
/dev/sde
Jan  9 13:14:15 debian5 kernel: [1739740.929817] BTRFS info (device
sdc): dev_replace from /dev/sde (devid 4) to /dev/sdd finished
(...)

From a quick look I don't have an idea how this patch causes such
regression, doesn't seem to make any sense.

I changed btrfs/071 to comment out the remount loop
(https://pastebin.com/X5LiJtpS, the fsstress arguments are to avoid an
infinite loop during fsync, for which there is a fix already) to see
if that had any influence - it does not.
So it seems the problem is device replace and/or scrub only.

I can trigger the failure somewhat easily, 1000 iterations of
btrfs/071 on 5.5-rc5 produced 94 failures like that.
With this patch reverted (or passing true to
btrfs_inc_block_group_ro() from scrub), 20108 iterations succeeded (no
failures at all).

I haven't tried Josef's recent changes to inc_block_group_ro(), so I
can't say yet if they fix the problem.

I can take a closer look next week to see if I can figure out why this
causes such weird failures, unless you already have an idea.

Thanks.

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
