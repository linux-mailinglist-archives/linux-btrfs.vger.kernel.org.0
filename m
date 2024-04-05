Return-Path: <linux-btrfs+bounces-3976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFF89A4DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56531C20D77
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623E172BD7;
	Fri,  5 Apr 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="JwwL7s1n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AD171E66
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345191; cv=none; b=WlEHnzy8dOD8EcqD8SYkb/evGaZFwpxdaffiUsnUHIN4QIqeH3v5YKuGxuiePHI7syesS1FWcJhT7ovnwUAuMAsZ5gZAgPBokx7u+iLGClmPIxgr6KRYWuQoio6LsKxINkXWkKQqwKx9PNe/asrx84SzfZTQspDcMFrVOqgvbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345191; c=relaxed/simple;
	bh=igTRZr89tia+YLzR4KTMyLw/RdwxKuEcuOFIb1fNNv0=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=fl8zme7RJfZdWv/nP+Hj64yiG4BdNxskEqzC259ZPr1rZxYunrPfd0zYHyFfceLycqgOwucd4iy8nl7hm/2Gp6XBfkL0Gofxym2IQXe2c2+RZmaSZlypkr2D1nkeeD6T2o/qToN1jw5/phjLKB9PaGSryMnbhxYPBMGdaURQlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=JwwL7s1n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e223025ccbso14456205ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712345188; x=1712949988; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQXOMqOMheA3j5jSfwBi1wa6nrelyPrvkpkakE4BB08=;
        b=JwwL7s1nnjT0XEPHH854uf8UB/5Ew/XwJyG2c4b6z1+L4iBvtI8Y72RmNuuhp+xyYa
         sofkns2NXmcD4b0GtzJgndS8ik+n/dAkqrfAu0VPgoWGObq9DiubHATMo9InirMAyWNA
         3H2t5ElxQY4ctchIomFsRyVnfWsnC181k02mR1AurKz1nrUujpKnnsGJWkQphmva4Q8Z
         x75b4Wrk7MxYBEN5rkjeRyKoAtLzgfy+9Q44RzhHY/K2deK4fTGqt8NRkO3P2Gv154iy
         +YeAg/O6HC0h3RJxa+gbqaMNZWHqHp/4PsgTfZIG/fiDDWLhzcwslWRsrHoIsBhrk2FB
         Sa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712345188; x=1712949988;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQXOMqOMheA3j5jSfwBi1wa6nrelyPrvkpkakE4BB08=;
        b=qbgSKmF+K2kqkPq2uk4iK9y1JEKmOXrGmJPFU+LZ6MX/fg4E7UTxgAnLT/bl3NE088
         rJCGhCUQrWxq1/xf1ZMr+PvqHia48v2lhnAqkYvJuI2WXRJMxHtb6KFYYANfHPMUvOdT
         Hw6u4fedBquMvYrmgmqizf7ikHQUuwWAWHb16lRD7AluNnMPxLDdhQ6LN81uAKc8ofjE
         TaF4+lPFn1rTvrHlOMe8A+ym5cbM6z+nutFi4pilm+d4CJRzKbM12/Mt3ZWfc14nIkiP
         M8CirffqBG52fPjjGhXMl9HD+XpjIZdLSSFyzcdGa3xm6ui7hutYqoEmX0wRHOEDsQm+
         /sgg==
X-Forwarded-Encrypted: i=1; AJvYcCWnWyWk13IkhxQE8+CCpcQXc8Kyl1/1PuHfpgZt6DzZErnPCAwEgBqd1HHV2O7Pqz1rWpy3ac5ObVDTIW1kJJuLzirQhQFG/XQdi9M=
X-Gm-Message-State: AOJu0YwH9P7uNJJT3dIHyydrL4YKsEC1tA3wmOhEa5KSquQGUqkESmER
	YJAidQIm7/SWrCC3dME+2oyBSMjHPjS8tmJ/Q0kjz4Q4vK6pHO5ZgJ0qAo520cU=
X-Google-Smtp-Source: AGHT+IHlGOLDCySr/KT5KMnap8S3Ttwp/5kqb8Lz1q+LKFSRfoCjHNYyVDbbcFjOelK7Org8jrpugg==
X-Received: by 2002:a17:902:7484:b0:1e2:8eee:ca5a with SMTP id h4-20020a170902748400b001e28eeeca5amr2148522pll.52.1712345188499;
        Fri, 05 Apr 2024 12:26:28 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001e088a9e2bcsm1953865pld.292.2024.04.05.12.26.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 12:26:28 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <E34A242A-4FB8-402E-842F-89E61CE56979@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_538C0DAC-3BDC-46CE-A0D4-B4B59A2FD009";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 08/13] f2fs: fiemap: add physical length to
 trace_f2fs_fiemap
Date: Fri, 5 Apr 2024 13:28:36 -0600
In-Reply-To: <c24fc95fa184fdd799d9d3d32b3227f790ba772f.1712126039.git.sweettea-kernel@dorminy.me>
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <c24fc95fa184fdd799d9d3d32b3227f790ba772f.1712126039.git.sweettea-kernel@dorminy.me>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_538C0DAC-3BDC-46CE-A0D4-B4B59A2FD009
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>=20
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

With the compat macro in the first patch in the series, IMHO this one
should be merged into the next patch that actually sets the phys_len,
since passing "0" for the phys_len isn't super useful by itself IMHO.

Cheers, Andreas

> ---
> fs/f2fs/data.c              |  6 +++---
> fs/f2fs/inline.c            |  2 +-
> include/trace/events/f2fs.h | 10 +++++++---
> 3 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 87f8d828e038..34af1673461b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1836,7 +1836,7 @@ static int f2fs_xattr_fiemap(struct inode =
*inode,
>=20
> 		err =3D fiemap_fill_next_extent(
> 				fieinfo, 0, phys, len, 0, flags);
> -		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
> +		trace_f2fs_fiemap(inode, 0, phys, len, 0, flags, err);
> 		if (err)
> 			return err;
> 	}
> @@ -1863,7 +1863,7 @@ static int f2fs_xattr_fiemap(struct inode =
*inode,
> 	if (phys) {
> 		err =3D fiemap_fill_next_extent(
> 				fieinfo, 0, phys, len, 0, flags);
> -		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
> +		trace_f2fs_fiemap(inode, 0, phys, len, 0, flags, err);
> 	}
>=20
> 	return (err < 0 ? err : 0);
> @@ -1982,7 +1982,7 @@ int f2fs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
>=20
> 		ret =3D fiemap_fill_next_extent(fieinfo, logical,
> 				phys, size, 0, flags);
> -		trace_f2fs_fiemap(inode, logical, phys, size, flags, =
ret);
> +		trace_f2fs_fiemap(inode, logical, phys, size, 0, flags, =
ret);
> 		if (ret)
> 			goto out;
> 		size =3D 0;
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 49d2f87fe048..235b0d72f6fc 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -808,7 +808,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
> 					(char *)F2FS_INODE(ipage);
> 	err =3D fiemap_fill_next_extent(
> 			fieinfo, start, byteaddr, ilen, 0, flags);
> -	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
> +	trace_f2fs_fiemap(inode, start, byteaddr, ilen, 0, flags, err);
> out:
> 	f2fs_put_page(ipage, 1);
> 	return err;
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 7ed0fc430dc6..63706eb3a5db 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -2276,9 +2276,10 @@ TRACE_EVENT(f2fs_bmap,
> TRACE_EVENT(f2fs_fiemap,
>=20
> 	TP_PROTO(struct inode *inode, sector_t lblock, sector_t pblock,
> -		unsigned long long len, unsigned int flags, int ret),
> +		unsigned long long len, unsigned long long phys_len,
> +		unsigned int flags, int ret),
>=20
> -	TP_ARGS(inode, lblock, pblock, len, flags, ret),
> +	TP_ARGS(inode, lblock, pblock, len, phys_len, flags, ret),
>=20
> 	TP_STRUCT__entry(
> 		__field(dev_t, dev)
> @@ -2286,6 +2287,7 @@ TRACE_EVENT(f2fs_fiemap,
> 		__field(sector_t, lblock)
> 		__field(sector_t, pblock)
> 		__field(unsigned long long, len)
> +		__field(unsigned long long, phys_len)
> 		__field(unsigned int, flags)
> 		__field(int, ret)
> 	),
> @@ -2296,16 +2298,18 @@ TRACE_EVENT(f2fs_fiemap,
> 		__entry->lblock		=3D lblock;
> 		__entry->pblock		=3D pblock;
> 		__entry->len		=3D len;
> +		__entry->phys_len	=3D phys_len;
> 		__entry->flags		=3D flags;
> 		__entry->ret		=3D ret;
> 	),
>=20
> 	TP_printk("dev =3D (%d,%d), ino =3D %lu, lblock:%lld, =
pblock:%lld, "
> -		"len:%llu, flags:%u, ret:%d",
> +		"len:%llu, plen:%llu, flags:%u, ret:%d",
> 		show_dev_ino(__entry),
> 		(unsigned long long)__entry->lblock,
> 		(unsigned long long)__entry->pblock,
> 		__entry->len,
> +		__entry->phys_len,
> 		__entry->flags,
> 		__entry->ret)
> );
> --
> 2.43.0
>=20
>=20


Cheers, Andreas






--Apple-Mail=_538C0DAC-3BDC-46CE-A0D4-B4B59A2FD009
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQUOQACgkQcqXauRfM
H+BUSQ//dbRTR76g+R9wqiRBS5vw0ahQgPCf6yTSReukjBaQF0M9oly6GAGm4nN2
ilNV7M4T5M8lAN4yil25IwWcYrIjz9BBygH6en1dbB+P/vkSHXIBebtR/a2rNS3/
jxT1O/usTLB0QCUh3wtetRyWPRoD9y0hMIIxdWuBOQVFTXHCptfJ2AGl5QB2TsY+
kI9Zovu7baYF0AwgTqMIZzWsm3Vvj4Cf6k7k5EApmXUKb1BVzQANexhmZHssr6XU
BO6t9//3rDWYCkUsSI67TCmC64uGwYiCsu+4fYrVoQVO6D8YRcxWTfYh6qLTNPnA
50oFWH0R39X87I/L4iY2b2szG3956IQxJSZm0wdJSplMcJidylfOr88l1xRLe4qh
Vk4v72XzN97rXc32qn20gcuiVqXKSzXAJjnmJdPOFMzBmfk2jD7TPNW+xRT0xLdS
kGDZzEh7Iwh9vy/BUu/5nBXs1EZOLmit72jqeo8cT0nR/eZAgdX6N7LlLZQW0K2c
5D+tYcFAd7UTiTlt9yR1dv2vdNoIZVwhc24sUXyPhXdUq6G+VgvgadCjnjmu3HeB
D9ZCKOzqvtmRkxvbGeqXAAYybdLMcWYmXBw0M9s6kEONeTy3qqqrLHCwI8lp406m
xarUriKrfSZunKeZDwMJkrmNsZhOYS/JamFtZZInZW6nYKf9M5Q=
=2SWR
-----END PGP SIGNATURE-----

--Apple-Mail=_538C0DAC-3BDC-46CE-A0D4-B4B59A2FD009--

