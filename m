Return-Path: <linux-btrfs+bounces-4191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33DF8A31C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E04D283781
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD0148309;
	Fri, 12 Apr 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVVCZLca"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAE1482F3
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934206; cv=none; b=XXrWeWQhYMGD7sd2E8UddRDPPoxS5jmXuSYIq9E8h+7XLf+r1O7i9zoEVrtSiVR7wbcK9bpYQ33WfJ7iPqcGj0+SdnvVCWMv2DRyNDyQIL6pChdRVOCI+umpJ3uukMq16MvlUpwXouNPkU0XHgpWBjPHAqIm2v68GeXaCQ+F5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934206; c=relaxed/simple;
	bh=pw0GEzuKXjzbv8HpOGGDW3L+JBJyEpR0E42+wlYh0Y8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6bL2gSCcrwj346BBQWn7MwT1QJyjR9NRWojaX3uy8/3WjLClknyS+HGoloRdJZUk5A1tqItkzuI61lY26ScgmIV6zDyXKN4/gDVrAJQihqoqjMwBXg6XZFXK6hsur4F0wEuIMftT/0w9n+lpRSIVb5/vlfoD5+wBqE/Mo2TLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVVCZLca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA1EC113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934206;
	bh=pw0GEzuKXjzbv8HpOGGDW3L+JBJyEpR0E42+wlYh0Y8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pVVCZLcaP9+LqPNAMcBGwHFavq0Nixf8vreMmO12KgZQpZzQoalvwuHa1GoNwA25A
	 9eHV9Ox5bo/jjBpg6TqujInqUIW99M6g+9LWjPSDVEVWchpwsXXZ4CauWT5TKY5BQ0
	 p0PrHbxAxCMqoOftfuPJN2MzIPeOpDFeV4bG4TYHd2uSZvn8KWEHpNwhOukJvTSoIe
	 2678S+xDbHNZp/Lbgu3/HPE/V934fI1a7V/j1+xGQS4JUI9AbjhH+1A0R4Ce6Fnbkt
	 22AvKSrWGLA61LsSO3dgjJcRp03pf+9MvDIbWLPwj8A74yFLuElxFqJ3ZsvFjs/QXH
	 jRp43ygyjvzWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: add function comment to btrfs_lookup_csums_list()
Date: Fri, 12 Apr 2024 16:03:15 +0100
Message-Id: <6cd95c2965fedf3f2b2d8b5dbf1dcbb072067192.1712933005.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712933003.git.fdmanana@suse.com>
References: <cover.1712933003.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Add a function comment to btrfs_lookup_csums_list() to document it.
With another upcoming change its parameter list and return value will be
less obvious. So add the documentation now so that it can be updated where
needed later.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e58fb5347e65..909438540119 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -450,6 +450,19 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	return ret;
 }
 
+/*
+ * Search for checksums for a given logical range.
+ *
+ * @root:		The root where to look for checksums.
+ * @start:		Logical address of target checksum range.
+ * @end:		End offset (inclusive) of the target checksum range.
+ * @list:		List for adding each checksum that was found.
+ * @search_commit:	Indicate if the commit root of the @root should be used
+ *			for the search.
+ * @nowait:		Indicate if the search must be non-blocking or not.
+ *
+ * Return < 0 on error and 0 on success.
+ */
 int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 			    struct list_head *list, int search_commit,
 			    bool nowait)
-- 
2.43.0


