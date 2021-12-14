Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1C474324
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 14:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhLNNCG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 08:02:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhLNNCG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 08:02:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1817A1F37C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639486925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AP47eM/bh2GPFBGF8DGj3SdbxtsWPyr/ylENRDgVcxU=;
        b=F36cupYtL1peWEPXQ2K4feW8bzjYKjkOIjwoRcHosM/uCgs63Y/LkMH5nL5zo1ASYBqKYd
        92E2SzZfkewc1u9u7WWtF41LbmZdni9jQSjlPVqMKpMKD+C/oeWre1LqLlJaLXIT4p/itf
        Sldk00QiETZDFDb73GiUJmAg+cTcCaQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4573313DD9
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 13:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDeiBcyVuGF3HQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 13:02:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: use btrfs_path::reada for scrub extent tree readahead
Date:   Tue, 14 Dec 2021 21:01:44 +0800
Message-Id: <20211214130145.82384-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214130145.82384-1-wqu@suse.com>
References: <20211214130145.82384-1-wqu@suse.com>
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

This patch will add the readahead for extent tree, so we can later
remove the btrfs_reada_add() based readahead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 41908f0c1e76..70457aadd721 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3247,6 +3247,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 */
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
+	path->reada = READA_FORWARD;
 
 	/*
 	 * trigger the readahead for extent tree csum tree and wait for
-- 
2.34.1

