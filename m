Return-Path: <linux-btrfs+bounces-11270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A1A2701E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 12:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72747A528D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1320C02D;
	Tue,  4 Feb 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1cV2zBT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973E20127B
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667998; cv=none; b=DSB+2SXSGpN25muM0uqe7rbD30hF5eheJbLI3ET1dQyVZ2vEEqLABkmsimSBodbY0FEdrinaQguONDwZibwDbAwaVn0V4Hm/39rBn0umrmr/kpStwspoyARmrUbIMgEhIkqLAwwwO8P3SOzAyYna6KMW/H1wYmjxFph3fvHmj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667998; c=relaxed/simple;
	bh=0M2rk4PT0OPqmQ1f/64MoOThaW695axzIudv26ciORA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kaj/Mfp8WZWcDP4xg6mF71NXIbVIzaSKs6NmDs8SaAnhnprL9ijoPwz09j1E7s4QDoY7W0FrEu/+ubCaBTaiQA1pbtVsThWpd5cWppf00Z/UQh+jrEvXUT5ek7NMcpUjAErUUNof6SAc75nFVZgVhzV2jKzgiA+BzP8AOWX75IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1cV2zBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C39FC4CEE2
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738667997;
	bh=0M2rk4PT0OPqmQ1f/64MoOThaW695axzIudv26ciORA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c1cV2zBT1uNLvcJfWAvaMhVU11tloFuK/tplCdUq5PrP67XaRTCiGRxH5uxinbsWq
	 NbAddU+PFuRkHWz6JUt0vpGBshxhmR1/7OBT/HTZquZLKUml4oqzrpRJkYjf4FQ+LA
	 aJgTFkhIDbPhY3pUCOJxBuEwAd7AsrBKM/j8wWBYM/jOv51SKYoqTWeJsi8vB38sHm
	 Nq4jN1gRRqVr8/f+oc8EsAAckv2flT+k51Ncen7eOzPtycvw0fB81O4lg4BStZeGI0
	 jOgFaIGfjEAk92s4AH3rEaeUIh7S6+ThSISedYroApqJTq2IGhnJIBW/7R9fUvHRw0
	 vp3zQDZMVKllQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso930423266b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2025 03:19:57 -0800 (PST)
X-Gm-Message-State: AOJu0YypIbVt9D/I88AbA7hR3Ths3FAyrLvJtU76xbg1FMa6SrvdboBv
	ah9fnly0mSO+lB1cBMY+4aZD2Xahapmk+zPX9UoDbjLc+q/qSJNC0RlvgZCA1DjRkr7EzbiZ2Gc
	MCVmHUzZu0KFFg1LkvXQezg+wtbQ=
X-Google-Smtp-Source: AGHT+IGPI2donqIkfCphBC8TUKQocUnkmkOS3JJIKgTfU4ZhQUgpRmwQgmgopuqcmOgNax6+f3ds9tyVY25dJzML+qM=
X-Received: by 2002:a17:907:94cd:b0:ab2:fefe:7156 with SMTP id
 a640c23a62f3a-ab6cfdbc4f5mr3076885066b.43.1738667996093; Tue, 04 Feb 2025
 03:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
In-Reply-To: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 4 Feb 2025 11:19:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7eJG2pRDQnvsfob7ifOiHSU_W0QNfzXyO=V99c5ugXQQ@mail.gmail.com>
X-Gm-Features: AWEUYZnXnhGYnV-pFdcc0dQ6r7sJLnyUEQ53Uyo55B3oLqEKyImiFakgudLivK8
Message-ID: <CAL3q7H7eJG2pRDQnvsfob7ifOiHSU_W0QNfzXyO=V99c5ugXQQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: always fallback to buffered write if the inode
 requires checksum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> - Always fallback to buffered write if the inode requires checksum
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
> Changelog:
> v2:
> - Move the checksum check just after check_direct_IO()
>   So that we don't need the extra ENOTBLK error code trick to fallback
>   to buffered IO.
>
> - Slightly improve the comment
>   Adds that only direct write is affected, and why buffered write is
>   fine.
> ---
>  fs/btrfs/direct-io.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index c99ceabcd792..0de4397130be 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -855,6 +855,21 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struc=
t iov_iter *from)
>                 btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
>                 goto buffered;
>         }
> +       /*
> +        * For direct IO write, we have no control on the folios passed i=
n,
> +        * thus the content can change halfway after we calculated the da=
ta
> +        * checksum, and result data checksum mismatch and unable to read
> +        * the data out anymore.

I would phrase this differently to be more clear:

We can't control the folios being passed in, applications can write to
them while a
direct IO write is in progress. This means the content might change
after we calculate the data
checksum. Therefore we can end up storing a checksum that doesn't
match the persisted data.

Otherwise it looks fine to me:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +        *
> +        * To be extra safe and avoid false data checksum mismatch, if th=
e
> +        * inode requires data checksum, just fallback to buffered IO.
> +        * For buffered IO we have full control of page cache and can ens=
ure
> +        * no one is modifying the content during writeback.
> +        */
> +       if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> +               btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +               goto buffered;
> +       }
>
>         /*
>          * The iov_iter can be mapped to the same file range we are writi=
ng to.
> --
> 2.48.1
>
>

