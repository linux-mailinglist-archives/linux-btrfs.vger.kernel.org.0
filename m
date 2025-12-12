Return-Path: <linux-btrfs+bounces-19696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B37B1CB8803
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 10:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A310530CCA74
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9315314A6C;
	Fri, 12 Dec 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm7x1uSa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D03148D2
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532057; cv=none; b=KRifQszUJuAil0UWwBeGXpgERA31p39c3S6GpHli172eR5m0nn1rXxIFElub6DCU1830HubkqFsqWnhDFO31x0TsLT5Z/p9sQppsPB+uZX9SR5jCCWDR1+hCgUCwPmzzJpAkvxNLvqYqPoZkhaS4tSmVMjpM2zUGoPmExZg8MjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532057; c=relaxed/simple;
	bh=DyuyJZr/zGOCjSvf0bfQ4OmRhKJdxqwmWDZvUn80e9g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qVUM/oHUOj0k9kwp/TWslmNbU2unKtl/7Tm8tUUwou0vtxCY5iAuNXsGMRHbPnyrNIAjl6bd6U0+rQSA4kyd2a0Y8L2JtlqAmvp27rCRRnTCO5RzUE0T5wJj9R9F2xtKnDIgcM4G1A60+JzhMEaUM0say2pV7UtBBW+pBdpqLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm7x1uSa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59584301f0cso990373e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765532052; x=1766136852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AWttxVRHI1d6ipzZzd8zoDg1U+sxthQSDMa6ba25Zk=;
        b=Mm7x1uSa+3SuRbfpJUQ0eviwi4bQTMqFPVAQZ6P336uqLcXFs4mOxH86PMNe8fau7a
         zg9HaCCzFoBNCEQMS8Z/emRKnccWD1bPLadQ7dXFmUuquX+vBzLzRpF+DAn+94jJwJ51
         XubNFWJcr8+uTekSVBdtJfDYKwxOdAvtpILSGA/LjoAywwVhxJKDu97Gzx1bKxZgwmIm
         E/7mp755Ha+NZJMaIpO+jVknLl22RqtD9qJHVx9iizhMfz0Znb2GVZ/TZ0FrzmyJ6mpy
         DgyOFvUZtd7foXsVfC2NdBefwmbUDdP4awPFXjRk7zV1ZTCzA6TzcQ7q7OEft/gbnKxW
         y4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765532052; x=1766136852;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AWttxVRHI1d6ipzZzd8zoDg1U+sxthQSDMa6ba25Zk=;
        b=S6QlswBAQ0jvKQEtDnWrVC+MqbwTK9nCHB8RXvrDIzSUjbTN8ULywB4ggISotAu7/u
         wYXv9U9JaCn27sRbyuIIhKVEVKNWgnt5MTE8rqY+2uGfKuPvObBnh0apy4YsEGkHc/M9
         /WsNwYokKFRIge8iyyRK0AgEuVu7GcajdIaa20wSRgTbJ6QHhi5fDxyjCrjO6dPEErxv
         bTDYfU97LeYzG7g7EUm/R1ic/oG0Gn/9QmuCuzZS2geBFtBlP0+7AlC6HBfTmtleRjlz
         Q9eA0fMNiwcn9q+ot8/GZg1G5WlIiv26g28oViU0dJeCllAxHSU6/Lw7AZF3hM+2SHg5
         tsHQ==
X-Gm-Message-State: AOJu0YxtfrIl8Kj0eWJjVxKVVeKV3Q73W+i81AbCVqQYxlb+15zcFDea
	KijBLRyRs06+XDr4+GrwS7JjXzT75YChhqGj4DshNS+IsSi8lVuJgMJD
X-Gm-Gg: AY/fxX4ZpnQxDqOOQl4JUSWSYCBL1UrzajnWXFBlzM1LuBSy4z12qTaV9+13mJl3C7J
	pYJ192gSF4gzH63I6JemQqhmEnH4WhB+C+iwJLUHOU2Ma3a1ZBWz1irhkV6CagU/UnTMRe1Bftr
	LaPZKUmh9kXUGBhLNGYSt9Ocl9sB3wh4g5fL/8CqXIc3Etyc4QjjuN9wh3YTMiV16bp9HkrSlGP
	n6I9GVDuIzj0iMY+EcfvabbwIyWZyRyVAvc2VCow2jSlxxCnJL7kEt1JZsCdxGHe5ZEOgWg9E4Y
	iX0Az6/nAYgC14+I7kcO1Li5RiMAJeazsF2qAaOoMO1i8o+gc3N6U+hwo2k2dTn7nB1mmcmACfY
	lgVaDPfmqiNo4T0d3ctaYm9SfkCDxIFITnPxOsdF6EtpuC2S63DvVEFthD1qGM7LKKAKxTnKl/x
	rVuSOZC/cqf2E1GoFGiN1QU7BRU9aBa1os
X-Google-Smtp-Source: AGHT+IFeRom6bEgV+mWLlLO3RNs9UQhbtwjLhvGhRqNIy39ug72iCpbd6Zn3WnEwHxfKr6i1NlSCsA==
X-Received: by 2002:a05:6512:3c97:b0:598:853e:4868 with SMTP id 2adb3069b0e04-598faaa232fmr410566e87.53.1765532051623;
        Fri, 12 Dec 2025 01:34:11 -0800 (PST)
Received: from [10.128.170.160] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37fd2be23d5sm3248621fa.28.2025.12.12.01.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 01:34:11 -0800 (PST)
Message-ID: <3d517755-3ed1-46eb-9fee-c4e56193ebc4@gmail.com>
Date: Fri, 12 Dec 2025 12:34:10 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Subject: mtime and ctime is not updated after truncate operation if file
 length was not changed
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Detailed description
====================

Last data modification and last file status change timestamps are not 
updated after truncate operation if the file content was not changed 
(truncate length == file length).

ext4 updates both mtime and ctime. But many (if not all?) other file 
systems (btrfs, xfs, nilfs2, f2fs, ???) do not update any timestamps.

The latter behavior seems to violate the POSIX.1-2024 standard. 
Documentation for `truncate()`: “Upon successful completion, truncate() 
shall mark for update the last data modification and last file status 
change timestamps of the file". No special cases described for (not) 
updating timestamps. `ftruncate` behaves as expected though.

Maybe I should also report this to the developers of other file systems.


System info
===========

Linux version 6.18.


How to reproduce
================

```
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
   int status;
   struct stat file_stat;

   status = creat("file", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("CREAT: %d\n", status);
   close(status);

   status = stat("file", &file_stat);
   printf("STAT: %d\n", status);
   printf("atime=%ld\n", file_stat.st_atim.tv_nsec);
   printf("mtime=%ld\n", file_stat.st_mtim.tv_nsec);
   printf("ctime=%ld\n", file_stat.st_ctim.tv_nsec);

   status = truncate("file", 0);
   printf("TRUNCATE: %d\n", status);

   status = stat("file", &file_stat);
   printf("STAT: %d\n", status);
   printf("atime=%ld\n", file_stat.st_atim.tv_nsec);
   printf("mtime=%ld\n", file_stat.st_mtim.tv_nsec);
   printf("ctime=%ld\n", file_stat.st_ctim.tv_nsec);
}
```

Expected output (ext4):

```
CREAT: 3
STAT: 0
atime=122561651
mtime=122561651
ctime=122561651
TRUNCATE: 0
STAT: 0
atime=122561651
mtime=124063093
ctime=124063093
```

Actual output (Btrfs):

```
CREAT: 3
STAT: 0
atime=502902570
mtime=502902570
ctime=502902570
TRUNCATE: 0
STAT: 0
atime=502902570
mtime=502902570
ctime=502902570
```


