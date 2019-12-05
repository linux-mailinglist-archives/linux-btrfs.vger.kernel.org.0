Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AAA113AD1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfLEE3l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32810 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id 21so1929235ljr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkE9f8o4C1OrIuAl7+lxsirTVlWroGkSzZA9s/nYbMg=;
        b=YTAGnmFPYDtPZnweQr9+bhbv4ZT13TK6QuJqsMWNaxaUlasJZilaxZiRFUjngeza9/
         7HloN3u7Oq3jou4coAfCsrwQuK5HelzYi+I128/ndU/gmAEGplzc+x1dZvqEWBkQ2mFb
         jN323d3p7MPCdeMTb4mJSX9vVo6R9I0vHOB56BerC9EFUGbxQkoGtcWguETUMzW3zvm+
         9ZDuAZ0vLOqMitDV5krl5qYNGRvuvkaX/wCDJX5TT6YxoAVFXQRyItEf+gOnUlMzuMlr
         RtMj5u+YCa97m19JpyCYDekgHdbIov71UqzmWTuUPksWYfjCPg9SWmNWAG7GJpajsycI
         To6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkE9f8o4C1OrIuAl7+lxsirTVlWroGkSzZA9s/nYbMg=;
        b=flrjbywcwOBhRtoxitsgssTauflVi4K23aufz7LypB7gf7N/rCrd5r0n8wN6ZFjasd
         TAMOsw0dxseGb/UHRzjLNSoC1e3m9Cy2ixsqjzjohuJJ/qWb1yx0JEyM2jiIqUsQpXl+
         gitvLaYPhhR96ce2tebpJHQG4RXbyxungnw21ikkBwohEqZhUsqcqggv89KQhBWAAJUL
         ZsJdxugY9ntB3KLqLYEXZ6B8Wv6GoCebU2S2iWnjpBgJespCLi/WWUoMem5Rix5J9XhP
         vjkMastpSzb0UOMOSXU3VbZpCaSgtlFFkLG2eoJz0XBAxCqZpAzX8nyx1M0vrZPz2Y6z
         yRvg==
X-Gm-Message-State: APjAAAWm/LNdzcaNYfHMZHiy70lOMQ/wd6bmqzNnP4sKsC9NJ7NyG47E
        dvbuc6abloEhrL7bwPfntX4hB/UGZ9Q=
X-Google-Smtp-Source: APXvYqyDjioQcKAoQ1fVHuN9PeJ5CaXRqir7J+IwKhfIeUURPi/QUdc/pCk4iDcqPdPMgd3RcVRsYA==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr4158873ljj.23.1575520179197;
        Wed, 04 Dec 2019 20:29:39 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:38 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 04/10] btrfs-progs: reform the function block_group_cache_tree_search()
Date:   Thu,  5 Dec 2019 12:29:15 +0800
Message-Id: <20191205042921.25316-5-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Add the new value 2 of @contains in block_group_cache_tree_search().
The new values means the function will return the block group that
contains bytenr, otherwise return the next one that starts after
@bytenr. Will be used in later commit.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index ab576f8732a2..1d8535049eaf 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -196,13 +196,16 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 }
 
 /*
- * This will return the block group at or after bytenr if contains is 0, else
- * it will return the block group that contains the bytenr
+ * @contains:
+ *   if 0, return the block group at or after bytenr if contains is 0.
+ *   if 1, return the block group that contains the bytenr.
+ *   if 2, return the block group that contains bytenr, otherwise return the
+ *     next one that starts after @bytenr.
  */
 static struct btrfs_block_group_cache *block_group_cache_tree_search(
 		struct btrfs_fs_info *info, u64 bytenr, int contains)
 {
-	struct btrfs_block_group_cache *cache, *ret = NULL;
+	struct btrfs_block_group_cache *cache, *ret = NULL, *tmp = NULL;
 	struct rb_node *n;
 	u64 end, start;
 
@@ -215,8 +218,8 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 		start = cache->key.objectid;
 
 		if (bytenr < start) {
-			if (!contains && (!ret || start < ret->key.objectid))
-				ret = cache;
+			if (!tmp || start < tmp->key.objectid)
+				tmp = cache;
 			n = n->rb_left;
 		} else if (bytenr > start) {
 			if (contains && bytenr <= end) {
@@ -229,6 +232,13 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 			break;
 		}
 	}
+
+	/*
+	 * If ret is NULL, means not found any block group cotanins @bytenr.
+	 * So just except the case that cotanins equals 1.
+	 */
+	if (!ret && contains != 1)
+		ret = tmp;
 	return ret;
 }
 
-- 
2.21.0 (Apple Git-122)

