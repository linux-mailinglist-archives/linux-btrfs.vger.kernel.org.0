Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB713422262
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 11:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhJEJgE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhJEJgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 05:36:04 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A363AC061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 02:34:13 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:9ca4:a53a:9ffa:e003])
        by albert.telenet-ops.be with bizsmtp
        id 29a72600U119333069a7g2; Tue, 05 Oct 2021 11:34:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mXgpr-0028mJ-EX; Tue, 05 Oct 2021 11:34:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mXgpq-005CuT-SL; Tue, 05 Oct 2021 11:34:06 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        noreply@ellerman.id.au
Subject: [PATCH -next] btrfs: lzo: Mask instead of divide to fix 32-bit build
Date:   Tue,  5 Oct 2021 11:34:06 +0200
Message-Id: <20211005093406.1241222-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 32-bit builds (e.g. m68k):

    ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!

"cur_in - start" is 64-bit, while sectorsize is u32.

As sectorsize is always a power of two, the 64-by-32 modulo operation
can be replaced by a much cheaper bitwise AND with "sectorsize - 1".

Fixes: 0078783c7089fc83 ("btrfs: rework lzo_compress_pages() to make it subpage compatible")
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 fs/btrfs/lzo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 47003cec4046f13e..d08f9eba49dab3cd 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -211,7 +211,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	 */
 	cur_out += LZO_LEN;
 	while (cur_in < start + len) {
-		u32 sector_off = (cur_in - start) % sectorsize;
+		u32 sector_off = (cur_in - start) & (sectorsize - 1);
 		u32 in_len;
 		size_t out_len;
 
-- 
2.25.1

