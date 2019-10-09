Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C8D0D55
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 13:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfJILAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 07:00:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:55433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfJILAe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 07:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570618824;
        bh=4/uaZhoKyHWJQJ3o0MERFo7oz9lsceOwQk4sZkIxXNo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S2tBTYjKISJYaGxfs4UQjgOWVOGbz8ozIzgmg522Xa9W3Kx+dgNx2/jwM1mIXi63u
         ifqUVZJLhcYiaFGHBkKen6oafFWjZZU0JclLT7poI7RQIkkx+QnJ8ElHzjfFoGdx2u
         Wvpj3blXuiNQ5TLsZokehT/zN8JHItpgaMiw+Deg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1i3SHT32fN-015cQc; Wed, 09
 Oct 2019 13:00:23 +0200
Subject: Re: [PATCH v2 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
To:     Felix Niederwanger <felix@feldspaten.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044909.157750-1-wqu@suse.com>
 <c47049af-d034-0228-c61c-65187d07e6b4@suse.de>
 <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>
 <23af48db-c28b-3406-b136-c5da30884a88@suse.de>
 <b4821d86-eeb9-f21c-66aa-480df2d3a13d@feldspaten.org>
 <6f17fcd6-c576-adad-fb20-defcfde4efb5@gmx.com>
 <cba919dd-1b77-5757-cf37-760ad6718fe3@feldspaten.org>
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
Message-ID: <43b50e0b-03dd-3b93-adaa-dc467d9cbad1@gmx.com>
Date:   Wed, 9 Oct 2019 19:00:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cba919dd-1b77-5757-cf37-760ad6718fe3@feldspaten.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O8cpi1Fmk9xTbUGolggCfM8HBlTLEHBaO"
X-Provags-ID: V03:K1:g60Q72UXV/ICe75ldGHCLxfgp2MzUF3QUoIkZpNi5myl9Le8iIp
 ORQ5xzGvEfcgyMqo/s8XjroJw5NjYp0dvc5wJ3jFUUUq9JTlPHPLzHSwVrKnFR8hanU8tx4
 TNbXEvQx9wz7XY3O6xBVCvY1yPsd9EzwDL6J3WjDBd6CIvdjdSXDtyJq3tU9CpePNmSFO8B
 1T4QfbNGy4kRyusqF3b2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Ertfynw/C8=:A9tUZsbRS9+W6sExxFC6XX
 xIixHSQunaTkLelcOYby2EIybH2v2bemUm2594VuXXh0MwKb5gEM5lchspoIuCzc6Zm3jLtAw
 NouYI+mKwKw+grIuo7axNQKzpSIySuf4l5KWnX2AvOi6Td3SrYAUjrpzYvrJPI9FC7U3257yl
 capEMyTCHJDaWXSexnJ5uZmSB8/GpiKqEpLUM+JX8s5734rnEFg0HkFrv8WZMiuqJ81pY1jjV
 BHY7mL3ruOkeqJ81uzbndhecGVRgot1o609pAglY3MSE1HgO92JOh9k74t6lEXkKbKpbgmi77
 TnGDIiiAaMx0UG/fl12OaySZcUB+5AJygvu7GecOnPJ48zMfUc1XqM7pejmTFZEzzGZAgiA71
 N5d1sGKZnHgEpB+BwMlLhH1BpDXt8Ah9x+3bQb+uQDo7XOdY+uY0vR5W1b+wnUnDcGMB1l16K
 MhMy72tUO6jBegr9GeT8WKuBtLIicht4Y/wegkqpE/eiuIiCP+ftQUUFng7hhNUuMBFo2mYMw
 2q473wvj8RmJbwB2p/P86TK29yQGx5pS8C5bvCXftLsvRQAsnxaI2AlV+Pc85G5jNeEZBKfK+
 FqdFAe5JzhAaITJcjdIPB1cG56XkAUtQf5gMJxyoQA8HdmNc0RBr+SHCrNWgrJhLYTY+SeYMj
 ik7E2JCaWA46d4UE24t0GaQ96gucFiWY82Ro6eFlP5PBlq1BGhsyXV1K6SmpSBj1jeRBjMB2B
 x4tTLX/VnvVM3v8xQir4N+QykBNUj0qe8TvywA8P5x2AwtpVoiEI5a/EmwIyxg1dsWUvfwmN2
 8huYWeUA6pom5PyM1KmyS1IpvUwBqBg7ow6ZJe4UjNsJacV82ItKTa+ap39EjcwDIxJH4OZe5
 3iMbxM15XevpVxjmIJVVGrpBe4nzzRKyBb/fPREN3wEqiCCQVEA9f7FQD5GxTkcTS2dYQUcpt
 zIczg7JFeMiDpzgbQ3T7wH3JIH+ALHYJqtPLY3/jXsZocZBuixgKafqLLFacQrbOPgRa68m3L
 2OV383YxCFtHLdOMUN2Vdq3FZe/bzinluGz9Fr2kt3HNqa5uOhCGslw8arfKTCez0lkrEpTXI
 NASTNI29UO0066bTMrhkbLsZyGoMAX/2X8vO9lJaC1o0L10zdhzCNehd7oNx4lnPw+s22hQAH
 dPU/QY9yKKzIGskIS4F9HuRoa0VocXAJ7r8E6oiR3FhHMr1IBZfK7y7CkcJwcqhzYw4BNxoLC
 dg5tMTIsJnAyhGHtLIsH5h9vyrzjNM4MYLFOkYIqVamvslTbCwlsXfqK0o4o=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O8cpi1Fmk9xTbUGolggCfM8HBlTLEHBaO
Content-Type: multipart/mixed; boundary="GRTSP7tMmy0lCgREN6oSP85AUkb5bAI8U"

--GRTSP7tMmy0lCgREN6oSP85AUkb5bAI8U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/9 =E4=B8=8B=E5=8D=884:08, Felix Niederwanger wrote:
> Hi Qu,
>=20
> I'm afraid the system is now in a very different configuration and
> already in production, which makes it impossible to run specific tests
> on it.
>=20
> At the time the problem occurred, we were using about 57/82 TB filled
> with approx 20-30 million individual files with varying file sized. I
> created a histogram of the most common unsed filesizes for a small subs=
et:
>=20
> # find . -type f -print0 | xargs -0 ls -l | awk
> '{size[int(log($5)/log(2))]++}END{for (i in size) printf("%10d %3d\n",
> 2^i, size[i])}' | sort -n
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 7992
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 3072
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0 4
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8 1536
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 128=C2=A0=C2=A0 2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512=C2=A0 22
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1024 4600
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2048 3341
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096 5671
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8192 940
> =C2=A0=C2=A0=C2=A0=C2=A0 16384 6535
> =C2=A0=C2=A0=C2=A0=C2=A0 32768 700
> =C2=A0=C2=A0=C2=A0=C2=A0 65536=C2=A0 17
> =C2=A0=C2=A0=C2=A0 131072 3843
> =C2=A0=C2=A0=C2=A0 262144 3362
> =C2=A0=C2=A0=C2=A0 524288 2143
> =C2=A0=C2=A0 1048576 1169
> =C2=A0=C2=A0 2097152 856
> =C2=A0=C2=A0 4194304 168
> =C2=A0=C2=A0 8388608 5579
> =C2=A0 16777216 4052
> =C2=A0 33554432 604
> =C2=A0 67108864 890
>=20
> 26240 out of 57098 files (45%) are <=3D4k in size. This should be
> representative for most of the files on the affected volume.

That explains the problem.

There are 3 main factors contributing to the mount time:
- Number of block groups
  This directly affects how many tree search we need to do.

- Number of extents
  This affects how random the block group iteration will be.

- Disk IOPS performance
  Obviously, since bg iteration is mostly random IO, it's IOPS affecting
  the overall mount time.

In your case, your fs seems to have all the boxes checked.

Anyway, it still stands inside the assumption I have, although it's a
pity that we can't get a real world benchmark, it still contributes to
the motivation of bg-tree feature.

Thanks,
Qu
>=20
> The affected system is now in production (xfs on the same RAID6) and as=

> I left university, it's unfortunately impossible to run any more tests
> on that particular system.
>=20
> Greetings,
> Felix
>=20
>=20
> On 10/9/19 9:43 AM, Qu Wenruo wrote:
>>
>> On 2019/10/9 =E4=B8=8B=E5=8D=883:07, Felix Niederwanger wrote:
>>> Hey Johannes,
>>>
>>> glad to hear back from you :-)
>>>
>>> As discussed I try to elaborate the setup where we experienced the
>>> issue, that btrfs mount takes more than 5 minutes. The initial bug
>>> report is at https://bugzilla.opensuse.org/show_bug.cgi?id=3D1143865
>>>
>>> Physical device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Hardware RAID controller ARECA-1883 PCIe 3.0 to SAS/SA=
TA 12Gb RAID Controller
>>>                              Hardware RAID6+HotSpare, 8 TB Seagate Ir=
onWolf NAS HDD
>>> Installed System:            OPENSUSE LEAP 15.1
>>> Disks:                       / is on a separate DOM
>>>                              /dev/sda1 is the affected btrfs volume
>>>
>>> Disk layout
>>>
>>> sda      8:0    0 98.2T  0 disk=20
>>> =E2=94=94=E2=94=80sda1   8:1    0 81.9T  0 part /ESO-RAID
>> How much space is used?
>>
>> With enough space used (especially your tens of TB used), it's pretty
>> easy to have too many block groups items to overload the extent tree.
>>
>> There is a better tool to explore the problem easier:
>> https://github.com/adam900710/btrfs-progs/tree/account_bgs
>>
>> You can compile the btrfs-corrupt-block tool, and then:
>> # ./btrfs-corrupt-block -X /dev/sda1
>>
>> It's recommended to call it with fs unmounted.
>>
>> Then it should output something like:
>> extent_tree: total=3D1080 leaves=3D1025
>>
>> Then please post that line to surprise us.
>>
>> It shows how many unique tree blocks are needed to be read from disk,
>> just for iterating the block group items.
>>
>> You could consider it as how many random IO needs to be done in nodesi=
ze
>> (normally 16K).
>>
>>> sdb      8:16   0   59G  0 disk=20
>>> =E2=94=9C=E2=94=80sdb1   8:17   0    1G  0 part /boot
>>> =E2=94=9C=E2=94=80sdb2   8:18   0  5.9G  0 part [SWAP]
>>> =E2=94=94=E2=94=80sdb3   8:19   0 52.1G  0 part /
>>>
>>> System configuration : Opensuse LEAP 15.1 with "Server" configuration=
,
>>> installed NFS server.
>>>
>>> I copied data from the old NAS (separate server, xfs volume) to the n=
ew
>>> btrfs volume using rsync.
>> If you are willing to/have enough spare space to test, you could try
>> that my latest bg-tree feature, to see if it would solve the problem.
>>
>> My not-so-optimized guess that feature would reduce mount time to arou=
nd
>> 1min.
>> My average guess is, around 30s.
>>
>> Thanks,
>> Qu
>>
>>> Then I performed a system update with zypper, rebooted and run into t=
he
>>> problems described in
>>> https://bugzilla.opensuse.org/show_bug.cgi?id=3D1143865. In short: Bo=
ot
>>> failed, because mounting /ESO-RAID run into a 5 minutes timeout. Manu=
al
>>> mount worked fine (but took up to 6 minutes) and the filesystem was
>>> completely unresponsive. See the bug report for more details about wh=
at
>>> became unresponsive.
>>>
>>> A movie of the failing boot process is still on my webserver:
>>> ftp://feldspaten.org/dump/20190803_btrfs_balance_issue/btrfs_openctre=
e_failed.mp4
>>>
>>>
>>> I hope this contributes to reproduce the issue. Feel free to contact =
me
>>> if you need further details,
>>>
>>> Greetings,
>>> Felix :-)
>>>
>>>
>>> On 10/8/19 11:47 AM, Johannes Thumshirn wrote:
>>>> On 08/10/2019 11:26, Qu Wenruo wrote:
>>>>> On 2019/10/8 =E4=B8=8B=E5=8D=885:14, Johannes Thumshirn wrote:
>>>>>>> [[Benchmark]]
>>>>>>> Since I have upgraded my rig to all NVME storage, there is no HDD=

>>>>>>> test result.
>>>>>>>
>>>>>>> Physical device:	NVMe SSD
>>>>>>> VM device:		VirtIO block device, backup by sparse file
>>>>>>> Nodesize:		4K  (to bump up tree height)
>>>>>>> Extent data size:	4M
>>>>>>> Fs size used:		1T
>>>>>>>
>>>>>>> All file extents on disk is in 4M size, preallocated to reduce sp=
ace usage
>>>>>>> (as the VM uses loopback block device backed by sparse file)
>>>>>> Do you have a some additional details about the test setup? I trie=
d to
>>>>>> do the same (testing) for a bug Felix (added to Cc) reported to my=
 at
>>>>>> the ALPSS Conference and I couldn't reproduce the issue.
>>>>>>
>>>>>> My testing was a 100TB sparse file passed into a VM and running th=
is
>>>>>> script to touch all blockgroups:
>>>>> Here is my test scripts:
>>>>> ---
>>>>> #!/bin/bash
>>>>>
>>>>> dev=3D"/dev/vdb"
>>>>> mnt=3D"/mnt/btrfs"
>>>>>
>>>>> nr_subv=3D16
>>>>> nr_extents=3D16384
>>>>> extent_size=3D$((4 * 1024 * 1024)) # 4M
>>>>>
>>>>> _fail()
>>>>> {
>>>>>         echo "!!! FAILED: $@ !!!"
>>>>>         exit 1
>>>>> }
>>>>>
>>>>> fill_one_subv()
>>>>> {
>>>>>         path=3D$1
>>>>>         if [ -z $path ]; then
>>>>>                 _fail "wrong parameter for fill_one_subv"
>>>>>         fi
>>>>>         btrfs subv create $path || _fail "create subv"
>>>>>
>>>>>         for i in $(seq 0 $((nr_extents - 1))); do
>>>>>                 fallocate -o $((i * $extent_size)) -l $extent_size
>>>>> $path/file || _fail "fallocate"
>>>>>         done
>>>>> }
>>>>>
>>>>> declare -a pids
>>>>> umount $mnt &> /dev/null
>>>>> umount $dev &> /dev/null
>>>>>
>>>>> #~/btrfs-progs/mkfs.btrfs -f -n 4k $dev -O bg-tree
>>>>> mkfs.btrfs -f -n 4k $dev
>>>>> mount $dev $mnt -o nospace_cache
>>>>>
>>>>> for i in $(seq 1 $nr_subv); do
>>>>>         fill_one_subv $mnt/subv_${i} &
>>>>>         pids[$i]=3D$!
>>>>> done
>>>>>
>>>>> for i in $(seq 1 $nr_subv); do
>>>>>         wait ${pids[$i]}
>>>>> done
>>>>> sync
>>>>> umount $dev
>>>>>
>>>>> ---
>>>>>
>>>>>> #!/bin/sh
>>>>>>
>>>>>> FILE=3D/mnt/test
>>>>>>
>>>>>> add_dirty_bg() {
>>>>>>         off=3D"$1"
>>>>>>         len=3D"$2"
>>>>>>         touch $FILE
>>>>>>         xfs_io -c "falloc $off $len" $FILE
>>>>>>         rm $FILE
>>>>>> }
>>>>>>
>>>>>> mkfs.btrfs /dev/vda
>>>>>> mount /dev/vda /mnt
>>>>>>
>>>>>> for ((i =3D 1; i < 100000; i++)); do
>>>>>>         add_dirty_bg $i"G" "1G"
>>>>>> done
>>>>> This wont really build a good enough extent tree layout.
>>>>>
>>>>> 1G fallocate will only cause 8 128M file extents, thus 8 EXTENT_ITE=
Ms.
>>>>>
>>>>> Thus a leaf (16K by default) can still contain a lot of BLOCK_GROUP=
S all
>>>>> together.
>>>>>
>>>>> To build a case to really show the problem, you'll need a lot of
>>>>> EXTENT_ITEM/METADATA_ITEMS to fill the gaps between BLOCK_GROUPS.
>>>>>
>>>>> My test scripts did that, but may still not represent the real worl=
d, as
>>>>> real world can cause even smaller extents due to snapshots.
>>>>>
>>>> Ah thanks for the explanation. I'll give your testscript a try.
>>>>
>>>>
>=20


--GRTSP7tMmy0lCgREN6oSP85AUkb5bAI8U--

--O8cpi1Fmk9xTbUGolggCfM8HBlTLEHBaO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2dvcIACgkQwj2R86El
/qgZugf+MEkBaFOGeNYVTE4kEiGlTaYTyIC48MYVejWMHFB0OkQdU4oiwuCDsenx
C856JXH58WfU5aoFRYBDXv5nQUQ8A4EQqmutUTn1U3+/MYWl2faQ70XPUiLayiCV
goTzNXSNawIqbmzWWt+WyKU4TGhCsJA5cZAxRnuIVEb6jwu6k2CLLTJ+QdyYJqab
Qm4zcgDLJVR9aeInjRtL7gAYhe3Moky0rbbSdBVJrHwTUJm/MmTXiulaOSnyp6Iv
rBA7QH6G5IpDw1O8b047AfClIBMeK6YlJLJczqHpq1F3AA2Ce9oTPC2YaIdVYowr
GtCigoQcVprSSJSbtkmd8GFyPLC/JQ==
=hHQo
-----END PGP SIGNATURE-----

--O8cpi1Fmk9xTbUGolggCfM8HBlTLEHBaO--
