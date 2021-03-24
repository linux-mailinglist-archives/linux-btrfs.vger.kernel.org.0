Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1F347ABF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Mar 2021 15:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhCXOcU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbhCXOcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 10:32:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E0C0613DE
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Mar 2021 07:32:09 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u8so1516391qtq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Mar 2021 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kRIuEnFSmW4/NSfJPfZK6DdTyd/LM3V5gXRWk4UNCwQ=;
        b=CQck2nSOwZ5AxgGwKCWdjHZnLmzLeAHaULISM/4xhwvgKWHeaYe2DWKVQI84iWN2As
         tJrDfRrS6i3tV/U308eOpVmPZ9ixkp3L2cm7PXuZ5t+qqJTJ/NULO76dxfqdGNeFkEYD
         fY5t0qZ4cUMCejENrJupil0PC2HOIwH8FVWNgLvTPJrdrtQO9s4sb4/lyZ1DslFSAUy4
         1EO0dfxmDpEtXjCmYDTmnHG2PXdUVqnAdbeYWkmzjE0sHz4JBZqROOWQlKBHuAhwaZrC
         amQ4L4QKI1vqD1R57Yc/2TOt2qrd6U+tljF2MSPRRdgG328cyHIW55+U/808WvCBNJqe
         6eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kRIuEnFSmW4/NSfJPfZK6DdTyd/LM3V5gXRWk4UNCwQ=;
        b=IOg49V/TOfN1M0kpg7NGCaSn5xfq1QEa89jZazd1HLPmY1h3O3NUSXO6JI1vOPTv7R
         0tYSZVtP3TKWSB+TvLBn6SIrk1OF5NK+E+IwImCmKZ5pDINkxXDC8jQnxI9fUQkufJQ/
         UgXSbqnfHuyDOBhI27fUZfvsg6uEwpeykmUMoT9mBx0GvPWK2T3ew6Qwt70/TydgdUj0
         ALtRox159HN1PbvAFnTIZLoBHNUZi84qDRZRCyeZloOxcw6poI8Bl2wVTo4f0aP+VGvk
         27YQwPb5RGuyxWiSf3R/3iiCA+cLdTVkPYkU1s1EOkcO/Z5FYl3v+kuVZpQtftr9VGCi
         ooDg==
X-Gm-Message-State: AOAM530OGmFNa70qI7pqs2qQOkVaX9w/P04/Gr7Ofr181qMMvNyE+ja3
        VfkVZ1Z4tvkROO1UL0UR/PO6QwtGa3+/UUBd5iU=
X-Google-Smtp-Source: ABdhPJwGqIXfjX5k1eoic5wxRiiy8/ERT0Zvw/zNdD59xcKSE37xz9Gxs2CfDOBibK49NzDoog+9I+QaaKi/b7FPahE=
X-Received: by 2002:ac8:5347:: with SMTP id d7mr3197210qto.259.1616596328366;
 Wed, 24 Mar 2021 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <984c070461f31182e87d1b4f27c4565088a31b40.1616595693.git.naohiro.aota@wdc.com>
In-Reply-To: <984c070461f31182e87d1b4f27c4565088a31b40.1616595693.git.naohiro.aota@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 24 Mar 2021 14:31:57 +0000
Message-ID: <CAL3q7H5jEMUCE+Mfwg=uyhpxQAL1pYXmMD1aK0nBExkDDPsi8w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: move log tree node allocation out of log_root_tree->log_mutex
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 24, 2021 at 2:26 PM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> Commit 6e37d2459941 ("btrfs: zoned: fix deadlock on log sync") pointed ou=
t
> a deadlock warning and removed
> mutex_{lock,unlock}(&fs_info->tree_root->log_mutex). While it looks like =
it
> always cause a deadlock, we didn't see actual deadlock in fstests runs. T=
he
> reason is log_root_tree->log_mutex !=3D fs_info->tree_root->log_mutex, no=
t
> taking the same lock. So, the warning was actually a false-positive.
>
> Since btrfs_alloc_log_tree_node() is protected only by
> fs_info->tree_root->log_mutex, we can (and should) move the code out of t=
he
> lock scope of log_root_tree->log_mutex and silence the warning.
>
> Cc: Filipe Manana <fdmanana@suse.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-log.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 92a368627791..72c4b66ed516 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3165,20 +3165,22 @@ int btrfs_sync_log(struct btrfs_trans_handle *tra=
ns,
>          */
>         mutex_unlock(&root->log_mutex);
>
> -       btrfs_init_log_ctx(&root_log_ctx, NULL);
> -
> -       mutex_lock(&log_root_tree->log_mutex);
> -
>         if (btrfs_is_zoned(fs_info)) {
> +               mutex_lock(&fs_info->tree_root->log_mutex);
>                 if (!log_root_tree->node) {
>                         ret =3D btrfs_alloc_log_tree_node(trans, log_root=
_tree);
>                         if (ret) {
> -                               mutex_unlock(&log_root_tree->log_mutex);
> +                               mutex_unlock(&fs_info->tree_log_mutex);
>                                 goto out;
>                         }
>                 }
> +               mutex_unlock(&fs_info->tree_root->log_mutex);
>         }
>
> +       btrfs_init_log_ctx(&root_log_ctx, NULL);
> +
> +       mutex_lock(&log_root_tree->log_mutex);
> +
>         index2 =3D log_root_tree->log_transid % 2;
>         list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2=
]);
>         root_log_ctx.log_transid =3D log_root_tree->log_transid;
> --
> 2.31.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
