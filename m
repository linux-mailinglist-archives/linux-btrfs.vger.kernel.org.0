Return-Path: <linux-btrfs+bounces-8659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FAF99587A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 22:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8841F24AF8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A3215014;
	Tue,  8 Oct 2024 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQO3PkWR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564B1E104B
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419483; cv=none; b=cOFWAYuS197cWPgz9gs/mzj2Gi65ZKIHnbPIpdWFJ3N6zUJYgsA1GryOYzm88m2q5PqcjBc/i/z3/WyIK4/z9PSravj25/KubYOCkkuOpNRHmjoFxMnpHRy/hL8q8bVpuhO7lVeY/UwB4U9BOAd25jI6tB3dtEzzrDbChlIAtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419483; c=relaxed/simple;
	bh=MQeep1NUpvoidJwiFxP2Z/NzPIcr0pd3HVxNgeTnAYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8Nvy9G70S6jJIHYC6OeEJCUy5yEHZklOFWn070CZzTXQymJcuFzxoi2YLp9lMkiG82YX52J4AGRrOP5e+57E5gDMbAslsnv2LhRf/jPioFSTu8SqUk+DIEKXlnQ7EJ7QlPpkJGTtG45kSWarYx7mIjo5JNomJ1rAi5q7257nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQO3PkWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128ADC4CECE
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728419483;
	bh=MQeep1NUpvoidJwiFxP2Z/NzPIcr0pd3HVxNgeTnAYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iQO3PkWR3Tds0TiqJiHaeqd/vjW4mT94mET3V9b4yvFIH8xa/qIeUcc1bX3SsUjKc
	 eIzEUIoTOdv7CBwK5v1F5f52mWGj/xOVnLN2dHn9fcJRLf5VVvWeNGy5CQemgWcRHT
	 2/b9pPrAQFUxbQYO/VbXfp5Vcq5gRGx5qKiQZ1e77g1Jyr56tLy+zDi7sRM4YylLCY
	 HtCkU9gOEZ0/ERrU11bCBpcleZ5lHLl3KhMVuaAwtd9YR34xEL26o59vyVkm5jqjB3
	 Y3Kj2Gg0p5j3b2+ytophbo0aH+jtWeJjpXeMDh3JgDCWyvDyXfrsXYFGGlHhr+hotq
	 xky0W4sR4A8Kg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398b589032so9367373e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Oct 2024 13:31:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzwdJ+YwAoQ611qm32MUrwqwSMtDTmhuXFL0nrrHVMiZ02d6rVD
	gS4j9e8kjNgubqk4RPfucs2IOdzpKnocAHEFMv4GZ55a/E9ju0yKnQxUnG7qbfMeqvxuWN2bnVJ
	e97VF1PclqJpMrRcMQTCBNMH1VdM=
X-Google-Smtp-Source: AGHT+IFeUhopSojHhPKdgcV5Gc+64ABxfJzPoJQQadcKbtPrveLoX1uIONnl957FZ9pjr50+YPC/aM6k1rI4yrIMUWk=
X-Received: by 2002:a05:6512:1254:b0:538:9e1e:b06f with SMTP id
 2adb3069b0e04-539c48e1b71mr23687e87.27.1728419481416; Tue, 08 Oct 2024
 13:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727342969.git.fdmanana@suse.com> <7e4b248dad75a0f0dd3a41b4a3af138a418b05d8.1727342969.git.fdmanana@suse.com>
 <f6a720b3-65cc-494d-b32a-50a2991929a2@ijzerbout.nl> <CAL3q7H7WvUbQB99GtYTNQvr3oSb3tMJZMdq0v3DRmyPehj1gPw@mail.gmail.com>
 <ffe53748-0375-4901-9b83-62e4fe49ec69@ijzerbout.nl>
In-Reply-To: <ffe53748-0375-4901-9b83-62e4fe49ec69@ijzerbout.nl>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Oct 2024 21:30:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4d9UcaCNGjhTKS_Ba5zt5rqgPAUPbxcJUvTvSGre2cGg@mail.gmail.com>
Message-ID: <CAL3q7H4d9UcaCNGjhTKS_Ba5zt5rqgPAUPbxcJUvTvSGre2cGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] btrfs: fix missing error handling when adding
 delayed ref with qgroups enabled
To: Kees Bakker <kees@ijzerbout.nl>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:21=E2=80=AFPM Kees Bakker <kees@ijzerbout.nl> wrot=
e:
>
> Op 08-10-2024 om 22:03 schreef Filipe Manana:
> > On Tue, Oct 8, 2024 at 8:39=E2=80=AFPM Kees Bakker <kees@ijzerbout.nl> =
wrote:
> >> Op 26-09-2024 om 11:33 schreef fdmanana@kernel.org:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> When adding a delayed ref head, at delayed-ref.c:add_delayed_ref_head=
(),
> >>> if we fail to insert the qgroup record we don't error out, we ignore =
it.
> >>> In fact we treat it as if there was no error and there was already an
> >>> existing record - we don't distinguish between the cases where
> >>> btrfs_qgroup_trace_extent_nolock() returns 1, meaning a record alread=
y
> >>> existed and we can free the given record, and the case where it retur=
ns
> >>> a negative error value, meaning the insertion into the xarray that is
> >>> used to track records failed.
> >>>
> >>> Effectively we end up ignoring that we are lacking qgroup record in t=
he
> >>> dirty extents xarray, resulting in incorrect qgroup accounting.
> >>>
> >>> Fix this by checking for errors and return them to the callers.
> >>>
> >>> Fixes: 3cce39a8ca4e ("btrfs: qgroup: use xarray to track dirty extent=
s in transaction")
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>> ---
> >>> [...
> >>> @@ -1034,8 +1047,14 @@ static int add_delayed_ref(struct btrfs_trans_=
handle *trans,
> >>>         * insert both the head node and the new ref without dropping
> >>>         * the spin lock
> >>>         */
> >>> -     head_ref =3D add_delayed_ref_head(trans, head_ref, record,
> >>> -                                     action, &qrecord_inserted);
> >>> +     new_head_ref =3D add_delayed_ref_head(trans, head_ref, record,
> >>> +                                         action, &qrecord_inserted);
> >>> +     if (IS_ERR(new_head_ref)) {
> >>> +             spin_unlock(&delayed_refs->lock);
> >>> +             ret =3D PTR_ERR(new_head_ref);
> >>> +             goto free_record;
> >>> +     }
> >>> +     head_ref =3D new_head_ref;
> >>>
> >> There is a chance (not sure how big a chance) that head_ref is going t=
o
> >> be freed twice.
> >>
> >> In the IS_ERR true path, head_ref still has the old value from before
> >> calling add_delayed_ref_head.
> >> However, in add_delayed_ref_head is is possible that head_ref is freed
> >> and replaced. If
> >> IS_ERR(new_head_ref) is true the code jumps to the end of the function
> >> where (the old) head_ref
> >> is freed again.
> > No, it's not possible to have a double free.
> > add_delayed_ref_head() never frees the given head_ref in case it
> > returns an error - it's the caller's responsibility to free it.
> >
> > Thanks.
> OK, but ... in add_delayed_ref_head() I see the following on line 881
>
>          existing =3D htree_insert(&delayed_refs->href_root,
>                                  &head_ref->href_node);
>          if (existing) {
>                  update_existing_head_ref(trans, existing, head_ref);
>                  /*
>                   * we've updated the existing ref, free the newly
>                   * allocated ref
>                   */
>                  kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref)=
;
>                  head_ref =3D existing;
>
> It's calling kmem_cache_free with (the old) head_ref, which can be
> repeated in add_delayed_ref

No, it can't because after line 881, the one which calls
kmem_cache_free(), we never return an error pointer.

Thanks.

> >
> >> Is it perhaps possible to assign head_ref to the new value before doin=
g
> >> the IS_ERR check?
> >> In other words, do this:
> >>           head_ref =3D new_head_ref;
> >>           if (IS_ERR(new_head_ref)) {
> >>                   spin_unlock(&delayed_refs->lock);
> >>                   ret =3D PTR_ERR(new_head_ref);
> >>                   goto free_record;
> >>           }
> >>
> >> --
> >> Kees
>

