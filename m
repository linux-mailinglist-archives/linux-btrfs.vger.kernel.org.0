Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9907524E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGMORL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjGMORC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:17:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6196B2733
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:16:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 045422215C;
        Thu, 13 Jul 2023 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689257818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=T8s7J9XfXATwjILd5jYXvmwh2dNWEpNL61+Hxv5Ymmg=;
        b=sNeZ8LlvhKEYonqMBveWUdh7yHVXGLc0KdDCEhViyMnRBJ3ZC7JM3v/zGpTX6fS51jcZkZ
        puE+D0aQW2nqCpsimi1ASv0Adiqt/KeaRmN1F60v4MkdMN1Gy4MlJruVk3awuPAPFGXLaJ
        LK25mlBDCeGOXOBN95gOKV81O9lDRIg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EBAC92C142;
        Thu, 13 Jul 2023 14:16:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B92F9DA85A; Thu, 13 Jul 2023 16:10:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Minor macro and type cleanups
Date:   Thu, 13 Jul 2023 16:10:22 +0200
Message-Id: <cover.1689257327.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Get rid of unsigned char, and use sizeof_filed().

David Sterba (2):
  btrfs: replace unsigned char with u8 for type casts
  btrfs: use helper sizeof_field in struct accessors

 fs/btrfs/accessors.h     | 23 +++++++++++------------
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/file-item.c     |  8 +++-----
 fs/btrfs/send.c          |  2 +-
 4 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.40.0

