Return-Path: <linux-btrfs+bounces-10231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4539ECF0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE09F1686E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5FB1C1F34;
	Wed, 11 Dec 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLULYCcX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B581B6D0D
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928816; cv=none; b=MdyW/MrG78w5BwVGkP6GJx/J+OiUU3SIW9QxFZ0PTIN0VzrVg9oPIhekBwpG55GqMAk5H55UKE8Wnh5o9xuKYMkMg+yeRxMJaZfwbcp2Kk96urgc6ae8alDnrGMPcc0AvoocbwIdi2SFjhbVcmH6fuTuF+Oh7sR05RGiWJh6RhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928816; c=relaxed/simple;
	bh=gcJlCl3eYEkScuFHlQMq13/7I4cWeKB5TpS20bMssO8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOPZV+GpCNasojYI5ntZrefk7DKtrQ2XgrE/y6KMft2vaAxMZ0AYKAeF8fia4khjdbZ4VyBADEOPuA9DclZfvyYjqBAh0TxZ02oLyVFHi6vdWnhrGWaKDT6Z8OrlPSujDN27c4XvhfmLKcU+p1Y/fr+ZRwJb5GNX7ezPXdPem7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLULYCcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D26C4CED2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928815;
	bh=gcJlCl3eYEkScuFHlQMq13/7I4cWeKB5TpS20bMssO8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GLULYCcXd7+vcYriF9lmQtWPY+sbNFDWXeC3BxDGlfblmiBAQUbUJH9PKGBQ4M9wA
	 4p4Ywx3tyDgF7pVAddkPJ5N6nx0WQtuoAEkztXANHDI7PQ9rZgl1peixq83p+7sYiI
	 vMkVssV1l3MXU6au37nhB3X5E7UnHgrxCQokG/FMHgoNNl9AglhiEDeovqXCjGRtxv
	 44QQMSpJj1MKAYzp4g70pPQvqacTbpQ+FyBo9NbM6bx90hDa+nSF+I6iLiOHLtD9kh
	 q0MW+e37z+if7k1aPPWZ12iOhdsXECPMQekacHRA4frysYY6VLmaNp6cX8QU+QImdJ
	 bvmCFC8kelTPQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: avoid monopolizing a core when activating a swap file
Date: Wed, 11 Dec 2024 14:53:21 +0000
Message-Id: <c37ea7a8de12e996091ba295b2f201fbe680c96c.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During swap activation we iterate over the extents of a file and we can
have many thounsands of them, so we can end up in a busy loop monopolizing
a core. Avoid this by doing a voluntary reschedule after processing each
extent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5edc151c640d..283199d11642 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10078,6 +10078,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			ret = -EINTR;
 			goto out;
 		}
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


