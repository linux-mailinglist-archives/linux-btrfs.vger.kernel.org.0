Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C011018D717
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCTSev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 14:34:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45838 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCTSes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 14:34:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id z8so5769620qto.12
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nuRiJsp0hGWSv076MkcmRVQ1AsfI5+HaZD08/Cdax2c=;
        b=BCycgyk+P4dZRj441Ci1Ybo9l7ibUamTq+37gvG1JjmKcH2qKIoYGsqNYglUTJxEYR
         T6Rt8QTG087JR+IJmloiTgiG5pW8dFZWfMaPz1CoiLg0yMNoQ8La1VDTPrW0v2FLuw4g
         xw0UPDKolsJv63qMYirekQRWGGpCGTjIQEPOclQZHxFUldWOeiSjDpyiOzlAi9LwpcBh
         HLKv7QOT0waiYv/8T7QqCjM6PugziY2i7hnCuQg1rI/3zt+eEvHuSztIfVg8PPq+B5bx
         Ohpv+QcR+NS/RLSOrWnI7tEK/kUdkkxvFtOGqf77hdhKPm+3LBlPORmX+iScE203jV06
         iybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuRiJsp0hGWSv076MkcmRVQ1AsfI5+HaZD08/Cdax2c=;
        b=DC2j5gYheiBQrzo9MkPs59O6HlhTM8SpMhBcv/0FHDAbkbCyT93wAbWZYlT92IFRDQ
         mSnoqb7VmJJ7PnDVFD4OBFRF0DHsUPyrzte4xsrSVHn/yMfs436whnNcETPbrJb7fBsO
         XACy7uzYxrPYS4tjJZHNSj2ieZlTQ11J3biM/RMYstGonT6MFvC4ytOGdAv9BM12q5hr
         BEXRuKyyiFg+GRP/E+XPCiut4tPMO2s0w0oG/SCM2LNOU/qTLwv9x9Bzk8hvDajcyjHe
         l7jYEzRd7eBUyGwfyXnsyU6zuXfACDhZPg8S1YJKNeeHhKQA7UPwoZ4tHaB60WN1ywRI
         PRtA==
X-Gm-Message-State: ANhLgQ2bDHVMvKdYwyWfbl7bkJzqLOyfS0EoEoC0PY50mY7LRqTpkXoP
        hY7satxlX7A2bRSRI0sEAQ3WCxvLsiBc8w==
X-Google-Smtp-Source: ADFU+vv1Rj2il0s9N+66oAngigzA1ADENo7ood0Ef1WbpmtUCri94U+ZP6nKWaqx0EyxZ7Q449iWPg==
X-Received: by 2002:ac8:4e2e:: with SMTP id d14mr9978401qtw.179.1584729287454;
        Fri, 20 Mar 2020 11:34:47 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x65sm4693001qkd.65.2020.03.20.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:34:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: do not resolve backrefs for roots that are being deleted
Date:   Fri, 20 Mar 2020 14:34:35 -0400
Message-Id: <20200320183436.16908-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320183436.16908-1-josef@toxicpanda.com>
References: <20200320183436.16908-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo reported a deadlock where a task was stuck in the inode logical
resolve code.  The deadlock looks like this

Task 1
btrfs_ioctl_logical_to_ino
->iterate_inodes_from_logical
 ->iterate_extent_inodes
  ->path->search_commit_root isn't set, so a transaction is started
    ->resolve_indirect_ref for a root that's being deleted
      ->search for our key, attempt to lock a node, DEADLOCK

Task 2
btrfs_drop_snapshot
->walk down to a leaf, lock it, walk up, lock node
 ->end transaction
  ->start transaction
    -> wait_cur_trans

Task 3
btrfs_commit_transaction
->wait_event(cur_trans->write_wait, num_writers == 1) DEADLOCK

We are holding a transaction open in btrfs_ioctl_logical_to_ino while we
try to resolve our references.  btrfs_drop_snapshot() holds onto its
locks while it stops and starts transaction handles, because it assumes
nobody is going to touch the root now.  Commit just does what commit
does, waiting for the writers to finish, blocking any new trans handles
from starting.

Fix this by making the backref code not try to resolve backrefs of roots
that are currently being deleted.  This will keep us from walking into a
snapshot that's currently being deleted.

This problem was harder to hit before because we rarely broke out of the
snapshot delete halfway through, but with my delayed ref throttling code
it happened much more often.  However we've always been able to do this,
so it's not a new problem.

Fixes: 8da6d5815c59 ("Btrfs: added btrfs_find_all_roots()")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9d0f87df2c35..0dcc11644be4 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -523,6 +523,12 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		goto out_free;
 	}
 
+	if (!path->search_commit_root &&
+	    test_bit(BTRFS_ROOT_DELETING, &root->state)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
 	if (btrfs_is_testing(fs_info)) {
 		ret = -ENOENT;
 		goto out;
-- 
2.24.1

