Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C614475B6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 01:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfGYXlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 19:41:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:53393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfGYXlz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564098106;
        bh=5DrjjJ0Qy2J/HhvNGL2HDoD4BbCh+h3pWiCuY6TRXyU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZOypsc5k2OY0aToa52ZSkapWoy1ct0fBvWnMFl+Tq0oLEuCbxwdciFBWtuKRUkr61
         kCXOvrMlYcG1H3Az8fWE+/Y8oNxNF7JvJOut1ln0YMC3RtMCoZtJ7AjBFSnSHYhBbn
         uE04A7RvIFXV1WwFbynbmUfjbLIsk/e6VKIFZCso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Mdrph-1i3D2i4C5N-00Pff9; Fri, 26
 Jul 2019 01:41:46 +0200
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190718062749.11276-1-wqu@suse.com>
 <20190725183741.GX2868@twin.jikos.cz>
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
Message-ID: <a835760e-be9d-cfd9-d8c3-c316f34ec20f@gmx.com>
Date:   Fri, 26 Jul 2019 07:41:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725183741.GX2868@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p2Pn2ByTKKkOVc1wnYArLAeroBLrAV6hH"
X-Provags-ID: V03:K1:KGmuvniE1rrba9kSNLW6QTS92/ALNU9NP2Wk/ZOwCagrJOLr5Q3
 WU4HShrIfFm4WZVsrCPnRHRBOvNkfHc2GFwESfAgVNPGPGybhsI89dJxQWvr2olCngGapWw
 xYEkMcqKTwnOWxdEZM+CEXDxaFKXwKa0EpiYy8iyH1WsYB6LZXKWjnlfZnrzUJK+hxuuWdH
 AhdE6KSMwuGxuiGYXJXZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUvRir+A0C4=:HSzCTOfaXxlBLuVGkoV0/v
 h1OKnR3PhYyLhbbBVFTcQC+/H/nyxEN0GTgfFzYzm0PzPKIHHq8LifZIrrkMhxfsrxcSYgvHf
 fLUmA5DrCCu6rRkJ9sRclb9ndycZkxeZo9sEYaMUoYiVdo8WTKf7d3QSQ4vcuBjujAB+mUeEO
 z3DmoZWUGhK3BuSzqHdx8Y0uko5SpVsE+D+haKqsSWF2NPTvCTRU/AQKBXTdkEdtjLT02MpY/
 vR46+Ildx6ezg3chDEf5lILlQlXilJa633+sAuUUWqd2BYNWxmwjOoscT5ZdEh55AQiqVudc3
 VHjZMei4Pw3avaXLzkKAU7746y245laB9NH8dksbyKfPaj8jNotmcZosr930megrkYetw2kK1
 gdS2lwr5EsJX7rtg3T6oQmucG592MOv6ZxmtXf1fSnYohlqINDay6Rc9eGx845xZqjeZqqIT/
 GkQt5PHWy08mVmf4nUeUOZPcvTZ5Oi6DypPSECAsJ1ELYe1klY4YjgZVNn3tE9QJGGONz6T08
 wV2IKlQnqNleoirtlJQ9Uqp59Emo6Tljf3/b+8uD0AmLBqbAo8gvuTYCMYZtBi4I0OCa4pWLU
 7mxhZL6+JBQ1BSndoWuGHkZ8ayNrV2C0f4Ll12sdXT/1YyDd79e0NQdexNrbBhIo/h3tOBr2x
 KV43dITunqr0fxo3yek4EL0+BB3rRRRHDV+BRw8YMZwVNi9XR81yOJ+QlBYFe+NWYcJtDJzCX
 TaBuLgGOAx55QZFd8MZG/S0YHkWmenrhAKd5HyQKBz8NcH8hImSJZkGO4nuxlFVQYo9uK5inL
 S3U/MYLi7Lg4wALzKHr4Oxi/9gIWDNvSc7k1MKYBqn8s98by5VISTR8uDBxvE5Sz5Pg170KbS
 X9T72Kle6NIJTDJLP3glA+/MTnr8xH/IBjOzEk5OFVT6KLxbttm/owE+jN+mwNIA5pjgD6p+g
 4eR8STKxjyDtgDWAxwvQZrm64WWGBujJtgoeCmMaRsw7ThSUHAeW6pqPaD9M7BAXYcKaNLmKK
 A8DEHFvrASGVnI+UW339nT2B4ahV/yRzVIuUbwgWKJ5GvLKMgUWNugCFKPEk/W0QN1pQ/w8r0
 EkTWYjINWzGC9g=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p2Pn2ByTKKkOVc1wnYArLAeroBLrAV6hH
Content-Type: multipart/mixed; boundary="45u8ylyl9zsDeXCHqwBi3upPAlF3DsTnS";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <a835760e-be9d-cfd9-d8c3-c316f34ec20f@gmx.com>
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
References: <20190718062749.11276-1-wqu@suse.com>
 <20190725183741.GX2868@twin.jikos.cz>
In-Reply-To: <20190725183741.GX2868@twin.jikos.cz>

--45u8ylyl9zsDeXCHqwBi3upPAlF3DsTnS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/26 =E4=B8=8A=E5=8D=882:37, David Sterba wrote:
> On Thu, Jul 18, 2019 at 02:27:49PM +0800, Qu Wenruo wrote:
>> RAID10 can accept as much as half of its disks to be missing, as long =
as
>> each sub stripe still has a good mirror.
>=20
> Can you please make a test case for that?

Fstests one or btrfs-progs one?

>=20
> I think the number of devices that can be lost can be higher than a hal=
f
> in some extreme cases: one device has copies of all stripes, 2nd copy
> can be scattered randomly on the other devices, but that's highly
> unlikely to happen.
>=20
> On average it's same as raid1, but the more exact check can potentially=

> utilize the stripe layout.
>=20
That will be at extent level, to me it's an internal level violation,
far from what we want to improve.

So not that worthy.

Thanks,
Qu


--45u8ylyl9zsDeXCHqwBi3upPAlF3DsTnS--

--p2Pn2ByTKKkOVc1wnYArLAeroBLrAV6hH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl06PjUACgkQwj2R86El
/qhplwgAi0LSjDWKnUvxVE/TQqcQQgENmhbHjsWaYKEqS00/N1sVEAIxsHzU8H0Z
iO8e6pU752BVXNTafmlok+yUj4qQG2bY7rPbzuK1MOGxEH073L2ivQBLOAiR5Tgw
fh67en93zgbz0lIlDHFnw/3lZd8FTMUjvrvyzAUXc5BfE40yPHlBEVD3fh49vlsu
keNbnlBQsjwl3gOCdHndHDFjxCS2p3TI2J6ApIsUtanOTVWNMV28NmBTz9Ws5/kN
HdCVACyVbFeSqW6sQ4G5m2bqvVWogzhGHkWtqphm6JyIOsBv7/M4+2U4fmc6q04R
MnMbCqnYpqHJ289MayX0fScme/fwAA==
=4uL/
-----END PGP SIGNATURE-----

--p2Pn2ByTKKkOVc1wnYArLAeroBLrAV6hH--
