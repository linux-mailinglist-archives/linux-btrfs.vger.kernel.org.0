Return-Path: <linux-btrfs+bounces-12668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75548A75244
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 23:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D096170F7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C801D63FA;
	Fri, 28 Mar 2025 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cRcO8dX3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345C145B24
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199487; cv=none; b=HNvzR6Mu+S/LWu9VDGbi2djW2GHFOjaOt/4QzceB5cEcpORSIlIYfZEmUMzkAd11CBDI96KevJuZkn3Wywi8/0LJI/22Lj7rP58d5LhS8S+4geBhLtjteT2bRv/snazmoHHD4B95oBHwQT9zk/5IfHxj3Z4vfZakn//fskdYwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199487; c=relaxed/simple;
	bh=ldd/6K4guePy/iKcCsFVhsQHxolOtY+W4nk8wKC++Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/tPD5LvaBLA0e9fQ3Ancx3RDBPP1N0Q5jE8GejPmDMUBh1HHShABWYhwLH5NAEkebduGJ+ANvSsTn7qhZmpSuNclFAtBSaNL3dWQmHgiovEJOkjTAqIB8mEywvV9stUaYnII6c9uyRyuLDe0oJIE8JqWiH64lOVbOQ7diNVN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cRcO8dX3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-394780e98easo1585058f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743199483; x=1743804283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=blomsD3SwHXsSK3bfYyfC0xzZp/66ru7MTqNKHGQ4A4=;
        b=cRcO8dX38DzBFLxILKNrOkt0O682vb4WmCQZLproGbLn3KDfbJWoEhTV8c1WFd1jBa
         L0vgw06cPoPP3HeaaVCCjTzPPu38xd55r/VLPSuRpdTAE2hsWt8Bxrs+rizemOytqsef
         XrOLtNtmuxEKHFrUIFUnZ7bIN0aWSe19W52w2ysVsBGDEon2n3ganP1en+skX2vwGI8e
         2lf9gWDKSXOvMBESEoc0ywbKptmNMQxGhaaddHlpcuq+skEZkNatANYkObQJq4IeA0Ya
         gyRIC0ullsFrO13khs5hZSSC5VcamyF3RtWJe3YPBTl98Geldmit+K5uyAR6HcRUvmAj
         PFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743199483; x=1743804283;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blomsD3SwHXsSK3bfYyfC0xzZp/66ru7MTqNKHGQ4A4=;
        b=Ms6whxd+4T5scNFqTXcTkZyom86AGOiDP6M7oq8V+hRVKltrLz/nmBgRerIIYfRN1K
         rH9TCUcBuV/JQWKmmJwmbv5dd2Hq1m0poO/kPjkbGgM1Dr0MBAzjvbWTylt76UTtlcL2
         BnBoqUakhpw2vI1PRR+Ed86k3JATBDVPS5Jpx2bMD3nmse9CfU6keQ/v6FUkB1MOuElG
         m4KfgnbtCUYgKds5NHR7hlyrMpD6ohr5xLBegGC6Fv5zrQHf5CIJoxGyXr1wK8IfWM2N
         GFNfkWn7MF1+VpUpGI+WXV+bcBbGljJhzuejvUxCAtRL/J2sz2HRpSUAs+8KBvC94xEA
         oJbQ==
X-Gm-Message-State: AOJu0YzUiVrQ8EFHpYeVRBegheALW8gYJPMXVCm7Z9tb4ebWA/FoB+qv
	x3Wh5K8Q6f2UJxgsOa+j3IS28CmO9kkf4F9itkPwlCxoxHuaBiy3GdeRrxQzzoI=
X-Gm-Gg: ASbGncvPHgJpYAUyhzzMs0bTTjnyBqenXGfs+X2TFqXjfSWWukkn/I6cAxRsxN91y38
	GUyeUD3TxSXs/rb3u3sDbhlLdYwIUqI+Wxnn/SPRqQxqmdg1+VXn3RH0Jt3NL78DjWhuDpIFfmK
	GQ5GcPHEYJqMeU9SamK72Xr832sC1x9R7+L6LAWaPd7URJAiLzRfzDm67mfgfQAqGDwyH4qLjSD
	bvaz5V9AquFS3KiZ7O1yRwUap9/Fm1tdtxd0aRoZyDaA3yc6P3TfeuwOBq0W2vc+jw3Exqk56hq
	+ZH1/T7r9uolNJ7pSxrPfh63CJPUxnezgjKVlmcFeQ6MNCT70i3poIdTI/w3r4ONdQ7Lq7v7JG9
	ZTfU8M6k=
X-Google-Smtp-Source: AGHT+IHzrmz1O2AYgM7502bSxLtT+4j3QZHCN11VqfdC9ehOyaJOHfR5nPPg921OEwGhOj4uh7JJCg==
X-Received: by 2002:a5d:584a:0:b0:391:ab2:9e71 with SMTP id ffacd0b85a97d-39c120dec0dmr657697f8f.20.1743199483021;
        Fri, 28 Mar 2025 15:04:43 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710d075csm2323994b3a.165.2025.03.28.15.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 15:04:42 -0700 (PDT)
Message-ID: <6cbfbb9a-c3da-4aa4-b719-1295ff3d18eb@suse.com>
Date: Sat, 29 Mar 2025 08:34:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: refactor btrfs_buffered_write() for the
 incoming large data folios
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1742443383.git.wqu@suse.com>
 <20250327164713.GV32661@twin.jikos.cz>
 <0ca94ef9-7626-48e5-8417-0c1efa4d6832@gmx.com>
 <20250328191207.GI32661@twin.jikos.cz>
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
In-Reply-To: <20250328191207.GI32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/29 05:42, David Sterba 写道:
> On Fri, Mar 28, 2025 at 07:17:39AM +1030, Qu Wenruo wrote:
>> 在 2025/3/28 03:17, David Sterba 写道:
>>> On Thu, Mar 20, 2025 at 04:04:07PM +1030, Qu Wenruo wrote:
>>>> The function btrfs_buffered_write() is implementing all the complex
>>>> heavy-lifting work inside a huge while () loop, which makes later large
>>>> data folios work much harder.
>>>>
>>>> The first patch is a patch that already submitted to the mailing list
>>>> recently, but all later reworks depends on that patch, thus it is
>>>> included in the series.
>>>>
>>>> The core of the whole series is to introduce a helper function,
>>>> copy_one_range() to do the buffer copy into one single folio.
>>>>
>>>> Patch 2 is a preparation that moves the error cleanup into the main loop,
>>>> so we do not have dedicated out-of-loop cleanup.
>>>>
>>>> Patch 3 is another preparation that extract the space reservation code
>>>> into a helper, make the final refactor patch a little more smaller.
>>>>
>>>> And patch 4 is the main dish, with all the refactoring happening inside
>>>> it.
>>>>
>>>> Qu Wenruo (4):
>>>>     btrfs: remove force_page_uptodate variable from btrfs_buffered_write()
>>>>     btrfs: cleanup the reserved space inside the loop of
>>>>       btrfs_buffered_write()
>>>>     btrfs: extract the space reservation code from btrfs_buffered_write()
>>>>     btrfs: extract the main loop of btrfs_buffered_write() into a helper
>>>
>>> I'm looking at the committed patches in for-next and there are still too
>>> many whitespace and formatting issues, atop those pointed out in the
>>> mail discussion. It's probably because the code moved and inherited the
>>> formatting but this is one of the oportunities to fix it in the final
>>> version.
>>>
>>> I fixed what I saw, but plase try to reformat the code according to the
>>> best pratices. No big deal if something slips, I'd rather you focus on
>>> the code than on formattig but in this patchset it looked like a
>>> systematic error.
>>>
>>> In case of factoring out code and moving it around I suggest to do it in
>>> two steps, first move the code, make sure it's correct etc, commit, and
>>> then open the changed code in editor in diff mode. If you're using
>>> fugitive.vim the command ":Gdiff HEAD^" clearly shows the changed code
>>> and doing the styling and formatting pass is quite easy.
>>>
>> This is a little weird, IIRC the workflow hooks should detect those
>> whitespace errors at commit time, e.g:
>>
>> $ git commit  -a --amend
>> ERROR:TRAILING_WHITESPACE: trailing whitespace
>> #9: FILE: fs/btrfs/file.c:2207:
>> +^I$
>>
>> total: 1 errors, 0 warnings, 7 lines checked
>> Checkpatch found errors, would you like to fix them up? (Yn)
>>
>> But it was never triggered at any of the code move.
>>
>> I know I missed a lot of style changes when moving the code, but I
>> didn't expect any whitespace errors.
>>
>> Mind to provide some examples where the git hooks didn't catch them?
> 
> I don't use the git hooks for checks so I'll copy it from the patches:
> 
> https://lore.kernel.org/linux-btrfs/b0bd320dba85d72a34a4f7e5ba6b6c42caedbe41.1742443383.git.wqu@suse.com/
> 
> @@ -1074,6 +1074,27 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
>   	return 0;
>   }
>   
> +static void release_space(struct btrfs_inode *inode,
> +			  struct extent_changeset *data_reserved,
> +			  u64 start, u64 len,
> +			  bool only_release_metadata)
> +{
> +	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +
> +	if (!len)
> +		return;
> +
> +	if (only_release_metadata) {
> +		btrfs_check_nocow_unlock(inode);
> +		btrfs_delalloc_release_metadata(inode, len, true);
> +	} else {
> +		btrfs_delalloc_release_space(inode,
> +				data_reserved,
> +				round_down(start, fs_info->sectorsize),
> +				len, true);
> +	}
> +}
> ---
> 
> The parameters of btrfs_delalloc_release_space(), matching its origin:
> 
> -	if (release_bytes) {
> -		if (only_release_metadata) {
> -			btrfs_check_nocow_unlock(BTRFS_I(inode));
> -			btrfs_delalloc_release_metadata(BTRFS_I(inode),
> -					release_bytes, true);
> -		} else {
> -			btrfs_delalloc_release_space(BTRFS_I(inode),
> -					data_reserved,
> -					round_down(pos, fs_info->sectorsize),
> -					release_bytes, true);
> -		}
> -	}
> ---
> 
> Maybe the checks ignore possible whitespace adjustments in moved code,
> e.g. comparing the - and + change literally and not taking the new
> location into account.

Sorry, I just compared the patch and the commit inside for-next branch, 
but I didn't see any white-space related changes.

Only the fs_info grabbing is moved into the else branch inside 
release_space(), and moving the indent of parameter to align with the 
'(' for btrfs_delalloc_release_space().

If by white-space, you mean strict indent for all parameters, that's not 
(and I guess it will never) be implemented by check-patch.pl.

> 
> Basically the same pattern in https://lore.kernel.org/linux-btrfs/522bfb923444f08b2c68c51a05cb5ca8b3ac7a77.1742443383.git.wqu@suse.com/

The same indent pattern you modified.

Personally speaking, I do not think the indent alignment to '(' should 
be mandatory.

The indent different is small, won't change the reader's ability to know 
it's a parameter, and there are both types of indent usages across the 
filesystems.

To be honest, aligning to '(' will only make future function rename 
harder, thus I prefer fixed tab indent other than strong alignment.

But if you insist, I can follow it in the future, but since it's not 
included in checkpatch.pl, there will be missing ones here and there.

Although I really prefer to not have such a mandatory alignment 
requirement, to reduce the burden on you and all other developers.

Thanks,
Qu

> 
> code moved to reserve_space() from btrfs_buffered_write(), parameters passed to
> btrfs_free_reserved_data_space().
> 
> I remember fixing more code like this, but hopefully the two examples would be
> sufficient to test the hook checks.


