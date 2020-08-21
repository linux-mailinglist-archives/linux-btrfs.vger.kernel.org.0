Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A656724D538
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHUMmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 08:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgHUMmJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 08:42:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E705DC061385;
        Fri, 21 Aug 2020 05:42:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so1714073wmg.1;
        Fri, 21 Aug 2020 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMgjS6TbvnNFuUvjyUB4t/vSCOuQYAmjXBRUb4TOC1U=;
        b=Il5o4Pv/5wUAqtykgtuqOPhZvYUTLTDr5f/IuxehsDDsDA3NCWQl1HtGKfEMz4ly5u
         mo+9Gb5Td0C8WSasVhTEfNrFanWAjSrxUV+U5tfFTDM+fupjJoGyBFK9J/1Iu756pb1t
         5xBKGN6TwyWzG7s2i5wzWzuCyv1j/zCeXtmp7gkGI0WbxOBDI0ycFZ/mcpSPuMZzMDg/
         NlJQpavRJ0BbzGHY19HXFFKPaoWxTdGlFczSAsi7p1Tpu/a/Pb5Mk1KVIXqFdKnE/Hef
         vvfnZ0EX6KaPsTYpVfyr+MGLM3VRZK/WixmvElxmLIlVq4wTqIm1a00jsZiBXc8ho3ID
         aigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMgjS6TbvnNFuUvjyUB4t/vSCOuQYAmjXBRUb4TOC1U=;
        b=c4nzlpxnKIkY+xleCdOZ70feTg75lyB/B5hoJWE65IRxxy5DngG5Saimi15Wuyg5hn
         MbgXGWINxYzmcGEE6Hu1zgaI2qZCT5fdiIEzN2rlf39mo37rdcgW9Z3ECxlR4crD7U91
         SMRrLMnnA6Jyd25pG438h66JHu52KHyfIAQ/jywFiI4oFNIlwDT8QPVR/+KCLxmJ2+x6
         dvm1TNX2nJ3iQTXX9PfnR0dGWTnacVY/0iNKs9JqWDGSWCDIKEDmd8h2KlE7Jyr8C40M
         r217kt/js/PrExWS6Bt7pFolXAuoxdUxMq2T+SXxOYk6fODzPHfJ7hx+pC3QJYLNdljb
         RZ7A==
X-Gm-Message-State: AOAM533ODOvwDiE9ikSaaMeK6XbyEyyw8Nri+2V9YZiUQ78JPA8Yw+Tg
        yKadYn7BpXZuRRLyDU6U0UM=
X-Google-Smtp-Source: ABdhPJyzwlZDHumT3taKe8Dm0S+5C+Ko4Xf+iQ/rbwPsHIL2sUHpS1rN0OkC6cSAr89k6NvSTzut3Q==
X-Received: by 2002:a1c:48c2:: with SMTP id v185mr2961666wma.5.1598013725134;
        Fri, 21 Aug 2020 05:42:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:4b87:b300:cc3a:c411:9a4b:dba6])
        by smtp.gmail.com with ESMTPSA id l21sm4664448wmj.25.2020.08.21.05.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 05:42:04 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] btrfs: check return value of filemap_fdatawrite_range()
Date:   Fri, 21 Aug 2020 13:41:54 +0100
Message-Id: <20200821124154.10218-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_dio_imap_begin(), filemap_fdatawrite_range() is called without
checking the return value. Add a check to catch errors.

Fixes: c0aaf9b7a114f ("btrfs: switch to iomap_dio_rw() for dio")
Addresses-Coverity: ("Unused value")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 fs/btrfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7b57aaa1f9acc..38fde20b4a81b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7347,9 +7347,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * outstanding dirty pages are on disk.
 	 */
 	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-		     &BTRFS_I(inode)->runtime_flags))
+		     &BTRFS_I(inode)->runtime_flags)) {
 		ret = filemap_fdatawrite_range(inode->i_mapping, start,
 					       start + length - 1);
+		if (ret)
+			return ret;
+	}
 
 	dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
 	if (!dio_data)
-- 
2.28.0

