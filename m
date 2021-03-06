Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7E32F753
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 01:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCFAkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 19:40:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:40884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhCFAkZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Mar 2021 19:40:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614991224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OuOkkaYvpdFW+0ywWEx5fDqo057rY5UTGDlHGsCnhQs=;
        b=hCsC6iYFmOz7ZHoWyjBn8rF3XLt3iVQ1/y3W6xOogzzSIcfnrYFE/kvtkFJoWxKYrpkwcu
        OyO0rBWXzFb9KPbnfg9LcL+EHrkJhNVEAndh3XiYepcjYHi8kProLf3eYiCOYTB8+hf7cs
        A/Y3rkIqCqS2lf8v3LgvQ//vSvDYuS4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC151AD72;
        Sat,  6 Mar 2021 00:40:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: fix false alert on tree block crossing 64K page boundary
Date:   Sat,  6 Mar 2021 08:40:19 +0800
Message-Id: <20210306004019.18528-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When btrfs-check is executed on even newly created fs, it can report
tree blocks crossing 64K page boundary like this:

  Opening filesystem to check...
  Checking filesystem on /dev/test/test
  UUID: 80d734c8-dcbc-411b-9623-a10bd9e7767f
  [1/7] checking root items
  [2/7] checking extents
  WARNING: tree block [30523392, 30539776) crosses 64K page boudnary, may cause problem for 64K page system
  [3/7] checking free space cache
  [4/7] checking fs roots
  [5/7] checking only csums items (without verifying data)
  [6/7] checking root refs
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 131072 bytes used, no error found
  total csum bytes: 0
  total tree bytes: 131072
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 125199
  file data blocks allocated: 0
   referenced 0

[CAUSE]
Tree block [30523392, 30539776) is at the last 16K slot of page.
As 30523392 % 65536 = 49152, and 30539776 % 65536 = 0.

The cross boundary check is using exclusive end, which causes false
alerts.

[FIX]
Use inclusive end to do the cross 64K boundary check.

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Fixes: fc38ae7f4826 ("btrfs-progs: check: detect and warn about tree blocks crossing 64K page boundary")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/mode-common.h b/check/mode-common.h
index 8fdeb7f6be0a..3107b00c48bf 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -186,7 +186,7 @@ int get_extent_item_generation(u64 bytenr, u64 *gen_ret);
 static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
 {
 	if (start / BTRFS_MAX_METADATA_BLOCKSIZE !=
-	    (start + len) / BTRFS_MAX_METADATA_BLOCKSIZE)
+	    (start + len - 1) / BTRFS_MAX_METADATA_BLOCKSIZE)
 		warning(
 "tree block [%llu, %llu) crosses 64K page boudnary, may cause problem for 64K page system",
 			start, start + len);
-- 
2.30.1

