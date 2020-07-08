Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295F82189B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgGHOAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGHOAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:52 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F620C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:52 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m8so16268770qvk.7
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46HbDWQcKmcttSQB7AW4PupurGGvNNNEWKfXAY7s/Ks=;
        b=O9PhikjIA9JGPu5uRkpf9BDS+laBYRKRiP6mA0KwiQbGy3ylVwUBWoO0HN965dJXKW
         B/u6my+6n7nJt34CoAAZky57OUI4YxxHEmCw5xKckAaLs2icSsVCKlM+e1NEsI/zsehi
         ZeAnV59q5ff1Hb9pTJQsYGrux9PsbnujaUct7lWJliXOMj8z6O0fRR7ZvhYHaCKzjMSg
         fH/6w4Mob0CT4GAqbEzyZJbKANPQVmfBkJI6+Wu8cnpSbEd0PGCnL4xymqT1kRwaSQ9Y
         FFhOQ9r0mz74A4+fQJOJ59mbzjF9Ds83ETFH6W+HSA1yhfXVfyuatluM6aav+hvFpmBo
         fnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46HbDWQcKmcttSQB7AW4PupurGGvNNNEWKfXAY7s/Ks=;
        b=BbvXo5WWPbPGSPY+uJyG6Mc1wS7DbQd8126fLJq6r+a/mDtSoX1lCELhIIG1/DSN96
         8CEnBch65B6FypGBlpm/YqoQMnn9xG1IYADPDW87prq8BiBndrQjNgFaEyihl6WvfORL
         fl8V/Ph1yyANku/o4bB/AcQWogn+8Iqg+Ixo39DTwD2DT6fw4XKZhg7wWx9LPRBhd2mj
         DkkMpeWmJWDtaevamrj51YQ9f5ZSsljkyLnOzl7eMewjG6S4TQUEtMq1LCQKuvd92r+p
         YbU8nBirzNJZ1HOImgJMJqj7Iu0P6s1aF322C/4VFkUt4bZRcvT27sEeTtsbGxE6q+lp
         7oIw==
X-Gm-Message-State: AOAM531o+7nO3bfrAm77908WvcT+hkIcPeR+XuIJ/GaVAWPMliu9qCUj
        +vh3ayLnBc7oVoCoKZgA8/OsaNGZe5aHSQ==
X-Google-Smtp-Source: ABdhPJy0kEXBgaOEydd7n55oLy32XRWPzBfh+Zzu8+90kxb2qMYing3ZfCyXN/BsLXmn9YnaNnWmdA==
X-Received: by 2002:a05:6214:949:: with SMTP id dn9mr54530724qvb.116.1594216851537;
        Wed, 08 Jul 2020 07:00:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z187sm25898526qkb.102.2020.07.08.07.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 16/23] btrfs: serialize data reservations if we are flushing
Date:   Wed,  8 Jul 2020 10:00:06 -0400
Message-Id: <20200708140013.56994-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay reported a problem where generic/371 would fail sometimes with a
slow drive.  The gist of the test is that we fallocate a file in
parallel with a pwrite of a different file.  These two files combined
are smaller than the file system, but sometimes the pwrite would ENOSPC.

A fair bit of investigation uncovered the fact that the fallocate
workload was racing in and grabbing the free space that the pwrite
workload was trying to free up so it could make its own reservation.
After a few loops of this eventually the pwrite workload would error out
with an ENOSPC.

We've had the same problem with metadata as well, and we serialized all
metadata allocations to satisfy this problem.  This wasn't usually a
problem with data because data reservations are more straightforward,
but obviously could still happen.

Fix this by not allowing reservations to occur if there are any pending
tickets waiting to be satisfied on the space info.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a107370d144c..afdc774cebe9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1402,13 +1402,17 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
 	u64 used;
 	int ret = -ENOSPC;
+	bool pending_tickets;
 
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
 	spin_lock(&data_sinfo->lock);
 	used = btrfs_space_info_used(data_sinfo, true);
+	pending_tickets = !list_empty(&data_sinfo->tickets) ||
+		!list_empty(&data_sinfo->priority_tickets);
 
-	if (used + bytes > data_sinfo->total_bytes) {
+	if (pending_tickets ||
+	    used + bytes > data_sinfo->total_bytes) {
 		struct reserve_ticket ticket;
 
 		init_waitqueue_head(&ticket.wait);
-- 
2.24.1

