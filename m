Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1FB744F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2019 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfISHkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Sep 2019 03:40:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46848 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfISHkR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Sep 2019 03:40:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so1673967pfg.13
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2019 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ePvWTkXx28MTm4wiNqOIWppE2mFzzXHavQnmQLKKpHI=;
        b=lz+HVhvtSsUkVMo/7ydWHek+APWDwPr2uB3kl5sIh7rtA67r9FdvgpR/Tz21+dB4ZM
         knWB/o9caVhHz4m66+ZJz9neeYS36JWItrQPBcth2k+MVDvkgk4Vq4bVPgiBolXMNf6T
         NR3jjKfW2BlYih5txTvkhXvhx2Uap3RALzbSHA/7CoqduBfNtEFp868A7ofy+rQmyU46
         GivE038UJ/R4aNkL91Zp1t0EgTfDLU1jFgMbhguY9FMJFJKWlmnnP2MDpD1sF8a42TzV
         sgyzo1xGXryUDk2hFIBytAO3smqgb4KQdZmugqe4LiBx15IV1hQYANOmibaqwi/if03V
         ubaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ePvWTkXx28MTm4wiNqOIWppE2mFzzXHavQnmQLKKpHI=;
        b=HtzDPJCf4JAiqUrWyfCXf1sA6xspCl2KsLWnabqgXZGsYdM4Wsn9pQwWopei8+jd3E
         37rWaC7B+UH/5VQVCChqH4158RoP2QPRKyu56AKNdNibvOVGzivTOPGJW373nWS8XDA+
         /XoTUkIlAB7wZj/1jqK2oiGVFdFPwrLtCUKPc0yicfSBDD+D8T39pZVbJwelQp4qVjui
         +fLkFQd+3k5/63ronv2mWUlLyecQGqyS5UB/rkAs7Aj+Ih3YCYUC+inKEShpKewuD1Ld
         845jnRdMf3BHAoZdAf4hos9hMzcccXovSkpU7I8WGKskS6NZouTlWIGK/wmHdc6wRMbN
         daww==
X-Gm-Message-State: APjAAAV2/UbBGBxwruGLM0OOYPHWncYi2y8V76vQ48kjGoGnj7x3CXU7
        ZGWP9CIEahguKFCFJEXIMeQ=
X-Google-Smtp-Source: APXvYqw52FfcanrcxOc6//oHhQKbMSXI1MB9ZY8sySf6fbnna3pxZTePjpxfxxMjUV/3xhB0et7CWA==
X-Received: by 2002:a62:b416:: with SMTP id h22mr8493957pfn.180.1568878816681;
        Thu, 19 Sep 2019 00:40:16 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:3613:c415:107a:7123:4ce:911a])
        by smtp.gmail.com with ESMTPSA id l7sm20364850pga.92.2019.09.19.00.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:40:15 -0700 (PDT)
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
X-Google-Original-From: Aliasgar Surti
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH] fs:btrfs: Removed unneeded variable.
Date:   Thu, 19 Sep 2019 13:09:57 +0530
Message-Id: <1568878797-29553-1-git-send-email-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

Removed unneeded return variable and directly return the value instead.

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 885ce33..4904820 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4259,7 +4259,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4267,7 +4266,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_info(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return 0;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4311,7 +4310,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 
 	spin_unlock(&delayed_refs->lock);
 
-	return ret;
+	return 0;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.7.4

