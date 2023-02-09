Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377368FFB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 06:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBIFOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 00:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBIFOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 00:14:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC52E0CB;
        Wed,  8 Feb 2023 21:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K7hO9e5fkjBhaTZ0nFLpSZgyJT3lQtrWMmHkU0NOSvM=; b=vU1EaMntfFGyKwaGAYcXAY3igX
        Gz5t/lW3x3EicAYar7c8hqYdMdBpwyStwZ+3SEKHtAZd0m1kPadVJkQcj8capOz7MxHF+drjnhlH6
        0Vj22tKxdvq1/n8B9N0RTNpKn9rLfez0jXJKe8G1GnbHVUM5gTj/sDnnKNwA1D1vw1yagRCaL+wR8
        0GAPyFnWgalpNnKg920WjDkzkONGYJeuLxwx5NUzSg2C7DZwE7gAJX6X9VBOieXk2iUCqINiN++sC
        T6a9Xz6IXsnyxwlBaa9WMIseZWw86Uka7axFcApbZq4O7z28udXeWPpGS2nskrJNnLZFz+hl5EVYJ
        rPLXcQog==;
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPzG3-000Bum-5b; Thu, 09 Feb 2023 05:14:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 4/7] generic: add 042 to the auto and quick groups
Date:   Thu,  9 Feb 2023 06:13:52 +0100
Message-Id: <20230209051355.358942-5-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209051355.358942-1-hch@lst.de>
References: <20230209051355.358942-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

generic/042 was removed from the auto group in 2015 by commit
7721b8501608 ("generic/042: remove from the 'auto' group") because it
always failed on XFS and wasn't run for other file systems back then.
Since then XFS fixed the problem it reproduces, and ext4 and f2fs
have grown shutdown support and also pass it reliably.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/042 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/042 b/tests/generic/042
index 38e0a488..5116183f 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -13,7 +13,7 @@
 # stale data exposure can occur.
 #
 . ./common/preamble
-_begin_fstest shutdown rw punch zero prealloc
+_begin_fstest shutdown rw punch zero prealloc auto quick
 
 # Import common functions.
 . ./common/filter
-- 
2.39.1

