Return-Path: <linux-btrfs+bounces-17324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78805BB1E05
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 23:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22CE19C1642
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 21:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC6311C1E;
	Wed,  1 Oct 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHnzPXVm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF4286D4C
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355499; cv=none; b=BZNIQaFKrA2nGtzkCXtSbiYtRKhEN+zgCLPDRnBFolwcm8aMmbAYswUP6U9e7NsJoHE1z4zzRo2VTE9uf75I0zHjb9PeL/VBhMJ1t7OHPRn3jGOPoTXl/iwpckkfSQLX2KSGniuO5ynzY2tsWsyvZEox9l1MMUY9KAM+Zydm7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355499; c=relaxed/simple;
	bh=9UL/1ASgh+3hLlEezmNNQbuDpvgLbZG38vZaP1sp9Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7TIeFcBtxVRgYB9+zsY8577YBG2yO0Il95KXaHXg5n7Gp1vosCYhkhRnqYQPZHc4obo+kCzF0gwZbvqhEOdwru9yrz8z4RNIU0LfBwzDrofa81pgzc0tYBOhL3qcARN0lI/Kh8illM2Bz/5A3mBDzKJgmElUbC47qQYTWZQMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHnzPXVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43249C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759355499;
	bh=9UL/1ASgh+3hLlEezmNNQbuDpvgLbZG38vZaP1sp9Cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YHnzPXVmYJpU0gGLoy4rmWgBozcuyd7kjcY1mASOMvPWR1E2W97F/5REOEdlPzHLp
	 FsGudIuJyiZVWiLbZ7j9BaU7I+FWDD6PfLx4tOUcUfFqJzIu3ywBl+kA50uSBvX6N7
	 Mv4etor1U88XQhqCuZB/ndjyJeX/82jE5Q8/lXqrJmeTWV/IUdxb4+nAIejZXs5JOS
	 hXCqswDxm2+6J9mh80Kqs2X3QFnu3P5IajgGtE/f8MnFAJtTuxM78SKcGgoRBIh5Dt
	 sLkY7AaGuox7VPgfceKMXJae+VNcGUuclrpfByx8IwqfWKMLYlS99Mghtsuz4DtO/T
	 tUQBDmJ113cxw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso492738a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 14:51:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwgbRG9QQwUt/XCRa26qXx04QLaFM5KRw/5BaNnTpRk6zvrXTN2
	OwC+bITaPie2CvGFyQtiqX1BqXkvG2ZwhPxKi7i+txvtEC9SM12eRcSMvUbZMkmBdyPHgVqIGO4
	sqqmpNJTpfFi8w+LMMT9GY6ye8P3B++4=
X-Google-Smtp-Source: AGHT+IGCxqtUuxm7ClLljvd7wD37dNh3EkUg+6omScocWf+s5yMLrXQ4a566ZKctxfsdNuSze1VNwijvTfHBl0iVV7c=
X-Received: by 2002:a17:906:c149:b0:b3d:b251:cded with SMTP id
 a640c23a62f3a-b46e4d79a6fmr658959866b.16.1759355497775; Wed, 01 Oct 2025
 14:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001180503.1353226-1-mssola@mssola.com>
In-Reply-To: <20251001180503.1353226-1-mssola@mssola.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 1 Oct 2025 22:50:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7V0XQVvOiX8VwyZDzdM6qJeSbcq32sVYducLnNc4+ZWA@mail.gmail.com>
X-Gm-Features: AS18NWDFuzHCWUUOoibJvyzdud3JgSuw4N--nCXlu1dmpQuNpPTXei3KsV4Ad1A
Message-ID: <CAL3q7H7V0XQVvOiX8VwyZDzdM6qJeSbcq32sVYducLnNc4+ZWA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: prevent a double kfree on delayed-ref
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	fdmanana@suse.com, wqu@suse.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 7:05=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <mssola=
@mssola.com> wrote:
>
> In the previous code it was possible to incur into a double kfree()
> scenario when calling add_delayed_ref_head(). This could happen if the
> record was reported to already exist in the
> btrfs_qgroup_trace_extent_nolock() call, but then there was an error
> later on add_delayed_ref_head(). In this case, since
> add_delayed_ref_head() returned an error, the caller went to free the
> record. Since add_delayed_ref_head() couldn't set this kfree'd pointer
> to NULL, then kfree() would have acted on a non-NULL 'record' object
> which was pointing to memory already freed by the callee.
>
> The problem comes from the fact that the responsibility to kfree the
> object is on both the caller and the callee at the same time. Hence, the
> fix for this is to shift the ownership of the 'qrecord' object out of
> the add_delayed_ref_head(). That is, we will never attempt to kfree()
> the given object inside of this function, and will expect the caller to
> act on the 'qrecord' object on its own. The only exception where the
> 'qrecord' object cannot be kfree'd is if it was inserted into the
> tracing logic, for which we already have the 'qrecord_inserted_ret'
> boolean to account for this. Hence, the caller has to kfree the object
> only if add_delayed_ref_head() reports not to have inserted it on the
> tracing logic.
>
> As a side-effect of the above, we must guarantee that
> 'qrecord_inserted_ret' is properly initialized at the start of the
> function, not at the end, and then set when an actual insert
> happens. This way we avoid 'qrecord_inserted_ret' having an invalid
> value on an early exit.
>
> The documentation from the add_delayed_ref_head() has also been updated
> to reflect on the exact ownership of the 'qrecord' object.
>
> Fixes: 6ef8fbce0104 ("btrfs: fix missing error handling when adding delay=
ed ref with qgroups enabled")
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks. I've pushed this to for-next [1] and renamed the subject to be
more specific:

"btrfs: fix double free of qgroup record after failure to add delayed ref h=
ead"

[1] https://github.com/btrfs/linux/commits/for-next/

> ---
>
> Changes in v2:
>
> - Change documentation to reflect that we are using an xarray instead of =
an
>   rbtree.
> - Change warning to assertion on qrecord_insert_ret.
> - Fix function notation on comments.
> - Fix commit message as suggested
>
>  fs/btrfs/delayed-ref.c | 43 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 481802efaa14..f8fc26272f76 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -798,9 +798,13 @@ static void init_delayed_ref_head(struct btrfs_delay=
ed_ref_head *head_ref,
>  }
>
>  /*
> - * helper function to actually insert a head node into the rbtree.
> - * this does all the dirty work in terms of maintaining the correct
> - * overall modification count.
> + * Helper function to actually insert a head node into the xarray. This =
does all
> + * the dirty work in terms of maintaining the correct overall modificati=
on
> + * count.
> + *
> + * The caller is responsible for calling kfree() on @qrecord. More speci=
fically,
> + * if this function reports that it did not insert it as noted in
> + * @qrecord_inserted_ret, then it's safe to call kfree() on it.
>   *
>   * Returns an error pointer in case of an error.
>   */
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
> +               ASSERT(qrecord_inserted_ret !=3D NULL);
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
> +                * add_delayed_ref_head() has _not_ inserted it for
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

