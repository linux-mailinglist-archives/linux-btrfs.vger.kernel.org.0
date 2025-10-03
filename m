Return-Path: <linux-btrfs+bounces-17414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC6BB71FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 16:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8D19E095A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9E207A22;
	Fri,  3 Oct 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="useM9sfP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962161FC0E2;
	Fri,  3 Oct 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500676; cv=none; b=bdSmf0+nsrBeD15uKQqkACdGIXcx4n7iNxOkz1qOIGmV3fZ6Zkauui9kdkRHabKhOFhjWu0fFoL6B5a+QBavzXmZRrAOeFTyuZvZLdbx1qLXJ2XoAXmpOEjZBRj1TR3YaONqO+qUphMOaPCNofXvuF1luxkczg9jQ2JLBfNPLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500676; c=relaxed/simple;
	bh=4vN1hEkmtmKRCkrSy9yEROR2zwPDFh6Z4FaS19nadUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vhb+yKcDaLPTPAvlLHBDPwT88nhL2evq3SRqM/kS1BKbEBpiXXCOb/YImmV4Xg9qq0XYdetZ35t3p8XUDX9viZ+28+MvBLHin6PNqCjhUw3imOrbOyhlLbLY17kP7Xen8Q1+0wl2VCOBiIfrsP1jPuzlyBzsPMC58hzpLwrg3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=useM9sfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423E9C4CEF5;
	Fri,  3 Oct 2025 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759500674;
	bh=4vN1hEkmtmKRCkrSy9yEROR2zwPDFh6Z4FaS19nadUk=;
	h=Date:From:To:Cc:Subject:From;
	b=useM9sfP6F/GkKCi7h4t6GsMEIWewPJCvIFTHd0suV7ge5Ofkt2GJhIxYDVfZDcvl
	 tuoEkYPzlPKID/+XwMkM4bO/aVqsXI2jcU1CrKMrinjGXfO2igPTrvtW4JEMBhx4lb
	 93w9d5jj6cOAuofCB2zH4PLjff3VAWxg+bC1cSav1VNR5hVhwU30LEzZlO73i9JOYK
	 oh+IswBQSd8wB7blxIKPjhRhlmYhz39R/ooqRNVd6lWdMcIWZJjgHPrS8SJDXqM9Nl
	 PZFbb00O8Z5oZ7zTW/eeJfJm3u5oIDc8RSsly7jRN39jdsvICVgv+wbr+iQuoRlYNd
	 nwRvs2PsbuZ6A==
Date: Fri, 3 Oct 2025 15:11:06 +0100
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aN_Zeo7JH9nogwwq@kspp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the corresponding
structure. Notice that `struct fs_path` is a flexible structure,
this is a structure that contains a flexible-array member (`char
inline_buf[];` in this case).

Fix the following warning:

fs/btrfs/send.c:181:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/btrfs/send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9230e5066fc6..2b7cf49a35bb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -178,7 +178,6 @@ struct send_ctx {
 	u64 cur_inode_rdev;
 	u64 cur_inode_last_extent;
 	u64 cur_inode_next_write_offset;
-	struct fs_path cur_inode_path;
 	bool cur_inode_new;
 	bool cur_inode_new_gen;
 	bool cur_inode_deleted;
@@ -305,6 +304,9 @@ struct send_ctx {
 
 	struct btrfs_lru_cache dir_created_cache;
 	struct btrfs_lru_cache dir_utimes_cache;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct fs_path cur_inode_path;
 };
 
 struct pending_dir_move {
-- 
2.43.0


