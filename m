Return-Path: <linux-btrfs+bounces-5749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4804390A24E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 04:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F551C21527
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255C167DB9;
	Mon, 17 Jun 2024 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVKw3BuB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C241581E3
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590107; cv=none; b=ReOwwzpFlHP7o3/Zw0GamqFruQtw6ZROOK9BlFsIOPvy4vmLrjbYRsF9W9b4DQ9HnpyAtufBJ9HatHm2smGMOcYsf2bF1s+VNets0O3cFjs0v6W7wD4T/HrD+a0Yh1sO/9lI/5E+QXg3myQ40Jj9npO1a0lPjzE6qdYl4uyDIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590107; c=relaxed/simple;
	bh=HJN8jFWAlsIPcpShP6WoQgNINEkUP8+n6VBBOco9PvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhECXSrvHTsiaAQwbMitQRF+1UDHYy7gq2Sn+5W92zNVjRC+cA3sxasJy4QbbqHs1Bj1LZgnE3R3CjVh1GdNgwOhRiGzkUJo951J1P4t9E10k9jaDZydmQ+pMuGrKLY+bvTlJQMI1NBSwhD2uTS1n+MwINDwu729e8YiRlh29HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVKw3BuB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so4488544a12.2
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jun 2024 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718590104; x=1719194904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv46x6sUx13AjNrjYxrx6KLvsu68AiLVnTKfcu6E6Iw=;
        b=IVKw3BuB5DrMARR5F8TLkRjn90uV6CPjF5qR0CplEqYDr7/cBOMWFwKLtWuuaaDimq
         Xr8zhLH2xwchk/aLBAcij54SeXgiHyWKBVLSptoDxfccRKyW/Vsf4zeRWEqmvZSsiegg
         6uCr5Gc2rB+YpcQTacjuA2+evGQyjQMvTeTd+5m9zJR7sRePKhw73JKk7q4SaE34Q/BV
         VNK9WmrET9SNXeaCT1QlGRIfHW3w25VUx9PQPJWpVVOjoZVb9NWezHXS87eWfrX2SfNj
         fbBSr1frntYfC32+IuMVVHH8ZBH8/ZDNEH1uLEUZvnM7FHdRcjtAiZaQkPsHOUHh59zq
         /uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590104; x=1719194904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lv46x6sUx13AjNrjYxrx6KLvsu68AiLVnTKfcu6E6Iw=;
        b=UuCgHs2NkG1I+onvq0OWh4/Z6Eb622HJINzYUZPjc0wxf8LwFyFJt5ujRpxZrn6lEU
         R+pcdcJFXvRQ2wrl5F0k9ul7DcJur2CugAbKxaBaRwYRo7AunqDZ0aGflgdbbdpVLpkN
         NnerRgZuhvfdgX4CyWz0Sng6XhGryoQlKdyQt722R8QUjixVpBkxeY0IFf4Zszk6+3aj
         iq87BuCipRpfJ0qtP/sgUeoWfzjmeFShVclTYTbn00eCgC5essQ3ngbuVJhG2MkWTlln
         0wA3LcRW9Uj3gIRBlA8LSOajEpfOEYj5/+XPhZRbPjntyFJy71EupKYdeM9m7hW3AsmD
         41wA==
X-Gm-Message-State: AOJu0Yw+KkJeqCyQLgVFMITPi7HuST9BITCzh2yyBUwKb3weIhX5Ec9S
	sn48N1BEhNQwkgmAmf57yjNAwmogHeQFdsEuYajp08R/LZlpWBm8BItxogRV/8LHgtc5odyryfx
	8CCVqtMnj3wFWv2ml5EFnS2MnXhlMZQ==
X-Google-Smtp-Source: AGHT+IEqxUzOabZ1DucyY45KQzSyCgTjf5JZN6pbuMgeyHva2bjR0b9AgLPBMwAygS42U+rbrSawwL8sMveWbBsIvns=
X-Received: by 2002:a50:a6db:0:b0:57c:6004:4375 with SMTP id
 4fb4d7f45d1cf-57cbd66dec9mr7486750a12.15.1718590103252; Sun, 16 Jun 2024
 19:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607143021.122220-1-sunjunchao2870@gmail.com>
In-Reply-To: <20240607143021.122220-1-sunjunchao2870@gmail.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Mon, 17 Jun 2024 10:08:12 +0800
Message-ID: <CAHB1NajLsZPbUJUYwvPuK=ogKkunfJauTmszzfc9VO2w+OD2Og@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: use goto style to handle error in add_delayed_ref().
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping...

Junchao Sun <sunjunchao2870@gmail.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 22:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Clean up resources using goto to get rid of repeated code.
>
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> ---
>  fs/btrfs/delayed-ref.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6cc80fb10da2..1a41ab991738 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1041,18 +1041,13 @@ static int add_delayed_ref(struct btrfs_trans_han=
dle *trans,
>                 return -ENOMEM;
>
>         head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
> -       if (!head_ref) {
> -               kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
> -               return -ENOMEM;
> -       }
> +       if (!head_ref)
> +               goto free_node;
>
>         if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_q=
group) {
>                 record =3D kzalloc(sizeof(*record), GFP_NOFS);
> -               if (!record) {
> -                       kmem_cache_free(btrfs_delayed_ref_node_cachep, no=
de);
> -                       kmem_cache_free(btrfs_delayed_ref_head_cachep, he=
ad_ref);
> -                       return -ENOMEM;
> -               }
> +               if (!record)
> +                       goto free_head_ref;
>         }
>
>         init_delayed_ref_common(fs_info, node, generic_ref);
> @@ -1088,6 +1083,12 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>         if (qrecord_inserted)
>                 return btrfs_qgroup_trace_extent_post(trans, record);
>         return 0;
> +
> +free_head_ref:
> +       kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> +free_node:
> +       kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
> +       return -ENOMEM;
>  }
>
>  /*
> --
> 2.39.2
>


--=20
Junchao Sun <sunjunchao2870@gmail.com>

