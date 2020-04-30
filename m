Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56D1BF0B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD3HCA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 03:02:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:59837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgD3HB7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 03:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588230117;
        bh=ZN61G0cKkNYGu/zBQwfC8CPlrWXnzKrly6XnzWnqALY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HQjLT/Xt0LD2psSBxaZQ+64yjiWy/3SBiz37rw4ez4xY0T7bG16Rn3LcKuGX2IIBJ
         nva107ntYloVEG3z9MttDV18R1GpmMyKo1V5+wpaSVbHr+tVN602+gtgx1OfnzaJLk
         LIoO3V+QhrQKzt2Ul7xDGAfxqIY79RpGlo2PYwCY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbivG-1itLHG2WsA-00dGww; Thu, 30
 Apr 2020 09:01:57 +0200
Subject: Re: many csum warning/errors on qemu guests using btrfs
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Michal Soltys <msoltyspl@yandex.pl>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
 <76ec883b-3e44-fcda-d981-93a9e120f56d@yandex.pl>
 <CAJCQCtTxGRqA4SZFnC+G+=b0bK2ahpym+9eG31pRTv9FH1_-3w@mail.gmail.com>
 <cc0b6672-a65a-5c7b-d561-21cc585ead62@gmx.com>
 <CAJCQCtTwH54CEhcGwv1S9P-i8JOgSHZFg3sKkQxAL1ppeG1cwQ@mail.gmail.com>
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
Message-ID: <869f0156-64a9-3b53-001a-57e3efeba157@gmx.com>
Date:   Thu, 30 Apr 2020 15:01:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTwH54CEhcGwv1S9P-i8JOgSHZFg3sKkQxAL1ppeG1cwQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DORbZ1oVXT8x316RINNdzBVzpvMA1oIZw"
X-Provags-ID: V03:K1:nlxr32Z94HcarrCKX9FFTD2J+wwy0po9opjKzR0tjrh0lHcukLn
 GoRvlQ2v38sbRpAtdHMZj7IV8Xp79q5o8RiuGP+ZUVXE1Tl2lGaamwGJIefslhjMYiVPGkB
 UA8wocBTEYiYGsvyy8bRSrdL7k1fq5vUgMBEL9mhO6Vsaqv+hn+PPo40LMYcJJv8nsVlatr
 zfH2ebwPkdO+wbHMJEv+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BEYvGkfrSD0=:pwINJpprvyenWJZoPRx1/x
 Bnya2dtHq9GAtX+9CGvlAcNJNNiCs/toskuPxpmx76EDGcApLppn9HFscsROGosk0RQs1PsdL
 mwd8FbBDg25Kt9E/7Qk8d38wXpTjDNyh+YdTA5Z9RRZW/0Nrw6gke/cMMUeTxdb+HfIoNMl6d
 Mg2MJOT92TjZQ073BeffhHIo02LjG6drcIugZIjoI0dnh4T8Q2KkzuX0d0PDp8k97gSGF7hHT
 MtA63XMoESiT7aktxy5pS2Z6GxGSkyeut0XslDN1ifV2gdXGtIW669jRukjZKMICqIB2poiW8
 y/WsbhoCgWcbtkFBXixg269PPpoBLqtBdNbhDhOUXuhe9OjPHi3PEP4Gnf4th5CnTI6jD1T86
 0TgsfmtSkmWDX+UqDz8xZVdFEKKFNuIIBPxaZk+wO1cfDaoPl5ke13suGyZDYD1drH9eDquo7
 g0T+FI+dunJas/NC9KQD4QraosP8rygo0l3aFbybEkSL7DX468LC/SxxLl9R2JcZdj9toFEB6
 yb23guqoUy5/sAmTbB2gzkhp9dlow2boQI59XER/XETbF73+Sz0BlSIztU79OKGn+xeNtNWvd
 InDD2Y2gSAiQq2APGJxAf09pbLfPOnr5wUqKpF57sZpLybcIESF6llxBohbkgBhhf2pl0D73C
 W4PfSEE92b8ErVCdk/xFhoIo4v+/858xZsOfGUeT+loB33m9nAc335to1KFVVa5UzcLSY+e6N
 6dNXWICqvY3xkSYPv0EeRKKbhfEr6f5+MiuOLC2HUbF7xvY2HKodCRY12hO1Dk2MY9EyvjgQv
 K5Ti8KEn6u+r5uv+3J9RXezK9FQUpoytWUIk3LJ3qGLpUJ6OYEkCVXKVdzbFP0fmneFgTNm6q
 v1rfEOA5jKx6DDchXW9VDsn5gKw0rZZkPCgkgaiZwxxRoXYDAioOy44vHViFQUNzG7mxPs+KC
 pKIpI9/LQYpi2xZ31/kFQEwomZDtLe7vncBawndPqkve0DBkeGlRGI73cgdo4gkXmfIVS6wuP
 a9XD/Vg7BzVFIIrXBNOK+GMyO00X5811QVghHbAh4ZeL25HNnfiJUplYMcNXw05jLDAVNM6St
 FIgBCoA5M8UpT1VXfPIo0LpiF6G/Fj3hBQZUb9k/BlTC4kmV/pbTKXHGaiTCC/LSy7KUeEhG+
 7WtVi9NY2a+U5UrezA7DIpPciSu0g7Cn23gzYTvK5Yr2tsEAKEiDaK74WtcuJZ4fRHy2Xbiyq
 d4aaL287oMgAFUrdv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DORbZ1oVXT8x316RINNdzBVzpvMA1oIZw
Content-Type: multipart/mixed; boundary="Kzrb04bbiu2iPIVdLHdZNcknX3H3HhOZ4"

--Kzrb04bbiu2iPIVdLHdZNcknX3H3HhOZ4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/30 =E4=B8=8B=E5=8D=881:01, Chris Murphy wrote:
> On Wed, Apr 29, 2020 at 7:46 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/4/30 =E4=B8=8A=E5=8D=883:21, Chris Murphy wrote:
>>> On Wed, Apr 29, 2020 at 9:45 AM Michal Soltys <msoltyspl@yandex.pl> w=
rote:
>>>>
>>>> Short update:
>>>>
>>>> 1) turned out to not be btrfs fault in any way or form, as we recrea=
ted
>>>> the same issue with ext4 while manually checksumming the files; so i=
f
>>>> anything, btrfs told us we have actual issues somewhere =3D)
>>
>> Is that related to mixing buffered write with DIO write?
>>
>> If so, maybe changing the qemu cache mode may help?
>=20
> I thought this would only happen if the host is Btrfs?

Mixed buffered write with direct IO is known to cause problem, not only
for btrfs, but almost all fses.

> Maybe it's a
> bit crazy but these days I only use Btrfs on Btrfs with cache=3Dunsafe.=


Unlike the name, if you're using cache=3Dunsafe, all writes are buffered,=

thus you won't hit any csum mismatch problem caused by this.

But you can hit other problems though, e.g. if memory pressure is
forcing some image data to be written, it can break the COW requirement
of the VM (but the file is still completely sane).

> I do lots of VM force quits, never see any problems. I haven't tested
> it, but I think unsafe is quite unsafe if the host crashes/power fails
> while the guest is active. Performance is much better though.
>=20
Yeah, host power loss is another problem.

But at least, cache=3Dunsafe actually avoids the csum problem.

Thanks,
Qu


--Kzrb04bbiu2iPIVdLHdZNcknX3H3HhOZ4--

--DORbZ1oVXT8x316RINNdzBVzpvMA1oIZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6qd+EACgkQwj2R86El
/qjtOQgAp/wRvocUNEcBY4OIlElqCTOINvGtMorgFe0IHQKFSNUAmhgrm5AXXNRv
R43WpIVWiF0cewIRPLtJyNYB5isrNLN4VvipHOYsxd1RWl3Cl1/aG5lzQgYRSB83
PAO8A7bECDLINz3ym59zJK27Bkv8G2+dJvph55ntgR9XkOO7EMvRrlSKd9MfEcVw
RCx8I9z6APcvAoLFu3snqRkf0WvA2tbQomTUV2J3C7eZ/qEggvuTrRHoDOZpr40o
IBJ2Nx3X1mvVFzBeRI34ZrviRerkWnCOW3R0dRcDdeXGXcWO04pnZO8s7gNrhUbB
2KU4+hIZ6FVd5pN2czxbHwtG6teVFg==
=HgGa
-----END PGP SIGNATURE-----

--DORbZ1oVXT8x316RINNdzBVzpvMA1oIZw--
