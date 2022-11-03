Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969361855A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiKCQxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiKCQxf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 12:53:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84657B7EE
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 09:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23B45B8295E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 16:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B2AC433D7
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667494411;
        bh=yatMWFl39r/OE7UTTbcPbvyoAW1RGdrPnOb1sMiIcZA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GA+PH8WKNcaLu9HkF/SZQ1AWOgFI58pYCrBtt19V40+8COzY8SRUaxCUmuc7qJX7h
         1NmD6PJzMNUuKAJh/fS2V5ul4Gcm8zJ7cRzVWT/FcPxzn0V7V/4dn5h4CEIpEXhJku
         XIrhLD7cbKl+iQidBBV4tr0fh670u0VnQ1vFgjWYuUMHMEWJ1oz5E1EnQD9ZxQT1es
         2lyHfxTZczfuxWApHYi1O5pTGWxFG+FXHkA98xvd6OhJROMe5Yma1cwV4qL/Hu5h9n
         G637qrGHgi9WhOL3Bsdtb4aBzHzl5N+seP+AjIweQYlW593PHRqteiqBkVEbIgcxkD
         OFT29OvfHLwKg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: receive: fix parsing of attributes field from the fileattr command
Date:   Thu,  3 Nov 2022 16:53:26 +0000
Message-Id: <d6c43dfa29a3ab6015e82a030b8f869470d3fd76.1667494221.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667494221.git.fdmanana@suse.com>
References: <cover.1667494221.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We're trying to get a U32 for the attributes, but the kernel sends a U64
(which is correct as we store attributes in a u64 flags field of the
inode). This makes anyone trying to receive a v2 send stream to fail with:

    ERROR: invalid size for attribute, expected = 4, got = 8

We actually recently got such a report of someone using send stream v2 and
getting such failure. See the Link tag below.

Link: https://lore.kernel.org/linux-btrfs/6cb11fa5-c60d-e65b-0295-301a694e66ad@inbox.ru/
Fixes: 7a6fb356dc65 ("btrfs-progs: receive: process setflags ioctl commands")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/send-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 72a25729..e9f565e6 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -570,7 +570,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 		break;
 	case BTRFS_SEND_C_FILEATTR:
 		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
-		TLV_GET_U32(sctx, BTRFS_SEND_A_FILEATTR, &fileattr);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_FILEATTR, &fileattr);
 		ret = sctx->ops->fileattr(path, fileattr, sctx->user);
 		break;
 	}
-- 
2.35.1

