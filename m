Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F8147710A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 12:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhLPLsA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 06:48:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhLPLr5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 06:47:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94D2921119
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639655276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aYjzZVkuBSjI6yoJAtUJ6ld+Vlm2ZLXiyDGG1VE2JcA=;
        b=hGCXl/JYiNiYSdfXk2siGav67IW6pG19yTE7yLRgTr3rXVtGhxMTn7RRcLQzaiOwbOE9wp
        bytMjQkjEe4MTRvL8c0PeuqjEY2I6OgrhdLsA5x5uub074iX9T9AZKPMM6kwgn6nLAfZTR
        xNV3ojv4vV/SIkauiyOx8H5eweCkRng=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C622613B4B
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5+6MIWsnu2FvQwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:47:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: bug fix for read-only scrub on read-only mount
Date:   Thu, 16 Dec 2021 19:47:34 +0800
Message-Id: <20211216114736.69757-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long existing bug that read-only scrub on read-only mounted
btrfs can cause a uncommitted transaction to trigger an ASSERT() at
unmount time.

The first patch is the fix while the 2nd is to make the debugging of
similar bugs easier.

Qu Wenruo (2):
  btrfs: don't start transaction for scrub if the fs is mounted
    read-only
  btrfs: output more debug message for uncommitted transaction

 fs/btrfs/block-group.c | 13 +++++++++++++
 fs/btrfs/disk-io.c     | 43 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.34.1

