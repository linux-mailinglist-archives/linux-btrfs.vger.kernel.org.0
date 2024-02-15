Return-Path: <linux-btrfs+bounces-2423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B076856257
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C3528BDB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0012C802;
	Thu, 15 Feb 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrF/zM9t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6712C7E0;
	Thu, 15 Feb 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998272; cv=none; b=IN1ea3yIwYnhxTaIkd4UBo61A2h/zJZCjSk6AoWnVBc6J+jjgNtJGPGBg6t+2elSVEfEewibo4UxcF9Qp7Z/BOujoaJ5LjpTxwwpmKfg49rPEF3tlI7VzKKbUx5s5BJarH6EL8o21sIjF1wVL3XjO6z8JHUNn8L3H53/qheiaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998272; c=relaxed/simple;
	bh=Zi+9ekP8in+SzpmUGUfcCJMcONAIsFt2q+i/F3vi5z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKxJQ21z5fYjtNsaTWR9MiLFPxJjoumbW6oe75TV7yj06tdFk8GTWVL1jonPoeb/bQRtPVUd570Ws0Pks+aIDiQGAwWjC84m0R4+o9VmMrsjDL0jQGyJdRYyZyAeSDISnoAj/ND/48IqWCcqonNCGCD3t03EdLLYhAttBt5DCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrF/zM9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C24C43390;
	Thu, 15 Feb 2024 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707998272;
	bh=Zi+9ekP8in+SzpmUGUfcCJMcONAIsFt2q+i/F3vi5z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XrF/zM9t+Kk6nUarYpeyqv0RFNPp5pxBHGUwSHHQqgLIlNpz9WCN/9+S270J+ziW9
	 p5BUggR2TplLmBtFKe+UYSZniUHL4Tg7hy/1eXtQzxhOguVnlPNWsaqBNB19X8/Nnp
	 qcQdhZRbYb7LMk7RMJN58Nf8MhPm54dxErNGdHx3Nt7L19W3Ujm0v5lYPQuTw9azYQ
	 IGbw4oZwtS1xXUSSGduCKuYXrdbwoavWUCdAIwFCPmT+W9+5XdZk1qCzksf7vusFke
	 T79YwCztM44lWo9JywcELWfpIc7ZkNXjjz1wBBRQayUfVYOMp3tp0Fw1ie2iEthEse
	 rOIqtV0/EQBjA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso10721831fa.2;
        Thu, 15 Feb 2024 03:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUJWeBU+eyFUhX5KhaLQTjKVdyJ7q7RA7U9TGiMbPQ0MLqEQ4pLVxgrqkOKig76M0CDwTSS2jHdBBsob3WiksJ5FH9HwKcpOE5jBE=
X-Gm-Message-State: AOJu0Yx6dCoww4mRysepxoUmVbG/M6idQANcc5L/kcASjA3C6HNdeO7y
	mZr7mvdLmjTRbFpNkOS+DgGAowgDDaz8W48NHDxbaySS5emmT8Sd2EKqnAZaWNAFh+xstLdJQqK
	xqAE5wB9tPhT19/tSP3Rc6tLw6SE=
X-Google-Smtp-Source: AGHT+IGQSmzUsz5K8ksWPNWh0TEHkA+u9qG7A9v/BAx1nAacDtLS/yFb4QSYIw+HFQ0gAe/EPXjmnz3faJwWYoYDPDo=
X-Received: by 2002:ac2:5f83:0:b0:511:6e10:b80e with SMTP id
 r3-20020ac25f83000000b005116e10b80emr1342997lfe.33.1707998270236; Thu, 15 Feb
 2024 03:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <8b09597200b5ef28be39ed3658d84e9b22febea7.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <8b09597200b5ef28be39ed3658d84e9b22febea7.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 11:57:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6q=52q5OwXX0TmTLWCnSE4Zapwawg6vxPfHDGbtZeamw@mail.gmail.com>
Message-ID: <CAL3q7H6q=52q5OwXX0TmTLWCnSE4Zapwawg6vxPfHDGbtZeamw@mail.gmail.com>
Subject: Re: [PATCH 03/12] btrfs: introduce tempfsid test group
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:37=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Introducing a new test group named tempfsid.
>
> Tempfsid is a feature of the Btrfs filesystem. When encountering another
> device with the same fsid as one already mounted, the system will mount
> the new device with a temporary, randomly generated in-memory fsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  doc/group-names.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index 2ac95ac83a79..50262e02f681 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -131,6 +131,7 @@ swap                        swap files
>  swapext                        XFS_IOC_SWAPEXT ioctl
>  symlink                        symbolic links
>  tape                   dump and restore with a tape
> +tempfsid               temporary fsid
>  thin                   thin provisioning
>  trim                   FITRIM ioctl
>  udf                    UDF functionality tests
> --
> 2.39.3
>
>

