Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D906A3ACE0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhFRO5Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 10:57:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhFRO5Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 10:57:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7A5AC1FDAE;
        Fri, 18 Jun 2021 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624028114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=h0k5MV2y/fScUzdBTBqcQC40lwaw6Nxmlpuoqwd2U+w=;
        b=lDPPE8tBGQ2ZyJJ53An2FSSG8YNFtxJ2N+RuHYLn0Kv3L2GKta8oiza/uIuSq12kkNVl39
        2aMPslqIdZmKGWgNtu0VJdi/fbTrseb+1EgR+iH1CGUp0SwxJTHSlwGnsg4l/xI2Tr/aS2
        tDXaHMTUgNYbWjDv7OOopMHeWS3tY4k=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 73978A3BBC;
        Fri, 18 Jun 2021 14:55:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1604DA7B0; Fri, 18 Jun 2021 16:52:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Mount option bit definitions cleanups
Date:   Fri, 18 Jun 2021 16:52:25 +0200
Message-Id: <cover.1624027617.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The number of mount options has reached 32bit limit and adding a new one
causes some funny effects, so convert them to enum and use proper int
width.

David Sterba (2):
  btrfs: switch mount option bits to enums and use wider type
  btrfs: shorten integrity checker extent data mount option

 fs/btrfs/ctree.h   | 65 +++++++++++++++++++++++-----------------------
 fs/btrfs/disk-io.c |  3 +--
 fs/btrfs/super.c   |  5 ++--
 3 files changed, 36 insertions(+), 37 deletions(-)

-- 
2.31.1

