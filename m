Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B783F4032
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhHVPCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhHVPCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 11:02:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271FC061575
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 08:01:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 17so14174043pgp.4
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TZICNk2ZyYDy/NkvZzhboQlxO2q8ac4pmrvAC89gLY=;
        b=j4L5ZD9mq/vVtuwF6pld9kJkm9zup+Iu/kq80r1WwBxPMpLiB1LkWAAX+NGpQ/qFYf
         8ScUZL9iFz12ceSPECixPNIIyC0UM6Ec2MKuL+vME/JN2klYifkQwF1Q10brXORZh26U
         duQ1sTBSE/GaCIFqtiUY9hcxeG8+zFvImqlWz18FvnSMM7RuM3AECSoCjNd9b4XbiQzK
         je99h2lRn+TMQJjPU9ySOxFn78tM8WVc7cn8PKQ9ZwtXVzKuVGuc0xbLojAe6yIIwxpc
         Nn6H1Qo3STzP0PDWgaMKR87+mbdwjNVQMIYQ3cVswoZWcSaP8/0+uxCg2uOeL61rwV3y
         b1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TZICNk2ZyYDy/NkvZzhboQlxO2q8ac4pmrvAC89gLY=;
        b=bATPHbt5qEjzQ2vGpYfOMwDrxFJrBqo6nrWyIybL7gmsXYj8389o+iQ2dzcLUf4Fkx
         RyPFX66Lv4ZC60SP9Y3IKrQicQAudaTpivig7iUMZ4K9ZdZop4Q7JkDfdQP2Eve55AYR
         kUXBfOY2qFjFDU5NH5Nhfs8SqJPgkcJZoKtZ0QjDuTCHFE1YHqGNWKqgvMrc0SRP4NxU
         yhHxuWFhoipUfi/wGioFqZwekRLaHU/3AdQyfuPeNmzRvaOhvxYCRpHMa1aqAnT6TMi4
         YUqEL+1sNeQ3iBIwvNaEc8cPFEQ7xQQH5KdzDRgd49lijrUs1blpGxbyvE+/4zXbhmVw
         3gsw==
X-Gm-Message-State: AOAM532pEkQ7rqR380NQU7CPvEQhY2TfYxg6Dx3Nj7it1lV2wc6w2DlG
        WYq1FHNslbA+JJRyMldeXG6BeD87DcXtng==
X-Google-Smtp-Source: ABdhPJxudgHL5S6nQfXRe1ODuC2jQwZ533AvcbUk2E484lr1TqNNK/ef1vAnL86pLX53VbE7vyoejw==
X-Received: by 2002:aa7:84c5:0:b0:3e1:16bb:6e22 with SMTP id x5-20020aa784c5000000b003e116bb6e22mr29767781pfn.32.1629644517396;
        Sun, 22 Aug 2021 08:01:57 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n185sm13992266pfn.171.2021.08.22.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 08:01:57 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC PATCH v5 0/2] Add subcommand that dumps file extents
Date:   Sun, 22 Aug 2021 15:01:38 +0000
Message-Id: <20210822150140.44152-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I'm want to print which device has the file_extent. but I don't know
how. Maybe it could be found by find block group in extent tree and find
devid in chunk tree again. I don't know it's good way to find it. is
there any good way to find devid?

This patch series add an subcommand in inspect-internal. It dumps file extents
of the file that user provided. For avoiding duplicated code, the patch that
export functions is in this series.

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
v5:
 - Supports json format
 - Print hole type by checking disk_bytenr
---

 Makefile                         |   2 +-
 cmds/commands.h                  |   2 +-
 cmds/inspect-dump-file-extents.c | 161 +++++++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 kernel-shared/print-tree.c       |  18 ++--
 kernel-shared/print-tree.h       |   5 +
 6 files changed, 178 insertions(+), 11 deletions(-)
 create mode 100644 cmds/inspect-dump-file-extents.c

-- 
2.25.1

