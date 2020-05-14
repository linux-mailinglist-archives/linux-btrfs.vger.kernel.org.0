Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6336D1D2B85
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgENJfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 05:35:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50412 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENJfA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 05:35:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id m12so24550412wmc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 02:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tyhjMaUQzo8bA0rgRdEpeMknJatA3rYifd0Lg/h3B0g=;
        b=Dh52+7zOpGh2VsDHR9XSz02TWzIUeddBvrDI45G+twkz7RZ7tM96OfmFU8dM6wA5VK
         M3skK3aOEK5rAAs8duOtnXbrwu+Z3XwxiwKqTcy9gEjpSbC5jhVTW+q4lU+C1EEQJLY2
         8ZT0c/Ts/RlHeE/9SLTf5trbUTCH5l2n6O+PQZHzpibzym4YTAunQVNqOeIn3BIpFFSg
         afza+vUpMR/Rpmz8J6rmbURTdKdpJhdqUGYgba50jO8YkSSu5a0r6sm0O8kMZe40iEep
         jw/VQABgan72xisPrGtdO1hGrksxse7/ICD0he4XWx3My0mpRwOmlSeFmLhM8bEsW4At
         fvOw==
X-Gm-Message-State: AGi0PuYp+btOBho9k6YxwYhf9H68uQxFlfi2SHhJrxVegQGN3TSiszFn
        FqJM5R8qoISUp5pQA0tFDf8=
X-Google-Smtp-Source: APiQypJHspnb+qPZHGU2jM3iJ6UchIoq4GIp8/EuhDtyT4Z7SYREl/SebuyivgQerdaxXTDr5iv9uA==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr47838101wmd.95.1589448898016;
        Thu, 14 May 2020 02:34:58 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id l12sm3522750wrh.20.2020.05.14.02.34.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:34:57 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/5] btrfs-progs: support creating authenticated file-systems
Date:   Thu, 14 May 2020 11:34:28 +0200
Message-Id: <20200514093433.6818-1-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This series adds support for passing in an authentication key and using
HMAC(SHA256) for mkfs, dump-super and fsck.

Changes since v1:
- re-sync csum type with kernel

Johannes Thumshirn (5):
  btrfs-progs: pass in fs_info to btrfs_csum_data
  btrfs-progs: add auth_key argument to open_ctree_fs_info
  btrfs-progs: Add HMAC(SHA256) support
  btrfs-progs: add --auth-key to dump-super
  btrfs-progs: add auth key to check

 btrfs-find-root.c           |  2 +-
 btrfs-sb-mod.c              |  4 ++--
 check/main.c                | 15 +++++++++++---
 cmds/filesystem.c           |  2 +-
 cmds/inspect-dump-super.c   | 38 +++++++++++++++++++++++++-----------
 cmds/inspect-dump-tree.c    |  2 +-
 cmds/rescue-chunk-recover.c |  4 ++--
 cmds/rescue.c               |  2 +-
 cmds/restore.c              |  2 +-
 common/utils.c              |  3 +++
 configure.ac                |  1 -
 convert/common.c            |  2 +-
 crypto/hash.c               | 30 ++++++++++++++++++++++++++++
 crypto/hash.h               |  2 ++
 ctree.c                     |  1 +
 ctree.h                     |  3 +++
 disk-io.c                   | 39 +++++++++++++++++++++++--------------
 disk-io.h                   |  8 +++++---
 file-item.c                 |  2 +-
 image/main.c                |  5 +++--
 mkfs/common.c               | 10 ++++++++++
 mkfs/common.h               |  3 +++
 mkfs/main.c                 | 25 ++++++++++++++++++++++--
 23 files changed, 157 insertions(+), 48 deletions(-)

-- 
2.26.1

