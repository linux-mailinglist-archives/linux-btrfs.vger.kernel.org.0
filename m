Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4466B140C3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgAQOQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:16:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:35347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQOQ6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579270612;
        bh=RfEFk393DWtTYSvhMSiUhRJcH23rsQpXQpTR1MZ+THI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UUyljtspAhuXOPKo+ac/Ahy7YQpGHsQj/6VtKRO78ijXhNqYP4+qibGduDMlpE2iZ
         5M8Rk+r5Gxxhknc1Y1Jjmyb1Zq22z1hhLeSMUNksU4uJDbOQN9+/KZ3hBbuvTIoHQ9
         zTUnqhI48eTvgHtp7/DPTbQd3+Je6mFtOWXWR33c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5G9n-1jb6u60s4L-011BBL; Fri, 17
 Jan 2020 15:16:52 +0100
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
 <20200117140231.GF3929@twin.jikos.cz>
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
Message-ID: <f1f1a2ab-ed09-d841-6a93-a44a8fb2312f@gmx.com>
Date:   Fri, 17 Jan 2020 22:16:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117140231.GF3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="caRxM8DIUeUg6XbpE5sc8CgJOWJc8kAyC"
X-Provags-ID: V03:K1:zG+X98WTCw+JM9Fu1Csur7tEoSZFdp+05Nx9jkCh9UrHB7eNGOP
 UysSi6Jz+RPapdHWL9MVilVmsb6sTmlisf4PX9tvUrwCfM+bQLN4PvnMrWhxTDFEd0bdiLv
 BQm+F9YTw0p/CAFHuPIdlU8/yBcWfg4A0PGkKDWDt+XEusdXOE4cgpMe4FPghUmXHGn29HN
 OuqZX+ObXu26F5/NBl3ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eT6k4Pyu3BQ=:CKUIS6xepHnicQyjYomWcg
 Zlx67fpcDfHF/zEan/KlAgS+i0udDY+LQfNMqwnXOwM59CWp+zQzRzEV9ha3LNKR4uBV393TC
 jq8nCWfGtyTxTld2ER1gk2VUDmjBNlTjpcc4Np1x+WXMpbByQBoL/zP/mqG5XWprWWzrM4biy
 OEiccxIMQJd3NV+NbEZ5WrvasaoNhffi4aEs8KgAAWtERU9mq5lEOk/zK4MPECcUqm1nGrOwC
 E2VhSEQC8GPXlZseALEfsuozIcXyjnS6JR04MiM8XDJ9mesgZJquEEw+SKj6Mwfi5IlQBIFV0
 0LPVk37m8ADh6rezGM/lekJ/oh1anQpqhH2WxIM8YAHoLYviaHXEIdRGrFtpCoCyW82AL9isX
 hNc4rJ8eppb4+0XbhgsBT5azGlmoPk9IOk/vBp3aGjFMkcnDVUXFl2CfooXxEq89n98TrOb7r
 xSTeKI8whmNBt+evc4TI0WpC/MDG0rvtTq6nOkHb4piSw0FwUKezyNvcVndrF8fiaJbHRyzzZ
 FEJSePrzIj3eg1LzHmEXNOUqIVLMr0h6onJlI/clqrpBpVCPWx8OgNblLVGCuj9cA9VDg4AvW
 SCn4PeweY15CQcT2m1hFzN2ihnz8pBeOqLbi8wxfIm1JAZZFf+0n6ej2HWtpFu/TDICHVKzoo
 3U+i4DjYtVBOa6wEdBs/UvkryWo6VnGBMzsFZboHQnnkcTM91+QcE+1tYXGsyN/8n75Tygbpa
 DMb7DA7gidmyGJ+HsWL75mwgD0IhAatS05Khj9o8PvaNpV5GTBTlQSKhzf/VwWJpXMsMgNKz2
 dsmUQRILRxJKS0h6kkCcK2/NNRu+hU5lbNJml6Z6bZ/PdVDxRSdC1BuZKGa5q4Inn6R9MB3ni
 vvK6WbGRvF1X1zJ6vgrIlfBuBjzRahZ49Q8AFK1Ea72oACD+vg22uD1uqgUz+3wthf8H4KfSy
 88I2SEmygHAq5uM5JpX1o0ZAUDX7iW4Sy4qKDdANXgJXhInx+OPQvD+V4vAWSyO+p1a8YmChx
 N/VhfvwGRFDebOeg2ngliItaKOIOhzsA2AlXJ/0zFvsdM0NVedOq7uU7E+326JTCvMVbJte0X
 7BJqoDVCDqS1zz+++A46kNENcjpxKVDWDw5g6u/VPtscLOtQKKNxqVkstRM7HflTP41Hi3LPn
 1LOnWhqabuT3GmmLgwuqV32SzOqIq5u6MPeL3MiYMRO7CNw+MDmG0TcMRraoxo/W+V52oXA8V
 TOL86cPQn/Qbs+raTXhuFGdz9DqTKvJ8gMc9OUFpAYoTz5dJPbkp+J1iNetU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--caRxM8DIUeUg6XbpE5sc8CgJOWJc8kAyC
Content-Type: multipart/mixed; boundary="DbteeyMVNnyJpbjj8SvsToeTO1mJMvgT6"

--DbteeyMVNnyJpbjj8SvsToeTO1mJMvgT6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/17 =E4=B8=8B=E5=8D=8810:02, David Sterba wrote:
> On Fri, Jan 17, 2020 at 08:54:35AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/1/16 =E4=B8=8B=E5=8D=8810:29, David Sterba wrote:
>>> On Wed, Jan 15, 2020 at 11:41:28AM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> When there are a lot of metadata space reserved, e.g. after balancin=
g a
>>>> data block with many extents, vanilla df would report 0 available sp=
ace.
>>>>
>>>> [CAUSE]
>>>> btrfs_statfs() would report 0 available space if its metadata space =
is
>>>> exhausted.
>>>> And the calculation is based on currently reserved space vs on-disk
>>>> available space, with a small headroom as buffer.
>>>> When there is not enough headroom, btrfs_statfs() will report 0
>>>> available space.
>>>>
>>>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
>>>> reservations if we have pending tickets"), we allow btrfs to over co=
mmit
>>>> metadata space, as long as we have enough space to allocate new meta=
data
>>>> chunks.
>>>>
>>>> This makes old calculation unreliable and report false 0 available s=
pace.
>>>>
>>>> [FIX]
>>>> Don't do such naive check anymore for btrfs_statfs().
>>>> Also remove the comment about "0 available space when metadata is
>>>> exhausted".
>>>
>>> This is intentional and was added to prevent a situation where 'df'
>>> reports available space but exhausted metadata don't allow to create =
new
>>> inode.
>>
>> But this behavior itself is not accurate.
>>
>> We have global reservation, which is normally always larger than the
>> immediate number 4M.
>=20
> The global block reserve is subtracted from the metadata accounted from=

> the block groups. And after that, if there's only little space left, th=
e
> check triggers. Because at this point any new metadata reservation
> cannot be satisfied from the remaining space, yet there's >0 reported.

OK, then we need to do over-commit calculation here, and do the 4M
calculation.

The quick solution I can think of would go back to Josef's solution by
exporting can_overcommit() to do the calculation.


But my biggest problem is, do we really need to do all these hassle?
My argument is, other fs like ext4/xfs still has their inode number
limits, and they don't report 0 avail when  that get exhausted.
(Although statfs() has such report mechanism for them though).

If it's a different source making us unable to write data, I believe it
should be reported in different way.

Thanks,
Qu

>=20
>> So that check will never really be triggered.
>>
>> Thus invalidating most of your argument.
>=20
> Please read the current comment and code in statfs again.
>=20


--DbteeyMVNnyJpbjj8SvsToeTO1mJMvgT6--

--caRxM8DIUeUg6XbpE5sc8CgJOWJc8kAyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4hwc0ACgkQwj2R86El
/qh1WQf/W1qbpOv4ljDfaocoQBC1TsLvHQP//X51hFDHq3FriVxPSx2prIKOJ+QS
uvN/E80APPSxi66ImBOowLahSOrvNKZDiI151DOrtryHBZ93Jt6fNCZDm9C0M/fb
asCGu1sr/iNkFKl3BUbufcuEeROaPHD8X/eTq2t5z5lHWO0aVsN5d9vH+mShhi69
dhiYkrf9hKi0H0n1/6tmRXCXn0ga7kwEDvz4ix4KSnRgFgyQhTwshR+aFt1YpNLX
UFNwYCccb98ms1KcStzzl/dSO0P8AVh205KeEn94mIIte0TtSaGgVrDUe9Ffa2DC
IjF+jq5JuK6noJLG/JJl/osTqwiCdw==
=ascQ
-----END PGP SIGNATURE-----

--caRxM8DIUeUg6XbpE5sc8CgJOWJc8kAyC--
