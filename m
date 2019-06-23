Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34214FBF7
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfFWNza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 09:55:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:50857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfFWNza (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 09:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561298127;
        bh=9eXIruE0fvFRSt9QHFWoYxWeyr0eUW/tQZG2+rjSM0o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=b6TH7M57hzaZpMUXnVobaikLx0g/EJV00UgK6DzkDADJDeM9bEKug4xK227SV9fq7
         BttWo6U9FzQifTLMT70L7xtvHbcJ26YU38vZ6kI7dYwf6iYAKUWZEIixUNWkVTDf1z
         YxPoYOCrFEsPt+k+H7DSYPoYQCjcT/XOAti/2R1g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lck9X-1iL0xg2KE3-00k6gP; Sun, 23
 Jun 2019 15:55:27 +0200
Subject: Re: Confused by btrfs quota group accounting
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
 <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
 <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>
 <63286845-0fc3-e595-3e35-e8e2bef4fd17@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <0310c56a-6865-e561-41d0-4545845f4c58@gmx.com>
Date:   Sun, 23 Jun 2019 21:55:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <63286845-0fc3-e595-3e35-e8e2bef4fd17@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZMcsWT7BmgkozO1fVvW6TN01qU1Laoisv"
X-Provags-ID: V03:K1:CVJ4VZULzspQUDhwyka02SntkZamONsVICO63k8g3Otzm6Y1aBI
 n/ZA1xOYyr8yYyz9Bd1NDGeoB1p+vHa4PsIb33Rb5n6tKSCdXP+g1/vpWb6fEN4M0s0PysR
 7CqPuCzEdBEsgKjvbVD5XGpFGm6OGbkhWDQXGMb14xf4KIjG5v47IuBPHshHOOexBGtuMzI
 LCq7qVEotZ25x/S8fROGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ITxuNDBTpfE=:rD0zyYC584030KMQBaLisS
 gBhkCnkXVWaJGnyhv1VTRuQefguGBUqnw7QaUx4Gvypt74XNZ2yxhO+Wv0vLwhoVYjz29d31p
 p6OcaCb8mUpboRpNy2fY1BtYZQ9A6OV4Eu4xfshfqNjVJkiYb86By5/ZpUh9un+QDn9/8nDz+
 7nKUNcPIXIqDLjIxyDJ5Lu1fhhNyxOwAROeZY90YMLQrQRy79jIbx0ZTVva2o8fE0XZ07Kprj
 31dZ2IY3G5BDKP7QmZYWyD/4c+476jRGlBKmifepIyWLuyuij8uHLFOS5wlpzjk0Vqs6DQp8u
 Qv/PzstzOFFjHhZRszjnebsWX/StcREOEfjMu3ZIpADZc450FH2C8l0J+swYaDchOS/TBIGHk
 3KA74YPo6FATBe+3xfngJris6JRXTxi/gbFB1OhgdiKNMt9K/NGOMi8jn6NyiPUDQrZu0Az+M
 vc5ovh+wJ6YeJKxmc9ARdHG5sNQw9pws4OLzdlury7BAzI2TeSQCzIQ8WJz4t0lJx6k384Bbg
 hihGwmW0hAtscMPsbSjs0Dydhz9j0lxPCotYoGdGpRajmaqTYima44HKcvcm69/Q9085FbY3F
 g7M2SFGDDThJhxAOP8I9YhJTYmAft8UB9wp2UFqX4OcuTFnsroNyz6e7OmNOKgNogpDQEgQyI
 og/dmb3oPFr6lptIIoPixAYh9gv8HPJWrjf6SNaVzIWSrrIbRoalR5DC1+NWPbyv+vPspMRau
 Z1gA/idnIk54OunGEjeLy8x/tldgkgeHaNJ79VVxAHa2u5oBez8HT9AGFtyljdzA3Do04M79f
 cVheKugW9Z9dhEqSFn+rkrG/DiMsDwrWW2drxQwEWMBu9rH0o13jSdRtoJBs1nMW17Xv+xs4d
 62iFJbWiMbHZ0BhWs4eANbiVsSerOS6E0HbgmxUkmdFmCPyujdIlFbyuMuodzPjq9ulYIrTMf
 MNuRgefz4Su1WqnZj+k2+AWJfmOGx8mc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZMcsWT7BmgkozO1fVvW6TN01qU1Laoisv
Content-Type: multipart/mixed; boundary="uHDfPghjVi3QtfxzQrFOqB5d1m45f01tt";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <0310c56a-6865-e561-41d0-4545845f4c58@gmx.com>
Subject: Re: Confused by btrfs quota group accounting
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
 <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
 <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>
 <63286845-0fc3-e595-3e35-e8e2bef4fd17@gmail.com>
In-Reply-To: <63286845-0fc3-e595-3e35-e8e2bef4fd17@gmail.com>

--uHDfPghjVi3QtfxzQrFOqB5d1m45f01tt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/23 =E4=B8=8B=E5=8D=889:42, Andrei Borzenkov wrote:
> 23.06.2019 14:29, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>
>> BTW, so many fragmented extents, this normally means your system has
>> very high memory pressure or lack of memory, or lack of on-disk space.=

>=20
> It is 1GiB QEMU VM with vanilla Tumbleweed with GNOME desktop; nothing
> runs except user GNOME session. Does it fit "high memory pressure"
> definition?

1GiB Vram? That's very easy to trigger memory pressure.
I'm not 100% sure about the percentage page cache can use, but 1/8 would
be a safe guess.
Which means, you can only write at most 128M before triggering writeback.=

Considering other program uses some page cache, you have less available
page caches for filesystem.

>=20
>> Above 100MiB should be in one large extent, not split into so many sma=
ll
>> ones.
>>
>=20
> OK, so this is where I was confused. I was sure that filefrag returns
> true "physical" extent layout. It seems that in filefrag output
> consecutive extents are merged giving false picture of large extent
> instead of many small ones. Filefrag shows 5 ~200MiB extents, not over
> 30 smaller ones.

Btrfs does file extent mapping merge at fiemap reporting time.
Personally speaking, I don't know why user would expect real extent mappi=
ng.
As long as the all these extents have the same flags, continuous
address, then merging them shouldn't be a problem.

In fact, after viewing the real on-disk extent mapping, it's possible to
explain just by the fiemap result, but using fiemap result alone is
indeed much harder to expose such case.

For your use case, it's already deep into the implementation, thus I
recommend low level tools like "btrfs ins dump-tree" to discover the
underlying extent mapping.

>=20
> Is it how generic IOCTL is designed to work or is it something that
> btrfs does internally? This *is* confusing.
>=20
> In any case, thank you for clarification, this makes sense now.

AFAIK, we should put this into the btrfs(5) man page as an special use
case. Along with btrfs extent booking.

Thanks,
Qu


--uHDfPghjVi3QtfxzQrFOqB5d1m45f01tt--

--ZMcsWT7BmgkozO1fVvW6TN01qU1Laoisv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0PhMYACgkQwj2R86El
/qie9wf8CKKmu7+VQfOQ2mV+cfvDaRVfgd0Sy9yXUJFJLtAsZ2skhn7NkGj2cwjf
n4MIg74rF8Syl1ROwaO+VuukuKNZM2ShyinV4zHRsR1omUYeA7ETMBVkHpjL3sPz
XAfj22JHuZlHyYIFE8WUhxxXsLhddw1x8O17ZIMeOEPMVyx+BT2mPPX9XaZFLLvv
aju9bAgeFtlCrsZTbeyetFlqkw1MzTX/XVonkLkgu1PYo4Xr1zUjIBuEW+eYVyVA
e+SgyE1/yh7ggZKkmNOe7yh9u0OsVoFEOeaOZr7jlJlufxvaCsoWtjFu05FtA+Sk
rvbuo+sDdRLxCJGdcvjvWTJRwwtbgQ==
=1ffD
-----END PGP SIGNATURE-----

--ZMcsWT7BmgkozO1fVvW6TN01qU1Laoisv--
