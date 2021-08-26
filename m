Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30E3F8292
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 08:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbhHZGlc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 02:41:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhHZGlb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 02:41:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB40322283
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629960043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXdk1AabqBpp86K890+V+Z315ytiBPIVsFgO/jjMTbg=;
        b=BCcnIqk6L3zY3yw26Y4NnHjBrc899HHR94DwLBLAEJJyjowGF/YjWnFPH+j0y4QutRmNv5
        IHAb3c7rM+YsBuLaTKNcmnea8Gn8INXhHsgH0QvhG8JSI9eb69zhvgcmpC5bblR79wyOEo
        HQsmZ5K1QMH59UcQb+JWThr/W7X4JnE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 15CB513895
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SFCVMWo3J2E+cgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 06:40:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: check: output proper csum values for --check-data-csum
Date:   Thu, 26 Aug 2021 14:40:36 +0800
Message-Id: <20210826064036.21660-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210826064036.21660-1-wqu@suse.com>
References: <20210826064036.21660-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running "btrfs check --check-data-csum" on fs with corrupted data,
the error message almost makes no sense:

  $ btrfs check --check-data-csum /dev/test/test
  Opening filesystem to check...
  Checking filesystem on /dev/test/test
  UUID: c31afe0a-55bc-4e7d-aba0-9dfa9ddf8090
  [1/7] checking root items
  [2/7] checking extents
  [3/7] checking free space cache
  [4/7] checking fs roots
  [5/7] checking csums against data
  mirror 1 bytenr 13631488 csum 19 expected csum 152 <<<
  ERROR: errors found in csum tree
  [6/7] checking root refs
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 147456 bytes used, error(s) found
  total csum bytes: 16
  total tree bytes: 131072
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 124799
  file data blocks allocated: 16384
   referenced 16384

[CAUSE]
We're just outputting the first byte and in decimal, which is completely
different from what we did in kernel space, nor what we did for metadata
csum mismatch.

[FIX]
Use btrfs_format_csum() for btrfs-check to output csum.

Now the result looks much better:

  [5/7] checking csums against data
  mirror 1 bytenr 13631488 csum 0x13fec125 expected csum 0x98757625

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index a27efe56eec6..587a6ff362f0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5812,12 +5812,19 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 				read_extent_buffer(eb, (char *)&csum_expected,
 						   csum_offset, csum_size);
 				if (memcmp(result, csum_expected, csum_size) != 0) {
+					char found[BTRFS_CSUM_STRING_LEN];
+					char want[BTRFS_CSUM_STRING_LEN];
+
+
 					csum_mismatch = true;
-					/* FIXME: format of the checksum value */
+					btrfs_format_csum(csum_type, result,
+							  found);
+					btrfs_format_csum(csum_type,
+							  csum_expected, want);
 					fprintf(stderr,
-			"mirror %d bytenr %llu csum %u expected csum %u\n",
+			"mirror %d bytenr %llu csum %s expected csum %s\n",
 						mirror, bytenr + tmp,
-						result[0], csum_expected[0]);
+						found, want);
 				}
 				data_checked += gfs_info->sectorsize;
 			}
-- 
2.32.0

