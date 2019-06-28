Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6055C59A0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF1MKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 08:10:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:44805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfF1MKF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 08:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561723796;
        bh=7N4oVRDX7gq+XYJAccXaKc/C6maqk0SCZ2vqsS7+wCI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=i1q9ZUDkxBr2xsUEmUr4QazyHKWwKzevhH60rS7NCdb8sx4wXsw4MvUJUVR6A/7CG
         tCLxPriKJPymbsh9Vm4y+sKK55GNvqNTUIV7e5UucwjePQvEmGPunzkoZAu6+XuGrq
         dOsg4oCDqC66yzdpw2CUZ3cJ+81cEVE8FR3r41v0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvcA-1i2x5n0Qro-00Us03; Fri, 28
 Jun 2019 14:09:55 +0200
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <dafc56c9-1cd8-2727-049d-99db6504b7e2@suse.de>
 <20190628113458.GF20977@twin.jikos.cz>
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
Message-ID: <a13ec40a-1839-aa2b-894d-4e0e3bd4d81c@gmx.com>
Date:   Fri, 28 Jun 2019 20:09:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628113458.GF20977@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o0BkoP3Y5QzU19sV7cNDekbGzw3h3r6UF"
X-Provags-ID: V03:K1:ANGg134EhI6BGKVYqs7ekAg87LAxroIC8ICs62EAodWK6j3IXfa
 th5E6B5NPDxIhE94wDjyyeFmZcMGuGBG7SONFdVSMjmeox4vgvIegCGPtRnrc0JmBuNdBmB
 anEeeG9T18cah76C3XW+4pQ+NoWwU8zdUV5RyBmU1MmebR4Rj/OfFYc5YOPgqL9xGt4OTJH
 NWLhyUSkcsTeoKOkUKIRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FdhEymxZkxM=:iqMkg4NF7TiYsKpIeJQN4V
 pnKdNgQb2sGL1g1zMQ7aLFkXZ4EULUQcR8wEYhMKg3EHbcrofI+iAjPcbmQtQQq0DWnYW3al8
 9CuFCCx0OR35gVM3CT/CjfzsrQZiFpsyrHJtJYhBAQIgOgnuO7AVMy6dJBDW6TfY+ESVkwmz4
 F4mL6R63Rbcy5Vf9YFqOjuMWvzFQ9lluCYOo46AQg2P5JST8aEqybIJsFpIL3WM6eZNdSBs/t
 oHSbr1RR6+rsxqaP0Wl1XaQM+EqomEoIYYpnJesiNTp0tqbD6lkrbox2jWvkYPrHmtwir4+JT
 dof+tJfkYaUnPWZKAm1Eh6TSYVD1Rf38/Gwpk/Pw3891Y3AFzBmdu8ua/rpUHsxZku5T6YkYK
 /SXoZ018VbNl4MfKf9eV91rLC75anPRJxLuB2q4sGcWr8jKeAtACqJMv7/sR/dCr+nqseWO8+
 3JsbpJ6KA43F9i8qDUMNbJdE77zR4i0VQZUVQr89LpQxC3fLFsKUmtRrDPLSgph6rZjv8FRth
 yQKixz/xNfum3yNXYyp5b7ePOCdQWEj39Zc+AKSNosSS12p/1A7/DcSHNQyTRpOVNbZW9KAyk
 gVaYz7Y8g+Fm1UrlG/kT0EuGsnL9PwSrrhTHBGXJnciXQCK0bffbwMvA8E8FF/1CLjbrnZqAI
 xxgYbYN5ksYTXOVyxGloAJCzhaEQ1rw9lA9klVnDa5yll9dtbf9S4mULwDbZgc9R83fT46dIZ
 kw06sS3oiQEpeqkhN3JRquDrG+bmGTgH3kNhKue/jiazj1Paf2WILbU9PpZ+IeYZzbpMFxjSE
 V9OnZdXCgIbl76bF4gaNQVv2n9DBlhWLPRwGTokYBUdfnIW78WJLB4I1OARZKShRzpLt50WMu
 u2x0dN7ee8j4LGVTNWbNs+zYj0mwtCDuVH3zY4UWDbE5shaS9nLZePMAteA4P5SCcSM32iP2H
 3N60DGIyMI1uPJ6oCWZkfqnR/Lh6bN3s/IDbp0dAlNO0vg7UJAgXgoMbC8o74SsJ0RmS0Y4q0
 FR0QqsGX51DFMD0aels9gF3VArBikoh2qFA5ze5A6CY1K38xQff/bSNYV3KrVgoAWfKW+6/rP
 IKGNsAAGk8Wo/I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o0BkoP3Y5QzU19sV7cNDekbGzw3h3r6UF
Content-Type: multipart/mixed; boundary="UkglCvHFQv9WIGBCL9AmQuZyPODSIWzC0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.de>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Message-ID: <a13ec40a-1839-aa2b-894d-4e0e3bd4d81c@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <dafc56c9-1cd8-2727-049d-99db6504b7e2@suse.de>
 <20190628113458.GF20977@twin.jikos.cz>
In-Reply-To: <20190628113458.GF20977@twin.jikos.cz>

--UkglCvHFQv9WIGBCL9AmQuZyPODSIWzC0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/28 =E4=B8=8B=E5=8D=887:34, David Sterba wrote:
> On Fri, Jun 28, 2019 at 09:26:53AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/6/27 =E4=B8=8B=E5=8D=8810:58, David Sterba wrote:
>>> On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
>>>> Ping?
>>>>
>>>> This patch should fix the problem of compressed extent even when
>>>> nodatasum is set.
>>>>
>>>> It has been one year but we still didn't get a conclusion on where
>>>> force_compress should behave.
>>>
>>> Note that pings to patches sent year ago will get lost, I noticed onl=
y
>>> because you resent it and I remembered that we had some discussions,
>>> without conclusions.
>>>
>>>> But at least to me, NODATASUM is a strong exclusion for compress, no=

>>>> matter whatever option we use, we should NEVER compress data without=

>>>> datasum/datacow.
>>>
>>> That's correct, but the way you fix it is IMO not right. This was als=
o
>>> noticed by Nikolay, that there are 2 locations that call
>>> inode_need_compress but with different semantics.
>>>
>>> One is the decision if compression applies at all,
>>
>>> and the second one
>>> when that's certain it's compression, to do it or not based on the
>>> status decision of eg. heuristics.
>>
>> The second call is in compress_file_extent(), with inode_need_compress=
()
>> return 0 for NODATACOW/NODATASUM inodes, we will not go into
>> cow_file_range_async() branch at all.
>>
>> So would you please explain how this could cause problem?
>> To me, prevent the problem in inode_need_compress() is the safest loca=
tion.
>=20
> Let me repeat: two places with different semantics. So this means that
> we need two functions that reflect the differences. That it's in one
> function that works both contexts is ok from functionality point of
> view, but if we care about clarity of design and code we want two
> functions.
>

OK, so in next version I'll split the inode_need_compress() into two
functions for different semantics:
- inode_can_compress()
  The hard requirement for compress code. E.g. COW and checksum checks.
- inode_need_compress()
  The soft requirement, for things like ratio, force_compress checks.

Will this modification be fine?

Thanks,
Qu


--UkglCvHFQv9WIGBCL9AmQuZyPODSIWzC0--

--o0BkoP3Y5QzU19sV7cNDekbGzw3h3r6UF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0WA4oACgkQwj2R86El
/qim3Af9EEAUE8lSlitn4WM37haCuI3782szMKJa1R14Rqf67v0oqnLXz7FaD7uO
IZNz2GjWXFtpvs3SNSF85wHrZwqOiJd0GC/+lFG2J1STVPTLpBoKM3OgSTwJnI8L
ZLGJ4YNaFYrs7BGYKz0NQO80DpBmsz0zFOJhD3HyBKmY8JtkoGQkK/V0g6DrXPo4
223LZQWJjUFd68TH3lkojJSctNDe5z+Hc7PsoLJeH3zTOFl/pIGyMJFq38fdLmS7
g3C4VOA4XaUM7aVSVgNh/dXBIHU4SJLHxjz9UVjBoZnquQGpndJ+eJJ3E4n4X0TW
qYoZeqwkUMK08lxCR7YwYEDuUx9Rtw==
=4FPE
-----END PGP SIGNATURE-----

--o0BkoP3Y5QzU19sV7cNDekbGzw3h3r6UF--
