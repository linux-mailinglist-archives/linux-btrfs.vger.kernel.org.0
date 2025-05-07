Return-Path: <linux-btrfs+bounces-13815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC0AAEF16
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 01:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67FA4E4EA9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 23:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A9289834;
	Wed,  7 May 2025 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBmeVr41"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB628C027
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659525; cv=none; b=eubVBK3aF+Y3IJg4thT+M7rWG3uGvLSWdRwZRZa7MUFvWfAdz4S+ICnbgBav+CWMDY1Sf06OdyTqumTOWHK3rCYvKg8tdk6DjKRidL7mTFVWiVibnxq/IOy5NLgsy7pScZcYBnre/Sc61wQA1vbGmX5d2EUyYJ8JxiGF7I7wd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659525; c=relaxed/simple;
	bh=hxQjHfiyh/8Weqa567QTjrIbLU8bz1RVTHJmsvYlry8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTvq10SWOewZe+t9fUt3rilJYPFeFeSwUFnGxU2Wlept/infV7aeYgd3aY2s4cyXtWywBpQGEBymiuoEA4iS9B95tXjca8yvzgnJkQOEfEPn39NbDHP4H97QPoCmv5S6EVi8Bz7GdXKzwOTCfSE8Ns6hpfryR8RaAKHagQ1X8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBmeVr41; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so4001865e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 May 2025 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746659521; x=1747264321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PV0KP1nwAL13fv7CA5X9ErJBie3DBFX1I9ldP1RpU4w=;
        b=eBmeVr41Z5319LcGapSzkz+DsVzMEmE07Q8fr/cyXCymyPwgdnp9HO8ZkAVwrk8c26
         A8fW1ulBnRbh+co0evZYTKrTTi5ilJdBgCPg23aA2+1ofecSC9iubax9thyr9naNC/nN
         LQk4zOzEeWQpU24d6yZ9dDi8wDSs0kKnK3yLhQtEXM/w1SYxh4ytAwUxZ19fhBInNwVo
         6iCM+B0ZGYP+3TQEfO6KognORLjfBPLxdtjN8OKvkrdsLAoGXCe9e1EYdFu1ScOs7ku/
         yNZsd2BpiyornOVBteS00W/3BP+yAHotX8og9sQ5BSeM+dWPuifB+myZpRQ85quxJ2rI
         m4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746659521; x=1747264321;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV0KP1nwAL13fv7CA5X9ErJBie3DBFX1I9ldP1RpU4w=;
        b=SMe4YeDG0201hXKd8nNJPHOJoQ0kuwPWN7m3WyNDn6UzcvbCyAWgpVhpC1nzRHP6Fh
         66X7wqUBTVi/UmEZcd9eg1r17WHbfTubPS6VWHkWZSH/LINZf3k7XC3uM/P2f/yu4jCN
         X2H7Ewr/CbkXeczQ+OOVdlsCwsoRE1qKRPyvCZJ0zDiSBl/iTyAtXALkB8cjcLHQlAik
         N8DKjSGdBsrGNlwGOQUAeYY7fjwgk4q3IyWqjv0zst4+lJcbrFSvbfoxm9PgYsSnqisI
         fs2AYAc0XreY5dKi7C3rb3AYIKjIJzwoMKFipNDzczXjJErtDE4jInB0TsJY9h3/EVil
         UG5g==
X-Gm-Message-State: AOJu0YzRwZZU1v4u/jaz+jnT28x13JTBHPjjq24wITYaIe+HiZOzt06n
	BTbX7u3Pl4VklBXlNZDkElihkBluje/IXsEWqJsZizoZgphz/urNBsGILNwYUT0yqAGwAh5ismo
	6
X-Gm-Gg: ASbGncv0DARepyOp+wpOYpS4AcwA/6iUT92G46QCp7Bor4P2OrvIE+7QGgXTVWG9jr8
	gdTwMFSXlFPwjRkELgY679CXepcOokG3KUquU4ETlmcZQP3sOnWDNqUEjp0YfM6Kwzzi+HGQN+i
	QgWDvE77d8egIaFFo5EpLT3mmU5M4z1HDBnXX7c1B4RffBQXfnpwu1uyOVt12Ozksu7Zo6sIbEM
	UxC7pLiwPMhOyPmjM5GdDFcmYvNJ3cWBLm5RxQ2UP95CcKHv0u7PiYu5lpwWLCNhDZxdqMhC1Dv
	ok7hip4XW+p0Q3di7GqwjQ8tn/fRLW0mg5h4j1CMYjK1P+KwKWoRl5G+wOb7bB0Yq/NVOEnlHc1
	z1UM=
X-Google-Smtp-Source: AGHT+IGgk3ZcRh6d0u8jtWVXMh9gel+tn4sGWF+qJDjdIi9aER3JPhJ+rgi4nZOz/d5fvK9SU2Gu2w==
X-Received: by 2002:a05:6000:402c:b0:3a0:aed9:e39 with SMTP id ffacd0b85a97d-3a0b4a24be6mr4326840f8f.28.1746659520864;
        Wed, 07 May 2025 16:12:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902104fsm11843181b3a.115.2025.05.07.16.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 16:12:00 -0700 (PDT)
Message-ID: <ccacb32f-e345-49c7-9c6b-8bdc72c69a7f@suse.com>
Date: Thu, 8 May 2025 08:41:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
To: Boris Burkov <boris@bur.io>, fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <cover.1746638347.git.fdmanana@suse.com>
 <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
 <20250507223347.GB332956@zen.localdomain>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250507223347.GB332956@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/8 08:03, Boris Burkov 写道:
> On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> If we fail to allocate an ordered extent for a COW write we end up leaking
>> a qgroup data reservation since we called btrfs_qgroup_release_data() but
>> we didn't call btrfs_qgroup_free_refroot() (which would happen when
>> running the respective data delayed ref created by ordered extent
>> completion or when finishing the ordered extent in case an error happened).
>>
>> So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
>> ordered extent for a COW write.
> 
> I haven't tried it myself yet, but I believe that this patch will double
> free reservation from the qgroup when this case occurs.
> 
> Can you share the context where you saw this bug? Have you run fstests
> with qgroups or squotas enabled? I think this should show pretty quickly
> in generic/475 with qgroups on.
> 
> Consider, for example, the following execution of the dio case:
> 
> btrfs_dio_iomap_begin
>    btrfs_check_data_free_space // reserves the data into `reserved`, sets dio_data->data_space_reserved
>    btrfs_get_blocks_direct_write
>      btrfs_create_dio_extent
>        btrfs_alloc_ordered_extent
>          alloc_ordered_extent // fails and frees refroot, reserved is "wrong" now.
>        // error propagates up
>      // error propagates up via PTR_ERR
> 
> which brings us to the code:
> if (ret < 0)
>          goto unlock_err;
> ...
> unlock_err:
> ...
> if (dio_data->data_space_reserved) {
>          btrfs_free_reserved_data_space()
> }
> 
> so the execution continues...
> 
> btrfs_free_reserved_data_space
>    btrfs_qgroup_free_data
>      __btrfs_qgroup_release_data
>        qgroup_free_reserved_data
>          btrfs_qgroup_free_refroot
> 
> This will result in a underflow of the reservation once everything
> outstanding gets released.

That should still be safe.

Firstly at alloc_ordered_extent() we released the qgroup space already, 
thus there will be no EXTENT_QGROUP_RESERVED range in extent-io tree 
anymore.

Then at the final cleanup, qgroup_free_reserved_data_space() will 
release/free nothing, because the extent-io tree no longer has the 
corresponding range with EXTENT_QGROUP_RESERVED.

This is the core design of qgroup data reserved space, which allows us 
to call btrfs_release/free_data() twice without double accounting.

> 
> Furthermore, raw calls to free_refroot in cases where we have a reserved
> changeset make me worried, because they will run afoul of races with
> multiple threads touching the various bits. I don't see the bugs here,
> but the reservation lifetime is really tricky so I wouldn't be surprised
> if something like that was wrong too.

This free_refroot() is the common practice here. The extent-io tree 
based accounting can only cover the reserved space before ordered extent 
is allocated.

Then the reserved space is "transferred" to ordered extent, and 
eventually go to the new data extent, and finally freed at 
btrfs_qgroup_account_extents(), which also goes the free_refroot() way.

> 
> As of the last time I looked at this, I think cow_file_range handles
> this correctly as well. Looking really quickly now, it looks like maybe
> submit_one_async_extent() might not do a qgroup free, but I'm not sure
> where the corresponding reservation is coming from.
> 
> I think if you have indeed found a different codepath that makes a data
> reservation but doesn't release the qgroup part when allocating the
> ordered extent fails, then the fastest path to a fix is to do that at
> the same level as where it calls btrfs_check_data_free_space or (however
> it gets the reservation), as is currently done by the main
> ordered_extent allocation paths. With async_extent, we might need to
> plumb through the reserved extent changeset through the async chunk to
> do it perfectly...

I agree with you that, the extent io tree based double freeing 
prevention should only be the last safe net, not something we should 
abuse when possible.

But I can't find a better solution, mostly due to the fact that after 
the btrfs_qgroup_release_data() call, the qgroup reserved space is 
already released, and we have no way to undo that...

Maybe we can delayed the qgroup release/free calls until the ordered 
extent @entry is allocated?

Thanks,
Qu


> 
> Thanks,
> Boris
> 
>>
>> Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak")
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>   fs/btrfs/ordered-data.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>> index ae49f87b27e8..e44d3dd17caf 100644
>> --- a/fs/btrfs/ordered-data.c
>> +++ b/fs/btrfs/ordered-data.c
>> @@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
>>   	struct btrfs_ordered_extent *entry;
>>   	int ret;
>>   	u64 qgroup_rsv = 0;
>> +	const bool is_nocow = (flags &
>> +	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
>>   
>> -	if (flags &
>> -	    ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
>> +	if (is_nocow) {
>>   		/* For nocow write, we can release the qgroup rsv right now */
>>   		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
>>   		if (ret < 0)
>> @@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
>>   			return ERR_PTR(ret);
>>   	}
>>   	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
>> -	if (!entry)
>> +	if (!entry) {
>> +		if (!is_nocow)
>> +			btrfs_qgroup_free_refroot(inode->root->fs_info,
>> +						  btrfs_root_id(inode->root),
>> +						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
>>   		return ERR_PTR(-ENOMEM);
>> +	}
>>   
>>   	entry->file_offset = file_offset;
>>   	entry->num_bytes = num_bytes;
>> -- 
>> 2.47.2
>>
> 


