Return-Path: <linux-btrfs+bounces-2196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA984C355
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 04:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FB41C21631
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 03:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917B710A14;
	Wed,  7 Feb 2024 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiQtShA0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2B1094E
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278210; cv=none; b=qfqgTPvbbKCSBwsW2xESZgIzdF9CBC9uGGJjpV8j/fB1j5a7U3IVkw6gsFbHMEwwFvBWcVDkG3bj3rVzACY8HDPAhj2J6Zg2RXRx0ZCb7er/lr4MfyQngJwP0I4NaSooTcsJWjmrO5hI2fgQ3UhEIOQ2slKPgLteRJ1uykvwMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278210; c=relaxed/simple;
	bh=lRjdliu11xo/DTNRO8rojH6Yy4JIAwjHPvN91mKxeOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RVe15qEBeRWiuiaeU5bBz9tMtKLPLiNtAwQB9tuwgfykiqWBz1YsX9CNlBGKZQocabw+EXEep7UJYZ3laaRyJ1Ky5BW5NaZwkfd34xc+IXVZtNs1UJXUmSUQ1Y8un8HOqW/Re5pAtK/UOad90t27EQwFKDyRtmyc9uQ5qQYQ7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiQtShA0; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0a29b05bdso790221fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 19:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707278207; x=1707883007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yx/OosvtBkJEgm31R9U7EAhRfjYGpr7u77fL/k3xAQ=;
        b=KiQtShA0vAPhwAogkvBRFc/3BIwmqOWnAAFcGFPvC2pFIl/woD1HpL3nODah9fC7+9
         RZlmLXOZuzEVTa7bYF12qQgWdaE5ctokrpczgULOwwtausB3QzfTUwKfj1Rdh+wO0dE+
         ehrRo3zY+WQ+B6m7HL/KxNzn/aR91AUiYsw20x7y517mlm2PuVGAkF69wqjCqvpnkSf+
         PyVwRK+hA9FipIrA4RKQxAZlJuDQ/4JWPQw2CFAaiM9cvtMxZoYoCFrLmeLRffoDEwZk
         SsKNU8seP7AB1IinG0Bk8/L0lVOSqT66dcsy61duKG2E+D/idKNnHLblULEANCRZs2mV
         CcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707278207; x=1707883007;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yx/OosvtBkJEgm31R9U7EAhRfjYGpr7u77fL/k3xAQ=;
        b=MHQ4G5cEiXXInbzrQVCbv5Wlf6IgueM5BMvgDzErYl4BPwfE+67yS0bW26GCGT3XnE
         dRy4rWMBRDbXE5I6SI3QekUP62ZDr4Mahie70oi3b7ptXKWd5DewKSF8+7E2sCMaEFTK
         v/vCnYPKQyDfc2U6qW/AdXM59qG7bZ9+ZaFItdOKI3BYUJ5TObucuVCOTuT6nxMMyVZD
         7ZNERq8HX84nNoyrGAmZGdVAS7Pl3Wj3QD639fr8LUGXzr0Hs9KV1mklmrOGc28V8NYk
         gtefL14oeVs3OSij1NQKPFt3yCpTmtwfnVFW9hx4ukg9SQkP5IAgyPuJdSTCnNsaNkEb
         b9Pg==
X-Gm-Message-State: AOJu0Yx5Eco6n7dQ/dp0gno/Sz1BC5Vago3wBAhclIUrCJWLvEy2s8pW
	NA8WE77bFgkFDOHQ8bKlYElBZ1Tntij/guMykVb6ykjRbR+M8QeCsAp8DyLc
X-Google-Smtp-Source: AGHT+IEUeoWP9Hwx3fdfBorlPLgmA/wx+/HmX01qAXg82m/IYUOWED0K6oZTEWNy/yeve/SLe+wvBQ==
X-Received: by 2002:a19:655a:0:b0:511:66e4:e204 with SMTP id c26-20020a19655a000000b0051166e4e204mr161962lfj.6.1707278206920;
        Tue, 06 Feb 2024 19:56:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgiIPUxAESAYqeUCLAzhSQs2FDqgTCsVRJbyOOfrswzR34WWHxnoSQv0y4+rmCVbhHq8ntR6zjhwhMsCdYjylu+LmO4P/tRJrSA5lnl5/UxnfL7g+cKZle6eXmEFE=
Received: from ?IPV6:2a00:1370:8180:225c:d919:3ba5:61aa:f67d? ([2a00:1370:8180:225c:d919:3ba5:61aa:f67d])
        by smtp.gmail.com with ESMTPSA id z8-20020a056512370800b005114b735ed6sm41487lfr.280.2024.02.06.19.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 19:56:46 -0800 (PST)
Message-ID: <5f42231f-6143-4539-804e-6f23991d4e8d@gmail.com>
Date: Wed, 7 Feb 2024 06:56:43 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to delete/rewrite a corrupted file in a read only snapshot?
Content-Language: en-US, ru-RU
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
 Marc MERLIN <marc@merlins.org>, linux-btrfs@vger.kernel.org
References: <ZcKEoftmxxp3SOiB@merlins.org>
 <62904255-4169-c126-2e6f-4323b02ebace@applied-asynchrony.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <62904255-4169-c126-2e6f-4323b02ebace@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.02.2024 22:29, Holger Hoffstätte wrote:
> On 2024-02-06 20:12, Marc MERLIN wrote:
>> howdy,
>>
>> I'm seeing this during a background check:
>> [374402.156920] BTRFS warning (device dm-18): checksum error at logical 4401320624128 on dev /dev/dm-18, physical 2939697954816, root 63534, inode 595460, offset 1506283520, length 4096, links 1 (path: nobck/file2)
>>
>> this is in a read only btrfs send snapshot, so I can't just delete the
>> file or the snspshot (I have 20 historical ones all with the same broken
>> fine).
>>
>> can I either
>> 1) force delete it with some admin tool
>> 2) even better force/overwrite it with the correct file from source?
> 
> You can flip subvolumes between read-only and read-write:
> 

This will break replication chain.



