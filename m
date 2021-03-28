Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C834BAA1
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhC1EV3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhC1EVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26BC061762;
        Sat, 27 Mar 2021 21:21:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q12so4935051qvc.8;
        Sat, 27 Mar 2021 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzA2D6eu/ilzvze7gZb1rkcdrb6w8qBD4NuP2f4sb4Y=;
        b=b4YQeKe3jnM6mRHLD86gSsvyfonnMtDfeivqjmMHu7Uw0+xoD30C4RzAS09K1XaU2s
         tAeIcenM/M/1bCk6yGwNdkOkFQ3GbHEQQbBJLL/m+wxVG2K5yumuCT1PZk48r15x2Qc7
         Txk7Fz7CiZy4JQp13scWHd83NUDGii5x9oC0X+jt4TXG6j2bcb6HxDWh3VRpW4zbKHnx
         QetreRmS30N73f3sdUawHYCy4gMnOBX9itUdYwedZqel9VTMAHaQo65GxxNBwL3jrHKd
         DZ5b76apjq6OJzyBEkB0Mk0VHR4NFIZQ0FNttykr8W4LIq6vJffEGJkutRRZQRvO5x+0
         1+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzA2D6eu/ilzvze7gZb1rkcdrb6w8qBD4NuP2f4sb4Y=;
        b=aS9p/rRtaKVXKVfZ/UCM/n9VNzmrPy6qJIYNLW/gE/WGf2q26PzpnC4A859N29U2Jg
         ZEtmMKoKbUNVmHLDOsBLpDS2aR2Wm1v8Y7uCSpOTD+qvIqLSyzwZe339yr4eyljiAisE
         okbHWInxh8XdXXeRD+ejX4p3+2woIFJWUSGPQ+8DfpMwPcYEG3eRkMDK9z5BHW6iJFCG
         n7eIpaWYwBBipi9W8fYpJozKYGj5AljSWF1NEzJ9EGbDucsMY+N9nLC9h6P5KwLadFhE
         nWyhS640zL0H1KojEunVPIHTQgPYeePWPK/QYCdGxjEjsxaKYBLUH25vK34p01jE4cSt
         vX9A==
X-Gm-Message-State: AOAM533lDmuKYnqXo/yCZd4Te4Sc0qGaQFBFzyD00Mywsm4n2nWy9BJr
        J+U/Qz9naCAg9QXLYuVekz0=
X-Google-Smtp-Source: ABdhPJxHaAa2aQXxWBx0VCKY4ct48AlCgI+pZAjEUOZovENBULurnaoyhbqDmEUD8QYK5mlNhaQNeA==
X-Received: by 2002:a05:6214:326:: with SMTP id j6mr20015542qvu.13.1616905268983;
        Sat, 27 Mar 2021 21:21:08 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:08 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] BTRFS: Mundane typo fixes
Date:   Sun, 28 Mar 2021 09:48:24 +0530
Message-Id: <cover.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series fixes trivial typos as they appear in the files.

Bhaskar Chowdhury (10):
  extent-map-tests.c: A typo fix
  dev-replace.c: A typo fix
  ioctl.c: A typo fix
  zoned.c: A typo fix
  inode.c: Couple of typo fixes
  scrub.c: Fix a typo
  locking.c: Fix same typo in couple of places
  volumes.c: Fix a typo
  extent-tree.c: Fix a typo
  disk-io.c: Fix a typo

 fs/btrfs/dev-replace.c            | 2 +-
 fs/btrfs/disk-io.c                | 2 +-
 fs/btrfs/extent-tree.c            | 2 +-
 fs/btrfs/inode.c                  | 4 ++--
 fs/btrfs/ioctl.c                  | 2 +-
 fs/btrfs/locking.c                | 4 ++--
 fs/btrfs/scrub.c                  | 2 +-
 fs/btrfs/tests/extent-map-tests.c | 2 +-
 fs/btrfs/volumes.c                | 2 +-
 fs/btrfs/zoned.c                  | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

--
2.26.2

