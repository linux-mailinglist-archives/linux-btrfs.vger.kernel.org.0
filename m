Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35824389D7
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJXPii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Oct 2021 11:38:38 -0400
Received: from michael.mail.tiscali.it ([213.205.33.246]:56232 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229782AbhJXPii (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Oct 2021 11:38:38 -0400
Received: from venice.bhome ([78.14.151.87])
        by michael.mail.tiscali.it with 
        id 9rXM2600l1tPKGW01rXNhv; Sun, 24 Oct 2021 15:31:22 +0000
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
Date:   Sun, 24 Oct 2021 17:31:20 +0200
Message-Id: <f3efa348101b1e9c444e5ae770a677bcdd6424cb.1635089206.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1635089206.git.kreijack@inwind.it>
References: <cover.1635089206.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1635089482; bh=bp2jd9YUorg+14LTdIT25JN1v6CidyFdDSQHXW2UJjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=PQDfhmT+w1D6ErGR/V3FZp0aFCX9H6BS6eiLg5nEt6JliPuNHnkopq/4uMW6qZkad
         CiBhTgpj9xufW/7rvAmziMLRTI1nzSvclw0OIThMm8y4bH1x+oJXBWBbF1GIr5o+H3
         yrautxxs5CurSZbupQW66+6CHZx/v8ApOpfX55Po=
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
2.33.0

