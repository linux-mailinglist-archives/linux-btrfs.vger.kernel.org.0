Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFB2AB0E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 06:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgKIFkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 00:40:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgKIFkB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 00:40:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604900400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=34/2MRWfTyWG8ZP4g/XezsD3HH2sUX3HW8pakpii2+s=;
        b=JjCQ+EityrIqUZ0Q19ZAIAf8YpQw7vGHUsYqRjv510/YMyicXDN0IhxWoAL7UFV7SL18Hy
        W4RrKaZuJTtPmb8J9o5VmSLHL+DSP4cNXYiXLvvt4tQVz2zgGhpLFOER43KgsK4QpR5PTA
        8VMBLlEHoTfAL6ePTnXh5n9L0CjtIQc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77BE9ABD1
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 05:40:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: add new precaution check for incoming subpage support
Date:   Mon,  9 Nov 2020 13:39:50 +0800
Message-Id: <20201109053952.490678-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the incoming subpage support, we need to ensure no tree block could
cross 64K page boundary.

Currently both kernel and btrfs-progs won't create such tree blocks, but
still add such check as non-critical warning to catch any ancient btrfs
in the wild.

Also enhance the existing test cases to catch the warning message just
in case we miss something.

Qu Wenruo (2):
  btrfs-progs: check: detect and warn about tree blocks cross 64K page
    boundary
  btrfs-progs: tests: check the result log for critical warnings

 check/main.c           |  2 ++
 check/mode-common.h    | 18 ++++++++++++++++++
 check/mode-lowmem.c    |  2 ++
 tests/common           | 12 ++++++++++++
 tests/convert-tests.sh |  1 +
 tests/fsck-tests.sh    |  1 +
 tests/misc-tests.sh    |  1 +
 tests/mkfs-tests.sh    |  1 +
 8 files changed, 38 insertions(+)

-- 
2.29.2

