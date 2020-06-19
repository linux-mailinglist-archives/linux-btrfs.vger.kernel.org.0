Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562822005C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 11:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgFSJwq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 05:52:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:46557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbgFSJwl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 05:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592560357;
        bh=0HpDiv2vZ4lH/vwOT+5QTqkiSFNkIknD0dfrKy7k+aI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Y2Y32yM/kbIZjbwWK8MdZyE6YDsY9LydazC2r71lMWmm578XQlfOpcZRSI5fN/ikd
         kHT3+rWDSnX5SyU95sOtMtt3NZMgi58X7qB40khcScDuBIvWk9luP1em0yYIHffLit
         /us6nBDg4S6hjwmArkaAqXptrAiTX8FSlHcLOzf4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FjR-1jqMhX0osx-006LRy; Fri, 19
 Jun 2020 11:52:36 +0200
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
 <20200619093903.GB27795@twin.jikos.cz>
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
Message-ID: <94942230-bada-98a0-3d94-3b466752ff3e@gmx.com>
Date:   Fri, 19 Jun 2020 17:52:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619093903.GB27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kp7uq0tAIA7IKONldeE9m8ry7pSbwhMhC"
X-Provags-ID: V03:K1:ShRRNet/HR+ej0sGWG77aJcEFkq1yMXC2TEjPOaKKDK1HWe9BoZ
 zOW5an0RRULhAgNwSFhrta9La5vw9ah0KmY1EwcGf4VigG5boNNSWkab9Z68jQFshDVesJP
 1El/nWh80EWe/4ltTWnzWnuYuwPH7dqLIc/y4a9BzKib+oeVvPllQksBDjaKnA6HTl7nmAL
 4JX0237GTdCT6TcQUMfGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iJicWAGrdQ4=:VJ9mCFyhfIjaCixAes+gMV
 /nllec/5XRzDcTtIZfzUhecmCRRAiYQUL4qGtocwLRqpBTfBKAF+7sEGmTDIbfXciixGBJ7tT
 TTc29y9UFfzdIPDRyWG0BHw7wmSlpDU8n1v7Yqw/vKcPAbMq+FtBKf8IC3SQM2GeFxMbTBsfl
 +8bbNPkR2/ydDYUfCnJVeb7AuE3qmYa+mJMhUNE0QHKXmBu9HG8Xu3OhBpRlQp3C50cdx8hDD
 44Ip03olHMxunTAkDNIHlTLzcwS4rLxg/HZSa8Q+68YqT/jISHUk2m69i43tM6XKRt85qQ7w0
 HwNSOXkSqFMywlc2KhgcOZ7sqkbwGD2CliXqmyVbnOFSkUXLLjbpq1PP7FmaSpRGEpI2x6H7K
 roeWmnjaWlla+DwPQLth9aX5JXoA0u8eEplWaidf4d/co1De53F8niA9b6EO83AELgp+LyM6S
 Rer1cnaglMs9B90b99XBubMdaAc4VfycKQeUNgfS4vG5aA6O03gd9SKzfEppGtpvHn5c/N4gT
 nBLe+LBvEI1A3nJCemvxrewtjUg1ELtHZtrjoImE1Hatfot1JsEwuPzxjRV4psqjuCsLxEFZ4
 t/RqLCHNy8JEhdQ2zlQnvdZDmtTRViu7nS7P9pzkAen6g4XoKVVqjnNkRXvH1azP1c0m3bo95
 eED9oYBKfWmPiasGeYMqfA5i8zoPpUltSx5UMBUdogpPHDrq91Xa+nsagEry9NmaXUp/kVHOh
 CI2oq0LZei2QWWkmWMqxde5B7fXIEB7e5/9NsmyqD6XJ1gIZuvZ92iTIxTLi/LYKBIABVNsgW
 /SzMOR3WMzfOVfW7LzcwMBHpcbQ4HqduuDltqCz4mOzkLSq/4p7ME+Q/mw+udE4t7P5M4UG8/
 Cp0qJ8jcnhCVZFcxZtbWEgEl0Kf78ArHXomZmv26LQ7oK2fecbs61OkSH6tcDb0g/P0sk9ewQ
 oxXUadlBRmrQ/2tBf45mekxzjKBDv82/oVbM5DMugA59wNSOUDVV1UJjLJC5muxyDt2RcN7gX
 Lx07Sk0Tbp7L53qd9O/ZmFTTCdcT+Wvv9rKxHFA4beMCgMZJzWiFzU0VxzGJ5Y7IHUPIEyByR
 BWsGh/XCMHRK84BQFmzzREO9huDO5vMD03m5ysDjrY4Z8e1ioJRGDiaRTnsFhf+ljo/clKfjU
 DL7SmgMKRPS5tVwNKNkRW/mrs2xaJv3AywjLDxVlY8aQ4MKjk9RmPNz2HCd38R0MKK7XOUIoh
 3fvyjGJO9rHCCovK/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kp7uq0tAIA7IKONldeE9m8ry7pSbwhMhC
Content-Type: multipart/mixed; boundary="r6OYPZeoVgjAhQy6x5UivbqDn94OfTHxe"

--r6OYPZeoVgjAhQy6x5UivbqDn94OfTHxe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/19 =E4=B8=8B=E5=8D=885:39, David Sterba wrote:
> On Fri, Jun 19, 2020 at 09:59:46AM +0800, Qu Wenruo wrote:
>> This patch will add the following sysfs interface:
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rfer
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/excl
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_rfer
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_excl
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/lim_flags
>>  ^^^ Above are already in "btrfs qgroup show" command output ^^^
>>
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_data
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_pertrans
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_prealloc
>>
>> The last 3 rsv related members are not visible to users, but can be ve=
ry
>> useful to debug qgroup limit related bugs.
>>
>> Also, to avoid '/' used in <qgroup_id>, the seperator between qgroup
>> level and qgroup id is changed to '_'.
>>
>> The interface is not hidden behind 'debug' as I want this interface to=

>> be included into production build so we could have an easier life to
>> debug qgroup rsv related bugs.
>=20
> But why do you want to export it to sysfs at all?
>=20
There is an internal report where user is not that co-operative to do
more experiments, but insists on providing more debugging info.

And since they don't want to unset qgroup limit, nor unmount their root
fs to make sure the latest qgroup data rsv safenet catches leakage, the
last method to debug strange early EDQUOT is to export rsv info to user
space.

And, for most users, the new interface won't bother anyone, but when
things go wrong and the user is not cooperative, such interface can save
us a lot of time.

Thanks,
Qu


--r6OYPZeoVgjAhQy6x5UivbqDn94OfTHxe--

--kp7uq0tAIA7IKONldeE9m8ry7pSbwhMhC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7siuAACgkQwj2R86El
/qjQwAf+OtXWi8vmENhPVM0is/ehlHrEPDJy6ahzFKLRKGLI0yl6uh7wfBxFuxEl
1nn4OdUe3CCiiOL5YhdQY014VPM7y9LEA7sGck3HPgOI6+VsflsFhZOYkMmQEtWd
yb4t/zt4wxSL90rp+V3sIzdYJyoA2lruH9OqmPQqSGKFogHcEPqQHWOVDoYcjGfP
sIWTiimo/5hSzCf4In3ESOVfTTPaSdm8lRxP4ycT5F42gchvvNhNIrmIzCC4Hvxg
Lx6haXCisONLAeTPgDILvw+HVVSjQUa7ZsRzIDubYbthHoYtayZjqjFvAyiEHL49
PyW5k/filPy/zOrlH0TVhF+EjRXzfQ==
=PKDc
-----END PGP SIGNATURE-----

--kp7uq0tAIA7IKONldeE9m8ry7pSbwhMhC--
