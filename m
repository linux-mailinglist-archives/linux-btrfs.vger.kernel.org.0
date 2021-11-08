Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A34481BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhKHObJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 09:31:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56514 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbhKHObI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 09:31:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B10BB1FD50;
        Mon,  8 Nov 2021 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636381702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1IBZqcmEUI4nVt9vg4w1/RocotS3x6HzX7diMgOCJDw=;
        b=qYSFQwF2iLFdljnF0JYcMnuT3ekt8t+2ISS0G+Z/Q5qt9nfxIuiRHMigqEWMWlwLqCJ2TL
        rg6vjgAuMqe4gJXvySTH6w1R1Yo8xsN7ou54CgOUMnHEZrQAp6JHuL72f8ucla1AsxGDxr
        cd79CkVn4R+G04FhgB+2rAGEJ/4QfLY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FBC813BA0;
        Mon,  8 Nov 2021 14:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JiGPHAY0iWGSJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 08 Nov 2021 14:28:22 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 0/3] x Balance vs device add fixes
Date:   Mon,  8 Nov 2021 16:28:17 +0200
Message-Id: <20211108142820.1003187-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's v2 of the patchset allowinig to add a device if we have paused balanced.

Changes in v2:

 * Patch 1 now contains a btrfs_exclop_pause_balance() helper which reduces
 some code duplication and encapuslates ASSERTS

 * Also in patch 1 balance pause is now handled in btrfs_balance and not in the
 caller of btrfs_balance. The original code was buggy due to my misunderstanding
 when need_unlock code is executed in btrfs_ioctl_balance()

* Patch 3 now uses btrfs_exclop_pause_balance instead of duplicating code.

Nikolay Borisov (3):
  btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
  btrfs: make device add compatible with paused balance in
    btrfs_exclop_start_try_lock
  btrfs: allow device add if balance is paused

 fs/btrfs/ctree.h   |  3 +++
 fs/btrfs/ioctl.c   | 39 +++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.c | 11 +++++++++--
 3 files changed, 47 insertions(+), 6 deletions(-)

--
2.25.1

