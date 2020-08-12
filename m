Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE068243170
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 01:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHLX3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 19:29:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:55861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHLX3q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 19:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597274984;
        bh=XiQwnjYcAF5ADu+DxcLZ6kmVKKk0dfZYkVqpkPzzivc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ivKgRdRwCu9kM/ggaNQVRWKhSXG763Nr5WsiJjDP0FRDJuNeOduP6ZYePowlRWAH0
         /YajZSmOoii38vp4a1CaxZuImhwkno1gSU8mX3+apWKQ1Wm5BFFdJ4v8KGKYPVQbyV
         ub9I0y5JIY9pFNnxyBX/HXrqWuWdI7RcgYlTRjQs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel7v-1keW3e0iqz-00aic5; Thu, 13
 Aug 2020 01:29:43 +0200
Subject: Re: AW: Tree-checker Issue / Corrupt FS after upgrade ?
To:     benjamin.haendel@gmx.net,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <004201d670c9$c69b9230$53d2b690$@gmx.net>
 <facaa4ae-5001-13e7-3ea1-26d514f73848@gmx.com>
 <000801d670fd$bb2f62d0$318e2870$@gmx.net>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <940c43d7-b7e0-82fa-d5a5-b81e672b85a9@gmx.com>
Date:   Thu, 13 Aug 2020 07:29:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000801d670fd$bb2f62d0$318e2870$@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aEyjxYM3s6nlIWIqW8GcFlnv0f7yCekrS"
X-Provags-ID: V03:K1:1C3hi/CbK/KQCKqYdbt+Uzi4CJtS7ztXj+z+S+JW6Dgvtxl1o0E
 2hOnd6HDAyZh2VDOU7X0bpSWy4Q5orrgpihlSDgbWe+Bxhiwoh4E94sR2GAHqrlNR+kRcyP
 +ZGT0b7VDoNMqJA9JLzs7exVev+vnhU4/5bR1vdgbZ93dUpr9mem2IpieYuQtogqHQKCyxW
 ldjyUpQQfUqG/x26fi2eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IS855siTnSQ=:5hBs/kjyIAPra8orlYf5hc
 RzYSsb+ce5jC4KflF/UUO9MckIuqi6W/lgiFYlsIJ4uoPDV0yt7kJMo8vN/kBTlnQVyN/vc++
 r6VzWiquAroTUGmqQR8GPnNqsho0/cTJQ1wvVcByc3aHurEOIu54nQPwqkWLVSCHYGSbzx5RS
 SrYua4oJPmSj51GPUFYSVfplbSZL+9WVl1E4it/WgPO3yiwL+hUFj7wQk5JoWSMgn8jP2z8Zl
 6PMjE6iKS3mgreBGdWHY+x7qCrHoWzYAPgYfUD0v8fuycr7fglN31f8zBtYK4OKUqC/Me+tZA
 F6DvXMVl66nGKCEo19kSLWgq6rULCo4DzncGNTOad+/d8bx9tR8Ukbo+A2pwxn0hW3bRjuRlH
 jDdUaclqsPGdlPkqQPoSuTU/HGoV4NATiH0Mw9hFENAb4NSV3dAang5GQl6nO11LgT9N0FmbG
 MXhf+CbB03ec7vd6CmKT1ek2Wo/6hkkTrBrT0q2WA7TL1kd8nj9T5A2iloEdQUvesMS97I+yv
 /dagSfaPzZ6bKeIGvNQ2YASjASmVSJPWzOOrvUPuyqGXFayojVS9OUCE6FYZGAq+ImN3ykR+V
 NjPG78jqhASttvwHtDj2K9JAUsNw8S0CEsiRpVfbFFlQiaAEhZoTuVHf2+pbCrAqOr8VgrDPo
 oNERmbSPbgEM4Z6LIYsVC75fzgx0EqhCM8FaHPd0ZSQJLWWrO0xzLppyE8e/OOwGxB1SSLEmF
 X0LAPe7JKtbj9N0chrUnbzazRB0RF2IHDyR2/wF7GDX2F8Yf8vmc90ceLiCJflKHoDHTny5T3
 A2U++vw8IQVsnb/EDhUvS5vREYoyRxgLYvZZPictw5mAx7kvR8vHM4zJVjkoLQEuu6+6mgIXA
 cdn4AoGz6/aiDpFgvcdPP+9CTe3px7xOgToOgF+6gW0GRL+1IessZFf1dXXH1FBEC+zkyk8uV
 6m7DoLfevue4+eSlYcMguId/w0S/FkMuzttD0Z2KFaJfUL4wAQjKb1ajTk7Ndczy9U6bdnSzG
 h+qFcJooNB7coHhLzabfW6fpKDcfXCC/XxFa99ow1NbAAJvkJ+rc1DBIuoLFxF7XaC8cCichX
 Mu6snKlWs2YqIbKz9j3lgvZkg7c79sKIfias2emtown9QAiiDq7+4FeQkQLILj9OguEj+523J
 OcsISYPnJ+8Wqt53bbqFLe+E5S/Sls9QNOJVQczQlHmGQVjhdmIBHLwW+I44E6PYb2uW7ds+s
 MNifBs7KuChgSlUb0QN6YXPRFY2XpE5KiXjU/iQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEyjxYM3s6nlIWIqW8GcFlnv0f7yCekrS
Content-Type: multipart/mixed; boundary="ajHWexoLUUjJSK5IuTCrviYEZv8fM9pqU"

--ajHWexoLUUjJSK5IuTCrviYEZv8fM9pqU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/13 =E4=B8=8A=E5=8D=887:10, benjamin.haendel@gmx.net wrote:
> Hi Qu,
>=20
> thanks for your reply, i am not sure what to do from here on.
> What do i have to download from here or compile/make/install etc. ?

You need to compile that branch.

For how to compile, please check the README.md.


>=20
> I'm no total idiot but i still don't understand what i have to get
> And how to apply it...sorry :(

Or you can use btrfs-send to send out the content of your fs with older
kernel, and create a new fs using newer kernel, then receive the stream.

The uninitialized data is only in extent tree, which won't be sent with
the stream, by receiving it with newer kernel, you won't lose anything.

Thanks,
Qu

>=20
> Best Regards,
> Ben
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Gesendet: Donnerstag, 13. August 2020 00:51
> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
> Betreff: Re: Tree-checker Issue / Corrupt FS after upgrade ?
>=20
>=20
>=20
> On 2020/8/13 =E4=B8=8A=E5=8D=8812:58, benjamin.haendel@gmx.net wrote:
>> Hi,
>>
>> i have been running my little Storage (32TB) on a Ubuntu 18.04 LTS=20
>> Machine with btrfs-progs 4.17. I then did my monthly upgrade (apt=20
>> dist-upgrade) and after a reboot my Partition could not mount with the=
 error message:
>> "root@Userv:/home/benjamin# mount -r ro btrfs /dev/mapper/Crypto=20
>> /media/Storage
>> mount: bad usage"
>>
>> I then proceeded to run a btrfs check which gave thousands of errors=20
>> and then also a super-recover:
>> root@Userv:/home/benjamin# btrfs rescue super-recover -v=20
>> /dev/mapper/Crypto All Devices:
>> Device: id =3D 1, name =3D /dev/mapper/Crypto
>>
>> Before Recovering:
>> [All good supers]:
>> device name =3D /dev/mapper/Crypto
>> superblock bytenr =3D 65536
>>
>> device name =3D /dev/mapper/Crypto
>> superblock bytenr =3D 67108864
>>
>> device name =3D /dev/mapper/Crypto
>> superblock bytenr =3D 274877906944
>>
>> [All bad supers]:
>>
>> All supers are valid, no need to recover
>>
>> I now checked my dmesg log:
>> [45907.451840] BTRFS critical (device dm-0): corrupt leaf:
>> block=3D22751711027200 slot=3D1 extent bytenr=3D6754755866624 len=3D40=
96=20
>> invalid generation, have 22795412619264 expect (0, 207589]
>=20
> This is caused by older kernel, which writes some uninitialized value o=
nto disk.
>=20
> You can try to fix it with this branch:
> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>=20
> Or you can use older kernel to delete the offending extents.
>=20
> Thanks,
> Qu
>=20
>> [45907.451848] BTRFS error (device dm-0): block=3D22751711027200 read =

>> time tree block corruption detected [45907.451892] BTRFS error (device=
=20
>> dm-0): failed to read block groups: -5 [45907.510712] BTRFS error=20
>> (device dm-0): open_ctree failed
>>
>> Google inquiries to this topic led me to this link:
>> https://btrfs.wiki.kernel.org/index.php/Tree-checker
>> It tells me to mail here first so thats what i am doing. I kind of=20
>> suspect since everything worked perfect (Memtest also no errors)=20
>> before the update, it has to do something with that update. I am=20
>> wondering if it would help if i deleted my OS Disk and reinstalled an =

>> older Version of Ubuntu, like
>> 16.04.6 LTS ?
>>
>> Since then i upgraded to 20.04 LTS with BTRFS-PROGS 5.7 as a lot of=20
>> forum entries said it would be wise to use the newer versions as older=
 were buggy.
>> That brought no help as well.
>>
>> Since i am no Linux/Unix Expert i thought it might be better to ask=20
>> now first as advised in the link above before proceeding with any othe=
r plans.
>>
>> I find it hard to believe that all data is gone, i feel its buggy=20
>> behavior as the partition and everything is still there:
>> root@Userv:/home/benjamin# btrfs fi show
>> Label: 'Storage'  uuid: 46c7d04a-d6ac-45be-94cc-724919faca2b
>> Total devices 1 FS bytes used 28.23TiB
>> devid    1 size 29.10TiB used 29.04TiB path /dev/mapper/Crypto
>>
>> Best Regards,
>> Benjamin H=C3=A4ndel
>>
>=20
>=20


--ajHWexoLUUjJSK5IuTCrviYEZv8fM9pqU--

--aEyjxYM3s6nlIWIqW8GcFlnv0f7yCekrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl80e2QACgkQwj2R86El
/qhREwf8D09kOSYeWQkrR5y7RqEGFvVyAsbI8z7uvN8AavgC7no44Y3NKlXC3WyU
bS969b5hIQctlxgncO9+a5SQLHZ1FS6+CYLiRjhrmTCMY/uVdSSMLDOBTg9KR5DG
go6ZCXnsbkZ3zfZfmYdQVv+2lZL4TCxJIg+UEETPLFJ8MW6go5+l4tAC42GV5Whp
Q2+gdaIcLNyEjZtgwJpH+WQZXUlPg0tNV7zgSZyllPE2UudeM73v2jd1fc0rjugA
a+TnsrKQteouafyGgv18Q4tZ8oyHStZZm2hs4qrobn0DIUBmci/TJY+qkf/Zt0Rq
P6e6/+N3RVlVr4auXJm0NPYm58vOEQ==
=UUp1
-----END PGP SIGNATURE-----

--aEyjxYM3s6nlIWIqW8GcFlnv0f7yCekrS--
