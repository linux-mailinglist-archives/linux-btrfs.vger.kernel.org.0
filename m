Return-Path: <linux-btrfs+bounces-14907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B8EAE617A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B934C0C8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009C1283C8C;
	Tue, 24 Jun 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P4pt91vt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808A28031C
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758719; cv=none; b=hkU7FR3Vd8f9a6UbYnSfszCJIgrOfDaDi0cNvJatMAatWm0HaUHOKCPbguPiOeQRfXjgMaVKgl1T/0di3kAfKmzfb+Zry/kGQ3B4pKntHmiK7zuUqqXX1WRUqAEZ4UbKyRZyBlWm2OFtba1q6hUmTlwX8ADR0/L3VHl7QaFRfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758719; c=relaxed/simple;
	bh=3ggjFNl0YiUcZwHZCzVY2fLaZl2eqqSvLjxPcrQQ5iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdybBQUknojAQv1k/3OCbzZcEnkWmgExzLV17TTkufrynOelmkO/pisZLEZC1HuqJQzM+/PACKlaRmrq4onAXIloUSELKd6Ck+ckkcLtC3NxQgRspVhE0/7FGkVSzj38fsBPFPmM46PisuGFRt81cQfW+P1mcXRgL5DT/KEpwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P4pt91vt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so222408f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750758715; x=1751363515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mCMEAjfRu5oUF/8uWMFtpH6cgk/kkkTfVrjbmLL8XJI=;
        b=P4pt91vtdnJ66d1BkubJS+uWK4DRIYFFhkZHdEaoXlPOGy9GgKEfKlO12+d/LEnA7f
         U0WGM7X5gf+2OnkSyf8sBW9U1A0dy/A2zFoKG7A0YuQM1Xw33oH9o+pz9MP/fE5Bpxf6
         zMmhczrpG2M78946/NPxrMbEAS3W2KLK/iJ/TS5wZs4eJk1BMdZPI3lXoVGuXc1nieyw
         l6TD2z6PQcKbdGoMoKXsqKYuLK2I4ary2qYxin0/xfv+xGrXz75fK23BT8dDyFKwppSW
         HAf/NIPE49jKWcgPVQmvKQ6+EQOyp5X4YQxNM4sWAzh2rerOPCaxU2zPNLY6DTsdiWsg
         Aaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750758715; x=1751363515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCMEAjfRu5oUF/8uWMFtpH6cgk/kkkTfVrjbmLL8XJI=;
        b=cHgjKbxFVzg8KxqyqkyEYKHSvAC2oNqqfNRcbrDB2WLGuaw5F6asKcfsBwtdRcknLK
         ntZG0DAVU4LAaJoLZKnVraq7n7sDTCCQYB3S4exC1JUGtpX+Ym3Ss8thLZVg12qhCM3p
         0PktTRjKXFMFHYojdj99KlsxAxUXxhSYKLLEv4Pp6LkFBSoVaaosZq+LzqVFKeWXev5B
         NKX+EzHnqtvPjxncQiIL5wGwrNFcUX5Tr4DQ+MNZlVTV9S5kploBLHwQ7zbcATG6HdOw
         ZwNqtw8YumHXKR0k0Rn3IAUwha8l6TSir73zOHJmr/JEOv7rdpHXTy5QIiYQ1+HJk0BG
         KxeA==
X-Forwarded-Encrypted: i=1; AJvYcCU+GfehCjDXRH9hPkYswoemeddkkd9Pfu1MEtX3XLbHCkUM/UcE3Bl4vnY5xnbLLfS72H+7wsgaAK/EDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXsS9Fbujxhq3/O4U7XsbroASyGZSRtltv3X6+iP+ZtyAzzK+
	QIr8EpZ/+I1e04dU77ydr5Evke83rL20MPaQxsZ8sv7iIQzrL3NEWONEPZXIyEgSOBY=
X-Gm-Gg: ASbGnct37eyq2PElT6D3hugsRJ5iFSmP1zBkpcLB48tn383R/BBWD8SoQCg20jNhD5c
	C29v3I1PX6uyLGrZGYdzSF73n8LzAPvIQt8Ru9vgaByCvU1INntKz5yV0x9wxfJ2nTqohDfB/KS
	BO15kl9heJVtg1cAD3GTnSqLBV0HnedAU1EyFc/K7NAVc6FGVbJ7iW2pHl2v4++LtDpv8LHSRoK
	MVEyVkkCURcLdi+zkxTcfdFpN2O2guig1qPBWZ0yW2apBPw0bBQxzMydmhphmYY+tB0FLVtaKDl
	4KV4yfJeg09fAh77IL/yFCb/eqwJOXYsfmrKq9w5ElCmS5JAboLyYcfQPGdIdQg4NEv1jZjFpJp
	7GoJqghOEKTKuBN2hhohYhr6/
X-Google-Smtp-Source: AGHT+IFsuTvDUHmwiflUkrAvnHqrLlFxtwWqNkQoNZHM87eDeSw6YeebvIDXbtNpDWjsXgce3SdntA==
X-Received: by 2002:a5d:5f4b:0:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3a6d12c1848mr13619681f8f.16.1750758715062;
        Tue, 24 Jun 2025 02:51:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83f11easm102204355ad.84.2025.06.24.02.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:51:54 -0700 (PDT)
Message-ID: <abe98c94-b4e0-446b-90e7-c9cdb1c9d197@suse.com>
Date: Tue, 24 Jun 2025 19:21:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
 <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>
 <20250624-briefe-hassen-f693b4fe3501@brauner>
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
In-Reply-To: <20250624-briefe-hassen-f693b4fe3501@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/24 18:43, Christian Brauner 写道:
[...]
>> It's not hard for btrfs to provide it, we already have a check function
>> btrfs_check_rw_degradable() to do that.
>>
>> Although I'd say, that will be something way down the road.
> 
> Yes, for sure. I think long-term we should hoist at least the bare
> infrastructure for multi-device filesystem management into the VFS.

Just want to mention that, "multi-device filesystem" already includes 
fses with external journal.

Thus the new callback may be a good chance for those mature fses to 
explore some corner case availability improvement, e.g. the loss of the 
external journal device while there is no live journal on it.
(I have to admin it's super niche, and live-migration to internal 
journal may be way more complex than my uneducated guess)

Thanks,
Qu

> Or we should at least explore whether that's feasible and if it's
> overall advantageous to maintenance and standardization. We've already
> done a bit of that and imho it's now a lot easier to reason about the
> basics already.
> 
>>
>> We even don't have a proper way to let end user configure the device loss
>> behavior.
>> E.g. some end users may prefer a full shutdown to be extra cautious, other
>> than continue degraded.
> 
> Right.


