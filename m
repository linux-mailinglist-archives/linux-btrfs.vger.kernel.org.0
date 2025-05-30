Return-Path: <linux-btrfs+bounces-14342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5680AC97B2
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 00:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8DD16B5FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF427A454;
	Fri, 30 May 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BW4fZCmr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB5221573
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748643838; cv=none; b=IB8OjkJvzXNe8NvfYdQ/7eiTBay38fAAt4ClMEXib4DFy1Qcs8g1ZkG0FBqE3ekeL/l6WOpps9znFs8AavkfZZTQb+eyfgj6L2bijahvFhIZRuJSALEQ/b/IkBkc47Q/Exspvblq/ZEaOg36Ouo7ZQQ0dNnj8fixxqdhJc4Ng6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748643838; c=relaxed/simple;
	bh=85pP7tcRGSDPJmSueZpF/MKmxAY2IiuoP3TPdyZFqKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czwTJEzKiVhu+1krs8cDJ1+KcbQrkv/cHFPyhKRZ4Stw4K2B2fFWmgomhCi7JhdcuImcl003JEg6x3ir3bL/BzYCd4tH2mJlHKEJIAbIEtakaBXcgyNPbU1uM125GA9R0+ZLBL9X2tADBXi/vRcayN2/yqq+DBvSvDd6IJKKLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BW4fZCmr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so15901935e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748643834; x=1749248634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RqDJGzyob/tBt6i9jmUQdrVONRk4zMfA/Z04HgjJ/S0=;
        b=BW4fZCmrUtgNVKJdzU86BoCcE522mWlRWzjXD/wcjNDklB7eXFAB/WhlqSny5a8PSw
         BqZE03N2EBwJ2mns/+tBFKrfBrFSVM231fPbhqajLhLhuN6tRtXn2ZL/3gj1nlyunF3O
         Ms4KcqKAwOlC+tdEik0UevQw7lR1KligyzBhYnsOtBn41sFblbFd0tyBiJi5tXWtb52m
         wkuacR9jr6d8u1CthN/nltsIJkN5kEuqE0QqKkNL9R72ogs5wUtJtPa7SKVtFA0gow1k
         QzF5gRyJEvxBRJ6PQfSAOQgk+mXPjVgKLvSUwkOsjPihUg8ATnkF8umeIHqO5fqa/QS5
         Jd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748643834; x=1749248634;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqDJGzyob/tBt6i9jmUQdrVONRk4zMfA/Z04HgjJ/S0=;
        b=VEC+Ev5+x0XpENRsafiNAdMxJnLcixvpMXaC7fGB7XEUAKqflRhlI2i1cQbIqQLohk
         8e/Gh7MLOe/OXegQ7pMeDwm+KFhr5g6MD/n+IiKgpkSvSmy+iHUW8vxmt8aeuxYuuffL
         KYkbHkUVQN89HwtM6m9MeLciSeN4If+MT4hvtskOpst7NHlSRyD4QymA6YnElG7vZJ9v
         dm2Ubo2689oPGwBT/EktDYlMP3dnMc10V0nlu1oiD8doSbJ3rCbDWetPegpoVkHlmIsX
         UpFV8vjwpbN9by83jh+BOsVRruizjBWISVo2xX+gyKGDx+FIcTSWV6f4yMpsdR+AyNC+
         qndA==
X-Gm-Message-State: AOJu0Yx0lZSQ151OypecO6mj2h27XPdgJxLRTY2mhzJLWwotmRzfN0ns
	AWjwJp7wE2NWwNM8xb/gTk2w7cxmcY3OnBk2OLVokiR779jkzG3hl0GtwTWPbtpxWts=
X-Gm-Gg: ASbGncsE4jW7CdmWBNKHhEMQzMYgAhBouU9Nq9tZXLczzS7hM9eTscNfmAaDvedVcuW
	R692X16IMqogKzWLJ3TEnHG2rvovyfEpBV3L8GkWuDx8056juSk/RXDaVgxIDQ0ICADKA0hl3bQ
	eOS2xNvne1DHq0wqpWFqH8XIOWq0pp0jkz4ALYKyzfnrfMSc6au4oYsUpYGRWoO+iZuKSLzCdlx
	Jd0Iq2Vo3LaCPxGajpbP3z6h7ghYpmPbEtilXxkX8UvJqP4Z9pmkffw1wbv0rrIlFL5/ZgZt6nk
	hsQXq7LKzln1FJ0WA2c1zpAC7xe/yJ8nZQbfL3MOsfVL8YqQAejkuuqYJEZbpWEJxPfl1aDTL8K
	+5lI=
X-Google-Smtp-Source: AGHT+IHwfNcPPpOP8cAu0djk4agnGBZdUpCc/E3pMhMz61frLmHJgpc41RH/ssYXfY7NyRNksUJaaA==
X-Received: by 2002:a05:6000:1aca:b0:3a4:ef98:74f6 with SMTP id ffacd0b85a97d-3a4f89ad216mr3233000f8f.14.1748643833483;
        Fri, 30 May 2025 15:23:53 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab820sm3626534b3a.60.2025.05.30.15.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 15:23:52 -0700 (PDT)
Message-ID: <8064a4e8-fd7e-4a14-b7c3-ddfd75359664@suse.com>
Date: Sat, 31 May 2025 07:53:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] btrfs-progs: fix-data-checksum: update csum items
 to fix csum mismatch
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1747295965.git.wqu@suse.com>
 <c78f6903cbb952acad86ac026dd597645d0af31b.1747295965.git.wqu@suse.com>
 <20250530111945.GU4037@twin.jikos.cz>
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
In-Reply-To: <20250530111945.GU4037@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/30 20:49, David Sterba 写道:
> On Thu, May 15, 2025 at 05:30:20PM +0930, Qu Wenruo wrote:
>> +static int update_csum_item(struct btrfs_fs_info *fs_info, u64 logical,
>> +			    unsigned int mirror)
>> +{
>> +	struct btrfs_trans_handle *trans;
>> +	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
>> +	struct btrfs_path path = { 0 };
>> +	struct btrfs_csum_item *citem;
>> +	u64 read_len = fs_info->sectorsize;
>> +	u8 csum[BTRFS_CSUM_SIZE] = { 0 };
>> +	u8 *buf;
>> +	int ret;
>> +
>> +	buf = malloc(fs_info->sectorsize);
>> +	if (!buf)
>> +		return -ENOMEM;
> 
> Not fixed, but the block buffers can be on stack as well if they're just
> for the single function, the size is bounded.

Unfortunately the sectorsize is still runtime determined, thus it can 
not be on-stack.

Thanks,
Qu>
>> +	ret = read_data_from_disk(fs_info, buf, logical, &read_len, mirror);
>> +	if (ret < 0) {
>> +		errno = -ret;
>> +		error("failed to read block at logical %llu mirror %u: %m",
>> +			logical, mirror);
>> +		goto out;
>> +	}
>> +	trans = btrfs_start_transaction(csum_root, 1);
>> +	if (IS_ERR(trans)) {
>> +		ret = PTR_ERR(trans);
>> +		errno = -ret;
>> +		error_msg(ERROR_MSG_START_TRANS, "%m");
>> +		goto out;
>> +	}
>> +	citem = btrfs_lookup_csum(trans, csum_root, &path, logical,
>> +				  BTRFS_EXTENT_CSUM_OBJECTID, fs_info->csum_type, 1);
>> +	if (IS_ERR(citem)) {
>> +		ret = PTR_ERR(citem);
>> +		errno = -ret;
>> +		error("failed to find csum item for logical %llu: $m", logical);
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto out;
>> +	}
>> +	btrfs_csum_data(fs_info, fs_info->csum_type, buf, csum, fs_info->sectorsize);
>> +	write_extent_buffer(path.nodes[0], csum, (unsigned long)citem, fs_info->csum_size);
>> +	btrfs_release_path(&path);
>> +	ret = btrfs_commit_transaction(trans, csum_root);
>> +	if (ret < 0) {
>> +		errno = -ret;
>> +		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
>> +	}
>> +	printf("Csum item for logical %llu updated using data from mirror %u\n",
>> +		logical, mirror);
>> +out:
>> +	free(buf);
>> +	btrfs_release_path(&path);
>> +	return ret;
>>   }
>>   
>>   static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,


