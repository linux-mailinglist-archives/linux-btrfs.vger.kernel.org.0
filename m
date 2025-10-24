Return-Path: <linux-btrfs+bounces-18269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D68EC05527
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4641D4061E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43726E6F6;
	Fri, 24 Oct 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA/KJcO9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD1302162
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297399; cv=none; b=LlS3kjx7fuzjkmw4tQoXX2q2S4DnqAXFUYkh45Sx4XkFGeOHt1qVMISPF6ZaxdFYphWUORNtk9BeQYnUdfvrVOXINDa+64JZUWkF5RHAMS0C6A9cj32wSwy6ILARvItt/M+p19j3We9v00WIRWaitTSUo+eickrNM+cCWrD0WRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297399; c=relaxed/simple;
	bh=DRavPNhPICFbrW8kBHinhTaqs0FvIw3GKydnT9Z0H9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeWGoqYxdAN+/bnn88MtdedCxyYDAgh1YWsZBJ94SvE/JfrlXxw/Zp+LtTpCwk2+wYLwsoxrHP0RPTwmNpk686FhstBmMvZsnqyes+qKYEoaGIKboSLU5PfQMYK25eNZNGDynou4slKBZ68pSnKoxbQp1PjaPBc99WB5FkFEL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA/KJcO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCC7C113D0
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761297398;
	bh=DRavPNhPICFbrW8kBHinhTaqs0FvIw3GKydnT9Z0H9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WA/KJcO97k9/ITvq5E2jDifaeVHKS+dNVO44CmQxCMGg9guAYXPx092UBC7wl7UoN
	 QeIMLhJv9Sh6EmvBALh788Rz+OMhBH6e+1mgBGX5GdKwGpBeKw8AFtdAAQtOxNzaU6
	 y2qIjd0TsBK6FuF9a1JrfjbaTYGyA2BD58sBase7AUtrQrRijV19InUx6qoQF6sJrN
	 IKfbnaj85ObMxeuOD142P7hWs6ilkyOGo5Ng/oaCGaKACLncoIqe1OOxE558CRqcnq
	 HCMi+z5GH51akaGGM4n8594vCiEDs3k4itS1LhYQKI38+zsUxRx0wR4GF7rQjULCj+
	 ZKzbhshbLUbEQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso366757366b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 02:16:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXunqFTzn6Ppjn8IInNvbayinLfOK9/ksArRwaXoiQv2sLWfI7gCcmux0iUnyxWodpan+ERu+tu82o+Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXoClDjO2njgLIs2usF6AhT4gcPgX0FhpgJQXZfxATv5nhwBE
	kuBsrLmYMrQA+ZfOLXgQ8ZRBGZj/DWfUURyrhAGMdXhguTUUZtsXksspIMCJXDSNB2Iea0ET7Z9
	tvmtYITbDDZLhHPH8LEuHk0ujhwXhbNE=
X-Google-Smtp-Source: AGHT+IGTsChoahuZk2XWAKEyxkgvLFwDO4PLXjJgm3i/MY2vbmPjMYkCmzccsibRKhNP7DzGJ/RMNP3s75100J3SUug=
X-Received: by 2002:a17:906:fd87:b0:b07:c5b1:b129 with SMTP id
 a640c23a62f3a-b647195b8c3mr3494052266b.1.1761297397005; Fri, 24 Oct 2025
 02:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
 <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
 <6f36e8d0-630b-4cc3-a780-11be4aa0a65f@suse.com> <CAL3q7H4TcJNY7cYeYWoByOW0ek6BBEbtgSSFFOvc7aagarfFXQ@mail.gmail.com>
 <63aac204-5ea5-45b1-854e-6b3d78db99fd@gmx.com> <CAL3q7H4nO6TB66RhrrrC94GSrjLOb1tOQ1xPJqmZs=m82gX73g@mail.gmail.com>
 <1baa687a-22f6-4eaa-8de8-5096e8a29275@gmx.com>
In-Reply-To: <1baa687a-22f6-4eaa-8de8-5096e8a29275@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 10:16:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H49m-qBM_QdxPhQ=-ByEOJWkrqBe=r9thm2fmGS=C6MnQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkigUKUHqZVVFXQNtunArct32b0Ll1KT6t347nOf6zgKGfSE8Pmjdu_nzE
Message-ID: <CAL3q7H49m-qBM_QdxPhQ=-ByEOJWkrqBe=r9thm2fmGS=C6MnQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: make sure no dirty metadata write is submitted
 after btrfs_stop_all_workers()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:10=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2025/10/24 19:25, Filipe Manana =E5=86=99=E9=81=93:
> [...]
> >
> > If there's no backref in the extent tree and no delayed ref for tree
> > block A then we already have a corrupted fs.
>
> Yes I know.
>
> >>>
> >>> Even after a transaction aborts, it's ok, but pointless, to allocate
> >>> extents and trigger writeback for them.
> >>
> >> Writeback can be triggered by a lot of other reasons, e.g. memory
> >> pressure, and in that case if we try to writeback tree block B, it wil=
l
> >> overwrite tree block A even if it's after transaction abort.
> >
> > It doesn't matter why and when the writeback is triggered, that was
> > not my point.
> > My point was if a transaction was aborted, what matters is that we
> > can't commit that transaction or start a new one, and can't override
> > existing extents (either they are used or pinned).
>
> My point is, your last point (can't override existing extents) is not
> guaranteed especially after a transaction is aborted, which can be
> caused by corrupted fs.

If there's no backref for tree block A, or a delayed ref, then we
already have a high risk of overwriting tree block A.
The transaction abort is irrelevant... if there's no abort, we
overwrite it (and silently) - so we're in a more bad situation if an
abort happened.

We can never guarantee a fs is healthy if it's already corrupted.

>
> Yes, the initial fs can be corrupted, but it doesn't mean we're free to
> make it more corrupted.

>
> Thanks,
> Qu

