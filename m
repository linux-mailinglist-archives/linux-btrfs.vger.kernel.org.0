Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5F247E40
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 08:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHRGHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 02:07:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:35325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgHRGHO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 02:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597730828;
        bh=SyOQijODAM5bArU84yOFhj5FQReQVqsY0cTQFguu3/0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aBySx5TI8Dk0r26IvPu6OAmWrIx9Rrwy7RSfZOXJsgcAcKucUW7niNNOOjcVtGg1n
         0KxiKKPdGuuPairKVUuyzRxxrwla6EdQD3hKDbMQLY+RbBcIfa2x5rISvrfHBIlckX
         +LyMmfiY22RfLGOFMilVUAhb+0hlrQfyYyMHJgZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNh7-1kavP21aff-00htf5; Tue, 18
 Aug 2020 08:07:08 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
 <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com>
 <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com>
 <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com>
 <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
 <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com>
 <CAJheHN2-PbGC8S3f74CAFipsjxwXgip5N0zKG_xs-m8ky=WD2A@mail.gmail.com>
 <CAJheHN3qwDAGY=z14zfO4LBrxNJZZ_rvAMsWLwe-k+4+t3zLog@mail.gmail.com>
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
Message-ID: <11fe4ad3-928c-5b6b-4424-26fc05baa28d@gmx.com>
Date:   Tue, 18 Aug 2020 14:07:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN3qwDAGY=z14zfO4LBrxNJZZ_rvAMsWLwe-k+4+t3zLog@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="53F9ehagKDYVCVELh3x8DxfDTt6ZaoYTc"
X-Provags-ID: V03:K1:NwqpQx5kcsHnQRGQdbHXSw1FGmWYIeRmnJz5fHyOQXt1/qht4QD
 2yB5kEKblMISaE31SVcJWF1qML2bbNuWmLuyW0qDnpPXIGHRWIFuexggV50jEp2HTbRYPmK
 Q8ml1t3Gds2TmxaJ9OEzq8NpYyYWEqqDrkRyu0LxVAYETSkqZro/QKFSZqoxfAgAQnXoGIl
 knmFjgFfHO/tLXMRP8gyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Gani5qqHjs=:SaHGzvzkJ1cvdWVyFQEmmp
 AZU2MN5upke80DkqbNl4d9DBTkD4glspRVxNl3K4VjBE/UIfaOQKogHuqP9WOmUXYFcogjo2y
 2qwiZ+7rkK/j3hET+Kg3ECNtcxch9UlBbON7g/Vr39W4HycWiqn+TDkUaXGRSTvhuYVkuCyt7
 yDBLEFXluY6i5BwRLIAk354VkYgjkCaXtjlaqoJYc6XC+MnkZpNpaTJN9ssB9osqH0MpzxQBd
 SlrZWvg7d0oYmxR+nlJ6IEMRBvp9jsQGF7VsjKjcJ7Kw547g6gKsQ3ChQv+Aw5HmytVylQkYY
 3iGQ9jkx8uSPSAPSRTusMs5xJZvkT/d8AUPPxJNe9Irx1DSmCodkNxd0wOSHe9k+N1VZio8jF
 bgCfg0UsQrayeCMCAdLlfdGI+lmfxC9kJOKqeyxMflzWQDQwGe2kbYDa+5UVh4leQ9TjADRuh
 wPQYvaFmyXQOsYrCuRHx4C40pQeYU+m4OWU245qEwl6RuKDR4LeANJ8EH/04nvVO4m+ksALuc
 DozFq2B/k0t8iFp5R7/KCXjZzyd+6AFDR54W5mehP/pjeU99BGWXg6DccHLaflExRbshqnra2
 93ULUKUhBhi17J3DPgqvXarUuMW/6dYF1aOfE28PWjJzhWml8STQ4EQRvrvs/m06rldlKauoP
 X09fYmroASLsTB7rowf1H50BT5nSWmXYrmxkWiWVFvTK5YiLSpgY/G+P0wcYwalnA2nn447CZ
 oVA+9Q5CZ0sxYToFEBu8j85cBnNG41lx53pgI9r4+6KgDUzUUbgV6nhCJi2tFBwxJ5bdj2Gs9
 nQ1rq2sDNNSWpsQ4vBmVNNetmHcyGMCh8fwa6PDxW8T+mBrWY7GOqV3RhKfIcyjbNsJ5miBcu
 +ikkfNBTznxDfx86HIWbxoEYf6dQx5WdD+r90yseO9j/VFDOMoSd8ViXUWAwU5oZyr8wIhCbA
 7gqtnDTNlFjiNJ3ndoWNLgNEhqmVH1D89xLfEwV+pV/fWXWNkxVgrDUnBi0+bMXXuRDvmxWNw
 WOzZUE+LMHebTcTd6q/V3tqBALPlDj6nbMUypb+oS5gA3YpVxNQS5GUWTIqexLQJQIt3oVDPm
 jYiRqBsZUy/JgbpxoFZPm2NWTIZXm/mRZ2voTH2MuxLEJDaD/5hj3WSvkv+dEbldNSU9s4HBc
 +xX2pgI1xtyR9bY34Lxz0V1zk/WCmmXAIZA1M5aucLmK0rW+9B7Urh/CSWeUlpisHrJ078kxo
 omKts6QHyrN1mH0mJYuFWLBTnOLGPwKqKPdalRw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--53F9ehagKDYVCVELh3x8DxfDTt6ZaoYTc
Content-Type: multipart/mixed; boundary="DgkqsxCPrb48l7uJlSlYGAKaogHtjG2z2"

--DgkqsxCPrb48l7uJlSlYGAKaogHtjG2z2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
> Qu,
>=20
> Sorry to resurrect this thread, but I just ran into something that I
> can't really just ignore. I've found a folder that is full of files
> which I guess have been broken somehow. I found a backup and restored
> them, but I want to delete this folder of broken files. But whenever I
> try, the fs is forced into readonly mode again. I just finished another=

> btrfs check --repair but it didn't fix the problem.=C2=A0
>=20
> https://pastebin.com/eTV3s3fr=20

Is that the full output?

No inode generation bugs?
>=20
> =C2=A0I'm already on btrfs-progs v5.7. Any new suggestions?

Strange.

The detection and repair should have been merged into v5.5.

If your fs is small enough, would you please provide the "btrfs-image
-c9" dump?

It would contain the filenames and directories names, but doesn't
contain file contents.

Thanks,
Qu
>=20
> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gmail.com
> <mailto:t.d.richmond@gmail.com>> wrote:
>=20
>     5.6.1 also failed the same way. Here's the usage output. This is th=
e
>     part where you see I've been using RAID5 haha
>=20
>     WARNING: RAID56 detected, not implemented
>     Overall:
>     =C2=A0 =C2=A0 Device size:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 60.03TiB
>     =C2=A0 =C2=A0 Device allocated:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A098.06GiB
>     =C2=A0 =C2=A0 Device unallocated:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A059.93TiB
>     =C2=A0 =C2=A0 Device missing:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.00B
>     =C2=A0 =C2=A0 Used:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A092.56GiB
>     =C2=A0 =C2=A0 Free (estimated):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0.00B=C2=A0 =C2=A0 =C2=A0 (min: 8.00EiB)
>     =C2=A0 =C2=A0 Data ratio:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.00
>     =C2=A0 =C2=A0 Metadata ratio:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02.00
>     =C2=A0 =C2=A0 Global reserve:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 512.00MiB=C2=A0 =C2=A0 =C2=A0 (used: 0.00B)
>     =C2=A0 =C2=A0 Multiple profiles:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 no
>=20
>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
>     =C2=A0 =C2=A0/dev/sdh=C2=A0 =C2=A0 =C2=A0 =C2=A0 8.07TiB
>     =C2=A0 =C2=A0/dev/sdf=C2=A0 =C2=A0 =C2=A0 =C2=A0 8.07TiB
>     =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =C2=A0 =C2=A0 8.07TiB
>     =C2=A0 =C2=A0/dev/sdd=C2=A0 =C2=A0 =C2=A0 =C2=A0 8.07TiB
>     =C2=A0 =C2=A0/dev/sdc=C2=A0 =C2=A0 =C2=A0 =C2=A0 8.07TiB
>     =C2=A0 =C2=A0/dev/sde=C2=A0 =C2=A0 =C2=A0 =C2=A0 8.07TiB
>=20
>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
>     =C2=A0 =C2=A0/dev/sdh=C2=A0 =C2=A0 =C2=A0 =C2=A034.00GiB
>     =C2=A0 =C2=A0/dev/sdf=C2=A0 =C2=A0 =C2=A0 =C2=A032.00GiB
>     =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =C2=A0 =C2=A032.00GiB
>=20
>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
>     =C2=A0 =C2=A0/dev/sdf=C2=A0 =C2=A0 =C2=A0 =C2=A032.00MiB
>     =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =C2=A0 =C2=A032.00MiB
>=20
>     Unallocated:
>     =C2=A0 =C2=A0/dev/sdh=C2=A0 =C2=A0 =C2=A0 =C2=A0 2.81TiB
>     =C2=A0 =C2=A0/dev/sdf=C2=A0 =C2=A0 =C2=A0 =C2=A0 2.81TiB
>     =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =C2=A0 =C2=A0 2.81TiB
>     =C2=A0 =C2=A0/dev/sdd=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.03TiB
>     =C2=A0 =C2=A0/dev/sdc=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.03TiB
>     =C2=A0 =C2=A0/dev/sde=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.03TiB
>=20
>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com
>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     >
>     >
>     >
>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
>     > > If this is saying there's no extra space for metadata, is that =
why
>     > > adding more files often makes the system hang for 30-90s? Is th=
ere
>     > > anything I should do about that?
>     >
>     > I'm not sure about the hang though.
>     >
>     > It would be nice to give more info to diagnosis.
>     > The output of 'btrfs fi usage' is useful for space usage problem.=

>     >
>     > But the common idea is, to keep at 1~2 Gi unallocated (not avaiab=
le
>     > space in vanilla df command) space for btrfs.
>     >
>     > Thanks,
>     > Qu
>     >
>     > >
>     > > Thank you so much for all of your help. I love how flexible BTR=
FS is
>     > > but when things go wrong it's very hard for me to troubleshoot.=

>     > >
>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gmx.co=
m
>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     > >>
>     > >>
>     > >>
>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
>     > >>> Something went wrong:
>     > >>>
>     > >>> Reinitialize checksum tree
>     > >>> Unable to find block group for 0
>     > >>> Unable to find block group for 0
>     > >>> Unable to find block group for 0
>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
>     > >>>
>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed55=
0b3]
>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>     > >>> Aborted
>     > >>
>     > >> This means no space for extra metadata...
>     > >>
>     > >> Anyway the csum tree problem shouldn't be a big thing, you
>     could leave
>     > >> it and call it a day.
>     > >>
>     > >> BTW, as long as btrfs check reports no extra problem for the i=
node
>     > >> generation, it should be pretty safe to use the fs.
>     > >>
>     > >> Thanks,
>     > >> Qu
>     > >>>
>     > >>> I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
>     > >>> available. I'll let that try overnight?
>     > >>>
>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     > >>>>
>     > >>>>
>     > >>>>
>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
>     > >>>>> Thank you for helping. The end result of the scan was:
>     > >>>>>
>     > >>>>>
>     > >>>>> [1/7] checking root items
>     > >>>>> [2/7] checking extents
>     > >>>>> [3/7] checking free space cache
>     > >>>>> [4/7] checking fs roots
>     > >>>>
>     > >>>> Good news is, your fs is still mostly fine.
>     > >>>>
>     > >>>>> [5/7] checking only csums items (without verifying data)
>     > >>>>> there are no extents for csum range 0-69632
>     > >>>>> csum exists for 0-69632 but there is no extent record
>     > >>>>> ...
>     > >>>>> ...
>     > >>>>> there are no extents for csum range 946692096-946827264
>     > >>>>> csum exists for 946692096-946827264 but there is no extent
>     record
>     > >>>>> there are no extents for csum range 946831360-947912704
>     > >>>>> csum exists for 946831360-947912704 but there is no extent
>     record
>     > >>>>> ERROR: errors found in csum tree
>     > >>>>
>     > >>>> Only extent tree is corrupted.
>     > >>>>
>     > >>>> Normally btrfs check --init-csum-tree should be able to
>     handle it.
>     > >>>>
>     > >>>> But still, please be sure you're using the latest btrfs-prog=
s
>     to fix it.
>     > >>>>
>     > >>>> Thanks,
>     > >>>> Qu
>     > >>>>
>     > >>>>> [6/7] checking root refs
>     > >>>>> [7/7] checking quota groups skipped (not enabled on this FS=
)
>     > >>>>> found 44157956026368 bytes used, error(s) found
>     > >>>>> total csum bytes: 42038602716
>     > >>>>> total tree bytes: 49688616960
>     > >>>>> total fs tree bytes: 1256427520
>     > >>>>> total extent tree bytes: 1709105152
>     > >>>>> btree space waste bytes: 3172727316
>     > >>>>> file data blocks allocated: 261625653436416
>     > >>>>>=C2=A0 referenced 47477768499200
>     > >>>>>
>     > >>>>> What do I need to do to fix all of this?
>     > >>>>>
>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     > >>>>>>
>     > >>>>>>
>     > >>>>>>
>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
>     > >>>>>>> Well, the repair doesn't look terribly successful.
>     > >>>>>>>
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>
>     > >>>>>> This means there are more problems, not only the hash name=

>     mismatch.
>     > >>>>>>
>     > >>>>>> This means the fs is already corrupted, the name hash is
>     just one
>     > >>>>>> unrelated symptom.
>     > >>>>>>
>     > >>>>>> The only good news is, btrfs-progs abort the transaction,
>     thus no
>     > >>>>>> further damage to the fs.
>     > >>>>>>
>     > >>>>>> Please run a plain btrfs-check to show what's the problem
>     first.
>     > >>>>>>
>     > >>>>>> Thanks,
>     > >>>>>> Qu
>     > >>>>>>
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> parent transid verify failed on 218620880703488 wanted
>     6875841 found 6876224
>     > >>>>>>> Ignoring transid failure
>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
>     item=3D84
>     > >>>>>>> parent level=3D1
>     > >>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0child level=3D4
>     > >>>>>>> ERROR: failed to zero log tree: -17
>     > >>>>>>> ERROR: attempt to start transaction over already running =
one
>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=
=3D4096
>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>     225049066086400 len 4096
>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>     225049066094592 len 4096
>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>     225049066102784 len 4096
>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>     225049066131456 len 4096
>     > >>>>>>>
>     > >>>>>>> What is going on?
>     > >>>>>>>
>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wrote:
>     > >>>>>>>>
>     > >>>>>>>> Chris, I had used the correct mountpoint in the command.=

>     I just edited
>     > >>>>>>>> it in the email to be /mountpoint for consistency.
>     > >>>>>>>>
>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
>     > >>>>>>>>
>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     > >>>>>>>>>
>     > >>>>>>>>>
>     > >>>>>>>>>
>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrot=
e:
>     > >>>>>>>>>> Hello,
>     > >>>>>>>>>>
>     > >>>>>>>>>> I looked up this error and it basically says ask a
>     developer to
>     > >>>>>>>>>> determine if it's a false error or not. I just started=

>     getting some
>     > >>>>>>>>>> slow response times, and looked at the dmesg log to
>     find a ton of
>     > >>>>>>>>>> these errors.
>     > >>>>>>>>>>
>     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt
>     leaf: root=3D5
>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invali=
d inode
>     generation:
>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
>     block=3D203510940835840 read
>     > >>>>>>>>>> time tree block corruption detected
>     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt
>     leaf: root=3D5
>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invali=
d inode
>     generation:
>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
>     block=3D203510940835840 read
>     > >>>>>>>>>> time tree block corruption detected
>     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt
>     leaf: root=3D5
>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invali=
d inode
>     generation:
>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
>     block=3D203510940835840 read
>     > >>>>>>>>>> time tree block corruption detected
>     > >>>>>>>>>>
>     > >>>>>>>>>> btrfs device stats, however, doesn't show any errors.
>     > >>>>>>>>>>
>     > >>>>>>>>>> Is there anything I should do about this, or should I
>     just continue
>     > >>>>>>>>>> using my array as normal?
>     > >>>>>>>>>
>     > >>>>>>>>> This is caused by older kernel underflow inode generati=
on.
>     > >>>>>>>>>
>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check --repa=
ir.
>     > >>>>>>>>>
>     > >>>>>>>>> Or you can go safer, by manually locating the inode
>     using its inode
>     > >>>>>>>>> number (1311670), and copy it to some new location usin=
g
>     previous
>     > >>>>>>>>> working kernel, then delete the old file, copy the new
>     one back to fix it.
>     > >>>>>>>>>
>     > >>>>>>>>> Thanks,
>     > >>>>>>>>> Qu
>     > >>>>>>>>>
>     > >>>>>>>>>>
>     > >>>>>>>>>> Thank you!
>     > >>>>>>>>>>
>     > >>>>>>>>>
>     > >>>>>>
>     > >>>>
>     > >>
>     >
>=20


--DgkqsxCPrb48l7uJlSlYGAKaogHtjG2z2--

--53F9ehagKDYVCVELh3x8DxfDTt6ZaoYTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl87cAcACgkQwj2R86El
/qgKcQf+Ph+oS6yMBUGmolRRJmHfq8elAu+U/19VIsWbSKbTFQVNnJ94wl853vU7
FNa15PtJVFH3wEXOhzaoIgteyPXWxMYlqwa2p4NyKmkersaFbiKhIqxCE5uiCJy5
4HYdO1djSbIuP8BhQZhzGJeeSX7aER1BNxjJJ2W33y//S3trnH3AQ881N7iZQYRf
KnJwQigXBZ+Wlitx4AMGHWWqMiCffbc8Q/icg5krEFCBOZ4mercTsPnkmcB2svEU
UbyoYg8XLVoZnEbrbVpsFdzDP5nBSyi0vdWv7QY+EZe3ieAdL2R/Z2qemYIY0mqa
zgD1K1oWYbJlR69nDGQ16EUSeAnB2g==
=MqDf
-----END PGP SIGNATURE-----

--53F9ehagKDYVCVELh3x8DxfDTt6ZaoYTc--
