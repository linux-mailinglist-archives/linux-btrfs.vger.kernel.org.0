Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE404E6903
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352826AbiCXTHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 15:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbiCXTHh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 15:07:37 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9BB82CF
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 12:06:03 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-16.iol.local with ESMTPA
        id XSmUn7cqPxXfVXSmUnQsPJ; Thu, 24 Mar 2022 20:06:00 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1648148760; bh=+jSN4IVX+Foig/moRBEeSb3mw4YGDRvLMC55IB1eOPw=;
        h=From;
        b=V0Qg//doOTVKCmAs/h6/WnCixXVHwhdiuYQ9jjfl/FLT2M57N1EX30Z1H7jpuul3a
         Wxp2eGwT6TVrTZrF55BI4fHJSVz3xdQuv/x7qAIoynkecpyMJRfbCkXY1uNfXL3nhn
         3kSF/lvXgMOpr94uvvwWldulzyz8wanQcTPpZg2qe4tIdnw6prqkCITgSmrI58bW09
         JgUZ77LrO2LBd5FrtF8gHkgnNEadjNTGLBRFvh7HdC0B7BAtPV29xU+2Om2Zzagx2k
         4pDrOJlYScSCi69jU70fhdojdPhYCyMeQ31jvjUnL4wHLz60Bj10PJ9d1XG0Z3fQTi
         7kjzYbhEhuOyw==
X-CNFS-Analysis: v=2.4 cv=XoI/hXJ9 c=1 sm=1 tr=0 ts=623cc118 cx=a_exe
 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=YZ9HFjzuCqBDBibpDxYA:9 a=QEXdDO2ut3YA:10
Message-ID: <ee73fbf4-8126-01dd-c740-88b6cbdd3d86@inwind.it>
Date:   Thu, 24 Mar 2022 20:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
 <Yjoo5TOlfGXgAUyk@localhost.localdomain>
 <42e2b1fd-809d-3370-e802-2a9b926d38c5@libero.it>
 <YjqMXjn1wLAXVwKl@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <YjqMXjn1wLAXVwKl@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMA5mPZuBSd5tZLA4cGbY5LWaS1R3BgdztGO5eM/aqCIDrdZQOgwvYkvmiT1EohkaDBQx6JcvoG1aORlyC5s2d2fbeZVilBpJ+0r6SJtRYYkNqwqF0Jl
 2oQdVAxvDTbrHIAjQTz5mbptqSjG0KONlNh+Xqddj7Cv1X4sjD4Nph7wy7ZUnzNeClR5NsyhtluBN1ZH7vk3I6VSfltldCzzJYDPWrYLt+1xM5hgtqhvWde8
 qbKmDOhzod3EpdZHFa9rVBCqXtIccAFOBoJ9XMd8l3PutqYayBA3M1bJZlzyQXf+yRK47P/owOJQBHMuNcXnKE13YD5wLFacwTSmdXLqeXnItT5UPkIZ4yNU
 lbVI2dkBdmVl7J0TpQncQyurmst6eQ==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2022 03.56, Zygo Blaxell wrote:
> On Tue, Mar 22, 2022 at 09:25:45PM +0100, Goffredo Baroncelli wrote:
>> On 22/03/2022 20.52, Josef Bacik wrote:
>>> On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>
>>>> Add the following flags to give an hint about which chunk should be
>>>> allocated in which disk:
>>>>
>>>> - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
>>>>     preferred for data chunk, but metadata chunk allowed
>>>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
>>>>     preferred for metadata chunk, but data chunk allowed
>>>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
>>>>     only metadata chunk allowed
>>>> - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
>>>>     only data chunk allowed
>>>>
>>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>>> ---
>>>>    include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>>>> index b069752a8ecf..e0d842c2e616 100644
>>>> --- a/include/uapi/linux/btrfs_tree.h
>>>> +++ b/include/uapi/linux/btrfs_tree.h
>>>> @@ -389,6 +389,22 @@ struct btrfs_key {
>>>>    	__u64 offset;
>>>>    } __attribute__ ((__packed__));
>>>> +/* dev_item.type */
>>>> +
>>>> +/* btrfs chunk allocation hint */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
>>>> +/* btrfs chunk allocation hint mask */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
>>>> +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
>>>> +/* preferred data chunk, but metadata chunk allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
>>>> +/* preferred metadata chunk, but data chunk allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
>>>> +/* only metadata chunk are allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
>>>> +/* only data chunk allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
>>>> +
>>>
>>> I also just realized you're using these as flags, so they need to be
>>>
>>> (1ULL << 0)
>>> (1ULL << 1)
>>> (1ULL << 2)
>>> (1ULL << 3)
>>>
>>
>> Could you elaborate a bit ? These are mutual exclusive values...
> 
> One of the comments I had on earlier versions was that these should
> be bit values.  Bit 0 is data (0) or metadata (1), bit 1 is preferred
> (0) or only (2).  Thus "metadata only" is 3, "data preferred" is 0,
> "data only" is 2, and "metadata preferred" is 1.  This maintained on-disk
> compatibility with the earliest versions that only had the two "preferred"
> options encoded as 0 and 1.

At this point I would prefer to not change this part.
  
> At some point this got lost.  Between one of the patch versions and
> another I had to change the type numbers on all of my devices.

I remember that in the first iterations I used 3 bits, when now I use
only two bits. So it is possible that I changed the values.

> 
>>> Thanks,
>>>
>>> Josef
>>
>>
>> -- 
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
