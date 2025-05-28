Return-Path: <linux-btrfs+bounces-14267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E19DAC5DF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 02:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21559E4DCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144B13AC1;
	Wed, 28 May 2025 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+p+kd5g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE6EEB2
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390673; cv=none; b=Ft0aEDuNVPqWbAGG6pWHrDnDP5C/WUTAFqTKak8Y4/PGR+QLR1asSxZKfiU9U1oA2Jwk6zN6nhGuNcRC9LMHsdoQ9L39HYNiXvDm9R+ph+Zf1SkXm5rucnYp8Ix7rIzjedqmVMHV/vHizhTO4VlO/Fj4Qkd/+SYsgjTYerloEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390673; c=relaxed/simple;
	bh=16RSBmHW2WvDPJPIMJjXm6Pvs9eZimVrpD2JwGlyHcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9zl9HToaNwX3KGXsM9yE9JIWEZSyQzx+/bO9X42rwYtZ2d1awLJri76ACcjWGmE9VThAnkk3HR3Nt4N5avQKZxTUnoo8lerqVt5+ueMu+ijrgUbMYYzEo5qY1Dofbk1J8NEX4/d2ElB3nC/SIAO3mcSZwze/eUiIXBuH1RhIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+p+kd5g; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-3f6aa4b3a7fso726631b6e.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748390670; x=1748995470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+RsNlsTWQXWyQ4XcAxGpRMgxAJkjEfZsDhyCbOxdxw=;
        b=i+p+kd5gmiWJ7sbgXbNWUCFKQ8GRMSuj6b0PtHSrywiIVV+0TLoceXHkMbOamuit05
         PFAIp26joidkPhV0mXhaVCphcvK20nLSf32O/e4+GRgp4g1bXN1DnjsunV4JgQiqvyd2
         SBWu1gTp8RET5DYSTBOlaVxChRYc8FBQJeBMUBgB73LCN1ftQ5jD2E9zKSNbswrklY72
         y3dJK7wkU87aP5IPqoiLqQcwqU39UM7nvAjl1kkmGjM7/wRz60wNWahks+szSRUwwykp
         XY6P+Gc2Jf3SuV0oGmSIN4eh3XItvjjGZoPjUtWKKZlm+fBdBnLluVPYMmtGyqaLlhQx
         t2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390670; x=1748995470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+RsNlsTWQXWyQ4XcAxGpRMgxAJkjEfZsDhyCbOxdxw=;
        b=jSWmYIumSSWUow4X5A8wh8hwzVkdykxlKDkz4b1C62EjmcJj7DXdgs5kVVbzLd8sIX
         E2bOM7e7xO9Y/IcQLTd29vRkMuZSwC9NcYmGvGMlEM36kJD8JPI/UCLj4gFUVWWOkZM9
         QLldB9m2Flwx0GnLrife302WmTIeolkjNVPDGVJyrUzFf2BuyG3ecJ2qEi/6U7N8/jgS
         rMjsMJIVQ1awS0q3oKwfO0AmijS81N+g/ZifaZvYMy/HLHZtma9uIsN1sz63iGRJsghO
         FOeTQhwjujHWo6P2hcVX9YOcMzI6OU6iT976abRqC2K5cOr3c6bu/VBJQKGVxxFGAP9n
         y0gQ==
X-Gm-Message-State: AOJu0YwdeL+ZYF8JFxS0CexTKSQ48Y0JYM+WRdLgBS+A3d23E/wRhbMK
	Qo8cnuyKpfIIWHwq/lswjRLtHnJnYQ+jJG1gid1ONOrTA9alEOswIw81uWn+YsBL
X-Gm-Gg: ASbGncsKNoBdotDaX6znL94QbTJTrtaQMpabEQnap+YSPCyIEeQ+tL/bVHt/Dvhek4j
	vYuO4jT+XW4Zn3hnktO/sTY6sjKJQ7BdF4yff7vFEsju80jO2KqSsckAASfGNxBL27xNWJrDf+J
	uWi8jnOx/mroZcXw6b34u5cyWHa2EyClZQM/8QB+V4xNYfwK2cc/tc38hVZ+MzaQOw4pOhVyXD1
	O3jt8kWSUGPECrrYQYYRDbGgnnoN9ALpVlaWO4qEsaB+PswckHyti/MsTmx0WodYOVCkeI+VGxs
	b14kNk0meBB9xMN/+sPoMvnjLlv/nljmselIP3MuuMvD6Q==
X-Google-Smtp-Source: AGHT+IHYSGwrj595uyrUVz1OLJXZxHbNPBsRCrGKjvzD5pynh6EE7RoFLKC+haxUNxI5jHvJnoU5oA==
X-Received: by 2002:a05:6808:3a14:b0:403:3549:6a78 with SMTP id 5614622812f47-4064686b96cmr8818346b6e.33.1748390669725;
        Tue, 27 May 2025 17:04:29 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40663eb147dsm60855b6e.32.2025.05.27.17.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:04:28 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 1/2] btrfs: fix refcount leak in debug assertion
Date: Tue, 27 May 2025 17:04:21 -0700
Message-ID: <15b13535b70ccb306ebafbe1c381415b3dea62a2.1748390110.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748390110.git.loemra.dev@gmail.com>
References: <cover.1748390110.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the delayed_root is not empty we are increasing the number of
references to a delayed_node without decreasing it, causing a leak.
Fix by decrementing the delayed_node reference count.

V2 CHANGES:
- combine warn and if statement

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delayed-inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c7cc24a5dd5e..8c597fa60523 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1377,7 +1377,10 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
 
 void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 {
-	WARN_ON(btrfs_first_delayed_node(fs_info->delayed_root));
+	struct btrfs_delayed_node *node = btrfs_first_delayed_node(fs_info->delayed_root);
+
+	if (WARN_ON(node))
+		refcount_dec(&node->refs);
 }
 
 static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
-- 
2.47.1


