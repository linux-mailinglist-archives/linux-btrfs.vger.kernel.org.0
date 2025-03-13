Return-Path: <linux-btrfs+bounces-12272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E16A5FEA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F8819C4670
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65D1EDA0B;
	Thu, 13 Mar 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry6SHqHy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3791EBFE2
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888544; cv=none; b=HMtYYcIUblOYxIJU80GdnpaPM1vUKVlMehYCTorDgZsR8GqKCuNQN+E7P9R9GQWHQLeIEqil0yKu0jZogeoDzMoqMLp0o7BGRlqmoJX+vt1c68a86JkEw1BfYT2jihZJy1Fmbbd9ex6+3euHWDeUDjklYGCiEN2FpyGD3jOlbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888544; c=relaxed/simple;
	bh=5KBLJlL6WBezu97iLhZh0a2nGayAwPdvVOuZg0otm18=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIdLwIY9rLVUTS9+TVvBrPSCNnLK/PcG0TV/OLRNDORhu0tjaFNfqAAm8wq2tKRGE4GHQ8R3BQLywbmtpH5/gwDEFt/Gu404NgVv+P+SrqkXF334/8tZvn8PkxovD1fXZa9WgwdkpbUU9mR7COyWaSwwREwdajrMKwe4MDHdV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry6SHqHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304F9C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888543;
	bh=5KBLJlL6WBezu97iLhZh0a2nGayAwPdvVOuZg0otm18=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ry6SHqHyvmExLjsVXxC2vK7CB8fmzOvRmlFgdyodDzUpv/G5Ri8Vc/3FbIPpX6pYa
	 JlWzdx6YTJv8to/2/ney74uWaRrIEIOfZWfhGoBNt/1C7omGYkR8ryhU9maXhEkpce
	 fL/jEn6g/KHYqdveRr9JtlqUS2FTW3JxUWQSv0trxFtiIE4s1uQH/spZHai5KvUeR+
	 vWZNP+9OslZVo1E0odvEg2htkQz4NOfzea2YaHTMPf4ZKlf8uCJtQhUDNiDtGv1Fb0
	 bIMXfLKQzzDaYEriHoOu+uEtmgVqkCZ/SCXAODAOuv0oAgHByGBZia9przw4Q0bMPJ
	 cT40LFRzNgVXQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: update outdated comment for overwrite_item()
Date: Thu, 13 Mar 2025 17:55:33 +0000
Message-Id: <d4baa7de0f44a6ef20bbb2dd51297318087976b2.1741887949.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function is exclusively used for log replay since commit
3eb423442483 ("btrfs: remove outdated logic from overwrite_item() and add
assertion"), so update the comment so that it doesn't say it can be used
for logging. Also some minor rewording for clarity and while at it
reformat the affected text so that it fits closer to the 80 characters
limit for comments.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f23feddb41c5..889b388c3708 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -376,12 +376,12 @@ static int process_one_buffer(struct btrfs_root *log,
 }
 
 /*
- * Item overwrite used by replay and tree logging.  eb, slot and key all refer
- * to the src data we are copying out.
+ * Item overwrite used by log replay. The given eb, slot and key all refer to
+ * the source data we are copying out.
  *
- * root is the tree we are copying into, and path is a scratch
- * path for use in this function (it should be released on entry and
- * will be released on exit).
+ * The given root is for the tree we are copying into, and path is a scratch
+ * path for use in this function (it should be released on entry and will be
+ * released on exit).
  *
  * If the key is already in the destination tree the existing item is
  * overwritten.  If the existing item isn't big enough, it is extended.
-- 
2.45.2


