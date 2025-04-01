Return-Path: <linux-btrfs+bounces-12727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750C2A77F43
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2C93AF1F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29D20C037;
	Tue,  1 Apr 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwUfnaPG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2C15E90
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522336; cv=none; b=AnERX1jz9DbOMWwQuRiTkOoMX7TlgV0f7QqbreU8v3nsZPJmFVrES45T9fb+lTuxhoGCcZ0FgYgsNnTQna7ftC+X4OVMbY9Vz3B7jFS1eoiPRXWISK3s5qeyo58EbLCzRTyJcvvZBufW5qPyE9KwDaZx9eNWXZteuNFAjiCtjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522336; c=relaxed/simple;
	bh=h3gnC9XB2eBJs3MObJUG1D3ddsL5rpPdxxqkGMSu29A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAFKM96q5RMVfgwJx8xJDv4zySt+jx9rAI3iCCrePnBnk11i7wIwVoAodVU8WsTA9iZemLIfQjyOVmMC/jUNIy+UDn5pqeUcPITrdc6bMU473HMy0ZYy9Iz059L1+GOJM9zGsDrb6xpXTiWlq/KZi5c4z+8M2nAXFq2JpY8sBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwUfnaPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C7EC4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743522336;
	bh=h3gnC9XB2eBJs3MObJUG1D3ddsL5rpPdxxqkGMSu29A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EwUfnaPGj8U+bOU3jZo7udLu4ZZfJB89HZZz9itW1PdxgzD8vBjWKZiSTUYZHAX6X
	 DiSjpoGGgrMazChv616Kcchzjw/4xeIRMJfHSM7mUXI5BhR4FgXn41o8CT4PAzflDF
	 EDhMtkHnUd7RO+zapSrOt9GpbzZ4dBcIzF283FpX2rDfQF/JBJbCzUkkxMdTm1pu6u
	 WF299XeaMuxpLE6mXfcdZMWO2VVw02MWLekmnqkpq7YNk/qZ6NS9gZf0mDWAQbj1Hr
	 nJm2Hd/7I8r2YogQ2gL2bE3oeRq3jOaOJvgCURtZ4yNfs+ATz19WEPlEoqg1Tv+JbN
	 BtXEFtyZAYVwg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac73723b2d5so647398566b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 08:45:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yznj9+sci2eJET0BPxIwwpdXLvWjre8A94IAwJpaPzH4IhT6Nzg
	m/NA9/QBZyO29Bm3KwTh6xcY0hNVU5EW0Fp4uUCqHtzIBeihK2Ql/5Hf3u3exQErQQtG+grYeyG
	LlSelWp7q0Y/NJerS0iNwTYtfBU4=
X-Google-Smtp-Source: AGHT+IHqy0cu1w8NmHqQnK6zWKHy0N5Rglr6TKr3OctEhPwlERNwoy84wLQkbDqCq7nDoJj9qj9ej8CdGKKLD3uXsBA=
X-Received: by 2002:a17:907:2d87:b0:ac6:b816:454f with SMTP id
 a640c23a62f3a-ac738c242e3mr1229369966b.54.1743522334705; Tue, 01 Apr 2025
 08:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743493507.git.wqu@suse.com> <9d2b4cb00e01eb1f42ebf0590d2367d9bd224b7a.1743493507.git.wqu@suse.com>
In-Reply-To: <9d2b4cb00e01eb1f42ebf0590d2367d9bd224b7a.1743493507.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 1 Apr 2025 15:44:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6VSEiXo3OkYDxudtypj4i1m_LmAc8CjTQYjH4g+1aZpA@mail.gmail.com>
X-Gm-Features: AQ5f1JpO9U5Lo1CEQU7zSfvMym1cBnvKL3jethYDYMTNsGvg69w_4caShEEEDw0
Message-ID: <CAL3q7H6VSEiXo3OkYDxudtypj4i1m_LmAc8CjTQYjH4g+1aZpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix the ASSERT() inside GET_SUBPAGE_BITMAP()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 8:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> After enabling large data folios for tests, I hit the ASSERT() inside
> GET_SUBPAGE_BITMAP() where blocks_per_folio matches BITS_PER_LONG.
>
> The ASSERT() itself is only based on the original subpage fs block size,
> where we have at most 16 blocks per page, thus
> "ASSERT(blocks_per_folio < BITS_PER_LONG)".
>
> However the experimental large data folio support will set the max folio
> order according to the BITS_PER_LONG, so we can have a case where a large
> folio contains exactly BITS_PER_LONG blocks.
>
> So the ASSERT() is too strict, change to to

change to to -> change it to

> "ASSERT(blocks_per_folio <=3D BITS_PER_LONG)" to avoid the false alert.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/subpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 5fbdd977121e..d4f019233493 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -664,7 +664,7 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, =
folio_clear_checked,
>                                 btrfs_blocks_per_folio(fs_info, folio); \
>         const struct btrfs_subpage *subpage =3D folio_get_private(folio);=
 \
>                                                                         \
> -       ASSERT(blocks_per_folio < BITS_PER_LONG);                       \
> +       ASSERT(blocks_per_folio <=3D BITS_PER_LONG);                     =
 \
>         *dst =3D bitmap_read(subpage->bitmaps,                           =
 \
>                            blocks_per_folio * btrfs_bitmap_nr_##name,   \
>                            blocks_per_folio);                           \
> --
> 2.49.0
>
>

