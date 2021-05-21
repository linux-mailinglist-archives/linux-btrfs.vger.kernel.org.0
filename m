Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2CA38C63C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhEUMK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhEUMKX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w0pX3/HLfD/S6u+m6oKPRQfgTVhp6ERvXEzt96xrfFQ=;
        b=kAZlcn2Dd0oSBEsjTlNj8RGc3yczL0LIG6heQmTi2vjuvHJgHVur6CJvMFXHodXMi+pDOb
        5rTfg+oWIVoe9sJzq9OLMLjo64444/KWQCboH6feR1Kd07mbkoy/RCmV4PhDHJy4kJq9Cr
        IW2/pMYB3DgAo4+/67QB80q326tlHw4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B3ADAAA6;
        Fri, 21 May 2021 12:08:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD655DA725; Fri, 21 May 2021 14:06:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/6] Support resize and device delete cancel ops
Date:   Fri, 21 May 2021 14:06:24 +0200
Message-Id: <cover.1621526221.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't have a nice interface to cancel the resize or device deletion
from a command. Since recently, both commands can be interrupted by a
signal, which also means Ctrl-C from terminal, but given the long
history of absence of the commands I think this is not yet well known.

Examples:

  $ btrfs fi resize -10G /mnt
  ...
  $ btrfs fi resize cancel /mnt

  $ btrfs device delete /dev/sdx /mnt
  ...
  $ btrfs device delete cancel /mnt

The cancel request returns once the resize/delete command finishes
processing of the currently relocated chunk. The btrfs-progs needs to be
updated as well to skip checks of the sysfs exclusive_operation file
added in 5.10 (raw ioctl would work).

David Sterba (6):
  btrfs: protect exclusive_operation by super_lock
  btrfs: add cancelable chunk relocation support
  btrfs: introduce try-lock semantics for exclusive op start
  btrfs: add wrapper for conditional start of exclusive operation
  btrfs: add cancelation to resize
  btrfs: add device delete cancel

 fs/btrfs/ctree.h      |  16 +++-
 fs/btrfs/disk-io.c    |   1 +
 fs/btrfs/ioctl.c      | 174 ++++++++++++++++++++++++++++++++----------
 fs/btrfs/relocation.c |  60 ++++++++++++++-
 4 files changed, 207 insertions(+), 44 deletions(-)

-- 
2.29.2

