Return-Path: <linux-btrfs+bounces-1194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE0822275
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC1028479C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA016410;
	Tue,  2 Jan 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2WMv4XZV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7CC16404
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jan 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e784ce9bb8so73476427b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jan 2024 12:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1704226691; x=1704831491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpq9K/mL73ipjfP2eef/+0SA9OsyRalGNJEvRxq/19U=;
        b=2WMv4XZVCtzZ1r3jQdx+bd4r/IBDT0TYtzOfIKQXEYBzafQAjqdUtHVw47hlQe44Xp
         wB0YNyea9fNMWHyQ6W0KcbYDCxI6iew8K0xkM6L+y5y4yOKBZ21TXMBbSu8oKcmdRfM2
         86e0JQXoIrojgGVL/FFdqDXhShPvxRFXMBzsJjfCVhSNE6anGDU1WEAhS1Py2sQLU416
         NadwLbV8rTj5ijf5OVo4ooyMIrwY3w/wK9/yEPAYmLgotGNsPpvSBUmmLuDuPWy0cxJW
         JmVX6KDdZ7TWtoXXaggedIRE3QLLPmTxUvPLJIY293B9ex+LbeffqprFlkTSoBVrCF9P
         kBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704226691; x=1704831491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpq9K/mL73ipjfP2eef/+0SA9OsyRalGNJEvRxq/19U=;
        b=S0DNSeq31LjqzkfsvhQ0UEKQEfQo8UQUU7ra0+0gv3CdOO82LQS5x8aV8RJ6lnr9AS
         8OisJ4F3z1KD8zTdV3QVGfas80S9JQAIuLYen9hA5oAmsxJMF/wQPUhuYkV97sj/UMTN
         mGenjue6tA8rq1OwIOtxojnHTHegsMmeDAc4706cvxO8Q+79cdiRG8E1t5l6GFpAnhpX
         jFgokbXcr7sD6oCNvNZ1HxYlWXwcWkxh+n1jyO0bW+B5W2n8IEwOt2Uot7VitlB0CosY
         QSSlB4Y8blZoFiw/cc3v74BcSyHcM/N+fATxxVUhBaqPKOro/LH2ss+2/AlL/g2KDGYN
         1JPg==
X-Gm-Message-State: AOJu0Yz5sln0Giz/o1Vblj6AOrrrXy0FenO0jRTeGcRvLyQ3Yc2fxASe
	/Md42e62QsqG8mdgYLXGdg7vlp0QcTO2zw+I1Fyr/txAFb4=
X-Google-Smtp-Source: AGHT+IHhmoafvnVGnr65wqAlJ+agQs5RzGzCMqtrc9qZVUWy9ms3t2Fp7FoOkXzJ4K/sqe206FJUyQ==
X-Received: by 2002:a05:690c:270b:b0:5ed:a981:fe65 with SMTP id dy11-20020a05690c270b00b005eda981fe65mr5809522ywb.26.1704226690884;
        Tue, 02 Jan 2024 12:18:10 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k3-20020a0dfa03000000b005e7535a3303sm12474807ywf.91.2024.01.02.12.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 12:18:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: WARN_ON_ONCE() in our leak detection code
Date: Tue,  2 Jan 2024 15:18:07 -0500
Message-ID: <f94513bea5369c4ea65c8dab9a5a83403381c521.1704226673.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fstests looks for WARN_ON's in dmesg.  Add WARN_ON_ONCE() to our leak
detection code so that fstests will fail if these things trip at all.
This will allow us to easily catch problems with our reference counting
that may otherwise go unnoticed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c        | 1 +
 fs/btrfs/extent-io-tree.c | 1 +
 fs/btrfs/extent_io.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c6907d533fe8..5f350702a4d9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1244,6 +1244,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 		btrfs_err(fs_info, "leaked root %s refcount %d",
 			  btrfs_root_name(&root->root_key, buf),
 			  refcount_read(&root->refs));
+		WARN_ON_ONCE(1);
 		while (refcount_read(&root->refs) > 1)
 			btrfs_put_root(root);
 		btrfs_put_root(root);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index e3ee5449cc4a..1544e7b1eaed 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -48,6 +48,7 @@ static inline void btrfs_extent_state_leak_debug_check(void)
 		       extent_state_in_tree(state),
 		       refcount_read(&state->refs));
 		list_del(&state->leak_list);
+		WARN_ON_ONCE(1);
 		kmem_cache_free(extent_state_cache, state);
 	}
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a0ffd41c5cc1..a173cf08eb8f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -82,6 +82,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
+		WARN_ON_ONCE(1);
 		kmem_cache_free(extent_buffer_cache, eb);
 	}
 	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
-- 
2.43.0


