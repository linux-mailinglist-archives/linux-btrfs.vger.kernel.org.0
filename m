Return-Path: <linux-btrfs+bounces-11002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA24A1602B
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 05:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38C518860C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 04:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F11369B6;
	Sun, 19 Jan 2025 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0f/PYTf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C22837B
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737261135; cv=none; b=BvD/o/2z1czZ2JM7JBcblmkf0/6cVGW3WchkQEOmyIdQ9LgwKfAMI8fCMkv+hDSTYlMfC0MhKUsQin6acGH+VYIOuQuU4HVLoRdwctlxND1V7p7AZyjs0oLRp/V9LA7X9KiTdnn89TXavIPfyg3RB5HkvGjmA+bX63sWQAOtqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737261135; c=relaxed/simple;
	bh=1rL90uodV39wI6PAKtHlJlGutvuVVWcGdKd4T5pmvko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPhIs1WFHtZ9T6y8Rhd6hiiCkm8QuabKJ8f8OjX1WU+lUtDs3L+XMT6/6Ed1gQ4DG7pU3oLae7xbYHqi00vV+ZxlGBuNSQZ6LiSiE8aWiHIht3esuTZnf0ckCfaPvk/uAzF6hZmVJoU3LqpYJPuJPbWuDkePdhXX3JuYC8KzESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0f/PYTf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e46c6547266so4913237276.3
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jan 2025 20:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737261132; x=1737865932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJzOOA6QQGLJgdIVTVltQf/eitm6zvaQuOr+lYSpSmc=;
        b=k0f/PYTfii48Mh0+tWUDaFndkMB/Q3mPW7nMKblTqg+We27rkhrWKjC3Q8nu6cMLaw
         hsUSHiUlqtIPRm614dvfgespHIqx+Z03vs40AIWtwRDWr4l12m0K612x1SL+dFpRzpWM
         +Z8LKmsMlqJ67ebP71jpNlDkBgcXPxqnc3aJN5nf2Dqwc0lKjZM0oZkVd34+ZmDZREaR
         zzKBJ+nsG6E7hPBhYkOsYdMTsonReGJK46DNt1YeTqItolcwivOoH5R0b3zIJLU7aT5X
         tg7NnyxmHWkpYLXUFKD+/2laGD9n9/P/aGLNGDNHeY2pWU/+p9V1Uxz7TLMJ3HcvxMY/
         7tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737261132; x=1737865932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJzOOA6QQGLJgdIVTVltQf/eitm6zvaQuOr+lYSpSmc=;
        b=U6T5AHpx2BWy9oq6J8W5tLt4iwmDyyArvLadUau0zSUSSOiFAUXZGxbbr/0Gif8bH7
         HU0YCnbl0ZF5+KkQgQtTo9vzqQeSG/vjJovGyubbo48va/qqzOO9hL41qnwNvClFfUpE
         MnregJIB944V2WEXOTKenurZ5qmckgSuYo5LOHR3KIt8ODyNhb9J/eFenjXtJEituwk3
         r4nXhHAgRCPIQSTR2D0obNIgLAbeXgESXaK3U9bBEi5IAiovrRNBEMRv6xCezrYLNyei
         Q3JMoGtFijiLOsmAYT80QQR3xTSg+eZRAnJndv0cxL6RCCgQPp4tfY59OBRzRst111Z7
         3Ubw==
X-Gm-Message-State: AOJu0YwqFeskB0TWdsRq6keQJC27RK0HZy+n1S0gSQucEBD3uwAfnZuY
	e7mzKDEJw8zgYCDt+57PgqysBoBDRt9qRqaAbGcFvD9KFGsxA/9en8B5hQkJzNPQaDmPM8P3+bq
	hCFLvt0HvVynAtTkHLrDi9RKbtq2IBF7EuxU=
X-Gm-Gg: ASbGncs8oeJDbxspjbY/lSU+08Cz4oC+KVX53OGLdwWz4LbjdBTOYWNfW9IvNscUI3N
	EM4IEPTI8lzaacE7foJ7qEK8PbG87gyZfsts5OF+lODJzzFtnAXo=
X-Google-Smtp-Source: AGHT+IGoXRtCMju/ng69JXIkYocP7uPn2lO4e3umgnxxi0R/A9EQaG7NPUp4qXhP0PzhkbS5hgHAmGiogc/3lDp37Vg=
X-Received: by 2002:a05:690c:6501:b0:6ef:70fb:4594 with SMTP id
 00721157ae682-6f6eb67bb1dmr75320707b3.13.1737261131770; Sat, 18 Jan 2025
 20:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com> <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
 <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com>
In-Reply-To: <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com>
From: Dave T <davestechshop@gmail.com>
Date: Sat, 18 Jan 2025 23:32:01 -0500
X-Gm-Features: AbW1kvbCpm7DK_1ToIVoMeaKV5vjRT0266BN5QDWxc4pHKCX1VaqIZksFMJvf-Y
Message-ID: <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's Arch Linux and kernel version 6.12.6-arch1-1

Here is the output of btrfs check. (FYI - BTRFS runs on top of
dm-crypt, and I passed the "--readonly" flag to "cryptesetup open"
before running this. I guess that is why it says "log skipped" below.)

[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
ref mismatch on [300690628608 16384] extent item 10, found 9
data extent[300690628608, 16384] bytenr mimsmatch, extent item bytenr
300690628608 file item bytenr 0
data extent[300690628608, 16384] referencer count mismatch (parent
404419657728) wanted 1 have 0
backpointer mismatch on [300690628608 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space cache
[5/8] checking fs roots
root 336 inode 69064 errors 1040, bad file extent, some csum missing
root 336 inode 113496 errors 1040, bad file extent, some csum missing
root 336 inode 113558 errors 1040, bad file extent, some csum missing
root 336 inode 113563 errors 1040, bad file extent, some csum missing
root 336 inode 113624 errors 1040, bad file extent, some csum missing
root 336 inode 113839 errors 1040, bad file extent, some csum missing
root 336 inode 113931 errors 1040, bad file extent, some csum missing
root 336 inode 114145 errors 1040, bad file extent, some csum missing
root 336 inode 133069 errors 1040, bad file extent, some csum missing
root 336 inode 133072 errors 1040, bad file extent, some csum missing
root 336 inode 133074 errors 1040, bad file extent, some csum missing
root 336 inode 133153 errors 1040, bad file extent, some csum missing
root 336 inode 134151 errors 1040, bad file extent, some csum missing
root 336 inode 134154 errors 1040, bad file extent, some csum missing
root 336 inode 134782 errors 1040, bad file extent, some csum missing
root 336 inode 134783 errors 1040, bad file extent, some csum missing
root 336 inode 134919 errors 1040, bad file extent, some csum missing
root 336 inode 138340 errors 1040, bad file extent, some csum missing
root 336 inode 143988 errors 1040, bad file extent, some csum missing
root 336 inode 143995 errors 1040, bad file extent, some csum missing
root 336 inode 144002 errors 1040, bad file extent, some csum missing
root 336 inode 144003 errors 1040, bad file extent, some csum missing
root 336 inode 144014 errors 1040, bad file extent, some csum missing
root 336 inode 147060 errors 1040, bad file extent, some csum missing
root 336 inode 147061 errors 1040, bad file extent, some csum missing
root 336 inode 147063 errors 1040, bad file extent, some csum missing
root 336 inode 148818 errors 1040, bad file extent, some csum missing
root 336 inode 148819 errors 1040, bad file extent, some csum missing
root 336 inode 152019 errors 1040, bad file extent, some csum missing
root 336 inode 152027 errors 1040, bad file extent, some csum missing
root 336 inode 155177 errors 1040, bad file extent, some csum missing
root 336 inode 155769 errors 1040, bad file extent, some csum missing
root 336 inode 155772 errors 1040, bad file extent, some csum missing
root 336 inode 156233 errors 1040, bad file extent, some csum missing
root 336 inode 156236 errors 1040, bad file extent, some csum missing
root 336 inode 156293 errors 1040, bad file extent, some csum missing
root 336 inode 156497 errors 1040, bad file extent, some csum missing
root 336 inode 166294 errors 1040, bad file extent, some csum missing
root 336 inode 166419 errors 1040, bad file extent, some csum missing
root 336 inode 171167 errors 1040, bad file extent, some csum missing
root 336 inode 201429 errors 1040, bad file extent, some csum missing
root 336 inode 201564 errors 1040, bad file extent, some csum missing
root 336 inode 201575 errors 1040, bad file extent, some csum missing
root 336 inode 201577 errors 1040, bad file extent, some csum missing
root 336 inode 201584 errors 1040, bad file extent, some csum missing
root 336 inode 201585 errors 1040, bad file extent, some csum missing
root 336 inode 201597 errors 1040, bad file extent, some csum missing
root 336 inode 201666 errors 1040, bad file extent, some csum missing
root 336 inode 201673 errors 1040, bad file extent, some csum missing
root 336 inode 202502 errors 1040, bad file extent, some csum missing
root 336 inode 202504 errors 1040, bad file extent, some csum missing
root 336 inode 202506 errors 1040, bad file extent, some csum missing
root 336 inode 202517 errors 1040, bad file extent, some csum missing
root 336 inode 202520 errors 1040, bad file extent, some csum missing
root 336 inode 202521 errors 1040, bad file extent, some csum missing
root 336 inode 216890 errors 1040, bad file extent, some csum missing
root 336 inode 216938 errors 1040, bad file extent, some csum missing
root 336 inode 216948 errors 1040, bad file extent, some csum missing
root 336 inode 217216 errors 1040, bad file extent, some csum missing
root 336 inode 217218 errors 1040, bad file extent, some csum missing
root 336 inode 217367 errors 1040, bad file extent, some csum missing
root 336 inode 217632 errors 1040, bad file extent, some csum missing
root 336 inode 217635 errors 1040, bad file extent, some csum missing
root 336 inode 217636 errors 1040, bad file extent, some csum missing
root 336 inode 218188 errors 1040, bad file extent, some csum missing
root 336 inode 218198 errors 1040, bad file extent, some csum missing
root 336 inode 218201 errors 1040, bad file extent, some csum missing
root 336 inode 218204 errors 1040, bad file extent, some csum missing
root 336 inode 218594 errors 1040, bad file extent, some csum missing
root 336 inode 218596 errors 1040, bad file extent, some csum missing
root 336 inode 218600 errors 1040, bad file extent, some csum missing
root 336 inode 219356 errors 1040, bad file extent, some csum missing
root 336 inode 219357 errors 1040, bad file extent, some csum missing
root 336 inode 219358 errors 1040, bad file extent, some csum missing
root 336 inode 219793 errors 1040, bad file extent, some csum missing
root 336 inode 219797 errors 1040, bad file extent, some csum missing
root 336 inode 219810 errors 1040, bad file extent, some csum missing
root 336 inode 219944 errors 1040, bad file extent, some csum missing
root 336 inode 219946 errors 1040, bad file extent, some csum missing
root 336 inode 219949 errors 1040, bad file extent, some csum missing
root 336 inode 219950 errors 1040, bad file extent, some csum missing
root 336 inode 219954 errors 1040, bad file extent, some csum missing
root 336 inode 219955 errors 1040, bad file extent, some csum missing
root 336 inode 219956 errors 1040, bad file extent, some csum missing
root 336 inode 219958 errors 1040, bad file extent, some csum missing
root 336 inode 219959 errors 1040, bad file extent, some csum missing
root 336 inode 219967 errors 1040, bad file extent, some csum missing
root 336 inode 219974 errors 1040, bad file extent, some csum missing
root 336 inode 219975 errors 1040, bad file extent, some csum missing
root 336 inode 219976 errors 1040, bad file extent, some csum missing
root 336 inode 219977 errors 1040, bad file extent, some csum missing
root 336 inode 219978 errors 1040, bad file extent, some csum missing
root 336 inode 219979 errors 1040, bad file extent, some csum missing
root 336 inode 219981 errors 1040, bad file extent, some csum missing
root 336 inode 219983 errors 1040, bad file extent, some csum missing
root 336 inode 219985 errors 1040, bad file extent, some csum missing
root 336 inode 219987 errors 1040, bad file extent, some csum missing
root 336 inode 219988 errors 1040, bad file extent, some csum missing
root 336 inode 223581 errors 1040, bad file extent, some csum missing
root 336 inode 225590 errors 1040, bad file extent, some csum missing
root 336 inode 228361 errors 1040, bad file extent, some csum missing
root 336 inode 247689 errors 1040, bad file extent, some csum missing
root 336 inode 247693 errors 1040, bad file extent, some csum missing
root 336 inode 251782 errors 1040, bad file extent, some csum missing
root 336 inode 251787 errors 1040, bad file extent, some csum missing
root 336 inode 251788 errors 1040, bad file extent, some csum missing
root 336 inode 252228 errors 1040, bad file extent, some csum missing
root 336 inode 253363 errors 1040, bad file extent, some csum missing
root 336 inode 337045 errors 1040, bad file extent, some csum missing
root 336 inode 337096 errors 1040, bad file extent, some csum missing
root 336 inode 346036 errors 1040, bad file extent, some csum missing
root 336 inode 347087 errors 1040, bad file extent, some csum missing
root 336 inode 347091 errors 1040, bad file extent, some csum missing
root 336 inode 347236 errors 1040, bad file extent, some csum missing
root 336 inode 347266 errors 1040, bad file extent, some csum missing
root 336 inode 347271 errors 1040, bad file extent, some csum missing
root 336 inode 347288 errors 1040, bad file extent, some csum missing
root 336 inode 347372 errors 1040, bad file extent, some csum missing
root 336 inode 347375 errors 1040, bad file extent, some csum missing
root 336 inode 347391 errors 1040, bad file extent, some csum missing
root 336 inode 347396 errors 1040, bad file extent, some csum missing
root 336 inode 347397 errors 1040, bad file extent, some csum missing
root 336 inode 347455 errors 1040, bad file extent, some csum missing
root 2932 inode 322 errors 1040, bad file extent, some csum missing
root 2932 inode 323 errors 1040, bad file extent, some csum missing
root 2932 inode 325 errors 1040, bad file extent, some csum missing
root 2932 inode 326 errors 1040, bad file extent, some csum missing
root 2932 inode 336 errors 1040, bad file extent, some csum missing
root 2932 inode 339 errors 1040, bad file extent, some csum missing
root 2932 inode 340 errors 1040, bad file extent, some csum missing
root 2932 inode 347 errors 1040, bad file extent, some csum missing
root 2932 inode 348 errors 1040, bad file extent, some csum missing
root 2932 inode 355 errors 1040, bad file extent, some csum missing
root 2932 inode 363 errors 1040, bad file extent, some csum missing
root 2932 inode 364 errors 1040, bad file extent, some csum missing
root 2932 inode 365 errors 1040, bad file extent, some csum missing
root 2932 inode 366 errors 1040, bad file extent, some csum missing
root 2932 inode 368 errors 1040, bad file extent, some csum missing
root 2932 inode 371 errors 1040, bad file extent, some csum missing
root 2932 inode 381 errors 1040, bad file extent, some csum missing
root 2932 inode 386 errors 1040, bad file extent, some csum missing
root 2932 inode 389 errors 1040, bad file extent, some csum missing
root 2932 inode 390 errors 1040, bad file extent, some csum missing
root 2932 inode 394 errors 1040, bad file extent, some csum missing
root 2932 inode 395 errors 1040, bad file extent, some csum missing
root 2932 inode 396 errors 1040, bad file extent, some csum missing
root 2932 inode 397 errors 1040, bad file extent, some csum missing
root 2932 inode 400 errors 1040, bad file extent, some csum missing
root 2932 inode 401 errors 1040, bad file extent, some csum missing
root 2932 inode 408 errors 1040, bad file extent, some csum missing
root 2932 inode 409 errors 1040, bad file extent, some csum missing
root 2932 inode 415 errors 1040, bad file extent, some csum missing
root 2932 inode 417 errors 1040, bad file extent, some csum missing
root 2932 inode 419 errors 1040, bad file extent, some csum missing
root 2932 inode 426 errors 1040, bad file extent, some csum missing
root 2932 inode 427 errors 1040, bad file extent, some csum missing
root 2932 inode 428 errors 1040, bad file extent, some csum missing
root 2932 inode 431 errors 1040, bad file extent, some csum missing
root 2932 inode 432 errors 1040, bad file extent, some csum missing
root 2932 inode 433 errors 1040, bad file extent, some csum missing
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/mapper/int_luks
UUID: a7613217-9dd7-4197-b5dd-e10cc7ed0afa
found 786786136064 bytes used, error(s) found
total csum bytes: 750877664
total tree bytes: 4204183552
total fs tree bytes: 2994487296
total extent tree bytes: 367149056
btree space waste bytes: 721104463
file data blocks allocated: 2761159544832
 referenced 1384698466304

On Sat, Jan 18, 2025 at 11:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2025/1/19 14:17, Dave T =E5=86=99=E9=81=93:
> > Here is the full dmesg. Does this go back far enough?
>
> It indeed shows the first error. But it doesn't include the kernel call
> trace shown in your initial mail:
>
> [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 000074c0e2887ced
> [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI:
> 0000000000000003
> [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000
> [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15:
> 0000000000000000
> [  +0.000004]  </TASK>
> [  +0.000001] ---[ end trace 0000000000000000 ]---
> [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -22
>
> I guess that's no longer in the dmesg buffer?
>
>
> > I will run the "btrfs check --readonly" soon.
> >
> > # dmesg
>
> > [  +5.340568] BTRFS info (device dm-0): relocating block group
> > 299998642176 flags data
> > [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
> > move data extents
> > [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
> > for logical 404419657728 length 16384
> > [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
> > for logical 404419657728 length 16384
> > [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -5
> > [Jan18 17:31] netfs: FS-Cache loaded
>
> So far that balance is trying to balancing a tree block at the next
> block group. That definitely doesn't look correct.
>
> Please also provide the kernel version.
>
> Thanks,
> Qu

