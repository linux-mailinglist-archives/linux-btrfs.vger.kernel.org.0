Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5615E3AAF8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 11:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFQJUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhFQJUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 05:20:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FFC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 02:18:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f70so2363615qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=MmczpXOBUAw6RcYv0O4IIae4aA7s3COA8geAr4BgEvs=;
        b=FLxokDjzOniGUNY711/1RsEb+FybSJS/73Jx+3oCAK0Si3KbpLVRTsBBEEyUZoDCqF
         HDDrZAMcg+b0/b0WNPrSnYbxDinuxW/XnyOXwThClLGu7lCfKqebmbjjSRBGLjUzkLKS
         mrGr5hPakvNnhiDzUQddSk366DeFrvdwURfA99RzltzVWO4+E8k7ePAa1L6eZgHfxcHe
         ZOS5FcBd75YMmIbsC2PWMQ/sv5PJuLTGHp8SUAM4nspJ2Z2MWvgy5q4WfWDdqgxfwGox
         44ZNZ7MDcGYJak45vm9wp3gEpiRdkhHlecD52Vnjo5FdYkZQpv/mIVIoIUvgYfoj7O95
         lz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=MmczpXOBUAw6RcYv0O4IIae4aA7s3COA8geAr4BgEvs=;
        b=bdz/+qtdIcE/NWhlS26WYs3lc4iykjJybZuWklOYvMnalejsl2mQ8Rx3xzJZ7mZQs2
         7QMhrltzxt1Nw0VZg/U9qxK+9MmSvauID0Fxi1SEKPAUzxN3nVZS4u6XAdSk4uPvLgyZ
         x9nkldBeQlqpsBGzlEJOhwk76SV1ss7TCFS2eoPqawxnYTpIkAQjJTRUfW9hUm5nEyWC
         OR4YfelgofOe2FDFlHANt+cWldqsSeqNiQWwC3kWUibIe5HY4PfiKVc7tRfwsqwDMxF8
         l2A/kcoed+9d/dN7Za1eWZMYuhV/kFm6x6Rk+30/0+bb/IQz//MpJZP0stwYeMqW0NA3
         O0cQ==
X-Gm-Message-State: AOAM531kD+U2MghzkjlH+hOz/EldMoUC7vmZSXy09TvX/YOclwdsz1dE
        uI79iQhZgvGQSCVRyS0hDkZa/P/cbuAJVAKyhJM=
X-Google-Smtp-Source: ABdhPJzvrwyQDmN7lXg0bupQ/ChxTafgrhgmjyFdcCNpBaeAHpIKS02MeqjGU4DT+Bgv3WiwHNWRZDV1KucOV4lRTDM=
X-Received: by 2002:a05:620a:2f9:: with SMTP id a25mr2697215qko.479.1623921493934;
 Thu, 17 Jun 2021 02:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4xwZwZaBVXjJ8n9152D39eomfKOS1j0QQBFAWn7kYUxQ@mail.gmail.com>
 <20210616155828.13703-1-dsterba@suse.com>
In-Reply-To: <20210616155828.13703-1-dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 17 Jun 2021 10:18:02 +0100
Message-ID: <CAL3q7H6U2Usjk=sZ9r5uuaoLYD8REqE+pOezVhp1HrvoRNJNhQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add cancellable chunk relocation support
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 16, 2021 at 5:01 PM David Sterba <dsterba@suse.com> wrote:
>
> Add support code that will allow canceling relocation on the chunk
> granularity. This is different and independent of balance, that also
> uses relocation but is a higher level operation and manages it's own
> state and pause/cancellation requests.
>
> Relocation is used for resize (shrink) and device deletion so this will
> be a common point to implement cancellation for both. The context is
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
>
> v2:
> - put the blockgroup by the original pointer 'bg' in
>   btrfs_relocate_block_group

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

>
>  fs/btrfs/ctree.h      |  9 +++++++
>  fs/btrfs/disk-io.c    |  1 +
>  fs/btrfs/relocation.c | 62 +++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4049f533e35e..b7c36aad45ef 100644
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
> +       /* Cancellation requests for chunk relocation */
> +       atomic_t reloc_cancel_req;
> +
>         u32 data_chunk_allocations;
>         u32 metadata_ratio;
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 34bcd986f738..d1d5091a8385 100644
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
> index b70be2ac2e9e..420a89869889 100644
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
> + * Mark start of chunk relocation that is cancellable. Check if the canc=
ellation
> + * has been requested meanwhile and don't start in that case.
> + *
> + * Return:
> + *   0             success
> + *   -EINPROGRESS  operation is already in progress, that's probably a b=
ug
> + *   -ECANCELED    cancellation request was set before the operation sta=
rted
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
> + * Mark end of chunk relocation that is cancellable and wake any waiters=
.
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
> +               goto out_put_bg;
> +       }
> +
>         rc->extent_root =3D extent_root;
>         rc->block_group =3D bg;
>
> @@ -3952,7 +4000,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info=
 *fs_info, u64 group_start)
>         if (err && rw)
>                 btrfs_dec_block_group_ro(rc->block_group);
>         iput(rc->data_inode);
> -       btrfs_put_block_group(rc->block_group);
> +out_put_bg:
> +       btrfs_put_block_group(bg);
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
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
