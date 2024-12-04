Return-Path: <linux-btrfs+bounces-10059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1989E38C0
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 12:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6991686A1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F291B218D;
	Wed,  4 Dec 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfW2exju"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FA1AC884
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311614; cv=none; b=DdOFMGgzEm9zNybkpaNwdHDK3BDzhHNlkWrDftHJx77eydhXBofvwObjgAwngxrlcingBouRdTzNPkrpP68q2CDZnmud4pKx5z15yCizNBt6fyVPINRLgd1+sW92EipZcpDZjWtyCOOSOFMNm8fwCuspsa7wIRPumlqKCTp+w3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311614; c=relaxed/simple;
	bh=BfNUHobOchlj2Nmu38ZW6gkT6bxOS7Mvbo6gwBLLfOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaSM1W77lBY1cPxv43nqhdOtiKzwxCWsyBxYJOxWEeil5ht7/Fosct8h9t3UnFaEvEIyYCGOsk6NTunVPb5erkdWRxL63w7kKsSW5hOoxxsP5cRSRyCvIYM56K0aQznFfpWFKGVKNslMGseSWkP4frQy+wtmvzRIY2LKrhnfFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfW2exju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45059C4CEDF
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733311614;
	bh=BfNUHobOchlj2Nmu38ZW6gkT6bxOS7Mvbo6gwBLLfOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rfW2exjuTqXaJzsO7WZD92T6mJkyphsT7VUZOx0iqwXGmTATIMzTkk6j1/uK9p08L
	 K7jHKWJLpz7z1VFcoCgT01Fu1bV3mVOiAVmHLG97TSz2z6bpfQKVHJfUT/YFshkkBq
	 7cHtyOyL2IZcQBw5dQsCr5idw51i0+kaX7COvO7XcpPO7ovMMquhhdWlIHipNlxWfP
	 MG+nQzjgwuSmJak4Kbgl5pb8AFuxVPPbeBTJJqIHqvkd38PjKpyN2Wq106RqMNhpNH
	 FJQaeXLVc76izyRVVXatYYmEcY1lqOcu9SKSVYhQjo8qb3EgOPv5g8ZUxpPvOOY+dW
	 7AXiQzPKOFi6Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so881965e87.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2024 03:26:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yx73uFYCBnrFNjPiuvJeoXYMhlZfFYQo0zeDeVnratvlszwqayL
	i4dfEcCb2eQGtBZmqeR/EGhaYLGKqy3XEGtg6S6Ul2JteGrr/5WMuNWuO595XbrAgkMxIs2YETV
	sbiKPFiqQOP2Spk/lJchPQkN1Y+o=
X-Google-Smtp-Source: AGHT+IGPcXuPN8yAuQTOgp35BFzZ6nCe5aFtqi9Dius+PtPCJ/kfbJF5d+Iy8AVedc6mPudJoprMUUFFl901LGIs6w8=
X-Received: by 2002:a05:6512:1249:b0:53d:e077:deed with SMTP id
 2adb3069b0e04-53e12a344f0mr3599350e87.52.1733311611588; Wed, 04 Dec 2024
 03:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <839022e69496e80413ade9dc8287fb9ccaef9557.1733282486.git.wqu@suse.com>
In-Reply-To: <839022e69496e80413ade9dc8287fb9ccaef9557.1733282486.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 4 Dec 2024 11:26:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7vujk4iSDm_Z_PKVKWQ+205DzNn+tMpXFfiy7YvbJCLw@mail.gmail.com>
Message-ID: <CAL3q7H7vujk4iSDm_Z_PKVKWQ+205DzNn+tMpXFfiy7YvbJCLw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: reject inline extent items with 0
 ref count
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Frankie Fisher <frankie@terrorise.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:56=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a bug report in the mailing list where btrfs_run_delayed_refs()
> failed to drop the ref count for logical 25870311358464 num_bytes
> 2113536.
>
> The involved leaf dump looks like this:
>
>   item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
>     extent refs 1 gen 84178 flags 1
>     ref#0: shared data backref parent 32399126528000 count 0 <<<
>     ref#1: shared data backref parent 31808973717504 count 1
>
> Notice the count number is 0.
>
> [CAUSE]
> There is no concrete evidence yet, but considering 0 -> 1 is also a
> single bit flipped, it's possible that hardware memory bitflip is
> involved, causing the on-disk extent tree to be corrupted.
>
> [FIX]
> To prevent us reading such corrupted extent item, or writing such
> damaged extent item back to disk, enhance the handling of
> BTRFS_EXTENT_DATA_REF_KEY and BTRFS_SHARED_DATA_REF_KEY keys for both
> inlined and key items, to detect such 0 ref count and reject them.
>
> Link: https://lore.kernel.org/linux-btrfs/7c69dd49-c346-4806-86e7-e6f863a=
66f48@app.fastmail.com/
> Reported-by: Frankie Fisher <frankie@terrorise.me.uk>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 148d8cefa40e..0b9891f416ec 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1527,6 +1527,11 @@ static int check_extent_item(struct extent_buffer =
*leaf,
>                                            dref_offset, fs_info->sectorsi=
ze);
>                                 return -EUCLEAN;
>                         }
> +                       if (unlikely(btrfs_extent_data_ref_count(leaf, dr=
ef) =3D=3D 0)) {
> +                               extent_err(leaf, slot,
> +                       "invalidate data ref count, should have non-zero =
value");

invalidate -> invalid

> +                               return -EUCLEAN;
> +                       }
>                         inline_refs +=3D btrfs_extent_data_ref_count(leaf=
, dref);
>                         break;
>                 /* Contains parent bytenr and ref count */
> @@ -1539,6 +1544,11 @@ static int check_extent_item(struct extent_buffer =
*leaf,
>                                            inline_offset, fs_info->sector=
size);
>                                 return -EUCLEAN;
>                         }
> +                       if (unlikely(btrfs_shared_data_ref_count(leaf, sr=
ef) =3D=3D 0)) {
> +                               extent_err(leaf, slot,
> +                       "invalidate shared data ref count, should have no=
n-zero value");

invalidate -> invalid

> +                               return -EUCLEAN;
> +                       }
>                         inline_refs +=3D btrfs_shared_data_ref_count(leaf=
, sref);
>                         break;
>                 case BTRFS_EXTENT_OWNER_REF_KEY:
> @@ -1611,8 +1621,18 @@ static int check_simple_keyed_refs(struct extent_b=
uffer *leaf,
>  {
>         u32 expect_item_size =3D 0;
>
> -       if (key->type =3D=3D BTRFS_SHARED_DATA_REF_KEY)
> +       if (key->type =3D=3D BTRFS_SHARED_DATA_REF_KEY) {
> +               struct btrfs_shared_data_ref *sref;
> +
> +               sref =3D btrfs_item_ptr(leaf, slot, struct btrfs_shared_d=
ata_ref);
> +               if (unlikely(btrfs_shared_data_ref_count(leaf, sref) =3D=
=3D 0)) {
> +                       extent_err(leaf, slot,
> +               "invalid shared data backref count, should have non-zero =
value");

Here it's correct.

> +                       return -EUCLEAN;
> +               }
> +
>                 expect_item_size =3D sizeof(struct btrfs_shared_data_ref)=
;
> +       }
>
>         if (unlikely(btrfs_item_size(leaf, slot) !=3D expect_item_size)) =
{
>                 generic_err(leaf, slot,
> @@ -1689,6 +1709,11 @@ static int check_extent_data_ref(struct extent_buf=
fer *leaf,
>                                    offset, leaf->fs_info->sectorsize);
>                         return -EUCLEAN;
>                 }
> +               if (unlikely(btrfs_extent_data_ref_count(leaf, dref) =3D=
=3D 0)) {
> +                       extent_err(leaf, slot,
> +       "invalidate extent data backref count, should have non-zero value=
");

invalidate -> invalid

With those small fixes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +                       return -EUCLEAN;
> +               }
>         }
>         return 0;
>  }
> --
> 2.47.1
>
>

