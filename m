Return-Path: <linux-btrfs+bounces-2618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D7385E4D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798BC1C2371D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D684A31;
	Wed, 21 Feb 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RENZryMO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BC82D9B
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537506; cv=none; b=KFX1f3CrMYBjX/ILe5zrEY3MivKpSwE5ckFNmBThpmpjxS7MBypl6EXBp+SH0PL2/sjvtfngCP5gN1iQUQDgw58DUJmfk5AytOTPEKhaQA3lL/0c1jL7kAYHyStnRiOS+VcJ6Wa7PJ7RzmsycrtAfcUScRcBbQwmrZJXsViRuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537506; c=relaxed/simple;
	bh=lFgKfVC7rYsmOrNvd6Y06DVmwQOqhrvw/XpwbvgSrdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s0aa6MXyU7wGqrEoWjw5LKd6Bom3ji6Jn70SP0krYyy3MSKHryAIovExx4gM/rEPv/iJ4qWeJUny2y+Aob8L1oCWH/amy37tevlTiYbSR+0LMzBwiIQk6ZXXJc9uoSyIaNpcoiqruk4IjdPwRYWFaPXSWmE7Ggqwh7seTF8THZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RENZryMO; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc745927098so903026276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537503; x=1709142303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSlvk88STqoeI0yaiEvAd6UzcCBL54rpJ6MmZkiTUVk=;
        b=RENZryMOnaHT/hNktdPIEBKe5yO83QwFygsfyqqtPQ3Hka+VbVxB3H/R5Orvky0gVn
         1ViWkxeDgvRS8YfYdYWc7rr2LiwGDm2ucucKdVlzb3bbTs+K44I8s/Mg1eFJ191E9ABx
         xNoMCQhYA22E21bsuIVXNKBQwgbzwumgsBu0zyVDAHsNnrdyPZBW3nzaQ2Zu097Ne4ED
         QHp719pWE5caywHxHsSSWS7yCSHazHJHgyrJrTtP2/iJwE+6Qyp4NxuvVnaOBcEZaz7m
         14MC9Yejuh2ewNaKof3L+xQg7/94JKmoLmx5xc9A/P4gNsRHpEFDTGPTPBQ03rCkLWFI
         1gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537503; x=1709142303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSlvk88STqoeI0yaiEvAd6UzcCBL54rpJ6MmZkiTUVk=;
        b=lmYynDEbFA/DSbBhM2olr347r5a19dpJV/iYM7uKR+gjabq4+ecP+qmPyrhpNtUAGr
         Tw5bKG25JOp0FUSTHs5b7kWbQjk6hieF8qvUWJBpT/OH8luPrm0D+iNrg0pSGlLrQz51
         HccT0b7JsiXQ3R88IwivuMNfAVk7YttealouBmtzznj3T9RK1KOh5uUwGixNsxwDFGko
         JK6rtwBAicXsVwtz67AF+z3blBjB7LPTrDyf+vF6FG7Ajm5GgAwNldHX8FbfLNpgzJsJ
         tHOcJ+wqFafeuzp1nMTgwANhYJsarEYl8mVurziISxnc3/Ya4csB741zV0TEtehSQmO1
         vKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/a5oHn/aZjpaSkEpTAogxr4BrIoA6QdBtGtUx4kivFjiiJdoRLGwgT17HQFPhDEKRdngKJp5lRSYEyV6RDiqzxBeIOioR6RUAUR0=
X-Gm-Message-State: AOJu0YwQZoY1hIYRqGjfWR41FrPBRqy3PgsZmneWSI+KNoQPcbobqqql
	c9M6FHoJDnqv7nA9jhlO/CI11el9CZEHyygCyW01LGLR2AkSWAK8
X-Google-Smtp-Source: AGHT+IEvQfEltE6fZWjU9XllwHzk9Ea9v5XNcJtNeoG8aJVPL1vmrXA+q6DunySOA93Y+kwKjh9S3g==
X-Received: by 2002:a05:6902:2201:b0:dcc:2caa:578b with SMTP id dm1-20020a056902220100b00dcc2caa578bmr16787412ybb.40.1708537501996;
        Wed, 21 Feb 2024 09:45:01 -0800 (PST)
Received: from ?IPV6:2600:1700:a624:b6b0:2a78:c1a0:a8d8:cf6f? ([2600:1700:a624:b6b0:2a78:c1a0:a8d8:cf6f])
        by smtp.gmail.com with ESMTPSA id j27-20020a05620a0a5b00b0078719b3b55bsm4505458qka.14.2024.02.21.09.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:45:01 -0800 (PST)
Message-ID: <469f04cd-0cde-4355-9299-9a9006aac2e2@gmail.com>
Date: Wed, 21 Feb 2024 12:45:00 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apply different compress/compress-force settings on different
 subvolumes ?
To: Roland <devzero@web.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
 <1597160e-0b54-403b-8e9d-9435425f14f3@gmx.com>
 <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
Content-Language: en-US
From: "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
In-Reply-To: <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/21/24 08:15, Roland wrote:
> Am 21.02.24 um 10:33 schrieb Qu Wenruo:
>
>> 在 2024/2/21 19:19, Roland 写道:
>>> and why is compress-force silently ignored? (see below)
>> Compress-force has no coresponding per-inode prop option though.
>>
>> But I don't think compress-force would cause much difference against
>> regular compress.
>
> apparently, force-compress can make a big difference (and compress only
> can lead to no compression at all):
>
> https://bugzilla.proxmox.com/show_bug.cgi?id=5250#c6
I can attest that this is indeed the case, though it’s very dependent on 
the exact usage. For the case of large files with highly varied data 
(think filesystem images, VM disk images, large databases, etc) that 
don’t include inherent compression, it’s very normal for compression to 
actually be a huge help, but the early parts of the file to have very 
high entropy and thus not compress well, resulting in regular `compress` 
not actually helping at all (because BTRFS quickly decides it’s not 
worth it for that file and chooses to not compress it at all).

As an example, the VM disk images I’m storing on my home server take up 
roughly 40% less space with `compress-force=zstd:1` compared to just 
`compress=zstd:1`.

In comparison, I see no effective difference when doing it on the root 
filesystem of said home server, so like I said above, it’s rather 
dependent on exact usage.

There is of course some extra overhead to attempting compression n every 
write, but at least for me, on the lower compression levels when dealing 
with ‘slow’ storage, it’s not enough to cause problems.

