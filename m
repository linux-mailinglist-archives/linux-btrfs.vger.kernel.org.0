Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCFF5B1882
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIHJXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 05:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiIHJWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 05:22:52 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801264E624
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 02:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662628888; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=I3xcHKt6exffJRDbYxCYB24EqO+E/1k+LJvHJHA6o2CinCnSX76aPldZDM990GB5LH5FdNN7gZpg6fk95y2Hpyxh0CwW3NtkYHhf8L9BW+5nxZ8r6JlQrfXCy2vzhW2g0GmMbVLDaN+oTNGts4PMndFW9dMxfx7aY/CWFNWJM5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1662628888; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dWIQzr267fHSGVAUnaNBGzx8VdDgNLXICHhrpMb5/1s=; 
        b=BTsRvvQl1pLbka50x7DazEa9IzOQp5qxKcgiV2r0iV2gVw6as3Kbu9COe5YI5ysfSIP7ZPL0aX70EO9oM6rpy09ZYvZ/YZgoIZezaGqy3GRo46fCtnlzmdIsJbAfHy8KocA3RhMqZwKFxzowQlLaszrFpDC81fOPLoOxpMH06Ok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:references:from:in-reply-to:content-type; 
  b=b0QKSocxJtPGUY1GwLCByj8zYx4Tb12QNMjAnsJbGI0lLTIlffsILRKWiR89VzyRq1vlEO8t9wwf
    WVpH1Cw9YAb/P3+mGi+2Lc4upd2tgLYh+ukbRVf7tLGH3VdK5/+H  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662628888;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=dWIQzr267fHSGVAUnaNBGzx8VdDgNLXICHhrpMb5/1s=;
        b=IJhWgpRzHdhkSAS+iMMGe2CxjmbvyrQQeC4u4IbONBVrZsaebkg2uGFmmy02sY4E
        V40BhxbHH2lWyN5SLxiOH1Hh7x4xCiviAXUWM/X976QKNYBRlRf6jsOfmCsgmDvUWue
        ojYrZiRepiRTKhJHCFMb6cfUFoXbv1DAKXjzyVA8=
Received: from [192.168.0.103] (58.247.201.23 [58.247.201.23]) by mx.zohomail.com
        with SMTPS id 1662628888067165.34381713348193; Thu, 8 Sep 2022 02:21:28 -0700 (PDT)
Message-ID: <fa865b92-fb3b-19d8-81d9-fad7928da6ba@zoho.com>
Date:   Thu, 8 Sep 2022 05:21:19 -0400
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
 <e2e84e6c-147a-b54b-1213-32a1b7c34660@zoho.com>
 <70caa5b6-af86-2841-c602-602c0306fca2@gmx.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <70caa5b6-af86-2841-c602-602c0306fca2@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thanks for your reply. Sorry for the ambiguous and inaccuracy in last mail.
This email is intend to express my idea in detail.

[Main idea]

    Calculate the checksum of all blocks in a full stripe. Use these checksums to
    tell which stripe is corrupted.


Let's go back to the destructive RMW.

[test case]

    mkfs.btrfs -f -m raid5 -d raid5 -b 1G /dev/vda /dev/vdb /dev/vdc
    mount /dev/vda /mnt
    xfs_io -f -c "pwrite -S 0xee 0 64k" /mnt/file1
    sync
    umount /dev/vda
    xfs_io -f -c "pwrite -S 0xff 119865344 64k" /dev/vda
    mount /dev/vda /mnt
    xfs_io -f -c "pwrite -S 0xee 0 64k" -c sync /mnt/file2

        At this point, the layout of devices is as follows.

                |<---stripe1---->|
        vda |...|CCCCCCCCCCCCCCCC|...|

                |<---stripe2---->|
        vdb |...|UUUUUUUUUUUUUUUU|...|

                |<---parity----->|
        vdc |...|PPPPPPPPPPPPPPPP|...|

		C:corrupted    U:unused    P:parity

        Before the data of file2 written to the stripe2 of vdb, we can still
        recover the data of stripe1 by stripe2 and parity.
        But Here is the problem.

        How can we know which stripe is corrupted?
          We need checksum for whole stripe.



        But If we calculate the checksum of all blocks of a stripe, we can also tell which stripe is corrupted.
        As for our test case, Here is my plan.

        1. If we use some part or all of stripe1, then we calculate the checksum of stripe1 and stripe2.

        When the write request of file2 comes, we can calculate the checksum of stripe1 and stripe2 block by block
        in the RMW process. If some block in stripe1 mismatch, then stripe1 is corrupted. If some block in stripe2 mismatch
        then stripe2 is corrupted.

        In this case, we know stripe1 is corrupted, so we can use stripe2 and parity to recover stripe1.

        In my opinion, the checksum stored in checksum tree is by byte number. So we can calculate the checksum of stripe2
        during the writing process and store it to csum tree in later end_io process.

    cat /mnt/file1 > /dev/null
    umount /mnt

Thanks,
Flint

On 9/7/22 04:46, Qu Wenruo wrote:
> 
> 
> On 2022/9/7 16:24, hmsjwzb wrote:
>>
> [...]
>>> That's the idea to fix the destructive RMW, aka when doing sub-stripe
>>> write, we need to:
>>>
>>> 1. Collected needed data to do the recovery
>>>     For data, it should be all csum inside the full stripe.
>>>     For metadata, although the csum is inlined, we still need to find out
>>>     which range has metadata, and this can be a little tricky.
>>
>> Hi Qu,
>>
>>    As for fix solution, I think the following method don't need a on-disk format.
> 
> I never mentioned we need a on-disk format change.
> 
> I just mentioned some pitfalls you need to look after.
> 
>>
>>      For Data:
>>        When we write to disk, we do checksum for the writing data.
>>
>>          dev1 |...|DDUUUUUUUUUU|...|
>>          dev2 |...|UUUUUUUUUUUU|...|
>>          dev3 |...|PPPPPPPPPPPP|...|
>>
>>     D:data Space:unused P:parity  U:unused
>>
>>        The checksum block will look like the following.
>>          dev1 |...|CC          |...|
>>          dev2 |...|            |...|
>>          dev3 |...|            |...|
>>
>>          C:Checksum
>>
>>        So if data is corrupted in the area we write, we can know it. But when the corruption happened in
>>        the unused block. We can do nothing about it.
> 
> We don't need to bother corruption happened in unused space at all.
> 
> We only need to ensure our data and parity is correct.
> 
> So if the data sectors are fine, although parity mismatches, it's not a
> problem, we just do the regular RMW, and correct parity will be
> re-calculated and write back to that disk.
> 
>>        The checksum of blocks marked with C will be calculated and inserted into checksum tree.
> 
> Why insert? There is no insert needed at all.
> 
> And furthermore, data csum insert happens way later, RAID56 layer should
> not bother to insert the csum.
> 
> If you're talking about writing the first two sectors, they should not
> have csum at all, as data COW ensured we can only write data into unused
> space.
> 
> Please make it clear what you're really wanting to do, using W for
> blocks to write, U for unused, C for old data which has csum.
> 
> (Don't bother NODATASUM case for now).
> 
> Thanks,
> Qu
> 
>>
>>        But what if we do the checksum of the full stripe.
>>                   |<--stripe1->|
>>          dev1 |...|CCCCCCCCCCCC|...|
>>                   |<--stripe2->|
>>          dev2 |...|CCCCCCCCCCCC|...|
>>          dev3 |...|            |...|
>>
>>        So in the rmw process, we can do the following operation.
>>          1.Calculate the checksum of blocks in stripe1 and compare them with the checksum in checksum tree.
>>            If mismatch then stripe1 is corrupted, otherwise stripe1 is good.
>>          2.We can do the same process for stripe2. So we can tell whether stripe2 is corrupted or good.
>>     3.In this condition, if parity check failed, we can know which stripe is corrupted and use the good
>>            data to recover the bad.
>>
>> Thanks,
>> Flint
>>
>>> 2. Read out all data and stripe, including the range we're writing into
>>>     Currently we skip the range we're going to write, but since we may
>>>     need to do a recovery, we need the full stripe anyway.
>>>
>>> 3. Do full stripe verification before doing RMW.
>>>     That's the core recovery, thankfully we should have very similiar
>>>     code existing already.
>>>
>>>>
>>>> [question]
>>>>      I have noticed this patch.
>>>>
>>>>          [PATCH PoC 0/9] btrfs: scrub: introduce a new family of ioctl, scrub_fs
>>>>          Hi Qu,
>>>>              Is some part of this patch aim to solve this problem?
>>>
>>> Nope, that's just to improve scrub for RAID56, nothing related to this
>>> destructive RMW thing at all.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks,
>>>> Flint
>>>>
>>>>
>>>> On 8/16/22 01:38, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/8/16 10:47, hmsjwzb wrote:
>>>>>> Hi Qu,
>>>>>>
>>>>>> Sorry for interrupt you so many times.
>>>>>>
>>>>>> As for
>>>>>>       scrub level checks at RAID56 substripe write time.
>>>>>>
>>>>>> Is this feature available in latest linux-next branch?
>>>>>
>>>>> Nope, no one is working on that, thus no patches at all.
>>>>>
>>>>>> Or may I need to get patches from mail list.
>>>>>> What is the core function of this feature ?
>>>>>
>>>>> The following small script would explain it pretty well:
>>>>>
>>>>>     mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>>>>>     mount $dev1 $mnt
>>>>>
>>>>>     xfs_io -f -c "pwrite -S 0xee 0 64K" $mnt/file1
>>>>>     sync
>>>>>     umount $mnt
>>>>>
>>>>>     # Currupt data stripe 1 of full stripe of above 64K write
>>>>>     xfs_io -f -c "pwrite -S 0xff 119865344 64K" $dev1
>>>>>
>>>>>     mount $dev1 $mnt
>>>>>
>>>>>     # Do a new write into data stripe 2,
>>>>>     # We will trigger a RMW, which will use on-disk (corrupted) data to
>>>>>     # generate new P/Q.
>>>>>     xfs_io -f -c "pwrite -S 0xee 0 64K" -c sync $mnt/file2
>>>>>
>>>>>     # Now we can no longer read file1, as its data is corrupted, and
>>>>>     # above write generated new P/Q using corrupted data stripe 1,
>>>>>     # preventing us to recover the data stripe 1.
>>>>>     cat $mnt/file1 > /dev/null
>>>>>     umount $mnt
>>>>>
>>>>> Above script is the best way to demonstrate the "destructive RMW".
>>>>> Although this is not btrfs specific (other RAID56 is also affected),
>>>>> it's definitely a real problem.
>>>>>
>>>>> There are several different directions to solve it:
>>>>>
>>>>> - A way to add CSUM for P/Q stripes
>>>>>     In theory this should be the easiest way implementation wise.
>>>>>     We can easily know if a P/Q stripe is correct, then before doing
>>>>>     RMW, we verify the result of P/Q.
>>>>>     If the result doesn't match, we know some data stripe(s) are
>>>>>     corrupted, then rebuild the data first before write.
>>>>>
>>>>>     Unfortunately, this needs a on-disk format.
>>>>>
>>>>> - Full stripe verification before writes
>>>>>     This means, before we submit sub-stripe writes, we use some scrub like
>>>>>     method to verify all data stripes first.
>>>>>     Then we can do recovery if needed, then do writes.
>>>>>
>>>>>     Unfortunately, scrub-like checks has quite some limitations.
>>>>>     Regular scrub only works on RO block groups, thus extent tree and csum
>>>>>     tree are consistent.
>>>>>     But for RAID56 writes, we have no such luxury, I'm not 100% sure if
>>>>>     this can even pass stress tests.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> I think I may use qemu and gdb to get basic understanding about this feature.
>>>>>>
>>>>>> Thanks,
>>>>>> Flint
>>>>>>
>>>>>> On 8/15/22 04:54, Qu Wenruo wrote:
>>>>>>> scrub level checks at RAID56 substripe write time.
