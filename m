Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2085F472CE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 14:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhLMNLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 08:11:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35282 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhLMNLS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 08:11:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57322212B7
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639401076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pD+6WTDU3GTYEM94e6LHursanoM4BUoLAQ+aqRpoHVs=;
        b=Ns1KfpxMX/EmffA/Yx2PH/e0U1sKbMJiXiUOrOnU4oax0wS5t769bOktyD6IajJnN8Co0v
        i0VpnUpft7e7tvDmMyU6vR0sdIgqMgKI5Yngm+qT/hYA78R+hGaPW7W9ZkFKlDn3aAX+61
        PHeMAsYKLJp3nkZ9Uej/dr/PmRz1fak=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADBE813D6E
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sHDpHXNGt2EFCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use btrfs_path::reada for scrub extent tree readahead
Date:   Mon, 13 Dec 2021 21:10:54 +0800
Message-Id: <20211213131054.102526-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213131054.102526-1-wqu@suse.com>
References: <20211213131054.102526-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For scrub, we trigger two readahead for two trees, extent tree to get
where to scrub, and csum tree to get the data checksum.

For csum tree we already trigger readahead in
btrfs_lookup_csums_range(), by setting path->reada.
But for extent tree we don't have any path based readahead.

This patch will add the readahead for extent tree.

With path based readahead only, on SSDs the scrub speed is the same as
previous btrfs_reada_add() mechanism.
While on HDDs, the scrub speed get degraded by at most 5%, although not
the best case, it's still pretty acceptable, especially considering how
many bugs there are in the old btrfs_reada_add() mechanism recently.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e1c8e8812793..aca80a12a930 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3242,6 +3242,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 */
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
+	path->reada = READA_FORWARD;
 
 	logical = base + offset;
 	physical_end = physical + nstripes * map->stripe_len;
-- 
2.34.1

