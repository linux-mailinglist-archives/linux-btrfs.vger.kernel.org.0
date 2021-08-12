Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349303E9DF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhHLFfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:35:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33620 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhHLFfk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:35:40 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 431981FF0B
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628746515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WirGfeoK/nfRbqXUaAwbbxVr5os2SrD41no2c/RL1k=;
        b=jry4b97LcBLQApJyZNgDjk2VQj+Wp70r3ny5vFlhxgEwnkwx6IZAYx1LbVx5aCqbTqzMFz
        9X14ycdqaDtKPGzSI3mvCoivM+h/Q8Zvf3flEZS/iiUf7DTgdxdkTg+plCmkPPQw6paOyB
        k2hNaOzVedhtaXSsP9bEUoyCNIOJJC4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8153913838
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aAwgERKzFGFeZQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: map-logical: loosen the required trees to open the filesystem
Date:   Thu, 12 Aug 2021 13:35:07 +0800
Message-Id: <20210812053508.175737-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812053508.175737-1-wqu@suse.com>
References: <20210812053508.175737-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs-map-logical, it only requires chunk tree to do the
logicla->physical mapping.

All othe trees are not really needed.

Loosen the required trees to make btrfs-map-logical to work better on
corrupted fs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-map-logical.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index 21f00fa20ce8..9f119d08bad8 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -261,7 +261,8 @@ int main(int argc, char **argv)
 	radix_tree_init();
 	cache_tree_init(&root_cache);
 
-	root = open_ctree(dev, 0, 0);
+	root = open_ctree(dev, 0, OPEN_CTREE_PARTIAL |
+				  OPEN_CTREE_NO_BLOCK_GROUPS);
 	if (!root) {
 		fprintf(stderr, "Open ctree failed\n");
 		free(output_file);
-- 
2.32.0

