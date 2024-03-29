Return-Path: <linux-btrfs+bounces-3781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA4891DE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47891C2794E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA61A3389;
	Fri, 29 Mar 2024 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2+5lUfV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B21A2B93;
	Fri, 29 Mar 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716438; cv=none; b=MEvyuvnl11luTP4H3Bq3NfuYFkcUib34ArnFx8R6NqgUsxBycEINZtyMo6jcsxM6pgMZFp3eN2IYOjZuA8S0LKYmlozbkJQuMCw2rUw1YbWolPOVQYtPmlFotpNc/hUoYCTBU6TJl62zFLcwG57W2A82b2Nj3UGwR9OJCeY3fiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716438; c=relaxed/simple;
	bh=d5DArg/0hqWJGePnz1+kSxWB/3LWOiBxH1jRuA5RlpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbH0ZwoeuhxlP4Tz+rnEKPiDY59TZKUzpidFAiPXnQmjCZT1uIyhRisjdYtSFx7CRrqtURHjPo6lUa2LKEPSHC2fAE/bAcjZ/vs1Io2ZeO8WhejANetl+gBVq9W1BRYc2fLxGTv8BwLygWfdoXND2hMNrPze7/qIu6Qzy/EUKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2+5lUfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61BC433C7;
	Fri, 29 Mar 2024 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716438;
	bh=d5DArg/0hqWJGePnz1+kSxWB/3LWOiBxH1jRuA5RlpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2+5lUfV7Kq5ohezF10KO9CjRv5rj0tn77A8Noovpt2awGCaAtItq0T0MAuvpV3vG
	 CNOAyj+DyXPLYVoePDLS3SN92oqIEyPzWMTnLhsk7jszM1iUL2qmsJVHgOE4ghyLry
	 fKbyN8Jie0R/Aavw4USgTgPTSk0IoHwC8haFGgWXeIl3sqwXuPYcIW0F+QTXqfWGZy
	 pnG/KIdHw1la5W5twTvjPjFUlmPb8AZLgbYOiuSfbr0Pd6NCwgPYBfWEp0yWvtJI9d
	 nz0IG0a9Lr9HES5n+rQPsEXOauAM6+FoxMWEjsPl1WDbtzu8R37OHi/ZecIvw0/SMT
	 xZuLpUEPIbIPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 41/52] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:45:35 -0400
Message-ID: <20240329124605.3091273-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 26b66d1d366a375745755ca7365f67110bbf6bd5 ]

The get_parent handler looks up a parent of a given dentry, this can be
either a subvolume or a directory. The search is set up with offset -1
but it's never expected to find such item, as it would break allowed
range of inode number or a root id. This means it's a corruption (ext4
also returns this error code).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index fab7eb76e53b2..58b0f04d7123f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -161,8 +161,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
-- 
2.43.0


