Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812256E35D0
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjDPHiw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Apr 2023 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDPHiv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Apr 2023 03:38:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205C1FFC
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 00:38:49 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1qPXbc0t8p-018HlR; Sun, 16
 Apr 2023 09:38:47 +0200
Message-ID: <932806e4-045f-3a2a-f972-3149d37acc30@gmx.com>
Date:   Sun, 16 Apr 2023 15:38:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Torstein Eide <torsteine@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com>
 <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
 <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: scrub/balance a specif LBA range
In-Reply-To: <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UT1JTVYqDCHuTK37N8LUwNgYVVRD4AxE3XI1FphrpS7OsXlEaYT
 KRoWjx0EPapK4uBzBhYRP8+SiB/tJcrCPJnLuJ6Fs285LHhnxVoNy6vln04aSCheaejZtdL
 rxn4B1DUd/IDTZDkwArHw735WMrXhiDlQIkuAGRLN2bYmeKCWEW34u+k9VmmS7OkGNx3g3i
 3EYJwxHR1YgNd2tpT+F6Q==
UI-OutboundReport: notjunk:1;M01:P0:PV7Ctx7Dlno=;x1xAa6kkA89SDfyFfwVZo1fXRSn
 rd334IxSuqn31f0i61SHOEwqVuKGv1KAa7HdO+lVm2zOgpsF5EaubkUt/FzTvAVOuQmMQ0kZT
 P6u7YeUTBLmeg+vqC/4hrSjZWZ4GQtkWFTlp5rRHW1qmvBcOzAa8paDpXjM8AFRFBrY9ERk3y
 Hjr2IuZKP4UjD+dI0YNyGSyArtbudjWqEVw0drpFqsym6zaTAe8aptr1jrPKhIL2cgAI1NHeE
 UWhSEfjQKCKkWWO7mCuepAWEudmKqi7QIgnp3DsGALrspJv/90mLM0eO2NCd36qHShWmY9oeG
 EBmqqgua/j00d8irFzI9rtYAzNaqBuA9J84VLBXhZI0Z5skOlN41Tr3nGSo/P/bLeCHzZkz1r
 TI9daqjKxuweX/8u0RTXjFgza3QYijqLJUEKXDIrp0bxoDMRbLEmRh1GvsoppPV2iT9AH8Wux
 WgiKlF37Yo2KQUhTSeQHkX9Zk4LnFOQjmClCZiJCmdP6nofLu4d2zLk7WSk+5TjM1mlgW5+UT
 91lKtDNPIimbgBDCzsZlv30z57Bbq6tVPNOmJ8SJ7Di2xotx2gLHSdvC4Vdz6QZ03PvdMQ2kX
 vRJ341Ok9mymgLekS3emgz5ApNDSPn7MrFEk8dZHaIAHBNZsewPH7Q68p5tKZMjA4RRh8+baP
 yAkcTzvB26JSZKFCYw5+J/d7xW/b/u+9ot6D93voFSSu7zHl+9I215OOJi9lRViNBpivxzu0v
 bmIrDpHlmYSsp36wMOISm7a6DChvkfpZaXCnl5Zx2NDa5sBWy2qxInEYbFJEmqEm+ZS4sKWmZ
 GgpBx2o/tGxxPu0rno5H/mCyHZZVpzAwdS+niPFlolPRKRuZzqKAmbNncaf1tz8tWesJuDArs
 udushRGd2bF9MVC25ijgAoLG9bqBvy5gAPMCVWN+dI0xm7SyzcVkPc0LFQqCP97Mr9uX76iiI
 duetCUXV19d4808jp7Lx8yl6Usk=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/16 15:24, Torstein Eide wrote:
> The correct format is then:
> 
> `btrfs balance start -v
> -ddevid=2,convert=raid6,drange=11454997800..11454997807` (convert
> force move, only data on that device)
> `btrfs balance start -v -ddevid=2,convert=raid6,drange=11455002752..11455002759`

I guess that LBA is in 512 or 4K unit (because we're seeing unaligned 
bytenr like 11454997807).

So the proper range should need to be multiplied by 512 or 4096 based on 
the block size of the device.

Furthermore, if you're not doing convert, no need to specify convert=.

And finally, you need to duplicate all the filters for metadata and 
system, just in case those profiles are involved in the drange.

So the full output would looks like something like this: (assuming 512 
as block size)

# btrfs balance start -ddevid=2,drange=5864958873600..5864958877695 \
                       -mdevid=2,drange=5864958873600..5864958877695 \
                       -sdevid=2,drange=5864958873600..5864958877695 \
                       <mnt>
> 
> And so on?
> 
> Since I believe one of the ranges is matched with a bad sector on a
> different device, can I tell BTRFS to, if failed work on the next
> block that is not dual failure?

Sorry I didn't get your point.

Balance would try its best to rebuild the data (as long as it's 
checksumed), even there is a bad sector, btrfs can still detect and 
rebuild the good data.

And of course, if btrfs failed to rebuild a data matching the csum, it 
would fail the balance.

If you're concerned about that failure, in that case dmesg should output 
which file is causing the problem, and you can delete the file and retry 
the balance.

Thanks,
Qu

> 
> søn. 16. apr. 2023 kl. 02:23 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>>
>> On 2023/4/16 08:16, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/4/16 02:59, Torstein Eide wrote:
>>>> Hi
>>>> I have a disk with "Pending Sector remap".
>>>> That can be view with:
>>>>
>>>> ``smartctl -l defects  /dev/sdd``
>>>>
>>>> ````
>>>> Pending Defects log (GP Log 0x0c)
>>>> Index                LBA    Hours
>>>>       0        11454997800        -
>>>> ....
>>>>       7        11454997807        -
>>>>       8        11455002752        -
>>>> ....
>>>>      15        11455002759        -
>>>>      16        11464481352        -
>>>> ....
>>>>      31        11464486423        -
>>>>      32        11480702000        -
>>>> ....
>>>>       39        11480702007        -
>>>> ````
>>>>
>>>> Can I tell btrfs scrub or balance to move files on these locations?
>>>> I was thinking the balance `drange` may work but was unsure of the
>>>> correct format.
>>>
>>> You can use balance to only balance a logical range.
>>
>> s/logical/physical/
>>
>>>
>>> And it's indeed the drange option.
>>>
>>> Although you may need to specify the option for both metadata, data and
>>> system, or go --full-balance to make sure all chunks are covered.
>>>
>>> Thanks,
>>> Qu
>>>
