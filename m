Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03103E9DF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhHLFfk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:35:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54278 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhHLFfj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:35:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10F6F2221F
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628746514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGyoQz3s1utP7+oRHjje+JWGssL8A1MnuHH8cEVi+gs=;
        b=WEfIEgvcFuwMs9Dsvmu4f4CZW0DDfKfUmAASmfrN1/3ammIGF6J8z3oOJnhPr7letfNDwn
        ckuCpUgmBPflk5UGZQSjPeNoTxKTWX3NCf68dyi+mb9M6nxo3a1snI3e/fUzt3ErbP95PL
        gZduu7b60yXc8ZEHGpvaOacSuXKOGSg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4E10E13838
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ECm4BBGzFGFeZQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: map-logical: reject unaligned logical/bytes pair
Date:   Thu, 12 Aug 2021 13:35:06 +0800
Message-Id: <20210812053508.175737-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812053508.175737-1-wqu@suse.com>
References: <20210812053508.175737-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs filesystem is a block filesystem, there is no sense to support
unaligned logical/bytes pair.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-map-logical.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index eff0b89dbec6..21f00fa20ce8 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -289,6 +289,16 @@ int main(int argc, char **argv)
 
 	if (bytes == 0)
 		bytes = root->fs_info->sectorsize;
+
+	if (!IS_ALIGNED(logical, root->fs_info->sectorsize) ||
+	    !IS_ALIGNED(bytes, root->fs_info->sectorsize)) {
+		ret = -EINVAL;
+		error(
+	"invalid logical/bytes, both need to aligned to %u, have %llu and %llu",
+			root->fs_info->sectorsize, logical, bytes);
+		goto close;
+	}
+
 	cur_logical = logical;
 	cur_len = bytes;
 
-- 
2.32.0

