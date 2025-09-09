Return-Path: <linux-btrfs+bounces-16757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE281B4FFBC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC553B899B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E734DCFD;
	Tue,  9 Sep 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+kw861c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672E1A9F97
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428984; cv=none; b=DmKuNXFgw2MsGc0mNnu4/oyC82xBm2D2fPzCcZ6ZRMP7Yr2oT+hgm0sFjJcHw3sYXsgvNQn/I+3pGKvZnvaGr4DDEBnUR4lfcy8HIpc0Yi39Z4iVvAlaOMUE31PXAqS3Db8iAtyx/1gJB03ZLdFntsWBWPqNcBJvwVqoH9ZcK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428984; c=relaxed/simple;
	bh=cPs360OsbjuO5/dhvRXLHVZyUu877J34ePC4N+qQfKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSuZ6kHXeX+Ax8w8M16NsIJ6iO3IHpamTZo4emPyt7JsMcX+d30hdt2OeFzjsAbqHJCRjVmYPKIsRoT0Zd0SDvEQ9JhGmV4iE2dnIlKGm2cNTqIGvU8k2bhteqSxzz9e/nUxcAlEfCjzB+HzvPOJuVZT6klkFYJlqGt2xtjWJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+kw861c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE4FC4CEF4
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428983;
	bh=cPs360OsbjuO5/dhvRXLHVZyUu877J34ePC4N+qQfKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u+kw861c+3NrEcFw/9VxAu2/OA37/FKJWpWIp9DV2TD/XafXbFKnUbJy1tSkvWEUz
	 PKlAioM82z4UFJSTVNp1YR0ihAr6+41gf4Wvx3xkKZXzPmY7fe93P8nnB/SJpY5KSe
	 nRiyT5I+5n1NPd7zGWNWqSH0aLj1naEZzEWrSuuvwwmEoeQImQX15gbRejVukTi77l
	 TQVpwWIVrR1ziKdAdni9cX+Eg6JbrQyMHd8HMZKMVoI//WluII1fEPVTWmzooDV6R4
	 53FqqQhzW8jQo89HwicN9usYJI9WPLNkKwRyqnz2lEbgp0gaSnPjrgDJ5tLVktPDjs
	 0W1Rk1oNjpEJA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0475ce7f41so987629966b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 07:43:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YzhG9dvOBvvirz/sy6rtaMc6zqOi84FPdQLa8REUXyHDjZQFgPY
	aXLDzLgagdsKph7Sqr2sI6iyA8N7C6EhcHOgnkQnZN9QkAp1gIslZpV6RNxe6WrDo7ZVuGTRikf
	OZqiZ1dQcW2f7GUxnVe3tJ6Vo8tTzalg=
X-Google-Smtp-Source: AGHT+IH3QScsWe8cjJxgJ2p6XRosAUdfkk7F6qQaZh8QaPMGHbkSbYGLwEn5lRu8L8Jj5DN3CeIXlvQZ+6nyfdaU0Mg=
X-Received: by 2002:a17:907:9494:b0:b04:57e7:911b with SMTP id
 a640c23a62f3a-b04b16dda17mr1089735966b.61.1757428982402; Tue, 09 Sep 2025
 07:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757271913.git.fdmanana@suse.com> <27429afe0fe9e2a7ebd06d888a3470e0c65fb8ed.1757271913.git.fdmanana@suse.com>
 <20250909005327.GU5333@twin.jikos.cz>
In-Reply-To: <20250909005327.GU5333@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 9 Sep 2025 15:42:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H60OLae+o34tKpC6XW5E2-rdChVQ8AYtq1dPsem4OdKzg@mail.gmail.com>
X-Gm-Features: Ac12FXyqpsmJIKz1ISbPEXH9mvSS3ygjywNcV1bQshR9OvKpqTZUA5-iwa8qFVI
Message-ID: <CAL3q7H60OLae+o34tKpC6XW5E2-rdChVQ8AYtq1dPsem4OdKzg@mail.gmail.com>
Subject: Re: [PATCH v2 33/33] btrfs: dump detailed info and specific messages
 on log replay failures
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:53=E2=80=AFAM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Sep 08, 2025 at 10:53:27AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently debugging log replay f
> > 1) Dump the current leaf of the log tree being processed and print the
> >    slot we are currently at and the key at that slot;
> >
> > 2) Dump the current subvolume tree leaf if we have any;
> >
> > 3) Print the current stage of log replay;
> >
> > 4) Print the id of the subvolume root associated with the log tree we
> >    are currently processing (as we can have multiple);
> >
> > 5) Print some error message to mention what we were trying to do when w=
e
> >    got an error.
> >
> > Replace all transaction abort calls (btrfs_abort_transaction()) with th=
e
> > new helper btrfs_abort_log_replay(), which besides dumping all that ext=
ra
> > information, it also aborts the current transaction.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/fs.h       |   2 +
> >  fs/btrfs/tree-log.c | 432 +++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 348 insertions(+), 86 deletions(-)
> >
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index 5f0b185a7f21..28bb52bc33f1 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -104,6 +104,8 @@ enum {
> >       BTRFS_FS_STATE_RO,
> >       /* Track if a transaction abort has been reported on this filesys=
tem */
> >       BTRFS_FS_STATE_TRANS_ABORTED,
> > +     /* Track if log replay has failed. */
> > +     BTRFS_FS_STATE_LOG_REPLAY_ABORTED,
>
> As the series improves error handling and debugging output, it may be
> also useful to add the state BTRFS_FS_STATE_LOG_REPLAY_ABORTED to the
> table messages.c:fs_state_chars. The log cleanup error is there (L).
>
> When the log replay is aborted the normal transaction abort won't set
> the bit so the reason wouldn't be visible in the message headers.
>
> (This is on top of the patchset, no need to update it or reset.)

I've updated messages.c to add:

[BTRFS_FS_STATE_LOG_REPLAY_ABORTED] =3D 'O',

And pushed to for-next, thanks.

