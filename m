Return-Path: <linux-btrfs+bounces-10060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7589E3B6D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 14:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D547285C19
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7EE1B983E;
	Wed,  4 Dec 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvjZMTtc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26601BC08B
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319541; cv=none; b=m8QukqSIxtPpVcNwCz+fuIkT0fQwT7RYN7/Xla9Tu7njMKlvthn2UZN/AXd/yA59reqZZ7eVPr7w6yOk8HB2oijR2i7LprO8Zt/TBjW/E7xSOyWoxlGVcqEiLE4Rv2EEtUFQjQGweURInoPswMWa2ppg7Jq6BfzK8rU1QtFiN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319541; c=relaxed/simple;
	bh=cmIwOQ/FLxV6o0Lows7bGBtmBJ2Z2Yyj4qrOgPfNASA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Vz96W6qTEFJpFY02X4FseGD5AIZmhy+lkau7RBOfmORp5EqQ6f3LpU1kTXUjh5c985uwkerB8hh1JJ28EhaUQm28Xem6X9qpiQTbnXiaAuZLxtgraJ2am3jcs4PRA/ck6Oc/QZTYVwAADY10Vg7JDAmbez/xtqNNbD2s7n2KVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvjZMTtc; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d89dc50927so23444306d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2024 05:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733319538; x=1733924338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hx92aOUTdzsO8QesLRdfJIy7w6XWFquv4i5XmmjjM3Y=;
        b=JvjZMTtctB39Ra9vaNqY71P63Q2AoJCiSCDcWLVcjSszqQOVJ6V9CsZWM1/+uDPNus
         OrojAZ4bVWH5aA74bZ2e9V18HwK/j9hCwqiHuaJnnh9qjtNcGvLAYefYnOmNhY91/dBc
         dsKTLJkruxuFOgwevYggOP7e3IdB9kia7C2HXVaZPdcpXWyQTnO3IJeTIAUQxXsSnFri
         7lCmk+Sr5T2RCfX/R2hmHJ4akSi/PTWgcDc2mnWyJZ00NBl8G+TwA4iTGNd6j4CcaEGG
         t4+d9VehfkphL4iNbesOkzApNhjXHtkC+TfbSf0+FjQrtL9PLy/P3X4Y4dTVqSa7YaMV
         JaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319538; x=1733924338;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx92aOUTdzsO8QesLRdfJIy7w6XWFquv4i5XmmjjM3Y=;
        b=IhCCdhXPum+tqwg8jXWEts6nxQd7bLSLQcG7KgccoZeZizRQg6AzjIv+IBey9kKKjY
         C5KEPrVtzTLrnBU9pdx4D/PhTjRkNg1wDKeeNO014x/TXyM5mcDW5LmAB53l2vqrZ7oY
         u0iW6tUMQmANauFykg3KmC49Qbvis270xVkJmaZy7VDYsjhNb48o+bjM6VFlfe0yzDdr
         ONmG5p7XnbuknljYwU7rmpCIGOwdvBk9xKHvrD/d8g+7n7EBszGMo2R0M2YHh66o9nGA
         NHT5yPXeMP0CENeciYKENoYMM9edLjiYEd2mmmJo0L65jMYmkI+6lnmuZcj5j9Ui7vLs
         oiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHUZ+0y+ZQrrtnbJCTEBuddTtxTEjOPp7Md3GAfp/ZqpHBIu2pEa9zviDWNNaXn/126Goirjaam75znA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDU+v6j7v6kbThhS9sPL171Y20aE9oKwNbTecVGLNM9W1xwUt
	LqqkctXlxRj5DRTTIGOtxyCic9OrlDNo60S/aG6rYV72SCkHkPXrFOnYoQ==
X-Gm-Gg: ASbGncs4BDI9Ku9xbF01JT1pBk72xQEQ6LINo/6sEPL9s+sIs7XvSssCXujQKJCGlSP
	it1oreFl6Qm+/SHVcEGe0uqMHfp7l3RYwi2psgP00Jm2klSjtjoX6xQvcWpo17MA/JWD9sgovAa
	LRTL2Nwyo5IgtSykeCyc09h3XKuMMUbwjdyIV+E4VB8qd93VJJDnnT0bbPOnrt+SwB9OamWzX11
	I0ueMd2qqo6jjpdQSgKnneT0+CJr79NN7dD9CENLg0corWfcKa1cxy+StWmTpodbXPox58hCoYA
	JY25GaasQmEBnX6ahyHhxD8Sdg41i7KOD12w
X-Google-Smtp-Source: AGHT+IEcUui9xm4ysmiVsxnWn7mWtrJgMLUjxjkV7sn4S9u+DQqTJgK3IoyCO4KydLETiaBu7XOyJw==
X-Received: by 2002:ad4:5ba9:0:b0:6d8:850a:4d7d with SMTP id 6a1803df08f44-6d8b73318d1mr115388126d6.2.1733319538404;
        Wed, 04 Dec 2024 05:38:58 -0800 (PST)
Received: from ?IPV6:2607:fea8:c1df:ffe5:815c:167b:c62d:6e49? ([2607:fea8:c1df:ffe5:815c:167b:c62d:6e49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d89b158778sm47234046d6.96.2024.12.04.05.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:38:57 -0800 (PST)
Message-ID: <b3ab256f-5b51-46f3-aea3-98f931adf6a7@gmail.com>
Date: Wed, 4 Dec 2024 08:38:57 -0500
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
 <e9544172-ef74-4a65-b14f-8d3addb957d7@gmail.com>
 <3fc16982-4f69-4b78-95c7-35964d6fd1e0@gmx.com>
 <78bb97cd-516a-4647-8866-2a67e9bcdbcd@gmail.com>
Content-Language: fr, en-CA
In-Reply-To: <78bb97cd-516a-4647-8866-2a67e9bcdbcd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> [...]
>>>>> I'm currently running btrfs-progs v6.12 but the balance was originally
>>>>> run on v5.10.1. Is there any way to recover from this or should I just
>>>>> nuke the filesystem and restart from scratch? There's nothing super
>>>>> important on there, it's just going to be annoying to restore from a
>>>>> backup, and I thought it'd be interesting to try to figure out what
>>>>> happened here.
>>>>
>>>> Recommended to run a full memtest before doing anything, just to verify
>>>> if it's really a hardware bitflip.
>>>
>>> I started Memtest86+ ~3.5 hours ago (it's on the 7th pass) based on a
>>> recommendation when I asked in the IRC channel; no errors yet, but I'll
>>> let it run overnight at least and let you know if it fails.
>>
>> Just in case, have you tried memtester?
>>
>> There used to be a AMD SFH driver bug that causes random memory 
>> corruption.
>>
>> Tools like memtest86+ are doing its own EFI payload so that it will
>> detect problems caused by kernel drivers.
>>
>> Anyway, 7 passes already look good enough to me.
>>
>> Then the cause will be much harder to pin down.
> 
> Oh alright! I haven't tried memtester - I'll give it a shot and get back 
> to you. Thanks again!

I let memtester run overnight; it's now at loop 20 and still running.

