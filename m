Return-Path: <linux-btrfs+bounces-521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53344801617
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1D7281E3C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA315CD05;
	Fri,  1 Dec 2023 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nXq/jpGg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A010D0
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:48 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cce5075bd6so22789527b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468767; x=1702073567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=To9jP0OMafmtyLxtyQVvx+ygcdRboZeNuphRs/ixeY8=;
        b=nXq/jpGgGjxBm+1QKNolaeO9Y8lufuyJhGNZc76zgik9xFJsEqtn2/AwCp7scRx+x9
         m7vFP5WAvInqiDFC1DDwycAq96jw9J6g6fziPN5/mV9H4QDf34syUBgVERQUKPkkLU6z
         u44jhIKwc/7v6dApofBHVk7bhGV6XioHTewbRmE91KnvUH3/lWR3d2492c6kCXYJ0dtd
         SNufcoY9xpNXjrg5ck6+kgTmc80IlcN/rZJhvupuuu/nczZ6L5YUFt6HY0MmtuvI/MRU
         r1zpgtzSWuS7c8Z79os3jQ5iLK63d92g9HgXap4hTCSZprPnl7r71VVs4zUAl4q2BhkB
         ooLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468767; x=1702073567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To9jP0OMafmtyLxtyQVvx+ygcdRboZeNuphRs/ixeY8=;
        b=iEMw8M0eE5rCxzsq7ySSYqCFMiKibHJwVX6RpDPbIF0MOx0bjcjn2LotQo7IogySke
         Te6Gf4efRg6SxC8ei7/rKyU2Qf7oSh/LigVHyh/gQ5g9RvVYMgTnSVb71Ef8g6huiYJ7
         cho7ICBpT8ze/TZpdC7zWNrYlV12oCvmyVFoCvjhIetI8KE1WYamgynisiJCG6BDCrKO
         Cvw1qeMazHzfON+vaSUM6n5H6W9RCsRPe0afBIqR8eb8LDP57LLke6MbChj8s7a3J4Lh
         0oz2vy3il/run73MMp8AdB+sz5KAq4wbqTu5cMdRFe4IGdKes7PGXmfUHx+FXqN5H+xD
         YskQ==
X-Gm-Message-State: AOJu0YzXPiqjzqzfMNzjMpyMDOt+GpGzkaTPZ0ZrmrNeDpIAEzcvM7nu
	SoRcj8kd99JF5n9xLfK7aedVhmKRu+7pdq4dbIqkPw==
X-Google-Smtp-Source: AGHT+IEV7qvQUvQ7dVIdOHP6KIEg+8A7r1mAJ4GyXkJqOBWmRFWrg/2XHdgckyDW2CK0/l4ADvT8AA==
X-Received: by 2002:a05:690c:3709:b0:5cd:fdfd:dc28 with SMTP id fv9-20020a05690c370900b005cdfdfddc28mr306324ywb.7.1701468767224;
        Fri, 01 Dec 2023 14:12:47 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n16-20020a819c50000000b005ccb2d17ba7sm270329ywa.101.2023.12.01.14.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:46 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 40/46] btrfs: don't rewrite ret from inode_permission
Date: Fri,  1 Dec 2023 17:11:37 -0500
Message-ID: <060bf2d2a9f5eea2675f82ac0a7cc22bba8b4665.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our user safe ino resolve ioctl we'll just turn any ret into -EACCES
from inode_permission.  This is redundant, and could potentially be
wrong if we had an ENOMEM in the security layer or some such other
error, so simply return the actual return value.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 48d751011d07..2f4f9f812616 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1977,10 +1977,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			ret = inode_permission(idmap, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-			if (ret) {
-				ret = -EACCES;
+			if (ret)
 				goto out_put;
-			}
 
 			if (key.offset == upper_limit.objectid)
 				break;
-- 
2.41.0


