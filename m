Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C02CC71D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbgLBTxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389676AbgLBTxD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:03 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7851C08E862
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:11 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z188so2458567qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YLT30jDDPjAI9bRwtfTiSJ+iMHBOrJFaI2d0TTwoY0c=;
        b=zfj1rWnfKvYiiVDZ3U3D85irQ/R0iNQvgHYf1zv+K66nQNrz2VobeWohWqEqwz2M2e
         e3eJV1QIUdw8j6TyGPpT6FoJICaHkmWIVQRG0uG23zdzg3U5KEP6LkrUOyIsNyz91Xab
         isRxrM4zuDH1nRIQO+HrSpoDYUf8QtPMhs9IeVD6GONd5XG76JqFDw8dOxSmQO18vDrU
         yNzq78kMJCzCyuRqVMvg/dfNbiB7C4D/UeLk0yvdCIxobJWJvymBwUsrdlMKWfVaH7lQ
         dWEeANiu8oincLEYQZ95SkIG9m7xUP5ZH4kUtBQTaLGOgY4Y3qhm0D8WNAikZW4qPoGn
         rcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLT30jDDPjAI9bRwtfTiSJ+iMHBOrJFaI2d0TTwoY0c=;
        b=i1BTBIctky5TYiXI28YZNrTaIr73v8yIaqE7jKNkk2n02g5RUw/QfWQUpcyLR3P8KQ
         GS1MzpPrnlJqSButR2fquK1lJi8F1NoGLviUIOfQE4JBbNnxBesh3clgRj0GE8K6Z8em
         o0KuisbpCeSMSYwugmEp7O9KLypB8ZvN2J/PZOGV1Vh+u35ifr4FnjhWI+DN+jm94eAx
         ZHYRizwybZFODTH4nUF+9UmUeURReL7QeUQ4jXgL6hR8KV6GkKDgJ7aPuwpZICGbr/5A
         EY6Jp1Wvpzv6acZIr72oTeoXzfVuuP/mxFJ5DH6HdoaBcNEt9soTsW4gf6lKHr8PmMB9
         3YsQ==
X-Gm-Message-State: AOAM530a8WW6oJX+AsQo05d3KyeTBBbl95xP6JCtTHyXIgQHKMwYUKRN
        VOL367d5B4lpDCVkTWWk1XbsR/91wDRT7Q==
X-Google-Smtp-Source: ABdhPJzHGze7qffb7A8pf3MGfLidKjwW2EWAKoFJcTH8GgKcsY3x+pAauFSQQoXEYIFeh9mVPn0mdA==
X-Received: by 2002:ae9:edcb:: with SMTP id c194mr4264874qkg.46.1606938730552;
        Wed, 02 Dec 2020 11:52:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 189sm2906402qkn.125.2020.12.02.11.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 31/54] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Wed,  2 Dec 2020 14:50:49 -0500
Message-Id: <55ff15d8ef98e0eab03044fc75e44d6cb2bc64b5.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in commit_fs_roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5393c0c4926c..5064beff3f9f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1344,7 +1344,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			err = btrfs_update_reloc_root(trans, root);
+			if (err)
+				return err;
 
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
-- 
2.26.2

