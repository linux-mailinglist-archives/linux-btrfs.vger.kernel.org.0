Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA74008F9
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 03:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350794AbhIDBch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 21:32:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38622 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350805AbhIDBcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 21:32:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4E8C1FDCB
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Sep 2021 01:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630719094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4x1lcsisxqNE6F4rLxYGe1oLmgFuFRKR8SiUJ+EkziU=;
        b=VsAVlQ40EY+wdHO0mblumd7yJFHyE1hEJxrxZ0U3+OGMamfKxGJUACY2F/+hMe3ieuvUi0
        RAHZ8mVE6+z8yHelqr9U3SYslmhhwUJeQBYpwi2RH39Jt3iDTFDUlFSsTudHTpt7sHHR2E
        YgnV0JZXwBh5ygWRLtC8Yg08x1p4s1I=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2D07313689
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Sep 2021 01:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZtePN3XMMmGKQQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Sep 2021 01:31:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: error messages enhancement for bad tree blocks
Date:   Sat,  4 Sep 2021 09:31:28 +0800
Message-Id: <20210904013131.148061-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When handling a corrupted btrfs image, there are tons of meaningless
error messages from btrfs-check:

  incorrect offsets 8492 3707786077

Above error message is meaningless, it doesn't contain which tree block
is causing the problem, just some random expected values with corrupted
values.

On the other hand, btrfs kernel tree-checker has way better error
messages, and even more checks than the counterpart in btrfs-progs.

So let's just backport the superior tree-checker code to btrfs-progs,
with some btrfs-progs specific (but minor) modifications.

Now the error message would look more sane (although a little too long):

  corrupt leaf: root=2 block=72164753408 slot=109, unexpected item end, have 3707786077 expect 8492

Changelog:
v2:
- Fix an uninitialized pointer which leads to fsck test failure

Qu Wenruo (3):
  btrfs-progs: use btrfs_key for btrfs_check_node() and
    btrfs_check_leaf()
  btrfs-progs: backport btrfs_check_leaf() from kernel
  btrfs-progs: backport btrfs_check_node() from kernel

 check/main.c          |   9 +-
 check/mode-original.h |   2 +-
 kernel-shared/ctree.c | 246 ++++++++++++++++++++++++++----------------
 kernel-shared/ctree.h |   5 +-
 4 files changed, 163 insertions(+), 99 deletions(-)

-- 
2.33.0

