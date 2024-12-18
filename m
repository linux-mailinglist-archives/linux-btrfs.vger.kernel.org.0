Return-Path: <linux-btrfs+bounces-10593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87C9F6F70
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 22:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EEC7A0309
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C121FC7E5;
	Wed, 18 Dec 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UhPktotA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014C35949
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557304; cv=none; b=YCybVj+w88BGmd0KUgIbgvJZbH13Zk79Rb+ivOvaAEg6T8t9LJBriYxExyJ/t705CkkB5PKkfXAE9ECgAUjxJaobto0NP6MqC6Nrui5Qh4xMSLqpiumW9jnlFYLDlU8WA+x61rtJq+/ViD8fcLw9h2MK6giftOLEdC7cJ9VtkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557304; c=relaxed/simple;
	bh=7xIoR8vpImmYOUdPDSFUyGkLD0WBYP8iNr/ZNcApn8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLWxI4fPRCBNLgNayyRfQ4QMnRgb/tFXb+rTkD0sr2V47pGXU1eZFXs3OzAsQsEQrI6p9cApm7WYh7Nzt5T1S6ZvXujiBPN6wLVs356XKRHbZVV0bHk6NJHtAT+xfEgjA5rKpmOeYBNaZwQlUNgm2m9jj9pQ7U2X5JFd4329kjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UhPktotA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso745445e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 13:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734557301; x=1735162101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nimcYlA4tlXtI44WTjsPUa83O2G64YVz6YDf6iXpxhA=;
        b=UhPktotAQJx4armrrp3nJ699uMLquk0P64gvtF49ewagyW9NUwuPuX0JbZ5qlE+EHW
         ouCG4FVBgXOvTEB5KPrYMVexvb5Xx8n7YhrKoO0NbAD/h4f8TbIaeOL4pUbWtlHOrkf8
         9B3TAZ3AynhKrHnm/LZwuM7ln1ZDbTIV9d5b7g7dDwLwL+/9kVolu12kWytbnx9c9Vdz
         cll9ev3IlIt+6+ZTATGVpsRU5zVBbnb7Pw7IaKMzSbG1ppbyccbDZ66o56zRpbDQZviO
         9GgX+j+Ux9P13arutKPb7gXQFMme1WK0HVsi+6idUzfbQv/xh4pdsuQ0K5NCnDtfaC/O
         n8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734557301; x=1735162101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nimcYlA4tlXtI44WTjsPUa83O2G64YVz6YDf6iXpxhA=;
        b=HFdFKwMZY3eaFWo+mq55BNrAZ05WNwUYx5p4ygWb4oPC2N/GRSwOhX6fx80pq5CUSV
         7AWhTjHHVTThZVgN74bCXhfEC3DcB7pL4WkNh1DbnliRctDWmYDhh2KyHclBMTohnVZY
         aC/6NBM1rnpKO71HDbJ5z47x4HddNp8vskl073asKchOjx4qRlepdjzOXiL8Lda0LYrR
         vR5LA38hFupt4bxvz9TZR/qNxe1LzByJLYGBhzZCYHGWClbnR/Kc0DshsB1dEH2QDw+V
         R6dfkOh4VdJyjrfN2VLdc0s/whL9Cm+9KdbUAYjCmFvmqxxKrYWD5QQky5iPQ5r3HFgl
         scTg==
X-Gm-Message-State: AOJu0YzbhZuVSEzOtrwtknyHQTrmMcgIfc1Hm9vUqOjmbTsEH8K+OV2Q
	wj//8lx1wqlbC9MASkf8HF3Kc/FVXVTtOPVgONEkEItoZWa6JJOJd1AZbvAw9Q+JEhdo8eaGsTR
	F
X-Gm-Gg: ASbGncsr1GeBtwo5pCEHJlejoVuNXPZCq6GYcKGk3lvfQm6DDw1uYMdEDUviYVlUNB9
	IHkWKc+eaQCrSoW8+JJkUJD5iyMUcKaCKt4cP40yHRHiLPzPoWro1eF6FSu3MK76kSeLQV85aTR
	FLySvbeUzT6dOmJxZoYr2vKoqgfeTACkrDeHeQQ6IdRwleMJekfRTJPW/faIXlWKnCf7lDA5dKA
	qQbh+TZ5/n9yKekVlpgabigqaFmdgmNWETTX8Zo4YQKOb53FZKNuHzpv6dti9gKkL/WTmv8t6Vh
	oVlH5v+C
X-Google-Smtp-Source: AGHT+IFZZiQYyLlS3bK/IhPxGOAcgt5fPIKkv+axg8KI5wpt6+E9rBT7hEvppNNs2nrovGfl1A9lZA==
X-Received: by 2002:a05:6000:717:b0:385:fc00:f5f3 with SMTP id ffacd0b85a97d-388e4d2df2fmr3637648f8f.4.1734557300329;
        Wed, 18 Dec 2024 13:28:20 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918baf958sm8931737b3a.135.2024.12.18.13.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 13:28:19 -0800 (PST)
Message-ID: <c4daaaf6-110e-426f-aa8d-edbc375663ae@suse.com>
Date: Thu, 19 Dec 2024 07:58:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into
 fs.c
To: Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1734368270.git.fdmanana@suse.com>
 <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
 <20241218202117.GG31418@twin.jikos.cz>
 <CAL3q7H5ScfeKwWXndwWP6DjhxC5MvqTKxyikQMCcmEUyfF9Gpg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5ScfeKwWXndwWP6DjhxC5MvqTKxyikQMCcmEUyfF9Gpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/19 07:15, Filipe Manana 写道:
> On Wed, Dec 18, 2024 at 8:21 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Mon, Dec 16, 2024 at 05:17:17PM +0000, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> The ctree module is about the implementation of the btree data structure
>>> and not a place holder for generic filesystem things like the csum
>>> algorithm details. Move the functions related to the csum algorithm
>>> details away from ctree.c and into fs.c, which is a far better place for
>>> them. Also fix missing punctuation in comments and change one multiline
>>> comment to a single line comment since everything fits in under 80
>>> characters.
>>>
>>> For some reason this also sligthly reduces the module's size.
>>>
>>> Before this change:
>>>
>>>    $ size fs/btrfs/btrfs.ko
>>>       text        data     bss     dec     hex filename
>>>    1782126      161045   16920 1960091  1de89b fs/btrfs/btrfs.ko
>>>
>>> After this change:
>>>
>>>    $ size fs/btrfs/btrfs.ko
>>>       text        data     bss     dec     hex filename
>>>    1782094      161045   16920 1960059  1de87b fs/btrfs/btrfs.ko
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>   fs/btrfs/ctree.c | 51 ------------------------------------------------
>>>   fs/btrfs/ctree.h |  6 ------
>>>   fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   fs/btrfs/fs.h    |  6 ++++++
>>
>> Can you please create a new file for checksums? Moving everything to
>> fs.c looks like we're going to have another ctree.c.
> 
> Is it really worth it? After this patchset fs.c is only 229 lines and
> the csum related functions are just a few and very short.
> My idea would be to do such a thing either when fs.c gets a lot larger
> or we get more csum functions (and/or they get larger).
> 
> But sure, why not, I can do that on top or send a new version of this patch.

Personally speaking, I'm not a huge fan of a lot of small files/headers.

It makes the include path less clear, and make the path completion 
easier to hit conflicts.
(That's also why I hate the "mode-" prefix in btrfs-progs check/ directory)

The current fs.[ch] is definitely acceptable, thus I'm pretty happy with 
the current move.

Thanks,
Qu

> 
> Thanks.
> 


