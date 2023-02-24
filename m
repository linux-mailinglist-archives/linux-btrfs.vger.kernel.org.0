Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9931C6A1D9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 15:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBXOnJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 09:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBXOnG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 09:43:06 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9DF12879
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 06:43:05 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z6so2851796qtv.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GjxMeVZ2V93JPhV+GkvfhXv74XBqSHG636s0Z6I3pPw=;
        b=FAbqfqx5DahDVDRbSWP/aaG9xTpOqwW7t8eiT8otPuoevrIJKrakd3Hu57XLeFkTdf
         5cv795nzvgI4kQC+odcQA3S+lB1xpj+z14NkSL+fsYIv/XWgDrbdj76h9E8phuEVhS1p
         /J4DygzJE/gmK8fBLC5B4cfpRwFVNyqEI8aJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjxMeVZ2V93JPhV+GkvfhXv74XBqSHG636s0Z6I3pPw=;
        b=UknB45Z3koK13tPWTA2L4u5P3RT9v3w8Re5s0BHI0Hf6O54V62lvt4If1PVJkXZOPW
         rNgN0wyF2VUH1L6yStqkomik6xTIOJAPePKngu7U5dVPKTUxEsBHBRP7eXMhxqFCn/0F
         prj6GWJnsRwYH9CaPCUF7eEmG1oEgIVrNwQ/kYKBs/NG6CzZ4RZdlPZrS2ab0yY8M2ts
         Pd69U/2qrTsfLwk89ZKsTjjkkqxX8WVRGFQB3AMzTMAC66g+hnSXIjKIyAXWP43xFEp6
         s51H8gd44yhYesp7mhY/4LtUp3JI0EO6CgA+LF5szq2FkWs1EJ6TMGCdaiNPqClWh/v4
         bT7Q==
X-Gm-Message-State: AO0yUKUcO70KKtbK+ZkFx9u+95m5U325c3aLMvg58LC3jbrovgH/Xbnb
        f0jz/NOT8Sn5izh8UjKpvQ4Fr+GlWtNnKaEYp5I=
X-Google-Smtp-Source: AK7set8KMb2XK3ztM0oEtYbXsHjfNZhqX0d78fl2EX/gCcAL2vJC9fmkoLJXs92j91fG+4PU1NdY5w==
X-Received: by 2002:a05:622a:1048:b0:3b8:4951:57b8 with SMTP id f8-20020a05622a104800b003b8495157b8mr14878636qte.15.1677249784105;
        Fri, 24 Feb 2023 06:43:04 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-7b76-35a4-b335-d04d.res6.spectrum.com. [2603:6081:7b00:6400:7b76:35a4:b335:d04d])
        by smtp.gmail.com with ESMTPSA id 206-20020a3705d7000000b007426f115a4esm1598331qkf.129.2023.02.24.06.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:43:03 -0800 (PST)
Date:   Fri, 24 Feb 2023 09:43:02 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] fs: btrfs: limit the mapped length to the original length
Message-ID: <Y/jM9hON98uyocFI@bill-the-cat>
References: <99e2c01bb0366af9aec7522f7109c74b09c5509d.1676248644.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8e0zc3Dd6/EdfhGB"
Content-Disposition: inline
In-Reply-To: <99e2c01bb0366af9aec7522f7109c74b09c5509d.1676248644.git.wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--8e0zc3Dd6/EdfhGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 08:37:59AM +0800, Qu Wenruo wrote:

> [BUG]
> There is a bug report that btrfs driver caused hang during file read:
>=20
>   This breaks btrfs on the HiFive Unmatched.
>=20
>   =3D> pci enum
>   PCIE-0: Link up (Gen1-x8, Bus0)
>   =3D> nvme scan
>   =3D> load nvme 0:2 0x8c000000 /boot/dtb/sifive/hifive-unmatched-a00.dtb
>   [hangs]
>=20
> [CAUSE]
> The reporter provided some debug output:
>=20
>   read_extent_data: cur=3D615817216, orig_len=3D16384, cur_len=3D16384
>   read_extent_data: btrfs_map_block: cur_len=3D479944704; ret=3D0
>   read_extent_data: ret=3D0
>   read_extent_data: cur=3D615833600, orig_len=3D4096, cur_len=3D4096
>   read_extent_data: btrfs_map_block: cur_len=3D479928320; ret=3D0
>=20
> Note the second and the last line, the @cur_len is 450+MiB, which is
> almost a chunk size.
>=20
> And inside __btrfs_map_block(), we limits the returned value to stripe
> length, but that's depending on the chunk type:
>=20
> 	if (map->type & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1 |
> 			 BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4 |
> 			 BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
> 			 BTRFS_BLOCK_GROUP_RAID10 |
> 			 BTRFS_BLOCK_GROUP_DUP)) {
> 		/* we limit the length of each bio to what fits in a stripe */
> 		*length =3D min_t(u64, ce->size - offset,
> 			      map->stripe_len - stripe_offset);
> 	} else {
> 		*length =3D ce->size - offset;
> 	}
>=20
> This means, if the chunk is SINGLE profile, then we don't limit the
> returned length at all, and even for other profiles, we can still return
> a length much larger than the requested one.
>=20
> [FIX]
> Properly clamp the returned length, preventing it from returning a much
> larger range than expected.
>=20
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--8e0zc3Dd6/EdfhGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmP4zPYACgkQFHw5/5Y0
tyzC3gv/T3YGdv+jtrb7m3q0Exx1+NT1G/yi94TCRokbjX0LP29Zp+OOMEznOND+
okQo6I3Z4HI0+2Z+dv6XQw1DyFoRTxEggnJ8Emr6EUs3JD/G4Gb5vh70dWSSC92k
sYE0a1+IL2gZPs8Qh5XX+98f9w5sNK+LgdupTXgrU7FTUhQ9NbPrBtIBVhrA0vW5
85ehsN/B/D9Nxar5rLlyuPWhNWAYMreGqIURkKSUZESH9iau1wuVamyLj9I5ej5D
aeYMAqYxPFplkaElcen+ebxXtlW8GZjhj/YrSPk9U+hZO1tAUaGlJvbC43KLxm+s
AAG4rdZ7BJPD4vMNUsEOynOiCbnUG4wukkDnl/TF6kt7LuHRKhsT5HESVnjxmX8E
lce8szt2UtsaCHMaJ4AaBsE0FtiTEzRKE+mZOwDeJqpFcLK4UuY3Dz+DsOax1DFn
xq6XJGfKD+mSVOgTpaEmMITO/0eFRyPGkOn1s3Ebj0XI7JKRJX4WMXYytLTYfgv9
ifoM/ruO
=i5+K
-----END PGP SIGNATURE-----

--8e0zc3Dd6/EdfhGB--
