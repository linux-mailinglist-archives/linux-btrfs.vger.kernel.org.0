Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D950954F72D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382101AbiFQMFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379829AbiFQMFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:05:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E06B7CD;
        Fri, 17 Jun 2022 05:05:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o7so8390993eja.1;
        Fri, 17 Jun 2022 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGIp+QlRrASXpLA1ruzGKEZ+hGOchTV156BeLyAGRU0=;
        b=lvYw/KHTd+ub9f4Gl25j1q4HqkSdQb/JcmLbtIJPr+yVanl9ido+MKgqrvD4+RtLqk
         o++z50zeMkuVuACOCoAIcsYMF7+y5bVqnO6henmOmLLypIkWiiK6VQr4Nkj5Gjl5Yry+
         njpjVWSEvRRPO+Vs5dLvhwMS5kK6/Vzu62xiOxjile396oo0+fyGK3hFtictbmA3EzCd
         OFKIIrZ3HFAPuGUPOY6I0oHyjlrGMyCyF29oWW5b6RuX9QTl2R5x74wOd/m9cfyLQTud
         qJ/kQFB0yqUICfS3LGNBWHJf+5bvltp7AZU7WDIFV34LOlKjL6WURBUH02MLDDTR3UzQ
         wpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGIp+QlRrASXpLA1ruzGKEZ+hGOchTV156BeLyAGRU0=;
        b=EOYUnDjaOY2zR/3l20/7iKZGZN5EQroXtlbWnDxwKIbQa1atO9m8SZ+S1/SGw7L9cL
         or6Vh+9qOv7rY5V9sCzY8vmnb2Vn02kaavyZODx0Zi0TY4+NZcjTzLxEBv1XMf/uynsS
         HCZK/82eqgWtZ3Sq5wE4c26G5e/Zv0TLVNOGQ+xOqfDxTwlnLuFRChWeEouuvnjNRDL4
         lCY9qZlXHHW2/+v/uZ8lrkonyTTbOZI2I0e19DPLjkQCzL9/fZPoQnqrkqa+pKD2ARpE
         KTpJ16JT5ZIU3I7/bq4Yw1u7yniCx7QTBp6VeQIZ+EHGkbQyIXGuJa0XYCpGkpBe2rmx
         78OA==
X-Gm-Message-State: AJIora/PN/VDm06iNqjLJWrrn4u6T0LtHrCeIjOP8S9Wq/h+RT4LydlG
        +bYWFGrlGi6Ik0X1A0hyLUo=
X-Google-Smtp-Source: AGRyM1sagedOAKzq+khe7axC3tTQnvqv7im+gzzXup6NBV4ss6JMZ23u6Tj2LfJ8syFA+ol7hQ6Fqg==
X-Received: by 2002:a17:907:160f:b0:70f:cceb:d78c with SMTP id hb15-20020a170907160f00b0070fccebd78cmr8982804ejc.247.1655467546245;
        Fri, 17 Jun 2022 05:05:46 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id kw2-20020a170907770200b007121361d54asm2135179ejc.25.2022.06.17.05.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:05:44 -0700 (PDT)
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
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RFC PATCH v2 0/3] btrfs: Convert zlib.c to use kmap_local_page()
Date:   Fri, 17 Jun 2022 14:05:35 +0200
Message-Id: <20220617120538.18091-1-fmdefrancesco@gmail.com>
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

The use of kmap() is being deprecated in favor of kmap_local_page(). With
kmap_local_page(), the mapping is per thread, CPU local and not globally
visible.

Therefore, use kmap_local_page() / kunmap_local() in zlib.c because in
this file the mappings are per thread and are not visible in other
contexts.

This is an RFC because patch 3/3 uses an horrid hack. I'm using an array
based stack which tracks local mappings / un-mappings. I understand that
it is not the better solution, but it works and it is easy to implement :)

I've decided to decompose RFC v1 into a series of three patches in order to
make clear that I encountered problems with conversions in patch 3/3. I'm
pretty sure that people who are familiar with these functions could refactor
this code and provide much more elegant and efficient solutions.

Since this code currently uses kmap() / kunmap(), I think that the functions
I'm converting had been designed without taking into account the rules of
ordering of nesting local mappings / un-mappings.

I've been trying to refactor this code but it is something beyond my current
level of knowledge and skills...

Can anyone please provide any better suited solutions for patch 3/3?

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
HIGHMEM64G enabled. Each patch of this series passes 26/26 tests of group
"compress".

tweed32:/usr/lib/xfstests # ./check -g compress
FSTYP         -- btrfs
PLATFORM      -- Linux/i686 tweed32 5.19.0-rc2-vanilla-debug+ #45 SMP PREEMPT_DYNAMIC Fri Jun 17 11:14:11 CEST 2022
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/024 2s ...  3s
btrfs/026 5s ...  5s
btrfs/037 3s ...  3s
btrfs/038 3s ...  2s
btrfs/041 3s ...  3s
btrfs/062 41s ...  41s
btrfs/063 22s ...  23s
btrfs/067 39s ...  40s
btrfs/068 14s ...  14s
btrfs/070	[not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
btrfs/071	[not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
btrfs/072 39s ...  41s
btrfs/073 20s ...  20s
btrfs/074 41s ...  41s
btrfs/076 3s ...  3s
btrfs/103 3s ...  3s
btrfs/106 3s ...  3s
btrfs/109 3s ...  3s
btrfs/113 3s ...  3s
btrfs/138 53s ...  54s
btrfs/149 3s ...  3s
btrfs/183 3s ...  2s
btrfs/205 4s ...  3s
btrfs/234 4s ...  4s
btrfs/246 2s ...  3s
btrfs/251 3s ...  2s
Ran: btrfs/024 btrfs/026 btrfs/037 btrfs/038 btrfs/041 btrfs/062 btrfs/063 btrfs/067 btrfs/068 btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074 btrfs/076 btrfs/103 btrfs/106 btrfs/109 btrfs/113 btrfs/138 btrfs/149 btrfs/183 btrfs/205 btrfs/234 btrfs/246 btrfs/251
Not run: btrfs/070 btrfs/071
Passed all 26 tests

Fabio M. De Francesco (3):
  btrfs: Convert zlib_decompress_bio() to use kmap_local_page()
  btrfs: Use kmap_local_page() on "out_page" in zlib_compress_pages()
  btrfs: Use kmap_local_page() on "in_page" in zlib_compress_pages()

 fs/btrfs/zlib.c | 91 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 24 deletions(-)

-- 
2.36.1

