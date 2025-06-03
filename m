Return-Path: <linux-btrfs+bounces-14412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E04ACC99E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5AD07A65E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EE823AE62;
	Tue,  3 Jun 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThZJvkR5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408A23A9AA
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962233; cv=none; b=BCFAb2OxKoKbBmhumP0OZir3Xcmqin4XEGQSVNymJqwqLQcCbY8RAFUJ3Gycc+4IRrGFnZ//uhvMe8e0Zd1Vy//IGCBPjYU7dqhzQf4i5d56vqok7IE5+10kgKsy/lCBujXlXudbETw8Ce66zhNHTHjrENUHLvLxE2VxCk4CTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962233; c=relaxed/simple;
	bh=zRzykk+xhI9Z9XeLQunTkrcAKNohFw22ElRvZm/CTqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5UibP/0TDuxdvifh2er+yb+Okv8lIA0GXS3xRxn6syRZwwAW+w7CJFeyP1DdKgMrUsncLQ/whYsqg09rXeoPbkkF6yoNJKDmuExAY9b9UUvDam51J8uYt5Fn85rH9sqrpBCQ8l3wh9NFMfVCatcFwspVoqEhxCPOBiLHX3X72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThZJvkR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F34C4CEF2
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962232;
	bh=zRzykk+xhI9Z9XeLQunTkrcAKNohFw22ElRvZm/CTqg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ThZJvkR52v9EEz/SHQkukHSdBeN2fC8lUTr3KjGNfHe64yc20IHWx1jo1GetcFTfL
	 Yq0ZhjKZ/YleIlXb92GP6a+gi/nGDleMJACKQg4EGZTc52AC4ZNMHh5GP9sfHa8JTI
	 Vyt4Ml5vYFziPWn676o01K+QRUbBb5maCRvEI1CkwvlJ9kG3AMdHNuSl1rleKYJUhh
	 ojRdsDus5OZYa3r8ojvatjWWlaMae+JXjYuoTxQp9pouSHe518HLwjiVCMr8vnU46q
	 b9v1mS2M3enmRAGVY+/OPovhcHK1f/40sxdJpM21RcROlH6sQJ0PmgqJonI+MFyu72
	 XHXzUaVdd6O9g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: reorganize logic at free_extent_buffer() for better readability
Date: Tue,  3 Jun 2025 15:50:25 +0100
Message-ID: <efce1f97dd115d01776b1fa08b830168a8a16133.1748962110.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748962110.git.fdmanana@suse.com>
References: <cover.1748962110.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's hard to read the logic to break out of the while loop since it's a
very long expression consisting of a logical or of two composite
expressions, each one composed by a logical and. Further each one is also
testing for the EXTENT_BUFFER_UNMAPPED bit, making it more verbose than
necessary.

So change from this:

    if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
        || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
            refs == 1))
       break;

To this:

    if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
        if (refs == 1)
            break;
    } else if (refs <= 3) {
            break;
    }

At least on x86_64 using gcc 9.3.0, this doesn't change the object size.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c562b589876e..a7713be7ae87 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3487,10 +3487,13 @@ void free_extent_buffer(struct extent_buffer *eb)
 
 	refs = atomic_read(&eb->refs);
 	while (1) {
-		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
-		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
-			refs == 1))
+		if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
+			if (refs == 1)
+				break;
+		} else if (refs <= 3) {
 			break;
+		}
+
 		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
 			return;
 	}
-- 
2.47.2


