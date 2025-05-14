Return-Path: <linux-btrfs+bounces-14005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD7AB6A1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE95F4C010C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC62701BF;
	Wed, 14 May 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2WEhTf3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4941A0BE1
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222560; cv=none; b=WbPO85i2I9h2rsybomB3QzUs5zv+pwBb3WnzgHuRDfb+VmvFsLB9+K8utoG4FFHToS2gOOT8McrRAeo30bdCCZA2d4DQMeDZa0LOhYtkhwbPdbEhdx7NB0tLfXxR9yJD2AX1Awdz/z11cPJg+JebL3kQT/mQ01IAGtazHhDT700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222560; c=relaxed/simple;
	bh=AepI2gQuXKXhEfKrNZnBYKPR5UwKJqU9qm3GZ1kEifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzixDWL9tdT3XDmSuf52CYY4uSckG6TmWVjEJ8RkIZFxiVHS9Z6FzBgseSPZTT0HEh9FUfNGlG3fE9StGJt8zQwt5zo5wGuzMZH4j8ejTS957L55GmsaGZpVZK/NzhnPd4g3c6pdTaLxea3mNe6+pRfjT4XR5m2PUeHLoCilNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2WEhTf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A86C4CEF0
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222560;
	bh=AepI2gQuXKXhEfKrNZnBYKPR5UwKJqU9qm3GZ1kEifg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M2WEhTf3ykNDulSFvPWBVyw09TNvC6Zlb8a7bi3fil8kMeeQ27MZe+F+Y+TJrZ7w+
	 mEfwH59sByrQ1htRupkd/0kRr4X9UwhOElA1tD6MuVHLzBtZLV4b3mqw0nL7NtgDOq
	 ADr+QaGZ3Mp8UsA+lNubeIegsmVW22UIXt+ZQaIEiUnVYGIe85CjbHEKRuF5//NEvn
	 zeDsFBktsvLqQPoxKtwYo96/iX0Je0YUb21Zt+EmFNF3xGSEjf7QuaclqT7kZ0BmWN
	 6M1sbKHs8JZwGHimZYTmajaGhzRGsjofNLfiplFTWJhvVYVKiHntip3Qa8YqTIejgL
	 kSzJXOflvXt3Q==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fbf007ea38so11030417a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 04:36:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YxENh/wttQvtK03iTU14rVgAiX4rLO04+q6vRGlBcoLXvPsHzN5
	WjzTggXAm8xnE9lbhEj9TxCeJ+BVPnup7M5NJe84us2g9f1UFfF3xeruB/WqDPmQgKc0Syql7T0
	eitI0xfDgqOV9KvGhECf1WTNQaEc=
X-Google-Smtp-Source: AGHT+IGRFF7nQF77KFkrzOGLEd+Yh4NX2t+tF8bHXtdnHKlCgHM79ZWRT6jKfoUsONHKGTpD6YeqK8zpOVYizuk/Fyw=
X-Received: by 2002:a17:907:728b:b0:ac3:3e40:e183 with SMTP id
 a640c23a62f3a-ad4f714719dmr351373166b.3.1747222558635; Wed, 14 May 2025
 04:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747217722.git.fdmanana@suse.com> <fc9d7357ad819c2586a3ad42bc3e0f3486d577e0.1747217722.git.fdmanana@suse.com>
 <86e99ac0-31d1-40c3-ac28-ad978347da17@suse.com> <CAL3q7H4vziMoLxJbBSQJuw3Dvya-f8jQxTZMoTKUMEqajLVEEA@mail.gmail.com>
In-Reply-To: <CAL3q7H4vziMoLxJbBSQJuw3Dvya-f8jQxTZMoTKUMEqajLVEEA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 14 May 2025 12:35:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Atv=8ZUq==hOpsyA6+BBfWKqd7VZEahFpkK39-5m2tw@mail.gmail.com>
X-Gm-Features: AX0GCFtr4HdH7VsHV9RhzZgRAqzX81ZFoQhfcKowPIOp1kPdP2Nz9LG_ClaQUpc
Message-ID: <CAL3q7H6Atv=8ZUq==hOpsyA6+BBfWKqd7VZEahFpkK39-5m2tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: simplify early error checking in btrfs_page_mkwrite()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:57=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Wed, May 14, 2025 at 11:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2025/5/14 19:59, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > We have this entangled error checks early at btrfs_page_mkwrite():
> > >
> > > 1) Try to reserve delalloc space by calling btrfs_delalloc_reserve_sp=
ace()
> > >     and storing the return value in the ret2 variable;
> > >
> > > 2) If the reservation succeed, call file_update_time() and store the
> > >     return value in ret2 and also set the local variable 'reserved' t=
o
> > >     true (1);
> > >
> > > 3) Then do an error check on ret2 to see if any of the previous calls
> > >     failed and if so, jump either to the 'out' label or to the
> > >     'out_noreserve' label, depending on whether 'reserved' is true or
> > >     not.
> > >
> > > This is unnecessarily complex. Instead change this to a simpler and
> > > more straighforward approach:
> > >
> > > 1) Call btrfs_delalloc_reserve_space(), if that returns an error jump=
 to
> > >     the 'out_noreserve' label;
> > >
> > > 2) The call file_update_time() and if that returns an error jump to t=
he
> > >     'out' label.
> > >
> > > Like this there's less nested if statements, no need to use a local
> > > variable to track if space was reserved and if statements are used on=
ly
> > > to check errors.
> > >
> > > Also move the call to extent_changeset_free() out of the 'out_noreser=
ve'
> > > label and under the 'out' label  since the changeset is allocated onl=
y if
> > > the call to reserve delalloc space succeeded.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Looks good to me, but I'm wondering can we do something better by
> > completely merging @ret2 and @ret.
> >
> > In fact we didn't really utilize @ret except two sites:
> >
> > - page got truncated out
> >
> > - btrfs_set_extent_delalloc() failure
> >    In that case, we should use vmf_error()
> >
> > In the out_noreserve tag, do something like:
> >
> >         if (ret)
> >                 return vmf_error(ret);
> >         return VM_FAULT_NOPAGE;
> >
> > Now we only need a single "int ret" as usual and not need to bother the
> > VM_FAULT* return values at all.
>
> I considered all that, but it's not so simple, one thing is that 'ret'
> is of a different type, vm_fault_t, which happens to be an unsigned
> int - but I don't think it's good to make assumptions about that in
> the code.
>
> There's also the case where we set ret to VM_FAULT_SIGBUS.

Ok getting rid of this case, allows for a simple way to get rid of
having two return value variables.
Added two patches for that in v2 of the patchset.

> I thought about getting rid of ret2 and have a single 'ret' or type
> int, and then do something like:
>
> if (ret < 0)
>      return vmf_error(ret);
>
> return ret ? ret : VM_FAULT_NOPAGE;
>
> But then I was making assumptions that vm_fault_t values are positive,
> and didn't think it's a good thing to do because it's an opaque type.
>
> >
> > Thanks,
> > Qu
> >
> > > ---
> > >   fs/btrfs/file.c | 15 +++++++--------
> > >   1 file changed, 7 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index a2b1fc536fdd..9ecb9f3bd057 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1843,7 +1843,6 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> > >       size_t fsize =3D folio_size(folio);
> > >       vm_fault_t ret;
> > >       int ret2;
> > > -     int reserved =3D 0;
> > >       u64 reserved_space;
> > >       u64 page_start;
> > >       u64 page_end;
> > > @@ -1866,17 +1865,17 @@ static vm_fault_t btrfs_page_mkwrite(struct v=
m_fault *vmf)
> > >        */
> > >       ret2 =3D btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_res=
erved,
> > >                                           page_start, reserved_space)=
;
> > > -     if (!ret2) {
> > > -             ret2 =3D file_update_time(vmf->vma->vm_file);
> > > -             reserved =3D 1;
> > > -     }
> > >       if (ret2) {
> > >               ret =3D vmf_error(ret2);
> > > -             if (reserved)
> > > -                     goto out;
> > >               goto out_noreserve;
> > >       }
> > >
> > > +     ret2 =3D file_update_time(vmf->vma->vm_file);
> > > +     if (ret2) {
> > > +             ret =3D vmf_error(ret2);
> > > +             goto out;
> > > +     }
> > > +
> > >       /* Make the VM retry the fault. */
> > >       ret =3D VM_FAULT_NOPAGE;
> > >   again:
> > > @@ -1972,9 +1971,9 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> > >       btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> > >       btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, pag=
e_start,
> > >                                    reserved_space, true);
> > > +     extent_changeset_free(data_reserved);
> > >   out_noreserve:
> > >       sb_end_pagefault(inode->i_sb);
> > > -     extent_changeset_free(data_reserved);
> > >       return ret;
> > >   }
> > >
> >

