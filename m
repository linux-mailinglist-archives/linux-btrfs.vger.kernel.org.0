Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80896C1B7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfI3Gc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 02:32:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:48109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3Gc0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 02:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569825143;
        bh=vMKOlK/T/tJxkFLPeghgun/lk3EGAyIpYDsM9xrRT0I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=C3AyqN613tkbn7Oeqwpq7+DXNA2Thbl9D0LJhjDqdlvel0DM0XnHmn3ZoN57ClV9f
         FsopJkrI2Yv86Avw6Fb9ivG9C03l5RdihHblWY8fnbuy2h12XBpFBF9gxux9+PGzG7
         dlnEackf3ybnwpsEh0+GMuCxI8b30+w2RK+vNVAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1hyXQm0JhH-00stLs; Mon, 30
 Sep 2019 08:32:23 +0200
Subject: Re: Bad tree block - data rescue possible?
To:     Felix Koop <fdp@fkoop.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <e29ff3cc4a2cfac8b24d694eecee594c129b2115.camel@fkoop.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <5786af09-a2b8-b29c-1475-61996c8aa8d0@gmx.com>
Date:   Mon, 30 Sep 2019 14:32:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e29ff3cc4a2cfac8b24d694eecee594c129b2115.camel@fkoop.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5yFM7TLOM4Kz4Fh7DRarEBLuJWEHmd8Zw"
X-Provags-ID: V03:K1:+sfXBMnK0O8uQMpX6q3UDCNhc88LNFRZr4Yykm9E9ulXAxMgoT3
 bJFIBN7CeEFFucTb1wFBO12pzJ7rl6TkYfSsDQhy/xw9k+RlHdTpg7tm6CqiHePuPFGKn/d
 35U31vCJdw7pRcMUTfXLnLqK3rlhsTGJVBdGaeFxviZLRXoyYOWNAbGLJegesUwsL0xwm4Y
 qjBG4PZalRGdckfvyGmMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TJ1syAzSN2s=:R1pw0ylr/2SrxHGUpRqDyw
 fMt46UvzswKbAvYBMytmcK0aXX1Zi7MfiajAGWW7DnQVqTyv+zMCLQhRGyexDKefMQbrG+thI
 5bKUqOmB4NH7/zdfRKiW+xCKPmhXAq/9r/91O5s5HEXdL30syMY8uxiTt3TgvU0kn1OeOM3mF
 xB5gDTdNxaHvU6TCU6rK9zgiajs7HUT81KyPw5qHgD5rBj1qKhcpbs5GMxENE9dTT+6w8KAkM
 VPT9sBoSiEk9g9BRvaj9UdtDSlKnf0mFna9R7Hmw0u17Eq0J1lhEjaDqs+R2YdM/XHSWJirUl
 V3WVXRarXJjopIBGqQEAKyt6++bHJP0Ad8XE597ezD9Gj2svc4jWxZrDUZB0xK4m6hrbIRLWL
 0cA15I2tIYpCXIdbHYXKrmNvSxnzH4IezyW2VR6L5rcRSN+rm+WoBOv88D2MV+GWDWn/eeiXA
 OIuNM7GvKHO5jWjkaOh8jQBjR1l0eNog+0veOlKrMJ689Gs0vH+mpuVoVXtPu6wd0Bnz5hIet
 1G/bczZnb2Y+SPepiEGgMXQ1lrGercxWAz54wbK24hD1ER4WlvlJMN1hfazTz+s9bWLYR7hKV
 xCjnssQyP9U0ct4pwq0avlPlcmQi5WjkegU2Q4HJ/0xZkqp8azkflD/RPwgB7zZOh7zJPKmTU
 CPENnzglectovrWwvZG/3GbTlLcssGplvFfiTfJw/s3QQe2autu2rmS8zNU+66kNht2BG0PHQ
 TdvEH3OH6SY2y8yyKEWhkUKjHr41pBTtLo9jJ8LbT3yFHUaeFOU/BeetFmzHAGHHOQwcFp7CN
 D5GzVAk+HlZZghYAQoefys/VaLlCIlHV/KNS2jEr8YZ8fG4DxreOqmEDGJL/lEWXXLoU5k7Ia
 ckZg/WlZIAE6lcZBw3lN7mjrIAzjlVQaa6YMEk18c46wjRW8d+4ZaYJ3C9SGwBjOt46KwffhE
 n6Md9Mj0Y1RSWi+pyVtJiRvEjHd/tvcgKdEbQPTebevHzl1jFSV7XsnnONIaEajbJn/2qFHl5
 fbAhwn4t2sJ3DYt5376Sl4a7rvuKbmofgP+8U9asTQpCKkLL/xJlkw+h2jVRJNh8g0/VAmK3K
 WSu17cp7HQN5m025epf1eXmauluzmjxlCXKOzIFd2teUOITZP3rYONm/sKkF4ylUl1+N3VApK
 yRqUyov75O4jjUFRFVqGka2LYeV55j8qUn67fnTzdSiIbSNdqiIkOIf9+ZI4rpD+8BFOnFUFA
 cHjhhKFr4CytYypqS8qNMRc0fV9LJkEYI8zz9dNcvyNy7nYWTDL1wE64OF+I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5yFM7TLOM4Kz4Fh7DRarEBLuJWEHmd8Zw
Content-Type: multipart/mixed; boundary="oC5b1Vca95GWvIY2ascsGJXYYvpsLU4K9"

--oC5b1Vca95GWvIY2ascsGJXYYvpsLU4K9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=882:22, Felix Koop wrote:
> Hello,
>=20
> please help. I have a btrfs filesystem that does not mount any more.
> This is the error I get:
>=20
> root@tuxedo:~# mount -t btrfs /dev/md/8 /archive/
> mount: /archive: wrong fs type, bad option, bad superblock on /dev/md8,=

> missing codepage or helper program, or other error.
>=20
> root@tuxedo:~# btrfs check --readonly /dev/md/8
> Opening filesystem to check...
> checksum verify failed on 525573472256 found 34F97C00 wanted 15AEE1E6
> checksum verify failed on 525573472256 found 34F97C00 wanted 15AEE1E6
> checksum verify failed on 525573472256 found 72A4DA2D wanted 5756BAAD
> checksum verify failed on 525573472256 found 34F97C00 wanted 15AEE1E6
> bad tree block 525573472256, bytenr mismatch, want=3D525573472256,
> have=3D6438209987097185951
> ERROR: cannot open file system
>=20
>=20
> relevant dmesg:
>=20
> [  288.589999] BTRFS info (device md8): disk space caching is enabled
> [  288.590004] BTRFS info (device md8): has skinny extents
> [  291.596699] BTRFS error (device md8): bad tree block start
> 6438209987097185951 525573472256
> [  291.608786] BTRFS error (device md8): bad tree block start
> 2211084770032297782 525573472256
> [  291.608844] BTRFS error (device md8): failed to read block groups:
> -5

Extent tree corruption.

If it's not hardware to blame, it means we didn't write some tree blocks
to disk. Looks like a bug in v5.2.0~v5.2.14. Have you mounted the fs
using those affected kernels?

btrfs-restore is able to get around the corrupted extent tree.
Or you can try this patchset: (based on v5.2)
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715

With that patchset applied, you can go mount it with "ro,rescue=3Dskipbg"=
,
then try to grab as much data as possible.

Thanks,
Qu

> [  291.660214] BTRFS error (device md8): open_ctree failed
>=20
>=20
> I am currently running kernel 4.15, but I tried also a 5.0 kernel and c=
ould not mount the data either. btrfs is version 4.20.2 on ubuntu disco.
>=20
>=20


--oC5b1Vca95GWvIY2ascsGJXYYvpsLU4K9--

--5yFM7TLOM4Kz4Fh7DRarEBLuJWEHmd8Zw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2RoXIACgkQwj2R86El
/qjcpQf/ahPUOcnpW/mjhZGIx2IpdJUkWS02CytZSpzM3hgXWGEJjrqhdtiv4IFC
feYR9ew9QnvLUHoJllLcJHteGo4gXbFZMVg4bXZECsT6qOW7JzRnNyo06rbkvPqy
D+HiEk0HnQyRo+TdfzztqJqsz7dzx0o7umtN3qmgZcWREeSS7TkyG4E6+1EBKQ0c
7IM4Lfm/ii1dDjtUmYJhlRvene3uNh6UL8Gjmx0ybAB6IftgZkzLjwH3jMbIIz6H
vKM3+rV1ZP+3Dzf7c9W4wXzUut6CDbuIqCCkCcpeTXLOHzEu1j8mIb+rYUNR5pXm
M8ozF+agMP2sVAqERulbr2p3AmgTJw==
=+xBq
-----END PGP SIGNATURE-----

--5yFM7TLOM4Kz4Fh7DRarEBLuJWEHmd8Zw--
