Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1962AB4B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgKIKWA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKWA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:22:00 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAFEC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:21:59 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 13so3761335qvr.5
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=N1/m7RxZJQoqT1E6QClwsjzDThGKD2Ute2sIBD5zRks=;
        b=eAItuv1VUF5PMwhLiuCwuEtM+N0FdrvjSeLRWzg6DOs3JQwnvbe3lbxA52XmnRybU8
         fFIJapJx/hkVH5W1gYVj5mR//1royToMFnGplt17Bh2wcVoGr8OWhj6UWTqQQu7uCp0F
         P0Mt7uchAiH/x1f+oly1WpErzKCIGqPAIE7pp6Nx4u9yF3AeyXgOPYBIbekUVbYyD1kX
         dFnrp/OKb4XQJukvO31xg3FsUxsmw432V9oPNRkIVtVdm4kLPaE+2qItQqSDQzy7UzCW
         IFpmL60v/TCxpop4GLG2EaO3Va42b4Kcs8I9z3YiQoils4yrLf5IBRMRXWwVlw+A5B5/
         5vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=N1/m7RxZJQoqT1E6QClwsjzDThGKD2Ute2sIBD5zRks=;
        b=gG3tL3tj05cqu/Tzn/jsYiLo9x7p5SLwd3cJZSMNA/Z/4MfdAKC2olIgx5sjBIiPb/
         RMO7qNaLp1CLHBp1QpQfdLTaNymSkos07d9+fNi8/DUgvMOgcYV54p5wDYSbqapXjBjM
         G3Mur8PvHjPGstE678AluV9H487Nmd2OoaNl88astRSuX54bo7Wcn+QpPSYXZtWxsr7o
         xXFuoWXQ5YnGCYkK9UOBk0CIxHNjafcvgabVAM2g2FktcedZK83gMrZHCYMXKQg4MW2E
         bjqrgJyw36SeSQTDWLBW03Y6izp2U7BAljm4HFQiEY1egzu/VoU5Bj2i7DnWGCVFzqms
         5ZVQ==
X-Gm-Message-State: AOAM5316vo0koAucVj6yX/GoAsmyApA042n99vXkGwIldYUkFjU42UoE
        E7NydJRyqkJOftSzLc2eHHEdt7HxWyZNVdBZ0J8=
X-Google-Smtp-Source: ABdhPJxwwRhNBJl/cVf7S5zzSn8ucre0ioGb6rHoeYfvFG9v9uMafgURZSLpOP2nVxdDpGkgt7lxIAV5Zv94ZJJTZFw=
X-Received: by 2002:ad4:57a6:: with SMTP id g6mr3377055qvx.27.1604917319241;
 Mon, 09 Nov 2020 02:21:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <cce77fcffe84af208d0260120a874134b771ce65.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <cce77fcffe84af208d0260120a874134b771ce65.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:21:48 +0000
Message-ID: <CAL3q7H71NAcLc9jq2vL26G2JuZ_C=FbjpRpue1bvTE7Q=5SAvw@mail.gmail.com>
Subject: Re: [PATCH 6/8] btrfs: use btrfs_tree_read_lock in btrfs_search_slot
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We no longer use recursion, so
> __btrfs_tree_read_lock(BTRFS_NESTING_NORMAL) =3D=3D btrfs_tree_read_lock.
> Replace this call with the simple helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index ef7389e6be3d..2cdfaf7298ab 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2857,8 +2857,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                                 btrfs_tree_lock(b);
>                                 p->locks[level] =3D BTRFS_WRITE_LOCK;
>                         } else {
> -                               __btrfs_tree_read_lock(b, BTRFS_NESTING_N=
ORMAL,
> -                                                      0);
> +                               btrfs_tree_read_lock(b);
>                                 p->locks[level] =3D BTRFS_READ_LOCK;
>                         }
>                         p->nodes[level] =3D b;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
