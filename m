Return-Path: <linux-btrfs+bounces-10724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F031A01718
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 23:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B5B1884372
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 22:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377221D6193;
	Sat,  4 Jan 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D+cPWW5A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FA1CCB4A
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2025 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029572; cv=none; b=WCSq7op+gT668oIG6MFsy0fs/CXI2TuoewDvvu81kVGuCPpFcSvBMF2y/nr4FF1E0XI3tjtSPSPe60OavFNb/JAwAwHsq1Jbn6RtWZnyCDkb48VGGgYmVGshhnaxWNiQA/SaE296OVEuchw9lI4Sb0pZkebYzC3317D7sEeTnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029572; c=relaxed/simple;
	bh=KlVrK1UPE0bO8ZcdDnO1nlKEZ52pSE5UKE1Lmb83cKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcUgs8VzIbcBI2k7pPgZFaHQWLFnKUD186K5OSnuqzNRD0pFFYupZk3iEdnE4VRS9VI5DPQJhuChtUFzcGc7RdZWYOGAlkhC8B78BTP7PPtNiwirB7w0rp+pBUz3q6DQ4lm1G/3BjOSpnC+aARJc2KlNfIcr6+f3XUy8zPyDGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D+cPWW5A; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aabfb33aff8so2355925466b.0
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jan 2025 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736029567; x=1736634367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBf9P9zvXMPVyWVronF99WIkLNwHXFGd5g84HO70P90=;
        b=D+cPWW5AYpnmFnKipgSxCt91QiGjyffoLNgoSQLO/HpMmqAQEHoeeRUNAF+N3/q1Gt
         jgQMaCl/7ksxFpeBVBUkDaQnCxZvyg0YnqgoFLNSk5c6dEEb5qIIYeoVZlk84BM9ipOO
         leJSugY+qqc4XmLlCefKOOw/xQe/eYzd7G7ES9Ll6XgOPPlvYXSwqZhkEu3mXWIJJ1OR
         lrM9I9wex5eLwz+pTaIDv5VZ3grHHZxJrZcAQYeXFj101mrrJU8sFXpZtersfwMdvGtS
         Ra4dGqZF81U9Q6fFfnBM+ra+DUBZTBkFhfsy/rSazqT52eXQde0zWaRFwOCFDvfhFXjU
         pfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736029567; x=1736634367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBf9P9zvXMPVyWVronF99WIkLNwHXFGd5g84HO70P90=;
        b=kTuzmpyFjFXQsTPIVgWeR8mG9bTqIs+s2/uL/LMO//juMEuCTZ2xE0tT9+VtLCQg8X
         tBR24V4m0MsIL1DHZMHeA97ue5yNc94uhZ3RfkF6McUV1kJzTJBEoRbg2OTdfy6qy4iD
         rOFB9lyYPSZgJDC/s0p/cqRX0akoFryBi7TRCmtSrL8ieWIvC8cid5xdmMb4V0UEHXgW
         cdXZTsxFp66Mz+zitM7KXKYm7b0BJLrACPhd1kp4JJcuuE4r2fLEreC333XCpOwgQ0vS
         G2n2iqLCqNpL+D8ZO17U49JYQKNjNbRhck8hxmqqx5UnQrUqa5i3w1bMXdkBhhrmG0OL
         LFNg==
X-Forwarded-Encrypted: i=1; AJvYcCW8IQxeeHSqJmOYmENO4gsfV9VH/VF2KBYcYLd211Kyjwczaz+LQklkyeMAWrsgAcUDVROyOybbEmDjSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8HaaAzCdiSw/3ToE4pxX/wKZyxqORPCSC4UjTQsw0uS2AZ0J
	sywxSAhqMsyZ4hmr4o8NolYopyojxuXsl+/jMRH5YGB1Vb3+CqylqigQjfCzCMA=
X-Gm-Gg: ASbGncsJRjZpmMMKy0ft8m0diCpd2uMS55OmXB/gxjhgw5+LLwfJuxFEb2Qhq3vydq8
	pukXoBJjQ5b+J+FRUPy+XcRxk6f3nNzpLiFUuFhG2pouqSFJLMmnqA4WXXfIp0sN5Q7K2ivoTOW
	M9DTJVi0uk04DSz0syjgF14yFp5vAcaKOguiJYohmKDykyw1l1KXpcd+QYChskdXZnDn9leB0nb
	S2FI8po2EfYDeRVriKj3ouUpmZu/RC3w0ZnDwxRp9HP+RVvFKSDXJvocuKhdc4rwdeiuf3Xj+QH
	KmW4/tFV
X-Google-Smtp-Source: AGHT+IHfx1U0+mQs8Qj9lCWF1G/HgYikPL6TOeoQOqKFm5i0c0UCxESUiPWYhDohECQNzuDBr+qD0A==
X-Received: by 2002:a17:907:3f0b:b0:aab:daed:9ee9 with SMTP id a640c23a62f3a-aac080fe50bmr5435499666b.6.1736029566994;
        Sat, 04 Jan 2025 14:26:06 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7312sm264790635ad.225.2025.01.04.14.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 14:26:06 -0800 (PST)
Message-ID: <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
Date: Sun, 5 Jan 2025 08:56:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mnt_list corruption triggered during btrfs/326
To: Christian Brauner <brauner@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
 <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner>
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
In-Reply-To: <20250104-gockel-zeitdokument-59fe0ff5b509@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/4 21:56, Christian Brauner 写道:
> On Wed, Jan 01, 2025 at 07:05:10AM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2024/12/30 19:59, Qu Wenruo 写道:
>>> Hi,
>>>
>>> Although I know it's triggered from btrfs, but the mnt_list handling is
>>> out of btrfs' control, so I'm here asking for some help.
> 
> Thanks for the report.
> 
>>>
>>> [BUG]
>>> With CONFIG_DEBUG_LIST and CONFIG_BUG_ON_DATA_CORRUPTION, and an
>>> upstream 6.13-rc kernel, which has commit 951a3f59d268 ("btrfs: fix
>>> mount failure due to remount races"), I can hit the following crash,
>>> with varied frequency (from 1/4 to hundreds runs no crash):
>>
>> There is also another WARNING triggered, without btrfs callback involved
>> at all:
>>
>> [  192.688671] ------------[ cut here ]------------
>> [  192.690016] WARNING: CPU: 3 PID: 59747 at fs/mount.h:150
> 
> This would indicate that move_from_ns() was called on a mount that isn't
> attached to a mount namespace (anymore or never has).
> 
> Here's it's particularly peculiar because it looks like the warning is
> caused by calling move_from_ns() when moving a mount from an anonymous
> mount namespace in attach_recursive_mnt().
> 
> Can you please try and reproduce this with
> commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
> from the vfs-6.14.mount branch in
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git ?
> 

After the initial 1000 runs (with 951a3f59d268 ("btrfs: fix mount 
failure due to remount races") cherry picked, or it won't pass that test 
case), there is no crash nor warning so far.

It's already the best run so far, but I'll keep it running for another 
day or so just to be extra safe.

So I guess the offending commit is 2eea9ce4310d ("mounts: keep list of 
mounts in an rbtree")?
Putting a list and rb_tree into a union indeed seems a little dangerous, 
sorry I didn't notice that earlier, but my vmcore indeed show a 
seemingly valid mnt_node (color = 1, both left/right are NULL).

Thanks a lot for the fix, and it's really a huge relief that it's not 
something inside btrfs causing the bug.

Thanks,
Qu

[...]
>>>
>>> The only caller doesn't hold @mount_lock is iterate_mounts() but that's
>>> only called from audit, and I'm not sure if audit is even involved in
>>> this case.
> 
> This is fine as audit creates a private copy of the mount tree it is
> interested in. The mount tree is not visible to other callers anymore.
> 
>>>
>>> So I ran out of ideas why this mnt_list can even happen.
>>>
>>> Even if it's some btrfs' abuse, all mnt_list users are properly
>>> protected thus it should not lead to such list corruption.
>>>
>>> Any advice would be appreciated.
>>>
>>> Thanks,
>>> Qu
>>>
>>
> 


