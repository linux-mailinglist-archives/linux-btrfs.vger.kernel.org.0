Return-Path: <linux-btrfs+bounces-21391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCGHGLvbhGkV6AMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21391-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 19:04:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB864F64B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 19:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D065B302411D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C330595B;
	Thu,  5 Feb 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GerMfZFf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCF305047
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314659; cv=none; b=eSez+Aej90lom1JAb3nS/Z0fB9MNFuH5BzqukFaYgPPi1jLcdhYLXeUonFKgjtVGlpiUJi3sLeJ8iJpzKO2KCmchEqG7SHqMyaeDyD7maI3faqJV7FE91AwXhEmGNnkjfsZRgRNjNM/VaNwlJ0Gs30VjTIR1iGLM1gzNNAiQvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314659; c=relaxed/simple;
	bh=2j4wexEGjnCGhvpNp7P1EbVN/TpBfEAUE89CZCrrT/U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=D0QIWKGvz7cEkDoxztFMjlAhCWK5fySmw4gBgMXNNHITidGr6/F/9DjQkKjrkQP9WwKFvoG6TFqqavTXnXKEpoXqn/87Xntijp5QZSncfKGZsiIqJ9sIUwFaRb6kjZOeRbxRIKV6MbSU81UJM7wCKPvTWkTMcXAvLaq7vAvr9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GerMfZFf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so2581351a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Feb 2026 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770314657; x=1770919457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFsJ5yIxjxRJ8JYO0hCEq7a26t7dTX8Nq9jQeRS/Pi4=;
        b=GerMfZFf3IM2Wf9ibKT18ekUAu0yBpHIPuAIuI0rYjCPznF1eO9uWR4Q9ZiBYnihql
         Jpc7xK1+NB4Asv4LaX/MeJzY4RZFXSO4UpfdHG3GdEZxQj5F31bbmQBW60Yl1F7kxpYG
         TnfR0KFHadM75Lnt8FvVpTZBtQg6FwjGFipQ6p4p1gA1YEWRD6THw1AiAYmH2oPMsX8y
         2KgyyTcJgb+bdMwVK5SKRAQcAL/cLNGeLAVw2Z2zUIgSl0QXC7oJvaL/X40VbjHO24BX
         5mObFPhwGfiZvIvn44ydIiGLSSuZ9CYtE9wF0gA2I2CkV0+799AnfgRLw81DA2e6+LU2
         oxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770314657; x=1770919457;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFsJ5yIxjxRJ8JYO0hCEq7a26t7dTX8Nq9jQeRS/Pi4=;
        b=nB7a81fZQ92KoyAUnnWYxsETgRauei3KzEn1zniHGvM6Pm7TJ8sRauP2FW3nL5wFbz
         ePfqD/W00zwQSJ3tgJvt6vrwjaz1kjmF0Ezpbx/TcnWYZLFXmXtFbMd7oWxRqwWCk2Ro
         70Oe1swICsAGrfVG4B0p+tZKrcmpS2IrXNPLaOj4xVl7XFU4CtrOveZ+56YJSMI5JarF
         fpBr52VfonfBmPcx0dJnjQPqCE4RWrebfXzakwqc0OVqwjVuZ4Ntrwfl3EyiwzcRN0ZH
         VDIWAeZtJ3s6CQ9nj6NlDtnE7155GwdoPQDvhka/YOh6AAnuMgfKcXLLRpgCFCJMNpgZ
         ewcA==
X-Gm-Message-State: AOJu0YxzfHnndVmDU0XfnAMggORbZ/yG/0RZA1aSpDSBGan30fan/izs
	RYwoxm0SQOB0Ys5patonvyaqmL1LwwwVitM1SiYwTyAPNmWBFqK5FOOJXxWOhQ==
X-Gm-Gg: AZuq6aKB7wNJr6y6aBENnHNwaH8H59mL4FgtvFiTHYNFW44r7/Ju2LvsrsYlL5tcSnH
	PM5kUgH5F9qAC68uoI/YjCUz2gChQkb9mVMzUeCBKNFkpehh5mwRo/XeqW3Sjv/+VQDbf7Io1kr
	Rs3B5dWZ8vEM85VG9BuIVpgccFbLC2Eq13aIDLbJqyr8FpI4hlxcM+grXAnj/qKqxtoy1FTekFW
	d7HPbTVqpt5qX3sxa6hvJX2kGQ6OUc/wgKpJLyKbgz2ClJldWGc/mSToX7eGfE/7IW9nv8k6KoB
	iI6ckhjRrnu1Xw7rY/Lf2+ypO9X4Mgdx6kCKRi6Y9ntoDwM+GxGBXULXDmlNQnmTr96tRcpavqV
	l38yqPak//eamCpUM+lf9zHt0fUcgp2M1Aa23Ijr8S32uHSmm77wtohiyhjZTyXmPCz4FulQ1GS
	gHwD3AUcS3bGdZKq4KfPuWZ236f7A4JBupMpPWlVBU0GDK50PgLXmICg==
X-Received: by 2002:a05:6402:2790:b0:658:b8de:179a with SMTP id 4fb4d7f45d1cf-65949abd4f7mr4659503a12.11.1770314657230;
        Thu, 05 Feb 2026 10:04:17 -0800 (PST)
Received: from [192.168.1.4] (109-252-133-207.dynamic.spd-mgts.ru. [109.252.133.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6594a228ed0sm2485020a12.29.2026.02.05.10.04.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 10:04:16 -0800 (PST)
Message-ID: <a1f42d52-9ca5-4b6f-b2ae-4a63b0f443cc@gmail.com>
Date: Thu, 5 Feb 2026 21:01:59 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: critical target error?
To: linux-btrfs@vger.kernel.org
References: <20260205141205.GA5656@tik.uni-stuttgart.de>
Content-Language: en-US, ru-RU
In-Reply-To: <20260205141205.GA5656@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21391-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arvidjaar@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fex:email]
X-Rspamd-Queue-Id: CB864F64B1
X-Rspamd-Action: no action

05.02.2026 17:12, Ulli Horlacher wrote:
> 
> After reboot I found in kern.log :
> 
> 2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Very big device. Trying to use READ CAPACITY(16).
> 2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] 33951716474 512-byte logical blocks: (17.4 TB/15.8 TiB)
> 2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Write Protect is off
> 2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Mode Sense: 6d 00 00 00
> 2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Write cache: disabled, read cache: disabled, doesn't support DPO or FUA
> 2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Very big device. Trying to use READ CAPACITY(16).
> 2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Attached SCSI disk
> 2026-02-05 14:51:03 kernel: BTRFS: device label spool devid 1 transid 50265 /dev/sdg scanned by mount (648)
> 2026-02-05 14:51:03 kernel: BTRFS info (device sdg): first mount of filesystem 68c59310-da6a-440e-bf26-5aae2f38c3f1
> 2026-02-05 14:51:03 kernel: BTRFS info (device sdg): using crc32c (crc32c-intel) checksum algorithm
> 2026-02-05 14:51:03 kernel: BTRFS info (device sdg): using free-space-tree
> 2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> 2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 Sense Key : Illegal Request [current]
> 2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 Add. Sense: Invalid command operation code
> 2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 CDB: Write same(16) 93 08 00 00 00 00 00 00 6a 18 00 00 01 e0 00 00
> 2026-02-05 14:56:44 kernel: critical target error, dev sdg, sector 27160 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0
> 
> A media error is highly implausible, because sdg is a ESX virtual disk on a
> high redundant Netapp fileserver.
> Maybe an internal btrfs problem?
> 

Kernel attempted to discard unused blocks (you use the option "discard") 
and decided to use WRITE_SAME SCSI command that the disk rejected. It is 
completely unrelated to the btrfs; normally SCSI device should report 
what features it supports. Either your device lies or there is a bug in 
sd driver resulting in selecting the wrong discard method or parameters 
of it.

> 
> root@fex:/var/log# grep sdg /proc/mounts
> /dev/sdg /spool btrfs rw,relatime,discard=async,space_cache=v2,user_subvol_rm_allowed,subvolid=5,subvol=/ 0 0
> 
> root@fex:/var/log# df -TH /spool/
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/sdg       btrfs   18T  105G   18T   1% /spool
> 


