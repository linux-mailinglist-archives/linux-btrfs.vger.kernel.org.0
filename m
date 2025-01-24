Return-Path: <linux-btrfs+bounces-11058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED4A1B5E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 13:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937A93A6291
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBFF21B192;
	Fri, 24 Jan 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWty85gP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C31CEEA4
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721595; cv=none; b=QWoVO+OY0+lawmxcIDYcdRxvLTR5oijqTXdl6aS9kiDOCuN3gq0rfvcjun5wpGWgjePRHPnpKwxlncC4K1CshGlMaZnhPiXUr/E++4zCuamLR1JyqnA/PFzcTzrfuVwS1ZRPSblgMfxZe+0vyQ3B7reD03jN2RaqWqGLnRmucfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721595; c=relaxed/simple;
	bh=R2dnaLsKEnfE5h/eMg7GkFevxKlpj2Ot4CDfurtfDjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4kyJsmVqrTCiA3qMb0H6d8VYDOUzl93sesezvBced5RuNFPejiydKVVO2F5ZwwYlCqjb0MVNJDcJ/GKdy4ksWJiqv62gQJhxxn5280Ub9wqRgXuaPERJecbqh3+wbS4jMBSL1UhsYe+xEIcb/WElrA8TpEJGqflm8nTR+c48v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWty85gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377FCC4CEE2
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 12:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737721595;
	bh=R2dnaLsKEnfE5h/eMg7GkFevxKlpj2Ot4CDfurtfDjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MWty85gP3fP3UyEZOmlHow5dyI1bYfuD3iLRExOGxlKsfWJQExblXueJ10DleqPNP
	 CZSPkAflzJaxvH+ZJXuxcc6nS2FIXl3kE2tI0ZXVCOvp1PHdKLTauIzHO6DKs3rX2Y
	 YJzyHsafVJ6GULE9qK2BLvNy9fjBHbBzhFzFOKie9Zfdpcw2Fcfq0KhZbipGIp1jaK
	 JD4phwt9CPmjYMMBMu9MCjw2HBXcQiNawKkR4ci9QmMwC/dmRQI/ePcDaiG4O5aoBk
	 JTLzkoQQFhIyYRkJStyc7+sBCKh8Pggp5YS5JAnsg1Ji10aRRb6KKKFyQQwToRWLe/
	 FoALRV/Iu6fpg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67ac42819so328731166b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 04:26:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTT7Dlo9YwISMUY6cpxjEUo+vzJovvvAKM2nCNLp6vs+VeCm17N7/FsW2YAQEaJbz/MYH7b2EFjcKWow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOPtA9dSW7nANivYuMfKPIwODqov9wuF8DfvpFVGfop7Xue0H
	kEOWGi0zDYwtRZfuF169cwdU4D5LfLkAjK+uVwi+bkpvI1748GAbdUZjM+KdapC7uggh9+7KK4D
	4yz8jJdGoFycyEwIXAnE9VujQgEU=
X-Google-Smtp-Source: AGHT+IHB5B+0g4bsun43HZsIMAZEky1Ax2t7Sc4r52cVXkol8ylwxJHDytA+i1mNLq1G2Ei0iFlLnH5wFnAH0LR1hpc=
X-Received: by 2002:a17:906:7314:b0:ab2:f5cb:c039 with SMTP id
 a640c23a62f3a-ab38b48ae9amr2734103566b.54.1737721593765; Fri, 24 Jan 2025
 04:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz> <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
In-Reply-To: <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Jan 2025 12:25:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
X-Gm-Features: AWEUYZl6NnWd6vRTi-fKQVbQYeiKpQSZNo4X135ph37GH_XUN9ZPAxNLF4kMu4w
Message-ID: <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 8:22=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Thu, 23 Jan 2025 at 23:00, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Jan 22, 2025 at 02:51:10PM +0100, Daniel Vacek wrote:
> > > On Wed, 22 Jan 2025 at 13:40, Filipe Manana <fdmanana@kernel.org> wro=
te:
> > > > > -       if (unlikely(root->free_objectid >=3D BTRFS_LAST_FREE_OBJ=
ECTID)) {
> > > > > +       if (unlikely(val >=3D BTRFS_LAST_FREE_OBJECTID)) {
> > > > >                 btrfs_warn(root->fs_info,
> > > > >                            "the objectid of root %llu reaches its=
 highest value",
> > > > >                            btrfs_root_id(root));
> > > > > -               ret =3D -ENOSPC;
> > > > > -               goto out;
> > > > > +               return -ENOSPC;
> > > > >         }
> > > > >
> > > > > -       *objectid =3D root->free_objectid++;
> > > > > -       ret =3D 0;
> > > >
> > > > So this gives different semantics now.
> > > >
> > > > Before we increment free_objectid only if it's less than
> > > > BTRFS_LAST_FREE_OBJECTID, so once we reach that value we can't assi=
gn
> > > > more object IDs and must return -ENOSPC.
> > > >
> > > > But now we always increment and then do the check, so after some ca=
lls
> > > > to btrfs_get_free_objectid() we wrap around the counter due to
> > > > overflow and eventually allow reusing already assigned object IDs.
> > > >
> > > > I'm afraid the lock is still needed because of that. To make it mor=
e
> > > > lightweight maybe switch the mutex to a spinlock.
> > >
> > > How about this?
> > >
> > > ```
> > > retry:  val =3D atomic64_read(&root->free_objectid);
> > >         ....;
> > >         if (atomic64_cmpxchg(&root->free_objectid, val, val+1) !=3D v=
al)
> > >                 goto retry;
> > >         *objectid =3D val;
> > >         return 0;
> > > ```
> >
> > Doesn't this waste some ids when there are many concurrent requests?
>
> Quite the opposite, it's meant to prevent that. That's why I suggested
> it as the original patch was wasting them and that's what Filipe
> pointed out.

Not wasting, but allowing the counter to wrap around and return
already in use object IDs, far more serious than wasting.
And besides that, the counter wrap-around would allow the return of
invalid object IDs, in the range from 0 to BTRFS_FIRST_FREE_OBJECTID
(256).

>
> It will only retry precisely when more concurrent requests race here.
> And thanks to cmpxchg only one of them wins and increments. The others
> retry in another iteration of the loop.
>
> I think this way no lock is needed and the previous behavior is preserved=
.

That looks fine to me. But under heavy concurrency, there's the
potential to loop too much, so I would at least add a cond_resched()
call before doing the goto.
With the mutex there's the advantage of not looping and wasting CPU if
such high concurrency happens, tasks will be blocked and yield the cpu
for other tasks.

Any improvements in performance could also be measured easily with
fs_mark, which will heavily hit this code path.
I would prefer if the patch adds fs_mark numbers (or from any other
test) in the changelogs.

Thanks.

