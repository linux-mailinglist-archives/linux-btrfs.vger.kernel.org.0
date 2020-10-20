Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746DA293EEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408252AbgJTOmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 10:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbgJTOmR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 10:42:17 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFC42224B;
        Tue, 20 Oct 2020 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603204937;
        bh=my0QmVMLxI1uk2n/NMksngmKeHf/PXBVQ4WqBksY0PM=;
        h=From:To:Cc:Subject:Date:From;
        b=IW/z2wHeM93blqtRtitlCX7Td0Zmzzfd78vhDeaknLrP1ayA6N3cmk/9cGQUwOI2l
         hEZsg0ncTds0tZkOCyYRgygJsgUVYci7J0veAK1g2/Y9gaelGA4bGGuYPJtsESnii3
         V7PvK+ZwPtoGzeGR0NyYPp+w1KEkYxHq8FrN1RbU=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] check: fix misspelled variable name for sections
Date:   Tue, 20 Oct 2020 15:42:10 +0100
Message-Id: <9609363e0dfbe7098ded407898b8b78c651dae0f.1603204642.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have some places that refer to the variable OPTIONS_HAVE_SECTIONS
has OPTIONS_HAVE_SECIONS, obviously a typo. So fix them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 check | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 8b5e241c..5072dd82 100755
--- a/check
+++ b/check
@@ -393,7 +393,7 @@ _wipe_counters()
 
 _global_log() {
 	echo "$1" >> $check.log
-	if $OPTIONS_HAVE_SECIONS; then
+	if $OPTIONS_HAVE_SECTIONS; then
 		echo "$1" >> ${REPORT_DIR}/check.log
 	fi
 }
@@ -441,7 +441,7 @@ _wrapup()
 		fi
 
 		$interrupt && echo "Interrupted!" | tee -a $check.log
-		if $OPTIONS_HAVE_SECIONS; then
+		if $OPTIONS_HAVE_SECTIONS; then
 			$interrupt && echo "Interrupted!" | tee -a \
 				${REPORT_DIR}/check.log
 		fi
-- 
2.28.0

