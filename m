Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF34184B34
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgCMPpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:45:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36394 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgCMPpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:45:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id u25so13253834qkk.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IGM9rYO2INmWjL6t4f52R0U2ORwMLuXiVxTzv7xQVy0=;
        b=19gdTsHej178wnGReCgf5rPDjtCFaQ7VnnP9vbKbox7pUDHsdDfpO64V1nFe/8MBp6
         6Yz5hXLxX/dEpaJYS9HMUUg/AJy53sKxJbemsqUwQvsgI670MvKGBdvXx16ceZS9phy3
         lDNr9Iu5TpfiOAVYbOmTwmWaSY+d4Nviucy9xRFD15SfbFYMGE3lKuRhtTLkv9rrw1r8
         U+JII/r03wZ0WsR2DyP84kbCOkWsWDPjIRK7oNkhFNvjRQpHnBgV11463bUkO2sKINNo
         VXNlX6OKTO90ID/PEZR20ZkzGW/tTieOUhgAV3J1rFyNnc+FTugIR/6sCuVm81EFNFtN
         A/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGM9rYO2INmWjL6t4f52R0U2ORwMLuXiVxTzv7xQVy0=;
        b=QMRQXxsUU3UzlGRBtZ9bPdlEYGmI17X3DT9PJMgAZCoxgBKRV8UQOvsct/Nm2H1WlS
         oOlKbqHvkw34eN7eXIx25I07bgvWaNtVQLF6VhVHfZw34CN1FhfHmOJVoIWwJqOngm50
         xIiL7BJ45H2RDaZ/uaKYwhbSXJ4O6/mXHj/097yQYYz1Fay8F3LvWGRpg1pQscBPbuUc
         H4nYMZbYSdD8KotapARdOX8XsnGNIk0ujeJt8oM21Mso7/ZrwJp+fLviCaIolzd0F+46
         N3+dDSrdNIGu1IChObdq48doAdRt93u/+qFmsdBQu18YGaK9uofXEY7TZ2YT1J/QmTgS
         C/ww==
X-Gm-Message-State: ANhLgQ0tyV63nki4Kv5XvE5Gqswmcc1z5+BZHzmDUfWe3UOYkJokEL1F
        TpLVdYCEqpAjV/e6U2YM2DNQnlXDtiE=
X-Google-Smtp-Source: ADFU+vssEPCmZR0S4PkJ5cXZZdBYqXiCW9FcU/qv1r1CpuLS0ujsn/TOqbg+25ZZwwBortgeK1KMdA==
X-Received: by 2002:a37:b986:: with SMTP id j128mr13554470qkf.109.1584114306042;
        Fri, 13 Mar 2020 08:45:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v19sm14361747qtb.67.2020.03.13.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:45:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: remove a BUG_ON() from merge_reloc_roots()
Date:   Fri, 13 Mar 2020 11:44:48 -0400
Message-Id: <20200313154448.53461-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313154448.53461-1-josef@toxicpanda.com>
References: <20200313154448.53461-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was pretty subtle, we default to reloc roots having 0 root refs, so
if we crash in the middle of the relocation they can just be deleted.
If we successfully complete the relocation operations we'll set our root
refs to 1 in prepare_to_merge() and then go on to merge_reloc_roots().

At prepare_to_merge() time if any of the reloc roots have a 0 reference
still, we will remove that reloc root from our reloc root rb tree, and
then clean it up later.

However this only happens if we successfully start a transaction.  If
we've aborted previously we will skip this step completely, and only
have reloc roots with a reference count of 0, but were never properly
removed from the reloc control's rb tree.

This isn't a problem per-se, our references are held by the list the
reloc roots are on, and by the original root the reloc root belongs to.
If we end up in this situation all the reloc roots will be added to the
dirty_reloc_list, and then properly dropped at that point.  The reloc
control will be free'd and the rb tree is no longer used.

There were two options when fixing this, one was to remove the BUG_ON(),
the other was to make prepare_to_merge() handle the case where we
couldn't start a trans handle.

IMO this is the cleaner solution.  I started with handling the error in
prepare_to_merge(), but it turned out super ugly.  And in the end this
BUG_ON() simply doesn't matter, the cleanup was happening properly, we
were just panicing because this BUG_ON() only matters in the success
case.  So I've opted to just remove it and add a comment where it was.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7eae49834f3e..d35f075014c2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2653,7 +2653,21 @@ void merge_reloc_roots(struct reloc_control *rc)
 			free_reloc_roots(&reloc_roots);
 	}
 
-	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
+	/*
+	 * We used to have
+	 *
+	 * BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
+	 *
+	 * here, but it's wrong.  If we fail to start the transaction in
+	 * prepare_to_merge() we will have only 0 ref reloc roots, none of which
+	 * have actually been removed from the reloc_root_tree rb tree.  This is
+	 * fine because we're bailing here, and we hold a reference on the root
+	 * for the list that holds it, so these roots will be cleaned up when we
+	 * do the reloc_dirty_list afterwards.  Meanwhile the root->reloc_root
+	 * will be cleaned up on unmount.
+	 *
+	 * The remaining nodes will be cleaned up by free_reloc_control.
+	 */
 }
 
 static void free_block_list(struct rb_root *blocks)
-- 
2.24.1

