Return-Path: <linux-btrfs+bounces-10401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B055C9F2BF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C0A1888909
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F41FFC57;
	Mon, 16 Dec 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DydwwEHV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A191CEAD5;
	Mon, 16 Dec 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337975; cv=none; b=lmcnuDNCc7Y/CESQWY6Rz9dWhI/xqPYN7M41A98O+ygM/iOz4LLKhlwTkUWTYejrUlmxd4lm3Wk6fya4lgodxHMimly5KQPBpgTIAx3+fUb93TBCZ1e1iKDY1VSyKlv/kVgS2/VPq9Qf+srJZqgeO8/kHJJ9kzzyft3eXNtLtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337975; c=relaxed/simple;
	bh=olVS1kY17WrcCv3kW793pCXAc2bhMbq54Nxa5kggo2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=shlTuxBdT1nWkhzUp0dl/ALsbtfpmK++UTlqeZ4P+KnEkECHM9YkaayHA6yP7+VJurA7x6u5FBUkkSK6R6QFUtDXChugkZr2lQl+Of0emwGPJ5QF7ZlFh/ENXRyQAZazbis6DWSWr7FrvGUeu0A73IQVGN8W/mcO8GfV4DaOyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DydwwEHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E694EC4CED0;
	Mon, 16 Dec 2024 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734337975;
	bh=olVS1kY17WrcCv3kW793pCXAc2bhMbq54Nxa5kggo2w=;
	h=From:To:Cc:Subject:Date:From;
	b=DydwwEHVVJ2uxhaLVBGXpepl8IbQCawS8vI+buXtQh4ej8pIzEKoM2nfHGoHrJt1V
	 455BaPLqXlwxBlrdSI/V7Pm3kxU5I9U8l0ipjuvQiMAVJwdGCx5DyRv6wtoa9aHxNU
	 6NO8koBNCmQEmMEgxMIL9xATnvE7v9+JF2krMIhsyYv10vMjJYKElPGb67zXi0d+72
	 3IJ9w1LdZSgRbQJo8zT6hL1iyVnIZk9xyJB4kZkBXi9CM/EbQjeIyJ8GLTOC9gg6tH
	 xi8SQ7x4cth8GtQLd+/uFmrjpxFfcO+ncASdtf8jHpyx4z2lEViEK0gBY2NyE53g8p
	 gK4GEIeCcdy9w==
From: Arnd Bergmann <arnd@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Anand Jain <anand.jain@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Boris Burkov <boris@bur.io>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: avoid opencoded 64-bit div/mod operation
Date: Mon, 16 Dec 2024 09:32:37 +0100
Message-Id: <20241216083248.1816638-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Dividing 64-bit numbers causes a link failure on 32-bit builds:

arm-linux-gnueabi-ld: fs/btrfs/sysfs.o: in function `btrfs_read_policy_store':
sysfs.c:(.text+0x3ce0): undefined reference to `__aeabi_ldivmod'

Use an explicit call to div_u64_rem() here to work around this. It would
be possible to optimize this further, but this is not a performance
critical operation.

Fixes: 185fa5c7ac5a ("btrfs: introduce RAID1 round-robin read balancing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 50bc4b6cb821..67bc8fa4d6ab 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1433,7 +1433,9 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	if (index == BTRFS_READ_POLICY_RR) {
 		if (value != -1) {
-			if ((value % fs_devices->fs_info->sectorsize) != 0) {
+			u32 rem;
+			div_u64_rem(value, fs_devices->fs_info->sectorsize, &rem);
+			if (rem) {
 				btrfs_err(fs_devices->fs_info,
 "read_policy: min_contiguous_read %lld should be multiples of the sectorsize %u",
 					  value, fs_devices->fs_info->sectorsize);
-- 
2.39.5


