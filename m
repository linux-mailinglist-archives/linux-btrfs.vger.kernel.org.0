Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF414078F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 11:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgAQKKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 05:10:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:49163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgAQKKE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 05:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579255798;
        bh=Q0lf8kyNiT/ZSDgI4zh0WUFjlQgukTptAFcNJMHICsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PSeCGp7lMiZKiFEqKPsMkE6odi7zI2HxSiSMTeSYFKQ/O1AD9St8rmqzc/9PtMN0w
         OX6GbFXJXnXZbAWWXL5AaRN00RRdQwGv80Xhd5DUzMZrv0pcO0OiNK9bEeANmGwNTb
         eXn+Y7aLYdVkf0AtNFoLmRkOtNKqBTaydEBIgtk8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1jhWwa08io-016uzV; Fri, 17
 Jan 2020 11:09:58 +0100
Subject: Re: write time tree block corruption detected
To:     Kenneth Topp <toppk@bllue.org>, Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <5c4a4a6e021fcaf8f608c247a572e95b@bllue.org>
 <381e8322-48dd-6885-23e6-16da38922086@gmx.com>
 <35d184624be3d8aac778a29d4f701606@bllue.org>
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
Message-ID: <58069c2d-cf72-369f-edd8-679fc04a9cfd@gmx.com>
Date:   Fri, 17 Jan 2020 18:09:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <35d184624be3d8aac778a29d4f701606@bllue.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sGZUxjeomLDsr63GYphdKFq6QQQ5XdjHr"
X-Provags-ID: V03:K1:Jtq1paA5dlA9aD/KLFGVZbUFBJcnwsq3hnwe4BBfMCs/F2Mujwn
 wa95QzAuKroz25Yp2MeogOyw9kWysBtiVH4hlFaLcTX8AnBumNh0BjEAdnefOMc/4Q9mZx1
 eFP5IsxnXOTZbrnf+PcGU3X+WybrEhDpvqIFrtKkVh2W9bZi27XxUNkQjbpB9NgVpKzGR3q
 dsBCfXe2qr363FBOGkCTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aPteOnBgndU=:gpbD8S5KzxAo5sUsOj478H
 +x5++Ab50y5OM6vs9g4yCEqPJZ7QV7CtwQouYUjY4tRbqszmU7HzxjTkNVd+B4QP5yT0kOiH6
 X6zeUxDdhz4LuALYrjU0Cb14e53FqcHWo0TC2HVeI3IDIk2QDltmqBKtnXcilVbVeQELGLomQ
 kR8vYRkFNNcOWuNUD2AXRv6MosNYFbBP0IY99VOwCJPRAEI+O7Rp8tqN49dDEY/dvHdwC/nU2
 VnqSWM0D1jNiIVUP2E9DxJ3Z6Ur/EWkoqW+gWnHIjmGE971LestSEKSf0xjtTrW4kLXVlRBxX
 JJ8uEGvSpRN55LU5yDc2ZI4dUMArCuaSMUfUTqsG4BU0x9okZkFwjY8MUazsnsG61fytCXRMu
 T9mxXR8cT6KrIQ7RK7a7VV1kXpeuo11xn/PHntT51iM8wkVuJa4aMEc/76yISei9i/P3mCdVi
 jIyWdfuNULSAcMccMzMW7IDT08U8D3C5k+8MRU2zj0OV056uZEjJlsOMohORkxb6BLVA4VgiI
 EN++/ztcAfAzP1pEZM/Au58+Faxi1kb9mTkozFH77ruaNVysLelon55VeqleQjoswV36aS0c8
 MUukmBK2af3WRNbwKmXSZU0+YsU4KsJ0M3Ok0rtGHtu+bh1ZZ4w0djHaB4pcYpR5Wf0mtMOX0
 8rJWZFxbAwJ2+i5Dit5y5PbRsRdsZIW8ztef7Ln8jFSiTMdl0uaOJawehGxMaQOK5Nep2H348
 dRd9E6ESE6qF7Z0+CxRgR3pZMKkHB39uKnjSoFjPs0OMe8yr8Gqs4dCJC0rzj31htF34y1jib
 00NEKWQevs+rdeb5Qt8Mp61PBaaCMAr3Skvvm5xC5oidHdVdoc9ILDPGHg8P1mIeeJ61hcy0w
 r6bSu5NsxhFOJ+fKFxDsBA1cn8eC3sJ/160BWcj2Xws8BsiZRYxRGLJabhKifj++a8aqKR8Dc
 JAXvpRjb86towSXMQ/Kefu8UjzGr5seTLi351VHXOUGd2lhtSnQ2J7Aapt0A8iR+GZ+Y6En18
 LPVUmlxWj5aaPn4sLh5nPTjQcjjPQ7FDnOlmT0uOoT6erwnR5Bwzk5onv8iPpaantc8vI4Dvf
 lIV6Sgz0lJCX6Xy8nICnderGpvlcRtNiVt0ULpLWV9kRSZpz5CQl03d0OzbocRIOWK1PA50QR
 g79HCT91HNcXGr/QQOR9ginjaWvHtdGbJ+ZuKZmnUv+Wgjy4qAnOJQeKSiKw2Dz4XnXd2MI+t
 a5GBX6CZMMQr3jiHevzuCiTi/ylQkM2tF3Z75yRAhmtOAI5x8tM07JUC9NZc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sGZUxjeomLDsr63GYphdKFq6QQQ5XdjHr
Content-Type: multipart/mixed; boundary="8gALYC3DxCSYaKOVlctHxmDRA7psGvuo7"

--8gALYC3DxCSYaKOVlctHxmDRA7psGvuo7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/17 =E4=B8=8B=E5=8D=884:48, Kenneth Topp wrote:
> On 2020-01-17 03:33, Qu Wenruo wrote:
>> On 2020/1/17 =E4=B8=8B=E5=8D=884:21, Kenneth Topp wrote:
>>> I've been running 5.4.8 for 10 days and this popped up:
>>>
>>> [917767.192190] BTRFS error (device dm-19): block=3D21374679056384 wr=
ite
>>> time tree block corruption detected
>>> [917767.193436] BTRFS: error (device dm-19) in btrfs_sync_log:3104:
>>> errno=3D-5 IO failure
>>> [917767.193438] BTRFS info (device dm-19): forced readonly
>>
>> You missed the most important line. One line before "write time tree
>> block corruption detected" is the most important line.
>>
>=20
> sorry, here is the missing line.
>=20
> [917767.192187] BTRFS critical (device dm-19): corrupt leaf:
> root=3D18446744073709551610 block=3D21374679056384 slot=3D174 ino=3D219=
743
> file_offset=3D1385357312, file extent end range (1460178944) g
> oes beyond start offset (1385385984) of the next file extent
> [917767.192190] BTRFS error (device dm-19): block=3D21374679056384 writ=
e
> time tree block corruption detected
> [917767.193436] BTRFS: error (device dm-19) in btrfs_sync_log:3104:
> errno=3D-5 IO failure
> [917767.193438] BTRFS info (device dm-19): forced readonly

Hi Filipe,

This looks like one of your fixed problem for log tree, but I'm not very
confident.

Is this a fixed one or a new one?

Thanks,
Qu

>=20
> thanks for responding so quickly!
>=20
> ken
>=20
>>>
>>>
>>> This was a btrfs filesystem created on 5.4.8 with two 4kn drives, eac=
h
>>> with a single whole disk dm-crypt partition.=C2=A0 The fs was created=
 with
>>> mkfs -O no-holes -d single -m raid1 and mounted with
>>> clear_cache,space_cache=3Dv2.
>>>
>>> After that issue, I tried to update my backups, but it didn't go very=

>>> well:
>>>
>>> [918052.104923] BTRFS warning (device dm-19): dm-19 checksum verify
>>> failed on 21374567694336 wanted 6c2341bd found 640f30e8 level 0
>>> [918052.121801] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.121818] BTRFS info (device dm-19): no csum found for inode
>>> 219677 start 3397271552
>>> [918052.138406] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.139080] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.139094] BTRFS info (device dm-19): no csum found for inode
>>> 219677 start 3397275648
>>> [918052.139768] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.140158] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.140171] BTRFS info (device dm-19): no csum found for inode
>>> 219677 start 3397279744
>>> [918052.140532] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.140868] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.140880] BTRFS info (device dm-19): no csum found for inode
>>> 219677 start 3397283840
>>> [918052.159794] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 219677 off 3397271552 csum 0x33c9a639 expected csum 0x00000000 mirror=
 1
>>> [918052.213959] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.216411] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.216418] BTRFS info (device dm-19): no csum found for inode
>>> 219677 start 3397271552
>>> [918052.216570] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 219677 off 3397271552 csum 0x33c9a639 expected csum 0x00000000 mirror=
 1
>>> [918052.216790] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918052.217037] BTRFS info (device dm-19): no csum found for inode
>>> 219677 start 3397271552
>>> [918052.217165] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 219677 off 3397271552 csum 0x33c9a639 expected csum 0x00000000 mirror=
 1
>>> [918062.496366] BTRFS warning (device dm-19): dm-19 checksum verify
>>> failed on 20043100192768 wanted 8bf4c1c9 found 23b8dea8 level 0
>>> [918062.504832] verify_parent_transid: 1 callbacks suppressed
>>> [918062.504836] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.504848] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 28672
>>> [918062.506174] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100241920 wanted 45126 found 45104
>>> [918062.509823] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 28672 csum 0xa0f9eaf7 expected csum 0x00000000 mirror 1
>>> [918062.513826] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100241920 wanted 45126 found 45104
>>> [918062.513838] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 49152
>>> [918062.519723] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 49152 csum 0x76421bb0 expected csum 0x00000000 mirror 1
>>> [918062.530287] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.530866] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.530874] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 65536
>>> [918062.539238] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.539560] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.539566] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 69632
>>> [918062.540020] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.540261] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.540269] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 77824
>>> [918062.540965] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043100192768 wanted 45126 found 45104
>>> [918062.541199] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 114688
>>> [918062.541753] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 118784
>>> [918062.544496] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 65536 csum 0xdcb45a27 expected csum 0x00000000 mirror 1
>>> [918062.547421] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 114688 csum 0x1d5a0f30 expected csum 0x00000000 mirror 1
>>> [918062.549968] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 69632 csum 0x24dd186c expected csum 0x00000000 mirror 1
>>> [918062.572502] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 77824 csum 0xba341c47 expected csum 0x00000000 mirror 1
>>> [918062.575300] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 118784 csum 0x519e7044 expected csum 0x00000000 mirror 1
>>> [918062.584005] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 172032
>>> [918062.586782] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 221184
>>> [918062.587106] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 221184 csum 0xc9c50b2d expected csum 0x00000000 mirror 1
>>> [918062.590739] BTRFS info (device dm-19): no csum found for inode
>>> 5464098 start 450560
>>> [918062.591255] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 450560 csum 0xd2e5e3eb expected csum 0x00000000 mirror 1
>>> [918062.601361] BTRFS warning (device dm-19): dm-19 checksum verify
>>> failed on 20043100258304 wanted 61da40d5 found 204cd10a level 0
>>> [918062.602875] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5464098 off 503808 csum 0x183beedc expected csum 0x00000000 mirror 1
>>> [918085.820716] verify_parent_transid: 42 callbacks suppressed
>>> [918085.820730] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.837964] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.837992] __btrfs_lookup_bio_sums: 17 callbacks suppressed
>>> [918085.837994] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 159711232
>>> [918085.838459] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.838987] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.838995] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 159715328
>>> [918085.839349] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.840054] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.840065] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 159719424
>>> [918085.840402] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.840943] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.840951] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 159723520
>>> [918085.850438] btrfs_print_data_csum_error: 17 callbacks suppressed
>>> [918085.850442] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 159711232 csum 0x1e34dbf6 expected csum 0x00000000 mirror=
 1
>>> [918085.959941] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.960447] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 21374567694336 wanted 45126 found 45104
>>> [918085.960452] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 159711232
>>> [918085.960624] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 159711232 csum 0x1e34dbf6 expected csum 0x00000000 mirror=
 1
>>> [918085.961220] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 159711232
>>> [918085.961341] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 159711232 csum 0x1e34dbf6 expected csum 0x00000000 mirror=
 1
>>> [918087.026984] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 193855488
>>> [918087.028152] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 193859584
>>> [918087.028598] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 193863680
>>> [918087.029005] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 193867776
>>> [918087.042810] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 193855488 csum 0x86af03b1 expected csum 0x00000000 mirror=
 1
>>> [918087.054812] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 193904640 csum 0x279aea06 expected csum 0x00000000 mirror=
 1
>>> [918087.071004] BTRFS warning (device dm-19): dm-19 checksum verify
>>> failed on 20043549310976 wanted fcc4f73a found 3d3d8e83 level 0
>>> [918087.103303] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 193937408 csum 0x1fedc264 expected csum 0x00000000 mirror=
 1
>>> [918087.118559] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 193986560 csum 0xc47dad65 expected csum 0x00000000 mirror=
 1
>>> [918087.131234] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 193855488 csum 0x86af03b1 expected csum 0x00000000 mirror=
 1
>>> [918087.132513] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 193855488 csum 0x86af03b1 expected csum 0x00000000 mirror=
 1
>>> [918087.135749] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 193986560 csum 0xc47dad65 expected csum 0x00000000 mirror=
 1
>>> [918119.990544] BTRFS warning (device dm-19): dm-19 checksum verify
>>> failed on 20043135205376 wanted 79d70254 found 93ac2b61 level 0
>>> [918120.010421] verify_parent_transid: 105 callbacks suppressed
>>> [918120.010428] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043135205376 wanted 45126 found 45104
>>> [918120.010565] __btrfs_lookup_bio_sums: 48 callbacks suppressed
>>> [918120.010567] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 678543360
>>> [918120.028733] btrfs_print_data_csum_error: 5 callbacks suppressed
>>> [918120.028735] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 678543360 csum 0xcd3c1a5d expected csum 0x00000000 mirror=
 1
>>> [918120.040591] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043135205376 wanted 45126 found 45104
>>> [918120.041097] BTRFS error (device dm-19): parent transid verify fai=
led
>>> on 20043135205376 wanted 45126 found 45104
>>> [918120.041112] BTRFS info (device dm-19): no csum found for inode
>>> 5468073 start 678543360
>>> [918120.041440] BTRFS warning (device dm-19): csum failed root 5 ino
>>> 5468073 off 678543360 csum 0xcd3c1a5d expected csum 0x00000000 mirror=
 1
>>
>> Since you haven't rebooted, all these mismatch can be caused by aborte=
d
>> transaction.
>>
>>>
>>>
>>> Fortunately, after a reboot, everything appears healthy, no file
>>> corruption that I can observe, but I'm still running some checks.
>>
>> That's great, write time tree checker prevented corruption.
>>
>> But still, btrfs check, and scrub recommended.
>>
>> And the most important thing, please provide the missing key log line.=

>>
>> Thanks,
>> Qu
>>
>>>
>>> I'm not sure what the write tree is or if this is related to the read=

>>> tree issues mentioned on the mailing list, any advice/pointers would =
be
>>> most appreciated.=C2=A0 One thing I can note is that I've started to =
write
>>> heavily to this filesystem via nfs export (the nfs client happens to =
be
>>> a vm on the same machine, fwiw).
>>>


--8gALYC3DxCSYaKOVlctHxmDRA7psGvuo7--

--sGZUxjeomLDsr63GYphdKFq6QQQ5XdjHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4hh+4ACgkQwj2R86El
/qgFeQgAlCZX5o+jYW9L6zcNeTfB8End+PvxtGEYPdZ5lMVqmTmmfpwVVkijzDp4
l1ErymxaAmFq9nrlsB9L76dj5aaT995fnEf58LvXWz2Amr7HZyNr6Uq+cOOIIkNK
I3r/X69Krf8YPoxXxV/Nzccs7H2we2FR5SUMhSlSh4OXytsJSYEE8ShkGF06UIu3
q4pj7tBu7zVqxbGKZS++phcl5TgpfcoP/vtuls1FCosbu8suLLJ1NFQLyZauCmn3
L22FXG3tofc8VHpajFhdbKZJdLSZkdppW7ihcGYI02ees9C86bbdBqDrMk1LkUHM
No57oM/+pynxrjYOdVbg4G6+1QxlsQ==
=eGH7
-----END PGP SIGNATURE-----

--sGZUxjeomLDsr63GYphdKFq6QQQ5XdjHr--
