Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51CB2E7663
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 07:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL3Fuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 00:50:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:44031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgL3Fuy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 00:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609307359;
        bh=fTVru6JgrP2J/uyih68I2kqTrR92r9EU7IovEABsreo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Mlz7jDXmIO6hrCXW1e+M4J7xWdtXI+I4MwdDkodudY2Y2HGdUAZEZ9qDnIovblAOV
         S34NFDprQ71ofeM0IVbCNtz/G3PBHFzWSkgcLbX0ySOuOquLRxp14q20D5BDYLJpoE
         eujk55eXxtoukVlBc1WL/W1KID9PxSlBzJQ+BWww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1kys4U1Xu4-004PLd; Wed, 30
 Dec 2020 06:49:19 +0100
Subject: Re: [PATCH] btrfs: relocation: output warning message for leftover v1
 space cache before aborting current data balance
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <02f6b3d7-c502-fe29-ec74-cce99922296c@gmx.com>
 <43269375-cefd-8059-5335-ed891fdd26fe@suse.com>
 <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
 <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
 <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
 <e811efd8b2936a559d665e7303ce0873@lesimple.fr>
 <9c981dde8dafe773e2a99417e4935f6b@lesimple.fr>
 <e8107ffa29ffe7285b1da76805bd5fc4@lesimple.fr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8d9becab-de4c-da3f-967e-1104648ae56d@gmx.com>
Date:   Wed, 30 Dec 2020 13:49:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e8107ffa29ffe7285b1da76805bd5fc4@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o5jDtGdSI/tftNlBbEaJShRrFJ36I/wcwLLbEuwU0KoynHDkQPM
 XyDo6S51bPk/a92IV9/34SKlXmX1m5kognGcyU8/By730RGf0/eB8b/CFlwq1Z8XgoPrv34
 7P/Ej+sIgbUWWA7++sOKAzgqt9Ij5IL6kthRI9K5zN2kBMNV01Xex/QiQEhPFSMqpJMzEB+
 yxr66JelJyNOw/T1gDilg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t9b4Hhl5vvY=:xkBWY0k5xvyYWAzQjqkQF5
 893xE4zFg6tS7kYttafElbQAJWql3iNQ36jZUJqejKqvsHPjZyQNhOw0GrZLmhPitUEI43du7
 2L6mpJZS0l8VAP7CnDUURslh4AscmR1JL9h7mhWICrjbYcRtnn8HXKi/jbZTmJsMB/cJ2dZ7h
 Zxl3fy2ESUkLWcBxlHq4SCbEOf9MBu4IkN6cnwVVNhi9uE8WIoVYKsfid+YtwvHlie0sxDhb9
 TrU+4r+ju7udukWQ0fex8KjVr9RsDifaDVYJm6g27JjY4Ecx6GYbDsZFeE2kANGplIyRHputv
 qYi+9biV2Zp7znKSRa5qsgwKC+moVAUkZBrS1pJLeciYF5LujdhQ6x/JLN8C7GbEmKTUbBnXp
 Qjpl4GfExZaQebJrrhOjrQVcoMlLOaw05P69rw/WO6FKHC8KAK395wYsBrthXRD8ydc8weNk0
 rbPWx/gq/WBPJv5vwo0P0qeDEna4RASg+pOP07DT/TceFueO8bxkPPB7MjBXlrc6ocLzhHSHB
 We8dLEI0VVlGBG1dM32ON3O7yaiNTtHKWbCOcqf6Iw3Q4x7/nKPV1b0hoigjGkkeljOE/a12L
 2fRfS5GD8pY36isRoyBFHQOtb919bMFqZeaXkpAErP12d9UcvVLUhZCywWu5ZyP3I73dLYbtj
 frfc14x/0o+j1k2bcl/AtvraN6zXKnqv05KWJT4LzYdQOqgLBLicMjJ/qFrUbAzvH90AIcCPh
 lQJk0FIMiIbsv/q0oemtMJcRaG9uTvuoXupophE81CyyvqnblW8FjsKJfFIR7/eOSBhDLE+VW
 XzDutsnIzTJQT88Cwqg5O7BDR7WawNup1PWdTpRHb3I+SALQweo3JSseLNaisrCO4rhNZ4wCz
 G/aWwPSOFjMfwXoMsbVQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8B=E5=8D=889:17, St=C3=A9phane Lesimple wrote:
> December 29, 2020 2:08 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:
>
>> On 2020/12/29 =E4=B8=8B=E5=8D=888:51, St=C3=A9phane Lesimple wrote:
>>
>>> December 29, 2020 1:43 PM, "Qu Wenruo" <wqu@suse.com> wrote:
>>>
>>>> On 2020/12/29 =E4=B8=8B=E5=8D=888:30, St=C3=A9phane Lesimple wrote:
>>>
>>> December 29, 2020 12:32 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote=
:
>>>
>>> On 2020/12/29 =E4=B8=8B=E5=8D=887:08, St=C3=A9phane Lesimple wrote:
>>>
>>> December 29, 2020 11:31 AM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote=
:
>>>
>>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep EXTEN=
T_DA
>>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>>> item 12 key (72271 EXTENT_DATA 0) itemoff 14310 itemsize 53
>>> item 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53
>>> Mind to dump all those related inodes?
>>>
>>> E.g:
>>>
>>> $ btrfs ins dump-tree -t root <dev> | gerp 51933 -C 10
>>>
>>> Sure. I added -w to avoid grepping big numbers just containing the dig=
its 51933:
>>>
>>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep 51933=
 -C 10 -w
>>> generation 2614632 root_dirid 256 bytenr 42705449811968 level 2 refs 1
>>> lastsnap 2614456 byte_limit 0 bytes_used 101154816 flags 0x1(RDONLY)
>>> uuid 1100ff6c-45fa-824d-ad93-869c94a87c7b
>>> parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397c
>>> ctransid 1337630 otransid 1249372 stransid 0 rtransid 0
>>> ctime 1554266422.693480985 (2019-04-03 06:40:22)
>>> otime 1547877605.465117667 (2019-01-19 07:00:05)
>>> drop key (0 UNKNOWN.0 0) level 0
>>> item 25 key (51098 ROOT_BACKREF 5) itemoff 10067 itemsize 42
>>> root backref key dirid 534 sequence 22219 name 20190119_070006_hourly.=
7
>>> item 26 key (51933 INODE_ITEM 0) itemoff 9907 itemsize 160
>>> generation 0 transid 1517381 size 262144 nbytes 30553407488
>>> block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>>> sequence 116552 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
>>> atime 0.0 (1970-01-01 01:00:00)
>>> ctime 1567904822.739884119 (2019-09-08 03:07:02)
>>> mtime 0.0 (1970-01-01 01:00:00)
>>> otime 0.0 (1970-01-01 01:00:00)
>>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>>> generation 1517381 type 2 (prealloc)
>>> prealloc data disk byte 34626327621632 nr 262144
>>>> Got the point now.
>>>>
>>>> The type is preallocated, which means we haven't yet written space ca=
che
>>>> into it.
>>>>
>>>> But the code only checks the regular file extent (written, not
>>>> preallocated).
>>>>
>>>> So the proper fix would looks like this:
>>>>
>>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>>> index 19b7db8b2117..1d73d7c2fbd7 100644
>>>> --- a/fs/btrfs/relocation.c
>>>> +++ b/fs/btrfs/relocation.c
>>>> @@ -2975,11 +2975,14 @@ static int delete_v1_space_cache(struct
>>>> extent_buffer *leaf,
>>>> return 0;
>>>>
>>>> for (i =3D 0; i < btrfs_header_nritems(leaf); i++) {
>>>> + u8 type;
>>>> btrfs_item_key_to_cpu(leaf, &key, i);
>>>> if (key.type !=3D BTRFS_EXTENT_DATA_KEY)
>>>> continue;
>>>> ei =3D btrfs_item_ptr(leaf, i, struct
>>>> btrfs_file_extent_item);
>>>> - if (btrfs_file_extent_type(leaf, ei) =3D=3D
>>>> BTRFS_FILE_EXTENT_REG &&
>>>> + type =3D btrfs_file_extent_type(leaf, ei);
>>>> + if ((type =3D=3D BTRFS_FILE_EXTENT_REG ||
>>>> + type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) &&
>>>> btrfs_file_extent_disk_bytenr(leaf, ei) =3D=3D
>>>> data_bytenr) {
>>>> found =3D true;
>>>> space_cache_ino =3D key.objectid;
>>>>
>>>> With this, the relocation should finish without problem.
>>>
>>> Aaah, it makes sense indeed.
>>>
>>> Do you want me to try this fix right now, or do you want to have a loo=
k
>>> at the btrfs-progs crash first? I don't know if it's related, but if i=
t is,
>>> then maybe I won't be able to reproduce it again after finishing the b=
alance.
>>
>> The problem is, I'm not that confident with v2 space cache debugging,
>> thus can't help much.
>>
>> But at least, the problem you're reporting doesn't really need a
>> btrfs-check repair.
>> Just a kernel fix would be enough.
>
> Yes indeed.
>
>>> I don't mind leaving the FS in this state for a few more days/weeks if=
 needed.
>>
>> That's fine if you want some one to look into the btrfs-progs bug.
>
> I'll leave it like this up to, let's say, mid-January.

BTW, would you mind to dump the root tree?

# btrfs ins dump-tree -t root <device>

I'm more interested in the half dropped v1 space cache. Currently
although they are sane (with proper inode items), I'm a little concerned
if current v1 space cache cleanup can remove them.

Feel free to remove any subvolume names.

Thanks,
Qu

> If nobody has expressed interest
> in looking into this other problem, I'll apply your final patch and comp=
lete the balance,
> so that you can add a Tested-By.
>
>> I'll submit a proper bug fix soon.
>
> Thanks,
>
> Good evening!
>
