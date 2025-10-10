Return-Path: <linux-btrfs+bounces-17635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA4BCE8CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 22:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0495453E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55956302750;
	Fri, 10 Oct 2025 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXgGA8v6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927125A32E
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129244; cv=none; b=SnaCGrZaLMQp7OPg3QAFpUTLteV6uoKd0HTUsmn84e9JvN+iInpsUFrDxFmxuRpE/rylFslk6i2R7nJgsKJBxrNnKZRy3c2DPcU0zoMIwr8u7XqiBbLFlrKBbC3THMkDf4LOdle3Y1AMkug4jOsOkBZUVPPholYKaEHaYieOC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129244; c=relaxed/simple;
	bh=qPRKzLVIbSw1eB6Ie5OFJGPHlPCjzK37kb8uFwy5awQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RO75+DpR8e6+Mx3Lqjs+ijXIYZiTS0E4f2zBUsZfelHge2vjYAqaaT+SFoINoqCYSKnv/5nptrcxDzILwOIri/JbmcZU8/VMBoUGUtc3V1+JlXzpXDuW94pekOOgg2md+sdTcJYs/l66yCGm1J64YnxjeWjwXXPqjNGMSrrZSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXgGA8v6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso18558595e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760129240; x=1760734040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eyWI6TBeQ9qIDT1vlS8ACDW11lp60v7/lVrkvBWhWjY=;
        b=dXgGA8v6IYvTNXlQjn8RujtcYXpCDbwbd6QOaVJfKw2fG+cCcSWlqLSIuX8FF1iu2q
         HnFNUK5Nljtk2hh73t8CPXgXlcgMq4W6JVFgYOm+2RZyBiNnS8nsPPvxpq6B4ITio6vI
         rj6sYzW9XqXCJkJ8BPyDTBpbP5bLgnJahbzE4a0qnkJfPgxeVFQLrSARqpas2B/qnxxT
         VcmqWnARiNovjFsvpPeiD+xIBLWoQdFaVxtsV2MU82yfsULlIPLnkvJLQKdXbrEkhlXG
         BSH8DvL5ah3WRAnnnGfUS+BTI6XdwQseCGw5dLkXuXOqv0rDJdMHCI7D4PwKspbtSLwp
         9Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760129240; x=1760734040;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyWI6TBeQ9qIDT1vlS8ACDW11lp60v7/lVrkvBWhWjY=;
        b=J71LQDh/1pcbis/Ekr9R66IetgfH/je4Zy4Ybyz7pHdNLxpBRQwLK+8tiNh/LS0xEN
         xvce3gqUVnZxFBGFkfys3WqiorV6YAs4g8bL7J6FayZA9vsT6Bd3gaA1sLHTbPhzlU+t
         ZYrSMQlC7QZrrSEAYTHYX5rM15c7qCia3BxenYpv0PuXD4wA/RzYW5ICVGlhXBeQEEdx
         wb3YcJfiu5x7Usi7oEJWEfplFsmNAMx0ks8dGC8oDVvZhNtXXLVvKzXkaV9E+9kvKOrk
         vqNOqAFYacgkWfKouqMVgvqkCVsqPTL+qZ+IesZYjtFkS98FlJEY+CJqu/pzm4erOL6I
         4EhA==
X-Forwarded-Encrypted: i=1; AJvYcCXphE94x+S7aXt2AM/9hwM+I/z5Tteuy7eV9XZtSZdEXq80kau9CO7hkrYWoHYWwqc3mP4lMGWGRETc3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAuaMjVEabUPXMvjUP8KXqEhOGrnp6qq1yFuVUR3eSWJUEKD4Q
	Dc3kjnr9M1xolSDgN0KYFV9DjSMHodu3CsdCJeFVNVE3msu7vuPyB5wMy7h5Ilz/NoJJ+JzuzWm
	9sLbo
X-Gm-Gg: ASbGnct1EzuJ2zS+Ge3wpxVXjkca9+s/q0ya4VOn5Vh5yJ9pt7cEKMPhi58+ksmc6NZ
	X63X2k1GUwLTzpeeodD+JA7mRO5wF8FnNUSJPPW+p8M7+tnAZNtQyO4ThGn2VSYhfaE3MpTnkoc
	44GnsgcNRE9FN3DqQ59zD6bnrMHi3RS++VQSulr0A1q9/HCY4SPaSwjQOzWeYYJmdSOcllU1zye
	lWz3wAI0e4LpQekYns2vGtnMK1jZUFOpkW8tahNFf+rYHz2XXsyHHpGoBbLgr7sWjejf148PYN0
	TAut2g9eIfLckUiTprdKyyREbpusz65+ISUCJfk6047qU89SUXB9UYPGnpSGES4lJoMByMOCf5d
	w5f5P+VxoMcVzDGugiTXisZsUQy95iBxH0U7KI9Am4vlvCxu2IaZLF8CbD+J9uBpncZaEevSQ+c
	1WPLml
X-Google-Smtp-Source: AGHT+IEy8jjFjvkJeuDxefYt3nhRouGHj/2XwyUwUwPdfoUlIbtWyj0zIRB5iCMjfYPVGO1lpaHpHg==
X-Received: by 2002:a5d:5d85:0:b0:3ee:155e:f61f with SMTP id ffacd0b85a97d-42666ac6188mr6469658f8f.8.1760129239990;
        Fri, 10 Oct 2025 13:47:19 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992db864c7sm3829752b3a.82.2025.10.10.13.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 13:47:19 -0700 (PDT)
Message-ID: <ebeebd7b-4075-4b30-b40f-ff8f218b52cd@suse.com>
Date: Sat, 11 Oct 2025 07:17:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trying to tackle https://github.com/kdave/btrfs-progs/issues/541
To: =?UTF-8?Q?Ra=C3=BAl_S=C3=A1nchez_Siles?= <rasasi78@mailbox.org>,
 linux-btrfs@vger.kernel.org
References: <2800637.mvXUDI8C0e@prox>
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
In-Reply-To: <2800637.mvXUDI8C0e@prox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/10 19:25, Raúl Sánchez Siles 写道:
> Hello!
> 
> After a mount error "parent transid verify failed" I went to offline check the
> partition and I came accross this issue. After this, I backup all data I
> could get from the partition (via btrs restore). As a sidenote I also tried
> mounting with the rescue=usebackuproot with the same outcome.
> 
> Currently I have a reproducible scenario to look into the issue and provided
> lack of activity in the issue I thought I may be of help to provide more
> information so issue can be fixed. The btrfs consistency issue looks serious
> so even in case of successful debugging I don't expect to recover access to
> that partition.
> 
> OS and SW:
> 
> - Debian sid
> - btrfs-progs 6.17
> - linux 6.16.11
> 
> Mount error:
> [  120.652356] BTRFS: device fsid 06dc5f24-a16f-4520-993a-xxxxxxxxxxxx devid
> 1 transid 968758 /dev/sda3 (8:3) scanned by pool-2 (4449)
> [  120.653973] BTRFS info (device sda3): first mount of filesystem 06dc5f24-
> a16f-4520-993a-xxxxxxxxxxxx
> [  120.653994] BTRFS info (device sda3): using crc32c (crc32c-x86) checksum
> algorithm
> [  123.225415] BTRFS info (device sda3): start tree-log replay
> [  123.523786] BTRFS error (device sda3): parent transid verify failed on
> logical 229603573760 mirror 1 wanted 968173 found 966625
> [  123.538334] BTRFS error (device sda3): parent transid verify failed on
> logical 229603573760 mirror 2 wanted 968173 found 966625

Extent tree corruption, metadata COW is broken.

It looks like some writes are lost. Btrfs check should report the same 
problem.

It is not log tree causing the bug.

I'd recommend posting the device model and check if there is any known 
report with transid mismatch.

Sometimes you can not really just trust their firmwares.

Thanks,
Qu

> [  123.538372] BTRFS error (device sda3): failed to run delayed ref for
> logical 487464960 num_bytes 4096 type 184 action 1 ref_mod 1: -5
> [  123.538383] BTRFS error (device sda3 state A): Transaction aborted (error
> -5)
> [  123.538387] BTRFS: error (device sda3 state A) in
> btrfs_run_delayed_refs:2159: errno=-5 IO failure
> [  123.538395] BTRFS: error (device sda3 state EA) in btrfs_replay_log:2094:
> errno=-5 IO failure (Failed to recover log tree)
> [  123.544693] BTRFS error (device sda3 state EA): open_ctree failed: -5
> 
> Please CC me as I'm not subscribed to the list.
> 
>    Best Regards,


