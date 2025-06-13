Return-Path: <linux-btrfs+bounces-14636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D540AD82F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 08:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAA01685F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 06:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236C256C73;
	Fri, 13 Jun 2025 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWuycgAM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8881B95B
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795129; cv=none; b=KjAJIqQgOaAj7FZzhGoBEpvUtmk37gCHC2E+lZtYNT5/VsjFxiOA+qUlkd8IfTT76g2M3WsJN8Gy7DQC7tD3b5omBJnuRnA4N2xqx8P8emFcCOdXu53VRZYrD3GKeVidDSmSWLgVIu7EgCMFCII5zplxErRZ9+Js0oZzI9GF57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795129; c=relaxed/simple;
	bh=ClG/Jv2VlQ9nLztJLBsH15/WHPKFmLonQ6vNI84DZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=amaABeLvQShvfJyCC2fuFN1nOl5UsSMfjfa7zWyzamIUIzZYx26ebZOcs0ikaa2oLtj6+P9CZbpjE4fca4qj0XdJZyQOeAERQ4mbYW1z+1DA7n0917XzLh5yEpWLWf0LefUym4vbMiqfjLdFQUCUAOc7iOpcmEuVAXqTHYKFgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWuycgAM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so3609119a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 23:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749795125; x=1750399925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BoY4746TWUwh5IknXABqAcjHNrT1NRyrBZMK2HaZCD4=;
        b=bWuycgAMensOiIuvzbcQcofD4GMpG62lNVovwTIYDvfwyBtfGcghIPT6CNmMCPceD5
         p4MhnbkSZl2td7GiDuNLv0GXsM85fUJOJrBsuLUbqYcPURwQK2z8YynK/pXzR36MTPGY
         yF4uEZWEfACLPaM0IbTRtFkqC6PoAmOgJyHzS4wSedsvJo0RhdzwzdV0zUK21MTmAMOQ
         ZzldqqSa93IDNg2+cH1+FVqXAhGQAZpvkVqSbTlwSLSUpB0pcb6zq4fVygEjrM6GtrJ+
         NmSAbQj1Poh5lmXrq+GWYjdY8h3dUvZBj86BKgsmUEUkD/1oTCgFQN4QsMBJP7cgjkqj
         aKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749795125; x=1750399925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoY4746TWUwh5IknXABqAcjHNrT1NRyrBZMK2HaZCD4=;
        b=NtyMUD9n9/XDD5F7ustFP/LyCBtYPZQLmkcnkjcY+NYmK1r7IhFZBq3BIh3Ef1LfJU
         eKxO9gXakYg23DV5wujoiRj/F/KOBI9dkzeZCUPVFU9bXAQEJOhI7gZHx6so20wQlXZF
         kB9CFBAWsWwcJUolYTGuQ8HazStnNphG8g4NyekDdb89W7GknEZs83NsmzYl+MIm7Sk1
         M/grxeoGsZO5MkUHs8kfgwY0GyGypSGVl16JrKVQ0MQBEG+2++Qri6kO6a6cdKpDIVRo
         rgSPkK0rdCJ41ajKkt+rtsWyF/u8oZzQS/qUhWPRmr3YF65+ScfijViIF4Gywb5t3Kbx
         1IBg==
X-Forwarded-Encrypted: i=1; AJvYcCUsPfpfSeqxHamq15Pd2WYYzTcVh6ymMp7uQf7/BjvHBIwfA7u5yHQdqEmaZx8SIYsEQ0UyFEbjkc8eyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMPT50Ut6/RRV9YOvPnkJBEyhntpGM+8/9B2FKEVTId6DrG+Q
	B3IDMl/Q1o5T+pxHZJi6TTPPTLrpz5kiJxdE+U3wVuDXoXgf0yD4Fr1qR3uWwK89
X-Gm-Gg: ASbGncslVOTir5OYU5Kb37YdaVh7Ou1CZdlLGi2wQhbB59kNbdo5G4AaC7s15LnikXv
	Bfq4/l2v33Nxuwyih7VxHxc8LeqncbV5Sfrctx8ottwBNyjfSegHCKnQkN5Mo3+kmLOixUHSBxY
	49r5MKlZjx2ZK13XiO/bJbfxmLuYTRumpjPEJ7crWSxzNGGA1KI3yrV730562MIhIQm9XIU1aXU
	BGb6iBHGiT6qqej+NA+UjUSiLvzcImTvyPMjz7vaiy95cGfX4A2guNL/4jMumi+1AABFCPY0jjE
	SDDCjBzmGEvKnDiNkvXNqRIOu4tARQ7vXXznKk4yxJ2OYvXiwLWIQQX/7WlAUAwCYU42nF4aEFW
	++WIPbJeb33JPz/yOM9IxgLrA/SGlNOE1HhP0hGPi2A==
X-Google-Smtp-Source: AGHT+IEXktzRjqQ3+QOks74ztfDYFL8R3V9ICN4P/6xIzgkd+Hqmm79eDCeTZjAwe0EAxXCMyfi/bA==
X-Received: by 2002:a05:6402:2108:b0:608:64ef:38a6 with SMTP id 4fb4d7f45d1cf-608b4656ec7mr1414879a12.0.1749795125294;
        Thu, 12 Jun 2025 23:12:05 -0700 (PDT)
Received: from [192.168.88.169] (91-246-244-193.dynamic.t-2.net. [91.246.244.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48a901fsm720312a12.2.2025.06.12.23.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 23:12:04 -0700 (PDT)
Message-ID: <e264b3d7-1242-4470-8a5c-805e29911390@gmail.com>
Date: Fri, 13 Jun 2025 08:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck in CHANGING_BG_TREE state after interrupted btrfstune
 --convert-to-block-group-tree
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
 <d57e673e-f894-48cc-8b34-c3754fa23b70@suse.com>
Content-Language: en-US
From: Tine Mezgec <tine.mezgec@gmail.com>
In-Reply-To: <d57e673e-f894-48cc-8b34-c3754fa23b70@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Qu,

Thanks for taking a look at this.

Here are the three tree dumps you asked for:

http://144.76.28.172/btrfs/block-group.dump.gz
http://144.76.28.172/btrfs/chunk.dump.gz
http://144.76.28.172/btrfs/extent.dump.gz

Let me know if you need anything else

Thanks,
-Tine

On 13/06/2025 00:29, Qu Wenruo wrote:
> 
> 
> 在 2025/6/13 03:13, Tine Mezgec 写道:
>> Hi,
>>
>> I have a Btrfs filesystem mounted at /media/storage with the following 
>> setup, that took minutes to mount:
>>
> [...]
>> btrfstune --convert-to-block-group-tree /dev/sdd
>> (using btrfs-progs 6.6.3-1.1build2 from Ubuntu 24.04), but the system 
>> lost power during the conversion.
> 
> The progs is a little old, but I do not think there are bgt related 
> fixes after that though.
> 
>>
>> After reboot, rerunning the command gives:
> 
> Rerunning the command is the correct way to resume, but something 
> doesn't seem correct here.
> 
> 
>>
>> ERROR: failed to find block group for bytenr 186297726533632
> 
> Please provide the following dump:
> 
> # btrfs ins dump-tree -t chunk <device>
> # btrfs ins dump-tree -t extent <device>
>    The above one is pretty large.
> 
> # btrfs ins dump-tree -t block-group <device>
> 
> I guess there is something wrong with the last converted bg checks, 
> resulting btrfstune to trying to convert an already converted bg.
> 
> Thanks,
> Qu
> 
> 
>> ERROR: failed to convert the filesystem to block group tree feature
>> ERROR: btrfstune failed
>>
>> extent buffer leak: start 185256860958720 len 16384
>>
>> Trying with kernel 6.15.2 and btrfs-progs 6.14 gives the same result.
>>
>> The superblock flags now show:
>>
>> 0x4000000001 (WRITTEN | CHANGING_BG_TREE)
>>
>> Attempting to revert:
>>
>> btrfstune --convert-from-block-group-tree /dev/sdd
>> fails with:
>> ERROR: filesystem doesn't have block-group-tree feature
>> ERROR: btrfstune failed
>>
>> So I'm stuck with a filesystem in a half-converted state — not fully 
>> converted, but marked as changing.
>>
>> What’s the best way to either complete the conversion or revert/abort 
>> it cleanly?
>>
>> Thanks,
>> -Tine
>>
> 


