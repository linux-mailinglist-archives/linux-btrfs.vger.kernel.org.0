Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3A42494A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 23:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhJFV7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhJFV7l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 17:59:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D69DC061746;
        Wed,  6 Oct 2021 14:57:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HPpGT5gr3z4xbC;
        Thu,  7 Oct 2021 08:57:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1633557462;
        bh=mDBRfga6SZvibvvHDdqBAbf+FzmtKjQ3xH+l7Tj5m8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PD3enKfxv4SCc//X3LCTuocUPTL3+fTNA95a7RqxfHm4PawvYaPo+/O+3z3zEOoW7
         t554tUbODVnpzl0uvl7k/ufcvQiOrHmi+bDqvcBTIZDeCd4eCT5/Zg4+A2NJHecMmD
         FYlwU8Q2rsR9VkwMnU4U9izpD6H64P+LwzuTQiB8ndHV/0BxEZG0Pw7g1dgQcq6uoA
         wzkelcY+tXelHIFBdBHmdaYp96WqxgfYZeKu3PuHQ5lLNxeE3fLGel47TnVS5y3lRI
         15CVsOneqeUMbtmGQcRcHmFbUh9b+fcOsRwM2NWO44J+XumfYClzg1hX9bfo2pVNnr
         snIyRtY6ChQBg==
Date:   Thu, 7 Oct 2021 08:57:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     linux-next@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>
Subject: Re: [GIT PULL] zstd changes for linux-next
Message-ID: <20211007085734.657b32b3@canb.auug.org.au>
In-Reply-To: <20211006191724.3187129-1-nickrterrell@gmail.com>
References: <20211006191724.3187129-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sceN_pTpTrXqbiUV+GL_We4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/sceN_pTpTrXqbiUV+GL_We4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Wed,  6 Oct 2021 12:17:24 -0700 Nick Terrell <nickrterrell@gmail.com> wr=
ote:
>
> From: Nick Terrell <terrelln@fb.com>
>=20
> The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae408=
96:
>=20
>   Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/terrelln/linux.git zstd-1.4.10
>=20
> for you to fetch changes up to a0ccd980d5048053578f3b524e3cd3f5d980a9c5:
>=20
>   MAINTAINERS: Add maintainer entry for zstd (2021-10-04 20:04:32 -0700)
>=20
> I would like to merge this pull request into linux-next to bake, and then=
 submit
> the PR to Linux in the 5.16 merge window. If you have been a part of the
> discussion, are a maintainer of a caller of zstd, tested this code, or ot=
herwise
> been involved, thank you! And could you please respond below with an appr=
opiate
> tag, so I can collect support for the PR

Added to linux-next from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/sceN_pTpTrXqbiUV+GL_We4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFeG84ACgkQAVBC80lX
0Gxw7wgAkqe1jhYnAvexTOtuSAy6aOgLiu6va+r0dTF3LDKy11lWRwZxsh6EQHNk
rqpXo3RzlY/ENk1viaEYTu1SFuhsQR2Pp07pKbW5552+XzUu5BwvBG1PIogLCfuF
bfIoDe6Nm8aagN1GqMg1knbp7SQZ8/dG7RhZ3x/rqV+MNzyf/c4LcK9NiHflLOI3
3LrWYyg5gqCsIdMBLx0VCwfKmoNDsnw4uTyRebdHNTKot48SjMlktSRGIRDXd4VZ
CEmrMqquBQsY6BHn5HFYkV8D76UNR8SjcLjJNy1oUyFrM4XQCdHYSjp/gKOG8GXr
fefwHF2WLobFqahl8bRCd2og0DkrgA==
=4E6X
-----END PGP SIGNATURE-----

--Sig_/sceN_pTpTrXqbiUV+GL_We4--
