Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834BC545D9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347048AbiFJHed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 03:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346992AbiFJHeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 03:34:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE819138933
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654846436;
        bh=D2EEN9HkPsS8ZhmZvPpmDUTV0ok6F89t7Nkg3WzZkxw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U2KS3WT6sRXPJ+VO+9PHAyx8r3FGa3IB796j+wnBjtNojaHcTD7VKVp0wZDZ4cQQj
         siXrYmWPy1tO4rDNfPjsnYSqmFsmB9yS6YMWFNFkkwCkQMrw+8W7iPxER8Uu18AhiA
         55/lYnjXAWpqUNvPh5m91Czsd9DXSX5lGLT9r1MY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXuB-1oFgA00Wrf-00Z0cm; Fri, 10
 Jun 2022 09:33:55 +0200
Message-ID: <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
Date:   Fri, 10 Jun 2022 15:33:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
 <ed4f2880-b4f3-cf16-00c9-b107141a7421@gmx.com>
 <d1957ade-a9be-c1e4-1356-89d3e73bb121@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d1957ade-a9be-c1e4-1356-89d3e73bb121@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yIFE9mdE8ozjMkshcnsEeueTVSTyLQcg4GX3n6cp54odwW6SBGM
 4f5Lb5Lk8QP3lWtL+X2YBhAvL4g2/8wsxDtvd/os3z6MjQ+e1D7+wUijLXf2bRQpZ25b9Sf
 yQMBSHRDbMydhCaxSa0y9DCLjUJofV5qGJ8emdlu2YsOYu3nvZHCgjU9Dm9NnlwlTVxjkWi
 Q7Yyc/KKoEvGM0TwuGSuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NvbuIA6qZfc=:fzTDkv/UTfAsG5zdn6mx6I
 AqFqYhjGzoGxp1A53g8HH59/prmxx7/Mp7sdCBNYzoXJdar4jIgUrUENRE6DRyzuwam5O1LYr
 rNj2Uu3IR3Py1oXiU7HYzmRTqCchEAoLvRiofMccOCZ+hJH6yYBjnS6lqCgzc1ckpnJExjW8n
 WSZ6QhQmvF2yRemBcQN2jZ49y8Ooam8USWd0+J4yFYcHrfLrnCQ0gI9T1ssQ0Dnh1Dn4fEwjt
 r5i1cfSmIOPddnvwWBH8mRSGKVMErmSVJNX5rXbLC0idWZole8mbSMrq0Z3Tpgh5Vd9elWSjo
 8K6iFiCVlpTu+X1ZuHMUBRRyf47wvcl00LPH6zWem08xbOhBJP4ig2sXov52qO0hO5rgHmR8H
 L8Sra42S/BnURq8Io56SQ8PZRIxHpYdkFdJs1nZKh23MSEWaAszEs5qm5DkpdKBkP0Nn2QWc/
 /x00DTW+odN2ooMCFl1GsoYY5bpLrXxmysvlZMrT1xYe1xgeu+yuTrnzpbZHsIvE8vkw8WtXx
 A2HTo6QXGsJ50CkrZqdiCTHaYoeqS6TWZ/u5t11/PhjMcXqesF/VE/jPMRwRGy2+5P8itUFyg
 kzaOG5V7fgAHd284h830C2rmdROgI/1QTsW1ngY7N/zDw2xzyE49Mtnyj8wT2bMoytaEMEkGr
 bRywtFejVDAvHPfM0BDn36Og6moY08ncQHia8H2Odk3UWTb7VYpnV6khsWoiUxOgEmoavBMqt
 xZqY0gi219pXpLJYRJmxZZT+JqgqfwlhwaEnzKVYpG+7Ow0lPoS1tYfVE0kUodpBhhTl48Tbk
 8sonM6zjrpTELnBf5i+AIwiCnyhtY49fi+nrSbqTgJamO1I5Qf/WFKlt/uYC/U9MidB4qD2db
 lNkcUEWKB2URoy6v1lmOOB4o3vR5b22BTorCSwLjan60Vh/6YWmw9NPLMCAbYzG2L0HL+c/vi
 7o/+SyFMaCVPIFgH4PKLTVUIU7DbMvuZwcHP8AVvpmpcJ+uHxHI8Ssfdh7GHonQpOxzxE91sf
 lEeMNmRtEaMVxqk28Ge14/XCQulcuyu8S2cbRNJTabq9mQDmqw/Vblexhz+gf4tQ/9Fky8HEx
 4qz9X5Jeln+82oGuM45WzCZuOoSzB20uENrTwdYdpy9b8TlJQAwiOf4vA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 15:23, Nikolay Borisov wrote:
>
>
> On 10.06.22 =D0=B3. 3:07 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2022/6/10 00:46, David Sterba wrote:
>>> Currently the super block page is from the mapping of the block device=
,
>>> this is result of direct conversion from the previous buffer_head to b=
io
>>> API.=C2=A0 We don't use the page cache or the mapping anywhere else, t=
he page
>>> is a temporary space for the associated bio.
>>>
>>> Allocate pages for all super block copies at device allocation time,
>>> also to avoid any later allocation problems when writing the super
>>> block. This simplifies the page reference tracking, but the page lock =
is
>>> still used as waiting mechanism for the write and write error is track=
ed
>>> in the page.
>>>
>>> As there is a separate page for each super block copy all can be
>>> submitted in parallel, as before.
>>
>> Is there any history on why we want parallel super block submission?
>
> Because it's in the transaction critical path so it affects latency of
> operations.

Not exactly.

Super block writeback happens with TRANS_STATE_UNBLOCKED status, which
means new transaction can already be started.

Thus even if we don't do any parallel submission, there is no
performance impact on transaction path.

Thanks,
Qu
>
>>
>> In fact, for the 3 super blocks, the primary one has FUA flag, while th=
e
>> other backup ones doesn't.
>>
>> This means, even we wait for the super block write, only the first one
>> would take some real time, while the other two can return almost
>> immediate for devices with write cache.
>>
>> In fact, waiting for the super block write back can tell us if our
>> primary super block did really reach disk, allowing us to do better
>> error handling, other than the almost non-exist check in endio.
>>
>> And such synchronous submission allows us to have only one copy of the
>> sb.
>>
>>
>> Furthermore, if we really go parallel, I don't think the current way is
>> the correct way.
>>
>> One device can have at most 3 superblocks, but a btrfs can easily have
>> more than 4 devices.
>>
>> Shouldn't we parallel based on device, other than each superblock?
>
> I agree that instead of having 3 pages per-device we can go the 1 page
> per device, and parallelize based on the device, rather than the super
> block copies.
>
> <snip>
