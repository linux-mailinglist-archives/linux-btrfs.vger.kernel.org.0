Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DEFC2CF2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 07:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfJAFf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 01:35:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:43857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfJAFf7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 01:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569908157;
        bh=iqPQPnMJE7r+IhqeKti79b1CKm/tUeD2bbxI9h34kpQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ctRMh9o1J64LXMC24G59fztkOfNCmblnywxg2/waWupOc4NduvPwsaMs6/JCFPiT0
         Hz5EFGdcUd6aPl4RdFol7ninrykqvfXXXKx7m7qBGSLupFMwHS5kHMeISfJugwx1ni
         aTbwkMt5R2CgS+/PQWyOonZseoaNBmWpcIDybtSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1hvT4k3nPV-00xrtd; Tue, 01
 Oct 2019 07:35:57 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <b0ec0862-e08c-677d-8bf4-8a87b74c1ec2@yandex.ru>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <54a2e030-3b8f-6680-a1b6-826c2f5c0928@gmx.com>
Date:   Tue, 1 Oct 2019 13:35:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b0ec0862-e08c-677d-8bf4-8a87b74c1ec2@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="irEfxQe4z4JBDxw9n8z9LfiZMpLyYtfWV"
X-Provags-ID: V03:K1:1Qi+eLpd3UpwT+MQMvPTemhTzpywk4n+rNxvdh9TjtwcwtyfU/4
 8Q2wfCq4ZG6qbCmcUaLNAxOGA8Vq6QGMc2U78pInGhuszJXlBQTYvA/3IO9Hkos3FHGSxvz
 e+p5zRt8iRtd2yNeOVHkE5ntes8ZhtAWIhWMPm8B7bKgl34DInX3iWgyFO/SIlXB39Ag3AQ
 Utv4xQkniw9YFZXjf+8PA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hR8CSQlHejY=:+0OThGmffWXBCmAIG4AHz/
 5D7tY4D0wevSJWtCCvlUDqL4Dd9M5iCDYOnBFnWIlItq6Gf4fQp0u3BBSPxIKDaLbkaPuN/j0
 eMctvplmvfMSC0CKDIW6McTQtZ5wwPDgVaLFWbuXejuNgJgLnWO544nVJIBHYdqMyhL/ybTou
 UkL5Wxs5elxOSi2FEnVnMctCJ0ykMvtabkgISGZpO4uU0eweeaGXSAacefyi74dud8uX9m8vw
 F7KjsfHBvSg00ExxYSQ9GXflOfUi/fM3J0IQHqsBPSjc+5Hrh042ymCDeVooCv5kSI/inlYmS
 0U6l7BoeeIG8NfP6IcfP46yW294B+9mxTRGayUXYR69A6p12oHKakyLcFcr5VsM9JIFWTVQV1
 GJOPt0qS/yDyHZA7YVnp2Rao3sbxWFO3bvnYj2P8Y174ZApinTdcBOTB+Wz2ZHnkTJnnqKhbF
 ha++sZNCJZw75pkJVgTNPLzHAWLaWAfCaPHzQwq8qjdE7QcUCskvfvgq0/BjRaThI6DWfowHt
 eTYik7QcKCyulfLU19IZZMIHHRqcKdjwjxK22qXEd2wyaIBThPzcFq4o4jz0WUpLMnbuaJ2dI
 wTl6nS2iRusr8+KjG3pgUJB5kxsaZRwjz8MOuC045kxObzX7DqeGE1h+VlTq47Et9p4uyX6xq
 5451+2lunaZK5ZbtME1uygr4EB6xyQPr+h86y1/0gvvXpXd9c8me422bMDIcOXRqiiIJQe0jp
 30Y9xfvqqhPshp8aBol3vYlTHFMpGxwGQaVnQcCKDL3ZPY+oPx9D8huulCvftMUEOH8cYj8e+
 9NnFyuvtRWf9nk8PPFzXY+JL2oriaFHEwI3RqUzkj28UM2F0lW09Vzj28UbZHaOHni7HKFbFy
 HwKzGz9WKhz049SXaky9VC0oFkzAp3JOaB8YBslv7IdPYu6o13JmsxLBlk1+A7jl3OWM8sZy2
 cojfyi41ztOMrGbWHTl8go8AWorMGe5Rtzk8UFtWBm2p598OCowLbOMg61ZJJ0Q9LKsBehTEZ
 nWT7TbZ6aQ2v3BpmcUMu3LRLgMeIMw8Y0vBYq4dJ8zPCHeHqMOfYeFY11Ya3bI5HRIdxpsFHx
 fm2wB1XQglUSE9e7xG121xh41Q7S2Sw4T8/gZNMORXgIiCRuw8TQuCCu3WERq4aI2e3h6o+9/
 Mfp0NpEPdZ8wJJtZ55+z6EEM7pW0fFxPXGP5Bi75V49B9/3s6vYT9Hf/Wq8sbif/84QgAXB0k
 Ix7ldaQCjI3ckyqQGq/d+m3XFYTUuS9eSv1QyhLr1+Z6/TTEgiN+XD7VhISs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--irEfxQe4z4JBDxw9n8z9LfiZMpLyYtfWV
Content-Type: multipart/mixed; boundary="K1DeWRmG57XgX1unRrqyLJYtzCvrKpTww"

--K1DeWRmG57XgX1unRrqyLJYtzCvrKpTww
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/1 =E4=B8=8B=E5=8D=8812:08, Andrey Ivanov wrote:
> On 30.09.2019 9:27, Qu Wenruo wrote:
>> I recommend to do a "btrfs check" on all fses.
>=20
> I had done "btrfs check" on /dev/sda4:
>=20
> attached btrfs-check-sda4.output
>=20
> There are some errors. How to fix them?

It looks like "btrfs check --repair" can handle most of these bugs.

Please do a backup and try repair.

Thanks,
Qu


--K1DeWRmG57XgX1unRrqyLJYtzCvrKpTww--

--irEfxQe4z4JBDxw9n8z9LfiZMpLyYtfWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2S5bcACgkQwj2R86El
/qicwwf/Qsy+rEDlJf42kbz/zOcRI79U4LGDG1Uri/c+bt+9m2KQIkzsmauo7Grc
BQcMLulrkOoDRmwbModZv7h4new3ej/H8JL/lfRh4tNXQUaTys58p0Kmdx2fJwZk
GqIKMl9on3tJl0ncU8X+DPy5ut2JXtTgTBDomfuW+2Wfe1PCztRU4nsLDkCmJt27
CRejvpswpn4CpRV4jDPDWni4dShdALO5rfJccN6Ejwrqjsir6g455fZxZCzxub3v
RBeGjxNqxrCTfwZeFzPS1N15uwQxUI5h8/ycY7VoUfFG9RR+8bfdh9C68QqzyFCV
ji7ctyiIcEsaRMgPUe7iTmO64ABhWA==
=rpW5
-----END PGP SIGNATURE-----

--irEfxQe4z4JBDxw9n8z9LfiZMpLyYtfWV--
