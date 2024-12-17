Return-Path: <linux-btrfs+bounces-10448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873899F42CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 06:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29999188790F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 05:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF01474A0;
	Tue, 17 Dec 2024 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbp2ZgPV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADE1361
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734413531; cv=none; b=fa/glwjk1iSp2MF+ok3vQVP0iCy7AFcyXJ6gZFykBfeiVXcHFq1vBB2hiobxkHymELriP63cqgjd+8ymWCWVDFdUAY77QxtMMh/xeqQ3ZhHKOAIk0um522AU0D9HNZ/PQlWyz/D/kTPhLRO86CocBW8PfM0odzKqeNAKiEpCsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734413531; c=relaxed/simple;
	bh=K797sJKGdqhkqn6kPbTj7Y2xfDMrP5EnJELUTaf1EcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIeyoavCwJFBiCssItJAvjPPtYh0jyo8uvnQvO0jIPVrSbyDQA+lLtNKg+7N83xQrk+zBwxS8pSUNnEclGMiWZZLySvbt9+BYrGsWRUwXe5Y23L/RYIqdsKbRz0QIFDPltf+RL4s8/DtT2xt/iC9ZIT9ImkcooobFJJ8SHSUDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbp2ZgPV; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3022c61557cso52093071fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 21:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734413527; x=1735018327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p69RCzsyRmA2FxpN27TxwNsVGVmj4RZ7QPFd/Tf86XE=;
        b=fbp2ZgPVnDgPtoIrQqx4IzykwNHREgMw6PPtjw1SLrJ7ttk41WK0ow0n5zn9/0JCCd
         06K3nfKWDz/HQr4t2WPhgJnUoUm8bF8CMM14rzLBHE2UlyLoq2b3rRwfy2g1idUMKYC1
         2O2IrVE9/2p+aEUn3N8h2jD4YdPOslGfwbGgkjulcK10cMdRA1JGxAWVQ1ZZRSTG0t8j
         tmMfaR83voyUQo7+7CudUki9DvmHnud2X/FQD7vYie53/7KqtcMIAnOvnhLyVgfMW4Ge
         xLVwQUqH90l0LRhn6tjRROp1JFsiU4r/8LG6vlDWZOU9Rrs3L1UgfATpl/onNfIRn3sP
         hJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734413527; x=1735018327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p69RCzsyRmA2FxpN27TxwNsVGVmj4RZ7QPFd/Tf86XE=;
        b=EiVUC9ofS7SKSvFdku/K5uJnBgVxBIOyJu3UI9fPiJyCQ5oEPY3H2aLW36KIgaSy17
         /Io46+oAP6Osh5efwyEuZ95sk50j3+Mt3/m+jjetKebSg9ySHcrS710hV3RjY9m97/lq
         F1YonJ0VnjS+xXJ8lrMbaQWEKZgMIaHLNq2qhT1fBE1K4RPaO4aR/yX2O6Xa22MSWcbJ
         guas9Gw6K4yeeNrW3CF2qFe1K8seBkkwd5Y4VxeOOKQJ8MvKkPN0iN9qPKIodS2XfW7f
         XpaGAb7K2zHj20gNa5riR59asvRoGIcde3qH1/x0FZoJ1y0IrKdImwWI+rdgUkaLKJN6
         zGgg==
X-Gm-Message-State: AOJu0YyQ+UmeIubIW8BEp8mGt78dnu4oWHxI0XogahQ9uL6DTSQLibNm
	f4KHb5yo9yYt1U576mvOuKqfL6DLgZIOJbZp92fc8pPoQkhSU/J5SYIB/CTPBfANyJDxiLwox/q
	X2qBT1uvR63yliVDs24l7/YvAtbOZ/t6Z
X-Gm-Gg: ASbGncthaYZQTvHs6he6I+L02wcFiNMdUy0n2BKfZuPuX8HZ8Q6a1LAtQkMwovsYXQq
	J9FRwukWKL2pGq075AaPerHtsHgYblSjNLuRzo50=
X-Google-Smtp-Source: AGHT+IEiR36q79WanqTBHc1/+I0NVWGwrMCo9QZoL/Q/7Btx177kOwZeatbFc/1RWr7Ds919mmXWnSFS2txlTVRPnsQ=
X-Received: by 2002:a05:651c:2127:b0:302:29a5:6e24 with SMTP id
 38308e7fff4ca-30254423198mr45346201fa.7.1734413527140; Mon, 16 Dec 2024
 21:32:07 -0800 (PST)
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
 <CADhu7iBQf_vE3hSoDH7L=eCPzq9LZQyr1R8xDhF-OEXHENkD1w@mail.gmail.com>
In-Reply-To: <CADhu7iBQf_vE3hSoDH7L=eCPzq9LZQyr1R8xDhF-OEXHENkD1w@mail.gmail.com>
From: j4nn <j4nn.xda@gmail.com>
Date: Tue, 17 Dec 2024 06:31:55 +0100
Message-ID: <CADhu7iD+kKsvxZtnX9q94tuJzS6z=zs3B7Xc9Bb4G+mnQ6_UhQ@mail.gmail.com>
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 19:52, j4nn <j4nn.xda@gmail.com> wrote:
>
> This is unrelated, but as you have been interested in the hung task
> backtrace, I got two more when using "btrfs send ... | btrfs receive
> ..." to copy 7TB of data from one btrfs disk to another one (still in
> progress, both rotational hard drives):
> [81837.347137] INFO: task btrfs-transacti:29385 blocked for more than
> 122 seconds.
> [81837.347144]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
> [81837.347147] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [81837.347149] task:btrfs-transacti state:D stack:0     pid:29385
> tgid:29385 ppid:2      flags:0x00004000
> [81837.347154] Call Trace:
> [81837.347156]  <TASK>
> [81837.347161]  __schedule+0x3f0/0xbd0
> [81837.347170]  schedule+0x27/0xf0
> [81837.347174]  io_schedule+0x46/0x70
> [81837.347177]  folio_wait_bit_common+0x123/0x340
> [81837.347184]  ? __pfx_wake_page_function+0x10/0x10
> [81837.347189]  folio_wait_writeback+0x2b/0x80
> [81837.347193]  __filemap_fdatawait_range+0x7d/0xd0
> [81837.347201]  filemap_fdatawait_range+0x12/0x20
> [81837.347206]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
> [81837.347250]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
> [81837.347286]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
> [81837.347319]  ? start_transaction+0xc0/0x820 [btrfs]
> [81837.347353]  transaction_kthread+0x159/0x1c0 [btrfs]
> [81837.347386]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [81837.347418]  kthread+0xd2/0x100
> [81837.347423]  ? __pfx_kthread+0x10/0x10
> [81837.347427]  ret_from_fork+0x34/0x50
> [81837.347430]  ? __pfx_kthread+0x10/0x10
> [81837.347434]  ret_from_fork_asm+0x1a/0x30
> [81837.347440]  </TASK>
> [82205.983491] INFO: task btrfs-transacti:29385 blocked for more than
> 122 seconds.
> [82205.983498]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
> [82205.983501] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [82205.983503] task:btrfs-transacti state:D stack:0     pid:29385
> tgid:29385 ppid:2      flags:0x00004000
> [82205.983508] Call Trace:
> [82205.983511]  <TASK>
> [82205.983515]  __schedule+0x3f0/0xbd0
> [82205.983524]  schedule+0x27/0xf0
> [82205.983528]  io_schedule+0x46/0x70
> [82205.983531]  folio_wait_bit_common+0x123/0x340
> [82205.983538]  ? __pfx_wake_page_function+0x10/0x10
> [82205.983543]  folio_wait_writeback+0x2b/0x80
> [82205.983546]  __filemap_fdatawait_range+0x7d/0xd0
> [82205.983551]  ? srso_alias_return_thunk+0x5/0xfbef5
> [82205.983555]  ? __slab_free+0xbf/0x2c0
> [82205.983560]  ? srso_alias_return_thunk+0x5/0xfbef5
> [82205.983563]  ? kmem_cache_alloc_noprof+0x201/0x2a0
> [82205.983567]  ? clear_state_bit+0xfc/0x160 [btrfs]
> [82205.983609]  ? srso_alias_return_thunk+0x5/0xfbef5
> [82205.983612]  ? __clear_extent_bit+0x160/0x490 [btrfs]
> [82205.983646]  filemap_fdatawait_range+0x12/0x20
> [82205.983650]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
> [82205.983689]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
> [82205.983725]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
> [82205.983759]  ? start_transaction+0xc0/0x820 [btrfs]
> [82205.983793]  transaction_kthread+0x159/0x1c0 [btrfs]
> [82205.983827]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [82205.983859]  kthread+0xd2/0x100
> [82205.983864]  ? __pfx_kthread+0x10/0x10
> [82205.983867]  ret_from_fork+0x34/0x50
> [82205.983871]  ? __pfx_kthread+0x10/0x10
> [82205.983874]  ret_from_fork_asm+0x1a/0x30
> [82205.983881]  </TASK>
>
> Let me know please if you need some more info.

Got few more of those during the above mentioned transfer:
[101497.950425] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[101497.950432]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[101497.950435] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[101497.950437] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[101497.950442] Call Trace:
[101497.950444]  <TASK>
[101497.950449]  __schedule+0x3f0/0xbd0
[101497.950458]  schedule+0x27/0xf0
[101497.950461]  io_schedule+0x46/0x70
[101497.950465]  folio_wait_bit_common+0x123/0x340
[101497.950472]  ? __pfx_wake_page_function+0x10/0x10
[101497.950477]  folio_wait_writeback+0x2b/0x80
[101497.950480]  __filemap_fdatawait_range+0x7d/0xd0
[101497.950489]  filemap_fdatawait_range+0x12/0x20
[101497.950493]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[101497.950536]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[101497.950572]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[101497.950606]  ? start_transaction+0xc0/0x820 [btrfs]
[101497.950640]  transaction_kthread+0x159/0x1c0 [btrfs]
[101497.950674]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[101497.950705]  kthread+0xd2/0x100
[101497.950710]  ? __pfx_kthread+0x10/0x10
[101497.950714]  ret_from_fork+0x34/0x50
[101497.950718]  ? __pfx_kthread+0x10/0x10
[101497.950721]  ret_from_fork_asm+0x1a/0x30
[101497.950727]  </TASK>
[102358.101888] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[102358.101895]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[102358.101898] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[102358.101899] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[102358.101904] Call Trace:
[102358.101907]  <TASK>
[102358.101912]  __schedule+0x3f0/0xbd0
[102358.101920]  schedule+0x27/0xf0
[102358.101924]  io_schedule+0x46/0x70
[102358.101928]  folio_wait_bit_common+0x123/0x340
[102358.101934]  ? __pfx_wake_page_function+0x10/0x10
[102358.101939]  folio_wait_writeback+0x2b/0x80
[102358.101943]  __filemap_fdatawait_range+0x7d/0xd0
[102358.101951]  filemap_fdatawait_range+0x12/0x20
[102358.101956]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[102358.102000]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[102358.102035]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[102358.102069]  ? start_transaction+0xc0/0x820 [btrfs]
[102358.102107]  transaction_kthread+0x159/0x1c0 [btrfs]
[102358.102142]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[102358.102174]  kthread+0xd2/0x100
[102358.102178]  ? __pfx_kthread+0x10/0x10
[102358.102182]  ret_from_fork+0x34/0x50
[102358.102186]  ? __pfx_kthread+0x10/0x10
[102358.102189]  ret_from_fork_asm+0x1a/0x30
[102358.102195]  </TASK>
[102849.617090] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[102849.617097]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[102849.617100] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[102849.617102] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[102849.617107] Call Trace:
[102849.617109]  <TASK>
[102849.617113]  __schedule+0x3f0/0xbd0
[102849.617122]  schedule+0x27/0xf0
[102849.617126]  io_schedule+0x46/0x70
[102849.617130]  folio_wait_bit_common+0x123/0x340
[102849.617137]  ? __pfx_wake_page_function+0x10/0x10
[102849.617141]  folio_wait_writeback+0x2b/0x80
[102849.617145]  __filemap_fdatawait_range+0x7d/0xd0
[102849.617151]  ? srso_alias_return_thunk+0x5/0xfbef5
[102849.617155]  ? kmem_cache_alloc_noprof+0x201/0x2a0
[102849.617160]  ? clear_state_bit+0xfc/0x160 [btrfs]
[102849.617202]  ? srso_alias_return_thunk+0x5/0xfbef5
[102849.617206]  ? __clear_extent_bit+0x160/0x490 [btrfs]
[102849.617240]  filemap_fdatawait_range+0x12/0x20
[102849.617244]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[102849.617283]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[102849.617319]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[102849.617353]  ? start_transaction+0xc0/0x820 [btrfs]
[102849.617387]  transaction_kthread+0x159/0x1c0 [btrfs]
[102849.617421]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[102849.617452]  kthread+0xd2/0x100
[102849.617457]  ? __pfx_kthread+0x10/0x10
[102849.617461]  ret_from_fork+0x34/0x50
[102849.617465]  ? __pfx_kthread+0x10/0x10
[102849.617468]  ret_from_fork_asm+0x1a/0x30
[102849.617474]  </TASK>
[103464.011016] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[103464.011023]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[103464.011025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[103464.011027] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[103464.011031] Call Trace:
[103464.011033]  <TASK>
[103464.011037]  __schedule+0x3f0/0xbd0
[103464.011045]  schedule+0x27/0xf0
[103464.011048]  io_schedule+0x46/0x70
[103464.011051]  folio_wait_bit_common+0x123/0x340
[103464.011057]  ? __pfx_wake_page_function+0x10/0x10
[103464.011061]  folio_wait_writeback+0x2b/0x80
[103464.011064]  __filemap_fdatawait_range+0x7d/0xd0
[103464.011072]  filemap_fdatawait_range+0x12/0x20
[103464.011076]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[103464.011113]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[103464.011143]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[103464.011172]  ? start_transaction+0xc0/0x820 [btrfs]
[103464.011200]  transaction_kthread+0x159/0x1c0 [btrfs]
[103464.011228]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[103464.011255]  kthread+0xd2/0x100
[103464.011259]  ? __pfx_kthread+0x10/0x10
[103464.011262]  ret_from_fork+0x34/0x50
[103464.011266]  ? __pfx_kthread+0x10/0x10
[103464.011268]  ret_from_fork_asm+0x1a/0x30
[103464.011274]  </TASK>
[103832.647363] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[103832.647370]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[103832.647372] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[103832.647374] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[103832.647378] Call Trace:
[103832.647380]  <TASK>
[103832.647384]  __schedule+0x3f0/0xbd0
[103832.647392]  schedule+0x27/0xf0
[103832.647396]  io_schedule+0x46/0x70
[103832.647399]  folio_wait_bit_common+0x123/0x340
[103832.647405]  ? __pfx_wake_page_function+0x10/0x10
[103832.647410]  folio_wait_writeback+0x2b/0x80
[103832.647413]  __filemap_fdatawait_range+0x7d/0xd0
[103832.647420]  ? srso_alias_return_thunk+0x5/0xfbef5
[103832.647425]  ? __clear_extent_bit+0x160/0x490 [btrfs]
[103832.647466]  filemap_fdatawait_range+0x12/0x20
[103832.647470]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[103832.647509]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[103832.647545]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[103832.647579]  ? start_transaction+0xc0/0x820 [btrfs]
[103832.647613]  transaction_kthread+0x159/0x1c0 [btrfs]
[103832.647648]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[103832.647680]  kthread+0xd2/0x100
[103832.647685]  ? __pfx_kthread+0x10/0x10
[103832.647688]  ret_from_fork+0x34/0x50
[103832.647692]  ? __pfx_kthread+0x10/0x10
[103832.647695]  ret_from_fork_asm+0x1a/0x30
[103832.647700]  </TASK>
[104078.404940] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[104078.404947]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[104078.404950] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[104078.404952] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[104078.404957] Call Trace:
[104078.404959]  <TASK>
[104078.404964]  __schedule+0x3f0/0xbd0
[104078.404973]  schedule+0x27/0xf0
[104078.404976]  io_schedule+0x46/0x70
[104078.404980]  folio_wait_bit_common+0x123/0x340
[104078.404987]  ? __pfx_wake_page_function+0x10/0x10
[104078.404992]  folio_wait_writeback+0x2b/0x80
[104078.404995]  __filemap_fdatawait_range+0x7d/0xd0
[104078.405001]  ? srso_alias_return_thunk+0x5/0xfbef5
[104078.405005]  ? kmem_cache_alloc_noprof+0x201/0x2a0
[104078.405010]  ? clear_state_bit+0xfc/0x160 [btrfs]
[104078.405051]  ? srso_alias_return_thunk+0x5/0xfbef5
[104078.405055]  ? __clear_extent_bit+0x160/0x490 [btrfs]
[104078.405089]  filemap_fdatawait_range+0x12/0x20
[104078.405093]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[104078.405132]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[104078.405168]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[104078.405202]  ? start_transaction+0xc0/0x820 [btrfs]
[104078.405236]  transaction_kthread+0x159/0x1c0 [btrfs]
[104078.405270]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[104078.405301]  kthread+0xd2/0x100
[104078.405306]  ? __pfx_kthread+0x10/0x10
[104078.405310]  ret_from_fork+0x34/0x50
[104078.405313]  ? __pfx_kthread+0x10/0x10
[104078.405317]  ret_from_fork_asm+0x1a/0x30
[104078.405323]  </TASK>
[104324.162492] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[104324.162499]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[104324.162502] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[104324.162504] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[104324.162509] Call Trace:
[104324.162511]  <TASK>
[104324.162515]  __schedule+0x3f0/0xbd0
[104324.162525]  schedule+0x27/0xf0
[104324.162528]  io_schedule+0x46/0x70
[104324.162532]  folio_wait_bit_common+0x123/0x340
[104324.162539]  ? __pfx_wake_page_function+0x10/0x10
[104324.162544]  folio_wait_writeback+0x2b/0x80
[104324.162547]  __filemap_fdatawait_range+0x7d/0xd0
[104324.162553]  ? srso_alias_return_thunk+0x5/0xfbef5
[104324.162557]  ? kmem_cache_alloc_noprof+0x201/0x2a0
[104324.162562]  ? clear_state_bit+0xfc/0x160 [btrfs]
[104324.162604]  ? srso_alias_return_thunk+0x5/0xfbef5
[104324.162608]  ? __clear_extent_bit+0x160/0x490 [btrfs]
[104324.162641]  filemap_fdatawait_range+0x12/0x20
[104324.162645]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[104324.162685]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[104324.162721]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[104324.162755]  ? start_transaction+0xc0/0x820 [btrfs]
[104324.162789]  transaction_kthread+0x159/0x1c0 [btrfs]
[104324.162823]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[104324.162854]  kthread+0xd2/0x100
[104324.162859]  ? __pfx_kthread+0x10/0x10
[104324.162863]  ret_from_fork+0x34/0x50
[104324.162866]  ? __pfx_kthread+0x10/0x10
[104324.162870]  ret_from_fork_asm+0x1a/0x30
[104324.162876]  </TASK>
[105798.707833] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[105798.707840]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[105798.707843] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[105798.707845] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[105798.707850] Call Trace:
[105798.707853]  <TASK>
[105798.707857]  __schedule+0x3f0/0xbd0
[105798.707866]  schedule+0x27/0xf0
[105798.707870]  io_schedule+0x46/0x70
[105798.707874]  folio_wait_bit_common+0x123/0x340
[105798.707881]  ? __pfx_wake_page_function+0x10/0x10
[105798.707886]  folio_wait_writeback+0x2b/0x80
[105798.707890]  __filemap_fdatawait_range+0x7d/0xd0
[105798.707896]  ? srso_alias_return_thunk+0x5/0xfbef5
[105798.707900]  ? kmem_cache_alloc_noprof+0x201/0x2a0
[105798.707906]  ? clear_state_bit+0xfc/0x160 [btrfs]
[105798.707949]  ? srso_alias_return_thunk+0x5/0xfbef5
[105798.707953]  ? __clear_extent_bit+0x160/0x490 [btrfs]
[105798.707989]  filemap_fdatawait_range+0x12/0x20
[105798.707993]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[105798.708034]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[105798.708071]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[105798.708107]  ? start_transaction+0xc0/0x820 [btrfs]
[105798.708142]  transaction_kthread+0x159/0x1c0 [btrfs]
[105798.708177]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[105798.708211]  kthread+0xd2/0x100
[105798.708215]  ? __pfx_kthread+0x10/0x10
[105798.708219]  ret_from_fork+0x34/0x50
[105798.708223]  ? __pfx_kthread+0x10/0x10
[105798.708227]  ret_from_fork_asm+0x1a/0x30
[105798.708233]  </TASK>
[105798.708235] Future hung task reports are suppressed, see sysctl
kernel.hung_task_warnings

The transfer has been completed, took following 'time':
real    812m30.231s
user    6m7.214s
sys     169m1.938s

The destination btrfs filesystem has been freshly created (single
device, no raid) and thus empty before starting the transfer.
This is output of destination 'btrfs filesystem df' after the transfer:
Data, single: total=7.10TiB, used=7.06TiB
System, DUP: total=8.00MiB, used=768.00KiB
Metadata, DUP: total=8.00GiB, used=7.53GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

The btrfs is on a luks device (cryptsetup -h sha512 -c aes-xts-plain64
-s 256), but cpu has been idle the whole time (ryzen 5950x).

Hope that helps.
Thank you.

