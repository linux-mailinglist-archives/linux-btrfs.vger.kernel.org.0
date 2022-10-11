Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA65FB2C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJKM7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJKM67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:58:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5E923E3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:58:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FB98204DC;
        Tue, 11 Oct 2022 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665493132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXwa5DxqtYvjxmCCJ3nZI9az+4iYMGFEJnreIjEOUQ0=;
        b=b1lryQ9isqo90nIxiSnRRxptLJcw04QCCOQ/wqZ6OL7xnm95Ey92RAu8q/hn/7/RIXOmKk
        NwP14e33RRdF99N7ZyQ1HcQJy/Cyu5Q43O/Chf9vq7z8wKhGRy+qa53O909mhGvqOo/sUh
        ENuzLG3kJAXNMhJP8gsNR/h2L0CZw54=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 17E362C141;
        Tue, 11 Oct 2022 12:58:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1657DA79D; Tue, 11 Oct 2022 14:58:47 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/6] btrfs: add helper for bit enumeration
Date:   Tue, 11 Oct 2022 14:58:47 +0200
Message-Id: <8ac93de3eef16c454a9cdd9770515ee7c5bd229a.1665492943.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665492943.git.dsterba@suse.com>
References: <cover.1665492943.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Define helper macro that can be used in enum {} to utilize the automatic
increment to define all bits without directly defining the values or
using additional linear bits.

1. capture the sequence value, N
2. use the value to define the given enum with N-th bit set
3. reset the sequence back to N

Use for enums that do not require fixed values for symbolic names (like
for on-disk structures):

enum {
	ENUM_BIT(FIRST),
	ENUM_BIT(SECOND),
	ENUM_BIT(THIRD)
};

Where the values would be 0x1, 0x2 and 0x4.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/misc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index f9850edfd726..69826ccd6644 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -10,6 +10,14 @@
 
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
+/*
+ * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
+ */
+#define ENUM_BIT(name)                                  \
+	__ ## name ## _BIT,                             \
+	name = (1U << __ ## name ## _BIT),              \
+	__ ## name ## _SEQ = __ ## name ## _BIT
+
 static inline void cond_wake_up(struct wait_queue_head *wq)
 {
 	/*
-- 
2.37.3

