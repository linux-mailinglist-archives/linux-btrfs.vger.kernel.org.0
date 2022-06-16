Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971454EBCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378851AbiFPVA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 17:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378825AbiFPVA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 17:00:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A96006D;
        Thu, 16 Jun 2022 14:00:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so3399907wms.5;
        Thu, 16 Jun 2022 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raPY/hCjGIt20pynbedv9SDuvusSbEqlEbu0G5lGIn0=;
        b=UL70T9SBdT4nNt5Jm2X76BLM/y8crPm9BBOvZV664PpOHbcjuAVurIxpyxdvVIXvXJ
         A5/VoCI+R+IgSg5/3lVAPyB5k8b9rbKcoYsx3qTHq79lDzoIDiO80IQmmksdpbTa8BDC
         SRNJnFQXpTEd2R4S6+DvX2j+azjSFrmerdP0Utz4IzmwLbJaRVOQS5lRST8EHP1JVeGx
         WhqrFn8CFSyhAkCM2//yFXxJiOVwfa3gAb6YsuLTYmuSzfuwxup5ZTvArFsCZyvRrlXJ
         3qi0PP7FVPi2pf/wlHErE0VdZWlgGb0xTliLhealscXBsq0gdOQShA1hu8DKNUrzJGaJ
         Ks2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raPY/hCjGIt20pynbedv9SDuvusSbEqlEbu0G5lGIn0=;
        b=yvV/mxsXpUcssaPFRbkiNErNABHF4crXXyfHH3NiOCPHekB50SO8Er8T6R4F9isep1
         hLUQ4/k3zbx27HvHxkFJpX1LG25Yn+wwvUriQ1U+0OFg8h0C37OzEXjDE7X/jatfuXQc
         psfuwRWkHLLYK8jtIsRiflGCJHzNU5eQwUzAH4StNaNs9GMQU9mBOoam6woGmTYF9JgJ
         +4L7u+WVsYl/HqIUFYp/3AOrblgc57VvqLAtI2/puioZw/ULX6YRq8SbuBvJhKBqxKs3
         cpKLd94E5NbV+dDXWP1u2DBZrdGmDXS2oXr8yb/Ex58Zc5eKt6Ab94oD9rn4uUvuxy+Z
         pv+Q==
X-Gm-Message-State: AJIora/b+p/PihdIPPPrXzWIJKvG1Find7IrHnSPuUUtGt5GbEHMUw6/
        g9bqeIAEzNS9JMjtFjjUJ/E=
X-Google-Smtp-Source: AGRyM1sbuwm3ki89XTDlpELf5UO5x8ktqFA0y6YKQOdmG82oyMaOtgiF3NvWim6izHEnGX0jH2mTnA==
X-Received: by 2002:a7b:c389:0:b0:39c:49fe:25df with SMTP id s9-20020a7bc389000000b0039c49fe25dfmr6744751wmj.164.1655413253290;
        Thu, 16 Jun 2022 14:00:53 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id bt28-20020a056000081c00b0020fcc655e4asm2658043wrb.5.2022.06.16.14.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:00:51 -0700 (PDT)
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
Subject: [RESEND PATCH v4 0/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c 
Date:   Thu, 16 Jun 2022 23:00:34 +0200
Message-Id: <20220616210037.7060-1-fmdefrancesco@gmail.com>
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
__kunmap_{local,atomic}() to their own correct semantic. Since those
functions don't make changes to the memory pointed by their arguments,
change the type of those arguments to become pointers to const void.

This little series has version number 4, despite it's the first time the
two component patches have been re-united in a series. This may be a
questionable choice, however patch 1/2 should be at its v4 and patch 2/2
should be at its v3. I've tried to preserve the logs of version changes.

v4 is due to the fact that, when I sent v3, I forgot to Cc several people
and mailing lists. Furthermore, Andrew M. made me notice that I've made
confusion with the tree structure: this is why now I have to send this
series again.

I want to apologize for the noise to people who have received these two
patches more times than it should have been.

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

