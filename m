Return-Path: <linux-btrfs+bounces-19630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED715CB3C3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 19:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7803064ADD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2261283FC3;
	Wed, 10 Dec 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He5sYYjY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512221E5B9A
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765391460; cv=none; b=rvPIWRP8YKZpbaU9q6KS4Et58iTycRa4nun9eoBeUcSJzZ7kWwQ7xuiJrI8quQWVpg88Q+WUqVG4+8Cn0SCqOCU8YHbwwIQyGl7qFNvP7xRtfECg7UTLktIe5f4lkrQhREW/v5H9wOqP6WimWsAmrCe1YzdRpgIR3Y04AFvWVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765391460; c=relaxed/simple;
	bh=Kh5I2HCYCHX9WJfjEHQ7ofB79I0qvLRKAlDomHQ6iSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HV80h+s+GP/Bx/LoG0JIVxG1xTCV8U+EY3BawikQJ32dGgMlE3KiHPZOxUcgkpr7v87gtQHZg5YO38bAdUNYEWnSj+omWk0Lnf/90+bSiP3vxgaLJcd37SvMK8jw/1RH4jOx4GIvb7P/tkDk6ngFOqhToNCzETKTHUgID3bI//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He5sYYjY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5957753e0efso46444e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765391456; x=1765996256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUmRlrCDWdsvUlk84sB8kM88pjooi87Jh0CVpmUu3KQ=;
        b=He5sYYjY0FXxJ9IYi6fAZUPcO4UAXX9TR/jhUt0nvwmqSLz6IGz/QTF6w/dZnwFjrm
         NDx6qpnxAxhbwbIFehZKayKsQf+IFmQFTKrSYPj5nKvggLN08Bck7+lpFoJ7SUZoIGV9
         fVWVRyONXJqa3jWLFoY6/8LC4ZyELMk55f0TsO0lkVSnzxu7iHuL5QrTUsDDpI7V4c9i
         CDbXyhzOiHHqfCxfjRiL8zp1lhzV/Ap549hlngCGCVVjwQmUHtbW6l+kJnQXTBmDRwvd
         0w+aIF8linIYRC606Tl5h/9sJ/on0KxoGBX53QcvVw+E/vU1xw9VH3F+bYHfr5xwztph
         Znuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765391456; x=1765996256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUmRlrCDWdsvUlk84sB8kM88pjooi87Jh0CVpmUu3KQ=;
        b=DOwWxoojZYoxDhgvre26eOxV5kSMepWJP8C1KGEfx/XjWnV7KhvsOpRKea541Nch4Z
         dygC+ie/fIQx/gtdmPbASSCKoJJEd76S0KmGHckSiVfZSdNbr3sGxx1IuLKTouWfP7za
         ArQBPih79NrpTKlwyQGp/tJQuoQ35x/Dx/PXX39IkzcvSC01khqTs5jMN+LiRAidrVcF
         Ew84iIcnaYDeOenOzfG6DGNrc/yweX3W3/USPelVtMUh3uYKErWYo4evY0FqdDx7QHtG
         Vd1oTcbhm70GtcAJYWXB337fRXlnmWhLdCC3GzMREj0FUGsoJtCuP979xwdBZGkRXnCd
         6K6g==
X-Gm-Message-State: AOJu0YwTfxx0dwqNQ0P3pau20dwQnBJLNhwlcObTCbxpWAmg6F1TfjKN
	KKuPMdksxxdzUonfqqpvB7heX2yGujjL2yLQWct+93fNJU5Oy6udFyLm78DuXA==
X-Gm-Gg: AY/fxX5sQSrl+4H9Vl3G2aLQZTXI7aKljP+eVD1l2M7OaoxKCdvk6RjhgEhrdi/MKUx
	cd9RqiCC7D85ldjOf3y8hWweJmQSD8FioU66hRQZXlaUgojLp1LYp6gl8GFSVM93lrEJ/H/IxxW
	Qb9DipHk4SznhG1C+ucyp6kmzIhYEhl4Tk59nfBRdzwEChndWIvF1k6JgMAHhDqcD1z625p1k9r
	n4fIjbEcVpXVhvpGeu2gXRZnZz1MtsO4cdxFluyY7OeuRa79QAeZ5gzpS4haA1hizpQaODgyo3o
	lSiGKh3OAPZM88ibvSJgUq+Td84nDMClFTscVTRPKWi+A4A7XosedAYd0QhMfY3f94MWJJMH0ca
	ijsQBhN2DTY//OhH5hbFr28NruOCW7Z+zJPUzJUlcgveyRGw6K4XxrUJHIqfHQghYO3zvgPGT8A
	GhZGcbV2K0QvobosNbKLP7tsyHeLQfPrdwcgC7paLumUb8m+umPvTkYup1Iw==
X-Google-Smtp-Source: AGHT+IEocPCbmJhQahPayAUwsWzPZPy9+yC8ajAlipRm6WmwUkEm6loPOE8IY/xhJD+MkvdqEroBzA==
X-Received: by 2002:a05:6512:1558:b0:598:ee6c:ed6 with SMTP id 2adb3069b0e04-598ee6c0f19mr966772e87.30.1765391455802;
        Wed, 10 Dec 2025 10:30:55 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3b0f:85a0:574b:95e:fc51? ([2a00:1370:8180:3b0f:85a0:574b:95e:fc51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f378dbsm64899e87.1.2025.12.10.10.30.54
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 10:30:55 -0800 (PST)
Message-ID: <9805c251-c7de-40f7-b12c-5f98ecebc27e@gmail.com>
Date: Wed, 10 Dec 2025 21:30:54 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: booting from degraded RAID1?
To: linux-btrfs@vger.kernel.org
References: <20251210165041.GA585304@tik.uni-stuttgart.de>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20251210165041.GA585304@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

10.12.2025 19:50, Ulli Horlacher wrote:
> 
> (I am using Ubuntu 24.04 with kernel 6.8)
> 
> I have read that booting from a degraded RAID1 filesystem (eg with one
> dead disk) is not possible, because systemd waits forever for the second
> partition.
> 
> Is there a HOWTO/best-practise what to do in this event?
> 

systemd waits forever for the device with btrfs due to this rule:

bor@ThinkPad-E16-Gen3:~/src/systemd$ cat rules.d/64-btrfs.rules.in
# do not edit this file, it will be overwritten on update

SUBSYSTEM!="block", GOTO="btrfs_end"
ACTION=="remove", GOTO="btrfs_end"
ENV{ID_FS_TYPE}!="btrfs", GOTO="btrfs_end"
ENV{SYSTEMD_READY}=="0", GOTO="btrfs_end"

# let the kernel know about this btrfs filesystem, and check if it is 
complete
IMPORT{builtin}="btrfs ready $devnode"

# mark the device as not ready to be used by the system
ENV{ID_BTRFS_READY}=="0", ENV{SYSTEMD_READY}="0"

# reconsider pending devices in case when multidevice volume awaits
ENV{ID_BTRFS_READY}=="1", RUN+="{{BINDIR}}/udevadm trigger -s block -p 
ID_BTRFS_READY=0"

LABEL="btrfs_end"
bor@ThinkPad-E16-Gen3:~/src/systemd$


You probably can break into initramfs shell and delete this rule which 
should allow normal startup sequence to proceed further. It may be 
possible to manually mount /sysroot (or whatever the location is in 
Debian/Ubuntu), but I am not sure.

> I have create my root/boot filesystem this way:
> 
> root@mux22:~# mkfs.btrfs -m raid1 -d raid1 /dev/sda4 /dev/sdb4
> 
> root@mux22:~# btrfs filesystem show /dev/sda4
> Label: 'M22'  uuid: 9329698e-bbb0-4047-bcef-863e584f314b
>          Total devices 2 FS bytes used 144.00KiB
>          devid    1 size 64.00GiB used 2.01GiB path /dev/sda4
>          devid    2 size 64.00GiB used 2.01GiB path /dev/sdb4
> 
> 


