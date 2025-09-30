Return-Path: <linux-btrfs+bounces-17294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EBBAE034
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16DA84E035E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1493090DF;
	Tue, 30 Sep 2025 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUzfLcmK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7C2248A0
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248506; cv=none; b=DpXdub3SRq1VuYidY+GTuxwxKWEIQ95hS+PrppQF46LXEWb5ImabU+Lh2UL+4Ac6JEoaFHUEFWJii0eEqbR7UtoPq/46LAac4g3sJNesyeLNvr5qW5Ipwjedlv8Ifa/R4HKQehoLq6+yCy8SqWPSJKjF1SMkEQHp81SzvKLITU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248506; c=relaxed/simple;
	bh=9uRbdsyPNzDl5hpxeHdF1qvjCZaE0bQqFIgtXU1bFog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbqefoIdl9dF67rZA4fO1N861SHGfZB7FgQHHtr9PCo98eRb28Dxuy6YmCzRx2tVKEXG+1nlV0WVRM68wElmBM9X0oX6YKpOfFCEJmL2dHqxlYhA2/XscvIQJye08wtgx38C4RZPb6HT9HYNrK8bjLMNEYDZ7HSN3zodgqgDXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUzfLcmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D6DC116D0
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759248505;
	bh=9uRbdsyPNzDl5hpxeHdF1qvjCZaE0bQqFIgtXU1bFog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dUzfLcmKMNRbk85xyOCUJz0XsWHh+7speOkOMJDS7W/n0Vz0ExbRLhi4f/dBwfuB/
	 1slSwD1SbF8lS8rXBe0EuLlrzO9dIybFTaBcB2OS4XB973rKlbijuxFgkSOO+8spL1
	 h/LQNodYwqWjbmj/oAJ29mV2LBE0+UgjrT4LISmeXLcCRd3XFY0JUjeurxDL/37/ty
	 DPmgaLYI6MiDYhDxuuj8UHCLUAOj6PttPE3N28WmFh9Yy93uOvQnsGY+fm2Ze9XoHR
	 ik2rwdv1GaaHXTCUHKdJNa0Dtrm54Ir+tEGU3Z3WsZFm2bpLQd6YnVrzbLNkr8w6V+
	 sVWqqd9+PRyyQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-634c01ca9dcso7359631a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 09:08:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YwwGutBbkTmu0gxAKMDTkPU+rKLdHorCgTOcwHrrApTL2gcf2Ib
	PWlzcC1LtSnGouNkWU/zDKUhZGo0uUH5JcGUbIphVXVwZjKZRTReaOCpqAl+zeup+8IRvWoxySG
	1E77A53oq5CugTKF5nDtRaNOQP1i7FQk=
X-Google-Smtp-Source: AGHT+IHlKfOYEncn3ugNTRFMwKhndnrBD7lzoNy7PiC3kKGc/mSD0vqFUC0luKLegxIyR9nZyRY0TNacwK6ngIVkg9I=
X-Received: by 2002:a17:907:7212:b0:b3e:c7d5:4cbb with SMTP id
 a640c23a62f3a-b46e6339e60mr16403666b.35.1759248504011; Tue, 30 Sep 2025
 09:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930130452.297576-1-mssola@mssola.com>
In-Reply-To: <20250930130452.297576-1-mssola@mssola.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 30 Sep 2025 17:07:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H66AOc_hbXX_PN-DGP5fT36NnxE7p4j2LqjPXyRaOu=iA@mail.gmail.com>
X-Gm-Features: AS18NWCf0aCyEgpDdVsD-F5dGKSomPPsI3FXkpJVek6slno2O7f4bkNjz-pmPrg
Message-ID: <CAL3q7H66AOc_hbXX_PN-DGP5fT36NnxE7p4j2LqjPXyRaOu=iA@mail.gmail.com>
Subject: Re: [PATCH] fs: btrfs: prevent a double kfree on delayed-ref
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	fdmanana@suse.com, wqu@suse.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:05=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <mssol=
a@mssola.com> wrote:
>
> In the previous code it was possible to incur into a double kfree()
> scenario when calling 'add_delayed_ref_head'. This could happen if the
> record was reported to already exist in the
> 'btrfs_qgroup_trace_extent_nolock' call, but then there was an error
> later on 'add_delayed_ref_head'. In this case, since
> 'add_delayed_ref_head' returned an error, the caller went to free the
> record. Since 'add_delayed_ref_head' couldn't set this kfree'd pointer
> to NULL, then kfree() would have acted on a non-NULL 'record' object
> which was pointing to memory already freed by the callee.
>
> The problem comes from the fact that the responsibility to kfree the
> object is on both the caller and the callee at the same time. Hence, the
> fix for this is to shift the ownership of the 'qrecord' object out of
> the 'add_delayed_ref_head'. That is, we will never attempt to kfree()
> the given object inside of this function, and will expect the caller to
> act on the 'qrecord' object on its own. The only exception where the
> 'qrecord' object cannot be kfree'd is if it was inserted into the
> tracing logic, for which we already have the 'qrecord_inserted_ret'
> boolean to account for this. Hence, the caller has to kfree the object
> only if 'add_delayed_ref_head' reports not to have inserted it on the
> tracing logic.
>
> As a side-effect of the above, we must guarantee that
> 'qrecord_inserted_ret' is properly initialized at the start of the
> function, not at the end, and then set when an actual insert
> happens. This way we avoid 'qrecord_inserted_ret' having an invalid
> value on an early exit.
>
> The documentation from the 'add_delayed_ref_head' has also been updated
> to reflect on the exact ownership of the 'qrecord' object.
>
> Fixes: 6ef8fbce0104 ("btrfs: fix missing error handling when adding delay=
ed ref with qgroups enabled")
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> ---
>  fs/btrfs/delayed-ref.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 481802efaa14..bc61e0eacc69 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -798,10 +798,14 @@ static void init_delayed_ref_head(struct btrfs_dela=
yed_ref_head *head_ref,
>  }
>
>  /*
> - * helper function to actually insert a head node into the rbtree.
> + * Helper function to actually insert a head node into the rbtree.

Since you are updating this line just to capitalize the first word,
you might as well replace rbtree with xarray as we don't use rbtree
anymore.

>   * this does all the dirty work in terms of maintaining the correct
>   * overall modification count.
>   *
> + * The caller is responsible for calling kfree() on @qrecord. More speci=
fically,
> + * if this function reports that it did not insert it as noted in
> + * @qrecord_inserted_ret, then it's safe to call kfree() on it.
> + *
>   * Returns an error pointer in case of an error.
>   */
>  static noinline struct btrfs_delayed_ref_head *
> @@ -814,7 +818,14 @@ add_delayed_ref_head(struct btrfs_trans_handle *tran=
s,
>         struct btrfs_delayed_ref_head *existing;
>         struct btrfs_delayed_ref_root *delayed_refs;
>         const unsigned long index =3D (head_ref->bytenr >> fs_info->secto=
rsize_bits);
> -       bool qrecord_inserted =3D false;
> +
> +       /*
> +        * If 'qrecord_inserted_ret' is provided, then the first thing we=
 need
> +        * to do is to initialize it to false just in case we have an exi=
t
> +        * before trying to insert the record.
> +        */
> +       if (qrecord_inserted_ret)
> +               *qrecord_inserted_ret =3D false;
>
>         delayed_refs =3D &trans->transaction->delayed_refs;
>         lockdep_assert_held(&delayed_refs->lock);
> @@ -833,6 +844,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *tran=
s,
>
>         /* Record qgroup extent info if provided */
>         if (qrecord) {
> +               /*
> +                * Setting 'qrecord' but not 'qrecord_inserted_ret' will =
likely
> +                * result in a memory leakage.
> +                */
> +               WARN_ON(!qrecord_inserted_ret);

For this sort of mandatory stuff, we use assertions, not warnings:

ASSERT(qrecord_insert_ret !=3D NULL);


> +
>                 int ret;
>
>                 ret =3D btrfs_qgroup_trace_extent_nolock(fs_info, delayed=
_refs, qrecord,
> @@ -840,12 +857,10 @@ add_delayed_ref_head(struct btrfs_trans_handle *tra=
ns,
>                 if (ret) {
>                         /* Clean up if insertion fails or item exists. */
>                         xa_release(&delayed_refs->dirty_extents, index);
> -                       /* Caller responsible for freeing qrecord on erro=
r. */
>                         if (ret < 0)
>                                 return ERR_PTR(ret);
> -                       kfree(qrecord);
> -               } else {
> -                       qrecord_inserted =3D true;
> +               } else if (qrecord_inserted_ret) {
> +                       *qrecord_inserted_ret =3D true;
>                 }
>         }
>
> @@ -888,8 +903,6 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans=
,
>                 delayed_refs->num_heads++;
>                 delayed_refs->num_heads_ready++;
>         }
> -       if (qrecord_inserted_ret)
> -               *qrecord_inserted_ret =3D qrecord_inserted;
>
>         return head_ref;
>  }
> @@ -1049,6 +1062,14 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>                 xa_release(&delayed_refs->head_refs, index);
>                 spin_unlock(&delayed_refs->lock);
>                 ret =3D PTR_ERR(new_head_ref);
> +
> +               /*
> +                * It's only safe to call kfree() on 'qrecord' if
> +                * 'add_delayed_ref_head' has _not_ inserted it for

The notation we use for function names is  function_name(), not 'function_n=
ame'.

Otherwise it looks good, thanks.

> +                * tracing. Otherwise we need to handle this here.
> +                */
> +               if (!qrecord_reserved || qrecord_inserted)
> +                       goto free_head_ref;
>                 goto free_record;
>         }
>         head_ref =3D new_head_ref;
> @@ -1071,6 +1092,8 @@ static int add_delayed_ref(struct btrfs_trans_handl=
e *trans,
>
>         if (qrecord_inserted)
>                 return btrfs_qgroup_trace_extent_post(trans, record, gene=
ric_ref->bytenr);
> +
> +       kfree(record);
>         return 0;
>
>  free_record:
> --
> 2.51.0
>
>

