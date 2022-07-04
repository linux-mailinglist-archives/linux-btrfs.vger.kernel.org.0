Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962335659AE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 17:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiGDPXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 11:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGDPXb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 11:23:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C765C5;
        Mon,  4 Jul 2022 08:23:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so5888620wmi.0;
        Mon, 04 Jul 2022 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xM5MK26CZ/c80sgGRiAvi/tYGUd6tin4tICi/jLr3g=;
        b=StziVOwR2dqeGT1vkrtGCUdDAS1P9FphpWD52LirNPf3iqYLtKZmz96p6YLOKpyirW
         Xg8JOmCVBVJAAgA7tHVbxrmMaFg7Gh5oxqY5L3mjEIfMUEADw3V729BEfgHKPuDN7HSZ
         hghcl2Y9AQyVE1zfSWC2uyJnOhLIHDj20IkjS4W8ow0xEEwULbIC5anBQ+7XAVulGgDh
         KrvXgKdOdn5ttyZmEM9b9hfPmNqv9SaQO0HN/rBE/ePL5T/JOhk+y4ZlbCQknX1+CxkY
         uigE6jI+scbqDnD/Sm5hiEYq9Gfbupw2sCW/y4S21GQvilSXMyNd61Jg1AMbi2DNC16w
         AR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xM5MK26CZ/c80sgGRiAvi/tYGUd6tin4tICi/jLr3g=;
        b=iYCNssxbJjgViLts+ylTWQG5rt0RPXUzdDxRBJCVQwEWelaBRhfx65858QMEUvXNa0
         fV3DSI7HQS9nPxaqnZTb+jSMRRtm7cakwleaz5XR4eqSBXd22aRqUo8X7zQjVS0TeMqS
         Et3X22Ja3z1gjOADE2AWe4KopKdWcJ96ykwH/ZRqXzdyNwC6d4yNtOqTLEZ97/oAVTaP
         qECXWC+EAqs0veXXNYx//q5dZNHwK8GiyMLcYY5qd0jFW2nXPTTR8g2r9OX9EzQgCrbO
         H5wThg/xStuxmQLAl8Tq4IlGLrAI1rC9xZplsonXNYTbZ/uLuhwPs0/E8iWxT3ut5xhR
         JFnw==
X-Gm-Message-State: AJIora+zlxna/XnvYzWUmCpJdUd9RNgFYpVuhAlfcPNrXVMBCVAIfZ8F
        zlTrFk741F7TsSXF9W4U+yo=
X-Google-Smtp-Source: AGRyM1vzf20CdbFist58GfvoI3TvwOK/hr0xIWe08/cnfGoFCg1oShfoM7s/f5wOgE994h/OSlOlmg==
X-Received: by 2002:a05:600c:500a:b0:3a1:8c53:9bd5 with SMTP id n10-20020a05600c500a00b003a18c539bd5mr20226182wmr.82.1656948209080;
        Mon, 04 Jul 2022 08:23:29 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id p28-20020a1c545c000000b003a02de5de80sm16089631wmi.4.2022.07.04.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:23:27 -0700 (PDT)
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
Subject: [PATCH v5 0/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Mon,  4 Jul 2022 17:23:20 +0200
Message-Id: <20220704152322.20955-1-fmdefrancesco@gmail.com>
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

v4 -> v5: Use plain page_address() for pages which cannot come from Highmem
(instead of kmapping them); remove unnecessary initialisations to NULL
(thanks to Ira Weiny).

v3 -> v4: Resend and add linux-mm to the list of recipients (thanks to
Andrew Morton).

Fabio M. De Francesco (2):
  highmem: Make __kunmap_{local,atomic}() take "const void *"
  btrfs: Replace kmap() with kmap_local_page() in zstd.c

 arch/parisc/include/asm/cacheflush.h |  6 ++---
 arch/parisc/kernel/cache.c           |  2 +-
 fs/btrfs/zstd.c                      | 34 ++++++++++++----------------
 include/linux/highmem-internal.h     | 10 ++++----
 mm/highmem.c                         |  2 +-
 5 files changed, 24 insertions(+), 30 deletions(-)

-- 
2.36.1

