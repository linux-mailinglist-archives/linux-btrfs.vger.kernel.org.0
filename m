Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8124E674D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352005AbiCXQzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352072AbiCXQzP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:55:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93375B6D00
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sb/KWpR3LrIfdnjYTvSBXXlF03E6gQ/vVeznL7//dzk=; b=qoTobDCHKh86FsQtf+wGJbJtEV
        IeWn5Q+QHfKu4iJPQnKUxO1DR9ifpCqlQAgFNM2O/aPok4dnzpV6MntWWuOPjMTn91WD4kokE99/k
        +USo5UPXo/zUMoNNZszL4B4e+rbVxnotWixkZurAtjXbih9f7CspqN9cDFv82n0MsDtG9bPSOINFm
        ZWIhcbf2JVnoG+0RwEvt0whFF0/BUJ5KDi6PFD71FvQMrbeaVvu5Nbkuf5Z8H6lq1OI9DYhJrDGw8
        jH65xX44qqwajmdskKU+Pw4h2dJxVl7231Yrj+qBZirac2cXDMGfU7UhSlJR92jP9MPK+ccar34HS
        Mt6dSJTg==;
Received: from [2001:4bb8:19a:b822:2a44:1428:2337:3096] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXQh5-00HFx8-JX; Thu, 24 Mar 2022 16:52:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: remove the zoned/zone_size union in struct btrfs_fs_info
Date:   Thu, 24 Mar 2022 17:52:09 +0100
Message-Id: <20220324165210.1586851-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324165210.1586851-1-hch@lst.de>
References: <20220324165210.1586851-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reading a value from a different member of a union is not just a great
way to obsfucate code, but also creates an aliasing violation.  Switch
btrfs_is_zoned to look at ->zone_size and remove the union.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7631b88426e3..0edcce6d2db64 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1045,10 +1045,7 @@ struct btrfs_fs_info {
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
 	 * if the mode is enabled
 	 */
-	union {
-		u64 zone_size;
-		u64 zoned;
-	};
+	u64 zone_size;
 
 	struct mutex zoned_meta_io_lock;
 	spinlock_t treelog_bg_lock;
@@ -3928,7 +3925,7 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
-	return fs_info->zoned != 0;
+	return fs_info->zone_size > 0;
 }
 
 static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
-- 
2.30.2

