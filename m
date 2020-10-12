Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0728AE7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 08:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJLG4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 02:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgJLG4b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 02:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602485790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XdZcFzIrYfBZoLYVuw/AmN1TBNF8JTaxpC3zxBg2Wec=;
        b=rs+K+fCWP3E7Sog0XIRe2MvDIV4AHgoFWwsl2buO9mLRdTcLYz83/RbK+2WPXBTpVGDXUf
        TN1YGepfHXxHARAxbB8U8pjHf9hatbXabbATfsfCR49cskcHTgQ4jnxziQg7yNebiFg35c
        6Mjs6OrptxpTcsAyDugIvPKGOL4TwaA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 042E8AEE8
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 06:56:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: space-info: fix the wrong trace name for bytes_may_use
Date:   Mon, 12 Oct 2020 14:56:24 +0800
Message-Id: <20201012065624.80649-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The trace_name for bytes_may_use should be "may_use", "space_info".

Fixes: f3e75e3805e1 ("btrfs: roll tracepoint into btrfs_space_info_update helper")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c3c64019950a..25fe03a53fb8 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -113,7 +113,7 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 	sinfo->name += bytes;						\
 }
 
-DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
+DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "may_use");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
-- 
2.28.0

