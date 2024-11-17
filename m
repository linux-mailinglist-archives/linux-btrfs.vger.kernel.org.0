Return-Path: <linux-btrfs+bounces-9741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A89D0661
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Nov 2024 22:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758402823AF
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Nov 2024 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB22C1DDA3D;
	Sun, 17 Nov 2024 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omm8epi2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219484A4E
	for <linux-btrfs@vger.kernel.org>; Sun, 17 Nov 2024 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731880155; cv=none; b=amq6be3WEb9Ub/zDHlnd2b16dZGky9ya1eF5Zcrf5Z5SuxpVN/NPTm0SKxWRGRWqXmTRA4/1moeQPuUm7kT4v1aVnvgoLlEZRfuDBOZQgXcZAlp9b8L5Q3Q2wah8X5rbhiglVt6+67fPF6xPX8zC5lvmXtOV/u3lVhoBi5sFoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731880155; c=relaxed/simple;
	bh=lDWYhpIccA4ViRszl6U3K9fjUH5k9+jwICH9eAPfsmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GgCWEcSOyG2/a7aesIaaG+ivN5NcAeSwivWQlEbubmB1XBF+RzY+BPGJ5XyzwNeG4lQhniBMGINgtrZI1VacqTZnRIw5W81+vZMYZBDA7rfhHPBFUbI37qjXrVd3olNflwiAY5oVJybc47W5dZJ3d34SfkN+GKUzJ8RD2lDBs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omm8epi2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f646ff1bso549172466b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Nov 2024 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731880152; x=1732484952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFkbcGW5W8Z2qPmmjCeAPuPc1hDJ2gnH7p0medL2XVs=;
        b=Omm8epi20dawMDFVFROPAwjGXlTMrh5Ly58hapgfzS3RpIlDklvGEXUu1q9X1zpKUi
         JnhACgWotdmgrj2Hwey9TFlHtqxllLsxG65C+SaZVK2vxLo1dGfiMG8erU9gje0EMpMy
         M9qViQFMe+jId03m6TxB9daW/zhQwrzXi8bBc2CkrtHtsSCCqgESlWQIWzmTHwCCWddX
         CxZ8WgI7D7OpAzft9qMZqqnW3Jww1v4bDPEODBDHoMfy5bVc0aaS9bEhQebfzehYevmR
         ty065H7YKwQ7W3VWw/xmcI0JUAfc+Cy0JIlGpB/pTVpL7nr/MHHQXyY2Wk/w2phGhDyF
         Z0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731880152; x=1732484952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFkbcGW5W8Z2qPmmjCeAPuPc1hDJ2gnH7p0medL2XVs=;
        b=lLWe7BjvQZhII21ZMubBLAWIIv84Z5fmSENjSFMyhpyODPacRfcuQwWVJUyLtIhm/F
         5Sxny2dP27NyWrKjrT4lR0/mpLZU6kBZwTlCGE+OxaOuydvmqVYkNTiEn0DzUZ+buxJo
         XzQNt88f3trMPmwbvUBSfcOCTCMCBzitotidMFQFWTAUWffHinNIuxf3CRrx7jiDaEm+
         RqTZWpBn4rs0AzPWP9VdRzHa0phC69LyyjNeQFsa1pLaRhcLwC5m99inHsBCvRYuB3iU
         B30EI1TFn2jl4+kwUNg1a1QxpPYHOcNh3d8KOorVW98rh1G/Dto++fuKNfvE/ccI4fLv
         lzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEabdH3Gjx+J8Z2PYITNZwrfO7KU2Ph5olRo3huzdUZn2JG0xgDYCvSlcv6x6cU6CadM7POwubJ3+sJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG25cs/tAf9qNnDMjJ1k97zGYflXcKGkuTvR531mjhWvoLrL/8
	lZQWa4rjEqRJcd+GyxcXw4kS4a1u5CkF5B2pFpxVYyicEIRuCAQ/
X-Google-Smtp-Source: AGHT+IE1OPe4oNIDJi+MmeHTlw3D/4EA2gDLaobD/LikGUh6LnlMR7jGL2Wl4AmFt4jg8vmbw0ORAw==
X-Received: by 2002:a17:907:74c:b0:a9e:b378:6c13 with SMTP id a640c23a62f3a-aa48340ff04mr1113846166b.17.1731880151585;
        Sun, 17 Nov 2024 13:49:11 -0800 (PST)
Received: from [192.168.10.194] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd736sm458658966b.118.2024.11.17.13.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 13:49:10 -0800 (PST)
Message-ID: <770176d3-f1e6-46d5-8025-24610843be81@gmail.com>
Date: Sun, 17 Nov 2024 22:49:09 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs scrub results in kernel oops does not proceed and cannot be
 canceled
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <e4e79b2b-ebca-4ca2-a028-084a6dfcb3e8@gmail.com>
 <931d4609-6ad9-4232-a930-4c6866434a10@gmx.com>
From: Sergio Callegari <sergio.callegari@gmail.com>
Content-Language: en-US, it-IT
In-Reply-To: <931d4609-6ad9-4232-a930-4c6866434a10@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the answer!

On 14/11/2024 21:20, Qu Wenruo wrote:
> 
> Dmesg please, for the regular mount (without rescue options) and the
> scrub oops (with rescue options).

Thought I had saved it, but in the restlessness of trying to put the 
machine back in a condition to let me finish work, I ended up messing 
it. My bad.

> 
> And I'm guess it's an extent/csum tree corruption, that caused some
> btrfs_root_node() failure.
> 
> This patch should solve it:
> 
> https://lore.kernel.org/linux-btrfs/20241025045553.2012160-1- 
> lizhi.xu@windriver.com/
> 
Is it already in some stable kernel? Was it a regression or something 
that was just recently discovered?

>> - The scrub does not seem to progress (calling it with status).
>> - The scrub cannot be canceled.

Mouting read only with the `rescue=` option let me get some access to 
the filesystem content and helped me recover some of the data. Other 
data was recovered from a backup that, unfortunately, was not very recent.

What seems strange is that if the filesystem can be mounted it cannot be 
scrubbed.

I have a questions, if you are so kind to answer:

- mounting in rescue mode I have apparently lost all the files at the 
top of my subvolumes (some disappeared altogether, other appeared with 
zero length). The stuff inside the directories that survived seems to be 
there. Can I trust these files to be correct? Are there checksums in 
place, so I would have seen errors if they were not?

> 
> Yes, I do not think it's the driver.
> When hibernation and suspension is involved, things can get tricky.
> (From ACPI bugs to btrfs bugs)

My swap (for hibernation) was not a file in btrfs, but a separate 
partition. Can this make any difference?

> Thus my personal experience is, just do not utilize them.

Hard not to use hibernation with laptops that only sleep to hidle, so 
that the battery charge ends up while sleeping and you get an unclean 
shutdown whenever you leave the laptop alone for more than 12 hours.

And to switch off the laptop is a pain with full disk encryption and 
grub taking ages to unlock the encrypted device...

I'll try to back up more often...

Thanks
Sergio


