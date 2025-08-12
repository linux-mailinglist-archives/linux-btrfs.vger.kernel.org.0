Return-Path: <linux-btrfs+bounces-16033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12421B23C2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DEE6E4A99
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB9296BAD;
	Tue, 12 Aug 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB9T5qnn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF21ADC69
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039889; cv=none; b=fJd41tGmW0q/nQfBP1DFCEIhxSs/4CLIY+F4Dx2TqsiBzbbehzO7PqkG8o/uNVAC5+PVCgT77rFonMnp/Kk2hLPF5jokaPvqmxw3KdF6kYLjD12OyGEriEt/qIMrr+oHp25BGIHgain6ntd4SXL0rA+Pou6aD/LOzYV626GzFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039889; c=relaxed/simple;
	bh=Ol+acYe9na+r3f8aB7M750Es06W9ONjfbON7mKSwxDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NNnF/wJOD7g+lvG3POAopD2ePuGrbFGnAhw6mPcdNX31wuhJCFJ/Hwhpx/vz4zsugch8C+G/kaT6J9dkLSmq8Dtlcu3Mjveo88kjaHOyNYNCyNBy33DwWi5BVU7rKvQ9L6pnmygNll6Nw+bGb118EWzQs2+Xr0fN/MT/m7lErS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB9T5qnn; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e8e1ae319c6so4838015276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755039886; x=1755644686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+Zpf4B0SVml88AV0G8gz76heGZ9OZgSeVh6lPLPtis=;
        b=cB9T5qnnbJd7KqdK9k+I+GyQPfkG2BQ1zS5A6XvkSDwuYXLITnMmTgqnRiaV0R6E4I
         ESxww/1RQ8O1XlrI/v5VkMGdox07hDFXOpiSD0zci9Y+olxP3vlz0JEIJoQI0jasaaUV
         FKQVa4TnLywd31yvG2CvZUD5wmB8bkQ5L1ptIlPOV0yjPtG6Bh9Qr9hEYt0N6Ht/YAf3
         D95BelYqpf5rq76LliG/TzNVylYseGDds+dT0cuBoDAb2W5tZTvZjHziecsgsfRZDKkc
         3aOOrGVx6XAtkcpscyksbW+AOtFbhvJF5wdx0wyURpDvIztQARHkJdLaMKvQ4LyFJi77
         tDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755039886; x=1755644686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+Zpf4B0SVml88AV0G8gz76heGZ9OZgSeVh6lPLPtis=;
        b=GbrUJnIfEtCMX0BH0GyCYcdN/GR2D6qXUiwSS/9LHwURWO8MWtZfyISZkbGzeXQbGS
         q8Xrw9+tVLI2JKTxmnpo9Mb1ZkygnliyJamweCojQs6/w7UXTkNUWilQMAUKBwBolWmF
         a8TdWBmNYalWYnW/yncQ8pZ5exiWfmkV1gysqAgsSK8BdZ4HUjjiCfwzzSliSvbWLeCb
         5lbvFsDH9Ei52CRilB2L0Ox1wqtn6O4Lh7vhmwzAZ9EOoVapnLGK1QWNdvaT3zN00TfG
         +hUemlVsjslmf0OAa70CwgqcobIC5qx1Sv0gRyVQjP6tu2hY/9ubRbNu46ieSlR0dCtd
         on7w==
X-Gm-Message-State: AOJu0YyPBNnIxLyD3iyt7/jjSVko+9kfNoM9CIb4alkQAC3rBMBwJyQA
	QEWEbfODRwJzZEBFdikcZ9xGNgwzFn5ABl/P4Zvw56SHkSQWbGtSLtlBTtCDdP2A
X-Gm-Gg: ASbGncsmbdxI+m1aXhnBGa7Q6QLG+1EtS3ZI4EB1JEh78FDZQuHwQ7EjGS8xAYNlpM1
	Y+atThgpS7P5HGDw/iRiq1cD8g+5j0lNd1lMb1D2jx8HmhHeiCK5EaIN9o+UVWH0D2Usg40mjce
	Byv0qD1xkBCor+DYALVbbGJO3aoL1/2co0WF+vGn3Fxa7Az7apiROawgLqmaoR+9xJvudOlBxLP
	nP+573kLQF6ZZjGwJVhIE32/JwzAA+MwQ8TE0g4NQdJLLOl4woS0iXLCe45eILUjB/xLIMYxJp3
	1RTm36MbKAMGW6wy5ZWMUErmY3E2fNWcLpCCy5GRVCXNJsNOIHLTDfq3Kt8OVmAzaGq13LW1+Gg
	ikhuD5AgznmqEKbzz
X-Google-Smtp-Source: AGHT+IFfiK0nBitDRZEwWVlAzgeRVJuPpIfW0JzJ+spYT8+INzj2/LNQWyIKHqiDaiPTFfagsPmgYQ==
X-Received: by 2002:a05:6902:1506:b0:e8f:eb74:24b7 with SMTP id 3f1490d57ef6-e930c24d4e7mr1459063276.49.1755039886012;
        Tue, 12 Aug 2025 16:04:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9046d8a0c1sm4714836276.13.2025.08.12.16.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 16:04:45 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 0/3] btrfs: ref_tracker for delayed_nodes
Date: Tue, 12 Aug 2025 16:04:38 -0700
Message-ID: <cover.1755035080.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leading btrfs related crash in our fleet is a soft lockup in
btrfs_kill_all_delayed_nodes caused by a btrfs_delayed_node leak.
This patchset introduces ref_tracker infrastructure to detect this
leak. The feature is compiled in via CONFIG_BTRFS_DEBUG and enabled
via a ref_tracker mount option. I've run a full fstests suite with
ref_tracker enabled and experienced roughly a 7% slowdown in runtime.

Changelog:
v1: https://lore.kernel.org/linux-btrfs/fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com/
v2: https://lore.kernel.org/linux-btrfs/20250805194817.3509450-1-loemra.dev@gmail.com/T/#mba44556cfc1ae54c84255667a52a65f9520582b7
v3: https://lore.kernel.org/linux-btrfs/20250812113541.GD5507@twin.jikos.cz/T/#m264fd2f4ce786d9fbbb8a16b6762b8341f5ef902

v3->v4:
- remove CONFIG_BTRFS_FS_REF_TRACKER and use CONFIG_BTRFS_DEBUG

v2->v3:
- wrap ref_tracker and ref_tracker_dir in btrfs helper structs
- fix long function formatting
- new Kconfig CONFIG_BTRFS_FS_REF_TRACKER + ref_tracker mount option
- add a print to expose potential leaks
- move debug fields to the end of the struct

v1->v2:
- remove typedefs, now functions always take struct ref_tracker **
- put delayed_node::count back to original position to not change
  delayed_node struct size
- cleanup ref_tracker_dir if btrfs_get_or_create_delayed_node
  fails to create a delayed_node
- remove CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER and use
  CONFIG_BTRFS_DEBUG

Leo Martins (3):
  btrfs: implement ref_tracker for delayed_nodes
  btrfs: print leaked references in kill_all_delayed_nodes
  btrfs: add mount option for ref_tracker

 fs/btrfs/Kconfig         |   3 +-
 fs/btrfs/delayed-inode.c | 193 ++++++++++++++++++++++++++++-----------
 fs/btrfs/delayed-inode.h |  93 +++++++++++++++++++
 fs/btrfs/fs.h            |   1 +
 fs/btrfs/super.c         |   7 ++
 5 files changed, 241 insertions(+), 56 deletions(-)

-- 
2.47.3


