Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA002008B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbgFSM1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 08:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:45486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732985AbgFSMY7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 08:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C9B5ACB8;
        Fri, 19 Jun 2020 12:24:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/6] Fix enum values print in tracepoints
Date:   Fri, 19 Jun 2020 15:24:45 +0300
Message-Id: <20200619122451.31162-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While looking at tracepoint dumps with trace-cmd report I observed that
tracepoints that should have printed text instead of raw values weren't
doing so:

13 kworker/u8:1-61    [000]    66.299527: btrfs_flush_space:    5302ee13-c65e-45bb-98ef-8fe3835bd943: state=3(0x3) flags=4(METADATA) num_bytes=2621440 ret=0

In the above line instead of (0x3) BTRFS_RESERVE_FLUSH_ALL should be printed. I.e
the correct output should be:

6 fio-370   [002]    56.762402: btrfs_trigger_flush:  d04cd7ac-38e2-452f-a7f5-8157529fd5f0: preempt: flush=3(BTRFS_RESERVE_FLUSH_ALL) flags=4(METADATA) bytes=655360

Investigating this turned out to be caused  because enum values weren't exported
to user space via TRACE_DEFINE_ENUM. This is required in order for user space
tools to correctly map the raw binary values to their textual representation.
More information can be found in commit 190f0b76ca49 ("mm: tracing: Export enums in tracepoints to user space")

This series follows the approach taken by 190f0b76ca49 in defining the various
enum mapping structures.

Nikolay Borisov (6):
  btrfs: tracepoints: Fix btrfs_trigger_flush printout
  btrfs: tracepoints: Fix extent type symbolic name print
  btrfs: tracepoints: Move FLUSH_ACTIONS define
  btrfs: tracepoints: Fix qgroup reservation type printing
  btrfs: tracepoints: Switch extent_io_tree_owner to using EM macro
  btrfs: tracepoints: Convert flush states to using EM macros

 include/trace/events/btrfs.h | 128 +++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 60 deletions(-)

--
2.17.1

