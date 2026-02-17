Return-Path: <linux-btrfs+bounces-21702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK3+IzBJlGn0BwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21702-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:55:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 334FC14B08F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C95A305ED2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 10:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD0C32ABCE;
	Tue, 17 Feb 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAYYoxmj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309332BF51
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325633; cv=none; b=Wj1X0wWmAb9mBYlFM+SdpIP8scKJtK9lZU6DSt5GL7TTUIC71xRAbuGnTYjqHRHazN3BGjYauEFiCbmzGpxdNkNDcRa8UmsoM2YPlfd6OjsAuawff2FHwuxxnoe7zkp9x5oM79ogGQPELUchqeuHuQdTLyhglCNk7nv66JjTuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325633; c=relaxed/simple;
	bh=4UBTG9oMeaPmJ2t2B+hU3Sb3xkvvjYvkvZQf+srwZpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doXz/Z0UcG/z1eF1wofOiRWYWsPpq29oXtQQwhLR++qeD4ze7I+6pazwG+5ugLTcYl30wHeZT7GOfhYKzy4OL7+5yLWvUqC//oO+6LNRzCuWUE18c1XolG8GkI4T1vA768m+rvov/cJb/NITBXXaViojlCg6YFZ/HOmtaYq2+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAYYoxmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5213C4CEF7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 10:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325632;
	bh=4UBTG9oMeaPmJ2t2B+hU3Sb3xkvvjYvkvZQf+srwZpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fAYYoxmj81pYDttH1sKvF3dn6iPyxJyOT2H1yx7khbjQCtIIlSrl066Pzp41630LW
	 IE5bO0AKZ465y9d9jLgzfQnoCDqKiFtdQ0lJZ5cQPOWtW4QOwsImLIjWmmZa8vbnLu
	 1GKQBL9dh5WZYh/G4hrAht2QWudabYep+SQCBxxsPih4dqRC/m97U0Xw8xaukZ5l6y
	 Zg8EKlU3lZ0cFJ+dLk6Uil03D7v2Sl7eo1xPF/C/7v1K2OG/KbZm1lOWBgNPb97g8y
	 NCbv2zklZlLycvn9THrwFAy7/FEt+n9Z3/oe74lD2EaSx9G2GBxxNfPT1HvJCCOM/k
	 tiVwIjYfJX6MA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b885a18f620so76622666b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 02:53:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6GWQn50Fg+tJbk1egeC215IFAeJgREa5TobBxk3weeNnIOSbMX4nyFrzc3o59gW0MOTjBArtjDoHdXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8RNsRRuRBa0jKIbxCZAXXNHT9wDmAUYaBQq7f1G5M9F6e2i+
	553bsPLRjMNcbnWEcZDw5BiyWLH7nxqyF29mZSPQ6ocKuD0CW+CoE+WlrAMmzFlEVd3l1d4oaIs
	MEZfMk6LL8Sl19iJSYik0M8+j1WRVxX4=
X-Received: by 2002:a17:907:6d1c:b0:b8e:a179:aa59 with SMTP id
 a640c23a62f3a-b8face90a5emr842950766b.56.1771325631285; Tue, 17 Feb 2026
 02:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f1d7281b3004c6baa24a531b409c466@orionsoft.ru> <6994405b.170a0220.24287.89ffSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6994405b.170a0220.24287.89ffSMTPIN_ADDED_BROKEN@mx.google.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Feb 2026 10:53:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7x3ZRYXBkMjyA1UihWr8FUz4NQE1nR+thc9Q3g7rwd3w@mail.gmail.com>
X-Gm-Features: AaiRm52HAbuy0euylV193YpHYx8uv7EU8iEarA3PQNEf_3Beby88SzcWlLLF8_M
Message-ID: <CAL3q7H7x3ZRYXBkMjyA1UihWr8FUz4NQE1nR+thc9Q3g7rwd3w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove dead assignment to dirid in btrfs_search_path_in_tree()
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: Burenchev Evgenii <EBurenchev@orionsoft.ru>, "clm@fb.com" <clm@fb.com>, 
	"dsterba@suse.com" <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21702-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 334FC14B08F
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:18=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <msso=
la@mssola.com> wrote:
>
> Hello,
>
> Burenchev Evgenii @ 2026-02-16 16:16 GMT:
>
> > From ff2df73ba6483b0dc67b3ed89d2a43c49f1c2eb8 Mon Sep 17 00:00:00 2001
> > From: Evgenii Burenchev <eburenchev@orionsoft.ru>
> > Date: Mon, 16 Feb 2026 18:39:30 +0300
> > Subject: [PATCH] btrfs: remove dead assignment to dirid in
> >  btrfs_search_path_in_tree()
> >
> > After the introduction of btrfs_search_backwards(), the directory
> > traversal state in btrfs_search_path_in_tree() is fully maintained via
> > struct btrfs_key. The local variable 'dirid' is no longer used to contr=
ol
> > the search and the assignment
> >
> >     dirid =3D key.objectid;
> >
> > has no observable effect and is dead code.
> >
> > Remove the unused assignment to avoid confusion and silence static
> > analysis warnings.
> >
> > No functional change.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Signed-off-by: Evgenii Burenchev <eburenchev@orionsoft.ru>
> > ---
> >  fs/btrfs/ioctl.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index a6cc2d3b414c..292043b11207 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -1708,7 +1708,6 @@ static noinline int btrfs_search_path_in_tree(str=
uct btrfs_fs_info *info,
> >               btrfs_release_path(path);
> >               key.objectid =3D key.offset;
> >               key.offset =3D (u64)-1;
> > -             dirid =3D key.objectid;
> >       }
> >       memmove(name, ptr, total_len);
> >       name[total_len] =3D '\0';
>
> I would add a Fixes tag with the commit that made this assignment
> useless.

No. We add Fixes tags for patches we want to backport to stable
releases, things that fix a problem affecting users, like functional
bugs or performance regressions for example.
For cleanups, removing unnecessary code, we don't want a Fixes tag, as
that will trigger unnecessary backport overhead.

> As far as I can tell this is commit 98d377a0894e ("Btrfs: don't
> miss inode ref items in BTRFS_IOC_INO_LOOKUP"), which made the update
> inside of the loop of 'dirid' no longer needed. This way it's easier to
> track from where this was no longer needed and whether that's really the
> case.
>
> Other than that, and taking a quick look at this function, I can already
> tell that the 'ret' variable could be initialized to 0 in the beginning
> and make the last assignment to it (just before the "out" label) not
> needed. Hence, while we are at it, could you also remove that
> assignment?
>
> Cheers,
> Miquel

