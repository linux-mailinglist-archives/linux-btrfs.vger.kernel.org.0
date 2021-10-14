Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2242DF1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhJNQ2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 12:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhJNQ2M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 12:28:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A05E2610F9
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634228767;
        bh=Hp5o65SntccKw6CF4OkQJVy3Bp7uVTKKaf1smx80LQg=;
        h=From:To:Subject:Date:From;
        b=eDmNr5xHPFmQGK8a7N5dkrNSYPSXP5KYlUpBc3VO95oqarLMExEIkNef9oF5RQJ0J
         /grDUl/qs42GBTSLkYIbpsOpu0RXSH6rlJk2TtETgLY8Ps0yX7Hh7ggCHg/kd1bPFK
         7DM71X797BP8l0wKpNkwpBRfdwYRmNMAJd2DRRzgiW4uZsLskTOUSBA8ixUUxPuJmY
         bq4AvxnoRs2EKij8YlFbA1nz8eq853JtJ0+OC4U6RhcKAh/mqcj2VX3BP24j4dsbYn
         gypl51jsDQIY83e5edxYCVuCuxJxTn2grnQU0AJPg1nhV9EMmgiFOlkaTTPL1C0uWn
         pHG91vxc4jQ/A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix lost error handling when replaying directory deletes
Date:   Thu, 14 Oct 2021 17:26:04 +0100
Message-Id: <d580b8836d741d5f474536ddcb262dcd26de6262.1634228346.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At replay_dir_deletes(), if find_dir_range() returns an error we break out
of the main while loop and then assign a value of 0 (success) to the 'ret'
variable, resulting in completely ignoring that an error happened. Fix
that by jumping to the 'out' label when find_dir_range() returns an error
(negative value).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 71b3ddb0333d..711394d1138c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2528,7 +2528,9 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 		else {
 			ret = find_dir_range(log, path, dirid, key_type,
 					     &range_start, &range_end);
-			if (ret != 0)
+			if (ret < 0)
+				goto out;
+			else if (ret > 0)
 				break;
 		}
 
-- 
2.33.0

