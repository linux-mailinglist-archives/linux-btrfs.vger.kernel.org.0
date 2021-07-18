Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39D23CC7FD
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 08:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhGRGtJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 02:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGRGtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 02:49:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B972C061762
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:46:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so10206221pjo.3
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbYEnk+YW3fmvpYPf2Soz9Ngvmh3VY/PwbH5LjdKdas=;
        b=vafhro4gkcyPlU8Ye47jp0ZoIgJ9rzT25Ytsh7huZIaxLcP+VOq2I9L25zwyewMdFz
         FCMZlCcZym9mDkZP+2yYsm8HQk89YSLu2OZa4Uh0SOIbdbYnSk1RxgmrwKz5v9i9ovmL
         CJxvS3u7wCW3Kt4jaVD56rX8kDT85OU0n66wCM9QsLEhkwx8jHpu12hT1s2GuCuF7rpT
         R5aP8pd6j1kNKSaTkZCoXMWpIBlGVYTRrUir7Z/uV0O6+elz6eVjD9RiLCgmEZ7/Pg4a
         jbneuDxM85V+3PyymCh4aVlJqC+EpsX4yq1pvoJxcHuokFvvLC519Bx+oXSUxOj0dOUT
         OhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbYEnk+YW3fmvpYPf2Soz9Ngvmh3VY/PwbH5LjdKdas=;
        b=czjjRL7dYseDTyJR0r8hUj5t7N+hRNt6OGG8P6JasWsyFQdgtkNbO88j/tF3PLGsjq
         +2ITrQEdjgt37F8DDax7sh2mWwL1sPkeKQyzBno+pQFl9zFUg8o7ZgPaj1eNKui9ayKO
         IXlKDi4ahMeiBliugDIRSozVmHJuq40LmVPcMy4YbEyPKWZHQAmFhCgjh5y/hj4Ni331
         tU4Nkx2Cdl4UIWOyqlHOB+HGjoFp+X3ZcxvTocJQgyK5liYK3qI7glUeQAMGJMUbEjVz
         PDistromQYwDCGe8gjxjn3WoovijJ879emuGqB3x9tQxEOufdswmWniJcryYY9DdIcoY
         2Wfw==
X-Gm-Message-State: AOAM530vtqH/a33D5ID3yuLk0NtRQJ5tJOGzrq29AZxEWtIpDuwQhYQn
        wfgiGoZjKmNgqZIujwWopcPEnroMxpU=
X-Google-Smtp-Source: ABdhPJx6DJgt7280tVPiHCCXv2FWkSLCp7xfs/JI07sDrNkSNcZOLzSI821HEVyhecQqgow5bOunxw==
X-Received: by 2002:a17:90a:6097:: with SMTP id z23mr7206285pji.172.1626590769592;
        Sat, 17 Jul 2021 23:46:09 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id w23sm1302741pfc.60.2021.07.17.23.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 23:46:09 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v4 0/2] Add subcommand that dumps file extents
Date:   Sun, 18 Jul 2021 06:45:59 +0000
Message-Id: <20210718064601.3435-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series add an subcommand in inspect-internal. It dumps file extents of
the file that user provided. For avoiding duplicated code, the patch that export
functions is in this series.

Sidong Yang (2):
  btrfs-progs: export util functions about file extent items
  btrfs-progs: cmds: Add subcommand that dumps file extents

---
v2:
 - Prints type and compression
 - Use the terms from file_extents_item like disk_bytenr not like
   "physical"
v3:
 - export util functions for removing duplication
 - change the way to loop with search ioctl
v4:
 - export COMPRESS_STR_LEN for using function safely
---

 Makefile                         |   2 +-
 cmds/commands.h                  |   2 +-
 cmds/inspect-dump-file-extents.c | 134 +++++++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 kernel-shared/print-tree.c       |  18 ++---
 kernel-shared/print-tree.h       |   5 ++
 6 files changed, 151 insertions(+), 11 deletions(-)
 create mode 100644 cmds/inspect-dump-file-extents.c

-- 
2.25.1

