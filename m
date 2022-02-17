Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD79F4B9FD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiBQMM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 07:12:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiBQMM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 07:12:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A2DED2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 04:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E566102C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C0BC340E8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645099931;
        bh=H90pEUa+WPIn02XBwRiaShygYUiBZQ5Fc8m8giBynk4=;
        h=From:To:Subject:Date:From;
        b=py6GVF3uhpmla86Lju+9Qx+aEFaNUzW53n/2lFfz7o50uaVwb94gg1XjWhXfz5krI
         Bf32nQd/ResyBXJ2TAgDFU13Jdw24GZ3bYR/yHKIZYoRA++1eL2JcTZpRWI74kqP0X
         9TBWntMofFNbbXcc1Uty9jrUDzglvTcj+FfWZo0bzIsSPj2ucoj0f/j/6OEHh0ICn/
         Ob4AdDvXhLIZgweEL2dnucn9t5wFrUZ849gYQCIQvCB4aMdI6AMfHhv6umY1U5Fa+P
         kXyFZeWotJDkik73FKuiRupnFFfFhtvPIJPiHaONQVas22W9ddEAXk5eiEHxwkYpHJ
         jzlLDvyyFFfEQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: a fix for fsync and a few improvements to the full fsync path
Date:   Thu, 17 Feb 2022 12:12:01 +0000
Message-Id: <cover.1645098951.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This fixes a bug (first patch) with preallocated extents beyond eof being
lost after a full fsync and a power failure. The rest is mostly some
improvements to the full fsync code path (less IO, use less memory for
logging checksums, etc), and silence smatch about a possible dereference
of an uninitialized pointer. More details in the changelogs.

Filipe Manana (7):
  btrfs: fix lost prealloc extents beyond eof after full fsync
  btrfs: stop copying old file extents when doing a full fsync
  btrfs: hold on to less memory when logging checksums during full fsync
  btrfs: voluntarily relinquish cpu when doing a full fsync
  btrfs: reset last_reflink_trans after fsyncing inode
  btrfs: fix unexpected error path when reflinking an inline extent
  btrfs: deal with unexpected extent type during reflinking

 fs/btrfs/btrfs_inode.h |  30 +++++
 fs/btrfs/file.c        |   7 +-
 fs/btrfs/inode.c       |  12 +-
 fs/btrfs/reflink.c     |  39 +++---
 fs/btrfs/tree-log.c    | 285 +++++++++++++++++++++++++++--------------
 5 files changed, 254 insertions(+), 119 deletions(-)

-- 
2.33.0

