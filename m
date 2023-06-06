Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D54724F9F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 00:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbjFFWbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjFFWbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 18:31:08 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B087172E
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1686088861; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=ldlJIsQWyO1HsaQcBBqnsXxSX3izPDLPrGDAAFd9hi4=; b=HGtXXPoueJw24
        +4h+VlpjTO037xZwwSWNVJG3Lwo9x9dUq4grR1sOPkyHAAPGp8c+NUh5g+D+bdS0as3GT3EEJ/SxS
        CEHnqnaqK/DZ/i6K4SjCS93olDlXk5zODS95841uz3xsWIAGg0cyxTcDgNDph8UHjCy+o05RVoHuz
        1gGrypd7F1Y/6Ho9aWXnjOF/Kcr738SEp1WHh8f2CYN3p8rp2hh6mUEfPWIizLMUTYwzP3I9ZO1oG
        VtO6/FrIYK9R8HZfMRVPd0pYeFqc+TkQtaw5oUx9D7dyTecpbYMM4lbAPvaHRfRiDGDMunVOsf1Mg
        I3YBYGNxFYiHgosJYsx0g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1686088863; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=ldlJIsQWyO1HsaQcBBqnsXxSX3izPDLPrGDAAFd9hi4=; b=WU9JSiGZzQ706M+itHl1W//Oif
        ddDFhFxooulAl4wEzQ4Jvwvs2qwWLsBuknZmRXOO4+eqxNHnesVtVlfdkx5UVRa2MuDnsCz2AscpQ
        0Nzj5WWSf1OKbubHK7QH5zrdiDaA02vkxwXodNMcpyvl/eJuOUTbElSmkYHICHQbAnRqRPpkGKsRf
        IsRX3Z6oCCnI+w51V4G0xrLDYdPpZuVFhRFDJRxQAi+3t3uTm1PcGzqiXfer6w+tDcDsafW+0/44D
        i7przdC48D3fRCUiHN23GKH4j0qkrq93E5qzKLPs/zQEF4QBqoKYjkNmhlckNWiq8CeT2c9Hkz63c
        zpuYtypg==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q6fCj-004s4O-0k;
        Tue, 06 Jun 2023 22:31:05 +0000
Message-ID: <8f857c05-446e-dab1-5863-e6fdf737acff@bluematt.me>
Date:   Tue, 6 Jun 2023 15:31:04 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
Content-Language: en-US
To:     kreijack@inwind.it, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <276ea9bf-13f3-1349-a5b6-4dfcaaab7ef2@bluematt.me>
 <ed8c45b9-1b83-d706-add9-fa2d5f41576d@libero.it>
 <e3636d48-92c7-27e3-b63e-b3605fcc1dbf@bluematt.me>
 <a7851ed8-8b1f-3ec0-56a4-fe059bdf6183@inwind.it>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <a7851ed8-8b1f-3ec0-56a4-fe059bdf6183@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/6/23 11:27 AM, Goffredo Baroncelli wrote:
> On 06/06/2023 01.45, Matt Corallo wrote:
>>
>>
>> On 6/5/23 2:10 PM, Goffredo Baroncelli wrote:
>>> Hi Matt,
>>> On 05/06/2023 21.31, Matt Corallo wrote:
>>> Does SINGLE is missing too ? It should be replaced by
>>> BTRFS_AVAIL_ALLOC_BIT_SINGLE...
>>
>> Right, explains why there was no fallthrough before.
>>
>>>> Because of the way it checks, if we have blocks with different
>>>> profiles and at least one is known, that profile will be selected.
>>>> However, if none are known we may return a flag set with multiple
>>>> allocation profiles set.
>>> [...]
>>>>
>>>> Signed-off-by: Matt Corallo <blnxfsl@bluematt.me>
>>>> ---
>>>>   fs/btrfs/block-group.c | 14 +++++++++++++-
>>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>>> index 4b69945755e4..60b3fe910a4a 100644
>>>> --- a/fs/btrfs/block-group.c
>>>> +++ b/fs/btrfs/block-group.c
>>>> @@ -79,16 +79,28 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>>>>       }
>>>>       allowed &= flags;
>>>>
>>>> -    if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>>> +    /* Select the highest-redundancy RAID level */
>>>> +    if (allowed & BTRFS_BLOCK_GROUP_RAID1C4)
>>>> +        allowed = BTRFS_BLOCK_GROUP_RAID1C4;
>>>> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>>>           allowed = BTRFS_BLOCK_GROUP_RAID6;
>>>> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID1C3)
>>>> +        allowed = BTRFS_BLOCK_GROUP_RAID1C3;
>>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>>>           allowed = BTRFS_BLOCK_GROUP_RAID5;
>>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>>>           allowed = BTRFS_BLOCK_GROUP_RAID10;
>>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>>>           allowed = BTRFS_BLOCK_GROUP_RAID1;
>>>> +    else if (allowed & BTRFS_BLOCK_GROUP_DUP)
>>>> +        allowed = BTRFS_BLOCK_GROUP_DUP;
>>>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>>>>           allowed = BTRFS_BLOCK_GROUP_RAID0;
>>>
>>> +    else if (allowed & BTRFS_AVAIL_ALLOC_BIT_SINGLE)
>>> +        /* BTRFS_BLOCK_GROUP_SINGLE would be 0, so
>>> +           use BTRFS_AVAIL_ALLOC_BIT_SINGLE */
>>> +        allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE;
>>
>> No, this doesn't work, BTRFS_BLOCK_GROUP_PROFILE_MASK does *not* include the SINGLE profile, and 
>> alloc_profile_is_valid would still vomit, SINGLE has to return zero here.
> 
> As we already agree, the code is ugly and difficult to follow. But please try to follow
> my explanation why checking BTRFS_AVAIL_ALLOC_BIT_SINGLE makes sense.

No need to be condescending.

> btrfs_reduce_alloc_profile() is called by btrfs_get_alloc_profile() where the
> 'flags' variable is set from 'fs_info->avail_{data,metadata,system}_alloc_bits.'
> 
> fs_info->avail_{data,metadata,system}_alloc_bits are set by
> set_avail_alloc_bits(), which *extends* the 'flags' using
> chunk_to_extended().
> 
> chunk_to_extended() checks if the profile is 0 (a.k.a. GROUP_SINGLE), and if so
> it sets the bit BTRFS_AVAIL_ALLOC_BIT_SINGLE to 1.
> 
> To say otherwise, on the platter the SINGLE profile is stored as 0, when in memory
> often it is stored as BTRFS_AVAIL_ALLOC_BIT_SINGLE.

That's all right, but I missed in my previous comment, and this description misses that the final 
value is passed through `extended_to_chunk`, which explicitly removes BRFS_AVAIL_ALLOC_BIT_SINGLE. 
So you're right, we can set allowed to BRFS_AVAIL_ALLOC_BIT_SINGLE, but it just gets wiped two lines 
down before returning :)

Having a fallback here which wipes all the bits but single and forces us to single still feels like 
very much the wrong fallback, if we want a fallback, we should pick a bit that exists on the fs, not 
make one up, and we should definitely not make one up that has a lower redundancy level than what 
the user is expecting.

I'm open to some other option (or go back to the highest-bit-set version), but I'd still prefer 
transaction-abort/remount-ro over SINGLE.

> Finally BTRFS_EXTENDED_PROFILE_MASK contains BTRFS_AVAIL_ALLOC_BIT_SINGLE (a.k.a
> SINGLE profile).

Right, my original analysis concluded that this doesn't matter and BTRFS_BLOCK_GROUP_PROFILE_MASK 
matters because alloc_profile_is_invalid decides its mask based on the `extended` flag (second 
argument), which selects between `BTRFS_EXTENDED_PROFILE_MASK` and `BTRFS_BLOCK_GROUP_PROFILE_MASK` 
- if `extended` is zero BTRFS_AVAIL_ALLOC_BIT_SINGLE would be unacceptable, whereas if it is 
non-zero it is. In my case (see the `[6.1] Transaction Aborted cancelling a metadata balance` 
thread) I'm looking at `btrfs_create_chunk` which calls alloc_profile_is_valid with a constant 0 for 
the second argument.

The WARN_ON+remount-ro/transaction-abort I saw in practice is called via the stack trace on that 
thread, and the flags field is set straight from btrfs_reserve_extent and then not updated until we 
hit alloc_profile_is_invalid, from what I can tell.

> In conclusion, it makes perfectly sense to check against BTRFS_AVAIL_ALLOC_BIT_SINGLE
> when you want to check a SINGLE profile.
> 
>>
>> The existing fallthrough will WARN all the time, so will simply remove it.
>>
>>>> +    else {
>>>> +        /* We should have selected a single flag by this point */
>>>> +        WARN(1, "Missing ordering for block group flags %llx", allowed);
>>>> +        allowed = rounddown_pow_of_two(allowed);
>>>
>>>
>>> I think that it is more coherent and safe to return BTRFS_AVAIL_ALLOC_BIT_SINGLE,
>>> when we encounter a new unknown profile.
>>>
>>> Coherent because btrfs_reduce_alloc_profile() selects a SINGLE profile when there
>>> is not a valid combination "selected profile" and "enough disks number".
>>
>> No, having a case where we randomly go from a RAID system to falling back to SINGLE is really not 
>> an okay fallback. We should just remount-ro.
> 
> Even thought I don't like the logic too, this logic is used from several years (if
> not from ever); and nobody complained.

Not sure what you're referring to here, I'm just a user trying to fix a transaction-abort I saw on 
my system and needed this patch to get my fs to mount RW :). At least the specific code in 
get_alloc_profile has no such fallback.

> Anyway for me it is enough to have a WARN_ON; but without that the patch losses most of
> its interest.

I don't really get this - the current code isn't just kinda messy, its also very broken, a patch 
that fixes the brokeness, which I ran into as a user, should be "interesting" irrespective of if it 
also cleans up the code, which is messy but certainly far from the worst code in kernel anywhere :).

Matt
