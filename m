Return-Path: <linux-btrfs+bounces-8066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E6397A2E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 15:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594251F23CB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B988156C72;
	Mon, 16 Sep 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNb2Z+6C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C4155730
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493147; cv=none; b=sUl6M8WWABZuWa2p7fvAFJxEgdN25U0coEDwisjRQ6DQBO78mohUGExPgxGBI3APz0f0cpQhAX3V3T6AoCYLb43SOZ6XINmjNTvf18QwuflnDklILj4Dp+iQE1odCeDEZVo3hANT5ILGU5tsmdCttkjBUktMg/2Q8ltu0DKdIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493147; c=relaxed/simple;
	bh=soTBR3IEjnmw2mXnIQwh9FmsutdUZqYNQCRfm+h8HhM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L+SrUNg9mpGSHzGGf1bLnRF52JIO78p1ivwHJgX3inRvgNiPuO4TDY86jX9N53cRyheneYrYiakUzsc9sIJaH6tIF3uCXkgVej76oSGbN83ggwwlZBJjOP9NW6ZeNXo5mBoGdGC7kvWOldlhfTjRFcdN1j4HppHVIInnQlG3yP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNb2Z+6C; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d885019558so3015006a91.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726493145; x=1727097945; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfoBc6a6z0pZAo5BA5Yva/CIOWWGCpDomL3UaQ5C18E=;
        b=TNb2Z+6CkvOghszboUx3/7yONVPWQs1jxtS1fIeLT4CuCEcYrmqJkoFBnME9Lh3x2s
         GhPK+w86ECgqE3M4h5HvMrOFEmp3DzApSQynXPRQ7LlmSE3pVVtqeUZawmmM0KYr5fmM
         2Zup4e5us8P5CIlhKcmJdruPlPJ0amJFYd9BT2AVOoOCrn7iIzT/dHipHhX+CIK3qcCt
         y9Rv37tarns/RPTwBm454d6Az2g3xKAdPWX30cVeCxdDM2rmxNHVH9eIfQ0MgnVPfA+t
         hpxADBooY6BatV16QnO2Q6RzxMxOQBiGTnUdsqs8JOa7Y3OJpJ1+vXppYdH2YtqfSoVh
         wNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726493145; x=1727097945;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfoBc6a6z0pZAo5BA5Yva/CIOWWGCpDomL3UaQ5C18E=;
        b=eKEg8qECXpfjKjPIA4xncCgKAGNZ8sSpwwqDtLUqU8nEK7x+kIcBGHVl1+K+SpRTb1
         dTe1BcAXjNplf+gy1izE/wxrvPMQRGhJWyPDmPK/0JsRQwQwGvv1vbGDxBM6huznpJK1
         z65Z5VRdAyR1HneBXKj/vgjDPJfJPhippa2vn8Nu3vmYZ7ieH+WRgzo1xFcMAddGk2j9
         4q33IR0VranVwXYPVEGANGUGi61kT5HYgr6ZqRR6V7swoZxCY1EEzvGbjqAHlHR8ZEC/
         ScxSbxOiLmq+vijniLcJVqO0AG7N5JuqUfYgJXzCxrJYD9z/GleztPCO8nUvUcajEucY
         a9eg==
X-Gm-Message-State: AOJu0Yz/DIyyE3qNlKmllWF4aCXhNQ9z4snU1fnY/5GHffNvSJlw+/hp
	AjPLN5rE7E8xTvXitzkuNp+AxGSuJPVxgxmeE6czTYsQrnKjvpUgsFBby0Zx37v3D1p4p2KwI6b
	PE31LuWxOVbd9a1ujjQq7m+RyoO/8tDtQ
X-Google-Smtp-Source: AGHT+IHDZ+kGeGVKY2PVwg+L6ZwlBH21/c/emjMs9d8iueEOnJZGk1ke6j3PbdOeFRRw5CSNYxhl7a076KyTfnV+Kcw=
X-Received: by 2002:a17:90a:4e0b:b0:2cc:ff56:5be1 with SMTP id
 98e67ed59e1d1-2db9ffb0e2bmr18368732a91.7.1726493144669; Mon, 16 Sep 2024
 06:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Ed T." <edtoml@gmail.com>
Date: Mon, 16 Sep 2024 09:25:08 -0400
Message-ID: <CAPQz974fFioBDc=sBBJNkmCQna4gQONbDyRNXQ5dApfzSj-Hjw@mail.gmail.com>
Subject: Hung task timeouts from btrfs on 6.11
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Noticed this in my logs this morning.  I updated from 6.11-rc7 to 6.11
yesterday.  Have not seen any hung tasks in rc7.

The kernel is tainted with a dkms module for a razer mouse.  There are
also two local patches, one adding a quirk to an nvme device and the
other printing
more info on errors I am getting from a sata device (tout_hsm errors
none of which had occurred when these tracebacks happened).

During the time this occurred the system was doing backups which
create a snapshot and then sends it to a backup fs.  This is done for
three btrfs raid10 volumes.
No LVM or LUKS used.

Thanks
Ed Tomlinson

Sep 16 03:09:18 grover kernel: INFO: task btrfs:154859 blocked for
more than 122 seconds.
Sep 16 03:09:18 grover kernel:       Tainted: G           OE
6.11.0-1-stable-git #1
Sep 16 03:09:18 grover kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 16 03:09:18 grover kernel: task:btrfs           state:D stack:0
 pid:154859 tgid:154859 ppid:4114   flags:0x00000002
Sep 16 03:09:18 grover kernel: Call Trace:
Sep 16 03:09:18 grover kernel:  <TASK>
Sep 16 03:09:18 grover kernel:  __schedule+0x3d5/0x1520
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? ttwu_queue_wakelist+0xd0/0xf0
Sep 16 03:09:18 grover kernel:  schedule+0x27/0xf0
Sep 16 03:09:18 grover kernel:
btrfs_commit_transaction_async+0xe6/0x140 [btrfs
d81a5631725934f03c861b18e6ad76df5247d033]
Sep 16 03:09:18 grover kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
Sep 16 03:09:18 grover kernel:  btrfs_ioctl_start_sync+0x4b/0xb0
[btrfs d81a5631725934f03c861b18e6ad76df5247d033]
Sep 16 03:09:18 grover kernel:  __x64_sys_ioctl+0x94/0xd0
Sep 16 03:09:18 grover kernel:  do_syscall_64+0x82/0x190
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? __pte_offset_map+0x1b/0x180
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? next_uptodate_folio+0x89/0x2a0
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? filemap_map_pages+0x518/0x600
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? syscall_exit_to_user_mode_prepare+0x149/0x170
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? do_fault+0x26e/0x470
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? __handle_mm_fault+0x7e2/0x1030
Sep 16 03:09:18 grover kernel:  ? do_fault+0x26e/0x470
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? __handle_mm_fault+0x7e2/0x1030
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? __count_memcg_events+0x58/0xf0
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? count_memcg_events.constprop.0+0x1a/0x30
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? handle_mm_fault+0x1bb/0x2c0
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? do_user_addr_fault+0x36c/0x620
Sep 16 03:09:18 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:09:18 grover kernel:  ? exc_page_fault+0x81/0x190
Sep 16 03:09:18 grover kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Sep 16 03:09:18 grover kernel: RIP: 0033:0x7fa24f5e6ced
Sep 16 03:09:18 grover kernel: RSP: 002b:00007ffcca7b7820 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
Sep 16 03:09:18 grover kernel: RAX: ffffffffffffffda RBX:
00007ffcca7b7900 RCX: 00007fa24f5e6ced
Sep 16 03:09:18 grover kernel: RDX: 00007ffcca7b78f0 RSI:
0000000080089418 RDI: 0000000000000003
Sep 16 03:09:18 grover kernel: RBP: 00007ffcca7b7870 R08:
000055efb4c21c00 R09: 0000000000000007
Sep 16 03:09:18 grover kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007ffcca7b78f0
Sep 16 03:09:18 grover kernel: R13: 000055efb4be7418 R14:
0000000000000003 R15: 000055efbdf8b2d0
Sep 16 03:09:18 grover kernel:  </TASK>
Sep 16 03:10:36 grover clamd[981]: Mon Sep 16 03:10:36 2024 ->
SelfCheck: Database status OK.
Sep 16 03:11:21 grover kernel: INFO: task btrfs:154859 blocked for
more than 245 seconds.
Sep 16 03:11:21 grover kernel:       Tainted: G           OE
6.11.0-1-stable-git #1
Sep 16 03:11:21 grover kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 16 03:11:21 grover kernel: task:btrfs           state:D stack:0
 pid:154859 tgid:154859 ppid:4114   flags:0x00000002
Sep 16 03:11:21 grover kernel: Call Trace:
Sep 16 03:11:21 grover kernel:  <TASK>
Sep 16 03:11:21 grover kernel:  __schedule+0x3d5/0x1520
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? ttwu_queue_wakelist+0xd0/0xf0
Sep 16 03:11:21 grover kernel:  schedule+0x27/0xf0
Sep 16 03:11:21 grover kernel:
btrfs_commit_transaction_async+0xe6/0x140 [btrfs
d81a5631725934f03c861b18e6ad76df5247d033]
Sep 16 03:11:21 grover kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
Sep 16 03:11:21 grover kernel:  btrfs_ioctl_start_sync+0x4b/0xb0
[btrfs d81a5631725934f03c861b18e6ad76df5247d033]
Sep 16 03:11:21 grover kernel:  __x64_sys_ioctl+0x94/0xd0
Sep 16 03:11:21 grover kernel:  do_syscall_64+0x82/0x190
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? __pte_offset_map+0x1b/0x180
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? next_uptodate_folio+0x89/0x2a0
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? filemap_map_pages+0x518/0x600
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? syscall_exit_to_user_mode_prepare+0x149/0x170
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? do_fault+0x26e/0x470
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? __handle_mm_fault+0x7e2/0x1030
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? __count_memcg_events+0x58/0xf0
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? count_memcg_events.constprop.0+0x1a/0x30
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? handle_mm_fault+0x1bb/0x2c0
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? do_user_addr_fault+0x36c/0x620
Sep 16 03:11:21 grover kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 16 03:11:21 grover kernel:  ? exc_page_fault+0x81/0x190
Sep 16 03:11:21 grover kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Sep 16 03:11:21 grover kernel: RIP: 0033:0x7fa24f5e6ced
Sep 16 03:11:21 grover kernel: RSP: 002b:00007ffcca7b7820 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
Sep 16 03:11:21 grover kernel: RAX: ffffffffffffffda RBX:
00007ffcca7b7900 RCX: 00007fa24f5e6ced
Sep 16 03:11:21 grover kernel: RDX: 00007ffcca7b78f0 RSI:
0000000080089418 RDI: 0000000000000003
Sep 16 03:11:21 grover kernel: RBP: 00007ffcca7b7870 R08:
000055efb4c21c00 R09: 0000000000000007
Sep 16 03:11:21 grover kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007ffcca7b78f0
Sep 16 03:11:21 grover kernel: R13: 000055efb4be7418 R14:
0000000000000003 R15: 000055efbdf8b2d0
Sep 16 03:11:21 grover kernel:  </TASK>

