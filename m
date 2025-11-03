Return-Path: <linux-btrfs+bounces-18520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9EC29EAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 04:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4403F3B2D1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 03:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6CA285CAE;
	Mon,  3 Nov 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DhG5K0PW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE4154BF5
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139209; cv=none; b=E0vhMm34ShRAy7H9zP+PiyGS1yP0kB+yNuePgeWJZb7hwE+Ct2bBEUF2A3uYlfCThJ7EV5Y1g3x0z2eh11vs67pIP4JneYpbNWPD0onGDnVbckV6A/aYYujtz9wQH2IhI8mCs5h7iy87k1UCPvCU5qx5piLXMq21p+8ndvas6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139209; c=relaxed/simple;
	bh=9grNKPQjLsJjRuG31PP/rQLmgppQVL4AEMMZS6mhA0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BEZlfdlVzWvpPr6gO58Xzgyft+4UITVfoouZ1HuJTCMwYN+pM+rBtkcrisXXNg5dHfEU9M+uOsLP8LMOWEo64/kYpFoeMbsl6mxmaIc4VhChtXfxXUcDRKEii5l7/zedrwGM5SmzsGxMCZv18lVKATRIesIBkShcYlnuzbcPQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DhG5K0PW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429bcddad32so1982872f8f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Nov 2025 19:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762139204; x=1762744004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9AtXSt1Id+ROx18Awd4f+SaQMN66fTBAT2KrdO5O4g=;
        b=DhG5K0PW1UMJ4eDG8KfgUYGcDFBAGzcEtyF5Z1LHr6VyR/ZEFx7N5nnBwKAAT6mKfW
         YJuI27SFoN307AJtoTtM7pt4XS3mjqlrFK/YEczk2QU11tX1iGfNbDKo+b/zlwi9jOHp
         ewsVgkH0i+0S8VCjrQMucK0bYDRZwBqYftMV0uiJZKWqa8aHfSKktrv4d9ztZC4yEnyH
         SiEpKfsPE7gDlK8m2w58q7/nJbg9qAQgdjJ53/oKmhd4mRLlk3Mv2oWq5KScnwnR9Wu0
         WLdj2AbfNjKdU6ThjUSk+NI542bDSys4KIEHn1G7OAGEi0ZPNWj9uBwf7qwsoKljJd95
         rTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139204; x=1762744004;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9AtXSt1Id+ROx18Awd4f+SaQMN66fTBAT2KrdO5O4g=;
        b=w8dsqEqbxfUg2dYEu9L7vZOFGYBDIfI5XaQOj+WQRMxG4VSWlO6wFWsgb2qyvvbveo
         DiB3JEScCoG7kgRJVMjfwYEOU2it6gsX5iiH0HjWdUHt1f1vkoFrCRvDVo1Z9cERhvW/
         Wtqxgk+5vDAM1rbE/Avsz5KdcdCYWyw68qoF4PCyhzQXIv/F3swYrNngo628jNL+M/5h
         HS5q5tb+oMqAz2dRvZ76nICVPBlmSOvo7qxnxIh0w0metK+NCWcSnSiQ9mQsczJ1MSlN
         eyBDp1i4IMEM6NaNKzuK9jdusuq9R6ro071t1dz8COQdRRzq3YC+zCv8FNfgjs2U41oN
         ghgg==
X-Forwarded-Encrypted: i=1; AJvYcCX1TVJKmyv9QSjC192UgCuniCjv0tYvYo8FrzmK+d2zS9EHTF6blr+wDU0Z/S8Cbtairi9N6pv0mqwXsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdr5ndOCIQUAGJk9/XkM/zMfxqAepzuGjyy+7aD2wzNnRJKOg
	7MBbIp9CkH1pQWqz1Kx9UwZDoPCQgSEgh8fAWeiSl0gonTEX53DzzabSAr8UBDX3MxhXHVKmQkD
	ThpbE
X-Gm-Gg: ASbGncu+xgq+OOTveRvlGLgYzBav/YAdb6HND8zRxAk+JCjrNEFyFZ+B4PtAuQuzfEf
	FbYJ7qDFBUvs2c5Zh3zCbUWQmlwrMB1QqqJCPrLN0InvdXmoQmfz5obu5dOFgLnEocucjMDuRIT
	zKQONf2KUn1D3P6KnHzjI5ZRZyOPz4Ogi1RB5j9QXDbSXviEl1sZa+tlgAwyHCl7Y39LHqINyCq
	0iGg6cBTacf5d/nEmlxl4CAbiFBh88t1E+8uHrk1gxmlvOl1sIVJ7Mbb8LEHNCgOatu1wz2quLy
	KlaR7pPxiZMnfAGnx2Bz/Qayqh/ZwWhzyAgIEE14cXGDcx7VUdW663oARaCLoCak2RMvwe2zLaT
	Lc0MUmZXtIYp36M38cwT7baW5YynKhhGkVHV3er3qtjSOChD5twvZP34xoWLIQXMFPPaOshx/ew
	AaegMpJdaTHSK3alY6Wj56UsQbfvNn
X-Google-Smtp-Source: AGHT+IFynU3oBE8AmF6LESLgG693MYem//lvS1RrwXPrQ76+jXDcCpQT+wBRwjPP0uRA7lLPVw8aJw==
X-Received: by 2002:a5d:64e7:0:b0:426:da6f:2930 with SMTP id ffacd0b85a97d-429bd6a4473mr9358475f8f.33.1762139204566;
        Sun, 02 Nov 2025 19:06:44 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29554cba950sm70108345ad.97.2025.11.02.19.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 19:06:43 -0800 (PST)
Message-ID: <8bf2de18-3e2d-4f8a-a0c9-ea7a1313c6cb@suse.com>
Date: Mon, 3 Nov 2025 13:36:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs bug: SysRq-S SysRq-U don't sync btrfs
From: Qu Wenruo <wqu@suse.com>
To: Askar Safin <safinaskar@gmail.com>, linux-btrfs@vger.kernel.org
References: <20251101150429.321537-1-safinaskar@gmail.com>
 <1c419b6e-61eb-44fb-aa32-c31afd901497@suse.com>
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
In-Reply-To: <1c419b6e-61eb-44fb-aa32-c31afd901497@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/3 13:08, Qu Wenruo 写道:
> 
> 
> 在 2025/11/2 01:34, Askar Safin 写道:
>> "Press SysRq-S, wait 5 seconds, press SysRq-U, wait 5 seconds, press 
>> SysRq-O"
>> doesn't sync btrfs.
>>
>> Here is script to reproduce this in Qemu:
>> https://zerobin.net/? 
>> 677f7ff6c348d96f#Ka5RFMytXRmyvrwPVp1wuMAgWzaunkJ1+A+/5ahVn2A=
> 
> Confirmed the sync_fs() callback of btrfs is not executed for the global 
> sync.
> 
> Will take a look at it.

The emergency_sync() is responsible for this sysrq-s handling, and it 
will sync all filesystems.

However there are several problems:

- sync_inodes_one_sb() will only work for single device fses
   Where s_bdi is some real devices.

   Unfortunately btrfs uses a dummy block device for s_bdi, thus it will
   skip the writeback of dirty inode pages for btrfs completely.

- do_sync_work() pass @nowait instead of the common @wait
   Which is the opposite of all the fses I checked (xfs/ext4/btrfs).

   Not sure if this is designed or not, will dig into the history to be
   sure.

- sync_fs_one_sb() is called with @wait == 0.
   For btrfs this is critical, with @wait == 0 passed in, btrfs only
   flush the btree inode, and nothing more.

   This means no super block update, thus really no thing is committed.

   Although this is more or less the same as xfs/ext4, the problem is the
   previous sync_inodes_one_sb() won't do anything for btrfs.
   Thus the wait == 0 call will screw btrfs completely.

I guess the only way to solve it is to handle the @nowait properly for 
btrfs.

Will try to send out a patch for that. reverting the @nowait bit.

Thanks,
Qu


> 
> Thanks,
> Qu
> 
>>
>> - The bug is reproducible on current master (e53642b87a4f)
>> - The bug is reproducible with btrfs, but is not reproducible with ext4
>> - The bug is reproducible both in Qemu and on real hardware
>> - If I replace SysRq with "sync" or "mount -o remount,ro /disk" command,
>> the bug disappeares
>>
> 
> 


