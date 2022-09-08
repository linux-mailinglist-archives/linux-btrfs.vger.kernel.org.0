Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4C5B2964
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIHWf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIHWfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 18:35:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55389E899
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662676520;
        bh=wihQTQzWKqzbo1urtESqlxpk82pZWIk5C7PNeAzRTec=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NDEOY34WUqAB1A1rCbUINLxGu8UnjB11R9PbtMM6dvDSTXvNC6Uaj0g8KqgHXODCC
         tkI8jqIHe2pw3r3A9jSgzX/mUJa5rr6CrkbHH0dEiJ2AdghrQxlmUkxjsYNYKCdaJY
         GRFbgsUPVKUO1N2shIr5U7ss5VfOxeJEtXrh4XsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRR0-1ovbQp1F9A-00TkMq; Fri, 09
 Sep 2022 00:35:19 +0200
Message-ID: <91c7d385-4687-efd9-2c9a-bd02afae6141@gmx.com>
Date:   Fri, 9 Sep 2022 06:35:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] btrfs: don't update the block group item if used bytes
 are the same
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
 <YxnrXj7GqhPg7vRa@localhost.localdomain>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YxnrXj7GqhPg7vRa@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yqUY4UaL8rUsAznGcLTRngLaV6ukyvr/9svxbnAm9XF+DE3LVpg
 05sRA4QL/9+UAoo8sq53NdXBDPTaCgpcwILiJm3mCpZeIrF/dZ9H9BN9djuizwfO66AdcC9
 er6kqWdxF6jk1sgOrmnlT49/njargOzrqMsA+K6SPhkc30nDJNA7MhGRUy0G4KVunQ5r4G2
 x8uuD1FY3t3oaVWaY5iVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DTGREMVkfZc=:Y6QlkR3yzCaYrgJ9mxCpri
 2OnaQWAVYiIUR2Z6ic9MVrMiss519PszyKAQQGTdLJRVbexMqQnm1nLOKRTKIq2VuRDrV1Eiz
 agCuiBArlsjMOq7jY0RotFgFdLBQ88jtuqQUJNrA4Zgp7A6s5/tepBV2+DT4l31lPXPBfJsMt
 ODZZnJStISltlee1wMEYokMyQTPhCuT+Iwm8zWVJgnqkw0o0EwYjLw67g1PPdOgN9AgbiJF9M
 jYnEcVYJW+DHtvInECifIbNl7UDarNjyIsPGIe8n40ERNzGQ3747dpCYk2/60mJ7VhP1WNjZz
 0nhOt3VaYn9BFqgnBmnwg69Ty37eON6Y4xNFd/a3JH2yX4ORMeVZ723PbtHCpMFy4nzDiQ87r
 7/+y5ufrZn0zcgyFY9FetvRO4B/Sictu6OmGd7DxlM/WLwa+Xff3SsihCkNBt4CQOKEo85ENo
 orayXLzwIJJS9trrMjr9oatJJBUJLrNteZ0tMb43cMxSZie3E4tddK3xMp466kdKlRd8eJLvD
 HzIWaGR6AZL8DNrxem4oqOYOE2gji3hL7r6LIkUJ+2kam+Kiptori8UwjIQgeJHsuwVNxzkaW
 +8RZg++kQoHcCoKbM7lq/Z4OPmd+E6uYifC0oTsSF0wPoNgdIXJ8G9gpVDzBAAxB5rxYx7taH
 CBnR+52e8usxqkZYI7itGEyjpqnhJdJAlNqHWX8MCDdTHhTGjHGaFKQ/VPxosaQWt9jBi7LpC
 lNjuoW8N2D1CH6ErILglnyduTJAxlaC/Drivxe98/AcKjjHb/C9ElCi0s1YRxoL2rwxXN8PkR
 sI9t4v9W5+WYfLV+DWebdxWrlPKIiSjqxvVwDYljLmVB1l6+z4MJ0+Pwsvy7Nr2ROjWFQA1hf
 l4I2AAr9BzPiTvkPn0d3Bkvnq55GpqiE9nrjIU71QzFWJKVfhXzfN3VSR6qcNlGC4W+7nZSHC
 cQb0U0QrunbTD3nfnJp+Zs8GkOMbA0Ox/bHSZJUkUhtcnLVYnBg4Cx8L+WjxihVGYva0QOFK0
 Hv48dqmw86O5D6ST9lq9ZPqqp1HC7h6PdUDMFuWJuhm2ARO07/7Xa21KVDuTuRRThsf7ZteFG
 a/fE/jdBcPvtGOvJ/dtynZzuPCrmo1x9elfj0yEwaoJ0dqjjmXMo1PAPgoeLsAtkflO4OubjQ
 cDoj3lNOPn4fVLAMP6TJDgkWyW
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/8 21:17, Josef Bacik wrote:
> On Thu, Sep 08, 2022 at 02:33:48PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>>
>> When committing a transaction, we will update block group items for all
>> dirty block groups.
>>
>> But in fact, dirty block groups don't always need to update their block
>> group items.
>> It's pretty common to have a metadata block group which experienced
>> several CoW operations, but still have the same amount of used bytes.
>>
>> In that case, we may unnecessarily CoW a tree block doing nothing.
>>
>> [ENHANCEMENT]
>>
>> This patch will introduce btrfs_block_group::commit_used member to
>> remember the last used bytes, and use that new member to skip
>> unnecessary block group item update.
>>
>> This would be more common for large fs, which metadata block group can
>> be as large as 1GiB, containing at most 64K metadata items.
>>
>> In that case, if CoW added and the deleted one metadata item near the e=
nd
>> of the block group, then it's completely possible we don't need to touc=
h
>> the block group item at all.
>>
>> [BENCHMARK]
>>
>> To properly benchmark how many block group items we skipped the update,
>> I added some members into btrfs_tranaction to record how many times
>> update_block_group_item() is called, and how many of them are skipped.
>>
>> Then with a single line fio to trigger the workload on a newly created
>> btrfs:
>>
>>    fio --filename=3D$mnt/file --size=3D4G --rw=3Drandrw --bs=3D32k --io=
engine=3Dlibaio \
>>        --direct=3D1 --iodepth=3D64 --runtime=3D120 --numjobs=3D4 --name=
=3Drandom_rw \
>>        --fallocate=3Dposix
>>
>> Then I got 101 transaction committed during that fio command, and a
>> total of 2062 update_block_group_item() calls, in which 1241 can be
>> skipped.
>>
>> This is already a good 60% got skipped.
>>
>> The full analyse can be found here:
>> https://docs.google.com/spreadsheets/d/e/2PACX-1vTbjhqqqxoebnQM_ZJzSM1r=
F7EY7I1IRbAzZjv19imcDHsVDA7qeA_-MzXxltFZ0kHBjxMA15s2CSH8/pubhtml
>>
>> Furthermore, since I have per-trans accounting, it shows that initially
>> we have a very low percentage of skipped block group item update.
>>
>> This is expected since we're inserting a lot of new file extents
>> initially, thus the metadata usage is going to increase.
>>
>> But after the initial 3 transactions, all later transactions are have a
>> very stable 40~80% skip rate, mostly proving the patch is working.
>>
>> Although such high skip rate is not always a huge win, as for
>> our later block group tree feature, we will have a much higher chance t=
o
>> have a block group item already COWed, thus can skip some COW work.
>>
>> But still, skipping a full COW search on extent tree is always a good
>> thing, especially when the benefit almost comes from thin-air.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> [Josef pinned down the race and provided a fix]
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Generally I like this change, any time we can avoid a tree search will b=
e good.
> I would like to see if this makes any difference timing wise.  Could you=
 record
> transaction commit times for this job with and without your change?

Sure, would add extra benchmarking the transaction commit time consumption=
.

However previous fio performance tests show no observable change in
performance numbers, so just in case I would also record the total and
individual execution time for update_block_group_item() function just in
case.

Thanks,
Qu

> That would
> likely show a difference.  In any case the code is fine
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
