Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC5545FBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbiFJIpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348124AbiFJIpQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 04:45:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C8377EF
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654850694;
        bh=2wSW0t6Et3wHSIVO6ai28yaWEO85vQ5NHjKuxt/zjfk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DQdVYdfNJ7k/SUaBDCMRdPZH9/TVD5W1bL9p1Re7HZPGB+Zu2m6AWH0A4Ciu/NbZQ
         StiiNfFDGKFhyQAvDHG2FxjFg2+4OO0BEm5rOOuEymX0eEUoSO/HuKYeAr3Z1iJEVu
         xPnX4kPIOUeGXYpiiW4wNvlch4IXNO5WxuQTPpTY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDkm-1noog938Fk-00xcCb; Fri, 10
 Jun 2022 10:44:54 +0200
Message-ID: <71ac5734-b481-972a-f562-5b2ef1611df6@gmx.com>
Date:   Fri, 10 Jun 2022 16:44:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
 <ed4f2880-b4f3-cf16-00c9-b107141a7421@gmx.com>
 <d1957ade-a9be-c1e4-1356-89d3e73bb121@suse.com>
 <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
 <20220610083929.GA3742796@falcondesktop>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220610083929.GA3742796@falcondesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fF88okbAmE2julFnmkEYZWWigBbWySMG+F4Vyf0P8Qkm0+8Z2aj
 87IlUzLvr1LfrdCHVT6OVI+c3mn7OxOZ7GV13KMr5qjANdLpFu9OLskxs/Ws/0RUD2MkVkU
 8tuyt55Ahq3nJ0nxVa6/ITXL5YltzwW/wO3KrcgyLfhtHA/3n3PQWDOYawzvE42RULFGZ4x
 xJYfneax3eZ3AxOGY9iYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wnzvuaVYYRM=:JmcS9T39olCB97S1USpe5f
 BhMa41+bKdVGweWuPi2Gfk/ovkgVYiRxViNCRTGl4NKt5TuaDuaYZ2v1h1tZEU0mU57CYb8aD
 Eo9LDUA3lNJNseZI5f0ae3/2vBqMxtJ8s+DntTa5191ve3hGXURC+TIX3MQF6Nl3xEi/MC8yn
 fDDzTf+KN/GorXMgeQKpRvz65kCmIzlEqjPGyTV7zgBu5XW4/BVvA4uypEV2TEAEy9acFqdwg
 veWaW6vF6LQhXuSbiATwoMymiw1CK4CVLNBLMeRRMMnwGC5RkvmCoUvEJdpkU0HFXt9GWO2lZ
 fPYPJvF2Kf6JFXz1klZfZLSvOkBYPH6XE1f2F9Hzj/CyVYjU6bjMvWtpONGRnZFbwpwdp1+Nx
 jKUlqGQjAp+J2uKqPUhE7laPu3ABRw7mWxRrzSDR3tNJrjJSJUrZHNlV/dECu9PAstQlyRb3y
 cgpyJKzfN8CRiidkxphSLPKmrRuYm71EO4WJoHwkqGHlASEEVmUdiQ+rz87SuY5AfOsjmWjK/
 T0gU5R4DZhRPRpjwixR4ZQxflYrtTDsIw5H6zz49QW9QcQc0mdlXv5XFig7co1ef6AooiS3aR
 XI11Mg1bYXHZEHqA5g2vhIF2lGtJRN5Mmckcw9zeSSx4L3y0eNCrCQRHdL63x+FSFMmH8V8GU
 BBWqNWkmlPzzMBrOi2ZnAnHSmCG9DCIZ1RLZPTUlmxWXJwNd0wqANoKQ6cPumEn56FUAN4d1N
 KDI1Rh0xj9SVkfaeHilDRaClBJafWUyCTfneo/HK1M72Jlwa3j4thW8JEaEdQEtiRrQV2Cv2p
 zJh19XNDep4lj+naGz9RB3wFTGDAIioGvVCPg6EiKl8+8/eksh8rvSoswlsv0ELcSBR8uzbcw
 ae9G81qQO1W5e4GyaU7vw4YcUz0FNewGC7rA1d+BQiNz2BBo1d72bJbgGKjmil4Oqx2OPscyW
 azxj1atHoMEhAolFjAv6s+zlzIyAPiFi+Pe6NGhXH8wtwqUuYGNmmA0slfHm7/JxZH9dwbDXa
 SdLxBQZlLTew7VVhQDeipjWWzlQhhEpEPshjq9CGrDdeasoAsSnS2maAUnrtOmlLItOT190lr
 q2lJO3zAQnYNwUFDJBZvWbzUExS3WFAuY51GbTZJn7MkN+20VLbqAP3LQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 16:39, Filipe Manana wrote:
> On Fri, Jun 10, 2022 at 03:33:47PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/6/10 15:23, Nikolay Borisov wrote:
>>>
>>>
>>> On 10.06.22 =D0=B3. 3:07 =D1=87., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/6/10 00:46, David Sterba wrote:
>>>>> Currently the super block page is from the mapping of the block devi=
ce,
>>>>> this is result of direct conversion from the previous buffer_head to=
 bio
>>>>> API.=C2=A0 We don't use the page cache or the mapping anywhere else,=
 the page
>>>>> is a temporary space for the associated bio.
>>>>>
>>>>> Allocate pages for all super block copies at device allocation time,
>>>>> also to avoid any later allocation problems when writing the super
>>>>> block. This simplifies the page reference tracking, but the page loc=
k is
>>>>> still used as waiting mechanism for the write and write error is tra=
cked
>>>>> in the page.
>>>>>
>>>>> As there is a separate page for each super block copy all can be
>>>>> submitted in parallel, as before.
>>>>
>>>> Is there any history on why we want parallel super block submission?
>>>
>>> Because it's in the transaction critical path so it affects latency of
>>> operations.
>>
>> Not exactly.
>>
>> Super block writeback happens with TRANS_STATE_UNBLOCKED status, which
>> means new transaction can already be started.
>>
>> Thus even if we don't do any parallel submission, there is no
>> performance impact on transaction path.
>
> Hell, no. There's more than transaction states to consider.
>
> Taking longer to write super blocks can have a performance impact on fsy=
nc
> for example. And fsync always has to write super blocks and wait for the=
m
> to complete. In fact, a large part of time spent on fsync is precisely o=
n
> writing super blocks.

Fsync() only write the first super block, thus even if we go synchronous
submission, it's completely the same for that specific fsync use case.
We will wait for the write back of super blocks anyway.

>
> In some cases fsync has to fallback to a transaction commit and wait for
> it to complete before returning to user space - which again requires wri=
ting
> super blocks and waiting for their completion.

Although in that case, it's going to cause some differences, since we
are serializing the super block writeback for all super blocks.
And btrfs_commit_transaction() will only return if everything is done.

>
> Similarly, there are ioctls like snapshot and subvolume creation which
> commit a transaction, and any changes to the way super blocks are writte=
n
> can also affect their latency and impact applications.

Then I'd say, we would also want parallel device submissions too, which
can further save some time, even we're just writing back the primary
super blocks.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> In fact, for the 3 super blocks, the primary one has FUA flag, while =
the
>>>> other backup ones doesn't.
>>>>
>>>> This means, even we wait for the super block write, only the first on=
e
>>>> would take some real time, while the other two can return almost
>>>> immediate for devices with write cache.
>>>>
>>>> In fact, waiting for the super block write back can tell us if our
>>>> primary super block did really reach disk, allowing us to do better
>>>> error handling, other than the almost non-exist check in endio.
>>>>
>>>> And such synchronous submission allows us to have only one copy of th=
e
>>>> sb.
>>>>
>>>>
>>>> Furthermore, if we really go parallel, I don't think the current way =
is
>>>> the correct way.
>>>>
>>>> One device can have at most 3 superblocks, but a btrfs can easily hav=
e
>>>> more than 4 devices.
>>>>
>>>> Shouldn't we parallel based on device, other than each superblock?
>>>
>>> I agree that instead of having 3 pages per-device we can go the 1 page
>>> per device, and parallelize based on the device, rather than the super
>>> block copies.
>>>
>>> <snip>
