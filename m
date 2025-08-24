Return-Path: <linux-btrfs+bounces-16316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA1CB332E1
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Aug 2025 23:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB8F1B253B0
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Aug 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8FE244681;
	Sun, 24 Aug 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ai9G4TaT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448923A995
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Aug 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756071669; cv=none; b=pTQMDyO6e67viW4EA2khZpubVvtTY4iY0hrGkXE0LeUHkyK9+Wm8zWHBVsKZf6OuNA27quea8vOmF/yvP6TzYyQt6LRYw36a2nFn9jaPfE3J3dT2xIOVpTcS0fSZesOXgxlBuWTQP85syOKKlb7cc0MXCvVqSK+Y6anCTPWqU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756071669; c=relaxed/simple;
	bh=k7rV/e03Lony7Uei6rOIUN2FSEOu206Imyr4MKnVf2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilfR/Uxi7kcnnSRT4k/Wt4iCcw9UMOkz2cudcf1CGUNugzqpyoTNp3X9RP68EsBz8lxp7MVo9suMEKra8T4vNvkvH0anVryrMQOw7PwoDeV93XLga7upysisaFZX2ZGCvm3LRzDtG+6VHdkauY+fjoIZfgwK94bTWLeVve/dIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ai9G4TaT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2262928f8f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Aug 2025 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756071665; x=1756676465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fYd06LbXp2FRlpwpsbVMjBRnrPXQz3hanPHKIS6jTro=;
        b=Ai9G4TaT+maDWXLzqzyIoFOWhr+1iZe9diah82VoZX5UEMJgY7LPSOjUtVjGLTOMyH
         VhYkvcIiH5J8n8CwExiVQIt98m0FogIbuOr+WhEb4aGqEU9RwArQ2Wg8IcPw9TCeznjp
         MUAyQT0Nn5hPp32Av9HAdQY4s+JXgjYqN4B/CdkdX3usoYaAw5BKERE+lE8bKOiIy9cg
         15LLNuz1a4YLyMZLRoE88b8s6yZmekPmldSCN+2Gf4ZpiVxt/Hpmtw0LW5KbV6UN/C81
         qD5zZw0p7ntNCGJe6junApDTi99IOZ7kTxfzmMHI7G8rBtst1E98xLTIMuG27+kQNZvX
         HfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756071665; x=1756676465;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYd06LbXp2FRlpwpsbVMjBRnrPXQz3hanPHKIS6jTro=;
        b=hPzYcFoT2yFuvWU0AUOViWfCo9hRZBgy74uVTPvvs5BFikAYGeVJWwLzP1JPcvbfRl
         1UMnGALLCs+8BGQuW2jIQvVmf71Pd2ffMeF3fTdOhfZPb7i/CqGSDdweTlK9KlQGAGSR
         IcHMq/Bcv35g/AeWKakYAN1lAjsGJOMY/lch5f4HpyAS/n/M4RqtSm8XTRGma+RM30T2
         XaH36EKCtrmFX8+iQaLY3ByGzmAlCTHGCQTbMdUgyL3Ylx/B9hE3n7o1HHvYHK0Wrz0f
         jvEkwVvcTFn0FEQ5BtEtdwCYWI2VAW/TWDbpFPJ9tJlEC6KIb/aJE3OYglfIhSiRTH48
         BbQg==
X-Forwarded-Encrypted: i=1; AJvYcCWL45NbEGEWzxww23gb24jkSkguto24W7sc+rBM6o7mrUO4tVzoLtrZrm0MAETEjqGv77x4zDGHpbe9pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4s9rG98vnzkYW0Mi2TOqLAvJqPCjtxEFCBAjUQk141sgthdGr
	P3CB6kTIvEdwkNa3YG8tPo+z9MvIZ2S0dlUVAHDhHmI3PNStLSNBgOvNM+eyg9d3Yhg=
X-Gm-Gg: ASbGncupD6cMxFzSwWmamLkGvdN9wfXbPj+QFk5M4McJyFtdxtH32dHTPosxWdzRYF8
	67ADdmElBxwKFDjNdbIgnGY4L0LkecxB0Ozud10aoogl0+GKvIhjyj4zS87p+kA7air0mPJ7u2P
	SNtSadaP647KYkajZxUJIfEMo61PXgYrs/PdXZNKbnMqEYl5h6SuM58ldgBnDmaN5bPrfiWq/vs
	O4o0KmjyiASwwpa9GUnQ2P9WwMzm/vuD5djb8zo+JCvhbouAOCXfywhfrrFuiHnWKQDwMNwlYJS
	tKAwklIk3v3/wDcEfkNi9uF+mBnOVbTYBoGdTZYZT5wYdDqv6jYBCxSIxGE9wSA4aIF/n1q0h4+
	MFanGd8sHd3PAtdrgUkuAR0GRUUndhC3tIg+B6LlqLx4easF76kM=
X-Google-Smtp-Source: AGHT+IEeMmJiluk3pS4DXG0dP7BS3MPPCo90S8ZCiieAjVxeh349XrIx83k4rAc08WG0zYvIox/sZA==
X-Received: by 2002:a05:6000:3105:b0:3b4:9721:2b32 with SMTP id ffacd0b85a97d-3c5da83c440mr7597451f8f.10.1756071664925;
        Sun, 24 Aug 2025 14:41:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb47c4sm5534448b3a.4.2025.08.24.14.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 14:41:04 -0700 (PDT)
Message-ID: <9ada7f0f-2b46-4e7d-812d-666af3b5c023@suse.com>
Date: Mon, 25 Aug 2025 07:10:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Calvin Owens <calvin@wbinvd.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sun YangKai <sunk67188@gmail.com>, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, neelx@suse.com
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me>
 <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
 <aKj8K8IWkXr_SOk_@mozart.vkv.me>
 <9cacdafc-98ec-4ad2-99a8-dfb077e4a5fb@gmx.com>
 <aKs2mCRjtv3Ki06Z@mozart.vkv.me>
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
In-Reply-To: <aKs2mCRjtv3Ki06Z@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/25 01:28, Calvin Owens 写道:
> On Saturday 08/23 at 09:09 +0930, Qu Wenruo wrote:
>> 在 2025/8/23 08:54, Calvin Owens 写道:
>>> On Saturday 08/23 at 07:14 +0930, Qu Wenruo wrote:
>>>> 在 2025/8/23 01:24, Calvin Owens 写道:
>>>>> On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
>>>>>> 在 2025/8/22 19:50, Sun YangKai 写道:
>>>>>>>> The compression level is meaningless for lzo, but before commit
>>>>>>>> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
>>>>>>>> it was silently ignored if passed.
>>>>>>>>
>>>>>>>> After that commit, passing a level with lzo fails to mount:
>>>>>>>>         BTRFS error: unrecognized compression value lzo:1
>>>>>>>>
>>>>>>>> Restore the old behavior, in case any users were relying on it.
>>>>>>>>
>>>>>>>> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
>>>>>>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>      fs/btrfs/super.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>>>>>>> index a262b494a89f..7ee35038c7fb 100644
>>>>>>>> --- a/fs/btrfs/super.c
>>>>>>>> +++ b/fs/btrfs/super.c
>>>>>>>> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
>>>>>>>> *ctx,>
>>>>>>>>      		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>>>>>>      		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>>>>>>>      		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>>>>>>>
>>>>>>>> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
>>>>>>>> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>>>>>>>>
>>>>>>>>      		ctx->compress_type = BTRFS_COMPRESS_LZO;
>>>>>>>>      		ctx->compress_level = 0;
>>>>>>>>      		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.47.2
>>>>>>>
>>>>>>> A possible improvement would be to emit a warning in
>>>>>>> btrfs_match_compress_type() when @may_have_level is false but a
>>>>>>> level is still provided. And the warning message can be something like
>>>>>>> "Providing a compression level for {compression_type} is not supported, the
>>>>>>> level is ignored."
>>>>>>>
>>>>>>> This way:
>>>>>>> 1. users receive a clearer hint about what happened,
>>>>>>
>>>>>> I'm fine with the extra warning, but I do not believe those kind of users
>>>>>> who provides incorrect mount option will really read the dmesg.
>>>>>>
>>>>>>> 2. existing setups relying on this behavior continue to work,
>>>>>>
>>>>>> Or let them fix the damn incorrect mount option.
>>>>>
>>>>> You're acting like I'm asking for "compress=lzo:iamafancyboy" to keep
>>>>> working here. I think what I proposed is a lot more reasonable than
>>>>> that, I'm *really* surprised you feel so strongly about this.
>>>>
>>>> Because there are too many things in btrfs that are being abused when it was
>>>> never supposed to work.
>>>>
>>>> You are not aware about how damaging those damn legacies are.
>>>>
>>>> Thus I strongly opposite anything that is only to keep things working when
>>>> it is not supposed to be in the first place.
>>>>
>>>> I'm already so tired of fixing things we should have not implemented a
>>>> decade ago, and those things are still popping here and there.
>>>>
>>>> If you feel offended, then I'm sorry but I just don't want bad examples
>>>> anymore, even it means regression.
>>>
>>> I'm not offended Qu. I empathize with your point of view, I apologize if
>>> I came across as dismissive earlier.
>>>
>>> I think trivial regression fixes like this can actually save you pain in
>>> the long term, when they're caught as quickly as this one was. I think
>>> this will prevent a steady trickle of user complaints over the next five
>>> years from happening.
>>>
>>> I can't speak for anybody else, but I'm *always* willing to do extra
>>> work to deal with breaking changes if the end result is that things are
>>> better or simpler. This just seems to me like a case where nothing
>>> tangible is gained by breaking compatibility, and nothing is lost by
>>> keeping it.
>>>
>>> I'm absolutely not arguing that the mount options should be backwards
>>> compatible with any possible abuse, this is a specific exception. Would
>>> clarifying that in the commit message help? I understand if you're
>>> concerned about the "precedent".
>>
>> Then I'm fine with a such patch, but still prefer a warning (not WARN(),
>> just much simpler btrfs_warn()) line to be shown when a level is provided
>> for lzo.
>>
>> Furthermore, since we already have something like btrfs_lzo_compress
>> indicating the supported level, setting to the proper default value would be
>> better. (Already done by btrfs_compress_set_level() call in your v2 patch).
> 
> Thanks Qu. v3 below.
> 
> There was an off-by-one in my v2, len("lzo") is three, doh.
> 
>> BTW, since you mentioned something like "compress=lzo:asdf",
>> btrfs_compress_set_level() just ignores any kstrtoint() error, allowing
>> things like "compress=zstd:invalid" to pass the option parsing.
>>
>> I can definitely send out something to enhance that check, but just want to
>> be sure, would you opposite such extra sanity checks?
> 
> I have no objection to that at all, IMHO that's a good thing to do.
> 
> Is it worth adding a testcase somewhere for the compression options? I'm
> happy to do that too, but I'm not sure what the right place for it is.

It can be added to fstests.

> 
> Thanks,
> Calvin
> 
> -----8<-----
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [PATCH v3] btrfs: Accept and ignore compression level for lzo
> 
> The compression level is meaningless for lzo, but before commit
> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> it was silently ignored if passed.
> 
> After that commit, passing a level with lzo fails to mount:
> 
>      BTRFS error: unrecognized compression value lzo:1
> 
> It seems reasonable for users to expect that lzo would permit a numeric
> level option, as all the other algos do, even though the kernel's
> implementation of LZO currently only supports a single level. Because it
> has always worked to pass a level, it seems likely to me that users in
> the real world are relying on doing so.
> 
> This patch restores the old behavior, giving "lzo:N" the same semantics
> as all of the other compression algos.
> 
> To be clear, silly variants like "lzo:one", "lzo:the_first_option", or
> "lzo:armageddon" also used to work. This isn't meant to suggest that
> any possible mis-interpretation of mount options that once worked must
> continue to work forever. This is an exceptional case where it makes
> sense to preserve compatibility, both because the mis-interpretation is
> reasonable, and because nothing tangible is sacrificed.
> 
> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/super.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a262b494a89f..18eb00b3639b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -299,9 +299,12 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
>   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>   		ctx->compress_type = BTRFS_COMPRESS_LZO;
> -		ctx->compress_level = 0;
> +		ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_LZO,
> +							       string + 3);
> +		if (string[3] == ':' && string[4])
> +			btrfs_warn(NULL, "Compression level ignored for LZO");
>   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);


