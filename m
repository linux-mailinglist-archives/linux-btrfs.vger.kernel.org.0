Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D55A54C9CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352890AbiFON34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353605AbiFON3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:29:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9703534B93
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 06:29:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 55AB021C62;
        Wed, 15 Jun 2022 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655299768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fpryS57A9oHdA2wNjU/4k11Uai0NII3+OZwE2ERVCBw=;
        b=oAAv2KJ39F+jmbZ1TEWDkER8NYlez3PHTJnCWpNp/nP0rORXr6r8vFbPL/qQU3+7SAHZW8
        dCAFb4DqhDHIo9Vjs54+8PaqLUtaRCY8DMcwrf/vHrJ6n0TLUxSj5Soj6s8E3KSXVs6DLR
        9UaEO8NDB/77GTbmOunZGZSfZw/hFsk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4CA312C141;
        Wed, 15 Jun 2022 13:29:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2EA6DA85E; Wed, 15 Jun 2022 15:24:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/6] More send v2 updates: otime, fileattr
Date:   Wed, 15 Jun 2022 15:24:55 +0200
Message-Id: <cover.1655299339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
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

New protocol enhancements:

- send otime with utimes command
- rename SETFLAGS to FILEATTR and send the btrfs inode flags
- other cleanups

David Sterba (6):
  btrfs: send: add OTIME as utimes attribute for proto 2+ by default
  btrfs: send: add new command FILEATTR for file attributes
  btrfs: send: drop __KERNEL__ ifdef from send.h
  btrfs: send: simplify includes
  btrfs: send: remove old TODO regarding ERESTARTSYS
  btrfs: send: use boolean types for current inode status

 fs/btrfs/send.c | 147 ++++++++++++++++++++++++++++++++----------------
 fs/btrfs/send.h |  17 ++++--
 2 files changed, 109 insertions(+), 55 deletions(-)

-- 
2.36.1

