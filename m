Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B72211A89
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 05:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgGBDJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 23:09:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:50059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgGBDJj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 23:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593659369;
        bh=FlJIbljjt7ZINA+MVy1FwYBEZ2QFVXSVmMvdur0ur7I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AERy9UdiJ8teQ09cXbqmM1TXHHAcvip7GeEGnfMJyu97ThVnA7EldqbgcuvKhrX1p
         IMR6HfEM7ryNac0mF0uh76lyZQvfokTIr6Z9vBh0zeT5KaNzfaEVH6Lz0CgOht2noX
         fJ2x68vte4z3pa4WcwX9AQwakESlHaRMcB5h5+iY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1jJo6z0ZvU-00X40P; Thu, 02
 Jul 2020 05:09:29 +0200
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     Josef Bacik <josef@toxicpanda.com>, waxhead@dirtcellar.net,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
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
Message-ID: <e0294251-606e-b08f-6df7-20a225de8630@gmx.com>
Date:   Thu, 2 Jul 2020 11:09:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JJIboFAc92Rdje9dIHZOAVGjL2FkLu5d3"
X-Provags-ID: V03:K1:Ex40Gc6pFZSoNf7Yl7UFlA3pG+FF3USucxcfeMCfRW9fNkvkUIs
 RKq0clnenPqdh3kcCOu/6HGYN3q2stlN4soHG/GBm+AcJGQYbpl3UnHn++FVAK2dJreaX6N
 Y6AJlHXNT+FjxRu9Nd1F4spZBd5n9P+DqQTRp6+LgVVQuYwDQNh0/pEW6TrPskMfJZT/oI/
 BD8MYQBeHpasZXMeTKOBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zdT8T6ADhzA=:TshxhXS9y4j+anaC7zLgrq
 MGlJBWYZheB7F4J4fotyl6+g+h5d8sFQn3+7VMZl+VObZIXUfc3CR9pcaApdEPmAl5K1iF1aC
 R5rqF97mmzCTrqe5X6ahsHMCEefRZxX9+x/RvIk/KMkmcE5Kx44KZv8fA7Kyrt9LneVuqE1NQ
 aRyC8nOWp1CnAETYNlb5DrSR5atDI4GG5B20OTucHV6sS1MEYv3Q340TlIUffOcRryyHx8nhn
 AvYD/kGhB0hpDN8Kb4B8Shdqss3DTYvBl7GVq3q7SB628V9NWR+ImfzBuA5NLWuC4ngPKyMEv
 emrpO+qF90jVlsJRsOHTkxncBtroj1sNuq65mSdV7vMlQXtDBHg6w39PLxJlvrfT9XaM8w85M
 wpWiPQousS1AEGkcgyd/0ZAlSBKPtmgNdaePmKnyA1vY+c83jOTDAEbDw5FXNI19h5ldS34G7
 uK6tE4XLTgJPWe1KvzNdXktuYmSNyhe2nL9XZtqJbiQujXKDGJQ8ryRXQuD0aUAsmtefqTxA2
 rN2nN7VaKKfCdvVt54+q2EUsv+kemIJd495KdZ1D+vO3DZVY+0pJEtq1ESw463caCvoANYDkP
 CdnvKcxAaeOqujJ/lQOh3iPepn2dPmu1XqgeE2iSG/1vU6A0ZoGXXDWbPCwhOhDP4w/G403Gw
 hbTdA6GwUAAbUH6Au18LiEIC51TVH4eicpXu+o/EkakUlAxLHdDZZWH5a7ahLyUk1uf9J8mXN
 sNKeXKvYNUyOaM+7/7O++yaIMviXrOPdwa6qc8utz/3ZqkFQc0PTgtiV/VXYOrIduO/fGeHpo
 vamHJKD+jKVHZV4hGQS0mhlfnjmphKu2fGCRNUCVaNNUomE41mSbdHqcljEt+n7vX2ocYN1w4
 FQUOUpjtPJIMnzCHAqZuN/+Sao3SJo9s0ar6Da0g5yv0cWLDYOgzV/Pgk9qvmIHxaxR6zALfE
 HdLhcKWqB9eNzTUcdLR7uZs4Q6+0b5njFUVYopO7e0einSDd9B58S5MRrazwaG4iJnPnDBENJ
 3j2gpQ5fLo94zvExFTEBXZHyy8jYOZS6phnFfZ+NJfBlUkIWlSiGcNW2e3LnvXBvuO7dJlHn+
 qfkmGOUxgFrDbbUBEulmPLLuiWmMz760cLpvu/k4K39FkpweZ4qTDw4ncl/3gq0o2+6eB9PqW
 6S/XY0+nN0GRG5CZ794Yt/BmiROORw2YAvait3yGXE/vMdjJw14cEoolkeHTrSdpfLdsBU1C4
 YKlf8Kof/GZQ6KR/jGMNfwkrl0By+FdYlqoWpmw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JJIboFAc92Rdje9dIHZOAVGjL2FkLu5d3
Content-Type: multipart/mixed; boundary="qfysd6Gz65S780EFbrhnbZekRgnPwjj8J"

--qfysd6Gz65S780EFbrhnbZekRgnPwjj8J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8A=E5=8D=883:53, Josef Bacik wrote:
> On 7/1/20 3:43 PM, waxhead wrote:
>>
>>
>> Josef Bacik wrote:
>>> One of the things that came up consistently in talking with Fedora ab=
out
>>> switching to btrfs as default is that btrfs is particularly vulnerabl=
e
>>> to metadata corruption.=C2=A0 If any of the core global roots are cor=
rupted,
>>> the fs is unmountable and fsck can't usually do anything for you with=
out
>>> some special options.
>>>
>>> Qu addressed this sort of with rescue=3Dskipbg, but that's poorly nam=
ed as
>>> what it really does is just allow you to operate without an extent ro=
ot.
>>> However there are a lot of other roots, and I'd rather not have to do=

>>>
>>> mount -o rescue=3Dskipbg,rescue=3Dnocsum,rescue=3Dnofreespacetree,res=
cue=3Dblah
>>>
>>> Instead take his original idea and modify it so it just works for
>>> everything.=C2=A0 Turn it into rescue=3Donlyfs, and then any major ro=
ot we fail
>>> to read just gets left empty and we carry on.
>>>
>>> Obviously if the fs roots are screwed then the user is in trouble, bu=
t
>>> otherwise this makes it much easier to pull stuff off the disk withou=
t
>>> needing our special rescue tools.=C2=A0 I tested this with my TEST_DE=
V that
>>> had a bunch of data on it by corrupting the csum tree and then readin=
g
>>> files off the disk.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>
>> Just an idea inspired from RAID1c3 and RAID1c3, how about introducing
>> DUP2 and/or even DUP3 making multiple copies of the metadata to
>> increase the chance to recover metadata on even a single storage devic=
e?
>=20
> Because this only works on HDD.=C2=A0 On SSD's concurrent writes will o=
ften
> be shunted to the same erase block, and if the whole erase block goes,
> so do all of your copies.=C2=A0 This is why we default to 'single' for =
SSD's.
>=20
> The one thing I _do_ want to do is make better use of the backup roots.=
=C2=A0
> Right now we always free the pinned extents once the transaction
> commits, which makes the backup roots useless as we're likely to re-use=

> those blocks.

IIRC Filipe tried this before and didn't go that direction due to ENOSPC.=

As we need to commit multiple transactions to free the pinned extents.

But maybe the latest async pinned extent drop could solve the problem?

Thanks,
Qu

>=C2=A0 With Nikolay's patches we can now async drop pinned
> extents, which I've implemented here for an unrelated issue.=C2=A0 We c=
ould
> take that work and simply hold pinned extents for several transactions
> so that old backup roots and all of their nodes don't get over-written
> until they cycle out.=C2=A0 This would go a long way towards making us =
more
> resilient under metadata corruption conditions.=C2=A0 Thanks,
>=20
> Josef


--qfysd6Gz65S780EFbrhnbZekRgnPwjj8J--

--JJIboFAc92Rdje9dIHZOAVGjL2FkLu5d3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79T+IACgkQwj2R86El
/qieigf/Wlqhnmn8SHXJsctp+6Q8k2305MuYrPukTnlj/tl5Y+H1ykMQdMLAicwA
qkR0Wr681pClAe6F0HbOVwnO5GX2s7PMsVGZDDN9vkDPPoKONuBLSwM+vvBNmyiG
m+mFKp/r7k/bvJGKxn/+Y5y0EKCkrSVEyQfg+9vhyCGDO0xh9n5ncLIVXuumeEyY
3wvhe0PkIxSubdT9Z5Jdwyy9Ki/tUYoLhSHP6kzxKYz4sMvHntZP/Tb9qexojxy4
hsBVHzsRsduOwLY1mfhLlMNL+O4Mi+g2OOxY5dpmQj21jxV1WP/1Fltgf43+EZOb
ehU0iiIra5NEKliSCDy4Wzc/HKjbmQ==
=eJUr
-----END PGP SIGNATURE-----

--JJIboFAc92Rdje9dIHZOAVGjL2FkLu5d3--
