Return-Path: <linux-btrfs+bounces-13027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AFCA8959D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 09:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A686189CA83
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F82741D2;
	Tue, 15 Apr 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIxDdKeb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6F194C86
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703398; cv=none; b=Y8IhG8JZacOF0h9xgIrGZC7vCCVwxJEANfgIts3JPI+flv7QWuzfoaFCe9Hs5C+b3IO3METgzSag1IfdUcONmy4b4cGVWShKE3RN9fOFNLRiBe2G8ggii71dlvjy+NPJriRX+hP/t2+sXVFmtAw/OHrcqHsMSDKPquzpDxVBOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703398; c=relaxed/simple;
	bh=CHh/+taoiIE5liUJj2MOr1AmXjWgZRB1A2M7/yN6YJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB5Bf6LLeGvv4NW6QP9uliuWbY90iKSWEn0wXkO2MBPYscvt2eRd/7U18c9fIKwvYlIGDPO/p7DgxRYLwW1z3WtJD/gEDSIenWqJ2s0SzNNBOGflRxbZ4Kz+iXh0ZM46+g0lFCBVvFbaLFhUsWXmvxp0u5iVj++RdehcbbdmZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIxDdKeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D6EC4CEEB
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744703398;
	bh=CHh/+taoiIE5liUJj2MOr1AmXjWgZRB1A2M7/yN6YJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lIxDdKebEM1GraWb5dZlB5wtbzrQUfivB115IK2K52A7omASGudidLihpfQ4o9Lem
	 D1iAklebgtNQXRCw+MVWeBvZuLkCaplDm1NZqx+ADKIS/61nuqC5FH3R8VkP6+8Lpz
	 bh7eKItOlA4ea7mzJBdIN6byHe23LWkbARS8i8INPJk7p/B/rYK0azZp1hrHyiWebu
	 pXixhY3+zz45NDg/DZt0E2ukL47Sajby6NABV80gh2jtLLAuQLavGZ0TzwROxh8zc+
	 4ZmVoKwrz9LbEXqAA0bzPPNiCz7NLFXO4T8SHeZ6pQKUuTrrgoBg4IT6KDiRCQd2yu
	 lXQNKbIC0BH7w==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso8665102a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 00:49:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxp1W0hj8rRiZ6MOhqiFS+JfcZJ9Yv19Xu5vV4EDqUYZ6O0ER8l
	Dc4Ji+Wl77m6u0Qf98KbKACqoZSPXKSGHtIzfwgicijhiFgVYUYpDARU1T10yZ5/7skthPwI5XB
	/Z+mDxxmlONeGYlhUkodfjd68GT0=
X-Google-Smtp-Source: AGHT+IH0SykGuajQL2Yc192P/Q6ZCZOpZ1D1MTM4+IKDedwYz84k60tVpAcdFvOIaUerZsIqlitQtyS+MTZTcCt+ZYQ=
X-Received: by 2002:a17:906:c105:b0:ac7:ed56:8a34 with SMTP id
 a640c23a62f3a-acad34996acmr1271117166b.21.1744703396562; Tue, 15 Apr 2025
 00:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415063342.3033071-1-davechen@synology.com>
In-Reply-To: <20250415063342.3033071-1-davechen@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 15 Apr 2025 08:49:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4LWk03_4hcejQ2vBzcZHm1e1=bmKeUZDV71eiCzt7aMw@mail.gmail.com>
X-Gm-Features: ATxdqUGEVCYRG20gc-RxS_y4hucwpDYx0Ae0rMb-HrtTakkrq3mCuKMa_kX8rqo
Message-ID: <CAL3q7H4LWk03_4hcejQ2vBzcZHm1e1=bmKeUZDV71eiCzt7aMw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix COW handling in run_delalloc_nocow function
To: davechen <davechen@synology.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, robbieko@synology.com, 
	cccheng@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 7:34=E2=80=AFAM davechen <davechen@synology.com> wr=
ote:
>
> In run_delalloc_nocow(), when the found btrfs_key's offset > cur_offset,
> it indicates a gap between the current processing region and
> the next file extent. The original code would directly jump to
> the "must_cow" label, which increments the slot and forces a fallback
> to COW. This behavior might skip an extent item and result in an
> overestimated COW fallback range.
>
> This patch modifies the logic so that when a gap is detected:
>   - If no COW range is already being recorded (cow_start is unset),
>     cow_start is set to cur_offset.
>   - cur_offset is then advanced to the beginning of the next extent.
>   - Instead of jumping to "must_cow", control flows directly to
>     "next_slot" so that the same extent item can be reexamined properly.
>
> The change ensures that we accurately account for the extent gap and
> avoid accidentally extending the range that needs to fallback to COW.
>
> Signed-off-by: Dave Chen <davechen@synology.com>
> ---

In the future, don't forget to add here, after the "---", a
description of what changed in this version of the patch compared to
the previous one (look for examples in the mailing list).


>  fs/btrfs/inode.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5b842276573e..394d5113b6cb 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2155,12 +2155,13 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>
>                 /*
>                  * If the found extent starts after requested offset, the=
n
> -                * adjust extent_end to be right before this extent begin=
s
> +                * adjust cur_offset to be right before this extent begin=
s

I'll add punctuation to the end of the sentence to make it comply with
the preferred coding style.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Patch looks good to me now, I'll add it to for-next, thanks.

>                  */
>                 if (found_key.offset > cur_offset) {
> -                       extent_end =3D found_key.offset;
> -                       extent_type =3D 0;
> -                       goto must_cow;
> +                       if (cow_start =3D=3D (u64)-1)
> +                               cow_start =3D cur_offset;
> +                       cur_offset =3D found_key.offset;
> +                       goto next_slot;
>                 }
>
>                 /*
> --
> 2.43.0
>
>

