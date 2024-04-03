Return-Path: <linux-btrfs+bounces-3873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F963896EA6
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F22885A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D90A145FF8;
	Wed,  3 Apr 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFRDsF2N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704B145FE1
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145953; cv=none; b=RGVZQni4RfqoqXI8tWDAJFNjwTDOU1iCzLCzvXN0QE2VYJOQlsJfbD5fGLF2v8H2F0hxO5m90qWiOHQ65gxMes0ne6WMJkNBZHUsNZQhPj8XKVyIl9RNQvj2KJPG0MRHMQ3CddnmrWg9C3QtuW1TFsLwsW+MldFx/LrCWVyXjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145953; c=relaxed/simple;
	bh=TnYmwu5GwQR9qIA51rv7wkwu5eOnYQXjWSoHU/rybms=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdJCIHzhHzaif80qJq1iVCdi6IQoAi75wboZ+yjPfTcaJD+cSMIX1GwJS6YYDK4bVm5NVPpuhTy1oR83Z4DhjXLAily1YTWTQ0cEXy9gDH4k/dhponHgYEidSK/o8+IQRa7k9DtezUUw8xgBoiWUFigBPcU1tD8IIXYQgtwfvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFRDsF2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A8CC433C7
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712145953;
	bh=TnYmwu5GwQR9qIA51rv7wkwu5eOnYQXjWSoHU/rybms=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AFRDsF2NB/WFiICJ1EmoNKCoH2pM74rdHl0+gT5HLe5zLXqpGeb39lOXD2yRrbim3
	 zfrkRLo+LI6JKAZ1ifCmuE9s8hEXghdeKnEyTehV7eoGl/uG5abA8pqk/1tFBxM8Dd
	 7Zu9HCmraz8G/5eJoZnv7SOy+IntU9PVnoB3IDXltEvdVPWllL9IBxllCs5LewGRp5
	 YeyyVrlqRmZyuP7URzngJenwd55V233/M/2JVrKcTVlsih6v6F8kiPSOXUPRy37hVF
	 o9fq2VQzQR4bkkPlwJB7qSQwyJgP0Cl5BXd8D5TlYYdzPy2rYi0mq2nt5cCA8QkMIX
	 JCofKNEpCiNhg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: remove pointless return value assignment at btrfs_finish_one_ordered()
Date: Wed,  3 Apr 2024 13:05:46 +0100
Message-Id: <8618abb228019ca2fd331a993fb9461d76cce471.1712145320.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712145320.git.fdmanana@suse.com>
References: <cover.1712145320.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_finish_one_ordered() it's pointless to assign 0 to the 'ret'
variable because if it has a non-zero value (error), we have already
jumped to the 'out' label. So remove that redundant assignment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c6f2b5d1dee1..94ac20e62e13 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3185,7 +3185,6 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
-	ret = 0;
 out:
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits,
 			 &cached_state);
-- 
2.43.0


