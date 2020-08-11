Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D3241A95
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 13:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgHKLpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 07:45:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbgHKLpi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 07:45:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F67EAD75
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:45:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs-progs: check/original: don't reset extent generation for check_block()
Date:   Tue, 11 Aug 2020 19:44:49 +0800
Message-Id: <20200811114451.28862-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811114451.28862-1-wqu@suse.com>
References: <20200811114451.28862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In check_block(), we unconditionally reset extent_record::generation.

This is in fact pretty correct, but this makes original mode fail to
detect bad extent item geneartion.

So change to behavior to set the geneartion if and only if the tree
block generation is higher.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index f93bd7d4ca70..72fa28ad216a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4440,7 +4440,8 @@ static int check_block(struct btrfs_root *root,
 	if (!cache)
 		return 1;
 	rec = container_of(cache, struct extent_record, cache);
-	rec->generation = btrfs_header_generation(buf);
+	if (rec->generation < btrfs_header_generation(buf))
+		rec->generation = btrfs_header_generation(buf);
 
 	level = btrfs_header_level(buf);
 	if (btrfs_header_nritems(buf) > 0) {
-- 
2.28.0

