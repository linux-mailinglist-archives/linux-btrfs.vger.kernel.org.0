Return-Path: <linux-btrfs+bounces-3260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADF87AFF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CC928B8F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B684A28;
	Wed, 13 Mar 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BthV/ShU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5CB84038
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350909; cv=none; b=LPZWmBKhzNTRCZSrSdWdEo0EAGmdAw/AMI8YvoL5rWahJjIQIIHlMHACS8NYtbeNz3zHUdhcrYKoQeBDoJ1econoBayDXmncesHd5dXnH7TIfqLZLTWltxoJZv0uMAzelzUJw1E6e1reZAHBnMk1dv4V3esfYBOu86zwMXabvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350909; c=relaxed/simple;
	bh=TPIpgh436/RTkMU6hqLipvWCgLN+GFBBbvyuHhDu76s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtXGsIyTfXVD4JArPFqeEHXWSa2fS1mpRTEOTSqwaYfcgaFUH8kSgIQxtQVMWfm5ZEXP3cs/5xN3uB+kFEIWfPEMkWX/iqNYuDeF+MKBFgtSMao3nYpw7Kc1d2nLGddQHoaEq8UFTebt3SMjhuEpjq+Ew7pFMOM6rlPNFOO0UTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BthV/ShU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616B9C43390
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350908;
	bh=TPIpgh436/RTkMU6hqLipvWCgLN+GFBBbvyuHhDu76s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BthV/ShU3Y2Mri0AdzfCRdpS6ZMc3OvWWLHrhGUgv8np0XZpYsiA8eMe4RtAIP3Ql
	 sN9MStuLtWUAuHlaWrAT6u8MofsARBRk9ocqRZM/0j6LSMJhzy9YBkUipVr8bxDjdf
	 /+SwzI1oWTY6SsiOQfiJ6jucurW+ZC1tF7DUh2MHbIAclvfC3JUj1OT8d41XC5hqQp
	 ubyPmSl2EZmUWsJRccqNm3FX0f5GSsxYQy9/+yorCIEYZMmxpawl0ra3vNccIXsD/f
	 HMBfmhejHjFIcwDRSy9reCOJJdZfFJlKm9OzRz6qA6Xy5bu9o5ePWeoIR30aLPRudO
	 PHBHuGIKCbo4g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: fix message not properly printing interval when adding extent map
Date: Wed, 13 Mar 2024 17:28:21 +0000
Message-Id: <ed32b1183350d7b8a5c9cce7d3e04cada65b828d.1710350741.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710350741.git.fdmanana@suse.com>
References: <cover.1710350741.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_add_extent_mapping(), if we are unable to merge the existing
extent map, we print a warning message that suggests interval ranges in
the form "[X, Y)", where the first element is the inclusive start offset
of a range and the second element is the exclusive end offset. However
we end up printing the length of the ranges instead of the exclusive end
offsets. So fix this by printing the range end offsets.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 2cfc6e8cf76f..16685cb8a91d 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -634,8 +634,8 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 				*em_in = NULL;
 				WARN_ONCE(ret,
 "extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu\n",
-					  existing->start, existing->len,
-					  orig_start, orig_len, start);
+					  existing->start, extent_map_end(existing),
+					  orig_start, orig_start + orig_len, start);
 			}
 			free_extent_map(existing);
 		}
-- 
2.43.0


