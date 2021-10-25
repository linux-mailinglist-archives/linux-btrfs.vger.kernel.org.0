Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8343920B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhJYJLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:11:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhJYJLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:11:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94EAD1FCA3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635152919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZdsFw1WdtMNqpxVPYngv0GREc/KoTGUPIndMwHwazmI=;
        b=fSyAWQrWp00NncHdq2hXuJfVKFrTQJ0dQRLFMwD/jhDl0hMa3qQjN+b+xcLSE3HoliXrVf
        dJrnl23Hu6yQ+X8LMBt3EBryVmk9bGs+UWEIhCFbdeK0r7t7NBTSXUaYn3//J1/IhjCgVR
        3fFhrXcAGVTy3etSJeFGwCcJ+gnQv90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2D2113AAB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HYwbKhZ0dmHDPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: ctree.he refactor
Date:   Mon, 25 Oct 2021 17:08:18 +0800
Message-Id: <20211025090821.65646-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs is abusing ctree.h for almost everything which doesn't have a
better location to put its definitions.

This makes ctree.h super congested for both kernel and btrfs-progs.

Here is just several cleanups inspired by my WIP btrfs-fuse project.

Currently my read-only (and still WIP) btrfs-fuse only has a ctree.h
with less than 100 lines.
The read-only project is definitely going to be much smaller than
kernel, but there are several tricks I used to make ctree.h slim:

- Put ondisk-format into ondisk_format.h
- Put BTRFS_SET_GET_* macros into accessors.h
- Put message output functions into messages.h

So we will only really high level structure definitions in ctree.h

Unfortunately for kernel, we still have tons of function
definitions, which don't have proper headers for them.

But this is still a good direction to go.

Of course, any advice on the names of these new headers will be very
helpful.

Qu Wenruo (3):
  btrfs: move the remaining on-disk format to ondisk_format.h
  btrfs: move the BTRFS_SETGET_* functions to dedicated header
  btrfs: move btrfs_printk() related macros to messages.h

 fs/btrfs/accessors.h     | 1004 ++++++++++++++++++++++++++++
 fs/btrfs/ctree.h         | 1340 +-------------------------------------
 fs/btrfs/messages.h      |  170 +++++
 fs/btrfs/ondisk_format.h |  223 +++++++
 4 files changed, 1400 insertions(+), 1337 deletions(-)
 create mode 100644 fs/btrfs/accessors.h
 create mode 100644 fs/btrfs/messages.h
 create mode 100644 fs/btrfs/ondisk_format.h

-- 
2.33.1

