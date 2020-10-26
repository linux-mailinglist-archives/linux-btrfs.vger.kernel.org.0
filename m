Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF129984F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgJZU5g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 16:57:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40288 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgJZU5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 16:57:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id m9so7805689qth.7
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M84GAXEwUxWaRrqs+QZ2oVxAW6ZNZ9Sx6nHQ3GDL8GE=;
        b=oo6Cc5LMGZHG7LALrZpoEGKC4UXN952AKNTgyJCa10S7BHfDHczeDz8RhNcdQEneGY
         anER7yT8RDC38NjFkZfueUpAv9WKtfGNvtTp1deYt/Aez5WdlBXkvZ2HUbi3DjEnZ+d+
         fPMjuWInqEfWrjGbZvVC7RKekTO6R236dshhOYNnip/f9IlM3yD7I1lGDAFlAHAJgMoU
         Zm5auveUokKCv6e6jNEXiFjKIbMTAI29xNALxi2i9TuSH/4hKVfnxDxF9jrzAOuLykWg
         VUCunDRic8UTg4odUTSCjO18dOEtpGBqql38HcYu7jhczd4G11j1K9QaCrhmy8eBEtqz
         0SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M84GAXEwUxWaRrqs+QZ2oVxAW6ZNZ9Sx6nHQ3GDL8GE=;
        b=YUMAOH3P/raHlqGOMJFD55VTcgpjYbvz6gSHZApvjB8WszRQKwZ0Ovd52UgQFCECMf
         zDyzqWC2ITlN0EJmoYUn4mvfAkmzs4Qqt70oqfWxBYvEWU0f27OI9+ubmobhlQYKyQAR
         L0Igz87YN7gNe7ucbxXSS0wpv6EQnzaYFjOGWnGNCcbtT/oGAGmNqP86L+pbiKuXMwoj
         SfPxyiTB8VLo1QNmQ6e5eWT7uL8EGyAO/D+zOTTA50j7cG40Mg/YUGWOj0lZMcj8omFA
         nvYahUmZLLPgixZkFVMYLvhChetdXh9Lxhi78USfYapqlFFRjXAnJkZNgGmHb1tuVy2y
         AfpQ==
X-Gm-Message-State: AOAM531wWHF4qbDNJ4v0IigPyEjlLO5grOaNJAe/9s9q7B+gZe4jywok
        d5XMx5wL9ufac+6/ieEYKdPNx/Rjvobj62wn
X-Google-Smtp-Source: ABdhPJz8EKnCJP3YOGl8hqYn4un403dmvpkfNshZeIvByEzkD39rXOMdat0UOQgGxahuDejw+JzhLg==
X-Received: by 2002:ac8:4e01:: with SMTP id c1mr19279551qtw.343.1603745853399;
        Mon, 26 Oct 2020 13:57:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d129sm7225239qkg.127.2020.10.26.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:57:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: fix min reserved size calculation in merge_reloc_root
Date:   Mon, 26 Oct 2020 16:57:27 -0400
Message-Id: <617eb7b3560d2319b8362209331fa4bc3ec03cc5.1603745723.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603745723.git.josef@toxicpanda.com>
References: <cover.1603745723.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The minimum reserve size was adjusted to take into account the height of
the tree we are merging, however we can have a root with a level == 0.
What we want is root_level + 1 to get the number of nodes we may have to
cow.  This fixes the enospc_debug warning pops with btrfs/101.

44d354abf33e ("btrfs: relocation: review the call sites which can be interrupted by signal")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3602806d71bd..9ba92d86da0b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1648,6 +1648,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	struct btrfs_root_item *root_item;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
+	int reserve_level;
 	int level;
 	int max_level;
 	int replaced = 0;
@@ -1696,7 +1697,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	 * Thus the needed metadata size is at most root_level * nodesize,
 	 * and * 2 since we have two trees to COW.
 	 */
-	min_reserved = fs_info->nodesize * btrfs_root_level(root_item) * 2;
+	reserve_level = max_t(int, 1, btrfs_root_level(root_item));
+	min_reserved = fs_info->nodesize * reserve_level * 2;
 	memset(&next_key, 0, sizeof(next_key));
 
 	while (1) {
-- 
2.26.2

