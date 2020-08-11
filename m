Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50344241979
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHKKOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgHKKOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 06:14:45 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F20C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 03:14:44 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q13so5696212vsn.9
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vXbeJgtbbFHG6nkwEPOKElfs5EVn5mrjJq80PPpho7s=;
        b=WQ6PRhGP9Q9PCERtJNoyhQrgFZC6X0maj4eS057ybyl+wEJAfISI98Q/b6qD/op3b+
         agxQha7HBV7qJQTPLAWzn+eCnJUvQRWgsB2u5wwRutbDDaMieyVk3nLiHZDvD95BSRfs
         NHZ1nNqQbORh1N3loeBtASeZet7sTRO7WSEn7Nl6UoWHeh25yHg/ZdoLtwQsRtlxpaTb
         sP1vTmNX/nrWAS3ModSCy/2l9og3gLViE+HhuyjS2ciw0easFhXW0RjDDMeoLLg8IGdu
         jRnfLiwM78O2AJDx39Hp7TfdPu5pLuru2JyfgOdopqa3VH6TzZI4SGsJ/elgvluqkCEk
         A24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vXbeJgtbbFHG6nkwEPOKElfs5EVn5mrjJq80PPpho7s=;
        b=EqunTjey3w4JL5ZQMkji2Ak6bIZgkuqUNgm/Nfu5OmhJSmmPmt5KuPeEZVaiBRXsov
         n0SmlIqkEllormyMsg6mV6LiJjwwwFIM5PIVJSi7DpkKYjJbll+yRgvqeqJ+VRa6TIFR
         /WGFQIU7YxGuHA7BhyVRc1Zcf76eSZ+Tfy49ZRQjuAlUzCTvsghXH7OMyWbyke+EWcJt
         SMIYNN2ZbKjhgq7zZCwAk7mWeM4cfCuadLWTOTbVNJWbWu6HqCcIk6HcRYNfefSaHRxA
         IJgAInvrwFjWyoYz8J3eJfGGf8M7Dk62xjdMCHRvYGTTIHT4KgxCuBNubqsB6s/xqsGK
         u8sw==
X-Gm-Message-State: AOAM533HH9+YGE/0rE4bgHephZ2IWXSu4HdmO08GVR1Raa0b4x9B/IY9
        xjhvIHjEHun+EOZs1kSADcWk8/DMOeHSSF+UUrw=
X-Google-Smtp-Source: ABdhPJxSBLvHom5AYk3wQCWPg9yoR1q9sgiaND2QW8FX4kV91mZMQJGeoyIQbMJUGzTZTd7zDNW4Pfa5XRw4bPCWpaQ=
X-Received: by 2002:a05:6102:22ed:: with SMTP id b13mr20481191vsh.206.1597140883362;
 Tue, 11 Aug 2020 03:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213116.795789-1-josef@toxicpanda.com>
In-Reply-To: <20200810213116.795789-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 11 Aug 2020 11:14:32 +0100
Message-ID: <CAL3q7H4T-orhnnJrNxNqTXOXHm8c0jnqRf3GX3LuOV+9ZXjD4w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check the right variable in btrfs_del_dir_entries_in_log
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 10:32 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> With my new locking code dbench is so much faster that I tripped over a
> transaction abort from ENOSPC.  This turned out to be because
> btrfs_del_dir_entries_in_log was checking for ret =3D=3D -ENOSPC, but thi=
s
> function sets err on error, and returns err.  So instead of properly
> marking the inode as needing a full commit, we were returning -ENOSPC
> and aborting in __btrfs_unlink_inode.  Fix this by checking the proper
> variable so that we return the correct thing in the case of ENOSPC.
>
> Fixes: 4a500fd178c8 ("Btrfs: Metadata ENOSPC handling for tree log")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/tree-log.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index e0ab3c906119..bc9ed31502ec 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3449,11 +3449,11 @@ int btrfs_del_dir_entries_in_log(struct btrfs_tra=
ns_handle *trans,
>         btrfs_free_path(path);
>  out_unlock:
>         mutex_unlock(&dir->log_mutex);
> -       if (ret =3D=3D -ENOSPC) {
> +       if (err =3D=3D -ENOSPC) {
>                 btrfs_set_log_full_commit(trans);
> -               ret =3D 0;
> -       } else if (ret < 0)
> -               btrfs_abort_transaction(trans, ret);
> +               err =3D 0;
> +       } else if (err < 0 && err !=3D -ENOENT)

Why the check for ENOENT?
If any of the directory index items doesn't exist, the respective
functions return a NULL btrfs_dir_item pointer and we do nothing and
return 0.
I'm not seeing anything else that could return ENOENT either.

Other than that it looks good.


> +               btrfs_abort_transaction(trans, err);
>
>         btrfs_end_log_trans(root);
>
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
