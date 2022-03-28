Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17084E8E35
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 08:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiC1GbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiC1GbM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 02:31:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D061148
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648448973; x=1679984973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AMYFyBdErjBYpbOwj42VFSS5eQqiRfGIhaZcEa/4+xo=;
  b=em4fZeNkBloLcayiCQNlU1jS3ovLS9BhImtEVGWm/BZ8k2uNWwgqnYMH
   hrqWl1xp9E9u+MQWWFr0TsgKWyMr3IuOHtGUZS1ktPvOyfufAB49Vaz6X
   RPH6znO/PQ1FE41PfP689awUsFf+fdP218RoWbvuy9dWna+INthYyeDfs
   3LWneT6xtrXJ7mnYy2gFtEqaMvaTkTyCdlRWvFKQIBodxUxEYsVR+aAWO
   2rRTgfaO4Ciao9r1yePAXJZiR0S8U2phB66C2tARxga+ATd6qHSspC3o8
   AMofUITndMoHAR6z16ai619SJPFMtc6RPso2DmJLmt2aXDjU4R8qOOdSa
   A==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="300566281"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 14:29:32 +0800
IronPort-SDR: 3v0qT8HlSFDV00Vc0YT4qo/1OnSRlxxLPigotaEdIJ3IMRN+dQfe1eMPg/sVCp4IGRUo9GWSu+
 3BTdZqmXi+xv02wx3+KObwAuZHVy6C9NC5A4EBjGf+GGEARE7oEJOUGVZVP75l3F+HQhrYeRZF
 /5+iHrdwVP+rRcHeP8YxSZ6oRlZ2XfIqyLryLKnCRrIrCxhUfqcKqVq1+kCWqBspvtOyqhOmRE
 b/ewbLfYYPUkdAuRX6H/R5O7+Ef/W5THkYi7AQ6KGIkMFvmMYWLJ/DyLb+f+BCrzLoo0tD79PM
 yO1PV9YMskYBHTTmgupt60fh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 23:00:25 -0700
IronPort-SDR: tx97LU0y3k04xKL08O0GtYvdnL7tBxJrlz4ZIoDTedZVUXYE9UvC+PDiFFarzQQpdYjxEZpDzD
 zSZmyXWbGeMPXrm/xSBjA+elSFLKf51UBcZEt2p0NGlaybsjFt524RveYFaoAPqsHvxq7wywK5
 nzwh170Ga+UMFfHfAVU0hNTLLVhCvU7xqEQcYhOg+7k7uvykQOQG2F6lMnhVPCM9O3RuvYsbbf
 SMmQ68YYyX/NYfiAxjN0TWf0999CLRj7B+y8Qq2U6inoUe8zi8WM36tycenL4mBhOGH9GjfUeQ
 /3U=
WDCIronportException: Internal
Received: from phd006511.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.242])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Mar 2022 23:29:32 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 2/3] fs: add check functions for sb_start_{write,pagefault,intwrite}
Date:   Mon, 28 Mar 2022 15:29:21 +0900
Message-Id: <5a8a19efe9f19b3e11026f57835614731aeeb62d.1648448228.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648448228.git.naohiro.aota@wdc.com>
References: <cover.1648448228.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a function sb_write_started() to return if sb_start_write() is
properly called. It is used in the next commit.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 27746a3da8fd..57fedc4af4a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1732,6 +1732,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
 #define __sb_writers_release(sb, lev)	\
 	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
 
+static inline bool sb_write_started(struct super_block *sb)
+{
+	return lockdep_is_held_type(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1, 1);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
-- 
2.35.1

