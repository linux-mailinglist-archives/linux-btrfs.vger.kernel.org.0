Return-Path: <linux-btrfs+bounces-12303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9CA6304E
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EEE3AB28A
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953782045B8;
	Sat, 15 Mar 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzpc8c7A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB80BA3F
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742057549; cv=none; b=IBxxCrwTDWgO6lVwigIxtYdhbsvpYnlyX9LfoGfQoUgVW2YRyPN0t+uKFfSxW0QpTiXy5Qju5ozwIriIyLj2vWtAPeuDooMeb01ijw/s3bJuZI2iwsiBcqDX8sLIU0w9ZsY5gRaAYsLZYkclUlDa2NOhgPSlrKyeCSMvWL+TIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742057549; c=relaxed/simple;
	bh=cRTlMSgbxjrPD47eXBA/RxfvEiUya3MnGN4AGnC5t+c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rsaEUXg88kp7ZCgjjBOgWEg4y04YswFloJjR3DAGL7iRf9pv5cT0skKnBgqTYWFduW2x7bXw1d8LOWcwVYS3XzB2jNsw60VvoeY7nDGZjechwqa0LXtQ8LFLitw6X4oFazQ3PVjYRw7fcx3OjbNhRjtElpVLLjuEtf/Q4qfA8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzpc8c7A; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476964b2c1dso22309971cf.3
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742057547; x=1742662347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfX9nJaMJrxthrnRA8gCMPbAgB50TaiAtKRcKlnGONw=;
        b=mzpc8c7AFDPjq46V77U3LmBC16yX5XX1ZYeVluILEjVWcw4OM97ELQ+OmOPIjdR5jX
         Y2Ddn93ny9k0J6q2Gc92jlYT1s8auU6KuO/TSv4IWI8WD7ocNP8pcFyNTZYME3YYWq0+
         Elvx6c8Z1lXx4kabVp+BfykRMyWXtZItgmpix22LXf4+/E4zmke3fUpUnnVWpwkAtYmu
         Ib/OfLd5ZxRQDoJjYPqRamBQZ7vuyh0EbPUOFIoPzfHkiopLDuATdbmdaA1pqLPRbFND
         w57LROVivB+sTQB03dwbeyqVzbek+3Kc0nfk7IWEi91WRMDIH9SlTxD6GBhhkB8j1R0t
         dwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742057547; x=1742662347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfX9nJaMJrxthrnRA8gCMPbAgB50TaiAtKRcKlnGONw=;
        b=cdkjTldAsdN3GF78DzGuMPcNDwqFC/9+u9pHRji40ZeO7tcUEgWFrl6zpcE6GouQjF
         prRP9qt8VgtnreAbZuuGHeI4bN96cEW8H2oWZneMfHO+0QPQULQC1ymhXAmkFBfC3SuK
         h7Y3HhG5I0qFGS8BwEZSzW3uGQ+UyRl+W4H5nNly9nHXFgRZnuD+BFQ+uQGejvRDS0xr
         Sk40Vikd5kKqhaKOymRmxr8CE79kbJ+UvHrgjb57RXIGexhXh6QIjQ7bqbVybqibettR
         DTHZ4VOBLPzhN4Aayn36K4fBeEQFdaPjuFZ4mJs2LFaQE4E4RxW7QqbzrAOuN01B6oeJ
         ZW6w==
X-Forwarded-Encrypted: i=1; AJvYcCV+Y6kQDP451wWSEqGqYvQFXk8oXM6a41mZrjyu7/60Pq9ZaB7SPda78wZ10PjdnNWsHQHWjrZwiBqDrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQk/b0VMHERAUsENGNB3zpdEj7KpQ8ZMj9u8SW56qj6x4uIHjB
	55wfya4Fiy1A5tYbEofyy+GZ5bpJfSliFbkdgKw0GQrrTZHhyLonIusraw==
X-Gm-Gg: ASbGncvssJJgVa7nYtxZJnzr3sEp+ft3rXqPM/LrgAqUa+M/OdRBCvz12NnKsVySOYj
	Q/89eLLRVvrlZxJnxfdQgQJALmcVzvAAOtfJZtMPk8WdELPUhboVYA7uWGlqbmGxeY2WmrmNBMO
	W38FwHKUb3l7EEjFsfXffDyX0o49EHkaWsabkEZo4DMxNRKXmdOi2fzm1z6IbIuq3qYE+NnlBDq
	Yc0qTeJm7o+czZoyHfgDjgruKTI/ET1e60zVhym4P66Y7iVJldx5bUHfW1ojwA8PA9U+9FtrsSc
	QTjp8S/o1ioCqcNWf9s6pbyow0Xd0pBs6qpCCiGkzg6VmHQcyddSO6w+PLRNxS/7+/J48Gq+xnp
	jo2LoGB8pNIWZJtFNaBrXq6+6dWg3G/SBiAPz/g==
X-Google-Smtp-Source: AGHT+IEEztBG32Aznq7gzety7XGSjgWFaWPAWo5RVUIzPEZPPGYj85UXaUAd8n9uYIJi7x3m7jJGTw==
X-Received: by 2002:a05:622a:87:b0:476:ad9d:d4f0 with SMTP id d75a77b69052e-476c81d93b3mr89633431cf.48.1742057547031;
        Sat, 15 Mar 2025 09:52:27 -0700 (PDT)
Received: from ?IPV6:2607:fea8:c1df:fdde:408c:8ea3:cc7:5898? ([2607:fea8:c1df:fdde:408c:8ea3:cc7:5898])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb7f3d6asm35819971cf.55.2025.03.15.09.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 09:52:26 -0700 (PDT)
Message-ID: <6a2ea224-48ed-49f6-88d3-10d5ec7c79a6@gmail.com>
Date: Sat, 15 Mar 2025 12:52:27 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
From: Nicolas Gnyra <nicolas.gnyra@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
 <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
 <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
Content-Language: fr, en-CA
In-Reply-To: <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 2025-01-29 à 14:33, Nicolas Gnyra a écrit :
> Le 2024-12-03 à 21:50, Qu Wenruo a écrit :
>>
>>
>> 在 2024/12/4 10:32, Nicolas Gnyra 写道:
>>> Hi all,
>>>
>>> I seem to have messed up my btrfs filesystem after adding a new (3rd)
>>> drive and running `btrfs balance start -dconvert=raid5 -
>>> mconvert=raid1c3 /path/to/mount`. It ran for a while and I thought it
>>> had finished successfully but after a reboot it's stuck mounting as
>>> read-only. I seemingly am able to mount it as read/write if I add `-o
>>> skip_balance` but if I try to write to it, it locks up again. I managed
>>> to run a scrub in this state but it found no errors.
>>>
>>> Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd,
>>> UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)
>>
>> The dmesg shows the problem very straightforward:
>>
>>    item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
>>      extent refs 1 gen 84178 flags 1
>>      ref#0: shared data backref parent 32399126528000 count 0 <<<
>>      ref#1: shared data backref parent 31808973717504 count 1
>>
>> Notice the count number, it should never be 0, as if one ref goes zero
>> it should be removed from the extent item.
>>
>> I believe the correct value should just be 1, and 0 -> 1 is also
>> possibly an indicator of hardware runtime bitflip.
>>
>> This is a new corner case we have never seen, thus I'll send a new patch
>> to handle such case in tree-checker.
>>
>>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>>> `btrfs check --repair` (ran after a discussion in Libera Chat, failed):
>>> https://pastebin.com/BGLSx6GM
>>
>> In theory, btrfs should be able to repair this particular error,
>> but the error message seems to indicate ENOSPC, meaning there is not
>> enough space for metadata at least.
> 
> I finally had some time to try out a version of the kernel with your fix 
> (built locally from commit 0afd22092df4d3473569c197e317f91face7e51b) and 
> I can now see the modified error message (see new dmesg contents: 
> https://pastebin.com/t7J5TJ0Z). Unfortunately, apart from that, 
> behaviour seems to be identical to before. `btrfs check --repair` still 
> fails in the exact same way. Is this expected? For some reason I had 
> assumed your change would fix it, but I had forgotten this mention of 
> ENOSPC so is there any chance of getting back into a writable state or 
> should I just reformat the drives?

Just wanted to check in one last time before formatting the drives. Is 
there any chance of recovery here? I just tried with kernel v6.14-rc6 
(80e54e8) and the latest btrfs-progs from GitHub as of writing (721df6f 
on the devel branch) but I'm still getting the same error with `btrfs 
check --repair`.

>>> I'm currently running btrfs-progs v6.12 but the balance was originally
>>> run on v5.10.1. Is there any way to recover from this or should I just
>>> nuke the filesystem and restart from scratch? There's nothing super
>>> important on there, it's just going to be annoying to restore from a
>>> backup, and I thought it'd be interesting to try to figure out what
>>> happened here.
>>
>> Recommended to run a full memtest before doing anything, just to verify
>> if it's really a hardware bitflip.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks!
>>>
>>
> 


