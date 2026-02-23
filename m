Return-Path: <linux-btrfs+bounces-21838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFVVFXJOnGktDwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21838-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:56:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB51767B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4B6304EA44
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B730366074;
	Mon, 23 Feb 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeUfFBEc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615B36680D
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851365; cv=none; b=HhjyIEV4JQCd7PEmTZeHbQ7GceFN5KVvptBBd5vO7hnpCCVsvs2tNk/4wX4/gtXtt8RFJxE2N9WYTbVKZgx3pjjnKkI3q+anZcTHFTksTFd+WQSBb8zWik0uBFUq//nbb3L2vvmC1IY/c9MvHPZqcO492IYMYWNZYarSY74qqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851365; c=relaxed/simple;
	bh=+QJ+29cYpKDBTGhke953el0KTW3O9MufJxpvPVPo4H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZa9IzMuijseJUWun4SNaU72k8rAAXJWR4Grw/xwVdjAOroQYunFS6SqhHmeeuQ8nItnc8LxvzJKbYSMmg8/qRPDdagF6yZ5aK/YVq+PTLTmNY3i3Cozl8e9JF620R3W42emlwRxWHwl1WxoYTtSX+WSYTZnOUlT9bR4bpqi1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeUfFBEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BE8C2BC86
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771851365;
	bh=+QJ+29cYpKDBTGhke953el0KTW3O9MufJxpvPVPo4H8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XeUfFBEc7MiPVgxh2MIGT3ytLWNtjacG9MJiYJTH9GLPytx0O0IraAQU3XVBER6h5
	 w0hRagdI1uHhGUfXzLRse6zgd5rXOJJ44Es2xUdIYSqG6jR3U3rRWqee76u0acwkK0
	 v21gzM6JfTtFniud5+8RH03jO1nmjwYuo9LZ0cWYwXul5vyRWYC2QgSiT57knprToh
	 T6TWZ5LCF1WdVENnNCkKnf18BZenlDr9aJ8IABXAzw+GbSQlaL2b0A1xim5fN4FtYP
	 lztSHqnyHNBWNTupWB4LhRk/q4EYSkG7o0w8t3NYLIWMK0MISQEIXu+yj+DTbk3lpf
	 Z/091coljNs1g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65c5a7785b4so6441200a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 04:56:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzsEmMZpoUaPbMybWQEVZsr267laKDBrYKuKIfw2z2v5rUrHhJJPiJWuSPt5xepcM43TE5zJSzFuGacQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+nXqjEm1IMLK9Pac8/M2GWT6/1zQtq1xwbxpwUyfFejhYGk7
	5thQc2oeHQIp4fy7lJKslYMD0Yhse1vX0SZrVPwcT7ZUA1C+5K8lIQNGd4lzySCZMx0+AaoaU8G
	nG3uOVsrrtjPkgd50xd7wXRmTEftH4sg=
X-Received: by 2002:a17:906:7307:b0:b8f:a68a:e85d with SMTP id
 a640c23a62f3a-b90819c0975mr597352466b.23.1771851363740; Mon, 23 Feb 2026
 04:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222124758.953175-1-a.velichayshiy@ispras.ru>
In-Reply-To: <20260222124758.953175-1-a.velichayshiy@ispras.ru>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Feb 2026 12:55:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4LhJ3zTZUwvmuFTY8DqBqPHfTO1CRtFiwJDAUMpaYT_w@mail.gmail.com>
X-Gm-Features: AaiRm52dH-lcOiOO7HxLe7_TUnusCfUezsp-LomT-lrhA_9VPxpeV4bmeX1NcSg
Message-ID: <CAL3q7H4LhJ3zTZUwvmuFTY8DqBqPHfTO1CRtFiwJDAUMpaYT_w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Remove redundant nowait check in lock_extent_direct
To: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21838-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: C5FB51767B2
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 12:48=E2=80=AFPM Alexey Velichayshiy
<a.velichayshiy@ispras.ru> wrote:
>
> The nowait flag is always false in this context, making the conditional
> check unnecessary. Simplify the code by directly assigning -ENOTBLK.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Pushed into the for-next branch [1] with minor changes to the subject
(uncapitalize first word and add () to function name).

[1] https://github.com/btrfs/linux/commits/for-next/

> ---
>  fs/btrfs/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 07e19e88ba4b..72a229c44833 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -107,7 +107,7 @@ static int lock_extent_direct(struct inode *inode, u6=
4 lockstart, u64 lockend,
>                             test_bit(BTRFS_ORDERED_DIRECT, &ordered->flag=
s))
>                                 btrfs_start_ordered_extent(ordered);
>                         else
> -                               ret =3D nowait ? -EAGAIN : -ENOTBLK;
> +                               ret =3D -ENOTBLK;
>                         btrfs_put_ordered_extent(ordered);
>                 } else {
>                         /*
> --
> 2.43.0
>
>

