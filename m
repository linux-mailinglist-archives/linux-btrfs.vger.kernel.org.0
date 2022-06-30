Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23289561FE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiF3QDZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiF3QDX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 12:03:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8D2197
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AePrhXWUXBDZ2Mei9NPiylnrVlTWDYBS+8EtIGcsnu4=; b=4rzos8/Vw1xYhFjFXCm5qZRnvQ
        3eB+lsGcLq36//H1/9TTOZU3Z0uCBLZABOU06g1gx8JQPGHvSt4HPqS8wQt+UyCIY9JO1bpXNFLfW
        gYLh/Oj+Tm7pDfBL/jVbYg3pg9Chzo549tovAZwS0xPbDBYRtqhoayQcaqwcJjnKLwiH+92sF6nXX
        0VtACBSpkpjF9LQAEkHaXQmpVtMnk8KxV/37rwQJV1rZGZjPMjcq1D3HRzeYYJ5xvnWgVSZ586cWn
        SaQBO/tYBcucQm3IQGZurEOwVfHU6pzl+tSYi8foC9kCZyAZ79fFc+OhvInvKBKW9Z+Bx+o2QUZgZ
        sw8peXmQ==;
Received: from [2001:4bb8:199:3788:3ea8:4fde:60a4:7dbf] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6wdU-000U6j-Tv; Thu, 30 Jun 2022 16:03:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
Subject: [PATCH] btrfs: fix a memory leak in read_zone_info
Date:   Thu, 30 Jun 2022 18:03:19 +0200
Message-Id: <20220630160319.2550384-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Don't leak the bioc on normal completion.

Fixes: 7db1c5d14dcd ("btrfs: zoned: support dev-replace in zoned filesystems")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7a0f8fa448006..e92bd5582cab3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1759,7 +1759,7 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
 		break;
 	}
 	memalloc_nofs_restore(nofs_flag);
-
+	btrfs_put_bioc(bioc);
 	return ret;
 }
 
-- 
2.30.2

