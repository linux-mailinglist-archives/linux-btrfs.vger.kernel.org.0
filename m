Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3640E114AD4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 03:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLFCN7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 21:13:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:52391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLFCN6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 21:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575598431;
        bh=Kfx7X1QvcnvkWLIzxf8hkXr11MHd6BFOVvAZmStGCIA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G7LoEedHOyYbsEOQTOKs/WH1eBURpdQArlisakuvGdvDmSWyQA2F4bG1yyDv8hdGn
         vnANHf3gZWKria4P6U3jMN3SQ/7teV0tvITJP7BE8/+o3cUqzb1hlaWfW5zCwIa74r
         IND/KfIpZNkYkFE/72Y+Tju9nQfvBb9b+/mMpqmY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlXA-1hwXNY1vqo-00juaz; Fri, 06
 Dec 2019 03:13:51 +0100
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
 <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
 <522495ca-ed55-dd81-a819-dab93e67d0aa@gmx.com>
 <BD72A51F-A536-428C-9993-91A43C99EE30@icloud.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e7b5cffa-a65f-31a9-1e13-cda18cdc80bd@gmx.com>
Date:   Fri, 6 Dec 2019 10:13:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BD72A51F-A536-428C-9993-91A43C99EE30@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oPiPTbNA3UckYhQvLzktFiOXlSvlOhp8G"
X-Provags-ID: V03:K1:FtEtAUzEVgeUuMAR47OX3KhKW2Igej4XaESxiMhUoTHq23JFhLq
 oiBq/+CbroLEZJjoc0bOLabQzKto9S911hFNSxXfJ1NKuyI1O2NVtTCsKAHVj+sSvbMIRKP
 iCBAqnuSJT+RfOp+ZCSrDmn6sOg47XmKTcdBjFgLJD1BB7Wnw5IKpVRXmJ6e6leaKiM0O/L
 QajpOTLWPEdthmx3jAhLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z3mf5WFWwuU=:1RePYbUaL3u3kv24RvNwgq
 0ehqky6h/LGdJ+hjS8x2xSXVDCeTU1oz+SdQr3u/bKllWdwLomgElH/j/9pisuTSnCQ5PJazH
 RE5oHqn570rJFsIbSy139rgH6c7wKUmrKGw+nzZF0Q7PlI2QWTXkVjcAZPDwcBw0yM8MP75ZM
 orCITbOyDpHfjUWvP6SDVVjpC10dtRbVRvZ+RFb9YuvQvDzM7U2N7yUJUAFPSnWGvwi15n5gX
 2W6lyoWFIob+UFARasGC/BCzSPtWCgKvglfoG67b9gQA0PCDi1xoZcvw3SFVyEsQMMD4epWIh
 9VQVTjQWCLRA+kEhc3xIE/ci5GlASOZ9WPloslY+ShQAvFY/nKFqYG3qvMJ3hYe8dH6/yxpL3
 jxGw4wvZoCPXnAPFIrHHyNY/9s3i7iI8fx1CkmVDBgA+K94ilsY6btIMLOrz4X7Zvwx0wKqQs
 ZGaA3oMVZwcPuAzu5P2ivr8X2MYdEAqob78ovD+fwdyTw+AC8TJnbqC6K73J5grmA4Gzr2Gj5
 dDrmDRhUmbeJjIR5dt/K1kFG91zxpgjRev3M4iAOXkjXPNX7euYaUeIXXtZjkEMnRzSpA//oY
 HrljeS4JqtS5UkT6/yk+oBGW705T2TjN5FHs33M2891X9nDxRsNNlvX6HQP1K53n55/jCiPfN
 54cDTMEaYAmAZBMmaC7TZWJUuGKAobbhsd3bjTsRSUP4jhHL5qG2NLo4GWQ7dgLbhUV7puGSM
 O5Rle2Y2nEKS+roWl12d+wzint/9yCxYvzFkUHggA2HbICiM7kfy12QsrFTia+uo6XH7xC+ag
 gaYx11eVbGA5MS60VIOdkGSz9CivedGeMVxL9SWErX+iqmIut7cYqvAs+LSLcGFIUcXIfrQ/f
 qYT9Gwl58JqoJQxWh90YxlBG6c/LIYn/D2A4kQsHewIuv/COEX5DB5eTEhDd24BAVAJNQKoC7
 aUTUQpT/MIZ/X5GHekt+YWmdwMOXWPc2hd4xqjNqCkLX9JQTyu1gPseswRwtprcDp/F36NdvF
 ZlKdM/IGebM7a1c3kSBS3zgK2P9B5Cwy9qRmvewVBmG+EEI04SEYGObAp0x8pZgZoN3LNGYY9
 1c1Wrc18zzN9rN6feAblYrCJxgPYk5+nkWBQn5wME8KvFrY82hxp45Jh81RP1OmE3tHYbCTSj
 S9+tvDCR/wtiSxPcu12X4ImB37sHSlYzu6YEhtMnYeyKzITejBR/mZ9fB6/rnkjPxbizzRQBC
 nAjI34wa/RU+4heq07sFkb9y4aKMYjqK4cUPfLv6Q+qmQBUaaXswhLOVzEWI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oPiPTbNA3UckYhQvLzktFiOXlSvlOhp8G
Content-Type: multipart/mixed; boundary="l1XfnBXNurf6MGHenOAjHvNZG7BgEPehJ"

--l1XfnBXNurf6MGHenOAjHvNZG7BgEPehJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/6 =E4=B8=8A=E5=8D=889:31, Christian Wimmer wrote:
> Hi Hugo and Qu,
>=20
> here the output from the commands:
>=20
> # btrfs ins dump-tree -t root /dev/sde1 2>&1
> btrfs-progs v4.19.1=C2=A0
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
>=20
> # btrfs ins dump-tree -t extent /dev/sde1 2>&1 >/dev/null
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> # btrfs ins dump-tree -t chunk /dev/sde1
> btrfs-progs v4.19.1=C2=A0
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> # btrfs ins dump-tree -t 5 /dev/sde1 2>&1 >/dev/null
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> I will try to setup a newer kernel. Which Distro you would suggest for
> this purpose?
> The idea is to download and install a small linux just for recovery
> purpose for now.

Archlinux ISO is good enough if you only want latest btrfs-progs.

For kernel it's just several weeks older, but for your case, kernel
isn't a big concern.
As either you will need to compile kernel with out-of-tree patches, or
Arch kernel will be more than enough.

Thanks,
Qu

>=20
> Thanks,
>=20
> Chris
>=20
>=20
>=20
>> On 5. Dec 2019, at 21:04, Qu Wenruo <quwenruo.btrfs@gmx.com
>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>
>> btrfs ins dump-tree -t root /dev/sde1 2>&1
>=20


--l1XfnBXNurf6MGHenOAjHvNZG7BgEPehJ--

--oPiPTbNA3UckYhQvLzktFiOXlSvlOhp8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3puVoXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qinlAf8DQlBIYjuC3055ZEX7njBkY+A
fvZ29cdJTmVlvkc8uM3v0FEzlr9qru9Bz5HKECx8r+atGB7h19bicBEbSLMLE9S6
Lu6HDcOxmj2D2EcpC0fcMvHTwD5F+LAhxN3TRBUKTBJiIh7dv03Uolc+SNTgXrtZ
MrursxRSboZQAwuFdiAFWz6wdtBIYVEsmRFxmiyv2XRL2GnV6SiqyrJpVEynqNIg
ToGLtNkymT1Lg1gKz83vUzKFDcDFGLi7SCMHpcpGElAYI5EMyMuwd1t2WwVD0Seb
1F+Cxsl/AprtgBXpV0PZIx8a2LSfW+Yfutq5umXSLdTi8ztbQ2TyatYFywMCtw==
=S6Vn
-----END PGP SIGNATURE-----

--oPiPTbNA3UckYhQvLzktFiOXlSvlOhp8G--
