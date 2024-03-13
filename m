Return-Path: <linux-btrfs+bounces-3269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7B87B561
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 00:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A77BB21544
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 23:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D555D75A;
	Wed, 13 Mar 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5BcM3i2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000859B42;
	Wed, 13 Mar 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374026; cv=none; b=GuPMIllOObzuIQkNYwM2ujp8suVck1+hAK6zNP+GIBC8+MaMqUGk/x0hb5/gfDPU1oMyy6YLQnFfgpwO467goG6Zsge5qKpS79FpOmM8QTDVcUJC58e6OYjD6EQwyl9JC8O2OC2AIE1y6h4u3KDQOuZJxhSHJ/PU6xE0uQCKokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374026; c=relaxed/simple;
	bh=YXVex9z9Q+3r7yWj01TrADTbS+C/C87up1v7kZ1KTxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ1oP9t37zOVnoFmFPj3VgIsNRT6EcOUwDlQ8hTMr4PzkwvLDTfqXecWtC349ORlSN9oM4g2clBZuiD/AGTvixC+FbQQweEZNWhaXVLwb2YFD0sDXdq6BzGvCwQwg65bgCN5zkJ031Y1dXZKGDoEJ5k1HT8DIjghWuhD0WT9lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5BcM3i2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD240C433F1;
	Wed, 13 Mar 2024 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710374025;
	bh=YXVex9z9Q+3r7yWj01TrADTbS+C/C87up1v7kZ1KTxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M5BcM3i2vEDXxfHRf+cG5pIsjv4OmGoZiQR9bCw0jLGsLqfXLYZInhhPbtvzOGaSL
	 EV6EQxTqq2zhP7lQSH+touFqnwjRNexq5Dho3snDPcn0ofJitqe4vH9c7amfU2WU1J
	 tS+JCtsLfNSybfuVcVayVMSm7ffTGZhL7BmaOXUVETzxTSHu+DgQGQ/IggNGGCpCJk
	 ByIsNiEZLafKBwDjclyikEa7FqOanniDiF1TSMqrtmtC3lwiIqy78s8+2H6NKoawog
	 jOO3zIMuprpIpHa2fcfNNdvHI26y1wfjieP5/jiAFk7iOwLvzXF+tE6Sv8cd4FpmVf
	 /kSr9NTF8a3uA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a449c5411e1so46621566b.1;
        Wed, 13 Mar 2024 16:53:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV974TqAe9gdja3y0sLN9GEoltaofCuHAONKQXdpwH6ZiVc1nmKWwfJ86m8b+GXU1HA4g033q3Oy1XDYogV4mto8vcSkIaO/w==
X-Gm-Message-State: AOJu0YxBoq1WZRNpHBl23o6Vzo0ruu4zIa7wNXpHU+EMWzrej2+0dJa6
	Q4G0McOtUdDuMuDA1NXW747HWmgI3hkFVA2THSySeROmnvhM9oauXyYVyPyoXmPcxDm1sKtH0eb
	FU7EerRseo+40ZmWZ9JOtRas3b4c=
X-Google-Smtp-Source: AGHT+IGrJ5s7uh2nnEWkwuYg5oR2bP3BpMC+I3g7h0QXfz6Cy8tmbDQlEgK5ynX3xOkMTZwNi2fCi6VwTBPeTgMDxEc=
X-Received: by 2002:a17:907:a642:b0:a46:628f:4072 with SMTP id
 vu2-20020a170907a64200b00a46628f4072mr71117ejc.0.1710374024267; Wed, 13 Mar
 2024 16:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
In-Reply-To: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Mar 2024 23:53:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5HsNLFJ_nHpFQZBGdy+-R_dz1FEMnAQkNPiuawHewWNA@mail.gmail.com>
Message-ID: <CAL3q7H5HsNLFJ_nHpFQZBGdy+-R_dz1FEMnAQkNPiuawHewWNA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/277: specify protocol version 3 for verity send
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:45=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> This test uses btrfs send with fs-verity which relies on protocol
> version 3. The default in progs is version 2, so we need to explicitly
> specify the protocol version. Note that the max protocol version in
> progs is also currently broken (not properly gated by EXPERIMENTAL) so
> that needs fixing as well.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/277 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/277 b/tests/btrfs/277
> index f5684fde1..3898bda4d 100755
> --- a/tests/btrfs/277
> +++ b/tests/btrfs/277
> @@ -84,7 +84,7 @@ _test_send_verity() {
>         echo "set subvolume read only"
>         $BTRFS_UTIL_PROG property set $subv ro true
>         echo "send subvolume"
> -       $BTRFS_UTIL_PROG send $subv -f $stream -q >> $seqres.full
> +       $BTRFS_UTIL_PROG send $subv -f $stream -q --proto=3D3 >> $seqres.=
full
>
>         echo "blow away fs"
>         _scratch_unmount
> --
> 2.43.0
>
>

