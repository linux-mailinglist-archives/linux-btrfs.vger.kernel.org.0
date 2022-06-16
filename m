Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FAE54DB55
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358876AbiFPHQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 03:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFPHQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 03:16:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481845BE43;
        Thu, 16 Jun 2022 00:16:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so2310736wms.5;
        Thu, 16 Jun 2022 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VF5mujp1z61uQ0mQB70iLU3OS1JG7+caH2G4EBII08=;
        b=WU8hXUA+yVaep+QEcxhWHmWYUCilcwoRWHUOmIpiZhraomm9XXJebUGTeAH/uGfwRV
         CgwIvfXINDHlYVfWyUAZTIa92q/ifIu7UnRq++Gd2blXDjF0kpcd8rwfbcsYaYbskKDm
         LL21lPAjo3j82G30dAVcWgm/+piJCO9qwTjj5Akuz6nwdtRTE4v0iSGX8N/CBH8+7rpv
         ZfYW6jWO9h3XUEzf048jvyGIRp8IFxEtkEQq8HpkP9ECqtKC4I0yBHbdgHnefaqIZMVu
         EChRbcV3eD9z5qb+ajygs24ULtuOsrJXmhZFqGgHsU0fhS7v4DRRODqG71Rki584/VJq
         xoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VF5mujp1z61uQ0mQB70iLU3OS1JG7+caH2G4EBII08=;
        b=7mGKzP5Pt2pujfXlo/Za8/WPEtXbMUiwmxnmejns7alPGJSpfit+vGBHMGTfxm3NQ5
         4lNi+yVQrwSfxjGa4dTsWgG+mSSu0E8EA0QKEhR46Kb7YLWRYXpM9FhYXTt2Q/kKFaIm
         fyrVMe4wnxZY+etaC2TVi5nwq1bg+N6XF+QIkZivrEVr5Oe9VeFe+pxbFNI7oMvFVNmI
         CBsFruGa7l3x0Mv18IoFo96swBiWse7DH5KYmCAyIBbBUkqyedHW+MyAMWK0nhe54sHN
         30/+dnE2J6AthB+SgtnxKjOmuap267ekPk8p4W6lJ5zXkYeVd9J81JtIwT7gzKvxgsqb
         tokw==
X-Gm-Message-State: AOAM530p414uX6ATldFH2IRg2ij5ZiKSsTsNOs+CPOw/bTOingwgsEnc
        92ECxYNWmAd8N8hjSsS+exjKLwOzCWg=
X-Google-Smtp-Source: ABdhPJzVwrNpx0rDj3b4jpSnNbg/sCWbD2klXs2+L5j1NaMGbb5xIgjLhhRX37Z9NGicra7o5V7vtg==
X-Received: by 2002:a7b:ce12:0:b0:39c:3cd4:4dd8 with SMTP id m18-20020a7bce12000000b0039c3cd44dd8mr13914943wmc.181.1655363761770;
        Thu, 16 Jun 2022 00:16:01 -0700 (PDT)
Received: from localhost.localdomain (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c4d0a000000b003942a244ee6sm1242770wmh.43.2022.06.16.00.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:16:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/2] Replace kmap() with kmap_local_page() in zstd.c
Date:   Thu, 16 Jun 2022 09:15:49 +0200
Message-Id: <20220616071551.12602-1-fmdefrancesco@gmail.com>
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

This little series has version number 3, despite it's the first time the
two component patches have been re-united in a series. This may be a
questionable choice, however patch 1/2 should be at its v3 and patch 2/2
should be at its v2. I've tried to preserve the logs of version changes,
so, as said, this new series carries v3.

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

