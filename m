Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7145B6763
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 07:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiIMFbk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 01:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiIMFbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 01:31:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4254CA0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 22:31:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C3D45BD02
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663047094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKxHFWx6UPZAYP6Vd7eiJXaRoK0pldiFcCMKLdiri84=;
        b=fyHzqya518ult0RZohMYUZfcNsR+q0DdtbLc0ZtpI6aNI8eGSc8NacOAHwRDrlwWrDcojc
        ye7wU4KbNjOB+AO+SPht4sVFvZMdOM/CPiOcYPepF2+1YnNLli99Xvn4Qi83GJfQhxLh2p
        G5PslYeh8vjsPxR8HYIsuC1EvkbkBUk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91F2213A86
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QJm7FbUVIGO5VwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:31:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: update the comment for submit_extent_page()
Date:   Tue, 13 Sep 2022 13:31:12 +0800
Message-Id: <e348ecdbf6ab68956ba1cd04c51e662ee3589f4d.1663046855.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663046855.git.wqu@suse.com>
References: <cover.1663046855.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 390ed29b817e ("btrfs: refactor submit_extent_page() to make
bio and its flag tracing easier"), we are using bio_ctrl structure to
replace some of arguments of submit_extent_page().

But unfortunately that commit didn't update the comment for
submit_extent_page(), thus some arguments are stale like:

- bio_ret
- mirror_num
  Those are all contained in bio_ctrl now.

- prev_bio_flags
  We no longer use this flag to determine if we can merge bios.

So this patch will update the comment for submit_extent_page() to keep
it up-to-date.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cea7d09c2dc1..a3e8232c25ed 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3347,11 +3347,13 @@ static int alloc_new_bio(struct btrfs_inode *inode,
  * @size:	portion of page that we want to write to
  * @pg_offset:	offset of the new bio or to check whether we are adding
  *              a contiguous page to the previous one
- * @bio_ret:	must be valid pointer, newly allocated bio will be stored there
  * @end_io_func:     end_io callback for new bio
- * @mirror_num:	     desired mirror to read/write
- * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
  * @compress_type:   compress type for current bio
+ *
+ * The function will either add the page into the existing @bio_ctrl->bio,
+ * or allocate a new one in @bio_ctrl->bio.
+ * The mirror number for this IO should already be initizlied in
+ * @bio_ctrl->mirror_num.
  */
 static int submit_extent_page(blk_opf_t opf,
 			      struct writeback_control *wbc,
-- 
2.37.3

