Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BBF4CED29
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiCFSRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiCFSRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:17:10 -0500
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58A3865D38
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:16:17 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36FE270011dDdji016FFc1; Sun, 06 Mar 2022 18:15:15 +0000
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
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/2] Update man page for allocator_hint property.
Date:   Sun,  6 Mar 2022 19:15:12 +0100
Message-Id: <28310223e30fc7f44fb1f5e7974fbd3f63dbe2be.1646590206.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646590206.git.kreijack@inwind.it>
References: <cover.1646590206.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590515; bh=qSM8QhaFpQPMUeUvvIuorJmrCscJervHgUpY3t3l2NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=OiSdKM8mwCyJHirFAAWR2gQm8AsFGla3oN3+wKWTjfHmVF7o4eG7apCiStEQBtqn/
         c1uhLnN0XJbye7sPFHkFDSd5B7NrvqSE+bY0vaq5TkHibFWC+IHSu8TFnq8SZblhUO
         /R4lxUlCLY9RqMpln0vAPLZ5uFHbiX832utM+dgI=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Update the man page of the btrfs property subcommand to show the use
of the device property "allocation_hint".

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 Documentation/btrfs-property.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/btrfs-property.rst b/Documentation/btrfs-property.rst
index 5896faa2..155839fe 100644
--- a/Documentation/btrfs-property.rst
+++ b/Documentation/btrfs-property.rst
@@ -48,6 +48,27 @@ get [-t <type>] <object> [<name>]
         compression
                 compression algorithm set for an inode, possible values: *lzo*, *zlib*, *zstd*.
                 To disable compression use "" (empty string), *no* or *none*.
+        allocation_hint
+                a device property that instructs how and when the allocator should use a
+                block device.
+                Possible values are:
+
+                METADATA_PREFERRED
+                        the device has an higher priority when a new metadata
+                        chunk is allocated. Data chunk is allowed only if there is no other
+                        possibility.
+                METADATA_ONLY
+                        the device is used only for metadata chunk.
+                        Data chunk is never allowed.
+                DATA_PREFERRED (default)
+                        the device has an higher priority when a new data
+                        chunk is allocated. Metadata chunk is allowed only if there is no other
+                        possibility.
+                DATA_ONLY
+                        the device is used only for data chunk. Metadata chunk is never allowed.
+
+                The default is 'DATA_PREFERRED'; if all the disks have this setting the
+                allocator uses all of them with the same priority.
 
 list [-t <type>] <object>
         Lists available properties with their descriptions for the given object.
-- 
2.35.1

