Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4B58BDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfF0UkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 16:40:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37682 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfF0Uj7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 16:39:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so3995770qtk.4;
        Thu, 27 Jun 2019 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMywy7ALEe2t0mNJ1TRlsbiFePyakRxLczRqN/PYLqo=;
        b=R0VDCHQe0+ZVtPpHXez9PeF4IKo1fN/BqfuQtE78nnlRkmudxsQrwwOWjfkHoL5sKY
         N0Ur2BTQ62Cs6+R/42uHdn0Pso0IGX3tHyknB/AXOI69hG7Dia8Zt6MDTUsuAefjmMua
         Amli6efEBxs/T/55RsLg9AfCjqq/ZxPXniVAYKgayjMnyJWIPmEPOqwVIn/F0vmIt12g
         ItguiZP9RbnGqEPMz7RF7EpZ1xZh69kPWN3TBaaQTg+oclUpMByWLcny5yyFLHYakIRo
         /sz5Yggzahgf2fmL6TWYauIEGFlgYFtrTFbuRyUQZ2J5l9pb22W62vF4K1JIPvhGCC8N
         dV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AMywy7ALEe2t0mNJ1TRlsbiFePyakRxLczRqN/PYLqo=;
        b=Yv55e6iB+CMpiWQ4ku/2bCtuZhBT4z3fllqbDfTRJCvNxRT9h6Qi6Qbf/rYnXt3cu0
         SLwU9fYMCgOJMM//z5w1bgZrD/GZzjmbA5bncowuyqtpr1td8AX411L3R63LVHFVOaEy
         qQlrvdCbWKFIxHMIf3XHdUANnLRGVZKVzw+ynBgmQ2fVFQ4gq5tDWKBIPEXNxJ19rxkL
         r3UDfWzunG7JdagFxvl+7oiNrzZehGTouWPgx/UzPumMNrOKkh/mYd4+AOtU/sRbsqkp
         1HWXLgixibQSrx9aLogIgSlFhML0tK4xuEV5ePjpAjLR6NilocgFRSqyQCFson5voFSJ
         Ow1g==
X-Gm-Message-State: APjAAAVuFrYJVCDtMhFK+GLvwtqrBFNdon8eKgANelfXL77iqH3onePf
        NrMshqCzB52rgI//dUApy0c=
X-Google-Smtp-Source: APXvYqweuAgf29mRrCJ2Yfz4Yw3CYiuLfScCA+pqmcAtQjba1z/7eF/+dYrC95C0D1Syo5Ho5LZfgA==
X-Received: by 2002:a0c:af18:: with SMTP id i24mr4742816qvc.115.1561667998558;
        Thu, 27 Jun 2019 13:39:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5a51])
        by smtp.gmail.com with ESMTPSA id k55sm101322qtf.68.2019.06.27.13.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 13:39:58 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     jack@suse.cz, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] cgroup, blkcg: Prepare some symbols for module and !CONFIG_CGROUP usages
Date:   Thu, 27 Jun 2019 13:39:48 -0700
Message-Id: <20190627203952.386785-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627203952.386785-1-tj@kernel.org>
References: <20190627203952.386785-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs is going to use css_put() and wbc helpers to improve cgroup
writeback support.  Add dummy css_get() definition and export wbc
helpers to prepare for module and !CONFIG_CGROUP builds.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-cgroup.c     | 1 +
 fs/fs-writeback.c      | 3 +++
 include/linux/cgroup.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 53b7bd4c7000..3319ab4ff262 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -47,6 +47,7 @@ struct blkcg blkcg_root;
 EXPORT_SYMBOL_GPL(blkcg_root);
 
 struct cgroup_subsys_state * const blkcg_root_css = &blkcg_root.css;
+EXPORT_SYMBOL_GPL(blkcg_root_css);
 
 static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 9ebfb1b28430..a8a40bc26c2f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -270,6 +270,7 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
 	if (unlikely(cmpxchg(&inode->i_wb, NULL, wb)))
 		wb_put(wb);
 }
+EXPORT_SYMBOL_GPL(__inode_attach_wb);
 
 /**
  * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it
@@ -582,6 +583,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 	if (unlikely(wb_dying(wbc->wb)))
 		inode_switch_wbs(inode, wbc->wb_id);
 }
+EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
 
 /**
  * wbc_detach_inode - disassociate wbc from inode and perform foreign detection
@@ -701,6 +703,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 	wb_put(wbc->wb);
 	wbc->wb = NULL;
 }
+EXPORT_SYMBOL_GPL(wbc_detach_inode);
 
 /**
  * wbc_account_io - account IO issued during writeback
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c0077adeea83..da9d2afbcf0c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -687,6 +687,7 @@ void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
 struct cgroup_subsys_state;
 struct cgroup;
 
+static inline void css_get(struct cgroup_subsys_state *css) {}
 static inline void css_put(struct cgroup_subsys_state *css) {}
 static inline int cgroup_attach_task_all(struct task_struct *from,
 					 struct task_struct *t) { return 0; }
-- 
2.17.1

