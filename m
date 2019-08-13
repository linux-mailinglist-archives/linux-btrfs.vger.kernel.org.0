Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67358BFA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfHMReU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 13:34:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33037 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHMReU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 13:34:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so10801933pgn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0ctQcqaDrrBp6sNTNEwrnOYvjCPNvxV2M36SfnWlWI=;
        b=fwgis/UMWIoUw7p5sgUG46jJs4TUcQBFjwY8pht7Q0XUnBZV3zQg9ukgDRTcFDyIWR
         /OWLxHmqK0XliLFB7yzemB92HZiCUgLiY3uoREEFqROjil0Yj5lGAQGdZd3h9cbOXRkA
         9SDy0kt7zwGu5StLGQkQHmT/uj1sMfswHSt+R/WVbXGiWbumeA4IHVX27ithODAG7X35
         ZLVPXPaRPkRiWVfeRtC5dZVQALwH4FEpFiuBOobTcPtXKPUkj7nUc1Dv14kayz812AXs
         CeE1SAcbWmp4lQ/OAuRHJnY3/xMXyHkKTES8E8rbnEgWRgMWpmXXmwhYL7k/GDoxzhTV
         Ar3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0ctQcqaDrrBp6sNTNEwrnOYvjCPNvxV2M36SfnWlWI=;
        b=uX6DWfmZPmZEmq9Cv4IUg7lkUR+ear/NZiXUXhc3OHiHUllbSni3I6UUp88T4k0qR4
         b7mn5jxITVJIqNp+moHKiPc7mYFSBFFzDk6x5nZX0FfT5ID2LQ6pOfUf52IVFPlX4QuZ
         X73U72Cg7q7IQt457lJtS5DhbRtGkoJy5WkXg7fKbVHWAefaHSFFY0UCIpOmDT2Gu/U+
         X/SXynhzfWMmA4ZL/rmID/oUpD0ZCJv9IeqqdRMyO9qBa4EoZNQbn3J7b9I/xzozeEEJ
         V0M0qrQamuoxHBRFgz4tFs+8mpclinFaCPRGpcbdzlQuzTjNZOKO5rF0uXt+qe683tXd
         5fwg==
X-Gm-Message-State: APjAAAX53+1u0OYO2HlaErXCYTTur+4a2DmJOSRN+s0uBqgNWSmBOv68
        DCinImWRAi+tln3ZKliqZOWnFt3PL8M=
X-Google-Smtp-Source: APXvYqxlEFBysxrUIGxSzEraT4WDTB6KJ2us5TBsp/cajY50bn/GqtWlwZsbWZ9e8Fu+MDVkjk9oQQ==
X-Received: by 2002:a62:144f:: with SMTP id 76mr9579358pfu.62.1565717659426;
        Tue, 13 Aug 2019 10:34:19 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::1:f9b5])
        by smtp.gmail.com with ESMTPSA id x17sm11076151pff.62.2019.08.13.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:34:18 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 0/2] Btrfs: workqueue cleanups
Date:   Tue, 13 Aug 2019 10:33:42 -0700
Message-Id: <cover.1565717247.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This does some cleanups to the Btrfs workqueue code following my
previous fix [1]. Changed since v1 [2]:

- Removed errant Fixes: tag in patch 1
- Fixed a comment typo in patch 2
- Added NB: to comments in patch 2
- Added Nikolay and Filipe's reviewed-by tags

Thanks!

1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/
2: https://lore.kernel.org/linux-btrfs/cover.1565680721.git.osandov@fb.com/

Omar Sandoval (2):
  Btrfs: get rid of unique workqueue helper functions
  Btrfs: get rid of pointless wtag variable in async-thread.c

 fs/btrfs/async-thread.c      | 79 ++++++++++--------------------------
 fs/btrfs/async-thread.h      | 33 +--------------
 fs/btrfs/block-group.c       |  3 +-
 fs/btrfs/delayed-inode.c     |  4 +-
 fs/btrfs/disk-io.c           | 34 +++++-----------
 fs/btrfs/inode.c             | 36 +++++-----------
 fs/btrfs/ordered-data.c      |  1 -
 fs/btrfs/qgroup.c            |  1 -
 fs/btrfs/raid56.c            |  5 +--
 fs/btrfs/reada.c             |  3 +-
 fs/btrfs/scrub.c             | 14 +++----
 fs/btrfs/volumes.c           |  3 +-
 include/trace/events/btrfs.h |  6 +--
 13 files changed, 61 insertions(+), 161 deletions(-)

-- 
2.22.0

