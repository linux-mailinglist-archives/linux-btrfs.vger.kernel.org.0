Return-Path: <linux-btrfs+bounces-13909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47CAB41E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D1E7B5203
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F4298CA9;
	Mon, 12 May 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FydXKL0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08323297109;
	Mon, 12 May 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073075; cv=none; b=PiMxTfnAvnT7VQOVYvnUJMuqx9kxlsjHh+x3B98yzVxl11smCK9PPJ6/uyQ4NKG1bzCb9K1ouxMywh5pAmNUo3z+iV47MFUriVo2JLN+yvBDacTKyBZBetLLJCqhIE1UcKvaach6xbwA2OP4+iBKKhx8Viz0MGbZjUAvPZ7bvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073075; c=relaxed/simple;
	bh=gF7jtwSWHDrtX0F77/is6sahyq41N8gbc93SoZnjKXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEF5qXduKq3SYIEmkGkKyzShByjipZpB5tWHH10dbKjjvsQaTLbsj/SsQY504mSy0nfu5H4n4tbB03tC0jfE9s93g570PVfJK3KHmnnifkh1NCBGVPZZ+MUm5pkm4gZS2HJeePDAYvWT0PXa+F/3Otmts7lx7QeZ+SwZpddKPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FydXKL0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0676C4CEF2;
	Mon, 12 May 2025 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073074;
	bh=gF7jtwSWHDrtX0F77/is6sahyq41N8gbc93SoZnjKXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FydXKL0hVEoTxcWj75awZZhKUkw+d823EoVDjblchCLwmsB2oG6X52IImKnuWyk71
	 LWAFoCTQ2z0qO2g980ml0B1wLQqbP6B3adw6fcVjxUH/uEYjtaApQN59bMbWfUn5Ay
	 RgVryOfVMjO1tbS+jneG41MDh8fP/g56rqLLraV04NQj/VTRIM/MWZFk/FSqXJngPN
	 VwjhZCKXI/ssMKLHKoepK9n5oOs8UHjFQP7F0pQMp9GkAUhESugn0gyaKqNFI4R3DL
	 q6ru9jMFQIuy/SW/LtGYIyINbnpo4QmKbauFvhyQ0irIvMqgV5JZK7xvn4lYLaM3zO
	 mMt/rpEKdENpw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 03/11] btrfs: handle empty eb->folios in num_extent_folios()
Date: Mon, 12 May 2025 14:04:18 -0400
Message-Id: <20250512180426.437627-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180426.437627-1-sashal@kernel.org>
References: <20250512180426.437627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.28
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit d6fe0c69b3aa5c985380b794bdf8e6e9b1811e60 ]

num_extent_folios() unconditionally calls folio_order() on
eb->folios[0]. If that is NULL this will be a segfault. It is reasonable
for it to return 0 as the number of folios in the eb when the first
entry is NULL, so do that instead.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8a36117ed4532..fcb60837d7dc6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -293,6 +293,8 @@ static inline int num_extent_pages(const struct extent_buffer *eb)
  */
 static inline int num_extent_folios(const struct extent_buffer *eb)
 {
+	if (!eb->folios[0])
+		return 0;
 	if (folio_order(eb->folios[0]))
 		return 1;
 	return num_extent_pages(eb);
-- 
2.39.5


