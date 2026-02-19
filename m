Return-Path: <linux-btrfs+bounces-21781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOr4OEgol2kzvQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21781-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:12:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F815FF84
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A498302A7AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03D342510;
	Thu, 19 Feb 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+gT06Mq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C833FE06
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513620; cv=none; b=gcVhqHMLD0Vr82sRSWJTJeSluU0grEPneD7X8S0aR0OZ8iy3n/VWMkVQ6oZHSulF1e6kbxhXrFnuEnkw47ViedXqKgiSzYeHLQhkjKfANls26eE+PVznbbV1d1+s8/DuVYRC4feXD8Mt8RcL6+JxEi3OLg8tyciDfndaPaj+q1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513620; c=relaxed/simple;
	bh=mzn9iIPLKa36B8O+7v6brExEWdBSUhQ2sm0UXHvkp9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDox4qGgNcz60EIhGV3QE/Jh5q8NSw0lcMZI26yW678RC3DmG/GojMFXJpplRTRLIKAA8l2yiEUwEtI0JMAPuv52IkSqYHZ1OCozOvDFOq33wVsDAmP3FqqBVCftWfcd/3fza9ouxOKKxetBqEB6LYvLRuxgujWgYsRQNUhd0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+gT06Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A17C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771513620;
	bh=mzn9iIPLKa36B8O+7v6brExEWdBSUhQ2sm0UXHvkp9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J+gT06MqwYUwh+vWUecNpPUx0dHac8Cm9kS3ESFVO5hPH8jMchFIG1Mw2gWguU4le
	 WN345hmLWN5ZCfWCRxfeerpzMT5cnU6B1dQPvYl+EMmQf511RJyEmCTJMKhSkaInpQ
	 nmhWqy9km1YngAZDO806wsjdhyDZsJ8i03mNHgld8IjLQX5PTXk5+HY7l1FvBYcOEc
	 gtr+pbD7XNnqMGl3P2dEXjucsdY9JNZ+Ns9IYgtKKqdZzAPtGEkLrAi5x26pWy3xRo
	 MyLwtgfMWdUAw+O/JhoilBOnTUoS3o8vTEnEqnrqvx7KmO+R9sXUEfPCbjLphVsqFg
	 FdmYIk7FTqh0w==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b884a84e622so164507566b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 07:07:00 -0800 (PST)
X-Gm-Message-State: AOJu0YwBFY01JxmJL3A5DWX1y/xRYjXAXydnFxUKl3L5+IWVFh1go3z1
	DZ/jYF6uC23MAiWwKPdmEj8FSHmlPHi62q3ph0rqtjCkNr8cqFtY8eDHsbs+Ynhb8bg5Vdeitfa
	F1X55KdqoAJqDOqCb1qpqTZrFGnssrOA=
X-Received: by 2002:a17:907:70a:b0:b8e:d0ec:c9e2 with SMTP id
 a640c23a62f3a-b8face8c2e0mr1325128466b.53.1771513618635; Thu, 19 Feb 2026
 07:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771488629.git.wqu@suse.com> <4170e39bac4a2559ad0535f9bd74a89bc44a36d4.1771488629.git.wqu@suse.com>
In-Reply-To: <4170e39bac4a2559ad0535f9bd74a89bc44a36d4.1771488629.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 15:06:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6fVTJGUEYaRDcHVzx5GFFV3OKq9ProDZp4aVVDpbLtkQ@mail.gmail.com>
X-Gm-Features: AaiRm5296Q7L3Ezv93lg0aFdV_X5XUcYBd0z3HRpD323-hGxVHENf0K93x3psr8
Message-ID: <CAL3q7H6fVTJGUEYaRDcHVzx5GFFV3OKq9ProDZp4aVVDpbLtkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs: fix a bug that makes encoded write bio
 larger than expected
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21781-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A57F815FF84
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 8:21=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/284 with 64K page size and 4K fs block size, the
> following ASSERT() can be triggered:
>
>  assertion failed: cb->bbio.bio.bi_iter.bi_size =3D=3D disk_num_bytes :: =
0, in inode.c:9991
>  ------------[ cut here ]------------
>  kernel BUG at inode.c:9991!
>  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>  CPU: 5 UID: 0 PID: 6787 Comm: btrfs Tainted: G           OE       6.19.0=
-rc8-custom+ #1 PREEMPT(voluntary)
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  pc : btrfs_do_encoded_write+0x9b0/0x9c0 [btrfs]
>  lr : btrfs_do_encoded_write+0x9b0/0x9c0 [btrfs]
>  Call trace:
>   btrfs_do_encoded_write+0x9b0/0x9c0 [btrfs] (P)
>   btrfs_do_write_iter+0x1d8/0x208 [btrfs]
>   btrfs_ioctl_encoded_write+0x3c8/0x6d0 [btrfs]
>   btrfs_ioctl+0xeb0/0x2b60 [btrfs]
>   __arm64_sys_ioctl+0xac/0x110
>   invoke_syscall.constprop.0+0x64/0xe8
>   el0_svc_common.constprop.0+0x40/0xe8
>   do_el0_svc+0x24/0x38
>   el0_svc+0x3c/0x1b8
>   el0t_64_sync_handler+0xa0/0xe8
>   el0t_64_sync+0x1a4/0x1a8
>  Code: 91180021 90001080 9111a000 94039d54 (d4210000)
>  ---[ end trace 0000000000000000 ]---
>
> [CAUSE]
> After commit e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage
> for encoded writes"), the encoded write is changed to copy the content
> from the iov into a folio, and queue the folio into the compressed bio.
>
> However we always queue the full folio into the compressed bio, which
> can make the compressed bio larger than the on-disk extent, if the folio
> size is larger than the fs block size.
>
> Although we have an ASSERT() to catch such problem, for kernels without
> CONFIG_BTRFS_ASSERT, such larger than expected bio will just be
> submitted, possibly overwrite the next data extent, causing data
> corruption.
>
> [FIX]
> Instead of blindly queuing the full folio into the compressed bio, only
> queue the rounded up range, which is the old behavior before that
> offending commit.
> This also means we no longer need to zero the tailing range until the
> folio end (but still to the block boundary), as such range will not be
> submitted anyway.
>
> And since we're here, add a final ASSERT() into
> btrfs_submit_compressed_write() as the last safenet for debug kernels.

I wouldn't say "debug kernels", because CONFIG_BTRFS_ASSERT() is not
necessarily a debug feature.
All SUSE kernels have it enabled by default. Just say instead "for
kernels with assertions enabled" or something like that.

Otherwise, it looks good:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Fixes: e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage for enc=
oded writes")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 1 +
>  fs/btrfs/inode.c       | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 1938d33ab57a..348551ab2c04 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -324,6 +324,7 @@ void btrfs_submit_compressed_write(struct btrfs_order=
ed_extent *ordered,
>
>         cb->start =3D ordered->file_offset;
>         cb->len =3D ordered->num_bytes;
> +       ASSERT(cb->bbio.bio.bi_iter.bi_size =3D=3D ordered->disk_num_byte=
s);
>         cb->compressed_len =3D ordered->disk_num_bytes;
>         cb->bbio.bio.bi_iter.bi_sector =3D ordered->disk_bytenr >> SECTOR=
_SHIFT;
>         cb->bbio.ordered =3D ordered;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index baf400847ce8..471fb08ebff2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9871,6 +9871,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, =
struct iov_iter *from,
>         int compression;
>         size_t orig_count;
>         const u32 min_folio_size =3D btrfs_min_folio_size(fs_info);
> +       const u32 blocksize =3D fs_info->sectorsize;
>         u64 start, end;
>         u64 num_bytes, ram_bytes, disk_num_bytes;
>         struct btrfs_key ins;
> @@ -9981,9 +9982,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, =
struct iov_iter *from,
>                         ret =3D -EFAULT;
>                         goto out_cb;
>                 }
> -               if (bytes < min_folio_size)
> -                       folio_zero_range(folio, bytes, min_folio_size - b=
ytes);
> -               ret =3D bio_add_folio(&cb->bbio.bio, folio, folio_size(fo=
lio), 0);
> +               if (!IS_ALIGNED(bytes, blocksize))
> +                       folio_zero_range(folio, bytes, round_up(bytes, bl=
ocksize) - bytes);
> +               ret =3D bio_add_folio(&cb->bbio.bio, folio, round_up(byte=
s, blocksize), 0);
>                 if (unlikely(!ret)) {
>                         folio_put(folio);
>                         ret =3D -EINVAL;
> --
> 2.52.0
>
>

