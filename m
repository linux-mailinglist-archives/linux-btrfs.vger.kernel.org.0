Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7242AEE85
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 11:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKKKKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 05:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgKKKKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 05:10:49 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716BC0613D1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 02:10:48 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id z17so595156qvy.11
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+O7lCoVvEWaCwPSHi310we/khhsG6j/2LseGcJzNqFs=;
        b=Gy0aofLVYlWjN/jgm9yJtwg6U0wLCQXrkJJvNgDimZ++cvBN0NUr+pcgGcYjiu+8ex
         81ExxzcGwZ4R2Jbo++qogm0mtGG8etjpDlz+QPR6B/K+t2B4kmqO+1aFugLmr0IGkBc/
         K5s11nD2aEpEMGZlqrNakT4AXOnsS73GZljXyyznw/fdzUlmVNEU7EH/oawpKoZop8Ly
         SscZGaMEWt/BK33cyaynh3HcZILmHGniyuk0FaPcOZf8fPGAFM1WfICY7mivlq+4dWQr
         Suv56/Z40ITIp/4v0ukzgGkNBhnwA9wscvbuWnh9L0XubIc+o/GAVtjqJxut3O7t6Tgv
         Vkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+O7lCoVvEWaCwPSHi310we/khhsG6j/2LseGcJzNqFs=;
        b=Gcy/UptC3s3T9q/yt0Qjpddembk2AKu3opCkdwY4DaVEEu0IaqcZUV2wlIc/W6C1O9
         5VEJt1pGOei8Vr7wXo8OUGqG0dXE9hVt6+LP4nHv2eDM+PRWGOMRWVSq2slPZ7zJoyFm
         +ggo/04zfxK10cCSh/NGkWapyTJ+/D/mwMhWsmfUGTMoC4CGyHEcKj4lfVACbDYT8X37
         37goZ55kgqbYM/TPdZIGekamZTuyQ6Zhbfi3VieqkUySl6jP3qv1j/cvmiNyGPE9czkR
         D0FvA7o15xIrBJ1+Hp9NPFwRhlxZISQdnHoscQM3tZCe1Gucm7fU38o55Tijlyu+3FQ1
         kcSg==
X-Gm-Message-State: AOAM533+T2XKVgW0bdpBl4VaFuc1K+TJmIsROTijdtyiFUvkFsF14NXc
        KW8SZ6xpO/rgSMY+LoRql/ScCw+FEwq4HK7W66tWbx4Pve4=
X-Google-Smtp-Source: ABdhPJwt/AwSGE/KrBlqke48nkkie8bOvGPTpNF+AlCdDqPsJfS12s7+wcbSsY1T+o185bbPVx26u4+W1f0rcyTcGJ0=
X-Received: by 2002:a0c:99e1:: with SMTP id y33mr23671760qve.62.1605089447949;
 Wed, 11 Nov 2020 02:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20201111093041.123836-1-wqu@suse.com>
In-Reply-To: <20201111093041.123836-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 11 Nov 2020 10:10:37 +0000
Message-ID: <CAL3q7H6r0MV82P5-6YADNFnCrv9s4q2oc2YfSCRhORy_-f_J-A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: don't commit transaction when we have
 already hold a transaction handler
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 9:32 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a report about v5.9.6 hitting ASSERT() when running fstests:

Please mention the test case which triggered the failure.

>
>  assertion failed: refcount_read(&trans->use_count) =3D=3D 1, in fs/btrfs=
/transaction.c:2022
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/ctree.h:3230!
>  invalid opcode: 0000 [#1] SMP PTI
>  RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
>   btrfs_commit_transaction.cold+0x11/0x5d [btrfs]
>   try_flush_qgroup+0x67/0x100 [btrfs]
>   __btrfs_qgroup_reserve_meta+0x3a/0x60 [btrfs]
>   btrfs_delayed_update_inode+0xaa/0x350 [btrfs]
>   btrfs_update_inode+0x9d/0x110 [btrfs]
>   btrfs_dirty_inode+0x5d/0xd0 [btrfs]
>   touch_atime+0xb5/0x100
>   iterate_dir+0xf1/0x1b0
>   __x64_sys_getdents64+0x78/0x110
>   do_syscall_64+0x33/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7fb5afe588db
>
> [CAUSE]
> In try_flush_qgroup(), we assume we don't hold a transaction handler at
> all.
> This is true for data reservation and mostly true for metadata.
> Since data space reservation always happens before we start a
> transaction, and for most metadata operation we reserve space in
> start_transaction().
>
> But there is an exception, btrfs_delayed_inode_reserve_metadata().
> It holds a transaction handler, while still try to reserve extra
> metadata space.
>
> When we hit -EDQUOT inside btrfs_delayed_inode_reserve_metadata(), we
> will join into current transaction, and commit current transaction,
> while we still have transaction handler out of qgroup code.
>
> [FIX]
> Let's check current->journal before we join the transaction.
>
> If current->journal is empty or BTRFS_SEND_TRANS_STUB, it means
> ourselves are not holding a transaction, thus is able to join and then
> commit transaction.
>
> If current->journal is a valid transaction handler, we avoid committing
> transaction, but just end current transaction.
>
> This is less effective than committing current transaction, as it won't
> free metadata reserved space, but we may still free some data space by
> the incoming data write.
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1178634
> Fixes: c53e9653605d ("btrfs: qgroup: try to flush qgroup space when we ge=
t -EDQUOT")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/qgroup.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index bf4b02a40ecc..e320bb574421 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3478,6 +3478,7 @@ static int try_flush_qgroup(struct btrfs_root *root=
)
>  {
>         struct btrfs_trans_handle *trans;
>         int ret;
> +       bool can_commit =3D true;
>
>         /*
>          * We don't want to run flush again and again, so if there is a r=
unning
> @@ -3489,6 +3490,19 @@ static int try_flush_qgroup(struct btrfs_root *roo=
t)
>                 return 0;
>         }
>
> +       /*
> +        * If current process holds a transaction, we shouldn't flush, as=
 we
> +        * assume all space reservation happens before a trans handler is=
 hold.
> +        *
> +        * But there are cases like btrfs_delayed_item_reserve_metadata()=
 where
> +        * we try to reserve space with one trans handler already hold.
> +        * In that case we can't commit transaction. but at most end
> +        * transaction, and hope the started data writes can free some sp=
ace.
> +        */
> +       if (current->journal_info &&
> +           current->journal_info !=3D BTRFS_SEND_TRANS_STUB)
> +               can_commit =3D false;
> +
>         ret =3D btrfs_start_delalloc_snapshot(root);
>         if (ret < 0)
>                 goto out;
> @@ -3500,7 +3514,10 @@ static int try_flush_qgroup(struct btrfs_root *roo=
t)
>                 goto out;
>         }
>
> -       ret =3D btrfs_commit_transaction(trans);
> +       if (can_commit)
> +               ret =3D btrfs_commit_transaction(trans);
> +       else
> +               ret =3D btrfs_end_transaction(trans);
>  out:
>         clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
>         wake_up(&root->qgroup_flush_wait);
> --
> 2.29.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
