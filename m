Return-Path: <linux-btrfs+bounces-21783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNtoGMUql2nmvQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21783-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:22:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B703A16012F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B786301052E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED90342CA1;
	Thu, 19 Feb 2026 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBixWZmZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D957226CF6
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514488; cv=none; b=MnVCn4AaA7/V1rTmRJPOd92oYNT3pZWI4NF5yz/YImF0Iagc3iejwD+jHd+wamJqllKrj8MCpD2CPGQRV3LWt8+2ZmuQzrfHhp2zIRjmcTUjCN7WR4y5j0x3pgHHupXjW/7iihyycusgwXH8fh/oPf8AGPOWSLuPTtySjVakoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514488; c=relaxed/simple;
	bh=rqtWRep3LvvALHsKRkwAk7vbvqtD5h4OvTLiNbldG/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9JUaIZb1gob9KyqS6ZWeeETfgacFep4bD6ft/s3gm/GV7fGFREJPpAxJIsLEbFCkx/xwokU3e6FFwZ0j6mqv23txoFFCP14DTsdO971HqDUR9lGk+MfzMSzKXmiMInOIdyi7wN1nhnbT3JafzSBOYWdlJvIuw8hA67UoISK7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBixWZmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06F5C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771514487;
	bh=rqtWRep3LvvALHsKRkwAk7vbvqtD5h4OvTLiNbldG/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DBixWZmZ49sqxpxJtwWX7CL7Jo5zJoUYbFWazptrcSHt4qH4cZqgOIAWSylvc7jeq
	 5TB9jjr5uCuYBE57UyMyu9p7KZ+/cv+SeUDIcM3yjPE4PGot6irI2rojjnoDvK5I1B
	 E+ugsRCboJmB9LjRH9QTFBPliSNfZf2TL6IZ6ES86LTkbhX118wg8iBG6p5Vd4tFAC
	 kXp3uBN/78x7ni3989vbFnD7U8P475b4q/sFb9wqHyYljnmHGgFZlS3wOHk709/6mk
	 DmhO0dzq+NlcKUaYLmb7GCUWBaFux7l2wzr9ZJnIk3jEmI1wt7HDxPtjwpnSdar/2e
	 KsLuA7C70ZQQA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65a1970b912so3469824a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 07:21:27 -0800 (PST)
X-Gm-Message-State: AOJu0YwDhtr6PgNwHkIf8cTkTtivHQ5s23/RTOcMIKxvuoDZ7cDvbfPS
	XzGYiQ0pVCNi+zJCjs24DdtXB0V/VCVBVcjdlErnbIUL0AA79a0wnHoharn0axyTNOYuXHDXkdh
	rGWITMZD+mgoU3Afn+7J5VlzvieWjWJo=
X-Received: by 2002:a17:907:940f:b0:b8f:8054:504 with SMTP id
 a640c23a62f3a-b905444ceafmr140986966b.29.1771514486301; Thu, 19 Feb 2026
 07:21:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771488629.git.wqu@suse.com> <6c9530ebc218de97439aa5043840d544e9b6470a.1771488629.git.wqu@suse.com>
In-Reply-To: <6c9530ebc218de97439aa5043840d544e9b6470a.1771488629.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 15:20:49 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7LvU_2iNpTpSY8nmBKTCm87g7QvmQ6__yGpQcijX7Www@mail.gmail.com>
X-Gm-Features: AaiRm51vwQsUvXFrBrj2zH7mARtMiwveBauQvWibLpIDZPPkAVSuArTFb0Bf_mI
Message-ID: <CAL3q7H7LvU_2iNpTpSY8nmBKTCm87g7QvmQ6__yGpQcijX7Www@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] btrfs: fix an incorrect ASSERT() condition inside lzo_decompress_bio()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-21783-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B703A16012F
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 8:22=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/284 with 64K page size and 4K fs block size, it
> crashes with the following ASSERT() triggered:
>
>  BTRFS info (device dm-3): use lzo compression, level 1
>  assertion failed: folio_size(fi.folio) =3D=3D sectorsize :: 0, in lzo.c:=
450
>  ------------[ cut here ]------------
>  kernel BUG at lzo.c:450!
>  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>  CPU: 4 UID: 0 PID: 329 Comm: kworker/u37:2 Tainted: G           OE      =
 6.19.0-rc8-custom+ #185 PREEMPT(voluntary)
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  Workqueue: btrfs-endio simple_end_io_work [btrfs]
>  pc : lzo_decompress_bio+0x61c/0x630 [btrfs]
>  lr : lzo_decompress_bio+0x61c/0x630 [btrfs]
>  Call trace:
>   lzo_decompress_bio+0x61c/0x630 [btrfs] (P)
>   end_bbio_compressed_read+0x2a8/0x2c0 [btrfs]
>   btrfs_bio_end_io+0xc4/0x258 [btrfs]
>   btrfs_check_read_bio+0x424/0x7e0 [btrfs]
>   simple_end_io_work+0x40/0xa8 [btrfs]
>   process_one_work+0x168/0x3f0
>   worker_thread+0x25c/0x398
>   kthread+0x154/0x250
>   ret_from_fork+0x10/0x20
>  Code: 912a2021 b0000e00 91246000 940244e9 (d4210000)
>  ---[ end trace 0000000000000000 ]---
>
> [CAUSE]
> Commit 37cc07cab7dc ("btrfs: lzo: use folio_iter to handle
> lzo_decompress_bio()") added the ASSERT() to make sure the folio size
> match the fs block size.

match -> matches

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> But the check is completely wrong, the original intention is to make
> sure for bs > ps cases, we always got a large folio that covers a full fs
> block.
>
> However for bs < ps cases, a folio can never be smaller than page size,
> and the ASSERT() gets triggered immediately.
>
> [FIX]
> Check the folio size against @min_folio_size instead, which will never
> be smaller than PAGE_SIZE, and still cover bs > ps cases.
>
> Fixes: 37cc07cab7dc ("btrfs: lzo: use folio_iter to handle lzo_decompress=
_bio()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/lzo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 8e20497afffe..971c2ea98e18 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -429,7 +429,7 @@ static void copy_compressed_segment(struct compressed=
_bio *cb,
>  int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  {
>         struct workspace *workspace =3D list_entry(ws, struct workspace, =
list);
> -       const struct btrfs_fs_info *fs_info =3D cb->bbio.inode->root->fs_=
info;
> +       struct btrfs_fs_info *fs_info =3D cb->bbio.inode->root->fs_info;
>         const u32 sectorsize =3D fs_info->sectorsize;
>         struct folio_iter fi;
>         char *kaddr;
> @@ -447,7 +447,7 @@ int lzo_decompress_bio(struct list_head *ws, struct c=
ompressed_bio *cb)
>         /* There must be a compressed folio and matches the sectorsize. *=
/
>         if (unlikely(!fi.folio))
>                 return -EINVAL;
> -       ASSERT(folio_size(fi.folio) =3D=3D sectorsize);
> +       ASSERT(folio_size(fi.folio) =3D=3D btrfs_min_folio_size(fs_info))=
;
>         kaddr =3D kmap_local_folio(fi.folio, 0);
>         len_in =3D read_compress_length(kaddr);
>         kunmap_local(kaddr);
> --
> 2.52.0
>
>

