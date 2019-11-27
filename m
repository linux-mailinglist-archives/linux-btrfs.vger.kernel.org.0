Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66A510C0AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 00:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfK0Xh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 18:37:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:49391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfK0Xh6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 18:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574897809;
        bh=+0CMTliyRaqS5dlGO2ZaUVZaBP2oBEwHrVSm45HGBeY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XyuYHg3UYgFGJ0kQJOCfgvqalU+HKhaIE10vrzzjG+KcSGJnfOzKvQGPOiIeYqefH
         9qPc4qgUNkW9FYd7V82kehnp7ld7E5LZFSGS1Io0jliucNiGJOdEfSJ9vFhTgRZPg8
         wzMLM423VtvyfuyxYz0vjmH64GG1osWeQPKmQCbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5iZ-1iHD6L1CPF-00J1Iu; Thu, 28
 Nov 2019 00:36:49 +0100
Subject: Re: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-4-wqu@suse.com>
 <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
 <f928122d-4e77-e83b-9a53-d2eea7ee16d3@gmx.com>
 <20191127192329.GA2734@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8c0a2816-1a7d-7d75-f591-c8712a85efd5@gmx.com>
Date:   Thu, 28 Nov 2019 07:36:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127192329.GA2734@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uWXu2ggNE9qw0SiZF2Zwc7upudEuISEOC"
X-Provags-ID: V03:K1:G764hfRaa+ZCN3brYKKpb4gYTaJTbZe+IPS9WITDqGiGQd8SlXd
 +UD0fJHJsup1Ja9MkRISGOr3oUenfvcO/v3uXu+TxBNEfEOVwXPmniZnbtQ4kiZFstY038v
 c/SgJq+12TicyeSXfOmoVTiQbNkArYq0hte3klQ8IhXGgYWvNJTD7bWQwK3miF1W54NTyEf
 3/fKYNoi8bIDvhgtWdVkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SWRsALGZJRw=:gq0V+LNqAwxgZJu0w0aXhW
 r7p6U9qskbW1pEUgnBa1zKt2Q0UHUkzSSPz0mFV31fzuOdX4JzZwLKEGwJyMYDXw2U5aKlzXp
 u6XnQ4GPqLUiTuroPispJKq20Nxnb1001DQQqXyFfAtOH3kl9poVBFi5YwvQRDRlJJW6nO+pK
 Isr4OKbqJSvSbhbnw/G8lUyfTnbJHWxWLMA/B/k6dTES8iISm44M/TTLKDkFeMonA9bnr/zOY
 OdKoMCpiVWiAKzESZdShbVKwRTu2NAuzeajrp/XKrTV8ih+j9uY19HvL7bS5lrqR1AE0jW0pH
 8Gfkyt/yZBLAzfQKfNfqLJN/WIwCEx/bb51gQazbgB97DY79pdjbszDtnqyzfYq8A37NWUJhr
 wdQphW7jA+XiNuAEmu5BFrY9+Ce8hxlCMId/saDS8C38LIUGl0pkbZ+/+xCRL2izG6XkoEyA8
 dT3ir+yctI12S8PFG4rE4sq4waUfhK6VQgbFN85YQ5JeQI04MsuZ9dw/Z7Cit9x8+UWCPwbVh
 z44GrYiwzJY1aa3B5R7hGNYt5swmFxXQhSAbmzo/7kZQvzIufDKCkgTcNLrQCnQQF5pUPIhi3
 ce+DleMhG9YSjlVR0TJWAnWFRbXG9Jj89oxXrmwOFYCS4hRjoFffRFx3Y5gr20J4N9RG4gVmg
 Tdmhcl2FEhPbL0heE1rXKNGhWOWcxTZuY+5d3aHiEq+vE7e7ttAce58M60ojvhhM3Janm/dSY
 SYB22NAfq/fmNxsk35ynp2iSzB1kD4MokQ/5siSp++5bsaVOTLmhV+kz+rPmGCadO8IhP8LuY
 MOUV9zN9jyjtbT6QmnYFtg14DKegpjSUollSRzWJA67MytVmeHay/sHP2Eh0POqzSpg2dImdC
 9JEaPc+N6hWgWFEYa2PmYiinCQreVFIrbUNkC25sZJkjUMewKRE/y+uoUv2NxxC6WELN1/TYK
 ttfVzS8yxbPmRwlFtooSZtG5CLXSL5kHMf/z6K+zVLmNvREpbOENDSoOpdNzpCVrPv8YQfZxz
 lCs5rcbYgwTY4sKS8lAk4zBHbjaz+meLZyUMyPFbDjroiTRpI7prTPjLCmOMZvEhyiLC39Zit
 ntOX9wRHfJMMj/ayAkcTPgs833olvvqGri3tRqdB9qVwnd423e1BLNlRFytfkXxDDk98UbdJk
 DSJTun9woA/P8fqDQh6NwBG5G7Kd8vsbCm7pKVQ5myaS7GZroh0l/QcMbbLisrzEPtP3S3u9q
 KFBEn3HCVDJ+Md/zJBl6AthuWtZBBAdh7NYkzUhTUzwTFpJI2f1jxc2cVc5I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uWXu2ggNE9qw0SiZF2Zwc7upudEuISEOC
Content-Type: multipart/mixed; boundary="MHYEtXocD0oVTwNVclQwYFbjBKlMd4qmd"

--MHYEtXocD0oVTwNVclQwYFbjBKlMd4qmd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/28 =E4=B8=8A=E5=8D=883:23, David Sterba wrote:
> On Tue, Nov 19, 2019 at 06:41:49PM +0800, Qu Wenruo wrote:
>> On 2019/11/19 =E4=B8=8B=E5=8D=886:05, Anand Jain wrote:
>>> On 11/7/19 2:27 PM, Qu Wenruo wrote:
>>>> [PROBLEM]
>>>> Btrfs degraded mount will fallback to SINGLE profile if there are no=
t
>>>> enough devices:
>>>
>>> =C2=A0Its better to keep it like this for now until there is a fix fo=
r the
>>> =C2=A0write hole. Otherwise hitting the write hole bug in case of deg=
raded
>>> =C2=A0raid1 will be more prevalent.
>>
>> Write hole should be a problem for RAID5/6, not the degraded chunk
>> feature itself.
>>
>> Furthermore, this design will try to avoid allocating chunks using
>> missing devices.
>> So even for 3 devices RAID5, new chunks will be allocated by using
>> existing devices (2 devices RAID5), so no new write hole is introduced=
=2E
>=20
> That this would allow a 2 device raid5 (from expected 3) is similar to
> the reduced chunks, but now hidden because we don't have a detailed
> report for stripes on devices. And rebalance would be needed to make
> sure that's the filesystem is again 3 devices (and 1 device lost
> tolerant).
>=20
> This is different to the 1 device missing for raid1, where scrub can
> fix that (expected), but the balance is IMHO not.
>=20
> I'd suggest to allow allocation from missing devices only from the
> profiles with redundancy. For now.

But RAID5 itself supports 2 devices, right?
And even 2 devices RAID5 can still tolerant 1 missing device.

The tolerance hasn't changed in that case, just unbalanced disk usage the=
n.

Thanks,
Qu


--MHYEtXocD0oVTwNVclQwYFbjBKlMd4qmd--

--uWXu2ggNE9qw0SiZF2Zwc7upudEuISEOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3fCIkXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjFcwgAp6j9qsmauIZIUVwR1tA/zTj5
viHbyvniC7Un+w14uMchf3HYewDXwNwT3oYrVkCxTTlr0UM4/louYv5zyLkBlOrX
G5P5M0M/bMILs1YDf+pFtgec6HK11fO3UROmZAXmCpez/plmCLs12P7xUZ8idrwf
lzMMjaa4OtXQPfelNN6TuuVU1LGnzeF1rElCSlpVVtjAmxCZE2Kzx9KhWZMggnrM
Cy+dkfskHP0a3ehrPf1efGvkD+pSCFGJ6KdZpmWxh98dIvZuxhRUHHDgK0mcfu4M
3q+PsmJ6ERN9kf+RzGD2uV0/UVX+n577oiNyTCrkn3OzMJ7tK8wjjl1EmoTHpQ==
=Wp05
-----END PGP SIGNATURE-----

--uWXu2ggNE9qw0SiZF2Zwc7upudEuISEOC--
