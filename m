Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738BF724B60
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 20:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbjFFS13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbjFFS12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 14:27:28 -0400
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3A1706
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 11:27:24 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.140])
        by smtp-17.iol.local with ESMTPA
        id 6bOqqENzGpE876bOqqTysH; Tue, 06 Jun 2023 20:27:20 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1686076040; bh=xDH7SUWhsclyZuQUxurZsZeG/kj/m/R+74nZMRVLJRg=;
        h=From;
        b=DGYLTnA+f+6fNYiujM7TVs/X35xQ636d0KfoSrMUN5etQcPMengBOPfsU8Z9OCJRM
         4kh/D2PaTJcIrgQECKLq8yyvvOqlYxInIjnfblWszjWKnZQhMvgUnQHHnHrtkj24JC
         y6c+4snxFoFeQYq/b0FL0uyD36hjLGiR2480b2plVa40zcPuhQIrJVyixeYoJvoq3p
         XzmY/q0e4wA+OAVo3DMbrTLRqq6K69OGBuaZ2WYUicmx7cmCeVuftZ+jjHfDYBGAaO
         JtkZku6rP4bIuEaqhaXPFhZ9wLoPWXl6Zv16NCCdfwZBf55Tu97R9IMB/EFIvGEc+Z
         FcrsEnIT+4LcQ==
X-CNFS-Analysis: v=2.4 cv=fr4aJn0f c=1 sm=1 tr=0 ts=647f7a88 cx=a_exe
 a=SDvFMQE/2DkMPFoCQNiONA==:117 a=SDvFMQE/2DkMPFoCQNiONA==:17
 a=IkcTkHD0fZMA:10 a=K2GaIjtP2kI1Ic4ljTsA:9 a=QEXdDO2ut3YA:10
Message-ID: <a7851ed8-8b1f-3ec0-56a4-fe059bdf6183@inwind.it>
Date:   Tue, 6 Jun 2023 20:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v3] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <276ea9bf-13f3-1349-a5b6-4dfcaaab7ef2@bluematt.me>
 <ed8c45b9-1b83-d706-add9-fa2d5f41576d@libero.it>
 <e3636d48-92c7-27e3-b63e-b3605fcc1dbf@bluematt.me>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <e3636d48-92c7-27e3-b63e-b3605fcc1dbf@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHQRntrSGeR+HrOJowaJPPDAa5PckXc7mSNtvDeGL5nEhlSfaDXHlxDC4fkvK0Gvzd8es9CGG+hVQiGaBUNFUQrytuGUUS8vzZYj3dAQIHvhvR30uND5
 hQ+smYJKo+Z0r1JEYN0vZGPUp8Kw+KhVvz1tcQKAWb3yCw7Tax3aECHzNX2NO2ertqx/NyGuU7/2Nrwpz0TTldJJld1iL/0bGnFnp6QVc45Ac7Cep7jmzGd+
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/06/2023 01.45, Matt Corallo wrote:
> 
> 
> On 6/5/23 2:10 PM, Goffredo Baroncelli wrote:
>> Hi Matt,
>> On 05/06/2023 21.31, Matt Corallo wrote:
>> Does SINGLE is missing too ? It should be replaced by
>> BTRFS_AVAIL_ALLOC_BIT_SINGLE...
> 
> Right, explains why there was no fallthrough before.
> 
>>> Because of the way it checks, if we have blocks with different
>>> profiles and at least one is known, that profile will be selected.
>>> However, if none are known we may return a flag set with multiple
>>> allocation profiles set.
>> [...]
>>>
>>> Signed-off-by: Matt Corallo <blnxfsl@bluematt.me>
>>> ---
>>>   fs/btrfs/block-group.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 4b69945755e4..60b3fe910a4a 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -79,16 +79,28 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>>>       }
>>>       allowed &= flags;
>>>
>>> -    if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>> +    /* Select the highest-redundancy RAID level */
>>> +    if (allowed & BTRFS_BLOCK_GROUP_RAID1C4)
>>> +        allowed = BTRFS_BLOCK_GROUP_RAID1C4;
>>> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>>           allowed = BTRFS_BLOCK_GROUP_RAID6;
>>> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID1C3)
>>> +        allowed = BTRFS_BLOCK_GROUP_RAID1C3;
>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>>           allowed = BTRFS_BLOCK_GROUP_RAID5;
>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>>           allowed = BTRFS_BLOCK_GROUP_RAID10;
>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>>           allowed = BTRFS_BLOCK_GROUP_RAID1;
>>> +    else if (allowed & BTRFS_BLOCK_GROUP_DUP)
>>> +        allowed = BTRFS_BLOCK_GROUP_DUP;
>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>>>           allowed = BTRFS_BLOCK_GROUP_RAID0;
>>
>> +    else if (allowed & BTRFS_AVAIL_ALLOC_BIT_SINGLE)
>> +        /* BTRFS_BLOCK_GROUP_SINGLE would be 0, so
>> +           use BTRFS_AVAIL_ALLOC_BIT_SINGLE */
>> +        allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE;
> 
> No, this doesn't work, BTRFS_BLOCK_GROUP_PROFILE_MASK does *not* include the SINGLE profile, and alloc_profile_is_valid would still vomit, SINGLE has to return zero here.

As we already agree, the code is ugly and difficult to follow. But please try to follow
my explanation why checking BTRFS_AVAIL_ALLOC_BIT_SINGLE makes sense.

btrfs_reduce_alloc_profile() is called by btrfs_get_alloc_profile() where the
'flags' variable is set from 'fs_info->avail_{data,metadata,system}_alloc_bits.'

fs_info->avail_{data,metadata,system}_alloc_bits are set by
set_avail_alloc_bits(), which *extends* the 'flags' using
chunk_to_extended().

chunk_to_extended() checks if the profile is 0 (a.k.a. GROUP_SINGLE), and if so
it sets the bit BTRFS_AVAIL_ALLOC_BIT_SINGLE to 1.

To say otherwise, on the platter the SINGLE profile is stored as 0, when in memory
often it is stored as BTRFS_AVAIL_ALLOC_BIT_SINGLE.

Finally BTRFS_EXTENDED_PROFILE_MASK contains BTRFS_AVAIL_ALLOC_BIT_SINGLE (a.k.a
SINGLE profile).

In conclusion, it makes perfectly sense to check against BTRFS_AVAIL_ALLOC_BIT_SINGLE
when you want to check a SINGLE profile.

> 
> The existing fallthrough will WARN all the time, so will simply remove it.
> 
>>> +    else {
>>> +        /* We should have selected a single flag by this point */
>>> +        WARN(1, "Missing ordering for block group flags %llx", allowed);
>>> +        allowed = rounddown_pow_of_two(allowed);
>>
>>
>> I think that it is more coherent and safe to return BTRFS_AVAIL_ALLOC_BIT_SINGLE,
>> when we encounter a new unknown profile.
>>
>> Coherent because btrfs_reduce_alloc_profile() selects a SINGLE profile when there
>> is not a valid combination "selected profile" and "enough disks number".
> 
> No, having a case where we randomly go from a RAID system to falling back to SINGLE is really not an okay fallback. We should just remount-ro.

Even thought I don't like the logic too, this logic is used from several years (if
not from ever); and nobody complained.

Anyway for me it is enough to have a WARN_ON; but without that the patch losses most of
its interest.

BR
G.Baroncelli.

> 
>> Safe because using rounddown_pow_of_two() assumes:
>> - the highest bit is the safest choice
>> - a new profile will be represented by *only* one bit
>> - the higher bits are only used for select a profile [*]
>>
>> Even tough all these assumption are quite reasonable alone, I am not confident
>> that together make the code less brittle than before, which was a goal of this patch.
>>
>> So I suggest to return BTRFS_AVAIL_ALLOC_BIT_SINGLE.
>>
>> BR
>> G.Baroncelli
>>
>> [*] for example see BTRFS_SPACE_INFO_GLOBAL_RSV
>>
>>> +    }
>>>
>>>       flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>>
>>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

