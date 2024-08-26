Return-Path: <linux-btrfs+bounces-7494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A72095F156
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A735D282246
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D316EC19;
	Mon, 26 Aug 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQteZl8K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E77804;
	Mon, 26 Aug 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675572; cv=none; b=kkKMeajyh1ehXuaa6uUShkEMSAfslIR5uhN0utjVhRWc5tH7T+JU2+OeiD1fh0a6okWSIu9jQEb05ww2tlqef0/xlMik2MQZQCAxx1CvRWUA5Wy1l20OF3oa2HndSFQQOmA/B3SMTS7/Olg8ti3KEn1aUfJggGRQ4nQ4XxryDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675572; c=relaxed/simple;
	bh=6TGV03I0+hWHGDlnHVsLUq+IZ78wKt/1wRM/aw92JU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHbd1b6OOQB2yBbgXeIdSXFyxXaAjBikuIFgk5Fl738/qw3SFQVKzqIbmoTw1axNvFqYqAeHHTJb3m49hpCe+kzBsZ5VzatC1V9KZHWrje8wRvFIXpEVKLTZU4CaUuGpuWlmbyVEzpV/Cq0wR/FYDYLWXsPYJL2azZmNDBOquI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQteZl8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAF5C51404;
	Mon, 26 Aug 2024 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724675571;
	bh=6TGV03I0+hWHGDlnHVsLUq+IZ78wKt/1wRM/aw92JU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NQteZl8Kvxt2sITWLkxgNijFE3jJYEAg2xf5jNyhp/OXJzS0lIGy2h9raTyiBSmcM
	 GNxynQ90yeT1jl2nzB5VLiPasngeiMfwZLWss19FpbJxzwcOlgx/WBDDeJxA3LueX2
	 5x1MYDs2+UbGAsBWK0Bp1usysSjDYxg4Reht6SNH3fthiSWPyNhWbDaN4N1MoNNJ6Y
	 F0XvvG9R1GF2sgGfQNENu3tpDshhD0aIYwQM8birmem+byqCgH7knyNVrgqyiNxhzn
	 60ADjjXbBpb8DstLVvJ+z4rHc++wow2JKW83nsM53QEIRtVDOFJcuyu9xT9MGjtsOc
	 Pd6WYUuRSPCWw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so542802866b.1;
        Mon, 26 Aug 2024 05:32:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURl/au0QTkYnOBckTSgb/tRsiFR/CzfZx1YlkSFtH2SfZFsMZdgmbZwWpPo02mlTtqpq0KE096@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXCiMjb4EYlOA7HgevVuj0hxfY2xOe0p7VCe5O9TcotjXKdb2
	CRhFkP7MqX+fycGqlZEdA4QfZjGWCiBWYHBH2/3zO+gQCWimI8gq2zXHHdbpb97AHsNB6Ceafeo
	4o6SvxFJgE7Ln1sRXI4T/1U37rys=
X-Google-Smtp-Source: AGHT+IFLdLBVAYJfWkIbYQQNn7reJ6LbzUCuuEXb5bSlf78NmujIUhbMnegUjPSh2e1VWzc28o3/DoHr0KQko/pAPTg=
X-Received: by 2002:a17:907:6095:b0:a86:45aa:ba5b with SMTP id
 a640c23a62f3a-a86a54dfbb1mr691009166b.69.1724675570137; Mon, 26 Aug 2024
 05:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b39ba0c9a496b0ceaa940f4b1e3faf94a4256baf.1724454084.git.wqu@suse.com>
In-Reply-To: <b39ba0c9a496b0ceaa940f4b1e3faf94a4256baf.1724454084.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Aug 2024 13:32:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5QF8E2-NfUqYhOTfSRPGFb8zs9_BVpH7KKWe53OX8UPw@mail.gmail.com>
Message-ID: <CAL3q7H5QF8E2-NfUqYhOTfSRPGFb8zs9_BVpH7KKWe53OX8UPw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/125: do not use raid5 for metadata
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 12:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There are several bug reports of btrfs/125 failure recently, either
> causing balance failure (-EIO), or even kernel crash.
>
> The balance failure looks like this:
>
>      Mount normal and balance
>     +ERROR: error during balancing '/mnt/scratch': Input/output error
>     +There may be more info in syslog - try dmesg | tail
>     +md5sum: /mnt/scratch/tf2: Input/output error

It's been like this forever. Historically there are periods where this
happens with some frequency, then for no reason it happens very, very,
very, sporadically, then after some time it comes back, and so on.

This has been pointed out and discussed several times in the past, for exam=
ple:

https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62Vf=
LpAcmgsinBFw@mail.gmail.com/

https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b791264730=
1.1654672140.git.wqu@suse.com/#r

It would be good to add links to such discussions in the changelog.

>
> [CAUSE]
> There are several different factors involved.
>
> 1. RMW mix the old and new metadata, causing unrepairable corruption
>    E.g. with the following layout:
>
>    data 1   |<- Stale metadata ->| (from the out-of-date device)
>    data 2   |     Unused         |
>    parity   |PPPPPPPPPPPPPPPPPPPP|
>
>    In above case, although metadata on data 1 is out-of-date, we can
>    still rebuild the correct data from parity and data 2.
>
>    But if we have new metadata writes into the data 2 stripe, an RMW
>    will screw up the whole situation:
>
>    data 1   |<- Stale metadata ->| (from the out-of-date device)
>    data 2   |<-  New metadata  ->|
>    parity   |XXXXXXXXXXXXXXXXXXXX|
>
>    The RMW will use the stale metadata and new metadata to calculate new
>    parity.
>    The resulted new parity will no longer be able to recover the old
>    data 1.
>
>    This is a known bug, thus our documentation is already recommending
>    to avoid RAID56 for metadata usage.
>
>    > Metadata
>    >    Do not use raid5 nor raid6 for metadata. Use raid1 or raid1c3
>    >    respectively.
>
>    Furthermore this is very hard to fix, unlike data we can fetch the
>    data csum and verify during RMW, we can not do that during RMW.
>
>    At the timing of RMW, we're holding the rbio lock for the full
>    stripe.
>    If the extent tree search requires a read-recover, it will generate
>    another rbio, which may cover the same full stripe we're working on,
>    leading to a deadlock.
>
>    Furthermore the current RAID56 repair code is all based on veritical
>    sectors, but metadata can cross several horizontal sectors.
>    This will require multiple combinations to repair a metadata.
>
> 2. Crash caused by double freeing a bio
>    By chance if the above RMW corrupted csum tree, then during
>    btrfs_submit_chunk() we will hit an error path that leads to double
>    freeing of a bio, leading to crash when hitting the race window.
>
>    Thankfully the patch has been sent to the mailing list.

If the changelog is mentioning this bug, then it should also mention
which kernel patch fixes it.

With that update:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


>
> [WORKAROUND]
> Since it's very hard to fix the RAID56 metadata problem without a
> deadlock or a huge code rework, for now just use RAID1 for the metadata
> of this particular test case.
>
> There may be a chance to fix the situation by properly marking the
> missing-then-reappear device as out-of-date, so no direct read from that
> device.
>
> But that will also be a huge new feature, not something can be done
> immediately.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/125 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index 31379d81ef73..c8c0dd422f72 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -70,7 +70,7 @@ count=3D$(($max_fs_sz / 1000000))
>  echo >> $seqres.full
>  echo "max_fs_sz=3D$max_fs_sz count=3D$count" >> $seqres.full
>  echo "-----Initialize -----" >> $seqres.full
> -_scratch_pool_mkfs "-mraid5 -draid5" >> $seqres.full 2>&1
> +_scratch_pool_mkfs "-mraid1 -draid5" >> $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  dd if=3D/dev/zero of=3D"$SCRATCH_MNT"/tf1 bs=3D$bs count=3D1 \
>                                         >>$seqres.full 2>&1
> --
> 2.46.0
>
>

