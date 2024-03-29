Return-Path: <linux-btrfs+bounces-3789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A2891ED9
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCACC2852DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4B61B9A0D;
	Fri, 29 Mar 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EParbhA4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13E13BC31;
	Fri, 29 Mar 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716643; cv=none; b=VINxxWZw8U27db9H9f9rjU7jtVwGYHz+1WCs5jUtqEl86dGbDa3IPphKR8A503ZxSRLoFqWEneIcuDJ1zpoERMjivlg9JSFb296+ZonKhtuwRTNlHX9VUuVOakE+IkMp+jK6YSBsmcC4x48VlgcaaYGvpj89798YsueP283XTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716643; c=relaxed/simple;
	bh=cpHNBfKk529oOkjbsJ4ZSHaOTq6oarlx4e5vOEXv7lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2oa4ESn5HIPIgDRHgkGHmIu3uy2saDJ87313Om1ZSdjlkGnornySbsI0/w8piMt3/5wPz7k/HRH7RcjYMjTSFEYNIKz9AgPDatwJDIA03EjyT+inPWoUttacPz+DgRkVDmaI235iXa7w9Vqwmr/5O1SIxRMnCs+a+Lje42j5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EParbhA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF74C433F1;
	Fri, 29 Mar 2024 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716643;
	bh=cpHNBfKk529oOkjbsJ4ZSHaOTq6oarlx4e5vOEXv7lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EParbhA47RTX7VVuqeblGTrxK5CJMIhxt2I1+cPAU6f7SRAD3tw4zb8FVPDYqp+zq
	 5k35S1jfmxnaFNaqEiCDGIoWwdyss7T/9er59wDvdIoO2uDFETZarAVUxJE7mw2j5L
	 u70zEQOuJbpOyUXpi2i4Psh3OQQxs0eC6eU7UiDLH7umb2yfHvvFQAue74eawXYAMn
	 3+mb5TSj/yb+g3BpbhfGTkZRUK9gDdY0wmUxPQ86Z0EeV+7U1BEWi3ByCGwQBaMwN0
	 l3MQ1//gnIk7AFZH432mNt18scM9k25bT7/oNVDmjPxy+SMWSyE5SzfYvrOnv4JSNL
	 ct4uGkeHb0UGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 18/23] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:49:51 -0400
Message-ID: <20240329125009.3093845-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 7411055db5ce64f836aaffd422396af0075fdc99 ]

The unhandled case in btrfs_relocate_sys_chunks() loop is a corruption,
as it could be caused only by two impossible conditions:

- at first the search key is set up to look for a chunk tree item, with
  offset -1, this is an inexact search and the key->offset will contain
  the correct offset upon a successful search, a valid chunk tree item
  cannot have an offset -1

- after first successful search, the found_key corresponds to a chunk
  item, the offset is decremented by 1 before the next loop, it's
  impossible to find a chunk item there due to alignment and size
  constraints

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e11c8da9a5605..b5873df0aa93a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3268,7 +3268,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 			goto error;
 		}
-		BUG_ON(ret == 0); /* Corruption */
+		if (ret == 0) {
+			/*
+			 * On the first search we would find chunk tree with
+			 * offset -1, which is not possible. On subsequent
+			 * loops this would find an existing item on an invalid
+			 * offset (one less than the previous one, wrong
+			 * alignment and size).
+			 */
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
-- 
2.43.0


