Return-Path: <linux-btrfs+bounces-10574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A069F6BF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083A2171648
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE71FBEAC;
	Wed, 18 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkVOoWSh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9B1FBE92
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541630; cv=none; b=Md5fYQgBfPM9lVV0kPEcgcxDwvbo8CwZQXZWGVEqG8hSZcjt/bAxBbEnIJnSqEthOXcP6n4NrU64p3tNcYF5lzduKIgAAROJmIp4vzlb0Qs86+9DNiNq4dFJPqLh0pnpJ0kA1zqV5eEXWD4wvz/OvGigDhGyfWWsjPGvrDoWatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541630; c=relaxed/simple;
	bh=YcmVzk4TSdKHPT5pB2D2AfELrCwnZDek/xwtkktKw5o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GibbYr/blUpNg8LtGvgd+K5heSMdY53d6k9RtJCcsZpKzMqyk2s/dlAvXzDAvsukGRo9Wg59qUiiUGgux4x0BZshPy8Qh/4w+eNBnQKxqMPUBYyghFYGVlACU5iNy7pN+6cvINeZDMpcggKhuXnimiSgNNaynF0OHud1O7JKYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkVOoWSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C0FC4CED0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541629;
	bh=YcmVzk4TSdKHPT5pB2D2AfELrCwnZDek/xwtkktKw5o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LkVOoWShTezvAVPgjVkFb8Zyt0DRvT6+0JDTl2crLmtLh1fpP64fP31GJhP1s665x
	 8/k0K+guAAuB+SM+Nm5ZZdhT6GCgc3RBBv8PDJ1rQ5alVXfhv51akVCpflA/n4+Oui
	 62B4Od924LqpINj9m8dwt4rOVU29nIOV0RA+RPXjdrUdzXlBQt17ZTrxL4oRdHDfiU
	 IAAnRiBZn1x2lgIdfijTFAFwP5GrUha9MfG1d75TcBeNX+/5J4ss20hsZS01579fIa
	 xLyjQV5YmwB2j6/Jr07SVuWxbhdjuSNd+NUjkZGBx9+9zajeWpdk2JcoU7Nz2P/obx
	 LGIhPPHoRCOZw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/20] btrfs: uuid-tree: remove unnecessary call to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:45 +0000
Message-Id: <4094da56a76bc9ed72772ec3c6e904b37db4c494.1734527445.git.fdmanana@suse.com>
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

The call to btrfs_mark_buffer_dirty() at btrfs_uuid_tree_add() is not
necessary as we have a path setup for writing with btrfs_search_slot()
having a 'cow' argument set to 1 (through btrfs_insert_empty_item()).

This just makes the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/uuid-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index aca2861f2187..17b5e81123a1 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -140,8 +140,6 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 	ret = 0;
 	subid_le = cpu_to_le64(subid_cpu);
 	write_extent_buffer(eb, &subid_le, offset, sizeof(subid_le));
-	btrfs_mark_buffer_dirty(trans, eb);
-
 out:
 	btrfs_free_path(path);
 	return ret;
-- 
2.45.2


