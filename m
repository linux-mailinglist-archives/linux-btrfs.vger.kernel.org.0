Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAB12DE9BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbgLRTZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgLRTZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6BCC061257
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:39 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id et9so1410980qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YJOrmFF5Rg/rNiR/Y0w01wnyju/Fgp2JSLkpkzi6Uiw=;
        b=JxX32Ky1LPbxItEbYgt9QtupoDhhhs6JYJkWxxc35Bp62QdSt1EwWNNQWPEcrROaiY
         kfIpKFinP3fua39YGOVq4ONrczr6/92U0JWqn59+5qFMn8aJ6H1Wv/g0n+LR6Vw6Fa6I
         vKMfzXb2VrwBCWHXKHctVdTRgmst7F7YL7HAaYmJK/u6LXBUDQCciM+YrslZaYGpND6S
         9Elq6ElwOT7wpY9I258n+CpVZegZsF6ocOQg3PcOeM4QOSt6Upvk9ZvOv3nY0P1Xf3Q4
         1FXE3b8HXRKJaLBD6j07U9KV70trD3y1LCr9wN5O8aLAg+OMmIOW7mzoic0nggkYPNGI
         KMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJOrmFF5Rg/rNiR/Y0w01wnyju/Fgp2JSLkpkzi6Uiw=;
        b=gBBMQPWvqQzlI0ig7B2L+ko5KVHV33v0EQp1kuerROIE907qwhTHl8Rof+ejO7dJ4w
         qTNDoPNQsqzVjIDIPBbD9qTMCrioq4KR4Mb6sZhlLQadutucs/uKxibYwGyA5fIpZBHl
         ZmGLklS/ObT3jjCLokk/86eVIHhGiYIb4pER6ZmsRB4YqAWg2xHLVhwezLafnpvQz+ST
         J9ZlLMK7wxDOToXz0uE7XPb5WbGjdLbN5cp5vVzJ6q6bRud7m7q/gDMDs6FDIDOkI/3V
         6upenvt8gkixsJ/n0QCjCpXFPulXiedT0vcK90g76u+G0k6WeibZNk4JxELloNYTxpAW
         O6Eg==
X-Gm-Message-State: AOAM533ujaHEJS7L43lRJWbT/gH4ApYPcY/OzIZGq7eNifVSr1ReyrrO
        gzHGBvhdwavWXW4bXM3yJVngzYGYYTynHOWB
X-Google-Smtp-Source: ABdhPJwMcjxEp/JPjxiYEtN9y0TRzVG32ckcb94cG8fkBQZKbfcVXuRVpXQO4lE6oaziqQNXJQG19w==
X-Received: by 2002:a05:6214:d4a:: with SMTP id 10mr6147680qvr.62.1608319478692;
        Fri, 18 Dec 2020 11:24:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f59sm5777558qtd.84.2020.12.18.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 6/8] btrfs: remove bogus BUG_ON in alloc_reserved_tree_block
Date:   Fri, 18 Dec 2020 14:24:24 -0500
Message-Id: <1af52fb73699261a72a67cae1695efa1935e64e6.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fix 361048f586f5 ("Btrfs: fix full backref problem when inserting
shared block reference") added a delayed ref flushing at subvolume
creation time in order to avoid hitting this particular BUG_ON().

Before this fix, we were tripping the BUG_ON() by

1. Modify snapshot A, which creates blocks with a normal reference for
   snapshot A, as A is the owner of these blocks.  We now have delayed
   refs for these blocks.
2. Create a snapshot of A named B, which pushes references for the
   children blocks of the root node for the new root B, thus creating
   more delayed refs for newly allocated blocks.
3. A is modified, and because the metadata blocks can now be shared, it
   must push FULL_BACKREF references to the children of any block that A
   cow's down it's path to its target key.
4. Delayed refs are run.  Because these are newly allocated blocks, we
   have ->must_insert_reserved reserved set on the delayed ref head, we
   call into alloc_reserved_tree_block() to add the extent item, and
   then add our ref.  At the time of this fix, we were ordering
   FULL_BACKREF delayed ref operations first, so we'd go to add this
   reference and then BUG_ON() because we didn't have the FULL_BACKREF
   flag set.

The patch fixed this problem by making sure we ran the delayed refs
before we had the chance to modify A.  This meant that any *new* blocks
would have had their extent items created _before_ we would ever
actually cow down and generate FULL_BACKREF entries.  Thus the problem
went away.

However this BUG_ON() is actually completely bogus.  The existence of a
full backref doesn't necessarily mean that FULL_BACKREF must be set on
that block, it must only be set on the actual parent itself.  Consider
the example provided above.  If we cow down one path from A, any nodes
are going to have a FULL_BACKREF ref pushed down to _all_ of their
children, but not all of the children are going to have FULL_BACKREF
set.  It is completely valid to have an extent item with normal and full
back refs without FULL_BACKREF actually set on the block itself.

As a final note, I have been testing with the patch

  btrfs: stop running all delayed refs during snapshot

which removed this flushing.  My test was a torture test which did a lot
of operations while snapshotting and deleting snapshots as well as
relocation, and I never tripped this BUG_ON().  This is actually because
at the time of 361048f586f5, we ordered SHARED keys _before_ normal
references, and thus they would get run first.  However currently they
are ordered _after_ normal references, so we'd do the initial creation
without having a shared reference, and thus not hit this BUG_ON(), which
explains why I didn't start hitting this problem during my testing with
my other patch applied.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b6d774803a2c..c4846694ae9c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4516,7 +4516,6 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	}
 
 	if (node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
-		BUG_ON(!(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF));
 		btrfs_set_extent_inline_ref_type(leaf, iref,
 						 BTRFS_SHARED_BLOCK_REF_KEY);
 		btrfs_set_extent_inline_ref_offset(leaf, iref, ref->parent);
-- 
2.26.2

