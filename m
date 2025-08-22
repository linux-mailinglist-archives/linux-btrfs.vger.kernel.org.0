Return-Path: <linux-btrfs+bounces-16271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E41B31510
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5655D5A273B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3642D9797;
	Fri, 22 Aug 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B/A9pubU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0F2765E1
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857907; cv=none; b=BDKVCMKBkolykXPzmjKP9rA4gQNTKgcoAaT0h/fPHEt1PpnbSqOFhxYmvqRjCgdmKvP5XTdHhxEut9HHziM0Lqj+bCOvN7d0vJ/gaRyrvxNDxHGh8VuaxtgZcDjsJnYsoMXzuwDYMreztGfKUChbM3xIPGm8fieEldVchd51CJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857907; c=relaxed/simple;
	bh=ZRhqxi1umtqKjUZlTismpejrp60ueT8URBAZNkgaPLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dy6YeElDPCqWKfNMuQD8pTwnlVRR8dkrPSmudKgZVG3idaWLVdgISvuBpYsU5BkmWHTW18uwgKwik/vMC+meHpND/ujcLMdH0hHePk+PT2sMjD2fURUiSwBC4ucBlqIf2f0YnuOfocU14MfGvewuOBPP8+jO8KgEwuD2v/Q3uLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/A9pubU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so1192435f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755857902; x=1756462702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lUMVWvMJsvr8u0JNPGfEHSPjEjWHpYL2vU3r9p4k75c=;
        b=B/A9pubUJxisjipK7c7kPfQYEveIMSV4dmcWSR1Mzk47ZuHISo4jg6BGKs0+m0TyRA
         KUNTx13DNiRijkHqLuxrDXlOuJYKtKhVCNaWIa/1/EHVXj2sCjwQvcvQy9/ZbkduxVJf
         NxmU5ztsGiH5L+fjrUZ5TcJogYZCIkNXTv3cXXyRidCH/XBe0gXFNEFj9uvHVxUt5jzI
         cmncI5aFq2mXhSj8Rytv1QnufiU+6kWeqx2YuTBC3rD2krSj0r71Wmw+IBsqafifSEp9
         evsjLYlF1Pk/lNgDBSYYD3qJMp0DKOJ/YsLU4RY4n1RC8MbtfxaUKDqEGN2x216Jop00
         q1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857902; x=1756462702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUMVWvMJsvr8u0JNPGfEHSPjEjWHpYL2vU3r9p4k75c=;
        b=ggoLVYbo+BqxL9mYpYJz6Bs4vVJ4FIb5QDEIN7VxE6RLaQopAedfoZxxlPLJCcbtIN
         X0oAaSOwdMcQhJLddVz0Q7yhsXaQViL63zVR9qbpyHPQ5EMPfjvLaPWMlIFdi2h9fYNr
         UXYxWSIlDJrGMtv63YG/MVmHN7sqR77yigdU70XS960/FELaXuK+JvDPYMrYIVqiv1Og
         dMU/kMtOeyyFxDdSZPbIMPP2db++2x3BW895ja8buGX86M50NJFiVopYyxxenQrTBHZO
         ctE4RA9pCU6YQ2ljT2FlRPOgXnOHidgz3wpUIVqamZtkg1boJfuKBwxUX9iKbgE5mROi
         bLbA==
X-Forwarded-Encrypted: i=1; AJvYcCUigA7qHS5KqTVhOKD34+26jDcpC1G4YTRwLqPwGOurF9FBWlV+mpcsxLoXXWQa0+93WUqcvotA7xTGtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdR2pnLCIgju7SVT1xJ9jUndn+8dyVPW8C8Sv+oVdWFTa8KkFK
	5RDNqnWLJd0Okiu1Uxx/RrIVl31R28vHq1IwhXa7K9n2LiqVGsU5K++87rmzZw6CYx8=
X-Gm-Gg: ASbGncsHVQKZu5tYF8Lki9wpYHV8H15HopMKcJW5etkzuaPuyXq4emNO5SkQBfFW8iq
	dP5nVidh/XRq1yM8777IVfl8HE5/PpcKzVt+e3yQ2r3Dai1XHiYXcPYyHUbolQTMOMj/6b5FF98
	G8iUL0DFBStAJ3eN5aVrCz0fNouVsvKm0JneJg3VMzIk10Vhba0+Q6pwUDgndSwM4MvPrii/oeB
	PcOXVm1dVVLahbP93X8UcT1LrHejG7Uy2vVzHVYr+XkCeG4+pwvfgwH6mnISPDXYyV01PMNTbkk
	O3CXUi8MxTN5c+ejPhTgI5GtgAhG3fyhuJm5jvbr1VBl1SlUNA30weNCeZzfwENM0s6RL3UJGTT
	JqOg+ImUnhjjRGzf/sAi2X7T6AJeybI1b9fkyPXvCuRv6gVvlng839tmudIMjmw==
X-Google-Smtp-Source: AGHT+IF/GPcupV5lDGUOlmnOAJWWxOnSu3BrReGiSDsdOUDO4mFZN9L5UYnmPt128iVddNAXK9FWYA==
X-Received: by 2002:a05:6000:2501:b0:3b9:1108:8e99 with SMTP id ffacd0b85a97d-3c5dc542a7amr1804688f8f.41.1755857902108;
        Fri, 22 Aug 2025 03:18:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33cac4sm80039385ad.16.2025.08.22.03.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:18:21 -0700 (PDT)
Message-ID: <9bdb2726-de7b-4ef0-9ad5-7050d214a85f@suse.com>
Date: Fri, 22 Aug 2025 19:48:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Calvin Owens <calvin@wbinvd.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
 <aKg4PcgUCvXblVCY@mozart.vkv.me>
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
In-Reply-To: <aKg4PcgUCvXblVCY@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/22 18:58, Calvin Owens 写道:
> On Friday 08/22 at 17:57 +0930, Qu Wenruo wrote:
>> 在 2025/8/22 17:15, Calvin Owens 写道:
>>> The compression level is meaningless for lzo, but before commit
>>> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
>>> it was silently ignored if passed.
>>
>> Since LZO doesn't support compression level, why providing a level parameter
>> in the first place?
> 
> Interpreting "no level" as "level is always one" doesn't seem that
> unreasonable to me, especially since it has worked forever.

No means no, period.

> 
>> I think it's time for those users to properly update their mount options.
> 
> It's a user visable regression, and fixing it has zero possible
> downside. I think you should take my patch :)

I do not want to encourage such usage.

Sanity overrides "regression". If it shouldn't work in the first place, 
it's not a regression.

> 
> Thanks,
> Calvin
> 
>>>
>>> After that commit, passing a level with lzo fails to mount:
>>>
>>>       BTRFS error: unrecognized compression value lzo:1
>>>
>>> Restore the old behavior, in case any users were relying on it.
>>>
>>> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>> ---
>>>    fs/btrfs/super.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index a262b494a89f..7ee35038c7fb 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
>>>    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>    		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>>    		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
>>> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>>>    		ctx->compress_type = BTRFS_COMPRESS_LZO;
>>>    		ctx->compress_level = 0;
>>>    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>
> 


