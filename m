Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB74532A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 14:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbhKPNOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 08:14:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36208 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhKPNOH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 08:14:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 161001FD2A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Nov 2021 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637068270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=E4Mnid+S4z8buSnD0TvC1N6KKw5fYlzrHTktdrKuM2g=;
        b=IB0uYBHQPD8jN3jwrQauvHbTy1OJSpuusAXu0218ZmjlnQUsQKAltaQBmR9+fqGOplgEd0
        /To6YR02FzjeYORamXTIteOSn97dQ78ECkoaPlqGkehYuw3G5q4YaybtAwVEe1Va3wUJTt
        S/UziqccNORfizeJxjFB6ZsPdS+xNnc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 601F813C1B
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Nov 2021 13:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id En/oCe2tk2HxcwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Nov 2021 13:11:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: raid56: fix the wrong recovery condition for data and P case
Date:   Tue, 16 Nov 2021 21:10:51 +0800
Message-Id: <20211116131051.247977-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug in raid56_recov() which doesn't properly repair data and
P case corruption:

	/* Data and P*/
	if (dest2 == nr_devs - 1)
		return raid6_recov_datap(nr_devs, stripe_len, dest1, data);

Note that, dest1/2 is to indicate which slot has corruption.

For RAID6 cases:

[0, nr_devs - 2) is for data stripes,
@data_devs - 2 is for P,
@data_devs - 1 is for Q.

For above code, the comment is correct, but the check condition is
wrong, and leads to the only project, btrfs-fuse, to report raid6
recovery error for 2 devices missing case.

Fix it by using correct condition.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
But I'm more interested in why this function is still there, as there
seems to be no caller of this function in btrfs-progs anyway.
---
 kernel-lib/raid56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-lib/raid56.c b/kernel-lib/raid56.c
index a94a60ed73d0..6f690484c810 100644
--- a/kernel-lib/raid56.c
+++ b/kernel-lib/raid56.c
@@ -343,7 +343,7 @@ int raid56_recov(int nr_devs, size_t stripe_len, u64 profile, int dest1,
 		return raid6_recov_data2(nr_devs, stripe_len, dest1, dest2,
 					 data);
 	/* Data and P*/
-	if (dest2 == nr_devs - 1)
+	if (dest2 == nr_devs - 2)
 		return raid6_recov_datap(nr_devs, stripe_len, dest1, data);
 
 	/*
-- 
2.33.1

