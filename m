Return-Path: <linux-btrfs+bounces-20210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73324CFF324
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5D6334B9AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5C3358A7;
	Wed,  7 Jan 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWg3wjMi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F83161BB
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795104; cv=none; b=i3ji9a2EgjkkrtJfNukarRbsXAnALOYXLhjCg2UK27MAsBzfOa5FLfBHRAf1//Bxl66YavnrMhkSx8e5PGn6Mwv1IpciaHXbMVXe5Iq60A0P9k/R7J6iQMm18f6n9tVCyPLk1+MO+p7C/nWPVHdOvDtPUNmxTnwtB/QuHTGMaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795104; c=relaxed/simple;
	bh=bYtSxxF2dxNSCf8j6B0u9YNy9sF6QY0UEJ2KtNCj0cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Dvxx7TFWcZC1thkjM3A3pxYmkcCEg1eYMYA4dfSwcvImDNrC4lsCxoP78qFlHgy9AKYaEUm6zxTCzKMlVWoRVO0axdS/dFWS0u+Zdr4KXxNHxN7rZ/2W70ujzX2qLNiRZBcE0S8gKzK3z6gfC7OehTOSTrMM10+zgNWmChyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWg3wjMi; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a08ced9a36so2404405ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jan 2026 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767795097; x=1768399897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGVKUaABCrayVAeTN6OZrAF8z7zVhzepqozc4Pa2gA0=;
        b=HWg3wjMirWrR+38cl4hRq7rvyzQFOfNP1fiujA/daPsa4sQ5YhZb7A3ul9dbYaBIyl
         QhdxStTYhkkjcqfA6u1FtAEuweBXl2VqIKwrFdaZXm4r0lxAEzYkisg+cHzKwSJ4MkxJ
         DHMsCZLUq62e0G0R4StA3nO4LlA15C8QcwzyPjOOztKpTif3ciWBMUARsP+cjpwdoWPe
         Fi8kJMPSWDn8ZS0j6yUS7aEGEDqIcvzp0KmhUKfti5sRBIoOQKWf5yZLH01W1JODEBrU
         6dGlFMTnmMwgnDaxhTPNQFlgNofHJvszYi8n7XCc/e6yP6rRvb5gckLKPnERxPtrQu/O
         uH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767795097; x=1768399897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGVKUaABCrayVAeTN6OZrAF8z7zVhzepqozc4Pa2gA0=;
        b=bJBSnp+ZUTsatsxyQnnY6a/I0zTO2CJn1ll9+Ehp9r9C9VswxawiOXjhjGVudnqvRX
         5OvL9OeMzpei0Skqn84MqBKEOC9zACo/R0e3Lfes+Ek0I++o+tfSnEWGulbi6MUaxCXA
         qf6wA66bhIR0D17X8sKVm+tbUZAf/7JaxoyuF/bXsvGa7ITQTZtfOfhqV0+ZJmqmzOmc
         Q0ziKzxElwIpxDrlfQ2ITse+FOViVz+d3Cyh6PqxzoXVlaqBZroi3gIpcNjLXXLqzVW+
         BKARcQSJjUWcwBxiM01bpmjkk5uCPjs//ua6AOcStnv32qf28mqNfpiqdiEnHKP+2FRR
         BFxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqvlm1/pa9uUXQIPu1Y3lxWM82FEXGlpwsQPbdCUFFtUAE8JtyF8VD9lPNE8zRYUBfeyMqEYm/XmFNXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJLhedBzjcLj1i13bztQT7uXHLLr2jRZ0/SB1JNHkVSLZL52C
	47VLO9dY/D8EMvRr02Om1LR7KfUI3ygdf4JOslZJ8ZSmwqlyhBPboZEX
X-Gm-Gg: AY/fxX7awyS/yOXhZKM6PS9JeGE2q4js1sNE10aRRRtgJzqiwajkboLPDDBjwXZa1yi
	IwBrofyfTs/F7AWzSO+sEO7rPY9fvrS2+xrPKUSqwPqHMZJemiBXgK69QGbxwC4/xN1KXxPoBfT
	Qy2s76Z3K5xnKWBR56FshqTlOGDbFZroosG6HXAkVOeVPG6pnndFH2TjsJS+bDiakwqw1zL6stY
	y8Df4aCYr6p29Ykglas4gYvVqkRUUAsRCEyqZi0zkeX/Zk/VwcLj7PvQQE8oS2Ux0XTnEoo895T
	/kGkJfU94eB67XmK5SkoWhUQeNEtNs+7lmmBT18LZLynPgv10Z6HjLBmra01DLlXaP2p/lqfpgA
	I/IkcuO8VyeFvuavCVpjuStY8JHSx3PyG9EisSd4OVKB19NKV8s3uan/rwy1SeHte0EH2KHUwRM
	NAM8zKRCReRqf4/qJKnuh82bXDdw4ByC8YXsA=
X-Google-Smtp-Source: AGHT+IG++kEuBzrMUOrugxHafQhodsbPHGUjRCg4I6MINIpur0qcazpbXBbgPcN4fSOwp1zKwDidvw==
X-Received: by 2002:a17:903:1983:b0:29f:f14:18a0 with SMTP id d9443c01a7336-2a3ee48fedamr18215295ad.4.1767795096777;
        Wed, 07 Jan 2026 06:11:36 -0800 (PST)
Received: from [192.168.1.13] ([104.28.237.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48be5sm53234215ad.30.2026.01.07.06.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:11:36 -0800 (PST)
Message-ID: <34cafbe1-43fb-4a70-9016-fc2e4a655fe1@gmail.com>
Date: Wed, 7 Jan 2026 22:11:31 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
To: HAN Yuwei <hrx@bupt.moe>, Naohiro Aota <Naohiro.Aota@wdc.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
 <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
 <99066be8-992b-4476-9a22-8c1ff6f5cff2@wdc.com>
 <36718DD03AD165EF+c4b42ca9-02f2-41e9-9c43-1ff360a6e73e@bupt.moe>
 <DFH8LGFH8LD8.39G3E2X9L5318@wdc.com>
 <D61E098DC9397C2B+268b627b-a7c7-45e6-b388-c05dec782bb1@bupt.moe>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <D61E098DC9397C2B+268b627b-a7c7-45e6-b388-c05dec782bb1@bupt.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> [  246.880147] INFO: task btrfs:876 is blocked on a mutex likely owned by task
> btrfs:877.
> [  246.880187] INFO: task btrfs:877 blocked for more than 122 seconds.
> [  246.880219]       Tainted: G            E 6.19.0-rc4-btrfs-test-dirty #15
> [  246.880254] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> [  246.880289] task:btrfs           state:D stack:0     pid:877 tgid:875  
> ppid:1      task_flags:0x440140 flags:0x00080000
> [  246.880302] Call Trace:
> [  246.880307]  <TASK>
> [  246.880315]  __schedule+0x41a/0x16d0
> [  246.880324]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  246.880343]  schedule+0x27/0xd0
> [  246.880352]  schedule_preempt_disabled+0x15/0x30
> [  246.880361]  __mutex_lock.constprop.0+0x527/0xa60
> [  246.880381]  btrfs_inc_block_group_ro+0x7c/0x240 [btrfs
> baccf26ae5d5cb9debb29275b7601f927e8719f7]
> [  246.880614]  do_zone_finish+0x81/0x430 [btrfs
> baccf26ae5d5cb9debb29275b7601f927e8719f7]
> [  246.880819]  btrfs_zone_finish_one_bg+0xfd/0x130 [btrfs
> baccf26ae5d5cb9debb29275b7601f927e8719f7]
> [  246.881018]  btrfs_zoned_activate_one_bg+0x12f/0x160 [btrfs
> baccf26ae5d5cb9debb29275b7601f927e8719f7]
> [  246.881217]  reserve_chunk_space+0xe0/0x170 [btrfs
> baccf26ae5d5cb9debb29275b7601f927e8719f7]
> [  246.881444]  btrfs_inc_block_group_ro+0x223/0x240 [btrfs
> baccf26ae5d5cb9debb29275b7601f927e8719f7]

I'm not sure but it seems like a deadlock caused by

btrfs_inc_block_group_ro()
-> check_system_chunk()
  -> reserve_chunk_space()
    -> btrfs_zoned_activate_one_bg()
      -> btrfs_zone_finish_one_bg()
        -> btrfs_zone_finish()
          -> do_zone_finish()
            -> btrfs_inc_block_group_ro()


