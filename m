Return-Path: <linux-btrfs+bounces-10471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70B89F46CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 10:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947D0188B719
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18691DE2C3;
	Tue, 17 Dec 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ni6Acmr/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5E1DDC27
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426215; cv=none; b=NVNgQfA6rcamvrmqZQoF8OhACKuupJTEEzMWWKZV+tTHgOnrvSm6kv8/SpESsH2n268dHIxDN1SGVQZdZOZYVAvK1kCg2gAPTheiyFQpUWJjh3Bprm7LaR6qkTxv3zXhbeZcbS5qJrMFjjSLpJGV0m5AksnC5TlM4BA4Pvm1OCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426215; c=relaxed/simple;
	bh=gYl9Bwa0hYfCWxOnixc3k4K4+XO52hYq4GRJcAGDFfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qErdKZKF9DMl4KSovVrEmtw/Em4DdE6CGcx4TLIvSo5GJeEjklkvNhcsrEhCrTcl2DGUu2+JOCNSR71Ghbsv8YJpkPNuPXFmXSQ0L4Q8p1Dn076yl1qSAFJezHPgGo/lx0bKMLTK9D0RoPNEmZbnbZtftjcoEJ4SmaSgRXI3PjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ni6Acmr/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso4287597f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 01:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734426211; x=1735031011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0kaTPZ+0BLLgtvGuU9qjYCECnvb71mWpVwMAMaYmwi8=;
        b=Ni6Acmr/RYZahW1FM4PgJMK5tUsXj2CrQdfD5crIVgDPJSxUa1Rb1TxVOs76HFQ0hd
         EpasImJCd3+/a4ANerIKQ5qjNsObRJBIUc3Z+tYRrQBhX8N/Obocz4N7dzxQZfziz3ya
         ntyvOrVgbJOwIdF4bOSqZNvhYZL/jQO1keMoxNQ27DzIaiIwRM5Pp2QOUQd1dePdAMGk
         Ajpqup2RraocDh4tDcrDMyXZYQv41xH08VQWCaPH4KAPwr8d28AyDNvf1fJ66Ogu4nW/
         jvD6LDZZE91taM5ADh7W1VlQvDSxCjQVmZ/h6z87i6ho55+Ye4Eyil8ESbdsMSP4gAT0
         +aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426211; x=1735031011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kaTPZ+0BLLgtvGuU9qjYCECnvb71mWpVwMAMaYmwi8=;
        b=pKAlwb67VOPzOSZz7xAD1t9mTG/iv8R1BCe4n0f7cHugpeiqOWh+RmaLPTAFQiz25N
         jny6XdcHG13ZdM6Fxe7MSux0Ptg6GLpiaoyQg2peIroyIBLqDTFt3c+IctgN8+wmmUdX
         EuNK4cIyoWZ5BMlljjOr1QQZLTBHn20HoCvtgWvUL5mL05KzlYKbnJqfr4azKuD8a9hL
         sdDt6wm+bA5YKcRYgTakAPTKy9nt/7iHCsg+2zYUmT2i0VW30y864cysJ4CCXgvVwlKc
         4V8Aob1QLxoeCnD0QzepqlZUl5WwWxntberqBiFxLWeYHHSAYXf2HNvRE4H6Q8XD2QOH
         U3sQ==
X-Gm-Message-State: AOJu0YyiLN7GezJWoM4TGCbyEGiRtVnPoJamDtheYSFzGc0VUHyaNF0g
	hMiar5bNLqmF5avdQw0NBJqFhNLOiqsZF351XUQlROgiUECxCRGEYQjL3doYEQU=
X-Gm-Gg: ASbGncsq0t3wNBdsfe63ydb2N0XX3vg82OVTsULgQyTUJVAIEx0uB5GtV4dzQyXEwcs
	2y6QFqpxUEI8pMm5o8oUQEYvoY64lLZpLlztlzchGDO1XJgvJcRr3oT5eUIuNt37wC/gvDggrvh
	uWNQlMezwdP21TNWYMR31Z2pQFAmg3szCKRqd6+0zGq0VbHK1zD9bTCFS7EEii3rAIRQS6YmLD5
	cAGIi9sE3ntRSKqzL6bjgqlPLTlkjXymokNTAWw2BJzo6CVdh436HWNzXi2SB95RCOsG0HuvxNS
	5M3mSoOc
X-Google-Smtp-Source: AGHT+IHb8LB/LmKkFPsEAHdkgL067On5Xkw1NlPJv70km3qYVWO0uwJD5zc7y60zGv6W5UgEB90/Ug==
X-Received: by 2002:a05:6000:4b0e:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-3886fe7c5ebmr15474414f8f.0.1734426210824;
        Tue, 17 Dec 2024 01:03:30 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e54057sm55316015ad.146.2024.12.17.01.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:03:30 -0800 (PST)
Message-ID: <72f96e52-de4b-429d-8497-3539afd86c98@suse.com>
Date: Tue, 17 Dec 2024 19:33:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] btrfs: move btrfs_is_empty_uuid() from ioctl.c into
 fs.c
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1734368270.git.fdmanana@suse.com>
 <7aef21820a6bad0e41699f18660038546adbbc9c.1734368270.git.fdmanana@suse.com>
 <785dadec-8352-46d2-864d-3df93d979db1@gmx.com>
 <CAL3q7H6dPzBe0M564RrWUnsa-UxvHV2Ud4GqQuBXcrN_rY_igg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6dPzBe0M564RrWUnsa-UxvHV2Ud4GqQuBXcrN_rY_igg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 19:27, Filipe Manana 写道:
> On Tue, Dec 17, 2024 at 12:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/12/17 03:47, fdmanana@kernel.org 写道:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> It's a generic helper not specific to ioctls and used in several places,
>>> so move it out from ioctl.c and into fs.c. While at it change its return
>>> type from int to bool and declare the loop variable in the loop itself.
>>>
>>> This also slightly reduces the module's size.
>>>
>>> Before this change:
>>>
>>>     $ size fs/btrfs/btrfs.ko
>>>        text       data     bss     dec     hex filename
>>>     1781492     161037   16920 1959449  1de619 fs/btrfs/btrfs.ko
>>>
>>> After this change:
>>>
>>>     $ size fs/btrfs/btrfs.ko
>>>        text       data     bss     dec     hex filename
>>>     1781340     161037   16920 1959297  1de581 fs/btrfs/btrfs.ko
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/fs.c    |  9 +++++++++
>>>    fs/btrfs/fs.h    |  2 ++
>>>    fs/btrfs/ioctl.c | 11 -----------
>>>    fs/btrfs/ioctl.h |  1 -
>>>    4 files changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
>>> index 09cfb43580cb..06a863252a85 100644
>>> --- a/fs/btrfs/fs.c
>>> +++ b/fs/btrfs/fs.c
>>> @@ -55,6 +55,15 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
>>>        return ARRAY_SIZE(btrfs_csums);
>>>    }
>>>
>>> +bool __pure btrfs_is_empty_uuid(const u8 *uuid)
>>> +{
>>> +     for (int i = 0; i < BTRFS_UUID_SIZE; i++) {
>>> +             if (uuid[i] != 0)
>>> +                     return false;
>>> +     }
>>
>> Since we're here, would it be possible to go with
>> mem_is_zero()/memchr_inv() which contains some extra optimization.
>>
>> And if we go calling mem_is_zero()/memchr_inv(), can we change this to
>> an inline?
> 
> I'll send that as a separate change, using uuid_is_null() as Johannes
> suggested, on top of this.
> The goal here was just to move code around and not change the
> implementation while doing it.

Got it, feel free to add the reviewed-by tags to the whole series.

Thanks,
Qu

> 
> Thanks.
> 
>>
>> Otherwise looks good to me.
>>
>> Thanks,
>> Qu
>>> +     return true;
>>> +}
>>> +
>>>    /*
>>>     * Start exclusive operation @type, return true on success.
>>>     */
>>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>>> index b05f2af97140..15c26c6f4d6e 100644
>>> --- a/fs/btrfs/fs.h
>>> +++ b/fs/btrfs/fs.h
>>> @@ -988,6 +988,8 @@ const char *btrfs_super_csum_name(u16 csum_type);
>>>    const char *btrfs_super_csum_driver(u16 csum_type);
>>>    size_t __attribute_const__ btrfs_get_num_csums(void);
>>>
>>> +bool __pure btrfs_is_empty_uuid(const u8 *uuid);
>>> +
>>>    /* Compatibility and incompatibility defines */
>>>    void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>>>                             const char *name);
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index 0ede6a5524c2..7872de140489 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -471,17 +471,6 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>>>        return ret;
>>>    }
>>>
>>> -int __pure btrfs_is_empty_uuid(const u8 *uuid)
>>> -{
>>> -     int i;
>>> -
>>> -     for (i = 0; i < BTRFS_UUID_SIZE; i++) {
>>> -             if (uuid[i])
>>> -                     return 0;
>>> -     }
>>> -     return 1;
>>> -}
>>> -
>>>    /*
>>>     * Calculate the number of transaction items to reserve for creating a subvolume
>>>     * or snapshot, not including the inode, directory entries, or parent directory.
>>> diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
>>> index 2b760c8778f8..ce915fcda43b 100644
>>> --- a/fs/btrfs/ioctl.h
>>> +++ b/fs/btrfs/ioctl.h
>>> @@ -19,7 +19,6 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
>>>                       struct dentry *dentry, struct fileattr *fa);
>>>    int btrfs_ioctl_get_supported_features(void __user *arg);
>>>    void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
>>> -int __pure btrfs_is_empty_uuid(const u8 *uuid);
>>>    void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
>>>                                     struct btrfs_ioctl_balance_args *bargs);
>>>    int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>>
> 


