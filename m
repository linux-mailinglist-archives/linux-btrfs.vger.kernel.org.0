Return-Path: <linux-btrfs+bounces-9847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1FC9D6E33
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E7161D81
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7FE199EA2;
	Sun, 24 Nov 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0K7Jqqf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653919309E;
	Sun, 24 Nov 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451976; cv=none; b=Z6hCYZXj1OL3xpS6g3EXuCKMAMLRggk7uMNKO1pZEg+sxqNyaej4rK/cn5rJfZS9NLdoi8cjD1KDclZQXgf0tvS5lNFbRuAM6oHio8aSdFa9bfcoWjzm9zUabfkpnlykqq8wOfX4mkN55cIECLcnJ8+4SuV5f0QEpg3bMD/Wa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451976; c=relaxed/simple;
	bh=XMlo1yQpBRNNRnhGJupEGstoridPZ71ayczFxEU9lEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TphrhntiRYLSjJVpovxktXVBLg3DaBPuIi02DGLL7EB0UZR/VKRMuV1kd9aLUWRyXheK/Kos7m19oeRQn5gCav+pfs++ox3lmdqdd7wvQ1pEfxXrf9/FtaT/OEzvidhFAxc2I13jvg4bLjj3lC1oZBSmh7TZGOVECMIEwgxeBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0K7Jqqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9ADC4CED1;
	Sun, 24 Nov 2024 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451976;
	bh=XMlo1yQpBRNNRnhGJupEGstoridPZ71ayczFxEU9lEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0K7JqqfQkQMlaMDxffYtxYrq0cGv54eMARSKNlhmc1E1mp007y6nVw7KCiFGaUeI
	 tj8dnyDwaCP9E6yUSVfxZ/tGhySbG2/26aqzuBW4BdniTHIeWsVXoXrdtLyqGjYggw
	 6vKdxsltE+3GQIn212UzuXU8MryCv1etupcfujEkDqtzXyLjmPlX/3a4M4qkji9mgF
	 Q4lSihC1ZIxTZ3Q/MBnacP+OuR+HqALWT9S6NY5krjAf1B9aoiGOEBM+mf+2qmJZ7a
	 uUfaBcKis8pkcq1GkD+Vtg9sxwUBnr0wUId+mcQENOGDEOoFSb7SRPJJes8k9c469C
	 /Zmb1A7eTNrRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/19] btrfs: make extent_range_clear_dirty_for_io() to handle sector size < page size cases
Date: Sun, 24 Nov 2024 07:38:45 -0500
Message-ID: <20241124123912.3335344-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit a4ef54dbb576032ba31a646a5ffc8a26a83cb92c ]

For btrfs with sector size < page size (e.g. 4K sector size, 64K page
size), and enable the sector perfect compression support, then the
following dirty range can lead to problems:

   0     32K     64K     96K    128K
   |     |///////||//////|    |/|
                              124K

In above case, if we start writeback for that inode, the last dirty
range [124K, 128K) will not be submitted and cause reserved space
leakage:

- Start writeback for page 0
  We find the range [32K, 96K) is suitable for compression, and queue it
  into a workqueue to do the delayed compression and submission.

- Compression happens for range [32K, 96K)
  Function extent_range_clear_dirty_for_io() is called, however it is
  only doing full page handling, not considering any the extra bitmaps
  for subpage cases.

  That function will clear page dirty for both page 0 and page 64K.

- Writeback for the inode is done
  Because page 64K has its dirty flag cleared, it will not be considered
  as a writeback target.

This means the range [124K, 128K) will not be submitted, and reserved
space for it will be leaked.

Fix this problem by using the subpage helper to clear the dirty flag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1e4ca1e7d2e58..686d39309410f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -902,7 +902,8 @@ static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 e
 				ret = PTR_ERR(folio);
 			continue;
 		}
-		folio_clear_dirty_for_io(folio);
+		btrfs_folio_clamp_clear_dirty(inode_to_fs_info(inode), folio, start,
+					      end + 1 - start);
 		folio_put(folio);
 	}
 	return ret;
-- 
2.43.0


