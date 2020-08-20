Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5624C206
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgHTPTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgHTPSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB9C061344
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so1789101qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9JOsNzvq3JgLRkqqlWr+CTW4iTVEhluf/3FtXBdoz5E=;
        b=Ps7Oxu59G/WSLcCBY9qZl+8UlhKCJRGig1mVUbvIKcQ0cWbymK5upkEFCOlsJi+AaP
         o2g1+005FPxJaJ8tCGJWGG7FENfvirtBtGTHyg2wi+wctuB8OVJqGgEXpDUdQmX1Er1X
         DvfbBJrsOk1Ma1wI/WiLthdH82hheKQi84JpsM6MzjXvCzFAxgWZRIBdIMbNjjvpl6dp
         havsF0CRL85SkYnqwlfOqYKsnqHpLRDq0T4dNcUfJNgrZ9YbGiSwNGb3J/Rcjgki9SDC
         sTI+/74EhVABqz4XNk8LWY661kiDr5OA8t77M6iiWeLBtKZU8jL67Af68OPe2E6wlmi0
         OkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JOsNzvq3JgLRkqqlWr+CTW4iTVEhluf/3FtXBdoz5E=;
        b=Qb9yCuhaz/y6eFPzt4+Q0qmdbFTDXPURwA7e54UOsN+naWr3ih7ucvFZABmm9VAUjS
         ctrGYqsx/MWOeyi+BRZangQxGY8y6MjPSnrVYpatHGw4cms1q2u6qwPDyAdpeubS2DgB
         7jCHYnfkaoL7FQKOqgA+uy2RszTyLapMVqdrAoUDSTsYvUCw5Cu8/bAdKaLljPZxdyzX
         S7yxwUFPRD60qZWaGA6VyDb2/sFU65fZvGboQ8OJUPpK+rahyZXVfHgxWWG+vhMfHGei
         mYs5zB0LHXiKMAp+T4LLER8O/91s+EvVzMIZuuN68fW+4ekCj/MoLuJhVXvKZ0dVq1BU
         6vFg==
X-Gm-Message-State: AOAM533o934XsBcmMoE9hc7qSTsAl4cWgywUpMEF8aIIxFadU/3B/GnX
        eXrVx13fpr+KQ8DHEvg0svAxzL5J9KDi8+gX
X-Google-Smtp-Source: ABdhPJz/Z4lcoRpEI2Acpv2Ol+Uq+7S+5/Hl58Q3mlHbQOVaOHsadHYKzxBAr7L+Fx+b5fqxuQOsnQ==
X-Received: by 2002:a37:b502:: with SMTP id e2mr3171260qkf.144.1597936730022;
        Thu, 20 Aug 2020 08:18:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w32sm3507004qtw.66.2020.08.20.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: set the lockdep class for log tree extent buffers
Date:   Thu, 20 Aug 2020 11:18:31 -0400
Message-Id: <968c98eabd41974b5df245fb20234a49491df037.1597936173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597936173.git.josef@toxicpanda.com>
References: <cover.1597936173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are special extent buffers that get rewound in order to lookup
the state of the tree at a specific point in time.  As such they do not
go through the normal initialization paths that set their lockdep class,
so handle them appropriately when they are created and before they are
locked.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 09a0dc690a17..e0fd8a34efcc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1297,6 +1297,8 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	btrfs_tree_read_unlock_blocking(eb);
 	free_extent_buffer(eb);
 
+	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
+				       eb_rewin, btrfs_header_level(eb_rewin));
 	btrfs_tree_read_lock(eb_rewin);
 	__tree_mod_log_rewind(fs_info, eb_rewin, time_seq, tm);
 	WARN_ON(btrfs_header_nritems(eb_rewin) >
@@ -1370,7 +1372,6 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 
 	if (!eb)
 		return NULL;
-	btrfs_tree_read_lock(eb);
 	if (old_root) {
 		btrfs_set_header_bytenr(eb, eb->start);
 		btrfs_set_header_backref_rev(eb, BTRFS_MIXED_BACKREF_REV);
@@ -1378,6 +1379,9 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 		btrfs_set_header_level(eb, old_root->level);
 		btrfs_set_header_generation(eb, old_generation);
 	}
+	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb), eb,
+				       btrfs_header_level(eb));
+	btrfs_tree_read_lock(eb);
 	if (tm)
 		__tree_mod_log_rewind(fs_info, eb, time_seq, tm);
 	else
-- 
2.24.1

