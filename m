Return-Path: <linux-btrfs+bounces-10569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610D9F6BED
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788A37A2B6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8C1FAC4C;
	Wed, 18 Dec 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxBD7qeZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A21FAC4D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541625; cv=none; b=DPT0cQETfEb/UM+jMgxnFTr2xluX/HRSg7kjqUIVgpR1Y1IffCk+TvBmwIrkwt72gxqsRFliCuf8qhNbR4FUmulY42Kvo9twD+YrWNhuThgu0E40IfnTTQZmvlpCgiAR/IyLmIKLVoqsLst5at6BiVk/DDzUkjn6587m356aVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541625; c=relaxed/simple;
	bh=F9GmDBc+7QDgPlyWu1aRV6eYPErmrWCjaYaOJXgMisQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPs2rl0GuVphNJM3vNO+RHGcVafuLJKJtma31VJQU48sK5XBVp9HefCkyj7xeqsNl9JvwyhQ5DVdIm5IemXJu3t1QwgFHHKjeYMnDWLRfTvpn/Kog72jz8utqf2EANDy5KkxEDdHsUn5NOhGasmc37Hks3AbMQ2817LMkEOqX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxBD7qeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D0AC4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541624;
	bh=F9GmDBc+7QDgPlyWu1aRV6eYPErmrWCjaYaOJXgMisQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VxBD7qeZinOZ3k8NZwSd/Yb4SJukm2FNhPGbUBi7NG9anDsVNndk/Oi2TxAV1ojhC
	 scaVgGiNFPcDxIzJ9xTiFR8Yx8DVQqV1hmqEvoiepfb578dixf0aVzs8hUiWJ4CFkU
	 wfPCZoLvZoJXQv5RK7GK6OcBvkia/PMmZc0KSgNJR/wGdycWIfWkqOD4098SRyierp
	 ilkhE0A5zPIF8iMn5KYjyA/0StCyoueeL3uaKCaf2+Mr+FQlmGDBsarQQ8f7JIWNLG
	 kMvTI8z2F1njxXejOdAMyGMWaoZnx5HjqsOKh/LFcdUlhHQ7duDp7dfcg8nEK6fJxP
	 qMK+z6TOgsyIg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/20] btrfs: ioctl: remove unnecessary call to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:40 +0000
Message-Id: <631e83219099d38a4608511286d1d4d14b7812fd.1734527445.git.fdmanana@suse.com>
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

The call to btrfs_mark_buffer_dirty() at btrfs_ioctl_default_subvol() is
not necessary as we have a path setup for writing with btrfs_search_slot()
having a 'cow' argument set to 1.

This just makes the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7872de140489..0946dcb978e4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2916,7 +2916,6 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 
 	btrfs_cpu_key_to_disk(&disk_key, &new_root->root_key);
 	btrfs_set_dir_item_key(path->nodes[0], di, &disk_key);
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 
 	btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL);
-- 
2.45.2


