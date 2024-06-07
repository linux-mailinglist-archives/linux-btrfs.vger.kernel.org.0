Return-Path: <linux-btrfs+bounces-5533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B269006A9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F01B219C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393C197501;
	Fri,  7 Jun 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEqwQnQP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F9200A3
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770627; cv=none; b=EuYy1ncubD4J4Gawm49NP8iMSmBVaxxaKPAmMSuGVZVEYrtm5EBt7jK7VYs698U9RU2ljqneb9K0BIVgwsyhEyMgQYbr1u1Wm38LVfRxlyRzjhe/YtIMDdsPA/RTTuyi0FUiV1UCiAsl+B8UaUR0YSw07nBXT3kO4q1hCw1/d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770627; c=relaxed/simple;
	bh=/xkwMOhNCOfLsN2HIjrQK8RREVcv/Jtfuf6woPPo33o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eGtgyOZco6VWZvjlOsNOfbpfiZaAPcMWUgZnCCyDD1eqoOqfqxALaUHpbKqN2442qgN4lZ7fM/0caaVkGNToQodxPHqgU816ov/OpEArB8k5eNzL6CVHetHEnfH/TuQeXoKGrCyV2+mLXp8dKY6hP+crdtEvxGsC9JGeT8zXz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEqwQnQP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f6e183f084so3731865ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717770625; x=1718375425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcTrLmymNtm727ea1sPdne662eBqxbb96vILxmE79dI=;
        b=WEqwQnQPZjKJ9yJcTa2LotmhDj15I8e/1FBU4XKYgqsIbn/aPURd35eoTwEXl0Imf2
         QOb/fnAMpc75yhBqh1l3fzcv+yAdFhWgj0sqGay7uiWgH1H9FEepzgZkIRFm1BMEX6gx
         J8ByH5fOnwL7w/aEeHgH5zEcy07zdLaC2UC5TyPtVmJsaUvA2sGus1w9qRwlur3ndClX
         1nydMSo6MW2jByzxdcRj01431AZ/5DTjVUT6z/7GKUzfn6NpEgWiQAedcm/l/lYKgBjl
         ZOXKzTKJNs+YngRxQvpYG38KbSlKweRscccbhnvY9lSyZ8ErM4oRDLAtUCruuVfQUa15
         upNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770625; x=1718375425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcTrLmymNtm727ea1sPdne662eBqxbb96vILxmE79dI=;
        b=qgqoBq4KXQJS/XO1r5u32TlCOJxBT4koDZhN+36EP36/rf2qKEhSavnZN4EIH7pY0Q
         zwAxffjOLNBHxvZFerYsMWgzrfk667W3ys4I95Cgt737l8tXNFA75zy7OG1Qcje9J4r8
         u6lW9hQKAdrLmnek+NWG0/p0XhlTLVqV06uwIY0nC/XKGVB0IH9zu8ilsNXv9ZBUef2O
         nnddpQNtJNAZZVH4DmobynMIbkhe9EKmgDCVIcnEgXQQmLcGMjP6l1HNne2vj8IkwSBZ
         TVSdc+LHS35iLd2WreFsrWeRBdn/q/iUwfv9DKy0CSilFBNVkbGr+aFsWxCd/9sXursF
         0ixw==
X-Gm-Message-State: AOJu0YwZvNO7EzA5X6a7s4zYkVr63tA8ffQUB60Y4HBzLH3Y/HkUcuCR
	yox/hsJDCmxXe6RkcvIces+zOOMKmrnzCCH2HcrKbcjqDjwfQr4DWX/jE0pmwVM=
X-Google-Smtp-Source: AGHT+IHNbSIX7bmKZ+qyvkVYcMfJIKGfrnIG1u+44oWdjvh0rVaUeUHsm6ndKTUzvaZ36M08ZjvyPg==
X-Received: by 2002:a17:902:f549:b0:1f4:64ba:af9f with SMTP id d9443c01a7336-1f6d03bde49mr33173385ad.48.1717770624731;
        Fri, 07 Jun 2024 07:30:24 -0700 (PDT)
Received: from localhost ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76b70fsm34896135ad.64.2024.06.07.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:30:24 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v3 1/2] btrfs: qgroup: use goto style to handle error in add_delayed_ref().
Date: Fri,  7 Jun 2024 22:30:20 +0800
Message-Id: <20240607143021.122220-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up resources using goto to get rid of repeated code.

Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/delayed-ref.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6cc80fb10da2..1a41ab991738 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1041,18 +1041,13 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
-	if (!head_ref) {
-		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
-		return -ENOMEM;
-	}
+	if (!head_ref)
+		goto free_node;
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
-		if (!record) {
-			kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
-			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
-			return -ENOMEM;
-		}
+		if (!record)
+			goto free_head_ref;
 	}
 
 	init_delayed_ref_common(fs_info, node, generic_ref);
@@ -1088,6 +1083,12 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	if (qrecord_inserted)
 		return btrfs_qgroup_trace_extent_post(trans, record);
 	return 0;
+
+free_head_ref:
+	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+free_node:
+	kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
+	return -ENOMEM;
 }
 
 /*
-- 
2.39.2


