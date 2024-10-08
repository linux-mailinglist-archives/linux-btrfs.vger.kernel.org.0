Return-Path: <linux-btrfs+bounces-8657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83534995815
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 22:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D130283FDA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12911213EE7;
	Tue,  8 Oct 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP+3N6o4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410ED38DD6
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417859; cv=none; b=Zm2ixD0eR+j1tP4oKJMKVC+GkacXJ3DX7GIQQTC6Blhz3Y5viDSUYImcop5fMEsa7Vo2JabAqc1+DeHN4O+a+lC4BsE1xWLOdalB6o8GixWgRCgsFyvA4nPwi7cYgSQpibuBSmWcJ0J6vXmIN7FHV1goeUqUO5MihS/VQ9TK474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417859; c=relaxed/simple;
	bh=8AXOL9zSwudhJGeibKSAB+4QYBbTqEjgXP9asnOXXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoUd4fhKdlpTvqCJe881gSj5g61QId5WhEiIrZ91/iDHLmj60PlnE0WdzoHEfJ800iBg8bHK0wyOTQCdrMEmGGnJ4lOkL7o4XdfYKghiWY643EWpPbviYMr+ij+Tn1VD7r1waBIFG3hLJVQgVN7ecD2jdK6uOG087MVZbD9x+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP+3N6o4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0023C4CECE
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728417857;
	bh=8AXOL9zSwudhJGeibKSAB+4QYBbTqEjgXP9asnOXXqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SP+3N6o4XcpzftJPd48MkfZeAQW2hkqH9gc1SVKIdJiciiehGk3xObQiU7yjnugOk
	 jMIbwi2pQq3/btvq/N1GmAqeG0aJ3qsk4aI/AfhFhCeHsPRpy0+KDto7XM32XHdBGt
	 3yWWWlrQEalAQoP4AJK/h7KzwzVWXgJRLjHUX0dRCkHPLBwQAUMqL6nXnIBnCmtNqW
	 lEBl4xz4ZpAtxhVAmQ34WLz97rk3ypTTAKaMpKQenj9hooIPBnVf3aD+QGsL94KiBk
	 aMhnPAl95X8bWzZiO12jxGVVbvWeFjNPmDiU1TgOdo699y+M0F+9tgdIuTyxjaflPu
	 wwlBSBFUBkKgQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a83562f9be9so661382766b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Oct 2024 13:04:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YytzSu0OxG6B+XGURkDKTcvgR/vEo1SGlX3TpxIiN+DTB5dMVz7
	OZjPoCIxE6poQCRI8t+MC8MpxDkCMJ/kiKMmHa18n9/xOhBqlbWBz8RbqMIe9xuOZF+WC3rCHBD
	1vzIvSb97XhgY9/DWDkogOL8vos8=
X-Google-Smtp-Source: AGHT+IFCGSsr3HIN13iOXfw/w3nxLjxGrQwx1Zg57EPPQ7eqZY2DARUQnH0t/rxyz2DWH6rwdtTB2EOoK0HiV2wHAvQ=
X-Received: by 2002:a17:907:ea9:b0:a99:4ff7:720e with SMTP id
 a640c23a62f3a-a994ff77478mr981365666b.47.1728417856364; Tue, 08 Oct 2024
 13:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727342969.git.fdmanana@suse.com> <7e4b248dad75a0f0dd3a41b4a3af138a418b05d8.1727342969.git.fdmanana@suse.com>
 <f6a720b3-65cc-494d-b32a-50a2991929a2@ijzerbout.nl>
In-Reply-To: <f6a720b3-65cc-494d-b32a-50a2991929a2@ijzerbout.nl>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Oct 2024 21:03:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7WvUbQB99GtYTNQvr3oSb3tMJZMdq0v3DRmyPehj1gPw@mail.gmail.com>
Message-ID: <CAL3q7H7WvUbQB99GtYTNQvr3oSb3tMJZMdq0v3DRmyPehj1gPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] btrfs: fix missing error handling when adding
 delayed ref with qgroups enabled
To: Kees Bakker <kees@ijzerbout.nl>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:39=E2=80=AFPM Kees Bakker <kees@ijzerbout.nl> wrot=
e:
>
> Op 26-09-2024 om 11:33 schreef fdmanana@kernel.org:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When adding a delayed ref head, at delayed-ref.c:add_delayed_ref_head()=
,
> > if we fail to insert the qgroup record we don't error out, we ignore it=
.
> > In fact we treat it as if there was no error and there was already an
> > existing record - we don't distinguish between the cases where
> > btrfs_qgroup_trace_extent_nolock() returns 1, meaning a record already
> > existed and we can free the given record, and the case where it returns
> > a negative error value, meaning the insertion into the xarray that is
> > used to track records failed.
> >
> > Effectively we end up ignoring that we are lacking qgroup record in the
> > dirty extents xarray, resulting in incorrect qgroup accounting.
> >
> > Fix this by checking for errors and return them to the callers.
> >
> > Fixes: 3cce39a8ca4e ("btrfs: qgroup: use xarray to track dirty extents =
in transaction")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> > [...
> > @@ -1034,8 +1047,14 @@ static int add_delayed_ref(struct btrfs_trans_ha=
ndle *trans,
> >        * insert both the head node and the new ref without dropping
> >        * the spin lock
> >        */
> > -     head_ref =3D add_delayed_ref_head(trans, head_ref, record,
> > -                                     action, &qrecord_inserted);
> > +     new_head_ref =3D add_delayed_ref_head(trans, head_ref, record,
> > +                                         action, &qrecord_inserted);
> > +     if (IS_ERR(new_head_ref)) {
> > +             spin_unlock(&delayed_refs->lock);
> > +             ret =3D PTR_ERR(new_head_ref);
> > +             goto free_record;
> > +     }
> > +     head_ref =3D new_head_ref;
> >
> There is a chance (not sure how big a chance) that head_ref is going to
> be freed twice.
>
> In the IS_ERR true path, head_ref still has the old value from before
> calling add_delayed_ref_head.
> However, in add_delayed_ref_head is is possible that head_ref is freed
> and replaced. If
> IS_ERR(new_head_ref) is true the code jumps to the end of the function
> where (the old) head_ref
> is freed again.

No, it's not possible to have a double free.
add_delayed_ref_head() never frees the given head_ref in case it
returns an error - it's the caller's responsibility to free it.

Thanks.

>
> Is it perhaps possible to assign head_ref to the new value before doing
> the IS_ERR check?
> In other words, do this:
>          head_ref =3D new_head_ref;
>          if (IS_ERR(new_head_ref)) {
>                  spin_unlock(&delayed_refs->lock);
>                  ret =3D PTR_ERR(new_head_ref);
>                  goto free_record;
>          }
>
> --
> Kees

