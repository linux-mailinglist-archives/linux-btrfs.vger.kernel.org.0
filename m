Return-Path: <linux-btrfs+bounces-11567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167BEA3BD3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD4B7A00AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980811E0086;
	Wed, 19 Feb 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgBknuyF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB721DFE32
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965412; cv=none; b=F85a3n7wYifCKBwrcY9a/4hy/bdV4Htj9W/CNE6H7r4br6UeBh1hjoQC4cfZasQ1OBUG6W9cy7xCsSXXF50F3XQ+qZkL6mqcMDPkLBrs0KnUp8DufHPB+qxZraQSColvcLpjYzYERq4iV4HuxJgPR2tn3eR86vdRIwtvgo3pRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965412; c=relaxed/simple;
	bh=VElW5lz5SNietu+keLp8sG3SfJrkP00ZTihTb1ozIFI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3jjwOfnFRNC0QiXXJMEprKIKqPM7AZfaY8BnuPEP8jfbqvGZKUxVONKSd0Hte3uSTZQNiQ28hkmpXXq7rM9Ip8P8dAhFvedpynX1EDuX4caE/ClwzLYqY3pUDL2xmJS27UmkiUMry++p26MGWzHjTOleyoARSBHkcskOC4GIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgBknuyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB027C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965412;
	bh=VElW5lz5SNietu+keLp8sG3SfJrkP00ZTihTb1ozIFI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pgBknuyF9yV9DokWlrUcHrXHGCS02ZCt2cJv9U1cI4Mx2ueW+7EgXEn578QW/h5y5
	 JjK1jvHXECI3lU3xKAV7BrgwnJ2ug9VTZzUnJHQJIA8wmUpECapi8Gu73pbapNChGV
	 OaY04y/pU/iVBIZ6OEdk1hDfXGZJhYB0sGlIqK+UpZU7ZtiDhPMM1FqEU96ABJ2Por
	 rJxlHIWiDPAyfAUUa9MHE6slJv5VDxb8WVWjWLed7jAXkw441yQgCornL4lyOv/wMd
	 1QW0aXNcUGym8CP3YMYCqSaZSFB+23ePBecEpe3vmrRQDKrYjcM8X5HQjW9HbzZEEZ
	 seLKjJ+fKuoHA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/26] btrfs: send: make fs_path_len() inline and constify its argument
Date: Wed, 19 Feb 2025 11:43:02 +0000
Message-Id: <8f82f33481d50f8381a6c29ae0966982d3a7bc1d.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The helper function fs_path_len() is trivial and doesn't need to change
its path argument, so make it inline and constify the argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 8de561fb1390..4e998bf8d379 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -468,7 +468,7 @@ static void fs_path_free(struct fs_path *p)
 	kfree(p);
 }
 
-static int fs_path_len(struct fs_path *p)
+static inline int fs_path_len(const struct fs_path *p)
 {
 	return p->end - p->start;
 }
-- 
2.45.2


