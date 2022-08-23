Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FD59ED34
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiHWUMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiHWUME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 16:12:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE4A7A9D;
        Tue, 23 Aug 2022 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4lBrxzzuzYzQkHqa78SkigUFZ7vFyXW/HLHNNKSnt/8=; b=M2x3zIwfsCD0puaCfgdNqDN1Sc
        3qONZny1uUY/3rXsaw0DuFHfmrinGC+oX4t5X4lIZJ5Ys/yipEPdUzZQUKAYacYL2zbqWpCtmSkKU
        TQQjWwvogUNLgn9oN5DF8GnoInCr+Ov9B5HWBLNcap4YTgtoNq6gEwCRko4OzxG5aO0fQbJhk2HWu
        zX/7t05mjIYE0rI+v5OhfvYiwTIsxcoj7i02wT+KEqRmADvm8fccEwOHgcfOOVobU7FyfeM1EK178
        Z1enId56Xunxic7VCuhzCqVuRpnVkT3UDSDFvOSKcGc4WS94QkcdiIIrzdbRxKMH/4oNaE7gjjFSb
        sJSt7hxw==;
Received: from [2001:4bb8:190:6c32:d3e3:62e2:bb3f:326d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQZdZ-008bEi-AJ; Tue, 23 Aug 2022 19:32:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 1/2] btrfs/271: include common/fail_make_request
Date:   Tue, 23 Aug 2022 21:32:29 +0200
Message-Id: <20220823193230.505544-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This tests needs the _require_fail_make_request helper from
common/fail_make_request, so include that file to avoid a test failure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/271 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/271 b/tests/btrfs/271
index c21858d1..681fa965 100755
--- a/tests/btrfs/271
+++ b/tests/btrfs/271
@@ -10,6 +10,7 @@
 _begin_fstest auto quick raid
 
 . ./common/filter
+. ./common/fail_make_request
 
 _supported_fs btrfs
 _require_scratch
-- 
2.30.2

