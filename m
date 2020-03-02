Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6899176330
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCBSsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34165 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbgCBSsN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id 11so763202qkd.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l8wERg5ctbFlftxjcESVLjOuHsqqo3V/uLoiqby0hmU=;
        b=IuM0Niczf/97PBiPAsMEAEnzPF0oEI0peppPJE/h2K/p5RIkkMD9u2qebTtlwqYh21
         s7IrHuVHiEVJJhQ5pt+9L9Q43qx5lWxPGxzg7g47IkybO3DtWwpHkf19l/tUm/KP2huN
         0s84qlcBLPNZDRKjAlpChwTcsigZI3OG81Sc9BlnX7Xkl4mA25/AkKn4q77I3GcZtRYn
         w+VavrilpUxQNM2kg9iy043f783TyPlXrOn/qrYpTlbSxlanneV+SdsDgT3jcTPBFO6s
         ePwmj6wxSlAffV9U9P6D7XyEgt/9IYbCxeQ2BxBCh/ez1od0Xq4OmbGz+n+cLrupWx9C
         MGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8wERg5ctbFlftxjcESVLjOuHsqqo3V/uLoiqby0hmU=;
        b=Z9O9mNGQNCLYAqpY3bytg0M5BA3+wOwXhCnqkweGYB6TszqXbBd0/Li6xbyvUlfQcH
         n/Bz5alRTebKfTdmsgWSMUwjmrCV9O0ndpNOTODXsFnHPmtWy3RPdY94Y0Y2En3Goz/0
         5dj6gnxKdEKLo5zHA5q53RCEfS1pMxxWnBBlsHtOyrDmK4tk0ec/2ubkRjdzg0vZtWcW
         ZDn/KgAbNdQEy4kDikkZpyMtImDC7P2LRE8nDppLULG8TggYhCbHZpPv4eYnpoWcw0cW
         HCfmcURIzpN/OmQTOmvacVwdXorugpaMnHVg68huXecwsuKdvCJui1FRFfuCbDepG/eN
         5W2Q==
X-Gm-Message-State: ANhLgQ3aSAg1XlylO75Z0z7BdYSHv6E/DuEeSA+4DD1/ns1ehbNpL4i4
        YiA/nbIY0ra2PxRZmgfKZoAKObjXr4I=
X-Google-Smtp-Source: ADFU+vuDEEUMtg4DH5+SHtyQqeIbX89wk+1E9ESoDjFdKUC7FRGRXA/3IfydQbEvLWiOVg6oE5oHIg==
X-Received: by 2002:a05:620a:2114:: with SMTP id l20mr630543qkl.214.1583174891977;
        Mon, 02 Mar 2020 10:48:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o3sm10397296qkk.87.2020.03.02.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:48:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: remove a BUG_ON() from merge_reloc_roots()
Date:   Mon,  2 Mar 2020 13:47:57 -0500
Message-Id: <20200302184757.44176-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302184757.44176-1-josef@toxicpanda.com>
References: <20200302184757.44176-1-josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c8ff28930677..387b0e7f1372 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2642,7 +2642,19 @@ void merge_reloc_roots(struct reloc_control *rc)
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
+	 */
 }
 
 static void free_block_list(struct rb_root *blocks)
-- 
2.24.1

