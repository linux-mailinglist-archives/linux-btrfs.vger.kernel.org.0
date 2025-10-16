Return-Path: <linux-btrfs+bounces-17884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26987BE2CE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 12:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607B11A610BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF622BE7D0;
	Thu, 16 Oct 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBSZ/gi5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018F263C8E
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610695; cv=none; b=NY22IZ5JHHGr/2/y4RVzr1I09bivY+WxebkXogZcgd+yAr1XbvTZJ5L1NSt3n9khYha4gHvTVP1gjNfIpmW2c57eJsAmIulOC8VWtEJKaRFXUCUyl4gLZkhIXF6MZGa+ZYCiLXSoZDIluJHbdUIT0A/CIUDPf7KtrIxy764KFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610695; c=relaxed/simple;
	bh=vW2BegkVwse5H67KkhMRoawcVo0EWW20aAbp/NF6I8M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XG1R41k9/HCxt5njJcgzYnaFXCYmgoUdN7OVENv0NkJYABhdO1BIqdvI4MOJ//Xlv3GeoRyz5mjjAvmC4TJzNN9Kn+y+gfNFeNYk6Bni/n7ADfaMEU/407W9CXRhHTR/S1OOF6zUA2BCyOLP/DEVoVp77E72nzVZq5Z0PF04Sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBSZ/gi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CEBC113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610695;
	bh=vW2BegkVwse5H67KkhMRoawcVo0EWW20aAbp/NF6I8M=;
	h=From:To:Subject:Date:From;
	b=tBSZ/gi55wrg7otnIbxhrQFSBSsJggx6ol9L8wq4R/KDD8oHQuIWI1zewbS98KG+L
	 wHzV1tQAHWAIiyOs0h6nFaTdUkKSOcVCP6ic3z/c8x7L2MSGVXQv3oRf70WXUJgOfV
	 AeCR7aHRKib0Sx+FgjIP12eK33/UZYZDfT/YchPzjRFEW3iDDUrugnIHCddlICfefR
	 HTTZUfanIpjA/LwkQAL2Xf3DdAxP+HbEhBM57VGv0g/78NLBEz6Z2qPBmwW/GxShz0
	 rjvGcaunCGAqnHxeua8fI8HjLXPKcqKl0NA6K4CdpOBUVep/PrjAvnt/K7zK7tzpF7
	 X5etxmqkincBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless data_end assignment in btrfs_extent_item()
Date: Thu, 16 Oct 2025 11:31:31 +0100
Message-ID: <9a0df9f54ffd27b41bdae2c60b0ffd59a85a3eb2.1760610675.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in setting 'data_end' to 'old_data' as we don't use it
afterwards. So remove the redundant assignment which was never needed
and added when the function was first added in commit 6567e837df07
("Btrfs: early work to file_write in big extents").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3be1b66aea35..f6a9b6bbf78b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4136,7 +4136,6 @@ void btrfs_extend_item(struct btrfs_trans_handle *trans,
 	memmove_leaf_data(leaf, data_end - data_size, data_end,
 			  old_data - data_end);
 
-	data_end = old_data;
 	old_size = btrfs_item_size(leaf, slot);
 	btrfs_set_item_size(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(trans, leaf);
-- 
2.47.2


