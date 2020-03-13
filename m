Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55E1850DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCMVRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:17:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35325 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgCMVRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:17:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id d8so15151928qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nuRiJsp0hGWSv076MkcmRVQ1AsfI5+HaZD08/Cdax2c=;
        b=fzW1MMYgBWwyAVVX7UYfmboW0YXPH2KMHycPoQ5OmhoqvEvxWyttlVzugqd7Xu+VpE
         CGtv5R7xfeEssURv7w7qWfkDWbmVdIlgtrfA6i6eeqz6K+dszWIlXnlfhQyrsefE1Qq6
         rtkYMdeI2ZAgbxq3+t8RazxLmugbnQj0Z95RjSJl6o+0GYUhEJa/0eNqZS8Fx3KsgqbO
         gx5ONH4gS9Tl9Swg4Hggd5c7bU0ZVQxN9QZ9AJXuaiAyWUMkIKeaT6TVlx/I3V1DuVBv
         ePoJvKCG8jSfL5uBaL+vT5m/53FZWZjb8GncP46w4obvi5hwILxbbABgmhucrEKmwn9d
         BnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuRiJsp0hGWSv076MkcmRVQ1AsfI5+HaZD08/Cdax2c=;
        b=f/BsKZjAeQQpEObGSsX/DkSIoZD/k8ZHLI55xc0C3ZGqaOf7QqPDMfZyRO1CWNk74v
         6V/Ic4hXLGLpEOvCk6DuSFBG1TIZXrbTkZw+FfnVmv98sukPrPhGRGIVPZGVKFpnwiJn
         TuA+aFrnbG+HWmmqaTY5A3967Pv6uEG8KMb4LAyB8vUUaoCGLpou7jzlT0iMpMXDzIZ2
         /sWgwEsMGn1y7Ao8RywYtH2Lxvn1DrUW4xqRJfk+mz630hl8V95JGcfVz6LS0Ehf8nvT
         jpXhLm/ekdIDDBC/chbyeotGx+w76fopjQ4wRaEWLtsqDnBXXYFyOmuK4LWY6vmFMm2u
         XSzg==
X-Gm-Message-State: ANhLgQ3mJQdGDWvD2FlbGalD7L1FsK4b0qriRppore1bR8a0nH5pjNeE
        jZsx8dChGiWRPk1pkwq1Opl5OvRKnXRuUQ==
X-Google-Smtp-Source: ADFU+vt6HvmA4/CLwCc70sYhlfOuH9ZYq12SiSI6rjGE0nF2lFYAtXgdUy0O13jOKwDk7ZrEafzMfA==
X-Received: by 2002:a37:8641:: with SMTP id i62mr13302260qkd.290.1584134238853;
        Fri, 13 Mar 2020 14:17:18 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p23sm3541035qkm.39.2020.03.13.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:17:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] btrfs: do not resolve backrefs for roots that are being deleted
Date:   Fri, 13 Mar 2020 17:17:09 -0400
Message-Id: <20200313211709.148967-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211709.148967-1-josef@toxicpanda.com>
References: <20200313211709.148967-1-josef@toxicpanda.com>
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

