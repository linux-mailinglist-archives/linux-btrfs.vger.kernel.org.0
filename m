Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A021789C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 05:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCDEyh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 23:54:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:52977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgCDEyg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 23:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583297670;
        bh=ZIp6aKepBxU41Z2s0STpRHeYjKnIeCC3tklx7wEspuQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BKz+Mp7M1gqJl0XlF+XaKuqFHo2TpWrq5nlzun2lrNCdDin17VALSnaPYyxBSB4Uj
         ya1Cb3rHOk+o3nBm3cz3Ageg5pjcwo4lRdBaoBL/rS13CvQ8SbqloPwM3iSxU3c1ox
         l3PqvqJD3N9yh1G2rQllxwbD6UmP5GujnXJ0E+qk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgvrL-1jahej3B6L-00hPUz; Wed, 04
 Mar 2020 05:54:30 +0100
Subject: Re: [PATCH 00/19] btrfs: Move generic backref cache build functions
 to backref.c
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200303071409.57982-1-wqu@suse.com>
 <b6520f1a-4849-4390-6aa8-e08e69bebcd8@toxicpanda.com>
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
Message-ID: <886e97a1-2dff-7a1e-1324-6c389bb972b9@gmx.com>
Date:   Wed, 4 Mar 2020 12:54:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b6520f1a-4849-4390-6aa8-e08e69bebcd8@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Io7PblDO7cd827y9z0kNnRTwJf68xN2sX"
X-Provags-ID: V03:K1:8EG2YrCJppyitMVLrOVMaFXMVEd1UTk6JeGIws2JFhke2WE0mnV
 V6vzyfZFwcUBlrHIq7YhY/xl+lR4Kc/4XokQ/Iy29pNI8ZqDEONo3/mH6mXPNEFMK0BbCZg
 OeDUFLTmAN15RGahB/WiMjIT6R9CEA42p7qrEyiq7oJPLKPPBBnPBfBgCARMqs4BgKY0f15
 pRY2Lx8FGAhcjbgjVRnMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d744VwENCYY=:oeLgHntov1tA7IUfghP99P
 Fl62AGM7VKDbGiKPDWyhwnn3JKevY97Q32N3ez6Gkieq1kvsxCUZ+96N8xMFO2gtJrHXhYPmP
 7V/eV7ZWAjHXbk5RSgAd7wmUREcQC7wF8Vp5A/L2u2sp+ka27G5oQQnXramcJTxaDDVm79YMJ
 W1Ohvo7VOCxHi28yDGIqX4vq9B8Sxdr0uPbKAfHCUAJBFkwGQQDzWW0wT9c/07fONm2FbFty8
 YCo3TRivavsKsG3yzkAp/S2rm6w6Dv+gjqLGuWBvqaHO/KhH5+Mk/kwZsTgVyujh4SuEgxq+4
 FUXwR6luEn+JdQHKevh5hxa23Ta19JrBQUU4H9WKM06DYAM/0SJbLYDU6Gfo3hii7snnRDlwc
 xl7YVDL0uzvmBQ5QS/Ga3aVop711XT/3cw34uIP/aeiYVIWQwM0TWxtMG7rC+evr+Dbb2Eq+w
 e8t8PpFKOG1gsXHmCOUgz1gvnBQh9ycvqNUTkRYZfjVWA++Ai6teLXAAu2KRRqDu6DqPWhees
 YDbHtImfOVkJ9ECei4ppoZDi78NJIO2iGiyY2a8TntXW7dtoC605mvO5lw8k4ti9nza/A/QiG
 ZAgFcGPC7tuqBgEGkcbS5987hSCdsrY5u5Y/FA+6yPZBAJXMb3SmIjrTIQGQsrPdn6hpMmsPA
 SE6VH9JTTXBzZVOb/zyB1Esomp7pPhq5Wp+LDWahulZtcQxfpJT8g75g01MKdVq0Gy7lUb/D6
 lOe/YWthP8BG51p6reGQGksH/FafZ0QJ8WS8H9/V15/rZ74zgH/cDxKoxpIi+zJCQ+NUnmPeb
 1ivE064bGuP2lRWrvVjdcMutUgoW+Frflp4C+/kPuscCJWsUBJgpLHurUZEqfdjXf+wn1CPKc
 azHi5a6DQu8DoITQCTnHOc7XJoeGdKlfSUtkU0UzV3ubQQu7R6ontoHFoJeE0Ak2cxeq0PEla
 m0F9YZA3GqMCZKug9UTce19tsmv7eeiStcrtwYiXc6yFgy4ocGiYpamFLOlE+2EzamDl4jCXL
 r5mzlUw+mUq9NeMZiiDv9txDlUad10sJHxTdiCXrt4Nf+nd/m95cCky62MRAcbdScgMhID42b
 RPGxxmroDASXKuWUcQ84UJVYTQvMZGU8O3fttY4rN4JlZ1oR6OgT3d254t3qJIIAIxneramsa
 Oj9PVver27vbREWisj93WWke9R7xdnE37a9uP5vWz2VEnixfu45Qgx0b5i3A9cXxFTx3VIiEh
 359aHkUfuIudnOeqQ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Io7PblDO7cd827y9z0kNnRTwJf68xN2sX
Content-Type: multipart/mixed; boundary="f3YwZ6WFO39sfdvtcV9NKkM7KpACLXwOR"

--f3YwZ6WFO39sfdvtcV9NKkM7KpACLXwOR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/4 =E4=B8=8A=E5=8D=885:22, Josef Bacik wrote:
> On 3/3/20 2:13 AM, Qu Wenruo wrote:
>> The patchset is based on previous backref_cache_refactor branch, which=

>> is further based on misc-next.
>>
>> The whole series can be fetched from github:
>> https://github.com/adam900710/linux/tree/backref_cache_code_move
>>
>> All the patches in previous branch is not touched at all, thus they ar=
e
>> not re-sent in this patchset.
>>
>>
>> Currently there are 3 major parts of build_backref_tree():
>> - ITERATION
>> =C2=A0=C2=A0 This will do a breadth-first search, starts from the targ=
et bytenr,
>> =C2=A0=C2=A0 and queue all parents into the backref cache.
>> =C2=A0=C2=A0 The result is a temporary map, which is only single-direc=
tional, and
>> =C2=A0=C2=A0 involved new backref nodes are not yet inserted into the =
cache.
>>
>> - WEAVING
>> =C2=A0=C2=A0 Finish the map to make it bi-directional, and insert new =
nodes into
>> =C2=A0=C2=A0 the cache.
>>
>> - CLEANUP
>> =C2=A0=C2=A0 Cleanup the useless nodes, either remove it completely or=
 add them
>> =C2=A0=C2=A0 into the cache as detached.
>>
>=20
> I've found a bunch of bugs in the backref code while fixing Zygo's
> problem, you are probably going to want to wait for my patches to go in=

> before you start moving things around, because it's going to conflict a=

> bunch.=C2=A0 Thanks,

No problem, it's expected to have some comments even for previous patchse=
t.

So rebasing is expected.

Thanks,
Qu

>=20
> Josef


--f3YwZ6WFO39sfdvtcV9NKkM7KpACLXwOR--

--Io7PblDO7cd827y9z0kNnRTwJf68xN2sX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5fNIAACgkQwj2R86El
/qjSoAf/UXccCaTYOllWbBlj+P6WdzOuyLKByEgvkGy4G2H+4q/fhd0EuPQYcalj
2iTpmm42kPuxRXsmeqlnArZHkAkqsVMtvWuDIvhTfjLWvucWY+LbOyLbqHLUdnAk
3xjZQmKK18N/0+vwVAj7GbQz2IM7742aoks7Ugteg0fWAMAVsoow4A0H48TZybsp
VGQmJEUWiBU7FQ1Wmw9FJuLeFrooB8NGMKUsIqjSHJE5cSb6o7j8rIZF29QBb7Ff
+sZAHF+Ozsayd+o/lnyL6UlV+36Ke0MKJB8H9stKwq3kifrLpyfq5cb6m68j1nk+
kdchdkqeUrWAmImpicLFGMU+sJvjIA==
=1eox
-----END PGP SIGNATURE-----

--Io7PblDO7cd827y9z0kNnRTwJf68xN2sX--
