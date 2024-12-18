Return-Path: <linux-btrfs+bounces-10562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3E9F6BE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0ADE16F0A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD51F9F5E;
	Wed, 18 Dec 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViQ+cM7L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCA1F9F7D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541618; cv=none; b=D6tuvfaRORNlH0J9wzBb933XIGHerTvqFcGp8IUDnGYMf8nhhmtzf0yyEnDyDRmwqmQhAuhsR9s9vaCt6S7rOs+592O4JKqlydMlPUK3/cNqIDdLFGYjKlwxX/T9NubqKqr9yNfdmhO25dMOsnE5qpkqMjbiwJ5MweAztCJj/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541618; c=relaxed/simple;
	bh=dWM7V7jtLdxXXJP97eBznDIXUEen+vuhYU1RObHSTcQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TwAW/WXch4xLs86TCC//5NXT1EgdMhWRc6XPBFG+Owd5IgzBnCo+MSmUA+PsaG5YOa4exj1YmJN8vo0GOhygDw2fuSPWaSDMv9h85sqetH84XU6YNvpsb63u4b/C1J6roDefSoEO4DUkuiK71fOY8rkwgaP0+NY4tScdBz/egF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViQ+cM7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274D6C4CED0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541617;
	bh=dWM7V7jtLdxXXJP97eBznDIXUEen+vuhYU1RObHSTcQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ViQ+cM7LpT8RbM0oD59pv+Jf3HBbNOmwl0qFHJor5v8d1D6OxvWL8wSLbrinxL/Bd
	 jJQL6ky+mQ+INOZkIsfCWHap9FSk/FhtJyyxlxnByNGxO82WiGPiQKAZyVV2tLbsnu
	 5z+Bz5ibtk54TbssKZVRTigi9+y4cDytUiiKsxkxTTgS9fV1xCv42YG01nJ69TEtIp
	 IKmcV0HU2tCO/gRZQ2AZRsoVJvnJ4z8WidpdEnB5ITweYHchwuK2+7eaXnlnwHN0Vr
	 17NCOrJJ253MxaRMDzNWk4g5EC/cU0CAm8oxQNYaVrFdgSF+yBKoHyY2OyUEgsnyM2
	 5bOQzzmIo0QYA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/20] btrfs: dev-replace: remove unnecessary call to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:33 +0000
Message-Id: <c2daf4fa0809e651f163873d6c237cd95194d04f.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The call to btrfs_mark_buffer_dirty() at btrfs_run_dev_replace() is not
necessary as we have a path setup for writing with btrfs_search_slot()
having a 'cow' argument set to 1.

This just makes the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/dev-replace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ac8e97ed13f7..f86fbea0b3de 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -440,9 +440,6 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 		dev_replace->cursor_right);
 	dev_replace->item_needs_writeback = 0;
 	up_write(&dev_replace->rwsem);
-
-	btrfs_mark_buffer_dirty(trans, eb);
-
 out:
 	btrfs_free_path(path);
 
-- 
2.45.2


