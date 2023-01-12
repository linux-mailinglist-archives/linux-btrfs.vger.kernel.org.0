Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31665667933
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbjALP1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 10:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbjALP0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:15 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01546CDB
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 07:19:24 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e22so4213783qts.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6y4G6VKriTZj6EHS1tLONkaaHaeERS1Z28UUGPSoqw4=;
        b=L4cGV+9S3Livg3Jtsmf7M66JRpd/ObNnoGkNJ2zeJbIvBb6dD30yX+PgUgQDq6FLtn
         c/lWDa9Vy9xOD6tjMKZN3QtQTQymGgfq+BYJxiiC7D/qTp/Cp8p/Y4VSgnPXUfyQprNz
         /mhjjGeLV4yR3c6ujVV+b0xgVJZw8gEaJ5oPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y4G6VKriTZj6EHS1tLONkaaHaeERS1Z28UUGPSoqw4=;
        b=HM7srNC1h0h7YkZWuEdIN6Zbl12ujho2Fj/JR3/fiLvaXqZWqwfIf/L8kW/9y+cIZ/
         4CyATf43LLDSpXsWfC8+itqEefKHe8ug0X4GlORsbfJARx4vqxZOLcytPDpw+U6FYmF0
         n56sNFZjn4EgLwZ91C7A1OPhIYKyVrSo6wDgxSdcmXQ5AR9fY/ZypRBW8RWiVKHoMIxg
         952gW0HaOS+ZGFCX1jqwmqJJQJ2gk/jEVVIujVnIa6SMJ7vsVYAvxidnKGuDiGmiDwJ0
         PKWq1B6eOuvNlO5gR87JW+vrnIlp4wLThX2qr8y3X2disSzK+cbY5/CQU7c3QA5aMWBk
         GOPA==
X-Gm-Message-State: AFqh2kohDD2kgZWjpt+Vd/bnUuRQWxEOmYnw0akjjNh9QOE7PYpjxH5M
        bIFV0mtJ6tj1tn+EAATiHekl2w==
X-Google-Smtp-Source: AMrXdXswiqKiWLtcVujA+CLfRa4hIW6hCNn6xwvNQpBZUsRg/JoBE1/zGj6VGxy3/V4wFf5IActtHA==
X-Received: by 2002:a05:622a:4f0a:b0:3b0:a99f:a2db with SMTP id ei10-20020a05622a4f0a00b003b0a99fa2dbmr8015109qtb.15.1673536764081;
        Thu, 12 Jan 2023 07:19:24 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-38c4-8177-7e9d-a94f.res6.spectrum.com. [2603:6081:7b00:6400:38c4:8177:7e9d:a94f])
        by smtp.gmail.com with ESMTPSA id r3-20020ac87943000000b003a7f597dc60sm6960726qtt.72.2023.01.12.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:19:23 -0800 (PST)
Date:   Thu, 12 Jan 2023 10:19:21 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Sam Winchenbach <swichenbach@tethers.com>
Subject: Re: [PATCH] fs/btrfs: handle data extents, which crosss stripe
 boundaries, correctly
Message-ID: <20230112151921.GM3787616@bill-the-cat>
References: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WjR7BcqVHWH/gCit"
Content-Disposition: inline
In-Reply-To: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--WjR7BcqVHWH/gCit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 30, 2022 at 09:07:05AM +0800, Qu Wenruo wrote:

> [BUG]
> Since btrfs supports single device RAID0 at mkfs time after btrfs-progs
> v5.14, if we create a single device raid0 btrfs, and created a file
> crossing stripe boundary:
>=20
>   # mkfs.btrfs -m dup -d raid0 test.img
>   # mount test.img mnt
>   # xfs_io -f -c "pwrite 0 128K" mnt/file
>   # umount mnt
>=20
> Since btrfs is using 64K as stripe length, above 128K data write is
> definitely going to cross at least one stripe boundary.
>=20
> Then u-boot would fail to read above 128K file:
>=20
>  =3D> host bind 0 /home/adam/test.img
>  =3D> ls host 0
>  <   >     131072  Fri Dec 30 00:18:25 2022  file
>  =3D> load host 0 0 file
>  BTRFS: An error occurred while reading file file
>  Failed to load 'file'
>=20
> [CAUSE]
> Unlike tree blocks read, data extent reads doesn't consider cases in which
> one data extent can cross stripe boundary.
>=20
> In read_data_extent(), we just call btrfs_map_block() once and read the
> first mapped range.
>=20
> And if the first mapped range is smaller than the desired range, it
> would return error.
>=20
> But since even single device btrfs can utilize RAID0 profiles, the first
> mapped range can only be at most 64K for RAID0 profiles, and cause false
> error.
>=20
> [FIX]
> Just like read_whole_eb(), we should call btrfs_map_block() in a loop
> until we read all data.
>=20
> Since we're here, also add extra error messages for the following cases:
>=20
> - btrfs_map_block() failure
>   We already have the error message for it.
>=20
> - Missing device
>   This should not happen, as we only support single device for now.
>=20
> - __btrfs_devread() failure
>=20
> With this bug fixed, btrfs driver of u-boot can properly read the above
> 128K file, and have the correct content:
>=20
>  =3D> host bind 0 /home/adam/test.img
>  =3D> ls host 0
>  <   >     131072  Fri Dec 30 00:18:25 2022  file
>  =3D> load host 0 0 file
>  131072 bytes read in 0 ms
>  =3D> md5sum 0 0x20000
>  md5 for 00000000 ... 0001ffff =3D=3D> d48858312a922db7eb86377f638dbc9f
>  ^^^ Above md5sum also matches.
>=20
> Reported-by: Sam Winchenbach <swichenbach@tethers.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--WjR7BcqVHWH/gCit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmPAJPkACgkQFHw5/5Y0
tyyE4gv8DECpo3sU5ZHJlk0Ii/tRrBDnE304C5ASk2AOOGsXqUL+5jY7Z5ot8yry
yv6zhDDpsDGVRoL/UMsvxsUPijcb7N9fnCsTuuxjFJHVP1/w6C0q7CvVRYNwLGB6
z9q0gbOOkwa6PcEPEM82kJsz9q/m2cR2RJPLyydkghTs7bpUBkUPCE1QhwGxS4/o
GQPY8xrvuCcahZQJx0JOWGHQ4KWY1TKFQXCwBYPwFVIFAp9XN9d7Nb2qFr26yNji
xxZclXGp87X9LSPSZKmVmYRhBNb3BPbEWh3nHT6v9jfyt21Y73stfCSA3neiISex
Dua7eh0KvlD9OdbaeEhf+4XVwWArLdtmoygoHO9pTbQl+1tYKihWGKoYK3ITFtTD
mA0xk9OQSfnnh1SctDXx/An4ZzXG6vw2TUjSCXubw32YeMDJzVGrucImJu//kod1
/HUaFw+sGSrYZy4pcWF6SgFjltHwx7lWnEQvty1654hOIhvalh6k19HQSq83NJwT
C2Tuwqu4
=dWJC
-----END PGP SIGNATURE-----

--WjR7BcqVHWH/gCit--
