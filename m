Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C6260787
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 02:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIHA0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 20:26:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:40663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgIHA0r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Sep 2020 20:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599524793;
        bh=NgnzvhtoOiiFolCPM2o81YHF9D0oCys8rwgaiiYYIAs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C+DWkR3c3HVwPu4XaisrRbq32vXmcSdT5QSDyTOP6QkkpnDQA3JdvklSIRTQk/RxK
         e+qlvdtpKgUMScUthikQiqi4lZoo5tCE8gA2OGlO/czPcl1xiotFiem0UqXGwT63cI
         r/i2dR5dawR7oX7lOh/lvRT19aEIlKjmsPfS8F28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzBp-1jy34a0QWP-00HzHr; Tue, 08
 Sep 2020 02:26:33 +0200
Subject: Re: [PATCH U-BOOT v3 25/30] fs: btrfs: Implement btrfs_file_read()
To:     Tom Rini <trini@konsulko.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de,
        =?UTF-8?Q?Alberto_S=c3=a1nchez_Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20200624160316.5001-1-marek.behun@nic.cz>
 <20200624160316.5001-26-marek.behun@nic.cz>
 <20200907223501.GA11147@bill-the-cat>
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
Message-ID: <a88a1a38-8fce-f438-25c9-05d3edd83cf6@gmx.com>
Date:   Tue, 8 Sep 2020 08:26:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907223501.GA11147@bill-the-cat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jPgAusWPl7lwQRqEbfR20vIFfp7Ix9zLw"
X-Provags-ID: V03:K1:yZlW/mYBKCXhOMWNm4ELpDRkFj83dJbMngisStBO+ftoLVbjAi5
 uzeF65gZ/K25kAcNOJsMAXgzHHG6bLVN6ZLDZp+3r4AZ8+1MAL7Yqy5SQ32L819EgAtZ1o1
 DZ/TNkWFHOYEl/n+fkdRCD/GbhD+Y9d9JTgXqGHpEPFl2mRYMlMhgmnUMO1qtFT3IbetPLt
 H7mpBVlKM9x7gsCNyLXyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zq5Ih7HY2j0=:VhN00AqX+X99ZVDMcuXyz6
 e7iulTifYOFzrpARp8riUKNsZRglDjdqdiGFqr+sjNwiF7lhRsngkatRyJZ/hXE272KyXPgeT
 8Avipw0m/GSR8hWRSBo/s7ufkgcCRzCFcr0FSlnvHvGgA0E58+59ds6NWRuHyA3yGgq4O24tl
 1Z8ybWgL2VvIewyb19cg6Y0oVAFhlc5H9D51V3JuIbWXnanfFh352XoIcIc1h5Z1TFsOiO/nP
 g4Lc9CzMhiEjwhVMpD7E21dQim+FvkalvpBzGMsTeW5t1gg6UK9R7t2yvoxWEJWXAHYIkZNB2
 oDHBu1S1s+vHI3RYhuy/acfucDPxe1lKZR2I1V22D72pjRTmI+D4E+zUO4fFYDUOTz0yjS8y2
 qQKcT78L5byA2zpqvtLrFzaok8AvM2+TLredREAAoA96A4sNVXkCbcxNlxAzJV4WefrB7fWzC
 VNOrzKJR15kc0hldqVRUMiGFR2lJNAf1IJr/s7S62JWWSzWQua66VYY6yEakpFYkSWkevSone
 7YrRwI8S26VRAiXJtUFD+BZLc4hx2y37f4dpkwpEemuC0S64wKCSiu8pGC/fo0Dkl05tC5yMD
 zhyNm8jnQEu5gRXMvn+RZQLTGJIrCeP+mqt4mYu58qGud/AQSjLAjim3qKn0eYhQv71esYMHY
 aCHgxWy6YribeP9wa5CeTqoHSobCyUFXr5iWDYelGONl/CqfFNhcTJnFIXKDmVmCSHfIJSwmf
 E/orBcCTthXJkzn/nt5zYJisAoolvibn9YTZCRdILDL7aNKcyXnD3Ug9lMGK2Q6P8EV52Nasm
 Ds6XscKs7fB3sMjcalPFFjrU3sF/opc4jHYoXy46vRHz4Oa3aYJdac42xH+IqY7VKLpF2uZOZ
 3EtuuUyERkJV5wSQgHhe4F0rTHDFguIU6MDql0caWAjOm7Oo94ZDcZ/KG1j/7NWsFpw93qc4M
 iW4GmeeUFnO2FC54av5MmQsglR0Ue7CZgLidI+2JakT5YJ6sqX1PaRLycm8UuKTQXZGzk4hJV
 +0USwRkUJ5fPM/sA/16zPoz8arpzL0fglDQqoHaluR731rpLcPuEXEKzKA4xozHt76QxbXDKB
 Drc1uwF1jynaIdsJApCuOP/y9COB0H03bVJJ6Ip0WYgUvqHVgtjbjJgn/tdFTsTL1rgGF+Kfd
 +D/DlUd7H2mx6YW7Cibs4LQLROnvDjTKTNvtuhZvL4Y8ieVmKALVNaAiBcnGZMwta1CMdXl2G
 8cEch2VBkmMyetGWWnYmdjzjTH7V+QW5/jhwG9g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jPgAusWPl7lwQRqEbfR20vIFfp7Ix9zLw
Content-Type: multipart/mixed; boundary="SuVdPCjAMajx19lfLqV0oP2VxD5q4sj8S"

--SuVdPCjAMajx19lfLqV0oP2VxD5q4sj8S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/8 =E4=B8=8A=E5=8D=886:35, Tom Rini wrote:
> On Wed, Jun 24, 2020 at 06:03:11PM +0200, Marek Beh=C3=BAn wrote:
>=20
>> From: Qu Wenruo <wqu@suse.com>
>>
>> This version of btrfs_file_read() has the following new features:
>> - Tries all mirrors
>> - More handling on unaligned size
>> - Better compressed extent handling
>>   The old implementation doesn't handle compressed extent with offset
>>   properly: we need to read out the whole compressed extent, then
>>   decompress the whole extent, and only then copy the requested part.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
>=20
> Note that this introduces a warning with LLVM-10:
> fs/btrfs/btrfs.c:246:6: warning: variable 'real_size' is used uninitial=
ized whenever 'if' condition is false [-Wsometimes-uninitialized]
>         if (!len) {
>             ^~~~
> fs/btrfs/btrfs.c:255:12: note: uninitialized use occurs here
>         if (len > real_size - offset)
>                   ^~~~~~~~~
> fs/btrfs/btrfs.c:246:2: note: remove the 'if' if its condition is alway=
s true
>         if (!len) {
>         ^~~~~~~~~~
> fs/btrfs/btrfs.c:228:18: note: initialize the variable 'real_size' to s=
ilence this warning
>         loff_t real_size;
>                         ^
>                          =3D 0
> 1 warning generated.
>=20
> and I have silenced as suggested.  I'm not 100% happy with that, but
> leave fixing it here and in upstream btrfs-progs to the btrfs-experts.

My bad. The warning is correct, and since the code is U-boot specific,
it doesn't affect kernel (using page) nor btrfs-progs (not really do
file read with offset).

The fix is a little complex.

In fact we need to always call btrfs_size() to grab the real_size, and
then modify @len using real_size, either using real_size directly, or do
some basic calculation.


BTW, I didn't see the btrfs rebuild work merged upstream. Is this
planned or you just grab from some specific branch?

The proper fix would look like this:

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 786bb4733fbd..a1a7b3cf1afb 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -243,14 +243,13 @@ int btrfs_read(const char *file, void *buf, loff_t
offset, loff_t len,
                return -EINVAL;
        }

-       if (!len) {
-               ret =3D btrfs_size(file, &real_size);
-               if (ret < 0) {
-                       error("Failed to get inode size: %s", file);
-                       return ret;
-               }
-               len =3D real_size;
+       ret =3D btrfs_size(file, &real_size);
+       if (ret < 0) {
+               error("Failed to get inode size: %s", file);
+               return ret;
        }
+       if (!len)
+               len =3D real_size;

        if (len > real_size - offset)
                len =3D real_size - offset;



--SuVdPCjAMajx19lfLqV0oP2VxD5q4sj8S--

--jPgAusWPl7lwQRqEbfR20vIFfp7Ix9zLw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9Wz7MACgkQwj2R86El
/qieRAf/dJAyT/l4qulWGbCh7aYg68XvmTPs9f1Hx4RKDMvmQ3hIAXgOxZBL17IP
fy2BT181iQttKonpn3CJ3tE7rPyftHSKSVvL+t9vKHdQzyIv0rDIOw0/jFlSoo2J
uD33khYomwHgkEaQ8zR4Rys3lmiME83BByZkUGPFLEAL7cMyB0BHTxL58N2gArw1
S3btHT3d+BfFFC316QAYm5dYp3PqZiXxEO02GXjgrhLmyzABXBRo+v7xW3/w9ToF
WTDAN0ulz5R2ZxtxQz0OkkKBRVbRJ+YZFFkM6WGvIj3759NXLrdLRiKKWXlhsOJ1
QYXCp23kJ8jQmp1l2bsR2ewOkj50Xg==
=MELn
-----END PGP SIGNATURE-----

--jPgAusWPl7lwQRqEbfR20vIFfp7Ix9zLw--
