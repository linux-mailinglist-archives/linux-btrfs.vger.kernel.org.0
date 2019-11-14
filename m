Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AE5FC96C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKNPCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 10:02:21 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43049 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNPCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 10:02:21 -0500
Received: by mail-ua1-f66.google.com with SMTP id k11so1947062ual.10
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 07:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=U4jB0W+rIy+qlvjR6LGnN+dKjeKO12oJL9XwPgBs9ko=;
        b=nBdn2lwvVbBuJSEgPypPYV/iMIs6Ds5FXXZ9my54+wwQp3P2T/Fe1hpka84SVMfpGP
         00vaVmW2VqBRHOSKZuuBWPaWKZK3tZLHYD8hlpt659WdXeVCH1DCCWidAncfim/Ns2U4
         2G4f276dAdSF7y+M0dBw2NTPvQc/Z5MjfE5Y704PAO7MZcwVcH4s9D8k3aKrXUwsnE4n
         +MoqbAMR+lEJJGeduOePbsEcOPxtP9+YbU/lPe/cnaiTVl/2KbL5+DhnXbgZjZ1HPwmJ
         0AsUXjcUMzZE0CzWycM+Lq1buWCNFm0o6tKpD21KdMckTSReAranE7jeDEZPnk6m2r63
         klWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=U4jB0W+rIy+qlvjR6LGnN+dKjeKO12oJL9XwPgBs9ko=;
        b=pLscUgFSLd1cueG0RpUJ7PVxjn/xlFMl2jmYnL6XOOqHW5m1i4J9BFfj9Ciar5jfJr
         TecKkV3mSyL+nxV+rfHeDRLcOyWe6/6Yz9CbfqoATH+LuLISYyxjoQQFLN/RQCQtsVv1
         OkSoCSBgdZNS0eGVOTGnw89qjW+5VE/PmHHQT0iAX7yyPDsRX3bWDj8lvq9NkSdSQIoe
         Bn0M2FAsOWWwBThKJeX0aQFMmWfdLdiPQ8CxBA2l7DiPcOKICIjS76nnWezhlcKHdylm
         ppATW8EEXQ8NaK7ENKMOAauffB1zBCo6brnmzI5cz1osYfh6NEF9d0fCcLsC5bxwjPS7
         7MUQ==
X-Gm-Message-State: APjAAAVBeh8X5v07Td3xekG4mv5sbnQCLbHZ0J4Av1/9E9IhSDvlNNZx
        omd+IVoGiX/LyJP561LIDbLvBJCtuLX7WIajDnE=
X-Google-Smtp-Source: APXvYqywUcO2OEW5TdcyBpeBfFA3hdr5U8aV0NFUxOTlC95YuLw8rabhYVy4EEE3zklmcgAY1zqjv0a4RrRSxC2iIFA=
X-Received: by 2002:ab0:6842:: with SMTP id a2mr5936523uas.0.1573743739412;
 Thu, 14 Nov 2019 07:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20191114082547.34846-1-wqu@suse.com>
In-Reply-To: <20191114082547.34846-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 14 Nov 2019 15:02:08 +0000
Message-ID: <CAL3q7H5Qcf4P3BZwX2Avj3EGM+10dJ2_CF0a681vzVAnLYZn_A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: Don't check free space before marking a
 block group RO
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 8:28 AM Qu Wenruo <wqu@suse.com> wrote:
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
> So to break above spiral, here we introduce a new variant of
> btrfs_inc_block_group_ro(), btrfs_inc_block_group_ro_force(), which
> won't do the extra free space check and chunk pre-allocation.
>
> This should keep unnecessary empty chunks from popping up.
>
> Also, since there are two different variants of
> btrfs_inc_block_group_ro(), add more comment for both variants.
>
> This patch is only to address the problem of btrfs/072, so here the
> code of relocation side is not touched at all.
> Completely removing chunk pre-allocation from btrfs_inc_block_group_ro()
> will be another patch (and need extra verification).
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This version is based on v5.4-rc1, for a commonly known commit hash.
> It would cause conflicts due to
> btrfs_block_group_cache -> btrfs_block_group refactor.
>
> The conflicts should be easy to solve.
> ---
>  fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++-----
>  fs/btrfs/block-group.h |  1 +
>  fs/btrfs/scrub.c       | 21 ++++++++++++++++++++-
>  3 files changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bf7e3f23bba7..68790782bb00 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2021,8 +2021,7 @@ static u64 update_block_group_flags(struct btrfs_fs=
_info *fs_info, u64 flags)
>         return flags;
>  }
>
> -int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
> -
> +static int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *ca=
che, bool force)
>  {
>         struct btrfs_fs_info *fs_info =3D cache->fs_info;
>         struct btrfs_trans_handle *trans;
> @@ -2057,7 +2056,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gro=
up_cache *cache)
>          * block group with the new raid level.
>          */
>         alloc_flags =3D update_block_group_flags(fs_info, cache->flags);
> -       if (alloc_flags !=3D cache->flags) {
> +       if (alloc_flags !=3D cache->flags && !force) {

The above call to alloc_flags should also be skipped if !force.

>                 ret =3D btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC=
_FORCE);
>                 /*
>                  * ENOSPC is allowed here, we may have enough space
> @@ -2070,8 +2069,8 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gro=
up_cache *cache)
>                         goto out;
>         }
>
> -       ret =3D inc_block_group_ro(cache, 0);
> -       if (!ret)
> +       ret =3D inc_block_group_ro(cache, force);
> +       if (!ret || force)
>                 goto out;

So if force we jump to label 'out', and there if this is a system
block group, we still call check_system_chunk(), which can allocate a
system chunk.
That should be skipped as well. That is, just end the transaction,
unlock the mutex and return.

>         alloc_flags =3D btrfs_get_alloc_profile(fs_info, cache->space_inf=
o->flags);
>         ret =3D btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
> @@ -2091,6 +2090,30 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gr=
oup_cache *cache)
>         return ret;
>  }
>
> +/*
> + * Mark one block group read only so we won't allocate extent from this =
bg.
> + *
> + * This variant can return -ENOSPC as it will do extra free space check,=
 and
> + * may allocate new chunk if there is not enough free space.
> + * This is normally used by relocation as relocation needs to do new wri=
te
> + * immediately after marking a bg RO.
> + */
> +int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
> +{
> +       return __btrfs_inc_block_group_ro(cache, false);

This should be 'true'.

> +}
> +
> +/*
> + * Pretty much the same as btrfs_inc_block_group_ro(), but without the f=
ree
> + * space check nor chunk allocation.
> + * This variant is mostly used by scrub/replace, as there is no immediat=
e write
> + * after marking a block group RO.
> + */
> +int btrfs_inc_block_group_ro_force(struct btrfs_block_group_cache *cache=
)
> +{
> +       return __btrfs_inc_block_group_ro(cache, false);
> +}

So both variants pass 'false' to the force parameter, and never called
with 'true'.

I find it confusing the naming. I would just add the parameter to
existing btrfs_inc_block_group_ro() and name it something like
"do_chunk_alloc", with every caller passing 'true' and only scrub
passing 'false'.
The 'force' name is confusing to me, it gives me the idea it forces
chunk allocation when it does the opposite.

Other than that, it seems good to me for now at least.

Thanks.

> +
>  void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
>  {
>         struct btrfs_space_info *sinfo =3D cache->space_info;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index c391800388dd..07b6c1905fef 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -206,6 +206,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle =
*trans, u64 bytes_used,
>                            u64 type, u64 chunk_offset, u64 size);
>  void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)=
;
>  int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
> +int btrfs_inc_block_group_ro_force(struct btrfs_block_group_cache *cache=
);
>  void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
>  int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f7d4e03f4c5d..40a0d8b1a602 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3563,7 +3563,26 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>                  * -> btrfs_scrub_pause()
>                  */
>                 scrub_pause_on(fs_info);
> -               ret =3D btrfs_inc_block_group_ro(cache);
> +
> +               /*
> +                * Scrub itself doesn't always cause new write, so we don=
't need
> +                * to care free space right now.
> +                *
> +                * This forced RO is especially important for SYSTEM bgs,=
 or we
> +                * can hit -EFBIG from btrfs_finish_chunk_alloc():
> +                * 1. The only SYSTEM bg is marked RO.
> +                *    Since SYSTEM bg is small, that's pretty common.
> +                * 2. New SYSTEM bg will be allocated
> +                *    Due to regular version will allocate new chunk.
> +                * 3. New SYSTEM bg is empty and will get cleaned up
> +                *    Before cleanup really happens, it's marked RO again=
.
> +                * 4. Empty SYSTEM bg get scrubbed
> +                *    We go back to 2.
> +                * This can easily boost the amount of SYSTEM chunks if c=
leaner
> +                * thread can't be triggered fast enough, and use up all =
space
> +                * of btrfs_super_block::sys_chunk_array
> +                */
> +               ret =3D btrfs_inc_block_group_ro_force(cache);
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
