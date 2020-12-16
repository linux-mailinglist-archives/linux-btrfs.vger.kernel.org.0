Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C082DC428
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgLPQ2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgLPQ2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:20 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C8C0611CA
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:13 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v5so8357791qtv.7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGNUuifwBsvHD2zCYX/FZac+Jy1QnxNpjtDrlcuIIEE=;
        b=ROO13qR7/At/U4xipRVJyHXi1h/LoawKvJ5FCeAow6qiUArgEDuc8A+Kju9t2Sfp/c
         mS92M/GoSLEmvXhGUuXah8Xs0qErrxtFu+rBB+NDC3VEYt1XohT+SxKm2MY0arafH57/
         xOxDPiL9eBy/AKlPvveFu/nlXxmCKWyYnfr70xvloS3uHP+ofmfy85tUrg1kjFL2l+4B
         b1TIm0VNBidf+st4j7rmAIC9eODn0COIOUJxH23o8EMw4FZXlPyyO+mfepmZQmH9G1lj
         okB5X/V5WrhOowD8pSr5kwyAn7xHns95I10jeqb6bdWm+lYmnPypOl4WrFyFzOwbDdOz
         kzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGNUuifwBsvHD2zCYX/FZac+Jy1QnxNpjtDrlcuIIEE=;
        b=mjWgtyvn91Rj9efwkEGlCksHfpgfCUORQYFvGkoolEUbPn/sDpwSSXCb0exldq6kwX
         +xdwcNiZcRRVjy0yNr3oofA2EpkuayE6XIw+VD3KO0USnTUxvtlmuvyDmXZcO90WboQO
         SJA1wbgYjHJEroqthQmTnTCYvxpfQ7etm81FesSQUlxPp3tz+w2BNRHdnjEgEmQ3raGL
         IoJdb4ALvW8QZcrpWAsSccF2aWQ5M9YKpNsvcofrVI1jbwmvDf9U4uHMOI9FGmVPtX3E
         zILwHQ4VMM4CFH5UuttnE6zFOen87U9xEoZ7eOagLhKp2QPeJwjbi7Z3dfpNAXclslwY
         HAPg==
X-Gm-Message-State: AOAM530g98a1ymmieHCuqsOOXA8Ipcyur/xD5HdQLfi9SPgrn60Mqy8o
        DLykIiCzXpasVo7yr/Tt/YCroOQVRL9PuYpf
X-Google-Smtp-Source: ABdhPJwKlveNO5sNK7VtbmPgvWjp8x5bOOo2W31NsmxEPmMk0zWS68LadXBgMqQNamWgPiYkZ/DEgA==
X-Received: by 2002:ac8:6f12:: with SMTP id g18mr43654876qtv.335.1608136032073;
        Wed, 16 Dec 2020 08:27:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v137sm1406257qka.110.2020.12.16.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 09/38] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Wed, 16 Dec 2020 11:26:25 -0500
Message-Id: <9acda92afbbba43a3b0185da96ea3b9c12b1750e.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_delete_subvolume.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bcbae8b460c0..7a8d89e1b73f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4175,7 +4175,11 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		goto out_end_trans;
 	}
 
-	btrfs_record_root_in_trans(trans, dest);
+	ret = btrfs_record_root_in_trans(trans, dest);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-- 
2.26.2

