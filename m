Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29ADC1EB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfI3KKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 06:10:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:48095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfI3KKi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 06:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569838236;
        bh=shBjg05Pw783bEt00wPTISXzXahcbf3ckO7+iGMYmQo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OJ3WYtefWu/nwsnJi8TFs5dDYA+g6vUZXoX5jEfqr0oZr/3aEEGQmlpcQ5dDzMmAc
         7MZqKa4q1pa/gaZOPlqFoHzQO38RvPqSQTnFOw79Tk8n44KWQAYP9TCP4a55dNMsi0
         jn/8D9r1WEuqrOwtM8lVU3MauRvR9b6qW5401f8M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9gE-1iMbLB0FCO-00GbY8; Mon, 30
 Sep 2019 12:10:36 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
 <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
 <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
 <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
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
Message-ID: <1ca0434b-3ae6-bbbe-efd3-06cab9089782@gmx.com>
Date:   Mon, 30 Sep 2019 18:10:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MLatdF0bQ3BI2NtTMovMioUpsUWveO6rw"
X-Provags-ID: V03:K1:wwauClnphNTJb0a3jx3+UvSEDXpW6tnajfiTn1AldADdInc/Ubb
 nILK/g276FCGE1UEgFO7eO568FhVN2Qz+9RKixHCDwH1Ni5Q3yOtSh9aC9vDNBENh9OuVqZ
 iZPgSH/fdlI4S1EgOwVenDl5gsESWmuPcmytk9Cwwwx/d+8mgi+ByenGGRn+kHWloiLJ8Tp
 82w0Cjv31m0CRtSaBXpTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gvRv/FH/2D8=:ixc8UvpSDpM7qJ9CXsQhB6
 fTK4f/j7hmbB57Q4Gd7Ul5c82gf8fFTDV5ddKwe4XfFvEj/xisKX3rr8r5lo77hKY7RzMeu/d
 1Cf673uVBNBS8rtZOmrz4xuve5yujGcDS2v7biEM9GJt/cDVl/SRErT06qbAvzPqeVcztUxIs
 PkD/g9qilY7kD/b71z9drubnk6T46fsoh9EjQ3u7lQYQPTeic9gArYvqc38F0kHs2LyYUK5KZ
 mAVaCoEG/gjP8p9cskP27YFN++y9Z0HL3JvFCiOORpMHsNrwVKxu5NED7yGsUrqoRFnOLICeb
 jLrU8YB8J+FzPsE158JQhQ65BwQ/cpYXSuX3ruemTOmTIt/3CHeYOOCE0rRdsWMJWjVG1EYgr
 Ggm2WzXDh9PKQWmywXHMfSWbAUR5Bvyu4RPPasyZ6g2OdnH3ixk+q2XYgDdXD0CLo6phFUw0D
 tXyYeo4gdxZuGtl102q2AV0/kM11glBLWbNPWCRCc5WBLB3xE6vRwgXZVbukJp0AfV0/pAatz
 FPrj/JIKKb8DEWzTpkGOE7VUMka9Gnqxmb41/ApB2Ud4DDvZFbdT+Y1LXNpSEidgY9n3s6NhO
 U0zL0N/rELKVvegE/FK3+7Ndh4BNgwQBY9ME/RCZ277fh5hvXmd76Rr2mRussOdeTmg0F7W15
 UZ8i89/IAcRyRsqcQBA006Mxahm4lSSDgRi/8Utjgu96LYKTkT+UTPOnSuNoSzfbS0daoSX9L
 v8kDWQstkIFhAZ1EUTdLqNmSuuZv9PfUBosUYIUKIfL5I4v+O4CQ2wFh2piazmun+TDvf1Iqy
 dI7B9qL+PaC7rKjzQDPRV78qycQ3Ae4oV1Mdgvu29LsV0HLwKd4lEgQlioBAAjZH3itWRL+Im
 LCJIMNpg1w7Rjd1Cn7grKpeZbhnaspqauYbZ2zdUGKV06wUkHVIfScBuHTXqJQHnqoH7eiyXC
 ittxgTZWSgOfk4e+ZKz70bo6LbPSVlBYLLEv1BualoZ46FPTIXuGlRaLOWhvxscJtWOtWQZwD
 ZQZ39D1NwoItxJy/0Qvs4ss/M/f+MNB69DCK/fsm1HFkjW6yoqdPdkVQlSkvsvVqBbFTLY7nq
 rdV7WFnzXUOiKbVasWmNZ9L6rDq9v4iZ+wuB7cMzslzzY0O7pti32CCuu/YbRkgEzQE3nYJLr
 DiLYg20WmI0jsr5MS4Y4ZP824i6Ar+bEIG9Nlq+gXglNBicNOkX/qndyvYK9Hpn0uUiFC6Mxb
 skJV/GVTUidMsuWhlrMsAvk0Qrk0jfgjlWawtRohiiPUglt0m3PNhs8DEHJY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MLatdF0bQ3BI2NtTMovMioUpsUWveO6rw
Content-Type: multipart/mixed; boundary="kikVKFdwF1GOoPZp75blb5dFuIHjj2BD1"

--kikVKFdwF1GOoPZp75blb5dFuIHjj2BD1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=886:01, Andrey Ivanov wrote:
> On 30.09.2019 11:59, Qu Wenruo wrote:
>>>> Please prepare an environment to compile btrfs-progs (at least
>>>> btrfs-corrupt-block) if you want to try.
>>>
>>> Great, I'm ready to do it. Environment is ready.
>>
>> Here it is.
>>
>> https://github.com/adam900710/btrfs-progs/tree/dirty_fix
>>
>> To use it:
>>
>> $ ./btrfs-corrupt-block -X /dev/sdc1
>=20
> I had built and run it:
>=20
> # /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-bloc=
k
> -X /dev/sdc1
> incorrect offsets 15223 15287
> Open ctree failed

That branch updated to skip the item offset check completely.

But please keep in mind that, that check itself still makes sense, so
please use the original "btrfs check" to check the fs.

Thanks,
Qu


--kikVKFdwF1GOoPZp75blb5dFuIHjj2BD1--

--MLatdF0bQ3BI2NtTMovMioUpsUWveO6rw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2R1JUACgkQwj2R86El
/qg1xgf/WpCEz1urcjl6G85wEAo9aoQq9ZKNfzoQ3fzxDIYSBKlwZFw5oC398hpV
Re8g0o8dEhTS+e4ccjTA2MlAVPTDk9LjRvy4oYM98RdVA2VZkFkxNQKLsRG6QyJW
uM6FJTXdTnCqhlcqWA85MOt4VGwfy8xBWkOGMPPJOI/gcuPhAF31lCeifs4Sko8o
66XY6OirIFtngHP56ao3Oy19cIHup+40VbE1bu+8/dSaJsPsXccmj574XKVYb1Qn
cp3NF0H2id9DiRVqTyhJ2zNyW7YC3k5Vz4bYjDURvFesOhQsJVBqTXIUIZz3IeFO
QAg/fgnOUJBMgdMAGuowhjtwp+6fJQ==
=W+RK
-----END PGP SIGNATURE-----

--MLatdF0bQ3BI2NtTMovMioUpsUWveO6rw--
