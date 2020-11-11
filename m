Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E882AF3FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 15:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgKKOn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 09:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgKKOnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 09:43:53 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E451C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 06:43:53 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id 7so1427309qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8gRU5o5b4buqGDetAscdBGbA5neFJzBzU6PhSRuH7lM=;
        b=AH3FklJqQJ1Jhq5OYmy/E2aSaV7ufVJbqJFM5vHD0K+oq0HxPMD6yLeu6+O/sCT3fR
         /EVvQUWVsfNBFyQNuiw15Ou+ECWz1m8jPxpWJyVda2p29MaWXpETvzVikwBwcIeJgPRH
         wN37vLUGEatswUNsTsj+PUow/aXdoY3qtEsnJJr+QswsBqv7ULzu6LY+0tbmwcLQlQag
         T4aZSX1jM3yVI1WBJalrtpqPFPdejjKyk+takm2vCw5xfPTySPFZCqJZ3cJXzWy86bsV
         2a5tgXZt2A46QnEMTnDtt/CJ1wmeSCRd67lIMiT6wWU4PwHw6egXUUXOTenbUFHNwGxP
         QgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8gRU5o5b4buqGDetAscdBGbA5neFJzBzU6PhSRuH7lM=;
        b=gKEvUq3eGPRUEjQ9AKq/qeZEhauHRCN40Yy+bE985e/Zo1ZldIp57YAc606pcZlIrq
         JA1YI6DOQErQHBWTpIUordbTFffeBAYJdacBEC33c1Vlh2hp8NzvUf+dZTNZ04fbIdyo
         1oP4MjHrLZibEYlWQGajK0zYzxJhoj9Sxy2Mz22U192xN7PAU6fQYPC4sWkL8uB3wHa+
         kSdjW4GaKStGwYMmE8TSN9aIZwYUS22U/RWtQYFIAWGhv2xyxbv5zSIJDCudpLQB+Ieg
         zC85cA8Q1Y2YdTHkC3a1KxnvO0rg0u5f8MRFh5aZVCnUDJW9OYVhnHQLbi2D6SJN8kse
         /Caw==
X-Gm-Message-State: AOAM532i/ZtQMGuo4m+vaAcvVlULncsG4ieQ1LHdLlgvq1T5pluyfKcu
        aTPN030kPe10YejNvP+tx+kUOA==
X-Google-Smtp-Source: ABdhPJw2icyqRJg/xhC3eofwgjByuasd9NlBsfkHswUMRWB7eonH8UQTz9MB5AVFIs4TIB71LXfyBA==
X-Received: by 2002:ac8:24e5:: with SMTP id t34mr24938565qtt.0.1605105832419;
        Wed, 11 Nov 2020 06:43:52 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q189sm2249574qkd.41.2020.11.11.06.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 06:43:51 -0800 (PST)
Subject: Re: [PATCH 4/8] btrfs: remove the recursion handling code in
 locking.c
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1604697895.git.josef@toxicpanda.com>
 <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
 <20201111142930.GP6756@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <007a92c9-7af3-9aec-ba65-fc9ff3cda132@toxicpanda.com>
Date:   Wed, 11 Nov 2020 09:43:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201111142930.GP6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/11/20 9:29 AM, David Sterba wrote:
> On Fri, Nov 06, 2020 at 04:27:32PM -0500, Josef Bacik wrote:
>> @@ -71,31 +47,7 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
>>   	if (trace_btrfs_tree_read_lock_enabled())
>>   		start_ns = ktime_get_ns();
>>   
>> -	if (unlikely(recurse)) {
>> -		/* First see if we can grab the lock outright */
>> -		if (down_read_trylock(&eb->lock))
>> -			goto out;
>> -
>> -		/*
>> -		 * Ok still doesn't necessarily mean we are already holding the
>> -		 * lock, check the owner.
>> -		 */
>> -		if (eb->lock_owner != current->pid) {
> 
> This
> 
>> -			down_read_nested(&eb->lock, nest);
>> -			goto out;
>> -		}
>> -
>> -		/*
>> -		 * Ok we have actually recursed, but we should only be recursing
>> -		 * once, so blow up if we're already recursed, otherwise set
>> -		 * ->lock_recursed and carry on.
>> -		 */
>> -		BUG_ON(eb->lock_recursed);
>> -		eb->lock_recursed = true;
>> -		goto out;
>> -	}
>>   	down_read_nested(&eb->lock, nest);
>> -out:
>>   	eb->lock_owner = current->pid;
>>   	trace_btrfs_tree_read_lock(eb, start_ns);
>>   }
>> @@ -136,22 +88,11 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
>>   }
>>   
>>   /*
>> - * Release read lock.  If the read lock was recursed then the lock stays in the
>> - * original state that it was before it was recursively locked.
>> + * Release read lock.
>>    */
>>   void btrfs_tree_read_unlock(struct extent_buffer *eb)
>>   {
>>   	trace_btrfs_tree_read_unlock(eb);
>> -	/*
>> -	 * if we're nested, we have the write lock.  No new locking
>> -	 * is needed as long as we are the lock owner.
>> -	 * The write unlock will do a barrier for us, and the lock_recursed
>> -	 * field only matters to the lock owner.
>> -	 */
>> -	if (eb->lock_recursed && current->pid == eb->lock_owner) {
> 
> And this were the last uses of the lock_owner inside locks, so when the
> recursion is gone, the remainig use:
> 
> btrfs_init_new_buffer:
> 
> 4624         /*
> 4625          * Extra safety check in case the extent tree is corrupted and extent
> 4626          * allocator chooses to use a tree block which is already used and
> 4627          * locked.
> 4628          */
> 4629         if (buf->lock_owner == current->pid) {
> 4630                 btrfs_err_rl(fs_info,
> 4631 "tree block %llu owner %llu already locked by pid=%d, extent tree corruption detected",
> 4632                         buf->start, btrfs_header_owner(buf), current->pid);
> 4633                 free_extent_buffer(buf);
> 4634                 return ERR_PTR(-EUCLEAN);
> 4635         }
> 
> And
> 
> 185
> 186 /*
> 187  * Helper to output refs and locking status of extent buffer.  Useful to debug
> 188  * race condition related problems.
> 189  */
> 190 static void print_eb_refs_lock(struct extent_buffer *eb)
> 191 {
> 192 #ifdef CONFIG_BTRFS_DEBUG
> 193         btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
> 194                    atomic_read(&eb->refs), eb->lock_owner, current->pid);
> 195 #endif
> 196 }
> 
> The safety check added in b72c3aba09a53fc7c18 ("btrfs: locking: Add
> extra check in btrfs_init_new_buffer() to avoid deadlock") and it seems
> to be useful but I think it builds on the assumptions of the previous
> tree locks. The mentioned warning uses the recursive locking which is
> being removed.

Sorry I should have explained why I was leaving this in my cover letter.  The 
safety check is for the case that the free space cache is corrupted and we try 
to allocate a block that we are currently using and have locked in the path.  I 
would have preferred to move it under CONFIG_BTRFS_DEBUG, but it does actually 
help in the case of a bad free space cache, so I think we have to keep it.  Thanks,

Josef
