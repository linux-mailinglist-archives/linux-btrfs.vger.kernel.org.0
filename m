Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD668FFB6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 06:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBIFOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 00:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBIFOG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 00:14:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3D62B298;
        Wed,  8 Feb 2023 21:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=04+ZHy+d6CZBLWnLswvmtpg1gaw7Fvsb8uiLzpSsrkE=; b=GVkG1rHRPmydmfAvhGxHTLfwIZ
        aGVfiEaQYhbPMlMVP5Ah2lQynLp+WYEh17tLGVoTgzrbbywokp9pyY7mKbiM5W2HZoaGTUbSofBa9
        4DW5z5hImuXEQxe9p5ZVBVQ4RffbX869aQlVQD0qOM0zB3I+ndf9YUtnsQkeUb6cfl18rSO1JHwhu
        z9T3+gsFr2xEnuhBJiNc8YIwmHc8GAXc/m/DNWuCFlhX92Hd12px7pvOhYXGCtopqiisaw4tEWbrg
        M/GVJRe8d67oOCn4ObqYZS20wqUbzWbAlunbUZEYJo0wcg0hZ9Q2hUu6p2rIl2LEiMGU52QzZcmcS
        RIXeR6cQ==;
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPzG0-000BuT-OC; Thu, 09 Feb 2023 05:14:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: add 185 to the auto and quick groups
Date:   Thu,  9 Feb 2023 06:13:51 +0100
Message-Id: <20230209051355.358942-4-hch@lst.de>
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

btrfs/185 runs in a second, add it to the auto and quick group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/185 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/185 b/tests/btrfs/185
index ee97b626..efb10ac7 100755
--- a/tests/btrfs/185
+++ b/tests/btrfs/185
@@ -9,7 +9,7 @@
 #  a9261d4125c9 ("btrfs: harden agaist duplicate fsid on scanned devices")
 #
 . ./common/preamble
-_begin_fstest volume
+_begin_fstest volume auto quick
 
 mnt=$TEST_DIR/$seq.mnt
 # Override the default cleanup function.
-- 
2.39.1

