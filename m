Return-Path: <linux-btrfs+bounces-15556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21663B0AA31
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 20:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8463AAA74AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F22E7BC4;
	Fri, 18 Jul 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oUK3fxHj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF8148850
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863773; cv=none; b=o3nZ9OZGGvKOT8CBSwU1HXFQ0vPKO72PGXBzk/O9xwJBEkF2fVvzRIokML9BsOeEc5jX1J12rdOq1q+oQ2BdjPGcCTjAHXKj/PZkyD/aCby1sv4hWqCxWfqz/LrCm4QALF4y8kU3xCZMenhBcbJCdLQfQ+LEylhg7HMLofZOfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863773; c=relaxed/simple;
	bh=5qlQ+761hn6OrnIDwaSrOkWt9c8/47BkXB3UXwRLQss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5SIdIZCKjo26PBNCELFI6AJx0ZkT+1m0BhhKOUIK2WygfavRlP5aKg1yw8F55OKgVR0+R+Bo3m0oKwn3OYO/ZOQiO7+rDaf9UfjcnAFl7nhjg427OCoXRL2Vy16YYO8qCfWvVdHpLWCA7fu8lACZvtRloGI4leoMctvzXyYsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oUK3fxHj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b390136ed88so1652466a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752863770; x=1753468570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YHZSIH4QXyQQjmvIqyrjSbplelhoOzEiXOXvbUIHNY=;
        b=oUK3fxHjQrvNljhNQYlMGlMMbdSzoi0ax3lVkfmRynN9oXzvbwYfsc70R4z/4MJowO
         JC4lXcIu5NMSmmiosi7y4hiEguGlxoQTSn85CuMp0MUtG2Kb8lgcEEvTGxXVzpLSTtbw
         2obSk6KPuB8Rl12vbo+hu59JlxZbSpZnaxkwzBzdq+JXkNQ7iF6tS5vosuWBjDduf5xB
         95X8YKpvwhbr7S4rZD9OxTopoPu4/MuL86tlcs41v5KxgPHaCaag1GM8HeODko46NWhF
         f1WsOC22pGhwwQEZPCIT0uB91WXVA6emw9brkaqG7w8wBg8A0QotfLmINl61CrctcmCx
         wEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863770; x=1753468570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YHZSIH4QXyQQjmvIqyrjSbplelhoOzEiXOXvbUIHNY=;
        b=Pz4mNymaHYL0ywWHJlcAHtqMY/ZKwJurBGc+X9DKaPB8P2NR1kLzx1krV58NIEZro6
         Xld4sPrKduWvmpinZ07xWskVr3IfRe2p6yjMCWcXS9Tw3xysrKIep43TN3WgSetCJtgx
         ZI3XamguLGaMVMQQVHvH0sJdI4RZH0G/HyM7Yts4vbzsZ0dngQ8q867Zy7qCd8Tw9nZf
         BjdG83/Qyxz/yrz1Fp3D6IkhxpbhCsQ6+1dfUp+zra1jMo6XXJHITWcqnD9eanE8yXWd
         c/7gtxv0/v1IMH/mwGBiNmFLxcRYSDN8jcik07sFtK+DDBSpEuEwtHAaFYagcFrLBe3R
         0HgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3mC+U1oK6QikK5BPqOLeLh/Cz3VaC+222JzoNkHU5TLp0mJT7XeTTsLVauqjWiiLOuoHzUicBTWlIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1X/bCqJLS0VA1cKKkZw5PV7pt2WfdXd48PPrvt0wag7ALlUa
	RNta/jZRaf/8QHmhUIaok6bh/iP7o+Kvpko7Jo1Fa6sKNWJipIg5ZQrTsFMHn5Glc8c=
X-Gm-Gg: ASbGnctKFGNZSRc7pXDNIPy19JlaaKXOCLKlcvENNZwEn4U0Oi24/Xah6v1uIUtk+hZ
	Le1GabEKAZ4lolPgH8erqdLJHiYQnIP16O+NHfab3XpII4UL2xRyl/bqCy+2MYz+pwdSKukCwHb
	yuY00bRpyXDehUtnpqzvQyWuaI/fQ8HAmjk1SAXoC9SiqhS6zvbJQBa9O6Gk8ox07VwqXozc4Kt
	HkLwJ5YEjgMYplNZT+KTsPX6860Wke5KsnXVXDicmjH3ZEfsHeEHn/166FvF4D/7cDcp4JvahiF
	wOWlSQzsLiEcSPR8RpLr42T54wCD07Py7PCZWRMcNlvZSAglOJpPJZ7/XMnjQMftp4l/p25xmoI
	pxO7GqRka72bYh0uUFdi1NqXiWkpj7IQzmq7cNw3wjtGMpSoEL88XhoT02sF8upk76CE=
X-Google-Smtp-Source: AGHT+IHNjCZ1lF5IxEcSK7Q336xvA2JqN/FhLb91/xqIHcN1SLy4r5JEGGmXyt2l3qmS+/4JJPp6Gw==
X-Received: by 2002:a17:90a:d88c:b0:312:25dd:1c86 with SMTP id 98e67ed59e1d1-31cc25c5ab0mr6395789a91.18.1752863769794;
        Fri, 18 Jul 2025 11:36:09 -0700 (PDT)
Received: from [172.20.8.9] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b404sm1687820a91.12.2025.07.18.11.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 11:36:08 -0700 (PDT)
Message-ID: <72eeb282-2e9a-4c06-ac5c-54f226a8500d@kernel.dk>
Date: Fri, 18 Jul 2025 12:36:07 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] io_uring/btrfs: remove struct io_uring_cmd_data
To: dsterba@suse.cz
Cc: Caleb Sander Mateos <csander@purestorage.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708202212.2851548-1-csander@purestorage.com>
 <CADUfDZr6d_EV6sek0K1ULpg2T862PsnnFT08PhoX9WjHGBA=0w@mail.gmail.com>
 <bb01752a-0a36-4e30-bf26-273c9017ffc0@kernel.dk>
 <20250718172648.GA6704@suse.cz>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250718172648.GA6704@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/25 11:26 AM, David Sterba wrote:
> On Fri, Jul 18, 2025 at 10:58:07AM -0600, Jens Axboe wrote:
>> On 7/17/25 2:04 PM, Caleb Sander Mateos wrote:
>>> Hi Jens,
>>> Are you satisfied with the updated version of this series? Let me know
>>> if there's anything else you'd like to see.
>>
>> I'm fine with it, was hoping some of the CC'ed btrfs folks would ack or
>> review the btrfs bits. OOO until late sunday, if I hear nothing else by
>> then, I'll just tentatively stage it in a separate branch for 6.17.
> 
> I've taken the first patch to btrfs' for-next but if you want to add it
> to your queue then git will deal with that too. For the btrfs changes
> 
> Acked-by: David Sterba <dsterba@suse.com>

Thanks! I guess that works fine, it can go in separately. I've queued
up the rest.

-- 
Jens Axboe


