Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC525A9860
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiIANU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIANTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E0F51
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 972B0B826A8
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25B7C433D6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038319;
        bh=6zXj3CAfJxNMFI/x8djl6HcquqAJpIFiwQ/BTgLdf6E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TVqF5MNXZLLmvsSKnFh3qZGTPP0eF+llE4Gu+BbdwKQfn5uRjA3rTLE4y+Yc/3wJU
         Ah+Gouav+OZQWmstYwx14vPFF7igEQ9g4hf2SsmKwmqtwJbAihR6sQ7fHcVvSHT2fb
         VMObiUiCnvXkpb7vENuFyR1V9ifpaUJopAfjno+Z67yUAawAJaoBlfRF1MFBQgL97A
         M7879OX8LfhPuDiLLdq0Tev1xpZZurBVpnxkXqvO2IeG5QUeP4nh3QLBfvb96Bccp/
         PrTrSOU+OMbSR1Ag2gWzLsAF1ExnmkBlBCWrqjLaiSQCbB2Y5pApzvAnOsgULBZ7/o
         jFgkh0Fqop+dw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: allow fiemap to be interruptible
Date:   Thu,  1 Sep 2022 14:18:26 +0100
Message-Id: <5bf31c02f5117ece6a1f4709af1c8b938f149d3e.1662022922.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
References: <cover.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Doing fiemap on a file with a very large number of extents can take a very
long time, and we have reports of it being too slow (two recent examples
in the Link tags below), so make it interruptible.

Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e2143b6fba3..1260038eb47d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5694,6 +5694,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 				ret = 0;
 			goto out_free;
 		}
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto out_free;
+		}
 	}
 out_free:
 	if (!ret)
-- 
2.35.1

