Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892F58B377
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiHFCpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiHFCpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 22:45:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C62B1EEFE
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 19:45:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a15so3252265qto.10
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FB+XeVQ80mrQdXWFBUx+uWLxEpxIeWoWY/F5wj4d6Gg=;
        b=rrBstr/G7EJ/ByIa+f4a34GP7PBKkxCcJtxyhEiWifJUr3SRhvBux0tAdWZ951WX9H
         BSomfAC5vdoUmI3EyA/mZo/9LPSgb5QQpr0rs1OWvhVXU7Zv4lJjY4BSoCWtqYZS2bNg
         Ak9w2IR/+oK2OLDCF6X+ahbvaKF3Idya/8Olo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FB+XeVQ80mrQdXWFBUx+uWLxEpxIeWoWY/F5wj4d6Gg=;
        b=BiG1RTR5oHo0w+Oo1p2HUuGNHgKHFsVZ/0zEhb3e0ORBfaUHW85dGkhxiFKsVwxhcC
         XVswCpddmt7fLQfA2dIiR5mW0fQ8xlhPk57AZym0wn6n4/ElICs1nK5zk6gcNgPrx9dD
         AcFT4ODLO3R6j7fL42cZHsBVabGFCQeuPgxngMkhhNo9goWz9xVCNks6vpvOkrmt9azH
         +JIDbKbqmcgt47bdlQMudCizUnnWuS94UoYTIk7rzn4+xvC+EacInxVnrhVtMHmUkQDm
         IorXuqr9mnTO+OPczoFAu8VYvNL2dcOCudRM6N+tHHjcrGuWikbrl8l23YUOWGINvFtF
         8tTg==
X-Gm-Message-State: ACgBeo2zsxZjoW9xv1wbaPVu074hQmLLeyW1LuErNOk6vMjXHavaJeUV
        f4r0LAzYwpiYxFB88nhNw2jYMOCoD2QFQUGj
X-Google-Smtp-Source: AA6agR67MIcXg2DyFEHNmIhZA9Zgf7j3WpoF9+yLOQ5XhM9N1ElRgZ2FZ3W+66i8yfoLqB9dnzvVJQ==
X-Received: by 2002:ac8:5ad1:0:b0:31f:1c49:e1ee with SMTP id d17-20020ac85ad1000000b0031f1c49e1eemr8530995qtd.624.1659753899358;
        Fri, 05 Aug 2022 19:44:59 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id v21-20020a05620a0f1500b006b5f0e8d1b9sm4056007qkl.81.2022.08.05.19.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 19:44:58 -0700 (PDT)
Date:   Fri, 5 Aug 2022 22:44:55 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220806024455.GF1146598@bill-the-cat>
References: <cover.1658812744.git.wqu@suse.com>
 <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
 <20220805211420.GA3027583@bill-the-cat>
 <99d73f60-868c-28e9-e862-04a934e741ef@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7TMqqwj3UF3xJXrt"
Content-Disposition: inline
In-Reply-To: <99d73f60-868c-28e9-e862-04a934e741ef@gmx.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--7TMqqwj3UF3xJXrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 06, 2022 at 06:44:38AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2022/8/6 05:14, Tom Rini wrote:
> > On Tue, Jul 26, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:
> >=20
> > > That function is only utilized inside fat driver, unexport it.
> > >=20
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> >=20
> > Unfortunately, the series fails CI:
> > https://source.denx.de/u-boot/u-boot/-/jobs/478838
> >=20
>=20
> OK, it's a bug in the unsupported fses (which squashfs doesn't support)
>=20
> The actual read bytes is not updated.
>=20
> Sorry for the inconvenience.
>=20
> Any idea that how to run the full tests locally so I can prevent such
> problem?

The steps in CI should be able to be followed in a regular shell.  Also
see doc/develop/testing.rst

--=20
Tom

--7TMqqwj3UF3xJXrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLt1aQACgkQFHw5/5Y0
tyzWDAv/dPBmi6Cfn84I6cn0Ox/SenGyuwfUtoXSUKi7TqlNT6uy6vouKdj/+QaH
zDrsYKxsYkR7aa542rVn3Og0Drzlw4IW3Bk7GQl/D0XfYgl4ycopIEZ7U4FiMeO6
nzVSgsEJz+3z7e4/6LGaKcU5NmTH7rdGR2CVah05/3+/4XqB/h5qR2nIGJwDQwvv
zVailfwjcNZBDRjfs1YbUg5Knv66wTh2NvL1K59tnVXBKLvKe/9jmYHgu1O1u5s7
URwfsEH8ObYl2x4w3mpdT1yEdyTWqR2LweQLzic9KImANel2Nv/RjztgOj2wtscy
muMW2Ks9EooV52KjzQbfWmZ3ybpsCptPmv+q3/cMCxpqvaBkFXxYzqA5jKNe1Pfn
wjatx2LIH1n+1kTnWi0kCvRXSs6AFl8v7TE5BVO7cRTLh+JcjWX0I9aTRJQzlipX
3Wclr18ECOF29qHWYdsYZQhsCJJ76iraX+rEIhPl82CveQw+k1kgPeMPpy6Kqom8
yrJfKkIC
=SMbl
-----END PGP SIGNATURE-----

--7TMqqwj3UF3xJXrt--
