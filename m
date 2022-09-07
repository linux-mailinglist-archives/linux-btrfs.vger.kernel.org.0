Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851585AFEE9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 10:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiIGIZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGIZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 04:25:03 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D2B31DC5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 01:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662539097; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=aX3Qd+/gd5OhX5DVE5aN2GwHivihZYmn+EYT05lq0VUwv5msq7jzi/I4iHJoW5+oNTE/H9hzGV5w+E8ZZFTdql2gCylqebywNwzT9GOwIUs6rJEuIRTy+uCnvLpzuUpQYmGEEyUHOg3L/H3rvLlV526y3op95bfeJ4LqE7wet4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1662539097; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LGLiMqVAlTbyHNZRx6PofM1phIBjUiwv3VDAJPhOqYY=; 
        b=npyy4UvjFxra2KbIrzwIiCEz33t8viR2cWbTVv/hPCXXFWwUDGzmYUtt4iVAImpCMpaRyz+WZgDf4I8RQyQLxQHSzKv2guqP4kAnWBUq8dmiCkoup23gr+8fuxKWy9qlsR1BdOBnkydQ074JDZwScFGNpSiI+7gPCxsGrMlgb14=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:references:from:in-reply-to:content-type; 
  b=lG29dMKG0BtIO+9+FXbO1VVkAyvjuNxyQ9yOmXRoUtCjkJaIqq4OH5XdyFvlLxOuEcfJEYmFdlMl
    /fncaBdfATwKYmFQBJ0Km7+A4tLnYrTMxTs7sUCXtRkp2LjboV+p  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662539097;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=LGLiMqVAlTbyHNZRx6PofM1phIBjUiwv3VDAJPhOqYY=;
        b=V7/f0fhbc1FCKCIcxaspRscbD0m2b576ylZDdlXBTb87cS2Hy60zU1Uq5T7a0nSH
        DKCtjSZd5NyzZyjsBC0gyowk25yK0s1x70jZiA/HMrS/KNyEQjFI4udV0llybbO+5QG
        SICpf4i7+Uyy5QnK65woM5GpATpg6T0jDdmOP8FA=
Received: from [192.168.0.103] (58.247.201.81 [58.247.201.81]) by mx.zohomail.com
        with SMTPS id 1662539096971985.708000234449; Wed, 7 Sep 2022 01:24:56 -0700 (PDT)
Message-ID: <e2e84e6c-147a-b54b-1213-32a1b7c34660@zoho.com>
Date:   Wed, 7 Sep 2022 04:24:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: some help for improvement in btrfs
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <fb056073-5bd6-6143-9699-4a5af1bd496d@zoho.com>
 <655f97cc-64e6-9f57-5394-58f9c3b83a6f@gmx.com>
 <40b209eb-9048-da0c-e776-5e143ab38571@zoho.com>
 <72a78cc0-4524-47e7-803c-7d094b8713ee@gmx.com>
 <00984321-3006-764d-c29e-1304f89652ae@zoho.com>
 <18300547-1811-e9da-252e-f9476dca078c@gmx.com>
 <4691b710-3d71-bd26-d00a-66cc398f57c5@zoho.com>
 <7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.com>
 <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
 <1b00d889-bf4b-a092-38c0-fb6c6aa09fdf@gmx.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <1b00d889-bf4b-a092-38c0-fb6c6aa09fdf@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/6/22 04:37, Qu Wenruo wrote:
> 
> 
> On 2022/9/6 16:02, hmsjwzb wrote:
>> Hi Qu,
>>
>> Thank you for providing this interesting case. I use qemu and gdb to debug this case and summarize as follows.
>>
>> [test case]
>>
>> mkfs.btrfs -f -m raid5 -d raid5 -b 1G /dev/vda /dev/vdb /dev/vdc
>>
>> mount /dev/vda /mnt
>>
>> xfs_io -f -c "pwrite -S 0xee 0 64k" /mnt/file1
>>
>> sync
>>
>>     After the above command, the device look like this.
>>                 119865344
>>     vda |     |     stripe 0:Data for file1            |      |
>>                 98893824
>>     vdb |     |     stripe 1:redundant Data for parity |      |
> 
> Note, that is not redundant data, but some unused space, it can be garbage.
> 
> But still, we need this unused space to calculate the parity anyway.
> 
>>                 98893824
>>     vdc |     |     stripe 2:parity                    |      |
>>
>>     We can see that stripe 1 is not used by btrfs filesystem.
>>
>> umount /dev/vda
>>
>> xfs_io -f -c "pwrite -S 0xff 119865344 64k" /dev/vda
>>
>>                 119865344
>>     vda |     |     stripe 0:Data for file1(Corrupted) |      |
>>                 98893824
>>     vdb |     |     stripe 1:redundant Data for parity |      |
>>                 98893824
>>     vdc |     |     stripe 2:parity                    |      |
>>
>>     This command erase the data for file1 in stripe 0. I think it simulate the
>>     data loss in hardware.
> 
> Yep, that's correct.
> 
>>
>> mount /dev/vda /mnt
>>
>>     If we issue a read request for file1 now, the data for file1 can be recovered
>>     by raid5 mechanism.
>>
>> xfs_io -f -c "pwrite -S 0xee 0 64k" -c sync /mnt/file2
>>
>>                 119865344
>>     vda |     |     stripe 0:Data for file1(Corrupted)               |      |
>>                 98893824
>>     vdb |     |     stripe 1:Data for file2                          |      |
>>                 98893824
>>     vdc |     |     stripe 2:parity(Recomputed with Corrupted data)  |      |
>>
>>     After the above command, the stripe 1 in vdb is used for file2. The parity data
>>     is recomputed with corrupted data in vda and data of file2. So the Data for file1
>>     is forever lost.
> 
> Exactly, that's the destructive RMW idea.
> 
>>
>> cat /mnt/file1 > /dev/null
>>
>>     This command will read the corrupted data in stripe 0. And the btrfs csum will find
>>     out the csum mismatch and print warnings.
>>
>> umount /mnt
>>
>> [some fix proposal]
>>
>>     1. Can we do parity check before every write operation? If the parity check fails,
>>             we just recover the data first and then do the write operation. We can do this
>>        check before raid56_rmw_stripe.
> 
> That's the idea to fix the destructive RMW, aka when doing sub-stripe
> write, we need to:
> 
> 1. Collected needed data to do the recovery
>    For data, it should be all csum inside the full stripe.
>    For metadata, although the csum is inlined, we still need to find out
>    which range has metadata, and this can be a little tricky.

Hi Qu,

  As for fix solution, I think the following method don't need a on-disk format.

    For Data:
      When we write to disk, we do checksum for the writing data.

        dev1 |...|DDUUUUUUUUUU|...|
        dev2 |...|UUUUUUUUUUUU|...|
        dev3 |...|PPPPPPPPPPPP|...|

	D:data Space:unused P:parity  U:unused

      The checksum block will look like the following.
        dev1 |...|CC          |...|
        dev2 |...|            |...|
        dev3 |...|            |...|

        C:Checksum  

      So if data is corrupted in the area we write, we can know it. But when the corruption happened in
      the unused block. We can do nothing about it.
      The checksum of blocks marked with C will be calculated and inserted into checksum tree.

      But what if we do the checksum of the full stripe.
                 |<--stripe1->|
        dev1 |...|CCCCCCCCCCCC|...|
                 |<--stripe2->|
        dev2 |...|CCCCCCCCCCCC|...|
        dev3 |...|            |...|

      So in the rmw process, we can do the following operation.
        1.Calculate the checksum of blocks in stripe1 and compare them with the checksum in checksum tree.
          If mismatch then stripe1 is corrupted, otherwise stripe1 is good.
        2.We can do the same process for stripe2. So we can tell whether stripe2 is corrupted or good.
	3.In this condition, if parity check failed, we can know which stripe is corrupted and use the good
          data to recover the bad.

Thanks,
Flint

> 2. Read out all data and stripe, including the range we're writing into
>    Currently we skip the range we're going to write, but since we may
>    need to do a recovery, we need the full stripe anyway.
> 
> 3. Do full stripe verification before doing RMW.
>    That's the core recovery, thankfully we should have very similiar
>    code existing already.
> 
>>
>> [question]
>>     I have noticed this patch.
>>
>>         [PATCH PoC 0/9] btrfs: scrub: introduce a new family of ioctl, scrub_fs
>>         Hi Qu,
>>             Is some part of this patch aim to solve this problem?
> 
> Nope, that's just to improve scrub for RAID56, nothing related to this
> destructive RMW thing at all.
> 
> Thanks,
> Qu
>>
>> Thanks,
>> Flint
>>
>>
>> On 8/16/22 01:38, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/8/16 10:47, hmsjwzb wrote:
>>>> Hi Qu,
>>>>
>>>> Sorry for interrupt you so many times.
>>>>
>>>> As for
>>>>      scrub level checks at RAID56 substripe write time.
>>>>
>>>> Is this feature available in latest linux-next branch?
>>>
>>> Nope, no one is working on that, thus no patches at all.
>>>
>>>> Or may I need to get patches from mail list.
>>>> What is the core function of this feature ?
>>>
>>> The following small script would explain it pretty well:
>>>
>>>    mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>>>    mount $dev1 $mnt
>>>
>>>    xfs_io -f -c "pwrite -S 0xee 0 64K" $mnt/file1
>>>    sync
>>>    umount $mnt
>>>
>>>    # Currupt data stripe 1 of full stripe of above 64K write
>>>    xfs_io -f -c "pwrite -S 0xff 119865344 64K" $dev1
>>>
>>>    mount $dev1 $mnt
>>>
>>>    # Do a new write into data stripe 2,
>>>    # We will trigger a RMW, which will use on-disk (corrupted) data to
>>>    # generate new P/Q.
>>>    xfs_io -f -c "pwrite -S 0xee 0 64K" -c sync $mnt/file2
>>>
>>>    # Now we can no longer read file1, as its data is corrupted, and
>>>    # above write generated new P/Q using corrupted data stripe 1,
>>>    # preventing us to recover the data stripe 1.
>>>    cat $mnt/file1 > /dev/null
>>>    umount $mnt
>>>
>>> Above script is the best way to demonstrate the "destructive RMW".
>>> Although this is not btrfs specific (other RAID56 is also affected),
>>> it's definitely a real problem.
>>>
>>> There are several different directions to solve it:
>>>
>>> - A way to add CSUM for P/Q stripes
>>>    In theory this should be the easiest way implementation wise.
>>>    We can easily know if a P/Q stripe is correct, then before doing
>>>    RMW, we verify the result of P/Q.
>>>    If the result doesn't match, we know some data stripe(s) are
>>>    corrupted, then rebuild the data first before write.
>>>
>>>    Unfortunately, this needs a on-disk format.
>>>
>>> - Full stripe verification before writes
>>>    This means, before we submit sub-stripe writes, we use some scrub like
>>>    method to verify all data stripes first.
>>>    Then we can do recovery if needed, then do writes.
>>>
>>>    Unfortunately, scrub-like checks has quite some limitations.
>>>    Regular scrub only works on RO block groups, thus extent tree and csum
>>>    tree are consistent.
>>>    But for RAID56 writes, we have no such luxury, I'm not 100% sure if
>>>    this can even pass stress tests.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> I think I may use qemu and gdb to get basic understanding about this feature.
>>>>
>>>> Thanks,
>>>> Flint
>>>>
>>>> On 8/15/22 04:54, Qu Wenruo wrote:
>>>>> scrub level checks at RAID56 substripe write time.
