Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC270985
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfGVTPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 15:15:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44849 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfGVTPM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 15:15:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so18120862pgl.11
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KO6QNi1czS2xaRvdxXcaxuw0qRfpSHa2OeD6iAGhpeM=;
        b=eDz7i7g1KVGiQF0KNSjLr2UCY9SgG5niuH6kOC8WpdKfbZdyUan6vL1K8g68lZK21z
         2GADWZoif7QkaECv1Z0hNokSigZO3NwiaPNRQ56sZIp4Tsuw+fgk6mCt0tuYuW4Fe4rw
         D8G+5ftezZNOiAzhJgNwJhJjhteqSw8uVLfHNc+Gua7ba3cS/gRzS9xfumKLXPi5hWBi
         GyPBCqJN9zMFd19cFla7MFYy9nRixuvU5bYB+K3A+DGdQbfSlYce/2BVjwbInlFFaKQm
         mc2LS9GvKjWHZK0Y5d4REEaJhf4oFv2ZPTSrKHunPQT3VmkgfNThCvOFncLFuSfIIDbm
         jS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KO6QNi1czS2xaRvdxXcaxuw0qRfpSHa2OeD6iAGhpeM=;
        b=FUArpxVRRll6YIB/E/Dce+16e5syQNN87yhnopWlmh7h7x1cg8Dr5hYs4OU7OMl9Vf
         cmwisk5/4qXGUc3A24EwiAa1MwCBU6JegGLC/cTEAMzrHINtso+DF1wWGgw5e1UllQYn
         YWckWZh2xmyX312FmdYOAC44IJ9UOT1Ez1wxdB/EvOH6IjqJA5GXnloQ/L6NClgCUvsr
         yBWYZfsQjdzyrWhsNflnWgFgJvQWiddlgADhA3gkRaBY07LTm1iTT4VZ92yzfSL/TIJG
         tB2T6QqTa/WbnbLE2NYhIKhny+cnT0mB7D6+6r6yqQT9rPOWAZuOwbhP3YdYo6fvrcXI
         BgIw==
X-Gm-Message-State: APjAAAX7jClnemwuUltrBBSyRlbK3MwCBsuAG+8i4MdXcN4O+0epgXM3
        vEFfVlpvC7IojeWCQ2Xek+mGrz4r3us=
X-Google-Smtp-Source: APXvYqw5SezMVFUviGGCAe9NEZ8CAJjuRarF/Zdt6/x9bySiCizt3BC0g6W80OcdV52q1ScgmHQjKA==
X-Received: by 2002:aa7:8106:: with SMTP id b6mr1739165pfi.5.1563822911808;
        Mon, 22 Jul 2019 12:15:11 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:a31b])
        by smtp.gmail.com with ESMTPSA id t11sm47262048pgb.33.2019.07.22.12.15.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:15:11 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 0/4] btrfs-progs: fix clone from wrong subvolume
Date:   Mon, 22 Jul 2019 12:15:01 -0700
Message-Id: <cover.1563822638.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is v2 of [1]. Changes from v1:

- Split out removing commented-out code to new patch 1 and removed a
  related comment block.
- Made subvol_path const char * in patch 2.
- Added test case as patch 4.
- Fixed wrong signed-off-by.

Thanks,
Omar

1: https://lore.kernel.org/linux-btrfs/cover.1563600688.git.osandov@fb.com/T/#u

Omar Sandoval (4):
  btrfs-progs: receive: remove commented out transid checks
  btrfs-progs: receive: get rid of unnecessary strdup()
  btrfs-progs: receive: don't lookup clone root for received subvolume
  btrfs-progs: tests: add test for receiving clone from duplicate
    subvolume

 cmds/receive.c                                | 50 ++++---------------
 .../test.sh                                   | 34 +++++++++++++
 2 files changed, 45 insertions(+), 39 deletions(-)
 create mode 100755 tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh

-- 
2.22.0

