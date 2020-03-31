Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4AB19A01E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 22:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbgCaUrU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 16:47:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55493 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbgCaUrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id r16so4076344wmg.5;
        Tue, 31 Mar 2020 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3+lEy9Ryrh8ACNbjDPXJdFtX4Fu6xIuZ4HubjkFKpo=;
        b=KQyyLjlz62hMvM9CIRENXWHI+4qBvlyloYBG9pix8nl7FO9SFhpFfXI9gduV0S4gHU
         YMywHck7wDMBVK9zkQlEWjqzKnVLxXT2fai2IyaF225SH69eecpJ62kS0rDrwXEBRL5o
         +YYmpUS4nq9mGu6ZmNSj8V0YY0T+f8uOBJ8Tqll5GW3Rm3SQ/kLjEs4eFoejUGu2dOYx
         PBmQgQzmXk3Bp6BuvBkOHbcnVHVQKSXi1BQtsT/xuC5dBif3EG/HocaV1s4q6flEWwty
         tSjCEWYQXKeuXHXvZ6mjG/UtowwxhR7ctFLR4So808jHLHyC4VVIbvyNDyf/GjsuS8Gi
         0sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3+lEy9Ryrh8ACNbjDPXJdFtX4Fu6xIuZ4HubjkFKpo=;
        b=YBLoQbGxSp4E2/xbRc8oAQsMI84l+EZFrdQNfH/gxqYWRm/MhQGP+2mfYWLgA/MhUg
         81CcgSMD502IH4owx5kuwRwGQbcTtIlrMktB2uyfGcOeDLHE5MnNQ8vSuMmMgem8xGzR
         DqLbX20aJWlbtt5m0r8gozM+7QIQx3urGKC0U/g7j909BT/9sE1ONVXcIsIwgmzxk68Z
         VY0LVTipKPNAyYY4ATsHX5yNfZF/mSjyIVf0Q18tJg8IkHOardVEvLarhrz61wxWZ0rJ
         W4cIs4lwYQktCM5bxXVHbjSmbyZiqZ1MlG60B8NW9OQSYhGPRX1qVgm1FXwDFm8nWRR/
         S0Ew==
X-Gm-Message-State: AGi0PuaH7IvxpOI8vt59ANlQOTGnnDg5TXZa1JslOW2xNxsCd9HkMWAn
        bJbnTVC0DJ+uuhoQ1JKCYiTz+lJBn6jo
X-Google-Smtp-Source: APiQypIRg1XSLk0a2zJpj5sV9vH0gfBlwuo2jURCt8mVO4PHmNFFQSAcla4ku2bnpKJfSiSGXQzsQg==
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr716466wmm.106.1585687636714;
        Tue, 31 Mar 2020 13:47:16 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:16 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH 6/7] btrfs: Add missing annotation for btrfs_tree_lock()
Date:   Tue, 31 Mar 2020 21:46:42 +0100
Message-Id: <20200331204643.11262-7-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sparse reports a warning at btrfs_tree_lock()

warning: context imbalance in btrfs_tree_lock() - wrong count at exit

The root cause is the missing annotation at btrfs_tree_lock()
Add the missing __acquires(&eb->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/btrfs/locking.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 571c4826c428..850fae45a8a4 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -410,6 +410,7 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
  * The rwlock is held for write upon exit.
  */
 void btrfs_tree_lock(struct extent_buffer *eb)
+	__acquires(&eb->lock)
 {
 	u64 start_ns = 0;
 
-- 
2.24.1

