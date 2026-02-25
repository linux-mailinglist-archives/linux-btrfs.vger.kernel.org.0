Return-Path: <linux-btrfs+bounces-21927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qII4FdcUn2nmYwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21927-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 16:27:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37A199954
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97367301CC7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F503B530F;
	Wed, 25 Feb 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiUyVgOb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9713161BF
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032705; cv=none; b=hZyNiwM+FZTos3aqH+BvAl6q5Ia5vqTZMKjQNeEu7lEJWYIoiF1UvJ4JLz05llxI880mVHmlorrUsebpBMrdzy36zBPzjUhy8B8ox3aQ6O23JzUWEymeRY0UzLi9WW/V4TIjTm/AZTvF9VoiciQv+IvBrFlFQ1k3cSqAK8InFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032705; c=relaxed/simple;
	bh=1OF7Ohqb6rr4bsPuQNP7DqgMFHohTRP95Kj2yYpLq3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9S+sMke3xI1AB9512fxMhQZZ8r/YN8DAUGA1MPDEhB81ebjF9MUMrQxwpYSIDXTTfIleZ+G0hPGt2yMvYR3lVczC4u54oeS111JdGFy4JJN5EUw5gjKwpGRCAzRSBvTLDnMZnBvdgu1df/wtngfb/0385XwqDz70gf5NbYCI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiUyVgOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37A3C19425
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772032704;
	bh=1OF7Ohqb6rr4bsPuQNP7DqgMFHohTRP95Kj2yYpLq3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oiUyVgOb+qOsCZhbNzRpJMb/y3boZFuPBuNycc1QkBA8H/bwjJqFC7AidBlrxLBsE
	 tm0ZxQALWWAG1YqPOuHdt5uf/rZ9PPYMU6t55qiH+kcUpfMU6PKRZKlCOJ09nDMf1g
	 Xyn/OVnaRoyzL4TCKXDKFok2S7HSHqba0G5b5+h+1M5WWZXOt5X7wZv1ktMoJuQPgw
	 CM52pj0C1dvzWN4oLwNEy8iKhDwNzYcejjhEjo0Z9Q0cUX/F2Bmf0AGVr0UDU+kap2
	 Pr5xxgJWkYpWXO7zTgxTOI6P5rSgclHBrZsGB5DSbCIhRMIPQQLqrP3nZj3fCzeEYg
	 3JpTyyivWM73A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8fb6ad3243so956115766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 07:18:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDEswUyqY3T7CbtN/XbzkIMbGmRKhOwyCyvArJEJXGj+0WozA0EZkBFg3wXqICNzTIY6WU9CiA1sWzvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSxAVvTeLq68lMOOLNfMUKbKt4lxdEaztCJGKGDmEWvKl02WE
	bb9hSdfFES/c6YloI0AhKGduXzuAny9mtdSy9yEbrrHc2VGhzmg5YJY8s0osyzA991GmJjG4+Ka
	dQYx9cW1DUKDpM9IAHqQWd9rwiadngZA=
X-Received: by 2002:a17:906:3b54:b0:b8f:ae35:cbd3 with SMTP id
 a640c23a62f3a-b9081c0c2aamr748188366b.60.1772032703175; Wed, 25 Feb 2026
 07:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225103535.18430-1-mark@harmstone.com> <20260225150835.GF26902@twin.jikos.cz>
In-Reply-To: <20260225150835.GF26902@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Feb 2026 15:17:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4dT5aXaw7UsNfWNLccme=HcvbsrgCMuXzNZQRxV1mxjQ@mail.gmail.com>
X-Gm-Features: AaiRm50Scu6AQHGTQahpzS5lhzB6j2fYHFW_-YfIINeCUZblmP91bzF4mA6dKNg
Message-ID: <CAL3q7H4dT5aXaw7UsNfWNLccme=HcvbsrgCMuXzNZQRxV1mxjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix potential segfault in balance_remap_chunks()
To: dsterba@suse.cz
Cc: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org, boris@bur.io, 
	Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21927-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,mail.gmail.com:mid,fb.com:email]
X-Rspamd-Queue-Id: 5E37A199954
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 3:10=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Feb 25, 2026 at 10:35:31AM +0000, Mark Harmstone wrote:
> > Fix a potential segfault in balance_remap_chunks(): if we quit early
> > because btrfs_inc_block_group_ro() fails, all the remaining items in th=
e
> > chunks list will still have their bg value set to NULL. It's thus not
> > safe to dereference this pointer without checking first.
> >
> > Link: https://lore.kernel.org/linux-btrfs/20260125120717.1578828-1-clm@=
meta.com/
> > Reported-by: Chris Mason <clm@fb.com>
> > Fixes: 81e5a4551c32 ("btrfs: allow balancing remap tree")
> > Signed-off-by: Mark Harmstone <mark@harmstone.com>
> > ---
> >  fs/btrfs/volumes.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index e15e138c515b..18911cdd2895 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -4288,17 +4288,19 @@ static int balance_remap_chunks(struct btrfs_fs=
_info *fs_info, struct btrfs_path
> >
> >               rci =3D list_first_entry(chunks, struct remap_chunk_info,=
 list);
> >
> > -             spin_lock(&rci->bg->lock);
> > -             is_unused =3D !btrfs_is_block_group_used(rci->bg);
> > -             spin_unlock(&rci->bg->lock);
> > +             if (rci->bg) {
> > +                     spin_lock(&rci->bg->lock);
> > +                     is_unused =3D !btrfs_is_block_group_used(rci->bg)=
;
> > +                     spin_unlock(&rci->bg->lock);
> >
> > -             if (is_unused)
> > -                     btrfs_mark_bg_unused(rci->bg);
>
> Not related to the patch but isn't this pattern inherently racy?
>
> The "used" is read under lock but then btrfs_mark_bg_unused() is outside
> of the lock so the status can change. This can be seen it more places,
> but they seem to be related to the remap tree feature.

It's not a problem since when attempting to delete unused bgs we skip
any if they are actually used.
It's done not just for this type of race but also for the case where
after added to the unused list, it becomes used before the cleaner
kthread runs to delete unused bgs.

>

