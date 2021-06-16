Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87BD3A9CC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 15:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhFPN5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhFPN4g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 09:56:36 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534DC06124A
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Jun 2021 06:54:22 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e18so1551086qvm.10
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Jun 2021 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=gbN5ye64fpiDG0SpjbAoQPwgI82zEiu21v1ZkrhK5R0=;
        b=ahmDTSqSLNBOjAgaVw7eDIkrBV796+E7Y1WijhjPd5xKl9PvfmWtMWrus8kC5/7MFp
         P/NBXSMIF4Vktehg/M+f+tDNn8VH4fC7Rt8GPXP+Ko4nWnohLCVmAFSWjlje7u6/Y9pT
         UpUKpTwd4M33nxDGTN+QHrqMm3MGyQl6Xeg4xqU7OCeC8Nfn5DCOI/j0DGxgBL6n4NDE
         E68G2TydvjoRyWd8qfrRCEu3ZHjyhkqAQw5f7/8u1yRVYWASEPaxFKUSclNiJknvYytv
         I089XMRC4q0XFwCm56k+exhRhG5hvUqUFCWwL/ItPKkdOvczmrW+KjBbYhYQOVkMsBqD
         KXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=gbN5ye64fpiDG0SpjbAoQPwgI82zEiu21v1ZkrhK5R0=;
        b=Nw0trulCQT+3AO/sb2nhM+X63cGmT2bfCdY/KlEyYxB53RpmrJo/VJbWUVMoGAC3Pf
         tlamqaulCAiRBODWxuJWNNyI7Adj+Uo+SgHjUzVg0swJK+/KEamWzWrWDWHQwXoGY5hb
         N7tW3Y99tVowDA85Vx34IeZEZ93W0Tx4fpjInbo4/+JYGQfMtXc3vdIZ34bhrXVHdPRt
         5IDAbxsCY1N/RVE4VSfAc3Rc8+xbsQ3Ft1zDYefCPlRGxsF/8tfvdEuODy+wuihNcAeI
         EF1LNUd4MsAdGYu1269aEqSgubwlsl5f+GMrNRm/U0xeK325nGl0uG8cXueFKYGQGtYU
         zuYQ==
X-Gm-Message-State: AOAM530zUq+fdwocuMBLK+YllxoPQgWGdrQi2FqXARCjVHBb3s9gB6qZ
        zxbQsBwB1593DkWEpYawbTpi2+xAL4rfk82Dl7M=
X-Google-Smtp-Source: ABdhPJyPvtT6jL4Id7/yau5jRaowj9CZktpcVHCSCUUa8N4IEVPX4urNleys3aBQK42VvxKbR+Zm3mPG2h9grMMCh14=
X-Received: by 2002:ad4:4eee:: with SMTP id dv14mr91380qvb.45.1623851661224;
 Wed, 16 Jun 2021 06:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621526221.git.dsterba@suse.com> <79a09502c532bc9939645d2711c72ebad5fce2e7.1621526221.git.dsterba@suse.com>
In-Reply-To: <79a09502c532bc9939645d2711c72ebad5fce2e7.1621526221.git.dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 16 Jun 2021 14:54:10 +0100
Message-ID: <CAL3q7H6P-TqtM6BkRY5_15ThVJzD54HZCdjKtdkukUqrZzh5-Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] btrfs: add cancelable chunk relocation support
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 9:15 PM David Sterba <dsterba@suse.com> wrote:
>
> Add support code that will allow canceling relocation on the chunk
> granularity. This is different and independent of balance, that also
> uses relocation but is a higher level operation and manages it's own
> state and pause/cancelation requests.
>
> Relocation is used for resize (shrink) and device deletion so this will
> be a common point to implement cancelation for both. The context is
> entirely in btrfs_relocate_block_group and btrfs_recover_relocation,
> enclosing one chunk relocation. The status bit is set and unset between
> the chunks. As relocation can take long, the effects may not be
> immediate and the request and actual action can slightly race.
>
> The fs_info::reloc_cancel_req is only supposed to be increased and does
> not pair with decrement like fs_info::balance_cancel_req.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h      |  9 +++++++
>  fs/btrfs/disk-io.c    |  1 +
>  fs/btrfs/relocation.c | 60 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a142e56b6b9a..3dfc32a3ebab 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -565,6 +565,12 @@ enum {
>          */
>         BTRFS_FS_BALANCE_RUNNING,
>
> +       /*
> +        * Indicate that relocation of a chunk has started, it's set per =
chunk
> +        * and is toggled between chunks.
> +        */
> +       BTRFS_FS_RELOC_RUNNING,
> +
>         /* Indicate that the cleaner thread is awake and doing something.=
 */
>         BTRFS_FS_CLEANER_RUNNING,
>
> @@ -871,6 +877,9 @@ struct btrfs_fs_info {
>         struct btrfs_balance_control *balance_ctl;
>         wait_queue_head_t balance_wait_q;
>
> +       /* Cancelation requests for chunk relocation */
> +       atomic_t reloc_cancel_req;
> +
>         u32 data_chunk_allocations;
>         u32 metadata_ratio;
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8c3db9076988..93c994b78d61 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2251,6 +2251,7 @@ static void btrfs_init_balance(struct btrfs_fs_info=
 *fs_info)
>         atomic_set(&fs_info->balance_cancel_req, 0);
>         fs_info->balance_ctl =3D NULL;
>         init_waitqueue_head(&fs_info->balance_wait_q);
> +       atomic_set(&fs_info->reloc_cancel_req, 0);
>  }
>
>  static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index b70be2ac2e9e..9b84eb86e426 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2876,11 +2876,12 @@ int setup_extent_mapping(struct inode *inode, u64=
 start, u64 end,
>  }
>
>  /*
> - * Allow error injection to test balance cancellation
> + * Allow error injection to test balance/relocation cancellation
>   */
>  noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
>  {
>         return atomic_read(&fs_info->balance_cancel_req) ||
> +               atomic_read(&fs_info->reloc_cancel_req) ||
>                 fatal_signal_pending(current);
>  }
>  ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
> @@ -3780,6 +3781,47 @@ struct inode *create_reloc_inode(struct btrfs_fs_i=
nfo *fs_info,
>         return inode;
>  }
>
> +/*
> + * Mark start of chunk relocation that is cancelable. Check if the cance=
lation
> + * has been requested meanwhile and don't start in that case.
> + *
> + * Return:
> + *   0             success
> + *   -EINPROGRESS  operation is already in progress, that's probably a b=
ug
> + *   -ECANCELED    cancelation request was set before the operation star=
ted
> + */
> +static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
> +{
> +       if (test_and_set_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
> +               /* This should not happen */
> +               btrfs_err(fs_info, "reloc already running, cannot start")=
;
> +               return -EINPROGRESS;
> +       }
> +
> +       if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
> +               btrfs_info(fs_info, "chunk relocation canceled on start")=
;
> +               /*
> +                * On cancel, clear all requests but let the caller mark
> +                * the end after cleanup operations.
> +                */
> +               atomic_set(&fs_info->reloc_cancel_req, 0);
> +               return -ECANCELED;
> +       }
> +       return 0;
> +}
> +
> +/*
> + * Mark end of chunk relocation that is cancelable and wake any waiters.
> + */
> +static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
> +{
> +       /* Requested after start, clear bit first so any waiters can cont=
inue */
> +       if (atomic_read(&fs_info->reloc_cancel_req) > 0)
> +               btrfs_info(fs_info, "chunk relocation canceled during ope=
ration");
> +       clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
> +       atomic_set(&fs_info->reloc_cancel_req, 0);
> +}
> +
>  static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *f=
s_info)
>  {
>         struct reloc_control *rc;
> @@ -3862,6 +3904,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start)
>                 return -ENOMEM;
>         }
>
> +       ret =3D reloc_chunk_start(fs_info);
> +       if (ret < 0) {
> +               err =3D ret;
> +               goto out_end;

There's a bug here. At out_end we do:

btrfs_put_block_group(rc->block_group);

But rc->block_group was not yet assigned.

Thanks.

> +       }
> +
>         rc->extent_root =3D extent_root;
>         rc->block_group =3D bg;
>
> @@ -3953,6 +4001,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_info=
 *fs_info, u64 group_start)
>                 btrfs_dec_block_group_ro(rc->block_group);
>         iput(rc->data_inode);
>         btrfs_put_block_group(rc->block_group);
> +out_end:
> +       reloc_chunk_end(fs_info);
>         free_reloc_control(rc);
>         return err;
>  }
> @@ -4073,6 +4123,12 @@ int btrfs_recover_relocation(struct btrfs_root *ro=
ot)
>                 goto out;
>         }
>
> +       ret =3D reloc_chunk_start(fs_info);
> +       if (ret < 0) {
> +               err =3D ret;
> +               goto out_end;
> +       }
> +
>         rc->extent_root =3D fs_info->extent_root;
>
>         set_reloc_control(rc);
> @@ -4137,6 +4193,8 @@ int btrfs_recover_relocation(struct btrfs_root *roo=
t)
>                 err =3D ret;
>  out_unset:
>         unset_reloc_control(rc);
> +out_end:
> +       reloc_chunk_end(fs_info);
>         free_reloc_control(rc);
>  out:
>         free_reloc_roots(&reloc_roots);
> --
> 2.29.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
