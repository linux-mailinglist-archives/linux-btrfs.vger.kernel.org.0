Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5A5ADC1C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 02:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiIFABV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 20:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIFABU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 20:01:20 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A4E52E47
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 17:01:19 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C116080C62;
        Mon,  5 Sep 2022 20:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1662422479; bh=5/icVUmunebx+lIioksEmlm6zOChW2iPY+PWq6mpLJs=;
        h=From:To:Cc:Subject:Date:From;
        b=hEJSX0GxYY7VNyxuBkQecTRSoSR55D2D9QKRg9AfdoNJa8sdqD67bdMD+Giy+fIef
         4EnULlgnqxviluZ8IqMcwFJpgwRD0bdqkEzLx63JNFei/D9LmewPRIvSqEKA1lg6Kj
         LgnM7d1MToo3JKgpf2UXEwnTppeGKXhPuMLE/CXm6xCoahzY1XzX7WcJp0dKEhVePZ
         cTo2/pfFIzRiS4+fKWYo2xhJZvLhb0hTvFqE55scpk1tyQZPRtgov7goYY0xtRPfSQ
         3WKDIghymqEA+W1ZGKlBqQ93VCsowQxLN8FYAr3gO+TttNMftKKiT+7rB8S0mA0nhb
         jBQ+cuKgBSACA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 0/6] btrfs-progs: add encryption support
Date:   Mon,  5 Sep 2022 20:01:01 -0400
Message-Id: <cover.1662417859.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This changeset is a minimal set of changes to adapt to the kernel-side
changes for encryption in [1].

While the kernel-shared files could be updated to use fscrypt_names in
closer analogue to the kernel versions of the files, that is planned as
a followup.

[1] https://lore.kernel.org/linux-btrfs/cover.1662420176.git.sweettea-kernel@dorminy.me

Changelog: 

v2:
  - updated to match kernel changeset's fscrypt extent contexts and
    changed format storing encrypted context length.
v1: 
  - https://lore.kernel.org/linux-btrfs/cover.1660729916.git.sweettea-kernel@dorminy.me

Sweet Tea Dorminy (6):
  btrfs-progs: add fscrypt support to mkfs.
  btrfs-progs: update to match renamed dir_type
  btrfs-progs: interpret encrypted file extents.
  btrfs-progs: handle fscrypt context items
  btrfs-progs: escape unprintable characters in names
  btrfs-progs: check: update inline extent length checking

 check/main.c               | 32 ++++++++++---------
 check/mode-common.c        |  4 +--
 check/mode-lowmem.c        |  6 ++--
 cmds/restore.c             |  2 +-
 common/fsfeatures.c        | 10 ++++++
 kernel-shared/ctree.h      | 51 +++++++++++++++++++++++++++---
 kernel-shared/dir-item.c   |  8 ++---
 kernel-shared/fscrypt.h    | 27 ++++++++++++++++
 kernel-shared/inode.c      |  4 ++-
 kernel-shared/print-tree.c | 64 +++++++++++++++++++++++++++++++++++---
 libbtrfsutil/btrfs.h       |  2 ++
 libbtrfsutil/btrfs_tree.h  |  3 ++
 12 files changed, 178 insertions(+), 35 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h

-- 
2.35.1

