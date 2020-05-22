Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695FB1DDCAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 03:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgEVBdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 May 2020 21:33:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:33861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgEVBdB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 May 2020 21:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590111178;
        bh=51m3PXpqldWmJFgoczjKU2XNQmWDWOse2g+iNI44TQk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QB9I2n+ir82wZc003Zr9CEx1kdgHsEdyqX8AkQfFixKwiQ3SLsDSVZCpzufKDC8fh
         09v+PZ+vSPCUCVc8bmnWUHire7Fdn9gpyLRGxEBt2jNI7GPIxFazKgSkkaXQ5WNtik
         2rJZCwFScMcGaCyQF0sraafTE1jsObqTM7znofLQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH9i-1j3yiL3BIS-00cdgx; Fri, 22
 May 2020 03:32:58 +0200
Subject: Re: Trying to mount hangs
To:     Pierre Abbat <phma@bezitopo.org>, linux-btrfs@vger.kernel.org
References: <2549429.Qys7a5ZjRC@puma>
 <87436f2d-40d2-5fa1-cdee-4cc4f63e68c9@gmx.com> <7541432.rVhWMRgfCE@puma>
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
Message-ID: <290f9ee7-1aed-2a92-bdba-063d238bd5bc@gmx.com>
Date:   Fri, 22 May 2020 09:32:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7541432.rVhWMRgfCE@puma>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y9bgt3y0kI7qI6m5Eg9pz1OXJKtjP7XKR"
X-Provags-ID: V03:K1:/tiryM2WXTbhImhoQA6C3ru70pb7eRE8oAFzxXMj1Ci3S7PX5Od
 wn3wPzKwnfmFcrOBRShVBd8yI+d8i4oi9vFid+n6pPOOaSItPghZQDkUlth6kAX5Xt9ZzFC
 ddsbokpUrhrwAfghrpmfUAR0jM3Kw9qkWcQoWH0fn0mSWQ6U3NUVzoer3gHMnP6xzK0tUZH
 KLSSgVjrlU/OnzkG34eiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fhyZnwYvY5c=:3WtRKIfzZvn0r0dje+GoEo
 +VHdxC1L7vbx1zYXZ9ob7Mk+A9yuiOHyVC1sVS57COclyEqZp+tkcyjq07xeDi+rdLnBdtrYa
 TsjhIK1N4AUAfYlU8THuJDpTuG5kxFqIuqZWDEWI1VnUkn/jIdSmaR7vbELnBN6ymGAVFHF2s
 5tbhAfXr7Drl53oZCHbshd4fzweh4mmP13a60m5FPRIwSINmgjxLe+WKO8KevjKDXoXjfvhNU
 9/usTb1GiTmqM2Ptmyw6sC7VEl/S01xEqyCsyNrTTQfCs0Q65piSeVxzbT1oNFM2yqGyPB3QG
 2DeDSBlH3TfzcgG6zCvFTm+2T4isIQDKATbyJ2A7hM/UqDpM2Ddoa9cl3XmeJQirFOPNs4pTA
 m60LBKufs5tBcxrbJ1ShUqorSo92giacD/f0PemWOqx67IDnS4qmXcrxhe6EK011abtnr9tmX
 vZHfoERz9q+yf3Qst6rCgE0t4KrQzwerqnZxeftH8IkJ8fiYGH5Wc18v7sY47X2lQpAdmayNH
 D8pClyvjL/JpxbwaI0EA77Thf5E3bII+8IydfO0pYuA8zKrjFsNSlWPoE2r76dE2XFbQdYkCM
 LVjcBWXnL9msoO58wW55oy5U0M75P2DGhUfsvlfDjSUYnnj1Bub1YZGU+zW1hG19fTww56zJP
 GTxf1mjSu0l01Tv7RaqtmZ5Dv7ca0MG3/kNZNzFEDXjtP/QwbuAcViuwU3C3Fp4UsBIDXg3fD
 4Ux+8mWRUBtAvcc61KPYu7aWGs3JF3TncHxas03kiBg4AESGqdSybz2THP409er7XeFFRsEXS
 2oTfVbGGbLfO++FhCc4dAEOJLjjksXPMp4APY4JYPciMQ6IkBDQyc/M2/IUQLMPbFImelhgSO
 04bKwi292QhcO43xzY08pWsvo0j5FLNQMIQVTSQFKjgX93zimnCnoz49ju4T96Lox1zVEnJ2I
 5t59tlDojxpf8Z8G+kn3qIKEN+KTqR/PywA8zc8aQl3iUdldQEvclfKBiU7Q6/OHkxcPwLtPG
 qYJpBUtrX+bG+YyMMkIi1QFI1zl9Fr5hXyHL2VEK9XlRY45UwJ3pBpXWjmUPmtsxHpotSjwm8
 AKfkVPZA+ImT7Sa09NjrbUkujUHc3vIO3PlebQjoTDTWjZYvHFmEOuFPtXyNRr0yryvHh2BoC
 L0uQXdgn5STucSL0ZCFtYmIrCSOjf4nA9v5+h1BwHbn22f37klIXS80dkWVPdR6kkzlQvVniH
 XaXrhXte11VNxtWtv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y9bgt3y0kI7qI6m5Eg9pz1OXJKtjP7XKR
Content-Type: multipart/mixed; boundary="dZqL4mm5xy2PE11YFVU64Ougz9R6VvYLv"

--dZqL4mm5xy2PE11YFVU64Ougz9R6VvYLv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/22 =E4=B8=8A=E5=8D=887:48, Pierre Abbat wrote:
> On Thursday, May 21, 2020 3:56:01 AM EDT Qu Wenruo wrote:
>> That doesn't sound good. But according to your btrfs check result, you=
r
>> memory doesn't look good.
>> There seems to be a memory bit flip.
>>
>> A full memtest is highly recommended.
>>
>> And since your hardware is not functioning reliable, everything can go=

>> wrong.
>=20
> There was a thunderstorm. The power blinked twice within a few minutes.=
 That=20
> could have easily caused the bit flip.
>=20
>>> UUID: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> incorrect local backref count on 4186230784 root 257 owner 99013 offs=
et
>>> 5033684992 found 1 wanted 2097153 back 0x5589817e5ef0
>>
>> Here, the 2097153 is 0x200001, it's an obvious bitflip.
>>
>> And since it's in extent tree, even write time tree checker can't dete=
ct it.
>>
>> But that problem is not a big thing, btrfs check --repair can fix it.
>>
>> Still, memtest first, only process to try repair after your memory is =
fixed.
>=20
> "btrfs check" gave me a "device busy" error. (When I booted the M.2, th=
is was=20
> caused by the hung mount process, but it happened even when I booted th=
e flash=20
> drive. I don't know why.) I couldn't repair it. I had to get a new driv=
e and=20
> recover the files to the new drive.
>=20
> Trying to mount the corrupt filesystem consistently hangs. That indicat=
es a bug=20
> in mount. How can I send you the corrupt filesystem so that you can deb=
ug=20
> mount?

Considering your btrfs check reports no serious problem, the hang looks
strange.

The remaining possibility is the log tree.

You could try to boot using any liveCD with new enough kernel, then
btrfs ins dump-super <device> | grep log_root

If the result is not 0, then try btrfs rescue zero-log, then try mount
again.

Thanks,
Qu
>=20
> Pierre
>=20


--dZqL4mm5xy2PE11YFVU64Ougz9R6VvYLv--

--y9bgt3y0kI7qI6m5Eg9pz1OXJKtjP7XKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7HK8cACgkQwj2R86El
/qhvSgf/VKpCOVkFJGAzRVJvPTWnQLMbqrdhawSzGBSjO/nR4s2YGlZ5ClRDQiYB
FUVKjKen07ej9v0jb5mApNXQMx2X6YcURDknEvSgqwNHdMNmyFgPaXAMp37WDdMA
FFA4spqtnzxVidhAhqrVF6D5RAS/7QYTLWwIU++Bg6On7bkm604FlOWS0ZKOZW4+
LLrOPD3HRP1C6cMC3NWDp9UO/EoK6tXiRPmw7E2YRjnBr8Ayc64cHL0Z7e7I/JcI
i3pzZhcJWukM3EA+ZeQv9rJxDPDVQgtm5zEV1dN7fIX0j6Jdad8vTOlgjKiPxiut
GsHwhQ0xynCoCwrB3T+/6yeoj+HdlA==
=863N
-----END PGP SIGNATURE-----

--y9bgt3y0kI7qI6m5Eg9pz1OXJKtjP7XKR--
