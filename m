Return-Path: <linux-btrfs+bounces-11040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8DFA19203
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15AB1887862
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D272211712;
	Wed, 22 Jan 2025 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE7ZQyKa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A01BD014
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551101; cv=none; b=eG61vgKEOn0uz1HTmls5uTd1djHBQlhmjkX4Jv1oIeRfjHsPq9jPoZYP7cC9hDbjxHairwNtmnIdhLIEnUp5/CaLGCwvnC7Mqlv4u5YJ/m6381niI2DqPyaVddSLVPYXLrPAIYpmXDCu4cZEEeFDtIDTI7uIHaRnuiV2RiGwtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551101; c=relaxed/simple;
	bh=cNb7UJitvvBqpcK7V1WmE2tAXOS3TwNaJ6bGVUnmiTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvLquEyHpxktf4GYD5FBu/oCc4dX+cDgBiWMBAE+jNoYQJW8MLC8VFEYWMwmzhBgDs8ombGTceJLFBTsrn3czM6q2+Xr2/J7WrPd0mH6zcndDUbVi5v046b9bw3qDzrFH3Csvs8VGYzEaJri/ZDW1qeTPgh6c6mUr+RF8SEzp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE7ZQyKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C1C4CEE0
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737551101;
	bh=cNb7UJitvvBqpcK7V1WmE2tAXOS3TwNaJ6bGVUnmiTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IE7ZQyKaWgyHysCPvZVJShpQnr+r6gNAOFGCMtq3Th3MXzgRwUGl/mQSC4G+X23jE
	 Vn8euOcZVdW0MjVpAJWSAYox/9s23F+Xc0435AQSCbUOarg9PdLhIJQvvbUG/FCuKQ
	 Fv+DfjnjOJZ+aQ4YWFmFQYm9kHzng3pomx5lq/WV/4rpUVvddONJCdUKtE0uJUBqZZ
	 l6TtJnehGC5jqQn7gntmDhQqAA+UxUpvHQP5+87wff5W71Sr4z5gos40kOLGHlurlM
	 gmYeHbw5ZUAQ2UVXVKy2x1421IEUb+06BHnEd7saserLiuRVM7T+mVs7EgI49WJqeT
	 PCJJzUFR/W9Sw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1336405166b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 05:05:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8KqCFC3jRK8pb6+qqoCRgYGiDfG2syAxQdPmWfLdbZTwzgo+7
	Kw2Y0tiReDiNyutzpyQzoXej64F618IuwJ2ke0GtLza1DHFXEiEJXeqkNbQBDWIyEd+6ZpBHIU0
	GYoIaVdk9p2zOxDxJ+yvF/ug8BBk=
X-Google-Smtp-Source: AGHT+IFVIVYCmkfNve7Sc7q/aqNN1EWhupVOG+QGmYxqFdiqpQRAva4Cs1hc6WybCEmtgy0IUirE07Pplb1ER5RyiYE=
X-Received: by 2002:a17:907:7e95:b0:aa6:715a:75b5 with SMTP id
 a640c23a62f3a-ab38b44d44fmr1738263566b.46.1737551099687; Wed, 22 Jan 2025
 05:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <9845595d-1015-4012-96e7-a56856fb522e@meta.com>
In-Reply-To: <9845595d-1015-4012-96e7-a56856fb522e@meta.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 22 Jan 2025 13:04:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5-vR7jD+iepXuiH0kh66LUARik1QKixEsCc1aU-gLsjQ@mail.gmail.com>
X-Gm-Features: AbW1kvZHH-q2OBGH9gtUyMlj3ZP6un_3uhE0ZRQXFjJUknDhHYHYKm-Gz2Cv3yM
Message-ID: <CAL3q7H5-vR7jD+iepXuiH0kh66LUARik1QKixEsCc1aU-gLsjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Mark Harmstone <maharmstone@meta.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:59=E2=80=AFPM Mark Harmstone <maharmstone@meta.c=
om> wrote:
>
> On 22/1/25 12:39, Filipe Manana wrote:
> > On Wed, Jan 22, 2025 at 12:25=E2=80=AFPM Mark Harmstone <maharmstone@fb=
.com> wrote:
> >> @@ -4944,20 +4942,15 @@ int btrfs_init_root_free_objectid(struct btrfs=
_root *root)
> >>
> >>   int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
> >>   {
> >> -       int ret;
> >> -       mutex_lock(&root->objectid_mutex);
> >> +       u64 val =3D atomic64_inc_return(&root->free_objectid) - 1;
> >>
> >> -       if (unlikely(root->free_objectid >=3D BTRFS_LAST_FREE_OBJECTID=
)) {
> >> +       if (unlikely(val >=3D BTRFS_LAST_FREE_OBJECTID)) {
> >>                  btrfs_warn(root->fs_info,
> >>                             "the objectid of root %llu reaches its hig=
hest value",
> >>                             btrfs_root_id(root));
> >> -               ret =3D -ENOSPC;
> >> -               goto out;
> >> +               return -ENOSPC;
> >>          }
> >>
> >> -       *objectid =3D root->free_objectid++;
> >> -       ret =3D 0;
> >
> > So this gives different semantics now.
> >
> > Before we increment free_objectid only if it's less than
> > BTRFS_LAST_FREE_OBJECTID, so once we reach that value we can't assign
> > more object IDs and must return -ENOSPC.
> >
> > But now we always increment and then do the check, so after some calls
> > to btrfs_get_free_objectid() we wrap around the counter due to
> > overflow and eventually allow reusing already assigned object IDs.
> >
> > I'm afraid the lock is still needed because of that. To make it more
> > lightweight maybe switch the mutex to a spinlock.
> >
> > Thanks.
>
> Thanks Filipe. Do we even need the check, really? Even a denial of
> service attack wouldn't be able to practically call the function ~2^64
> times. And there's no way to create an inode with an arbitrary number,
> short of manually hex-editing the disk.

Well we do such limit checks everywhere, why would we ignore them only here=
?
Even if they are very unlikely to be hit in practice, if they happen,
we can get into serious trouble.

So I don't think it's wise to ignore the limit.

Thanks.

>
> Mark

