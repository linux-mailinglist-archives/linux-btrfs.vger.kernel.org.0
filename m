Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105CE539364
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbiEaOxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345345AbiEaOxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 10:53:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAAD8FFBB;
        Tue, 31 May 2022 07:53:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rs12so27075507ejb.13;
        Tue, 31 May 2022 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=beYwBzzh7tbSe8x778IfHk+2fBpa79M3lZZPBNy+pOU=;
        b=TeNh4seNqUbLrAGFCo0kIgIcwZTvnYf8LR3z1FVKFFXZTCkDmuJdo8sadoQBP++YuR
         J2fdHQ5fPF0KWc9sasn8RXAGHuX1oSz6i3u/R90AJB3QL8jMf5qX4VaTG4/e/uYETakK
         7uRuBtSWTanmAGoBaMVqB2iKPM9fVOtH8cevSxhMvmlDfAXm5rMc+g9IvfqShCLR3fqa
         neM41s7tDg8LQnKZowT1zfhFwTjMY2MVdKdPDqilfDJTpBo0LpxmkrR1d5PmmYw6ms3O
         bIwWKS7YdZ4BZtkCM5D4cqOAEWDt/yJPPXUCjB9CTUNT1JM2usmgu3NM9D04APYjNZur
         Gp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=beYwBzzh7tbSe8x778IfHk+2fBpa79M3lZZPBNy+pOU=;
        b=P5K/UqrlepbpGfDmA2Boz1eN1GZ/tio7P+S5meLCXd9d2Lyly32i5OzUDZM9gLp9a3
         6iA+hG1mtKXjDIUhkzWTvR7B2vg5XAJMPHP8Dd0BhZM7m5CKIjmD9ShBrcMYPg/IM3nE
         8WBO7W5n/wQ3/n4hSWFCD0rAGCcFFK1YIO1pZsYenW9d7yPIElO3qf4Y1+rM6xH9MjYS
         s6krmFqNI1LVaqgGH1shWH0aOcQ2CiCy0LVJYlwYOqxEF2oJBuMZWx+kdLLxQDFehxFD
         3ZuTMJJAa7tSfusTothqgRTAGLxeDnZTh08Je83ySyvZWxBHvCIYVVjLd1SK9LKGhFrh
         kQ4Q==
X-Gm-Message-State: AOAM532SC/HFCuV+Q4gx98qGBlwuGzRs6uHAeJ6LS5foLme8HtvtS2hR
        1tL8VUKeyB77CghtRUF4XLg=
X-Google-Smtp-Source: ABdhPJwA+E3ZBpGsPXmbP/nr899y3j/YF5wi66ZvsL+S1YETpLcPyT3Fej1veNGm5BWYdPWNeVefqw==
X-Received: by 2002:a17:907:9709:b0:6fd:c0e1:c86b with SMTP id jg9-20020a170907970900b006fdc0e1c86bmr52638668ejc.600.1654008827273;
        Tue, 31 May 2022 07:53:47 -0700 (PDT)
Received: from localhost.localdomain (host-79-55-12-155.retail.telecomitalia.it. [79.55.12.155])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090603c200b006fea59ef3a5sm5099779eja.32.2022.05.31.07.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 07:53:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Date:   Tue, 31 May 2022 16:53:32 +0200
Message-Id: <20220531145335.13954-1-fmdefrancesco@gmail.com>
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

This is the first series of patches aimed towards the conversion of Btrfs
filesystem from the use of kmap() to kmap_local_page().

The use of kmap() is being deprecated in favor of kmap_local_page() where
it is feasible. With kmap_local_page() the mapping is per thread, CPU
local and not globally visible.

Therefore, use kmap_local_page() / kunmap_local() in Btrfs wherever the
mappings are per thread and not globally visible.

Tested on QEMU + KVM 32 bits VM with 4GB of RAM and HIGHMEM64G enabled.

tweed32:~ # uname -a
Linux tweed32 5.18.0-torvalds-debug-x86_32+ #2 SMP PREEMPT_DYNAMIC Tue \
May 31 15:20:07 CEST 2022 i686 athlon i386 GNU/Linux

tweed32:~ # btrfs check -p ~zoek/dev/btrfs.file
Opening filesystem to check...
Checking filesystem on /home/zoek/dev/btrfs.file
UUID: 897d65c5-1167-45b4-b811-2bfe74a320ca
[1/7] checking root items                      (0:00:00 elapsed, 1774 items checked)
[2/7] checking extents                         (0:00:00 elapsed, 135 items checked)
[3/7] checking free space tree                 (0:00:00 elapsed, 4 items checked)
[4/7] checking fs roots                        (0:00:00 elapsed, 104 items checked)
[5/7] checking csums (without verifying data)  (0:00:00 elapsed, 205 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 3 items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 47394816 bytes used, no error found
total csum bytes: 44268
total tree bytes: 2064384
total fs tree bytes: 1720320
total extent tree bytes: 180224
btree space waste bytes: 465350
file data blocks allocated: 45330432
 referenced 45330432

Fabio M. De Francesco (3):
  btrfs: Replace kmap() with kmap_local_page() in inode.c
  btrfs: Replace kmap() with kmap_local_page() in lzo.c
  btrfs: Replace kmap() with kmap_local_page() in zlib.c

 fs/btrfs/inode.c |  6 +++---
 fs/btrfs/lzo.c   | 28 ++++++++++++----------------
 fs/btrfs/zlib.c  | 40 ++++++++++++++++++++--------------------
 3 files changed, 35 insertions(+), 39 deletions(-)

-- 
2.36.1

