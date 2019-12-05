Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CFC113A57
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 04:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfLED0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 22:26:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:37269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbfLED0j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 22:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575516387;
        bh=62w2zF6h6VefZJkTnxLpNB4hf+UEOVNJwgeWJT4SOxs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XX2TXfZTs+S7UifGNoIzJcRuMMw99QRxRKsGFYT8OH9UsOsF1zcZtBWeq8uSHQP2u
         guOfmoJy6+9yvV0MWlvPymHnwlfdkELg2OgtZsZiA/iZ32LaSCtupBjeuWemUTIFlK
         qLaw/v96f+0YejHKxH/Yfv52jAv+R+opZuOuw+WQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTABZ-1iBvYb3wJ5-00UaYf; Thu, 05
 Dec 2019 04:26:27 +0100
Subject: Re: [PATCH 0/4] btrfs: Make balance cancelling response faster
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20191203064254.22683-1-wqu@suse.com>
 <20191205025832.GY22121@hungrycats.org>
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
Message-ID: <99b2e889-df1d-7302-6076-42c643221a27@gmx.com>
Date:   Thu, 5 Dec 2019 11:26:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205025832.GY22121@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9M8ypIQPVR8rwW3fRamQcM1wfPgNqtRgp"
X-Provags-ID: V03:K1:2ezTKV/WYKf0G01ACH5QNyINSaxTr7EPV4knda2ijk1FOtWYkST
 IIGjrKnOqXNxEvc+yZAsulKS2NdfJG68gWfHoG2uGcDPFkdNKQcBpp8XAxdkfR8OuzvSnh5
 MYXlwNV/igd8qHUn1V3iZ2NiK4gVq61/5hp8I9thzFSc2cN7WeWdGn2abwFOldsavXg/vq1
 KH9WksjHncFcx/MZRDSYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nicBBlzdwCM=:fYVd1CnfBtZbQ+A8t5BohZ
 t2zXwpgCHjdbacx1ht8C1xFa7HDrDtg36QqHShoVWAXuux5BWwcgJD/T2Dey4cPc1r699i+9b
 4fZYiD8Nw7TbsJi7DUGesq1ffOzL+TcF1z+YHSCCC051bwffLxcaTZC6LhMLsfQ+WvohbzqvY
 0YuN6sqokSEAak0dKRAFGx63lWHHUs2p/M8n4xh4o/7IqMNpPYCZ1C63WDWDadPgRtDGa/rTg
 JPCsCaZxEJJEk/VYfLjujU0qSncryX/vjxY3YqO7HmtaVU6uWWKsCvcQKB+xbOzFcwrgNh/5o
 CtpKqUCuXYcJWZ16mr1dMq3JC5PvhfPcrPggeD4GVQbsu41W+sB4YWHKjSCM/iaDLNQ0TJonf
 5ZYlPYb8b5kjDIZl/szWxN14WrWVVCr3g3iZa2eTkPqGzcuc9B22qTOgYxoq451HAHx1PM47H
 xQkTbKrzNMFyvsfXt4ACb6fX1sBN9nWuaz7+JI7Lz/LoqOyp+0AzY6sV/aPHj/qBuuF4pPjNP
 lIZjtpLC+KU0NvfIy9EOYd1/uMChsQGrwF6D28wVbN3LQ+pp18cQStAGOtTuh9iTq/fPRNCRc
 VvEWLWzsjTcgcLH2p76T14YziOmcjcl3GqJPvgOm1BxEpj8NnLkPBZlgpNldV5u9o9NSi/L8u
 +6n+hW8T/PrinqxvgY10ahTcxzMSBSe5K4pEL/7g1WRY3jftaSOzqF3Y/eVmBa5yc4Bt11m1L
 4Ap2BuRm60VY1r+6CWuUzxgP0JWysbmE36aNEb1eXwcMpP2ovBQuUjsk3XOwrzs+V2kWH+AWe
 jLpVg1jcZm3Nd5X3veqPRwBXUp3r2uDfzVuvYSFwRQn1DSCZhGwG1KPBG8ZdTu2ZAvN4Lzss2
 3ghKQRRc3yUYOXHsq+UuWJFsuoQYhrl3N38GzOq6Fc3KOILpa9VFsC5KAtkK9SIIbNCczk1Xe
 QsqPH7ZkcOpH5cRhx3tNX2DvmDzAIE46kDULVPbxUMNnzSv/WaAqaMut+iKMq7Y6CnuPdAKjh
 ZCFAYZihOBLkref+Hs0uiA0QLGrCm8FoeKAz7f9OubKcpkSvNcn5gjBTC0VF0SOVaYYdcvFuA
 ZgSESdyP5vfeJDfzsYvJIa4jPNqcbeXRJCccgByHcK3o3RDLyYnso+8ZCy+PRtrr7gYkI+vr0
 xbsUpmp9BT6hy2s6ND3RhTVG4Pg6WCIQ5FlEwHj4bg64XWbZ4tBcqyxdZEt9TkAQP/iQJpNzR
 MxHs0PjLGBDs2CXmiYutYXLDqDAkbnwRJZ2WQorG0wYmkghwhk6ko5c640zo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9M8ypIQPVR8rwW3fRamQcM1wfPgNqtRgp
Content-Type: multipart/mixed; boundary="hOSRsj9JK9XO312uHDqhDflJbCgAvb3fF"

--hOSRsj9JK9XO312uHDqhDflJbCgAvb3fF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8A=E5=8D=8810:58, Zygo Blaxell wrote:
> On Tue, Dec 03, 2019 at 02:42:50PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> There are quite some users reporting that 'btrfs balance cancel' slow =
to
>> cancel current running balance, or even doesn't work for certain dead
>> balance loop.
>>
>> With the following script showing how long it takes to fully stop a
>> balance:
>>   #!/bin/bash
>>   dev=3D/dev/test/test
>>   mnt=3D/mnt/btrfs
>>
>>   umount $mnt &> /dev/null
>>   umount $dev &> /dev/null
>>
>>   mkfs.btrfs -f $dev
>>   mount $dev -o nospace_cache $mnt
>>
>>   dd if=3D/dev/zero bs=3D1M of=3D$mnt/large &
>>   dd_pid=3D$!
>>
>>   sleep 3
>>   kill -KILL $dd_pid
>>   sync
>>
>>   btrfs balance start --bg --full $mnt &
>>   sleep 1
>>
>>   echo "cancel request" >> /dev/kmsg
>>   time btrfs balance cancel $mnt
>>   umount $mnt
>>
>> It takes around 7~10s to cancel the running balance in my test
>> environment.
>>
>> [CAUSE]
>> Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel=

>> request are queued.
>> However that cancelling request is only checked after relocating a blo=
ck
>> group.
>>
>> That behavior is far from optimal to provide a faster cancelling.
>>
>> [FIX]
>> This patchset will add more cancelling check points, to make cancellin=
g
>> faster.
>=20
> Nice!  I look forward to using this in the future!
>=20
> Does this cover device delete/resize as well?

Shrink also takes use of balance, so I see no reason why it won't work
on such use cases.

>  I think there needs to be
> a check added for fatal signals for those to work, as they don't respon=
d
> to balance cancel.

That's a good extra idea.

Since we have that wrapper, it would be easier to add in the future.

Thanks,
Qu

>=20
>> And also, introduce a new error injection points to cover these newly
>> introduced and future check points.
>>
>> Qu Wenruo (4):
>>   btrfs: relocation: Introduce error injection points for cancelling
>>     balance
>>   btrfs: relocation: Check cancel request after each data page read
>>   btrfs: relocation: Check cancel request after each extent found
>>   btrfs: relocation: Work around dead relocation stage loop
>>
>>  fs/btrfs/ctree.h      |  1 +
>>  fs/btrfs/relocation.c | 23 +++++++++++++++++++++++
>>  fs/btrfs/volumes.c    |  2 +-
>>  3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> --=20
>> 2.24.0
>>


--hOSRsj9JK9XO312uHDqhDflJbCgAvb3fF--

--9M8ypIQPVR8rwW3fRamQcM1wfPgNqtRgp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3oeNwACgkQwj2R86El
/qgBiQf+PRLbeaNFzuMDGChGb/n9Rx02DnXKXyAdwzU/+jXqeObnCoD8lEMtPIwj
iC0NmeNmRwlN9teWN4XT9sui7ibScWppblH34MCP7OXzafq215e/yef0bWfVpzef
3mH+BQ1HsBG62OLc/Lq6L467CLhMzvqg5+U2ELpLnTSAVpdIFLJbLtfoRrBbVeQC
C21jcc59j64EQbUVSIrKhCV5zwD41VoBwrY1HYN/VW2HMTGwDp/5Lw1FfxQ670er
4c3n8mNxYjazN1kaZ6QJ1fcvacQQXoKsTUF5j8dZRm8Ifmfb2xpQwKKBLP7gZAIG
lmcbhzSfuSvrXK+Iwzp1n3F4CrhIRQ==
=xZks
-----END PGP SIGNATURE-----

--9M8ypIQPVR8rwW3fRamQcM1wfPgNqtRgp--
