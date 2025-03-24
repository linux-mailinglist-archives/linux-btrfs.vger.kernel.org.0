Return-Path: <linux-btrfs+bounces-12508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B178DA6D3E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 06:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E565E7A5461
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B518DB2A;
	Mon, 24 Mar 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LkeB0dsb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7D78F4C
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795117; cv=none; b=h5EBZJ9D9Gkh7ZSO9ww/tRcXupxzqDeZl4CbSS9jKe4wjO+kkHstWwS4iM8pRFbCGfTTVKHu0LZvtYGo8GQ9ttvXUC2fo8qTRiXHQZZ+22B7hvsiIy4uhgON7mA0gi7IOgOyaCRrS4tB3NvmZRlaXprkzbtEmHaqvfPkIO+2xHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795117; c=relaxed/simple;
	bh=YqchIEpMSrmAQPVtAR35nxb9bt5kb6QUr8NvMQF8ky4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=C+F9D04UabAWu6jK/ny+lmkVtPq44tl5WtOunNWWpgJZZuU2o7Fx96uBeE6omiegP4QaL27cH1wwyOcz6qcVLsDzlfssJSQqR9sOBbz2u4WeKy9n47zen97NzKX4AFqtpdBjFsapM58Af2Vp+ksTPOvfWdvvBZSXFCjwb3qNopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LkeB0dsb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39133f709f5so1999633f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Mar 2025 22:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742795113; x=1743399913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IInLBC9D7yWVPl3w6rKRiNZorcdnlp0gRkFtld0TbeI=;
        b=LkeB0dsbjCyGqTqfBdcEB2k9shtDeAa/SEjxQsgHj8ob+/Y59k11mxQ/AJGkZ5xMHF
         9vA2eT+aaAwjJ/ZBwl74lJpD38L93rUHjfNVLNr0FstDbag8jc6yirpMz0l+0MGF8Ese
         cAmkPc+PGKAccpjET2kXUf4djSfY958xeEsdZWSuAmWdyz3f3SA6v7D8d3j3pTh1C68O
         UGofqBabP3NCv+BU2b0wNsUIdeR0ItnBOUtmH9RjsqHtND/F227CUdsPP0dIQJ7/c9H1
         WCkQNlQwdZVCMTyIyqyj+CdD/nrxyjJ9JEjSmvF04go9vKlNcjHznlSqAI2vNcNf7tK7
         s05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742795113; x=1743399913;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IInLBC9D7yWVPl3w6rKRiNZorcdnlp0gRkFtld0TbeI=;
        b=qo3SXNI7gfjaQ5gWUpZPxScR60KBi9xPttKA2v4WwX3CW48az+pqzyAygJOF3QK3+k
         PT1HoLJT0M7kgE0vJraKIuznpXVRhUou1ATBewQbFlHcQMlJS/pqeLF8lXV7lWPtAU0g
         k1mr/7yj/7z5xOU+FRp713yLva8DGZE3sgs++z0IE/FxJuB29N9vXmiV9YA9of3NSzUO
         mpn/RC6h7cWnv4zej2w3WkH3xp5DGUQ1h4madnDp+Nv/OlrLEy2zhbVrkEDsfH09QBm8
         vbMPuXnCUe9f+U/M7WVVuQbz9rokNl75QWX1oFH7zOiw3IJ2KOVs0OoJ1/+N13vF51KH
         Erlw==
X-Gm-Message-State: AOJu0YzFX+dYIRFSxxg5Qg/fgEPLvKzywDYwSRvSHXEoqSba8enUtGsX
	aAPKXcCNyb4zVPIOJLLXLERAXpX8d8K3Zhqk0h7xWqfSbwBwP81HC/4aeUfnrx+YtzzntdDkLMS
	O
X-Gm-Gg: ASbGnctp7c6aLqmmB6oClyOlcUmEVEy723U018SHbBsZd+P59TRluTchb+DxK6Ufnhy
	aKR2qRRvAFdtB3s+Nzd3g08PvN4oQMud4Q+2XR7QhHSXsh1E6W4ZsV6Vv6U1cniHm5MSRC0qspQ
	6Bum/cfgqAbo4easSPB7tuHMK4NfeWtsTtog6Hdvoh0z46wB822SHe3ogUdba5wQ7UNzMQUVVRx
	omlj/i9+C2gfucmwTHk3PaIz6q+eaS9dcMeHkpnr5EzzDTWJC4zO9ksLXM3LXHg11SkKWdkagNg
	/SX3oCUW4XLRBZQ8Dn2PH425T+PPC7QyVZfR1kdTOI0j0H4nlzbFlJ/KTjwkpd/I8JONMtrm
X-Google-Smtp-Source: AGHT+IH5fFRIqTc1fPyxlinFJUY4TH8fHfBFCiFHT9fivPOkNYdJ6aKbfTQtZOt/2/7vbO2nxjcAOg==
X-Received: by 2002:a5d:64c6:0:b0:397:8f09:5f6 with SMTP id ffacd0b85a97d-3997f9366a0mr9543937f8f.47.1742795112882;
        Sun, 23 Mar 2025 22:45:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4761fsm6214927a12.65.2025.03.23.22.45.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 22:45:12 -0700 (PDT)
Message-ID: <3ed6c491-c107-4d39-b9df-1f4bea2d62f2@suse.com>
Date: Mon, 24 Mar 2025 16:15:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify the reserved space handling inside
 copy_one_range()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <dd15d8ede1b17f86d2be14390c3927b1633b1a72.1742776906.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <dd15d8ede1b17f86d2be14390c3927b1633b1a72.1742776906.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/24 11:11, Qu Wenruo 写道:
> Inside that function we have the following variables all involved to
> help handling the reserved space:
> 
> - block_offset
> - reserve_bytes
> - dirty_blocks
> - num_blocks
> - release_bytes
> 
> Many of them (block_offset, dirty_blocks, num_blocks) are only utilized
> once or twice as a temporary variables.
> 
> Furthermore the variable @release_bytes are utilized for two different
> operations:
> 
> - As a temporary variable to release exceed range if a short copy
>    happened
>    And after a short-copy, the @release_bytes will be immediately
>    re-calculated to cancel the change such temporary usage.
> 
> - As a variables to record the length that will be released
> 
> To fix all those unnecessary variables along with the inconsistent
> variable usage:
> 
> - Introduce @reserved_start and @reserved_len variable
>    Both are utilized to track the current reserved range (block aligned).
> 
> - Use above variables to calculate the range which needs to be shrunk
>    When a short copy happened, we need to shrink the reserved space
>    beyond the last block.
> 
>    The range to be released is always [@last_block, @reserved_start +
>    @reserved_len), and the new @reserved_len will always be
>    @last_block - @reserved_start.
>    (@last_block is the exclusive block aligned file offset).
> 
> - Remove the five variables we no longer need
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

This will need a fix at least.

It works fine on x86_64 but not on aarch64 with subpage cases.

Will get it fixed in the next update.

Thanks,
Qu

