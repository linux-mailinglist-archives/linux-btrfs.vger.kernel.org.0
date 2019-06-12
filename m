Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30256421F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437932AbfFLKFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 06:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437919AbfFLKFu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 06:05:50 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2342080A;
        Wed, 12 Jun 2019 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560333949;
        bh=k4A2pzobBLPXbGTuKkiFRaUB9wIe16jn/DYgJKaaS4c=;
        h=From:To:Cc:Subject:Date:From;
        b=hvvnagZ+rUOggi0Nty7gSqjvT2MJObv8mhIQofsQupeQ4z8vIjvu7jD/Bcd5W8dw+
         FDcuJJzruJkL8xwyZIebeAXy3Hw+MdNEwwo9HUkKiOOjLE17uaAbMj92Q1+neKaLZX
         hXRTaHK3D56HQwhBxr9JjQH5CoBxbo0NzhllBf2s=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/146: remove unnecessary scratch unmount to avoid test failure
Date:   Wed, 12 Jun 2019 11:05:44 +0100
Message-Id: <20190612100544.1890-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Right at the beginning of the test we are unmonting the scratch device,
however at this point the device was never mounted, so the unmount fails
with an error message like the following:

  umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted

Which is not expected by the golden output and therefore causes the test
to fail.

Since the device/mount point was not mounted yet in the test, and since
the test framework unmounts the scratch device after each test finishes,
just remove the call to _scratch_unmount.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/146 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/btrfs/146 b/tests/btrfs/146
index 8ec3128b..18e2eec0 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -38,7 +38,6 @@ _require_test_program fsync-err
 _require_test_program dmerror
 
 # bring up dmerror device
-_scratch_unmount
 _dmerror_init
 
 # Replace first device with error-test device
-- 
2.11.0

