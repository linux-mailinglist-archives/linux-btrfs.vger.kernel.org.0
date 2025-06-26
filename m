Return-Path: <linux-btrfs+bounces-14981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C119DAE98BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784A9188C44A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99F293C60;
	Thu, 26 Jun 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TdnmqeC/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCE25BF08
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927452; cv=none; b=OSA94e+zXYlJj8aNvEx09ZdcrTMuhrADYnF9TVoKUvbejql898mHdEr5hW1vSRr0KIlnQYhqM0/+FyZ9zALnfJCjkdSo3z4DlCMD7hU0zACvPtEK0wKruqJpSa7VaUHdsC+0NSmDTgKUBPh1hpQITVqMCVNvoraeHqfYGCPAqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927452; c=relaxed/simple;
	bh=8L5ExMvo6qk/tsjlQvMmvrihPQ//4a20pMuZToIOlwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQ7Plyi8iYAKZtLUnfZqnKFd61hAUUtkCY4XAHN+TFKVsr0oszstkz+eGWM6wf4TAQdu6V9+rJZEQ9oxyO6IEDA+AKhoP6Ln1MNdXnBmAXciKxyqUZjgCoZbYs/iBg0QxtIMgKcYhGxInuDvoyYFE5DGWgErCuVonNdk3o6Tn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TdnmqeC/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45377776935so6478415e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750927449; x=1751532249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jo5462XH/J0CHUJB31BqUZLvosDDfk454xCnbCM4JXw=;
        b=TdnmqeC/cwvnbrvp4wo/NBWCQqXdSgZIhztYw/lhu7hAoHTkcOEXNzrAeXKMDGMK8K
         v6XpxMZMamSqM0v5EqpSKW94CKp4Mn4/RcqtqhAoUHgaFY02Ze0MvwKK/fRSXWm74cV4
         k6znBPV2oaPjnuBt9H3uwWt6+XM64x3gb8jJO75g1y+yP/W+hG6zdomHTmRGAw2feQJV
         lL4IlgeJRcDkIxCWHV4kO/5ZvX8dYMjQwm7lI+haBCKEnL8lz46sE3sddP7Pu9/qKtNJ
         yLi5gvDDaMaQHUR8Ngwk2sOEI4BHOs8JT6qnANN5mN0o4hIwwkZJBusKuatquvJwX6XP
         T9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927449; x=1751532249;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo5462XH/J0CHUJB31BqUZLvosDDfk454xCnbCM4JXw=;
        b=baKriNW0mbnqYorr9KzFRgcEvHZXh3Ut1wwoaLWrSyK46Ag1TeCbFHj9B/PXCLtlU9
         0eLCTn6n2uPhjrUIDj/F6Dzxs7Ki5P14NAma0hsQ8B8tHfQSikBGUrm6JHDv4mCHPHD3
         SudfiDgua9wHYWACmXm7r4Fyw/sUn7m1Vp4kCjBOE/waQCpUJa/2w5jrT0659HDlQJgS
         gMerBln/dy4udgcKqscYp+ooP84OH99OjfqQ7PU8xBftVMYEFy7PAxlWXw36fWZDnhEw
         mDakaSlgwvQzcl1/FhippiMDun5bjrIaipJV8IXOoG0iNYL9cPJEB9bLyTA5Vhv6F7YI
         RjRQ==
X-Gm-Message-State: AOJu0YxJjCZK9eZEP0Tbfr9rnjmXPk/hHdSANEi5q5R1MMAmqBofti1P
	pNLeXvuzq6a3BmN+9rMbjcI9o/dvhGCugTgt+0sV8vl3rXuucG9zlQaiU+iKgEwiqM8=
X-Gm-Gg: ASbGnctnbiUQlTADdWL46TJ1E/xFIXf4pbp6+0w6j3iwN3ciptoYmRSycSmYCMb5azI
	cYLcdsaO/UPlII0hXTcow3SXm9vV+ZPNai08SSPYVJL0aWTIiuKp6Ii7hERKLj+TQy0uTv1u3rf
	3BuOTYHaIB7HsVEh2LDb4I+72ErMSyyhFn2r1KMZd3NLDn8dT4sI3lNXFdV0Bz802GAetSMVivv
	W1vUZpk7o6gjXso2XaGNPpCDPAFO0bpGQ9biHodvTp968JtJ642IGB+mkECW5wQcddivhLajvoN
	mNtV9DWR4aef0lIVwdwsFTqcwdJHWj8591CS6tY49YJjsCjN5ZsHow2Vg7didK23hwCtuGKvoPp
	5S8tq2Ru2/bOqhQ==
X-Google-Smtp-Source: AGHT+IEI2rVsRnZF2+YQ3sLqXU0Ra/H0nMwmAvU5nnF4ULUMVCZ2weL1T3HAxnDrGePI1CEgfuWmvg==
X-Received: by 2002:a05:6000:2410:b0:3a5:2ddf:c934 with SMTP id ffacd0b85a97d-3a6ed644198mr4469901f8f.30.1750927448280;
        Thu, 26 Jun 2025 01:44:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83f14adsm158539755ad.82.2025.06.26.01.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:44:07 -0700 (PDT)
Message-ID: <e8709e52-5a64-470e-922f-c026190fcd91@suse.com>
Date: Thu, 26 Jun 2025 18:14:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
 <20250626-schildern-flutlicht-36fa57d43570@brauner>
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
In-Reply-To: <20250626-schildern-flutlicht-36fa57d43570@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/26 18:08, Christian Brauner 写道:
> On Thu, Jun 26, 2025 at 09:23:42AM +0930, Qu Wenruo wrote:
>> The new remove_bdev() call back is mostly for multi-device filesystems
>> to handle device removal.
>>
>> Some multi-devices filesystems like btrfs can have the ability to handle
>> device lose according to the setup (e.g. all chunks have extra mirrors),
>> thus losing a block device will not interrupt the normal operations.
>>
>> Btrfs will soon implement this call back by:
>>
>> - Automatically degrade the fs if read-write operations can be
>>    maintained
>>
>> - Shutdown the fs if read-write operations can not be maintained
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/super.c         |  4 +++-
>>   include/linux/fs.h | 18 ++++++++++++++++++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 80418ca8e215..07845d2f9ec4 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -1463,7 +1463,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>>   		sync_filesystem(sb);
>>   	shrink_dcache_sb(sb);
>>   	evict_inodes(sb);
>> -	if (sb->s_op->shutdown)
>> +	if (sb->s_op->remove_bdev)
>> +		sb->s_op->remove_bdev(sb, bdev, surprise);
>> +	else if (sb->s_op->shutdown)
>>   		sb->s_op->shutdown(sb);
> 
> This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
> really dislike this pattern. It introduces the possibility that a
> filesystem accidently implement both variants and assumes both are
> somehow called. That can be solved by an assert at superblock initation
> time but it's still nasty.
> 
> The other thing is that this just reeks of being the wrong api. We
> should absolutely aim for the methods to not be mutually exclusive. I
> hate that with a passion. That's just an ugly api and I want to have as
> little of that as possible in our code.

So what do you really want?

The original path to expand the shutdown() callback is rejected, and now 
the new callback is also rejected.

I guess the only thing left is to rename shutdown() to remove_bdev(), 
add the new parameters and keep existing fses doing what they do (aka, 
shutdown)?

Thanks,
Qu

> 
>>   
>>   	super_unlock_shared(sb);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index b085f161ed22..5e84e06c7354 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2367,7 +2367,25 @@ struct super_operations {
>>   				  struct shrink_control *);
>>   	long (*free_cached_objects)(struct super_block *,
>>   				    struct shrink_control *);
>> +	/*
>> +	 * Callback to shutdown the fs.
>> +	 *
>> +	 * If a fs can not afford losing any block device, implement this callback.
>> +	 */
>>   	void (*shutdown)(struct super_block *sb);
>> +
>> +	/*
>> +	 * Callback to handle a block device removal.
>> +	 *
>> +	 * Recommended to implement this for multi-device filesystems, as they
>> +	 * may afford losing a block device and continue operations.
>> +	 *
>> +	 * @surprse:	indicates a surprise removal. If true the device/media is
>> +	 *		already gone. Otherwise we're prepareing for an orderly
>> +	 *		removal.
>> +	 */
>> +	void (*remove_bdev)(struct super_block *sb, struct block_device *bdev,
>> +			    bool surprise);
>>   };
> 
> Yeah, I think that's just not a good api. That looks a lot to me like we
> should just collapse both functions even though earlier discussion said
> we shouldn't. Just do:
> 
> s/shutdown/remove_bdev/
> 
> or
> 
> s/shutdown/shutdown_bdev()
> 
> The filesystem will know whether it has to kill the filesystem or if it
> can keep going even if the device is lost. Hell, if we have to we could
> just have it return whether it killed the superblock or just the device
> by giving the method a return value. But for now it probably doesn't
> matter.


