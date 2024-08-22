Return-Path: <linux-btrfs+bounces-7384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197DA95AA84
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FA51F217F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C798346522;
	Thu, 22 Aug 2024 01:29:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2410A19
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290184; cv=none; b=sVRnAp3P/JdXgBzZDy5O6e0So2E9hGAuvCCl/vGOy72af7zH+fUB6ggXyFccy265SMrEzXRnbSbO3djMqNXGZuNmtAKotmP+noJhOba7LjtHHtQILoIqCVLRNIjGSVKHaUJ5tzAwkb8En9wDI0idBt0+cP8pRqRiTdcaxivz1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290184; c=relaxed/simple;
	bh=7lVZXLm7YNqrsNS83Kr7V0DZmJDB0W/SJmt36ysW+8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DlZoUWNl5xXvJjdCccmXDquPEW5zW4YAZA5mk5XzoAzyPUtlowUwrNhqOkGYpGhq/Pr4bffwha5ykWDaqeZWpOk92NZUvSMXI7z3M6jnbY5P57NRbsB9bah2vQ0PwhoVI2yNHVDFpZ1+htAYmgSO76ORmgx+A/KoLv//v3sKO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wq59410qJz69LQ;
	Thu, 22 Aug 2024 09:24:56 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id DEB5A14037B;
	Thu, 22 Aug 2024 09:29:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:38 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH -next 00/14] btrfs: Cleaned up folio->page conversion
Date: Thu, 22 Aug 2024 09:37:00 +0800
Message-ID: <20240822013714.3278193-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi all,

In btrfs, because there are some interfaces that do not use folio,
there is page-folio-page mutual conversion. This patch set should
clean up folio-page conversion as much as possible and use folio
directly to reduce invalid conversions.

This patch set starts with the rectification of function parameters,
using folio as parameters directly. And some of those functions have
already been converted to folio internally, so this part has little
impact. 

I have tested with fsstress more than 10 hours, and no problems were
found. For the convenience of reviewing, I try my best to only modify
a single interface in each patch.

Josef also worked on converting pages to folios, and this patch set was
inspired by him:
https://lore.kernel.org/all/cover.1722022376.git.josef@toxicpanda.com/

Thanks,
Li Zetao

Li Zetao (14):
  btrfs: convert clear_page_extent_mapped() to take a folio
  btrfs: convert get_next_extent_buffer() to take a folio
  btrfs: convert try_release_subpage_extent_buffer() to take a folio
  btrfs: convert try_release_extent_buffer() to take a folio
  btrfs: convert read_key_bytes() to take a folio
  btrfs: convert submit_eb_subpage() to take a folio
  btrfs: convert submit_eb_page() to take a folio
  btrfs: convert try_release_extent_state() to take a folio
  btrfs: convert try_release_extent_mapping() to take a folio
  btrfs: convert zlib_decompress() to take a folio
  btrfs: convert lzo_decompress() to take a folio
  btrfs: convert zstd_decompress() to take a folio
  btrfs: convert btrfs_decompress() to take a folio
  btrfs: convert copy_inline_to_page() to use folio

 fs/btrfs/compression.c | 14 +++----
 fs/btrfs/compression.h |  8 ++--
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent_io.c   | 92 ++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h   |  6 +--
 fs/btrfs/inode.c       |  8 ++--
 fs/btrfs/lzo.c         | 12 +++---
 fs/btrfs/reflink.c     | 35 ++++++++--------
 fs/btrfs/verity.c      | 14 +++----
 fs/btrfs/zlib.c        | 14 +++----
 fs/btrfs/zstd.c        | 16 ++++----
 11 files changed, 109 insertions(+), 112 deletions(-)

-- 
2.34.1


