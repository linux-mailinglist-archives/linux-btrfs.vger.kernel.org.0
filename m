Return-Path: <linux-btrfs+bounces-14004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4BDAB6956
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB7F3BE955
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EA02749DC;
	Wed, 14 May 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7POTd8E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402A2749D8
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220316; cv=none; b=lbLQ4t9bHVMjt7JaEnl5/04LengXmczJXUebmdHNG+pCepKe5Sd5CfjwWKN+bih8YXret50VPkDc05p9JCXJENk6VUmkK2r7aI2dnYbztmy7p2M8+3+D8LtAPKkVLyxTS62+VhZx3mfaqZk0FdvSPZRHbQw6hmCtEfWHsMFCQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220316; c=relaxed/simple;
	bh=j+Q9iKYRHKuQw4jPFLhSx41JGrU8yuLjHOo35CZT4ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsBKINDVumGNPlUPbUs/CdCvP/ENtrGhtHaLouVdCihqBPzjn16pQmwYLKoklnJyiEM7hXbQHQuvT6xSOxdYbPTH3z1yBG8Y1Rzo9BkHH2ip9P/Xb2dcWBbCc5HUBYZblhw9XK1pPqXdOX/mOuugHvaGOg2xuY8z4Jr03SDtiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7POTd8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C075AC4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747220315;
	bh=j+Q9iKYRHKuQw4jPFLhSx41JGrU8yuLjHOo35CZT4ls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K7POTd8EyORC4+dLNcia9eqLCdglqTYok4Lu0HBQgfSjQx+CI5VKNl7gazfcWgt/g
	 CanXboGYH1pu9Hh6s2ElsUybgWYZ12tz1tsP3h7vH52wik8QBhzg52+QLcRxE5EzY5
	 kmtnwvjV1oJsY4Gwld65VEkB92SX9PoYV+BPsWTMRE3erwm/VLTUkvITybPfyBoZz0
	 trgQccXqHWN4W/BKG6TJhQEqJf53IUTt3234WuHq9j8wSTYjfB6ynnj4oMLmdlINn9
	 oBgmsI9W7ke70+ToMvKOV+CksduzaxQbc85QJOToU0/s56Qcg51VPDwVUDMHk/q5Sj
	 EiN4ykHO9+SZQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad257009e81so511119566b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:58:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YydYJO//C0G1BC6CV+smIZTMJTK7thNciwZT27dYDJ2d6fWqMwh
	rtRcE9nUyq0EK+usWjbGnrTVETKgx7Rx4reN2iB8r3ly1s3WYXULCSBEeqFsTQL1NM5Zw2VSEgW
	qqfa8Hf3Ef5mxYybVDY8Ntd5HWhA=
X-Google-Smtp-Source: AGHT+IFUPCafoDfeZGX5NOvEtf60qMiRrqHXxWxAFrbnSigB/AsbDAKAHEMI6tK+uRntnGydgtB+/k8m5RKxMjbT8Xw=
X-Received: by 2002:a17:907:d87:b0:ad2:4e5e:aa96 with SMTP id
 a640c23a62f3a-ad4f70d3328mr311847266b.3.1747220314356; Wed, 14 May 2025
 03:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747217722.git.fdmanana@suse.com> <fc9d7357ad819c2586a3ad42bc3e0f3486d577e0.1747217722.git.fdmanana@suse.com>
 <86e99ac0-31d1-40c3-ac28-ad978347da17@suse.com>
In-Reply-To: <86e99ac0-31d1-40c3-ac28-ad978347da17@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 14 May 2025 11:57:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4vziMoLxJbBSQJuw3Dvya-f8jQxTZMoTKUMEqajLVEEA@mail.gmail.com>
X-Gm-Features: AX0GCFu8qGeBmUbtQ91MdNriIZwKjFL4AoO5D-XoQgbw0DHJfG7Qt7X86knTSqo
Message-ID: <CAL3q7H4vziMoLxJbBSQJuw3Dvya-f8jQxTZMoTKUMEqajLVEEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: simplify early error checking in btrfs_page_mkwrite()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/5/14 19:59, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We have this entangled error checks early at btrfs_page_mkwrite():
> >
> > 1) Try to reserve delalloc space by calling btrfs_delalloc_reserve_spac=
e()
> >     and storing the return value in the ret2 variable;
> >
> > 2) If the reservation succeed, call file_update_time() and store the
> >     return value in ret2 and also set the local variable 'reserved' to
> >     true (1);
> >
> > 3) Then do an error check on ret2 to see if any of the previous calls
> >     failed and if so, jump either to the 'out' label or to the
> >     'out_noreserve' label, depending on whether 'reserved' is true or
> >     not.
> >
> > This is unnecessarily complex. Instead change this to a simpler and
> > more straighforward approach:
> >
> > 1) Call btrfs_delalloc_reserve_space(), if that returns an error jump t=
o
> >     the 'out_noreserve' label;
> >
> > 2) The call file_update_time() and if that returns an error jump to the
> >     'out' label.
> >
> > Like this there's less nested if statements, no need to use a local
> > variable to track if space was reserved and if statements are used only
> > to check errors.
> >
> > Also move the call to extent_changeset_free() out of the 'out_noreserve=
'
> > label and under the 'out' label  since the changeset is allocated only =
if
> > the call to reserve delalloc space succeeded.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Looks good to me, but I'm wondering can we do something better by
> completely merging @ret2 and @ret.
>
> In fact we didn't really utilize @ret except two sites:
>
> - page got truncated out
>
> - btrfs_set_extent_delalloc() failure
>    In that case, we should use vmf_error()
>
> In the out_noreserve tag, do something like:
>
>         if (ret)
>                 return vmf_error(ret);
>         return VM_FAULT_NOPAGE;
>
> Now we only need a single "int ret" as usual and not need to bother the
> VM_FAULT* return values at all.

I considered all that, but it's not so simple, one thing is that 'ret'
is of a different type, vm_fault_t, which happens to be an unsigned
int - but I don't think it's good to make assumptions about that in
the code.

There's also the case where we set ret to VM_FAULT_SIGBUS.
I thought about getting rid of ret2 and have a single 'ret' or type
int, and then do something like:

if (ret < 0)
     return vmf_error(ret);

return ret ? ret : VM_FAULT_NOPAGE;

But then I was making assumptions that vm_fault_t values are positive,
and didn't think it's a good thing to do because it's an opaque type.

>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/file.c | 15 +++++++--------
> >   1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index a2b1fc536fdd..9ecb9f3bd057 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1843,7 +1843,6 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
> >       size_t fsize =3D folio_size(folio);
> >       vm_fault_t ret;
> >       int ret2;
> > -     int reserved =3D 0;
> >       u64 reserved_space;
> >       u64 page_start;
> >       u64 page_end;
> > @@ -1866,17 +1865,17 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >        */
> >       ret2 =3D btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reser=
ved,
> >                                           page_start, reserved_space);
> > -     if (!ret2) {
> > -             ret2 =3D file_update_time(vmf->vma->vm_file);
> > -             reserved =3D 1;
> > -     }
> >       if (ret2) {
> >               ret =3D vmf_error(ret2);
> > -             if (reserved)
> > -                     goto out;
> >               goto out_noreserve;
> >       }
> >
> > +     ret2 =3D file_update_time(vmf->vma->vm_file);
> > +     if (ret2) {
> > +             ret =3D vmf_error(ret2);
> > +             goto out;
> > +     }
> > +
> >       /* Make the VM retry the fault. */
> >       ret =3D VM_FAULT_NOPAGE;
> >   again:
> > @@ -1972,9 +1971,9 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
> >       btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> >       btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_=
start,
> >                                    reserved_space, true);
> > +     extent_changeset_free(data_reserved);
> >   out_noreserve:
> >       sb_end_pagefault(inode->i_sb);
> > -     extent_changeset_free(data_reserved);
> >       return ret;
> >   }
> >
>

