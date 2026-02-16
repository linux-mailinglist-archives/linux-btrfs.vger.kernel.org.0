Return-Path: <linux-btrfs+bounces-21682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFDvC50Ck2nF0wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21682-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 12:42:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6FA143119
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 12:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6427D3016525
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A1E3009DE;
	Mon, 16 Feb 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1tnbpPA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4B27055D
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242129; cv=none; b=CfRG2VkuVhfpnt7XVbL9vIekRR4nndmVBtBdY1FKZRlI1MWSaP808xGHRuOQFYGavvHnjx2I6DuVI+AEzQvWgBX0Ff1k8Y1KgbuIF8i5vzIjEmF4EbIRmqji6TO5wYEcpRZ7A0TrF2kjJKUPpdwJHC7ecfxIG0yyNg4QBigZ6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242129; c=relaxed/simple;
	bh=9hXGM8HbOdUBIOFybUfPfYVQaewsRJkOkMaOUlDB7Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThkTSjtTMT7QWTtk24qubwbiHdgcEJsLm6TrQBxH4ZdBfZIRnkxz2ItyYagerHxfms9T6jKLN6ftUL9oqaYZj0Hkx/HD+o2E6BiH0Q6vPKbeXq56Q2jV2lA2A1DUowAmQoeYm+Tc2C6Gdz7roaEOHhDAR79fISZlNACgk4NqNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1tnbpPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF74C19424
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771242129;
	bh=9hXGM8HbOdUBIOFybUfPfYVQaewsRJkOkMaOUlDB7Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h1tnbpPAsr3t/iJwtaCVpLHvRWj7tvRZFNPDkli11fPhNwRp3DflyklDVtdaOhz7U
	 J1kBk2cfJOkXnZLG/9ckBrMNZ+0CIApu/qzzBGT5iJXhnQRvBsX0vBxgGYd2oiUefD
	 DdJq/+GcqEtvl/fLPHEdqK3c0x3EexwymxuSaEgRZQivLiHIwMfmrqAf7srJAYbTup
	 94pKcEOM+gb9RgndteWzrRN8WAggfB0+oGscCSIHoM5G2ktOKyqAXIjSVASczyfIGz
	 ah7B0YaZ/rSCmh77tg68YbeALZLT+ZP2JHzz8YkIogS6diw897SjLrZa3AwitgjKql
	 oRuQ8FsZDxYFw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b885a18f620so390227166b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 03:42:08 -0800 (PST)
X-Gm-Message-State: AOJu0YzAvENCq9yC96VdRGPekIo3MUiieo1F9v7B8oXCAaTW/o1l8ES2
	yHWqHCH5uCcc+IIGbbLjWRAbWFofsQGudxUNdI6RqDUw5fy802w7BYS7ymLNjDmWgzXzvTL1HKu
	+9RDin5Nf9gxp+GMS9x7bbteKcQ9D8BI=
X-Received: by 2002:a17:907:747:b0:b8d:c69c:bd5d with SMTP id
 a640c23a62f3a-b8facd3e5e1mr579572166b.29.1771242127562; Mon, 16 Feb 2026
 03:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1f0953814413fbcace1d625ce1227b9aa2d7c0a.1771211471.git.wqu@suse.com>
In-Reply-To: <d1f0953814413fbcace1d625ce1227b9aa2d7c0a.1771211471.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Feb 2026 11:41:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7HUfej7oqtMgjQBd-XP2HMetGxJ_UgVC7V9mtS+W+PYA@mail.gmail.com>
X-Gm-Features: AaiRm50aksMHfSSjmKfUEmODxv1B9W6PDDlnDEyQUGgCJJTWxp3zAIctxUWXJqE
Message-ID: <CAL3q7H7HUfej7oqtMgjQBd-XP2HMetGxJ_UgVC7V9mtS+W+PYA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not mark inode incompressible after inline
 attempt failed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-21682-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CB6FA143119
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:19=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> The following sequence will set the file with nocompress flag:
>
>   # mkfs.btrfs -f $dev
>   # mount $dev $mnt -o max_inline=3D4,compress
>   # xfs_io -f -c "pwrite 0 2k" -c sync $mnt/foobar
>
> The resulted inode will have NOCOMPRESS flag, even if the content itself

resulted -> resulting

> (all 0xcd) can still be compressed very well:
>
>         item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
>                 generation 9 transid 10 size 2097152 nbytes 1052672
>                 block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                 sequence 257 flags 0x8(NOCOMPRESS)
>
> Please note that, this behavior is there even before commit 59615e2c1f63
> ("btrfs: reject single block sized compression early").
>
> [CAUSE]
> At compress_file_range(), after btrfs_compress_folios() call, we try
> making an inlined extent by calling cow_file_range_inline().
>
> But cow_file_range_inline() calls can_cow_file_range_inline() which has
> more accurate checks on if the range can be inlined.
>
> One of the user configurable condition is the "max_inline=3D" mount

condition -> conditions

> option. If that value is set low (like the example, 4 bytes, which can
> not store any header), or the compressed content is just slightly larger
> than 2K (the default value, meaning a 50% compression ratio),
> cow_file_range_inline() will return 1 immediately.
>
> And since we're here only to try inline the compressed data, the range
> is no larger than a single fs block.
>
> Thus compression is never going to make it a win, we fallback to mark
> the inode incompressible unavoidably.
>
> [FIX]
> Just add an extra check after inline attempt, so that if the inline
> attempt failed, do not set the nocompress flag.
>
> As there is no way to remove that flag, and the default 50% compression
> ratio is way too strict for the whole inode.
>
> Cc: stable@vger.kernel.org

If we don't have a Fixes tag here, at least add a minimum version to
backport to.

Otherwise, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This is the smallest fix for backport.
>
> There will be a proper but much bigger fix to extract the inline attempt
> into a dedicated helper inside run_delalloc_range() other than put them
> deep inside cow_file_range() and compress_file_range().
> ---
>  fs/btrfs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 19c6fbb1273c..4523b689711d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1061,6 +1061,12 @@ static void compress_file_range(struct btrfs_work =
*work)
>                         mapping_set_error(mapping, -EIO);
>                 return;
>         }
> +       /*
> +        * If a single block at file offset 0 can not be inlined, fallbac=
k
> +        * to regular writes without marking the file incompressible.
> +        */
> +       if (start =3D=3D 0 && end <=3D blocksize)
> +               goto cleanup_and_bail_uncompressed;
>
>         /*
>          * We aren't doing an inline extent. Round the compressed size up=
 to a
> --
> 2.52.0
>
>

