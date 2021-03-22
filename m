Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF43436E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 03:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhCVC6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhCVC6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 22:58:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81856C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 19:58:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so15090529wrn.0
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 19:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIowy3iK6c5dODdqV7FzL5lTygPgHIthJY8xldBe6F8=;
        b=VS+r++qato0R6FFoIH2M3/zoL+pNp7V0R7OK78FUfkA5Op/Wozfwx7DRoEgqjgKt69
         ngatHMiOTH6ofibuhcZKtgiQV7HYpDsa6avF+rnSgQ9tGEyTc5pbjrwIcJnmc6yv4mRg
         ITVc7xamAzPkofbOlbGRvYsYJni3muBWlDZnmkQCWM40pcRRmKVJ3zWQhx9qvqf8h/MG
         8RZN3AChSgygLdc7GpjvmyIfIYL/RwyWrDcb6ZE5zVRcqahmCX1Zgc3VnS97mV4SGesv
         g589a4jaCAG8k6QAM+0utVodNFLSSn8JWpyERTptggKZRb6N5hXKiMcyA0GtOFx6CDNY
         9Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIowy3iK6c5dODdqV7FzL5lTygPgHIthJY8xldBe6F8=;
        b=k3XmhJJa3u6ia0wpHSccCYI4RPXRKpVrnwE5+rszdI3NxoJaHii0E5K/oRqp+cqXD5
         zOSATb1+VWXR8xhK+sp0c+ofLLYmmIF9gijaqlHI3KGdqrW3uuRsfLJFL/90cIyXMd1P
         YackcPmZotZnHKpyncwmfzX2T8+JF4O1HRMg9/IQ3yORXb2DWZf19SVCAY2zDjyw9nTB
         ae5Fc/Yzjd07NKH5pydw3xHM9volfvKt6KShG6EeKPyWm+cGzLjAyhs/fHa4L3vhEDr+
         BYU8VTiMyZmOqGsjLVXks+PzUlG1dgsoAMeuz3YQX8vN6IFOQtZKIsq53ed7ozI0umZX
         6peg==
X-Gm-Message-State: AOAM530Xd3qtU6tZ549EYJBp7oCwxc8uPOg/wmBEC2ONabx/MG8gIk36
        3QUFzkACXLTtd1uyVspXRcMZRAAoSI9h6Plx
X-Google-Smtp-Source: ABdhPJz9hOOQGOE4aH03xHpgTY5TU5KtZHPtJTEbFdzaguV3t5tNwDNx+7ZQ1XCalpc58aCbc9IDZg==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr9297638wrp.231.1616381920798;
        Sun, 21 Mar 2021 19:58:40 -0700 (PDT)
Received: from localhost.localdomain ([95.68.85.155])
        by smtp.gmail.com with ESMTPSA id m11sm17032258wrz.40.2021.03.21.19.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:58:40 -0700 (PDT)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] btrfs-progs: For btrfs-map-logical proceed even with some extent corruption
Date:   Mon, 22 Mar 2021 05:02:07 +0200
Message-Id: <20210322030207.34335-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If extent tree is corrupted then open_ctree without OPEN_CTREE_NO_BLOCK_GROUPS
does fail preventing use of btrfs-map-logical at all.
Also even if we can't find extent it still can be useful to get physical
offset which could be correct.

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 btrfs-map-logical.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index 24c81b8d..d121a8c4 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -261,7 +261,7 @@ int main(int argc, char **argv)
 	radix_tree_init();
 	cache_tree_init(&root_cache);
 
-	root = open_ctree(dev, 0, 0);
+	root = open_ctree(dev, 0, OPEN_CTREE_NO_BLOCK_GROUPS);
 	if (!root) {
 		fprintf(stderr, "Open ctree failed\n");
 		free(output_file);
@@ -298,6 +298,9 @@ int main(int argc, char **argv)
 		errno = -ret;
 		fprintf(stderr, "Failed to find extent at [%llu,%llu): %m\n",
 			cur_logical, cur_logical + cur_len);
+		fprintf(stderr, "Trying a guess!\n");
+		print_mapping_info(root->fs_info, logical, bytes);
+
 		goto out_close_fd;
 	}
 	/*
@@ -358,6 +361,8 @@ int main(int argc, char **argv)
 	if (!found) {
 		fprintf(stderr, "No extent found at range [%llu,%llu)\n",
 			logical, logical + bytes);
+		fprintf(stderr, "Trying a guess!\n");
+		print_mapping_info(root->fs_info, logical, bytes);
 	}
 out_close_fd:
 	if (output_file && out_fd != 1)
-- 
2.30.2

