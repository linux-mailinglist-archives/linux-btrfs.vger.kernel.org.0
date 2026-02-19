Return-Path: <linux-btrfs+bounces-21780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ9gHwMol2kzvQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21780-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:10:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9855115FF29
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E96F305D46A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8F34B438;
	Thu, 19 Feb 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNT7FDvv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FE34B194
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513436; cv=none; b=cdmM/OLxdgKWKtHQsgGdoGtiIBCKDDpwOJQnHrIV6AvxVvtPglgLQiAqRnUSCWpHLYXTCr1euo2RkR1j7R6Km8ZNUm14l8gAUhibs0kboD3n0uYwU1d8K+oIYTPIOzd0mpRKwQEBAkWOJKA8dk5KcBBhYP9wq+m6BGhGS0w2PQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513436; c=relaxed/simple;
	bh=IyiWyTTdXiITzMbIFzso1TLofef+qAvM6T8cwjbEHYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAcnG8es4xhYL53Q20pfWneSrPs6UPO4rrgFV9jJZnKx772BeO+l2Fm/hP5hWSqOzstGOEbygwDd0E1P8BkQ0SyV+wbqk9GIM+ma9vluea0PqaGXO3ZYwASPoqJcR7qdmyJG8dRAgdeNflNIVm2xhG9DGBeJhdSFVzcCuLJbhzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNT7FDvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5507FC2BCB7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771513435;
	bh=IyiWyTTdXiITzMbIFzso1TLofef+qAvM6T8cwjbEHYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fNT7FDvvXiSaqBH6vKGGdw0JYeU9hrI66zxoFf61/YxTjo7ULusWhE2UZGJLV/Be9
	 OM3yx6dZs3jYVLe4B5HCQDpBJWWnyh0HbuZrFMSHuzb3phJPOIKSOT4jjaQgxHwt7a
	 aGaYCYdMX6rZcAXimaPc1ELZb7CkHu9JMbwX+xvUUVNNL/jo5pOXHQq7zMGhKweI7/
	 ZIBmiFEjhbCcP4gwzR/VTWAyuNx3TXMTdZCIGy48SGHn1HzKBkWStSyBBXTlFD04bV
	 h005yKKLqon3UGL2J7imtx0sYEYkgEtbPBsKDAFF2Ll2/8uqXXQfhuDnpmUorRX9GE
	 dpMkXah5xIJdg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65c0d2f5fe1so1621569a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 07:03:55 -0800 (PST)
X-Gm-Message-State: AOJu0YxVbgKKSyB1uyJbSEukuIu6dh2gykIGOEMrcMqyqkAj75cMy0X5
	GvlAnZTQlE3+BOsPZypdhIwX7KgmMxzGEJ112VnxHFuzNyem0ix9uBdvSi/9ce7hh9YmwYTvMcO
	LoQvavfO5VSVWeF8jF5GPJy4XX+vxqWs=
X-Received: by 2002:a17:906:6a24:b0:b8f:6699:a036 with SMTP id
 a640c23a62f3a-b903da9671cmr341050166b.19.1771513433137; Thu, 19 Feb 2026
 07:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771488629.git.wqu@suse.com> <656c089a9f56d960ebcdd5619de38d89cb8beb79.1771488629.git.wqu@suse.com>
In-Reply-To: <656c089a9f56d960ebcdd5619de38d89cb8beb79.1771488629.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 15:03:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5_WA-kdRx0CYt16vrEuH+n0w8Hqcfa1QE=Oq_N8woKdA@mail.gmail.com>
X-Gm-Features: AZwV_Qj-zPQ7Q-NuuOm7O-5r3aUAUGAKWUjs1QSVnyrZNTIE2-47k2Ps3iBt48c
Message-ID: <CAL3q7H5_WA-kdRx0CYt16vrEuH+n0w8Hqcfa1QE=Oq_N8woKdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] btrfs: do not touch page cache for encoded writes
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21780-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 9855115FF29
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 8:21=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/284, the following ASSERT() will be triggered with
> 64K page size and 4K fs block size:
>
>  assertion failed: folio_test_writeback(folio) :: 0, in subpage.c:476
>  ------------[ cut here ]------------
>  kernel BUG at subpage.c:476!
>  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>  CPU: 4 UID: 0 PID: 2313 Comm: kworker/u37:2 Tainted: G           OE     =
  6.19.0-rc8-custom+ #185 PREEMPT(voluntary)
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  Workqueue: btrfs-endio simple_end_io_work [btrfs]
>  pc : btrfs_subpage_clear_writeback+0x148/0x160 [btrfs]
>  lr : btrfs_subpage_clear_writeback+0x148/0x160 [btrfs]
>  Call trace:
>   btrfs_subpage_clear_writeback+0x148/0x160 [btrfs] (P)
>   btrfs_folio_clamp_clear_writeback+0xb4/0xd0 [btrfs]
>   end_compressed_writeback+0xe0/0x1e0 [btrfs]
>   end_bbio_compressed_write+0x1e8/0x218 [btrfs]
>   btrfs_bio_end_io+0x108/0x258 [btrfs]
>   simple_end_io_work+0x68/0xa8 [btrfs]
>   process_one_work+0x168/0x3f0
>   worker_thread+0x25c/0x398
>   kthread+0x154/0x250
>   ret_from_fork+0x10/0x20
>  ---[ end trace 0000000000000000 ]---
>
> [CAUSE]
> The offending bio is from an encoded write, where the compressed data is
> directly written as a data extent, without touching the page cache.
>
> However the encoded write still utilizes the regular buffered write path
> for compressed data, by setting the compressed_bio::writeback flag.
>
> When that flag is set, at end_bbio_compressed_write() btrfs will go
> clearing the writeback flags of the folio in page cache.

... flag of the folios in the page cache.

>
> However for bs < ps cases, the subpage helper has one extra check to make
> sure the folio has writeback flag set in the first place.

has writeback -> has a writeback

>
> But since it's an encoded write, we never go through page
> cache, thus the folio has no writeback flag and triggered the ASSERT().

triggered -> triggers

>
> [FIX]
> Do not set compressed_bio::writeback flag for encoded writes, and change
> the ASSERT() in btrfs_submit_compressed_write() to make sure that flag
> is not set.
>
> Fixes: e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage for enc=
oded writes")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 348551ab2c04..64600b6458cb 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -320,7 +320,12 @@ void btrfs_submit_compressed_write(struct btrfs_orde=
red_extent *ordered,
>
>         ASSERT(IS_ALIGNED(ordered->file_offset, fs_info->sectorsize));
>         ASSERT(IS_ALIGNED(ordered->num_bytes, fs_info->sectorsize));
> -       ASSERT(cb->writeback);
> +       /*
> +        * This flag determines if we should clear writeback flags
> +        * from page cache. But this function is only utilized by
> +        * encoded write, it never go through page cache.
> +        */

By the way we can better use the 80 characters limit for comments
here, the first two lines are only taking slightly more than 60
characters.
Also the plural and grammar are a bit off. Something like

/*
* This flag determines if we should clear the writeback flag from the
* page cache. But this function is only utilized by encoded writes, it
* never goes through the page cache.
*/

Otherwise it looks fine, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +       ASSERT(!cb->writeback);
>
>         cb->start =3D ordered->file_offset;
>         cb->len =3D ordered->num_bytes;
> @@ -346,8 +351,7 @@ struct compressed_bio *btrfs_alloc_compressed_write(s=
truct btrfs_inode *inode,
>         cb =3D alloc_compressed_bio(inode, start, REQ_OP_WRITE, end_bbio_=
compressed_write);
>         cb->start =3D start;
>         cb->len =3D len;
> -       cb->writeback =3D true;
> -
> +       cb->writeback =3D false;
>         return cb;
>  }
>
> --
> 2.52.0
>
>

