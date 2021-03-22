Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC513435F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 01:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVAZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 20:25:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:47105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhCVAZe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 20:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616372724;
        bh=LtDzlNLIfL+gKtN6mA3R+VBftUBcIJUOz2ao1awWX7I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lLjXJ1pJjWQLqPFZiH6q324WxMWyeLQZulgmJJsusCGAt+WP3go3EFp5dKgKB6Stf
         Hl6lZUy0NkyTxKOozvE62+vbU8mjFA5Q6PmByW5dNuWUJdVbtJ8alD9VtbHrc8navl
         AF7AbJM1ufUzyEUnuOqrwPpgNhayVRTdHXnasxhk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1lAIRl3W8Q-00VMND; Mon, 22
 Mar 2021 01:25:24 +0100
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210317012054.238334-1-davispuh@gmail.com>
 <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com>
 <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
 <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com>
 <CAOE4rSwOLQY1JWr-Mdq06Y9nwU_WcQBnfXZx3VWhRQGnBThHUQ@mail.gmail.com>
 <f48c758a-39a3-c73e-fc50-5ab37d2280f9@gmx.com>
 <CAOE4rSzF3g4nA3sXkzEi9MJxFGZ+Sp+POAQHVsXV531y4CJTiA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7db8f3ca-785b-e985-99eb-474aba82281f@gmx.com>
Date:   Mon, 22 Mar 2021 08:25:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAOE4rSzF3g4nA3sXkzEi9MJxFGZ+Sp+POAQHVsXV531y4CJTiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kAHSHsRphMQ6jbBwS8YTQPNGh3nIwCBUX+MG1kRZqginUhfgJn9
 8kxe9YRTcha13XfyHhQmh1jFIzzsWPdYSkRlbL0KmHmuTXrfLmFuRguSzxfCO4pIKEvnN6u
 BXay+kfj0jHnoGqG7S36uAn6weUFQaK83d+upEaBR85ccqfJHHnX2ASfE8bj2HThujyVDLK
 gd3FKfGe2b8PJ3YSJksvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hi5zYkN0ZrI=:IZEzptkPA/51VCgyjA+1we
 0uA954c4q+G0vr6hkAQwfDHHthjqHSRLUPbe8g3JKJcJyZmdJGM7YMksDZhgz8lozMnu2sziM
 OQPjm8VyRD4UwngSh7KlVj130c+gt4w/0bznmVy2WpL861xeyMpVyDGKcGoFvHrVLbUcwottF
 b5fOGdUQiZHb5o1P0WO8o4WNx6ZExC4Erc7erwb0Pcu+qNVdMJK7xtBQG93Wj37sbxKD5NDUk
 ixnzYavhINoJYyQh0Vw9w061Tstu+KwCTOWQFTicgVoRn1nWUfP0KqL2VUqcDxupmNOV4YzNi
 dPcFfLD8j+fgcOQVl31GQJvZgoVrp78r5EDoVPNnrsHCaGx0UCXr5S8qru3dy8dz2PL3OXJnh
 nSZd616T0/KtA2JGCuFE4oYigIrcQase9xvffOAz50oozzo0mNRGg/AOSfkn6r6C7ugp5iLti
 Eu1QDGrE+bf9wDTEWMM2lR50LJ0fe5iu/R9tR004kxst0mWEjCbyI9lcdFMT51v80TUPAHV9L
 csVRJ3C/mGZ0tLfSNpWmJ83fomSjGfxnbRBpQyBZQ84yCHVq0OW+tdEuaCM7W+D4RlZIRvEXQ
 3gioqL4cD/QOptalxNgvWx/KDzKf87t6BLvWob9CSARgWX3xCiGY9jQZdvwOD37VNEU/y2MMS
 /+W6EiNJS2x3MeZmlo60is6lShcoe/4rORnxwWvIO6UXtA+3z97BdSjzb9vXjLYCY4nRdVhjq
 ds+YVeoNc5M21u+fX4kRLqK2qlN2aptZCP2TU5a0pNw53DI4N/ki6hWeqVoUXDqJ69HiiPb/4
 Ut5CjQy2oIKQn32HFKqKOYfHXs6WC7V6OuvM0+i0Q/fQuCpNb8Y1WyZMbAD+oe/LjcTn0NiIv
 z9ZkhyujqoczCehuLglE7q/CUwNX9sWicTeaFWl2xnXO/nYLEL8es8HfhxeH5vMwDKL55EuBs
 WkQxslMlV8G87BX/+kPYVGR+TDlj+ajS4l5C+E0hY2esFKBuVAzkscpzfExbNWExxOOpmGnxr
 WqTnGtGjaxzylGuDW4SiLrUIka06K2Zsnj+ZLDJkeWmSKU95x93j96xP6yevKMSx8OF3C4ToC
 Lj9Rbg8Ee2+ZPAr/2eWUCFdF/SUiw3Dbcgw6tyH1h4bIGmt19M0jOHhQl+G4EapZ9dBP5akRM
 x/z7v7uECczI/iyL/Qt25hut5+cFYDd7uiEms5phI81mkaG3WBtkl6LI/IUQ4HsZJg+SoLnYj
 fg3Axh12u1dW9MRhx
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/22 =E4=B8=8A=E5=8D=885:54, D=C4=81vis Mos=C4=81ns wrote:
> sestd., 2021. g. 20. marts, plkst. 02:34 =E2=80=94 lietot=C4=81js Qu Wen=
ruo
> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>>
>>
>>
>> On 2021/3/19 =E4=B8=8B=E5=8D=8811:34, D=C4=81vis Mos=C4=81ns wrote:
>>> ceturtd., 2021. g. 18. marts, plkst. 01:49 =E2=80=94 lietot=C4=81js Qu=
 Wenruo
>>> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>>>>
>>>>
>>>>
>>>> On 2021/3/18 =E4=B8=8A=E5=8D=885:03, D=C4=81vis Mos=C4=81ns wrote:
>>>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 12:28 =E2=80=94 lietot=C4=81=
js Qu Wenruo
>>>>> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wrote:
>>>>>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=
=81js D=C4=81vis Mos=C4=81ns
>>>>>>> (<davispuh@gmail.com>) rakst=C4=ABja:
>>>>>>>>
>>>>>>>> Currently if there's any corruption at all in extent tree
>>>>>>>> (eg. even single bit) then mounting will fail with:
>>>>>>>> "failed to read block groups: -5" (-EIO)
>>>>>>>> It happens because we immediately abort on first error when
>>>>>>>> searching in extent tree for block groups.
>>>>>>>>
>>>>>>>> Now with this patch if `ignorebadroots` option is specified
>>>>>>>> then we handle such case and continue by removing already
>>>>>>>> created block groups and creating dummy block groups.
>>>>>>>>
>>>>>>>> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
>>>>>>>> ---
>>>>>>>>      fs/btrfs/block-group.c | 14 ++++++++++++++
>>>>>>>>      fs/btrfs/disk-io.c     |  4 ++--
>>>>>>>>      fs/btrfs/disk-io.h     |  2 ++
>>>>>>>>      3 files changed, 18 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>>>>>>> index 48ebc106a606..827a977614b3 100644
>>>>>>>> --- a/fs/btrfs/block-group.c
>>>>>>>> +++ b/fs/btrfs/block-group.c
>>>>>>>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_f=
s_info *info)
>>>>>>>>             ret =3D check_chunk_block_group_mappings(info);
>>>>>>>>      error:
>>>>>>>>             btrfs_free_path(path);
>>>>>>>> +
>>>>>>>> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOT=
S)) {
>>>>>>>> +               btrfs_put_block_group_cache(info);
>>>>>>>> +               btrfs_stop_all_workers(info);
>>>>>>>> +               btrfs_free_block_groups(info);
>>>>>>>> +               ret =3D btrfs_init_workqueues(info, NULL);
>>>>>>>> +               if (ret)
>>>>>>>> +                       return ret;
>>>>>>>> +               ret =3D btrfs_init_space_info(info);
>>>>>>>> +               if (ret)
>>>>>>>> +                       return ret;
>>>>>>>> +               return fill_dummy_bgs(info);
>>>>>>
>>>>>> When we hit bad things in extent tree, we should ensure we're mount=
ing
>>>>>> the fs RO, or we can't continue.
>>>>>>
>>>>>> And we should also refuse to mount back to RW if we hit such case, =
so
>>>>>> that we don't need anything complex, just ignore the whole extent t=
ree
>>>>>> and create the dummy block groups.
>>>>>>
>>>>>
>>>>> That's what we're doing here, `ignorebadroots` implies RO mount and
>>>>> without specifying it doesn't mount at all.
>>>>>
>>>>>>>
>>>>>>> This isn't that nice, but I don't really know how to properly clea=
n up
>>>>>>> everything related to already created block groups so this was eas=
iest
>>>>>>> way. It seems to work fine.
>>>>>>> But looks like need to do something about replay log aswell becaus=
e if
>>>>>>> it's not disabled then it fails with:
>>>>>>>
>>>>>>> [ 1397.246869] BTRFS info (device sde): start tree-log replay
>>>>>>> [ 1398.218685] BTRFS warning (device sde): sde checksum verify fai=
led
>>>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
>>>>>>> [ 1398.218803] BTRFS warning (device sde): sde checksum verify fai=
led
>>>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
>>>>>>> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:30=
54:
>>>>>>> errno=3D-5 IO failure
>>>>>>> [ 1398.218828] BTRFS: error (device sde) in
>>>>>>> btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
>>>>>>> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
>>>>>>> errno=3D-5 IO failure (Failed to recover log tree)
>>>>>>> [ 1398.229048] BTRFS error (device sde): open_ctree failed
>>>>>>
>>>>>> This is because we shouldn't allow to do anything write to the fs i=
f we
>>>>>> have anything wrong in extent tree.
>>>>>>
>>>>>
>>>>> This is happening when mounting read-only. My assumption is that it
>>>>> only tries to replay in memory without writing anything to disk.
>>>>>
>>>>
>>>> We lacks the check on log tree.
>>>>
>>>> Normally for such forced RO mount, log replay is not allowed.
>>>>
>>>> We should output a warning to prompt user to use nologreplay, and rej=
ect
>>>> the mount.
>>>>
>>>
>>> I'm not familiar with log replay but couldn't there be something
>>> useful (ignoring ref counts) that would still be worth replaying in
>>> memory?
>>>
>> Log replay means metadata write.
>>
>> Any write needs a valid extent tree to find out free space for new
>> metadata/data.
>>
>> So no, we can't do anything but completely ignoring the log.
>>
>
> I see, updated patch. But even then it seems it could be possible to
> add new ramdisk and make allocations there (eg. create new extent tree
> there) thus allowing replay.

The problem here is, since the extent tree is corrupted, we won't know
which range has metadata already.
While metadata CoW, just like its name, needs to CoW, which means it
can't writeback (even just in memory) to anywhere we have metadata.

The worst case is, we choose a bytenr for the new metadata to be (in
memory), but it turns out later read needs to read metadata from the
exactly same location.

> I guess that's way too much work.

And we gain nothing but tons of potential bugs.


BTW, I'm curious what's your test cases? As it seems you're using
log-replay but if we hit anything wrong for the replayed data, it means
btrfs kernel module has something wrong.
Did you add extra corruption for the replayed data, or it's some bug
unexposed?

Thanks,
Qu

> Anyway thanks for feedback!
>
> Best regards,
> D=C4=81vis
>
