Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A527233C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 01:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjFEXpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 19:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFEXpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 19:45:54 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76B63CD
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 16:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1686007262; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=ObioTK9SnqGlTBExabvZXR48kHwjk/xI7PMwCAnejy0=; b=NRkQLX/BR4BDa
        aitGJzGyelV+8w9UO1IeoTA4+JXKZzWQlMXedq5mOQFFW8OeiBKNboqkHqmj+jlJ9z6gkeMZbE6Cj
        /MMmgCoirwYaI1h6ACK3LTpTLQ7yLl5DuBsZvf0b4q+7MmsWdIs+wBrAO6ydRbWM1219Pc9DWukq9
        jZm9JjrjKZNre5GnpS6CJv58jShd/zmufSUTjn8af2HjqGvkw0JLvFnhjk8JYQ1j0p9YWrp3Jdn0K
        0j+SMfCAwWRcz+4iy56LQrUqH0vZOPq0IPEVKU7pW9MCPwxvA6nBsNAwFvSo50SrOAaRpFj0z3n/Q
        TDPJrJOOJWqCpUT/xQ6jg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1686007263; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=ObioTK9SnqGlTBExabvZXR48kHwjk/xI7PMwCAnejy0=; b=aDbr4jSwh4HJKK1NTuYuDspjFw
        2/NTQOrXyAwds6FRgCTP/FKKVaEG628UlsHHfd7Z3QqQCD9YDKmBKkXhiItEq6PzilO+BH1OnIRkO
        DbNYvYQ3nJRnHktD/7fasofWjtojJ9iBc93jnWpD1QS4AeJcwKbSO1rlBoofciTc1GKxyMdEn7HBc
        AAvcEP0aB1t6+vzbFykUNbF3q0coYxzv7P4a06XAkeLsm3Gqf+viROXIlUDPjd7rlMtiL+1+iAhJc
        nK1er9YnlJM96AZYodHltJAhZ4aRTObDfrOcDyojafr3DMLqzQG/h+bwvi4dvfrwl0Kwp7qxncMRY
        RvYpKqZA==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q6JtX-004ePl-0J;
        Mon, 05 Jun 2023 23:45:51 +0000
Message-ID: <e3636d48-92c7-27e3-b63e-b3605fcc1dbf@bluematt.me>
Date:   Mon, 5 Jun 2023 16:45:50 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
Content-Language: en-US
To:     kreijack@inwind.it, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <276ea9bf-13f3-1349-a5b6-4dfcaaab7ef2@bluematt.me>
 <ed8c45b9-1b83-d706-add9-fa2d5f41576d@libero.it>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <ed8c45b9-1b83-d706-add9-fa2d5f41576d@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/5/23 2:10 PM, Goffredo Baroncelli wrote:
> Hi Matt,
> On 05/06/2023 21.31, Matt Corallo wrote:
> Does SINGLE is missing too ? It should be replaced by
> BTRFS_AVAIL_ALLOC_BIT_SINGLE...

Right, explains why there was no fallthrough before.

>> Because of the way it checks, if we have blocks with different
>> profiles and at least one is known, that profile will be selected.
>> However, if none are known we may return a flag set with multiple
>> allocation profiles set.
> [...]
>>
>> Signed-off-by: Matt Corallo <blnxfsl@bluematt.me>
>> ---
>>   fs/btrfs/block-group.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 4b69945755e4..60b3fe910a4a 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -79,16 +79,28 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>>       }
>>       allowed &= flags;
>>
>> -    if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>> +    /* Select the highest-redundancy RAID level */
>> +    if (allowed & BTRFS_BLOCK_GROUP_RAID1C4)
>> +        allowed = BTRFS_BLOCK_GROUP_RAID1C4;
>> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>           allowed = BTRFS_BLOCK_GROUP_RAID6;
>> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID1C3)
>> +        allowed = BTRFS_BLOCK_GROUP_RAID1C3;
>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>           allowed = BTRFS_BLOCK_GROUP_RAID5;
>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>           allowed = BTRFS_BLOCK_GROUP_RAID10;
>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>           allowed = BTRFS_BLOCK_GROUP_RAID1;
>> +    else if (allowed & BTRFS_BLOCK_GROUP_DUP)
>> +        allowed = BTRFS_BLOCK_GROUP_DUP;
>>       else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>>           allowed = BTRFS_BLOCK_GROUP_RAID0;
> 
> +    else if (allowed & BTRFS_AVAIL_ALLOC_BIT_SINGLE)
> +        /* BTRFS_BLOCK_GROUP_SINGLE would be 0, so
> +           use BTRFS_AVAIL_ALLOC_BIT_SINGLE */
> +        allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE;

No, this doesn't work, BTRFS_BLOCK_GROUP_PROFILE_MASK does *not* include the SINGLE profile, and 
alloc_profile_is_valid would still vomit, SINGLE has to return zero here.

The existing fallthrough will WARN all the time, so will simply remove it.

>> +    else {
>> +        /* We should have selected a single flag by this point */
>> +        WARN(1, "Missing ordering for block group flags %llx", allowed);
>> +        allowed = rounddown_pow_of_two(allowed);
> 
> 
> I think that it is more coherent and safe to return BTRFS_AVAIL_ALLOC_BIT_SINGLE,
> when we encounter a new unknown profile.
> 
> Coherent because btrfs_reduce_alloc_profile() selects a SINGLE profile when there
> is not a valid combination "selected profile" and "enough disks number".

No, having a case where we randomly go from a RAID system to falling back to SINGLE is really not an 
okay fallback. We should just remount-ro.

> Safe because using rounddown_pow_of_two() assumes:
> - the highest bit is the safest choice
> - a new profile will be represented by *only* one bit
> - the higher bits are only used for select a profile [*]
> 
> Even tough all these assumption are quite reasonable alone, I am not confident
> that together make the code less brittle than before, which was a goal of this patch.
> 
> So I suggest to return BTRFS_AVAIL_ALLOC_BIT_SINGLE.
> 
> BR
> G.Baroncelli
> 
> [*] for example see BTRFS_SPACE_INFO_GLOBAL_RSV
> 
>> +    }
>>
>>       flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>
> 
