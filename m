Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E88B388F44
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345463AbhESNju (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbhESNju (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 09:39:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C76C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 06:38:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k127so12681827qkc.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoN2/x/gh51SW7zBtlDdw8kguoXam//AdkUVcaB613Y=;
        b=Qedz2JxWXtWSa3mHyYUucp1tBc8YVg1s0hujrAgecYREIZorJTCINsy5chzfhTxmh2
         BPlCkpH94n3lAF5Ig6SppcXKo60wnR2cJXW2U+Br2engZVq6AdcrGLUsC7JUdgOjB2U/
         Lli5uZ6U/Eg3F938J5XC6Gv6lgXDSKnDkm3MMsiuU/1LafqCkxejrlJFH4G/BSchQpw1
         Z0cXpVfJstSDJPDwoVfQ4Fi6rlDI3hk19W0APkiQqN6c8Vgo/HmENhuZXTLklHUokrWY
         Yl0+gHm7FRJt4NANFhIzCJ5metqAj8qF4IZGXN7blcmjs9E2zK3mK2LuehiGtCPfJ/Qs
         xlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoN2/x/gh51SW7zBtlDdw8kguoXam//AdkUVcaB613Y=;
        b=cbyF1+G/PYCfJdIsDYB4GCClwzs5P2NwyJH9XgIwqdl1Is+ZkXQn/Tc9HeGw9/soBC
         Pb/axfAUxTelibb3cvAL4n1pHIUqrdcfVRbPbfZ9zMgcnAqSxANvVtD7C4r+YTsOHxkX
         OAqAuHVZpEJvbpD0A8n2Bsw4uBrd6ZCPxSgAI9KsHG+cOAmnKCovUBjKP3K+YeKBvwYn
         AF4Bu0YUJmmqYJIoH4JIfQjrBs3ICoEi+H4RpKIzOuNcEh1PgBBtUukDkY3hFLv84cNz
         4bofsVoRl494ZnRTbmkVYUxuV/lrx/d+OSKNihJZ4N1b3I9FwqviznXDWV2vPcIQ4nGb
         Wmcg==
X-Gm-Message-State: AOAM532YnHiEIQCLo7BWv/z5kEjAi5Ht5JLX23mxKAk53p5UlYOpdAfu
        fDyNLzUEJMeq6FoYD64wN6uW9qgdBxtkpA==
X-Google-Smtp-Source: ABdhPJwcEz3Nbm+ucmUtzh62V0Mc1rygdmwiquvrYWMo4GIJZz3vsAIg4JNlkSwlB1p+PkQuDXjuMw==
X-Received: by 2002:a05:620a:248f:: with SMTP id i15mr12701638qkn.239.1621431509269;
        Wed, 19 May 2021 06:38:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n64sm3269832qkb.111.2021.05.19.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 06:38:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: mark ordered extent and inode with error if we fail to finish
Date:   Wed, 19 May 2021 09:38:27 -0400
Message-Id: <5b855fadb3c1de5be46d01b23c77e512933de3b9.1621431374.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing error injection testing I saw that sometimes we'd get an
abort that wouldn't stop the current transaction commit from completing.
This abort was coming from finish ordered IO, but at this point in the
transaction commit we should have gotten an error and stopped.

It turns out the abort came from finish ordered io while trying to write
out the free space cache.  It occurred to me that any failure inside of
finish_ordered_io isn't actually raised to the person doing the writing,
so we could have any number of failures in this path and think the
ordered extent completed successfully and the inode was fine.

Fix this by marking the ordered extent with BTRFS_ORDERED_IOERR, and
marking the mapping of the inode with mapping_set_error, so any callers
that simply call fdatawait will also get the error.

With this we're seeing the IO error on the free space inode when we fail
to do the finish_ordered_io.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Wang Yugui noticed that this failed with btrfs/146, this is because we had
  already marked the mapping with the error when writeback failed, so we were
  double marking the mapping with an error and thus getting an extra report of
  the error.  Fix this by only setting the mapping error if we're the first ones
  to set ORDERED_IOERR.

 fs/btrfs/inode.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 955d0f5849e3..32a62ec4f127 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3000,6 +3000,19 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	if (ret || truncated) {
 		u64 unwritten_start = start;
 
+		/*
+		 * If we failed to finish this ordered extent for any reason we
+		 * need to make sure BTRFS_ORDERED_IOERR is set on the ordered
+		 * extent, and mark the inode with the error if it wasn't
+		 * already set.  Any error during writeback would have already
+		 * set the mapping error, so we need to set it if we're the ones
+		 * marking this ordered extent as failed.
+		 */
+		if (ret && !test_and_set_bit(BTRFS_ORDERED_IOERR,
+					     &ordered_extent->flags))
+			mapping_set_error(ordered_extent->inode->i_mapping,
+					  -EIO);
+
 		if (truncated)
 			unwritten_start += logical_len;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
-- 
2.26.3

