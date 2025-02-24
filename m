Return-Path: <linux-btrfs+bounces-11736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC21A41A21
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 11:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DC71784E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759D2528E5;
	Mon, 24 Feb 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt7VpsZ5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F724A055;
	Mon, 24 Feb 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391179; cv=none; b=cAprZK2UqoD+1BPejFidxX5I2FH5u/tiCjfOuP6pklcPhPzUDtlEzS3GZThGBXeBGefwmDFX3qrY2id/pIhAsQxm53mLZpi3PX+ntAV9Fy5mna852FDfe3xvA0H1bSdB/bdPieBPxo9pqaIN3Mt0br4SMVCV0PSfGkuev44or2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391179; c=relaxed/simple;
	bh=JD9u2n4cKf6e0QtZVKFcf81ujOiCIVUWgua9u8tSrsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQy6iA77gmatYXXSMYtpSuvNCd/rVzXhxhbUYVmsz2WIIwaqJ7M45F+/7TJZg20Zwc+DO9nOZTvLqbsDqWznxtWZvBeBXb1PyYwE48PAqgtg9DK9uO1YHgj49NkCJbdmG8k/sG3qKeT/ebyPnGa2V2gLio64CnX22/Fvtw1zaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt7VpsZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77ACC4CED6;
	Mon, 24 Feb 2025 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740391178;
	bh=JD9u2n4cKf6e0QtZVKFcf81ujOiCIVUWgua9u8tSrsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mt7VpsZ5j8y+PBbwYsYxpNA4RJWvvA86wI3pBKKsFN2p1OtYFIX/WL9KHHGPTlQLY
	 52pWQBBd//obrDtblygqoNbJ9zWGZh+bW2P1aL6wyviMk2W91vb2d6eRo42mzF0cqy
	 c7UPaq+v+OFLs4wE1I+yiRco7x+9KcA6Ocg9imKZEa0eYR4Cl+tkp951nM4+DzRDOF
	 E2JuLn1T5gLz6S4AIzUSn0o1kHXJfT0dh70kthXcYxSFs+D0duQg5bLOXzpyEnFfGu
	 i7WsqbU00Q9+o5EErsXfrjKIHtnyx0+zb3WyCHthc7BRF02j6tnTaDmM35BDGzSPae
	 cJ2eHlShHxx9Q==
Date: Mon, 24 Feb 2025 20:29:34 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 5/8][next] btrfs: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <3c3310a23caf3d78ae62c85c9476d5dfe4a1f871.1739957534.git.gustavoars@kernel.org>
References: <cover.1739957534.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739957534.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Change the type of the middle struct member currently causing trouble
from `struct bio` to `struct bio_hdr`.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure `struct bio`, through which we can access the
flexible-array member in it, if necessary.

With these changes fix 32 of the following warnings:

fs/btrfs/volumes.h:178:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/btrfs/disk-io.c | 4 ++--
 fs/btrfs/volumes.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f09db62e61a1..2fbaaa9ab3e3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3963,7 +3963,7 @@ static void btrfs_end_empty_barrier(struct bio *bio)
  */
 static void write_dev_flush(struct btrfs_device *device)
 {
-	struct bio *bio = &device->flush_bio;
+	struct bio *bio = container_of(&device->flush_bio, struct bio, __hdr);
 
 	device->last_flush_error = BLK_STS_OK;
 
@@ -3982,7 +3982,7 @@ static void write_dev_flush(struct btrfs_device *device)
  */
 static bool wait_dev_flush(struct btrfs_device *device)
 {
-	struct bio *bio = &device->flush_bio;
+	struct bio *bio = container_of(&device->flush_bio, struct bio, __hdr);
 
 	if (!test_and_clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
 		return false;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 120f65e21eeb..6eb55103b3d1 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -175,7 +175,7 @@ struct btrfs_device {
 	u64 commit_bytes_used;
 
 	/* Bio used for flushing device barriers */
-	struct bio flush_bio;
+	struct bio_hdr flush_bio;
 	struct completion flush_wait;
 
 	/* per-device scrub information */
-- 
2.43.0


