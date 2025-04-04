Return-Path: <linux-btrfs+bounces-12795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E902A7B9F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BD6189B2DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B11F1A7044;
	Fri,  4 Apr 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iesmariamoliner-com.20230601.gappssmtp.com header.i=@iesmariamoliner-com.20230601.gappssmtp.com header.b="uo/JgPtn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D31A5BAA
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758907; cv=none; b=UE+2/RP8YuJtTU6wChGVB3D1x3eo57AVq9Dq3814EUjToRCFBif2tcqp9QC2Q8BprRYxhA+822e2GgX4rmjP1eWlDxwBgj/MusEIczEHmKmuLpJvIJ+Ot1tf784HgXLmJ39HOIBF5s1eG8eu7fUz2TEo84u3slaQaPzUk4DPfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758907; c=relaxed/simple;
	bh=Er4mF2InnZdV7Q/m73Qars5//bpgzF6Xq4vom2JmO4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V2U3YhlLJksmuldt7bbv18N1bw1rukKpP5yxc7ZUmgWDq6MGP/AGWZ6KuRert7qxir0+/UQlFJWVjx9ZnDfOPKCol+SqLBjnOpzDcm2/xHNjrzmb0fCVW0jFJXD4itpoD7KdVeRm11N4cfQaWaaZNfa7T0VdCTkPSXBJ6hqq2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesmariamoliner.com; spf=none smtp.mailfrom=iesmariamoliner.com; dkim=pass (2048-bit key) header.d=iesmariamoliner-com.20230601.gappssmtp.com header.i=@iesmariamoliner-com.20230601.gappssmtp.com header.b=uo/JgPtn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesmariamoliner.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iesmariamoliner.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso15991105e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesmariamoliner-com.20230601.gappssmtp.com; s=20230601; t=1743758902; x=1744363702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iH91Rp9mGJoXOjPSIQui6XfCWQ4J6TqlEB5pBAlH8NA=;
        b=uo/JgPtnNQL2HjhXR9xKY+T6JxEEb5z6gnV3YPIlHCKBSfe36PYo9MqsUjo1a8LoA2
         IjYp+a3d3yb5QVX8hp5oYtYUa1rSE2slJ+hC47pCtIpHzqx63LcsLax+oy2Vuqk7AMb8
         6ZqtNqHcQst/JCfIa+Vzf7CG3Ch1k6gsT9Dhm5OrxQy2wZyGKJQ7dQuXJvWkGRJ1ANfb
         Wg/f4uc9A3xO3MGboW6dVTuSdW3Fz8ITo51KEY381ydeTiU5kvCl2VaM5BXIUh04xxny
         c0uCdmBvR2MVFr9PysXvMUWSCyXrfBsv7H/nIGclZvx2Ld/RoorDh8k1NHlFoW6wwGL+
         MJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743758902; x=1744363702;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH91Rp9mGJoXOjPSIQui6XfCWQ4J6TqlEB5pBAlH8NA=;
        b=X/kUVN5lrPTMY46oLe/YWjlHe9vIbOKz7Djw3RLRCc4QNXGuEMQS006vm9bFb1XHOw
         2d2c3ylSNf4xA18XRDciPLcZREUfBfZ9UkaLeHuCZCat5qT0Wzbqzymot/y1TGPjCWtK
         j4HzYBGZyrodBq9biegKFIkgTpQk9McQ0KN0gVy5fkdY9QQOIIf+T2k0wiEk8FietbbM
         B3KpVjifT3NUgkMdEsFGJERWKOD84poWQOHiBKOXewJbnUVYUTzMic3y3yDA4VonQGiC
         QWowDAjfLaoS7jG1yDSapai7QdcR+5Dhmz5KQ/Ft6xpNA51YWBnPpdsljI1wL6M7OocW
         LmUg==
X-Forwarded-Encrypted: i=1; AJvYcCUyXfR1XHWLBSihQbEt+itZFAWBWCgXegtilNkN2PLZ8nGpixIBIubg0Vq0Jl/mzL0+x11Wbvwjbf3w1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYgLEFsUbu/fjdIvvSDDOR0KVbtZyXVLzZMTvuzHeBwUV7cKv
	ti0wstCJpAgaWUoyB+nmtOW1btJTnmUdckmooELvju2DZdpo1DcESND6EcDVyXI=
X-Gm-Gg: ASbGncsdSlDfDtgFHuzTAGLol6FWNnhxLDk1Tspw40OF67WosMK5aBw5m0SvCYe1SrQ
	GMawJ8kV4dddsd3YGbyt9tQvX51v4UuTG3g58n8/OamMVaZ53dQ2R3CyHka1knPPKeam2RR4SM3
	tTnJsSRoU/BDfZSvLpcQ+X8zdrR3sKzIF6emjhsk1VVkgu5QDgLeBqH686wID1Nfn8lU3vd6jrb
	gkeNprl5shKGnR8t/IcT/BOj6k1WWa9xX+S3rk82noRYW0THLhI13vlEpfwrK1l3qG0OU28NwtS
	zbj6N5y+p51GSYvBM0baTN+B+RxIH6p/dq8ZZsl4yznVbVnD1kUCVrayzWNBuoSIQdcyacRWQ9b
	SALzU8gc/cSIz9U2ZDtkEGQ==
X-Google-Smtp-Source: AGHT+IES0wWIPBA3jvuOrNAdh/OExIu/DW7/zOOYVW+yBKoOetd3LhThSL1ybnGyRxHXv3MrHlXLkg==
X-Received: by 2002:a05:600c:3103:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43ecf89dd3emr21916785e9.12.1743758902183;
        Fri, 04 Apr 2025 02:28:22 -0700 (PDT)
Received: from [192.168.2.200] (92.red-83-58-49.dynamicip.rima-tde.net. [83.58.49.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366a699sm40337955e9.38.2025.04.04.02.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 02:28:21 -0700 (PDT)
Message-ID: <2992e93d-ebab-4e00-ae9c-58bcbaecf690@iesmariamoliner.com>
Date: Fri, 4 Apr 2025 11:28:20 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A lot of errors in btrfscheck. Can fix it?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CA+n7ozwhzdWs=KaBQh2miNwPwYxqBi+MEb807kddGNUZAOyNEA@mail.gmail.com>
 <ad298eab-b9c9-4954-beb7-fc09b238ed23@gmx.com>
From: Fernando Peral <fperal@iesmariamoliner.com>
Content-Language: es-ES
In-Reply-To: <ad298eab-b9c9-4954-beb7-fc09b238ed23@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/25 09:54, Qu Wenruo wrote:
>
>
> 在 2025/4/4 09:00, Fernando Peral Pérez 写道:
>> Opensuse leap 15.6 with btrfs in /dev/nvme0n1p1
>>
>> one day fs remounts RO.
>
> The first time you hit RO the dmesg is the most helpful.
>
>>  I reboot the system and all works and i
>> forgot about it.  Then some days after it happen again... and again,
>> and once each 1-2 days.
>>
>> I boot with last opensuse tumbleweed rescue system and run
>> btrfs check /dev/nvme0n1p1  > btrfserrors.log 2>&1
>> file size is 7MB (72000+ lines)
>> This is an extract
>> [1/8] checking log skipped (none written)
>> [2/8] checking root items
>> [3/8] checking extents
>> parent transid verify failed on 49450893312 wanted 349472898974925 
>> found 820429
>> parent transid verify failed on 49450893312 wanted 349472898974925 
>> found 820429
>
> Although you have ran memtest, the pattern still looks like some memory
> corruption at runtime:
>
> hex(349472898974925) = 0x13dd8000084cd
> hex(820429)          = 0x00000000c84cd
>
> BTW, the 349472898974925 value looks too large for a transid, thus it
> may be the corrupted one.
>
>
> Not sure why but the lowest 2 bytes matches, maybe an indication of
> random memory range corruption.
>
> There used to be a known bug related to amd_sfh driver which causes
> runtime kernel memory corruption.
>
> But it should not affect the openssue kernel AFAIK.
>
> So I have no idea what can cause this, especially when you have ran
> memtest already.
>
> [...]
>> My questions
>>
>> Can the fs be fixed?
>
> Nope.
>
>> Can the copies I have done be reliables?
>
> From the fsck, at least csum tree is not corrupted, thus the recovered
> one should have csum verified.
>
> So yes.
>
> Thanks,
> Qu>
>> Thanks in advance.
>>
>
>
>
I had the memtest running about 2 hours (two full passes).

You say it seems memory error. Then it can have been caused by a 
"one-time" memory error (or one time whatever error) or must I search 
for some fault in my hardware?




