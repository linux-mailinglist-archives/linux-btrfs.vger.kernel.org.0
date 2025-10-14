Return-Path: <linux-btrfs+bounces-17776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8226BDA378
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 147414FA84A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323A29DB6C;
	Tue, 14 Oct 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/hrddFo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F1296BBC
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454253; cv=none; b=IC3GSBL3F7QE+S3bLLnbAELkofnjmldIzq4AGo5/IrOn9B6Sj6CmgWq05AecjeXH4k/K19oZcHo/Ba+6TK/nHJwlPlhg8kfyjBDXr8wpE55T4Pm1eRrvABN+1Q/0xpvdC9wzZreYvPpdSSRMOGtwZOkg60tLow54r3S42yze4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454253; c=relaxed/simple;
	bh=DRMrxxo87hkpT3eQFH5SBhJ0TaM9CHLTC9ldMaJ/oBA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=QiJcTcD7a9jju7pzldqjy8tZ00WTPCwLlUbJtiSw++0qqsxicLW19FIHX/RjPv3KLS2bZ9UjsGSsBcPIczQR+W9Q/qJIPXbMELjG+a7nePpOC/Sof1Mtw72TjfMpXp6pMG8+WBdiwPX/BooMgqOYPwfnq8ULTQvHJdXndMbFQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/hrddFo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso40973275e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454250; x=1761059050; darn=vger.kernel.org;
        h=content-transfer-encoding:disposition-notification-to:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yjLOTyqQq4UQvH5sXY4aVJ0VszW5q08tLw2bi+K2rdU=;
        b=e/hrddFojXSvWaPYERyqKrqWSPas5CPnBZ1PqphuMFtSJPU21yP5a9fEfcIDF97O9q
         zq35YfzeTW86LeLV2Tn2huvA9IjgEUecjop4/awcj5GEGKKkc1tOHe52YbUl6vzEwULL
         sNsDDLPxe+UAW4FXwhYyLEBGGGd+tTl6UAMXQb48L8S/o1RdCK5UTKigrcdFgnj5TWFJ
         kqpVo4kWHm4qGP4+xVmXH54KVJaXh62FGz+IvaejgAJDmr+TIIqJuh16z9T3ttwz15wd
         XRc260ogjC9Yd+Sce9g7Vuo6e6GPwS5HyRjyFpBDh83vsVTowF8MtfDYlSELvJY47MpJ
         KhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454250; x=1761059050;
        h=content-transfer-encoding:disposition-notification-to:subject:from
         :content-language:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjLOTyqQq4UQvH5sXY4aVJ0VszW5q08tLw2bi+K2rdU=;
        b=pZn4hdUmGc6jQ5MsJQR3lPp7Al0Zu10AvRXiByJbvNKggg7vI6ZhYekA87mhwtTTFg
         rPv+Az4g1+k5NDcoaw5Ja3Enc8PnkLSdFBQfLRNQ3JPJa80f5Va5uHlSdfDbuZc51XfI
         BUUjYhTQLByRHHuyU/VfK2YlRCTa6ydwE6N/ciQzArNMrQ87YZa8KwXiymzVlYuDqqM9
         LdUGJmwxwvWobALxZCMbONCOc857YnbpqBOzbpug2KUsXLZWPrq4hjVQM37sx+1evWy/
         lvxjyF4lBjcSj7zR0x0UbVp2URmPHfJKL36lA7nO3jRlL/7FurH8RFwuCnxDeLY5oZh7
         DUCg==
X-Gm-Message-State: AOJu0YztlVo7cOiW+jQSyS9FgCm4VzrdLzZeZUDKCyz1ZUw130wuEDZZ
	wyx8RGy8EjDXJXAEuAVoXN52SfMZLoiMNAqBics4D8aLZD19C3aOGSxqHR4nDbBA
X-Gm-Gg: ASbGncuz+bUdRT2hJ0nNhmqyH9Djf+EUWki3OMcUP1c8E1ZQpFXhzhrh8A2Ecfp8jwi
	IUTpfhJDFTzd4fJbHLjI6v/MWXlzqILMQYozgN60OPuxjryxibdQWjKAVtBwRyesk6XYLuD4LtB
	hAyzv6C+Tkh845nmtUAM4h3xk2T5dNkCgZ/amvCp3fvhVwK0d5lSoQET7L8ZAodlfA08io4wyv8
	p8P+5E8s6A56xOGdU3+xlMejdHCMtGABju/C5Q2gFLlC6nBZTtVm1kOMfQ1DOkhdyi3Msz1bGFG
	KFJCzhNnpMiuWwtyUQ7HDmAFm3uMvN6311j/E7Vynuataf7Erdul5QDzo2NqlFI31Lu4IjxcOeX
	u1RbUd+TFrMb1PDt/fm8uBcYJ3yB8GExybEvNOhzcLYbT/+1Lyg9kiFaChdDf/fekmCsyDo4xWM
	9PvMN68xp1sERkqg==
X-Google-Smtp-Source: AGHT+IGcrgNmcOKJ0ECroJph3cXC6mWJkQ226emMCNERYGrBCtZmwyy551VHmMkkg4Hh2B+wNbAtqg==
X-Received: by 2002:a05:600c:888d:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-46fa9b939e4mr128253975e9.0.1760454249424;
        Tue, 14 Oct 2025 08:04:09 -0700 (PDT)
Received: from [192.168.1.178] (host-87-8-168-238.retail.telecomitalia.it. [87.8.168.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb55ac08dsm238623335e9.13.2025.10.14.08.04.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:04:07 -0700 (PDT)
Message-ID: <a1307c8d-2c6c-4fc7-968a-4101465e62a0@gmail.com>
Date: Tue, 14 Oct 2025 17:04:04 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: it, en-US
From: koraynilay <koray.fra@gmail.com>
Subject: high space usage after ext3 btrfs-convert
Disposition-Notification-To: koraynilay <koray.fra@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I btrfs-convert'd a 475 GiB ext3 partition which had a few GiBs 
free, after the conversion I removed the /ext2_saved subvolume and 
balanced the fs but the free space went to 0 B (statfs, df) and 1.61 GiB 
(estimated) and the df value would randomly jump from 0 B to 1.61 GiB 
for a few seconds.
Here whenever I tried to do any more balancing it would just fail with 
ENOSPC.

So I made a 488 GiB partition on another HDD and added it to the fs so 
that I had 488 GiB free, but when I deleted ~215 GiB, the free space 
wouldn't change.
I tried to balance a few times with different percentages but the free 
space would always stay at around 486-488 GiB.

So I did a defrag of the whole filesystem (using the command in the 
btrfs-convert man page), which made the free space go down to ~200 GiB 
and after deduplicating using bees (until it finished) (there is a lot 
of duplicate stuff) the free space settled on ~370 GiB.
Now the used space (according to btrfs filesystem usage) is ~600 GiB and 
btdu reports there are ~282 GiB of <UNREACHABLE> space which should've 
been fixed by the defrag (according to what I found online).

A normal ncdu scan says there are 380 GiB used (402 GiB apparent).

Is there anything else I can try to fix it or should I just save the new 
files, restore the ext3 backup and redo it?

Thanks in advance.

