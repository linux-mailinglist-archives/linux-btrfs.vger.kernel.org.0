Return-Path: <linux-btrfs+bounces-8380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6513698BAA7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148001F216DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4C1BF32B;
	Tue,  1 Oct 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="Q6sLZcJ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2219D88A
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780951; cv=none; b=LYsRiQsSors5BwIWElTNf13F/jhAb/QXz2LOkJ6V5Rmc58OyYN6dWtdFIkkvqztmPGBOM/LSPc+TU2McBS2uoseANYTYNJXfpD37IeznE+HGH5ulRJqu32ysyRlOMVIBmFfPes3Q5+D8NX205FHayGAGigNPvPTN2UXfyxT9oe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780951; c=relaxed/simple;
	bh=wbA757RxCzLM2R6ypMFsoaICyPYj84K+4eKZ0608s6U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L1n5tyg5bABpGqP1Pis/4vPYmap5J0j+9EMb7gsuJxTiT/1SghCFHEeKtw51Ba82sgI6B7+7khL+W1VzpDgIYjMTsGAFNevRCueJv7cMzugl0LAfpHEMEjz6VlZF7FdKFGahPHTZy2aOebLI+WOEnUowcXYZ2mSc3VXCBncNozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=Q6sLZcJ2; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-28706be9bd7so1855033fac.2
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1727780947; x=1728385747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bZhCOS4GVvypLhCEScHX53zbOfld7GzpHuQKaYdpXeQ=;
        b=Q6sLZcJ2+haf+iJVM99X65jy1+rQP0flq2Aw7dpB7rsM/Aol9ib3Gskdna8gh8ulS1
         JAafG+47uyd+hXVi/F3sKhXJ/KEVlR3WmgY9MxsQC3kMoudSvdlQcDnoPrQRlWuwZQLa
         ziCUiXiLFtjLfbHW9HkQdW96FzARZgLmxLKBC7LYiROQSiM0Cql8EOmx5bflGS7wMy65
         9RRnPIP/IXTknOvhC1O/VubUNNXFH9NqWrClmgcQ7ONziwyKNWwhrs/LAtoywNBk/J3Y
         sGUOLxEBpooByFL3k7zTOkHncy2KyacY18E9CkfQFm8rh/lgPGqU5NSPJwLlWRdtH5bo
         XWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780947; x=1728385747;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZhCOS4GVvypLhCEScHX53zbOfld7GzpHuQKaYdpXeQ=;
        b=PxPb7MzUV+F3FI3lKcIhpM5qCxC3i04cirQtAtfD3y1XR25NacWeW43dQ3pbe3vuGZ
         k5mPjtYJsWK75qpSRNkXM65j8uwtSCJF03Lw/EZl4dqPOTfBvyzfxP3nxqqyk5UIsm8u
         x2USsKPdLMss+5huoG8enMsQ/EmcQLmE4ehBKGJ2AHH1D4mteQHvMqLq9xcFQyC77QSx
         Tuqant2s+o5gTwyIL17lIsvTxG9rKDfG6tDLsZw2UfMKoG5JVYr8yr0V0+mSGgnHpMZS
         VMPWek6AvI+JXCNP81oqqJPJwR+h+FxJbBqwKVumbm/dRMRovlz8RWKIsn8RV3fWUoTT
         7xng==
X-Gm-Message-State: AOJu0YzlzntKwKCPJE80oDGtBQjqQ916pRsOi32xshkMOASb2peI3PBr
	KKUrfA+93LjHlEKnkiQ96mJTTLOkDESqKPfqR3//c5Syqiu56QQSAmAJxwWokJhhjVxltsv5sfa
	CJgjZ5R4MsiI8uEtMucApY7To7uwtr+NBY+xTUBlzSjpC4KU/Z37sZA==
X-Google-Smtp-Source: AGHT+IGr150qM1QKgY/rmeoFJMvmIdbD/NZYhEwKr4A2WvX4GRJ1r0L7AF3VyCtCJ+HVMpkvFPiLOG7Ix9yAUK2Cl5o=
X-Received: by 2002:a05:6870:b48d:b0:278:65c:3c14 with SMTP id
 586e51a60fabf-28710a01259mr10054823fac.5.1727780947239; Tue, 01 Oct 2024
 04:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Tue, 1 Oct 2024 14:08:56 +0300
Message-ID: <CAOcd+r1Cwaa9SG=ND4RtuT0CBP4gmCE1tvj0uW-VybD2hry_uQ@mail.gmail.com>
Subject: assertion failed: ctl->total_bitmaps <= max_bitmaps
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Greetings,

We have hit the above assert a few times in kernel 4.14 LTS with
stacks [1] [2] [3]. In all times it happens on a METADATA block group.
We are not using free space caching - not v1 and not v2 (free space
tree).

I looked over the free space cache code in kernel 6.6 which is the
latest LTS kernel. However, I did not see a fix related to this issue.

I did see a patch that prints some information about the block group
in case the above assert is fired
(https://www.spinics.net/lists/linux-btrfs/msg127072.html). We will
apply that patch.

Is there any other way to move forward with this issue?

Thanks,
Alex.

[1]
Call Trace:
 dump_stack+0x5c/0x85
 panic+0xe4/0x252
 assfail.constprop.18+0x50/0x50 [btrfs]
 recalculate_thresholds+0xa5/0xb0 [btrfs]
 __btrfs_add_free_space+0x2d2/0x430 [btrfs]
 ? _raw_spin_unlock+0xa/0x20
 btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
 btrfs_del_leaf+0xa5/0xd0 [btrfs]
 btrfs_del_items+0x3f9/0x470 [btrfs]
 ? btrfs_get_token_64+0x103/0x120 [btrfs]
 __btrfs_free_extent.isra.63+0x626/0xf60 [btrfs]
 __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
 ? walk_up_proc+0xa2/0x600 [btrfs]
 btrfs_run_delayed_refs+0x62/0x270 [btrfs]
 btrfs_should_end_transaction+0x3e/0x60 [btrfs]
 btrfs_drop_snapshot+0x3db/0xf70 [btrfs]
 ? __schedule+0x298/0x8a0
 ? __btree_submit_bio_start+0x10/0x10 [btrfs]
 btrfs_clean_one_deleted_snapshot+0xb6/0xf0 [btrfs]
 cleaner_kthread+0x330/0x3b0 [btrfs]
 kthread+0x11a/0x130
 ? kthread_create_on_node+0x70/0x70
 ret_from_fork+0x1f/0x40

[2]
[2512545.669387]  dump_stack+0x5c/0x85
[2512545.670047]  panic+0xe4/0x252
[2512545.670660]  assfail.constprop.18+0x50/0x50 [btrfs]
[2512545.671612]  recalculate_thresholds+0xa5/0xb0 [btrfs]
[2512545.672622]  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
[2512545.673629]  ? _raw_spin_unlock+0xa/0x20
[2512545.674405]  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
[2512545.675401]  btrfs_del_leaf+0xa5/0xd0 [btrfs]
[2512545.676259]  btrfs_del_items+0x3f9/0x470 [btrfs]
[2512545.677165]  ? btrfs_get_token_64+0x103/0x120 [btrfs]
[2512545.678156]  __btrfs_free_extent.isra.63+0x626/0xfa0 [btrfs]
[2512545.679245]  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
[2512545.680285]  ? finish_task_switch+0x74/0x210
[2512545.681112]  btrfs_run_delayed_refs+0x62/0x270 [btrfs]

[3]
[1272566.513241] Call Trace:
[1272566.513764]  dump_stack+0x5c/0x85
[1272566.514442]  panic+0xe4/0x252
[1272566.515080]  assfail.constprop.18+0x50/0x50 [btrfs]
[1272566.516071]  recalculate_thresholds+0xa5/0xb0 [btrfs]
[1272566.517119]  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
[1272566.518155]  ? _raw_spin_unlock+0xa/0x20
[1272566.518963]  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
[1272566.519993]  btrfs_del_leaf+0xa5/0xd0 [btrfs]
[1272566.520891]  btrfs_del_items+0x3f9/0x470 [btrfs]
[1272566.521833]  ? btrfs_get_token_64+0x103/0x120 [btrfs]
[1272566.522847]  __btrfs_free_extent.isra.63+0x626/0xfa0 [btrfs]
[1272566.523975]  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
[1272566.525082]  ? btrfs_add_delayed_data_ref+0x251/0x2b0 [btrfs]
[1272566.526235]  btrfs_run_delayed_refs+0x62/0x270 [btrfs]
[1272566.527283]  __btrfs_end_transaction+0x2fd/0x520 [btrfs]

