Return-Path: <linux-btrfs+bounces-2459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F7858555
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2352EB20E87
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1C1350E3;
	Fri, 16 Feb 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUmVFFX2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084901EA87
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108557; cv=none; b=KB1I+S5uCR9S3FO7W9PJ/D/SohkQsRsVf13diZyGrwUbS72rcLLcNk/XYAVavYDVSWcdw/+1J2H+jGEL9ea0wgi/buvxC+Rd7AiMu084v2R8/GC7Hu7b1rqPF+j9qlXiO5r5j1KKBg1xJtA3RpBWaiSbkQCatHNNWWUvdppilgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108557; c=relaxed/simple;
	bh=xyBo6thzSW9aStXqGYFPhGJ10xGEoYxvbng4OPcUX0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okj7A17myFFvWqMm9JNWGdHi3jZ1NMF2w/gAVGYEOu9DQstPCdtvhAyfMH8gNfEoP0rob/h8cccgBfFcgzsjXTY2dI70vUcrp1AUBPNU+h4GN/cor2k4YNJzYL6a9f/46FFpAo6NiaqqThfexZwuRVIy+jDfOtgXmmOfTXc11XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUmVFFX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73923C433F1
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708108556;
	bh=xyBo6thzSW9aStXqGYFPhGJ10xGEoYxvbng4OPcUX0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cUmVFFX2JfCz+1Du8AtisouAcK7gsOXZipUPuo9bj2y1n2AF3hMf0s6baFFJyo48o
	 LYfm5m4eOApLuqxCmxO/Y9lB2kj/iqG9wolmfXcjcaT3B+z/G8NjzHySMWBDVOcUhQ
	 gJ1zMywcHL5pHnFgme+x+QQ97YfUAWkNeoWtOv8Ca922Lc2E4nsQzs8AK0WFb51Co5
	 dy47TYzTbKkaN7wRhSXYDwM1TbSJQiEoBtNLgC9upaxqp1RTL3oqe7d4f5p+iDG4C5
	 YeffWm7WKHr9TYSkbErHpTW8aKrIzWJ47AuukBF1B7UGpfZ6F5Dm9yYm3+8YV9VRdp
	 2cPIF9jwznxOg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a271a28aeb4so140118566b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 10:35:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yxmefio2XHPdOEyKA5cIGSU3Z751tsDIBvI5R1gueXIf9bb74pe
	R2JaTjQ7m0oCwEkTDyEoxQZ08hsXkOXx4qRDqF4un8NmB9iQZFwBgBTu8vdlMRPKo5yoHtm7tig
	csHF3suncwh7NUGNNGVZ8ZU5SApE=
X-Google-Smtp-Source: AGHT+IGgN1qigFYsvLm6mDjk/p1K2lssq5s6Li6tKjDMZTBRH9k51YCAMfyjxtqIvkAGDshIiMOVEuCCcIDy3zPj90A=
X-Received: by 2002:a17:906:b17:b0:a3d:9144:93d with SMTP id
 u23-20020a1709060b1700b00a3d9144093dmr4158489ejg.19.1708108554878; Fri, 16
 Feb 2024 10:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me> <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
 <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me> <29b50a95-025d-41c3-bee6-f51888b28487@inix.me>
 <CAL3q7H41FJ1KV281OQKpozbtONLcEFoaMpZ2nCKhgTNR36GUCg@mail.gmail.com> <762c0677-56d9-4a02-bfc2-581b9f3309c9@inix.me>
In-Reply-To: <762c0677-56d9-4a02-bfc2-581b9f3309c9@inix.me>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 16 Feb 2024 18:35:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7-iO_CqR5PPaqTM2GdpsNtV2-EeSU=mxOwE2++Ggg1EA@mail.gmail.com>
Message-ID: <CAL3q7H7-iO_CqR5PPaqTM2GdpsNtV2-EeSU=mxOwE2++Ggg1EA@mail.gmail.com>
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
To: Dorai Ashok S A <dash.btrfs@inix.me>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:24=E2=80=AFPM Dorai Ashok S A <dash.btrfs@inix.me=
> wrote:
>
>
> On 16/02/24 21:05, Filipe Manana wrote:
>  >
>  > Ok, now I understand your use case.
>  > So I simplified the script to:
>  >
> ...snip...
>  >
>  > Which reproduces the 2.5G stream:
>  >
>
> Thanks. I am glad to hear you could reproduce this.
>
>  > So this is normal, because the file backing the thin device has holes,
>  > its size is 3G but only about ~77M are used.
>  > The thing is send doesn't support hole punching, so holes are sent as
>  > writes full of zeroes in most cases.
>
> That makes sense, it also explains why receive creates files that take
> up lot more space on disk.
>
> One surprise is, for any change to the disk file, such as I could just
> do `touch thin-disk` and it will still be a large send stream.
>
> # Touch
> umount thin-mount
> btrfs subvolume snapshot -r $(stat --format=3D%m .) 4.s
> btrfs subvolume snapshot -r $(stat --format=3D%m .) 5.s
> touch thin-disk
> btrfs subvolume snapshot -r $(stat --format=3D%m .) 6.s
>
> Output:-
>
> # btrfs send -p 4.s 5.s | wc -c | numfmt --to=3Diec
> At subvol 5.s
> 178
>
> # btrfs send -p 5.s 6.s | wc -c | numfmt --to=3Diec
> At subvol 6.s
> 2.4G
>
> Is this expected?

There are a few cases where we send the writes with zeroes where it's
actually not needed.
I just noticed an hour ago about one such case triggered by that use case.

So that can be improved, I'll send a patch for that on monday and let you k=
now.

>
> This all happens only after running fstrim. If I never do a fstrim, this
> doesn't happen. Also, I am able to avoid the large send stream by
> removing the holes with `dd if=3Dthin-disk of=3Dfull-disk` and using
> `full-disk` instead of `thin-disk`. This approach will work for me at
> the moment.
>
> If we could support send/receive holes, it will be useful for
> incremental backup of disk images.

Yes indeed. That however requires a change to the protocol to support
a new command (hole punching), and changing the kernel and
btrfs-progs' receive implementation, not something that can be easily
and quickly done, but has been on hold for years.

Thanks.

>
> Thanks for the help so far.
>
> Regards,
> -Ashok.
>
>

