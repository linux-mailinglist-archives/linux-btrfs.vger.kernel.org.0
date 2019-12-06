Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5791153C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFPCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:02:31 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43722 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLFPCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:02:31 -0500
Received: by mail-ua1-f66.google.com with SMTP id o42so2928666uad.10
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=U6fMTn4Fm68izbfStyTdNzfCSh7dM5cj6zi+K2X2IMg=;
        b=ZgeOrHo1y76rOgLXOcD3La+Lr8xKUxCZT8EQU6v5+wCS9faZqR8AhgiTEa6YL7XhgM
         UIfe9TJmFT+t+6PQ5/U1zY3EYsdA0QhK0XQewiGm5NuMMo0hw8p4UwDLS3eY7jIJqeYv
         QA9YDovEExiAusV0kLX7gewgwlI/F5VqxWjfJ9UendsS2UJoTY1s9iA1to2C0fxhDgrB
         doIsUxHRwXZC0wY2Ua/erpuZs0GUZIM57BuWzykZebwrkQzMVtRXBmdc8vhSKsyXCZA2
         qAKsoKTKif8oljOtDbOxVneyrFoYhsMw4ySV2zyspmUNHk9i8x1apNZJEzWqCBl9j1nk
         FT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=U6fMTn4Fm68izbfStyTdNzfCSh7dM5cj6zi+K2X2IMg=;
        b=VvQlUTS8zVSLsCgYV3QPRsPcTfhVVGTtCinZq/g/qkgSQPXogMmy/7aLIGm4bRhzKU
         vicvu1I1ExY6zcdo+ZjnkQt4WoeRlikc18mPcva8bJK+ugomQvNCZcribyKtab51e2aW
         HkwyMPdgTK0DdBivOH3KoioBrAP5kmpT9UIhQN3TmceEi6+Z6AWm3aaz/fMA3r7cdpfv
         5TF48KY2oQAp464AKU0TiuSGUzVjwhN75skofLOycQWjCnYDJojtqpnfisXjPXmP+JWw
         Kcczsb6+Pn0qgCnwXuvXFkV5GYH74T4bARLVNo2Om+IQMrKNUOnkvQOMCUfdQLKC6CYL
         Ezqw==
X-Gm-Message-State: APjAAAVLr+QmvDv5TCtMIpV7+vpJD64BCK4XzZUpnHz/ywnxThEFevGF
        TJhZvvRNN5XehGUiUL9ZmDbBUyjKOdGBx0SruZt2MA==
X-Google-Smtp-Source: APXvYqy51npFSUABk2l8cDt3ZSTnPBPV/EdHtXqcTUDksS3XFhCjl/IWEV/iot+yYQyA0/MbXL6BQRWh/5NtEOHdJPQ=
X-Received: by 2002:ab0:5a04:: with SMTP id l4mr11923104uad.135.1575644549687;
 Fri, 06 Dec 2019 07:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20191206143718.167998-1-josef@toxicpanda.com> <20191206143718.167998-2-josef@toxicpanda.com>
In-Reply-To: <20191206143718.167998-2-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Dec 2019 15:02:18 +0000
Message-ID: <CAL3q7H7W0rNWB5C=_SLjJS7+xTRv8fjr3uzLpK6B3z5L3YY8PQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: drop log root for dropped roots
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 2:38 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> If we fsync on a subvolume and create a log root for that volume, and
> then later delete that subvolume we'll never clean up its log root.  Fix
> this by making switch_commit_roots free the log for any dropped roots we
> encounter.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
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
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
