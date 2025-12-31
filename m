Return-Path: <linux-btrfs+bounces-20046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70482CEB45A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 06:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A3B83026ABF
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 05:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8430FF2B;
	Wed, 31 Dec 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="DAjOGPuz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36582D6409
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767157263; cv=none; b=CL8bBOKYsIMGSJGClH/0UZ6l+a/lGNPIvOUPWrEhCraGU379Oc0Z6jfcunGzzOTv1UNm/5u1hON/6r+6TedcRfg9l9EZMcpYYkZUd2pBJn4dewarK04xRRVPR86DP40PRxnz1yXh8R7z5yh6BNPKJA5geZrU7dVffMIKlA3N3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767157263; c=relaxed/simple;
	bh=VBLFcK2Z/i1v4Q6q9DBdSOiL2LU92Q5sEB08HQF0mEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEr/vrkfgsUO90piwTJsBCmVwENcBced142pi7MUErU5T6fFKKpXf0GxBmFFXesEFVud1UF9M6dFqESDt3KtYYCuGAzezpM09Ldt8/RrEaEfsSb668kF7/Ly8O/PYIE5TZx3emsyJ/smJGXEha1iLlj+mLCHBW96v3GIa0UMV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=DAjOGPuz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so6108632a91.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 21:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1767157261; x=1767762061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vILZq3yFlzvw/Wkw3qG58Pyg/FPe3qSBf5TB1FRbsr8=;
        b=DAjOGPuzcM4c1JFLq4fxVER/6M0RUqnfGu2a3tllgKobb6KrnG7e4pt8WuJ+N0PCNd
         xto1SZb+gbFX2x2Vo4CLbGZ+NrnxdSTk9cfjTQV4qKoPWgK4xCDU53e7+qoBO2EnzN3Q
         2o7EJIGFb4chr/a6nh0ctp9EbRcXEcqeHlbmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767157261; x=1767762061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vILZq3yFlzvw/Wkw3qG58Pyg/FPe3qSBf5TB1FRbsr8=;
        b=RUM6gMI40c9AwOMtAK5OgT7x9l/5BXy6bR+gUb2Xe7nAd+AZT8+P6jF3MewSyEo2p7
         zeSPa2g72UywHwRWrbIzaK3dVr3K62oe6RScMFEhxbDVYy4OFLIThloINGgqdlUMtomA
         2Ud19aXGT912tn3MThcdJi1UOFSKn0QIY9kutjylTDh3An0GBYuUeG4QO/KuAssPoRWB
         4fjC49iElvzP9p+ieKQ5JIc0eJ4QXGdLp/ywUnlM0BvEGMVe9zKi4XS9GXbJG4wB86So
         I0PhZnNZ/j290klWR7Sjt3sIkLArpcWJv9vua9LxUBbOoQV4FaeCZzr4nZmnS7fkRk9t
         4/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUZVl8XeTjHNCsqj5AOiJpit+xQjvSxbEVv6MplXoQdWBdmATHDKDsqehQTrLqKcm+u+xmd9aZ17eOICQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9HvpMwDNJ51sDpp915cGxlI2oNORluTF0xOX1RY1/aibIoZz
	fBnnzr7EX5GxGKunXfZhQwIQnAXnjC88gVdyUuLzn4MbI4Uakw7+eY7rWeYFuMvxluoRN9h8xpA
	GkSrKYCQjUm+waJv2t+fHO1N4KGmQOMP3kJm30KC8Dg==
X-Gm-Gg: AY/fxX6/SPX9Q4YTyKVsBjWcW21fK3I4gAv1+JRJuZqUVCmsmyLHte491/8FCXIecQl
	CwBSbC7iWcLxiPeZ94NL3aPzhzY4xAYhw7YpxvB9gaAwOw8fdYX0KP59O2AgzG44VMTkZebj2sR
	mZr28AyfdLIbP3LhSo7OFxR1CglVxK0DDZ5+0KvysfGErqwetGcjzS6Db6DmU5/D7XY7waxzeRw
	uZKjW+IhjRQIrvN4ASbevL5lw2ZFbqu2CmQoQ7AtP+ZD/p0wsAPP274O7xLebbReCF+MQ8do4XX
	em/4fEwfyWRmLR22IySt5LgYmUFwCAOoqqS2YPa9adwAmw8JLiDzwZL9etWOTU1ENG3/JnCJCVb
	oLKDV5UACYHbtOk2wqm6+AyxXyMCdR7Qaq+JTkF4zxEukcL+2d5iLs7HFPlHS3mGkHHJzUFLBi6
	BxPOjNt00RzJZYJHFsDgkE9i2YjjbqdEpuNOMEohhgdpRLMSI=
X-Google-Smtp-Source: AGHT+IGGjMZmA3W6Y87SsNuSW7ceZtn070YayGHBvn8dSx3+9rA7ugiw0gFrN5LfWNW1AEidn5d81vbwBN48C3lNPDs=
X-Received: by 2002:a17:90b:4ccd:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-34e90df6ab4mr31867856a91.17.1767157260914; Tue, 30 Dec 2025
 21:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
 <01d84dae-1354-4cd5-97ce-4b64a396316a@suse.com> <642a3e9a-f3f1-4673-8e06-d997b342e96b@suse.com>
 <CAMVG2suYnp-D9EX0dHB5daYOLT++v_kvyY8wV-r6g36T6DZhzg@mail.gmail.com>
 <17bf8f85-9a9c-4d7d-add7-cd92313f73f1@suse.com> <9d21022d-5051-4165-b8fa-f77ec7e820ab@suse.com>
In-Reply-To: <9d21022d-5051-4165-b8fa-f77ec7e820ab@suse.com>
From: Daniel J Blueman <daniel@quora.org>
Date: Wed, 31 Dec 2025 13:00:49 +0800
X-Gm-Features: AQt7F2qT5oHGObC_DYrjXo69zJNwTh7g0QjrZk2RyITMANLNzXLeFHGvNjhYFew
Message-ID: <CAMVG2subBHEZ4e8vFT7cQM5Ub=WfUmLqAQ4WO1B=Gk2bC3BtdQ@mail.gmail.com>
Subject: Re: Soft tag and inline kasan triggering NULL pointer dereference,
 but not for hard tag and outline mode (was Re: [6.19-rc3] xxhash invalid
 access during BTRFS mount)
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Linux BTRFS <linux-btrfs@vger.kernel.org>, linux-crypto@vger.kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com, 
	ryabinin.a.a@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Dec 2025 at 12:55, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/12/31 14:35, Qu Wenruo =E5=86=99=E9=81=93:
> > =E5=9C=A8 2025/12/31 13:59, Daniel J Blueman =E5=86=99=E9=81=93:
> >> On Tue, 30 Dec 2025 at 17:28, Qu Wenruo <wqu@suse.com> wrote:
> >>> =E5=9C=A8 2025/12/30 19:26, Qu Wenruo =E5=86=99=E9=81=93:
> >>>> =E5=9C=A8 2025/12/30 18:02, Daniel J Blueman =E5=86=99=E9=81=93:
> >>>>> When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
> >>>>> checksumming and KASAN, I see invalid access:
> >>>>
> >>>> Mind to share the page size? As aarch64 has 3 different supported pa=
ges
> >>>> size (4K, 16K, 64K).
> >>>>
> >>>> I'll give it a try on that branch. Although on my rc1 based developm=
ent
> >>>> branch it looks OK so far.
> >>>
> >>> Tried both 4K and 64K page size with KASAN enabled, all on 6.19-rc3 t=
ag,
> >>> no reproduce on newly created fs with xxhash.
> >>>
> >>> My environment is aarch64 VM on Orion O6 board.
> >>>
> >>> The xxhash implementation is the same xxhash64-generic:
> >>>
> >>> [   17.035933] BTRFS: device fsid 260364b9-d059-410c-92de-56243c346d6=
d
> >>> devid 1 transid 8 /dev/mapper/test-scratch1 (253:2) scanned by mount
> >>> (629)
> >>> [   17.038033] BTRFS info (device dm-2): first mount of filesystem
> >>> 260364b9-d059-410c-92de-56243c346d6d
> >>> [   17.038645] BTRFS info (device dm-2): using xxhash64
> >>> (xxhash64-generic) checksum algorithm
> >>> [   17.041303] BTRFS info (device dm-2): checking UUID tree
> >>> [   17.041390] BTRFS info (device dm-2): turning on async discard
> >>> [   17.041393] BTRFS info (device dm-2): enabling free space tree
> >>> [   19.032109] BTRFS info (device dm-2): last unmount of filesystem
> >>> 260364b9-d059-410c-92de-56243c346d6d
> >>>
> >>> So there maybe something else involved, either related to the fs or t=
he
> >>> hardware.
> >>
> >> Thanks for checking Wenruo!
> >>
> >> With KASAN_GENERIC or KASAN_HW_TAGS, I don't see "kasan:
> >> KernelAddressSanitizer initialized", so please ensure you are using
> >> KASAN_SW_TAGS, KASAN_OUTLINE and 4KB pages. Full config at
> >> https://gist.github.com/dblueman/cb4113f2cf880520081cf3f7c8dae13f
> >
> > Thanks a lot for the detailed configs.
> >
> > Unfortunately with that KASAN_SW_TAGS and KASAN_INLINE, the kernel can
> > no longer boot, will always crash at boot with the following call trace=
,
> > thus not even able to reach btrfs:
> >
> > [    3.938722]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    3.938739] BUG: KASAN: invalid-access in
> > bpf_patch_insn_data+0x178/0x3b0
> [...]
> > Considering this is only showing up in KASAN_SW_TAGS, not HW_TAGS or th=
e
> > default generic mode, I'm wondering if this is a bug in KASAN itself.
> >
> > Adding KASAN people to the thread, meanwhile I'll check more KASAN +
> > hardware combinations including x86_64 (since it's still 4K page size).
>
> I tried the following combinations, with a simple workload of mounting a
> btrfs with xxhash checksum.
>
> According to the original report, the KASAN is triggered as btrfs
> metadata verification time, thus mount option/workload shouldn't cause
> any different, as all metadata will use the same checksum algorithm.
>
> x86_64 + generic + inline:      PASS
> x86_64 + generic + outline:     PASS
[..]
> arm64 + hard tag:               PASS
> arm64 + generic + inline:       PASS
> arm64 + generic + outline:      PASS

Do you see "KernelAddressSanitizer initialized" with KASAN_GENERIC
and/or KASAN_HW_TAGS?

I didn't see it in either case, suggesting it isn't implemented or
supported on my system.

> arm64 + soft tag + inline:      KASAN error at boot
> arm64 + soft tag + outline:     KASAN error at boot

Please retry with CONFIG_BPF unset.

Thanks,
  Dan
--=20
Daniel J Blueman

