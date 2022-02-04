Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE04A94E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiBDINO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 03:13:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56356 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiBDINO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 03:13:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 660EB210DE
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643962393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4y2ZLEN1EVAmrFXFmk1WXD6S0rxPM6KL1kg6PksdHzw=;
        b=I5prE5TrDKP6BXnwxj0wHgDFwSzebnLCW7g1X3HogSfcb2hKodiSX5wakWtzZy8ubXvNYn
        Ai6PH+PY+R/oimbeUxOUdH1i4N1oboKwFz2EPihTb0gIjzCUKLiIPWemyarUdlEGpEUapA
        aPHIqDDeF7Rb9wR059as5yC3h/LkmnU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15837132DB
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CGf9M+Hf/GFUVwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 08:12:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
Date:   Fri,  4 Feb 2022 16:11:55 +0800
Message-Id: <39643a206e4439d0461780a52b9e0a734d75290a.1643961719.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1643961719.git.wqu@suse.com>
References: <cover.1643961719.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

And since we're here, replace the hardcoded bit flags (1, 2) with
(1UL << 0) and (1UL << 2), respectively.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/uapi/linux/btrfs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 1cb1a3860f1d..57332a529c4e 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -576,8 +576,10 @@ struct btrfs_ioctl_clone_range_args {
  * Used by:
  * struct btrfs_ioctl_defrag_range_args.flags
  */
-#define BTRFS_DEFRAG_RANGE_COMPRESS 1
-#define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS	(1UL << 0)
+#define BTRFS_DEFRAG_RANGE_START_IO	(1UL << 1)
+#define BTRFS_DEFRAG_RANGE_FLAGS_MASK	(BTRFS_DEFRAG_RANGE_COMPRESS |\
+					 BTRFS_DEFRAG_RANGE_START_IO)
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
-- 
2.35.0

