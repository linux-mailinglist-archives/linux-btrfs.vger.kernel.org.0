Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750C977444F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHHSQy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjHHSQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:16:20 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210C7C700
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:22:59 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 30EBD83548;
        Tue,  8 Aug 2023 13:22:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515379; bh=q6STkfWs95xOx/ABWfh893/5VkgOTWqqO2WZ02db+2s=;
        h=From:To:Cc:Subject:Date:From;
        b=JasaeK8FH8nqwhiR6NYXZmSEU1PEu7BEXUGMeellQGzAJZoE7kFwElihHdTdyeryb
         OC9NSpJ7IwdxKx2hS3Usi77vNDsjSzd7BbARTu6n1fGNIfkFaOk0Tf757ncoTXVSzJ
         0bU3MY7h+Chn0Ap613YktExSEQm7V5EtBnNe5jIaiTMWqo+tCYfguCh1q0690LXRLq
         edHOYJk80xdHHBlLnYeXC0Q1emy83ChyLySBaoDDrvaGRsll9aCNambKWr834tQxh1
         C73PV+FVkpryQIlW70YaYlYCjHfeYaB3UtuMZqhOU4Bl5/Tdn8d2SbZYoqFexXetJr
         SxDFr9rS2+4Tg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 0/8] btrfs-progs: add encryption support
Date:   Tue,  8 Aug 2023 13:22:19 -0400
Message-ID: <cover.1691520000.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

[1] https://lore.kernel.org/linux-btrfs/cover.1691510179.git.sweettea-kernel@dorminy.me/

Changelog:
v2:
- updated to match new extent context format

v1: 
- https://lore.kernel.org/linux-btrfs/cover.1688068420.git.sweettea-kernel@dorminy.me/

Sweet Tea Dorminy (8):
  btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
  btrfs-progs: start tracking extent encryption context info
  btrfs-progs: add inode encryption contexts
  btrfs-progs: save and load fscrypt extent contexts
  btrfs-progs: interpret encrypted file extents.
  btrfs-progs: handle fscrypt context items
  btrfs-progs: escape unprintable characters in names
  btrfs-progs: check: update inline extent length checking

 check/main.c                    | 29 ++++++++-------
 kernel-shared/accessors.h       |  2 ++
 kernel-shared/ctree.h           |  3 +-
 kernel-shared/fscrypt.h         | 25 +++++++++++++
 kernel-shared/print-tree.c      | 64 +++++++++++++++++++++++++++++++--
 kernel-shared/tree-checker.c    | 37 ++++++++++++++-----
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h | 16 ++++++++-
 8 files changed, 151 insertions(+), 26 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h


base-commit: 9a7c1226664ab3145f7382ffeae80770bd2d8d3a
-- 
2.41.0

