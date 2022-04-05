Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4EB4F3F59
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiDEPDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391998AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B13B7C4
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5EE1F745
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dm9wZpHzLRu1m2ubYA86QwPouRFMqU1XtBiS4Cecasc=;
        b=NVTTu1hf2lsNCBSpFCPFC3w9uFGlBOhqmcQzx4sG/6lZaiOfwS908M6EION6BfB/ZVC16K
        Mv2xx6rIiYKKyIuQcV3aiez7+rolw8hSJ5vyE6V09A8EDPCTPFYHRrazMHT90h0On0etK9
        n9h4IcYXuj6D48tcoHFem2jmJr0Tqf8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F42D13A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OKcoFrE6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs-progs: remove the unnecessary BTRFS_SUPER_INFO_OFFSET path for tree block read
Date:   Tue,  5 Apr 2022 20:48:23 +0800
Message-Id: <1011cb461b7520030b1ea1eb5bb02804460a4d1c.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
References: <cover.1649162174.git.wqu@suse.com>
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

We used to use read_whole_eb() to read super block, but it's no longer
the case (so long that I can not even find out which commit did the
conversion).

Thus there is no need for read_whole_eb() to handle super block read
anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 2a9b2681a043..f2492547f77d 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -302,8 +302,7 @@ int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirr
 		read_len = bytes_left;
 		device = NULL;
 
-		if (!info->on_restoring &&
-		    eb->start != BTRFS_SUPER_INFO_OFFSET) {
+		if (!info->on_restoring) {
 			ret = btrfs_map_block(info, READ, eb->start + offset,
 					      &read_len, &multi, mirror, NULL);
 			if (ret) {
-- 
2.35.1

