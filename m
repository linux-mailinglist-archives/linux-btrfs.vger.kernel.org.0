Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF155B774F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiIMRHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiIMRG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 13:06:57 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 08:56:06 PDT
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C264C57AB
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1663084504;
        bh=9yOJoey+GkdOo/8GOATnPApYCns8MB81JuspzHR93j0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=K5EE0T0EHH9OyiCGD5Ihnfl5XgrUUzO1hVjWWN+yhU3jML0RQRznP5ObRciY8p1d8
         nGXjfi1XmYYq7+CRpz4wA1whQZbGJqNFSd7fYC46gzQm7iygaCojUbShiAm+ikqkRM
         EczdpXUz+wEYYovNb/ztUku02gT0/3xT1JR+0T78=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([82.207.254.106]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myezp-1pWr6n3LyP-00ykrE; Tue, 13
 Sep 2022 17:48:36 +0200
Date:   Tue, 13 Sep 2022 15:48:26 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Mariusz Mazur <mariusz.g.mazur@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Is scrubbing md-aware in any way?
Message-ID: <20220913154759.147d1f40@gecko>
In-Reply-To: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
References: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4OJtgZgzsbq4uxc68qSqJqr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:1ypXeBBrXjj2s6aUtBB6J/bdAhor1wio6ePEUEy+AMvStVbLR9y
 T5QbhvqbooNr4B9ppdh+36xYrOhWmkzcs0lgJGND9VeSReUc+zjRnEWbAewR3sDdP+sBAkP
 6GMNzRDQ98N/N0YJLPeuNaeNwoNwNMfzUwj9KqRZSop1IwOcjRSa97CTREqTrBoTXuZvnBV
 bFp3U7vaZi384UyIoakRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ebOpIu/XLp0=:rtMLTvZLNchobPnoCcrDzv
 zn91ia8007DLzIaGjQQLcgtFLrXZCBfXICxIDTBdv+CZZoKnzR7kjWDtgW4af+OTzobRA8pIX
 yrulV50k1MOjcuxbUugjkZbX+qGb3lkkFmGYYBmNroyUSevXtwdMXLK6USz7yoUPE7+riqSXU
 O+eKSuKws3M/Jrb5Lj32ZnNogAkVD1JnusR2NjJo2PtPTjrdg3SkPVviI8l2CkFNzHjwZRLZd
 HjghYX9w+6ZQkO4+BxZ+jQ1gBFOOqTRpp56aJZ6Xa2e2Z0QcLN30Uam46gNMyB3u2/eBT1AYs
 K8QrJNNjxIFERaWDtKRdxT5ZpNboW7/2/J6iT+TGfb/nc3UA1cejgdNCS1SU4KybfMy2QV/XW
 TYchl60TjZAu1WqvW2yNgIPB5vyvCte0kbsTbXDGH+6z7ab9wUGa02rpRvfKHj5vGncpoi1wM
 1VKdcVKGK/s54u0Ff9BsNhhHmGUM4Bxk3r9X9fbTdrNXby/3C0cHDDG77Bmc2Xdyt6a0/2tBw
 AsoYg52eUS5U/d3Y/ZlthH22X5MGncvClLml4qwvTN3xhH3dmyDsFb3sG/l0f4z9bklyHj87A
 ojwVwWcRVx8prOHuPoPbpeC0x7DfScFY2k1mbCbvCKaYcuLu/gLbpg2xUpJc1KYQFeTPeDcua
 xxvUCvveRIWrP8KCqoWMHwf0eVn9rgMygmfxQBxPBnqtwlmy7jED3qn2EUowhlNmUa5DTO/NR
 RvM5c3bgY1be/lfBjbAiGSpOencraVq+E1jnVetCuZMiLum8p+QHHZqwTbIHrsHXY1JEf4b8I
 2EJyLMHoCEj4uwk+HOzmWt18XqjxE9sUaAxVLDrho0NqLpFelmTcpLadfPHQu99qIBPQAGheL
 TGYrDArLDEl/FvRlA/vKPo5nHmJ258gxApQNsIfcO0+UpDs4JTshgWFyfeZp/qN1BIkYzSJvB
 h2Lls8bVhvwtyu0AnHG930f108+1PhSwYh6uOHn5tOD+E3ZWi1jWEc/8xaC6ORcGuv9jjMU8v
 TE+Uj4EU+DuPuR6Ym2oCKn2Vk2XR/hqsDFmoNkxANCBptoIH17kFVTJhSqVhD9hFty0yEDS84
 AXoUc3OFp7v9770tJD3JQuh66N9Iw80XNeTbFD+dK1Mt1TctLPKmg2zrH1lD9SZWTawxjX/BC
 xWRHBsxm73ryIvy3hn91dFdLmT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/4OJtgZgzsbq4uxc68qSqJqr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Sep 2022 16:15:26 +0200
Mariusz Mazur <mariusz.g.mazur@gmail.com> wrote:

> Hi, it's my understanding that when running a scrub on a btrfs raid,
> if data corruption is detected, the process will check copies on other
> devices and heal the data if possible.
>=20
> Is any of that functionality available when running on top of an md
> raid? When a scrub notices an issue, does it have any mechanism of
> telling md "hey, there's a problem with these sectors" and working
> with it to do something about that or is it all up to the admin to
> deal with the "file corrupted" message?

No.

--=20


--Sig_/4OJtgZgzsbq4uxc68qSqJqr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMgpkoACgkQNasLKJxd
sliEkg//WmLHCbz6keIJnDbI9i6mNzDy2248U7fPdlI0YSBYMt71nYqtzpag2N3c
9v/pBdKw7aY2VLmBcRvv61g/weU3QHYiduhoVGNhmhQEdrzcl/NQhTjyHuaUvGID
XaRNmo6mwvk749nCcgcWbnsKYQq9wMCzBZik0LSA1XQBISkH69lCsE7KPBtJJQIh
wUvnS9W54d0pYtwWTNEeK2Ob9oMvZbuiXkgMw1K7lkIosbDzTtBVL7FyB52raY8j
CfjJ0sKXuN5Nkkci/QoM9UQK0/fTQqaYCFj0VpQxubuXSwPvr1j+tZZT21fVyrDo
yXl3fg/MXVQfs+lrJyJw/jjm9k1QVtVIbERCipF+UBWHR45dBrSYNBfgkRSLKnu1
30NhPP+uLldTFRlQyEgYSTBQItegcqYLELABNuHh5iMysJWVLI+XbYWeq+LvEdwc
ricbwqAFGuqxcKelpN8fqVP1i/yyUVWXXB+MmxXvWJbD5CFs8blLM4ctSjod2LGa
OSn6899yQ6QwohYftT+kJrZh3tjlWJdOEPvKXXgFxMod8lz/uA9chWEzf8r/ALwy
3VNRbAAmWQwFp4mjVOkN6/VDazVXY9wXCXdf0o+j8B5DuZGjAlTLvxlE8M9oVdES
lIme2KValwGhcpq6KSMYA1MZE8T/66Hv794cR/pPeKD5wqIzRGA=
=uyFR
-----END PGP SIGNATURE-----

--Sig_/4OJtgZgzsbq4uxc68qSqJqr--
