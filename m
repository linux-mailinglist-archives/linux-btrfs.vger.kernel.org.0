Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AE21536A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgGFHom (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 03:44:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgGFHol (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 03:44:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 238B5AEA8
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 07:44:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] btrfs: make ticket wait uninterruptible to address unexpected RO during balance
Date:   Mon,  6 Jul 2020 15:44:33 +0800
Message-Id: <20200706074435.52356-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report that, unlucky signal timing during balance can cause
btrfs to remounted into RO mode.

This is caused by the fact that, most btrfs_start_transaction() or
delalloc metadata reserve are interruptible.

That would return -EINTR to a lot of critical code section, and under
most case, our way to handle such error is just to abort transaction,
without any consideration for -EINTR.

This is never a good idea to allow random Ctrl-C to make btrfs RO, even
if the window is pretty small for regular operations.

This patchset will address it in a different direction, since most
operations are pretty fast, we don't need that signal check in waiting
ticket.

For those long running operations, signal should be checked in their
call sites.
E.g. __generic_block_fiemap() calls fatal_signal_pending() to check if
it needs to exit, so does btrfs_clone().

We shouldn't check the signal, and just throw a -EINTR for all ticketing
system callers, they don't really want to handle that damn -EINTR.

Only long executing operations really need that signal checking, and let
them to check, not the infrastructure.

Reason for RFC:
I'm not yet completely sure if uninterruptible ticketing system would
cause extra problems.
Any advice on that would be great.

Qu Wenruo (2):
  btrfs: relocation: Allow signal to cancel balance
  btrfs: space-info: Don't allow signal to interrupt ticket waiting

 fs/btrfs/relocation.c | 3 ++-
 fs/btrfs/space-info.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.27.0

