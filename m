Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED2CB58D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfJDH7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:59:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:49251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDH7A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 03:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570175929;
        bh=nQYh9cZDrla0MSwQF0Xpc5eTtHqB9lNywQDrE5g/1k8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AGvfTJhTNShOvJCFzDjVclrz3Ipqe5GOKHEB1pb9ovjkt6y343D7O9usMb7mDvyIx
         CG0bclH7NphN3Z0A/CoxYO6pKREvfdVs9WGkXpV73oHY5hHN8Ff3EbzaeE982rMuZd
         BCPDr6V02pPdkCCrhK4u2rBlXjxJVa/ime3757xA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5GDv-1i6R2401en-01171s; Fri, 04
 Oct 2019 09:58:49 +0200
Subject: Re: BTRFS errors, and won't mount
To:     Patrick Dijkgraaf <bolderbast@duckstad.net>,
        linux-btrfs@vger.kernel.org
References: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
 <293de2b3-506a-0fcc-f692-0fc03012941c@gmx.com>
 <1a5483ba85372d02d898ae9650686e591f82a735.camel@duckstad.net>
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
Message-ID: <2566e0ac-2814-6427-c1f8-33fc3b566491@gmx.com>
Date:   Fri, 4 Oct 2019 15:58:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1a5483ba85372d02d898ae9650686e591f82a735.camel@duckstad.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S96Kmm9jvNEZNGCHygcjDy0bPx0bJXVlq"
X-Provags-ID: V03:K1:DEKfbmMcfsVYij8yMaJiTw1sQMsOZgCe/8yF7axHSHJLBdIBnTv
 1q+RRofjTEnThgNIl/oqHC7BriaG3GTBfauWv96NcaAaxvFRUBhKcqacaBUlw29RzAbq3id
 m6nupUtbxBHT9u7Er1ETbRzdpJjSndnq/rZmBRT+f+2bmBW9oMqXLtoHckS4ba8BJ/D9pzF
 UWaXENSzVhXIRKsO+Va+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LkIqhaoUosQ=:wM3A8a4kn4ZWxkaY8/GKEC
 ZYGRvMovRJFkbmA2iniXy9lQwfO1TpAATcB7JNY3pjRDt9Gci8L6B93tCCEZw22h57bVc/rQ+
 uq0KJ0wmEETfpW+N8JIAjcg4fpQVte6aZqwGt9VV3B6gZe+mGK6+SQqM/8fpdIIZj1FQuBH2Y
 GuRkTtF4d4Bg26Yixl6NrgCPktEee+GyBBmb+LYQXI04HE8xyKHTbvSEBe8U06OciwL1OLMHg
 TB8BSLzSh0+p4+RwKPSgTYxO0vXg0u92k8K4Q7vMsQo58OBBlwESnonc0htddxwNTZs7eqKcS
 DMNZeI9rvATV4Sh6AyAQJhpmWC7d22TIUJIfFazwE5jy47rpLplV7S9JLD+aTZYCmr36gGODb
 ev9zlQBMRGbnZZZl8RYR11YB6vCv1a4HmOCvWKvq84QRhxkWyFTmrWJVPjoEoMm0DdJFM3P+V
 HElbrLi96etHVPOZQv+R3RlY3UUfq0UCzbYZ63Pr1dBJvBp3VeDCYKtYTC8gpJE6AjnklDWrK
 hrzJTmQzJSIp9uYU4RzZCTdTBGnV02dAmsWAPgHezigBxwWIzEYbw3/fe51aqvibo4p2VepEL
 BD6vOL7irjASaObqEJBrQy/8PtuY+lxTtpUxPyxid3CIPZBVX8VKNBxX14KKiPVk6ouwfsMZ5
 37DXSwf1blt5Bm6oOtXHOhL+Y1iNSw14gPl8qLncdqvmyqq/7BrOGoOlag3DXEWIkfwbfFL+Y
 p4HPGvInd1X84lldzzfuTelpeNq299AmiSrSd7h79yy3Cjea8Mm1KlHfWgnf3N40q5rNf4y/T
 dpEQqIwn4E9zCzmq0+wc+d8uCXssVrl0fieyHUk8QOZf5RJcGVg3UyGswftdH/6OcxJtBWuJA
 SYAjP2nt2J8T/urVYJD2sfdSNenmgMuh4WYCYmPdDM3Vazoz3MGG2CtI8xJKz3gxYsYXk9gRY
 gu8jtfyua43iCFzihckGlS3q2v79IYZ0rnx8mc297ddqW4ycZ+sB24L6RxXv5MN0gHWwdNwuM
 KmBInstQeS7YFrZT7TGS9vgqfF1Aaa3R981oikG2YdVZCr7fYslmB/e/OxeLesFDj6rZYshPU
 /wdHaSPnaj2MG2OVJcIAo5ctGYHfvvmUOIK7D9lM71IVPuOulYkKFWDNPCUxI6XuYw0MbXgf4
 40JaX7gMb+D4kIs5jDVOwn0XI8pJvy0mlCP4tLCwKhc16Jbyn+YUO4w5Je+kAC3sVVBUNOwYN
 4a/9zkDr9fEvDujIe9iY55gE5yz5hAy/HkuXfvgXXnA9MQxNBXQ5VbZQFOW4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S96Kmm9jvNEZNGCHygcjDy0bPx0bJXVlq
Content-Type: multipart/mixed; boundary="5MN8GvoM6J2FF5AjOjVywnBhYZHKobz9x"

--5MN8GvoM6J2FF5AjOjVywnBhYZHKobz9x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/4 =E4=B8=8B=E5=8D=883:41, Patrick Dijkgraaf wrote:
> Hi Qu,
>=20
> I know about RAID5/6 risks, so I won't blame anyone but myself. I'm
> currenlty working on another solution, but I was not quite there yet...=

>=20
> mount -o ro /dev/sdh2 /mnt/data gives me:
>=20
> [Fri Oct  4 09:36:27 2019] BTRFS info (device sde2): disk space caching=

> is enabled
> [Fri Oct  4 09:36:27 2019] BTRFS info (device sde2): has skinny extents=

> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): parent transid
> verify failed on 5483020828672 wanted 470169 found 470108
> [Fri Oct  4 09:36:27 2019] btree_readpage_end_io_hook: 5 callbacks
> suppressed
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286352011705795888 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286318771218040112 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286363934109025584 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286229742125204784 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286353230849918256 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286246155688035632 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286321695890425136 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286384677254874416 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286386365024912688 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286284400752608560 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): failed to recover=

> balance: -5
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): open_ctree failed=

>=20
> Do you think there is any chance to recover?

This means it's the tailing part of root tree get corrupted.

You can comment out the btrfs_recover_balance() call in open_ctree() of
fs/btrfs/disk-io.c, then try mount RO again.

This means some of your subvolumes can't be read out.


Another way to salvage is try using backup roots.

You can get all backup roots bytenr by "btrfs ins dump-super -f".
E.g:

$ btrfs ins dump-super -f /dev/nvme/btrfs | grep backup_tree_root
                backup_tree_root:       5259264 gen: 5  level: 0
                backup_tree_root:       24641536        gen: 6  level: 0
                backup_tree_root:       26378240        gen: 7  level: 0
                backup_tree_root:       5341184 gen: 8  level: 0

Then pass the bytenr into "btrfs check --tree-root <bytenr>" to see
which one could process further.

Thanks,
Qu
>=20
> Thanks,
> Patrick.
>=20
>=20
> On Fri, 2019-10-04 at 15:22 +0800, Qu Wenruo wrote:
>> On 2019/10/4 =E4=B8=8B=E5=8D=882:59, Patrick Dijkgraaf wrote:
>>> Hi guys,
>>>
>>> During the night, I started getting the following errors and data
>>> was
>>> no longer accessible:
>>>
>>> [Fri Oct  4 08:04:26 2019] btree_readpage_end_io_hook: 2522
>>> callbacks
>>> suppressed
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 17686343003259060482 7808404996096
>>
>> Tree block at address 7808404996096 is completely broken.
>>
>> All the other messages with 7808404996096 shows btrfs is trying all
>> possible device combinations to rebuild that tree block, but
>> obviously
>> all failed.
>>
>> Not sure why the tree block is corrupted, but it's pretty possible
>> that
>> RAID5/6 write hole ruined your possibility to recover.
>>
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 254095834002432 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2574563607252646368 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 17873260189421384017 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 9965805624054187110 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 15108378087789580224 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 7914705769619568652 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 16752645757091223687 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 9617669583708276649 7808404996096
>>> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 3384408928046898608 7808404996096
>>
>> [...]
>>> Decided to reboot (for another reason) and tried to mount
>>> afterwards:
>>>
>>> [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): disk space
>>> caching
>>> is enabled
>>> [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): has skinny
>>> extents
>>> [Fri Oct  4 08:29:44 2019] BTRFS error (device sde2): parent
>>> transid
>>> verify failed on 5483020828672 wanted 470169 found 470108
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286352011705795888 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286318771218040112 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286363934109025584 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286229742125204784 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286353230849918256 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286246155688035632 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286321695890425136 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286384677254874416 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286386365024912688 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
>>> block
>>> start 2286284400752608560 5483020828672
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): failed to
>>> recover
>>> balance: -5
>>> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): open_ctree
>>> failed
>>
>> You're lucky, as the problem is from balance recovery, thus you may
>> have
>> a chance to mount the RO.
>> As your fs can progress to btrfs_recover_relocation(), most essential
>> trees should be OK, thus you have a chance to mount it RO.
>>
>>> The FS info is shown below. It is a RAID6.
>>>
>>> Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
>>> 	Total devices 16 FS bytes used 36.73TiB
>>
>> You won't want to salvage data from a near 40T fs...
>>
>>> 	devid    1 size 7.28TiB used 2.66TiB path /dev/sde2
>>> 	devid    2 size 3.64TiB used 2.66TiB path /dev/sdf2
>>> 	devid    3 size 3.64TiB used 2.66TiB path /dev/sdg2
>>> 	devid    4 size 7.28TiB used 2.66TiB path /dev/sdh2
>>> 	devid    5 size 3.64TiB used 2.66TiB path /dev/sdi2
>>> 	devid    6 size 7.28TiB used 2.66TiB path /dev/sdj2
>>> 	devid    7 size 3.64TiB used 2.66TiB path /dev/sdk2
>>> 	devid    8 size 3.64TiB used 2.66TiB path /dev/sdl2
>>> 	devid    9 size 7.28TiB used 2.66TiB path /dev/sdm2
>>> 	devid   10 size 3.64TiB used 2.66TiB path /dev/sdn2
>>> 	devid   11 size 7.28TiB used 2.66TiB path /dev/sdo2
>>> 	devid   12 size 3.64TiB used 2.66TiB path /dev/sdp2
>>> 	devid   13 size 7.28TiB used 2.66TiB path /dev/sdq2
>>> 	devid   14 size 7.28TiB used 2.66TiB path /dev/sdr2
>>> 	devid   15 size 3.64TiB used 2.66TiB path /dev/sds2
>>> 	devid   16 size 3.64TiB used 2.66TiB path /dev/sdt2
>>
>> And you won't want to use RAID6 if you're expecting RAID6 to tolerant
>> 2
>> disks malfunction.
>>
>> As btrfs RAID5/6 has write-hole problem, any unexpected power loss or
>> disk error could reduce the error tolerance step by step, if you're
>> not
>> running scrub regularly.
>>
>>> The initial error refers to sdw, so possibly something happened
>>> that
>>> caused one or more disks in the external cabinet to disappear and
>>> reappear.
>>>
>>> Kernel is 4.18.16-arch1-1-ARCH. Very hesitant to upgrade it,
>>> because
>>> previously I had to downgrade the kernel to get the volume mounted
>>> again.
>>>
>>> Question: I know that running checks on BTRFS can be dangerous,
>>> what
>>> can you recommend me doing to get the volume back online?
>>
>> "btrfs check" is not dangerous at all. In fact it's pretty safe and
>> it's
>> the main tool we use to expose any problem.
>>
>> It's "btrfs check --repair" dangerous, but way less dangerous in
>> recent
>> years. (although in your case, --repair is completely unrelated and
>> won't help at all)
>>
>> "btrfs check" output from latest btrfs-progs would help.
>>
>> Thanks,
>> Qu
>=20
>=20
>=20


--5MN8GvoM6J2FF5AjOjVywnBhYZHKobz9x--

--S96Kmm9jvNEZNGCHygcjDy0bPx0bJXVlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2W+7UACgkQwj2R86El
/qgbIAf+PSjpcVNx/TZ1eYH7nJLHvNrFcwElPBSw+mMC3JDinxNuYt0IDiwp8Xdy
mBd2GOMuMFujGfeW7ZuhzDVnojuIwzkojmG+aFfZ69FkMetZ6nVwN2uBpS3iA1ev
KXWg9lQdoguAETHsBxFswjDhOMn+XxEXhZKxoNlCAiPUFElZjeFhqp8/tVV7+E7W
9j7z1wVaOuaQRkJZoNexBnY/GAycqGEKG97e66V6f1UW3MhLgMOZwWlI8V/zL6HS
IqpeTeN6ixMykbbrYxCDXWfNK/Ve+lhqLmWOpQ6oqHU1TSZzI7QV9K4hWavM//Kf
LHDMdV1FzRx6KNe6tCVvhU55v8O4nA==
=vL7U
-----END PGP SIGNATURE-----

--S96Kmm9jvNEZNGCHygcjDy0bPx0bJXVlq--
