Return-Path: <linux-btrfs+bounces-10555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6735F9F6BD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78CD16F421
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4191F8926;
	Wed, 18 Dec 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeSs/nv8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE191B423D;
	Wed, 18 Dec 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541501; cv=none; b=U1EXbsNPO+ESYy1T7zhpmVvA60srzH2Eap43zvfnO6/xmjoe0BAD7aoh1myoozXPvqRryyAvMsNsA9vlDY6wpYhH6+1k8/DDmjgD5dH4scE2u9XYRUK94Qf3nclMGEQlF2YPrlCmDUTBmnbohPDi2gUSqqBGudekdsmNaY8yzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541501; c=relaxed/simple;
	bh=9fzKAWxiE3aAsasqZIWJ/jFu6GfVtiknErxRG86SXzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVgbRCcRrNT5lfXytLgdlNYr7mN9ftFlX5jjcjhC+Z6s6BHqJ8gXRWrj4SAKdQmVEOLQoiqt6pwTqMZAuiHb5PZogwpXYqHm68BEu9zbhaK+cjUoVSZbLmSB4epfqw3RlyDcOp1+HzzWf4zuX1Lbq4ZWcNeR8pApm6Q/sfO3xoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeSs/nv8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aabfb33aff8so128609166b.0;
        Wed, 18 Dec 2024 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734541497; x=1735146297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9h31TDmJEfXzLmI8JagrSx6Gp6jjuEe99oznl0Cmdc=;
        b=DeSs/nv8zgSOn3JGjVq3Mgx+iSjuMOs7h80ARAcFPt3eWCNTl1bqOa9HmjNQUf20fA
         CKeW5SNMFA1bPtGkMr+fEhRp+rhVc0MScgVTFRcbWaGpa+Zjnl8MQOAU7W1+4y872p8z
         tB+IsAMOd3NWAVZ7dPT1frsrtw87/toXRuSKm4wBBkI/1Bl561CIP5pmrvfe+NuiChNh
         s2V1nOTSVEUVfc6boEdsMFlXguG9Pz9rL5+Fyb68t2VL9XblPz2vr2Fj9E2e7kJ8ChAe
         Lb0dVlqIvZR2URgQU/A2X9ZbnVE8yzm+9HWsFs9dd51qn+3h4pR/rIX6mREegrRpNybS
         F/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734541497; x=1735146297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9h31TDmJEfXzLmI8JagrSx6Gp6jjuEe99oznl0Cmdc=;
        b=TUzBHQFF+ZGlCdgErQR67X6EVkqVnpkCo/Mw27bjLWjx9/CtyG8sf3o9IzLRfbLH4Z
         yKGEyCD7uUmVVQEhplNCDG4pcfuYzsqXqFzErWtxqJnQ24w3lThPWr6gfVHGQ7Az5mH8
         C4J1MNsVGikezjHhIoAvQGtNP/SHnDRruU57hvCsDyh3J+DuvPG+Q2o68KG6oVdq/ids
         HwCtCpi+O+cxLbKZL+7Y7pwU5HqqUaVA8hUI4R1stY7JJoJl2AQngVNgM1cUSK4ZmRVW
         Z5Jj4te+yNmNLtIwF8thzPeX4LYR6wI4k0Gan9gbmqGJkkxaexEkVCSaJoOalhoSo7jk
         fCfg==
X-Forwarded-Encrypted: i=1; AJvYcCUrWCcmH3XN+nWjWiSU5O3RSnYFEkzTHK2VKYgJ7tmifLthJ+t5HlYxdU9gDHZ03nvDQOdCRtXmJ/i9eA==@vger.kernel.org, AJvYcCW9VTRbF+pj3DIE0ZgcYSpZyn8gdAMM9Ln33dMRPRh5vsuhykOTpU2WqglLnP32qAB6CBsICk6V6SFFGshD@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpVn+EiTZPEx9InxM2YEQgcQDHpqqCzecZy8WOcyUIejvc0gT
	GJM7+VfONwcbLNJcB5iRiLLOyePJBVxwmN0bQio+xtZhz2v99RWg
X-Gm-Gg: ASbGncvwb8Jtph4TCkmAlTVCkCYGX07pUgVWODssR4TfwausQPXNVcEqNRdDqwdpUhT
	OopnGq/4SC1ZvAnadRf9aWyDjGwTfNH2y6MQHXXkqXyPcVVWDRCrQvnvY+PL5MVt0CPtTnPs1rv
	HL18k4dJkVCnMbf6nep7Vmd27w3eJfLJZts/ClCI440xvSN+eNQW5ME928mDvqSn0Hhtj+PRZBo
	9/lKKxv2WVR8vbW451QD1pn0WsYAXCMLoVgXOUMg52SJX5SphmZUCWdJdTm5eVzNCDg/jILTOMN
	LCr7Aw==
X-Google-Smtp-Source: AGHT+IHvMJdo2YuwAJK4IzVo/6bAOk5K0/SxZO/UXu9/V6Y93MfRo8ti3kWFfUdw7eoMODvnJCfqHQ==
X-Received: by 2002:a17:907:7716:b0:aab:ef03:6d46 with SMTP id a640c23a62f3a-aac08112b74mr5226866b.4.1734541496716;
        Wed, 18 Dec 2024 09:04:56 -0800 (PST)
Received: from [192.168.178.20] (dh207-43-57.xnet.hr. [88.207.43.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963913edsm575357366b.168.2024.12.18.09.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 09:04:56 -0800 (PST)
Message-ID: <35055563-5280-4f57-ad9c-27f47d94f54a@gmail.com>
Date: Wed, 18 Dec 2024 18:03:48 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] btrfs: replace kmalloc() and memcpy() with
 kmemdup()
To: Mark Harmstone <maharmstone@meta.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Victor Skvortsov <victor.skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Mason <clm@meta.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20241217225811.2437150-2-mtodorovac69@gmail.com>
 <20241217225811.2437150-6-mtodorovac69@gmail.com>
 <2b4d265c-0efe-43b4-890e-dbab59d9d7b0@meta.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <2b4d265c-0efe-43b4-890e-dbab59d9d7b0@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Yes, I see you have the prior work and I have duplicated your work.

Apology for the inconvenience.

Best regards,
Mirsad Todorovac

On 12/18/24 11:32, Mark Harmstone wrote:
> There's a fix for this already in the for-next branch:
> https://github.com/btrfs/linux/commit/1a287050962c6847fa4918d6b2a0f4cee35c6943
> 
> On 17/12/24 22:58, Mirsad Todorovac wrote:
>>>
>> The static analyser tool gave the following advice:
>>
>> ./fs/btrfs/ioctl.c:4987:9-16: WARNING opportunity for kmemdup
>>
>>     4986                 if (!iov) {
>>   → 4987                         iov = kmalloc(sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
>>     4988                         if (!iov) {
>>     4989                                 unlock_extent(io_tree, start, lockend, &cached_state);
>>     4990                                 btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>>     4991                                 ret = -ENOMEM;
>>     4992                                 goto out_acct;
>>     4993                         }
>>     4994
>>   → 4995                         memcpy(iov, iovstack, sizeof(struct iovec) * args.iovcnt);
>>     4996                 }
>>
>> Replacing kmalloc() + memcpy() with kmemdump() doesn't change semantics.
>> Original code works without fault, so this is not a bug fix but proposed improvement.
>>
>> Link: https://urldefense.com/v3/__https://lwn.net/Articles/198928/__;!!Bt8RZUm9aw!4OVzQmIUbyH-UGdUwMAL582hR4Q-7HN2fn9IpyxeA1T8qrcC8RdBVz4xuL4m35_kksUllAi6OmdbRehcFpwfHw$
>> Fixes: 34310c442e175 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
>> Cc: Chris Mason <clm@fb.com>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: David Sterba <dsterba@suse.com>
>> Cc: linux-btrfs@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
>> ---
>>   v1:
>> 	initial version.
>>
>>   fs/btrfs/ioctl.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 3af8bb0c8d75..c2f769334d3c 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -4984,15 +4984,13 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>>   		 * undo this.
>>   		 */
>>   		if (!iov) {
>> -			iov = kmalloc(sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
>> +			iov = kmemdup(iovstack, sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
>>   			if (!iov) {
>>   				unlock_extent(io_tree, start, lockend, &cached_state);
>>   				btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>>   				ret = -ENOMEM;
>>   				goto out_acct;
>>   			}
>> -
>> -			memcpy(iov, iovstack, sizeof(struct iovec) * args.iovcnt);
>>   		}
>>   
>>   		count = min_t(u64, iov_iter_count(&iter), disk_io_size);
> 


