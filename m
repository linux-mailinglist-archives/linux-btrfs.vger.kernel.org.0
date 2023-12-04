Return-Path: <linux-btrfs+bounces-583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3159803A0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB4B1F2112C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4552E841;
	Mon,  4 Dec 2023 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEpfAiuc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EA2E834
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1527C433C7
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706846;
	bh=Sg8IL40WXhBNKERVU2Nx+6XDJEyIXLhZLw7A4RB4Vjk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oEpfAiucqOfQtrlBsPoz1T5NYWhNmBh2V8DRQlcEYBlcKK483VU4lZDs1mQ1sa8q4
	 8RwoDjymN7lzesryCihVl1iPMbLfTsvrLd/QnJmDAzBtVyW6qwNyyD6/b2OOE6Tv7U
	 /a2ieREFTqfxhWukfg+FStu2yQy5gTvx+v85kXKSM3Ee421NXSmrG4O/oK11PMgtal
	 WwJ7cRszzwVbnXkDf8LmO83YN6L0d6CQ7u8ITi7Nvl3UggUC7Ji9NLVqUUIrXKHDaa
	 sDF/DyGt6/3fSGFZ0Fsl23fTyPRQgqyuxvAgTg+2w8ZqBXmStwrIeTr1mWRQOjsdB/
	 LzSxP2yT3hSKw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs: make extent_map_end() argument const
Date: Mon,  4 Dec 2023 16:20:31 +0000
Message-Id: <231f120d97670f5a5fbd137e301ad076329ec1c5.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The extent map pointer argument for extent_map_end() can be const as we
are not modifyng anything in the extent map. So make it const, as it will
allow further changes to callers that have a const extent map pointer.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index cd1a9115908d..44dc0cb310ea 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -64,7 +64,7 @@ static inline int extent_map_in_tree(const struct extent_map *em)
 	return !RB_EMPTY_NODE(&em->rb_node);
 }
 
-static inline u64 extent_map_end(struct extent_map *em)
+static inline u64 extent_map_end(const struct extent_map *em)
 {
 	if (em->start + em->len < em->start)
 		return (u64)-1;
-- 
2.40.1


