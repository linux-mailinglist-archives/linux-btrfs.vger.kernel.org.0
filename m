Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A746568685
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGFLPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 07:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiGFLP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 07:15:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464227CFF;
        Wed,  6 Jul 2022 04:15:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s1so21569450wra.9;
        Wed, 06 Jul 2022 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVIqMuPLzYcOO4HfWaLexMHz/42n1NJarHPePFEhy5w=;
        b=m5QIzCxTztbi5KfIP3O6LOSDYQiWmkgsJQVhGH/t8ydJoQfPUxc/dKURnvfmJJS9Rz
         zwG7N+HRzcal5Fdnl/pKbNDvr/8OBXvtkeh9jTsJNQbkSU7qRF4T774IP8yKZmVo7XLT
         aKQJ0DRnvKnc5YgICzzMfIFF5dQ+A77fZenZFovchl8WEA9kExvAa4/ofYdiEtj7iPyR
         1sG7yz9QmKsbfjfaMZicR8VwSFT2cUtFK6yMODVdC4t2+7/eLLTXagm6Q+aEID7T/NjA
         psO6g7drtb9f5UtaCbJfajQyekacMm1av9fCTsbU3juL/Rdo1zDHefTV2y9F0xFJ7wgV
         NsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVIqMuPLzYcOO4HfWaLexMHz/42n1NJarHPePFEhy5w=;
        b=ENqQdjTiVoS78jdLV+kwWzbFBnkRqlEOIu6I1+oJ+pogulOIABSiV7U4Pi2Dl7iG0E
         u8bLygKHY9p4Ub2uI8E9kaoV/+Y7wdXLOlqgWSwMpjKiLpCyaoTA3MDDAXalr2FQi0JI
         MJTo+vPr+kcY2tU2hSpIzzRiIuOaEo6IZo2SSRxBK+qatTf7GHXq0dKIxOZg+IONjwGc
         vnaR0t+1fOCX9daYGBc0Hf9mYSTeGDVKpRK48Iib8AuOuNl3QEDQTGL3CsNft5CIisNW
         Fr2NZQPziriZp5HUFRr0ApMXzKWaRCPqIohx6gczrncYk9nl7a4c9bMNjCI6djQ6sCyz
         mOlQ==
X-Gm-Message-State: AJIora/uis8+ieFrNlP+0ZD7NEKtu3Q8gtfYMGoajV5Hp0BF9HvV/Wtg
        VPAFaa44Nn/t66etqW0BlKMmk6LYEGY=
X-Google-Smtp-Source: AGRyM1torpT8rb4PEx6tmQwuKc10pA2UzSAKa80fu6UU6snP+8f2bx4lOwv5uHAt71CsGSJ0lloNKQ==
X-Received: by 2002:a5d:484c:0:b0:21d:6c71:a053 with SMTP id n12-20020a5d484c000000b0021d6c71a053mr13020335wrs.449.1657106127146;
        Wed, 06 Jul 2022 04:15:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020d07d90b71sm34830696wrp.66.2022.07.06.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 04:15:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 0/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Wed,  6 Jul 2022 13:15:18 +0200
Message-Id: <20220706111520.12858-1-fmdefrancesco@gmail.com>
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

This is a little series which serves the purpose to replace kmap() with
kmap_local_page() in btrfs/zstd.c. Actually this task is only accomplished
in patch 2/2.

Instead patch 1/2 is a pre-requisite for the above-mentioned replacement,
however, above all else, it has the purpose to conform the prototypes of
__kunmap_{local,atomic}() to their own correct semantics. Since those
functions don't make changes to the memory pointed by their arguments,
change the type of those arguments to become pointers to const void.

v5 -> v6: Delete an unnecessary assignment in 2/2 (thanks to Ira Weiny).

v4 -> v5: Use plain page_address() for pages which cannot come from Highmem
(instead of kmapping them); remove unnecessary initializations to NULL
in 2/2 (thanks to Ira Weiny).

v3 -> v4: Resend and add linux-mm to the list of recipients (thanks to
Andrew Morton).

Fabio M. De Francesco (2):
  highmem: Make __kunmap_{local,atomic}() take "const void *"
  btrfs: Replace kmap() with kmap_local_page() in zstd.c

 arch/parisc/include/asm/cacheflush.h |  6 ++---
 arch/parisc/kernel/cache.c           |  2 +-
 fs/btrfs/zstd.c                      | 33 +++++++++++-----------------
 include/linux/highmem-internal.h     | 10 ++++-----
 mm/highmem.c                         |  2 +-
 5 files changed, 23 insertions(+), 30 deletions(-)

-- 
2.36.1

