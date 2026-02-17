Return-Path: <linux-btrfs+bounces-21700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPCPCF1AlGlhBQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21700-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:18:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B914AC3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24F0302A2EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41526D4DF;
	Tue, 17 Feb 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="x6JC+NwQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4018DF9D;
	Tue, 17 Feb 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323470; cv=none; b=uUK82Ze8gkW8+3jIkkhAvs7evm8N/dP1jhNayzIZlY+f8XNOUkHOB2Ukr1uobljzdLyki9142w3smxKOIkNZ9GUcAHsAimS5O3bdM9GMigRv2o9IEbA5LPzW7KTpQuUyzp8YMR8RPLuFIor43kYuOy4mQyNk1jNPpk+0zFZi+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323470; c=relaxed/simple;
	bh=uj+2QvEGo4AMYohdbIGdG+3ZjDhopoAv2aLXYdOLc7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ud6m8nzhhS0F22kcv73mn2fkDZZp2woEOHuP/O4Np3m4sxOrZlb/rWL1HQWz5v8z60hAe0JmsIoqf5HLmAV0EcCGCu63tEsxqFJn104J4spUTxblUEKeOuV6JKUK1pazyEzolOBmDC6A+FxIgXmDpJ2xOP8Av8InqsryXD9wde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=x6JC+NwQ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fFbDb6JcWz9thw;
	Tue, 17 Feb 2026 11:17:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771323455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMbDPyJBydbO/iYnr7vptdH/rbD4W8n4V0X65na9q5Y=;
	b=x6JC+NwQGuYJ6n8GoKbNZAdkgaLWCSzAJsmpb4VnEgdSsR6NSuvkGTqwzEEUgdzaSbnT3N
	BSlsiUBYzyt7bkSfNFG6/XmDjdgDb7lKNZJ135Ay8yLyd+sraARA//NlginrYVdBfrwlWF
	v+PcWMDcxGispCzuzIM7EW2Af9AU25TNqChwi4DkzB0EEYqy5tg5xqR5j1XcFq2qLkEGXw
	0cXjMy8VNfEfSXEReE+HadGniAhJVYdB7dWEaTjDmT6QfNBN5hGfcmtLJ11gCbnJe/dOPn
	hS1b81IyAgqndWNDgza9OzHO6mryHkODIkDai+y74NTlPi5Yo9ytrG7c6CKu7g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::202 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Burenchev Evgenii <EBurenchev@orionsoft.ru>
Cc: "clm@fb.com" <clm@fb.com>,  "dsterba@suse.com" <dsterba@suse.com>,
  "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] btrfs: remove dead assignment to dirid in
 btrfs_search_path_in_tree()
In-Reply-To: <3f1d7281b3004c6baa24a531b409c466@orionsoft.ru> (Burenchev
	Evgenii's message of "Mon, 16 Feb 2026 16:16:53 +0000")
References: <3f1d7281b3004c6baa24a531b409c466@orionsoft.ru>
Date: Tue, 17 Feb 2026 11:17:29 +0100
Message-ID: <87tsvfu11i.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.85 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-21700-lists,linux-btrfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mssola.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B48B914AC3E
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain

Hello,

Burenchev Evgenii @ 2026-02-16 16:16 GMT:

> From ff2df73ba6483b0dc67b3ed89d2a43c49f1c2eb8 Mon Sep 17 00:00:00 2001
> From: Evgenii Burenchev <eburenchev@orionsoft.ru>
> Date: Mon, 16 Feb 2026 18:39:30 +0300
> Subject: [PATCH] btrfs: remove dead assignment to dirid in
>  btrfs_search_path_in_tree()
>
> After the introduction of btrfs_search_backwards(), the directory
> traversal state in btrfs_search_path_in_tree() is fully maintained via
> struct btrfs_key. The local variable 'dirid' is no longer used to control
> the search and the assignment
>
>     dirid = key.objectid;
>
> has no observable effect and is dead code.
>
> Remove the unused assignment to avoid confusion and silence static
> analysis warnings.
>
> No functional change.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Evgenii Burenchev <eburenchev@orionsoft.ru>
> ---
>  fs/btrfs/ioctl.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a6cc2d3b414c..292043b11207 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1708,7 +1708,6 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
>  		btrfs_release_path(path);
>  		key.objectid = key.offset;
>  		key.offset = (u64)-1;
> -		dirid = key.objectid;
>  	}
>  	memmove(name, ptr, total_len);
>  	name[total_len] = '\0';

I would add a Fixes tag with the commit that made this assignment
useless. As far as I can tell this is commit 98d377a0894e ("Btrfs: don't
miss inode ref items in BTRFS_IOC_INO_LOOKUP"), which made the update
inside of the loop of 'dirid' no longer needed. This way it's easier to
track from where this was no longer needed and whether that's really the
case.

Other than that, and taking a quick look at this function, I can already
tell that the 'ret' variable could be initialized to 0 in the beginning
and make the last assignment to it (just before the "out" label) not
needed. Hence, while we are at it, could you also remove that
assignment?

Cheers,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmUQDkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZR6qD/wL62PFY6q7Lh44c0ewce5QIvpLL079v+pq1SBxYjTlfWcubRfizakCHQE9
0xW9K9t7ysvUOW+QB+ZptVQS9M+zScDqO3+j6iC8r1mhViL2cgoVZl5bQ0aPbTde
cx0CFZr9ZNqJBdYio+nYYVVgsnP5PRsE4w+rIEKxj2dWmP0rUZcdsmgxZHJeI0Mt
5Lc6s0e7s6IHrizFGZXcDaNqqWczt/YIoTVetDbafhPrmELBEjAuM5pt11k9NyAf
SL9r2Jj6/o5vvD8t1yBAc8ZtLTtZMsxtAO356kNywE7pwcsQ2TGqNsJ9MT7CQUOT
Tfkj+iXPia4gUVk9VZ6fKz90LbtwVFH2fDiAG6qzPJQ5Tqq0sYcpbbaKgsIpXrsk
kX/tUAYbL7SYQKtyWsA90fjCz8pkwQsbNxiioes3bClCUUWM7DPn2dJgRSUrg2m8
Y8vX7qXzjfllVDkZdfn9svW+xwuDwhggjWo79GPM3DX7NrtPvinDq3J9G3aS4aCF
2yKu83tElKaKjC0Q6WgO8ZsSFhzrNhmwT+WbpBXAnVt1WWZzQMJNAfC1xdmTNaoi
qjIGJkhvowoaWlq6zOUFALfHTxzj91Hehq4IIiw8fzPZVLymeKjhtuYtgbulji9K
ehOmDIa0H3nJ4l5RsPL7cy5dTLZVJFb07jNfhpGjalWrzZNRuQ==
=J7I3
-----END PGP SIGNATURE-----
--=-=-=--

