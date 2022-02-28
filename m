Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1914C6E2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiB1N37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 08:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiB1N37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 08:29:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F996D863
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646054951;
        bh=8In1hnOErtowiO2FaHHnk7K+ovXYxwh9J5GUHGjn/14=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NFJH5tTK5x7W1+fY/1ailnv6Sf5fGCIpLKgBj9pVH9n3+GsjJuv2PhdScHbXy7mdx
         DXEOPpxIF5rYqlV1TfOzfTbC4UgqSzuU7MuppMejXIDY5/lop1JHNn0oYeJAanp9Rw
         t3JHWDBlZu5BtU1AzqwolTRJD897AxP+5GuR+KUk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1oD3ok3ZUG-00tDv9; Mon, 28
 Feb 2022 14:29:11 +0100
Message-ID: <c04bcbb8-58e1-82e3-7d2d-6d6cebefab5c@gmx.com>
Date:   Mon, 28 Feb 2022 21:29:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
 <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
 <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
 <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
 <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com>
 <07588d0a-293b-643e-f2c5-ebeb74023c4b@gmx.com>
 <CA+8xDSqppu9yDqKbKZNPrwE2zJy9MPB6NM-WCuoZTDQ4-=r6EA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CA+8xDSqppu9yDqKbKZNPrwE2zJy9MPB6NM-WCuoZTDQ4-=r6EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3dxcIFJlPGRi1+cfrUxmNkjX4mXF/PQdMRm4rWY//fmbtPKtbq3
 gWI/iTj5k9XI87Af5ENZUM+6OEgB4qvNU3WGiG1eNecjv8W7XIusowAoAR6MaQpRUhKDDtt
 U7/Lbx5Uzt2q6ppJ6QphJ4wn521dWR2rqsWwT+tzrqZzNiZTFlHfdNcOci8jLeJkS4nzQYF
 r9iWj7xyl+f7K24u/4BXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/4S7tpItTOE=:onq8MZ5wV1Md0kfUvrkJa0
 ke2gkE1tJZ95y2x2Jy9e1LzKkjWIn3W0nk+MtSeMdX227h6RvSn8q2LpaEhr5Vcp35kDCdktO
 he+C6hJCfqO5UR/ihLVSL/Hqg41kZ4CgBoYlVnob4K/6HVDljaVh5+UVyYe6n7dKh68Ss9Zep
 7pOlhdB//tgXK0cDnuxLp8h6n+rEmoi8KoZAx7oyZCQGHxN2IirazLyJAFxc6Ug95AWJntVle
 5a/FZoCYR7olDc0Ha61cIWpK9Tx9Vb9IbYW/u/eDC/9LMxJ6/2xErthrxBe1a5ZblCyeXpehS
 /qKhk+FtRyS+w2bPkJXgmZLLZQm/hbfeH4yZGqpviI4m8Bk2p+SNd4TXGJKfQ9qGh14mdGVG0
 ScJaoUaXP8Ofe0vg9kASaX3NDpmiSoAShv7YIgK6fmlj18jtBBgld/8pn5kGSNlNJZYlvy3bp
 5rq+yUYIR6hm5s69FpNHs9Lup7Ia89gHdC3FdFx48rtwCTLZmkmUs2ujBA7DJ95Qq3uFP8Q0t
 N9B7KAlQohqxgLs75xhCMa8qtJcBtUgkoo+/qB21O11H5yg4OqeuPveeUcjzlx9HliRzFyEzu
 bZf1Ei5h2c6noPffB0PGGG4nxpQhgth+61UHtxDoZJy8ym6cei44OGRB3rUlTuJSoo0tY6eiz
 S6tE3zk17Z0HtPgoncEHBFkkdRkFzJK3Q8OLKIBtEcnwQrlXMsZOw01A0aCd4EhZvlemaLIBU
 7bScsPcBjF9FTtr3csCJ2j5ct1n4h8qsJdupDbQrB0IR+MiceD3swSetcLAbLUgSsirX333qs
 PQa3vSiwReegK3pVmWWt3M+yLgX3xgbztYC5H5AcxDJBt8z2LT/1JLoHjkp08DfH+Rv6OuMGP
 ifqtoXqEgtscao1yk0Kr++PVx6HNabbrhn448xBmX8o3Ozr6K49NL/egBR1ULLYnWbExGe00/
 g5wP6iJDqndsbZX3yFxS3vv54DvUFz2S6d/n+og2DXJn4Fpta9HFhyB0TcuHv48qbWtsVku/i
 ejsP9mQmzmlOK/+rUL95RsUfHqY14KptLQJDoSkuhjhlgFgJLbNs/bBBpeD9bbYBKIIs6TIHA
 qBPAd7eW8Bw4Fk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 21:13, Luca B=C3=A9la Palkovics wrote:
> Am Mo., 28. Feb. 2022 um 14:03 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx=
.com>:
>>
>>
>>
>> On 2022/2/28 20:51, Anand Jain wrote:
>>> On 28/02/2022 17:21, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/28 17:01, Anand Jain wrote:
>>>>> On 28/02/2022 16:54, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/2/28 16:00, Anand Jain wrote:
>>>>>>> On 28/02/2022 15:05, Qu Wenruo wrote:
>>>>>>>> [BUG]
>>>>>>>> There is a report that a btrfs has a bad super block num devices.
>>>>>>>>
>>>>>>>> This makes btrfs to reject the fs completely.
>>>>>>>>
>>>>>>>>     BTRFS error (device sdd3): super_num_devices 3 mismatch with
>>>>>>>> num_devices 2 found here
>>>>>>>>     BTRFS error (device sdd3): failed to read chunk tree: -22
>>>>>>>>     BTRFS error (device sdd3): open_ctree failed
>>>>>>>>
>>>>>>>> [CAUSE]
>>>>>>>> During btrfs device removal, chunk tree and super block num devs =
are
>>>>>>>> updated in two different transactions:
>>>>>>>>
>>>>>>>>     btrfs_rm_device()
>>>>>>>>     |- btrfs_rm_dev_item(device)
>>>>>>>>     |  |- trans =3D btrfs_start_transaction()
>>>>>>>>     |  |  Now we got transaction X
>>>>>>>>     |  |
>>>>>>>>     |  |- btrfs_del_item()
>>>>>>>>     |  |  Now device item is removed from chunk tree
>>>>>>>>     |  |
>>>>>>>>     |  |- btrfs_commit_transaction()
>>>>>>>>     |     Transaction X got committed, super num devs untouched,
>>>>>>>>     |     but device item removed from chunk tree.
>>>>>>>>     |     (AKA, super num devs is already incorrect)
>>>>>>>>     |
>>>>>>>>     |- cur_devices->num_devices--;
>>>>>>>>     |- cur_devices->total_devices--;
>>>>>>>>     |- btrfs_set_super_num_devices()
>>>>>>>>        All those operations are not in transaction X, thus it wil=
l
>>>>>>>>        only be written back to disk in next transaction.
>>>>>>>>
>>>>>>>> So after the transaction X in btrfs_rm_dev_item() committed, but
>>>>>>>> before
>>>>>>>> transaction X+1 (which can be minutes away), a power loss happen,
>>>>>>>> then
>>>>>>>> we got the super num mismatch.
>>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>>>>> The cause part is much better now. So why not also update the supe=
r
>>>>>>> num_devices in the same transaction?
>>>>>>
>>>>>> A lot of other things like total_rw_bytes.
>>>>>>
>>>>>> Not to mention, even we got a fix, it will be another patch.
>>>>>>
>>>>>> Since the handling of such mismatch is needed to handle older kerne=
ls
>>>>>> anyway.
>>>>>
>>>>>    Ok.
>>>>>
>>>>>
>>>>>>>> [FIX]
>>>>>>>> Make the super_num_devices check less strict, converting it from =
a
>>>>>>>> hard
>>>>>>>> error to a warning, and reset the value to a correct one for the
>>>>>>>> current
>>>>>>>> or next transaction commitment.
>>>>>>>
>>>>>>> So that we can leave the part where we identify and report num_dev=
ices
>>>>>>> miss-match as it is.
>>>>>>
>>>>>> I didn't get your point.
>>>>>> What do you want to get from this patch?
>>>>>>
>>>>>> Isn't this already the behavior of this patch?
>>>>>
>>>>>    Let me clarify - we don't need this patch if we fix the actual bu=
g as
>>>>> above. IMO.
>>>>
>>>> Big NO NO.
>>>>
>>>> The damage is already done, we must be responsible for whatever damag=
e
>>>> we caused, especially the damage has already reached disk.
>>>>
>>>> Just fixing the cause and call it a day is definitely not a
>>>> responsible way.
>>>>
>>>> Especially when the damage is done, you have no way to mount it, just
>>>> like the reporter.
>>>>
>>>> You dare to say the same thing to the end user?
>>>
>>> You have a btrfs-progs patch to recover from that situation. Right?
>>> Plus, I suppose you are sending a kernel patch for the actual bug
>>> which is causing this corruption. No?
>>
>> Not yet. It can be more complex.
>> Feel free to try to fix it properly.
>>
>>>
>>> This patch is the reporter side fix. I don't encourage fixing the
>>> reporter because a similar corruption might happen for reasons unknown
>>> yet. For example, raid1 split-brain? Which is not yet completely
>>> analyzed and test-cased yet.
>>
>> No matter whatever the reason, you still can't deny the fact that, if
>> just super num dev mismatches, there is no need to reject the full fs.
>
> As a user .. I expected to be able to mount it with "-o degraded" ..
> or/and "-o recovery,ro"

With this patch, you won't need any special mount option.
Since btrfs knows it's just a number mismatch, nothing to worry.

>
> But at the same time .. I don't understand what this "num_devices"
> does and/or why it's required...
> Or what effects it has on the data-integrity..
>
> It was just very confusing to me because "btrfs check" said everything i=
s fine..

That's why there is also another patchset for btrfs-progs, to detect and
repair the problem.
(Although now with this patch, you won't even notice a problem, kernel
will automatically fix the problem, other than rejecting it)

Thanks,
Qu

>
>> We have tree-checker for each chunk leave, and rw bytes check already.
>> Even the possible bit flip check for num devs.
>>
>> The super num devs check doesn't make much sense except causing more
>> hassles to the end uesr.
>>
>> The report is just giving us a chance to review if the behavior is
>> really helpful.
>> To me, NO.
>>
>>>
>>> In my POV.
>>>
>>> Thanks, Anand
>>>
>>>
>>>
>>>>>>> Thanks, Anand
>>>>>>>
>>>>>>>
>>>>>>>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.=
com>
>>>>>>>> Link:
>>>>>>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_=
cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>>>> ---
>>>>>>>> Changelog:
>>>>>>>> v2:
>>>>>>>> - Add a proper reason on why this mismatch can happen
>>>>>>>>     No code change.
>>>>>>>> ---
>>>>>>>>    fs/btrfs/volumes.c | 8 ++++----
>>>>>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>>>>> index 74c8024d8f96..d0ba3ff21920 100644
>>>>>>>> --- a/fs/btrfs/volumes.c
>>>>>>>> +++ b/fs/btrfs/volumes.c
>>>>>>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct
>>>>>>>> btrfs_fs_info
>>>>>>>> *fs_info)
>>>>>>>>         * do another round of validation checks.
>>>>>>>>         */
>>>>>>>>        if (total_dev !=3D fs_info->fs_devices->total_devices) {
>>>>>>>> -        btrfs_err(fs_info,
>>>>>>>> -       "super_num_devices %llu mismatch with num_devices %llu fo=
und
>>>>>>>> here",
>>>>>>>> +        btrfs_warn(fs_info,
>>>>>>>> +       "super_num_devices %llu mismatch with num_devices %llu fo=
und
>>>>>>>> here, will be repaired on next transaction commitment",
>>>>>>>>                  btrfs_super_num_devices(fs_info->super_copy),
>>>>>>>>                  total_dev);
>>>>>>>> -        ret =3D -EINVAL;
>>>>>>>> -        goto error;
>>>>>>>> +        fs_info->fs_devices->total_devices =3D total_dev;
>>>>>>>> +        btrfs_set_super_num_devices(fs_info->super_copy, total_d=
ev);
>>>>>>>>        }
>>>>>>>>        if (btrfs_super_total_bytes(fs_info->super_copy) <
>>>>>>>>            fs_info->fs_devices->total_rw_bytes) {
>>>>>>>
>>>>>
>>>
