Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B027E172
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 19:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfHARwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 13:52:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbfHARwb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 13:52:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C1CFAD17
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2019 17:52:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8B7ADA7D9; Thu,  1 Aug 2019 19:53:04 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: remove unused key type set/get helpers
Date:   Thu,  1 Aug 2019 19:53:04 +0200
Message-Id: <69849572853391c7e2e3aadd2f169786ec663234.1564681931.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564681931.git.dsterba@suse.com>
References: <cover.1564681931.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The switch to open coded set/get has happend long time ago in
962a298f3511 ("btrfs: kill the key type accessor helpers"), remove the
stray helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1110bbd4bffb..3af3f680b5f1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2072,16 +2072,6 @@ static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
 	btrfs_disk_key_to_cpu(key, &disk_key);
 }
 
-static inline u8 btrfs_key_type(const struct btrfs_key *key)
-{
-	return key->type;
-}
-
-static inline void btrfs_set_key_type(struct btrfs_key *key, u8 val)
-{
-	key->type = val;
-}
-
 /* struct btrfs_header */
 BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
 BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
-- 
2.22.0

