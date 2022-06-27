Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9050055D918
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiF0RtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiF0RtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 13:49:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230BA65D3;
        Mon, 27 Jun 2022 10:48:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g26so20711622ejb.5;
        Mon, 27 Jun 2022 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5so6o3lsHdESNYtq8PIm0PWXq9C33in8/VcoE/KuhZ4=;
        b=F6h0bcmYl7K7s/6rP6jzo27nQJEU2tETOnQkeRMUQQdQCanPbM2tGY3WXO1jakZlPh
         hCwi8dKTuFOfp9mw4ayy9sIUozJOKgh+kYOcDTX7bXfT01fj9PoHXtBMmoEq04gQEhMh
         +IrEhvcgoWR2Djz7OOULFWt4f/gLThPeuoeGA+uhmpSlcrlbRtwogehZC/C/gj/mwCMk
         RLPlsH3DOsJoVO19QGNH3i3jX/c246SMBHTNhvO4hxMC8YkSH8QjBEmnhYiuSFUo6WgO
         xEKDJ+CtL6xaVihWW/c9rmtozVgs5rrrNHdsWVUeEz7nzXbRQULMQMt/A84Nvq5d+Rcg
         EHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5so6o3lsHdESNYtq8PIm0PWXq9C33in8/VcoE/KuhZ4=;
        b=5MfblzSL9UF8WjhwYuhvCY3t8/JfquRa5CPopNwaj6lxsx30+NEw6yh0fhbUvPFADu
         mdjzS2axnnZ/BdmTh06v7kUw2cZmRIUJWOZyQFq2iozWYctLvrW5/Be/anQreYT+D9DB
         3paT2F/xh/DgNHL+KuRPjhv7x7k7/muBFUYbqGKP6Tii9tzP3malMgx81gHJ0Nuiahth
         5ewqGQc57anbTVLaomJFrUJAdCTXQIDPEz/pja99MC1CPwsGy0vDOeaPBkNMu7FoqGbm
         nv8pbWNqfD30er55eLEYnaVHnvya0gneF/F36ZCjFbzVkWlydLOAnihI3XJgwXDz9IKL
         sk6g==
X-Gm-Message-State: AJIora+kmlLqAwlWc3ce4dgB16U4XLO1HcgsBCuGXYVcVRLDzrwyJfPh
        8f9DhtqZ8zzP+aYiQClj5c8=
X-Google-Smtp-Source: AGRyM1uuE2HKf24Zx9OfG8R2hLlm2cKBKMz2MUwW/ZGSONbzIn1BkpnC6am+iavXIT7LbrQThJD4Ug==
X-Received: by 2002:a17:906:4302:b0:726:8efe:3bda with SMTP id j2-20020a170906430200b007268efe3bdamr11343420ejm.184.1656352135523;
        Mon, 27 Jun 2022 10:48:55 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id i25-20020a056402055900b00435681476c7sm7980916edx.10.2022.06.27.10.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:48:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, David Sterba <dsterba@suse.cz>
Subject: [PATCH] btrfs: Replace kmap_atomic() with kmap_local_page()
Date:   Mon, 27 Jun 2022 19:48:49 +0200
Message-Id: <20220627174849.29962-1-fmdefrancesco@gmail.com>
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

Tested with xfstests on a QEMU + KVM 32-bits VM with 4GB RAM and booting a
kernel with HIGHMEM64GB enabled.

[1] https://lore.kernel.org/linux-btrfs/20220601132545.GM20
633@twin.jikos.cz/

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Tests of groups "quick" and "compress" output several errors largely due
to memory leaks and shift-out-of-bounds. However, these errors are exactly
the same which are output without this and other conversions of mine to use
kmap_local_page(). Therefore, it looks like these changes don't introduce
regressions.

The previous RFC PATCH can be ignored:
https://lore.kernel.org/lkml/20220624084215.7287-1-fmdefrancesco@gmail.com/

With this patch, in fs/btrfs there are no longer call sites of kmap() and
kmap_atomic().

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
index e921d6c432ac..0a7a621710f6 100644
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
@@ -3357,11 +3357,11 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
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

