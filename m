Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1E2D2F80
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgLHQZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgLHQZq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:46 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD399C0619D5
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:02 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id u21so12273494qtw.11
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yH1zhl8oIh4YApB9HRlV1LmZwfiJDb6Ea6cl0tkUsaU=;
        b=YSo/93yGGQNYDYE2Dm0L+KLu+85My0sEOBsIqKcdG/DQXkBbrUjyy6nQIWjBd31Sri
         5A6X5mt6RBqjjrhEqKfTYx3l7Y4lPHWINDFXYNvfRtPS5i2srz6OJ/yuqIvqbr4nb1Vu
         nBRCE+o9rQkONzJEChMiCOmPFpyHxTu/SMeOs5j7iKGmI6+sg4JQAXEdEJmaJ3jtPIXh
         LA7oN7QF4T8lhU+Ni+YuT3BJBKk7awQTIb5UGkniFK93hjCQS2EEyKvjaESq924eCMn+
         WpZRe30ok2xN0jI4ljRpKnI9Fn9ujVTHV1+OEiAIqaj10Ons0D5vwQKagD1npfbR7t9G
         aaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yH1zhl8oIh4YApB9HRlV1LmZwfiJDb6Ea6cl0tkUsaU=;
        b=GYsHz/i5Ic6wCmSU91ATHI2oyTZ6AK5ZkyJpBa9mYNYCFmoyrk34F42kaUp+ALWYrG
         9ZfKxNU+uYgKawgLCnTt8ZEIJiunvw/2bwC7ebT+p1EKW0v4i3g1Eia1b4vqsPNcr8Lp
         fvbSg6/Ir+hmjnNjPYMfakBKXRSEVjMYR2AVVupU/nT6FG1BKMKkxoYhuQl8juK6ubSL
         XiEx+Q+J3eHF4n7Ak45spEc38s7DOcGprqvi9Y/XpW/Iky55OnTHF5TJUT3aWY7PeOUs
         j8dNGX4HbmnlkweFW7lpSTlQ9N1XMH0LrIq7HSBA7kjaelHZpsNbDsko5jTp1IFuy0FS
         TUXA==
X-Gm-Message-State: AOAM532QkuS7KXMD4+jo3k3NuWJo6Kb9VFs0Bm72ToJeBDgi4creicwr
        gnAMRDd7dgGWsFGMy7+IwZcb4MVa9vLq9kpM
X-Google-Smtp-Source: ABdhPJzUR+RS7eoqYir103kQ5Gqw+fYVpivoNY4s3GJo4RSU0L2br0nJqz2XtkndLtd1KT0bI1mUGg==
X-Received: by 2002:ac8:7754:: with SMTP id g20mr11854231qtu.27.1607444701648;
        Tue, 08 Dec 2020 08:25:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v204sm14946999qka.4.2020.12.08.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 27/52] btrfs: do not panic in __add_reloc_root
Date:   Tue,  8 Dec 2020 11:23:34 -0500
Message-Id: <b71ee33aae12524bd3a29e863b22523fdbce31b6.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have a duplicate entry for a reloc root then we could have fs
corruption that resulted in a double allocation.  This shouldn't happen
generally so leave an ASSERT() for this case, but return an error
instead of panicing in the normal user case.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a0453d67749a..36323cd08bc8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -638,9 +638,11 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 				   node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
-		btrfs_panic(fs_info, -EEXIST,
+		ASSERT(0);
+		btrfs_err(fs_info,
 			    "Duplicate root found for start=%llu while inserting into relocation tree",
 			    node->bytenr);
+		return -EEXIST;
 	}
 
 	list_add_tail(&root->root_list, &rc->reloc_roots);
-- 
2.26.2

