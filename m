Return-Path: <linux-btrfs+bounces-17315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60431BB151C
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 19:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF4B18817A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613C2D24BF;
	Wed,  1 Oct 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8t0kuuE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014D208961
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338659; cv=none; b=iMDNVwoARM+PwKpI7rd1HpR9JMTCvlOvDBypLJ/Nl8/EMJdXDzG+jpfulnlkFrZ2vLAB5DDGbx/srlAOAvpBS/Sor0Edz8hzDPXgh9mNsDPQb3IIubpU9OVp5vLPAleJPOEwBVJl8W5qiXaQQ0zZvfeduM7x83ziZaNPy+lH3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338659; c=relaxed/simple;
	bh=47KD6OvTADXEiaLBZChYAp5qToz9/RaQ5FYA6W51VQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMuyW5bIMWhhOSiMsNamtOJRkO5Pe3/87n654e4SfWHaHzHkDn6rrGVC+7CDldqN+ZgZRa/8D9PZIUhpPnHfMmdu6uAGJSdqOmaDrOTCaMSOqlItRRbnk4i/ClujYCU9n5xxEa8aVp1JD+aZN+XAyENrCSaXstH/DnVaLYspS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8t0kuuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1772C4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759338659;
	bh=47KD6OvTADXEiaLBZChYAp5qToz9/RaQ5FYA6W51VQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a8t0kuuELLBh28skyKG+8xPvpCciwIAFyVpetK/hyZDHhcYMCBmSdAMi0MLOajmcg
	 JlhzGPbKlNrsFqoMcvySPydXYrvYoI30lSiiBgOjKGm/7ZRZF9YhLGj5m9veSKCeca
	 BLpy4w0p6GPo9VDagDmHyX0ycAL4nGb/0OhSDurP4lkV32dVDy5CdMjVx0uVMJTTLJ
	 arFUODS9PMWfoUj7f0Pxy/CUv/57Lgj70msl+4nO/1od+BWcQVAsG6UowDdMtlJbfx
	 nEjBu/HGtPue3MLA3RJpK7HydAxGMYi9mfuicPoBtZtZKEwTIUoHxF45vcEsK0hcU6
	 EZ/0lSiebCdfQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso21638066b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 10:10:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyceo0yXu5Xt2uCeRfubE1boj33HOeX4uaDYHlBc9vDgRjCh/2m
	/Y9vyYy0/qh6l+mRMnzdLnwszGlIWKEgPSJFUTh3wZ0jZJaU76SRLhop7TEeHrRqt0H1O2zQKEv
	kUYWkOPEuTNBLNHFhO1BY0yEF1mxOQWI=
X-Google-Smtp-Source: AGHT+IFurj7T96UXmg7rqHWI8GsvLaunW97Fw5F3PdNA7y7eCpi0toFupBAQEB/hGk9qVCxDW0E+ha23ZkPdnwjWQ/A=
X-Received: by 2002:a17:906:f59e:b0:afd:d94b:830d with SMTP id
 a640c23a62f3a-b46e7cafd1emr560425866b.62.1759338658252; Wed, 01 Oct 2025
 10:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <763f1e5a6d9611638977e24aeead5c9a266da678.1759337413.git.boris@bur.io>
In-Reply-To: <763f1e5a6d9611638977e24aeead5c9a266da678.1759337413.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 1 Oct 2025 18:10:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4uPf0+dV=7-x4GyfqU2SxW1uzr5iT32aH10Pupa6r81g@mail.gmail.com>
X-Gm-Features: AS18NWBJmhqAnqqc7WcfLgzbNg0TbtzzVQ2K4HH06sdK9ucUqlXEsrGXv9bQ2aM
Message-ID: <CAL3q7H4uPf0+dV=7-x4GyfqU2SxW1uzr5iT32aH10Pupa6r81g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix incorrect readahead expansion length
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:51=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> The intent of btrfs_readahead_expand() was to expand to the length of
> the current compressed extent being read. However, "ram_bytes" is *not*
> that, in the case where a single physical compressed extent is used for
> multiple file extents.
>
> Consider this case with a large compressed extent C and then later two
> non-compressed extents N1 and N2 written over C, leaving C1 and C2
> pointing to offset/len pairs of C:
> [               C                 ]
> [ N1 ][     C1     ][ N2 ][   C2  ]
>
> In such a case, ram_bytes for both C1 and C2 is the full uncompressed
> length of C. So starting readahead in C1 will expand the readahead past
> the end of C1, past N2, and into C2. This will then expand readahead
> again, to C2_start + ram_bytes, way past EOF. First of all, this is
> totally undesirable, we don't want to read the whole file in arbitrary
> chunks of the large underlying extent if it happens to exist. Secondly,
> it results in zeroing the range past the end of C2 up to ram_bytes. This
> is particularly unpleasant with fs-verity as it can zero and set
> uptodate pages in the verity virtual space past EOF. This incorrect
> readahead behavior can lead to verity verification errors, if we iterate
> in a way that happens to do the wrong readahead.

So this misses being clear, explicit, about the worst problem:
buffered read corruption (even when not using verity).
In that case the readahead loaded data from C into the page cache
range for N2, so then later anyone doing a buffered read for N2's
range, will get data from C.

This should be easy to turn into a test case for fstests too.

With that changelog update:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>
> Fix this by using em->len for readahead expansion, not em->ram_bytes,
> resulting in the expected behavior of stopping readahead at the extent
> boundary.
>
> Reported-by: Max Chernoff <git@maxchernoff.ca>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2399898
> Fixes: 9e9ff875e417 ("btrfs: use readahead_expand() on compressed extents=
")
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dfda8f6da194..3a8681566fc5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -972,7 +972,7 @@ static void btrfs_readahead_expand(struct readahead_c=
ontrol *ractl,
>  {
>         const u64 ra_pos =3D readahead_pos(ractl);
>         const u64 ra_end =3D ra_pos + readahead_length(ractl);
> -       const u64 em_end =3D em->start + em->ram_bytes;
> +       const u64 em_end =3D em->start + em->len;
>
>         /* No expansion for holes and inline extents. */
>         if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
> --
> 2.50.1
>
>

