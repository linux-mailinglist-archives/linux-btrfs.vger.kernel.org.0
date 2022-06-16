Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A808E54DC98
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359649AbiFPIL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359612AbiFPIL6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 04:11:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAAB5D658;
        Thu, 16 Jun 2022 01:11:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a15so818148wrh.2;
        Thu, 16 Jun 2022 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amDKED5mOsWQ+K/CNIGULiX1ELwKCA1nvvmyVqf77To=;
        b=a8siBkH637bA11QQzzQ3C0wN2P3xzXYSr+nJqJgAr44mli5jvIzPSia4y9/XpC+2Hj
         eHBsKThuPe3ZeCiXZLKkgadkmUkaCbeU1ZqDdxhkR84uMb/vtWav0bC7HdH5XcFpunVt
         FE7aGJsU1E7BAKq6N2k9OYM8hF64yq9RWTvx0KFtTRpHJEQREm9Ef1G6fyz8yHQGA6Zx
         0ZkxVLZGdqOFdPaTUHivovdxlezUDnzGV2iL7lcCQV/899mdlLpxiweRNU+5IdWTUwQn
         Xnf8IeNhU8YL72JlEb8x27e3CR6/Xk4z0k5CF+oT6xGW3jZu2suPXoMmmab2oubJV9NF
         KDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amDKED5mOsWQ+K/CNIGULiX1ELwKCA1nvvmyVqf77To=;
        b=LiE2Qn1oaRKKLz1855tQakpgS+KRcvHJiNuRmZYGIzkxaHxjZAEw6yjPNL3/pZRRo8
         x6DAMA+6+O7s8kJvSuPXpNg8baaz44JP4iE+giJaTc1unxRCPj0uHzIxRHLUjAwqQ0ub
         10cuKRdmDIP6Eppum78l8SFZ1HqzwB4Wtw+zI4PN9Lp47q7hcO2kuNxEFIGUhbRrHiYi
         s993IRMVwDx7O2JKXvB+O8FH+KqQqrtQBdo4Ucx2WrgQ7SpRRX8K8uelKY2SNr+n3tfA
         qdK7KbT/RUaf4sKvfuvIlIhQEy8kuMTpdWfgOo8u1d9N9GxTT9mn0UrsXPJElpbZww/0
         gFZw==
X-Gm-Message-State: AJIora/okulU64LEqBWzjH0yGYjSrrmvZ0PFuDvKQAO7XD7lbG5aI3ha
        50YupG6M58DqsrOAkw4inE0=
X-Google-Smtp-Source: AGRyM1tA5uOFbmCqdUcOl257wMGAaUdvz/veRfzBd7RyXGoXL0BYHVKGwGsAa72bXy/8qZWbm6LzDg==
X-Received: by 2002:a5d:6484:0:b0:219:eb95:3502 with SMTP id o4-20020a5d6484000000b00219eb953502mr3452169wri.692.1655367114079;
        Thu, 16 Jun 2022 01:11:54 -0700 (PDT)
Received: from localhost.localdomain (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d6852000000b0021552eebde6sm1121807wrw.32.2022.06.16.01.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 01:11:53 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 0/2] Replace kmap() with kmap_local_page() in zstd.c
Date:   Thu, 16 Jun 2022 10:11:31 +0200
Message-Id: <20220616081133.14144-1-fmdefrancesco@gmail.com>
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
kmap_local_page() in btrfs/zstd.c. Actually this task is only
accomplished in patch 2/2. 

Instead patch 1/2 is a pre-requisite for the above-mentioned replacement,
but, above all else, it has the purpose to conform the prototypes of
__kunmap_{local,atomic}() to their own semantic. Since those functions
don't make changes to the memory pointed by their arguments, make those
arguments take pointers to const void.

This little series has version number 4, despite it's the first time the
two component patches have been re-united in a series. This may be a
questionable choice, however patch 1/2 should be at its v4 and patch 2/2
should be at its v3. I've tried to preserve the logs of version changes,
so, as said, this new series carries v4.

Furthermore, v4 is due to the fact that for v3 (where for the first time
the two above-mentioned patches had been united in a series) I forgot to
Cc several Maintainers and lists related to patch 1/2.

Sorry for the noise I provided to whom have received this same series
twice with no changes at all.

Fabio M. De Francesco (2):
  highmem: Make __kunmap_{local,atomic}() take "const void *"
  btrfs: Replace kmap() with kmap_local_page() in zstd.c

 arch/parisc/include/asm/cacheflush.h |  6 ++--
 arch/parisc/kernel/cache.c           |  2 +-
 fs/btrfs/zstd.c                      | 42 +++++++++++++++-------------
 include/linux/highmem-internal.h     | 10 +++----
 mm/highmem.c                         |  2 +-
 5 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.36.1

