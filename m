Return-Path: <linux-btrfs+bounces-12199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DD1A5CB66
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66777AB3C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E3261596;
	Tue, 11 Mar 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEbZEv/Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D6260A21
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712081; cv=none; b=AFM9l2xNFg5u9Q5AEdZB72IcxcqiKt4tfZGp9pXO7qSM6lihWL6x5RHITp3pLQlrAKfoRtWHta0cS01eTskDr56mO+dlmnbzLG06WfgXsuJvBLcBAPJJE8PhWerAhApAjgbbSVanxkpAYyjqtxOWJeqyn9nzxYB8eyc4aDakeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712081; c=relaxed/simple;
	bh=i5kOh3BxqjAblQrjCy6JxXEO+/UiggBVXYXUSd5XwJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjAc+7L5H2hGHNGOqyG7MGzGV4cEwv9l+cXR1iQBlxUTFaPZyLcaGmIqbTxPXoxyvbzw3BWeCbS0pYjt449kwhNyzSBk8TTAW6BJ/22KX+v3M1FkUMGqBnnkvsvSDOY5Udk68DNfoVlknWgmf3HQ0vfkWJLA4jgwiwGVCRHc+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEbZEv/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC6BC4CEEF
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741712080;
	bh=i5kOh3BxqjAblQrjCy6JxXEO+/UiggBVXYXUSd5XwJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BEbZEv/Ypq1xz+NFxrfH76N/oOdXz0zf7WROu+NhUiJEsfef9R7OUc7/q2phxThv3
	 NFDD5rokf07n5HDDSmFhaWSl2YQhEyJ+/WUGePKsRkPa1Njh6McbjOmycNy3EZf0PN
	 zR3t2RVpsZAgFBVObTHe7ty8dnMZ1DTqNODYilyzGShEcCSqaM7bzcZig4J9X3Tapf
	 x8OxbJKskZUbJU9LrAvR+4Yc4d2bZms5jZ62aRoNFY6Lx2Z82qZfFJdcId/AIX+VA3
	 9Ggsox/efit0U3IlC51p8pKLK56jB9z+Q97V8m8aHOaNY87XFfWRD7/8jnSGqbn0ZR
	 FB8o33tIy671w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1174598066b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 09:54:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw6QjB4gJ7eVg88Zwwc0FsN5Yq+MrOt0k7J+4+AZg7TTtENOpGD
	GqX2gG1qWVGel4Kn5f5Yto6zjFDXd/f/U7UQUP4RMg24hAgNwFymV78b7tbF2uC2P3pWBWaUGWK
	iOSVUIYnQGg9rQCuLtFEZn9yANqo=
X-Google-Smtp-Source: AGHT+IHl0DvT6vPMjZyyATxnm1XZIRhkLcA3sTZ50poLKRQ50KoTZW/8HMNLLWmvuS/h0dFJPu9Uzi8s2xCnoAhQGIc=
X-Received: by 2002:a17:907:7e97:b0:ac2:7bd9:b2f with SMTP id
 a640c23a62f3a-ac2b9db5b66mr537712166b.9.1741712079014; Tue, 11 Mar 2025
 09:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311163931.1021554-1-maharmstone@fb.com>
In-Reply-To: <20250311163931.1021554-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 11 Mar 2025 16:54:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5aMFgD_p5vE_9jkLN=-vMK-qQinZPaR1d1GUN5iTYjgA@mail.gmail.com>
X-Gm-Features: AQ5f1JrOCOr56J19cYrpvPsbC-IHP-7KqdwolvNXoCu7y54Ik4jW1cBxqG_ak7c
Message-ID: <CAL3q7H5aMFgD_p5vE_9jkLN=-vMK-qQinZPaR1d1GUN5iTYjgA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't clobber ret in btrfs_validate_super()
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 4:39=E2=80=AFPM Mark Harmstone <maharmstone@fb.com>=
 wrote:
>
> Commit 2a9bb78cfd36 introduces a call to validate_sys_chunk_array() in
> btrfs_validate_super(), which clobbers the value of ret set earlier.
> This has the effect of negating the validity checks done earlier, making
> it so btrfs could potentially try to mount invalid filesystems.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Fixes: 2a9bb78cfd36 ("btrfs: validate system chunk array at btrfs_validat=
e_super()")
> ---
>  fs/btrfs/disk-io.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0afd3c0f2fab..4421c946a53c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2562,6 +2562,9 @@ int btrfs_validate_super(const struct btrfs_fs_info=
 *fs_info,
>                 ret =3D -EINVAL;
>         }
>
> +       if (ret)
> +               return ret;
> +
>         ret =3D validate_sys_chunk_array(fs_info, sb);

While this fixes the problem, the function is structured in a way that
is easy to get into this sort of issue.
Rather than set 'ret' to -EINVAL every time some check fails and then
continue, I'd rather have it return -EINVAL immediately.

Anyway, this fixes a bug, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>         /*
> --
> 2.45.3
>
>

