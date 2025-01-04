Return-Path: <linux-btrfs+bounces-10719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0012A0128F
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 06:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF9A16418D
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 05:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78614831C;
	Sat,  4 Jan 2025 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz/GQo/B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBC17C69
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2025 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735968750; cv=none; b=sJczlCLHCvG5F/L/Y1NtqT1VBVnULIDa7kSKM0OsaJe+3mTTBUk2qC/WPFrjWgDAKVZOmP7yeDXVAR1X5cnnh6YMkHjELlLDBAgj+HQO1BtcRuvDG8ahdfYt5zXn8gJjF9oMWCQntQKql0ADpuTkFF3OLqrH5OywXTzsJyNUQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735968750; c=relaxed/simple;
	bh=D7ivjbT4d7MF118LHuSSXzi26v2O+6O9TX3X5rLyqJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uUuInZ1Y3OoXTKB50JDb2+6CrUz1Q8Kfc9oYJRtQDHF/GNniQjOYzXxT1OD4AVEpWl8muhx8EUztw9Sq8T4hE6O1DiUbWvUf5IQjpZUKeL1NetmiiRimxaPUM6L+HXnTeKq2794lqOPtgwCxb+jyEvHTCOTJKwUy3cbgvww+R2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz/GQo/B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd730so92019875e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 21:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735968745; x=1736573545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSTwWfSuXqfE01O2RfzHk2Sya4G8g4JV2FSNTFqe08E=;
        b=Yz/GQo/BBR/cCl3TdVNpw/g7m+12dIDIIepmhbVw66vFbdA+gt2WGuYzWmtVlROsRQ
         9rgPd/nyDwGMev78GfaP8oAnwJOGby1PrBArTqIpLY1IKHISd/Gl2FuQFo3bIKPdOx8/
         htTd72nrGssoyLlyQEshc6V2ORTZZBkow+aCmoe8r0oeKaTGyrnUXo0zQfDd3FEQWzkZ
         BBDBVzVJkbFYHYizfU1xazsoEamkXhsZ7KZTCX/p/iGnU039Ny34Yg0KfGpYfVGEBRN3
         TSBxIdZdxoKDXXsd7KxLwj1S3/T2+elrWyEq+vzZsdsy9Qb2uqN7BN6fGSGP01DNMSLT
         tqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735968745; x=1736573545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSTwWfSuXqfE01O2RfzHk2Sya4G8g4JV2FSNTFqe08E=;
        b=YBsQRkBATap8RVteBgyEjsTmf80C9md1OD6gVxZq87ymmPyKx+gMkQperXl4Ra8dYn
         73cFUDN+nMnq6WpFS6hv8qNY5mIAl4QI0iPp/MoME+Y1IkZoGi5p//dsx7tbEF63aMsy
         ABHBcw2FLc+UN/BgiEdiufRcSfJNlr+wTJ83gotD7IDB+H5+FrHwx7sCL/k05m6t3MAV
         0oh8vgaDYwpL6VybjMxefHho3A9DO4HssQA2VWwYWP8yz63sA1K1aOva7U28AGOLiILZ
         mgHC4feqWxhVx2NEKj1+zcW0BHscZERSNRWlDYYBEnOBMUasua2/MlUEnJSnwHORGL8Z
         raUA==
X-Forwarded-Encrypted: i=1; AJvYcCUnt98v1Kk7qA/4p3blOOg3uU5XRnwhVpylkwtPj8OoX98hR9nGOYqMyiENCvLK3dJCwMsgYBoO08wXYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMadHEu3x8CTRTFPat//GASalC4Z4E5ZRO1wswgrRsYdgmUfkv
	I987iWpN4NMl5STb7L1/8KL0AbPXBDxYZSBo2WSdqZTsA8IZ7DXbLIgi7Q==
X-Gm-Gg: ASbGncvNBzB01rDTEyi2aYHdVt+j5WhNjwkPDgiX02Q99xNzjh21YnOjIS6o/smFKt7
	H0BmQhUZEmc4Y/9QIET06uc3tW/9Zasrv3ZYB/Rugm39BPPUmHNjmuQxMjow9Xbv3fg59NgI+CJ
	27LYxdPxX2hK345XHmegyg+r4t1eOEy6+7kQuut2miwS+RbnForfb4TunUpmmRg6gZ58PY9XP2h
	X4MBGssmteyb60W8lbFVOh5Ijp2/y0QxttJ9tuzRhG+XWXVaFLnq9LdLZBjsd7Io+Jg93HC1TeK
	TIQm1e3KhLcuukkEOJ43YQ==
X-Google-Smtp-Source: AGHT+IGMjKGdqSRAHG66Hp5080kdDSua5aWTuz7crzxOd1PM7HNSdDtTsOramgTxe/PzWsmGlSLY/A==
X-Received: by 2002:a05:600c:46ce:b0:434:fdbc:5ce5 with SMTP id 5b1f17b1804b1-43668b78d1fmr412984675e9.29.1735968744512;
        Fri, 03 Jan 2025 21:32:24 -0800 (PST)
Received: from [192.168.0.104] (95-25-252-247.broadband.corbina.ru. [95.25.252.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8add5asm41723263f8f.107.2025.01.03.21.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 21:32:23 -0800 (PST)
Message-ID: <5d045808-1f34-4dd3-bb82-71da628ccaf6@gmail.com>
Date: Sat, 4 Jan 2025 08:32:22 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Leszek Dubiel <leszek@dubiel.pl>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
 <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
 <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
 <ea8eb95c-e64a-4589-b302-23eb1fc6bd5c@dubiel.pl>
 <a6a641f6-b0a1-4915-912a-638cc07eba88@suse.com>
 <000bcef0-a86e-4832-90bb-9a4a47afad6d@dubiel.pl>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <000bcef0-a86e-4832-90bb-9a4a47afad6d@dubiel.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

04.01.2025 01:52, Leszek Dubiel wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> W dniu 16.12.2024 o 22:01, Qu Wenruo pisze:
> 
> 
> 
>   > If you want to be extra safe, the best solution is to use tools that
> can report the usage percentage of each block group.
>   >
>   > You need something procedure like this:
>   >
>   > start:
>   >     if (unallocated space >= 8GiB)
>   >         return;
>   > check_usage_percentage:
>   >     if (no block group has usage percentage < 30%) {
>   >         delete_files;
>   >         goto check_usage_percentage;
>   >     }
>   >     balance dusage=30
>   >     goto start;
>   >
>   > Although there are some concerns, firstly the tool, sorry I didn't
> remember the name but there is an out-of-btrfs-progs tool can do exactly
> that.
> 
> In btrfs-progs package I didn't find any such tool.
> 
> There is "btrfs maintenance" by kdave:
> 
>                        https://github.com/kdave/btrfsmaintenance
> 
> but it starts normal balance, it doesn't analize "block usage percentage".
> 

https://github.com/knorrie/btrfs-heatmap

https://github.com/knorrie/python-btrfs

The latter is general Python library to work with btrfs and various 
(sample) tools, like btrfs-balance-least-used or btrfs-usage-report.


