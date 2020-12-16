Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47D02DC42D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLPQ2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLPQ2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:33 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B3CC0611BB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:26 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 186so23039602qkj.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X57lIxzhlDydEpNT+8ap17OnJ/IJCL7guXADYlfNQw=;
        b=zO9fERGbDJUobwzC0D86WqLKU2xmltJdBbNElEPp07OT41AQzOHDteIAIL/nYhWEqS
         1GCL0DpD9wP6BgGwag+amwicbQINZTbUzs2thbTz3kkjSXCOsroxHzzgKNWdK4f8ExRC
         igQN3Na4Pkhn4cBDsLciZfY5Y2j3Xkv5cTA8jd6Do6pNKOgC5I6hzmNH+pO3Gjeoabpe
         AWVsHxW/m7zWhY09N+Vv3SJ6gcTeWQyBFVZpwq12JuEv/c2kIzD35GDBdTlI4CkmGUC+
         4C/Q2MRywndczZgmKSKkNDN9758YnQeLZ7Rz1iNs+MRptWBX8BgzNDglJm7unMvM/kJT
         C4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X57lIxzhlDydEpNT+8ap17OnJ/IJCL7guXADYlfNQw=;
        b=KYQWCKGy68GfXk9K+jmEYuyyj93cLK+42ViREym3AOCm3K7zqMhEVYGwLUJztTy51b
         IMG1fwiw7WYMjblNoGIwVZ6NvoL96Ao8zIkINA4lQdn61lrPiCXV4O6DDj5gCZ99S3+c
         LHVMNfl/UyuDivwosK5YUlox3Pji3xm7RsIfzGgG51WmIgKUFz3Tsi1jkdBbZIYHYD2R
         +nwhPkE2K0xoMs0Ovm8pjYNJStBHc2VjdnIH3QUXWj9txPJwOujPMSW8734cy3RTI1gb
         4J2TCj7HJ6fB9dMu2BZKYi2yZ3MiTZRK9YpCjZ6nrT+s+cgJr9RjD0TZ0jLLvDVwBpxA
         SqWw==
X-Gm-Message-State: AOAM530MTsKYNd9r0u/cWYgSczJcQdPShtwQTya6e1xVKxhI/TOtBGys
        jaC7yIk1Po3d4yggYIpqZPvupJr/++9x4vLL
X-Google-Smtp-Source: ABdhPJxR36BerU97zWgccfXSOVCUF5EJeCf0nY9yAeChQG5lSkHLZ7rdVM3DbAs9VqsyWDLFM7ztdg==
X-Received: by 2002:a05:620a:673:: with SMTP id a19mr28434937qkh.353.1608136045780;
        Wed, 16 Dec 2020 08:27:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b4sm1192989qtb.33.2020.12.16.08.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 17/38] btrfs: do not panic in __add_reloc_root
Date:   Wed, 16 Dec 2020 11:26:33 -0500
Message-Id: <576c883b5f869a3d3915691b4d1c00299119739a.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index 7e3305aca6ac..410e779af1ed 100644
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

