Return-Path: <linux-btrfs+bounces-18952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE578C59125
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB834273E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17F35E559;
	Thu, 13 Nov 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsEh+hHO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676635E53B
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053006; cv=none; b=TJfqgz3GYhcwS+2AGkw8gA4P9UKzc/kh1UiECc9iOr0I8Z8G1VD1WF7mCValTGMGZFNAYOAyyLVhChNtLpZbQZtSd2eTLcHgGwvh39GDfc09CRlxXa0ZFJvRAFV1zUdoUx3VpjIx/p7j6c66q4ZIvbj9B8jIozjX69XlOU8LeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053006; c=relaxed/simple;
	bh=IR5kGD0CJXyGFCDGvBy7v3SjP1J2TGlOcyBrUQqlTIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne0aVAcw2Z+8h2qnfL+KYi8zALwyWSIKK+r2mP0g+mXznk6xc92GRx8vE+3phjSH6IzYfrkHaK8AB5PJMnQxbzv/mU/I2FUfWw0vfvOuuTjly+dY3nFoOSU/AvO3GEGypiBylHMqaG6JzCdzzzXDXbgYL3Pjvulw2WEKwKigII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsEh+hHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1830AC4CEFB
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053005;
	bh=IR5kGD0CJXyGFCDGvBy7v3SjP1J2TGlOcyBrUQqlTIk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GsEh+hHOyHycXzFsBJexqAiEGeFKGft9Bhu7gZOd44RrqASDvRCjCXaXOO5+B9JJl
	 QWTfXn/qOSJxJv7h2t62T19XGTnlanA6NSZ/gwLYndwqV6cLbJxxE8+XwuRDa+RD54
	 VTNhKKPc96oxurrIBIgBOu/+3jiyyutbgODppSqzdDk9nN4Iw+4yGO0h6GYxkGeK7B
	 VVnGtWtfYTroYOCR97YmovDvDWZJA0E8n9LcZatS1DJRRKJT2tarPjwWc2miES7+hL
	 aA1vwxAfEHkQHZ17phUjtCBYMu1Tb5Qe8faFGBJGdN7oCqMtDUr1E4VtR+uvr9MMtl
	 bedfWblq4QiEQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: remove pointless return value update in btrfs_del_items()
Date: Thu, 13 Nov 2025 16:56:33 +0000
Message-ID: <7248ed39a716ed9cd15a9b14026d13264882a8ac.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
References: <cover.1763052647.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The call to btrfs_del_leaf() can only return an error (negative value) or
zero (success). If we didn't get an error then 'ret' is zero, so it's
pointless to set it to zero again.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 614aa4b56571..e683f961742a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4565,7 +4565,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				free_extent_buffer(leaf);
 				if (ret < 0)
 					return ret;
-				ret = 0;
 			} else {
 				/* if we're still in the path, make sure
 				 * we're dirty.  Otherwise, one of the
-- 
2.47.2


