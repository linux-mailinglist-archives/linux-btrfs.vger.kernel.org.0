Return-Path: <linux-btrfs+bounces-3970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E589A48E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D0A28575A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3209172BC2;
	Fri,  5 Apr 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="nzmz8/7C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A455172798
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343843; cv=none; b=eN6x8vGvp9m3O1jOY185HxlIXC78FmiXpNRzxHkA5+QGmLOUm5kTEa7l6l1t+nawZW3egC8Q1x3EBA0s14aD31q9P7A+2VazaAFIeb0asPpthlg729fqnywBC2F/61xlk9riNq8fGEbx6V4P7qkWU1zQARvE3HPrmmOksROn0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343843; c=relaxed/simple;
	bh=XEKl06sBIFubO4kEIxiME6RWBGOpirneG37fQIFYI+E=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=hNS1XwnMfX/tyobCXAZwcqeksWm5P8jCxEIxDmhAyqzl/oVzbQ7NGbNnOR/+YbdN6evYzHxamLXG0h5ku48D2597EfU4fmarTECl98NGQCEPPrPix+xSsiDBG4o0eO/eFQvJkJMpkMXqtSHK9EZsvvmBBPYuKjUv0j0E8w7CBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=nzmz8/7C; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecec796323so2131276b3a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712343840; x=1712948640; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5F1jQjz8GKIvENiKZ18TsL/8/SjOJRyCEoniP0p7LQ=;
        b=nzmz8/7Cy8PiExcigb6y3g79BjbFNUxVQzk4dk70l25W2LEwMVpSv334Ir4BqC8s47
         jo0ts6S4jT0yzU8SkEtqDVKgXDSjMBjk6aSyI7f01LTJdPHErnRdHIRM06QlJuwENu4p
         GM/fgFUskms0QGgxn74OQllslkkQ2ImJcmyII94zw58Msd0rYuAFYG2GFXBVuUOYscz/
         C3npn+wfT1irPkzG40mXR3Wue8aVKa836zdgJ8WAgokph0lLVEBnXCW0t10mjircurZU
         0HpTuhPHfaA0elcCal1+imtbXfvMPkURenpLd23qbRzq2bzEbt9yxXa1FHjR3jjvxRX8
         oVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712343840; x=1712948640;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5F1jQjz8GKIvENiKZ18TsL/8/SjOJRyCEoniP0p7LQ=;
        b=W6TYjs5CXoXO4F2X8iEAvyu4sKNJXMJURjdzDl7HxH+4Ed7I/cJdOFvyxqK4+bYC3w
         YzkhQMz99Q/5xiC2TtqUqa0zTPkdf5kWeKJaj73bq8xm3AtMZ6Xn4JZ73jHGurwO4zrz
         bMuWO+ux7Bly5W9Ipfupp+rgSfS+y50sSPfbJGzINwmjXMndZbYgTG588WjsU0QVb9K3
         x16BNdc9pQTKo5g57a3Zd7C/mMyDxefKmHohjEfrYICXzU93jZdjoB4CeMT0N1N33C5e
         k+tys4Ed8+w2MLYesbP1cCUfkR21mOZzZwcI1rGpPXLKorcVB2NuCdFlNHpWwyAFYrPw
         dLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqHeEsiZLTVlP0oGmOUxFP2PeDZ7o6030BqMEY+G9L0MXYIaGIy5iI6vYmP3vrWNlCxzhmENsVPUL660odkl96cphZLkqz2MoG8Ps=
X-Gm-Message-State: AOJu0Yyo1iqlWomWHGCJy5uDEtt9AkSSbR3uVZBVaFOSeZs8v7FMKi1G
	S0aHS6qLgB4ffCshodu9yOPTRvggLuG6TDfhWAUY3NCCyto/WLaXEyOEOiiy04g=
X-Google-Smtp-Source: AGHT+IFAXbDKHeg34rzADfjJc020+AOdjsWUUxei/k5dSo82HE9jteZqnbSLLu9o4twWXBB1GicQAQ==
X-Received: by 2002:a05:6a00:1489:b0:6ea:ceff:2492 with SMTP id v9-20020a056a00148900b006eaceff2492mr2676124pfu.32.1712343840269;
        Fri, 05 Apr 2024 12:04:00 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id q29-20020a63751d000000b005f3a8643176sm1791656pgc.44.2024.04.05.12.03.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 12:03:59 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <2587135E-3AF4-430A-89CF-5E49D229F2D3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9F3BC9E2-9868-456E-9EFC-C29718A65C6D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 03/13] fiemap: add new COMPRESSED extent state
Date: Fri, 5 Apr 2024 13:06:08 -0600
In-Reply-To: <2befe2c13065bdf3ca74cb8b701727940310fd2a.1712126039.git.sweettea-kernel@dorminy.me>
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
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <2befe2c13065bdf3ca74cb8b701727940310fd2a.1712126039.git.sweettea-kernel@dorminy.me>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_9F3BC9E2-9868-456E-9EFC-C29718A65C6D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>=20
> This goes closely with the new physical length field in struct
> fiemap_extent, as when physical length is not equal to logical length
> the reason is frequently compression.
>=20
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Looks good.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> Documentation/filesystems/fiemap.rst | 4 ++++
> fs/ioctl.c                           | 3 ++-
> include/uapi/linux/fiemap.h          | 2 ++
> 3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/filesystems/fiemap.rst =
b/Documentation/filesystems/fiemap.rst
> index c060bb83f5d8..16bd7faba5e0 100644
> --- a/Documentation/filesystems/fiemap.rst
> +++ b/Documentation/filesystems/fiemap.rst
> @@ -162,6 +162,10 @@ FIEMAP_EXTENT_DATA_ENCRYPTED
>   This will also set FIEMAP_EXTENT_ENCODED
>   The data in this extent has been encrypted by the file system.
>=20
> +FIEMAP_EXTENT_DATA_COMPRESSED
> +  This will also set FIEMAP_EXTENT_ENCODED
> +  The data in this extent is compressed by the file system.
> +
> FIEMAP_EXTENT_NOT_ALIGNED
>   Extent offsets and length are not guaranteed to be block aligned.
>=20
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1830baca532b..b47e2da7ec17 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -126,7 +126,8 @@ int fiemap_fill_next_extent(struct =
fiemap_extent_info *fieinfo, u64 logical,
> 		return 1;
>=20
> #define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
> -#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
> +#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED|\
> +					 FIEMAP_EXTENT_DATA_COMPRESSED)
> #define SET_NOT_ALIGNED_FLAGS	=
(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
>=20
> 	if (flags & SET_UNKNOWN_FLAGS)
> diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
> index 3079159b8e94..ea97e33ddbb3 100644
> --- a/include/uapi/linux/fiemap.h
> +++ b/include/uapi/linux/fiemap.h
> @@ -67,6 +67,8 @@ struct fiemap {
> 						    * Sets =
EXTENT_UNKNOWN. */
> #define FIEMAP_EXTENT_ENCODED		0x00000008 /* Data can not be =
read
> 						    * while fs is =
unmounted */
> +#define FIEMAP_EXTENT_DATA_COMPRESSED	0x00000040 /* Data is =
compressed by fs.
> +						    * Sets =
EXTENT_ENCODED. */
> #define FIEMAP_EXTENT_DATA_ENCRYPTED	0x00000080 /* Data is encrypted =
by fs.
> 						    * Sets =
EXTENT_NO_BYPASS. */
> #define FIEMAP_EXTENT_NOT_ALIGNED	0x00000100 /* Extent offsets may =
not be
> --
> 2.43.0
>=20
>=20


Cheers, Andreas






--Apple-Mail=_9F3BC9E2-9868-456E-9EFC-C29718A65C6D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQS6AACgkQcqXauRfM
H+DZhQ/+N+FTBJl3kN1NsBtQXtsomVevJcR4usUlY6CqAaJaOHn6SST8tvc45maS
6TzHDvlG9y5RPqk8hjc4xqjlO95zMD/wIGtJjrqMGwhSKUiHj2GQxK6/oF6Ca4US
n2f2kjIcqQNCsPa2nZ3+KqgEthxUiaBlMBFrOd5/mecaDlsJImrQ+YRMHoADSUnz
j4AgO/BVE7YTzRb7HKvxWRIuPjHIy9s4Dv/mxv0litYtM3YmWVPMCI+D1lSeXZMt
ESm1NlJOIXqaLtYu1nKgaT2DlMWwPMOtdyFl4s3m8MPEyCD0Bugvff6F9X3N6DHa
ZkIUlrdCpZPqZjj8XtckHOa8n2XyigbkhOQLCyT4bwNPgHE3r+3Gop+BmT3Fag5S
MHOwhgm0NhIkk7cD4s7vTWYNXyaKCnW9nMqmZJWthjGr+X8hL9WMgBHJsjaCpCJd
MbtQsp7Tm553K5go36SFo0Xj5Fchad7bnmg8wQ1CZspqp2VkpsW/15n4UxoxIRV2
gyBRDpwLm3sd/jIeZPhms2JQLKnpgd2a2eCiV5nLektk3gG4kt4anIdcdR/9PJJB
KquxpKDdN6wu1rzGzfWKDzyLpGuc/YAL+oqsNNMSFgk1hBP9V4EkdKz5IuN08bt5
DPU0w4HHu4d/uj3xT4VCUpVKVFmMrrGweYMBL4B4AvuLiOzjpqc=
=9xNL
-----END PGP SIGNATURE-----

--Apple-Mail=_9F3BC9E2-9868-456E-9EFC-C29718A65C6D--

