Return-Path: <linux-btrfs+bounces-11235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B187A257C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 12:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F8B166246
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42246202C2F;
	Mon,  3 Feb 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKtkGco1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90B1DB551
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580699; cv=none; b=lSb0Jjs17fNM5dQ8Myb7y/MbLMm4Us+ibpnW86P/mfZRuJ5R7zzGOKE3xX5h2FfvoPkMpg5Gujcl329jav4D2/D+xbvfTJsp50nYApu3f+Ys8r0+T1AQsTSOtmh2mwEBuGxiyVxDPyO9lbmr9bk7zfEw4vvE/+VWEdnp8+AO1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580699; c=relaxed/simple;
	bh=rELvNsxxKduBlnF4tibfyg0MtID3CaPg5V1lfglhDNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcoJw1dNwoPd4/VzvIS+Wp6sL6PiVYc4sw+r7hWx4A29Uu+Ri8PzjEtKiIGywG/+/5maan4CaOl/rTtvkoxk0V2ejburzBdTWK9k4wxjc8hZncXb9awmNuiBKvwfl3LWIXDLGZCfPb5+gIw3t2XqfPKuf+Lq5Hn2dCsxF2QzGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKtkGco1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF4BC4CEE4
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738580698;
	bh=rELvNsxxKduBlnF4tibfyg0MtID3CaPg5V1lfglhDNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XKtkGco1okH5FhoDfvzmYIrIcNbGicJIdrZ7BKMhKXMONYIIQOZ5VDWvDJodfhPAV
	 kmor8t2xuA7tB6q54fLQxtEGIFhyj7eI3wdI+FMUJA3c6vmNseUp8rVpIT/ts++Ika
	 gpFFdfS0JF/SoTDGpUfB3NHaJJYOJ5sd29OiCgKt53m2FpLrC2pZsD6UbQrM6SMTbp
	 AfgKVZ1RHvI4pSj6owlEIqWTO6vcZXokP3pZBwqdWIemmphsjECzchiGMeYCLDMjnI
	 XWXyWg7PlTM2jwqxecmOgakgWNKi/i+xITL56E0+RU3J3cHYtWXwGOqDYHxFtmNrIm
	 G6LunYZ8m/7nw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab737e5674bso68314966b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2025 03:04:58 -0800 (PST)
X-Gm-Message-State: AOJu0YyIfEMbRhHPwtJsCqaj3PqldZFRamXv40FVcFRU5zf5dsMKK1vg
	4Tk5cdDsYOF0emtsZP+YqowBimovRV4V0Z8BfDz/xvRRlspToMv4GJWQ6UiFOLltDEpD6EPYVr+
	aSMLeFqP9M+GhMGboiJ1SqpJhN9o=
X-Google-Smtp-Source: AGHT+IH7w0X/40/aWR3Vocvz+nctjDoa204knNr4OIxbwpuaanhtZIf5nNcMUCGA5bAyjFtoYtUugLex2al/2jDZ0os=
X-Received: by 2002:a17:907:7b85:b0:aa6:81dc:6638 with SMTP id
 a640c23a62f3a-ab6cfcbb881mr2328181066b.16.1738580697391; Mon, 03 Feb 2025
 03:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
In-Reply-To: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 3 Feb 2025 11:04:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7t=HcNeGdDuSYwGdD0oLTPMoFh6JT5o-UHv+nKkZ7SWA@mail.gmail.com>
X-Gm-Features: AWEUYZnrgZLdzFmdGoLpGoJSOw-R66sDxqKUf4i3bKpV6oId7MZmgeKFgiHcAXo
Message-ID: <CAL3q7H7t=HcNeGdDuSYwGdD0oLTPMoFh6JT5o-UHv+nKkZ7SWA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: always fallback to buffered IO if the inode
 requires checksum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> It is a long known bug that VM image on btrfs can lead to data csum
> mismatch, if the qemu is using direct-io for the image (this is commonly
> known as cache mode none).
>
> [CAUSE]
> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
> fs is allowed to dirty/modify the folio even the folio is under
> writeback (as long as the address space doesn't have AS_STABLE_WRITES
> flag inherited from the block device).
>
> This is a valid optimization to improve the concurrency, and since these
> filesystems have no extra checksum on data, the content change is not a
> problem at all.
>
> But the final write into the image file is handled by btrfs, which need
> the content not to be modified during writeback, or the checksum will
> not match the data (checksum is calculated before submitting the bio).
>
> So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
> but btrfs requires no modification, this leads to the false csum
> mismatch.
>
> This is only a controlled example, there are even cases where
> multi-thread programs can submit a direct IO write, then another thread
> modifies the direct IO buffer for whatever reason.
>
> For such cases, btrfs has no sane way to detect such cases and leads to
> false data csum mismatch.
>
> [FIX]
> I have considered the following ideas to solve the problem:
>
> - Make direct IO to always skip data checksum
>   This not only requires a new incompatible flag, as it breaks the
>   current per-inode NODATASUM flag.
>   But also requires extra handling for no csum found cases.
>
>   And this also reduces our checksum protection.
>
> - Let hardware to handle all the checksum
>   AKA, just nodatasum mount option.
>   That requires trust for hardware (which is not that trustful in a lot
>   of cases), and it's not generic at all.
>
> - Always fallback to buffered IO if the inode requires checksum
>   This is suggested by Christoph, and is the solution utilized by this
>   patch.
>
>   The cost is obvious, the extra buffer copying into page cache, thus it
>   reduce the performance.
>   But at least it's still user configurable, if the end user still wants
>   the zero-copy performance, just set NODATASUM flag for the inode
>   (which is a common practice for VM images on btrfs).
>
>   Since we can not trust user space programs to keep the buffer
>   consistent during direct IO, we have no choice but always falling
>   back to buffered IO.
>   At least by this, we avoid the more deadly false data checksum
>   mismatch error.
>
> Suggested-by: hch@infradead.org <hch@infradead.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/direct-io.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index c99ceabcd792..d64cda76cc92 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode *inode=
, loff_t start,
>                         goto err;
>         }
>
> +       /*
> +        * For direct IO, we have no control on the folio passed in, thus=
 the content

folio -> folios

> +        * can change halfway after we calculated the data checksum.
> +        *
> +        * To be extra safe and avoid false data checksum mismatch, if th=
e inode still
> +        * requires data checksum, we just fall back to buffered IO by re=
turning
> +        * -ENOTBLK, and iomap will do the fallback.
> +        */
> +       if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> +               ret =3D -ENOTBLK;
> +               goto err;
> +       }

Why do it here?

We can do it higher in the call stack at btrfs_direct_write() after
locking the inode, right before or after calling check_direct_IO().
It's far more straightforward.

Thanks.

> +
>         /*
>          * If this errors out it's because we couldn't invalidate pagecac=
he for
>          * this range and we need to fallback to buffered IO, or we are d=
oing a
> --
> 2.48.1
>
>

