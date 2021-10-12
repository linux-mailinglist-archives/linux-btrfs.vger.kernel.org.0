Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A939C429FAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhJLIXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 04:23:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhJLIXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 04:23:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94D2922180;
        Tue, 12 Oct 2021 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634026899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3+8NYWA663lXmMZ4hUVG8GizXCiJhonEW/uqq+feuU=;
        b=A3c6TGdkkvQfjkiNCOZcg+KuULWu08HOu8f/k0RnXtc/HSKwes8hrfIf6SIDJUlqI2W16J
        1fz+4lYpmZud24rv59oiz9HbSFm7Z9P31jcBOrAIdITdbVu3JMuZjXsru1Fl/Igih5Snst
        9LR0BK+0SPNNrWA9FxEZt4kfeOMe+XY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59EC813AD5;
        Tue, 12 Oct 2021 08:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDCNE5NFZWGkRgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 08:21:39 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/5] btrfs: rely on owning_root field in btrfs_add_delayed_tree_ref to detect CHUNK_ROOT
Date:   Tue, 12 Oct 2021 11:21:34 +0300
Message-Id: <20211012082137.1476078-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012082137.1476078-1-nborisov@suse.com>
References: <20211012082137.1476078-1-nborisov@suse.com>
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

