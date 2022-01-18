Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C06492C8C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347416AbiARRjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 12:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbiARRjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 12:39:40 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3EAC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 09:39:39 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d11so10411316qkj.12
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HEpNzAuUuWXQjc6baJMYdW+RsniJfOKSy4lRRJ5euR0=;
        b=YkXGYOqw84gOhjAne/jSVDWbRHsBMO2O9LotbM2s9eeCjuubRur1rYT4EcgJX9WmxH
         xJejPO+nybEmLwslLIDJ1ZIvB8iEWWdA4AmWIYTWi3RGRhJBlDAJ5UAyJ+6FEm++uOKa
         6mhft9rHvbiAt/2BJEKRwt9GEB9A63zUrOfiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HEpNzAuUuWXQjc6baJMYdW+RsniJfOKSy4lRRJ5euR0=;
        b=VZvEnYKFb+73A+ba20b/BI999jQgcUcIcDus68KMs8jAqaMbDwqN+aWAEVbF6JgX/4
         7Bf5qFqg/XNWYHpchQBNzfKXaW1Iix2ouuRjVl32TFWqkvwNvxPiU+klNlb/NRQRv9FK
         FIOdxNbH/FzcU2hYtAVsVArgAFUnaKMmrrqTv2+0j5DuWr+XOKnb/MCeiq60H1Y3F1f3
         Ls5Mjn8LJdCLf64cHpyaQQnZpGR6PjwEB4/3H0DwoI95svLpDHWVdwO7n1PkNZyk1Y3A
         W0M7sk6U4VK/z2jTJvM9obsQLAZKXcfobA1auBMtTCkPH/pRglvDUivvpq4D2eHFtmVm
         WzqQ==
X-Gm-Message-State: AOAM530/qicxsgWeiJu2ZI9DFQaCDyV0hHBfgChFwtNcv4vlwxj5TN6k
        kYPgi+aSNBZtVvXK2i5y/18Mqulnp0SxeA==
X-Google-Smtp-Source: ABdhPJxG4csRRt+Y+HtqhmmwKiPAV+9TvKnPloKBSquidV6H8HVWaq/ZcWdrY5zvgQatH/zzb8Pltg==
X-Received: by 2002:a05:620a:1a0a:: with SMTP id bk10mr8596746qkb.537.1642527578948;
        Tue, 18 Jan 2022 09:39:38 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b01-cbda-ec5d-c40e-552f-ed0c.res6.spectrum.com. [2603:6081:7b01:cbda:ec5d:c40e:552f:ed0c])
        by smtp.gmail.com with ESMTPSA id g6sm8224532qtp.44.2022.01.18.09.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:39:38 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:39:36 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: fix a bug that U-boot fs btrfs implementation
 doesn't handle NO_HOLE feature correctly
Message-ID: <20220118173936.GQ2631111@bill-the-cat>
References: <20211227061114.54326-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rG+KBTClKkGekJUE"
Content-Disposition: inline
In-Reply-To: <20211227061114.54326-1-wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--rG+KBTClKkGekJUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 02:11:14PM +0800, Qu Wenruo wrote:

> [BUG]
> When passing a btrfs with NO_HOLE feature to U-boot, and if one file
> contains holes, then the hash of the file is not correct in U-boot:
>=20
>  # mkfs.btrfs -f test.img	# Since v5.15, mkfs defaults to NO_HOLES
>  # mount test.img /mnt/btrfs
>  # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
>  # md5sum /mnt/btrfs/file
>  277f3840b275c74d01e979ea9d75ac19  /mnt/btrfs/file
>  # umount /mnt/btrfs
>  # ./u-boot
>  =3D> host bind 0 /home/adam/test.img
>  =3D> ls host 0
>  <   >      12288  Mon Dec 27 05:35:23 2021  file
>  =3D> load host 0 0x1000000 file
>  12288 bytes read in 0 ms
>  =3D> md5sum 0x1000000 0x3000
>  md5 for 01000000 ... 01002fff =3D=3D> 855ffdbe4d0ccc5acab92e1b5330e4c1
>=20
> The md5sum doesn't match at all.
>=20
> [CAUSE]
> In U-boot btrfs implementation, the function btrfs_read_file() has the
> following iteration for file extent iteration:
>=20
> 	/* Read the aligned part */
> 	while (cur < aligned_end) {
> 		ret =3D lookup_data_extent(root, &path, ino, cur, &next_offset);
> 		if (ret < 0)
> 			goto out;
> 		if (ret > 0) {
> 			/* No next, direct exit */
> 			if (!next_offset) {
> 				ret =3D 0;
> 				goto out;
> 			}
> 		}
> 		/* Read file extent */
>=20
> But for NO_HOLES features, hole extents will not have any extent item
> for it.
> Thus if @cur is at a hole, lookup_data_extent() will just return >0, and
> update @next_offset.
>=20
> But we still believe there is some data to read for @cur for ret > 0
> case, causing we read extent data from the next file extent.
>=20
> This means, what we do for above NO_HOLES btrfs is:
> - Read 4K data from disk to file offset [0, 4K)
>   So far the data is still correct
>=20
> - Read 4K data from disk to file offset [4K, 8K)
>   We didn't skip the 4K hole, but read the data at file offset [8K, 12K)
>   into file offset [4K, 8K).
>=20
>   This causes the checksum mismatch.
>=20
> [FIX]
> Add extra check to skip to the next non-hole range after
> lookup_data_extent().
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--rG+KBTClKkGekJUE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmHm+1gACgkQFHw5/5Y0
tyyPvAv/SQR2PcfSDmOo4vz3yyfxH/d9Nvp62PVFrfnx5WzKyPYSbxqz4TperjhE
/rbvSraYiW1HhFPKOExNtebg+WWsLTOyUPh8KxEnP9P6o4mpAf3WUgfmSbOaRiCA
uz92Yd6oR8uy/7FXIvSFOe4nPbg7875RNFwazBqag8YWH+T+A6NFvwBdUgyGDFDn
7gjdxbLY4m2xQSiI+PBQgDzmwUuzFR1SLDtMo9tBJBR/zqp/NnnEvN6U2VJSgktx
3GUkchFkgKBHmBfDUzlI/QQb+mGMBf2XZPaaomJf31/5wfVWVMR/koG4dfLrDEAV
CbDTzR1uAr+spMX5yyMMFYKGml3GAGXaC6mP8Qy+oKpmQO3gcpZRt1RhTUVjO8kC
cUoyDAE7FHsR34eGvDYMU00JJjlILR1cSK++TkJzs0/k+TKokMpzfCCeN5VS3GdD
hJ2Ms2ADVmZb2QsM8BdQSNpMxwDUNt+1NwsiQjS+DXw7oUZTbGn2Jtp/zrKLOjrC
UKB/KJ+t
=TE3C
-----END PGP SIGNATURE-----

--rG+KBTClKkGekJUE--
