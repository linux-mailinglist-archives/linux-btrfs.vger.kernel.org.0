Return-Path: <linux-btrfs+bounces-10066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0F9E4CFB
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 05:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1861881973
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 04:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22F318BC2F;
	Thu,  5 Dec 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSBiLybk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB854C83
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371929; cv=none; b=fC7BfmSO4r06bdn4Z9DiBlsJlxl5S9BVf+u7uHav0nluiXaT2+H38jtU7CVicz4SxCEOfRlAfbGN24KPUvdLY3nehhHhNbFZVwqkCv1L2tGmcYQYj3eCDmKDjWznD1yEBXp5M+ckQDaRErwIwsraY3p8l73FRYlHAZMpxu/tGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371929; c=relaxed/simple;
	bh=cUFR6CboNRiLytgBeVpAO/GO6602/Mx+27r4ui1+jJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ggvP2M/D39w5/Zp9pfr81J+FAS7Nu0VHo0GXLHcT4oGu3QpiaZSITDxuHK69wHRBJHNXQ6yuYkEH8tmsWKsRCo4gvNIfBB2Azu9V+HrnJEoA+lZv2W89BfH3ZweLQL+gm6KCQ+ltULrUFp7SOanwzeP8lndsjPX8SzKi9Lq6EFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSBiLybk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so4011531fa.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2024 20:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733371926; x=1733976726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EMNhXEbDF+cKhlH9IH3mmALcvFSgWF8DCX5MuOCqh4A=;
        b=VSBiLybkSPHHTOOMTbBg6VwZOxcsxThrB0FOl8ZxWRy7i3HHMQqdPjr8yleI03i+ID
         b1Oplf/qvK+A/JP+pMXzyKMuxDYn9auSV8y749jqQwKqULrlaf5mD7kunyfDu+YTDBZ7
         emxZNrLhEN5QPb3VLQ8yTjhB0c+LOyd5fsdXG4KTOxGGOXclOfaC/9hKh9y3pDLsAyzI
         dLhoKqWj6zer9QXLm23M5OAjM9QAudYwag73bEf3a8f+R1GSmXS47jD9NRkVSpliHX+A
         T0b8YyEhv82f1UW5+iIx56aNSLPv6OV2Q4UrzVuE1sMtm1Jb9oVL65PIHp8nAX//jqzZ
         /8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733371926; x=1733976726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMNhXEbDF+cKhlH9IH3mmALcvFSgWF8DCX5MuOCqh4A=;
        b=N3dl7vyWrJITdz3IxzOCOu/OtI5FcpLNOO2b6l0eHdPF9PXP3bhqgZ3WnZOO0JGtmQ
         tGQulwMQfqz5ccyBhZc90QcOQtvcV9ggSGwOav/tIBmpPZb1xmo9CqSRdyi4khXamAdN
         rc/VswAoy9ArKOF2U4Dqoupbg400r6O/gu7FtkN6794bp0V3EbzAFShvn9wcOSS0eQbr
         +j1NQcE7unN44qUFPtzqMqHi8kfLDFf6mSkHR85iu0V2wtPCBXyu6qU3H6BwjulmnQdF
         c3LTCpzYlWQd3DFRVvDdcBrO4Ckd6AKL11zpSvoM84+zdovkRfECIZf6Llb0b6aSUkCh
         9U0g==
X-Forwarded-Encrypted: i=1; AJvYcCWwa7ErbyEFczIipZnLDXIK/YKrRbbqXoKiS4/0tDGp4bf56NNwBPe5N9XCy3SRMXoJUptn+22u2XIRaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38Od5gubP4WklMxQX2kEewvsWvytoBI+fH4e1N4JefP6SLXqQ
	Ln9UtdE3iM4Woxw7fh0gyim0DMGljK/bs6wXUhrFfh39MRgUMC6VGQAmsw==
X-Gm-Gg: ASbGnctYUepG64XOnYvmZjZtXzCBW5PIyI/4vjRA0sYoDPC/5uuyyCLhai65uReEOX+
	0tihONyfD0ZpWLI4847mqOA+788gY3yc6suIzxn9IHOi5kCf1UpwFVezDbuhx0qfDY7ZmlH8ffx
	2VYhexHPAxKqqSBkHkYa4vE77OvuXDJJ8TPqBUyzu6sUMYSBDQbxL5qoqdn9x9MRv2hbWIWYaX/
	5+PdqKT33eZIRTCgX8oxHFExlgqb1ay75F+ZkNR5D76h/MKekV2nwCpjCI6GSbfI/eS4i14qexp
	GJb04ORHXySiLnxF/6xC48lD
X-Google-Smtp-Source: AGHT+IE6891pVM+SqlmwWDKu7sq7p2Onl70q28JRjS5jitL+azlBRDRX4Cj/UPUg8aF/WnnHJl8PMg==
X-Received: by 2002:a05:6512:1188:b0:53d:e7b6:c6ec with SMTP id 2adb3069b0e04-53e1b8b74a0mr2401641e87.41.1733371926075;
        Wed, 04 Dec 2024 20:12:06 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3d9b:4d35:5668:cbfd:6319? ([2a00:1370:8180:3d9b:4d35:5668:cbfd:6319])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229752f0sm100283e87.96.2024.12.04.20.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 20:12:05 -0800 (PST)
Message-ID: <f6470c12-6601-4776-a738-cf073e3bcffa@gmail.com>
Date: Thu, 5 Dec 2024 07:11:59 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Copying a btrfs filesystem from one host to another, reflinks,
 compression
To: Andy Smith <andy@strugglers.net>, linux-btrfs@vger.kernel.org
References: <Z1DWkM8wjak50NrG@mail.bitfolk.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <Z1DWkM8wjak50NrG@mail.bitfolk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

05.12.2024 01:24, Andy Smith wrote:
> Hi,
> 
> I need to copy a pretty large filesystem from one host to another.
> What's the best way to do it?
> 
> The source filesystem has a single device (redundancy is provided by md
> RAID) and uses compression. Destination would be the same. It has a
> large number of reflinked files. rsync or tar | ssh | tar are not going
> to handle reflinked files, are they?
> 
> Should I be using btrfs-send?
> 

btrfs send/receive has better support for sharing data between files, 
yes. It is not guaranteed, that destination will have exactly the same 
data layout though; btrfs send may decide to send full data instead of 
sending clone request. I am not sure about exact conditions, IIRC one 
requirement for cloning is proper alignment.

> There's no subvolumes and no snapshots involved here. Would I just
> btrfs-send to a new subvolume and then mount that subvolume as the
> "real" filesystem?
> 

What do you call "real" filesystem? Any subvolume is just as valid 
subsystem as any other. You can effectively ignore subvolume by 
designating it as default so you do not need to explicitly mention it in 
mount option.

> Would that preserve compression or would I have to go through and force
> recompression of everything?
> 
> Source host's kernel is 5.10.0-32; btrfs-progs v5.10.1 (Debian 11).
> Destination would be Debian 12 so kernel 6.1.0-28 and btrfs-progs v6.2
> 

According to man btrfs-send, --compressed-data should preserve compression.

