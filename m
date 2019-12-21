Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A54A12865A
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 02:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLUBXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 20:23:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:53191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfLUBXw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 20:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576891429;
        bh=OXtEKorWOiEvUSsjc7r9U0hmBrRaACpQzCSOGr4k2pQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HS7kaqWk7OjRL0hcd4kQfggfXpGye4ekW+wvRgVe7xuOHayyeLUZsro1/I2HHqPwC
         HqlLJdn8E0J/Tja7sJva10tIqUB+AhbK5OM2ZkCrfWOQqcGL9yBXsXczto52ASVRtJ
         XlAco/18dqsTHb2NC+iMk1ZOkglcVpHmHo/F0zDw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNtP-1hx0mn3gjt-00lnCt; Sat, 21
 Dec 2019 02:23:49 +0100
Subject: Re: btrfs dev del not transaction protected?
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220170707.GA5577@schmorp.de>
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
Message-ID: <dda45fd3-0e77-6cd5-b351-52742dfb4aad@gmx.com>
Date:   Sat, 21 Dec 2019 09:23:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220170707.GA5577@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vOx7CzYVSIymRwC1yNld1Dil52emJywZQ"
X-Provags-ID: V03:K1:DjKJWPZNE5QhPwOjGMWVPI24d1/7oK8IEggPsEdsVmzDFxPu0q4
 yX59Hjb5Rf8oeVuBZSqOJXkZMhVLS2HOPuFHnpg+IKXJd+3GpGOsJL80fSg7wliGmWq2OQY
 QCthDNUtOi/AJAKuDG1QvrBWoMCCgfouK2sy/Pp/ZGkFb6O3wWjMwLeLrE94zVPpfra16H1
 NXcPQZMugs+Wi0yHYvdhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zqleG0WXLtY=:wrafskpS0gRUcYAfkJMxjL
 ZrXXBPCJ6KbRRUoCLDmQCmAsBxTRwsngNY1zxVLWy6kJJMOUXZJKjElg63pP/28y8jvZsimxe
 HEjSmkb5HLkjnIoJmowFp0qAmaxTTFzoTUHMNbrVNHPvxXN+WblxarO4KfYnD5/r3cCQxTUhU
 P4nKvsgtj4XhblBtzHcHQEjj0WPgh6yBEtVO2hTRMqVkIbyuRahImw2DRAQAKydT8jUzQT064
 ecDbYDaA1LiXPHt+HQlUFXh44IjYEyHH2wkN56xt2SD/iP7vQYJdZP6oKzXIB7BAm3z7Cbqdq
 fFPhRORvKl6me4cWDna+M6wS2vsX4wNTOJ3UbLp8c1PUwmXva35ZyIFskYv7JLR6IkzaTMcmw
 Sv/ff4ZmHnOSqGMyNe1OLWIbZrExbBYM3eESPkv+4hwvMGu+aZPlrrlDaq7RG3mcklwieVH81
 vRKTDIBGfdxw7j6BIFpGO+T4kXXj1ZPjsYaj0VMnbvi3LE2NuuQ9y6GFOi5V8S0Uabgeyvht8
 rCE3jgkOWOUvONDiIwjJehLl8wicRUN+t/nI+RkWZ42V+ihsVUHIpgt/tC/v40ChhAbzPgZuG
 bgKXb5Vh1uFAieipqIm5wnHey6hfqr9N6EAPvrxBRGQbvNqdMOvfTqpqDPxfdC9vt7FgJS8sZ
 QaO2cHDxOryoO8OL6sfYtS07880UUvMWlhLQ9P9Yc/yv7HpbypqPoN2eTYeBjtzJdFNRDYziw
 QfJSeeUG/SIQAKt+1HEGUg8mTRKgKhlXg/iKq28BbFtg4+saNtQ5pEoFJTb7xjjKlaYgQlOO4
 TePFCpZ7EYwBK5u+w35a/Lz9kuOn1t6beg4aIgGy3g9XV5sYiJcJT6XQmOuUIAJEiKW0c38VS
 UARPqlq0cZodcorVdOmx4keSSelZvsJImQ0Xm0W2dz6EnG3tokHnZvJzvpgarnRdO6t+9TNHf
 QFJhNegHvBCPQZrAU9PUulEhyXIea/4xbqyDAuZY8neufF5jU236NFKN0TbtMjWZL95h71HQH
 VPoUoUgYmywwtXk8IblAu0CMcEOQJxWUHr5RAvo4sTKDBTUPp44zSQ9cARU5+6E4KQvyRdh1W
 4L+bf0HlrtdCa/8E9cF2J5kD4oRV+gJmL9kQXGd50uiB30A1VZmqd7JuNUmg0KjcGDHeS2DJV
 rgSkipJ6f2xc4OUsWibdBp96z8gBnMegSGBL7dMx2obS17PEkIIwqsPoPzUJo+3Kh0rScG8rz
 Drqofg1Juw63VOdcHMCzfDcbW6MQyoyHfjhK32tGGYlY0/VGvEogEbqKh4Ds=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vOx7CzYVSIymRwC1yNld1Dil52emJywZQ
Content-Type: multipart/mixed; boundary="V7LWDAKcMLC56e8EUWxYfuuLQtbX72D9G"

--V7LWDAKcMLC56e8EUWxYfuuLQtbX72D9G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/21 =E4=B8=8A=E5=8D=881:07, Marc Lehmann wrote:
>> Just while I was writing this mail, on 5.4.5, the _newly created_ btrf=
s
>> filesystem I restored to went into readonly mode with ENOSPC. Another
>> hardware problem?
>=20
> btrfs check gave me a possible hint:
>=20
>    Checking filesystem on /dev/mapper/xmnt-cold15
>    UUID: 6e035cfe-5b47-406a-998f-b8ee6567abbc
>    [1/7] checking root items
>    [2/7] checking extents
>    [3/7] checking free space tree
>    cache and super generation don't match, space cache will be invalida=
ted

That's common, and not a problem at all.
Btrfs will rebuild the free space tree.

>    [4/7] checking fs roots
>    [no other errors]
>=20
> But mounting with clear_cache,space_cache=3Dv2 didn't help, df still sh=
ows 0
> bytes free, "btrfs f us" still shows 3tb unallocated. I'll play around =
with
> it more...

Df reports 0 available is a bug and caused pinned down.
It's btrfs_statfs() can't co-operate with latest over-commit behavior.

This happens when there are some metadata operation queued.
It's completely a runtime false alert, had nothing incorrect on-disk.

I had a fix submitted for it.
https://patchwork.kernel.org/patch/11293419/

Thanks,
Qu

>=20


--V7LWDAKcMLC56e8EUWxYfuuLQtbX72D9G--

--vOx7CzYVSIymRwC1yNld1Dil52emJywZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl39dCEACgkQwj2R86El
/qiHXQf/VB2q1kqA1VnSGw3rFtLJekYBc5pkZ9RM0OTl9j1IQOruIKgcM8P32qR3
fgyqkHCe+xpZqYtEM08u0yFIbSZrV14sqGC0YudxnpA7/wVuEPtfX/w2M9iqLhQi
VkNTqBi8jd8j7w9goirKyIelQ26U6ZbtnEfE1EwPjJ8KgoPmOIt883J07KtDybiA
ohsK2rJgZY7AqbUnAvNmMHfH/2snXmV5TmXfHqlzpM22Wu9ekBqJnBsYP0pXxihx
7U8m62jKgQRUvS3D/HQkdI+jh3n7vgoZX8Aqc+DGVjppYBpHnDwrZPHKFajL47NK
hokWb4tFcoFlaNBhnaenWSr2x0rJ5w==
=eFgm
-----END PGP SIGNATURE-----

--vOx7CzYVSIymRwC1yNld1Dil52emJywZQ--
