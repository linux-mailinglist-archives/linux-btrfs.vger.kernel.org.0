Return-Path: <linux-btrfs+bounces-17744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BABD6A6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 00:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E2618A59B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4722FE057;
	Mon, 13 Oct 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJC8dSB2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F182BE638
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395323; cv=none; b=WMJO/RcJVrb07CHKCy9H8AbSoiNVvgF5NHE9ujW/J5Xd+aC3hN/LpLnGUZGHvfAdhpUB9N4Xt8r/aR++JGLFOBV72z3ZRAtCkqq3L4TiY8Nqaquq1CszkN1mYzfQF263FMnxT/F+Ohd4vJD9SWqgZ1SjHwwifnPuEIfNpWFKWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395323; c=relaxed/simple;
	bh=WOCMLbSHSA2PZ/ABT4wCIagAZaSRwiosa2qE0eJ2W6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7IvNY3nY7dlT/gtXVXlpyNGC5fvUGuqT4bMExcRkfeGQnNTxCfE6xhrP+AC9sYwRWAduTgeOYPi8R5Gc6wywqI+ZmjNeDhAwB3QcW3aWOwZvVhLPBnMBIHFViuW6Ry87bxsi2yQTrvoxrCAqBT/RmTXKiioQuouOLUrwD0uP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJC8dSB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB73CC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395323;
	bh=WOCMLbSHSA2PZ/ABT4wCIagAZaSRwiosa2qE0eJ2W6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AJC8dSB2lgILhtDzMfLtd5OZWOGulFffzUX8aJ3U+yGquMgH+8nC4+ccvVxOEyolm
	 msgGDpLhzwKlydQ+mK02tHZTTl2c+5jn+Kt0Ms4IxjwNIYZQxWopGpOcjy71RRvziA
	 cne7r7guzgQhL21urHSVRO/7KbJ/DdrfXlLsRkJMr+BnxLYawoitL7fr/50mHzAhTM
	 NKigAPfVYsSfDgMY3teOhgfwUk/hZBjI8kMiglZm2pcjb8tkX1x3TmCycE6zDTASJC
	 HRy2gV4L0cJtmD5a2Zh92SPglQMZddk1gyaNJYIQdBZ32Yq+yvt5FW0SNqmrL9cZUp
	 uY05JMq8b8jiw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso7070863a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 15:42:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxldGXczXbeIN8VS5fQpOk+R2ff+xS66AsJNB0LRTXsvCJhhC2U
	gG17s1in6hdg5rwJMlNRGFFeCB0eSqMyso/b+1KfH9b5O31ppFIQ/pLb2Zo7LQ0RQxBITwhYm7W
	VIAPyl8Ns/ZbwhX2EoDX+3KFm4+zcYFs=
X-Google-Smtp-Source: AGHT+IENgiiAUPtoIApiTTNeBqFWJcz+b3ROROVFJQwHzuCNgzlt+/eZxYVlEjYQ4glrHM+QnWhukMIPW/E3a7UoOYo=
X-Received: by 2002:a17:907:1b12:b0:b41:e675:95e3 with SMTP id
 a640c23a62f3a-b50aa9a1c71mr2369623066b.16.1760395321521; Mon, 13 Oct 2025
 15:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760356778.git.fdmanana@suse.com> <622ef5ee-f94e-4c2e-8d70-8af73021146e@gmx.com>
In-Reply-To: <622ef5ee-f94e-4c2e-8d70-8af73021146e@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 Oct 2025 23:41:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4gALu1NYyGVLa3yxtH-5-FbGRxO0DPT2gesqJuOJk9Lw@mail.gmail.com>
X-Gm-Features: AS18NWBfVR4H4Ep9U79PVzMUYsJ5oqIagVASiHOF3fhYiP3Q03TWVjMyVBn-00s
Message-ID: <CAL3q7H4gALu1NYyGVLa3yxtH-5-FbGRxO0DPT2gesqJuOJk9Lw@mail.gmail.com>
Subject: Re: [PATCH 0/7] btrfs: fix a bug with truncation and writeback and cleanups
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:01=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The first patch fixes a bug where we can up persisting a file extent it=
em
> > that crosses the i_size boundary, making btrfs check complain because i=
t
> > won't find checksum items beyond the i_size boundary. Details in the ch=
ange
> > log. The rest are several cleanups in related code that popped up while
> > debugging the issue.
>
> The series looks good to me.
>
> Just notice one small inconsistency during review and it's not related
> to the series itself.
>
>
> Most callsites searching ordered extents are holding ordered_tree_lock
> with irq spinlock.
>
> However in btrfs_split_ordered_extent() there is a non-irq version
> spinlock of ordered_tree_lock.

Yes, and it's correct as it is.

Right before taking ordered_tree_lock, with a regular spin_lock(), we
take root->ordered_extent_lock with spin_lock_irq(), which disables
irqs.
That means the critical section of ordered_extent_lock can not be
interrupted to serve interrupts.

So everything's fine there.



>
> Looks like an inconsistency at least.
>
> Thanks,
> Qu
>
> >
> > Filipe Manana (7):
> >    btrfs: truncate ordered extent when skipping writeback past i_size
> >    btrfs: use variable for end offset in extent_writepage_io()
> >    btrfs: split assertion into two in extent_writepage_io()
> >    btrfs: add unlikely to unexpected error case in extent_writepages()
> >    btrfs: consistently round up or down i_size in btrfs_truncate()
> >    btrfs: avoid multiple i_size rounding in btrfs_truncate()
> >    btrfs: avoid repeated computations in btrfs_mark_ordered_io_finished=
()
> >
> >   fs/btrfs/extent_io.c    | 33 ++++++++++++++++++++++++++-------
> >   fs/btrfs/inode.c        | 18 ++++++++----------
> >   fs/btrfs/ordered-data.c | 23 +++++++++++------------
> >   3 files changed, 45 insertions(+), 29 deletions(-)
> >
>

