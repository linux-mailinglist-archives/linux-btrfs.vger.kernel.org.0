Return-Path: <linux-btrfs+bounces-22175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBjhIZvipmlAYgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22175-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 14:31:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0001F044F
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 14:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E287E308E4BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058EA22689C;
	Tue,  3 Mar 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7i+qtAE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB291552FD
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544619; cv=none; b=DAwzuY1zXLQKpIrEmIa3P1CveETMWW5+qQtYXXxC3k/SD+FpsGcghhmQsnaQcsWmv7nhG/Zc/d4HBn1PKFwOFkfMU7hs4ZiQrSkXpCB/pi3ZYBfZfbaN++eOSisZKfwRNR6D7+cA44qVJ550c87Vw9uiKVYCv+xJ3R3Z38OEuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544619; c=relaxed/simple;
	bh=ixhAhBvj0kOWXVjENEQNIiFRxvpV4SOUeVdtzhsGt3U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OEn2ifn0Owbv0oETGi/LAUDA3SocAkO1ErMcUD5OcHxfaaYr463ZmWVWiLJBst0c3qun+UNdPIHH1tAeNHbyT24HG2GzZD51a4TicjDkR9lz2iIC5c3NWhS7tgfAie/AyeUhufUbnwyuUooec9bXU3GdoTs/UcILKWPw2zFvtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7i+qtAE; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-389fa352b0eso83977021fa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544616; x=1773149416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdSFjYFBZYcw/JXwZRKv2ld6zUwdugjmGmj0vow6qOE=;
        b=G7i+qtAEivvVwLTz2ZegFaVtXcEOixbvXr6ULohmYH/cn9OnsYrfoaj32fG7i8vepX
         BqnfJeTc9WXyDQkcNaBAPcQCDSH95oC4KVLMmKTcZbkX8goWXAd8rydIOnEf7FuQBMSN
         kcs6KIATvqPBk2taKKI7P+t7Lg/XZN51wfap+clrdm9dsH502DX/cgGtTfjs6optyyIE
         rNC40BSuHsvdex/CxgHh85vgO+qj8E0AiL7qBJmBeSiCGt0Kg78dDXbbhY/amBq2crNZ
         18uGT/YZQLHc8ylC3G0Y82dl1Dscj9XKq4WUe6JCyqOt8yUbZiag0GqqCEZKbdqFng7K
         rz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544616; x=1773149416;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdSFjYFBZYcw/JXwZRKv2ld6zUwdugjmGmj0vow6qOE=;
        b=sv3j3W2m0aH8uDnEMQ2N3x1rS4OdLMsOGJuf3CFLTX8UKJ6jfgCWcEI1/dxI/hOvv8
         jarcrOWxfw9JjJvMF+YzMTFui8hxAwRJhBTz8Wr4jmw7GP/gPi6Fla+WYRmwcPwvjY4c
         rjVlFjIH9K8bqBI7SCZ/xJYqQPK9akyp67hrFtDRXxZsrtqzHy7gADLlZL/7JSCEGjTd
         1ROb5jyVGTSSHmZB4VgxbId5ZmnQS98HQLcUO/pAd34bKn7ujvmeqsC8nFsPJnRITVgm
         M/lIW8oMoyUOS36HMZxw7qfY49Ip0LzK/qDocM6OyHd/UY34VybxAxtWbd+cF43KwNwn
         8L+A==
X-Gm-Message-State: AOJu0YwjImHiHgnIxl/GBA0xbLUVKmh4fOs3LBz9Z6Cbynmdk8l0f7qz
	/OCvtIs/qIbECh66VWBmmOsdLQTNOlcDUYJTe6ZYIb77arrpfeBYgOZ7
X-Gm-Gg: ATEYQzxESC4sGB8pMhsRREyVdjdi7ZvSkCcGVcGBdNAy9cj/vbhKYIDcTOiA8nWtXYu
	r2uEp4FgEiC/N+Bd01SmWC2o1F5drEr6AXT+L2xgZj2Fn/c2+DZMSI05CcdT3bkmz68OTge01iY
	mh9pClLCLRo+fTEXBZZtTG8EUb8cPvi7yS5G+x/0C7Nj1bOY2tcJy9l+hwgiFgJYgEZA9P2ww7C
	8rO1612TBpZIhXRPgCiopBULYn5eI5ktQKLyadM8T4eV9ReZNd5sQZukMWW3Wi3oj2V8k4eQcO7
	tuD/hnumRewYoW4/jInsmgGatgfRAXIG1Jk7gb++xU/kkauOviHzrWK/U8gwEtbnybQSgZ3DQLS
	kACxlAYEL3D2CQ8Bkwf9zCz+PupGx0R9Dc3zYCQ/nJYip177gKgPpjOjb7Y8buIVzWQ1wvkFIBI
	AWASVHQ9KBGvhSKs5MPYvguIzrReYxaRguqbrckwBIijw=
X-Received: by 2002:a05:651c:3044:b0:37b:a955:d497 with SMTP id 38308e7fff4ca-389ff142268mr97884211fa.17.1772544615848;
        Tue, 03 Mar 2026 05:30:15 -0800 (PST)
Received: from [10.128.170.182] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235914c1sm556831e87.10.2026.03.03.05.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 05:30:13 -0800 (PST)
Message-ID: <182055fa-e9ce-4089-9f5f-4b8a23e8dd91@gmail.com>
Date: Tue, 3 Mar 2026 16:30:09 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Subject: Directory is not persisted after removing another directory and
 creating a hard linked symlink with the same name if system crashes
Content-Language: en-US
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED0001F044F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22175-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slavakovalevskiy2014@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Detailed description
====================

Hello, there seems to be an issue with btrfs crash behavior:

1. Create new directory `foo`, sync, then remove the directory.
2. Create new directories `dir1` and `dir2`.
3. Create new symlink named `foo` (NOTE: must have the same name as the 
removed directory).
4. Create new (hard) link to the symlink inside `dir2` (NOTE: this is 
also important).
5. Sync directory `dir2`.
6. Sync root directory.

Directory `dir1` will be missing even though it was synced in the last step.


System info
===========

Linux version 7.0-rc2, also tested on 6.19.2


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
   int dir_fd;
   int root_fd;

   status = mkdir("foo", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("MKDIR: %d\n", status);

   sync();

   status = rmdir("foo");
   printf("RMDIR: %d\n", status);

   status = mkdir("dir1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("MKDIR: %d\n", status);

   status = mkdir("dir2", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("MKDIR: %d\n", status);

   status = symlink("bar", "foo");
   printf("SYMLINK: %d\n", status);

   status = link("foo", "dir2/link");
   printf("LINK: %d\n", status);

   status = open("dir2", O_RDONLY);
   printf("OPEN: %d\n", status);
   dir_fd = status;

   status = fsync(dir_fd);
   printf("FSYNC: %d\n", status);

   status = open(".", O_RDONLY);
   printf("OPEN: %d\n", status);
   root_fd = status;

   status = fsync(root_fd);
   printf("FSYNC: %d\n", status);
}
// after crash `dir1` is missing
```

Steps:

1. Create and mount new btrfs file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that directory `dir1` is missing.


