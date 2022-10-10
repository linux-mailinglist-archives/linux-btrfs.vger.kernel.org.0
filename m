Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF45F9CD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiJJKgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJJKgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:36:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C857BE6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:36:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B60C31F8AC
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665398190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1jMgs/mUMH5Wsckg4NUad4SJe7QX0wxxgJHaY1yJp0=;
        b=PpNvN7lQffhyWqqH/oFMJPb0jySH1bMDgywK1AjUftnYTZks0b9e9W2z7tez80VFNbVQMT
        ykADXNj01WL1aMPHbzkIGpCQw9xDVSXHz5Vxe+O/v/VomQqtG1m/hl61g7yk9gqTLcgh0q
        zd/sl22K99ul5qL+eEMl+8XZ2+2YD3E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0663013ACA
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBRmL631Q2M9LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: raid56: avoid double freeing for rbio if full_stripe_write() failed
Date:   Mon, 10 Oct 2022 18:36:07 +0800
Message-Id: <d36ad8fbdc5d90ff09575ed7669eeb6b8048e013.1665397731.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665397731.git.wqu@suse.com>
References: <cover.1665397731.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if full_stripe_write() failed to allocate the pages for
parity, it will call __free_raid_bio() first, then return -ENOMEM.

But some caller of full_stripe_write() will also call __free_raid_bio()
again, this would cause double freeing.

And it's not a logically sound either, normally we should either free
the memory at the same level where we allocated it, or let endio to
handle everything.

So this patch will solve the double freeing by make
raid56_parity_write() to handle the error and free the rbio.

Just like what we do in raid56_parity_recover().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 892005f756cf..82c8e991300e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1632,10 +1632,8 @@ static int full_stripe_write(struct btrfs_raid_bio *rbio)
 	int ret;
 
 	ret = alloc_rbio_parity_pages(rbio);
-	if (ret) {
-		__free_raid_bio(rbio);
+	if (ret)
 		return ret;
-	}
 
 	ret = lock_stripe_add(rbio);
 	if (ret == 0)
@@ -1823,8 +1821,10 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	 */
 	if (rbio_is_full(rbio)) {
 		ret = full_stripe_write(rbio);
-		if (ret)
+		if (ret) {
+			__free_raid_bio(rbio);
 			goto fail;
+		}
 		return;
 	}
 
@@ -1838,8 +1838,10 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 		list_add_tail(&rbio->plug_list, &plug->rbio_list);
 	} else {
 		ret = __raid56_parity_write(rbio);
-		if (ret)
+		if (ret) {
+			__free_raid_bio(rbio);
 			goto fail;
+		}
 	}
 
 	return;
-- 
2.37.3

