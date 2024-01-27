Return-Path: <linux-btrfs+bounces-1858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C477383F03A
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 22:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202A12835E8
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5B81B5A2;
	Sat, 27 Jan 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="KhXchv28"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E861B271
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Jan 2024 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706391592; cv=none; b=Pq/pt9h+bibhSQI0a31Vup5NpAzdxE9+4T63sWYWOHbuvSITs1l9nakSyXulmbX6NFwpQugrMFW0rZpT/oRI0JpOKTSWhIuLiknY/4v3nhShirxkAWcJ3Kq/GuCsZ8dQvwNDbZmTgBhXTFumOADLbeWzRNS6GFW58tLPrlwhUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706391592; c=relaxed/simple;
	bh=sX6ELondmO2/DqLErpMydWRounc+pwUbf5cxWGDovo0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lMTEj2KCIl41K3caLfI9e82da3yLmTDmRfCw15qcIoFNji79Z2Ipxrd1I7BUrU9tZTp8Cfbk2nV220sYOQ+iAhtVoPuGpHuI3Q8kmBsVwlEAtcvIcFcMic3BePr67Ai2LpsyfMQVUHSSeMuwH45uu56qs9Z8L9hKFB6zwSaA5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=KhXchv28; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so23319075e9.2
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Jan 2024 13:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1706391588; x=1706996388; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sX6ELondmO2/DqLErpMydWRounc+pwUbf5cxWGDovo0=;
        b=KhXchv28Jor+m3vluNhjYdH7y88biFO60V6BoZthbPl1vE0/lukIwaIafnVzsDa8H3
         mFXemuQ/ufVlT66Gi64cdJW6EFUsvLY6yswwVBymNzFrHRZ9uzpeW4Ld077pLbT1LwpG
         Z3n0PGzmSCNba8ix4/YhShC2cljUYqN00DxP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706391588; x=1706996388;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX6ELondmO2/DqLErpMydWRounc+pwUbf5cxWGDovo0=;
        b=D527LVxCkGh0I4o6o9qLLUUVvnrxLMZ++HirRQgo+KeDd1wR+KHWz/1nfzCDnkH5zL
         FQeJHuzCG/VyyqCgjZLlWIxH1FYyD5FiThG9c4pbekR9dAgvUvVNvA4ycFUmtZ13l6u+
         Rfk++yKm+g6FA49rex5cBIQ9SqsnEmr2LGo/B/yobJ8oJ8rDGqt/DJMbFOIsyYSnSw/k
         5cPsX58rHvfbvmQCiHX8UBZKIr5KFv8uAYIz6TYpf52b786Qw5fOQdqD7c9JKy+6ROQW
         evvybD81HLqK2lvUf+VYO+6G0ZVyW4s3g/mUqj2WmpyRoLjbx8RaVvoeqdJn9PomlZKI
         kIUA==
X-Gm-Message-State: AOJu0Yy5ennom4hQZlqy95NKdtALV6AOmA86pLni8URhmdCyxndkwlpI
	xVhnjJl17qNGkISQ3x7CogyfcOxbv+8tvmPc6h01HV0ZcZ8ecFtwz7cpHEiDHPDuaKB5rww7yr3
	A
X-Google-Smtp-Source: AGHT+IHqblpl11XjqYoqiw2rw1HQagF4nQUB3SM3iTG6K4Z2+u7QL80ZwvwjXuP7IHaIplafxK6vhw==
X-Received: by 2002:a05:600c:190f:b0:40e:b93e:4a0f with SMTP id j15-20020a05600c190f00b0040eb93e4a0fmr1996141wmq.19.1706391587643;
        Sat, 27 Jan 2024 13:39:47 -0800 (PST)
Received: from able.exile.i.intelfx.name ([178.134.111.230])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b0040d91fa270fsm5682769wmb.36.2024.01.27.13.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 13:39:46 -0800 (PST)
Message-ID: <c0649a6d95144ca7040762efe467ac6ee707ac0b.camel@intelfx.name>
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
From: Ivan Shapovalov <intelfx@intelfx.name>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Date: Sat, 27 Jan 2024 22:39:44 +0100
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>
References: <cover.1706177914.git.fdmanana@suse.com>
Autocrypt: addr=intelfx@intelfx.name; prefer-encrypt=mutual; keydata=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
 NzAT4cw
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-CxXJ95y0XaLWQraIMjj/"
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-CxXJ95y0XaLWQraIMjj/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2024-01-25 at 10:26 +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> These fix a couple issues regarding block group deletion, either
> deleting
> an unused block group when it shouldn't be deleted due to outstanding
> reservations relying on the block group, or unused block groups never
> getting deleted since they were created due to pessimistic space
> reservation and ended up never being used. More details on the change
> logs of each patch.
>=20
> Filipe Manana (5):
> =C2=A0 btrfs: add and use helper to check if block group is used
> =C2=A0 btrfs: do not delete unused block group if it may be used soon
> =C2=A0 btrfs: add new unused block groups to the list of unused block
> groups
> =C2=A0 btrfs: document what the spinlock unused_bgs_lock protects
> =C2=A0 btrfs: add comment about list_is_singular() use at
> btrfs_delete_unused_bgs()
>=20
> =C2=A0fs/btrfs/block-group.c | 87
> +++++++++++++++++++++++++++++++++++++++++-
> =C2=A0fs/btrfs/block-group.h |=C2=A0 7 ++++
> =C2=A0fs/btrfs/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 3 ++
> =C2=A03 files changed, 95 insertions(+), 2 deletions(-)
>=20

Still broken for me, unfortunately.

--=20
Ivan Shapovalov / intelfx /

--=-CxXJ95y0XaLWQraIMjj/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmW1eCAACgkQe94XyOTj
Dp0Ctg/+OzCd21DZ9WcqwihjWLGatIhlh3x4T9uE/kI9/NXPjd4pZHMZ/gilut2F
StXRfE6GHtNr/ggqPtHX6wPxUGigEmnRPbwuNshGvlxctW0aaatDdzvr7AYLjnHz
p78e10UzM3Ia2DjpKRYbCuBoQtwaaKxx1axD9IU2DIem8GJA2fq4cmzBhPgKh4xM
G+3se+Hy1aSOi2TO20MkZSta+FhycCm0YYTq0dLTZjl6DI60lhgGkowoEZcCUiiV
wT2TZQuRUmyyoT9GMWeUQAwJs5OtJtHw09wXaY1xR+nIW2SyObs1Xk1BMadBhV86
hjLzIKKWH+b6hdBt3/UV8x2qlWw9Z64RhugvVItW03UvdZ0f9qQGe3qHQH0gaKaP
ANLEL7lObvEkjCJzNaGgcg3eBBVSKuicTXqTncOc8ZZ+pM8CSvFjnBWBjzaBl6pq
Lrnm9oRfiLmcoNawAGILVTsoGUOTuMiMFWiwQ66U+4xQmLdAmpTIIKwwmaBuBTmg
PmDH+YAVGOe9dwjkgG5jwTli/cNku2MxCwgfbD2G6N9ozqlJf6TuT/eFBC+fVbuP
hsyBiLi2WM2msVALCtfHu3D5XP0N4nsBngIq7QHSDsQmxRLBqW9MwXRi+h7HfqG5
qyoDwoJXudrOFM1csVO3YRX4o6sCf4zCC3Kfx8DEyK+b1uBgXuA=
=GvnX
-----END PGP SIGNATURE-----

--=-CxXJ95y0XaLWQraIMjj/--

