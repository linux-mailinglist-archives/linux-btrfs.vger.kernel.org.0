Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1016A45A303
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 13:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhKWMrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 07:47:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40694 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbhKWMrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 07:47:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6ADAC1FD63;
        Tue, 23 Nov 2021 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637671464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=RwjKEApi8yvylCq8MLCJ3kQ6u1yC+8hAz7iJlYfEa2g=;
        b=qtMRB/JxjcCBK3aHgPDIZW0ivAEE1A/qDLh07QKErz2kVys1HfjXWSdXTMz5EePUngKww3
        FIG91r/dQcEEpk5qPbnNdT2/KLMsd04Qo8bUmdzycqre96QDTyT5sA69OlrJrHGsncbFy2
        npfV4t3tKc2JQHjcc+WF1U0mb5tExnM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DC9C13DF4;
        Tue, 23 Nov 2021 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n2rJCyjinGEfdgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 12:44:24 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/4] Misc freespace cache cleanups
Date:   Tue, 23 Nov 2021 14:44:18 +0200
Message-Id: <20211123124422.5830-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's an assortment of freespace cache cleanups. 2 patches to consolidated some 
functions and 2 other to simplify/clarify arguments of called functions. This 
all results in a nice reduction of lines of code as well as code size: 

$./scripts/bloat-o-meter fs/btrfs/free-space-cache.o free-space-cache.patched
add/remove: 0/0 grow/shrink: 0/8 up/down: 0/-549 (-549)
Function                                     old     new   delta
__btrfs_add_free_space                      1124    1123      -1
btrfs_find_space_for_alloc                  1042    1039      -3
btrfs_remove_free_space                      648     644      -4
do_trimming                                  550     530     -20
btrfs_add_free_space                          75      55     -20
btrfs_add_free_space_async_trimmed            79      57     -22
try_merge_free_space                         602     505     -97
steal_from_bitmap                           1522    1140    -382
Total: Before=29299, After=28750, chg -1.87%


Nikolay Borisov (4):
  btrfs: consolidate bitmap_clear_bits/__bitmap_clear_bits
  btrfs: consolidate unlink_free_space/__unlink_free_space functions
  btrfs: make __btrfs_add_free_space take just block group reference
  btrfs: change name and type of private member of btrfs_free_space_ctl

 fs/btrfs/free-space-cache.c | 115 ++++++++++++++----------------------
 fs/btrfs/free-space-cache.h |   8 +--
 2 files changed, 48 insertions(+), 75 deletions(-)

-- 
2.17.1

