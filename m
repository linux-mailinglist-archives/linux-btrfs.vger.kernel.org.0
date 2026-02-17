Return-Path: <linux-btrfs+bounces-21703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKcnBuVMlGkNCQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21703-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:11:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24D14B32F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FEF1302D0A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C97330321;
	Tue, 17 Feb 2026 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2dbiMmt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F031A800
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326677; cv=none; b=KR2oFQYwadzU35amv60xQ2BGWdTz6AmKgJ/LiiQFO0g38GzrEuksj8gn2w5uLFEkp0PkxSC5OB1LzQaVSfOrLtNSDb1s7ybTpc2gwHuR6FmWLjzXdbuA48EwviJQIMttL0WbhnoFaVyTVWpERpD/6msrR3At4xDD7SYoxDYdNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326677; c=relaxed/simple;
	bh=yWR+xc00re0zA7H/U/EsSLTwzbwEGDLPbWtbUj7/IOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huXda1P5cdA+fkk/Dha6RGBBnpJnABCujHA7YLaQ1+aJkQgDoM1Er2Y+vKU/cqtu4jzgt92NSJY+DIqUagRcB6qTaZ/F+MQyRusJJ5ff497avqclvGki46a2PTinZwqKn2sMPVkJ+SSYywxBQfHRJqO6krpHvMaOGzgasWJRX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2dbiMmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0516EC4CEF7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326677;
	bh=yWR+xc00re0zA7H/U/EsSLTwzbwEGDLPbWtbUj7/IOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J2dbiMmtvF4iUwOU/TkgnareneRYKY5NY+r4Y39DekbpTNsAjPVhueB1Q+GeK5ujo
	 4vELtMWFsYPjKSS7gNf7s29mEeKa3ApB1dNjZKO7D8qHDsvedAvvLA/HHDBClk03OJ
	 aZL1UKBuMGoYMtGye/xEHffbUu7V0Cn7U8nID1yAbsxNRlFg2o8j5p3faPlyRWVT/M
	 J6SqHXBRAB1eOUUbbdyK+dOtIQr1e1IZQyw76HxeDdtpfzPF8+FV9KPyhe/pIhygvE
	 RCkIaAgpEGKknMeaVOYlhhEB68B6/6my972NFmG5sOXFRYTNrryRwSTNMrfoIymCl3
	 EqAU766dEQ75Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so681847566b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 03:11:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQmcoYZRDsSQU/Tni2HGsHseDnhEW9qhrTeT0scS+xg26SlxWZZHjfu1ouJPbHJ8iiDFV4EvFV5M9vLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/7RzaZl6wCzXcvj+OgN0+uHvUATGO69jFLgQ9CThNVF/30Bz
	E332IXG9PdxQj75NrWGBI+y4zoP3GNDjAE/aPEvEPS0Ykni8aABKIoW+jquaa929r8NY5xNOIaZ
	P+o3mU+578BSgTAuvCPH2hgwnSUK/9FQ=
X-Received: by 2002:a17:907:1ca2:b0:b87:fc5:40bd with SMTP id
 a640c23a62f3a-b8fb4770f97mr737360766b.65.1771326675606; Tue, 17 Feb 2026
 03:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216211215.4149234-1-mssola@mssola.com>
In-Reply-To: <20260216211215.4149234-1-mssola@mssola.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Feb 2026 11:10:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7kyo5hEEhn_RO2=55qyAr_6=duS=VQB79wHwNggf+bcA@mail.gmail.com>
X-Gm-Features: AaiRm51qFHegOuPFFbsN3klDzBGFxA-zXFfAqjdKy4jIWnbhIUj6aSTkBTjt5J8
Message-ID: <CAL3q7H7kyo5hEEhn_RO2=55qyAr_6=duS=VQB79wHwNggf+bcA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: free pages on error on 'btrfs_uring_read_extent'
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21703-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8D24D14B32F
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 9:13=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <mssol=
a@mssola.com> wrote:
>

As for the subject, should be instead:

btrfs: free pages on error in btrfs_read_uring_extent()

Note we don't usually surround function names with quotes and we
usually add the () after their name.

> In this function the 'pages' object is never freed in the hopes that is

that is -> that it is

> picked up by btrfs_uring_read_finished() whenever that executes in the
> future. But that's just the happy path. Along the way previous
> allocations might have gone wrong, or we might not get -EIOCBQUEUED from
> btrfs_encoded_read_regular_fill_pages(). In all these cases, we go to a
> cleanup section that frees all memory allocated by this function without
> assuming any deferred execution, and this also needs to happen for the
> 'pages' allocation.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>

Not contrary to what you had just suggested for a cleanup patch here:
https://lore.kernel.org/linux-btrfs/87tsvfu11i.fsf@/

This is the sort of change that should have a Fixes tag, because it
fixes a bug, something that affects users, therefore useful and
important to have backported to stable releases.

So adding a:

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads
(ENCODED_READ ioctl)")

You don't need to do any of these changes, I've done that changes
myself and added it to the github for-next branch, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> ---
>  fs/btrfs/ioctl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 38d93dae71ca..b3e8a8d9b19d 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4651,7 +4651,7 @@ static int btrfs_uring_read_extent(struct kiocb *io=
cb, struct iov_iter *iter,
>  {
>         struct btrfs_inode *inode =3D BTRFS_I(file_inode(iocb->ki_filp));
>         struct extent_io_tree *io_tree =3D &inode->io_tree;
> -       struct page **pages;
> +       struct page **pages =3D NULL;
>         struct btrfs_uring_priv *priv =3D NULL;
>         unsigned long nr_pages;
>         int ret;
> @@ -4709,6 +4709,11 @@ static int btrfs_uring_read_extent(struct kiocb *i=
ocb, struct iov_iter *iter,
>         btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
>         btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>         kfree(priv);
> +       for (int i =3D 0; i < nr_pages; i++) {
> +               if (pages[i])
> +                       __free_page(pages[i]);
> +       }
> +       kfree(pages);
>         return ret;
>  }
>
> --
> 2.53.0
>
>

