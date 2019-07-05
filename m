Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F96016E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfGEH1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 03:27:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfGEH1F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 03:27:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0774FAFCB
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 07:27:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs-progs: mkfs: Apply the sectorsize user specified on 64k page size system
Date:   Fri,  5 Jul 2019 15:26:47 +0800
Message-Id: <20190705072651.25150-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190705072651.25150-1-wqu@suse.com>
References: <20190705072651.25150-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
On aarch64 with 64k page size, mkfs.btrfs -s option doesn't work:
  $ mkfs.btrfs  -s 4096 ~/10G.img  -f
  btrfs-progs v5.1.1
  See http://btrfs.wiki.kernel.org for more information.

  Label:              (null)
  UUID:               c2a09334-aaca-4980-aefa-4b3e27390658
  Node size:          65536
  Sector size:        65536		<< Still 64K, not 4K
  Filesystem size:    10.00GiB
  Block group profiles:
    Data:             single            8.00MiB
    Metadata:         DUP             256.00MiB
    System:           DUP               8.00MiB
  SSD detected:       no
  Incompat features:  extref, skinny-metadata
  Number of devices:  1
  Devices:
     ID        SIZE  PATH
      1    10.00GiB  /home/adam/10G.img

[CAUSE]
This is because we automatically detect sectorsize based on current
system page size, then get the maxium number between user specified -s
parameter and system page size.

It's fine for x86 as it has fixed page size 4K, also the minimium valid
sector size.

But for system like aarch64 or ppc64le, where we can have 64K page size,
and it makes us unable to create a 4k sector sized btrfs.

[FIX]
Only do auto detect when no -s|--sectorsize option is specified.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 8dbec0717b89..26d84e9dafc3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -817,6 +817,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *source_dir = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
+	bool sectorsize_set = false;
 	u64 source_dir_size = 0;
 	u64 min_dev_size;
 	u64 shrink_size;
@@ -906,6 +907,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				}
 			case 's':
 				sectorsize = parse_size(optarg);
+				sectorsize_set = true;
 				break;
 			case 'b':
 				block_count = parse_size(optarg);
@@ -943,7 +945,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		printf("See %s for more information.\n\n", PACKAGE_URL);
 	}
 
-	sectorsize = max(sectorsize, (u32)sysconf(_SC_PAGESIZE));
+	if (!sectorsize_set)
+		sectorsize = max(sectorsize, (u32)sysconf(_SC_PAGESIZE));
+	if (!is_power_of_2(sectorsize) || sectorsize < 4096 ||
+	    sectorsize > SZ_64K) {
+		error(
+		"invalid sectorsize: %u, expect either 4k, 8k, 16k, 32k or 64k",
+			sectorsize);
+		goto error;
+	}
 	stripesize = sectorsize;
 	saved_optind = optind;
 	dev_cnt = argc - optind;
-- 
2.22.0

