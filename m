Return-Path: <linux-btrfs+bounces-19482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E6C9ED72
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 12:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 703B33496B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F62F39C4;
	Wed,  3 Dec 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf3/q3J6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB636D4FC
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761188; cv=none; b=ZNCpBaDYVZLvx4LZimOvBfMKO5LEtvzbrX0w0U4u92QlPLnhU+tAGXIlBAFVNVVKLvRwxYi4kl5WnKYiJZBK7l0Yau35o9Ch2IQl+OvuAKXAqPdkDSR2aZkN0axzItMvLdoogZTTevBhEy+LCrezhGXo8uHC24koUXMdf46GY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761188; c=relaxed/simple;
	bh=vgRlZloTI+VMwHD3FCjNwwDWn3CtZXJord3wWo74wds=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=VEc/Vc8+TxDaR3WDSmVQadd/249wlvvCbaXrSDEbQRyn+/HSjdn02cjRTJ9LAKQxUNFSFGmLHUnNgpS8F4SP4IG6EtXMvp6Kq45MGhhYjbNSvc74RSR0NKp76tHZzKxej24BdyoHEELVPVY2DBK+bwk1sRhFj0uB16SBAAuEODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf3/q3J6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5958187fa55so4159545e87.3
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764761185; x=1765365985; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhIEIr30EK2YFUF+AiavoLZElSeoj3prKR2BxIxzB4k=;
        b=Yf3/q3J673+6W9cnOrRBmWuOXm0Jsm7Mx0Vg9vu6QQZDAwoBEyWeG06FOK6aw9ujHD
         KE6INlTqKMGErVM80JjAhBlNGFatyAYhLlsntoLKxNPA25JNjaAUvoNEVWTV2kRcx9Xl
         +0mLPCVx+xGU+6kjJT7Hn5zWNKFMjaHpJ2udv1x/0DBYjccEf182xpMjQnLYjjN9iDFO
         j5Mcy8SVzXqYtNovlV7XwUeySuW5E/8wMCtbAOJ5oVEERdPH0Gy2nHM/Uiz0wV40T12D
         6U1E/TGoUVHpjsKpXL4GvIgHIc6FgMzLbqjkPen0yswXT5eTH7ZuTfL12ooDRgpDS8dD
         eH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761185; x=1765365985;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhIEIr30EK2YFUF+AiavoLZElSeoj3prKR2BxIxzB4k=;
        b=S0QLz4fPcNVYwK7XsFq2LMymVstI2fTd/XpOjsvzkRwcLVN95DlgS+T3pPYKqBAdqR
         bmTCXZMTG7VKwNhKZ/+qIGjf3PKaJyVlhS0xa6coH9wDMHUXCJRL+zkahlxc6bzrBc4h
         0TELW+9Jp1olIwf6XsnGC5+EamkIi5g5mw4W5DYZukgtPigMMbBmMveqTi6VaX6ZLpQ9
         12ChH5NcxBX/3c86OK/7EhIMGVt51n7jQshuFc+3mexHqZhB7CBrMxC1hofe9H+BmX38
         7j0ssymtGt1L6esi1kA9/70SS8xZBwFTAa5QFPEiX5l19YrRovdQhciyfKp2Cbo/3Ysl
         b3IA==
X-Gm-Message-State: AOJu0YylBNm/mIu/8AhHzZzzQqYyOch+WRwzCo+VbRdN7GlMa3WJFNEy
	yUtK2HqKUAT4c+K7a9iZUnzrJbDkkQcgZe2Y0dfcwE9jExtQI3MrgD70
X-Gm-Gg: ASbGncu8uC4SYZBvcjB+Ewj7rOGrP4cNMHxy44N06lGekB3OziiWWK7nrBe71a+R79v
	c4PMPdczkJSPrCiub+CjEC75f+PJH+rK95cUpUNUN2SD7VvsH7JUO2frZl0Dh1EMOBdoDtzl73u
	kXjhtAuWEbmn8va064Kh0ji5ajYg0tzPRqiqQz+Wa6aXtGEDy7L0zBqe3ZAVEeVqWwT5JQrXMqD
	d7h5fx8PoUtsj96imc+I1aaXfxiniwFINNh8zE3WzRT2EeBY7VBmEMTtOntAGtUo51W0EBDY1oi
	0iC32S37tr9DjsmysTDVuzAO35OLHOzQGgSA4sgpqmonyxvPgdLWXBUcp2oWBzRSHmLfOtjuBcc
	03syCGuLMgsEe5E+xBKAHWsGBCdAdNAeAUO5do+cODWN4MMpgFbWSm/n46ZInOKusMg0NiEfKLr
	8DPBPhD2AL4nsYn4Pua9xXRsAeX5UEvlYe
X-Google-Smtp-Source: AGHT+IHtFrMK/G54Aab8Rllz+zFVNRtz8oZcJCrDALjIMMr6Av1YFpJWF1SGnPVmhbWJUe7wR9EXLA==
X-Received: by 2002:a05:6512:1088:b0:594:347e:e679 with SMTP id 2adb3069b0e04-597d3ff2fb6mr738197e87.43.1764761184567;
        Wed, 03 Dec 2025 03:26:24 -0800 (PST)
Received: from [10.128.170.160] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8a7c7asm5615807e87.15.2025.12.03.03.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:26:23 -0800 (PST)
Message-ID: <84c4e713-85d6-42b9-8dcf-0722ed26cb05@gmail.com>
Date: Wed, 3 Dec 2025 14:26:22 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Directory is not persisted after creating 100s of files inside,
 writing to another file and renaming it if system crashes.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Directory entry is not persisted after creating 100s (hundreds) of files inside, writing to another file (with `O_SYNC` flag) and renaming it if system crashes.


Detailed description
====================

Hello, we have found another issue with btrfs crash behavior.

In short:

1. Create and sync an empty file in root directory.
2. Make new directory in root directory.
3. Open the file with `O_SYNC` flag and write some data (of specific size).
4. Fill directory with specific number of empty files.
5. Rename the previously written file.
6. Sync root directory.

After system crash directory will be missing, although it was synced in the last step.


System info
===========

Linux version 6.18, also tested on 6.14.11.


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

#define BUFFER_LEN 1024 // should be at least ~ 528
#define FILE_N 256      // should be at least ~ 128

int main() {
   int status;
   int file_fd;
   int root_fd;

   int buffer[BUFFER_LEN + 1] = {};
   for (int i = 0; i < BUFFER_LEN; ++i) {
     buffer[i] = i;
   }

   status = creat("file1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("CREAT: %d\n", status);
   close(status);

   // persist `file1`
   sync();

   status = mkdir("dir", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("MKDIR: %d\n", status);

   // `O_SYNC` is important
   status = open("file1", O_WRONLY | O_SYNC);
   printf("OPEN: %d\n", status);
   file_fd = status;

   status = write(file_fd, buffer, BUFFER_LEN);
   printf("WRITE: %d\n", status);

   char path[100];
   // fill directory with a lot of empty files
   for (int i = 0; i < FILE_N; ++i) {
     sprintf(path, "dir/%d", i);
     status = creat(path, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
     close(status);
   }

   status = rename("file1", "file2");
   printf("RENAME: %d\n", status);

   status = open(".", O_RDONLY | O_DIRECTORY);
   printf("OPEN: %d\n", status);
   root_fd = status;

   // persist `dir`
   status = fsync(root_fd);
   printf("FSYNC: %d\n", status);
}
// after the crash `dir` is missing
```

Steps:

1. Create and mount new btrfs file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that `dir` directory is missing.


