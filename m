Return-Path: <linux-btrfs+bounces-10432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589B99F3954
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE44A1883452
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2362C207E10;
	Mon, 16 Dec 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzF5yYOX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DE207DFC
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375182; cv=none; b=jqNg5nchRNFs4SGQLtJhYm/nzmtQlW5/kOe68+U4hS8/S/2WpBGHlL23qcS5zaWDRG56wvpyJbEwYLLE4lPaS5MdAZ4mNC7Zzmtds7Z37u53IGWH4r+JTVO1n2zNCTX9gMhMCnoTJXj7wvwnKBsU/r57nBgDT9+qR7gi8ikOczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375182; c=relaxed/simple;
	bh=O8iysBE98HMnF0pVIgzan9CZedWSzezx9Cw9CbxlAv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWHieAjhXrzyBf0+w+Rm7Dz17ULG7W7D1bdkxCIQRFimq+P5Rr863jI8pXJ15fMem7W7fahylFdw3v5QkgC/YMpeyCFLzUa9Gjx0H/PSZK1qnLevNMrFQwYuSB784JyYhYpLt8dPCE4FWYrAxhXjWV81Edf0QfE1qJNetyBTg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzF5yYOX; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3004028c714so44691101fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734375179; x=1734979979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ7V/qtINaQLoez6cVzEFDHQ1KmZYFkx2IIi9by4Q+U=;
        b=WzF5yYOXrtIk5hSX4D7BbJIA6PtuKqHuZmyrSjAKegkbcjz5eBy5Q6nXwDxzh9O4Up
         4+99eAga2MMuRRHcL6wCVkUmejgIy6ArnPDAFvt6RSKX22G6VaaE4kYuRp6KYQJb/mTk
         XS4C2ar/2Y7wKC75JyLiwqoda1iORrjsu3K/EjP4bdzinBzzWv4HbNFu35JljeiLAqng
         uxnOTUhV/A9/UptFVY7dkSQZj0kwY7kzZeAb1ngv5zJcEuLRY4G0zrwR44lh2NN+9vUP
         B4AFsDus1hIeqjz75BrX3rPT0xNsY+iVQtIrW/K/VGIb2bmLLM2cdY92rUd4aQpRwNic
         oG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375179; x=1734979979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ7V/qtINaQLoez6cVzEFDHQ1KmZYFkx2IIi9by4Q+U=;
        b=lXdhkmEYAhoZk+qlZ0ZuQoBxX4SDHeGxRI/2+RSDKYeVnK/owksPhCaQqLA5JmkVE/
         AttObW/SDQq2yhKBPn5EcAEFBoNbULcZAKDoFEFgA/2Lr4CKt/6L/8PtstzpFNUGYcwq
         /yZZHuwLAETmkS/qy9vFdxpkY4cz5fef8FDHC8wbstRNk6kP1hJxHHclcUppCKJ1agJw
         E8BG4oV9nHHcagy8uJ7RVZX3cwd7UnDmGZANxsw9D5c33mI3ZHo+IPfb/tLFZ3Uyd6Pn
         2Rn4Ppkz+if/JN6f0MY7RtKVi4BhbFBe4i/JlD/DyHNIyoVIY298NKolWb/akyAF4W6c
         kQTQ==
X-Gm-Message-State: AOJu0YxTurIysCgBquzITRZkm1XCpvU1uRS7sC+PMiJSMV6j+v8Cxb+8
	it5tM+OI5PYzZ3n/QIV+435PMbbnb+mVmxFv46cFCNZaw06kC6LbeCkFChji1F4p978vDrcA7ui
	fHXT7WgWB+r3pRRWGunKfjlttQV3PSKgq
X-Gm-Gg: ASbGncuE8djBLtD+1MsFWZHeTnUpouasqiZDws6c4VBhChw9efhw4Y7GYD2HQ4sNjBs
	LFW54Ty6tlh/ut6+V2RLuVuuOioDYEHnDWhIN68A=
X-Google-Smtp-Source: AGHT+IH4zilFxWkWP5hQaIPrvXddTK9Y2BGPWTo58qKQM99XFG6pfnkYa3XfhEVb/sH4HSUc1WDLebHenazcoYjroCI=
X-Received: by 2002:a2e:9b04:0:b0:2fb:54d7:71b5 with SMTP id
 38308e7fff4ca-3044351f883mr3024971fa.22.1734375178342; Mon, 16 Dec 2024
 10:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com> <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
 <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com> <CADhu7iCYRjcQ2kHWqvaZYTnwVUY-qFaBSaDyZA_OL2MEpr6EYg@mail.gmail.com>
 <61140354-83ce-43cb-8bb6-fc7b5ecaa1f1@gmx.com> <CADhu7iBR-i9bOHRDN-adtWkoF8R9v=kvFhAySV_Fbfk_v8iFXg@mail.gmail.com>
In-Reply-To: <CADhu7iBR-i9bOHRDN-adtWkoF8R9v=kvFhAySV_Fbfk_v8iFXg@mail.gmail.com>
From: j4nn <j4nn.xda@gmail.com>
Date: Mon, 16 Dec 2024 19:52:47 +0100
Message-ID: <CADhu7iBQf_vE3hSoDH7L=eCPzq9LZQyr1R8xDhF-OEXHENkD1w@mail.gmail.com>
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is unrelated, but as you have been interested in the hung task
backtrace, I got two more when using "btrfs send ... | btrfs receive
..." to copy 7TB of data from one btrfs disk to another one (still in
progress, both rotational hard drives):
[81837.347137] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[81837.347144]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[81837.347147] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[81837.347149] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[81837.347154] Call Trace:
[81837.347156]  <TASK>
[81837.347161]  __schedule+0x3f0/0xbd0
[81837.347170]  schedule+0x27/0xf0
[81837.347174]  io_schedule+0x46/0x70
[81837.347177]  folio_wait_bit_common+0x123/0x340
[81837.347184]  ? __pfx_wake_page_function+0x10/0x10
[81837.347189]  folio_wait_writeback+0x2b/0x80
[81837.347193]  __filemap_fdatawait_range+0x7d/0xd0
[81837.347201]  filemap_fdatawait_range+0x12/0x20
[81837.347206]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[81837.347250]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[81837.347286]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[81837.347319]  ? start_transaction+0xc0/0x820 [btrfs]
[81837.347353]  transaction_kthread+0x159/0x1c0 [btrfs]
[81837.347386]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[81837.347418]  kthread+0xd2/0x100
[81837.347423]  ? __pfx_kthread+0x10/0x10
[81837.347427]  ret_from_fork+0x34/0x50
[81837.347430]  ? __pfx_kthread+0x10/0x10
[81837.347434]  ret_from_fork_asm+0x1a/0x30
[81837.347440]  </TASK>
[82205.983491] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[82205.983498]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[82205.983501] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[82205.983503] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[82205.983508] Call Trace:
[82205.983511]  <TASK>
[82205.983515]  __schedule+0x3f0/0xbd0
[82205.983524]  schedule+0x27/0xf0
[82205.983528]  io_schedule+0x46/0x70
[82205.983531]  folio_wait_bit_common+0x123/0x340
[82205.983538]  ? __pfx_wake_page_function+0x10/0x10
[82205.983543]  folio_wait_writeback+0x2b/0x80
[82205.983546]  __filemap_fdatawait_range+0x7d/0xd0
[82205.983551]  ? srso_alias_return_thunk+0x5/0xfbef5
[82205.983555]  ? __slab_free+0xbf/0x2c0
[82205.983560]  ? srso_alias_return_thunk+0x5/0xfbef5
[82205.983563]  ? kmem_cache_alloc_noprof+0x201/0x2a0
[82205.983567]  ? clear_state_bit+0xfc/0x160 [btrfs]
[82205.983609]  ? srso_alias_return_thunk+0x5/0xfbef5
[82205.983612]  ? __clear_extent_bit+0x160/0x490 [btrfs]
[82205.983646]  filemap_fdatawait_range+0x12/0x20
[82205.983650]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[82205.983689]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[82205.983725]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[82205.983759]  ? start_transaction+0xc0/0x820 [btrfs]
[82205.983793]  transaction_kthread+0x159/0x1c0 [btrfs]
[82205.983827]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[82205.983859]  kthread+0xd2/0x100
[82205.983864]  ? __pfx_kthread+0x10/0x10
[82205.983867]  ret_from_fork+0x34/0x50
[82205.983871]  ? __pfx_kthread+0x10/0x10
[82205.983874]  ret_from_fork_asm+0x1a/0x30
[82205.983881]  </TASK>

Let me know please if you need some more info.

