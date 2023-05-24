Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B97A70F9A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjEXPDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjEXPDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D1F5
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hMVJehTwuH7w9DbGXSlJxOYWtxqeBJOFVh/4psqESiE=; b=w2EiZLyQGhOE4fMS/lFczHpiSy
        /yP0fPa+UvD89uDwve68H13eL8cl8TZb1qpB5SCm9KZ674XbgQSL/juv4QFt7OoKMLFRNnjtOznBi
        OgeKnR6d8AeGJXoWq4Vf3qUfF3c0PU6+J/fd6SNc653F+OVfOukNK9zXX5xTUiFoT468/5tsiJNj2
        u1HdEblcUT2xz67VUQhfQkzfbFQ2d0taBTkulgfQbbz64FQSKpSiOgNFdneMwXyh8LFi9+cFL/oKM
        eDUSPxl3SS3hsWAIWpARoWR2AqvttAQlmtsmIj0gNvAEnP17CDqATb4irSMyMEqm1KmvQKUdL/pjI
        kDlN3Z0g==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1M-00DmZx-2v;
        Wed, 24 May 2023 15:03:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 01/14] btrfs: optimize out btrfs_is_zoned for !CONFIG_BLK_DEV_ZONED
Date:   Wed, 24 May 2023 17:03:04 +0200
Message-Id: <20230524150317.1767981-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
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

Add an IS_ENABLED check for CONFIG_BLK_DEV_ZONED in addition to the
run-time check for the zone size.  This will allows to make use of
compiler dead code elimination for code guarded by btrfs_is_zoned, and
for example provide just a dangling prototype for a function instead
of adding a stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 840e4def18b519..5dd24c2916a1f3 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -853,7 +853,7 @@ static inline u64 btrfs_calc_metadata_size(const struct btrfs_fs_info *fs_info,
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
-	return fs_info->zone_size > 0;
+	return IS_ENABLED(CONFIG_BLK_DEV_ZONED) && fs_info->zone_size > 0;
 }
 
 /*
-- 
2.39.2

