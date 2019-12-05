Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0339B113ACD
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfLEE3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:30 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45130 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:30 -0500
Received: by mail-lf1-f50.google.com with SMTP id 203so1346865lfa.12
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mksnn918/RO1lMo+VF/LvsAOFQvine+Ga6NbDFkpuE0=;
        b=e4sfRw/Um4iAnZ0IvQyaC4bxK1cDb9oZQq1A+YhV3CKZ7k37JfGU0d+FIdPV9J3BFn
         HmHb6Zbn97w+dKwUYqc5q8epjii4VU06zdQmWbRxvOctH0RYp2jjNyJQkuyhGNmEKNVf
         eqq94DvHUECK4gMpIsG83Plsm3anv0bzE3tWWPnaN93oTiORJJIxeq2y+gaRK61rDzAE
         7R2r3PqkkxsntaKWfI2EuQeveq1M1akWfizFQer2witXcxZdlp+4D0Sj9xGfNHJ/TV0y
         WDImA9vFl14jokWhc+HcQpidh2NUIGqAuTWoc+2aPx1uZDoI/0I1/j+8Zi2rZx+8uhDu
         sHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mksnn918/RO1lMo+VF/LvsAOFQvine+Ga6NbDFkpuE0=;
        b=AlhDOFzAEbNsRvSeXlNPxltaSH8BdVu9oiqibVXBMPYG0ljKK+AvvrgR9KKH2GxeC2
         gac70xhUPsmEMKIlDR3XnLuaaixy7F+kg2xORLZ5Mw1yn3qevcmxgf/N7a15dblCyClL
         TnNr1yFvlG2uVqgV81IzswJxGWoqaRs65gSEzHr+UTVlYqcMQP5UBATeKHNDsB25lMle
         yyvoqJTrwkUQg/65aS6d0C2l6fhwmI0UlToUGMqK0+Yltkf8/h0Ans9x3H1QL8C0G9UP
         sjO/naGRq29vWiWahlC6u68X0NqeY8SOLSybdgqSESEpqFYrG6MfKbI1u4Ek7d+iCkM9
         IylA==
X-Gm-Message-State: APjAAAVwgrPxBl3SXaxO/+rm7DEawgLbSXDOAtuBqmgtEQq5ZbKiSVXB
        evob1wD4C+AcKOhklndEERS8PDwKwrU=
X-Google-Smtp-Source: APXvYqx08HlWee/W239GFCLCv2TMNBwvIegyv1nK+HTGs/I7JfgaCFtOgPxSsiAsYetkn3NglacYWA==
X-Received: by 2002:a19:a403:: with SMTP id q3mr386682lfc.66.1575520168145;
        Wed, 04 Dec 2019 20:29:28 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:27 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 00/10] unify origanization structure of block group cache
Date:   Thu,  5 Dec 2019 12:29:11 +0800
Message-Id: <20191205042921.25316-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Avaiable on https://github.com/Damenly/btrfs-progs/tree/bg_cache_reform

In progs, block group caches are stored in btrfs_fs_info::block_group_cache
whose type is cache_extent. All block group caches adding/finding/freeing
are done in the misleading set/clear_extent_bits ways. However, kernel
side uses red-black tree structure in btrfs_fs_info directly. The
latter's structure is more reasonable and intuitive.

This patchset transforms structure of block group caches from cache_extent
to red-black tree and list.

patch[1] handles error to avoid warning after reform.
patch[2-6] are about rb tree reform things in preparation.
patch[7-8] are about dirty block groups linked in transaction in preparation.
patch[9] does replace works in action.
patch[10] does cleanup.

This patchset passed progs tests and did not cause any regression.

Su Yue (10):
  btrfs-progs: handle error if btrfs_write_one_block_group() failed
  btrfs-progs: block_group: add rb tree related memebers
  btrfs-progs: port block group cache tree insertion and lookup
    functions
  btrfs-progs: reform the function block_group_cache_tree_search()
  btrfs-progs: adjust function btrfs_lookup_first_block_group_kernel
  btrfs-progs: abstract function btrfs_add_block_group_cache()
  block-progs: block_group: add dirty_bgs list related memebers
  btrfs-progs: pass @trans to functions touch dirty block groups
  btrfs-progs: reform block groups caches structure
  btrfs-progs: cleanups after block group cache reform

 check/main.c                |   6 +-
 check/mode-lowmem.c         |   6 +-
 cmds/rescue-chunk-recover.c |  10 +-
 ctree.h                     |  29 ++--
 disk-io.c                   |   4 +-
 extent-tree.c               | 306 +++++++++++++++---------------------
 extent_io.h                 |   2 -
 image/main.c                |  10 +-
 transaction.c               |   8 +-
 transaction.h               |   3 +-
 10 files changed, 169 insertions(+), 215 deletions(-)

-- 
2.21.0 (Apple Git-122)

