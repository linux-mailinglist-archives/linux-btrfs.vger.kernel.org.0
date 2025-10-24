Return-Path: <linux-btrfs+bounces-18267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C9C05334
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068F31895537
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958826E6E8;
	Fri, 24 Oct 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1KJNBOs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CA2F8BF7
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296170; cv=none; b=q9vWvLpheZXlwXol+Or1TejWb2cJuvhFJg8fpi0Y9trWKjAnlveFe0uEqFiz/sEYqC/e/DGNIZWz0Z2W1al0jM2lhbphQ5oWjXXtSN51cfi5aktz1HFFupT+74IQnVucZNSHngoqtLBhRpxcMIhTF5hoDqXxy7k2YV57lC4QDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296170; c=relaxed/simple;
	bh=fUCqAT82fiQ5ZDIRhGk+oxgUU7XhrZhv2TrCFQuns9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8TNDEeTHSHZi5h1vZQnAfybfTI/asp79nLf36bjhrP6npkPB/bwJ75Z2ZUDVsX+w8J1JVX3AxBbpE/FKfIVHjMsxDSuvNZ6k9M9XmvZ47KtDWUwsUMdPFhNXitC9+YThItASYNsCYNMK49GYsI81+ejvgxO4l1s0gcbbtaJwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1KJNBOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9816C116B1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761296169;
	bh=fUCqAT82fiQ5ZDIRhGk+oxgUU7XhrZhv2TrCFQuns9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N1KJNBOsMpA/9+xM7bFq7fNxOJHtOfcR34Z+0CVFRSXUGli1M7VLHjvvQrJY+T5BN
	 0cG5112M5fZFkDpe2czEUkTphsiZU8Rqn/93/UqVPx0Iipfa9BWrDI20VYCIHuI1Qh
	 Px8vX1zf1cV188ezuznlyblPkWQEfShwWwxrxXhGxLSbCwzQX/a+TBWA/7BDzypUXo
	 UGN9m+OlKNwhuaznJUq/rJ7sYf7svf06aVsAvvD+OtdJaxtxuBchwEPsIF4WFfDQIv
	 577PAwfwxwmrJg/tCwb8lM88VhUzydL8u+v2cKG7xX+JVo5nG9OHOMZXinXJi+/4Pl
	 luZ2IJLlCesog==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d53684cfdso406132666b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 01:56:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv86CLvL0v8JkOP5T4haN7J5aoM5euHbGFkf+sAyrpCgSp5Zs2Sj6KfVEBtEv4mEgYOLchmSiz0CFmKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0zV/09CWN7+/fPmM+aOeYIKQ6VTkqpLB7xwUPVTq23s45lb6
	ZnjooT0hWCCVs555Hw8ykjhCYRZMjx2LPGCBTDyKHyfQMNbP7noH/wQou5x3kWgJibX5gTo8rS3
	If9RxEo17hJ5suzuMBmSNILez64vW7H4=
X-Google-Smtp-Source: AGHT+IF40SONrI7C4ELzcKu2as1WJQ3GzsbwtA128cS+KSz+uPJJwzPTSLqtxn1O+aYRM1KMDRzvr50OCYlHnsMvXcE=
X-Received: by 2002:a17:906:ae5b:b0:b6d:3f8a:bda1 with SMTP id
 a640c23a62f3a-b6d3f8abee6mr616863466b.46.1761296168331; Fri, 24 Oct 2025
 01:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
 <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
 <6f36e8d0-630b-4cc3-a780-11be4aa0a65f@suse.com> <CAL3q7H4TcJNY7cYeYWoByOW0ek6BBEbtgSSFFOvc7aagarfFXQ@mail.gmail.com>
 <63aac204-5ea5-45b1-854e-6b3d78db99fd@gmx.com>
In-Reply-To: <63aac204-5ea5-45b1-854e-6b3d78db99fd@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 09:55:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4nO6TB66RhrrrC94GSrjLOb1tOQ1xPJqmZs=m82gX73g@mail.gmail.com>
X-Gm-Features: AWmQ_bkDp8Joji_1OKIxRSUMkfJ93NBRjLCTCU8NrHHa_u28T2IE9AqSfg9WKhk
Message-ID: <CAL3q7H4nO6TB66RhrrrC94GSrjLOb1tOQ1xPJqmZs=m82gX73g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: make sure no dirty metadata write is submitted
 after btrfs_stop_all_workers()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:37=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/10/24 18:37, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Oct 23, 2025 at 9:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/10/24 01:56, Filipe Manana =E5=86=99=E9=81=93:
> >>> On Thu, Oct 23, 2025 at 10:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wro=
te:
> >> [...]
> >>> So two suggestions:
> >>>
> >>> 1) Move this into btrfs_error_commit_super(), to have all code relate=
d
> >>> to fs in error state in one single place.
> >>>
> >>> 2) Instead of of calling filemap_write_and_wait(), make this simpler
> >>> by doing the iput() of the btree inode right before calling
> >>> btrfs_stop_all_workers() and removing the call to
> >>> invalidate_inode_pages2() which is irrelevant since the final iput()
> >>> removes everything from the page cache except dirty pages (but the
> >>> iput() already triggered writeback of them).
> >>>
> >>> In fact for this scenario the call to invalidate_inode_pages2() must
> >>> be returning -EBUSY due to the dirty pages, but we have always ignore=
d
> >>> its return value.
> >>>
> >>>   From a quick glance, it seems to me that suggestion 2 should work.
> >>
> >> Yes, that's the original workaround I went with, the problem is we're
> >> still submitting metadata writes after a trans abort.
> >>
> >> I don't feel that comfort writing back metadata in that situation.
> >> Maybe the trans abort is triggered because a corrupted extent/free spa=
ce
> >> tree which allows us to allocate new tree blocks where we shouldn't
> >> (aka, metadata COW is already broken).
> >
> > Metadata COW is broken why??
>
> Consider this situation, no free space cache, and extent tree by somehow
> lacks the backref item for tree block A.

If there's no backref in the extent tree and no delayed ref for tree
block A then we already have a corrupted fs.

>
> Then a new transaction is started, allocator choose the bytenr of tree
> block A for a new tree block B.
>
> At this stage, tree block B will overwrite tree block A, but no
> writeback yet. And at this time transaction is not yet aborted.
>
> Then by somehoe the tree block A got its reference dropped by one (e.g.
> subvolume deletion), but extent tree is corrupted and failed to find the
> backref item, and transaction is aborted.
>
> >
> > Even after a transaction aborts, it's ok, but pointless, to allocate
> > extents and trigger writeback for them.
>
> Writeback can be triggered by a lot of other reasons, e.g. memory
> pressure, and in that case if we try to writeback tree block B, it will
> overwrite tree block A even if it's after transaction abort.

It doesn't matter why and when the writeback is triggered, that was
not my point.
My point was if a transaction was aborted, what matters is that we
can't commit that transaction or start a new one, and can't override
existing extents (either they are used or pinned).

>
> Not to mention the final iput() in close_ctree().

By the time of the final iput() we are not supposed to have dirty
metadata, we have already committed any open transaction.
The exception was here for transaction abort case, but other than the
use-after-free, it can't cause any damage to the fs.

>
> Thanks,
> Qu
> > As long as we don't allow the transaction to be committed and new
> > transactions to be started, we are safe - in fact that's the only
> > thing a transaction abort guarantees.
> >
> > We may have many places that could check if a transaction was aborted
> > and avoid extent allocation and writeback, but that's ok, as long as
> > we don't allow transaction commits.
> >
> >>
> >> Thus I consider delaying btrfs_stop_all_workers() until iput() is only=
 a
> >> workaround, it still allows us to submit unnecessary writes.
> >>
> >> I'd prefer the solution 1) in this case, still with the extra handling
> >> in write_one_eb().
> >>
> >> Thanks for the review and suggestion, will follow the advice of the
> >> remaining part.
> >>
> >> Thanks,
> >> Qu
> >>
> >
>

