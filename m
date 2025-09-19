Return-Path: <linux-btrfs+bounces-17004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC3B8B737
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Sep 2025 00:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BF87B3512
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20C2D6E4E;
	Fri, 19 Sep 2025 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aivyJl/9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DB2D5C89
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319875; cv=none; b=uouLs9GUt9xoHcI/dgXWEk6BDb8O6qFhkAizjzFPrWn6DI8wm21lD6uBWic9W3gcnFAw+br3A45NqBztOUAIuAdRe+OC53glgdXsYf/XesmSwFyGZHzyjepn57+LRUDaivoa+EwTKHmn3hEFD7g0eTuSvBoNAR+3Do09VNZDB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319875; c=relaxed/simple;
	bh=c4/KXuw1YBYKVq3gR2RvdtX6J102qBJ6B3/SBaifStE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NtPSQleG6Z1o6z7GCtIb3baWil/TeQahT/81qCjHjQkMkTzWq0ZXQ+jGQPtbv8F18WHbZs2I6cgOpjqrArSMTUcUPsilWPbem950ZS9YwGLWs5fuIADuQ/T+vbOKJ80ahLaTZ04fIl4doRIXm5UYmQcJkQZinDwMHCnZNM7rZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aivyJl/9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1957822f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758319871; x=1758924671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yyUmXBXAtauW1Z1+x2iFaOwMFxkR7mG71hmVPt72Qkk=;
        b=aivyJl/9VGwJlzNhIhpbCFLIWO9PJdom1ybAAWrHd2Cm4UktXL88yT9xll4b9N+qng
         FEw8e0tZJcebh5pk9WYKX6sCNe4pSwVyocE/25vAi26qZApc7G+ddJZcxVh/OUvbYkhu
         Yjk4E73OktNV/PrZiRksi8u79hL2oEZHD/3hgo4f5BG1yKM/3kGVfM7HySrnKc26XwJJ
         S7D0O/obWqsF1GsT18cKnXFoEGeUwxxtTzBaY6ELqno0ejQpt01842R9ZWZlAdqGj+hW
         2pkOjjjBbdlLWAFVw68U8UEjuQ2NmZWjeQqHyf3tQLXmiERjCNlfWII/RpRTIypGhT5L
         GmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319871; x=1758924671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyUmXBXAtauW1Z1+x2iFaOwMFxkR7mG71hmVPt72Qkk=;
        b=neFuk4XybEFlIa0gmcYCuO/tBs6famPpJClRKZWwO3p3noFYKog1o+iZ2flj30NdHr
         bRMfKcHMMnwzAg18vZjW7kz/Uo/8zIFm9cEgvZarRSwN9HxlmVCXNOJxoEI+SlqGT8rl
         YQP9+pwivLNivfalwsSAEIHeHqmsL7VBe5v5ykFZaxRzDeu2Iv6ssQa3J94v6mMjzLQj
         gbboUP79HKJ6zSsVX36dkuZfTeAyLIHehNRNTx/HF2zs3atCWzUkyDkV4ODG2CrhV0vy
         5OsFseZyT8mLUqgKr4IogpInX8T6QYifCI6mzyJoxVYYF9pdgzxTdkRSXHRAjX1VZUM7
         edjA==
X-Forwarded-Encrypted: i=1; AJvYcCUdjN6VvD78Q1TXAlwAHPANp9oHXlRgW2NtC8pEczmpEBDUiWn9HMsNs5nwOQ/nMrJ6Z/42sip0etLxlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYUu1DxubOF8RUJ3PYr5jWFKWRxV24gvMnjM9LzmLE+ked4pb
	z8DaNd6dAsQVwgSeqR8eIqd/SYbAY8f5VSRISSXG3KTWG9qMG3w5QaViSCti/qR8XSDcJo6XJ3I
	4vzzq
X-Gm-Gg: ASbGnctWlWz6zl2d0FDrppRa/7zN4bk0rTALOmDPNcHRtcI0wrQlyGjBUwDKbHGECFP
	kbobCiq4VbCTjhRsDiP/atyl9I/ijW6CDMP7STeDktxieJcd2LZE/Y0U81G4TKa883XaGKnX8EM
	pj7I/DYRjWpQnPhYx2Lirh7wNQUwzjIW/MoNbLadD/EmhAO/5bBw23n1+B7uRUdfo8sFmIZ2Zyo
	/iJOV3lMc5Vm7imfcAbtM4W9fX7xYTDGmoEM/NZSY3gQm1AzS88blINUNFdZKMG4360hCyp5gQ9
	wBXHtC9kudnoCsb/ShnQtfMYNsS1p/VX+pzfJSaGg9ZclAFCT6y2g/CF78UuwwiH6/tFAdAfOxG
	+q088Iqp8lkIhE0Izy3rNPKkyaRo5UYrwC4D5V0F0rW12yhVjW8Y=
X-Google-Smtp-Source: AGHT+IGMXErdY7AHMe89BPs/AavA0dAyw7jtWurC2kSTkvdKvjKrRe6cILCdFTAZJVflh8jmmi7tWw==
X-Received: by 2002:a05:6000:268a:b0:3e1:219e:a74a with SMTP id ffacd0b85a97d-3ee7db4c3b4mr4404248f8f.21.1758319871449;
        Fri, 19 Sep 2025 15:11:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016ca44sm63498915ad.37.2025.09.19.15.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 15:11:10 -0700 (PDT)
Message-ID: <00e37a1b-9944-41fe-b3b4-a9bfc2b39ed1@suse.com>
Date: Sat, 20 Sep 2025 07:41:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make the rule checking more readable for
 should_cow_block()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <430201af947578096cabe79fc4a1eaea731e8ef4.1758272660.git.fdmanana@suse.com>
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
In-Reply-To: <430201af947578096cabe79fc4a1eaea731e8ef4.1758272660.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/19 19:41, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's quite hard and unreadable the way the rule checks are organized in
> should_cow_block(). We have a single if statement that returns 0 (false)
> and it checks several conditions, with one them being a negated compound
> condition which is particularly hard to reason immediately.
> 
> Improve on this by using multiple if statements, each checking a single
> condition and returning immediately. Also change the return type from an
> integer to a boolean, since all we need is to return true or false.
> 
> At least on x86_64 with Debian's gcc 14.2.0-19, this also reduces the
> object code size by 64 bytes.
> 
> Before this change:
> 
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1913327	 161567	  15592	2090486	 1fe5f6	fs/btrfs/btrfs.ko
> 
> After this change:
> 
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1913263	 161567	  15592	2090422	 1fe5b6	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index dc185322362b..13dc44e90762 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -613,15 +613,12 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
>   	return ret;
>   }
>   
> -static inline int should_cow_block(const struct btrfs_trans_handle *trans,
> -				   const struct btrfs_root *root,
> -				   const struct extent_buffer *buf)
> +static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> +				    const struct btrfs_root *root,
> +				    const struct extent_buffer *buf)
>   {
>   	if (btrfs_is_testing(root->fs_info))
> -		return 0;
> -
> -	/* Ensure we can see the FORCE_COW bit */
> -	smp_mb__before_atomic();
> +		return false;
>   
>   	/*
>   	 * We do not need to cow a block if
> @@ -634,13 +631,25 @@ static inline int should_cow_block(const struct btrfs_trans_handle *trans,
>   	 *    after we've finished copying src root, we must COW the shared
>   	 *    block to ensure the metadata consistency.
>   	 */
> -	if (btrfs_header_generation(buf) == trans->transid &&
> -	    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
> -	    !(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
> -	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
> -	    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
> -		return 0;
> -	return 1;
> +
> +	if (btrfs_header_generation(buf) != trans->transid)
> +		return true;
> +
> +	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> +		return true;
> +
> +	/* Ensure we can see the FORCE_COW bit. */
> +	smp_mb__before_atomic();
> +	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
> +		return true;
> +
> +	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
> +		return false;
> +
> +	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
> +		return true;
> +
> +	return false;
>   }
>   
>   /*


