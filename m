Return-Path: <linux-btrfs+bounces-21782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKppE/Qnl2kzvQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21782-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:10:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C515FF1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 254DD30333A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6E342523;
	Thu, 19 Feb 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7exIm2g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CB341AA0
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513798; cv=none; b=tX1QjyIrTZTLLG29z4U7rnRX1iAKwYXNeQLBRKss45C8sj93kZi9GYiMQLb0rC+rrbWJtHL9UQgZmp72ETpjZhTvLeBoft1HN3CsvHDHXrERWEW1/MFY3M2CXyXzt2FJmVQjAelXuR5fz8q8p7ZuXkEyEYWFK2KwXXz6AJL0Opg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513798; c=relaxed/simple;
	bh=OS2E1xvDk+HEdI4+Wpoh1aVLBo+HugZscfo0NwKjcD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdhjP1Jn8+M59mieTZy5NpV/sv5m/2cZMctxcMepaWEcx3ACQSQUbIyrOcZk6tvAu/W7lA73LTO6bF5+27+gOU/kkk+qrOYM7ssOPkK5WsX44aOneTB3FoW9ESbVCe1ndrc0ESsdtlGd48RtxMGDGS2AW6f13DR3rSmU40tlJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7exIm2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B10C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771513797;
	bh=OS2E1xvDk+HEdI4+Wpoh1aVLBo+HugZscfo0NwKjcD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q7exIm2gZJbloVKrZRbtbR9FYfYHGMJtawVCegn6ztDs/EVEUIgwN0DSwYIOeSMi/
	 0uj5zTODCEZItOSjysw5UBTiaA/bTLWB2oAZrIp49XLx8p3e1ce5qWmxMzkOkOKOQj
	 mEeKAiux/lZ8N6/BC3260kNZZYlrtsy2JdjuC3exiMtCLrm3h8bgEd93RfbsrCV30P
	 2OpYoluhmrtEDbvIktsKw4ibKzuKlccKicPvNJIj4/cGDqUkwtAcUhzJOI1lq4LECH
	 zIi9haM9kpyVnZuZztbbYXlnNRnoB8p6lKqhM7sC/hcGDCYJif2TD9NqJtdvQ+3Fgd
	 u088lgD2D9xfQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9047e72201so152036666b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 07:09:57 -0800 (PST)
X-Gm-Message-State: AOJu0YzkQklVI/avxEOVFlGhtoKLSFp4CEkikc/hqNn6fXTl38Q8GKk9
	1+QsRy/r0FdW3Y7+UwsRHCT8xAhJPyvKMT2mySmEnOCifsLdslDnxyI0Ppy2AQh57kwMTHY4vit
	k0EVzJ6xHGWI4YYTZ6ggPn+mbejxwnYs=
X-Received: by 2002:a17:907:cd07:b0:b8f:b4bd:c9a1 with SMTP id
 a640c23a62f3a-b8fc3d39623mr999463466b.60.1771513796166; Thu, 19 Feb 2026
 07:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771488629.git.wqu@suse.com> <3b5176eb0c8d7d1780b758ca50599d90c2c62bc9.1771488629.git.wqu@suse.com>
In-Reply-To: <3b5176eb0c8d7d1780b758ca50599d90c2c62bc9.1771488629.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 15:09:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Q7NXLwgbaU4AGkgd_x7xYpNB4YaGhS5m0tjJf7hb7hQ@mail.gmail.com>
X-Gm-Features: AZwV_QgXQvG0xUsVs0ct7gnCNhslONvbW2pT6r_PLZgOec1jOLOAYB7_jYiGNsw
Message-ID: <CAL3q7H4Q7NXLwgbaU4AGkgd_x7xYpNB4YaGhS5m0tjJf7hb7hQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] btrfs: fix an incorrect ASSERT() condition inside zstd_decompress_bio()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21782-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 883C515FF1B
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 8:22=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/284 with 64K page size and 4K fs block size, it
> crashes with the following ASSERT() triggered:
>
>  assertion failed: folio_size(fi.folio) =3D=3D blocksize :: 0, in fs/btrf=
s/zstd.c:603
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/zstd.c:603!
>  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>  CPU: 2 UID: 0 PID: 1183 Comm: kworker/u35:4 Not tainted 6.19.0-rc8-custo=
m+ #185 PREEMPT(voluntary)
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  Workqueue: btrfs-endio simple_end_io_work [btrfs]
>  pc : zstd_decompress_bio+0x4f0/0x508 [btrfs]
>  lr : zstd_decompress_bio+0x4f0/0x508 [btrfs]
>  Call trace:
>   zstd_decompress_bio+0x4f0/0x508 [btrfs] (P)
>   end_bbio_compressed_read+0x260/0x2c0 [btrfs]
>   btrfs_bio_end_io+0xc4/0x258 [btrfs]
>   btrfs_check_read_bio+0x424/0x7e0 [btrfs]
>   simple_end_io_work+0x40/0xa8 [btrfs]
>   process_one_work+0x168/0x3f0
>   worker_thread+0x25c/0x398
>   kthread+0x154/0x250
>   ret_from_fork+0x10/0x20
>  ---[ end trace 0000000000000000 ]---
>
> [CAUSE]
> Commit 1914b94231e9 ("btrfs: zstd: use folio_iter to handle
> zstd_decompress_bio()") added the ASSERT() to make sure the folio size
> match the fs block size.

math -> matches

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
> Fixes: 1914b94231e9 ("btrfs: zstd: use folio_iter to handle zstd_decompre=
ss_bio()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/zstd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 32fd7f5454d3..c002d18666b7 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -600,7 +600,7 @@ int zstd_decompress_bio(struct list_head *ws, struct =
compressed_bio *cb)
>         bio_first_folio(&fi, &cb->bbio.bio, 0);
>         if (unlikely(!fi.folio))
>                 return -EINVAL;
> -       ASSERT(folio_size(fi.folio) =3D=3D blocksize);
> +       ASSERT(folio_size(fi.folio) =3D=3D min_folio_size);
>
>         stream =3D zstd_init_dstream(
>                         ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->=
size);
> --
> 2.52.0
>
>

