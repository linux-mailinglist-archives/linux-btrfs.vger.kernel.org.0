Return-Path: <linux-btrfs+bounces-18083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA0BF3FF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D223BB3C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E7255E26;
	Mon, 20 Oct 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvPURugq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F10244691
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002183; cv=none; b=rws4RSWU0in2frdKEm5QWZONlMgSdUYKwTlmAOrLAWmtUDPz2s/9n3QZmtJP3AfSQSET6p9pu17aDmE1sd/QD8mivrs9FFAvvpSKYnMF4+KQ6UIp2zOjy8fc284metJCCqn1dx4EpaJnKT5ebP1SJHaAAl+pOY9+KaAXMq57bYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002183; c=relaxed/simple;
	bh=eQgHPjfjYPih0EMA4uoePu67Sm3WLSIaJjWlh1/mycU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SdiPF5j+cZZMS9AXhAdchjvB6z6nR6CEouLaWaMcSOE3szXQE4JUH7vYfFe2W35J7tbCZkxAEQMa32vxqnj0i2a1SYgWD3EF51Z0tGkGchlTtJlOLMSAPKNgjldCuq/AO2+xSImd65euEkGVbQ0mXfqEYcbxT/mhSzZHAz8HlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvPURugq; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7814273415cso40294967b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761002181; x=1761606981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=69DtbZl7O3J2V0yM2JvrpMSVLl9pRTj/WyGCTZ+3/uI=;
        b=LvPURugq7ciNbbEaKaXCCoYOGeE0+LfFeUKraE0ournEnVVOW3HRXuz378Sg+JzEnA
         CT/znixHB3x5KAzjeNmfp8s6nFhcB0lIDtvwCa/AXnScOhrcRBtzChgYdc3mTloDFYBI
         876jIxmjwdBqjQQoIJzTWpmbJxIiGGGkYI8Tm7TFRiaS+HPep+SDVm53X0bmaRyrALFv
         1tA8F7RnGL0FBiAcjU15DiGzQndeEWzpchU/HHT3VGc6PGCju+MGgrp64ql+r5H4bvbv
         pybkhlDbXbv06MR5ix3xYbHbDHh6Igji3cCKOeoe0MJ7tx2DZwKsS/dKDoZcJHZGu4ZG
         wMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761002181; x=1761606981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69DtbZl7O3J2V0yM2JvrpMSVLl9pRTj/WyGCTZ+3/uI=;
        b=JPjCaZEKowhakmsGaoNUqWaLtcnYzeFi11JvJam/IpScE/5YZSKztzG6EBbQJBrHTh
         Z2vpzMDUW/lg3+xaXsNl8uiYXugoMG0NPx1m9cVdmTy6XRaFdSDkB34xgObtEL+pssYE
         zNn0gvu1luZu1TpscF/KlZ0ESXvH6ewY9xfqvsu9inbYxiLw1WDRU6FzYxSV/3t6ELsd
         HbIw6NaYkPbL6UOiSija9hP6AkmRVBqXxlrJ+uUo2/EKydtHEgyUx5ZXYwQc6TGPD9Ss
         pfXKAbwAAHIfKl9+ITK4IDTVOFj9zJWr5yeUeTcXf/6g0yEgjeUmtQiJzbhnIjD3R+Sz
         o6Yw==
X-Gm-Message-State: AOJu0Yw24pOQQHsxdYBr7IMS9y/POypo0tbGu+S8By99OOW0FIRM54Tf
	OFW0IerX20QlRrP4XNfG2JWm85gqel5wgzf49hS//uI5ipbVFaDXSppD35QG0eyy
X-Gm-Gg: ASbGncscretielsHqbISGcmXhmG6aCyk8NoDHi5roCi41Q5mfl7uA2M7k3YmQjw0VnH
	v2qP69sWy9s1aa++nzbryu7i5dGlolTCxzUw56zvOxZG3pwRqcMid9ULoFK51SVGa8MCOsFlPmo
	3nL4AeNcmQjqB3BcsD3oh8ryjbfCz6YgsEQV009tRixEwlOWEui+VL5QFS62ZAXiCj7eZ1F6fYI
	LmSDP8g/DDNphvcDO7k9xL29NNHFNI6EsTvnld4m7WH2m8huZCVXSzRzOfHGIl63d46k4fTKfBA
	/1/0SUbTSRLai+lee099djjNDjUbPkQ9Jf0o3El7n1BusnoozSrQjsNnjcIArF6qUxySs6+WH/4
	CxCK56PPIiOIMRe7MQfWcnZbMASof7A0XllrBaA/m/sc1LVcZuUvso7+Qm9Rt6APss667aR1Lir
	7VQ4lJqXM=
X-Google-Smtp-Source: AGHT+IFtvNKt2pbiqYuk1a0cF5sqVHwINqzEbQCwkLCPbaYuVzVx029JUu7U02K1ptlCoBVMv3bjrQ==
X-Received: by 2002:a05:690e:34b:b0:63d:337a:1e07 with SMTP id 956f58d0204a3-63e161da87fmr8592910d50.45.1761002180547;
        Mon, 20 Oct 2025 16:16:20 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63e266bb40asm2743896d50.10.2025.10.20.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:16:20 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix delayed_node ref_tracker use after free
Date: Mon, 20 Oct 2025 16:16:15 -0700
Message-ID: <e5d6dd45f720f2543ca4ea7ee3e66454ef55f639.1761001854.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the print before releasing the delayed node.

In my initial testing there was a bug that was causing delayed_nodes
to not get freed which is why I put the print after the release. This
obviously neglects the case where the delayed node is properly freed.

Add condition to make sure we only print if we have more than one
reference to the delayed_node to prevent printing when we only have
the reference taken in btrfs_kill_all_delayed_nodes().

Fixes: b767a28d6154 ("btrfs: print leaked references in kill_all_delayed_nodes()")
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.c | 2 +-
 fs/btrfs/delayed-inode.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 41e37f7f67cc..3df7b9d7fbe8 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -2110,9 +2110,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 
 		for (int i = 0; i < count; i++) {
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
+			btrfs_delayed_node_ref_tracker_dir_print(delayed_nodes[i]);
 			btrfs_release_delayed_node(delayed_nodes[i],
 						   &delayed_node_trackers[i]);
-			btrfs_delayed_node_ref_tracker_dir_print(delayed_nodes[i]);
 		}
 	}
 }
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 0d949edc0caf..b09d4ec8c77d 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -219,6 +219,13 @@ static inline void btrfs_delayed_node_ref_tracker_dir_print(struct btrfs_delayed
 	if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
 		return;
 
+	/*
+	 * Only print if there are leaked references. The caller is
+	 * holding one reference, so if refs == 1 there is no leak.
+	 */
+	if (refcount_read(&node->refs) == 1)
+		return;
+
 	ref_tracker_dir_print(&node->ref_dir.dir,
 			      BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT);
 }
-- 
2.47.3


