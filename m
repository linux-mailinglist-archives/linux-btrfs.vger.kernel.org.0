Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7033A0C6C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhFIG3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 02:29:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59416 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhFIG3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 02:29:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6BABB1FD2A
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 06:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623220069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8M+uMB7++0uScb8ayVnA3WznpCfhOF07kG5IK4114c=;
        b=Do5o0+FnYCxIEQ+uzhaBbHZEuhAMhebkVmeWv99QJeJzmahZvYp1B6sufHI5t/vtOWiraP
        E+q8704x4713QjOgGjbWmzIAlVdL/q7F7ViEMRXkCKhQhqv0JDSHF1oP0Mv+1yuhwliW1h
        b+caCtARe6gje2iDW2BmR9XtdvIoXqM=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 6CAB5A3B81
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 06:27:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests/fsck: add test case to make sure btrfs check can reset btrfs_dev_item::bytes_used
Date:   Wed,  9 Jun 2021 14:27:43 +0800
Message-Id: <20210609062743.190936-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210609062743.190936-1-wqu@suse.com>
References: <20210609062743.190936-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test image is manually crafted with 1MiB offset in the device item
of devid 1.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../047-dev-bytes-used/.lowmem_repairable        |   0
 .../047-dev-bytes-used/default_case.img.xz       | Bin 0 -> 1896 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/047-dev-bytes-used/.lowmem_repairable
 create mode 100644 tests/fsck-tests/047-dev-bytes-used/default_case.img.xz

diff --git a/tests/fsck-tests/047-dev-bytes-used/.lowmem_repairable b/tests/fsck-tests/047-dev-bytes-used/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/047-dev-bytes-used/default_case.img.xz b/tests/fsck-tests/047-dev-bytes-used/default_case.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..28100c185cb6f6f3ec342434e9605b6faea135af
GIT binary patch
literal 1896
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

literal 0
HcmV?d00001

-- 
2.32.0

