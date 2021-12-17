Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF247946C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhLQSze (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:55:34 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:54240 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231979AbhLQSze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:55:34 -0500
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnC2600L5DQHji01WnEdP; Fri, 17 Dec 2021 18:47:14 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/2] Update man page for allocator_hint property.
Date:   Fri, 17 Dec 2021 19:47:05 +0100
Message-Id: <acc89ad83cb35ebb97f775b3df7ed6fbd796de1f.1639766708.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639766708.git.kreijack@inwind.it>
References: <cover.1639766708.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766834; bh=Jd5xPTtdoX67h8gRtajlyKkX1TaVEszE7qOM3Yug2qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=iSq5uWGVGDUgY9eymbaS4P/37hpFddcGlv+7+Cn6um42pbcM13CSOLy7HYvaLn6n+
         526272zverjEtYtdUR1OqZW2UbG1ryy5qkQNh/9mveY5So+Sp+E4mDzhLME1kzeQnR
         HdxySCQTKGwvWoHkEp3yn/lZB3u7MeRzCshHz4N0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Update the man page of the btrfs property subcommand to show the use
of the device property "allocation_hint".

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 Documentation/btrfs-property.asciidoc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs-property.asciidoc
index b32d000e..d9e9c4b9 100644
--- a/Documentation/btrfs-property.asciidoc
+++ b/Documentation/btrfs-property.asciidoc
@@ -49,6 +49,23 @@ device as object. For a mounted filesystem, specify a mount point.
 compression::::
 compression algorithm set for an inode, possible values: 'lzo', 'zlib', 'zstd'.
 To disable compression use "" (empty string), 'no' or 'none'.
+allocation_hint::::
+a device property that instructs how and when the allocator should use a
+block device.
+Possible values are:
+- 'PREFERRED_METADATA': the device has an higher priority when a new metadata
+chunk is allocated. Data chunk is allowed only if there is no other possibility.
+- 'METADATA_ONLY': the device is used only for metadata chunk.
+Data chunk is never allowed.
+- 'PREFERRED_DATA' (default): the device has an higher priority when a new data
+chunk is allocated. Metadata chunk is allowed only if there is no other
+possibility.
+- 'DATA_ONLY': the device is used only for data chunk.
+Metadata chunk is never allowed.
+ ::::
+The default is 'PREFERRED_DATA'; if all the disks have this setting the
+allocator uses all of them with the same priority.
+
 
 *list* [-t <type>] <object>::
 Lists available properties with their descriptions for the given object.
-- 
2.34.1

