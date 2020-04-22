Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9952C1B397E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDVH4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 03:56:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:49989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgDVH4V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 03:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587542171;
        bh=p7XgU4VesE+9wyk7jgxgz8x98/lXl7tA4n7k5fSIAK0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ciKHUv7HSgbfw22RplZBbvdXARRc/a9xRVBKwuXqH41wPhxs8rhwQFfZauZciweWD
         L1x4fLhqQX9W1dldg4P29wynFCRUUaFf7/IF2izNd97lefd3QgnB8DLmqIbA3j7pka
         0s5g8uw/HVZCrpiSI1BvLlPcJmKCz35JI6EOGlOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw7V-1izlur496h-00j2SF; Wed, 22
 Apr 2020 09:56:11 +0200
Subject: Re: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support using
 the more widely used extent buffer base code
To:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
References: <20200422065009.69392-1-wqu@suse.com>
 <20200422094607.1797ce2e@nic.cz>
 <fa3177ef-c264-2fc0-4793-d35209d05d2b@gmx.com>
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
Message-ID: <fc78b14b-ea71-80e0-f0cc-6f476860d6c6@gmx.com>
Date:   Wed, 22 Apr 2020 15:56:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fa3177ef-c264-2fc0-4793-d35209d05d2b@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VJvFv34DU6knf4hy0EhZJX2Uw7YxzPpdJ"
X-Provags-ID: V03:K1:+s8X3HAVrlVAd4r34X8G39FE60tBRKa/N/DiWcYw0kkIkCNaYP+
 P8cxt8cW0Rhr4W9ccqwDS/hIXLF7w9wQrHrWT3w7ma6GT5icEo1LLheIMLouoNcrei07bZf
 OnxZ6nHO7/XDk24s3qOYm8NrD0SAvxwwbMnNm3eBIOxsy285SVtnWK5PoUKcncfyyQfExC7
 iVfU7bQUqNfPg6wDp2XaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FxGIk7k9IsM=:uzmJ+dLrCKWndUKde723A4
 G6fyGir7EdnI5krfDpEcI/6RBD7oJ7lnfF7M3IFWYmPHWUY+6aXntNrdLct9wd5fvetoRBpym
 +A32z2Lzazakstp1svjpx7mUnJCPU4c//1gVoARil7yTuJYyAKB7FFwgPuf28Ovk9tD+AdkCm
 GRDNJ26R4/qb35TIO6WJhUIV6PnAfHrp1HHAOsmpMEGk8zDW/FHJE1KtZ7xPK1l7EoQaStsno
 3U+2CVmcu19ZS6wmiaeTiFRAQ48H4o2CDZW9ndOQ8o1WzfMj9MTw71nIkofpnt7yRoYkZ0Q9P
 TmDMy04KpipwXPPOg1gajc8GkN2QyWZKLo637sE7dlubvc5NZF2BqGnREuj2+sLEIoQ9F9loy
 eGvANmpwvGBDLxlVlig1Nb6ZzJkOnB6pnMYtW4GUxKvXRPOOQpD9cLBPoejOlz+cYYZWcx7s0
 QnYFsTFDr1G2dkmWrNKylSnwRd16VS5ZMOUsLDROI5STh+OGmHp1XzIASJmTHna6nukp1+oOG
 Q0mbFEXjsS4ElWDpd7N9fxG4ocR2kzJDfObVhOU8077EbpqtqXPJN9507NDWmmA663Ocn+Lxv
 8oYtwJINIaZTUvnunXJqi2uNC8CbL6/5oEobuOka1G1BDy3PlCG44n5u31vhKyxYbjaxfkwsO
 s9c0ZcBvB/VuNKA10IuaNzu8AhhGpLBGxRfqH3DiDCelSdky8UJx2C8GP/tTcOtAfLtyI9tUR
 oKLZ33QiD58WWlOKK3V/NIFm4Fzt6xRiRH8yCC0F+/ifniHVbgD8HUesHPFQXdRfbV/Nx8IcP
 vnU5O410ToOoJpyKAu87k2Y/MDTa6HUqyOoYzmBJDlGjafr+dCKJNL0dHUPuUHWx/6E5aoXLY
 kS0IfiQGXCLJUXUlnUBm3dGpafVIPS/f2ClLinPOvpjnGIfeTT3HKSAUo+uVD506Ri03U9Egj
 wD3+Irh1Q3yylAxl7b01zm3hHnf7Tv04ZMNwlXjmpeg0oFpm7cWBN6QVuGbTlSVQNhdHpqwKZ
 2eaXBVOV1nMIy3SdSGwmOYVg3BQOaLWE8+XbhviQFtuai47gTViAe8RGebbF8l54l8opuT2Wl
 maVeAIhRyi5VaB+4MsDq8e3becJC6SLkHz2ZF/Z550BjfaFzw8FQoO+PKcniAWAeMk3IEQe70
 qZGjst5OeGA6xkZ1dGs4D+YAC/6BQuqeRb4hdX4BDhrQ5EDOliEmCMeXNM6KPaR7lTk7oTzZi
 xMj6ipQ2s12rdypYB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VJvFv34DU6knf4hy0EhZJX2Uw7YxzPpdJ
Content-Type: multipart/mixed; boundary="aST7akugqk6Oz0Gz9RVUIBNim9RvrDPGn"

--aST7akugqk6Oz0Gz9RVUIBNim9RvrDPGn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/22 =E4=B8=8B=E5=8D=883:52, Qu Wenruo wrote:
>=20
>=20
> On 2020/4/22 =E4=B8=8B=E5=8D=883:46, Marek Behun wrote:
>> On Wed, 22 Apr 2020 14:49:43 +0800
>> Qu Wenruo <wqu@suse.com> wrote:
>>
>> Hi Qu,
>>
>>> The current btrfs code in U-boot is using a creative way to read on-d=
isk
>>> data.
>>> It's pretty simple, involving the least amount of code, but pretty
>>> different from btrfs-progs nor kernel, making it pretty hard to sync
>>> code between different projects.
>>
>> do you think maybe btrfs-progs / kernel would be interested if I
>> tried to convert their code to this "simpler to use" implementation of=

>> conversion functions?
>=20
> I don't think so, the problem is kernel and btrfs-progs all need to
> modify extent buffer, which make the read time conversion become a
> burden in write path.
>=20
>>
>>> Thus only the following 5 patches need extra review attention:
>>> - Patch 0017
>>> - Patch 0018
>>> - Patch 0022
>>> - Patch 0023
>>> - Patch 0024
>>
>> Anyway, this patch series does not apply cleanly on u-boot/master. I
>> tried with the first 3 patches and then gave up :(
>> Sorry about this but I will review and test if you send a series that
>> applies cleanly.
>=20
> That's strange, the branch is originally based on an older master, as
> you can find in the github.
>=20
> I guess there are some more btrfs related code change since then, I'll
> rebase them to latest master, and update the github repo then.

Git repo updated.
You can fetch that branch.

Only two small conflicts during rebase, and since it compiles I haven't
re-done the full test, but it looks pretty OK.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> Marek
>>
>=20


--aST7akugqk6Oz0Gz9RVUIBNim9RvrDPGn--

--VJvFv34DU6knf4hy0EhZJX2Uw7YxzPpdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6f+JUACgkQwj2R86El
/qh9yAf9HxmpFFqyYMkZmo/3mI1VNbGxNOU3xmCDTmcl4aiTTTG1xPzXuJXrtb74
m7EMKu2cQbUIvKP7ozbGMC8u+OscDzvpPmnY21WX8q++VC3x2CiTjb4R3wwXof4i
tzZZHlVl8hzu6Rn1D6YuPf0RV0/knKYV2S9ZNU9ORs5uINSpHTOSxwSOOglbVs9t
hm4/V+KTRSNQHH/UsHWNw4mzlSPyjv7eRrZVJIUqAYwpSYVn5YnMal4DZEfVm27x
Uwa77fI5Za5T8NtHZ0QmJ5Jggni+Rx78Q7645Kh+Xv2+MmlE0dYPyC7PelQK2FoX
DK5pRkPSE0964QdDePWoHKAH+M4lGQ==
=DEaq
-----END PGP SIGNATURE-----

--VJvFv34DU6knf4hy0EhZJX2Uw7YxzPpdJ--
