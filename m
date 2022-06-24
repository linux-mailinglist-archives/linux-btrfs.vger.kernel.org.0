Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8D559598
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiFXImg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiFXIme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 04:42:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40B766AD;
        Fri, 24 Jun 2022 01:42:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd6so2445063edb.5;
        Fri, 24 Jun 2022 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/bNzydjLfS6FoWzLmCL3RjLpUy/CcRj6s94kxyuCxs=;
        b=dTPHHSO6M3UC5M8AVVvieHM4AB6cdsU8zcydSDgycYuedEfXZZaRt++dvOrsBvTItV
         ilvb1kuhxEMzvxmvSRhiXgiLncWv4pj2a6GWeu1ikelJY4w+RKvhhykPs/0qH1ee/WuK
         azModRmICrq7ckO6FmLLIgOjwxTHO00AQ0w1puoMLfhV7ChNcQwFLghIHK7JMgTms8KE
         EhyZWnfbCrGfa+ZupoW+FxABcTFDX/eFafA/DIlg4eltS6AN1vN/Fqf9rpsUCiCPOFqv
         KXqdYBHWB4CfwGsx57WolI8w+d4uEPD04TYWw0BwbHX8UIufYJY44SKSMBVWfjOZpAMN
         hqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/bNzydjLfS6FoWzLmCL3RjLpUy/CcRj6s94kxyuCxs=;
        b=Mo9Ktv66fbaEyoqKMXlw+OP+je6Oa0yKzhzijI4i+rUL+V4o5Pw4qnNcM79I6LsWa0
         U7dwsgyNTmG9x9FvlzJgy7VmvvGH5dbs4pYkVPrDiRr9cGc2VhE4n/TZsiooOoHYAbr1
         Be42P51oMoGDicUi2aDOxUIEJuEVNwPFku05MOYJj9XB2fNic+YyMvaHM4UnBmYQJrqb
         FzMcZj7aolxv1jUfrN7krz8nzzk5wqxdOtCFunKMO58bu036Nx3XiHBfzkdsGoyj1yCf
         XMsvOupA8qcCrIP+XBECSkaqqkVgdxie4oYiQc7ZRHuCFsqiXWK+mxoq6gQDYAH9bzhR
         LYWQ==
X-Gm-Message-State: AJIora+Ho+SCmTot+MP8JouvkcSA9EVBsLJOrwelfThI/JBWHJGCesgJ
        KVv7/8g2KWWGomBlqyp6LG4=
X-Google-Smtp-Source: AGRyM1sNHCF89oZ3BAIwX//5qMMQTDe1k2bkioJtl3MyjPZ5NBbsj0VzPVD7jgiVzp5sXMWsONjExw==
X-Received: by 2002:a05:6402:3298:b0:435:8145:e6db with SMTP id f24-20020a056402329800b004358145e6dbmr16072573eda.294.1656060150387;
        Fri, 24 Jun 2022 01:42:30 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a056402038c00b0043561e0c9adsm1434824edv.52.2022.06.24.01.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:42:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.cz>
Subject: [RFC PATCH] btrfs: Replace kmap_atomic() with kmap_local_page()
Date:   Fri, 24 Jun 2022 10:42:15 +0200
Message-Id: <20220624084215.7287-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

kmap_atomic() is being deprecated in favor of kmap_local_page() where it
is feasible. With kmap_local_page() mappings are per thread, CPU local,
and not globally visible.

As far as I can see, the kmap_atomic() calls in compression.c and in
inode.c can be safely converted.

Above all else, David Sterba has confirmed that "The context in
check_compressed_csum is atomic [...]" and that "kmap_atomic() in inode.c
[...] also can be replaced by kmap_local_page().".[1]

Therefore, convert all kmap_atomic() calls currently still left in fs/btrfs
to kmap_local_page().

This is an RFC only because, testing with "./check -g quick" (xfstests) on
a QEMU + KVM 32-bits VM with 4GB RAM and booting a kernel with HIGHMEM64GB
enabled, outputs several errors. These errors seem to be exactly the same
which are being output without this patch. It apparently seems that these
changes don't introduce further errors, however I'd like to ask for
comments before sending a "real" patch.

With this patch, there are no more call sites for kmap() and kmap_atomic()
in fs/btrfs.

[1] https://lore.kernel.org/linux-btrfs/20220601132545.GM20633@twin.jikos.cz/

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/compression.c |  4 ++--
 fs/btrfs/inode.c       | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f4564f32f6d9..b49719ae45b4 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -175,10 +175,10 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 		/* Hash through the page sector by sector */
 		for (pg_offset = 0; pg_offset < bytes_left;
 		     pg_offset += sectorsize) {
-			kaddr = kmap_atomic(page);
+			kaddr = kmap_local_page(page);
 			crypto_shash_digest(shash, kaddr + pg_offset,
 					    sectorsize, csum);
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 
 			if (memcmp(&csum, cb_sum, csum_size) != 0) {
 				btrfs_print_data_csum_error(inode, disk_start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d84d57a0653..5fb4f6e929e5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -332,9 +332,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 			cur_size = min_t(unsigned long, compressed_size,
 				       PAGE_SIZE);
 
-			kaddr = kmap_atomic(cpage);
+			kaddr = kmap_local_page(cpage);
 			write_extent_buffer(leaf, kaddr, ptr, cur_size);
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 
 			i++;
 			ptr += cur_size;
@@ -345,9 +345,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	} else {
 		page = find_get_page(inode->vfs_inode.i_mapping, 0);
 		btrfs_set_file_extent_compression(leaf, ei, 0);
-		kaddr = kmap_atomic(page);
+		kaddr = kmap_local_page(page);
 		write_extent_buffer(leaf, kaddr, ptr, size);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		put_page(page);
 	}
 	btrfs_mark_buffer_dirty(leaf);
@@ -3355,11 +3355,11 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
 	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	shash->tfm = fs_info->csum_shash;
 
 	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	if (memcmp(csum, csum_expected, csum_size))
 		goto zeroit;
-- 
2.36.1

