Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB42607DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 02:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIHA44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 20:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgIHA4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 20:56:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CAC061573
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Sep 2020 17:56:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w12so13915744qki.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Sep 2020 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytCFZvwIzqrPX6SP6kjn0+0zbbouQI2uTZoutprh498=;
        b=cY4bLn4f5Si6c9LGUe/lU4t2lo+mcEu9xoyDc6ZMEh/iuU5XP1ZTfTO0jSqEs6fVZb
         zimsCrH9u4PSjV+jjbyH+OYr6OWL5TP9ZAfdtItVngDw8gTgHihjKnb24PGipTk+OLh1
         FpY5ShHD3yDhVfURpigTAYYey7Bj5R/hJdl/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytCFZvwIzqrPX6SP6kjn0+0zbbouQI2uTZoutprh498=;
        b=tp2rS4GIcwuOu2IjXQx5zOH7pvB+eFHCEW3gqH6jHr26C3Eyri/5XdWYYaxkqOdfJz
         8E+h8EnMwRBYjdKHf7mZLpHHpCz90HpBxxorxjPAhN6SqbvYDhv33Es/L+Ec2rGTp/Ra
         4IaanrXpTVwgenDS03gih5bONQrxesi5Z5QvfCcA9J4Mje0EC79m7oHmgUVoyGNDP3Y0
         Mr3SLEg5qdEoa0sSpEMycmPvmFkatjn3oHtM6N+y8AdO5ekj7t/FuJaZzcJlut+Va100
         6XBeL7EQTPAGoY5Eba5egrTUCkB0+/stIDrB1Q2z6wCm4yUFrwm29OlNKX6O2EK9dAEM
         pDyg==
X-Gm-Message-State: AOAM531swYR829mOFbBnLNJUbDrSAfiTzS98y39FvNhlE1aqszsZ+Bwh
        ITzxLiwPbNC+1awOPILDiXAaKA==
X-Google-Smtp-Source: ABdhPJyJsq7T6GjX6xbrtYJ7TZxGGJOASwGSfwklZtChdDaD0zJU1GFFBfIMICXdsX8Glj5213Aqcw==
X-Received: by 2002:a37:9d84:: with SMTP id g126mr20722570qke.473.1599526610533;
        Mon, 07 Sep 2020 17:56:50 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8ebe-8cc9-065c-5dd5-0752.inf6.spectrum.com. [2606:a000:1401:8ebe:8cc9:65c:5dd5:752])
        by smtp.gmail.com with ESMTPSA id u15sm13378611qtj.3.2020.09.07.17.56.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 17:56:49 -0700 (PDT)
Date:   Mon, 7 Sep 2020 20:56:46 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        u-boot@lists.denx.de,
        Alberto =?iso-8859-1?Q?S=E1nchez?= Molero 
        <alsamolero@gmail.com>, Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH U-BOOT v3 25/30] fs: btrfs: Implement btrfs_file_read()
Message-ID: <20200908005646.GG7259@bill-the-cat>
References: <20200624160316.5001-1-marek.behun@nic.cz>
 <20200624160316.5001-26-marek.behun@nic.cz>
 <20200907223501.GA11147@bill-the-cat>
 <a88a1a38-8fce-f438-25c9-05d3edd83cf6@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <a88a1a38-8fce-f438-25c9-05d3edd83cf6@gmx.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 08:26:27AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2020/9/8 =E4=B8=8A=E5=8D=886:35, Tom Rini wrote:
> > On Wed, Jun 24, 2020 at 06:03:11PM +0200, Marek Beh=C3=BAn wrote:
> >=20
> >> From: Qu Wenruo <wqu@suse.com>
> >>
> >> This version of btrfs_file_read() has the following new features:
> >> - Tries all mirrors
> >> - More handling on unaligned size
> >> - Better compressed extent handling
> >>   The old implementation doesn't handle compressed extent with offset
> >>   properly: we need to read out the whole compressed extent, then
> >>   decompress the whole extent, and only then copy the requested part.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> >=20
> > Note that this introduces a warning with LLVM-10:
> > fs/btrfs/btrfs.c:246:6: warning: variable 'real_size' is used uninitial=
ized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >         if (!len) {
> >             ^~~~
> > fs/btrfs/btrfs.c:255:12: note: uninitialized use occurs here
> >         if (len > real_size - offset)
> >                   ^~~~~~~~~
> > fs/btrfs/btrfs.c:246:2: note: remove the 'if' if its condition is alway=
s true
> >         if (!len) {
> >         ^~~~~~~~~~
> > fs/btrfs/btrfs.c:228:18: note: initialize the variable 'real_size' to s=
ilence this warning
> >         loff_t real_size;
> >                         ^
> >                          =3D 0
> > 1 warning generated.
> >=20
> > and I have silenced as suggested.  I'm not 100% happy with that, but
> > leave fixing it here and in upstream btrfs-progs to the btrfs-experts.
>=20
> My bad. The warning is correct, and since the code is U-boot specific,
> it doesn't affect kernel (using page) nor btrfs-progs (not really do
> file read with offset).
>=20
> The fix is a little complex.
>=20
> In fact we need to always call btrfs_size() to grab the real_size, and
> then modify @len using real_size, either using real_size directly, or do
> some basic calculation.

Ah, thanks.  I'll fold in your changes.

>=20
> BTW, I didn't see the btrfs rebuild work merged upstream. Is this
> planned or you just grab from some specific branch?

Yes, I'm testing them for -next right now.

--=20
Tom

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl9W1sUACgkQFHw5/5Y0
tyxHrwwAqjSHnpt+7s/EMTJiBTqk0NGfY0DFc9oBYonFYLGIXUYEWi1dzuIN1NMn
4rhmaHeXHfSAa5tBgf97RnLk98L19+x5zzmEwDcFFB2JqyM6fjKFhfgPWsjFhYmZ
IGaPCiaJIOGQdz4d3Q/zGERdHGND3sPCVOjGpuiH2Jns8GQ5rhD4gEHvvTR0BO5r
sD7EOTBnd0z2UoTDpFmnM0lG80ym1Iu2Na5vDNMFAg7Z76qGdJKXt13872dQm3xb
wPiVxzfamHOth/YyvBhwWfD7T4y2fmavuncZoTx041QmnV6AvZNzUrun5Va6XMYw
ClQ50i7d9wOzO06NYqyg75XykdsTpYVC2m2djQpF92ZuH7o9qw7kNQflBStQ07eK
zbJSNWHVwddHiWv0VC9llHHbWubtJPH9BgHd3mRVlWsJaJCppeGVgo20kAxBmBZc
m911C0ssowPvhb+M4mOPS6i8Rza2AAb+0R4sm8SNxMZX+ZgvCt4ogBKIbu4jrtLu
55b4A6YF
=qlwf
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
