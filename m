Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750D73C2790
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGIQcK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 12:32:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhGIQcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 12:32:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D90B82239F
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625848164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=+jAfC1xSuLkiVCGX8RdqcmFLiINyCCtzXCHpm5KvWGU=;
        b=URdoL3rAJBGi91ev8UBbmonZ7ySK0L+tm79Z4cYxLCsJUiNqtgJZaQzu8Thz6aAJ7DM9ik
        LKfoKIACvF7m3iGYMYBlPPq86s06T27krfwicJb7kZFQkpM6tOtwkhScGLT/mwRCOf3ro6
        0QwoMBOrkrG48UdP5kJHG1JnKI8My60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625848164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=+jAfC1xSuLkiVCGX8RdqcmFLiINyCCtzXCHpm5KvWGU=;
        b=xpazjG9ghPDLjUPhN2dhpv+MUgVPw6f6GfnvhfF+Rx0EGPLeFTP0wsrE9ckdGCpaZ9vNhR
        zGHl1PtY1uxNG3Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 754DC13A60
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 16:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R7diEWR56GBrUQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 16:29:24 +0000
Date:   Fri, 9 Jul 2021 11:29:22 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: mark compressed range uptodate only if all bio succeed
Message-ID: <20210709162922.udxjidc3kgxkgzx3@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In compression write endio sequence, the range which the compressed_bio
writes is marked as uptodate if the last bio of the compressed (sub)bios
is completed successfully. There could be previous bio which may
have failed which is recorded in cb->errors.

Set the writeback range as uptodate only if cb->errors is zero, as opposed
to checking only the last bio's status.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9a023ae0f98b..30d82cdf128c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -352,7 +352,7 @@ static void end_compressed_bio_write(struct bio *bio)
 	btrfs_record_physical_zoned(inode, cb->start, bio);
 	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
 			cb->start, cb->start + cb->len - 1,
-			bio->bi_status == BLK_STS_OK);
+			!cb->errors);
 
 	end_compressed_writeback(inode, cb);
 	/* note, our inode could be gone now */
-- 
2.32.0
