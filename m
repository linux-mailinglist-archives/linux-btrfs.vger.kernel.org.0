Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6722E3E9DF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhHLFfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:35:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhHLFfi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:35:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2B5522232
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628746512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FxPXhjmMOvUQPQnVtzE3BcTW1VeRblOuUzgLw0zeZM=;
        b=na/b7wWUyo+IbAY9F0XdEOgMMmcBthyElmPKCJqkteSB1seG9UckbjWK8c00A0mj+92t8f
        K52md4UpBqX8gs9/v88BuDcB3ezfQYh9fijxCMJ5hJblk4djfbS7d5osQ6XNIX3k27/tap
        KYOJs0ecOZJjKHS3x/UPfR68c5zaPTk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1ACA513838
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WNq3Mw+zFGFeZQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: map-logical: use sectorsize as default size
Date:   Thu, 12 Aug 2021 13:35:05 +0800
Message-Id: <20210812053508.175737-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812053508.175737-1-wqu@suse.com>
References: <20210812053508.175737-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Originally btrfs-map-logical is utilizing function debug_read_block(),
which pretents to read an extent buffer from disk, thus it uses nodesize
as default mapping size.

But after commit eb81f8d263ce ("btrfs-progs: map-logical: Rework
map-logical logics") it no longer requires an extent buffer to do the
mapping.

Thus the default mapping size is no longer needed to be nodesize.

Thus change the default size to sectorsize.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-map-logical.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index b35677730374..eff0b89dbec6 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -288,7 +288,7 @@ int main(int argc, char **argv)
 	}
 
 	if (bytes == 0)
-		bytes = root->fs_info->nodesize;
+		bytes = root->fs_info->sectorsize;
 	cur_logical = logical;
 	cur_len = bytes;
 
-- 
2.32.0

