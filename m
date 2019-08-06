Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F900836CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbfHFQ3I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:29:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38898 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387980AbfHFQ3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:29:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so85123173qtl.5
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bq4o8xp+1U6CdxlYT4fl0p8dn/HPG5NlDVcGVSly8uk=;
        b=ocdNhqfniONPFAYjQpH8vAo1hJoVWQAQ9TIJIgBrb/aOz5SHFSEhipmAHOnjYqBPIg
         4FyHK0TaOIguKGQw31PPtnFVDXiYVHO8L96PjcEth/nuBbOlcxi6r4EWvR64UQ2yvvFe
         H1URSyKpj9CEDb+/gnijRJ1RKXUM40cjY62yYmPiCMU/luntwcxVPbk1Q+tvbr6L2A57
         tf4YVDskrN6GincGikdsYCD1eNNZhi/ggJpecyipxCPtOHMeGjaOLD8PJQqtQOIg7Jgt
         JPvw5jBeh02w1eOQ3HIKCBxLe2ma2e8vcdZzXDU1LAEGtjbSzJIY3GQ5r501zdvVDuBr
         vZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bq4o8xp+1U6CdxlYT4fl0p8dn/HPG5NlDVcGVSly8uk=;
        b=Cj91OhlzkV3mgT4OT0KoIKNp6u7TJN3BB6gP9v8y1hTRJiU0Dt1iH7R5fkmr8W8Wfb
         0rsxKRfhtaSbkkaBoJ2oQajVwUAxkRBZ2MJphS4XA6PDuVp6j/LD7Mw/sCL/3nVJfmFl
         VAueqL91oFBvC9So0krFnTHlat8AVgw+OEwsctEtmlyX9PoC2wlxCmkPUeQqUOrCbFKe
         hnqi0NVwkzsykN0KzGUiwwNxrPVEsk8fHb1+V3ETsldVQmPwPhWHnye/b+MLPAl06rWF
         OFwn54DdmOSDh2CJalRIMT8j+L2WDph9DZKxc+6KVkYKXjbYIwvDSaF9F/PVDucfk5El
         0y3g==
X-Gm-Message-State: APjAAAWvNsjz/PJYEX7ipq8gAMEj2jTfPkMFE5vKAsl7QbXgf6agN5is
        EI4Jk7nR/XCWVZUzoE5wAfQEU8AWVwZriQ==
X-Google-Smtp-Source: APXvYqy21zH9RcHFaLxg5snWCvLEtFFWjVcey68j3qxffBVsEn6Udh3TCAxNG/6MSu0A1tNtMNXTgQ==
X-Received: by 2002:ac8:738e:: with SMTP id t14mr3840433qtp.386.1565108946779;
        Tue, 06 Aug 2019 09:29:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d25sm362883qtm.82.2019.08.06.09.29.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:29:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 15/15] btrfs: remove comment and leftover cruft
Date:   Tue,  6 Aug 2019 12:28:37 -0400
Message-Id: <20190806162837.15840-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit "btrfs: convert snapshot/nocow exlcusion to drw lock" removed
this code, but didn't remove the comment or the definitions, do that
now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 3 ---
 fs/btrfs/extent-tree.c | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 00c52b4a4dc6..a247237b8804 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2570,9 +2570,6 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 int btrfs_delayed_refs_qgroup_accounting(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info);
-int btrfs_start_write_no_snapshotting(struct btrfs_root *root);
-void btrfs_end_write_no_snapshotting(struct btrfs_root *root);
-void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
 
 /* ctree.c */
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f483345715b1..b6bdbaaaaffd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5849,12 +5849,3 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		return bg_ret;
 	return dev_ret;
 }
-
-/*
- * btrfs_{start,end}_write_no_snapshotting() are similar to
- * mnt_{want,drop}_write(), they are used to prevent some tasks from writing
- * data into the page cache through nocow before the subvolume is snapshoted,
- * but flush the data into disk after the snapshot creation, or to prevent
- * operations while snapshotting is ongoing and that cause the snapshot to be
- * inconsistent (writes followed by expanding truncates for example).
- */
-- 
2.21.0

