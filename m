Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2020C4F1C4E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380854AbiDDV0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379558AbiDDRbP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:31:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C8B615E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:29:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso417283pjb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Y/xPGZPRltwnNLJkEW7Y4NAxYs+n4k2Vm++2BZkKAE=;
        b=XdBP9nOyNj2izVDrfPDMvFI3ICNCGrUWpmuhWOldW9G0CnSOkJIw6S05gqcts9abw5
         wgKR4ngRtwBMTtPfs9r35lOG2w48VrLNBE7uU/p2agjORqtkcsYReoUHmmmWbbGHNpYH
         TLsGpt0zauvSyZsvqQCHkDXW+HefcJ176c4vZJa5Ipgck3DuZDyhuZhJdqFgL5blPjs+
         TBPlLc9XONOhx8OBd10HD3Imu1muue1MrCi7EOCEi/rXyjnVgdX1PVhJ8m9d+6xCoO7w
         LNtqcKVPWX8f+D0G0Sad1tncSKnj/nFOGNWDPvR5hIfiwAUZA+tf8YexUkWF+J7HMWO+
         Zr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Y/xPGZPRltwnNLJkEW7Y4NAxYs+n4k2Vm++2BZkKAE=;
        b=KDJjKOT6wofRF55M3CT+irnYGGxWCqGKH1UmqKy5kVuzRINuVyeRnmjpup7usE0Ed5
         e4cgm+Q6f1BdQUhBQQRIwAAx6vWYznIyGsGagdNY/n1XhazGhMjEXewNIPuCiZAtFdxW
         GMJjgS1gcPtkioYB4ImHscTih97Vpho9NOxKSQtmJfefpf1dZXNoe4kdsfkTSJmP+ajb
         FLd9NT3x+KbHrKmCbhOuMsyxR/Ux0pCiTqqtIm50bTsC32Q84mf7HwKc2XzRgQjuouYq
         uBOkKtjUqY+dR3K8Rp6gBk73AyOugH+5fGA3SWdzINgXSfM6kMoTQVsBiamGgWxlwXUE
         2uXw==
X-Gm-Message-State: AOAM532pOAYqOZY0XSQ98YmGuVGW23A+e4br245rJ9YXfAT5pYafak2e
        3RHesjRvLY1kYHm2MAk2aYQSRenmWCifMw==
X-Google-Smtp-Source: ABdhPJymdThgFYqRdewg+CRmfdznmdwOCcayfm10Q8KAuflr4YRR0tWIFr2aisbubqI2oTUg2lONJg==
X-Received: by 2002:a17:90a:9f0b:b0:1ca:4647:a447 with SMTP id n11-20020a17090a9f0b00b001ca4647a447mr255473pjp.11.1649093358119;
        Mon, 04 Apr 2022 10:29:18 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:eb9])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm12880787pfv.123.2022.04.04.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:29:17 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v15 0/7] btrfs: add send/receive support for reading/writing compressed data
Date:   Mon,  4 Apr 2022 10:29:02 -0700
Message-Id: <cover.1649092662.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series adds support for sending compressed data via Btrfs send and
btrfs-progs support for sending/receiving compressed data and writing it
with BTRFS_IOC_ENCODED_WRITE, which was previously merged into
misc-next. See the previous posting for more details and benchmarks [1].

Patches 1 and 2 are cleanups for Btrfs send. Patches 3-5 prepare some
protocol changes for send stream v2. Patch 6 implements compressed send.
Patch 7 enables send stream v2 and compressed send in the send ioctl
when requested.

Changes since v14 [2]:

- Added a comment about "put_data" to patch 4.
- Replaced hard-coded 2s with sizeof(__le16) in patch 4.
- Replaced patch 5 with new approach using vmalloc() + vmalloc_to_page()
  (instead of alloc_page() + vmap()) as suggested by Sweet Tea.
- Added Sweet Tea's reviewed-bys.
- Rebased on latest misc-next branch.

The btrfs-progs patches are unchanged since v14, so I'm not resending
them this time.

1: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
2: https://lore.kernel.org/linux-btrfs/cover.1647537027.git.osandov@fb.com/

Omar Sandoval (7):
  btrfs: send: remove unused send_ctx::{total,cmd}_send_size
  btrfs: send: explicitly number commands and attributes
  btrfs: add send stream v2 definitions
  btrfs: send: write larger chunks when using stream v2
  btrfs: send: get send buffer pages for protocol v2
  btrfs: send: send compressed extents with encoded writes
  btrfs: send: enable support for stream v2 and compressed writes

 fs/btrfs/ctree.h           |   6 +
 fs/btrfs/inode.c           |  13 +-
 fs/btrfs/send.c            | 320 +++++++++++++++++++++++++++++++++----
 fs/btrfs/send.h            | 142 +++++++++-------
 include/uapi/linux/btrfs.h |  10 +-
 5 files changed, 392 insertions(+), 99 deletions(-)

-- 
2.35.1

