Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09E629610
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 11:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiKOKh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 05:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiKOKhz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 05:37:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5FAE47
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 02:37:53 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XU1-1oz47r377x-014VFl; Tue, 15
 Nov 2022 11:37:51 +0100
Message-ID: <a4ebbed4-f75f-16d3-34d0-838d73d031f9@gmx.com>
Date:   Tue, 15 Nov 2022 18:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     li zhang <zhanglikernel@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
 <f5cceda5-e887-0807-7331-12382b45ea29@gmx.com>
 <CAAa-AGmQpL34eG8yx3bg8FYcbbOOjb3o8fb5YEocRbRPH1=NBw@mail.gmail.com>
 <11a71790-de79-3c2f-97f3-b97305b99378@gmx.com>
Subject: Re: [PATCH] btrfs: scrub: expand scrub block size for data range
 scrub
In-Reply-To: <11a71790-de79-3c2f-97f3-b97305b99378@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MrPo3YPSrMrwYKDNBhiYMd8fdXqPMkyf4i8IGvT+e+JOVkZOhqG
 FJJVFiZazTsVBfP2MkkIm39pFL3i0+9+VgfdJZxIGAJJY6ojSjxdLT5B49pZwH1Ifz/kRvI
 eUWjlUrhXWpe6WkM1qrBTcW6+0epEFdqPWj7XnbVqgpC0PmVK970dAuXMElrOoXghQm3ugs
 vY/G0oiE4EhEZbzkv1kAA==
UI-OutboundReport: notjunk:1;M01:P0:dtssINt93ws=;cehY7nMaeyehZH5QeegvRu8sb94
 52OZTFAdtIAuWRcWjIw+UvMJr0y3LXmFgIdmlqFFt/FmfFXLa48OjNm2n9mbvWjm5RhZTD6u6
 5qGLZTWAATxQ1KEa8Gh3cma46Ootdy2a9w2O+v+LuKM8nv61ns51gXcdLWsQMzsCCSrA12AV7
 8i24GKMbfpvnHpO9ONeUZqNegGEH3t9naghTRgG1EQ7813gjk9jHvUek1SNN9p+JX6oXMq7ZL
 lDUNqIJaqDMN3dFP+G19T+WDitiDUZ+tmL7n9L+LcxINoj0AW4dvxorxvvKOfE65SKHBe3IyF
 zQmuyfhkzfMyC003kZo3qwEYOOGWYLxXQCE8hbBvpzuoMHqn8TNt+NGX/TvYFZ8uas4l35Eap
 7MyVlEtdrvDuwZCoKxPcP3ombINik/S0Bqd8oFuVSMaIMp2Cm5W8fKvroECBStCoXNmV73Hc4
 UPJmxS8ojlpb9HA7E4IKTQsNTTkfddtFzTJQx8KdsQW5oFpDYZauYe1k3q4XucpJzRO5HY6OR
 mX8KsAHdAcsyl24SaFoajO3kzuIUlMlqxVY8e7W6Vr9UZbFix71XduD7L9jNETe95qgK/b7ht
 98ZUUHTHwpz/IifzvfRyhJlzhRS3IIhrS5RhBCg//XqM/ifGKC5O0JaaHxtm+22wk/6U2eVFn
 kbZ+LTK1Gc6gA7VtTHW+5G0dQfac1lQd0OdGRrCdPUhxdRjl6dibp3GQ/7WjAYDBIDu2xpEPF
 qi9RQR1AgSaC4KWX+gMaj2/wJdPoNd3CWHw9pS+LamehBJrpUazm/qROmE39uVpxEmSUiCWAa
 om2u8I94Hzd9iVCnE2dD1Tz7VPeGD5hiuufi3Ojyu3doqaSj7PTlGPMym26MCKtTpvOZlYYOa
 6EVYmNZoaX1SX+EJHGQIgx/Xa3H7TAr1kobc0a1yDAE+RBFgMHcrTILD6T/ozGzhBlcMh6F/f
 jT4g8KxQ3irYQQ+LW2zO8ZwsY9o=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Adding the mailing list, as the reply is to the first mail I got, which 
lacks the ML]

On 2022/11/15 06:39, Qu Wenruo wrote:
[...]
>>>
>>> And I hope it can also unify the error accounting of data and metadata.
>>>
>>
>> Because only one checksum is calculated for all sectors of the
>> metadata block.
>>
>> In this case the checksum count is ambiguous if
>> checksum_error means sector error, it should count all sectors, but if
>> checksum_error indicates that the checksum does not match and can only be
>> incremented by 1.

In fact, this is the problem of the existing scrub interface.

The scrub_process only reports an very ambiguous csum mismatch count.

If scrub reports 4 csum errors, you can not distinguish if it's 4 tree 
blocks csum mismatch or 4 data sectors.

Thus in my scrub_fs proposal, I do the error reports separately.
Furthermore unify the error report to use bytes.

That's to say, if a metadata (16K by default) has csum mismatch, it will 
report 16K bytes has csum mismatch for metadata.


>>
>> Also, since the metadata data block is a complete block, it cannot be
>> Fix sector by sector, the patch doesn't take this case into account.
>> So the patch still has bugs.

That doesn't matter. What end users really want is, how many bytes are 
affected, which is generic between data and metadata.

Not some ambiguous standard which changes according to if it's a 
metadata or data.

>>
>>> Currently for metadata csum mismatch, we only report one csum error even
>>> if the metadata is 4 sectors.
>>> While for data, we always report the number of corrupted sectors.
>>>
>>>>
>>>> The function enters the wrong scrub_block, and
>>>> the overall process is as follows
>>>>
>>>> 1) Check the scrub_block again, check again if the error is gone.
>>>>
>>>> 2) Check the corresponding mirror scrub_block, if there is no error,
>>>> Fix bad sblocks with mirror scrub_block.
>>>>
>>>> 3) If no error-free scrub_block is found, repair it sector by sector.
>>>>
>>>> One difficulty with this function is rechecking the scrub_block.
>>>>
>>>> Imagine this situation, if a sector is checked the first time
>>>> without errors, butthe recheck returns an error.
>>>
>>> If you mean the interleaved corrupted sectors like the following:
>>>               0 1 2 3
>>>    Mirror 1: |X| |X| |
>>>    Mirror 2: | |X| |X|
>>>
>>> Then it's pretty simple, when doing re-check, we should only bother the
>>> one with errors.
>>> You do not always treat the scrub_block all together.
>>>
>>> Thus if you're handling mirror 1, then you should only need to fix
>>> sector 0 and sector 2, not bothering fixing the good sectors (1 and 3).
>>>
>>
>> Consider the following
>>
>> The results of the first checking are as follows:
> 
> We're talking about "X" = corrupted sector right?
> 
>>             0 1 2 3
>>    Mirror 1: |X| |X| |
>>    Mirror 2: | |X| | |
>>
>> The result of the recheck is:
>>             0 1 2 3
>>    Mirror 1: |X| |X|X|
>>    Mirror 2: | |X| | |
>> An additional error was reported, what should we do,
>> recheck (which means it would recheck twice or more)?
>> Or just check only bad sectors during recheck.
> 
> Of course we should only repair the corrupted sectors.
> Why bother the already good sectors?
> 
> The csum error report should on cover the initial mirror we're checking.
> The re-check thing is only to make sure after repair, the repaired 
> sectors are good.
> 
> So the csum error accounting should be the original corrupted sector 
> number.

In fact, since my RAID56 work almost finished, I guess I should spend 
more time on integrating the scrub_fs ideas into the existing scrub code.
(Other than just introduce a new interface from scratch)

I'll try to craft a PoC patchset to a stripe by stripe verification (to 
get rid of the complex bio form shaping code), and a proper bitmap based 
verification and repair (to only repair the corrupted sectors).

But as I mentioned above, the bad csum error reporting can not be easily 
fixed without a behavior change on btrfs_scrub_progress results.

Thanks,
Qu
> 
>>
>>>
>>>> What should
>>>> we do, this patch only fixes the bug that the sector first
>>>> appeared (As in the case where the scrub_block
>>>> contains only one scrub_sector).
>>>>
>>>> Another reason to only handle the first error is,
>>>> If the device goes bad, the recheck function will report more and
>>>> more errors,if we want to deal with the errors in the recheck,
>>>> you need to recheck again and again, which may lead to
>>>> Stuck in scrub_handle_errored_block for a long time.
>>>
>>> Taking longer time is not a problem, compared to corrupted data.
>>>
>>> Although I totally understand that the existing scrub is complex in its
>>> design, that's exactly why I'm trying to implement a better scrub_fs
>>> interface:
>>>
>>> https://lwn.net/Articles/907058/
> 
> Again, all of the behavior I mentioned can be found in above patchset.
> 
> But unfortunately I don't have a good way to apply them all to the 
> existing scrub infrastructure without such a full rework...
> 
> Thanks,
> Qu
> 
>>>
>>> RAID56 has a similiar problem until recent big refactor, changing it to
>>> a more streamlined flow.
>>>
>>> But the per-sector repair is still there, you can not avoid that, no
>>> matter if scrub_block contains single or multiple sectors.
>>> (Although single sector scrub_block make is much easier)
>>>
>>> [...]
>>>> @@ -1054,7 +1056,8 @@ static int scrub_handle_errored_block(struct 
>>>> scrub_block *sblock_to_check)
>>>>                if (ret == -ENOMEM)
>>>>                        sctx->stat.malloc_errors++;
>>>>                sctx->stat.read_errors++;
>>>> -             sctx->stat.uncorrectable_errors++;
>>>> +             sctx->stat.uncorrectable_errors += 
>>>> scrub_get_sblock_checksum_error(sblock_to_check);
>>>> +             sctx->stat.uncorrectable_errors += 
>>>> sblock_to_check->header_error;
>>>
>>> Do we double accout the header_error for metadata?
>>>
>>> Thanks,
>>> Qu
