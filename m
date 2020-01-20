Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4214C142412
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 08:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgATHJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 02:09:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:34642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgATHJo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 02:09:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B51C6AF84;
        Mon, 20 Jan 2020 07:09:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: Always dump dmesg for failed test cases
Date:   Mon, 20 Jan 2020 15:09:37 +0800
Message-Id: <20200120070938.30247-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When hard-to-hit bugs happened, we really want every piece of info to
help us debugging.

Although we already have KEEP_DMESG config, not everyone is utilizing
it, thus when hard-to-hit bugs happened, one could only set it and retry
until next hit.

This patch will change the behavior by always dumping the dmesg for
failed tests, so that developers can always get extra info from any
failure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check b/check
index 2e148e5776e5..e580b2249f06 100755
--- a/check
+++ b/check
@@ -840,6 +840,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	# make sure we record the status of the last test we ran.
 	if $err ; then
+		if [ ! -f $seqres.dmesg ]; then
+			_dmesg_since_test_start >$seqres.dmesg
+		fi
 		bad="$bad $seqnum"
 		n_bad=`expr $n_bad + 1`
 		tc_status="fail"
-- 
2.24.1

