Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAE2DC443
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgLPQ3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgLPQ27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:59 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1CDC0619D6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:33 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c14so17619756qtn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2szEeDBy6YIpoBNDjP9rMSOrwKTMScKSxDHHb/Sb9H4=;
        b=ZcX83MAsRwZ+wLgPOeFDwcqrbWWK8M44EzD8U6dUYzj/PmVYwULE3kgVmcH7OUoWKW
         seIun/0PQttpd24QJhbKitUtavEZoj1S/LZYvcw/ylIjBbwZ3G2BtyAk06KpGM9+4poy
         iajOnh8A1ZfmR69ocuSZ+zM9aXSy9NHMiu3ELE1g0CEoj1PtF1AZgUzmi9EDTaqiShc+
         gZyLbjkrpsQhhubLsQsCyRUwDVntYuJVaucGoa8aus6A3+IdZpZ+Ekj127MgXZOzHUay
         s32AqIWMmoJIq3W5GVClFU38ZMcaKl+8Nz26fgq8t5plw9z+OTdrP7Jds/09ocgksdrj
         bsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2szEeDBy6YIpoBNDjP9rMSOrwKTMScKSxDHHb/Sb9H4=;
        b=A7bcoU2brg7fym9cnQHC0pjYOqfhJTFlnYzBpuE2Ys0r0wvFiam99lCUqslm0EUd9L
         iBufCUthHnFRGVa4RDrIldasTfsUomBVRp2S2OBPvPaEuw8D36dDuaWbGToHm+AkrGKj
         6NF+f/6kSi8x/8vdU01trhFNW9k7wZtbIDfgmR3xuCvQzV5duJ6lywT1K62X65l8i28u
         VsFe3S2wrfbjkHwoGs+1l8JWrlnvIF8625MCwlA0qGu6JLiZXlMOiqDs5SEq+TRexNcs
         qu8bMhVISJvhSILbgTXoL3SiB4rZIqRTY5IsE7JuhC6OGsrlc6K2WE/qts4nCbXbgM8u
         2ffQ==
X-Gm-Message-State: AOAM5314eig84Xz/8PGFUhcTsQysjPkdvDDhhIlEIb99wsYjIUaAFhBB
        nssCoyjWrfq2aiBkqBBUgNdU8TJJiJ6j8N+/
X-Google-Smtp-Source: ABdhPJygHcL4Iby0mHLRztpENZdd7+yr09BIkii/Qe+o8ZV4JkdSgowHFxm2xjld0zrArRrLZFrDkA==
X-Received: by 2002:ac8:4c8c:: with SMTP id j12mr43575152qtv.133.1608136052640;
        Wed, 16 Dec 2020 08:27:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g26sm1366368qkl.60.2020.12.16.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 21/38] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Wed, 16 Dec 2020 11:26:37 -0500
Message-Id: <e431ccc88cfe1b9475f3da4fb38792a15cd86381.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in commit_fs_roots.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0663675354a2..1e1587290955 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1344,7 +1344,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			ret2 = btrfs_update_reloc_root(trans, root);
+			if (ret2)
+				return ret2;
 
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
-- 
2.26.2

