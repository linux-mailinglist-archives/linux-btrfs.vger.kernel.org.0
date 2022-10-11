Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1985FB2C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJKM7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJKM6z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:58:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24992584
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:58:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E1BA22CED;
        Tue, 11 Oct 2022 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665493130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BmGTIupPGXHo/LRcUG8OZK9PG6Y9g099C7ov75Nb8nw=;
        b=Nl/SK3/R2WQ/QK2vi33c/mClTt68SRskTxiJDnwWE30qbtVtTYTl7RCFnGtGEyWFbr8RH9
        zSL/rBdpuJQ7Y49gBoDBvbnajDujJsZiEkBpLVt5u8Bo6jBGKqEuXY4kBfiA4qfPl5gTDw
        b5lb6OR5oUmXiyXFVLmAWDmRwPvhX3s=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 961112C141;
        Tue, 11 Oct 2022 12:58:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DDF01DA79D; Tue, 11 Oct 2022 14:58:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/6] Enumerated bits in enum
Date:   Tue, 11 Oct 2022 14:58:45 +0200
Message-Id: <cover.1665492943.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With some macro magic it's possible to let enum autoincrement define all
bits without manually specifying the value. How it's done is described
in the first patch, the rest are example conversions.

David Sterba (6):
  btrfs: add helper for bit enumeration
  btrfs: convert BTRFS_ILOCK-* defines to enum bit
  btrfs: convert extent_io page op defines to enum bits
  btrfs: convert EXTENT_* bits to enums
  btrfs: convert QGROUP_* defines to enum bits
  btrfs: convert __TRANS_* defines to enum bits

 fs/btrfs/ctree.h          |  9 +++--
 fs/btrfs/extent-io-tree.h | 71 +++++++++++++++++++++------------------
 fs/btrfs/extent_io.h      | 17 ++++++----
 fs/btrfs/misc.h           |  8 +++++
 fs/btrfs/qgroup.h         |  9 +++--
 fs/btrfs/transaction.h    | 18 +++++-----
 6 files changed, 78 insertions(+), 54 deletions(-)

-- 
2.37.3

