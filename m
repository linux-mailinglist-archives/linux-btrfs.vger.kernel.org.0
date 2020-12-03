Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB92CD11D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgLCISa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:18:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:35078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgLCIS3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 03:18:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606983463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YsnELQpV8jGSY6Mjm4MWkw9DLmXAMjK90RP/Rb8bIFQ=;
        b=UvPo9N05pkHFEHzuaMjji/2XK0PhXauaHE5MswbBhPfqMPVnOYt4oy19aaUoxZM4bA0NAR
        aMNT5zqns9PvrcKcDv8wuH7RRAmzVrb8Ju4TR819WkBrWTQw0P/lHWojoDunetarTFLsi7
        rIGBiq6xilnbvHpI8nEuXDTUNQCghk8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2A33AE46;
        Thu,  3 Dec 2020 08:17:43 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/2] Support removal of ino cache leftover by btrfs check
Date:   Thu,  3 Dec 2020 10:17:40 +0200
Message-Id: <20201203081742.3759528-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following the removal of ino cache support in the kernel, let's add support
for 'btrfs check --clear-ino-cache'. 2nd patch also adds a test to ensure we
don't regress this functionality in the future.

Nikolay Borisov (2):
  btrfs-progi: check: Add support for ino cache deletion
  btrfs-progs: tests: Test operation of newly added --clear-ino-cache

 Documentation/btrfs-check.asciidoc            |   3 +
 check/main.c                                  | 162 +++++++++++++++++-
 .../ino-cache-enabled.raw.xz                  | Bin 0 -> 160420 bytes
 tests/misc-tests/042-ino-cache-clean/test.sh  |  51 ++++++
 4 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 tests/misc-tests/042-ino-cache-clean/ino-cache-enabled.raw.xz
 create mode 100755 tests/misc-tests/042-ino-cache-clean/test.sh

--
2.17.1

