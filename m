Return-Path: <linux-btrfs+bounces-11691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCB2A3F3C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945AF42510F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB9320B1FE;
	Fri, 21 Feb 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kawpoAPB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B631E5701;
	Fri, 21 Feb 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139511; cv=none; b=ibp91FcCjhbZrbkKcifssX6BrkVnVAFLT9jEeokSccB9B0KaSnunM/62ZL5Gn3WaiE/g+W29gEjrQmvZeSg3wfQzmENuY5cdLdyR7Ri6oGON453T5EAqJiOvL1V7Es/XnWlTj4tJCUCjY16wL8hQyqbyg1c8JC2bpHm3g2DymGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139511; c=relaxed/simple;
	bh=cUqxcl8SfiwYmxIgkjeyFdso3n4dOeioO3i3nLIym6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMpgp6oMddGIY/m/eJucdmP3ZvF8yMoeuj5JFCf2Kj66B53xmhW+0yUN19VVeGH5n7YPyi2x9g4HU39c0Ozv2ttqiORccsbPqJS9ackq2Mjb0OSPWDAl6G+sR5HRD5PQsh6XaiuSrfA0jxXmNNDwGzx8hAUaJsCf7SmRNu9pyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kawpoAPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53E0C4CEE6;
	Fri, 21 Feb 2025 12:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740139510;
	bh=cUqxcl8SfiwYmxIgkjeyFdso3n4dOeioO3i3nLIym6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kawpoAPB7i0UkTPEsVOZHMfYWgdDxK2gzq1x8JIE82vXtmW/jGG8e0GIqe/ekXOFR
	 mTLsypsPSY1KV3uDsGPtncU/RUKn1/IVTWRaztkT/89eqIniFLZZAadnxJ+THYe0RO
	 +MHsOAMHkXa0xjeyj9LGEL5g+/3I5SZKelYUrGnAKLfHjwf4ne0VJ1+HocYtD5pus5
	 yYNFZg8eD1r6vt4DvamcWyMA3GyZUXrDrhvqmtYXYZb1jFTo0i0bdvPdhCVxwuYXZh
	 2PVUqu74AitHN+qvmnn/jJ5TZYW+D+6Aih+cgudbF/oCFpszqk5YrTmvElUDAWEaEz
	 CxGWjcu3eMjzg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so3481089a12.3;
        Fri, 21 Feb 2025 04:05:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+5D2al1iW/6RywoL3zx8Q7z6ZtkPFB16pilFvkyIdGemNS33aZy2p10fIs7T7gJ5KfdM2unLW@vger.kernel.org, AJvYcCUEaBRv5wOMnwSRnQz7X6MfWBkj1KqrC+SYy2eE9qdF1sgHgqTXDSZNXYpJxVmMH1A8XwQYqqMiGLdifds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4hrgzUQzhzZJXg7tjWlu6rD822R+y5AgncD8CzPRMhR/eR2U
	UTVbNCYLyFXRYuvKXe8mchLaJQXvlmoP03fcOtYr/dLRP8SMAwxreC81K9MER8MD5+GSVglO2gZ
	0VQPqnSO31jw1OA3ysIVT0CyQ43M=
X-Google-Smtp-Source: AGHT+IHahBn3zFBA39KXAA0RKXggsyvmOqfc7fJJxlvZu8gABRYiw7UAiIFLcs0do5jlDu980URsbEHn822AugTUw/s=
X-Received: by 2002:a17:907:7216:b0:ab7:86b6:beeb with SMTP id
 a640c23a62f3a-abc0de519d3mr285091066b.57.1740139509190; Fri, 21 Feb 2025
 04:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
In-Reply-To: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Feb 2025 12:04:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
X-Gm-Features: AWEUYZkKswD_20hf8wffgO0RfYeCUGxPBBvtkTtUtRKBr7oXMpPmCF24wSk_Exk
Message-ID: <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:36=E2=80=AFPM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> From: Qu Wenruo <wqu@suse.com>
>
> Update comments that were previously missed.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/226 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 359813c4f394..ce53b7d48c49 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>
>  _scratch_mkfs >>$seqres.full 2>&1
>
> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data che=
cksum,
> -# btrfs will fall back to buffered IO unconditionally to prevent data ch=
ecksum
> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> -# So here we have to go with nodatasum mount option.
> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodat=
asum
> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O=
.

Btw, this is different from what I suggested before here:

https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle=
.com/T/#mb2369802d2e33c9778c62fcb3c0ee47de28b773b

Which is:

# RWF_NOWAIT only works with direct IO, which requires an inode with
nodatasum (otherwise it falls back to buffered IO).

What is being added in this patch:

+# RWF_NOWAIT works only with direct I/O and requires an inode with nodatas=
um
+# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.

Is confusing because:

1) It gives the suggestion RWF_NOWAIT requires nodatasum.

2) The part that says "to avoid checksum mismatches", that's not
related to RWF_NOWAIT at all.
    That's the reason why direct IO writes against inodes without
nodatasum fallback to buffered IO.
    We don't have to explain that - this is not a test to exercise the
fallback after all, all we have to say
    is that RWF_NOWAIT needs direct IO and direct IO can only be done
against inodes with nodatasum.

So you didn't pick my suggestion after all, you just added your own
rephrasing which IMO is confusing.



>  _scratch_mount -o nodatasum
>
>  # Test a write against COW file/extent - should fail with -EAGAIN. Disab=
le the
> --
> 2.47.0
>
>

