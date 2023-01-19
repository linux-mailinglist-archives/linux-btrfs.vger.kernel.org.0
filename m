Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E406745A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjASWO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjASWNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:48 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20568A8393
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:37 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id p96so2465988qvp.13
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iqMaeL2/3iIa7APep2tYpwUpwF7cWyXv1iyiMsdJsQ=;
        b=Fx7HSwrB39VTGW1EALVtYGu8rh+dtutaTTjbW/LIDH9JTKL18r1Hmn0QzgAB6kIufL
         Eo7Z8dYCm/cz2Jzcw35rXbG30LQhmMhHW3LUR+zrrAGuXqUtKm+H9fY6MhqF3QgwZSGr
         1t86XNaJTTmKU3mm7hMOh0TAbjPpFKHfYt+NZgZDIBIme/Po0RlUPAe0KJICiOIfS70c
         +rX0SyZ6gTh8ogSdHmvlMnq7OMiRWNA3c5fHbp6djS/KzxzNzHGVuPCHFCELkWsR9djw
         xjqIyaNjpT0gcftz9dKaphluHOztthNcD6QB7Lhn+fcyG6T+aWp8JtZx7oPzUZJt7PqK
         ClnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iqMaeL2/3iIa7APep2tYpwUpwF7cWyXv1iyiMsdJsQ=;
        b=NJqDzHWijdiLOKOCRkZMQcEXMjHjDJkmWl6+pDAToD4VXkVg5GxaJxw/kRvTMKephP
         IPBaCvxh0HXKsBD/I8nTqwUNhc2y2TnAqymGIlXedWLjcPNLcTSXzlVqfEq9D0mcGZB6
         mGO0cLZFbm4NPju9B1p6BPjn3/LR2r+jz9hyX6O5r5o6DYJfQxHf2NlBU06mzTlcN97V
         fyj52A9t8/tMCD7TET+oHuyT+squWVLE2diC3eE9qM2GDX6aTS87ipnJnju+TjWhRqaU
         8+MkJNICfwRpG03qt4bzGSraflGgm4aUF6OcydUCE4++X1coRFBPH6rdGoLxrbcnxeZF
         AHCg==
X-Gm-Message-State: AFqh2kpdV5SCnNR+SmXdaqAnPaLUSe1xhq6cRC9MBEsH7cYMBGwIYfOW
        T1mOfCrjm3A9uj2WR41oYELIIuFRkPXWV+QNGdY=
X-Google-Smtp-Source: AMrXdXudiah2BMOx6rydCSWzjtg3npKI2+6A3tr4JjNTflm11A/4qPIuTLh0IvQ2pCbG3BZeTwO87Q==
X-Received: by 2002:a05:6214:3991:b0:535:90a:48c1 with SMTP id ny17-20020a056214399100b00535090a48c1mr18120093qvb.18.1674165215779;
        Thu, 19 Jan 2023 13:53:35 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bs15-20020a05620a470f00b006b61b2cb1d2sm25020122qkb.46.2023.01.19.13.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 6/9] btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
Date:   Thu, 19 Jan 2023 16:53:22 -0500
Message-Id: <7b486c703b7d8d595be4afbdea50306db5f88bc2.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only add if we set the extent buffer dirty, and we subtract when we
clear the extent buffer dirty.  If we end up in set_btree_ioerr we have
already cleared the buffer dirty, and we aren't resetting dirty on the
extent buffer, so this is simply wrong.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c87be46e0663..7cd4065acc82 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2467,13 +2467,6 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	 */
 	mapping_set_error(page->mapping, -EIO);
 
-	/*
-	 * If we error out, we should add back the dirty_metadata_bytes
-	 * to make it consistent.
-	 */
-	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-				 eb->len, fs_info->dirty_metadata_batch);
-
 	/*
 	 * If writeback for a btree extent that doesn't belong to a log tree
 	 * failed, increment the counter transaction->eb_write_errors.
-- 
2.26.3

