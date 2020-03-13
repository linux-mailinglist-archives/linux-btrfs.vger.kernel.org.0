Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20D01850D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCMVRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:17:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34057 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:17:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id 59so8870662qtb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=akzROzxN4NVHYG7CSwuIw/FSKKbNKqfIOEDtlmD/N7I=;
        b=eAnlcLNlzP/OcN+fTzSUgTQ9aYhADopkfGc7H4kuYiD/IAS4Iq66z9F6/cG47LA656
         9VokssXNh2sghnfpEVJv5TNXBSeGIpzSAu59/iT0JyAas4GCNVyA25b4BW0p5n6NCYxv
         ANcgMhmCS+CXS7pojCdvv5RXIx9qDza3pxU60Dz+TGOwZlB5NhPHU+snvGfHFP/7WFwO
         xdx+fTi/fIQplm29n49x/bT+cfYCjjmqZQar66ai9IUTA0F+27DIpqtRzp4rn+uVN7wW
         ds3C3KHXtHCV3fOrPkg7FGeWwiN26UfHArqgfP8ASVYnRf4fb75Yjw4KJqO7VIflm28M
         2umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akzROzxN4NVHYG7CSwuIw/FSKKbNKqfIOEDtlmD/N7I=;
        b=UcFFqzc+Y0LfEGQwJ33C5U2BNu+pNIYvGKmanYleL+J/PtEvWmmLUhUXDcflNiSvEZ
         pKgFBufMTwDNwuPTDcQlAiA6pU1EUutfE0Sg9iSkUmi0DcDblQaqN2y2aVMDTGKXaMHX
         iflBLZNRXyhuFH+GIn7ET/25vAzS0aQSiJL9X41GESvVK3NERf+nXdWW3g0fRJvJ31G3
         zaXi6JNgcFqMXjEp+fxQI8rXVjZ5reb9cj5Q0rwiHHz56zTJx+M4/l0FRCTb2Hrhubmq
         HNpS5/oWLf19/8aKMPZkrafYz++bU1GRGb6rdimSmsG0o22K3diQ0Miu/mZa3kX8j7vk
         X53w==
X-Gm-Message-State: ANhLgQ3z6u14AIfwQFjRCAzvof705iUUyHc4vSLIjnWnpwhsBxQs9Uwf
        /0oPIWVkoqXG2N2c74b3/O+oFz0236ljcA==
X-Google-Smtp-Source: ADFU+vtpX63TDhvD9DgBCb3QUWQmKh+K2CWOgF2+OU4CE23xyFB7GhaN6V++fNGlSVp0w8i/MmzUfw==
X-Received: by 2002:ac8:3488:: with SMTP id w8mr14554091qtb.187.1584134233181;
        Fri, 13 Mar 2020 14:17:13 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x19sm30074462qtm.47.2020.03.13.14.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:17:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: move reserve_metadat_bytes up in relocate_tree_block
Date:   Fri, 13 Mar 2020 17:17:06 -0400
Message-Id: <20200313211709.148967-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211709.148967-1-josef@toxicpanda.com>
References: <20200313211709.148967-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're using this to also throttle delayed refs move it before the
select_reloc_root().  The reason we want this is because
select_reloc_root() will mess with the backref cache, and if we're going
to bail we want to be able to cleanly remove this node from the backref
cache and come back along to regenerate it.  Move it up so this is the
first thing we do to make restarting cleaner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3ccc126d0df3..df33649c592c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3134,6 +3134,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 	if (!node)
 		return 0;
 
+	/*
+	 * If we fail here we want to drop our backref_node because we are going
+	 * to start over and regenerate the tree for it.
+	 */
+	ret = reserve_metadata_space(trans, rc, node);
+	if (ret)
+		goto out;
+
 	BUG_ON(node->processed);
 	root = select_one_root(node);
 	if (root == ERR_PTR(-ENOENT)) {
@@ -3141,12 +3149,6 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (!root || test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
-		ret = reserve_metadata_space(trans, rc, node);
-		if (ret)
-			goto out;
-	}
-
 	if (root) {
 		if (test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
 			BUG_ON(node->new_bytenr);
-- 
2.24.1

