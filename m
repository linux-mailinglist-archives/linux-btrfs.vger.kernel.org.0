Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E381794E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbgCDQSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:48 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42428 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388254AbgCDQSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:48 -0500
Received: by mail-qv1-f67.google.com with SMTP id e7so1026308qvy.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qu49wBlHMUVbjHma7QtYYz1SYOlxzwRAzTtjNU9X+z8=;
        b=TCSRF1PDiDcRySQnv6ehUR4QSll0z9Hq8HYwucTJImKdtCUAg2SRBaGMXZ8ST9osPO
         GlV7W1H50E9895MwnpgDC2swpVgk/F2n7L6z6+MuD8NqH+9y5RgEOLUnrzD6oekn2om0
         ZfcFkNyVtFKW9h+9Co9e9RCmXv7M3AnHwhVPmm76Z9jLlRAm5LynbXhFcCtkGl6lmzFl
         LscM7Nt675pdGXgB7acvrQtTd3feYfvI1CGxrFWv9oszPhxAhW/u5kqWL6xVJMP1iJ4S
         dXq00SMa5AcmE2pC3RBI4VyqnIo+AGf3IBSAE0nVrzipqpyre1DRNh6YZtQrp/7ocDGI
         AvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qu49wBlHMUVbjHma7QtYYz1SYOlxzwRAzTtjNU9X+z8=;
        b=qfzop5rqj2gPgZaloRQP5G96wP2ErgnEZ2f+B1PicZ4ydFWYh9BH8Qrj/Qk87FkxtO
         kMViZbp4MDdYHaZhwhb4KpzG/aWhU5cITNmN+S0tH9Xmlid5K/BzRGcu4/NK8NtA2qpf
         R1LoISXurfFG34tAdaG0VYMZ4FgpEXkFi5ifCL+M5KvKDH8IFy4dcczO2P5ijpxWB6hi
         kjZCr67OPeSsCvwEB1FAkeX4r3IkpqPD31g+ey0HyqsUigzpMW2FT9omZUGbU012SEmr
         mdc6TeFmgF28nwQc5XpeF3InzSCO6icMrjGz0bWeylc4iomxTIYfhgrtSw45t8OYqxcv
         nyuw==
X-Gm-Message-State: ANhLgQ2oGi1cnGGD5dpPyqHeeMvLciM1Fvm1y5k2bsyB+zjq4J+oA6Wp
        2xq4KIB/jEAYx06R+yIev+/YeFozwXI=
X-Google-Smtp-Source: ADFU+vsDMi3m6Tdvqm97pqzAVG4WQ3wvE1r8JlT6rZ+MWSc4vVIzctCT93iBpjaEFb5m7ym0y/Bx/w==
X-Received: by 2002:ad4:4a69:: with SMTP id cn9mr2789930qvb.218.1583338726856;
        Wed, 04 Mar 2020 08:18:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e7sm5412102qtp.0.2020.03.04.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: remove a BUG_ON() from merge_reloc_roots()
Date:   Wed,  4 Mar 2020 11:18:30 -0500
Message-Id: <20200304161830.2360-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304161830.2360-1-josef@toxicpanda.com>
References: <20200304161830.2360-1-josef@toxicpanda.com>
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
index 0f19a22d7f44..a2b26cf9ee5b 100644
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

