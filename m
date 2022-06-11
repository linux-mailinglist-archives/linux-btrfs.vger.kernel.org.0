Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003E3547138
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 04:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbiFKCFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKCFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 22:05:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6B279C0B;
        Fri, 10 Jun 2022 19:04:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d14so945088eda.12;
        Fri, 10 Jun 2022 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4sS/d4bcwXcxCV6l0ky+ZdRqnJ/udN/dJaZCImm896A=;
        b=Y/uezU8jO/V/WeSP/Ruzo3Yrm6HdOtvACBfxlhlLfGz8gJ1oPZ1qt9uxZGB6JaNeCp
         YUqUfAP5TE6YNPLhIupZCjAj0JqjKIRUOIuiEWeQzbQatMt+PCtV5rAsLvJVMbktBxbc
         TYLZspE8wSTNmTfS1EvXulEkUgAs1GjcU5gRt6+vZ1bgNj+/SIGjlyDtKnevJJi21yT1
         IIPZ90xK1uXRZxOl0ZHGaCfklAzmvYyYz/sxiEAbkZGaQBLAAhtjsOBSYWgsdbr7B3Im
         ibdskrdMIIbCx1bivv6IBVBylpmmeR1G20Eyk0DJOHpaEvede7jsZFtsb6JEH/C0cWMD
         Ik0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4sS/d4bcwXcxCV6l0ky+ZdRqnJ/udN/dJaZCImm896A=;
        b=Z1spdq55hD1UJFmvgBwos6vTXcl9jrf5o81jJ0ErZXINeUzpIUbGXiRLGK0IczX3Kj
         ORiKZgZwJqx6C05g2X+Ajy0VzPxNuO0TsizyqNbYGsbMQ6vTr0gZvI8pBGPJ81j3mE7S
         H6Dy7sm2NZPh2HpWJj26cwMCR4Oy6Zl9rBo1DpePum85mSimkQMzFWTA45Cv4rCV69CA
         lACjEzwHgQnmnEeVNVoQDH+RanvkcqNfNz5pF5+0ToM0Vlkcrc2jlpKlhh/b0ICaVyUF
         4CfwZdudAYirq5RNs1zx7V1226quCWqyzbZLMG12rrs8GI3aqs3O74ISTsyJwjRkGh7a
         ciqA==
X-Gm-Message-State: AOAM5310cS19vCtC74M1uY7vAYnc6PafFqWcKLDufbX0T7vr3jqV/qjp
        Dt/x12TvkKo9CyvGY1viDkg=
X-Google-Smtp-Source: ABdhPJyNyWKGselU04xDAqq3SNlmCcXJXQiEMhiPWlWy/pS+IP/sP+5O5T8TUpQ5bQiWsXQmpRrokw==
X-Received: by 2002:aa7:c306:0:b0:42d:d4cc:c606 with SMTP id l6-20020aa7c306000000b0042dd4ccc606mr54210165edq.341.1654913097688;
        Fri, 10 Jun 2022 19:04:57 -0700 (PDT)
Received: from localhost.localdomain (host-79-18-0-143.retail.telecomitalia.it. [79.18.0.143])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b006fec56c57e6sm364721ejg.46.2022.06.10.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 19:04:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Sat, 11 Jun 2022 04:04:51 +0200
Message-Id: <20220611020451.28170-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page(). With
kmap_local_page(), the mapping is per thread, CPU local and not globally
visible.

Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
this file the mappings are per thread and are not visible in other
contexts; meanwhile refactor zstd_compress_pages() to comply with nested
local mapping / unmapping ordering rules.

Tested with xfstests (./check -g compress) on QEMU + KVM 32 bits VM with
4GB of RAM and HIGHMEM64G enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This is an RFC PATCH because it actually passes all xfstests of group
"compress" with the only exception of tests/btrfs/138.

Since I am relatively new to kernel development and know very little about
fs/btrfs design and code, I would like to ask for the help from anyone who
knows this filesystem and xfstests better than me.

Can anyone please help me figure out what's wrong and how to fix it?

Please note that there is some discussion for changing __kunmap_local().
For now I had to cast workspace->in_buf.src to pointer to void,
otherwise GCC-12 complains with a series of messages like the
following...

/usr/src/git/kernels/linux/fs/btrfs/zstd.c:547:33: warning: passing argument 1 of '__kunmap_local' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  547 |   kunmap_local(workspace->in_buf.src);
      |                ~~~~~~~~~~~~~~~~~^~~~
/usr/src/git/kernels/linux/include/linux/highmem-internal.h:284:17: note: in definition of macro 'kunmap_local'
  284 |  __kunmap_local(__addr);     \
      |                 ^~~~~~
/usr/src/git/kernels/linux/include/linux/highmem-internal.h:92:41: note: expected 'void *' but argument is of type 'const void *'
   92 | static inline void __kunmap_local(void *vaddr)
      |                                   ~~~~~~^~~~~
 
This is what I get from running xfstests of "compress" group...

tweed32:/usr/lib/xfstests # ./check -g compress
FSTYP         -- btrfs
PLATFORM      -- Linux/i686 tweed32 5.19.0-rc1-vanilla-debug+ #20 SMP PREEMPT_DYNAMIC Fri Jun 10 14:15:51 CEST 2022
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/024 0s ...  0s
btrfs/026 3s ...  3s
btrfs/037 1s ...  1s
btrfs/038 0s ...  1s
btrfs/041 1s ...  0s
btrfs/062 34s ...  34s
btrfs/063 18s ...  18s
btrfs/067 32s ...  30s
btrfs/068 10s ...  10s
btrfs/070       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
btrfs/071       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
btrfs/072 34s ...  34s
btrfs/073 13s ...  17s
btrfs/074 35s ...  33s
btrfs/076 0s ...  1s
btrfs/103 1s ...  0s
btrfs/106 0s ...  1s
btrfs/109 0s ...  0s
btrfs/113 1s ...  0s
btrfs/138 43s ... - output mismatch (see /usr/lib/xfstests/results//btrfs/138.out.bad)
    --- tests/btrfs/138.out     2022-05-11 04:02:17.000000000 +0200
    +++ /usr/lib/xfstests/results//btrfs/138.out.bad    2022-06-10 17:22:14.419547768 +0200
    @@ -1,2 +1,3 @@
     QA output created by 138
    +Checksum mismatch for zstd (expected 4c99665eb952380c4c2c748a78be4f8a, got d41d8cd98f00b204e9800998ecf8427e)
     Silence is golden
    ...
    (Run 'diff -u /usr/lib/xfstests/tests/btrfs/138.out /usr/lib/xfstests/results//btrfs/138.out.bad'  to see the entire diff)
btrfs/149 1s ...  1s
btrfs/183 0s ...  1s
btrfs/205 2s ...  1s
btrfs/234 2s ...  2s
btrfs/246 0s ...  1s
btrfs/251 1s ...  1s
Ran: btrfs/024 btrfs/026 btrfs/037 btrfs/038 btrfs/041 btrfs/062 btrfs/063 btrfs/067 btrfs/068 btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074 btrfs/076 btrfs/103 btrfs/106 btrfs/109 btrfs/113 btrfs/138 btrfs/149 btrfs/183 btrfs/205 btrfs/234 btrfs/246 btrfs/251
Not run: btrfs/070 btrfs/071
Failures: btrfs/138
Failed 1 of 26 tests

tweed32:/usr/lib/xfstests # cat results/btrfs/138.out.bad 
QA output created by 138
Checksum mismatch for zstd (expected 4c99665eb952380c4c2c748a78be4f8a, got d41d8cd98f00b204e9800998ecf8427e)

tweed32:/usr/lib/xfstests # cat results/btrfs/138.full 
btrfs-progs v5.17
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM /dev/loop1 (12.00GiB) ...
NOTE: several default settings have changed in version 5.15, please make sure
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               06e21efe-2454-4d0c-ab80-f226320e1544
Node size:          16384
Sector size:        4096
Filesystem size:    12.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP             256.00MiB
  System:           DUP               8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, skinny-metadata, no-holes
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1    12.00GiB  /dev/loop1

100+0 records in
100+0 records out
Testing zlib
100+0 records in
100+0 records out
Testing lzo
100+0 records in
100+0 records out
Testing zstd
dd: error reading '/mnt/scratch/zstd': Input/output error
0+0 records in
0+0 records out

tweed32:/usr/lib/xfstests # cat results/btrfs/138.dmesg 
[ 1286.929283] run fstests btrfs/138 at 2022-06-10 17:21:30
[ 1287.090289] BTRFS info (device loop0): flagging fs with big metadata feature
[ 1287.090292] BTRFS info (device loop0): using free space tree
[ 1287.090293] BTRFS info (device loop0): has skinny extents
[ 1287.215036] BTRFS: device fsid 06e21efe-2454-4d0c-ab80-f226320e1544 devid 1 transid 6 /dev/loop1 scanned by mkfs.btrfs (19573)
[ 1287.226730] BTRFS info (device loop1): flagging fs with big metadata feature
[ 1287.226733] BTRFS info (device loop1): using free space tree
[ 1287.226735] BTRFS info (device loop1): has skinny extents
[ 1287.228967] BTRFS info (device loop1): checking UUID tree
[ 1321.763502] BTRFS info (device loop1): flagging fs with big metadata feature
[ 1321.763506] BTRFS info (device loop1): using free space tree
[ 1321.763506] BTRFS info (device loop1): has skinny extents
[ 1321.779751] BTRFS info (device loop1): setting incompat feature flag for COMPRESS_LZO (0x8)
[ 1325.730614] BTRFS info (device loop1): flagging fs with big metadata feature
[ 1325.730617] BTRFS info (device loop1): using free space tree
[ 1325.730618] BTRFS info (device loop1): has skinny extents
[ 1325.748761] BTRFS info (device loop1): setting incompat feature flag for COMPRESS_ZSTD (0x10)
[ 1330.663239] BTRFS info (device loop1): flagging fs with big metadata feature
[ 1330.663243] BTRFS info (device loop1): using free space tree
[ 1330.663245] BTRFS info (device loop1): has skinny extents
[ 1330.813468] BTRFS info (device loop1): flagging fs with big metadata feature
[ 1330.813471] BTRFS info (device loop1): using free space tree
[ 1330.813472] BTRFS info (device loop1): has skinny extents

 fs/btrfs/zstd.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68..ccfc098319fd 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -391,6 +391,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*out_pages = 0;
 	*total_out = 0;
 	*total_in = 0;
+	workspace->in_buf.src = NULL;
+	workspace->out_buf.dst = NULL;
 
 	/* Initialize the stream */
 	stream = zstd_init_cstream(&params, len, workspace->mem,
@@ -403,7 +405,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 	/* map in the first page of input data */
 	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	workspace->in_buf.src = kmap(in_page);
+	workspace->in_buf.src = kmap_local_page(in_page);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 
@@ -415,7 +417,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		goto out;
 	}
 	pages[nr_pages++] = out_page;
-	workspace->out_buf.dst = kmap(out_page);
+	workspace->out_buf.dst = kmap_local_page(out_page);
 	workspace->out_buf.pos = 0;
 	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 
@@ -450,9 +452,9 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
 			tot_out += PAGE_SIZE;
 			max_out -= PAGE_SIZE;
-			kunmap(out_page);
+			kunmap_local(workspace->out_buf.dst);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
+				workspace->out_buf.dst = NULL;
 				ret = -E2BIG;
 				goto out;
 			}
@@ -462,7 +464,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 				goto out;
 			}
 			pages[nr_pages++] = out_page;
-			workspace->out_buf.dst = kmap(out_page);
+			workspace->out_buf.dst = kmap_local_page(out_page);
 			workspace->out_buf.pos = 0;
 			workspace->out_buf.size = min_t(size_t, max_out,
 							PAGE_SIZE);
@@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		/* Check if we need more input */
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
 			tot_in += PAGE_SIZE;
-			kunmap(in_page);
+			kunmap_local(workspace->out_buf.dst);
+			kunmap_local((void *)workspace->in_buf.src);
 			put_page(in_page);
-
 			start += PAGE_SIZE;
 			len -= PAGE_SIZE;
 			in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-			workspace->in_buf.src = kmap(in_page);
+			workspace->in_buf.src = kmap_local_page(in_page);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
+			workspace->out_buf.dst = kmap_local_page(out_page);
 		}
 	}
 	while (1) {
@@ -510,9 +513,9 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		tot_out += PAGE_SIZE;
 		max_out -= PAGE_SIZE;
-		kunmap(out_page);
+		kunmap_local(workspace->out_buf.dst);
 		if (nr_pages == nr_dest_pages) {
-			out_page = NULL;
+			workspace->out_buf.dst = NULL;
 			ret = -E2BIG;
 			goto out;
 		}
@@ -522,7 +525,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		}
 		pages[nr_pages++] = out_page;
-		workspace->out_buf.dst = kmap(out_page);
+		workspace->out_buf.dst = kmap_local_page(out_page);
 		workspace->out_buf.pos = 0;
 		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 	}
@@ -538,12 +541,12 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 out:
 	*out_pages = nr_pages;
 	/* Cleanup */
-	if (in_page) {
-		kunmap(in_page);
+	if (workspace->out_buf.dst)
+		kunmap_local(workspace->out_buf.dst);
+	if (workspace->in_buf.src) {
+		kunmap_local((void *)workspace->in_buf.src);
 		put_page(in_page);
 	}
-	if (out_page)
-		kunmap(out_page);
 	return ret;
 }
 
@@ -567,7 +570,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		goto done;
 	}
 
-	workspace->in_buf.src = kmap(pages_in[page_in_index]);
+	workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 
@@ -603,14 +606,14 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			break;
 
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
-			kunmap(pages_in[page_in_index++]);
+			kunmap_local((void *)workspace->in_buf.src);
 			if (page_in_index >= total_pages_in) {
 				workspace->in_buf.src = NULL;
 				ret = -EIO;
 				goto done;
 			}
 			srclen -= PAGE_SIZE;
-			workspace->in_buf.src = kmap(pages_in[page_in_index]);
+			workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 		}
@@ -619,7 +622,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	zero_fill_bio(cb->orig_bio);
 done:
 	if (workspace->in_buf.src)
-		kunmap(pages_in[page_in_index]);
+		kunmap_local((void *)workspace->in_buf.src);
 	return ret;
 }
 
-- 
2.36.1

