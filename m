Return-Path: <linux-btrfs+bounces-18186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D706C02275
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CE750272F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED6D33C529;
	Thu, 23 Oct 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/PN+dW7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1C2459C9
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233664; cv=none; b=TmJPwzWNO7pzTvzyNooyU5pVrBM8PV084IdUPMRMFAHp3GRAgYLvonWkODg6yxHQ++eym6ecQZIBXWAc4M4Wj05tzijaMf+uL8pZ52l/BIisBDP5faK9kVClVFrW4WDPGrvRa/kITk/N0qYyv0+bZZEhxSlvBVg22y/lmdmSaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233664; c=relaxed/simple;
	bh=+FWrq9t+LpEEPkX1kLDEfprCCwBEjif0N3WmRzg2vRE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RPcYJQxFNAgxIegZsZ/0SkywOB/thzpJq1Fa0sDadkj4LgW8R65kItArx1dgCE6b3bWzAhQryECn3XuFIZ16EqGEremIT6XZOMLJstar30GxfQlDu95iT3mscDHNBqfvYf8kQpV9gMCMnZHhOvsyjkwWAhYhm8eyIZX5arBfeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/PN+dW7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b35e176dbso1284154e87.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761233661; x=1761838461; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcsguXi4wRVn67EPCkjWEWJxtm/162QjxoyyBYOm4oI=;
        b=C/PN+dW7YNYePSpyKzMnPWkLCMia5gtjmOqOUVZurnfBzc6CF6Ja/zeDnNC3aKmrVi
         2EUn6+1VKT9PK4gYyRwDPoQzt5xepxcmlR3iMO8q8l39f8f8eAOOIbiCHyJ/dkIMIKOW
         vJ3czPljDa9TC9tbfwqDX/LOA/GL7eq7XK2bdAVb5yLNpf9uxQU0WahWr7G51PGC3H4U
         EXVlYDggYd6cyJU0JDa7wzLCKdTA7lfG3AFfL5KUML9hExgX0t+4HWSExpbwAauY0mZI
         yQWjA8QqZsrYNDI0ScjHJYgWtghFULhCgTp5yEyU1+FpwcHhJcGNrUaSn9T3ZiWtl5g+
         T7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233661; x=1761838461;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcsguXi4wRVn67EPCkjWEWJxtm/162QjxoyyBYOm4oI=;
        b=lZRhljjpPpIrSnC3EKQBcu+UPXoLDbtfV0sDxiC1LcOV96ieTfiVW+Vgvr96V41BS3
         M2DxYJC5ntVKAP427ABPfa0Enk4fbqgWFIjrwcNwVnN7+hXuU6aLK7iTqy8WdiA5PrNJ
         aHnKsf4inyoZW1GdAVZt8e1xdA/qoDbZu2U8xxBOQSTBvUZqXP0r0zBClrQfp6IirKTg
         ozwuWTuEQyM3HxE92BXrgx+RPHG0lVZx/MO7a0G2s5mo8l83440lb1dV0KaIYkg+nU7S
         lnAeX58Wo91ti1iaem4qSDbEt9LyqK7fzf8A1QnxEzcyZ4PNygKafyrx98C41ebyx7ML
         gm9w==
X-Gm-Message-State: AOJu0YycjpsnnIIqO8ToM+mFWzzmNJDA1Z7+ujQaNomku13Fvsa3KEnE
	CF7uqN6hwh+PhbZOhYSGR0U8KD9iEEsH/iJTphR5P5DSOky0Ls7ckpf8
X-Gm-Gg: ASbGnctVptEPtEtHYMejjoJGb8DaCl7vXrsb5qfas7kyAYrZ//2s10KD26FoUb5VSXq
	f0gvGxsPUe5fbheRPsVERDaSv/Jj0/R+iqJUe2wNDuui5LsfsQm7/Cr/Zaqke3qVbSNRqvFilbS
	cJhOm/2nRIGBmnyW0obFzPc3h2mt6MmJqji0LGBwXZEy30burnMNCG+GGklINdZNAV/Inzw+wHq
	0rQk44wrqClByEsdGmF24FGEAhJWUbVL03x53EgK34/RiOhlVp2a0ppsAdYEi5D8M2V/ZTcRgrE
	fqGudU6ijLBnegOqXEDiaiwBRfcJfly4EiTKm3bdzh3dI3fnDhjkYcd39sOpEGPF9Q7I6VjDcqz
	MzAtUThMMWTTZDLJ9nTktVnlNyCNuprXuw1zCK/nqTJH41/ePERw7mlIp64aA/mNCTMNiy+hxn1
	llBNkeHZrFi4cgiuQpzZRlsg==
X-Google-Smtp-Source: AGHT+IFg2iGaLSTCORRq6yFX+F0ZfolbELu+uhZ3vqVTBoLeRZ/i1Z92m8xQW1IjBnuZFmYlMihMfQ==
X-Received: by 2002:a05:6512:b1e:b0:58a:92cc:5819 with SMTP id 2adb3069b0e04-591d853543dmr8845614e87.36.1761233660774;
        Thu, 23 Oct 2025 08:34:20 -0700 (PDT)
Received: from [10.128.170.160] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d20743sm821516e87.86.2025.10.23.08.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:34:19 -0700 (PDT)
Message-ID: <ac949c74-90c2-4b9a-b7fd-1ffc5c3175c7@gmail.com>
Date: Thu, 23 Oct 2025 18:34:18 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Subject: Symlink entry is not persisted after rename if system crashes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Under some circumstances, new directory entry of a symbolic link is not 
persisted after rename if the file system crashes.



Detailed description

====================


Hello, we are doing research on testing file system crash consistency. 
During

testing we found this issue with btrfs file system. In short, a symbolic 
link

is created and renamed. Directory entries are synced using `fsync` after 
every

step. However, after a crash, the symbolic link new directory entry is not

persisted (symbolic link has the old name). Read the test below for more

details.



System info

===========


Linux version 6.18.0-rc2 (root@ubuntu) (gcc (Ubuntu 15.2.0-4ubuntu4) 
15.2.0,

GNU ld (GNU Binutils for Ubuntu) 2.45) #2 SMP PREEMPT_DYNAMIC Thu Oct 23

12:32:29 UTC 2025


Also tested on Linux 6.14.11.


Operating System: Ubuntu 25.10

CPU architecture: x86_64


btrfs-progs version: v6.16

-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=builtin


Tested on QEMU emulator version 10.1.1.



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

int root_fd;

int dir_fd1;

int dir_fd2;


status = mkdir("dir", S_IRWXO);

printf("MKDIR: %d\n", status);


status = open(".", O_RDONLY | O_DIRECTORY);

printf("OPEN: %d\n", status);

root_fd = status;


// persist `dir`

status = fsync(root_fd);

printf("FSYNC: %d\n", status);


status = symlink("foobar", "dir/slink-old");

printf("SYMLINK: %d\n", status);


status = open("dir", O_RDONLY | O_DIRECTORY);

printf("OPEN: %d\n", status);

dir_fd1 = status;


// persist `slink-old`

status = fsync(dir_fd1);

printf("FSYNC: %d\n", status);


status = rename("dir/slink-old", "dir/slink-new");

printf("RENAME: %d\n", status);


status = open("dir", O_RDONLY | O_DIRECTORY);

printf("OPEN: %d\n", status);

dir_fd2 = status;


// persist `slink-new`

status = fsync(dir_fd2);

printf("FSYNC: %d\n", status);

}

```


Short test summary:


1. Directory `dir` is created.

2. Directory `.` is fsynced (`dir` entry should persist).

3. New symbolic link `slink-old` is created in `dir`.

4. Directory `dir` is fsynced using descriptor 1 (`slink-old` entry should

persist).

5. Link is renamed from `slink-old` to `slink-new`.

6. Directory `dir` is fsynced using decriptor 2 (`slink-new` entry should

persist).


Steps:


1. Create and mount new btrfs file system in default configuration.

2. Change directory to root of the file system and run the compiled test.

3. Cause hard system crash (e.g. QEMU `system_reset` command).

4. Remount file system after crash.

5. Observe that `dir` directory contains entry named `slink-old` instead of

`slink-new`.


Notes:


- In other file systems (ext4, xfs, nilfs2) the `dir` will contain new

(`slink-new`) entry, not the old one.

- The problem only affects symlinks, but not regular files.

- The problem only arises if `dir` fsyncs are made using different

descriptors.


