Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771AA4469BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhKEUby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhKEUby (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:54 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7DEC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:13 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id b11so8043569qvm.7
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bpqw75jqbcDSIbk5WrH7KTaX40c8yGb9tmuEntpkosI=;
        b=orPw824znnpYNFVu+oKKyqJfUePKLf+Wsrr0UJ8OV+vDRv1daUSu76Jhu67hFTJTkZ
         nRRfMn4YQh+0QbxBFdZVTVckv7XlNE8AIUL6oCegBJEeKVyYFIK4PRrWw8KbRCUcod0Q
         RwC/HJjgllPzZNqu05yDZ+0iVuHyjdCLXOMZxuxu399jGWdIO8/cj2HeQUA3xRHpCFYk
         4r1aZQ2oRDwNRv4rLSU0IOpDhPYkgihyD0Nfg+J3anQu28G35eAc156yKDZg0jn5R6B1
         im5nxpzUDNVyI3dkB6Zup5URwZZkgAqNiIcklGnXL6GacK49i4xo3h1ZI1jVUGZC5zd0
         vekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpqw75jqbcDSIbk5WrH7KTaX40c8yGb9tmuEntpkosI=;
        b=xZ/CUKYT6nmVJb55ReriqTaGXAGXElNDy7Bceogfty42Yzwm9dN7/vcbK/6GndUXfr
         vaNYTfjo4ehOBqJ22B6WqN23OtT3P4uKzQ0y58W6Vz2XNqP+ufDv9BMw3aTpahC7O/bW
         JgRFtSl2qvHECjjqCsnPZYOoV0nqGUXmSH9Iri9cPSqKwv6yvAPUW5KXGvvDwzwS45r1
         t2Hqf8CF6mefNM1VqvRLRe1W2aS6d6E8NqynI/AtplMKvOPD56/dxSG0RAquZoUHl5yM
         q1xRkPXz/lVnwLk0r7WOoeyzotQtP7x+/Ep/xdR6zBpWRSOj8wdXdCMxLz8nGutu0ffP
         CHLw==
X-Gm-Message-State: AOAM53334AOvacN3sxAHbTjnC2V/OLKelNMIuGbj0NBeOT7D0GuIuKLo
        airMr7lftfSVJ/TOchB+SIQVR6bv+o7+8Q==
X-Google-Smtp-Source: ABdhPJxnGnAPANijqrty1t0OWvpZ1FZX4/R6kEr1VQwid5JPPmYCwQD+Ot5mXtwern347QEMvZo0lg==
X-Received: by 2002:ad4:4f2e:: with SMTP id fc14mr42881800qvb.66.1636144152817;
        Fri, 05 Nov 2021 13:29:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z5sm6532973qtw.71.2021.11.05.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/20] btrfs-progs: check: check the global roots for uptodate root nodes
Date:   Fri,  5 Nov 2021 16:28:42 -0400
Message-Id: <f1261c2f957416e6996a1196bc045ac132e842ac.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of checking the csum and extent tree individually, walk through
the global roots and validate them all.  This will work properly if we
have extent tree v1 or extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/check/main.c b/check/main.c
index 140cd427..6795e675 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10379,6 +10379,23 @@ out:
 	return ret;
 }
 
+static int check_global_roots_uptodate(void)
+{
+	struct btrfs_root *root;
+	struct rb_node *n;
+
+	for (n = rb_first(&gfs_info->global_roots_tree); n; n = rb_next(n)) {
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (!extent_buffer_uptodate(root->node)) {
+			error("chritical: global root [%llu %llu] not uptodate, unable to check the file system",
+			      root->root_key.objectid, root->root_key.offset);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 static const char * const cmd_check_usage[] = {
 	"btrfs check [options] <device>",
 	"Check structural integrity of a filesystem (unmounted).",
@@ -10771,18 +10788,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		if (ret)
 			goto close_out;
 	}
-	root = btrfs_extent_root(gfs_info, 0);
-	if (!extent_buffer_uptodate(root->node)) {
-		error("critical: extent_root, unable to check the filesystem");
-		ret = -EIO;
-		err |= !!ret;
-		goto close_out;
-	}
 
-	root = btrfs_csum_root(gfs_info, 0);
-	if (!extent_buffer_uptodate(root->node)) {
-		error("critical: csum_root, unable to check the filesystem");
-		ret = -EIO;
+	ret = check_global_roots_uptodate();
+	if (ret) {
 		err |= !!ret;
 		goto close_out;
 	}
-- 
2.26.3

