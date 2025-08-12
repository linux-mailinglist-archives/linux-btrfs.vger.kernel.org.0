Return-Path: <linux-btrfs+bounces-16032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E5B23A40
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 22:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6C01A2517C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BBA2D0639;
	Tue, 12 Aug 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0TozRAF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6F23182D
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032117; cv=none; b=cmcpq6B7mInaMUUdVRn0HgNZBxgBva5/cxrIZWRBZxNKw831sP7GgEVlw7D/pZTpduGMr4GpapbOlBBHyTCK20o83sSRFnLs5PVZA2gDcYFqVqGzf6sFkbkG0Hd2uVnDxsjOOJuleE/g2n3KoTeSwBc0UhSlUkH1CWaDRPSpR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032117; c=relaxed/simple;
	bh=Yznj33T/1KKOtAtBrIoMh81gdre3h+jbS2xt6JbCDcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iEPsSLyMV/+6Ai3QZwZn3bVOhH5lVwYwmtm028qTgLUld2oVem9JQeRA3Nuqazt+8EZ6eo6r62SMSpnCkthWf2i7s0V2nwkEGo5psB/7Bz8dwAQM3YUVky73Z0PPQkFNG69/WUTNO6S84y5y1s2yTDaWHdTrwugzewOAffxPyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0TozRAF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24031a3e05cso2242715ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755032115; x=1755636915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yznj33T/1KKOtAtBrIoMh81gdre3h+jbS2xt6JbCDcM=;
        b=V0TozRAFgu08YQKwHZgS36CpuGmTl9Ym9Hlr1mrrZBtOhHkW0bqNle/Z6BIZBXgCQc
         U0xOBzdFGrqDXLIkNF0y/ynWEIN7uw836uF5iHRD5CxxTRBKTNo99dVa+y2yAguMmDHq
         0y5mwLcajkDvnc9vctRUcWdm2kdCEsuuurHnoCjUQEQ+Y0ZkXQcjhLxnNnDGmNbPX4Z1
         PtR3llVD6I62UsAvyvS3iOW7LeF0M8WVFH7xdP93jd5vaccRjujHkv6kZNc1k907Tsiz
         oR5H5WC2kILTBjb8HV445WAk9ILcnrPqBuCz5SHIGq80CGftCUSqzZrXK9v3IzAsdWi8
         YTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755032115; x=1755636915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yznj33T/1KKOtAtBrIoMh81gdre3h+jbS2xt6JbCDcM=;
        b=avEYMCA0+4eKIkqoVJzp2KvKO8/D+uDOi6xMQyQupBY8xOCtsoGKBooL3gLmbHtNo1
         034Nly/ZHK3ArSxw7A3MF4qvOpPCFdUxRoRABvAMOCJmIWNhtliihOo9GJm7ti5Ygmc2
         qfJ5Ry7j+RqrfYwgPEjp5LR4Rm0l6nsgs/E9rS5AoLQF49ds5LdHEobSkvWPeym80rCH
         OT6gFrNScHJG/PuK8K/L8b19oN6jXb49+tnOGOk9akiHIm70WIB4Xb4kZgeAKTbfTXLu
         xMWCLyQ4JUYip7trW2EATHA7D6apBN9pVy+b57AqxNoMXwEvFGm1snaQTEcqgL3nyILm
         Ohbg==
X-Forwarded-Encrypted: i=1; AJvYcCW7e+A0aN2+U2KALngdzxwfoSIZltLjdfdcLjwK7g0rfvDFsQzzq8JS8cOC86wodm1h90V9W6BkE5HVLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtb3FBti1+EEXNwmBE6JLHkIxPTEQOr32eplNWVhucW9l/DkEO
	Pg0HKObQeGUEhon26hkZeicAZk7cT+coDjfeQfCqN7/Q2gSjkfgWJ9/c
X-Gm-Gg: ASbGncuNrMiky1nV6yTxy8eOsw14LlQ1qBoBbMdYKPWUh7T+ARltqc551XplzDU7yjT
	qh+dhBNWHvJM2MdOBxNR1XfcbuEe4BhzeFZm5uOSm7k7zYpyb4VD2nBwI+770WdXXVzEYuDCSTb
	5UTkyd2/ctZvCUGNupwfw8q2vJsd84qzWTzC6h5zVZ/wc0YL1asfzznbSvGikQ42ODIVD3tAJ31
	VAVzTh+fpVL4WvO+D1et0xyd7kW/1ML0JmJpnuhmNhfBCuOYRTLt0v8BnoEXyRnUxuHdgA2Dejv
	vOwn1QqFwyFflwOoiUi0xKzoq0skGj153LkWhrQ08hRaJhqa7cAcSVl5ZmDY8Vhy1wYVzfyS0mJ
	inTkIn8Y/s/rHXa/ojgCwKw2QoF5JN5on7prKUisOplKch33GUV29yYAvHV+SBBNuXNcYmg==
X-Google-Smtp-Source: AGHT+IHd/t3D0V7WobQH0IJYNfMSwK17+CdSGEmkrHiJM5OB5DRRnr3XhBoAZhDusoiu3PN1H6bgWQ==
X-Received: by 2002:a17:902:dad2:b0:243:b81:ac14 with SMTP id d9443c01a7336-2430e926fd6mr59355ad.11.1755032114882;
        Tue, 12 Aug 2025 13:55:14 -0700 (PDT)
Received: from ?IPV6:2001:569:720d:7800:7805:71ff:feb9:1fb9? ([2001:569:720d:7800:7805:71ff:feb9:1fb9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769e9sm309177095ad.111.2025.08.12.13.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 13:55:14 -0700 (PDT)
Message-ID: <74890d9d-d4d7-43b3-befa-f2091244c1be@gmail.com>
Date: Tue, 12 Aug 2025 13:55:14 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS RAID 5 array ran out of space, switched to R/O mode with
 errors
To: Jani Partanen <jiipee@sotapeli.fi>,
 DanglingPointer <danglingpointerexception@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <99bc3ec8-8251-4530-ab4c-7b427883853e@gmail.com>
 <eeec436c-fa53-4644-aec6-5e4381da34ab@gmail.com>
 <89786d48-cdca-4e53-8646-09860a6f5482@gmail.com>
 <fa41cbe0-e419-4cc8-88b4-09a2b0a49ddc@sotapeli.fi>
Content-Language: en-US
From: "johnh1214@gmail.com" <johnh1214@gmail.com>
In-Reply-To: <fa41cbe0-e419-4cc8-88b4-09a2b0a49ddc@sotapeli.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the suggestion. I started looking into overlayfs as an option.

One thought that came to mind, I wonder what would happen if I made a snapshot of the main subvolume for the entire array, and tried to repair it? I doubt that'll work, since the snapshot sits on top of the underlying RAID structure, which is where the corruption most likely resides.

Since I need a new NAS with more storage, it's not really a waste of money to purchase 5 identical 8TB HDD's, and make full copies before trying to repair, I can use all 10 of the HDD's in the new NAS. The main issue, is I need enough storage to contain the current semi-broken data store, which means having a 3rd backup system, that's the main issue I'm working on solving.

if I can calculate exactly how much storage space can be successfully read, then I'll know how much temporary back up space I will need to make a copy.

On 2025-08-12 04:19, Jani Partanen wrote:
>
> On 10/08/2025 23.16, johnh1214@gmail.com wrote:
>> The best advice so far, was to copy all the data as is before performing a recovery. After that, if you can duplicate each drive exactly, then you can attempt multiple recovery's, however the array is too big for that much effort, so I have only one shot at it. The idea is to try mounting in "recovery" mode, if it tries to auto repair, cancel it, then add extra temporary storage space, because it was low on data. A balance operation is needed to free up space, but that seems dangerous given there's corruption, however a scrub may fail if there's not enough space. The temp storage should be large enough, very reliable (eg not a plugged in USB), and should have two partitions for duplicating the metadata.
>
>
> Hey, with overlayfs you can have as many shots as you like in theory. In short with overlayfs you can "freeze" your drives and all changes is written to temp files so you can start over and over.
>
> But I am not sure if this can be done with btrfs multi volume. Normally you just give one device or UUID at mount time.. Maybe with device= mount option it is possible to force mount to use all overlay devices, not real devices. But someone who knows this better need to answer that or some test to be made with dummy drives.
>
> Anyway overlayfs is worth to check out. It helped me to make sure that my mdadm raid-5 was running fine when something happened half the drives had different metadata update timestamp so it was not possible to assembly array. With overlayfs I was able to verify that force assembly works and array was fine.
>
>
> https://archive.kernel.org/oldwiki/raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID.html#Making_the_harddisks_read-only_using_an_overlay_file
>
>
> There is some usage example for mdadm.
>
> But like I said before I am not sure if this is possible with btrfs multi volume.
>


