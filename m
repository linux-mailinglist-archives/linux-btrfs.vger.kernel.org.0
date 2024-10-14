Return-Path: <linux-btrfs+bounces-8899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6599D3ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456161C25CE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D71AB538;
	Mon, 14 Oct 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsPTJ0Os"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA33231CA4
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921082; cv=none; b=BSLDXUsTrf5TIc6RWwH/azB/WqN3U9M0HYjzQ+dA3UmPBvo/GiH5sYxEjtoRCDPol4xCfnvxrx1uovhOOG7V/1EvD1n+vEnWeossVyk4i5xLvHItnSbgUB/KdGAWxuE9ke07l61imrhcY1jEAZCriRqlqOQxDSK4cVSoT//abBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921082; c=relaxed/simple;
	bh=PeORxTavIJte9CCxu7JxEIyRT8nIZo9GLbLb3wSEEjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuraC5YBtIhjSQxFkC1rG9hC5PR/mB+ucg6qx2INaHNGMHoIPugzXRPgxCxhFv10IqM7mjtu1c0LCSO0UG2Us2OpT51vvxpipSv2dCj5a24vxZFDnzi6LSY9UupmIv2fJSoxmnmWLwSd4iaXCXHWKicqKNAZSkoGXsZBrQPreyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsPTJ0Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB81C4CEC3
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728921082;
	bh=PeORxTavIJte9CCxu7JxEIyRT8nIZo9GLbLb3wSEEjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BsPTJ0OsKO+140bXjMOoHJPRdbGKPgoa5P155dGC1eNLWNErCRtL5Qh/4oSL+5k81
	 S8JsyTBZLfNRUfqgVW/O/6g5gppgb5Yl8y/qJ8QnbUIS30/jfh1dxwfnfQkWJ6qwW0
	 52B90ig4ON9YvlaF1BuTnplrUX6/1Hb2o4//eDor+UwcGn8dTXHnnNEtBEEj7XYcwW
	 mhLH0Wf/2SIV1hs72f77OOjbbDKtQA7L40KvJ8o4NQZlAa1O9Flo4qdxsJxRYzDGwv
	 h2vK06gulP/uNp3zE3T8QDjmOLq/ZN37+6qNoBppbWPbQNHrcqv2iHF1XXlL9OXaXJ
	 QD/RJYi+W3sDw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f58c68c5so1873695e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 08:51:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGvf3OQ4/K3hPWUoVUyLTK4uO5iu65kPMF78l/bkKPe47V0kFd
	QtwtDXWOZ9Nto+ATO5NNQ1DMk/EMa30/71KcppxIVKKlAkE+iNL3BwQ0WzVrP/ASW9Dcs4UcJUu
	vAFqUBfdQJ9Mr7bkPNStzN2NlsSM=
X-Google-Smtp-Source: AGHT+IEOBtTD1teDzrAJatdF386+5VYLn/WWnnDydoUQ2/GYQg9GErgVS7fGnkmbJCuWXTiqdfVGN2CGkYvqT7uJWR0=
X-Received: by 2002:a05:6512:39c7:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-539e550179cmr4805075e87.25.1728921080652; Mon, 14 Oct 2024
 08:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182416.13d0f8b0@nvm>
In-Reply-To: <20241014182416.13d0f8b0@nvm>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 14 Oct 2024 16:50:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7i0Tgg9ZvCEfCuQS2aoBqoK4BRdmUAX8Yp44=w2MHFJA@mail.gmail.com>
Message-ID: <CAL3q7H7i0Tgg9ZvCEfCuQS2aoBqoK4BRdmUAX8Yp44=w2MHFJA@mail.gmail.com>
Subject: Re: Issue remounting from compress-force to compress
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 2:24=E2=80=AFPM Roman Mamedov <rm@romanrm.net> wrot=
e:
>
> Hello,
>
> Just faced this when trying to change a mounted FS from compress-force to=
 just compress.
>
> Initial state:
>
>   # mount | grep btrfs
>   /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress-force=3Dz=
std:9,discard=3Dasync,space_cache=3Dv2,subvolid=3D5,subvol=3D/)
>
> Remounting:
>
>   # mount /mnt/p1 -o remount,compress=3Dzstd:9
>
> But no effect:
>
>   # mount | grep btrfs
>   /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress-force=3Dz=
std:9,discard=3Dasync,space_cache=3Dv2,subvolid=3D5,subvol=3D/)

It turns out we had an unexpected change in semantics with kernel 6.8+
due to the migration to use fs context, as compress-force is not
disabled anymore when specifying only compress.
I've sent a patch to bring back the old semantics:

https://lore.kernel.org/linux-btrfs/4d68f9e1e230dba0dfa70fb664540a962e0ae05=
5.1728920737.git.fdmanana@suse.com/

Thanks.

>
> OK, remounting to no compression:
>
>   # mount /mnt/p1 -o remount,compress-force=3Dnone
>
> Success:
>
>   # mount | grep btrfs
>   /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,discard=3Dasync,sp=
ace_cache=3Dv2,subvolid=3D5,subvol=3D/)
>
> Now, I expect to enable just compress:
>
>   # mount /mnt/p1 -o remount,compress=3Dzstd:9
>
> But suddenly, compress-force is enabled again instead:
>
>   # mount | grep btrfs
>   /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress-force=3Dz=
std:9,discard=3Dasync,space_cache=3Dv2,subvolid=3D5,subvol=3D/)
>
> This is unexpected and seems like a bug.
>
> The only way to achieve what I wanted was:
>
>   # mount /mnt/p1 -o remount,compress-force=3Dnone,compress=3Dzstd:9
>
>   # mount | grep btrfs
>   /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress=3Dzstd:9,=
discard=3Dasync,space_cache=3Dv2,subvolid=3D5,subvol=3D/)
>
> Kernel version is 6.8.12-2-pve (Proxmox).
>
> --
> With respect,
> Roman
>

