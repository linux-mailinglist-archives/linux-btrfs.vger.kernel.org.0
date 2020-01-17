Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD1140C40
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQORr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:17:47 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46552 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQORq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:17:46 -0500
Received: by mail-vs1-f68.google.com with SMTP id t12so14873819vso.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tuh4CTbwZtyBCQ+SAFIH7lo+imTrzJcz2M12YdmTu/Q=;
        b=qj8qg3TX6UVUIBIvyS+QgOqZ5sOQwGJ+LxXKxhCnTOD8T2wIHJfP6d5fV1PoRq9k+x
         afqhUtTb2wXJPwvAfZz4VN22xd5H85Diiqm122PxOu08UFwVnTagHozLkhoTsOJ+2/ZO
         EILqRE48ofYwng3P4k6vr2cd6ji34ZVLfH+nOYY0DV6RGw0ulwaYM0ETjU7OkCSdSy/K
         +NGaMx4ndHkuOj6mGEX8Xcy09YiYbFoFCKR7Y0fs+DVLGhrtCTol3pc2Xe5+DZrwu1Sy
         VA2quRK0fPOfanI/MnXuS3hEeu/MbptC2zdLJmcNn4nYd+/ZC6hVwDbpbWWzk+pm1C07
         U5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tuh4CTbwZtyBCQ+SAFIH7lo+imTrzJcz2M12YdmTu/Q=;
        b=jLrZBQ86nTYHGTf1cllpB0bDeKlxeGuz7eUxxOsbUTl2NTRK0Xk14/XqXVsXDZ2U9O
         ie+8N6LzlNqzRAdpaUdWr+e1q8kqZb7WJ1gGaIUZ8bjLwyZPZM8nrTJLJNPZK2Bv3/nM
         tY6aX3M33uG/0WQKW9y8d30Onm22ARp1+3IZzESOb5IbFOFHne/dPBCuHDoZh1rW2XUl
         2OWO5Gtyyk/fTcXxYpWt3DbX8U1x7t8WT+rsBySqfZ6yTE2GJhLuiYWOjdHZMjK6Yoao
         rPmT5oejnnHAheYpOKNpAdSo9FYkiPRDQfHgotVnaAVeOvE85e5QelTdtpGvA+98NExl
         xC2A==
X-Gm-Message-State: APjAAAXveMyIFN6xAjqVMwCQUag1wZyox0tEw3ui5zw8Lb/yEZeq2PTh
        JnfQ/EuxB+PTP10hRNnv3WxGApUinq9aUuO5cpc6HiRX
X-Google-Smtp-Source: APXvYqzAbZ4xwMrb74BZYz6zRgyi/ukV/Y6RisYNIfN0d+39KKkRov9yijdgeMvrQuOsusApXuGef+YhEQUO8lx9wAQ=
X-Received: by 2002:a67:af11:: with SMTP id v17mr4495346vsl.99.1579270665684;
 Fri, 17 Jan 2020 06:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20200117141245.42971-1-josef@toxicpanda.com>
In-Reply-To: <20200117141245.42971-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 17 Jan 2020 14:17:34 +0000
Message-ID: <CAL3q7H7oGrkiw57bPYs1TaonMTqQsT4J5tHySSdsMRPgE_Zsdw@mail.gmail.com>
Subject: Re: [PATCH][v2] btrfs: drop log root for dropped roots
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 2:14 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> If we fsync on a subvolume and create a log root for that volume, and
> then later delete that subvolume we'll never clean up its log root.  Fix
> this by making switch_commit_roots free the log for any dropped roots we
> encounter.  The extra churn is because we need a btrfs_trans_handle, not
> the btrfs_transaction.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Had already reviewed it last year, and still looks right to me.

Thanks.

> ---
> v1->v2:
> - Update commit message to indicate we need the trans_handle instead of t=
he
>   transaciton.
>
>  fs/btrfs/transaction.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index cfc08ef9b876..55d8fd68775a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -147,13 +147,14 @@ void btrfs_put_transaction(struct btrfs_transaction=
 *transaction)
>         }
>  }
>
> -static noinline void switch_commit_roots(struct btrfs_transaction *trans=
)
> +static noinline void switch_commit_roots(struct btrfs_trans_handle *tran=
s)
>  {
> +       struct btrfs_transaction *cur_trans =3D trans->transaction;
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_root *root, *tmp;
>
>         down_write(&fs_info->commit_root_sem);
> -       list_for_each_entry_safe(root, tmp, &trans->switch_commits,
> +       list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
>                                  dirty_list) {
>                 list_del_init(&root->dirty_list);
>                 free_extent_buffer(root->commit_root);
> @@ -165,16 +166,17 @@ static noinline void switch_commit_roots(struct btr=
fs_transaction *trans)
>         }
>
>         /* We can free old roots now. */
> -       spin_lock(&trans->dropped_roots_lock);
> -       while (!list_empty(&trans->dropped_roots)) {
> -               root =3D list_first_entry(&trans->dropped_roots,
> +       spin_lock(&cur_trans->dropped_roots_lock);
> +       while (!list_empty(&cur_trans->dropped_roots)) {
> +               root =3D list_first_entry(&cur_trans->dropped_roots,
>                                         struct btrfs_root, root_list);
>                 list_del_init(&root->root_list);
> -               spin_unlock(&trans->dropped_roots_lock);
> +               spin_unlock(&cur_trans->dropped_roots_lock);
> +               btrfs_free_log(trans, root);
>                 btrfs_drop_and_free_fs_root(fs_info, root);
> -               spin_lock(&trans->dropped_roots_lock);
> +               spin_lock(&cur_trans->dropped_roots_lock);
>         }
> -       spin_unlock(&trans->dropped_roots_lock);
> +       spin_unlock(&cur_trans->dropped_roots_lock);
>         up_write(&fs_info->commit_root_sem);
>  }
>
> @@ -1421,7 +1423,7 @@ static int qgroup_account_snapshot(struct btrfs_tra=
ns_handle *trans,
>         ret =3D commit_cowonly_roots(trans);
>         if (ret)
>                 goto out;
> -       switch_commit_roots(trans->transaction);
> +       switch_commit_roots(trans);
>         ret =3D btrfs_write_and_wait_transaction(trans);
>         if (ret)
>                 btrfs_handle_fs_error(fs_info, ret,
> @@ -2301,7 +2303,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
>         list_add_tail(&fs_info->chunk_root->dirty_list,
>                       &cur_trans->switch_commits);
>
> -       switch_commit_roots(cur_trans);
> +       switch_commit_roots(trans);
>
>         ASSERT(list_empty(&cur_trans->dirty_bgs));
>         ASSERT(list_empty(&cur_trans->io_bgs));
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
