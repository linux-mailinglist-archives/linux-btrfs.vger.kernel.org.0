Return-Path: <linux-btrfs+bounces-11753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A4DA437FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 09:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507F317A68D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF6225C6F3;
	Tue, 25 Feb 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WeL17LZ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFF13A88A
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473201; cv=none; b=USnqMSh8TdT0Guv2P/8h7SBsJ/ODej+SHx/WAN63oUWTWPs3qCon52l+YmuWJ/cksnoCiZLw2UIPJC1V3or80LHLfScOJGtkRzZO17o08VLeNFu3B73iB0aBGUaMMKeOoXWCUTRvt6yaCdWa0z6WIPIffBZm1LlHaSW50BEEFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473201; c=relaxed/simple;
	bh=tA3t5yOBFavzfmAfBrEgRl2oowICqcD1++uZCss10EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHinTLzOwdsA12ZXbrxay1U5DuJ0zbpO0eQTjOJT94pHpK2fYwSx1RHCcm/+HDiWNEPN9yricW/ti4+TjetT6zbVLSL9KHBj3iulD7bf1HuQZ9CG9Ly06AF6QfkWqSbGpehQ+EyJ48cFSTehLyJVA3XwAd8qIii9wsmGfcoVUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WeL17LZ2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so7234163a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740473198; x=1741077998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=94aUP/2tF3/ViQY27LXTB41Vp3VkHlp10EflJuU30dU=;
        b=WeL17LZ2TU64WoISoBHvnIjka1rlFRNctiyb718TZPaW0ryS7VBO53doK6e114caRo
         ld8RzuxyOM/JD3udHe50iWsw4jVJdpkD0wam07S8sgVQ3QDfooscERN2BuI5Xaj2DeYC
         kiCK/LOLreJQwVl47ZxSICrIC1/1r5Yi37HLcU3oq4PoffoucVtoXBiaUpSJh6xL6yp7
         RNKMxMAddDL3yNO0l9nKhA87D0vnRuBwh10RZOT3k9iANuGJyJEDVM2eOil7ZrNe9lIj
         nUAIG04l7w+Q06y6LWIILS7EXLRD2Ug6b7CnYQE68f/jW8EXQ3/GWVVYXGFD/umxmjVF
         SYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740473198; x=1741077998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94aUP/2tF3/ViQY27LXTB41Vp3VkHlp10EflJuU30dU=;
        b=w5R9j4T2snEOXacz6ff4G1IJc9lryIDyN2J+O0qCBoYZrceoe4WTrwLbL1+b95V/c1
         HeNk+eCn29/4dU0ai4G+BYsJCOiKPA2/kxkhjzRNBdsDWHazpj/aJ6mSCLgkxUTe3j0F
         xVnKD2aTNB5f/tblvVTBkUBZJvIKkNr+1Wy9A3kBuwHxIibdR+xpQaPRaWadZ0ewVo+r
         XLnzI0RUcb/j8NvqnC53vTLTOYwtTK/xL2RRQ94/uoh3FKIlXhdXGERXvzk8BXvC6VNu
         q5ZLWRlhnmLT6ui74bqDGsotETwNeU1twlC57FMl/YcZYEwgL+LaYaHHV7nOlb6VRJki
         SF7w==
X-Gm-Message-State: AOJu0YzDopcsk1ayR/tB+Xcsc9FS0Tx1blD4zFAWFkfIj1l/YB3i40w8
	HLnwxlRW89HPGv8mzQJUOTASQHcgWFWVth13ha1MLcd31+CFUZAKavySlBy2vWE=
X-Gm-Gg: ASbGncsUdCsxglIVSP7+/RDGHAmkaVODyyTDfjBRlde0mcDbiTwg24Z9pvRcL8TZMrw
	4nKBCu6lQMLgb2vzj2kTsmEki2SeGwS7LlJL3g0zij/Y2VJJhW+AwubdiYcfxwRtOtxqsnDhfqb
	5CPWQH7O7Ej8va3g3jnRy2C4+VOjw5ERARmOc6Xg0ao1H19P/IlAdy6wQ1sqFDqdfZIbbnevzgv
	AjrXC7nQPY1vkBwk2UQGHVTJoCGk1zmnwO57f2RvsXcFi44ghkoX0JdokRuM+aFidvx/RbMmt1C
	+OieSTvNMVPCHENpV42WskoDScbkeTr/WDH5Wcli3S0cDyBM37rkqQ==
X-Google-Smtp-Source: AGHT+IFzdtrTLh62kX597zBQDjHij7Ryo9zJ/GfRYC5MDoHPDyaktGBmR7pTibK69dTob/fa/E8Btg==
X-Received: by 2002:a17:907:86a3:b0:abe:cee1:6a9 with SMTP id a640c23a62f3a-abecee107e1mr321871966b.43.1740473197627;
        Tue, 25 Feb 2025 00:46:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b7790sm9049425ad.254.2025.02.25.00.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 00:46:37 -0800 (PST)
Message-ID: <d973b4b7-0d98-4310-bb7e-50f87c374762@suse.com>
Date: Tue, 25 Feb 2025 19:16:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
To: Marc MERLIN <marc@merlins.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Su Yue <Damenly_Su@gmx.com>,
 Josef Bacik <josef@toxicpanda.com>, Chris Murphy <lists@colorremedies.com>,
 Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, Roman Mamedov
 <rm@romanrm.net>, Su Yue <suy.fnst@cn.fujitsu.com>
References: <Z6TsUwR7tyKJrZ7w@merlins.org> <Z71yICVikAzKxisq@merlins.org>
 <018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com> <Z71_TednCt9KzR45@merlins.org>
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
In-Reply-To: <Z71_TednCt9KzR45@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/25 18:59, Marc MERLIN 写道:
> On Tue, Feb 25, 2025 at 06:37:40PM +1030, Qu Wenruo wrote:
>> Full dmesg please.
>>
>> The detailed extent tree leaf is what we really need.
> 
> Sure thing, it was posted in the first message but too big to put inside the message body without bzip2
> https://www.spinics.net/lists/linux-btrfs/msg152512.html
> 
> https://www.spinics.net/lists/linux-btrfs/attachments/biniWUoCw198B.bin (keys.bz2)
> 
> Marc

This really looks like something went wrong for this slot:

  	item 51 key (350223581184 169 1) itemoff 13397 itemsize 393
  		extent refs 41 gen 4807808 flags 2
  		ref#0: tree block backref root 479807
  		ref#1: tree block backref root 479806
  		ref#2: tree block backref root 479805
  		ref#3: tree block backref root 479804
  		ref#4: tree block backref root 479803
  		ref#5: tree block backref root 479802
  		ref#6: tree block backref root 479801
  		ref#7: tree block backref root 479800
  		ref#8: tree block backref root 479799
  		ref#9: tree block backref root 479798
  		ref#10: tree block backref root 479795
  		ref#11: tree block backref root 479786
  		ref#12: tree block backref root 479773
  		ref#13: tree block backref root 398
  		ref#14: shared block backref parent 737072365568
  		ref#15: shared block backref parent 736782532608
  		ref#16: shared block backref parent 471272603648
  		ref#17: shared block backref parent 471272472576
  		ref#18: shared block backref parent 471272341504
  		ref#19: shared block backref parent 471272194048
  		ref#20: shared block backref parent 471272062976
  		ref#21: shared block backref parent 471271964672
  		ref#22: shared block backref parent 471271735296
  		ref#23: shared block backref parent 471271587840
  		ref#24: shared block backref parent 471271129088
  		ref#25: shared block backref parent 471270735872
  		ref#26: shared block backref parent 471270522880
  		ref#27: shared block backref parent 471270391808
  		ref#28: shared block backref parent 471270293504
  		ref#29: shared block backref parent 471270096896
  		ref#30: shared block backref parent 471013490688
  		ref#31: shared block backref parent 470792732672
  		ref#32: shared block backref parent 350684020736
  		ref#33: shared block backref parent 350589992960
  		ref#34: shared block backref parent 350453350400
  		ref#35: shared block backref parent 350407852032
  		ref#36: shared block backref parent 349158178816
  		ref#37: shared block backref parent 349102440448
  		ref#38: shared block backref parent 153059819520
  		ref#39: shared block backref parent 50772246528
  		ref#40: shared block backref parent 50765955072

Ref#13 is the root that mentioned has the existing one.

I have no idea why it shows up like this.

But since the fs passes btrfs check, mind to dump the following tree block?

# btrfs ins dump-tree -t extent <device> | grep "(350223581184 " -A 50

I want to make sure if the ref 398 exists on disk, or it's generated at 
runtime.


And as usual, memtest.

I believe your machine is a ThinkPad P17 gen2 with a mobile Xeon, with 
DDR4 ECC memory support, but I'm not sure if your memory sticks have ECC.
Just as a precaution, please run a memtest (I know it will be painfully 
slow, so please only run it after the above dump is taken).

Thanks,
Qu



