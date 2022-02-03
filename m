Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA24A89FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352822AbiBCR1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:27:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47462 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352827AbiBCR1K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:27:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F375321128;
        Thu,  3 Feb 2022 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643909230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfLPlzGqYP/LAeHIPI2v6jFiHA3b/xUR1RCgog9Qkyo=;
        b=RtpKdadE1D68X7TKpezMebACfuhbiWxhZQWvKejTF4Pwwc0kbWZBAgEj0hfE2dgPx1pGVj
        qOvXROH+Dz/NonCIcZUYNdmTVR9fFi/WkKrIKZknk4U+JPCHIoO/cr2i1OQHLKByX3N/gI
        300IwXvUgBp6f8OwmCWbYHWHGBXxzOk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EDB83A3B81;
        Thu,  3 Feb 2022 17:27:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ECEFDDA781; Thu,  3 Feb 2022 18:26:24 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: remove redundant check in up check_setget_bounds
Date:   Thu,  3 Feb 2022 18:26:24 +0100
Message-Id: <0cccec1104fd7058b4b19c6960dd4c10da646058.1643904960.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643904960.git.dsterba@suse.com>
References: <cover.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two separate checks in the bounds checker, the first one being
a special case of the second. As this function is performance critical
due to checking access to any eb member, reducing the size can slightly
improve performance.

On a release build on x86_64 the helper is completely inlined so the
function call overhead is also gone.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index f429256f56db..12455b2b41de 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -12,15 +12,10 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 {
 	const unsigned long member_offset = (unsigned long)ptr + off;
 
-	if (member_offset > eb->len) {
+	if (unlikely(member_offset + size > eb->len)) {
 		btrfs_warn(eb->fs_info,
-	"bad eb member start: ptr 0x%lx start %llu member offset %lu size %d",
-			(unsigned long)ptr, eb->start, member_offset, size);
-		return false;
-	}
-	if (member_offset + size > eb->len) {
-		btrfs_warn(eb->fs_info,
-	"bad eb member end: ptr 0x%lx start %llu member offset %lu size %d",
+		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
+			(member_offset > eb->len ? "start" : "end"),
 			(unsigned long)ptr, eb->start, member_offset, size);
 		return false;
 	}
-- 
2.34.1

