Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01AD471AC
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFOSZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35368 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfFOSZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so6371988qto.2;
        Sat, 15 Jun 2019 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mzP081WUxg14pTor13LXGmwUotvYUmI76qpBJZ7MQmo=;
        b=ZRmkMz0qIw8nZnwRBWYitdL5G7bqJQ5Krrum9cypCGmsBxLiw9wW4X+EEfk5B0peB4
         E7XtmP/Sea0vSXcTMwMq6UT1O1U8MgB/Vn00i2tOaqdDXwzOKVxDsKz84lK8plowZ7sK
         v7jfD2iiXYr87DVUujW+AgDSz2VQWqY7LqPTp6Je4XCdjaKW1vi0G/Ed87L8YTSBEWHB
         +CzfIcVR2/5YsUZoq/GXQnnzDdtkPznwAqlQG8keNevJIGDsrqvwVqvv6rcSdD+QnwsR
         ggUpGQBAdBx3RxTiPNetKRjwhklpOmd5a7lDw4jto6vgGHuUXQOFXloeD/43wWCTpTFf
         gJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mzP081WUxg14pTor13LXGmwUotvYUmI76qpBJZ7MQmo=;
        b=QzzxYU3e1Ef26amDyBd/DURiypHUUkKntTgKll9+6Be1Zqb5vRHE2VQRgSHAfKKFgJ
         yKTb+TowdoamRyN+64UrIi1bx/hYQI+D7EMAS3jcxnm07IoVs2ndfNn7aRas6p9rmshN
         L9JEYoxjYFyJNxlg4yOXySHhw6DepBjMEktok6cgMMPGyAy1HB/ChIk/D4ywZD9F3+3e
         g1Ud8/mn0lfGpHtfJpJrECgMmpBsze+yKMpzxf1Zz4fyNw1EzW/1/jKm9o3szTSwEgwC
         Z1YF09WdJYsdOf86hMDqPQFZkn0K4wGYmKoBEm8Oozd4FBlIczpX4FjlvQXIc8eqS9eS
         8euw==
X-Gm-Message-State: APjAAAXM4fQEyR4EK5/SfbKLsrk8PX5rWEeQvftyEQ8pxptZbxV8h3Fs
        x9cwyajtJohO2XfXjSC9B+k=
X-Google-Smtp-Source: APXvYqyGoPk/K9c8GITJnQX6OVVFL5lE9btPsHaCNEMx1NWVv/ObSNXQtn9+ofrPJcVSolw+/a2SJA==
X-Received: by 2002:a0c:b39e:: with SMTP id t30mr14164013qve.212.1560623103669;
        Sat, 15 Jun 2019 11:25:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id u7sm4694764qta.82.2019.06.15.11.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:25:02 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/9] cgroup, blkcg: Prepare some symbols for module and !CONFIG_CGROUP usages
Date:   Sat, 15 Jun 2019 11:24:45 -0700
Message-Id: <20190615182453.843275-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
References: <20190615182453.843275-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs is going to use css_put() and wbc helpers to improve cgroup
writeback support.  Add dummy css_get() definition and export wbc
helpers to prepare for module and !CONFIG_CGROUP builds.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>
---
 block/blk-cgroup.c     | 1 +
 fs/fs-writeback.c      | 3 +++
 include/linux/cgroup.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 617a2b3f7582..07600d3c9520 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -46,6 +46,7 @@ struct blkcg blkcg_root;
 EXPORT_SYMBOL_GPL(blkcg_root);
 
 struct cgroup_subsys_state * const blkcg_root_css = &blkcg_root.css;
+EXPORT_SYMBOL_GPL(blkcg_root_css);
 
 static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 36855c1f8daf..c29cff345b1f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -269,6 +269,7 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
 	if (unlikely(cmpxchg(&inode->i_wb, NULL, wb)))
 		wb_put(wb);
 }
+EXPORT_SYMBOL_GPL(__inode_attach_wb);
 
 /**
  * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it
@@ -580,6 +581,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 	if (unlikely(wb_dying(wbc->wb)))
 		inode_switch_wbs(inode, wbc->wb_id);
 }
+EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
 
 /**
  * wbc_detach_inode - disassociate wbc from inode and perform foreign detection
@@ -699,6 +701,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 	wb_put(wbc->wb);
 	wbc->wb = NULL;
 }
+EXPORT_SYMBOL_GPL(wbc_detach_inode);
 
 /**
  * wbc_account_io - account IO issued during writeback
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 81f58b4a5418..4cb5d5646986 100644
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

