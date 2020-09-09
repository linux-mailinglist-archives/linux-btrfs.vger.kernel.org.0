Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8801626287B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 09:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIIHZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 03:25:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:43125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIHZm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 03:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599636337;
        bh=y2vEF6d/rGF/E/hoj6oo4awLIqZm8ahaXq36K9tOY7s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M6ULKmQeonz2Ybqqc4H3a5zOZ3h7baU5JBrwcvQuXLKJo1lsVXTMLrsu2k2+yDRgB
         ozfRc8CGsBklntOHDpCnbcqKXzQ0tIvwoXCB4QF2gDVkVdI4tZbJUIIyV/pochghQz
         h0sOl9ztRa+jVLhgkl/9E0GWeHdGimgEWG55GdSk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1kVFVo16Vs-00tEyX; Wed, 09
 Sep 2020 09:25:36 +0200
Subject: Re: [PATCH] btrfs: introduce rescue=all
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <921662f28b90d7e5a67bb52a1e0b0b2e9584f946.1599579772.git.josef@toxicpanda.com>
 <b862077c-0903-b4f0-ccc9-ee1c815534bc@gmx.com>
 <20200909072002.GD18399@twin.jikos.cz>
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
Message-ID: <3dce83b1-bf02-e119-a549-20f6fd36643d@gmx.com>
Date:   Wed, 9 Sep 2020 15:25:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909072002.GD18399@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WM80JN76p2MNXNOhgyF04HpVSMrnlC37f"
X-Provags-ID: V03:K1:30WCkUYdIruBYyc8ZVq0KT2C7Vrpdt2guqWAcq4V6er4rhx3/jc
 n5PPA8TKDQZ2EFgoFt6t24e0Sj7oVgXDK8AUtbNO+NH4oLT2ydIr6kg0w5rywNNIkaUAfbS
 MCqTlvw12hBKxHsegKtC6HaumjTF1kySRsO7U8R+enligq9mQmepcDCkZMWX1q5DU9+XW0Z
 FVXFM8FhL3eb2nEOUNklA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MAl5SRrwJkM=:Yr5F5stTVm3/H3e7QK5O3b
 ihn1gOFMIEURUnhLYbqyWGvACqeVJRY4SZSqyiQA3AgnGe7nQvb9UxH7T8p+3GKXFMwETZAmm
 AKh4EWseFgY0PaT+bJfaHiRjsiuWZFChHaesTV3t7nWi9aw5aNiHPGNcK1SheLZsp/JbOUC49
 aGAtBdpnHLNZgPM+FlczJBld2IC+yLAlyn66Lv5RMMSyvSURTw/fnHMBN2UTJSM+LvpkuJGMF
 h1/3tO50PiKy250xRQbEhkpbrrh7eVoBtba6NcodDch8d+riy6wxAQVIYDV4en/Kr1+2F7WMb
 gIPOuKWL5IT6mZQK7IK+o7NoEAnwFMF/WQfQ0vMXJWcSDV4cQ/3RdLsnU6eUNezPNuFxGCzhf
 RoUiwNm6+iC9+nq9/i4Z0Y7ZpZW2S6Llbna/XBDaWgtzfYIxDc2oHWDiG0iPhFsKcVkCVbcVK
 NMXb6T1eWHhndeGm8cOHougE35sEVsyihJQgDNPDuQbBMvsBUS4TcAKK14Mt29Ji0PyKG8FoW
 4HrQWry54hmIBoBLSyNELoLmHsa1Uu8QUPYpzLBpTBn7HVRGjQvyyeCDfGPDoIjoSzwTO6+yW
 MCgpCG3hV58cDUajINi+ZOqM0W+NBeTyXYZGpRuPJ3mjZ7tfc7OdLaK9NxphH4iPTVorEOahF
 PZe2IITZL6qR2l6KrqHWYYm9JjWH+qyiYl2/h+EqL5VbeJ6jz25ZTHuD2Pe2ZCqdtEHkQK2MV
 ja92HIN159X5n4oocnCqO4/K1RiH4MBqCXDQTnJ9NjK8ghxu1RRym4lM9T+V9OG7uMA3tBAvE
 Oz7uo98gNv0WsmZZ6eLhvF/nO8jnO1rvKyhEz0LoKL1XTBllyvLClKYD5iVZOdqXi6rWBRm0/
 /sOg5+V+36rN210p2n7re+WTLxgv892OLBPH5211prky47cAgDXzOLsPO3G1bSKfMxJgsfM3Z
 vt1VJdldN2Jbqq5qnE2Vf9anMWmrM3OYkRsfNWMM4kLoeacM1GPtcPyDObNTbutYp2OOKdcST
 zR4bfN4bYc+Jr/Lt+/rzIBheVro2u3JHdK/pr5hqqVq5qWzTuz03rYKxfQc+VPmOibhCQsiOw
 HHqzCctwNFkZwc4SDfo7ZFUyfLSOObmdSSACN86fg1BFDFiTSB7I5E/nOL2DTub3+Mbymi7/j
 +t7PEvouIHAGy9EckcDh22uulqM6jYS9xcSzvosD7awBT0f125DjYLnn9Hp4+tInm7dL1Mywk
 MuLnbwK8bGlXZeVuI4qbUt50OF5kt0A/LZLyfBg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WM80JN76p2MNXNOhgyF04HpVSMrnlC37f
Content-Type: multipart/mixed; boundary="rOiAdO9wXYXCPN4PiAMiGPlG9vgrfXqEw"

--rOiAdO9wXYXCPN4PiAMiGPlG9vgrfXqEw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/9 =E4=B8=8B=E5=8D=883:20, David Sterba wrote:
> On Wed, Sep 09, 2020 at 07:10:49AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/9/8 =E4=B8=8B=E5=8D=8811:43, Josef Bacik wrote:
>>> One of the things that came up consistently in talking with Fedora ab=
out
>>> switching to btrfs as default is that btrfs is particularly vulnerabl=
e
>>> to metadata corruption.  If any of the core global roots are corrupte=
d,
>>> the fs is unmountable and fsck can't usually do anything for you with=
out
>>> some special options.
>>>
>>> What we really want is a simple mount option we can tell all users to=

>>> try if things are really wrong that are going to give them the highes=
t
>>> chance of allowing them to mount their file system and copy off their=

>>> data in the most direct way possible.
>>
>> Then "all" doesn't look correct for such usage.
>> I'd prefer "salvage" then.
>=20
> Let's focus on the functionality for now.
>=20
Then the code looks OK to me on the functionality part.

Maybe missing my sob line for the initial fill_dummy_bg() code...

Thanks,
Qu


--rOiAdO9wXYXCPN4PiAMiGPlG9vgrfXqEw--

--WM80JN76p2MNXNOhgyF04HpVSMrnlC37f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9Yg2oACgkQwj2R86El
/qgCZAf9EmiPoegybD/S/xJ9tP8kl9h0SkNPtPDzatE6w0B8/jzk5Iefwv1tLoJS
nSKHdeua4w1Tnf/VSrmo7qgWKCVf+n4HSObcXfA5jDWSDe/XimnOYoGXf1PGsYDa
uQbua6xxPaCfszdhV7Ct86pmae5jOkPpxLRtJn6RGk50t4FfK5DVQovsPHsIiJeP
EnR/ZtKDZjMpKSSc68FU5UlBAdKIKnKBt36XO0IZ/ugrN3lXx5GVEddDQ3+WjE7X
0yGQcwtKHON4MX4ctIlrMByBv2/kcOEyOjgNnSY7nF604dK+0nxel/Vy2VDBrEzM
p6Z1+PYOjN9M3N5If6PQhp66eZBu9A==
=FO5G
-----END PGP SIGNATURE-----

--WM80JN76p2MNXNOhgyF04HpVSMrnlC37f--
