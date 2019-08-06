Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7322082855
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 02:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfHFAEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 20:04:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:60439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbfHFAEi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 20:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565049868;
        bh=8bLgcufoNxSAKNenm83PdqYsCkIih0uNqnls2V4cgfM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q1+341D2C2et1eUbN6HpmIuQ+zwCQSirmcaUAnEVlRAmXR8ALinGWKZiuuyserKTi
         N580/qKkBz0MJrFP7fTwrPF0C1ZGmHzAmU/te4jh7g+Ezalu577AoTfaweMErcr442
         SDpeGtY49HA0Bb/xeXOVN/SNPiO56PVd8BajjmHs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72oH-1hywEO1Ej9-008a0A; Tue, 06
 Aug 2019 02:04:28 +0200
Subject: Re: [PATCH] btrfs: qgroup: Try our best to delete qgroup relations
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Andrei Borzenkov <arvidjaar@gmail.com>
References: <20190803064559.9031-1-wqu@suse.com>
 <20190805181356.GG28208@twin.jikos.cz>
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
Message-ID: <0f02d4fc-22ae-c4e7-44e8-5564e8724d73@gmx.com>
Date:   Tue, 6 Aug 2019 08:04:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805181356.GG28208@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KF4iqJNOKM6WmxulcsrTE1yI77AwPojdB"
X-Provags-ID: V03:K1:zn6aApyO3rG5+S3XQZ3rTRwTQ01uBuXXbmK8/t+uCsp7vW2s5dS
 5PPEogrV1KWaXa/TO0/nUOYRQQX+XI7l1y84OJMrmbzHb0MzNFZHQQrFpxUzSRhAaSnO08v
 UqBwm5Ig1oroL3J3V6WDFuxmZtc+BGWXeSEvyGibf0wYkRFeF2GHMbtJAhXPwpNKsSdeXpS
 +elwpmNbEz/S881cCA8WA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l++HdeNgERA=:xrLEZH8ixD3vhUeSfDgXQp
 +F5JKO6pRZcJEnycPSTC//ypVoxF6oykDXbbj2DpIcRypgIP/xOwCqo2HPHDGP1vYPbJzm27/
 H0napcXUaCDUGODu9uedISiVIIux6kpp7yESr1vIXO7bJA/3CbADNICFT0lOlCfnS/KoEq++H
 fkdwDpyP9PlvANS3dz2gajHSrYbZtbLtoQXer4ZX7vuW0/9feJVnb+6yEczf2usAHQiFMvSEO
 t0H4WRD6XLztG4+jpp1xRz9cWzj1cT0J4pqgOqcijTVK3OTHn5aN8vygsy1p0xmz90HsBjla/
 F0yDcta7zolTL3PlZh6FYRONm97Uvpc1S79tyTXy/U8EXh0CYrlpk1PzP2PP5/sqvtUn8iKXW
 0/H7uylAK6uF/Mi/v45LTS+exECRVwFWXIVS6hY7KurtcP1/LrYOyFFh2H7fF66oitBU/vG5j
 P/9V/qKPvlRp7KdvzUgqh5mQliwSw9zfcMdIO7XgnhoI0z3GZLkLpPAF+2KbXGeYJJTVxOiAG
 EkWmAS4Zvjpn+jOWZJNIDI9LiWrf9hMTqQzyIk9HUiLGuUXw9txvS0daB4r0LGNMxpcvAwj6x
 0vsyF8ddVMpRiFQS1D5sAImmktKYFKrYt19cTDmJhDArRMA55fqQS5PwY6NmFrBM9GMB090oa
 Wb/Q3CdEQNX+6WSgkO4DP38PfchUTqDYsz6RXtyzmikyDh88eWC2Q5miNEFdA6gQCXot8Kv0u
 9hcLVb56wG255mf0/4Iw2aZU8JcAIJmNaRN+fVKARSHuUNvipwkCMfzi9KvGW13ZqXTvJxHH1
 RGFvNsgd+nU5FJWeCC1omqm4NthY7eoTbH65K7jxNBFkHr6XaaLsxee7HoG1YtNB889T50bfD
 un8rV0NOwwGjpMHUMMTmTnbDTUkRy+rLhZgODcWiJ5T11jIHYRMdDYGBthUFpHtwr8EAB6nkv
 OHDb1+ZMhpqE4t/cnkI9g4GHEw/YVU/jWCPaOL1JttdRrvEXlJJ6lGiUXZ5d1R8zo51URaRx+
 HKfLT381p6BcgA/e9EhHz/FDPFh0q0uYQUootk/pnIBNy29SquVq5JHBWRMjwvM2+OM8kd+oH
 nwp9ao+Q0T9tyQTffTi6gXrMANWuCXRL8w84vhQbPH7LDSQBXX9V3XUYg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KF4iqJNOKM6WmxulcsrTE1yI77AwPojdB
Content-Type: multipart/mixed; boundary="3VbNUW7QX6nMavirjleZISy4JbsLaZjBq";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <0f02d4fc-22ae-c4e7-44e8-5564e8724d73@gmx.com>
Subject: Re: [PATCH] btrfs: qgroup: Try our best to delete qgroup relations
References: <20190803064559.9031-1-wqu@suse.com>
 <20190805181356.GG28208@twin.jikos.cz>
In-Reply-To: <20190805181356.GG28208@twin.jikos.cz>

--3VbNUW7QX6nMavirjleZISy4JbsLaZjBq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/6 =E4=B8=8A=E5=8D=882:13, David Sterba wrote:
> On Sat, Aug 03, 2019 at 02:45:59PM +0800, Qu Wenruo wrote:
>> When we try to delete qgroups, we're pretty cautious, we make sure bot=
h
>> qgroups exist and there is a relationship between them, then try to
>> delete the relation.
>>
>> This behavior is OK, but the problem is we need to two relation items,=

>> and if we failed the first item deletion, we error out, leaving the
>> other relation item in qgroup tree.
>>
>> Sometimes the error from del_qgroup_relation_item() could just be
>> -ENOENT, thus we can ignore that error and continue without any proble=
m.
>>
>> Further more, such cautious behavior makes qgroup relation deletion
>> impossible for orphan relation items.
>>
>> This patch will enhance __del_qgroup_relation():
>> - If both qgroups and their relation items exist
>>   Go the regular deletion routine and update their accounting if neede=
d.
>>
>> - If any qgroup or relation item doesn't exist
>>   Then we still try to delete the orphan items anyway, but don't trigg=
er
>>   the accounting update.
>>
>> By this, we try our best to remove relation items, and can handle orph=
an
>> relation items properly, while still keep the existing behavior for go=
od
>> qgroup tree.
>>
>> Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Adding this to misc-next, please send a fstests testcase, thanks.
>=20
That's the problem, I haven't found how the orphan relationship item is
left over.

Latest kernel will already delete both of them if nothing wrong happened.=


So no idea how to write one test case.

Thanks,
Qu


--3VbNUW7QX6nMavirjleZISy4JbsLaZjBq--

--KF4iqJNOKM6WmxulcsrTE1yI77AwPojdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1IxAMACgkQwj2R86El
/qgVuQf/VY/mpq1Ag/BOzlhVMQKtivKzpxBmOc4aa2cy4Q7MxOfzw89zSzv1oLtX
uM1MHL3JkHDr9x6tW+NMgtOK1kE7lMxzemPQ+oE+d9k20KaLl+bPOG/isInRvGU5
nOiddGMU8oSOokutZYYz4e0cWxJSyI3974XKYQYFG2s5GB0cQGYrZaa3TZMvWnMG
Fs43nHraV6BCFbEedZWXHk2p6Jt5oFd1D2gMXaxB4NzwC1Ufl/Lrn1tgMdnhlTHO
NREpEW+LxGBBNUjG2WlUQOn7oFwWJ9szHxKTg3Cak2MxCC70Drv3SeF6UnB9wV9r
Zm6MBa/dLnFLespNp4siuuiUjUqDRw==
=umte
-----END PGP SIGNATURE-----

--KF4iqJNOKM6WmxulcsrTE1yI77AwPojdB--
