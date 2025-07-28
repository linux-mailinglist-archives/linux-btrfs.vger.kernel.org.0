Return-Path: <linux-btrfs+bounces-15713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88381B1392A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C037173025
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BA24A061;
	Mon, 28 Jul 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UUaeSnao"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7081D6AA
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699462; cv=none; b=NgDeyQ9DnfKnWU+DOlWaR/ks3Cv7Mrk0izfV4ElTMaJ1c37QoCf7ZJs3p05YaXymdc8EWHweYy/G8vZgdlZwny5Gzko0yvypUslPxxHww+dhRQOuXs5+OaqYkrps9JG9mJdQc8CflaECBKERiNsxiZlxa0Gg1OzT5HWwcMsJZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699462; c=relaxed/simple;
	bh=a68dC2IX5RZYA7JVsZSDy7V2bCDDXQ+0qW4mqbUTXe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QgoYD0qReh/L9uBhOdvsE5VfYqOdDfTcCymNXyb3GHcSRHnJ8dSrcYv0ddDe/fAop7lQ366X9Yd91W6RmuNIf1R6ayKo/iOQUDNyZSl2W1AU+ovDe84dU/lcyCxOVNvu4WHIxJNYypph6MYDXkgWL9lveW7l1wb1F/YiURXF9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UUaeSnao; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b78bca0890so189955f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753699458; x=1754304258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AQi3D0BOdiwNH4O7hK3zflxmgiJZgaFAAv8Hugio95o=;
        b=UUaeSnaotH6K52Nio2Yd5Onz1mc82Ds99W6SKr3RsCGo2Bb5RSS0ckWMup4/EGoz7A
         AkMgE4IYboiW67VcsqnJLPT5i0p0mtd5Ga2vOVmRjhhlt3Vv9NCUFbZZIWE9eBdQ8PNA
         yFeZPo8c+7yvbJcFSNi5YFnfGbv5kug6r7BeLEDkxA0Rwtq1ZHUbLfo5QtgZiLqP/scN
         Up/wNpiUpbJ4KfjYVXY9XipuR1/PXtazVDyZlqV/ZNz866Fk4dGfZ52fsgP1PVfLMIQt
         /tt8cGK92U3Cki2Rd6fXeeI8dnql45PQHZbFGsAsH8r8dnoL4+UJJ5+wdKymDLX6sivG
         PUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753699458; x=1754304258;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQi3D0BOdiwNH4O7hK3zflxmgiJZgaFAAv8Hugio95o=;
        b=PrILQYWfk1lB+o5u5WqGMPLuLHcr0yerqanfy+kdUKfY5hQo3TmoHrtyRZXtneDWtq
         XoGG2Sjy9wENF/S32KZ4RIKk001P78DKd3wKpXY32fr1/aDISakUozaAKq9kpUFS24LT
         Zu1dJ053noErtSwj+v+Z3WpSMxiddK1vybewdCmKKAmlhHuLxa3MPB5iIZpddjsfMSPQ
         jcgRXWxzrLltfmnRhyWSbmYahgn5TIGt/iB60OXViGJo3pqvPZoJNN7JNyjugugVNa+/
         PpAZ1wKxE04b83vwo0Pi2Q7HuUIsksrtlhOvok1yhVExwOBPeAj08TASoUZDvkzFJzl9
         VOHw==
X-Gm-Message-State: AOJu0Yz6HCFMBSi1K9nICGWhRWJL+fslHoVLeZVRh5/fdNxGBvxqN8KH
	6Ox3DoNIvuaxc/5lgxmhL2sj4beN11IURjSpqIhgsEdFJVOqtWTMwU+nc3KMayMs65RCNtHQ+4f
	Gk7FG
X-Gm-Gg: ASbGncvw2Lltm3hBHib6l4eqY70SWb96UtrdkEQKUVnVwRlaDhWN0a1XrcCZENUKJ2Y
	jB7OImRL6cKF0fIGDtA1fBAVi5p6c5PF6uSKeO6SnWYTZjJVhdBeiQ9esW5w9SDznhzzWwL4tzh
	z9zRUtsMDZLCzWrkvykVOVWK1gCEqDPH8Zwk3hyl0aYaW0hZhxKAyyGo3r76zERtQuzVHLVdqbS
	nkjhIT5dUkAaP1HAW53W4kfjiwHDC9sR0FErMtRVDQRiFtGDLZLqtjFiK2fPQ6J1QzNZpszc4Zb
	3Z6NBC4Ss01kSBK/i5UA6CBidsTAHNcYjZ/2C6xLq0RY9P0De0deTtwa5fynOcSjfqpvTjQWJ0u
	Rk6lnVrP5h/phjT8zpqLRKKpVcFsBUqMsYtuMauduGYiA+7WA9WNFlfQaxkmL
X-Google-Smtp-Source: AGHT+IEtIiJ41reXLFCk7CoFIT8yNe/+mOZd+j0LlzrV1QWrmTmc5stNjbFP5X2jbRf7XwUfIgdLHQ==
X-Received: by 2002:a05:6000:2284:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3b77675ff55mr8608562f8f.36.1753699458034;
        Mon, 28 Jul 2025 03:44:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe571756sm51980015ad.195.2025.07.28.03.44.16
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 03:44:17 -0700 (PDT)
Message-ID: <2099a2c0-2977-4ecb-8276-a878fe17ab24@suse.com>
Date: Mon, 28 Jul 2025 20:14:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cannot read default subvolume id?
To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250727174618.GD842273@tik.uni-stuttgart.de>
 <d738f9b1-2717-4524-b5de-3c5636351b44@suse.com>
 <20250728100845.GE842273@tik.uni-stuttgart.de>
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
In-Reply-To: <20250728100845.GE842273@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/28 19:38, Ulli Horlacher 写道:
> On Mon 2025-07-28 (08:06), Qu Wenruo wrote:
>>
>>
>> åš 2025/7/28 03:16, Ulli Horlacher åé":
>>
>>>
>>> Why is there a "cannot read default subvolume id"?
>>>
>>> tux@quak:~: btrfs sub create xx
>>> Create subvolume './xx'
>>>
>>> tux@quak:~: btrfs sub del xx
>>> WARNING: cannot read default subvolume id: Operation not permitted
>>
>> It's a warning, not an error. And you can see on the next line, the
>> deletion happened without any problem.
> 
> But this warning confuses a user:
> Is there a problem?
> What is going wrong?
> Have I made a mistake?

Yes, that's indeed confusing, and it should be hidden by commit 
0e66228959c4 ("btrfs-progs: subvol delete: hide a warning on an 
unprivileged delete"), which is included in v5.16.

Unfortunately that fix has a bug that the uid check is completely 
opposite...
> 
>> You're running as a non-root user, meanwhile default subvolume id search
>> is done using tree search ioctl, which require root privilege.
> 
> Why is this subvolume id search necessary for subvolume deletion and why
> is it just a warning and apparently no problem at all?
> If it does not have any consequences, it should not be displayed.
> 

It is an extra check to output a more meaningful error message if the 
end user is trying to delete the default subvolume.

Thus we need to search if the current subvolume is a default one.

Thanks,
Qu

