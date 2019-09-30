Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AADBC1C1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfI3HcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 03:32:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:59615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3HcB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 03:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569828719;
        bh=cl9Gw+gJYX/7P1q3CumVWwlvmA6uVEfUswM7QIgExcM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DHrwXySFmimFFKbjTBj/G49O9KnpljxUGe91YSnlZMnQnTupJsoHgY2kxRmGFtGR6
         UkJJ3Mc5e7b4nMygIc5+pLh+GfvYSXVpSRbk3AwjxekAq46Euka1/9PS85tJa8yrrK
         nUtHsKjP8BfFA5etWTPu29zO0JSGpZ0EV9XRbH3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1iLxh60n1u-00G4xa; Mon, 30
 Sep 2019 09:31:59 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
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
Message-ID: <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
Date:   Mon, 30 Sep 2019 15:31:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q5r67vcfkUtkFdKvC3NqWPwDBWzO3SQpZ"
X-Provags-ID: V03:K1:LMW0vFUit1pl/2ns0t9R0YCFhC2epEK4azRBU2D8Dxt7nv+3csO
 DHu6x9fxX6PgUE44h8418eeWGYJDUbJHZJwl+WQQFukowPBCwyx4/DYhemg9vTJrJSoESe7
 XuNklNyL1bFOwWsTVGqXZrBCjnsXzIWvRqP0iTdtjM4gonfzyl2ST9YJstpWvfH6ZZ2XkHB
 1jPDZDS2xNpp2p27JJ8Vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QMGLszJOk+8=:7KLnS60OU82gBICeB1+OAa
 ++TOolmuT3t28clVSdR+qjSRaxADguBMUWKZC6DOIcy6n1TUoxZhwn9jho086Q0FSVUX/5XM3
 GLpDQUxmexEHuV4fsO7OQNHkE2v83XGPrOBVPcb6oYHy1pbvLVC3j//ynVbgcgKZT0vRuVkP3
 Y0JoGAcXc0iMXVvtqf5DNHAabbQEBnMnWK8/ecrdKw09eLwolT9UP/5ncZz50k0rnGIqE59BX
 xYXbXvpH7e6wIXHPqxBHidWXUSfqc/bptcouxKfKqIyZ4QTAAH3pnY7D4xmpfsVV+a+NkWYyS
 vTdnK87j9sBBrf8kMgHKKoQkbpCGqlym7M0yl8zRN2jls9ud1a/e8Yn6hhwYbsRrm2Ie3Wgi0
 5F4ukszbhFrS/BymyLt7377kIy4AXZfrDEACsoElZlkPWiCNeQG1ccdGDQtLdPRQvgSfbieS4
 WHVaHyNFEwrsw3wlWUVFE/ZuKNP5nntaDGgU5qlZzxEpgylIcTsqDR14fL1lSiJvnnavlXVZ2
 2IIu2JcVsyJGMvAeWI99ASkeYNBCaB9sUbqYAnutrRENg0cHqPNgwT7ob0nIjMBaZAshOGxbP
 5dV25Spv2Lqfkwr1MvwcMsc2yX+09ypqvDApZsXn/IXT7IeiBxBP3/xKUu1yPeVnED+Zb0QZa
 qep9+lMffFlcxRa0OdUJk9b8ZKi7q+7BmGSLMAxSe3K4oOXcyvHGna1seVFkGa97xKFIt8sna
 KI7hvAenrsBTxW17deZkP9BEd1NI2rBjy8umu7V51iXwbozoLF7Cu89HJ1MTRJW7vpmjI8Y/f
 fVJayRgFWIGI3/w9STqbpCHBRdDavs4ureNE/v1r5677Q2T/dSjWIE4BkHsFBpFp2Kok1Z5wc
 jQwSvP/qk0zW+yIMDMHAOizGyiPDu1/Embk6gifcPXMOg9zUKxwJn6K/6v3QAuusTwO1wChH/
 JQpP0grUU4qQmfaUX+Odx5pKnOJ7MwnOBU55ZoCpDhq5V4DGb6C9TYRnhxggDwEuIQwzSk+rn
 DTbpn5dpBYIpJyF9Q6cHBa7ckAlcL9GkHIzCYnyp4w8JQx9bvP+Z35jAQYYOCf3crWZ8jdzDu
 tZH5n+CZcPCXu5xjiMrBG5AECuA6Kg2rYp+xkomiahhbwBJKFrLPABmb88z4BXFKkTKawnlKK
 508KTqlloUA9BQpOu3G+7pJtKx88XuKNswP5UadlnbpN+/D8KMLWU+XunJwICO4ZUSsCBQF+e
 z6PKAULSvOoDjVqHslxrJ1B4buncVp8yn0wodQV2VpZ+XdkkKjijtiauyWr0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5r67vcfkUtkFdKvC3NqWPwDBWzO3SQpZ
Content-Type: multipart/mixed; boundary="IHB7kIPIniXENMFBkP3wZEkefKjlQgrzk"

--IHB7kIPIniXENMFBkP3wZEkefKjlQgrzk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=882:58, Andrey Ivanov wrote:
> On 30.09.2019 9:27, Qu Wenruo wrote:
>>> This is the kernel message for /dev/sda4. It is also have some proble=
ms,
>>> but it is successfully mounted. I can't mount /dev/sdc1.
>>>
>>> Kernel message for /dev/sdc1:
>>> [=C2=A0=C2=A0=C2=A0 6.503265] BTRFS info (device sdc1): disk space ca=
ching is enabled
>>> [=C2=A0=C2=A0=C2=A0 6.503266] BTRFS info (device sdc1): has skinny ex=
tents
>>> [=C2=A0=C2=A0=C2=A0 8.890135] BTRFS critical (device sdc1): corrupt l=
eaf: root=3D2
>>> block=3D855738744832 slot=3D20, unexpected item end, have 15287 expec=
t 15223
>>> [=C2=A0=C2=A0=C2=A0 8.899635] BTRFS critical (device sdc1): corrupt l=
eaf: root=3D2
>>> block=3D855738744832 slot=3D20, unexpected item end, have 15287 expec=
t 15223
>>
>> This is from extent tree.
>>
>> Please provide the following dump:
>>
>> # btrfs ins dump-tree -b 855738744832 /dev/sdc1
>=20
> attached btrfs-ins-dump-tree-855738744832-sdc1.output

OK, tree-checker is again detecting the problem correctly.

	item 19 key (613039370240 EXTENT_ITEM 1048576) itemoff 15223 itemsize 53=

		refs 1 gen 52116 flags DATA
		extent data backref root FS_TREE objectid 5841996 offset 607125504 coun=
t 1
	item 20 key (613040418816 EXTENT_ITEM 1032192) itemoff 15170 itemsize 11=
7
		refs 1 gen 52162 flags DATA
		extent data backref root FS_TREE objectid 5842000 offset 927858688 coun=
t 1

Item 20 should be a regular single reference, but its size is 117.
But please check this:

117 =3D 0x75
53  =3D 0x35

The difference is 0x40, which is a single bit.

And if itemsize for slot 20 is regular 53, then it matches its neighbors
without any problem.

So at least to me, this looks like a bitflip.
Although I'm not sure if it's btrfs itself causing the problem or it's
the hardware or even 3rd party kernel modules to blame.

For this one, I could help you by just reverting that bit, and then you
may be able to continue mounting the fs or at least run btrfs check on it=
=2E

Please prepare an environment to compile btrfs-progs (at least
btrfs-corrupt-block) if you want to try.

>=20
>=20
>>>> [[EXTRA INFO]]
>>>> Please provide the following dump of that tree block by:
>>>> # btrfs ins dump-tree -b 134079905792 /dev/sda4
>>>
>>> attached btrfs-ins-dump-tree-134079905792.output
>>
>> Confirmed.
>>
>> It looks like the data_len got some bitflips.
>>
>> In that offending leaf, there is only two data_len and all are one bit=

>> flipped.
>> Considering that directory is not that old, it looks like some memory
>> bit flip.
>>
>> It's recommended to do a memtest to ensure it's not memory causing the=

>> problem.
>=20
> I did a memtest earlier. All had passed without errors. I can do a
> memtest again,
> but it seems to me that if the memory was faulty, the system would not
> be stable
> and often hung, but the system works fine.

Indeed, especially considering that there are already two bitflips in
one leaf, which should be pretty rare.

Any out-of-tree kernel modules? Or would you like to try v5.2.15 kernel,
which has a self detection for such problem.

Thanks,
Qu

>=20
>=20
>> I recommend to do a "btrfs check" on all fses.
>=20
> Can't do check on /dev/sdc1:
>=20
> # btrfs check /dev/sdc1
> Opening filesystem to check...
> incorrect offsets 15223 15287
> ERROR: cannot open file system


--IHB7kIPIniXENMFBkP3wZEkefKjlQgrzk--

--Q5r67vcfkUtkFdKvC3NqWPwDBWzO3SQpZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2Rr2gACgkQwj2R86El
/qhg1Af7BwIoKg2atY/zriuSpIvPx9xXDVgUUaBVwJXGwrblpldgFs6WehYSAgRL
7YwiG45uheKUiwvKFt8P6IB7fcLAbgFFptWY0t21AHyCj0rQqIz9yUZFk5Y4geR9
AtF3O7WI5uZ2MHCrZgQCNs4NYEDr2bxfVJOMGUD6u30ePh4C1x+A5qnTSRHnhH5l
JySCg7X5idVTjyOa5Z7XTFxlLbksGaGF8QPl0khE7AJLmiHpTv6NMrBe7WoU0Rzm
cPD7UJNWzud/L7x11HCdgP8Jr6TzxC4QRliTjXzyoor3Tk8Ywxqq0VBdudmOJikc
rfrLTRHaLHWS7sdu45Tft0VWQ5nsWw==
=/SnG
-----END PGP SIGNATURE-----

--Q5r67vcfkUtkFdKvC3NqWPwDBWzO3SQpZ--
