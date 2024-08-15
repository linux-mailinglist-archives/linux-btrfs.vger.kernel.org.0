Return-Path: <linux-btrfs+bounces-7218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F8953D4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 00:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AE7B21E5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939431552EE;
	Thu, 15 Aug 2024 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="GXTh7dj0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2801547CF
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760487; cv=none; b=vCu0urKJkCRl/6N+dXpQwx90rasZMOkuAVeSmiH7zPHe8gP7ayBxgdotNvqAEZNBH4wdTxcidapGMBwHm4CjzIfbeTGrAJN2prV2kbGbdw6W/ygC2WJj2ZGIvhVEx4DfMCCcGFNF6wjNaOEuth06Qd8AmiFTHCW2PbJvshnVPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760487; c=relaxed/simple;
	bh=AcXUrrXWVBnmrshWyGJvD3/mwG2J33jsAudWwlxT7N0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4b7Qe5TkWKZMq14tmPqji5ZurVh8iMfcNvGff7iKSqtwppV2XFfhunkkPis50jndMzzhAmA2D5o4Sq0f82q0t5+DA1dqO/8fYhU3NbPzzzf8xl+UDbGKFiFh2KhnYrEOr7CaIlkVBrSMbQTclsYYGnHTnsxGDiwXZgmFDWMoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=GXTh7dj0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e1915e18so9314565e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1723760484; x=1724365284; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AcXUrrXWVBnmrshWyGJvD3/mwG2J33jsAudWwlxT7N0=;
        b=GXTh7dj0vhf7t4qYycO8PsoJZHCQHavd1gjSMNqHjGL24y33NZWjMQJd8ZrmwvngDS
         djWPaRs83x5fB39l5j5Jkf9CuTuVTdVoCSfi/AdkrNNmegPM3JSWEsoKgITTOJhW3L1W
         yzA5nMi1n3ZeHPauWLepT54H7o89o4e5hiFs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760484; x=1724365284;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcXUrrXWVBnmrshWyGJvD3/mwG2J33jsAudWwlxT7N0=;
        b=lFOZ3LoDxq3mmcc0N/Kwc/XEYrkZXfJI5Fpwlq7Ka5O9ZHGoiXG9aTZhO/dzo1M6fN
         WpBdiMHwSlmQr7zMfLLtDxejTngvtET8RNGb6FuOgOA8KOE1M3uE9Iy75hYWos1Mjo8e
         43xee3Cm9xIxA3qkFf0+geQ0cUeW0+pgIy6+p5zMSbXf3Yz6foTyAcvkHdWsjzImosw3
         LoKFRuiSkjU70zV2BYUN8NLTKpkOP/RNs8P3qhbd+Gm75IMjmu4ZPjgeLY1syTJbiN6t
         MOX9jqB5NDJvPoNXVtjzSiFTKzrybcF2jqAyC04Zze4iywAS0wQ0PUjxtbP9pxnL1TPI
         u8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU0TB4TS0wazpPgxIXkwxG8MCBYFCFRbIBfxPFTrqueA55vjg2azsW8Too7dbgXkZ4wB8BiCD/IWeH9jcaw9l4BIcalT2qU579y7fM=
X-Gm-Message-State: AOJu0YxFgchhs7Qm2bBaw5qlX3Aksblcvljp/KfwbBJzac33+0wb4rK6
	8xgz/6zf7seA9OF4eD/LzUlyskkw2bTBBiprypdp04kim7dwNrdx1Ovd3V4gZ60=
X-Google-Smtp-Source: AGHT+IFZiXzy5v8BpOcQa6CPapu9yZigbtU1YiTee/Yk77ApgvfAnMubjh+4+GM9o8FBfTOKivIvfQ==
X-Received: by 2002:a05:600c:5103:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-429ed7a5f52mr4870645e9.4.1723760483820;
        Thu, 15 Aug 2024 15:21:23 -0700 (PDT)
Received: from able.exile.i.intelfx.name ([109.172.181.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed4a857bsm5891885e9.0.2024.08.15.15.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:21:23 -0700 (PDT)
Message-ID: <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted
 increased execution time of the kswapd0 process and symptoms as if there is
 not enough memory
From: intelfx@intelfx.name
To: Filipe Manana <fdmanana@kernel.org>, Jannik =?ISO-8859-1?Q?Gl=FCckert?=
	 <jannik.glueckert@gmail.com>
Cc: andrea.gelmini@gmail.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mikhail.v.gavrilov@gmail.com, regressions@lists.linux.dev
Date: Fri, 16 Aug 2024 00:21:20 +0200
In-Reply-To: <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
References: 
	<CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
	 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com>
	 <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-N9kYIbgMAIJwZYJIoizC"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-N9kYIbgMAIJwZYJIoizC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2024-08-11 at 16:33 +0100, Filipe Manana wrote:
> <...>
> This came to my attention a couple days ago in a bugzilla report here:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219121
>=20
> There's also 2 other recent threads in the mailing about it.
>=20
> There's a fix there in the bugzilla, and I've just sent it to the mailing=
 list.
> In case you want to try it:
>=20
> https://lore.kernel.org/linux-btrfs/d85d72b968a1f7b8538c581eeb8f5baa973df=
c95.1723377230.git.fdmanana@suse.com/
>=20
> Thanks.

Hello,

I confirm that excessive "system" CPU usage by kswapd and btrfs-cleaner
kernel threads is still happening on the latest 6.10 stable with all
quoted patches applied, making the system close to unusable (not to
mention excessive power usage which crosses the line well *into*
"unusable" for low-power systems such as laptops).

With just 5 minutes of uptime on a freshly booted 6.10.5 system, the
cumulative CPU time of kswapd is already at 2 minutes.

Regards,
--
Ivan Shapovalov / intelfx /

--=-N9kYIbgMAIJwZYJIoizC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAma+f2AVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dliYP/3SLMKaoIMi8wNJiZRY/ENITiwSe
toZK1Q70t6onLZcxpjJ+5HqlAuTWyufHx5+o18oqlSgLSWDM8U0fzWJlcooeoQtq
okW1aiU49gLaHjpP8W0dJO/3ECMZkZ3LMv79qK5xiirAUMuQcs/Q9FBHZlKyF5rB
jW+Abg4ShIm453X6mVYJUYgouigTNQwMTSIriagtd3pOGQ8pTyXAoJT4JLhGrvhk
1oABDcKa/y28ryjP0KznEjOPi5EEi/7c4UQZ/dxuIc88lAQdTu8bBFTtNvoEU4sO
LOMFOOjVt/4tIskK56VSHKC/V+u2mDuab6WE+uN6QCHKj4KJoJb4JMgIA7xM/MPX
81fMnc+2EYHaYP9Kx1RIU71uTxRkE/W9tAU+s9WOG3jiGXMsS3d2Z8pkGUkyoW6H
2Nv8q1T249rVduFAL4jV7M7zfWQ4mt8uNz+KI1hV8eblZXFBLHZ/MfJiCKhXeVcn
Jnc/+4bU052iEyzGsoERZnrs6qptexrWWHPap1BOB8gpAQq8/YS/y1A5xQheoDS4
AvRIWr04xMNhpMLQAeKwzwr03Pn3jFL7U2kXYVNJjU44A2DBhZsHA+HLgJhkQTvE
Ez5pOrkx3GQf50T3L38bheQdRDGZVojNyoNdSYdcS++jxauHGtoI2MqmGLryMc7V
NReL9QhNRCUKP/sf
=yxbx
-----END PGP SIGNATURE-----

--=-N9kYIbgMAIJwZYJIoizC--

