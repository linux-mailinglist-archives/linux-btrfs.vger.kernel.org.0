Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC12CED78
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 12:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgLDLtd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 06:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgLDLtc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Dec 2020 06:49:32 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92A6C061A4F
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Dec 2020 03:48:52 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id o1so3663781qtp.5
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Dec 2020 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LR+uojTi2/TPvzkQ61GsiqLl44IIdNwlyvmxPKomSxE=;
        b=lsFdY5IWFoYUD10ySmQTdgTAyx5ngIaznKkKzwTgX3AMBmD0OoBQxixAj2tuquIouA
         026p7iO6+2slsXbPB8OiDlH5pwHT2oCImR4VUVUoL3L/0y+6sRzRW5zTtnHDcRSJmzK3
         3YFgHFkFu9Qu9ru4SwrIyJ7XXUyyLq6Bt/vC4UKSA7C2QoPYZy4BhRQsvodSmexB71z7
         y7wS0da0yHf7xdjejKr50kAWYn44+Y+qEz5nddvK1EnYIlZvLxmF6tL6WieA+4svNUyu
         WwMLmIqGTvvj0lskmBm89X4hOYZJ7tuh6Bi8NmMvu7TDB3ED68x2yfm4nSdfTdGQTqLU
         qIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LR+uojTi2/TPvzkQ61GsiqLl44IIdNwlyvmxPKomSxE=;
        b=mhw1C7e//z+Z1AHq0q0Q91RDqlsucSJnNzFSM7VCpsGaJvby+nx2A84kN2E5j/jgv0
         hyAe9zfWDGKTZTnqrxHRwn1+sxgECNMEnYKlQX0BZBBvKjJiTPuMSI1JxgSz1OGhtkwh
         0sGhMrw2cMzwiJ8+sOIvpS3cGEofN2HrO79g7gYrG0p0Hsm0uJ8AztWTZMp8RVRI5O9r
         Ut+mxWFw/A3UxCLlDunPFupSSBZWNfRO0rNhSRwhDoF/++ewdet5p/HMnKFmh1+GpGgY
         uwccKtGWtbptX4odvxk03ytL6wXRrNNLqkZf7ajYDjamkcqB1YBq5iO/+TawPpqxv+fm
         kgYw==
X-Gm-Message-State: AOAM532mPlUWNHANsGIcGFHZbk7b+xzwoivuIWAfoHbYlyRlVBFSwVoZ
        pt1ICmBlfMFAnqZ/j+pu2MOhYQc74YRi4DtfkxdRjg/K3fp8mQ==
X-Google-Smtp-Source: ABdhPJypS3ecgxaN4ZvMlyARCmlLadAgSKvW431evssE2GTeRNlV5Ig8AcY2q6YV9jAwDciDJmQaRzQYawxsCjf30wI=
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr8490072qtw.213.1607082531967;
 Fri, 04 Dec 2020 03:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20201204012448.26546-1-wqu@suse.com>
In-Reply-To: <20201204012448.26546-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 4 Dec 2020 11:48:40 +0000
Message-ID: <CAL3q7H4qD0Y=6oPPRSTOmWo5f5hj6a0o+=tvDYkmgvVzVvhfrg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: don't try to wait flushing if we're
 already holding a transaction
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 4, 2020 at 1:29 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a chance of racing for qgroup flushing which may lead to
> deadlock:
>
>         Thread A                |       Thread B
>    (no trans handler hold)      |  (already hold a trans handler)

handler -> handle

"not holding a trans handle" and "holding a trans handle" respectively.

> --------------------------------+--------------------------------
> __btrfs_qgroup_reserve_meta()   | __btrfs_qgroup_reserve_meta()
> |- try_flush_qgroup()           | |- try_flushing_qgroup()

try_flushing_qgroup() -> try_flush_qgroup()

>    |- QGROUP_FLUSHING bit set   |    |
>    |                            |    |- test_and_set_bit()
>    |                            |    |- wait_event()
>    |- btrfs_join_transaction()  |
>    |- btrfs_commit_transaction()|
>
>                         !!! DEAD LOCK !!!
>
> Since thread A want to commit transaction, but thread B is hold a
> transaction handler, blocking the commit.

"thread B is hold a transaction handler" -> "thread B is holding a
transaction handle"

> At the same time, thread B is waiting thread A to finish it commit.

waiting for, it -> its

>
> This is just a hot fix, and would lead to more EDQUOT when we're near
> the qgroup limit.
>
> The root fix would to make all metadata/data reservation to happen

would -> would be

> without a transaction handler hold.

without a transaction handler hold -> without holding a transaction handle

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Other than the grammar, it looks fine, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/qgroup.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index fe3046007f52..7785dfa348d2 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3530,16 +3530,6 @@ static int try_flush_qgroup(struct btrfs_root *roo=
t)
>         int ret;
>         bool can_commit =3D true;
>
> -       /*
> -        * We don't want to run flush again and again, so if there is a r=
unning
> -        * one, we won't try to start a new flush, but exit directly.
> -        */
> -       if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
> -               wait_event(root->qgroup_flush_wait,
> -                       !test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->stat=
e));
> -               return 0;
> -       }
> -
>         /*
>          * If current process holds a transaction, we shouldn't flush, as=
 we
>          * assume all space reservation happens before a transaction hand=
le is
> @@ -3554,6 +3544,27 @@ static int try_flush_qgroup(struct btrfs_root *roo=
t)
>             current->journal_info !=3D BTRFS_SEND_TRANS_STUB)
>                 can_commit =3D false;
>
> +       /*
> +        * We don't want to run flush again and again, so if there is a r=
unning
> +        * one, we won't try to start a new flush, but exit directly.
> +        */
> +       if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
> +               /*
> +                * We are already holding a trans, thus we can block othe=
r
> +                * threads from flushing.
> +                * So exit right now. This increases the chance of EDQUOT=
 for
> +                * heavy load and near limit cases.
> +                * But we can argue that if we're already near limit, EDQ=
UOT
> +                * is unavoidable anyway.
> +                */
> +               if (!can_commit)
> +                       return 0;
> +
> +               wait_event(root->qgroup_flush_wait,
> +                       !test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->stat=
e));
> +               return 0;
> +       }
> +
>         ret =3D btrfs_start_delalloc_snapshot(root);
>         if (ret < 0)
>                 goto out;
> --
> 2.29.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
