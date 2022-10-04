Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6FC5F3D6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Oct 2022 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJDHoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJDHoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 03:44:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2FC4620D
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 00:44:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CADF21F929
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664869438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KkdgxKFFTF+uMySUqIWSg+w0rYq8bRuZaG30BxnzJA=;
        b=C/KWV63IWG75gX4TRST4PQVW5g+84yLVQICas3iw3SwQrZrGdMBOTsXxt3gFttgvsdS0Mc
        oqWeu8WHbA/ACcX8fBchyi7EQ+wBuAb5AhUj4XCDf304fmHlYIHrdRYDv8glkYLLzbTMS+
        brkPEyLkGMMnci5HUjyDMnQR2xD6+kE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20CAA139EF
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 07:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ABgpNz3kO2PxOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Oct 2022 07:43:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: properly initialized extent generation for __btrfs_record_file_extent()
Date:   Tue,  4 Oct 2022 15:43:38 +0800
Message-Id: <c06aff30ab435f40f77f56fd8c049a00161cb90c.1664869157.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664869157.git.wqu@suse.com>
References: <cover.1664869157.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When using mkfs.btrfs --rootdir option, the data extents generated will
has 0 as their generation in extent tree:

  # mkdir /tmp/rootdir
  # xfs_io -f -c "pwrite 0 16k" /tmp/rootdir
  # mkfs.btrfs -f --rootdir /tmp/rootdir $dev
  # btrfs ins dump-tree -t extent $dev
  btrfs-progs v5.19.1
  extent tree key (EXTENT_TREE ROOT_ITEM 0)
  leaf 30474240 items 13 free space 15536 generation 7 owner EXTENT_TREE
  leaf 30474240 flags 0x1(WRITTEN) backref revision 1
  fs uuid c1f05988-49f9-4dd4-8489-b90d60f522ee
  chunk uuid 40f81603-fe75-4f58-aa9e-e74e28df8523
	item 0 key (13631488 EXTENT_ITEM 16384) itemoff 16230 itemsize 53
		refs 1 gen 0 flags DATA <<< Generation is 0
  ...

[CAUSE]
In __btrfs_record_file_extent() we just set the extent generation to 0.

[FIX]
Use trans->transid to properly fill extent generation.

Now after mkfs, the first data extent backref looks like this:

	item 0 key (13631488 EXTENT_ITEM 16384) itemoff 16230 itemsize 53
		refs 1 gen 7 flags DATA
        ...

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 3a058a8698ee..92d5c521abe8 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3582,7 +3582,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 					    struct btrfs_extent_item);
 
 			btrfs_set_extent_refs(leaf, ei, 0);
-			btrfs_set_extent_generation(leaf, ei, 0);
+			btrfs_set_extent_generation(leaf, ei, trans->transid);
 			btrfs_set_extent_flags(leaf, ei,
 					       BTRFS_EXTENT_FLAG_DATA);
 			btrfs_mark_buffer_dirty(leaf);
-- 
2.37.3

