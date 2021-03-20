Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0E34297B
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 01:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCTAey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 20:34:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:42527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhCTAe2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 20:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616200460;
        bh=aOTWQ5venLz7NwFAO6rPkbHTKJFqh7QOlQrdKKM2Hlg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EH68PRRfDzSzyfFTG68lAKYONrDWP/4zzMsWtOlZ8IVUW3VNAvJJM3mlpdcX0h5fd
         t0rdCCcuaEtP7FSliOAVcpX30QbBijPQO42svAkqJoghxHM5S4oSlcec2PBDLvry1t
         LCmmgwUq36HPPP0JrNVHDYxAaHtF/ASYVy+RzrdQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72oB-1lKPhM1DrT-008XAU; Sat, 20
 Mar 2021 01:34:19 +0100
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210317012054.238334-1-davispuh@gmail.com>
 <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com>
 <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
 <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com>
 <CAOE4rSwOLQY1JWr-Mdq06Y9nwU_WcQBnfXZx3VWhRQGnBThHUQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f48c758a-39a3-c73e-fc50-5ab37d2280f9@gmx.com>
Date:   Sat, 20 Mar 2021 08:34:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAOE4rSwOLQY1JWr-Mdq06Y9nwU_WcQBnfXZx3VWhRQGnBThHUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UYuhJ4QP8HEdj6JjvSJpCAcZxkx1KEios0exHg3uT6rqCT0NQrv
 gRjZnQJs17VUIWjLwXZCsoKf9QeYt22zd2KzAptmiRmNAeDwkl29DTg90vKw/HK3WPmqDCA
 3f3L9YWAJo99Ydn6KHa+KIoTIrbS9gVj8dpw4t2eD4rBYdDeoN5QMBkq87IpTaX+rJ5q8H0
 snzfwVl/jw6iGg+yqo1YA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LXKv7PmoN3o=:2shYwHtD63HWmr0CmqoqHn
 QcghOFUR7cdIrO86jxJBwbCnuQVo8t+KPPRnBlmDhASCcZUOOmDRVyOvQfzTZOUY9PM9B2fam
 5BVzJYnN2mRZ6CjbnOHu64wVeDPAnwRsK7UrhtETAbs67pk4Z8gnzkrk2/cBxr/rKXx4SEq3W
 AOSeXzTdnBrwPOPg+FZbEke8qozibLqL6Y2O4UsjefOLw3CMyBPp+Ec+EzfUwVTGNIAWQ5Ck5
 KXSFzKZu4Dc/xZ01WacKMcQVimkyia6KwNc2tKvX1ZuEBXmRkH8U4j1VW5u7O2wwvw7kGE0rh
 z/BLGwPN/moiisFzkhyvhFz6vPUJzsPS9sw89ZKW8DqsLj+C140GFd2b7gozTIyEqI2nUXTHC
 LcBH5r+HjJTHm6qqIXjdxmyCBTmBmVix38ni+F4zOjpHh2lBKta1GdFXrKqlbnofFVed/2eZr
 97+DvALIrRKJpYHb/qSb2ShKS6TK0UcZsEXNzLUKpkNdRo7J9qB/tyt7RyQ5ibpcnEDnFpoRT
 ioq7DU27SAALKVaRZ2OKvdUR9kKxqyo5HLlM/HB4kr7cXpxXMWwd7Xhblu08/8kPuxXwXAV67
 cDUdSB0DODHbDZXKjRxRS3wZPG0mCGjeHOvuOAO40+JBER48FZP6bC30sgffH8t27+OsY4FUu
 hZTtaKU0Sw58lSmgVZqEFpmqk3ttTgLCbYslZipcP+7DYQ6a37b8mBcwXIHq4qM2tTfvw2trQ
 J7xso5iEv9xVuq8D6f5AvWknRdkB53U6bg2Jg0XoHHw1jGKqDIGHlQKY7X14nkg/Aa/qrf9iV
 ic/DCA0SUR0CNDBefH5+u+dyPQXmmLR/RY8AyoIYr/tUQwuSsdQryZzQ/Tb+gsr1BSUdzXMU5
 zP1us/7o6mpxzkrq9BFQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/19 =E4=B8=8B=E5=8D=8811:34, D=C4=81vis Mos=C4=81ns wrote:
> ceturtd., 2021. g. 18. marts, plkst. 01:49 =E2=80=94 lietot=C4=81js Qu W=
enruo
> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>>
>>
>>
>> On 2021/3/18 =E4=B8=8A=E5=8D=885:03, D=C4=81vis Mos=C4=81ns wrote:
>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 12:28 =E2=80=94 lietot=C4=81js=
 Qu Wenruo
>>> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>>>>
>>>>
>>>>
>>>> On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wrote:
>>>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=81=
js D=C4=81vis Mos=C4=81ns
>>>>> (<davispuh@gmail.com>) rakst=C4=ABja:
>>>>>>
>>>>>> Currently if there's any corruption at all in extent tree
>>>>>> (eg. even single bit) then mounting will fail with:
>>>>>> "failed to read block groups: -5" (-EIO)
>>>>>> It happens because we immediately abort on first error when
>>>>>> searching in extent tree for block groups.
>>>>>>
>>>>>> Now with this patch if `ignorebadroots` option is specified
>>>>>> then we handle such case and continue by removing already
>>>>>> created block groups and creating dummy block groups.
>>>>>>
>>>>>> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
>>>>>> ---
>>>>>>     fs/btrfs/block-group.c | 14 ++++++++++++++
>>>>>>     fs/btrfs/disk-io.c     |  4 ++--
>>>>>>     fs/btrfs/disk-io.h     |  2 ++
>>>>>>     3 files changed, 18 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>>>>> index 48ebc106a606..827a977614b3 100644
>>>>>> --- a/fs/btrfs/block-group.c
>>>>>> +++ b/fs/btrfs/block-group.c
>>>>>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_=
info *info)
>>>>>>            ret =3D check_chunk_block_group_mappings(info);
>>>>>>     error:
>>>>>>            btrfs_free_path(path);
>>>>>> +
>>>>>> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS)=
) {
>>>>>> +               btrfs_put_block_group_cache(info);
>>>>>> +               btrfs_stop_all_workers(info);
>>>>>> +               btrfs_free_block_groups(info);
>>>>>> +               ret =3D btrfs_init_workqueues(info, NULL);
>>>>>> +               if (ret)
>>>>>> +                       return ret;
>>>>>> +               ret =3D btrfs_init_space_info(info);
>>>>>> +               if (ret)
>>>>>> +                       return ret;
>>>>>> +               return fill_dummy_bgs(info);
>>>>
>>>> When we hit bad things in extent tree, we should ensure we're mountin=
g
>>>> the fs RO, or we can't continue.
>>>>
>>>> And we should also refuse to mount back to RW if we hit such case, so
>>>> that we don't need anything complex, just ignore the whole extent tre=
e
>>>> and create the dummy block groups.
>>>>
>>>
>>> That's what we're doing here, `ignorebadroots` implies RO mount and
>>> without specifying it doesn't mount at all.
>>>
>>>>>
>>>>> This isn't that nice, but I don't really know how to properly clean =
up
>>>>> everything related to already created block groups so this was easie=
st
>>>>> way. It seems to work fine.
>>>>> But looks like need to do something about replay log aswell because =
if
>>>>> it's not disabled then it fails with:
>>>>>
>>>>> [ 1397.246869] BTRFS info (device sde): start tree-log replay
>>>>> [ 1398.218685] BTRFS warning (device sde): sde checksum verify faile=
d
>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
>>>>> [ 1398.218803] BTRFS warning (device sde): sde checksum verify faile=
d
>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
>>>>> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:3054=
:
>>>>> errno=3D-5 IO failure
>>>>> [ 1398.218828] BTRFS: error (device sde) in
>>>>> btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
>>>>> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
>>>>> errno=3D-5 IO failure (Failed to recover log tree)
>>>>> [ 1398.229048] BTRFS error (device sde): open_ctree failed
>>>>
>>>> This is because we shouldn't allow to do anything write to the fs if =
we
>>>> have anything wrong in extent tree.
>>>>
>>>
>>> This is happening when mounting read-only. My assumption is that it
>>> only tries to replay in memory without writing anything to disk.
>>>
>>
>> We lacks the check on log tree.
>>
>> Normally for such forced RO mount, log replay is not allowed.
>>
>> We should output a warning to prompt user to use nologreplay, and rejec=
t
>> the mount.
>>
>
> I'm not familiar with log replay but couldn't there be something
> useful (ignoring ref counts) that would still be worth replaying in
> memory?
>
Log replay means metadata write.

Any write needs a valid extent tree to find out free space for new
metadata/data.

So no, we can't do anything but completely ignoring the log.

Thanks,
Qu
