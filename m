Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32280428A94
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhJKKMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:12:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbhJKKMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 464221FE94;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633947021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3+8NYWA663lXmMZ4hUVG8GizXCiJhonEW/uqq+feuU=;
        b=oLa0IDSE8xSlImQ2/W2tD02KsN5SGKFsiKBMi5laHJvyorPIfT+yEMAyeUqZn4exJJ8mgl
        NuclVBsPnVQB67vl+TEKbw7f5srSgY4v38sQUwhwjKmdRRkmNB9ZlcQ7VeLL1JHF4LMESY
        VPi+E/BFdFoW3Wiw8yh4B5llJa3OjKA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1632B13F9A;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MM/fAo0NZGGJLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 10:10:21 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/5] btrfs: Rely on owning_root field in btrfs_add_delayed_tree_ref to detect CHUNK_ROOT
Date:   Mon, 11 Oct 2021 13:10:16 +0300
Message-Id: <20211011101019.1409855-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011101019.1409855-1-nborisov@suse.com>
References: <20211011101019.1409855-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

real_root field is going to be used only by ref-verify tool so
limit its use outside of it. Blocks belonging to the chunk root will
always have it as an owner so the check is equivalent.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 53a80163c1d7..7c725379b8ca 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -906,7 +906,9 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u64 parent = generic_ref->parent;
 	u8 ref_type;
 
-	is_system = (generic_ref->real_root == BTRFS_CHUNK_TREE_OBJECTID);
+	is_system = (generic_ref->tree_ref.owning_root
+		     == BTRFS_CHUNK_TREE_OBJECTID);
+
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	BUG_ON(extent_op && extent_op->is_data);
-- 
2.25.1

