Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96E5466179
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356995AbhLBKeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:34:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50524 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356980AbhLBKeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:34:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C29F9CE2206
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EE0C53FD0
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638441048;
        bh=FH5/aMjQb7dh7n92dAky3VGE4WCmnzptcGr/oaeoFuw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PrVvwgKw0S3kcPOqPeDCSqOHt5xacxkwoirsak6V98qKNGalR7u3ctvGwNyz71gJy
         cBGwcUuxR5M8iTmMR+EXQVAEvzDWCP8xVPKhgY89bfqMsBCDkIOrAbsLvRi+T544HM
         9Om6ECDEER/MdIDyRabL61wlwyF2UCEoqYjXEFRntXZ15VXyNXNF4yVqS1Gm8Va1F2
         AmTQzXlXO3I1y4hg6lXVdiJHmYxEo1w2FiC9vRiIcLYSr/rP8WJf3bHKpqXPJtxY7V
         Rmh4w8VxyjO82TthdbLAEhfewXH7xvjCJ3yh+1u0cWitcDf/FcVGutJm8NThpUXLNO
         cAHDBzBvig/FQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: remove BUG_ON() after splitting leaf
Date:   Thu,  2 Dec 2021 10:30:39 +0000
Message-Id: <966e008cdf776b803b96a87756aa58917212a0c6.1638440535.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After calling split_leaf() we BUG_ON() if the returned value is greater
than zero. However split_leaf() only returns 0, in case of success, or a
negative value in case of an error.

The reason for the BUG_ON() is that if we ever get a positive return
value from split_leaf(), we can not simply propagate it to the callers
of btrfs_search_slot(), as that would be interpreted as "key not found"
and not as an error. That means it could result in callers ending up
causing some potential silent corruption.

So change the BUG_ON() to an ASSERT(), and in case assertions are
disabled, produce a warning and set the return value to an error, to make
it not possible to get into a silent corruption and having the error not
noticed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 15357274a0c4..bcf99c787d68 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1817,7 +1817,9 @@ static int search_leaf(struct btrfs_trans_handle *trans,
 
 			err = split_leaf(trans, root, key, path, ins_len,
 					 (ret == 0));
-			BUG_ON(err > 0);
+			ASSERT(err <= 0);
+			if (WARN_ON(err > 0))
+				err = -EUCLEAN;
 			if (err)
 				ret = err;
 		}
-- 
2.33.0

