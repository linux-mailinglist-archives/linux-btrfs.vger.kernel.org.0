Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE96536E63
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 22:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiE1Ufg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 May 2022 16:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiE1Uff (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 May 2022 16:35:35 -0400
X-Greylist: delayed 299 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 May 2022 13:35:34 PDT
Received: from cmx-mtlrgo002.bell.net (mta-mtl-002.bell.net [209.71.208.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03A7F43ADE
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 13:35:33 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [50.100.165.103]
X-RG-Env-Sender: nick.steeves@bell.net
X-RG-Rigid: 6284B4FF032C7BD4
X-CM-Envelope: MS4xfHprFE0FQi6RcQlFeFaTmvK3wuioUscH098uXFaahJ1Z2AOousxXNCRtLpPGKeNF5zRlbrzPAHHI4EcMDSRe93FgF6T1rA4qRs9MXvvGaeSvcd6g1P8p
 CrsgGk1OzXQktHP4j5SO1FkkouzinlpeFmnrGfcqzt10AnCC6nOqZcgkvdjiyEiaM0XKM37Q7Jwj5EBdovyUv2MBykhMGA+L2S0A9LG4xifgOeHhTXtz4yMk
 46ph4zug58zTpVtPuDSHnMKlKdPxfpEHRpSioNj7nhcvuDbYPgbeW18SgbAdN8JW+lz60/TOM65jTJgUco+JGvZFCNH08HLg4WuiY0O0nYMgEDSp24YmMk/X
 R2cis0xo
X-CM-Analysis: v=2.4 cv=FMx4e8ks c=1 sm=1 tr=0 ts=62928391
 a=vswWDEstyRI1efcgUK+z7g==:117 a=vswWDEstyRI1efcgUK+z7g==:17
 a=oZkIemNP1mAA:10 a=pGLkceISAAAA:8 a=VGN1SOTxtNvDN4kOGlwA:9 a=QEXdDO2ut3YA:10
 a=SOQ05j2XoNk16DnxrhkA:9 a=FfaGCDsud1wA:10
Received: from DigitalMercury.freeddns.org (50.100.165.103) by cmx-mtlrgo002.bell.net (5.8.807) (authenticated as nick.steeves@bell.net)
        id 6284B4FF032C7BD4; Sat, 28 May 2022 16:18:25 -0400
Received: by DigitalMercury.freeddns.org (Postfix, from userid 1000)
        id C4972C570B1; Sat, 28 May 2022 16:18:24 -0400 (EDT)
From:   Nicholas D Steeves <sten@debian.org>
To:     John Center <jlcenter15@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.18
In-Reply-To: <95422f7b-e0f9-c716-212e-ee1007176d7e@gmail.com>
References: <20220525140644.21979-1-dsterba@suse.com>
 <95422f7b-e0f9-c716-212e-ee1007176d7e@gmail.com>
Date:   Sat, 28 May 2022 16:18:21 -0400
Message-ID: <87v8tpe7hu.fsf@DigitalMercury.freeddns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Center <jlcenter15@gmail.com> writes:

> Hi,
>
> I usually build the btrfs-progs when it comes out.=C2=A0 I've upgraded fr=
om=20
> Ubuntu 20.04 to 22.04 & I'm having a problem with configure looking for=20
> ext2fs.=C2=A0 I have e2fsprogs & libext2fs2 installed, but it fails with =
"No=20
> package 'ext2fs' found".=C2=A0 What am I missing?
>
> Thanks!
>
>  =C2=A0=C2=A0=C2=A0 -John
>

You'll need e2fslibs-dev and other -dev packages.  The easiest way to
get all of these dependencies in one go is probably to get a copy of the
Debian/Ubuntu source package. To do this create "deb-src" lines based on
the "deb" lines in your /etc/apt/sources.list, and

  apt update
  apt source btrfs-progs

Then

  cd btrfs-progs

and finally

  apt build-dep ./

Then build the package as normal.  Note that this won't take care of any
new dependencies (if any) added since the version of btrfs-progs
released with 22.04.

I think synaptic might be able to create the "deb-src" lines, and
there's probably a GUI repository manager program that can do this, but
I'm not familiar with these methods.  I'm sure you'll figure it out
though!  Worst case scenario would be manually installing the -dev
packages for all missing dependencies; there are at least eight or
nine of these.

Cheers,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmKSg40QHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYXIGD/9+FOFI/Wpf8S5Np0OZoEDBNLZy6OKu9s/E
TsqZPlbF8cnAJKIjmX2fi4kUa3qo1sfM+9AyEawG4US3Opa7+Dlsu2OrHDaGeY++
u7cVGe0Z4wYHV9b62Ou/6cC+BeyQ54nhw0LvRIQhDEshplKBFHeDmURISVrtEKm2
OkS0qbGVp8NdzszVUxp4DCkygHdy6+SxEv5WZmKTr+DSWJfB6cwrQWZyHb5L/9Of
sNnnlzsDuoM44lGb/DjBLhBxnM3r6zi/jDUI/6zK8coGN0OibZRw7BjGINN3XZLg
Rik4R4woX5eXGfCp0uVscBExCXmYiKZf9hnsavumy4LDuOLawrW+niZQg7TGLAi3
Cb3nWcUW0bsqDZ0YoG2/ykIruKVCRVxfhe18cFaBT6sxRuxBLtaOGJEF57ZqAG9n
IfBftI4RuMkIO8seJDLOrR3OHMtdh+XK4aHJXUK4TMSqOFplQtMAUVhR42eLbEAD
dsNk/RXhROHbya+KJyrEdkGup56MRWp6tCvDa6P5cOFnqgTZzqRIZMuyCV4vrFoT
WeulNNBGqFqasWdOtrphjy/1Hx+ZCSp+zCd/QP3gbQW1keB3LYaQwr5ckHdWgI7i
G/qLut23TYOUUuNfEwE6v0/bmOudjzOs/reAQjZu0X6v4spuzOyu4FrsTqDwf8KM
ST8/LNWprw==
=1VcE
-----END PGP SIGNATURE-----
--=-=-=--
