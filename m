Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66815C634
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbgBMP6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:58:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60892 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbgBMP6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581609549; x=1613145549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfRFdlrmoYYFIpRot9KcZcVaDyhxUckjtUXezigMDZE=;
  b=A+mJIY/9XsZu5aaHHGBK0JVqwnZB07XF1ja23C7wKE6VDMw1V35bsd//
   Ii5mRCG4S21yevW/ldocTktMO2YU7qXuNjNlYCIk6WnIJa/ICdq51iB2j
   Eaz/KAa86B12Glz+fHaZ9dvBLGzVqv64ndnIkw6/i2cViiHlkVRbePGma
   HSN7DYWlHmQRgpdJPN4IuB+pxyaoArbsp1O/tA8gvCQM3f2VHGvuVQtWr
   QqTm9QNCNBKOUBMkJtWSbamyQQIVQWK2rLi3+FoDFGrgcUBUZWwXu4rQq
   HoBtmo0r4oTaRHx6sNJy9x+TDbO/tIIgD3lkpTNhJEmQrW11c9szNGEue
   w==;
IronPort-SDR: xd/BoR8sZ7iTkCQiO3fzLfZ/Uovkz1sglHmuWQ0ofn7RUOv5AbPhPNC7IwDc7qMEFPIupVS0Qc
 IPbD0k9DxCMG4x99l1cz3XXTIwdHSlh5L0WpF36TATD99/jmuc7gnZg/mD9KBc5Lsz0+M2idM8
 d8neW96tChYKO/tnpFexk3DyJSbQac/AUzPFXnllaN1DQBlf600wuM465I7m2doZwQTIgUEPex
 13+O7c3eY9pVn4Fw6JwH0tQcV2nkXiZD4hlM4AXqnbBRGtp3tUkq+0LnAA9Qiuab08t9NvIVVb
 k50=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="231587570"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:59:06 +0800
IronPort-SDR: j4ydFfcDHmG9XEFTo7R6Bl+vlaSpoxXLd5qCh6PR4QB/bayLwTNIhA3sxhx0sNIfdba+WOKExM
 FA7eJWhUbsgu6id5OmKypU5YMBf8ugXxbPhed4g6j7fjynZwu3d7IDjgbx7+xFJZEJvU05uDsp
 XVNcdz7HA8LHQUJA8HCzPaqgf4KHOkec9QsK9DnV5rDYi6vnu1Eh45VWjMDzJGTuqZywb9VbbD
 WbbOUMYnAib0eD5kGs5NJPYLsnwM8ryBZpj1gZsNXGbZ+cjqRxlhgiNeJrx4y6C4rG9VuZh1an
 Pjb9tSQe8gtYEgwl5MnEbRLk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:51:05 -0800
IronPort-SDR: tKv2KffTxYgWt0k0nDUc7syIbW/oXmJJqW0hT6ZiOdsksSbfPucTdVzr9JOj1LECv4zdTd5uli
 9nh+imcXYv3M9Uak/q52UQMZvZ9yi+gdXpKFgzRwnOlrQTuIkkTdWml19wknU22Nqk8kOfEPRU
 C60wViqH3Ifc0/+vxHiPtZhtXQMD4/qg9aDFvV1AH0qlUKP/vttPzCzUfKn1uukmIb3nQg1KK6
 2vPJddwnJDYzUt0X2w2/P54aAwzghh4/ZVLvMg5nHlh04Dpfg7BAF/KqU37cdV6Saba8QK0vkU
 m60=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:58:17 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 5/5] btrfs: simplify error handling in __btrfs_write_out_cache()
Date:   Fri, 14 Feb 2020 00:58:03 +0900
Message-Id: <20200213155803.14799-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The error cleanup gotos in __btrfs_write_out_cache() needlessly jump back
making the code less readable then needed.

Flatten out the labels so no back-jump is necessary and the read flow is
uninterrupted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 41e138f2ae12..c7ba2b393b33 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1372,18 +1372,6 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 
 	return 0;
 
-out:
-	io_ctl->inode = NULL;
-	io_ctl_free(io_ctl);
-	if (ret) {
-		invalidate_inode_pages2(inode->i_mapping);
-		BTRFS_I(inode)->generation = 0;
-	}
-	btrfs_update_inode(trans, root, inode);
-	if (must_iput)
-		iput(inode);
-	return ret;
-
 out_nospc_locked:
 	cleanup_bitmap_list(&bitmap_list);
 	spin_unlock(&ctl->tree_lock);
@@ -1396,7 +1384,17 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
 		up_write(&block_group->data_rwsem);
 
-	goto out;
+out:
+	io_ctl->inode = NULL;
+	io_ctl_free(io_ctl);
+	if (ret) {
+		invalidate_inode_pages2(inode->i_mapping);
+		BTRFS_I(inode)->generation = 0;
+	}
+	btrfs_update_inode(trans, root, inode);
+	if (must_iput)
+		iput(inode);
+	return ret;
 }
 
 int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
-- 
2.24.1

