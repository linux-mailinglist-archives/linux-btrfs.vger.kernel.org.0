Return-Path: <linux-btrfs+bounces-12890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC440A8142F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 20:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C4C7B21DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72C23E329;
	Tue,  8 Apr 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RtEsTnrq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB223E227
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135246; cv=none; b=S9Ad5AssSl6nS+m1NrdsXqjhgrfqq62LT/B1iFB4VsH0Trx+SF2LtZXZXvwtDUDxpMknvwu5MeXcGVS+OPScMa7t0Gjed81BWhNAY9NaR0xOkvddmgt/vWjIzpp+OWz79UCi4NMbPkINXdwNLpJBcvp+7ONbRBgOBmQ2uQWtQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135246; c=relaxed/simple;
	bh=LYQ/EYSTsD5+LXO9UJC/DMwBTnYSBqqhgEmMojUu3tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J72wkrCCZjROYtrnbDymz+7xvita5tjpbwP/P8Hol/GCVm8VmZAwf8cSC8FUn3+d041ziFP98nXwntgMHYCyPZaeGfYr6dMSZWn0LFKTJV4nkoPhvGWKT9jMmMDyRQ/tBOpT4K9mD8+pWrHmF9R4H2tIjDs2Ky19KkgU8EQlx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RtEsTnrq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2aeada833so1130451766b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Apr 2025 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744135242; x=1744740042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHRGUg/zBzHIvr3agUopnqTNoN9X+n+lQuy6s3Pbdxs=;
        b=RtEsTnrqHRugeqIEYVu6Spc9prswzfffrcGJIqQpnu1XdBMIBicbuyegGgTszY/Zkp
         YBeaa3+BWT+pgBJcGv9TQZpJlV2bHZOii0xeZhlUhUVMclJecXrfb0W7j5IsG8Q3YS7S
         nGK0pO9HdrpUSWISlY/2sJpkOoQaj/lE0FXffia+xwSDpO7B94aYNzomOWNctqBVNelW
         prbwbE2Mu+FXVgDlQ0v691SWRmo9eOjQOunS8lpPFW0ikPzFeTr59mXW/s1SNHk+qpn1
         tveMnxapcnYTvzK2EPuJhz7vLt9EwRbWAMde5vk60YtKL/iO0wu7FpdHL/mq3keFpxuA
         4D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744135242; x=1744740042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHRGUg/zBzHIvr3agUopnqTNoN9X+n+lQuy6s3Pbdxs=;
        b=qMChAGQXySzEGF06ryAl2BmyMFmBvB5VH9jmwxBxqkvfDGzNlQ5UTzAZb4CxYAd0pv
         mD75INsfaUj5EHYLWJe/RyVokK7j0v3MZCBeS44h9uS+yVkNp6S++ukD0tmkDrCn1DLg
         t3MxE4QgZcHp0QSNyvy8Ecndg2KDcvl484L/RClKDlUWa9N77pFt2AW5zjdmxUuJuwqp
         Tkcivlry8eO+qtGjW5VPtrQgE3q3FANN+iz2Lt7i5u9SrWskmw93yAlHI1r71nhFo4i7
         1lXNeohQRRMsS9VVqwsvN9SLHPlNwvPIQe+gyoYGo6BaDlBZKtBgGwnysFRHN91Nybw+
         rylw==
X-Forwarded-Encrypted: i=1; AJvYcCVcX2xtoJ0RZMpOWR/r3xHh9e2NMSlIGJx0ejzufCQMkekN4Ba6WGlDq/zF9RfyZpw4RVi0r1BozgY5Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQq37ANR1eMGw+3zgmFENgKxLqD/n9jl2tMTzQDnRfVJgNIBl3
	QH79TtuP3WqaAdxixBr+yHHKNN2sPzAiJP865gG1G2Oge73c+rxY+h141zw+0yCOxK6kFXgQ1LF
	TkAA/gb1FyPqJd+bZkL4rRUnpjY0sx1OBzy44Fw==
X-Gm-Gg: ASbGncssdTB4t2GU2ICu+JdCGFf4mpGesXZWUEiexAMR4HCKsUtfrVgumfjfW+QKJER
	hMObRWTOmPine6vo/GmvIEYifZAZhXXD+Z6xkLdHnooORvRirrZH81EmAMN6KK7ad/8GnORGiHE
	6xgk2UbkrbMST9hP2a5Uakfene
X-Google-Smtp-Source: AGHT+IEcQTZbBwEPToHhlhVm9O0fPdaEu7xjj5dpTlxIaVfShGey8YE5vjRJAMVy6gBWjJ82lj4ubqkYXigh1kL4XdI=
X-Received: by 2002:a17:907:3c93:b0:ac0:4364:4083 with SMTP id
 a640c23a62f3a-aca9bdf067dmr4033966b.0.1744135242398; Tue, 08 Apr 2025
 11:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
 <CAPjX3Fem5E26+Fj537zcOXk9YZum2pDdcY9SAwCOr12wrGrroA@mail.gmail.com>
 <CAL3q7H40yF8q78vZgd2c92LZMzBxqvU3XTrWMu86th1mGsGYDg@mail.gmail.com>
 <CAPjX3Fd275aj0g5CWVKyX2wu0Sjn3a3UdZBaOR5MqUV55e4ZXw@mail.gmail.com> <CAL3q7H5BGF6cnLd3-fbp_Szq4_DSekbcM_nz_ZSGnS40w90X6Q@mail.gmail.com>
In-Reply-To: <CAL3q7H5BGF6cnLd3-fbp_Szq4_DSekbcM_nz_ZSGnS40w90X6Q@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 8 Apr 2025 20:00:30 +0200
X-Gm-Features: ATxdqUGknCmHkBQq6L-NwppXDtR6YUeam5vq7FQztqmTQEykhuKHOi_GrvcO8jw
Message-ID: <CAPjX3FepgZqXJ5B1V2Msg4pZHjphqUTRR1K3w=RGeDWzVxaUCA@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
To: Filipe Manana <fdmanana@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 19:52, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Tue, Apr 8, 2025 at 6:47=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrot=
e:
> >
> > On Tue, 8 Apr 2025 at 19:41, Filipe Manana <fdmanana@kernel.org> wrote:
> > >
> > > On Tue, Apr 8, 2025 at 6:36=E2=80=AFPM Daniel Vacek <neelx@suse.com> =
wrote:
> > > >
> > > > On Tue, 8 Apr 2025 at 16:47, Filipe Manana <fdmanana@kernel.org> wr=
ote:
> > > > >
> > > > > On Tue, Apr 8, 2025 at 1:18=E2=80=AFPM Yangtao Li <frank.li@vivo.=
com> wrote:
> > > > > >
> > > > > > All cleanup paths lead to btrfs_path_free so we can define path=
 with the
> > > > > > automatic free callback.
> > > > > >
> > > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > > ---
> > > > > >  fs/btrfs/volumes.c | 7 ++-----
> > > > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > > > > index c8c21c55be53..a962efaec4ea 100644
> > > > > > --- a/fs/btrfs/volumes.c
> > > > > > +++ b/fs/btrfs/volumes.c
> > > > > > @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btr=
fs_fs_info *fs_info,
> > > > > >         struct btrfs_trans_handle *trans;
> > > > > >         struct btrfs_balance_item *item;
> > > > > >         struct btrfs_disk_balance_args disk_bargs;
> > > > > > -       struct btrfs_path *path;
> > > > > > +       BTRFS_PATH_AUTO_FREE(path);
> > > > > >         struct extent_buffer *leaf;
> > > > > >         struct btrfs_key key;
> > > > > >         int ret, err;
> > > > > > @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct bt=
rfs_fs_info *fs_info,
> > > > > >                 return -ENOMEM;
> > > > > >
> > > > > >         trans =3D btrfs_start_transaction(root, 0);
> > > > > > -       if (IS_ERR(trans)) {
> > > > > > -               btrfs_free_path(path);
> > > > > > +       if (IS_ERR(trans))
> > > > > >                 return PTR_ERR(trans);
> > > > > > -       }
> > > > > >
> > > > > >         key.objectid =3D BTRFS_BALANCE_OBJECTID;
> > > > > >         key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> > > > > > @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btr=
fs_fs_info *fs_info,
> > > > > >         btrfs_set_balance_sys(leaf, item, &disk_bargs);
> > > > > >         btrfs_set_balance_flags(leaf, item, bctl->flags);
> > > > > >  out:
> > > > > > -       btrfs_free_path(path);
> > > > > >         err =3D btrfs_commit_transaction(trans);
> > > > >
> > > > > This isn't a good idea at all.
> > > > > We're now committing a transaction while holding a write lock on =
some
> > > > > leaf of the tree root - this can result in a deadlock as the
> > > > > transaction commit needs to update the tree root (see
> > > > > update_cowonly_root()).
> > > >
> > > > I do not follow. This actually looks good to me.
> > >
> > > path->nodes[0] has a write locked leaf, returned by btrfs_insert_empt=
y_item().
> >
> > Well, the first return is before calling this function and the final
> > return is only after committing.
> >
> > Again, the function keeps it's former structure as it was before this
> > patch. I still don't see any logical or functional change.
>
> I don't know how to put it simpler to you. There's a path setup by
> btrfs_insert_empty_item(), with a leaf locked in write mode.
> You can't just do a transaction commit while holding it locked, as
> this can deadlock because updating the tree root is part of the
> critical section of a transaction commit.
> It seems trivial to me...

Nah, of course. I see. Simply put the btrfs_free_path() needs to be
called before btrfs_commit_transaction() due to need to
btrfs_tree_unlock_rw() in btrfs_release_path() first.

So the sequence matters. The path implicit destructor on return from
insert_balance_item() is only called too late.

Thanks for the details.

> >
> > I'm lost. This still looks to me just as a straightforward cleanup.
> >
> > > > Is there really any functional change? What am I missing?
> > >
> > > Yes there is, a huge one. Even if a transaction commit didn't need to
> > > update the root tree, it would be performance wise to commit a
> > > transaction while holding a lock on a leaf unnecessarily.
> > >
> > > >
> > > > --nX
> > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >         if (err && !ret)
> > > > > >                 ret =3D err;
> > > > > > --
> > > > > > 2.39.0
> > > > > >
> > > > > >
> > > > >

