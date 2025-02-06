Return-Path: <linux-btrfs+bounces-11316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A96A2A821
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479273A758F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FD22D4C0;
	Thu,  6 Feb 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7NYv8c0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D918B477;
	Thu,  6 Feb 2025 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843862; cv=none; b=gVfOZXxk3tALQiL5wGqjI9I4eL0HacIK4tZXcQ/kFgHZ6tsZMyot2k3XVNIRSPUxNOeJrfRK/wYUgzhtuCoC9n3EKbt10gSuO36GO6qW2LanIzypdUT/eFBJNDul3+uKhHqGI5giCeIQEcnGPJoSePg+BJAWU6I0DjBCjg+LONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843862; c=relaxed/simple;
	bh=IbxsU7tpdC6ikq+F4C7u0gptW5BWVg4D0JaJnBrpHXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFhoTRwty6pf/jffbpcEz7gxiUwR+egK9yMcZMx8Y6MevrBQ2B8faT87+E8dLgM23weJf+faRIDFWf/ITkr0uWKuSi5jl4n2bOLpEtDxdjlcNfdfbmZ/d4R+njiIFTCXiAOkQpBLNcBd/xE4pBy4Q5doyNrJLxi2DLsQkk773ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7NYv8c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77866C4CEDD;
	Thu,  6 Feb 2025 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738843861;
	bh=IbxsU7tpdC6ikq+F4C7u0gptW5BWVg4D0JaJnBrpHXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I7NYv8c0VE1VayjfiaRuEfhEYJKlNRw/hRSCNZvqwkAIY2oXtBCQW9RUPaMQ5c0bM
	 aT+Rty71U+6arMsYAlh5FMNjYRlQiqUpo2hxDERKBxUbgPcK2zqXOdyGzcSkCgSUTI
	 Iv4DuKZWP3nhnzvq7PqXCAd1iKAgALMaIenKD2u9eFr1YpBQK/Be5w516gFniChz0z
	 AJ+vCrwORjQcnBsFxAVtRijjf/RzR7Yp7ZbpzMbwqoQzYZ0fVv5aTq2j7ayWbckJd3
	 jbvnr9r1uqpqNVUKGWg/C/e+nOamt/kRl6wMAznlalF5oaraLDxJSLPqdKYXtX+/HP
	 XVKzD3BI2u9XA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so143017166b.1;
        Thu, 06 Feb 2025 04:11:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViartBDlHrJSmizuOuE+FqdkDmBlaxTdPL6poBzabN272FAtHqcklCSG8Mkga/VgJQxY8PpKdU@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJQ4WLcE7e+rgELYCWf0bcQlzl3UQNhu0FuIrBtrUt49K/ZYA
	49B8+4h+87qKZHr2pUfMHjAOQPQ6psiVE6liNM/MGKYl5b7msPqjSaFkJjZdpp0tu9Goy80MvPR
	HAOI3LCeHL8moxansKLqv0vUtDjI=
X-Google-Smtp-Source: AGHT+IG/qJYGelCq5bd6btFL5ZniKOXMTSTfOdIVzQMuH4yPZQ6ZcQTFtVUk8M1DKAw2Y88E4HDfN86PUKPAHGvMEZc=
X-Received: by 2002:a17:907:2ce3:b0:ab2:da92:d0bc with SMTP id
 a640c23a62f3a-ab75e234984mr739032166b.3.1738843860036; Thu, 06 Feb 2025
 04:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com>
In-Reply-To: <6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Feb 2025 12:10:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H74oD=fL9rRJVdQhONhyApOFDUFt=tcES_0=DcsQbiVGQ@mail.gmail.com>
X-Gm-Features: AWEUYZkRpM_hTYE-tIeBrLrUgxjb_KIBkD-B7D-NQsTOAqgf2l6xbNG3-RMIfO4
Message-ID: <CAL3q7H74oD=fL9rRJVdQhONhyApOFDUFt=tcES_0=DcsQbiVGQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/226: use nodatasum mount option to prevent
 false alerts
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:59=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> With recent kernel patch "btrfs: always fallback to buffered write if the
> inode requires checksum", the test case btrfs/226 will fail with the
> following error:
>
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.13.0-rc6-custom+ #209 SMP PREEMP=
T_DYNAMIC Fri Jan 24 17:23:03 ACDT 2025
> MKFS_OPTIONS  -- /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>
> btrfs/226 1s ... - output mismatch (see /home/adam/xfstests/results//btrf=
s/226.out.bad)
>     --- tests/btrfs/226.out     2024-04-12 14:04:03.080000035 +0930
>     +++ /home/adam/xfstests/results//btrfs/226.out.bad  2025-02-06 08:23:=
42.564298585 +1030
>     @@ -39,14 +39,11 @@
>      Testing write against prealloc extent at eof
>      wrote 65536/65536 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -wrote 65536/65536 bytes at offset 65536
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     +pwrite: Resource temporarily unavailable
>      File after write:
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/226.out /home/adam/xfst=
ests/results//btrfs/226.out.bad'  to see the entire diff)
> Ran: btrfs/226
> Failures: btrfs/226
> Failed 1 of 1 tests
>
> [CAUSE]
> That kernel patch makes btrfs to always fallback to buffered IO if the
> target inode requires data checksum.
>
> This is to avoid more deadly problems of mismatched data checksum.
>
> But this also means, for inodes with data checksum, RWF_NOWAIT will
> always fail, because we will wait writing back the page cache, thus
> breaking the RWF_NOWAIT requirement.
>
> [FIX]
> Update the test case to utilize nodatasum mount option, so that the
> direct-IO will not fallback to buffered ones unconditionally.
>
> Reported-by: Filipe Manana <fdmanana@kernel.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/226 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 70275d0aa2d8..359813c4f394 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -21,7 +21,12 @@ _require_xfs_io_command falloc -k
>  _require_xfs_io_command fpunch
>
>  _scratch_mkfs >>$seqres.full 2>&1
> -_scratch_mount
> +
> +# This test involves RWF_NOWAIT direct IOs, but for inodes with data che=
cksum,

involves -> exercises

> +# btrfs will fall back to buffered IO unconditionally to prevent data ch=
ecksum
> +# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.

mimsatch -> mismatch

> +# So here we have to go with nodatasum mount option.

The whole text could be shorter and clear:

# RWF_NOWAIT only works with direct IO, which requires an inode with
nodatasum (otherwise it falls back to buffered IO).

Otherwise it looks fine, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +_scratch_mount -o nodatasum
>
>  # Test a write against COW file/extent - should fail with -EAGAIN. Disab=
le the
>  # NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatac=
ow".
> --
> 2.48.1
>

