Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F51BBC03
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgD1LLe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 07:11:34 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37295 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgD1LLe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 07:11:34 -0400
Received: by mail-wm1-f45.google.com with SMTP id z6so2400550wml.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 04:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gYDydGQtXvgBW1agdD/MU4YV2iQTL3pAF8uLk1Fg8hQ=;
        b=Lk8qCQyEmFiOGpVhD23MzdienvKCkdCWluSDBvxigJu7eufz2IKxOQCocwG5CBg1Q+
         IivrXYTuH3hhsh+3lEbdgMtywz/tv3N4cAZNZYPUucwqgg+WqAeQ4Ap7Mv/n/dZKP79M
         V4af1KZSmjIki/D/hTjubkq38zppbRAkoVDOiccT00IviYMjgbAivBJ/e0GzfU0L0ott
         W1vCEkHDHijUi6nvwmhhUuFRVFKnX8FdEVNWhBA1+ZZSS0jtkG0UfVtCAztEHMEdDjOB
         JFDscRNty47PSz3MkFywPs1YXRCTeWhd9wFvoqxMOEjyK1Zmtqb8D+OIAHmzpA0p6c1P
         vTDQ==
X-Gm-Message-State: AGi0PuYBG5mfpe3k0GZqlMkQo/5pvI9bYdFPPYyUqGgO11OL4twlnDF5
        Tfh9PMDq/pBKP8LwC9CL3bY=
X-Google-Smtp-Source: APiQypJEzl7ho0lDjc6iCH0WZgwtVWjoZmG0btBI6/ZsmFPRdJn4Q7iGKvlKl4F91vuGpEr+YSerAw==
X-Received: by 2002:a1c:3c54:: with SMTP id j81mr3916825wma.140.1588072291262;
        Tue, 28 Apr 2020 04:11:31 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-205-206.dynamic.mnet-online.de. [46.244.205.206])
        by smtp.gmail.com with ESMTPSA id b191sm3126291wmd.39.2020.04.28.04.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:11:30 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] btrfs-progs: support creating authenticated file-systems
Date:   Tue, 28 Apr 2020 13:11:03 +0200
Message-Id: <20200428111109.5687-1-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This series adds support for passing in an authentication key and using
HMAC(SHA256) for mkfs, dump-super and fsck.

Johannes Thumshirn (5):
  btrfs-progs: pass in fs_info to btrfs_csum_data
  btrfs-progs: add auth_key argument to open_ctree_fs_info
  btrfs-progs: Add HMAC(SHA256) support
  btrfs-progs: add --auth-key to dump-super
  btrfs-progs: add auth key to check

 btrfs-find-root.c           |  2 +-
 btrfs-sb-mod.c              |  4 ++--
 check/main.c                | 15 ++++++++++++---
 cmds/filesystem.c           |  2 +-
 cmds/inspect-dump-super.c   | 38 +++++++++++++++++++++++++++-----------
 cmds/inspect-dump-tree.c    |  2 +-
 cmds/rescue-chunk-recover.c |  4 ++--
 cmds/rescue.c               |  2 +-
 cmds/restore.c              |  2 +-
 common/utils.c              |  3 +++
 configure.ac                |  1 -
 convert/common.c            |  2 +-
 crypto/hash.c               | 23 +++++++++++++++++++++++
 crypto/hash.h               |  2 ++
 ctree.c                     |  1 +
 ctree.h                     |  3 +++
 disk-io.c                   | 39 ++++++++++++++++++++++++---------------
 disk-io.h                   |  8 +++++---
 file-item.c                 |  2 +-
 image/main.c                |  5 +++--
 mkfs/common.c               | 10 ++++++++++
 mkfs/common.h               |  3 +++
 mkfs/main.c                 | 25 +++++++++++++++++++++++--
 23 files changed, 150 insertions(+), 48 deletions(-)

-- 
2.16.4

