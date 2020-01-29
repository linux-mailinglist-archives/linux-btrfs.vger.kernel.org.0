Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79F614D403
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgA2Xum (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43172 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgA2Xul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so990055qtj.10
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JIzbNs87a9nC3Q/cOAGcqGsGmsfQsumqS/N8eqiJ88M=;
        b=y5EOjwDDLf7pAyc9HopfxdRAzS6KlNaB2Uo6t1afBDbZ8P6d5qfBKg2J6KOMBBUJ82
         Xw1Zv4cgpPg2m1xxmxhWzDFCEjqWIGG4wYx6Vz/V6649IiSWf8vtVZcM15WVLrSlRcev
         WgTPdS0YMRYAZRvNVcSfP2P/H/U+rWsnk0qnno7rpKOOiYkzjb5VotjuTz/qKvRz5/EK
         BMWM3Q4KT6E3jrTwkFEfBuaLFwQAUCMv+gMz/ioalpDIETJ9bRCb7kmZcRSG5EXpql4u
         KSqEPnvm/2KQDXGxpyeqvj/QSGmN3JsBZI0aLxjg4KH/PbJ0GL5dJVynSLGXjsO4le2X
         OEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIzbNs87a9nC3Q/cOAGcqGsGmsfQsumqS/N8eqiJ88M=;
        b=faU1r0ET7mDomax5D8+YLZZFMZsN8t46mPlOVIMhXwgIC8vaaj2g9IFb825m5uuglF
         wxwR9M4+I4sSN3w57EKszg9v3l2KKNoWXjB9iU4sFP8MLYBe2NCd39CVFPDMwcxbTOPv
         quRDrxq2XTMHjMr4NxEw2Ay6kzGs1HBBoPHd7bJCRtIqxBwVj7nb/07wqFD3GX85l6to
         RsgsPWadbmNkAs4CRdeh8ddtURARtWT51ash0rrvIjNr8YENzwPq2NDPuhn3pV0I25gU
         V5aRAzLq7cPTflq3krB7FkVCjBmnTPWajN0MSsr8NpqkBKfQdL6salZrmi9Bt7mAANGQ
         ne0g==
X-Gm-Message-State: APjAAAWjCPK6bxjEmXs1w1rUi6EWQ0nj5NQdKVenBgyNO9J+LiBdMGKI
        MiakcJTe0kzKvtcH+rCkhahqdMNERAtbLQ==
X-Google-Smtp-Source: APXvYqzLgVMNTBARIdFXPnGuvuDEbjwQyGMlcdsp3qF5If7iBiTCNuvxtShUd38WZrwulUFhe8SBMA==
X-Received: by 2002:ac8:4244:: with SMTP id r4mr1968866qtm.169.1580341839541;
        Wed, 29 Jan 2020 15:50:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s22sm1883748qke.19.2020.01.29.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/20] btrfs: call btrfs_try_granting_tickets when unpinning anything
Date:   Wed, 29 Jan 2020 18:50:11 -0500
Message-Id: <20200129235024.24774-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When unpinning we were only calling btrfs_try_granting_tickets() if
global_rsv->space_info == space_info, which is problematic because we
use ticketing for SYSTEM chunks, and want to use it for DATA as well.
Fix this by moving this call outside of that if statement.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0783341ef2e7..dfa810854850 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2885,11 +2885,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				len -= to_add;
 			}
 			spin_unlock(&global_rsv->lock);
-			/* Add to any tickets we may have */
-			if (len)
-				btrfs_try_granting_tickets(fs_info,
-							   space_info);
 		}
+		/* Add to any tickets we may have */
+		if (!readonly && return_free_space && len)
+			btrfs_try_granting_tickets(fs_info, space_info);
 		spin_unlock(&space_info->lock);
 	}
 
-- 
2.24.1

