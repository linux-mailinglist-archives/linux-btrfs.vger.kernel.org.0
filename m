Return-Path: <linux-btrfs+bounces-12723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A18A77EF7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8164416CFEC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16520B80C;
	Tue,  1 Apr 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVG1dbET"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604520AF93
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521399; cv=none; b=V1RtygX+1CSmr4M42BPEaI4ULpIeCrmWZfmiyv5vwxUHkKcTvBbN/KYdRXSa1XZ+SCHXa5zk7rLxz2pTt3Mrc2Z6NJ/ibmfKUJ1RlJ6qW4kuwA1ufn0FefKwzeBWlIf2iL3ZTeI+yWJ6LtPC/VfVrhImR4+ukM2BSgD1No/JU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521399; c=relaxed/simple;
	bh=7wbYbugg6ZYVpEkA4oDYqRdd9oPIjzp6f2iMz/klY+A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TwFJHzu2T9xAYWGLzFKxxq5fUhLVdmkgsR6AY65MbTO9yww+kEVBRTPBV1v9oanmiRE9MPBWc/bB1gWyiNVAd2fU3v1M0yNe5XkJiOtpJl0BaVvEPbOme/6DfkoeLb8R3T/La44N5hLQ+51ZPYKp56jZH8BrKCznJ8PA2fv/Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVG1dbET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D49C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521399;
	bh=7wbYbugg6ZYVpEkA4oDYqRdd9oPIjzp6f2iMz/klY+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LVG1dbETp9ihcSTWbixiS3AD4wtDq4cnLruMZa33PbP3nkYQKaLllIDToMBBHdaOe
	 9Kfbo3bO8YsWbyu4/EU657w1VC7obzkZuu8pwG8lcrU2T7fezS+rd+ILs/rNHQ1ilo
	 BHenAJOehEin/lFMExW7xMe9jBfcMi8tK+8lrf6/jd6EZ5Z4tmRVCoYu2G0zFmQi+1
	 E1MG6H2DCbXHGVtq0+Yr2JICtwWAmmAVJCyJTV6zKp0NtZrGbxbKlXGmka8XButYsA
	 FXn/zXPNonmftkPmiKDpSzyzEBd/dQQCw5dOB+86aRCzAuLcXKO0DbwN3bg/tAZ/2f
	 GPmqtFe0mMWWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
Date: Tue,  1 Apr 2025 16:29:52 +0100
Message-Id: <f220d4520f6eef59436eed674af6b8327062842c.1743521098.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743521098.git.fdmanana@suse.com>
References: <cover.1743521098.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using __clear_extent_bit() we can use clear_extent_bits() since
we pass a NULL value for the cached and changeset arguments.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8c21c55be53..784d5a15ef29 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5508,10 +5508,9 @@ static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned in
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		__clear_extent_bit(&device->alloc_state, stripe->physical,
-				   stripe->physical + map->stripe_size - 1,
-				   bits | EXTENT_NOWAIT,
-				   NULL, NULL);
+		clear_extent_bits(&device->alloc_state, stripe->physical,
+				  stripe->physical + map->stripe_size - 1,
+				  bits | EXTENT_NOWAIT);
 	}
 }
 
-- 
2.45.2


