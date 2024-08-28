Return-Path: <linux-btrfs+bounces-7639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB561962FC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78060286C6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDB71AC44B;
	Wed, 28 Aug 2024 18:21:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9514D71E;
	Wed, 28 Aug 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869269; cv=none; b=DScAsP9CJSSjUTrV7hhmdIvaINah9au3LUKPJLM8+Qz77WZrhaPYPKBpuyMxroWpj3d49MJEPfrws9zixb3KQzi/JOPGSx3+iqT0P6m/wSb5vlbdu8JVJALPV6ZXmLW6QUE3ee7v/Ps7x0+7SGg/lvur79qCu6XC+c+tGlN2ELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869269; c=relaxed/simple;
	bh=IBSHBawgClK9JaPGHklBxDfCk453gFDJElM3fueeQLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FucVvhqjIO0Ya1mBVttGv6SMkmjScbPUgX9YQQpK7scDK+dLOWSybpBTqi+tPVK5Eo9+/TMV9TaLf4Riy3xlllJh32U54mmwDpyo7GCVXn9tnO052ie58azUrT9THlFLsBsj58/ounatwugW2bI9fUa/XLYqR19QqlJJyD9TUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvCQV0jJVz2DbZl;
	Thu, 29 Aug 2024 02:20:50 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id CB0941401F2;
	Thu, 29 Aug 2024 02:21:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 29 Aug
 2024 02:21:01 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <quwenruo.btrfs@gmx.com>, <willy@infradead.org>,
	<dan.carpenter@linaro.org>
CC: <lizetao1@huawei.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2 00/14] btrfs: Cleaned up folio->page conversion
Date: Thu, 29 Aug 2024 02:28:54 +0800
Message-ID: <20240828182908.3735344-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
inspired by him[1].

Considering Josef's suggestion[2], this patchset has passed most of the
xfs/btrfs use cases, include btrfs/060 and btrfs/069.

This patchset is based on commit bcdaf0fe6a52("btrfs: initialize
last_extent_end to fix -Wmaybe-uninitialized warning in extent_fiemap()")

v1 -> v2:
 * Change clear_page_extent_mapped() to clear_folio_extent_mapped()
 * Fix a bug[3] when folio is valid and it should be unlocked and put
 in copy_inline_to_page().

v1: https://lore.kernel.org/all/20240822013714.3278193-14-lizetao1@huawei.com/

[1]: https://lore.kernel.org/all/cover.1722022376.git.josef@toxicpanda.com/
[2]: https://lore.kernel.org/all/20240826140818.GA2393039@perftesting/
[3]: https://lore.kernel.org/all/20240822013714.3278193-15-lizetao1@huawei.com/

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


