Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A36D0939
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfJIII3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 04:08:29 -0400
Received: from feldspaten.org ([78.46.71.109]:50038 "EHLO feldspaten.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfJIII3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 04:08:29 -0400
Received: by feldspaten.org (Postfix, from userid 5005)
        id 7902B8C08CA; Wed,  9 Oct 2019 10:08:27 +0200 (CEST)
Received: from [172.16.1.13] (unknown [172.16.1.13])
        (Authenticated sender: felix@feldspaten.org)
        by feldspaten.org (Postfix) with ESMTPSA id 1B5358C08CA;
        Wed,  9 Oct 2019 10:08:25 +0200 (CEST)
Subject: Re: [PATCH v2 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044909.157750-1-wqu@suse.com>
 <c47049af-d034-0228-c61c-65187d07e6b4@suse.de>
 <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>
 <23af48db-c28b-3406-b136-c5da30884a88@suse.de>
 <b4821d86-eeb9-f21c-66aa-480df2d3a13d@feldspaten.org>
 <6f17fcd6-c576-adad-fb20-defcfde4efb5@gmx.com>
From:   Felix Niederwanger <felix@feldspaten.org>
Autocrypt: addr=felix@feldspaten.org; prefer-encrypt=mutual; keydata=
 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
 bgu+FykyaCU=
Message-ID: <cba919dd-1b77-5757-cf37-760ad6718fe3@feldspaten.org>
Date:   Wed, 9 Oct 2019 10:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <6f17fcd6-c576-adad-fb20-defcfde4efb5@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RJEQeLWobomDZWRXOY7BE9iRFK93SRUOj"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RJEQeLWobomDZWRXOY7BE9iRFK93SRUOj
Content-Type: multipart/mixed; boundary="p6sX4Dqv0x44S18HVoKO56caGWsgvmioB"

--p6sX4Dqv0x44S18HVoKO56caGWsgvmioB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi Qu,

I'm afraid the system is now in a very different configuration and
already in production, which makes it impossible to run specific tests
on it.

At the time the problem occurred, we were using about 57/82 TB filled
with approx 20-30 million individual files with varying file sized. I
created a histogram of the most common unsed filesizes for a small subset=
:

# find . -type f -print0 | xargs -0 ls -l | awk
'{size[int(log($5)/log(2))]++}END{for (i in size) printf("%10d %3d\n",
2^i, size[i])}' | sort -n

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 7992
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 3072
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0 4
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8 1536
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 128=C2=A0=C2=A0 2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512=C2=A0 22
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1024 4600
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2048 3341
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096 5671
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8192 940
=C2=A0=C2=A0=C2=A0=C2=A0 16384 6535
=C2=A0=C2=A0=C2=A0=C2=A0 32768 700
=C2=A0=C2=A0=C2=A0=C2=A0 65536=C2=A0 17
=C2=A0=C2=A0=C2=A0 131072 3843
=C2=A0=C2=A0=C2=A0 262144 3362
=C2=A0=C2=A0=C2=A0 524288 2143
=C2=A0=C2=A0 1048576 1169
=C2=A0=C2=A0 2097152 856
=C2=A0=C2=A0 4194304 168
=C2=A0=C2=A0 8388608 5579
=C2=A0 16777216 4052
=C2=A0 33554432 604
=C2=A0 67108864 890

26240 out of 57098 files (45%) are <=3D4k in size. This should be
representative for most of the files on the affected volume.

The affected system is now in production (xfs on the same RAID6) and as
I left university, it's unfortunately impossible to run any more tests
on that particular system.

Greetings,
Felix


On 10/9/19 9:43 AM, Qu Wenruo wrote:
>
> On 2019/10/9 =E4=B8=8B=E5=8D=883:07, Felix Niederwanger wrote:
>> Hey Johannes,
>>
>> glad to hear back from you :-)
>>
>> As discussed I try to elaborate the setup where we experienced the
>> issue, that btrfs mount takes more than 5 minutes. The initial bug
>> report is at https://bugzilla.opensuse.org/show_bug.cgi?id=3D1143865
>>
>> Physical device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Hardware RAID controller ARECA-1883 PCIe 3.0 to SAS/SA=
TA 12Gb RAID Controller
>>                              Hardware RAID6+HotSpare, 8 TB Seagate Iro=
nWolf NAS HDD
>> Installed System:            OPENSUSE LEAP 15.1
>> Disks:                       / is on a separate DOM
>>                              /dev/sda1 is the affected btrfs volume
>>
>> Disk layout
>>
>> sda      8:0    0 98.2T  0 disk=20
>> =E2=94=94=E2=94=80sda1   8:1    0 81.9T  0 part /ESO-RAID
> How much space is used?
>
> With enough space used (especially your tens of TB used), it's pretty
> easy to have too many block groups items to overload the extent tree.
>
> There is a better tool to explore the problem easier:
> https://github.com/adam900710/btrfs-progs/tree/account_bgs
>
> You can compile the btrfs-corrupt-block tool, and then:
> # ./btrfs-corrupt-block -X /dev/sda1
>
> It's recommended to call it with fs unmounted.
>
> Then it should output something like:
> extent_tree: total=3D1080 leaves=3D1025
>
> Then please post that line to surprise us.
>
> It shows how many unique tree blocks are needed to be read from disk,
> just for iterating the block group items.
>
> You could consider it as how many random IO needs to be done in nodesiz=
e
> (normally 16K).
>
>> sdb      8:16   0   59G  0 disk=20
>> =E2=94=9C=E2=94=80sdb1   8:17   0    1G  0 part /boot
>> =E2=94=9C=E2=94=80sdb2   8:18   0  5.9G  0 part [SWAP]
>> =E2=94=94=E2=94=80sdb3   8:19   0 52.1G  0 part /
>>
>> System configuration : Opensuse LEAP 15.1 with "Server" configuration,=

>> installed NFS server.
>>
>> I copied data from the old NAS (separate server, xfs volume) to the ne=
w
>> btrfs volume using rsync.
> If you are willing to/have enough spare space to test, you could try
> that my latest bg-tree feature, to see if it would solve the problem.
>
> My not-so-optimized guess that feature would reduce mount time to aroun=
d
> 1min.
> My average guess is, around 30s.
>
> Thanks,
> Qu
>
>> Then I performed a system update with zypper, rebooted and run into th=
e
>> problems described in
>> https://bugzilla.opensuse.org/show_bug.cgi?id=3D1143865. In short: Boo=
t
>> failed, because mounting /ESO-RAID run into a 5 minutes timeout. Manua=
l
>> mount worked fine (but took up to 6 minutes) and the filesystem was
>> completely unresponsive. See the bug report for more details about wha=
t
>> became unresponsive.
>>
>> A movie of the failing boot process is still on my webserver:
>> ftp://feldspaten.org/dump/20190803_btrfs_balance_issue/btrfs_openctree=
_failed.mp4
>>
>>
>> I hope this contributes to reproduce the issue. Feel free to contact m=
e
>> if you need further details,
>>
>> Greetings,
>> Felix :-)
>>
>>
>> On 10/8/19 11:47 AM, Johannes Thumshirn wrote:
>>> On 08/10/2019 11:26, Qu Wenruo wrote:
>>>> On 2019/10/8 =E4=B8=8B=E5=8D=885:14, Johannes Thumshirn wrote:
>>>>>> [[Benchmark]]
>>>>>> Since I have upgraded my rig to all NVME storage, there is no HDD
>>>>>> test result.
>>>>>>
>>>>>> Physical device:	NVMe SSD
>>>>>> VM device:		VirtIO block device, backup by sparse file
>>>>>> Nodesize:		4K  (to bump up tree height)
>>>>>> Extent data size:	4M
>>>>>> Fs size used:		1T
>>>>>>
>>>>>> All file extents on disk is in 4M size, preallocated to reduce spa=
ce usage
>>>>>> (as the VM uses loopback block device backed by sparse file)
>>>>> Do you have a some additional details about the test setup? I tried=
 to
>>>>> do the same (testing) for a bug Felix (added to Cc) reported to my =
at
>>>>> the ALPSS Conference and I couldn't reproduce the issue.
>>>>>
>>>>> My testing was a 100TB sparse file passed into a VM and running thi=
s
>>>>> script to touch all blockgroups:
>>>> Here is my test scripts:
>>>> ---
>>>> #!/bin/bash
>>>>
>>>> dev=3D"/dev/vdb"
>>>> mnt=3D"/mnt/btrfs"
>>>>
>>>> nr_subv=3D16
>>>> nr_extents=3D16384
>>>> extent_size=3D$((4 * 1024 * 1024)) # 4M
>>>>
>>>> _fail()
>>>> {
>>>>         echo "!!! FAILED: $@ !!!"
>>>>         exit 1
>>>> }
>>>>
>>>> fill_one_subv()
>>>> {
>>>>         path=3D$1
>>>>         if [ -z $path ]; then
>>>>                 _fail "wrong parameter for fill_one_subv"
>>>>         fi
>>>>         btrfs subv create $path || _fail "create subv"
>>>>
>>>>         for i in $(seq 0 $((nr_extents - 1))); do
>>>>                 fallocate -o $((i * $extent_size)) -l $extent_size
>>>> $path/file || _fail "fallocate"
>>>>         done
>>>> }
>>>>
>>>> declare -a pids
>>>> umount $mnt &> /dev/null
>>>> umount $dev &> /dev/null
>>>>
>>>> #~/btrfs-progs/mkfs.btrfs -f -n 4k $dev -O bg-tree
>>>> mkfs.btrfs -f -n 4k $dev
>>>> mount $dev $mnt -o nospace_cache
>>>>
>>>> for i in $(seq 1 $nr_subv); do
>>>>         fill_one_subv $mnt/subv_${i} &
>>>>         pids[$i]=3D$!
>>>> done
>>>>
>>>> for i in $(seq 1 $nr_subv); do
>>>>         wait ${pids[$i]}
>>>> done
>>>> sync
>>>> umount $dev
>>>>
>>>> ---
>>>>
>>>>> #!/bin/sh
>>>>>
>>>>> FILE=3D/mnt/test
>>>>>
>>>>> add_dirty_bg() {
>>>>>         off=3D"$1"
>>>>>         len=3D"$2"
>>>>>         touch $FILE
>>>>>         xfs_io -c "falloc $off $len" $FILE
>>>>>         rm $FILE
>>>>> }
>>>>>
>>>>> mkfs.btrfs /dev/vda
>>>>> mount /dev/vda /mnt
>>>>>
>>>>> for ((i =3D 1; i < 100000; i++)); do
>>>>>         add_dirty_bg $i"G" "1G"
>>>>> done
>>>> This wont really build a good enough extent tree layout.
>>>>
>>>> 1G fallocate will only cause 8 128M file extents, thus 8 EXTENT_ITEM=
s.
>>>>
>>>> Thus a leaf (16K by default) can still contain a lot of BLOCK_GROUPS=
 all
>>>> together.
>>>>
>>>> To build a case to really show the problem, you'll need a lot of
>>>> EXTENT_ITEM/METADATA_ITEMS to fill the gaps between BLOCK_GROUPS.
>>>>
>>>> My test scripts did that, but may still not represent the real world=
, as
>>>> real world can cause even smaller extents due to snapshots.
>>>>
>>> Ah thanks for the explanation. I'll give your testscript a try.
>>>
>>>


--p6sX4Dqv0x44S18HVoKO56caGWsgvmioB--

--RJEQeLWobomDZWRXOY7BE9iRFK93SRUOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElsYjfujFfHyZiaoDbnelkOP21xwFAl2dlXgACgkQbnelkOP2
1xycPA/9HC4vKCvP8BgGIBsoqrLXUqgL3jCL1VvFZ3MarIc95uJeaa/fU4n5w9Mq
Pz8mXbRD88OPfDRJfAXMftzKNvnE8uj0qKuWkwVe1zh7+kQToUqaEtKgHg20fJ3S
yo5BDBQH0ARfE+ia1osQgulqtai69NZJgHSOaDbK+rJdbXYDdD+s9R31BDBupaZo
IeFZ19vOlEBkYs17xPRWToBceuKiDXgDc7ZO5ysIsBHq9auVskVO9vZ9p5AK7Jvb
8WF+bQeD2feRzAK/GPnSwU7R2OLjOwQoK/lTVhu0vRDwEGQ7RHN+mx4LXxbwM/bI
7xvT4jGXCyDPVP6lxVq6peiuAkqKAyWO27Szu2e3MAZQXErvxuBQeO1nP6uoT0P/
c18I4jbTBzm0d+5JTvmOMkQiLGIE7ij6R13zQA0bP2yjQj0bCNA/+dIjdZmM14Jj
JqirJw5CLQjPPjldI7E3va8fyM5WGJqqdHCm9gNcMPrhcpYWYdrjkZe4yLImZbxm
lVpggkQ45DrZteaamG5aSNQuSamX0I1PYYGEe7sv8pjDlBhejORPca1gYgAkl57x
MhSJumj4hr+SRzeH2RRyfcLtC+NpebHKZ2wfjPirTXcS/qYhRzF9wVrnonMzmABk
AoPh3qw5uSfLZbobgOO6QV8vDECAFsttaT0UCMSkwfA64ihrBA0=
=S3W8
-----END PGP SIGNATURE-----

--RJEQeLWobomDZWRXOY7BE9iRFK93SRUOj--
