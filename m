Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8955339861
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhCLU1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhCLU0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:41 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029BAC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:37 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s2so4835414qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8oSBZRXUVWprsp/bA50/MihqamlhtVrIp1ItWvS1fk=;
        b=G7t3/oHaNfTbufVLXFfP1zuSj7cz6nQFVkx/enbdk4YtzDxoibyogeSws8I9e+mQPZ
         dv2GA4fSKjX0/xEVJT10gCmTvmOkhA4IQGoeFkSF3yYdzZ15TybYCQ0BWkMdBG3XnOd+
         SwskFd4wAZCuQIH8ezu31XsXK28vn5361aG/QB0fHJA4/jTJOQv67CTZ6A9VM42B5hEN
         2LKJDvCfIeCWC2I5bp1Oog+lhP4lcZQPX/i93I44oxpsOZJU780vqucV+9nHUJaklnKV
         g9T0i20Ob2gFGL2ChWH+bOZ03KJUhZbfk0Je1utGXv2eGNPBFVYZiZ78/VwyCDRoIskJ
         IMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8oSBZRXUVWprsp/bA50/MihqamlhtVrIp1ItWvS1fk=;
        b=DdZBOUJ4AqjbWwi5ZlPpD8U2eHzDTrNF+GnyO78EdtNM5XhQXWAQfQ6NmW2Qh0ThlS
         C9M2UWirw/ZR0AzWr3Gz/ugXCjL0piCF6Rg01mq8PgFNieEnmumT566I/bPhCaV9Y0pq
         vOyi743CFLPY0vUDLSc64gMqI5PTdd5UwtXBzidk6Z7inRcUvfhMzy7MFvxYj0G0zvjy
         hOqGvn0VsUZ6oO+6Tq2t9cvEICr7yuimR9F0MLr5CVLLx9QHW97PERwttowZ3pbad88A
         zpzk6gvGWLvVOMg6Pv4bhwjMuMci6fH4hvjE4mYX0MTeVTK53CyJ+Z34uZh0QdUcBg7G
         vfrw==
X-Gm-Message-State: AOAM5327IiMrZJbDXJVXTZuhsOEdD1Rz61fHtQDQV68wCpui65Wnd+E6
        148VOqxTDyXwLDCfBd234Xk2nQrpfT8AfQOn
X-Google-Smtp-Source: ABdhPJzPmxnrYW637p0lkPf7PsrMZCeKT0rbj5qpAhDzh8LoJRNQjZb0Rv/KXxO3OxC8M90dkVViqA==
X-Received: by 2002:ac8:4a90:: with SMTP id l16mr13335835qtq.33.1615580796002;
        Fri, 12 Mar 2021 12:26:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 77sm5295344qko.48.2021.03.12.12.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 39/39] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Fri, 12 Mar 2021 15:25:34 -0500
Message-Id: <4598afc28636ae8d935a64cafcd73d82f76196f9.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 557d4f09ce7f..371cd4476daf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1915,7 +1915,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3487,8 +3487,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3647,7 +3646,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.26.2

