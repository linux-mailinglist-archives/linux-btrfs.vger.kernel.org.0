Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1EA12CBA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 02:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfL3BiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 20:38:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:45085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfL3BiP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 20:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577669894;
        bh=kQnfDazLWctTBWFgt+yDXm8zYSsKuibee3cqM23cLUc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=F7PmAsucObIrTIwCS2Osa8B+gTLhHyc1yqYwa39haDmdFro04tWavi9oXkWMFnGqa
         GGUqW0OCvCy61oP91oEiw6dZyXhU3+0YiPWHOe4pr+I5yuZz1s+HMLfdNhO2HJMb2Y
         qBNP5x8dzrKlLfURc9dOmWLe26vJafFXDnDcRDWQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU0q-1jMAkr2C1c-00aSgo; Mon, 30
 Dec 2019 02:38:14 +0100
Subject: Re: Intregrity of files restored with btrfs restore
To:     Alexander Veit <list@nezwerg.de>, linux-btrfs@vger.kernel.org
References: <7fe8e3e1-ebea-7c61-cf3b-a0e0c6493577@nezwerg.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8d55e263-3dda-5f9e-77aa-f6b3801d7ea6@gmx.com>
Date:   Mon, 30 Dec 2019 09:38:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <7fe8e3e1-ebea-7c61-cf3b-a0e0c6493577@nezwerg.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9Y3LT0yXrHbP8nTJd9dd372cWcTqsCXIy"
X-Provags-ID: V03:K1:KNUnWSz7oCvx8uHe/kVhqGV+O3unz2ixmj6n6q01FZ9V7swlTG5
 eBlHiQNwedzRiRCxOBLH121SiZ91YlXR5QEvNqW0CpNsoI25h7BFYXmoQxchdXTu7VH27DB
 U03g1LtpwhOcHXg4h1pjUL88tc7zv6hgIADxV54BLuTiXtgeDXMEYOGWMr6LUgLm8+QLY3n
 ysJvT2WkEsV6hhnEYbU6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HTIXa2FkyjQ=:tUGwdAodhhUMmT4gdRiTwE
 TqkKCJuOZaZVq/C1eN+8tQHS2iGxRuJ457KMcriRlZII+WGeIdwDyBtzhWs9A6LFrJ4jKCvi/
 q4omezJCvuFmv7q2OcdaZEFGSEWeG0myR2bfxKGosP0jxUgW22NLpDMYkV+v1tZLzMB6bhIYd
 iERu2FYYwz010l8on2+DY8/BwDFm3rgc5r+M0Vo9FQgfeKm5tYFaylOzBI8b4WejAKo9OVvqY
 agujD6gb9bvTtmN4WMInuKb0bgDeOJJcZy7ru7Y0wV8yz+ntwohHSUJI4jXO5TaiY3d2T9GPO
 OQZ48xwezl+pTnIdzwbqN8dvC23pWftRNwUsgiHE+VyU3YVpVDD92M/Gr3V3YTOmPikIeBxKR
 7IQskF4TNxMBbWeZBhM9tV4I3qSzLIZO7XAOVKbVXKuis2xZETTIOHP7Fwcw0uKMAwe0NJcFL
 dwyONTv1iXvQoC0fKcOL9DJtFpovJHBsBDuePu2iVKYPPSoaxRCg4JuKeLxJCKZFy4NOsUZYt
 SpwY+CUglmkH+0ciJu+CbWFF9vIlKrS4TIKF2llx8IFCyC/tzBRvOK5tj8sWY+FyqclzuZW+h
 z8bpKsEIdTuTFMJ+/McvWAXq+66yPPbDsUjWofQsfOzVWmqijoxvrIxTIpOLnz2O4Oju344Sq
 ESOYFrK9xuseT9g+O/VAox2egXombK3YFFUKcTOxThHLWcLgmeIQ5SIy9N6/rgHqalV+iLZKC
 GkbNqdejWnqs4ndAekmCZSBGjjRoPC1WBkth92BIYU64hxmomixc9SavMc4mxszIq9o1A2Hs3
 t3I1l7TCR75GjiXpjSKZOVdJr13bF0pM/n1fC0MBgRVYSiy2tUcXg2XasfbolVi4HsX3e7kzw
 asrKhe6oBfDI/qiGUAadY+hlMKOCOOEH0jDguBB/U1ZoDS2uU+0k/ozAoHe+ERNi3BFdrq9OW
 ZiDE5VO57AgSj6PJbBxsL8UB1n42/+KFZWKpMgTVQOVf2UEsDBuBBdFUuHkpejPxAFpfhS1Fk
 oAMQOsxqrWgBFXujFQE2/5zvFbb1CGJJ9cu7JV2SvzI0ieEp9ZJBBF++89piDZG/K1BVPnkde
 pqHl1ZrLqGPTht/hCerCMfq9GfcRqC//fX3OXoecKDdebTFYYbVD2qx+31tQBh0c5McGx7Now
 LVYT3OUIvbtjkYi3jYv13yVd/dBw/2F58Vb0dFXNplxxNJ+2jvkVZvSiFC1jx8Z+aMobN9b+B
 VfLBo0J+LYredPdDYZU2nOCYpsmsscA2vjPG6CWIusuHvkIMEjj/bUkGrl3I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Y3LT0yXrHbP8nTJd9dd372cWcTqsCXIy
Content-Type: multipart/mixed; boundary="XZcOd6YHbvQKRJsL7zRCzxqZ8PHVy8uRT"

--XZcOd6YHbvQKRJsL7zRCzxqZ8PHVy8uRT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8A=E5=8D=886:58, Alexander Veit wrote:
> Hi,
>=20
> btrfs restore has recovered files from a crashed partition.  The comman=
d
> used was
>=20
> btrfs restore -m -v /dev/sdX /dst/path/
>=20
> without further options like -i etc.
>=20
> Are the recovered files consistent in the sense that if the file was
> committed to disk and was not open during the crash, then the content o=
f
> the file would be the same as before the crash,

Normally crash shouldn't corrupt btrfs, it's either btrfs bug or
something else causing corruption.

> and that damage to files
> during the crash (e.g. by random writes) would result in the file not
> being recovered by btrfs restore?

The restore doesn't check data csum. And by default it reads the first
copy of data.

If the read succeeded, btrfs-restore just call it a day, thus no data
csum verification or anything else.

So it's not as good as you would expect.

Anyway, btrfs-restore is the last resort method, before that RO mount
and various rescue mount options should be tried before it.
Kernel will always verify data csum.

Thanks,
Qu

>=20
> I could not find a clear statement about this in the man page or the
> btrfs wiki.
>=20
> # uname -a
> Linux healer 5.3.0-3-amd64 #1 SMP Debian 5.3.15-1 (2019-12-07) x86_64
> GNU/Linux
>=20
> # btrfs --version
> btrfs-progs v5.4
>=20
> The btrfs file system had been created in a system with a Linux 4.19.72=

> kernel.
>=20


--XZcOd6YHbvQKRJsL7zRCzxqZ8PHVy8uRT--

--9Y3LT0yXrHbP8nTJd9dd372cWcTqsCXIy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4JVQIXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjzrAgAnWCKNWhwhx7t1/nXx5xS6NL4
g5ivW516dhpQoukq9ZASodQzxAo27oshS9fMJGGgWVElXJTCm4Gnoaa63VN5rsM9
auVCK2tC8wkOQaw0AXa8j157b7euX+G5rO65C/NGFDiogN9HfyHQ1Ry0Ku5Z7/JV
NwR0TKnnTRMJMYrR7ZypLGLnnLy7KL0xvlkKtAGcn4TxUPfen6ywhCSaQDaTtuhh
U/3MCWt4kuInG8SpCeYyr8LxJBCnpVWoKvAZoQvSRBro8lUSsvIKF0yZzooJg7C3
XeGXQZj7KGh17NfAVN8tPKoVU5Enn4XogKgyJeKQc1dzo/YmpCTWQXETlT6SPQ==
=2v/W
-----END PGP SIGNATURE-----

--9Y3LT0yXrHbP8nTJd9dd372cWcTqsCXIy--
