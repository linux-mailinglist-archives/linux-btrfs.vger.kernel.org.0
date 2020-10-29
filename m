Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84129F94A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgJ2X4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:56:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:38529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ2X4l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604015797;
        bh=o1b9gvx8Qze3V19YL42nYsw2CgHJj2UzQKeB2g3Rl/4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZrQLE0TwCspDrYlVOTkhUG9IGGO7jBZuknEKteLbjKGDOci4rESU/Wk6x8dBedvqn
         w0g3LWQynj0sDVJEDpiRCrYsgi08hzjiRxQl7FKqnyPaPZjNyQfeVQO2d4IXOERfro
         iacqDyIPHce1EcftNJTOD8520ELew8LQnkD4NPQE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7K3Y-1kSm083Iaq-007klS; Fri, 30
 Oct 2020 00:56:37 +0100
Subject: Re: [PATCH v4 42/68] btrfs: allow RO mount of 4K sector size fs on
 64K page system
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-43-wqu@suse.com> <20201029233438.GA30165@qmqm.qmqm.pl>
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
Message-ID: <d3cb9ee1-acac-fc17-1f4c-c4837d928577@gmx.com>
Date:   Fri, 30 Oct 2020 07:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029233438.GA30165@qmqm.qmqm.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UvftQsiWw0ZkJ8JEWJDFdCn1fVhCBoOqZ"
X-Provags-ID: V03:K1:qlU6+6cz7ctoEGyhb7+sIeaxWZaFju5DUYt1xfRx6WzzW7EyLxX
 jfYOJzzHg56FXHGZfIqHkIw7DpUAbtkKuEjKC2NEFqZNxthCxp23BzIWawHHwn0i2+Ip+vq
 rEzG5k35jlr++/3kqjisZF4Ob5TPF8VsA3V9D0j4o8FojdwrrGX8W/06hgM5ZaRa1pfGMNQ
 yLPZRbM6KtsDjpcs+sJ9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vuewEznfpiw=:flScChc+QS5+tnPZkHGFsY
 yuX1kXlFBYv1GhIIu1i/dfozXIS7DYgcdPwQqNvgBS5k+11EX+CJn5xErJUJQH7d/Fwx2QxNP
 wX+twi/aatvU835MDe/vZVIsUlmNSeA7xKXr7o5ULOAxzWalcAWQVtvVhyy36eSlX8MR0cbTj
 kAfgspkeaW3m33OBLI90VxN9CHu1t2/0q89zwk0LijicCkMnnFbysoVUEmSrqsWhSD7t+KggB
 81tl05OLCpoltEuYhhLBKEZG5dUQBz79EJBTdq/2kPdqxA9coyUrEh8lUMyhNjCscJn5BeVPi
 hRBfzUy2xFGE7aTryQyxKdWgbLj7jp5WainbhXlOkCV8tSqxd+e5Bwp0oNWqKFYDi/qJ+SxtR
 mKqxvck4CkEhq0TRufJ3AVG3c6b61JaTHqj3ArixxsEMhYdnmUptnPiTQLV7XGPLP12iC5aAp
 CWfnQ0svTzOQAk0VGw78ciXoSS4AuRorsWjJzH+unHFJ9F9i46VEshnsjr/9/EstV9OVP1IIK
 ZDlRWj8fg/S1tBXnze3P7QYE2rbd5MIiQcVldj/GaexCBmdhdVkyJNEfC6xubIxmWKeqzL+yB
 Qrx51rJ1+/+EXY1Zoge49o/S57gLIigf1ex604WUehYsa6bg6fNmeeDql764U+yqyYPlBzf3r
 r1agUdeoQ0nUKWi7q282mGYFsE/si4fu6KBD8E3k7+pQhX1zzd9fNoyLtZ0+qn8Ah/2zi1hQp
 2lktqPViey38D8ybPn4lOfZgYF6DwpCUeKQXEgbXZ7TnmnH1V27W5xFiKWLPjsI8P0gqrhn3i
 U+GPWptDjYuw4ck5hM9fneySUh8eTqtgy+EVi7l1arEy+1AS9i+8NXJCDP5yR1nUJA33JLumn
 MNRSHWxFTU1aGILhJzaA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UvftQsiWw0ZkJ8JEWJDFdCn1fVhCBoOqZ
Content-Type: multipart/mixed; boundary="Z2UQTSmWVdGYSTQoIELxTTVoHNyyjTayj"

--Z2UQTSmWVdGYSTQoIELxTTVoHNyyjTayj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/30 =E4=B8=8A=E5=8D=887:34, Micha=C5=82 Miros=C5=82aw wrote:
> On Wed, Oct 21, 2020 at 02:25:28PM +0800, Qu Wenruo wrote:
>> This adds the basic RO mount ability for 4K sector size on 64K page
>> system.
>>
>> Currently we only plan to support 4K and 64K page system.
> [...]
>=20
> Why this restriction? I briefly looked at this patch and some of the
> previous and it looks like the code doesn't really care about anything
> more than order(PAGE_SIZE) >=3D order(sectorsize).

The restriction comes from the metadata operations.

Currently for subpage case, we expect one page to contain all of the
subpage tree block.

For things like 32K, 16K or 8K page size, we need more pages to handle th=
em.
That needs extra work to handle unaligned tree start (already done for
current subpage support) and multi-page case (not for current subpage,
but only for sectorsize =3D=3D PAGE_SIZE yet).

Another problem is testing.

Currently the only (cheap) way to test 64K page size is using ARM64 SBC.
(My current setup is with RK3399 since it's cheap and has full x4 lane
NVME support)

For 8K or 32K, I don't find widely available device to test.

Anyway, my current focus is to add balance support and remove all small
bugs exposed so far.
We may support 16K in the future, but only after we have finished
current 64K subpage support.

Thanks,
Qu

>=20
> Best Regards,
> Micha=C5=82 Miros=C5=82aw
>=20


--Z2UQTSmWVdGYSTQoIELxTTVoHNyyjTayj--

--UvftQsiWw0ZkJ8JEWJDFdCn1fVhCBoOqZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+bVrEACgkQwj2R86El
/qjfvgf/UuSrHoyLukHWKcwnOBrTMmKzShvL+xkit4+KsFWvuOAWL/Ikk476Vy2c
jIB4AvDCXiSYqToVlrn0Flojz4ABB8uD1yTRVnm+hkcPNDCiwafkHI4FfOkKLVhU
owETbTHY0v/6f8OIgcV1sT1WaYuLMchCRXEkPrQiwNKA5xaGTX8gww2fwqps8y5W
/Wn3fjkoMxC8wTuIpDdXioY1CwpDE5jbBKLfvCcn+A7h4QKOYQSHZySfAdsO6TJg
N54brxzICCkwWKy9mOoQdV1JOBlsIYN+zZm1SlXh893DowqwKAxKZ5yBD2v/slWB
IIMcroy7fu6vfCtSAj5wOoTq0k1IPg==
=NSJz
-----END PGP SIGNATURE-----

--UvftQsiWw0ZkJ8JEWJDFdCn1fVhCBoOqZ--
