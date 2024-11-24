Return-Path: <linux-btrfs+bounces-9871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C876D9D6EDC
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17E416281E
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0D51E0B91;
	Sun, 24 Nov 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX1LEq27"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA41E0B6E;
	Sun, 24 Nov 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452156; cv=none; b=eoBcSc0DMdfbX2tF6xqkYK84ERqSL21rJb9TTbc5Il+lOwLRiHKbYgL1TZiJfboJXiZcWeAKw1uvSKalylwIKFgGfWv2FPsgG1aQUdcykjNVIr7HyRRQwKpPxJQ33Ed9GMbYpnCqouVStKgASOzsQJEt6MNdmEpICpZ9cHR3RIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452156; c=relaxed/simple;
	bh=U5cJMnmzukYGPKOjl6IplW7PNAjyX2EZNYMB/z1fB5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bClRrman0THI0lxuSKhWIzoWf0kmrY5gIOL7GIS19ZzFKK3GZV8B2xdnUoek+4e+v1SaY1zFpW6J2bHA+mQdvTyqXN9+QmYrUZ8RSqiONFqVuRZzlJuvWU/thL0R6qmESe6bUHUbaTYc5Ab3E94pViQ1PTb3Y+iroiHzPuUYFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX1LEq27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E46C4CECC;
	Sun, 24 Nov 2024 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452155;
	bh=U5cJMnmzukYGPKOjl6IplW7PNAjyX2EZNYMB/z1fB5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX1LEq27R68zGVd39ywGNFfFQGQO7GJRanaCtuyB7xke2jzrEHBp7V5s1pIAjWMWb
	 c8h/EogpRgPZO3lMTAjflOqrHbtlkHhskgOjjpG3bLq2fgl8DzdBIFtcV1Z494Dicq
	 XdVFw2ktDhWm+yQNws8/qW6dqMKNrJCwW21GkBvEqtKpnJos6D1L9Tj/cbZapAOtzI
	 D+iIGuHwS2Tgbs7AEHDF758f9vfZ0P/hAtzxImbF57MTLR+LIodaHBxdbEhTsyCO3a
	 A2IgRyNm/4fSe4QKGnypfoFfQGgv6VMq8KQUen4NFs9Qrv/hEWAiZmRYhRYQFryzZI
	 N6JPYTR/AQzxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/2] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:42:28 -0500
Message-ID: <20241124124231.3337202-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124231.3337202-1-sashal@kernel.org>
References: <20241124124231.3337202-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 2342d6595b608eec94187a17dc112dd4c2a812fa ]

Smatch complains about calling PTR_ERR() against a NULL pointer:

  fs/btrfs/super.c:2272 btrfs_control_ioctl() warn: passing zero to 'PTR_ERR'

Fix this by calling PTR_ERR() against the device pointer only if it
contains an error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a595439518519..086d6d397f0be 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2283,7 +2283,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 					       &btrfs_root_fs_type);
 		if (IS_ERR(device)) {
 			mutex_unlock(&uuid_mutex);
-			ret = PTR_ERR(device);
+			if (IS_ERR(device))
+				ret = PTR_ERR(device);
+			else
+				ret = 0;
 			break;
 		}
 		ret = !(device->fs_devices->num_devices ==
-- 
2.43.0


