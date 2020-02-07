Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B915500C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 02:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGBj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 20:39:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:52245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgBGBj3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 20:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581039563;
        bh=+lVpM8B7PRL2UHiTeMRyrYhDLck/zCRAmirGaeatvhA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AVRi0oBcU6/0Wt60b67mcPxAus7+70R7nLhMNUXxv+3MCb80jteqVsCj4dQHJes0m
         35Da9OkZKv4NBZ0jRorMFTns0piSIDBi/6YZpvg7xI/yl2ZMDxJ+yCu1tSTlQvWf4/
         ls+jW4ZldbVM81xzgtVSzrHl3+7Gix5pQ6zXK1R8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUmD-1ioYU90r1T-00D2ig; Fri, 07
 Feb 2020 02:39:22 +0100
Subject: Re: [PATCH] fstests: btrfs/022: Disable snapshot ioctl in fsstress
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20200206053226.23624-1-wqu@suse.com>
 <e3c530b6-af9d-97de-7008-5bc02c77e037@toxicpanda.com>
 <8199544d-c5cb-eb1e-ed7c-f9b170324997@suse.com>
 <7da58abd-eb5e-0a7f-f3bf-205f1daf95cd@toxicpanda.com>
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
Message-ID: <bc0a2e79-bad6-9fab-045e-80c995f017fc@gmx.com>
Date:   Fri, 7 Feb 2020 09:39:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <7da58abd-eb5e-0a7f-f3bf-205f1daf95cd@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VtdIsolkwmxTG95N9TqW9emNiSAc558X7"
X-Provags-ID: V03:K1:HRtCAAHu5TBWxIoQaUrUQFzfOA1+VbmhueGOjk+uMubsGcbFBaF
 V1FVNGI5vod93Eu+fXnEy++t2NYQbUZn3zBTpHjAvgzWdO208SWlNly1eWWJ7KIdWQum0iI
 ZTKZAfTM+yglirogLbh5LBAfuukFZZpPTzz1kT9TLuoXePoe+JJqgY6MD9NVHSsPQ1aKqRH
 xwqZpMGBDfF6HwBqT0eHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TH3NSVF9zlw=:2YN0w6f5oLQU1/0lOqgv6U
 c7+rBqttGOJa2PTf1Ctd/kqSxgVVJAhp6jFfij9mNQKuMvgkspuWRkTugVUPIJkiIa6KF1gtz
 L4gX/579guA+YBsnYSInutXCe3xZvdcF91l3sWWS4cqAIziy9HcxsciGNTNjtqG5VjfhdgY6K
 xvTbsnNTzwBrhLXYUEBCQgc2+Il5s6iB/dv6uqpSe84iQQP+51KZZpG6JeU9TAVyoCVitvmpD
 +TkekPvCh8WUK90jTzyAjP9aHW4ZtfKsQHdYaUz076z157fCKxqy9igYv1vHcbYzQ13fdUe0g
 SO9ARM5mmvzLUiyTw8ETzgh0wpV3kAxpxwyCWmT5eZwa36jm2znMm56SmBnpUwX4+5T3N2AXO
 KBqtxV+/LDU7+GPF6BPLzqmc5ihS+zlmQ8c7V70zdcc2fwpk8uekMZ733OCIPrUNiOgDVe6IU
 yEIbqGuAfAZLax7MKKbKc8gvk7YSTnyR/5FHp3mVeNk/9yWrgL0DAB9jBoBr9DNJmLEp8O8nM
 zokeA5xG9pv91gDPYErrZCxfz+eOzgSFwPyH0SmymC9u7MmvDmUH3WpBlqw+cpCMj9K5MqAEt
 fcnvWfDBmbP+PBesotQwEMxFdLlR2SI5fJx1/vYLeBwDp46C79wNyatNp6yhClYAHIx3TvrSI
 t9PIbYN8u/XhIvTd2GKDkFkjMxnuu6eH4hujHIO5ukTBiV1THbP+1yt/K54nhlbO+oJZVNchI
 N4uIfQ3yQjHNILHUtY6Xl3DXdOLBJBv8lLJl88QKvNkbt/CAVZ9gyImeMbUi0ePpF3GkoU/KX
 ofAUPW4P8431WWme0K2b2rKsQ1FJofRw/LEZsrg9b5Qb7m9UBJKSrZaojvv08IR8wqEb3mrJy
 8q4V7cG+Ef30SXarEZlI3gMF9LeJK4muIfZCXH56WTvJ2qfzVe2yaePm7y6pS8E86kWd566Ob
 VVglM7UGiWcmW1+C7c5fSv3I48ErezHon6u/QM7AuV5rn/9SfBAdYsymnJvuOBCXXr3+pumBo
 +A9vGp0hamcPHI9C883ywG7QIecM5lDfdio6Z6TVgjNAoub9Q01onhUmaoPjEp7hIsuUK+QXP
 Wkin8GsIw+RJ+WFGDgkW6KFr+eUE/TC8WXK/yjkmYn73Y/55qDBPoYVv10MgwBg+gndMxJerz
 Hn29HghJHVhedp9xg1S76pQURlAbwTHSiPMzKOm6n40LOfk8u3wJSaMFVURIsYX3LEiAHX3ge
 +xp5u+yWTCDvtfOsc
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VtdIsolkwmxTG95N9TqW9emNiSAc558X7
Content-Type: multipart/mixed; boundary="FU5qqwfSjTLb20pc7sc23xndE5bSx05LF"

--FU5qqwfSjTLb20pc7sc23xndE5bSx05LF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/7 =E4=B8=8A=E5=8D=888:38, Josef Bacik wrote:
> On 2/6/20 7:35 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/6 =E4=B8=8B=E5=8D=8811:47, Josef Bacik wrote:
>>> On 2/6/20 12:32 AM, Qu Wenruo wrote:
>>>> Since commit fd0830929573 ("fsstress: add the ability to create
>>>> snapshots") adds the ability for fsstress to create/delete snapshot =
and
>>>> subvolume, test case btrfs/022 fails as _btrfs_get_subvolid can't
>>>> handle multiple subvolumes under the same path.
>>>>
>>>> So manually disable snapshot/subvolume creation and deletion ioctl i=
n
>>>> this
>>>> test case. Other qgroup test cases aren't affected.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Why not just fix _btrfs_get_subvolid?=C2=A0 You can use egrep to make=
 sure
>>> the name matches exactly.=C2=A0 Thanks,
>>
>> Because we have other requirement, like limit tests.
>>
>> If we have other snapshots/subvolumes, they don't have the same limit,=

>> thus unable to test qgroup properly.
>>
>=20
> That's fair, but we should also fix _btrfs_get_subvolid since we know i=
t
> doesn't work in this case.=C2=A0 Thanks,

My bad. It's not the limit test, it doesn't utilize fsstress at all.

It's completely the bad greping for qgroup ids.

We could have the following subvolume layouts in btrfs qgroup show output=
:
subvol a id=3D256
subvol b id=3D306
qgroupid         rfer         excl
--------         ----         ----
0/5             16384        16384
0/256        13914112        16384
=2E..
0/263         3080192      2306048 << 306 matches here first
=2E..
0/306        13914112        16384 << Then match here

Although disabling snapshot/subvolume creation solves the problem since
there will be no other subvolumes to start with, we're still not that saf=
e.

The root fix is to grep qgroupid by "0/$subvolid", not just $subvolid.

I'll do a proer fix, and keep the snapshot/subvolume creation to take
advantage of your enhanced fsstress.

Thanks,
Qu
>=20
> Josef


--FU5qqwfSjTLb20pc7sc23xndE5bSx05LF--

--VtdIsolkwmxTG95N9TqW9emNiSAc558X7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl48v8YACgkQwj2R86El
/qiDsgf9HH+VnJJArRaC0r4y9QG9U5spp1sKInvrNNup9ctsi8u6gUbpVTvBwX4y
Fmy0o4BfseZQ1s7O1HU3ui2Fp1TU6wwHhPSSSHFdFn1FVsQnfuNZIlk0Um04aK9+
0pwFOSdgod5kr9z1uGssdFpbaYogNGSMBd8PJcCGVzi3WFLF9vM6Y1UrwnhkhTAZ
OALLUwm9Ss7CaOyDnDF5fTYNIcpGu5MiUyUMutFyMj/PlDyTfaerhEVyNXh15iRo
0zuv7ft/0rQiwqm0c3DFYJb0AESZ6S4KLXV7SrCgktTudt0ezokc2UR8rO7D+HGl
Q5DQPSmkKET/9yU54yj51dHNTi2A1Q==
=MgjM
-----END PGP SIGNATURE-----

--VtdIsolkwmxTG95N9TqW9emNiSAc558X7--
