Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8116F437
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 01:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgBZAZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 19:25:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:44971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgBZAZH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 19:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582676705;
        bh=XCw0vXi1QFQG1gA9aAsx6YxELs6c7wE/24iLVAyA52s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dea5CBd/RhIMy/AXC/xdUzAJdK1LThlnp+GUlRjH5NrqamP6hP+wA1Q5m/rHCfNax
         72Qy5W5cPpyQxyhFqRqbULczxrjfHG74z5X21Pn0h7cZnZaJZwwm5lMhzzpmjhmfzR
         /aWm7efKcI3q8QH+5sbgoja0CMuyxyvR8gAuEbvA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1iw2380Qrz-00XsE4; Wed, 26
 Feb 2020 01:25:05 +0100
Subject: Re: Hard link count reported by "ls -l" is wrong
To:     "Franklin, Jason" <jason.franklin@quoininc.com>,
        linux-btrfs@vger.kernel.org
References: <051c9f6d-5765-e2d1-9aae-aff70e0f2bb4@quoininc.com>
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
Message-ID: <d3577f7b-44ee-cbe1-0c57-40636e5348b4@gmx.com>
Date:   Wed, 26 Feb 2020 08:25:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <051c9f6d-5765-e2d1-9aae-aff70e0f2bb4@quoininc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GMqOp42z5Cr8WErifGUmGNPh7PkCLCEDa"
X-Provags-ID: V03:K1:cjswGX5g9xYQ18oPEdhw+PpvAtzqXKe1wryTr3xeFcCJPQKslEX
 Rziy3TTw/sKto8ARVCI2lFhIB00r/NcAMLqslBpehy43JkOywnDFBv4q4v5RDydsP0CAb4D
 H1GRta11DyFdGGlxSoRa6EWHHWGJSbm03wJ6lXBQO01Yj9F7sPu6sp+lJK3vFYTDS5A8E3P
 NO2gDMsl2F7TqLLWU0yWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2zeBbX/8cUE=:RLP2ZJsUzWfUsOMWHFnnju
 9700S72Kbw95yLmUsEgh+72fa4KpczVdP9WQdViVY7w7ygGuQjDOGYZuvJmOho7aGIlLumg4I
 AqtASmqIehCVPuzyCqaB6DU3k8QyV300Ko9BtGYvlN4DXN2Xa8pkBWtHmetIW1uG5STgZk4uR
 /dotnfdPS8wgUWIsb2GYtjG0uq78lLGHc3FB7oYPHKCwKCsZRFGBo9wV1dv51MvSusKtOl/YY
 qu0m6gQ6s4WuODxNyeOykjNwyjT/keHYVYG3NyDc5Ue/prUGlqDS4PVW5pW46VU69DZ8mFMOw
 ZnoFuYZrfe50SV4U7QL5k20plTnzm8F7qWi8/VuG3EyPadvyk4H2Nnepy1GxFjlTW6S+FzwaT
 v6etcQFLkzRGsbWh+iD6wTuuuKx1R2aiDzct24h93TVfgKp7eBKy2R04mlp46L9vZdzGbCC+v
 t7EZ4J5O8UTS2Fa6qszfGaM1nq04fIcd38IeXggyrNnupwKYdJ2z3pZnb+diSvDJ8K6tdHGJh
 Xf2Mx9O856G6xnHh9Ou6TS9TgV+6MZmsmjRLmQklJ+Sf5WS3DsNHoob6vG+NXDqy6J1ngRHDq
 /Dwo5/m/G6nSrimKWpAgk6xNG9rIA5fug6H8qHOb0eTCmWO3wl0Z1L2UHveOxTmdSDcWF171f
 99yNiwQsEKAGQy1AWjC+28wNxqWxFdn8NV273iO1T/L3ucSpsSkSSdXffGJ0aTqlGOXkwztBT
 kfkx16IXyNB73v89ZxN/bRbYVbL/TfG+thSVjSalRGS01xz9538+diosU2y+6Y2ozgKTOYYry
 M0UGs0+D+hASwW7613tU/0EacrG+rNvJtgZFU0PQau8Qtu/wRe/KV/IUdfWD6woTppl3BJKg8
 Zg+Tyr7NUyGL0Isc0hxpHKi0F7/wmqUF5/RxZoPCnOWlYqR6WQGjMEyhbVCNZ2tKcplf9GhMO
 Nz9EaEjg7X5odggykVKjy/6cb6zKu2/iq74aPoSWXdjITWXGihDjbEiiRLi9F+aCDfZ0nGdok
 h1FlYkcvbpWuiJ/2elpgD2eoFmIZKrQ2mekZPwwnjQCupslKuHZtgSh1R+5sEuaZT/wNIqBJV
 r7ylj4LhVLtMjVLrYLsz011KzuHZRFD+5tJp4t/2jrgXVXLs7JMUTPkRJfFwS5/Uhln3s4M8I
 uP0ZwW4Dw2hfI8uZldOICbYgUXfDE/mVwJx7i/N13tevjMPWvGAjpbECUispnxlIL5kaPUZWF
 xWiVkHiD5Cfg+fWjr
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GMqOp42z5Cr8WErifGUmGNPh7PkCLCEDa
Content-Type: multipart/mixed; boundary="A1x3XJgw3z9Yqe62JeSA3OjojDo6P6sol"

--A1x3XJgw3z9Yqe62JeSA3OjojDo6P6sol
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/25 =E4=B8=8B=E5=8D=8810:59, Franklin, Jason wrote:
> Greetings:
>=20
> I'm using btrfs on Debian 10.
>=20
> When using "ls -l" to view a detailed listing in the current directory,=

> I get output similar to the following:
>=20
> total 0
> drwxrwx--- 1 jfrankli jfrankli  38 Feb 25 09:54 Desktop/
> drwxrwx--- 1 jfrankli jfrankli  36 Jan 24 10:37 Documents/
> drwxrwx--- 1 jfrankli jfrankli 612 Feb 24 15:48 Downloads/
> drwxrwx--- 1 jfrankli jfrankli   0 Nov  6 04:44 Music/
> drwxrwx--- 1 jfrankli jfrankli  20 Nov  6 04:44 Pictures/
> drwxrwx--- 1 jfrankli jfrankli   0 Nov  6 04:44 Public/
> drwxrwx--- 1 jfrankli jfrankli   0 Dec 27 20:20 Templates/
> drwxrwx--- 1 jfrankli jfrankli   0 Dec 27 20:20 Videos/
> drwxrwx--- 1 jfrankli jfrankli 522 Nov 26 09:53 bin/
> drwxrwx--- 1 jfrankli jfrankli  28 Dec 27 15:23 snap/
>=20
> Notice that these are all directories with a hard link count of "1".
>=20
> I have always seen directories possessing a hard link count of "2" or
> greater.  This is because the directory itself is a hard link, and it
> also contains the "." entry (the second hard link).

It's fs dependent on if "." and ".." should be accounted to nlinks.

For btrfs, there is no need to both "." and "..", as they are all
handled by VFS, thus no need to do extra accounting.

So btrfs choose to use straightforward nlink number, only increase the
nlink if there is a hard link.

And for regular directory, no hard link is allowed, thus it's always 1.

Thanks,
Qu

>=20
> Any immediate child directory of a directory also adds +1 to the hard
> link count on other file systems.  This is because each child directory=

> contains the ".." hard link pointing to its parent directory.
>=20
> Why does this not happen with btrfs?
>=20
> Could it a bug with the GNU "ls" tool?
>=20


--A1x3XJgw3z9Yqe62JeSA3OjojDo6P6sol--

--GMqOp42z5Cr8WErifGUmGNPh7PkCLCEDa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Vut4ACgkQwj2R86El
/qjvFQf+K39v6EfOM09MbEIwMSvoM26pc7Y0DKeVwNKd++0iVp/wACoZZKnW6fK/
m6nw9Dwv5dET1zyCtZE7SBHFxsP7HvX0Lmgs8jSAHZZG5mpidJDwM+hWaGWOsia2
4nLHE77DwLuEnrcHF4YGIbso6jz7/JOU+QE86J5VMOglOZu3Xr+ZPfiO/4ed5ruZ
YU5OEngtuxGPmdWn1txO5Yk9DD6fr3HdbvCVt/HfmjZfWDV5/MVE5drkxNRQkkJx
aR69mlWNsBdvduJn356Kflxhrl7E/bicR3gXF43eNS2wNNb1+eXOhRMpLHxPvB2P
iykCdLgd9qhaTMDOCwirhklbvK9okA==
=KwPx
-----END PGP SIGNATURE-----

--GMqOp42z5Cr8WErifGUmGNPh7PkCLCEDa--
