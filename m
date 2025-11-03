Return-Path: <linux-btrfs+bounces-18596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C77C2E110
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 21:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A9F1890056
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909612C15BC;
	Mon,  3 Nov 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EAcTXB9L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AA238C0A
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203315; cv=none; b=Q79p954o7Hxrh4MEHAeTsQg/5Kd19KC4RIeE6DCuAZpwrtikJ2Qv/BT347UznwiF7+ewQ/cCfN6aOmEM927n82psPaMYxmHDaLq28D1aBTMUcOYUVFfTbSvd71HYTMGmJBSWXcVoHCujhzKvzBIKf6WfQPscv9Q9dyPkie/z6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203315; c=relaxed/simple;
	bh=j2ka0Du304eFSI3URmzk7ROBpiufWYwrutSpwJmt+gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8YqtwmmQCuZzCJT3S3wwA6Pz7y4lLSUbCIQTgwJvWg5J3o0eF8W5bPKZMjMbLiDVXOLEW7vPUFktgGF13F+8oTnrECDzv2IcAIlcunsUH78HMf+wmCoUj2/MrsMxt7sIrErFXEijDFrSonrHaGumu6R43H48wtXnLQPEyOVsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EAcTXB9L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so1283819f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Nov 2025 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762203312; x=1762808112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=maeRjX1obKpA9rcTHZvyJjqqJETjy5RwGnFRm5Xcm8k=;
        b=EAcTXB9LcG0MIvCwVh1WFsdCeY6ltP07VDDPyOg+VAzQ+H3hUzsHEc2XKi+w7kTrWO
         POixBNO//7AXQH/3eZaWpI8U9Ga5ijbwt0G1MVvhF7cNWRoIkv5FfkFYkqy5l324jHSM
         pahRmkW/T1DjDRkBMF+AreR5csKnhATgheHGkfeKV6+Oxi2KRllghmOsufd/TsT2kbzI
         Kvt+JiKAzO/qKF8R4CSQ51Ty6QLOCZucRqaPiCk8xcx7U/I2NqV6OmjXY6HcJq5YD7MH
         EqvbHNYqKGUXTyToGZFlwBdsSSD2ACzdJoMd4tQGuWIyD2G98G7OLuzEhBwc7r6xppM6
         IFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203312; x=1762808112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maeRjX1obKpA9rcTHZvyJjqqJETjy5RwGnFRm5Xcm8k=;
        b=cDOPxv9pYqkweqsBhh1EGN3ePUL2B7Q/Nbt8xmMN/PymVOb4wqJGdOkkFGG/juXj93
         55lLqG+INEx7nbSO3qk4KeuR+CvPMh/7TxpyVijxtSdN0VOy0PszVFR+wjSqaCv/A4Lf
         lZ3kByuXTs+HwTzjdDYhzrTVfAsxrfM0EPWyZ/jWVPwp5cm5C8BFAHMoc9IQ/b3dEKZP
         vOaU0k/Oi0bbFHr2KGpPz2JGwv7Zy51mdF/5ZdaB9bl1KnGwygHfig6l8ulIOCKAH9Q9
         ZbzZDUThQ5tSMf3j8bx30pJZ6XDaA8OYEPoMd0whNal/0ah7THPrOCCBUbn5IDZzMZK9
         YkfA==
X-Gm-Message-State: AOJu0Yxlv/Y+/o70QyxurJUWRdJsdMbzTCcapiUZBAT/+6xYV4rntUtS
	yKJsbri0zfFcjOWvy8ayVMtLBtu0S3F5WermTZDV9m577TDzKhcsHnZssl9ylYnfyWg=
X-Gm-Gg: ASbGnctSDvfOOh9QdJMlzP6fNT0skLBki+iOUJjq99poVv5QWyAuDHrL0VJSOA2q+Fe
	G73efzPoHSTp4uPHO37ixgY/9AE5lPU5CnKK7KeKvx9jjDz7mRne571syhHKGVOZ9cI69gezhZq
	GWKt3KmUEEAHf9RRpJBkUNL+E/ugb7Id95JD36kkylf2WrZUSBV8Nl61wHmKVUWGXS8BfrmzYqr
	GmhE3zgELl1u9pkb9fXE4hGg4GRNBmgN1nzSF4vG/PGWEqoFpvcgdWQVKGDdQ0oI8UqcyQCY2lW
	TGcfqcVt27xUi1mWW1aUhmzi52OmqOQKQD2y7joOZwNBR4gn2m1KxAQ7D9Yva6pL62poDgHUmU1
	w8TDjqYBrjyYaMID8ufD0VoPYF8rBu4I2v4ErY4P2YzeAULtXm4SgDuVv7jdCgeBIEZmbwsV2QA
	9avzf33pS+fCq3TglaLQURFYtLI5WB78Ge2YxR/vc=
X-Google-Smtp-Source: AGHT+IEKmdFdDLRL0MpaKaBKWM8pPd65NhFlvW6yDCYoa7VcttAa1gHqo3eQEjKzWWMrrpeoxZkZcw==
X-Received: by 2002:a05:6000:3108:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-429dbd10259mr612205f8f.23.1762203311977;
        Mon, 03 Nov 2025 12:55:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14c6sm2076927a91.10.2025.11.03.12.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 12:55:11 -0800 (PST)
Message-ID: <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
Date: Tue, 4 Nov 2025 07:25:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 Askar Safin <safinaskar@gmail.com>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
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
In-Reply-To: <aQiYZqX5aGn-FW56@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/3 22:26, Christoph Hellwig 写道:
> The emergency sync being non-blocking goes back to day 1.  I think the
> idea behind it is to not lock up a already messed up system by
> blocking forever, even if it is in workqueue.  Changing this feels
> a bit risky to me.

Considering everything is already done in task context (baked by the 
global per-cpu workqueue), it at least won't block anything else.

And I'd say if the fs is already screwed up and hanging, the 
sync_inodes_one_sb() call are more likely to hang than the final 
sync_fs() call.

> 
> On Mon, Nov 03, 2025 at 02:37:29PM +1030, Qu Wenruo wrote:
>> At this stage, btrfs is only one super block update away to be fully committed.
>> I believe it's the more or less the same for other fses too.
> 
> Most file systems do not need a superblock update to commit data.

That's the main difference, btrfs always needs a superblock update to 
switch metadata due to its metadata COW nature.

The only good news is, emergency sync is not that a hot path, we have a 
lot of time to properly fix.

>> The problem is the next step, sync_bdevs().
>> Normally other fses have their super block already updated in the page
>> cache of the block device, but btrfs only updates the super block during
>> full transaction commit.
>>
>> So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
>> still using its older super block, all pointing back to the old metadata
>> and data.
>>
> 
> At least for XFS, no metadata is written through the block device
> mapping anyway.
> 

So does that mean sync_inodes_one_sb() on XFS (or even ext4?) will 
always submit needed metadata (journal?) to disk?

Thanks,
Qu

