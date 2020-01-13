Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9EA139027
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 12:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgAMLcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 06:32:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:54393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgAMLcD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 06:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578915122;
        bh=0hcP6O4PihvYc83oT1RrzUEjNl4ZFTFQJv7IR8+ge8M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=j0RRmPPqtEh+h+ZEKbAPAO+u2kSvlTb1hOOJQ9dpzWwv0WdGncA66BmAPdFkZYpIB
         5Nyyq+Ck5/bCzHQ4YYspOKXvuyQ5vYZIjz4hvexmd4Ek0BC4PJ3LJe7Ki1S32WGoyS
         xQKEPZ9jZp+/5GRIUZ7SQvKllMWOZA/spFkXQ6jc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1izFPL1DfC-00AaLn; Mon, 13
 Jan 2020 12:32:01 +0100
Subject: Re: Converting from one csum hash algorithm to another?
To:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQanp1_gHJyvhbZz1BNBToamAO9027zH7SjuxMg9nezkzQQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <ebb53e46-f9c4-e2fa-5e35-15af94c1b41f@gmx.com>
Date:   Mon, 13 Jan 2020 19:31:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADkZQanp1_gHJyvhbZz1BNBToamAO9027zH7SjuxMg9nezkzQQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2GE6c9wagXqZy9vuCifiEfa0pdb0znXOD"
X-Provags-ID: V03:K1:iexejUQbvW4scVMLpr9Rtfb2rw+x88a/dbxFd5vl7+CgLwnQYdX
 qq40axj4sKyfDebTCRkKMc0/WLr+dZlLAgEX8IPRpRZ0CX4oTi3NJXf/BzaqtDcrsboyoEp
 eZNcvPbQZWbkNQSh+4Vh5HcZErY7E3lGh7n+XSWqRzxfrAhRBAn0g0RECI7wLHV68BB3G7p
 HYoTNBCpqN41IvTQ+Jw7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kPNjU88GSw8=:07jCXtIB8R7iOlq+wntPLp
 5YVxxifbhrqC0FEEgxc+reQU8RUQ4bpBYRMiuRk14PZOBGmL6dmvcqC0S1xWiKezRgYlWoRn+
 jChA/iQUAjHXCSYS3EIS0ewbjDoksUbaRjBMfjsehS4eMn/qF+zk78DPWC2iSiHbhjROCAuV1
 21u0NO3V8s8KyGRR5L0mbrAouAr5gbVbHW7Oh7e8xWDcI1jyUqMCBxB+PbXfNEtpTtwXjKzkH
 odNj5/zAgFc22EhNbpaY6DXjZG7hJlODiK2q3Zkl8VY0JRGeGEq3m0a6KhEGCMRwK1MZDunsb
 3UaYC23CtWw68vflWNG1t1PBCLDJjRbw9J3UWdnKPOgta3Mc9grP1nzdAGmfTd1U/CputFj1K
 j4/mH2Hrdp9giDtoKkHHpnSHdpiDfS7m28bxj3pl2uo5lWP+vDtgCvajytn75xEIGqb5L2di7
 tTNvWdoVpx7PbFD8/Nujrietml0t3oDjjodXEgISBetL+uu9jOi7A6l7epGulJUpkG1byTW0K
 TLmCWZBmXrUUia60eawNGbMwyd+Uvc5z2iltuLTn7UXZVhbkuThd3iaWvuo0liGAXJBU/TtAJ
 E2tCDEC8v3RX5IT+ThUtzHyYC0ZCzt16IDMDHez7lFgLCEuHLVWWLayrkM+Qy3mcdIyLZi6Jm
 y7ipfNPL89WsPbqOXZeygxziU3jcoTsLMgKJCR15y2FM56bOvTwzyoc5VbnYQRtY0xTRrEJJJ
 9DSyK4e9MEvZKNNnaFWZWw1MBrb9EXqVisCXlW0bdRoCrfhR8wrp+a7o0cZjaMcw3XCqClMOd
 Kxmc041Qx8bFyFn3ln1jYbTFXrVL/biOHQWNZU7RANDYOzKlz3QgFu2GRHnLeCi3wvzyvX8Ib
 LVIv5y6W84eaM3ToLpL+eR75wbf9tnk6lctUt/98QflS+rrBQ1+cttzX1t0nbHS+2VRv6/O66
 /sojSV1cn6XryY+Sdveax+jLa64q8uSXzjpuPvNNRorhaCeVNpxBB/5OwsdiD3moA9cQ80a5g
 Y4qKV1shODpbRoxZsHEIbURDotMgmO2Oo7KTlXTRe/373xM5DVlI+3KrTG3lo9wAVracAEtIL
 ZHJYPyraoGUGbZa4c4g2AeLfg0GZn1/FglaLOlxkN3BtwUM2t9fDrKzQRcQCWxD0mQ0j6Eu1G
 cj6VuNOEP4sxVNIG/gzjsfA2kNk+S3iDbA4TgEgeY5Wg4G4DIJew0H0o4iJX0gGpEe0qKlYis
 k6wRHQrxHx4XqG/Zpn2pSUOGdMaBMOczv/BHg6kCKE3ILuZ23oNTLO60msNI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2GE6c9wagXqZy9vuCifiEfa0pdb0znXOD
Content-Type: multipart/mixed; boundary="VWaABPyqVBRbvRriORUeXynTL6ZrDEY9N"

--VWaABPyqVBRbvRriORUeXynTL6ZrDEY9N
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/13 =E4=B8=8B=E5=8D=884:45, Sebastian D=C3=B6ring wrote:
> Hi there,
>=20
> just a quick question: Will it be possible to convert existing btrfs
> to a different csum hash? It seems viable to re-read all
> data&metadata, verify existing checksums, and then recalculate a new
> one.

Yes, but consideration the complexity, it's not suitable for kernel i gue=
ss.

>=20
> I'm pretty excited about the inclusion of xxhash and am wondering if I
> have to recreate the whole fs at some point...

Considering there is the use case, we may consider add such ability to
btrfs-progs.

Since we already have things like btrfstune -M to change UUID, we may be
able to do that.

Thanks,
Qu


--VWaABPyqVBRbvRriORUeXynTL6ZrDEY9N--

--2GE6c9wagXqZy9vuCifiEfa0pdb0znXOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4cVS4ACgkQwj2R86El
/qgTIwgAlVmYDrG7irFS/ftyUBTjbe+F794TK4YnvIdrGdvd1uye2RYb8Ih/JT3f
7h3MGnUQ4eNHxjd6ofyJV8DjxGs2m7TuzlgG3cxL/ZC92fifhP2gpxmt/62ZxtfS
J9x+YUXBlUy9E0Vx4i6Uh5cCrx2wFoAron0XdO3v/pkISu0iMypH1+OdRMjU4W5U
gqNcMzS+dfZWY2PCmHCkztjTTG+skxO4HIpt7Xnjtose/KM0WsxNU/64Sey1OfFA
wP4JvTRMamrNNy+An88un2n4+fsHjADUveXSji0Ld+a2RNxjqTZ3WuTy6k1dtQEM
goDy7aZ789Wwe4eu5MNmvaewvpWd1A==
=Ke6X
-----END PGP SIGNATURE-----

--2GE6c9wagXqZy9vuCifiEfa0pdb0znXOD--
