Return-Path: <linux-btrfs+bounces-4970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942EE8C58B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58FD1C21A1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E296C17EB9F;
	Tue, 14 May 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+3NTuNJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D11459E4
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700416; cv=none; b=fiVQJ6b0hDj5nDK7OGm7NlICUOlwqCv06pKmAokt12N4rAjc4J8cvS99DjzAqkJaL0y79xJMcFuJRvaUJ3cXC2EwavWUsZjz7Uyi81sVc0rLqkAT8T9Zq+x36eWHz1uL5MqD8ADzxXsAKGkVGdtAIZ/cL+DjKyuriXgJhz0r+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700416; c=relaxed/simple;
	bh=pWZOZNKB+oM2rkmJrDKvNbbYcKECOFh0j90q308EXdY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SyUp1fvmowM/5aKOI5RNAFMGtVAWtL28KvWyORSxfBWyXAxqbH2h99ER2yyNGYbEspbSbdQ5Na+tEAJyrwecxhytjybJNHJjMbQfbjd229XJNFrQp+vhrrcLDJ7WE+Pdy0V07eafoqaQgU8FQDnVa9IMC5Z/kBPAd3xpgzLX4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+3NTuNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68734C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715700415;
	bh=pWZOZNKB+oM2rkmJrDKvNbbYcKECOFh0j90q308EXdY=;
	h=From:To:Subject:Date:From;
	b=q+3NTuNJUujC7TdWeiMCYYsHWpqeV+Uc3jWF8bTgs8i4o2s9KBqGc6gVdMoQlolcc
	 pWGDa3p6llKdekEvQqzNoyFQXiMSjY2wa4CyrRQRg1g0hodyruIJ1/3wsKWsDV477/
	 rnU2jiB/Y4jPDDdLsYt9DQPuom/6kR1JYUUasHnkNgWAdoHYXrnUpmv/nkqcvaebDo
	 BStrcC/vRgMIMgCha7IO0gTRmUp+5LeZfXuOf5ewG+1XreZHXEYDdZqOx6QbU9ozoG
	 sDfiI21998wMPh6jslsu4RW3Sp1uB8CjKEK22IYSVFMMU11jH9yUqfry+Otf40rmJ+
	 jW/LjTLKukhsQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix end of tree detection when searching for data extent ref
Date: Tue, 14 May 2024 16:26:52 +0100
Message-Id: <d025098ef2c013545df5f37ef85128805a104571.1715699835.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At lookup_extent_data_ref() we are incorrectly checking if we are at the
last slot of the last leaf in the extent tree. We are returning -ENOENT
if btrfs_next_leaf() returns a value greater than 1, but btrfs_next_leaf()
never returns anything greater than 1:

1) It returns < 0 on error;

2) 0 if there is a next leaf (or a new item was added to the end of the
   current leaf after releasing the path);

3) 1 if there are no more leaves (and no new items were added to the last
   leaf after releasing the path).

So fix this by checking if the return value is greater than zero instead
of being greater than one.

Fixes: 1618aa3c2e01 ("btrfs: simplify return variables in lookup_extent_data_ref()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 47d48233b592..3774c191e36d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -477,7 +477,7 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 		if (path->slots[0] >= nritems) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret) {
-				if (ret > 1)
+				if (ret > 0)
 					return -ENOENT;
 				return ret;
 			}
-- 
2.43.0


