Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015E3D8E44
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhG1Mvm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 08:51:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52298 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhG1Mvl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 08:51:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84E06222C1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627476699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=NvHWG2w4SVTpxrEjsIR5/oTyjso/XP+2+2r8iAE5FVU=;
        b=tmI1TeTIsGgHxi/N3/DgOwqUhGkSnVdSiMjuHIPxa7GRGexyQH6Z5Qls3HGvUSmDTePRXM
        7ZLORb73xyiVUAjpjFBIR2Sf2dzrAlYx7fdYpFAC4JpKQU4vGKYNcNrHC55DpbaeZWjZWP
        TfCAkOoe0wpRlBVhUOZfNgAT1kTbrl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627476699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=NvHWG2w4SVTpxrEjsIR5/oTyjso/XP+2+2r8iAE5FVU=;
        b=zUAvvtNY06KbILsEKMYVcxTqFfsWPz3hs8YYuKYmvzrggAR8VGZBe8r7NR+dkDzSiHKZru
        AGLmwtHX6YAfa4Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3408213318
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 12:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ra8HNNpSAWFtXQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 12:51:38 +0000
Date:   Wed, 28 Jul 2021 07:51:37 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] Change allocation from kmalloc() to stack
Message-ID: <cover.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627418762.git.rgoldwyn@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Apparently, git send-email --compose missed to send PATCH 0/7. So
sending again and hoping it lands in the right place...

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

-- 
Goldwyn
