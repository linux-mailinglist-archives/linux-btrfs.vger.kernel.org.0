Return-Path: <linux-btrfs+bounces-18292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8156C06EFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B458B3A9653
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E222322C60;
	Fri, 24 Oct 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ioj7k02r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851B2E62D8
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319151; cv=none; b=Q/Fio0xd0vwDF00uJWtRry+j8LLd604aiRqZet7i4YRIAWG+15mPj2aOk0GwobbIjr9+6rAJpmPcN9EuG9jvQlp9cXJxrNKZ5l7s2IsFT/LwTThflxNkaGRVl10tFMamPnd0jNfE8lE0zR8ssUdwQXGJ2CUKsangAFpo3uKCU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319151; c=relaxed/simple;
	bh=A1nZgSHLk3Ea+o8JUU07BQK973AUy09cBcqjoCtV9uI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=c9vYsqLMYRGXaFzeEwVuGZWMNY4G7cwkahT62+kxsNxHHgwuq8KurA0yQVtquCmvIV4la25RXyEDnXKXtNr4lMSnWSvBkyxDxCrf5aTPmrsRh4l3WFMZDJpk3qosHm+ERjsZv5FQ7eVtGeAj7IDEqWvCBIG2Qr1icopgVBxKUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ioj7k02r; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592f7e50da2so2331894e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319147; x=1761923947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIwyZW9sidCDypOWd4vP2sZ/37yenpkNQ950ZzRaSzg=;
        b=Ioj7k02rDixVhB5IwqfivZLAaN7Qe4LQkpURMYF+1N/3z6nnUSY06Rr0Qb7rsU/x35
         B/JHPFXavilwhpTg2xbkfefRbopEugf01QF+ds6hW9wkhUy0PHhi7+3JFJklMRnPTHP9
         xnglpKLyXovdx6i2qC9IIgFr+E66G0IsMOrVQnvf1quSFXTKdaRJffTBCOZbWiz7xK32
         xlpkjLZcCg/K8EJ2qq8ZoYv9NXDsJ6eVjnpabnMt3TG2tSihfk2CA34/+4LlaeycZADQ
         dolIANIche/HvmA9sXzlGLSeV6MVyxP1vpBp4zpRhkYI5zC5OAEp0CgTEdzVDWM0Dm65
         1fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319147; x=1761923947;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MIwyZW9sidCDypOWd4vP2sZ/37yenpkNQ950ZzRaSzg=;
        b=cgCom3BZHGGLtJO3FLI//GVOIHYy37HEkTU3eUgeTgifFQxHpYyfT8b1J4tFRpoF9R
         KdUBc0N89nYcdIkDYK0QuXLqFlNiPMFOMZBOXAOyLgZiYnbwGTg0FwkY33SGDOSm2IId
         zyEI0Cg0RDlz0IwGcZuIHG6XIhLDyq13rTpl7a5H4grV8oCW2Por4bOj/++YgFt53Ouw
         JaJwqux5bafQrXe4IaxPDJIScgfwClKT6gQakzXyH07KbpCUdVJB4/QVaYSEYYw1MXhR
         qpoY2t9L0ZpSbb0Zf5P+kL9qYklWFsrhndrY8wv22kN5NG1cVMInz6B8RULMChUi965K
         JTEg==
X-Gm-Message-State: AOJu0YyzBjFOaqJqiznNAtxr5XXwLCgYr8hWSFzltJpjaIiRAj9l2b0m
	sxADSxDcCCQ0qNL1+IlP3UyaImP39V7MOiiwkkqYKLay2juEjOzzxxMv
X-Gm-Gg: ASbGncsHV/PrKfbn7M2edwmdIcvFF2qTmIH2+PgP9J8jMJxyyoWRWvi6tQhefLOiNk6
	to1yycOlzh4yoLG6C+jGyr8/9ja4VrbJRqyzuRZCkvYHShRDjgSM125KjE7fZUI/gN0YfK2qLpx
	aGCr2YmbNIWiwG6l08IOhxzraK0T2cIPVJiV+Et1R90mSeP2xnZXCsOHXnrRlKNsn7kr34Z1oai
	RWlnLZpXWuNzTqQ0KF8lWFAX3wQbvZmIF4IDnVA8vf1zLPxU0FRK8IAgjEIDORI+pZZ5gs6ISPP
	0Ga1OGYUbz9hLuX5bflrvPVt0hkqKvXlu9XNwpYN6h/suxdbZdwVPajruBt4DEiZxSr8z7JCNSs
	EACQm3KD4fP+kZ+r+DwNQ3YnGs2lxAKYwH1A1wekwUBEovhl3/iwTVx+aMxri8P6pdCoSaQzJjp
	oYPU03+iyBcfMgeAz5AIXLB7sjw7s0oDnk
X-Google-Smtp-Source: AGHT+IEMahbi2fLPVnugBt7nBQpOJJXmfytKLyhTafnrSXtfTi0+A8tdG0+Nc8NOHGuU6LWNqGXYIA==
X-Received: by 2002:a05:6512:1502:10b0:592:fc5a:b6bb with SMTP id 2adb3069b0e04-592fc5ab708mr774549e87.6.1761319146729;
        Fri, 24 Oct 2025 08:19:06 -0700 (PDT)
Received: from [10.128.170.160] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d1f3bdsm1731154e87.81.2025.10.24.08.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 08:19:06 -0700 (PDT)
Message-ID: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
Date: Fri, 24 Oct 2025 18:19:05 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Subject: Directory is not persisted after writing to the file within directory
 if system crashes
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Under some circumstances, directory entry is not persisted after writing 
to the file inside the directory that was opened with `O_SYNC` flag if 
system crashes.


Detailed description
====================

Hello, we have found another issue with btrfs crash behavior.

In short, empty file is created and synced. Then, a new directory is 
created, old file is opened with `O_SYNC` flag and some data is written. 
After this, a new hard link is created inside the directory and the root 
is `fsync`ed (directory should persist). However, after a crash, the 
directory entry is missing even though data written to the old file was 
persisted.


System info
===========

Linux version 6.18.0-rc2, also tested on 6.14.11.


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
int file_fd;
int root_fd;

status = creat("file1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
printf("CREAT: %d\n", status);

// persist `file1`
sync();

status = mkdir("dir", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
printf("MKDIR: %d\n", status);

status = open("file1", O_WRONLY | O_SYNC);
printf("OPEN: %d\n", status);
file_fd = status;

status = write(file_fd, "Test data!", 10);
printf("WRITE: %d\n", status);

status = link("file1", "dir/file2");
printf("LINK: %d\n", status);

status = open(".", O_RDONLY | O_DIRECTORY);
printf("OPEN: %d\n", status);
root_fd = status;

// persist `dir`
status = fsync(root_fd);
printf("FSYNC: %d\n", status);
}
```

Steps:

1. Create and mount new btrfs file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that `dir` directory is missing.

Notes:

- ext4 does persist `dir` and `dir/file2` even though it was not synced.
- xfs does persist `dir` but does not persist `dir/file2`.


P.S. Want to apologize for formatting in previous report, first time 
using Thunderbird and plain text.




