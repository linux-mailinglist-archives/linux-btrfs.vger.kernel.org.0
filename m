Return-Path: <linux-btrfs+bounces-5715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49839907777
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB596288909
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23612FB2F;
	Thu, 13 Jun 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="WCewF9vF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA914B96D
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293640; cv=none; b=aoqTmfrpwKhulZit4wLqAe+eLe36YBqq/RnS+OkJVFAlXdPVerZKcQqhTGMCgzXchbXN3lPh69J7OJq/sF5IX9aVUfIPuz0e5HOBGsEcIwY8uH3xGBX3kPIlr1fXGzJqOM+ALDkgVcPgTNmUw/Y+xbCvsVJnbx0dHa+9VSUr1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293640; c=relaxed/simple;
	bh=C3z00bGAaGQvQuJ+duC0iKU7Y9jVfzMn1OWnmKmRFoE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Gf1SriTZKQeSiYnDPS5mtd+FbriIPMr0A4DtYaG+qa5O2e2MeyFtARYN0Nr3Nn5W640SyTA24Svoez1e3B/QkcTUrCrP7aRwQ9oK/I9pCZnmFBnN/YSfRrq+s9oCt1tbi85yeOhBZMiuqUcN/K97L+aIKE/LT4oVkPvR90vQo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=WCewF9vF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso13690021fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1718293634; x=1718898434; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3z00bGAaGQvQuJ+duC0iKU7Y9jVfzMn1OWnmKmRFoE=;
        b=WCewF9vF9FRnokxk7OMWS6k0cGGP4vBTvB0jf+ZPyui0JODO8NNaS5DdBidn1EJ+Q5
         9ho4aBlttF5/VaAOLVspuzxUEv1JnanYFUyjwNHlLDs//aKnEnr+6MiQ93ZRP8nWcaXX
         dt1YSTb6bItJV2XpDqpB0SsL3l2jGBxJI/HgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293634; x=1718898434;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3z00bGAaGQvQuJ+duC0iKU7Y9jVfzMn1OWnmKmRFoE=;
        b=MfLLrKnepKCLf+UZdR7HxCgdS5lR4xkEUyHmWwFDmGqF7ScUa/73IyoM7r/hiyi3zq
         jXKF2miWOkrCag3IvD7etVu+7MUZZNDRHLdKZw9PgaSIRfOqNh937M9QO7Op8XAaRzRV
         VmN+VTw6vUp94e9hCT9Lmg2OyvzyiaqiqeOcWhe1FeYcET/tjUtDYrt4kkej0P66sz92
         LBaj/g4zScmavcViQvVylzpPDGDZ0NzUpvuZ6Ft74UR6YrtGYz2+YptyECnTVb/tLa0U
         bZH9+SDf9RKQrlSDzaEafOwbZDB7J5nJ01FI8Y3kluNpXIdUZDgu0zCuQXacqEiS4iC0
         hUgw==
X-Gm-Message-State: AOJu0YzG7bTe0SpZzmM2BkJ1onCEED6d6Vti0srQikbp2IZWrq/3LpKn
	tsRZOqGtIILyGaeLvCTE25d+NU2VJBLqRbNGU2HCNMooldGUzFetUqk8WWl/fqT2WsuUhAei+Q9
	UkicRhzihOprXxLvhQspAzOFgEpYVwYBnKM1Lpxp32P8+QrwaBg==
X-Google-Smtp-Source: AGHT+IEIOt9MVOFvhtZVXMW6u5LtkGry2aW+RspdHMYHNmL2Fha+sCHoT2EzRl/MNGMhGudpadkIS5vcI09+xkdMquY=
X-Received: by 2002:a2e:7808:0:b0:2eb:fbba:cbe6 with SMTP id
 38308e7fff4ca-2ec0e4637c3mr1331581fa.1.1718293634245; Thu, 13 Jun 2024
 08:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Igor Raits <igor@gooddata.com>
Date: Thu, 13 Jun 2024 17:47:03 +0200
Message-ID: <CA+9S74ihGsyK=t7507x-UrQmNOnE6sh3uM6E6dWEPEj=+H3vHw@mail.gmail.com>
Subject: Stuck btrfs-transaction (deadlock?)
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We have been observing that few of our nodes get stuck recently when
btrfs is trying to write compressed files. I believe this was
happening on one of the latest 6.8.y and now it happens on 6.9.y.
Sadly (as in many cases), I do not have any reproducer for the issue
but as it happens from time to time, we may be able to collect some
more data if you do not have an idea from stacktrace below. We even
tried to wipe the disk completely and write data fresh onto it.

Few minutes before being stuck, there is something being read from a
disk with 500+M/s speed, then small writes and then everything just
stops.
Mount options: compress-force=3Dzstd:2,ssd,discard=3Dasync,space_cache=3Dv2

The node(s) are 48 vCPUs if this matters=E2=80=A6 It is a VM on a KVM
hypervisor if it matters.

Any help is much appreciated!

[1142527.677011] INFO: task btrfs-transacti:49545 blocked for more
than 122 seconds.
[1142527.678282] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.679218] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.680216] task:btrfs-transacti state:D stack:0 pid:49545
tgid:49545 ppid:2 flags:0x00004000
[1142527.681311] Call Trace:
[1142527.681945] <TASK>
[1142527.682545] __schedule+0x222/0x670
[1142527.683238] schedule+0x2c/0xb0
[1142527.683908] schedule_preempt_disabled+0x11/0x20
[1142527.684673] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.685420] ? release_extent_buffer+0x99/0xb0 [btrfs]
[1142527.686232] down_read+0x45/0xa0
[1142527.686863] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.687637] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
[1142527.688414] btrfs_search_slot+0x127/0xbd0 [btrfs]
[1142527.689157] ? kmem_cache_alloc+0x24d/0x330
[1142527.689819] ? kmem_cache_alloc+0x12f/0x330
[1142527.690488] ? btrfs_del_csums+0x53/0x3d0 [btrfs]
[1142527.691197] btrfs_del_csums+0x10b/0x3d0 [btrfs]
[1142527.691896] cleanup_ref_head+0x27d/0x2a0 [btrfs]
[1142527.692592] __btrfs_run_delayed_refs+0xb9/0x1a0 [btrfs]
[1142527.693340] btrfs_run_delayed_refs+0x7b/0x130 [btrfs]
[1142527.694064] btrfs_commit_transaction+0x68/0xb80 [btrfs]
[1142527.694779] ? start_transaction+0xd3/0x830 [btrfs]
[1142527.695462] transaction_kthread+0x155/0x1d0 [btrfs]
[1142527.696152] ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[1142527.696872] kthread+0xdc/0x110
[1142527.697390] ? __pfx_kthread+0x10/0x10
[1142527.697954] ret_from_fork+0x2d/0x50
[1142527.698501] ? __pfx_kthread+0x10/0x10
[1142527.699048] ret_from_fork_asm+0x1a/0x30
[1142527.699602] </TASK>
[1142527.700034] INFO: task kworker/u195:8:3259780 blocked for more
than 122 seconds.
[1142527.700829] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.701572] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.702360] task:kworker/u195:8 state:D stack:0 pid:3259780
tgid:3259780 ppid:2 flags:0x00004000
[1142527.703276] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.703989] Call Trace:
[1142527.704397] <TASK>
[1142527.704784] __schedule+0x222/0x670
[1142527.705261] ? leaf_space_used+0xad/0xd0 [btrfs]
[1142527.705827] schedule+0x2c/0xb0
[1142527.706266] schedule_preempt_disabled+0x11/0x20
[1142527.706792] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.707322] down_read+0x45/0xa0
[1142527.707744] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.708315] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
[1142527.708900] btrfs_search_slot+0x127/0xbd0 [btrfs]
[1142527.709429] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
[1142527.710054] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.710581] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.711139] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.711659] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.712221] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.712737] process_one_work+0x193/0x3d0
[1142527.713184] worker_thread+0x2fc/0x410
[1142527.713610] ? __pfx_worker_thread+0x10/0x10
[1142527.714073] kthread+0xdc/0x110
[1142527.714451] ? __pfx_kthread+0x10/0x10
[1142527.714887] ret_from_fork+0x2d/0x50
[1142527.715296] ? __pfx_kthread+0x10/0x10
[1142527.715714] ret_from_fork_asm+0x1a/0x30
[1142527.716149] </TASK>
[1142527.716458] INFO: task kworker/u200:10:3338782 blocked for more
than 122 seconds.
[1142527.717138] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.717755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.718455] task:kworker/u200:10 state:D stack:0 pid:3338782
tgid:3338782 ppid:2 flags:0x00004000
[1142527.719297] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.719930] Call Trace:
[1142527.720271] <TASK>
[1142527.720593] __schedule+0x222/0x670
[1142527.721010] schedule+0x2c/0xb0
[1142527.721393] schedule_preempt_disabled+0x11/0x20
[1142527.721890] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.722379] down_read+0x45/0xa0
[1142527.722775] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.723322] btrfs_search_slot+0x40f/0xbd0 [btrfs]
[1142527.723845] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.724368] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.724928] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.725447] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.726030] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.726553] process_one_work+0x193/0x3d0
[1142527.727001] worker_thread+0x2fc/0x410
[1142527.727421] ? __pfx_worker_thread+0x10/0x10
[1142527.727890] kthread+0xdc/0x110
[1142527.728263] ? __pfx_kthread+0x10/0x10
[1142527.728676] ret_from_fork+0x2d/0x50
[1142527.729087] ? __pfx_kthread+0x10/0x10
[1142527.729503] ret_from_fork_asm+0x1a/0x30
[1142527.729936] </TASK>
[1142527.730242] INFO: task kworker/u200:6:3497930 blocked for more
than 122 seconds.
[1142527.730910] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.731541] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.732237] task:kworker/u200:6 state:D stack:0 pid:3497930
tgid:3497930 ppid:2 flags:0x00004000
[1142527.733065] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.733684] Call Trace:
[1142527.734029] <TASK>
[1142527.734422] __schedule+0x222/0x670
[1142527.734833] schedule+0x2c/0xb0
[1142527.735223] schedule_preempt_disabled+0x11/0x20
[1142527.735900] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.736384] down_read+0x45/0xa0
[1142527.736775] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.737318] btrfs_search_slot+0x40f/0xbd0 [btrfs]
[1142527.737840] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.738357] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.738915] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.739429] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.740001] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.740521] process_one_work+0x193/0x3d0
[1142527.740968] worker_thread+0x2fc/0x410
[1142527.741389] ? __pfx_worker_thread+0x10/0x10
[1142527.741847] kthread+0xdc/0x110
[1142527.742235] ? __pfx_kthread+0x10/0x10
[1142527.742660] ret_from_fork+0x2d/0x50
[1142527.743071] ? __pfx_kthread+0x10/0x10
[1142527.743485] ret_from_fork_asm+0x1a/0x30
[1142527.743915] </TASK>
[1142527.744218] INFO: task kworker/u193:13:3507784 blocked for more
than 122 seconds.
[1142527.744888] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.745508] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.746203] task:kworker/u193:13 state:D stack:0 pid:3507784
tgid:3507784 ppid:2 flags:0x00004000
[1142527.747032] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.747649] Call Trace:
[1142527.747991] <TASK>
[1142527.748301] __schedule+0x222/0x670
[1142527.748712] schedule+0x2c/0xb0
[1142527.749105] schedule_preempt_disabled+0x11/0x20
[1142527.749587] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.750082] down_read+0x45/0xa0
[1142527.750465] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.751016] btrfs_search_slot+0x40f/0xbd0 [btrfs]
[1142527.751537] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.752055] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.752607] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.753136] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.753703] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.754229] process_one_work+0x193/0x3d0
[1142527.754675] worker_thread+0x2fc/0x410
[1142527.755107] ? __pfx_worker_thread+0x10/0x10
[1142527.755565] kthread+0xdc/0x110
[1142527.755952] ? __pfx_kthread+0x10/0x10
[1142527.756367] ret_from_fork+0x2d/0x50
[1142527.756777] ? __pfx_kthread+0x10/0x10
[1142527.757199] ret_from_fork_asm+0x1a/0x30
[1142527.757626] </TASK>
[1142527.757940] INFO: task kworker/u199:9:3642616 blocked for more
than 122 seconds.
[1142527.758596] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.759215] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.759915] task:kworker/u199:9 state:D stack:0 pid:3642616
tgid:3642616 ppid:2 flags:0x00004000
[1142527.760738] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.761359] Call Trace:
[1142527.761698] <TASK>
[1142527.762016] __schedule+0x222/0x670
[1142527.762417] ? leaf_space_used+0xad/0xd0 [btrfs]
[1142527.762937] schedule+0x2c/0xb0
[1142527.763320] schedule_preempt_disabled+0x11/0x20
[1142527.763803] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.764300] down_read+0x45/0xa0
[1142527.764694] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.765244] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
[1142527.765804] btrfs_search_slot+0x127/0xbd0 [btrfs]
[1142527.766330] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
[1142527.766946] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.767498] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.768054] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.768577] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.769149] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.769670] process_one_work+0x193/0x3d0
[1142527.770117] worker_thread+0x2fc/0x410
[1142527.770540] ? __pfx_worker_thread+0x10/0x10
[1142527.770998] kthread+0xdc/0x110
[1142527.771368] ? __pfx_kthread+0x10/0x10
[1142527.771783] ret_from_fork+0x2d/0x50
[1142527.772190] ? __pfx_kthread+0x10/0x10
[1142527.772607] ret_from_fork_asm+0x1a/0x30
[1142527.773042] </TASK>
[1142527.773346] INFO: task kworker/u195:9:3726533 blocked for more
than 122 seconds.
[1142527.774016] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.774630] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.775326] task:kworker/u195:9 state:D stack:0 pid:3726533
tgid:3726533 ppid:2 flags:0x00004000
[1142527.776152] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.776771] Call Trace:
[1142527.777114] <TASK>
[1142527.777421] __schedule+0x222/0x670
[1142527.777828] ? leaf_space_used+0xad/0xd0 [btrfs]
[1142527.778346] schedule+0x2c/0xb0
[1142527.778732] schedule_preempt_disabled+0x11/0x20
[1142527.779221] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.779709] down_read+0x45/0xa0
[1142527.780103] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.780654] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
[1142527.781217] btrfs_search_slot+0x127/0xbd0 [btrfs]
[1142527.781746] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
[1142527.782360] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.782889] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.783438] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.783967] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.784535] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.785056] process_one_work+0x193/0x3d0
[1142527.785494] worker_thread+0x2fc/0x410
[1142527.785913] ? __pfx_worker_thread+0x10/0x10
[1142527.786491] kthread+0xdc/0x110
[1142527.786872] ? __pfx_kthread+0x10/0x10
[1142527.787287] ret_from_fork+0x2d/0x50
[1142527.787694] ? __pfx_kthread+0x10/0x10
[1142527.788115] ret_from_fork_asm+0x1a/0x30
[1142527.788543] </TASK>
[1142527.788898] INFO: task kworker/u197:5:3788059 blocked for more
than 122 seconds.
[1142527.790084] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.790815] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.791527] task:kworker/u197:5 state:D stack:0 pid:3788059
tgid:3788059 ppid:2 flags:0x00004000
[1142527.792358] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.792999] Call Trace:
[1142527.793337] <TASK>
[1142527.793657] __schedule+0x222/0x670
[1142527.794072] schedule+0x2c/0xb0
[1142527.794455] schedule_preempt_disabled+0x11/0x20
[1142527.794949] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.795435] down_read+0x45/0xa0
[1142527.795830] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.796379] btrfs_search_slot+0x40f/0xbd0 [btrfs]
[1142527.796913] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.797427] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.797987] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.798516] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.799090] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.799615] process_one_work+0x193/0x3d0
[1142527.800067] worker_thread+0x2fc/0x410
[1142527.800506] ? __pfx_worker_thread+0x10/0x10
[1142527.800966] kthread+0xdc/0x110
[1142527.801340] ? __pfx_kthread+0x10/0x10
[1142527.801779] ret_from_fork+0x2d/0x50
[1142527.802191] ? __pfx_kthread+0x10/0x10
[1142527.802610] ret_from_fork_asm+0x1a/0x30
[1142527.803044] </TASK>
[1142527.803350] INFO: task kworker/u196:19:3788213 blocked for more
than 123 seconds.
[1142527.804025] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.804643] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.805343] task:kworker/u196:19 state:D stack:0 pid:3788213
tgid:3788213 ppid:2 flags:0x00004000
[1142527.806178] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.806800] Call Trace:
[1142527.807148] <TASK>
[1142527.807462] __schedule+0x222/0x670
[1142527.807887] ? leaf_space_used+0xad/0xd0 [btrfs]
[1142527.808395] schedule+0x2c/0xb0
[1142527.808787] schedule_preempt_disabled+0x11/0x20
[1142527.809279] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.809773] down_read+0x45/0xa0
[1142527.810167] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.810717] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
[1142527.811275] btrfs_search_slot+0x127/0xbd0 [btrfs]
[1142527.811798] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
[1142527.812411] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.812942] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.813493] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.814020] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.814591] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.815119] process_one_work+0x193/0x3d0
[1142527.815565] worker_thread+0x2fc/0x410
[1142527.815991] ? __pfx_worker_thread+0x10/0x10
[1142527.816442] kthread+0xdc/0x110
[1142527.816824] ? __pfx_kthread+0x10/0x10
[1142527.817247] ret_from_fork+0x2d/0x50
[1142527.817659] ? __pfx_kthread+0x10/0x10
[1142527.818079] ret_from_fork_asm+0x1a/0x30
[1142527.818516] </TASK>
[1142527.818825] INFO: task kworker/u193:14:3792561 blocked for more
than 123 seconds.
[1142527.819507] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
[1142527.820130] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1142527.820868] task:kworker/u193:14 state:D stack:0 pid:3792561
tgid:3792561 ppid:2 flags:0x00004000
[1142527.821699] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[1142527.822325] Call Trace:
[1142527.822673] <TASK>
[1142527.822996] __schedule+0x222/0x670
[1142527.823404] schedule+0x2c/0xb0
[1142527.823793] schedule_preempt_disabled+0x11/0x20
[1142527.824284] rwsem_down_read_slowpath+0x260/0x4f0
[1142527.824780] down_read+0x45/0xa0
[1142527.825179] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
[1142527.825726] btrfs_search_slot+0x40f/0xbd0 [btrfs]
[1142527.826254] btrfs_lookup_csum+0x5c/0x150 [btrfs]
[1142527.826775] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
[1142527.827332] ? btrfs_global_root+0x4d/0x60 [btrfs]
[1142527.827866] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
[1142527.828430] btrfs_work_helper+0xba/0x190 [btrfs]
[1142527.828971] process_one_work+0x193/0x3d0
[1142527.829412] worker_thread+0x2fc/0x410
[1142527.829840] ? __pfx_worker_thread+0x10/0x10
[1142527.830301] kthread+0xdc/0x110
[1142527.830682] ? __pfx_kthread+0x10/0x10
[1142527.831105] ret_from_fork+0x2d/0x50
[1142527.831515] ? __pfx_kthread+0x10/0x10
[1142527.831936] ret_from_fork_asm+0x1a/0x30
[1142527.832364] </TASK>
[1142527.832680] Future hung task reports are suppressed, see sysctl
kernel.hung_task_warnings

