Return-Path: <linux-btrfs+bounces-3972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91889A4AF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F3C1F211E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB974172BAB;
	Fri,  5 Apr 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="XHwvhxjs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95009171E42
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344125; cv=none; b=Fqf7y5IFdUpDm0HjRbb0eaYZHWZ3KafJI5h9ItXPaEVju3l6cqQqpldGuK0v1ASNeRHHy3HKovDKcxpR00smQ0x/p5n5rQ+do4nnRUVRUXdXi1p+TgigYUMql8AqoA2jv3JKj/B86j21c/MBvlEf68YnlmI+EwJ/Z8zWxsBhXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344125; c=relaxed/simple;
	bh=wye5veq5Kp9vNO8lurg4CiJ01Its6dfKvlbVtm98pW4=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=r8wtTT0ASrXYpNDvYOHakDYjL/AtYXD9/KVACPyDT9W5Ih1LmnWSZJs2dJcxx7UFGgC/5jXON9vTq+SwDPsbWae4MzIZDqTS1WM6BEnGFhknhSb1aTA9ZNT2qrKaJo1yys5fgMDbqIS3p7rOgUq+b9yjsugBhDntbuGQyduNauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=XHwvhxjs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed054f282aso602805b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712344122; x=1712948922; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkNZFLe3eGmgKHUGgYKucnDtOH0VAjv+69uvwH85wU4=;
        b=XHwvhxjsXX69ebrhUQOUO0vUoYYhBRF7SV6PqgR+jr4a930iM+DOmU95V1AYy+W1Gw
         SJkS8W0rJMknuH/+wCGv2p2VcTEJuiLDXGg8OLUOz5Vh9GaabTbgo5rrrMIZ1cAllWxj
         kor5bmGOcjCEYM2jGbxxevTa6acmGPknYyJwQiAFkg5rbwdImpCqg1NgxIuSQ9Wrtbwz
         Rc97zYMyZR1heGBVWI0zUO1YkJay3BFJ3vk6FxsOpIxUr3JNttz4KG2IihTBEyq7cTYc
         TmZscjV2dL+fFNGjP9j2CrJUqzjF03ZAplvln015NaoE6tYZcmw9yDm7TF1pz5LCeZNY
         c4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712344122; x=1712948922;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkNZFLe3eGmgKHUGgYKucnDtOH0VAjv+69uvwH85wU4=;
        b=sYrI2clvzfZEbkWRh/fJsECrmXuvAyddPHPn5roI52w/JlV71j4/HCvXpV0Xci0OmA
         2tC/A4NYOgP3ps5C+2z01MoVMcH6gNE2SB1zW+Hl8U9DE8NUvELNq8mtgEQm1Y0CWGdv
         2gTLCdfUZnDdDqLF4HPrx4w+xlRVMvhTq0ejRSFYbL0sGI43izHimrr2WOH6FRhwFTn2
         YGAfI4TpB0XixUIqc0fR186pt1yRj8h1w2eKM+dCfdh9SOE1A8dg3Gdmh6ISaWqVXTI+
         +zzAJCQjoSvGEuaq95vJgK5T3G8LVXfwiIC85yYH4wkKLP8LcFAaHyv7vrjS33bH9Efa
         5OSg==
X-Forwarded-Encrypted: i=1; AJvYcCXICY7bAcEHOqf26I+6qx865qSwI56zRyaD3XitT5Q6wsCD/lpjuwspufgUDjOcZM9MLwJV79r2XqgOo2IG3QGqgx84RK12xWUWcfc=
X-Gm-Message-State: AOJu0Yxfc9Jr/0X75BttkXpgiZxXcNma7qMp3uzF1cPWKksYtR+vjYrj
	FXLAEPYd6Iw6jgW4OIBb9UF/eryz9UEOQSRGBhroe9Tz/UJaCNiD2ROIX2Q7FuE=
X-Google-Smtp-Source: AGHT+IF1nJUb4fKVWVcqtFNp+ebx7OrH2AONGjxEQvnbKIOqXZ/4VjAYhvRIFBYA3h3iDAluaSrvrw==
X-Received: by 2002:a05:6a20:96ce:b0:1a7:1b6e:4d4 with SMTP id hq14-20020a056a2096ce00b001a71b6e04d4mr2293973pzc.23.1712344121925;
        Fri, 05 Apr 2024 12:08:41 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00270300b006e6c61b264bsm1861757pfv.32.2024.04.05.12.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 12:08:41 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <9F887394-68D4-4C2B-A5FA-1CA3D83C0E31@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_14FE9033-705D-4B95-9114-3A0DB8FFDFB4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 04/13] btrfs: fiemap: emit new COMPRESSED state.
Date: Fri, 5 Apr 2024 13:10:50 -0600
In-Reply-To: <ed3a3c3edbf01b728c20c0718d227ebb79611f47.1712126039.git.sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>,
 Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <ed3a3c3edbf01b728c20c0718d227ebb79611f47.1712126039.git.sweettea-kernel@dorminy.me>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_14FE9033-705D-4B95-9114-3A0DB8FFDFB4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>=20
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

I would recommend to merge this with the 05/13 patch that is setting the =
btrfs
fe_physical_length field.  Otherwise, by itself it would be confusing =
that the
DATA_COMPRESSED flag is set on the extent without fe_physical_length =
being set
to be able to do anything with that information.

Cheers, Andreas

> ---
> fs/btrfs/extent_io.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9e421d99fd5c..e9df670ef7d2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2706,7 +2706,7 @@ static int emit_fiemap_extent(struct =
fiemap_extent_info *fieinfo,
> 			if (range_end <=3D cache_end)
> 				return 0;
>=20
> -			if (!(flags & (FIEMAP_EXTENT_ENCODED | =
FIEMAP_EXTENT_DELALLOC)))
> +			if (!(flags & (FIEMAP_EXTENT_DATA_COMPRESSED | =
FIEMAP_EXTENT_DELALLOC)))
> 				phys +=3D cache_end - offset;
>=20
> 			offset =3D cache_end;
> @@ -3236,7 +3236,7 @@ int extent_fiemap(struct btrfs_inode *inode, =
struct fiemap_extent_info *fieinfo,
> 		}
>=20
> 		if (compression !=3D BTRFS_COMPRESS_NONE)
> -			flags |=3D FIEMAP_EXTENT_ENCODED;
> +			flags |=3D FIEMAP_EXTENT_DATA_COMPRESSED;
>=20
> 		if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> 			flags |=3D FIEMAP_EXTENT_DATA_INLINE;
> --
> 2.43.0
>=20
>=20


Cheers, Andreas






--Apple-Mail=_14FE9033-705D-4B95-9114-3A0DB8FFDFB4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQTLoACgkQcqXauRfM
H+C+JQ//RVIWVVU/mmIMIfM6I9hUuz7AfHU8nZHDzMf0XKVq1fPsPxlz3WC0eqzb
N63IB1Y3xTT8BUPsdhOcXiC0Q5SDrROjCOh2CMRJRP/SgeywDX0+li+M71DeeHMW
sL8gzCbjhZ6lHI2Minq2RVg3ZsJWbgr22+dFhbO+sIGlz1pHJb8rydIIqno9I40R
PuZD4dcDqktEBOpZgaZL/OcL2umYLxC0//7rWiYrzfTkuCfu6Otg/f4UfoPrnGfC
IwLknC6eji2x6CZTvz1iCYExpIJxRjNLpHN8QQs32rgVSXmA381ozvky63rRfSS6
LepXDGf8L7p4YaLJLyOfqmj+mFCO8UW7uVJPH4n1PBJprNFYrhRkZE0iL0IHA2Ac
R8yPgy4AVHHf2k9fqKnWT/5e9or6lSV4v6/xEC+UxoVspWqgBjqmb/x78S5PzwSY
jEmEV2iBGV7wgXU7TCF5oPfRli4Ot5CxnpNRbAHGdsIZmrepducQZhZ57ERjTqRh
uSn82O4EAjULOLFdaBZgSCU/u96PPd4Y7WeRKH6PygtKtCi2EODw6NONuF5Q8SVQ
PzQXbvmyP4JyU0K/UaaQQMFFLWjQlnkhqoZzxeieoVQ9ejl+8NKFNnkdnweNSRB0
RLt57nqqwJAbZjX8XYBpO2i5zTuN/l0/QTP/Y9ZQFy2vE++z44g=
=ixIP
-----END PGP SIGNATURE-----

--Apple-Mail=_14FE9033-705D-4B95-9114-3A0DB8FFDFB4--

