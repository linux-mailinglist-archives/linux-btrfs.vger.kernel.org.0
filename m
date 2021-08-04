Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38873E083A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbhHDStg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39552 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbhHDStf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 381BA222ED;
        Wed,  4 Aug 2021 18:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Aoa0W9lPL6MyFQSgcT2j+92h+ylEnNpPQdRETleJr3M=;
        b=ui6Vzer7YTGTi48OnW6MolreI8HLwCNUb2u2htbPSaHCo/XdG4L6ATOYu40X16RHDO9sFI
        BQtEuyZMPWLi6uH8uyCU2uEO0VlSq+vGozVxQ7Cdg1gNcw7pJav4PCYX+e+XHpvuPJsp2n
        z4ml6VKggSuVS6SWFL90kutdaf+dmnA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA42113D24;
        Wed,  4 Aug 2021 18:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D2AwKDDhCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:20 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/7] btrfs: Use btrfs_find_item whenever possible
Date:   Wed,  4 Aug 2021 15:48:47 -0300
Message-Id: <20210804184854.10696-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Searching for a key in btrfs is a very common task, so try to use
btrfs_find_item whenever possible to avoid boilerplate code, while making the
code simpler when possible.

Please review!

Thanks,
  Marcos

Marcos Paulo de Souza (7):
  btrfs: Reorder btrfs_find_item arguments
  btrfs: backref: Use btrfs_find_item in btrfs_find_one_extref
  btrfs: zoned: Use btrfs_find_item in calculate_emulated_zone_size
  btrfs: root-tree: Use btrfs_find_item in btrfs_find_orphan_roots
  btrfs: scrub: Use btrfs_find_item in scrub_enumerate_chunks
  btrfs: tree-log: Simplify log_new_ancestors
  btrfs: ioctl: Simplify btrfs_ioctl_get_subvol_info

 fs/btrfs/backref.c   | 73 +++++++++-----------------------------------
 fs/btrfs/ctree.c     |  2 +-
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/ioctl.c     | 56 +++++++++++++--------------------
 fs/btrfs/root-tree.c | 32 +++++--------------
 fs/btrfs/scrub.c     | 52 +++++++++----------------------
 fs/btrfs/tree-log.c  | 40 ++++++++----------------
 fs/btrfs/zoned.c     | 21 ++++---------
 8 files changed, 79 insertions(+), 199 deletions(-)

-- 
2.31.1

