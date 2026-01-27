Return-Path: <linux-btrfs+bounces-21126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMGTFtcpeWkIvwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21126-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:10:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC1B9A9FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1769302DA10
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802429BDB0;
	Tue, 27 Jan 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cq/VpB9z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FF27603A
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548231; cv=none; b=r1nZIevY78OphvLeyBTH3KfnXSj6C7BE/ObOOOrCxFGzlPg2Keq4s7rfV4K0N5ZgwgnVw8A6PNTdGG6Eknl/kkAPseHvM8ZCPpALdCzTNTI7tGj9fWByt+P1A2oKSuvOSs381dc8FxjtvEosO9Q6Kboqa2+yiCGeaHz5xs6I4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548231; c=relaxed/simple;
	bh=j5UIW57yw3+e8+tMnfrbNZTHE9X1pu1VhFVBARnNmZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRSgxVSNi/kBBljxRRu7I08+Z0qb6MeSJ9Px3XqbBey0bwP4W2rXEy4kT+K7ESatLkswoCVZe4FuF8u0yYEY3Tpeq5/xHGufackqebnUKXNNbQ+PGo7Hf50XAAzwi4xvAWzetdrDAvkKWPKdsSwucAWd+3f49qEMTCohZsgd00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cq/VpB9z; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4806bf03573so4431355e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 13:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769548228; x=1770153028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XFd8RO7NkGox/byVgwvZfAMgl/b6q+KsEvJutnkqvZs=;
        b=Cq/VpB9zQIT0QQqnGJWIVbqo9m9JnNazbcs+8ukDiHqPRjlk0Wnz6Iupn6leQhJ288
         qvutxjUjtRiay01uE2j79gykOq6Xgs7RMAC+N1+gPAYWjEsI8Fetq6lBinmK23Y+vj2g
         om231VSeUUYFxq8Ms/M+XJthiYo9nCDILXHdWRm8VuH2i2+iOOdAGBxmMIC+v7oBGGbz
         biSO5/XUsOzOds38TT86QLVDqk0GnwVNm3y0mMapZT9/vfqI8icQOkMQ8ijpguAMcvOC
         Mi8WBRzGR1dZgquSkaFcPP7KS0cNxC7I2Hzk4urx4E5+2/p8iBiXDv5jmy3vdLtNuA1b
         uf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769548228; x=1770153028;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFd8RO7NkGox/byVgwvZfAMgl/b6q+KsEvJutnkqvZs=;
        b=kY+tiwhZikPXUQW3/BR7zxqUro4GeXjsFeG9URnvQzZM0u23pGxGmf3J2Bgzok6WhL
         YaflSS9NGtHln+GJT88cFsjBCeHWmpzHMta3i2Jw64ijpXTN7nRgAqm/epEerUt9dWCV
         yyKpabtzJexiobJItie9FXqcrbG0/UcvDotUZc8y0Z8oZHQJbGR+fD4NfQMqqGzaNr4d
         wsm8YFImDTf6+dW1WprlHzmesbo72oRwT34m0EOZnmG59Ldk7fQIjL/fsHTQBqTC5G+M
         HTxV5d2M0fjpMXlXLLut5/E2IJ+wQ8ma7ks4lcjYVRY+2aFRV+aTzVKBbtlw40HP4z/t
         xwEA==
X-Gm-Message-State: AOJu0YwjVTKPbS1jO/mC5A2aURqn4GMl8Mejm6lr4epRtGSS5V//uET1
	daxRuHj74qhaGC6NoBjkp5J7jUaRCni06NGB4KXOchHriOgr240XhLp3GWyYdPVQhHgFBylO534
	pbYEg9ko=
X-Gm-Gg: AZuq6aJqLFzR5H0bbEK9I8C8AHwgEpq31VcBP8fnJUMFf3tiDQQc4QJ8gWEneVxRLgT
	qxf6/+7OBAs1q9cBg8JKO1CIEzbVAFPW040toiFHpLHu97Hvigto/hNOTl2BUdmpo8fGj+ll8Jw
	V0PFsUMVKuWJdMoLMGke5rv+t1AG7dl2FgZHncpRmYALcc+JjY4DuS1Rnub8GdkD1NQYpB4I1yX
	bl3jRxEkqZVzXYfezcWiC4q1KPgoWvdemptu8O/qrD+q249p/s4UsggXk5aAWCBDAbB0zjssSnE
	wRlq0c6k/BSfA2mqSOSi5VtsqagqIR22N/CTUB4GOBAOzsp9MwxthJVEaJ/ZsSH9MPF20D+vVsz
	56Cq1ndxs3WEik7SWoJs6wqY0YA6LBX7myzAuHW8g/hAZpWbaa0Lz6b7Kp5CV3uhenj/Lh62+C2
	r9neRsJcHAf34NTmcJ4TpXk2/W6RPTrn1GWegQuco=
X-Received: by 2002:a05:600c:6995:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-48069c92c03mr40942615e9.31.1769548227989;
        Tue, 27 Jan 2026 13:10:27 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eede6sm2507465ad.18.2026.01.27.13.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 13:10:27 -0800 (PST)
Message-ID: <a14a1533-ed6b-4c98-9ae8-c742efc7c28c@suse.com>
Date: Wed, 28 Jan 2026 07:40:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] btrfs: get rid of compressed_folios[] usage for
 encoded writes
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1769482298.git.wqu@suse.com>
 <9781beb3fa2948d125d16393d755c60096b855e8.1769482298.git.wqu@suse.com>
 <20260127202805.GA3504710@zen.localdomain>
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
In-Reply-To: <20260127202805.GA3504710@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21126-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: CBC1B9A9FC
X-Rspamd-Action: no action



在 2026/1/28 06:58, Boris Burkov 写道:
> On Tue, Jan 27, 2026 at 01:40:41PM +1030, Qu Wenruo wrote:
>> Currently only encoded writes utilized btrfs_submit_compressed_write(),
>> which utilized compressed_bio::compressed_folios[] array.
>>
>> Change the only call site to call the new helper,
>> btrfs_alloc_compressed_write(), to allocate a compressed bio, then queue
>> needed folios into that bio, and finally call
>> btrfs_submit_compressed_write() to submit the compreseed bio.
>>
>> This change has one hidden benefit, previously we use
>> btrfs_alloc_folio_array() for the folios of
>> btrfs_submit_compressed_read(), which doesn't utilize the compression
>> page pool for bs == ps cases.
>>
>> Now we call btrfs_alloc_compr_folio() which will benefit from page pool.
>>
>> The other obvious benefit is that we no longer need to allocate an array
>> to hold all those folios, thus one less error path.
> 
> This review is from claude using Chris's review prompts with some light
> editing / checking by me.

Wow, the AI review is better than I thought.

Indeed caught two real and careless errors.

[...]
>> +		if (bytes < min_folio_size)
>> +			folio_zero_range(folio, bytes, min_folio_size - bytes);
>> +		ret = bio_add_folio(&cb->bbio.bio, folio, folio_size(folio), 0);
>> +		if (!unlikely(ret)) {
> 
> Should this be unlikely(!ret) instead of !unlikely(ret)?

My bad, it should follow all the other sites to use if (unlikely(!ret)), 
but the heatwave makes my fingers slip.

> 
> While !unlikely(ret) evaluates to the same boolean result as !ret, the
> branch prediction hint is inverted.
> 
>> +			folio_put(folio);
>> +			ret = -EINVAL;
>> +			goto out_cb;
>>   		}
>> -		if (bytes < PAGE_SIZE)
>> -			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
>> -		kunmap_local(kaddr);
> 
> Is there a missing kunmap_local(kaddr) here? The original code called
> kunmap_local() after the memset:
> 
>      if (bytes < PAGE_SIZE)
>          memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
>      kunmap_local(kaddr);

I replaced the memset() with folio_zero_range() but incorrectly deleted 
the kunmap_local().

The proper location of the kunmap_local() would be after the if 
(copy_from_iter()) block.'
Or even move the copy_from_iter() out of the if (), and immediately 
kunmap(), then check the returned value.

Thanks a lot for the AI assistant review, which is better than my 
expectation.
Qu

> 
> But the new code appears to have lost the corresponding kunmap_local().
> 
>>   	}
>> +	ASSERT(cb->bbio.bio.bi_iter.bi_size == disk_num_bytes);
>>   
>>   	for (;;) {
>>   		ret = btrfs_wait_ordered_range(inode, start, num_bytes);
>>   		if (ret)
>> -			goto out_folios;
>> +			goto out_cb;
>>   		ret = invalidate_inode_pages2_range(inode->vfs_inode.i_mapping,
>>   						    start >> PAGE_SHIFT,
>>   						    end >> PAGE_SHIFT);
>>   		if (ret)
>> -			goto out_folios;
>> +			goto out_cb;
>>   		btrfs_lock_extent(io_tree, start, end, &cached_state);
>>   		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
>>   		if (!ordered &&
>> @@ -9962,7 +9970,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>>   	    encoded->unencoded_offset == 0 &&
>>   	    can_cow_file_range_inline(inode, start, encoded->len, orig_count)) {
>>   		ret = __cow_file_range_inline(inode, encoded->len,
>> -					      orig_count, compression, folios[0],
>> +					      orig_count, compression,
>> +					      bio_first_folio_all(&cb->bbio.bio),
>>   					      true);
>>   		if (ret <= 0) {
>>   			if (ret == 0)
>> @@ -10007,7 +10016,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>>   
>>   	btrfs_delalloc_release_extents(inode, num_bytes);
>>   
>> -	btrfs_submit_compressed_write(ordered, folios, nr_folios, 0, false);
>> +	btrfs_submit_compressed_write(ordered, cb);
>>   	ret = orig_count;
>>   	goto out;
>>   
>> @@ -10029,12 +10038,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>>   		btrfs_free_reserved_data_space_noquota(inode, disk_num_bytes);
>>   out_unlock:
>>   	btrfs_unlock_extent(io_tree, start, end, &cached_state);
>> -out_folios:
>> -	for (i = 0; i < nr_folios; i++) {
>> -		if (folios[i])
>> -			folio_put(folios[i]);
>> -	}
>> -	kvfree(folios);
>> +out_cb:
>> +	if (cb)
>> +		cleanup_compressed_bio(cb);
>>   out:
>>   	if (ret >= 0)
>>   		iocb->ki_pos += encoded->len;
>> -- 
>> 2.52.0
>>


