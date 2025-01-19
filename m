Return-Path: <linux-btrfs+bounces-11006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4BA1608D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 07:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209F218868F1
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E6157A46;
	Sun, 19 Jan 2025 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkE/dSgh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977C29415
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737267727; cv=none; b=OAH4Sv2mpGQ4byQstGcAOCTpd+155MyUN6HZSbt8HrOS38sQRh+zYVRIM6TgveW115Y6ix9VD7gx6B8J0JGA/AAYsbqwJStNK64GLmMCq7mVZVVgo3zxiMBh6wAjFyv18euCNGs1gdbe+Ke0hhYVWR648EzEdFEjb1vtnzc7VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737267727; c=relaxed/simple;
	bh=uEnEzvkzalKPOD1unKIbFjUEkhQh2BhyAQW7IPyk/mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXQsyBLvjJbbGpMFzdiQAMBFgrZTRWG6uFKVklfvompmSAfe/CQXoH/naPu3zbgPm3+bgvSJFAVhxxwlQCXLBGTfQgev0Jg/KRAtKoFwYM0BtfVHKq56tIt3g2QXUxG9IY25hmy1OFUv2mgZx6AEhhy+LMMcAkr2Gfl8uD8xUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkE/dSgh; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53a91756e5so6298970276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jan 2025 22:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737267725; x=1737872525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJdhp9IklRGg0e1njzKBaDpu7iYfzncPxiNpE8JJTSA=;
        b=BkE/dSghcqLvAahpkf7l5uTBPlDIDyqymt8KP1Ug1JC1eT0JCLkXGxfIRiOYNg/OiW
         4+PDD2QIvz2PXHpuogvGAFpAWB+OXdcSSiZkOFRuBJJiSfA8Dh+y8551EnlR+igMbSAQ
         3oRQyzzV2AwQA/T5n0hNfVHX4adfPMnBw0/11eIseM+W5N5U3gZAD7Z7wOIHze4ZyYBV
         QWNsRT2L85WLmTEJ77ojtMNCEpskpABjcAnJmoxUcs7YtpXWTlQHc6BVcNnc4SiRecqF
         IfUoSMitO7BzAoFpzIb3b3zsZQqJTzSmSA/DDC1vI6+xgOBetlG8scKJWD+0+njCV4M3
         JkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737267725; x=1737872525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJdhp9IklRGg0e1njzKBaDpu7iYfzncPxiNpE8JJTSA=;
        b=QfEJIbnvs8M5t+oxW8eUHiHAmR1eQ+KTgI9c2jMMxS3qo4YEVTtI63A+8IjldosvbM
         KROOqeuSPwbjBDF1bA7FiBrngEyWN29pdeNzdQiyzoPfYIV8eVxElEcaSMS/ol5M/sUw
         3Th5KF5uXLl5JeHsxv1k/I6hjdflC4+OWVjbDtrvTaH80/+H7JkeMIAoWIBk4xF668VT
         cLSFAJrHG3hNfGx/0mjLalVaxUtViwUz/QjvCjAOxbkyYSkIZFcIMOgNyikD3LyTfcXH
         BmdQPWmaMOxvBNlPDRzd9i7f91H5BsYmqpTqbXTBaz5BehA827QKmRTntK2WJLXGlrTS
         ObVg==
X-Gm-Message-State: AOJu0YzU5jN2xqI9L1wm8fI3M4240Cb9+plAq2pnIZLzaVb2Pm3EJbFt
	Um6+bwHu0PWU/I197URCfBQwlA00+eQSri1o9DunoBWKR5jYVOnrgvg3zUUZBHiXOJbYJ7o3C0n
	jFAynW7GXU9PZeX30ZCicn88f2dw=
X-Gm-Gg: ASbGnctsHusFyigNhQ8pa0IuxVEloTY6y/De8ZWsBUd/8F5nu0PlGoJvK+PlQAnLBC8
	lgXvrXnu8LQs7YHZfM+tvjOxAq3iWKdS12v4+q9Gg5Dcpn8JDxgg=
X-Google-Smtp-Source: AGHT+IFmh/nrIdvDjKPsixfs0gdXHbC9vJrUPTHhdkZsV/e5RIabpZC8ycu3MiAsa1p2svbQqElzA7xcdKHPSFGXnQM=
X-Received: by 2002:a05:690c:7091:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6f6eb65c979mr71017607b3.4.1737267724816; Sat, 18 Jan 2025
 22:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com> <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
 <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com> <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
 <b2267eca-5528-4cec-8956-d0f666f79c9c@gmx.com>
In-Reply-To: <b2267eca-5528-4cec-8956-d0f666f79c9c@gmx.com>
From: Dave T <davestechshop@gmail.com>
Date: Sun, 19 Jan 2025 01:21:54 -0500
X-Gm-Features: AbW1kvaTIb2-LzdARFqd40NGuXB_bqIskZqLSRkQ-YKuQylXnQDZKlTnCv4dpNw
Message-ID: <CAGdWbB46VJrjDMUxcNmeXsAfxq+YCD52v4pKcHK7OjpRpgc8rA@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you. I will run the btrfs check --repair" now.
I guess I should also change the metadata to duplicate from single, right?

> Anyway, I'd still recommend a memtest to rule out any possible bad hardwa=
re RAM problems.

The laptop doesn't have ECC RAM. Is it even worth it to run memtest?

On Sun, Jan 19, 2025 at 1:19=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/1/19 15:02, Dave T =E5=86=99=E9=81=93:
> > It's Arch Linux and kernel version 6.12.6-arch1-1
> >
> > Here is the output of btrfs check. (FYI - BTRFS runs on top of
> > dm-crypt, and I passed the "--readonly" flag to "cryptesetup open"
> > before running this. I guess that is why it says "log skipped" below.)
> >
> > [1/8] checking log skipped (none written)
> > [2/8] checking root items
> > [3/8] checking extents
> > ref mismatch on [300690628608 16384] extent item 10, found 9
> > data extent[300690628608, 16384] bytenr mimsmatch, extent item bytenr
> > 300690628608 file item bytenr 0
> > data extent[300690628608, 16384] referencer count mismatch (parent
> > 404419657728) wanted 1 have 0
> > backpointer mismatch on [300690628608 16384]
>
> This is the root cause. data extent 300690628608 has one bad parent that
> can not be found.
>
> Unfortunately I can not find related item in the tree dump to verify if
> it's a bitflip or not.
>
> Anyway, I'd still recommend a memtest to rule out any possible bad
> hardware RAM problems.
>
> After that, this extent tree corruption should be able to be repaired by
> "btrfs check --repair"
>
> > ERROR: errors found in extent allocation tree or chunk allocation
> > [4/8] checking free space cache
> > [5/8] checking fs roots
> > root 336 inode 69064 errors 1040, bad file extent, some csum missing
>
> Those are minor problems and can be ignored.
>
> Thanks,
> Qu
> [...]
> > ERROR: errors found in fs roots
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/int_luks
> > UUID: a7613217-9dd7-4197-b5dd-e10cc7ed0afa
> > found 786786136064 bytes used, error(s) found
> > total csum bytes: 750877664
> > total tree bytes: 4204183552
> > total fs tree bytes: 2994487296
> > total extent tree bytes: 367149056
> > btree space waste bytes: 721104463
> > file data blocks allocated: 2761159544832
> >   referenced 1384698466304
> >
> > On Sat, Jan 18, 2025 at 11:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/1/19 14:17, Dave T =E5=86=99=E9=81=93:
> >>> Here is the full dmesg. Does this go back far enough?
> >>
> >> It indeed shows the first error. But it doesn't include the kernel cal=
l
> >> trace shown in your initial mail:
> >>
> >> [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
> >> 0000000000000010
> >> [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> >> 000074c0e2887ced
> >> [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI:
> >> 0000000000000003
> >> [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09:
> >> 0000000000000000
> >> [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
> >> 0000000000000000
> >> [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15:
> >> 0000000000000000
> >> [  +0.000004]  </TASK>
> >> [  +0.000001] ---[ end trace 0000000000000000 ]---
> >> [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -2=
2
> >>
> >> I guess that's no longer in the dmesg buffer?
> >>
> >>
> >>> I will run the "btrfs check --readonly" soon.
> >>>
> >>> # dmesg
> >>
> >>> [  +5.340568] BTRFS info (device dm-0): relocating block group
> >>> 299998642176 flags data
> >>> [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
> >>> move data extents
> >>> [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
> >>> for logical 404419657728 length 16384
> >>> [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
> >>> for logical 404419657728 length 16384
> >>> [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -=
5
> >>> [Jan18 17:31] netfs: FS-Cache loaded
> >>
> >> So far that balance is trying to balancing a tree block at the next
> >> block group. That definitely doesn't look correct.
> >>
> >> Please also provide the kernel version.
> >>
> >> Thanks,
> >> Qu
>

