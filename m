Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3287184B2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCMPpC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:45:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45769 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgCMPpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:45:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so13200904qke.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gjs4n62lFhPeqX6CiEBAgr+CHJMvB2RjTdobKqO9pjA=;
        b=tsrTiS6Iu3LXow9JcXDBcTpbkFm/4eIBUBZX5AotmwQjrICN6deT910exGgGzkw1iz
         cVvm5MhS3e1KCC1EYJ5quD3VCU+gwdgZuauw+MK3oZdYZy3x4uabqk9do/8kufxFrCy1
         w8hsHOW5zEjWsFVLc1sy/Ox0xEdesXIoMRPV0pMVnGz155eRgVO1VHb+dRzxC99Sbknc
         Y+4oGVXh2h73QvY3GZ6mg/TjnO6OaKaVo54QDdNBNsPAbdaWfieYHCw7iCdK+00VNhdS
         HJk2UIub5BjzpqE6N0cO19+9d1YPxJm6R4zlzXV4F9W0lnqK2ye7O1KT+F+L5x/vHmt7
         TzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gjs4n62lFhPeqX6CiEBAgr+CHJMvB2RjTdobKqO9pjA=;
        b=NZtwzuzbcoMDYr4tJ1sfBwl8Zf5GrTpToBdDmrY3nGoxAVvLA7AP8VFR7dgo1vpxcB
         O9EH+PURwIOvgdzQPnONOalm7dVIN+pM3AVyC9csFuWJlaGxUScDHa5wl/wkbmHALQjQ
         qXNYbJhPXiz0+TCTsgAb5xZNoBT3ghBPfobDHXUb+KIwgwPr0ZgojvUwM2qUZmT99tiE
         pehEK9dPBxrGV4fOuAk90a5STo//haVpNilYD9QjciQQmp44q/x8R9YfJXwuU/5EWPlj
         HulDGAdoIPdEsxVeJUwBwctagC1i3BY6mdNE2JYLyUdW059OSoa/XklU54BvN/MGXr09
         AVnA==
X-Gm-Message-State: ANhLgQ1THnCSZcYvlOgwnJ03p12/FqzZsprH65mLHg900CNzdBdVCYTp
        uGKTqEX7WxEIlqQoemVo84l+JBK8i58=
X-Google-Smtp-Source: ADFU+vtdpObM1ipjeMIj0QpuZm/LNR7NbD421rrM8qI3Y08PcEGj5PsqL4ZU9Gij0PMcCt61BByADQ==
X-Received: by 2002:a37:b984:: with SMTP id j126mr12977933qkf.3.1584114298474;
        Fri, 13 Mar 2020 08:44:58 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u26sm4902067qku.97.2020.03.13.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:44:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
Date:   Fri, 13 Mar 2020 11:44:44 -0400
Message-Id: <20200313154448.53461-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313154448.53461-1-josef@toxicpanda.com>
References: <20200313154448.53461-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have an error while processing the reloc roots we could leak roots
that were added to rc->reloc_roots before we hit the error.  We could
have also not removed the reloct tree mapping from our rb_tree, so clean
up any remaining nodes in the reloc root rb_tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c496f8ed8c7e..721d049ff2b5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4387,6 +4387,20 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 	return rc;
 }
 
+static void free_reloc_control(struct reloc_control *rc)
+{
+	struct mapping_node *node, *tmp;
+
+	free_reloc_roots(&rc->reloc_roots);
+	rbtree_postorder_for_each_entry_safe(node, tmp,
+					     &rc->reloc_root_tree.rb_root,
+					     rb_node) {
+		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
+		kfree(node);
+	}
+	kfree(rc);
+}
+
 /*
  * Print the block group being relocated
  */
@@ -4531,7 +4545,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
 	btrfs_put_block_group(rc->block_group);
-	kfree(rc);
+	free_reloc_control(rc);
 	return err;
 }
 
@@ -4708,7 +4722,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 out_unset:
 	unset_reloc_control(rc);
 out_free:
-	kfree(rc);
+	free_reloc_control(rc);
 out:
 	if (!list_empty(&reloc_roots))
 		free_reloc_roots(&reloc_roots);
-- 
2.24.1

