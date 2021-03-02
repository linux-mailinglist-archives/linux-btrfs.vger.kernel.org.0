Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA30932A162
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Mar 2021 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbhCBF4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 00:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574549AbhCBDrr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Mar 2021 22:47:47 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05492C061756
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Mar 2021 19:47:37 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 2so9323285qvd.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Mar 2021 19:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/PV5q5NL/ppXZOH3kgi57MBUuRvV5B8kY86lC5TC79M=;
        b=B8sRbjcwwC5dmr9zWiUV3izYIasj8hsaAnjAFmxg5nf7AOS6rO1MfIQpkVUgo7Fa8N
         Evnbz5+T1UKfHdQyxtAcw4aEDOpWZM8kuxBZfm9Mj3hRWYzQNieNgrsHVxFSK86WONcz
         wobXELjtyte3Oe+ULp3A/lcWT8KA1n5dXOGPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/PV5q5NL/ppXZOH3kgi57MBUuRvV5B8kY86lC5TC79M=;
        b=Z93QS02nUcoYvXQvJGOeCXAGiZm8Av/lKNxBREvJTuudttesUImqQ2EspFyUC9HwaU
         o85r2McrYq7wODVvbtb95RSdOwa/kbOlUVbEVU62tyTElFJ9iqS1zP5GIuRH+0zK1XMp
         wwQ50bT/nNxVXgNzmKrDkmZ2p5ac8K/6XSwY+ONsjo1SDNDf4/qri+GBmYJd0Qn2l2uk
         hi0a/de2F4lmCIqEQWHc5mCyofYmWENe/y7edi+p3S5JyR2ORWoNhf/7o0HcZgKF8t71
         kuJ/H79a1Fy4rnXGSFoOE9AYY9+ERVkC0FwRi7yWPSbqB9yoGUqD1IYYZ2C8id7rpREV
         kCzA==
X-Gm-Message-State: AOAM530bYezWQ+ZQMkBRVOUmlvrKsm3E0qK1J+MfUDfp/JsgsvmtJWXE
        K/+HaGCthFLKOb3FHlpgD7l0Ew==
X-Google-Smtp-Source: ABdhPJzU0l80/UFV+8HfU258cS2JOx2/wzrfMw5wnIxKP6rOU+kNwuTzmeFdkTQ5yDZjvZYiM5+6ng==
X-Received: by 2002:a05:6214:1110:: with SMTP id e16mr17867646qvs.62.1614656856208;
        Mon, 01 Mar 2021 19:47:36 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b07-927a-30fb-7089-a2e5-f4c6.res6.spectrum.com. [2603:6081:7b07:927a:30fb:7089:a2e5:f4c6])
        by smtp.gmail.com with ESMTPSA id y20sm12042795qtw.32.2021.03.01.19.47.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Mar 2021 19:47:35 -0800 (PST)
Date:   Mon, 1 Mar 2021 22:47:33 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH u-boot] fs: btrfs: do not fail when offset of a ROOT_ITEM
 is not -1
Message-ID: <20210302034733.GO10169@bill-the-cat>
References: <20210209173337.16621-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F9CWS3VM42WKjaeu"
Content-Disposition: inline
In-Reply-To: <20210209173337.16621-1-marek.behun@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--F9CWS3VM42WKjaeu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 06:33:37PM +0100, Marek Beh=FAn wrote:

> When the btrfs_read_fs_root() function is searching a ROOT_ITEM with
> location key offset other than -1, it currently fails via BUG_ON.
>=20
> The offset can have other value than -1, though. This can happen for
> example if a subvolume is renamed:
>=20
>   $ btrfs subvolume create X && sync
>   Create subvolume './X'
>   $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: X$
>         location key (270 ROOT_ITEM 18446744073709551615) type DIR
>         transid 283 data_len 0 name_len 1
>         name: X
>   $ mv X Y && sync
>   $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: Y$
>         location key (270 ROOT_ITEM 0) type DIR
>         transid 285 data_len 0 name_len 1
>         name: Y
>=20
> As can be seen the offset changed from -1ULL to 0.
>=20
> Do not fail in this case.
>=20
> Signed-off-by: Marek Beh=FAn <marek.behun@nic.cz>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--F9CWS3VM42WKjaeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmA9tVQACgkQFHw5/5Y0
tyy3Wgv+I3cCGP51qKANA22xM0YB0Rzl+aEl/RGFITDBXVrPlGL/fmXXWNlcAa4Q
oNyGrX8yayXMgfJaKCmAPyClQOGqfLeTyWNGT2b3K9HIeaIVc8+6ANuBAOv0Lzfu
L5UvHtLHlb7nP/TvdC8BJVJfj8Goswvutszf1NOQISqiFBOLr7R1+YoCfLw3fhb2
to+e4MRplEfgxqX+mks1cNJ3+nC5NMMluGKaETeYDUoeJdUe5qRv3mlTvcuxBlOm
sVqDaGeln5gol4ViaMkQOdwC9TYM9nq9ekpvoDZqtiCsndnUOUXYh8bBV5y1deZa
kCH3uhp1s9Ra6APRm+Al5XBxrlYcDK7vdIWcDpCBuaK7c6HAf3RycxojJ9OPCPMZ
v6TrVbs/TrwFTl7mMHLQjiwfSoVzo3+akkFKk5I/kBJ6xQgRRmuUYXP1tOs//DXs
9g+SqGvx/k7J/G+bAPfJiB/oCkY/BcOcjZ18nSDBsxn8i1tdZ9SPy6HF7wU4Dib1
jh1J4D+J
=CFCv
-----END PGP SIGNATURE-----

--F9CWS3VM42WKjaeu--
