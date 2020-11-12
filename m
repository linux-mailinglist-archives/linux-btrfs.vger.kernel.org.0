Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4A2B1013
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgKLVU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgKLVU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB9C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:26 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so6883209qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W8bi0LsLZ9Op3BC6ygY4VwpzbB9YzP9G+uGYGGAxXJk=;
        b=AXDpXSrkEWBXzVBgpoL718eM/wN4/ZMI4Q/ezBr8e8wbHei6ihVddLwHdwjF+uRtND
         VUu+dCiQtA+JW9hGfRvcL/is2U8dqK8b+PX9/apcyCsaf0sDLNTcQGiHbfc5cF8g5B5Y
         obJis5ctYEOT1srbM2NjgEbG11nuDqmfefGH34OiIUz1zjESUWTHKY37uZeEWKp+r4Tr
         K8/VKc0AaU3QhFDwGPZ/8G2IPSU8JAbi4/sMaCpKB47Gu/e1HB3tcZ6OKuSMRNpBLFhN
         9f9kDiJ+YJo86e5l3FxMvvxqk3VFytuF4p7ImQmt8aKT8ZzUGt9bOYVJti7AtgNxGG13
         merg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8bi0LsLZ9Op3BC6ygY4VwpzbB9YzP9G+uGYGGAxXJk=;
        b=K+muXUrZZ18DL4Kn9cw3MGwVr2rMyd97K+cCxv6mb2GCYNv2ZU3ddw7I6vobk6vjNL
         CfiEwd6jp/SsN2xjjsmZNdKy1QNHs1yIsc2zLHyOYVM8AbAuMvff2rumd2M3k5K3z6md
         5qh1ro0KXvqDmfnsmOPWYRpvmR1D5v+eMoLjoy4JtFJHQ761E9rLBg6G7L02oBzf/c6T
         281xNhtOGhAfjK03EMiqgd/rxvf5tCSGbVVd3s2Gzzom1HV9uRMzYFsZMFYaFVbbl6+d
         XI9UQqtE+xGAhjGsxV1uWI2jHDtISQ99bMCcN5Kx/H6kf/YI8HCrBdIT8LXvpYCI2SK3
         MVnQ==
X-Gm-Message-State: AOAM530f1JeDsSWl1wPJ2OqMB1sOCZJvGsrMoouwDScfUdQKj+Z69/oo
        0fY2pqqJM8YBi/gYd1XQKBPFCEVVMFRgaQ==
X-Google-Smtp-Source: ABdhPJy0qm8QCxEs3frZw6Wqkt22uRqP+m8YFZdtBRKoqs7VpK/T57cjj+WrLYvgkXcIjkKyQqGZlA==
X-Received: by 2002:a05:620a:65c:: with SMTP id a28mr1828439qka.353.1605216025165;
        Thu, 12 Nov 2020 13:20:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e6sm5542971qtb.32.2020.11.12.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 34/42] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Thu, 12 Nov 2020 16:19:01 -0500
Message-Id: <a0322889bc3db12073f73f414d78a92de5100993.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index d8af62d9f98b..df39ad294aa2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1272,6 +1272,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->offset, fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
+			extent_err(leaf, slot,
+			"invalid extent flag, data has full backref set");
+			return -EUCLEAN;
+		}
 	}
 	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
 
-- 
2.26.2

