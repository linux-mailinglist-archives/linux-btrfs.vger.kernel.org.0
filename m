Return-Path: <linux-btrfs+bounces-14644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E41AD9492
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB9A1E4148
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71406232376;
	Fri, 13 Jun 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk6CR/sn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04B20F09B;
	Fri, 13 Jun 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839952; cv=none; b=EvUXpUuL1Xqg1oQcY4zvEi48AeD2qHyyGDCcHuS0D4MO8QikdK9mWafQowjuNNmg7VKcT2tqZb0meJIM/uY9yy+DxkC1eS7//XpCQE28XSC24ZE3HV9Lk1AILaflM3Z76is3HmUfTwNSiZxHbTfcOxn/wDt13KTxyRQvSSrlhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839952; c=relaxed/simple;
	bh=uxON06BiFkyn8kpoggwcIgSEOCzuk/HH+w7AfcQmYok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLsJfGnPgqbjvK76VBCfH85E0PXXCIlIeOoupBaS/Rkwa433N7iJFTfFWYGKGEmc6zkugq+tsEA/SQysNFOWE6Y6Ihk3x6RSA6QssP3iRI/0AuGjEJuuWQjs0NTRqaHVfWx4iKzzEVEKPc5Z5fYI7DbjQ7k2Q6Y6QcD235ugehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk6CR/sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9405C4CEE3;
	Fri, 13 Jun 2025 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749839952;
	bh=uxON06BiFkyn8kpoggwcIgSEOCzuk/HH+w7AfcQmYok=;
	h=From:To:Cc:Subject:Date:From;
	b=Xk6CR/snAuOmRpGz+7mjH0nfkUQBqWC/UPP+PlUrcF1LEw6AwPHjSGh4mCCHJb5er
	 lrlur8pKGLyF5i/wRt7XxaqE6XlEEmk52gO/dnaz2dIMvrrDI6vCt/Kd5KPIgXPTZt
	 MPk+wv7TzxVumEWXDqXYy4C1C/N7e0Fno0tZ9sFKHSewHqaBKU8M/mU9LI3jkneuDi
	 fovB82ooy7YIdcv+14NlyFkk1s5Wouohv+t3bqLSIqP06nIhE8L0E9VoOcuFxoCjaZ
	 0f884wLCs3vCdaoQ9cyAu7zHAvARI1KGUNW7l8mZiGJ2k6pqMKEywk0aMEGmmGv7MX
	 CLlgxmrVZT8Vg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Simplify the shash wrappers for the CRC32 library
Date: Fri, 13 Jun 2025 11:37:51 -0700
Message-ID: <20250613183753.31864-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series simplifies how the CRC32 library functions are exposed
through the crypto_shash API.  We'll now have just one shash algorithm
each for "crc32" and "crc32c", and their driver names will just always
be "crc32-lib" and "crc32c-lib" respectively.  This seems to be all
that's actually needed.

As mentioned in patch 2, this does change the content of
/sys/fs/btrfs/$uuid/checksum again, but that should be fine.

This is based on v6.16-rc1, and I'm planning to take these patches
through the crc-next tree.  These supersede
https://lore.kernel.org/r/20250601224441.778374-2-ebiggers@kernel.org/
and
https://lore.kernel.org/r/20250601224441.778374-3-ebiggers@kernel.org/,
and they fix the warning in the full crypto self-tests reported at
https://lore.kernel.org/r/aExLZaoBCg55rZWJ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com/

Eric Biggers (2):
  btrfs: stop parsing crc32c driver name
  crypto/crc32[c]: register only "-lib" drivers

 crypto/Makefile    |  2 --
 crypto/crc32.c     | 65 +++++----------------------------------------
 crypto/crc32c.c    | 66 ++++------------------------------------------
 crypto/testmgr.c   |  2 ++
 fs/btrfs/disk-io.c |  8 ++----
 5 files changed, 15 insertions(+), 128 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0


