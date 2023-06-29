Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8B742E01
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjF2T6g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjF2T6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:24 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B03359C
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:21 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id AFDDB80AF9;
        Thu, 29 Jun 2023 15:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068701; bh=jHC+s/GOK/escki6A2vtNNMh/+Ds11t/HXMS9b1ffa0=;
        h=From:To:Cc:Subject:Date:From;
        b=LUhUG4ZuznxRGdlHmFfNXV7VW3nuI6tpE+S/IBszT5kDwrWE8xt4dCm1GdElJ6UIS
         QdXFKF4N5LE2wlldXd7nkTk8a91hDQl1/FZCLaubgSl31eZ4X8cbKwyvRb3wTTnN0t
         Wd8qy6arYEu4uXGhC2VNScWwgzjjS1E4sf/VBkTrTa10XAE4U4NfhqpBgF0Dm6j5Xv
         iZrEpDLG9ahhMts8Kz3NdJC3i/MZXIp8znrbeaPZvklSnOKbYsicscQGaTfs+C1104
         HYM2XhWK8UpCZFmBfJFkUPZF8tq1HiUto6G522NyHxfJOnm32YjMg7tXjlQkAe7jpN
         4fFbn6OV0we+w==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 0/8] btrfs-progs: add encryption support
Date:   Thu, 29 Jun 2023 15:57:58 -0400
Message-Id: <cover.1688068420.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the progs side of the encryption feature [1]. The first four
changes are attempts to replicate the relevant kernel changes precisely
to the equivalents in kernel-shared; the next four add support to check
and dump-tree.

[1] https://lore.kernel.org/linux-btrfs/cover.1687988380.git.sweettea-kernel@dorminy.me/T/#t

Sweet Tea Dorminy (8):
  btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
  btrfs-progs: start tracking extent encryption context info
  btrfs-progs: add inode encryption contexts
  btrfs-progs: save and load fscrypt extent contexts
  btrfs-progs: interpret encrypted file extents.
  btrfs-progs: handle fscrypt context items
  btrfs-progs: escape unprintable characters in names
  btrfs-progs: check: update inline extent length checking

 check/main.c                    | 28 ++++++++-------
 kernel-shared/accessors.h       | 31 ++++++++++++++++
 kernel-shared/ctree.h           |  3 +-
 kernel-shared/fscrypt.h         | 30 ++++++++++++++++
 kernel-shared/print-tree.c      | 64 +++++++++++++++++++++++++++++++--
 kernel-shared/tree-checker.c    | 37 ++++++++++++++-----
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h | 16 ++++++++-
 8 files changed, 184 insertions(+), 26 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h


base-commit: a0f1c5308320d781d13f6ecd8c127c6609b32281
-- 
2.40.1

