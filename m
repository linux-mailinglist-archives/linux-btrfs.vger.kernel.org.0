Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8518541A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Mar 2020 03:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCNC4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 22:56:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:41997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgCNC4X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 22:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584154578;
        bh=i8WilJSytSDj6FNn0dPhu68n3IihdpdHTuKvjH6GW7A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B/fZy2U0lqK4wLkryjyZ0orqeRDwXYVnAI1AJjwjQTA/uEBs97XkdmKt4HVB+BWxL
         kSLnBfzDyvBljOTFOMoZ4DnzUM4OV94YH+TvBFaMbyhdRQWiJYKqXaQeY/rcN2NwZM
         viUl0lFUG/D2XCCn87mR7P+GKDjCZCvKjeowvHA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDj4-1j1RBa2oUo-00CmQr; Sat, 14
 Mar 2020 03:56:17 +0100
Subject: Re: [PATCH 0/2] Drop some mis-uses of READA
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200313210954.148686-1-josef@toxicpanda.com>
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
Message-ID: <91bf00f3-a851-2e84-4213-761b0d776af2@gmx.com>
Date:   Sat, 14 Mar 2020 10:56:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313210954.148686-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wvVLS2a5EMbhJGoIbZagD9OBIN2ruYrzZ"
X-Provags-ID: V03:K1:+8X58wM9dcI/Gz/7AZzsHHNPFrQE+WFVuPC3kST1zVL50T1mmIw
 KobJYWhtCwvEuVRN3JJeoJNWOa76p8g+sZavSPf2LfM3lyM1yC2nVAPN/Qtl7Ks5MIK0Q2M
 DgP5gqY4omLkOxIuW96iVwG9bwJJ4mi4unDeYe+TQ8POGB6IDd0tbreN20ktM/tu2ET7a7b
 ScdidRW7eeEc6WBpDK+lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QgR80meXEIQ=:1T4VqWTpLDYD5Z2V8Ltsc7
 AhEyDL1VuDSJ5mGsF1ITveU/z59Vz9vc7ujj33EokxEv86OAOJnKzbFNhbnrqfN9M6YfjNRN7
 BjanRKpKRIwipceRSL67V2NjlPVdGrzmE/k7h8PIfeHQBdcY4FbptwU5VGmvRo4TZvT3m6ZlY
 02/9v8yH9BJtx3VlL+YoL3vh93o1gcZGls4NnzpNsAI2Ke7/NoZuMBJ5Den8wflc+HZ2bCbcV
 /61/YX8Y/xOM6AehN3hzgzDy3iphmgD+I83glKQok3z0mxKJvY6Db0nQSfKvJlsudwR3mhkeD
 Ovljee+gFCjsI7kjMIC5Gm4MFrjIDuuN6buw1HYE/5A2/ebFof37EGm/N/p01hbden7a+jy45
 qulVIJjPiUeaKbL5td84Y17TRxPSRGFBPIXWGNpqRI8nAqUYPr/8KgwN+lSOJP9A36TyyAvB1
 wgvtRlXxNvNh/9tq2puVH/LF9u6MKXsSY7dPcQBLm7wuErCBqDfcldfK/gi5K4t9LfXTrD/z+
 8eX1FANXBp6gH1jEOiTO7g+9PIvD6Py5KfwY7Rmt3EyKU2aXBUPoHUeseDHWIX+8v6d19baWO
 YiTp0tKMuiie2ARSjoreRLruy/qkdoHrofieAIrAy6gFutCN2ahWEcmFJYsDP+SaFAJaci65W
 yUpDZXhOh2u+WgNlERUAbcSkOX6/JBFjFHT3W1LGx46L0pMd4BmA9kmc+BAIjknDRnDCYVDdf
 MYflrJVSLtjDm9RP8bbjz2Mama8r3+8pxn6+be5pq7ql6VLBg4DHFt5IMHpkgAaSj5cn7FFjy
 mHdviKqI7zZ0qWWXg5K7AOOCBhKlOFMRRoj816DgJ6ov35O2XkZg2zfI1CC5cHw3o5NVY4rkd
 ABk4kkUKg+LxG2FIak1mBQvsh5HLAT0vb4BOz+ONZmPBHFi3Zaz+tyB4B6Ki98fhyBW+iOsZs
 c8J+cGkBD/jjxHB3TJYIm38DmpC4ijMZu7aQo65LL13yINVc70KYIM0AN/uCrWCi3ihUgKIiX
 2v+46cb5KhBTUlvkk4cR0+Yn7KjT7y0ebdWrZ/1UGVxYwPmhVlMJ35vi3vL1dnjPV9T/Ht1Y6
 Wtb9PUvhQ/5dEZVdYPkAIm5bZnC9P0L/yqd78rsUbqTFnY0xAPRQkbRe8KyAeNu3mmzSBC8D8
 +HFr6fW2KxSuZEiydcYLSutsgBr066FYG83GnxeQHzcGNO5sehe/X6fEG7j6M8yAvdgRncXYd
 kMJx6bgpyHKDuSDq+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wvVLS2a5EMbhJGoIbZagD9OBIN2ruYrzZ
Content-Type: multipart/mixed; boundary="wuu6DMcDUerMzPbSD97p3AxXEWdQCewyc"

--wuu6DMcDUerMzPbSD97p3AxXEWdQCewyc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/14 =E4=B8=8A=E5=8D=885:09, Josef Bacik wrote:
> In debugging Zygo's huge commit delays I noticed we were burning a bunc=
h of time
> doing READA in cases where we don't need to.  The way READA works in bt=
rfs is
> we'll load up adjacent nodes and leaves as we walk down.  This is usefu=
l for
> operations where we're going to be reading sequentially across the tree=
=2E
>=20
> But for delayed refs we're looking up one bytenr, and then another one =
which
> could be elsewhere in the tree.  With large enough extent trees this re=
sults in
> a lot of unneeded latency.
>=20
> The same applies to build_backref_tree, but that's even worse because w=
e're
> looking up backrefs, which are essentially randomly spread out across t=
he extent
> root.  Thanks,

There are quite some other locations abusing READA.

E.g. btrfs_read_block_groups(), where we're just searching for block
group items. There is no guarantee that next block group item is in next
a few leaves.

I guess it's a good time to review all READA abuse. Or would you mind me
to do that?

Thanks,
Qu
>=20
> Josef
>=20


--wuu6DMcDUerMzPbSD97p3AxXEWdQCewyc--

--wvVLS2a5EMbhJGoIbZagD9OBIN2ruYrzZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5sR8YACgkQwj2R86El
/qh5NggAouo2Ioe93UKepUaYz5+30jMYLha72fSb5YE3KN45qub92YyV6xg0xorF
akxkmFK9VjWL6GcTQnpnHNz9LgHNfN8F56wW9qfHzmIrg7qRmTyIJMARMVMMeqSA
TXCOD9Q48xD6Y7QhTEL+2VfKmhKLfUkI7h66E39X+kodjThrMrxANyoVrOvb56v6
67MD6mW8beYctJPiNMMwjd29MykkuCgUs2/cyJD3J3EmLmf/ySUxr6oD1+NudAII
pibYX+3KVTrgZQcbqNDjxsP6DUpPoPCq18f3S5XPHDkS9ygvdHwBNP/bpGkFv8A0
niQFmlAU/6Ykt58X+n5L8DYashLEbw==
=Cq8J
-----END PGP SIGNATURE-----

--wvVLS2a5EMbhJGoIbZagD9OBIN2ruYrzZ--
