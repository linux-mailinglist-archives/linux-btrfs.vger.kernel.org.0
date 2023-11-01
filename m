Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB37DE57D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 18:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbjKARni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjKARnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 13:43:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4710E;
        Wed,  1 Nov 2023 10:43:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7001621A3E;
        Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698860606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAPb7AUyS8Sa7nt7J0Gh+N9Q7PPxJ73EwS5LWyR+yVM=;
        b=APcl+86OgTYkYFTAidJBzWL2x20ZzMNtZySekTI6YWTeppZB7Y4e7/WdgH+iOJMutGP3zu
        Is8213PlPglYz+YI2u8WE6M3MKyBimVDHCbZ7gaUa0iWRAI8xXx8cCeqrheMpIRjBa/4Je
        Z9EwxItfKVNdRNJRNm0E9PxJ+s1Ux/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698860606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAPb7AUyS8Sa7nt7J0Gh+N9Q7PPxJ73EwS5LWyR+yVM=;
        b=acpl0gTtnUUfB0RLR987knsM3JWjNCcCaQIlp1lqN/WIm18XtbHrdBJUfLRa4ymF1R/Je5
        erXEyBrAeLoIdsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D6BF1348D;
        Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z0fHFj6OQmUmYQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 17:43:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DCEFBA0767; Wed,  1 Nov 2023 18:43:25 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        <linux-xfs@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
Subject: [PATCH 4/7] btrfs: Do not restrict writes to btrfs devices
Date:   Wed,  1 Nov 2023 18:43:09 +0100
Message-Id: <20231101174325.10596-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101173542.23597-1-jack@suse.cz>
References: <20231101173542.23597-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=jack@suse.cz; h=from:subject; bh=pEwCsUz1St/xR0Od9vpX4Oa1kDf92xqHr2SB5l976Yo=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGFKd+nSniFlMt2oqNUz5OS2/U2bLxGidPevbJ87jnfaswy5H WWlTJ6MxCwMjB4OsmCLL6siL2tfmGXVtDdWQgRnEygQyhYGLUwAmErmcg6E7l9vGnE2y5kiInuaXRk ONX2yCO/I8b98Se81raHnQ391Bcl3pL6/Q33lXDR2SU546nn/p/OhW88bZjWduTU1uuRtV326zrfBl okbCR24mwW3X0hd7N81oN8xcGz6F8Y44d8rKl6Ir9A/P5dX+0rP49Zm9lp4b/jpWvtyifEy9zlP6tS aHZsuf/ZVr7+fH3H8ucyIvKJNjY0PuzfZApy25Xnlh1ZO0+D72Tjsa31Gwr0N8cS17SNif8pSIQxqf vE8wR811a6yL4Z6YrO8ccCdgX2RKaaWxaqK15av25kZm/dmbf1/czBEV8cgs91FZTsxnVz6pvy+374 rola7g9p66++++vRG6b+xSbz0GAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs device probing code needs adaptation so that it works when writes
are restricted to its mounted devices. Since btrfs maintainer wants to
merge these changes through btrfs tree and there are review bandwidth
issues with that, let's not block all other filesystems and just not
restrict writes to btrfs devices for now.

CC: linux-btrfs@vger.kernel.org
CC: David Sterba <dsterba@suse.com>
CC: Josef Bacik <josef@toxicpanda.com>
CC: Chris Mason <clm@fb.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6ecf78d09694..0ceeb9517177 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1403,6 +1403,8 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 			return ERR_PTR(error);
 	}
 
+	/* No support for restricting writes to btrfs devices yet... */
+	mode &= ~BLK_OPEN_RESTRICT_WRITES;
 	/*
 	 * Setup a dummy root and fs_info for test/set super.  This is because
 	 * we don't actually fill this stuff out until open_ctree, but we need
-- 
2.35.3

