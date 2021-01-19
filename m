Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8831D2FBA13
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404071AbhASOlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:41:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:37990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390777AbhASM3F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:29:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lgkt8W7DTlKf8yIh4tgLx3cP9saf6TvIyQL7+9cBMuc=;
        b=i3oKjaiMAjqOCI7YBkYotC7ilJwCqU6aNQRVWG2+2GHPF9WgWEQG4MAT7/9xGXWzLSBrVo
        /nL5FwkdplL6CKwMaiYN2Anv1pJK/Mm9KmVVmsaGCk91SQ8oeRbJkly1X8Us+RhUQVCway
        jwOAtSY3XFMM/nYui/ZCEw4hFm3eqnQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FEF7AF52;
        Tue, 19 Jan 2021 12:26:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 09/13] btrfs: Document btrfs_check_shared parameters
Date:   Tue, 19 Jan 2021 14:26:45 +0200
Message-Id: <20210119122649.187778-10-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
References: <20210119122649.187778-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/backref.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ef71aba5bc15..eca255432a59 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1503,6 +1503,12 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 /**
  * btrfs_check_shared - tell us whether an extent is shared
  *
+ * @root: root inode belongs to
+ * @inum: inode number of the inode whose extent we are checking
+ * @bytenr: logical bytenr of the extent we are checking
+ * @roots: list of roots this extent is shared among
+ * @tmp: temporary list used for iteration
+ *
  * btrfs_check_shared uses the backref walking code but will short
  * circuit as soon as it finds a root or inode that doesn't match the
  * one passed in. This provides a significant performance benefit for
-- 
2.25.1

