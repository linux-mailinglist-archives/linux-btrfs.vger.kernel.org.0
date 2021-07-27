Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E723D8192
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhG0VTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:19:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45956 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhG0VRr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:47 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C7A101FD62
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627420663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=smBE+TPvsN+SCKMCucEZRKrFrj+CVP/2SA6v6E9N+EQ=;
        b=Zl94nG9q4mWinYRezblWVotahBHr4LWPjJeQBYf8NRF6JI9JEJO6F5TrUUez2oJrd0B1h4
        ZtSrg4fYJottA4YVtXZdceYl7AMgWmJqavfkHHm6KsulqkoAZN/IkKSYiOxu0aQYMzmPpH
        4xy8OlJAyv6woRCGwJRKpK26Dn5Y/mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627420663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=smBE+TPvsN+SCKMCucEZRKrFrj+CVP/2SA6v6E9N+EQ=;
        b=MzIJ5hmOzdgkgtMFWxeGH4NOeNHXiT9sdMcOVrX2s9ta5T4fzliNcrt8GbWMHYi3hqDV5J
        te0+41bWKj+emGAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 630B9133DE
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 21:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KH3tC/d3AGFmdQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 21:17:43 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] Allocate structures on stack instead of kmalloc()
Date:   Tue, 27 Jul 2021 16:17:24 -0500
Message-Id: <20210727211731.23394-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are some structs which can be converted to allocation on stack in order
to save on post-checks on kmalloc() and kfree() each of them.

Sizes of the structures are also in the commit message in case you feel they
are too bit to be allocated on stack.

There are two more structs in ioctl.c which can be converted, but
I was not sure of them:

1. In create_snapshot(), pending_snapshot can be converted. pending_snapshot
   is used in the transaction.
2. In btrfs_ioctl_set_received_subvol_32, args64 can be converted, but args32
   cannot. All Pointers associated with memdup_user() can also be converted
   by using copy_from_user() instead. This would include many more structs.

Goldwyn Rodrigues (7):
  btrfs: Allocate walk_control on stack
  btrfs: Allocate file_ra_state on stack
  btrfs: Allocate btrfs_ioctl_get_subvol_info_args on stack
  btrfs: Allocate btrfs_ioctl_balance_args on stack
  btrfs: Allocate btrfs_ioctl_quota_rescan_args on stack
  btrfs: Allocate btrfs_ioctl_defrag_range_args on stack
  btrfs: Alloc backref_ctx on stack

 fs/btrfs/extent-tree.c      |  89 +++++++++++++-----------------
 fs/btrfs/free-space-cache.c |  12 ++---
 fs/btrfs/ioctl.c            | 105 ++++++++++++++----------------------
 fs/btrfs/send.c             |  29 ++++------
 4 files changed, 89 insertions(+), 146 deletions(-)


