Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055995B41AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiIIVsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiIIVsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:48:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4ED1023C9
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=e9DFomxrhjo+IolptmVq4lUWRNaZdIC5YdeRkoQ811c=; b=um0YlAYjAy/aUcp+H125i0awoW
        OypGM3qSoq0ElPRRxIPZL7roSQ1wHiOwEy/TbObDvwZ9J+pdsugT510vF0/iHOMnFxQSSpssKSkWe
        R05EOWZN+zIrWh6Xp5gEy+2T8iz7MpOnSQnApOMMLYwK/YJ2QC8+psx0NnD7V6x8Bo3IvZxI0zoQJ
        h3/8K/ioz6P9jNMgmMgMo8478GnOfGCf9LVdl+fIrUCEoQrLkw5BPLrE2n9vTDySOcHZmGmKHlSvD
        PQqSj7IoqCjm947/KHFIqSHE9caV6Bv7/VwkUYbjsi0qjcIYPESDqMr3OYxrvrhZvBYE0rCkwe9Ja
        V86dmr/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWlrD-003CEC-Az; Fri, 09 Sep 2022 21:48:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dsterba@suse.com, johannes.thumshirn@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org, damien.lemoal@wdc.com
Cc:     pankydev8@gmail.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: [PATCH 2/2] btrfs-progs: mkfs: use pretty_size_mode() on min size error
Date:   Fri,  9 Sep 2022 14:48:10 -0700
Message-Id: <20220909214810.761928-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909214810.761928-1-mcgrof@kernel.org>
References: <20220909214810.761928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use a human pretty output for the error message about the
minimum required size for a btrfs filesystem.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mkfs/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index ebf462587bd5..8a0018abd01e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1388,10 +1388,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 	/* Check device/block_count after the nodesize is determined */
 	if (block_count && block_count < min_dev_size) {
-		error("size %llu is too small to make a usable filesystem",
-			block_count);
-		error("minimum size for btrfs filesystem is %llu",
-			min_dev_size);
+		error("Size %s is too small to make a usable filesystem",
+			pretty_size_mode(block_count, UNITS_DEFAULT));
+		error("minimum size for btrfs filesystem is %s",
+			pretty_size_mode(min_dev_size, UNITS_DEFAULT));
 		goto error;
 	}
 	/*
-- 
2.35.1

