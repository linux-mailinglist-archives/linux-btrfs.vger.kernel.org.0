Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E83F5139
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhHWTYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhHWTYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA35C061757
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id ay33so8929437qkb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W++HpZkxxxn1o4o7hCkKWt345ONJhv7pJt9f92Wai+E=;
        b=nB+5dwwwqMYi7x5+jMP3kjVvIxoNn09qkz+iGkOfreGf+S/KaywE420E89W7NiDyBj
         5Px/bYD2CEVOBw66IubJw5XQVPjmhTTns0ENxI2zLJXbMDQTAuHZrt8DZvdpDp0VGrMr
         B0CHG6qxjJecO0E803N336tXrNXKyJMiPrg+qhOLnlW5zVms/gh1QswwnLm85covI/VH
         umhk309yOQCDIU9udnbBMpl6aSCqKsTF0hvLvNZEx+4ZFDvINEOE4uEy7uhZ66RVfWGO
         1mPlFMScOtuROPjhIYOva+De7UkP1ELhVLptswdb3r98P8VMl53cgnvD8vfyS8JkJL/p
         Hyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W++HpZkxxxn1o4o7hCkKWt345ONJhv7pJt9f92Wai+E=;
        b=K6qRvji82txSEDCD1DmyV40osN77ugX3JF2dyuIbnPnkraEKDGymfs7hBxh39kJkBJ
         I7cdJgNnDpsoMhQM00xHCzriPw2AbzIyE7YCmMlhcfrewbAMnp1xuOoOdYE1NYecOukj
         e+1AJKMaA9r9NVGQHmPvDFZ4IpEtG5Lv2/VXZFCobiwW9HuwWRj68Tm39nq68mLCEgrv
         bUVm6BtYxHJkScDF45FDzMYD7FahwAJUZyDpiA1NzCTzXJsqQU9a2+o0VCfYBBOOfS/+
         JvIrYFiEujIzeEMz3FMQ6DuBg5fot5ixs3XpY6Ta99gR/7yiu8/r/nDAE0ex55LYtpNd
         qUNw==
X-Gm-Message-State: AOAM532sb25cQ4NejhwvXErdrgmEgevd171bivMU9rUh4+eCXiEB4q2h
        My0Pu3lSsoSi2wYhr5zuv5GwHa88LvTNtA==
X-Google-Smtp-Source: ABdhPJzz9ZoEVFM7KHAlhaUUHVmgwuH5Hrc1hiDfvYLm5FAsqxIk3utvMVB+Q+YOl3+Bq1F1WJHCQg==
X-Received: by 2002:a05:620a:1212:: with SMTP id u18mr20310102qkj.154.1629746602580;
        Mon, 23 Aug 2021 12:23:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q7sm9176839qkm.68.2021.08.23.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/9] btrfs-progs: do not double add unaligned extent records
Date:   Mon, 23 Aug 2021 15:23:09 -0400
Message-Id: <9369a488d508519a4bea2742dfd0bdadccf4dc99.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The repair cycle in the main check will drop all of our cache and loop
through again to make sure everything is still good to go.
Unfortunately we record our unaligned extent records on a per-root list
so they can be retrieved when we're checking the fs roots.  This isn't
straightforward to clean up, so instead simply check our current list of
unaligned extent records when we are adding a new one to make sure we're
not duplicating our efforts.  This makes us able to pass 001 with my
super bytes_used fix applied.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/check/main.c b/check/main.c
index 81b6650f..6f77b5ff 100644
--- a/check/main.c
+++ b/check/main.c
@@ -7928,6 +7928,8 @@ static int record_unaligned_extent_rec(struct extent_record *rec)
 
 	rbtree_postorder_for_each_entry_safe(back, tmp,
 					     &rec->backref_tree, node) {
+		bool skip = false;
+
 		if (back->full_backref || !back->is_data)
 			continue;
 
@@ -7943,6 +7945,24 @@ static int record_unaligned_extent_rec(struct extent_record *rec)
 		if (IS_ERR_OR_NULL(dest_root))
 			continue;
 
+		/*
+		 * If we repaired something and restarted we could potentially
+		 * try to add this unaligned record multiple times, so check
+		 * before we add a new one.
+		 */
+		list_for_each_entry(urec, &dest_root->unaligned_extent_recs,
+				    list) {
+			if (urec->objectid == dest_root->objectid &&
+			    urec->owner == dback->owner &&
+			    urec->bytenr == rec->start) {
+				skip = true;
+				break;
+			}
+		}
+
+		if (skip)
+			continue;
+
 		urec = malloc(sizeof(struct unaligned_extent_rec_t));
 		if (!urec)
 			return -ENOMEM;
-- 
2.26.3

