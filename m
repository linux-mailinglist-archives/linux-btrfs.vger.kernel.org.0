Return-Path: <linux-btrfs+bounces-15942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E6B1F09D
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Aug 2025 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AE8165697
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2949E248881;
	Fri,  8 Aug 2025 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNljQvnm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981B220F52
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754691112; cv=none; b=OEASx5x7nz/knQ7SsHQFXcZ6Vim4XUlloJnsI4fwK3H0usRNk/jhcZR8vTffzvl7aGZ3CjnEoUKD9U196+bhiHF+R9rb3zSzsQVm7okom757Zb5R6/Q7wzqFysyR6hIyDRite3j98OO4q1nkOzpM2xrkvWb0IrtyvF7JANlZ1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754691112; c=relaxed/simple;
	bh=sPot/QiJGx0ie2GqPuzcKoCFOI60aOBXfDEt5ep6Kl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPfg4Pyh6JR8v+EraxDn+TDlP5VMjgF0+VS617IYlI6pyu+wrmevLzVyk5WRBgYtnfjxDQ1rC6yA5VY+ALum3+va9qfdjVt6cjjHqZBM/lFAo0aRhQSZVVSliWaDAUpe2OptGVBBMvgKge2E0VS2TnmxmHQhZQ7FDU+86KGafvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNljQvnm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so1596761f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Aug 2025 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754691108; x=1755295908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vfp4XJviTGuQNIDYxaXXZY38lwfZr5BPome6oUUC1Fw=;
        b=KNljQvnmNTVxXm3LkWBnKj1BOzOvTLrIFWhq40frLzqh0T0/jP2KK3EXMCb1xv1U2b
         6EzEVczFRSQ1a9ffbcnjWBouU3i2/6NmrTGxskcNZRGLmlPv3zz9Iv57z/+KazvKzmsO
         tPtHk7HytvbZSuCE/1eDq0xDbkG+iBObQoyyhZTDwjn5kM+t6BWNeGgKMCi0+BoBYW8B
         i0M38+zmZyPtKdB/bJ49cVxc7htRhVcVNqRGeY2107pBpPST4R4twnheYy06uZ0iP0Bc
         TXuR+NQo25wR/OvymkiLYp99jBRZt/ikXyGQXc0V+I9s0u26gKnm77GckjlJ9ELEUeOa
         W45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754691108; x=1755295908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfp4XJviTGuQNIDYxaXXZY38lwfZr5BPome6oUUC1Fw=;
        b=FwRNHlpOExBl8B1zqtDfzHtcIJHVT6msdn7z3ke8YiEZ2GvKqa+ltiprg5oe844z+V
         Gs5atZhGiiuVOi5Fi/btc0tFctBszCvUh8LXYThkvFyBbcfq6Pyztz4mVlCTmEhgTfhy
         TkG6M+c7adcuWqwxgdUIJ8l2F6vIqNxOp4OY/9PlXX4FPtw6eDUuzGGaHHr8hRSswl51
         NrGJSJUTCLFYQcnGqR1uK6BdyDWBXmX+hJZn1qgXNKebILmC0VVP+rLIbVfU7jBHibPH
         CxDyQWS+af/QnAlmSLuk3FDCfhdynKkBEe33qefsmoAVF9CppIa5usiMFa/1WncJxXXP
         SX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkGyMFVyo5j7AeYymkpvr76PeGfe7O1d1t0+0Ep3hNQgp5wkc+IebigPRMlxpXHZJe949TKQiypfZ0Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznwidiu5Sc9KJR8UXoOvPZxKAGI+wJS74Erdy+JOTTSAz6pGel
	iwimZ7IFqJpDzKHazuUYjSIRyIxKXaqStu999oursx8ht4Zkr/9EBfu7oyCIu/B460I=
X-Gm-Gg: ASbGncsTdPlJ+tQgr8YzRMNV/hc2ni4JpOUgccQQ9XNVsjAejH6x4EWzXrpuNGZepxs
	oOYeb4i4H+FveGPiPOXxuyOXJhyVgTIAVb5PzO2p+OtBLhLG8gg5MzuBTG2J47y1iLc840CRU9Q
	K17A5f9nxmyzAXikw1ob03LJUX3TrCFOexncSLyUX636HoMdgcGo0tnj17LmntT82Hi0CUamq4r
	tdHm9cueLFGDdV2rPL9MqQKK2iQasidi9M9bT2tyzPH+iz4KiSCN3D8KwytT6fYT4rm6faRu+hw
	lFPYzvkt/6x6h4xiVRb9auqTeCgrvkk/A3QJldwYTQWncJIYau74o/le2Us7/32XZFcxh8EmhgX
	MnA0XXyUwlAeJUSDAfZnmWr1KGJTerIlXAVIWHwSMVp6scnUrbBJJXKlhnVPU
X-Google-Smtp-Source: AGHT+IFIxLKMLKj0aUzzhwq3MMNuW4vixZGGnupJ71Z/AHI1G3sTObVSeFAVOad94beA9NPbKPu3+g==
X-Received: by 2002:a05:6000:1ac6:b0:3b7:7749:aa92 with SMTP id ffacd0b85a97d-3b900b6ab1emr3552969f8f.58.1754691108438;
        Fri, 08 Aug 2025 15:11:48 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm21219043b3a.42.2025.08.08.15.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 15:11:47 -0700 (PDT)
Message-ID: <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
Date: Sat, 9 Aug 2025 07:41:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
To: Theodore Ts'o <tytso@mit.edu>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
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
In-Reply-To: <20250808121659.GC778805@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/8 21:46, Theodore Ts'o 写道:
> On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
>>
>> 在 2025/8/8 17:22, Qu Wenruo 写道:
>>> Hi,
>>>
>>> [BACKGROUND]
>>> Recently I'm testing btrfs with 16KiB block size.
>>>
>>> Currently btrfs is artificially limiting subpage block size to 4K.
>>> But there is a simple patch to change it to support all block sizes <=
>>> page size in my branch:
>>>
>>> https://github.com/adam900710/linux/tree/larger_bs_support
>>>
>>> [IOMAP WARNING]
>>> And I'm running into a very weird kernel warning at btrfs/136, with 16K
>>> block size and 64K page size.
>>>
>>> The problem is, the problem happens with ext3 (using ext4 modeule) with
>>> 16K block size, and no btrfs is involved yet.
> 
> 
> Thanks for the bug report!  This looks like it's an issue with using
> indirect block-mapped file with a 16k block size.  I tried your
> reproducer using a 1k block size on an x86_64 system, which is how I
> test problem caused by the block size < page size.  It didn't
> reproduce there, so it looks like it really needs a 16k block size.
> 
> Can you say something about what system were you running your testing
> on --- was it an arm64 system, or a powerpc 64 system (the two most
> common systems with page size > 4k)?  (I assume you're not trying to
> do this on an Itanic.  :-)   And was the page size 16k or 64k?

The architecture is aarch64, the host board is Rock5B (cheap and fast 
enough), the test machine is a VM on that board, with ovmf as the UEFI 
firmware.

The kernel is configured to use 64K page size, the *ext3* system is 
using 16K block size.

Currently I tried the following combination with 64K page size and ext3, 
the result looks like the following

- 2K block size
- 4K block size
   All fine

- 8K block size
- 16K block size
   All the same kernel warning and never ending fsstress

- 32K block size
- 64K block size
   All fine

I am surprised as you that, not all subpage block size are having 
problems, just 2 of the less common combinations failed.

And the most common ones (4K, page size) are all fine.

Finally, if using ext4 not ext3, all combinations above are fine again.

So I ran out of ideas why only 2 block sizes fail here...

Thanks,
Qu

> 
> Thanks,
> 
> 					- Ted
> 


