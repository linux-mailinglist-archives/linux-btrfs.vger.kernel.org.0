Return-Path: <linux-btrfs+bounces-15750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2755B15E0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E9C16D440
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AF28751E;
	Wed, 30 Jul 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST9l7g0I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723227FB3A;
	Wed, 30 Jul 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870871; cv=none; b=QHM8R/c5lZs6KxQZm2ssHmL/g4GeAYSEry563SDLCBpjnriMOhiwJQ16nL4D4ctLsAYJ7wbenhSVM4tBtyKcYpdNR4BQjXX0OLY5IABlkOe3UU5YYMJ1B6upzEbmCygEOEmSXG/G6XVHnsmOqbG0PqBk5+HKUGkCCbdC+t4bssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870871; c=relaxed/simple;
	bh=5WLYtURJ7+E0ew+T9lWSwh94yasN9NmznSsFTfS59qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDtkRAW0OZVeI1JAvd6frhxtOevxitP59Cd6ClrBs10R2dzrNYoKDWGj2DR3ZMye9O2klVd2aBsda05qz0rZ6yxV2cqzold5XmQh5zOECBoEU2aBLKBzuy3B+2gk+RCXngcLFkqzTQvHycFwaIpKDSxgfW4RW7RUC93sQO/nOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST9l7g0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D7AC4CEF9;
	Wed, 30 Jul 2025 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753870870;
	bh=5WLYtURJ7+E0ew+T9lWSwh94yasN9NmznSsFTfS59qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ST9l7g0I3tja8PGCrnYWnKJOxAQP/FNGxVNW8hsobFUZM8PizS5vTQAcFanjZXi6u
	 ikrl+x0m+4HrPRrGJNVa7x6+50RM4YG65NiGNM1nbmb7y9bNcdV2JvSRmyHXhBXH+x
	 w3oQHc8xQHj/74KkXNBSl40tXa+BvxkuffK+APGLVQSWUvbuyHcLXQnL1VLeSVWhyp
	 HOzkI+JfypBNzV9ry0p6XnRiwxq4fjzchPwmjPpY3VOuWZPVI2peq7N2IUGCnsT+nY
	 u5Cka8Ayaqok44f+Gd4wx46wZN4ExMh1CNfI1r7EAd4mPXZ4aVeQgDn0jteQ/xXk5N
	 eQMmci0E/xv8A==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso3952032a12.3;
        Wed, 30 Jul 2025 03:21:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUQVnCPqgms3rmzW1zIuGRAJC2dxeUCiZ34LeNsWWd+eDhQmh26rMtd60Dtg/1JONB8nISzHXoqmu9BQ==@vger.kernel.org, AJvYcCX6052hH0YrRb2np/b8lII8+If5mpGxhWIBBPudruBPtTR4dSho/wPkjfdTpiPfVSbK+FQpkWNVsPocmrmG@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQD8T0JApzBQ5xRt7IbXEV4yV8LSmSO2YgZbR1WKH/BUuglHy
	0iT4C9FVhcQbY7227iFZP/j1xHiuu8+xU9aFNO5A0vK4UOwrr33dIEfJfRKLZEl4daO5vWUdIa8
	nHwa9amJu2H5USGtzpq8t/bcPc0vyUzw=
X-Google-Smtp-Source: AGHT+IEh7f5DjE3aZhiOGW/lQcmghui9D0DDQFpGNh+U61oQCozkuYfrYz6pTFYYCMK+9hRA2lB5Gurv4f1FwTqWAm8=
X-Received: by 2002:a17:907:6d0b:b0:ae0:bee7:ad7c with SMTP id
 a640c23a62f3a-af8fd9d1c8amr343180066b.46.1753870869385; Wed, 30 Jul 2025
 03:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730044348.133387-1-admin@mail.free-proletariat.dpdns.org> <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org>
In-Reply-To: <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Jul 2025 11:20:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5=cLEO3Cvty38bT1j5E6R0jJMuOWn+u9CkV6s58UhErQ@mail.gmail.com>
X-Gm-Features: Ac12FXwD5kbbyuVduKgNiVB9bs8iC3lK0MT0xcXjROhMKTQPD1IC2LDmI_8alyk
Message-ID: <CAL3q7H5=cLEO3Cvty38bT1j5E6R0jJMuOWn+u9CkV6s58UhErQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] btrfs: add integer overflow protection to
 flush_dir_items_batch allocation
To: kmpfqgdwxucqz9@gmail.com
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	KernelKraze <admin@mail.free-proletariat.dpdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:48=E2=80=AFAM <kmpfqgdwxucqz9@gmail.com> wrote:
>
> From: KernelKraze <admin@mail.free-proletariat.dpdns.org>
>
> The flush_dir_items_batch() function performs memory allocation using
> count * sizeof(u32) + count * sizeof(struct btrfs_key) without proper
> integer overflow checking. When count is large enough, this multiplicatio=
n
> can overflow, resulting in an allocation smaller than expected, leading t=
o
> buffer overflows during subsequent array access.
>
> In extreme cases with very large directory item counts, this could
> theoretically lead to undersized memory allocation, though such scenarios
> are unlikely in normal filesystem usage.
>
> Fix this by:
> 1. Adding a reasonable upper limit (195) to the batch size, consistent
>    with the limit used in log_delayed_insertion_items()
> 2. Using check_mul_overflow() and check_add_overflow() to detect integer
>    overflows before performing the allocation
> 3. Returning -EOVERFLOW when overflow is detected
> 4. Adding appropriate warning and error messages for debugging
>
> This ensures that memory allocations are always sized correctly and
> prevents potential issues from integer overflow conditions, improving
> overall code robustness.
>
> Signed-off-by: KernelKraze <admin@mail.free-proletariat.dpdns.org>
> ---
>  fs/btrfs/tree-log.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9f05d454b9df..19b443314db0 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3655,14 +3655,35 @@ static int flush_dir_items_batch(struct btrfs_tra=
ns_handle *trans,
>         } else {
>                 struct btrfs_key *ins_keys;
>                 u32 *ins_sizes;
> +               size_t keys_size, sizes_size, total_size;
>
> -               ins_data =3D kmalloc(count * sizeof(u32) +
> -                                  count * sizeof(struct btrfs_key), GFP_=
NOFS);
> +               /*
> +                * Prevent integer overflow when calculating allocation s=
ize.
> +                * We use the same reasonable limit as log_delayed_insert=
ion_items()
> +                * to prevent excessive memory allocation and potential D=
oS.
> +                */
> +               if (count > 195) {
> +                       btrfs_warn(inode->root->fs_info,
> +                                  "dir items batch size %d exceeds safe =
limit, truncating",
> +                                  count);
> +                       count =3D 195;
> +               }

Adding to what was already mentioned by others....
This is so wrong that I'm not even sure where to begin.

But here truncating to 195 (or whatever value) is incredibly wrong
from a correctness point of view...
This means you are discarding beyond that limit, making us not log
index items that should be logged.

The 195 you saw in the other place is fine, because we split things in
batches up to that size and insert everything, but here we would just
skip anything beyond the limit.

Anyway there's no way we can have an overflow here in the first place....


> +
> +               /* Check for overflow in size calculations */
> +               if (check_mul_overflow(count, sizeof(u32), &sizes_size) |=
|
> +                   check_mul_overflow(count, sizeof(struct btrfs_key), &=
keys_size) ||
> +                   check_add_overflow(sizes_size, keys_size, &total_size=
)) {
> +                       btrfs_err(inode->root->fs_info,
> +                                 "integer overflow in batch allocation s=
ize calculation");
> +                       return -EOVERFLOW;
> +               }
> +
> +               ins_data =3D kmalloc(total_size, GFP_NOFS);
>                 if (!ins_data)
>                         return -ENOMEM;
>
>                 ins_sizes =3D (u32 *)ins_data;
> -               ins_keys =3D (struct btrfs_key *)(ins_data + count * size=
of(u32));
> +               ins_keys =3D (struct btrfs_key *)(ins_data + sizes_size);
>                 batch.keys =3D ins_keys;
>                 batch.data_sizes =3D ins_sizes;
>                 batch.total_data_size =3D 0;
> --
> 2.48.1
>
>

