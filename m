Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889554607B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348257AbiFJIu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348390AbiFJIuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 04:50:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71210918E
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654850999;
        bh=C1KqeMQc0ddI4+nUNmyDbufpvXRegWzQcDmDmMH8lAA=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=LBpqfsCfDcUa0Q0M++jIi00vHmjw7ZpKtthTYCqpDhLF62OIe3eqQl40bcm/qr0B/
         CuDxAJkrD6XQ0pMySWytTibn11ObyoonzawgjLSGvgVNfecZ6djT4ZhmmQPNNa16VA
         mBEyHJh3gAQ3XBB6xvTBXJ5uyDRRyE9LMgnx4GmY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNct-1nXQBl0RsV-00hum3; Fri, 10
 Jun 2022 10:49:58 +0200
Message-ID: <92c7c01b-7aa4-2a1d-7578-ac77abdc3e91@gmx.com>
Date:   Fri, 10 Jun 2022 16:49:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
 <ed4f2880-b4f3-cf16-00c9-b107141a7421@gmx.com>
 <d1957ade-a9be-c1e4-1356-89d3e73bb121@suse.com>
 <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
 <20220610083929.GA3742796@falcondesktop>
 <71ac5734-b481-972a-f562-5b2ef1611df6@gmx.com>
In-Reply-To: <71ac5734-b481-972a-f562-5b2ef1611df6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QkGRncJCMqh1+9oU8RwOeXQ8KmKVdHjfllatlq1v0hIYccSRgUG
 2oBN5s90maQoCOnGS96yI60n+SFf8NUg5DQ9B93sRfqbxKzpjNJVo8UHlC5EyJ5TQDU+KR7
 70/6B1stkdbAa1Rrz2zDXE96YUZ7rqSCQWZPbjeMjs4n1uT7PTi1JsysJdOMmTSt4iS8BXW
 ZvI9kSsh4/yhKF5Ejh1SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDuh+b5I5Ns=:gUMqTLbuI9qkrMbRL3um8C
 /JgwLMN20KDBDA+7T/pbwZ2FcY5W5RnTNSO6qgLI2v0k0ElSGZEJy/DHFTvsR+/5g8Pgu8VV7
 kFWu33124qBL/GYxFZBKpZiKKbJCSFTuk6wTviIt9EH8xHkJ5hcUQDfzIVw7fiJwhPQSlQjuz
 lAR/q/VZ11y+XIX50Rs8kHnStkh/iOczDlrrOlLYAs6i5c6VQY0T+o8tW2aYk/+zNGylTVP5B
 x74rtSrQ/Gwsi+UMBCBIln1uVu6ExjvUdB9bbXWl30tbs+RwjB/VHKWKQPKBfaRSC3yU4gz73
 f7o0mWxTjaCKF5Mn8qftR3AB1uCijXhGBDxjook2Kaad7gIKt6qlhcvNa771Bxq5tiAASx65r
 pBD4Ewf6bWnG6j4GZNb+lQ6iachvPCfrEZhxdOMS+xMgdfmBFKa7zSNI3jXi9HLTkWI3Sfazs
 K5j3tNzY/LR8rxBUH/O5W2avxkBXGf7K4q5XK4no0rq591OGEavXsgWCxs1bUHkmzKHpP1kfN
 NSCqwddlRoNyfMc2LHYTnuiN+eTaKwiKJWaBM/rMwbljv/nSKSWyCHScg2MxCaseAiZkmw4hZ
 SZUebxcGqscnyZ9vrkfsC7nIQck4MPp69+l5cJQc9rQ+IgjtMY3avBMU9Qv4zzW/dpM4EwmiU
 SKd8iV0YGor/YKkR4qzT/YA3B3Tng8aumynWcMDB10Pl4hJ4xv7la5rlFsvSYGzp6k0eBUc3O
 Rr5YbMrBMKe7gn53Fn8VIg5xmBbpKhYRn+EfiJ8c2dSv9EZvF/aXBxA59tKMbnVwDjk+qiBr+
 PySuvxEJkQ47E2c0741Woez77DewXpj1m6zVvokLHvSi7uvLuQMsdN9D6HtFb/fFRFsnhkNTV
 E3cVg0nBKCUPXzAKr6DIbmNFsCKekHXtWRHFrp2ffixBcl/i18CVoMzR1NT+bUvdN5c65+LZO
 LzGSxmPnYortKFfyzjkzEHsYeE0tEf9geKrV9WfyHdXC9C53H2YgDLM6I5t5H08SYsor2C7V9
 gZW4sdFgGF/fzjf+wTZLhCQivrHh7u39Fq/2XODn2b3J4zakJVdfzbpjZnFhNjVLb8iwk97Xk
 mlA3xoff1DnI51qSMuuqrzZhoMpNVY7JxCIUT6TaHHIIZX/3U/e3mEkGg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 16:44, Qu Wenruo wrote:
>
>
> On 2022/6/10 16:39, Filipe Manana wrote:
>> On Fri, Jun 10, 2022 at 03:33:47PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/6/10 15:23, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 10.06.22 =D0=B3. 3:07 =D1=87., Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/6/10 00:46, David Sterba wrote:
>>>>>> Currently the super block page is from the mapping of the block
>>>>>> device,
>>>>>> this is result of direct conversion from the previous buffer_head
>>>>>> to bio
>>>>>> API.=C2=A0 We don't use the page cache or the mapping anywhere else=
,
>>>>>> the page
>>>>>> is a temporary space for the associated bio.
>>>>>>
>>>>>> Allocate pages for all super block copies at device allocation time=
,
>>>>>> also to avoid any later allocation problems when writing the super
>>>>>> block. This simplifies the page reference tracking, but the page
>>>>>> lock is
>>>>>> still used as waiting mechanism for the write and write error is
>>>>>> tracked
>>>>>> in the page.
>>>>>>
>>>>>> As there is a separate page for each super block copy all can be
>>>>>> submitted in parallel, as before.
>>>>>
>>>>> Is there any history on why we want parallel super block submission?
>>>>
>>>> Because it's in the transaction critical path so it affects latency o=
f
>>>> operations.
>>>
>>> Not exactly.
>>>
>>> Super block writeback happens with TRANS_STATE_UNBLOCKED status, which
>>> means new transaction can already be started.
>>>
>>> Thus even if we don't do any parallel submission, there is no
>>> performance impact on transaction path.
>>
>> Hell, no. There's more than transaction states to consider.
>>
>> Taking longer to write super blocks can have a performance impact on
>> fsync
>> for example. And fsync always has to write super blocks and wait for th=
em
>> to complete. In fact, a large part of time spent on fsync is precisely =
on
>> writing super blocks.
>
> Fsync() only write the first super block, thus even if we go synchronous
> submission, it's completely the same for that specific fsync use case.
> We will wait for the write back of super blocks anyway.
>
>>
>> In some cases fsync has to fallback to a transaction commit and wait fo=
r
>> it to complete before returning to user space - which again requires
>> writing
>> super blocks and waiting for their completion.
>
> Although in that case, it's going to cause some differences, since we
> are serializing the super block writeback for all super blocks.
> And btrfs_commit_transaction() will only return if everything is done.
>
>>
>> Similarly, there are ioctls like snapshot and subvolume creation which
>> commit a transaction, and any changes to the way super blocks are writt=
en
>> can also affect their latency and impact applications.
>
> Then I'd say, we would also want parallel device submissions too, which
> can further save some time, even we're just writing back the primary
> super blocks.

Oh, the existing code is already doing that.

Now I got the reason why we're doing the existing way of sb submission.
It's already firing all bios for all devices in one go, then waiting for
each device.

To improve the parallelism to max, and reduce the fsync() wait time for
sb writeback.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>>
>>>>> In fact, for the 3 super blocks, the primary one has FUA flag,
>>>>> while the
>>>>> other backup ones doesn't.
>>>>>
>>>>> This means, even we wait for the super block write, only the first o=
ne
>>>>> would take some real time, while the other two can return almost
>>>>> immediate for devices with write cache.
>>>>>
>>>>> In fact, waiting for the super block write back can tell us if our
>>>>> primary super block did really reach disk, allowing us to do better
>>>>> error handling, other than the almost non-exist check in endio.
>>>>>
>>>>> And such synchronous submission allows us to have only one copy of t=
he
>>>>> sb.
>>>>>
>>>>>
>>>>> Furthermore, if we really go parallel, I don't think the current
>>>>> way is
>>>>> the correct way.
>>>>>
>>>>> One device can have at most 3 superblocks, but a btrfs can easily ha=
ve
>>>>> more than 4 devices.
>>>>>
>>>>> Shouldn't we parallel based on device, other than each superblock?
>>>>
>>>> I agree that instead of having 3 pages per-device we can go the 1 pag=
e
>>>> per device, and parallelize based on the device, rather than the supe=
r
>>>> block copies.
>>>>
>>>> <snip>
