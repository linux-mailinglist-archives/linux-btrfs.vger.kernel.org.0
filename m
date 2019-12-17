Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA99123091
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfLQPhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:35 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43950 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so2363158qke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yvDui0iKYsyOEKeBTybYCyx7WqxXlZPZ8xZ+K+VP0tk=;
        b=HGUWIh6iK0EcFKU3EQYtqUxJtuXkOkHCY8nCnnKK33XEGww9VbPTZSrlsqmc79FaOC
         U4iBIO8XuDVhSJOkMzNpMRXv2pZHAJyByMqDIkpwc8nUnTJgfxTuLzotNTDp2q1VoN+O
         nUqG9dRpkIV26RcelLnxD8nTZkual4uwXKl6Yw49THu5qWLq7YoeSSVEsLcMU168EDSl
         l08vKBDStUnbx/QWGWTcqwd86GkWaXqhO10zbTtBExnT+3QCdtkB5Kwrn0CBokKHqYCq
         l3iTuP5PUVEKVBpBoqMmMwuCHGjeg+SJlNJBt3jXIpuFjpWfrvsGp01JW8cqgAb5b383
         tyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvDui0iKYsyOEKeBTybYCyx7WqxXlZPZ8xZ+K+VP0tk=;
        b=TOkz6xL8QaPSAphbfqp3lc0ww1KRrkVz+GYtM6GIyFhaj7+oZLwZ3tmfWvwHiROykr
         c2hT6gjQQjCCSxqL/JKfkeYT8qzdFNV7WqTWLw1gm8yPmVT1TfTr1m09hevTGKNC8Ft1
         dby1IFQBQ6a533k4r69d03GDuacAQKbNTh8qNBN0JeTFjcfHkrd1MNLZJrSwIPw9xpRu
         iRjBikIIfpvOW3CSXicwJDfxftl/a+wA5PHFutC+LaTkF1PegTC6O7z3CpZQ6NbpIydP
         fwROpsGJN4whluOm0ublVM3h2aChRYpNWdjiwmIXyythp2LRrAUPaWPJrio0YBNoyFHj
         newQ==
X-Gm-Message-State: APjAAAUvLlNvelsbtY1sDEDKVVx2YxNbrEktuCYmPy46M4gj5l1mSENr
        Sqob98Jyr2B9fGJXz3WRQfO9rKMJAdSTnw==
X-Google-Smtp-Source: APXvYqyZ4ah/BBsI9BHARkn/f7Y5pgONp6xIVSKTvPJfHLdbALHBaBo80ZvoXspdcoFi1WTpyN7ZoA==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr5785362qkk.190.1576597054441;
        Tue, 17 Dec 2019 07:37:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t198sm7189648qke.6.2019.12.17.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 31/45] btrfs: hold a ref for the root in btrfs_find_orphan_roots
Date:   Tue, 17 Dec 2019 10:36:21 -0500
Message-Id: <20191217153635.44733-32-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup roots for every orphan item we have, we need to hold a ref on
the root while we're doing this work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/root-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 9617dcedf521..cac2407cc003 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,6 +257,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
+		if (!err && !btrfs_grab_fs_root(root))
+			err = -ENOENT;
 		if (err && err != -ENOENT) {
 			break;
 		} else if (err == -ENOENT) {
@@ -288,6 +290,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
 		}
+		btrfs_put_fs_root(root);
 	}
 
 	btrfs_free_path(path);
-- 
2.23.0

