Return-Path: <linux-btrfs+bounces-19733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C8CCBD354
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1957C302AB9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406CD32AAAF;
	Mon, 15 Dec 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHBNKhCg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCB314D19
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791513; cv=none; b=WqUmNmuEZxeOzux4eC+VmZ073IWCfn/6XiLTNmYZ0F6+ee88N7+LdY5tVZvrzRU/peWPs8MksScqrpsl+UPZEnkjCK+oAaxAU3wPbVim8cQWDECWt4v9DmZMM7ri3deebkpZ0KJF1FPNMNfGq5XSdyZ92zcKsZCWAOb0RI8EwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791513; c=relaxed/simple;
	bh=dxm7F4ttT73QujOpYiVNjic1kSAGkDTFHWpvgCMtfQI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TuaZTyCKimRwSkninpDOdB3mc5E64mq7TALZ3cxw5w+Kn7P9I5MNWakVxDO2mg0PcNvcFaU8vo3SXqRiobEW90+08cXgch9in+70+vdJKZ5cnZ7MG++5X/D0kyZWF+lBmiw2LmxuTSOCZrV/Oe5dSg+GrPXakkO3PvolX+Ld6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHBNKhCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3855C19421
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765791511;
	bh=dxm7F4ttT73QujOpYiVNjic1kSAGkDTFHWpvgCMtfQI=;
	h=From:To:Subject:Date:From;
	b=OHBNKhCgsc0mWdXAdE7xVIgjIw+FdUmvocWDxwvyGO/r7ALJUUoVHT1W/5HR1j0B3
	 JIz1Qdr7nGRmP/Iqx7dE1Cv/NrC3pFM8TaXCOKgijkgNfkpi8Sq3bi4+vXFEaEAviR
	 fZfxGBthrdfMZxlv02fMsXiiidDrRRtUBVKLeBbdNxX2fS9ijwln3tKgpDGHgSZ79+
	 2i6iNS8HsTV2olAWzq8y4Tqyvv+QFq88OTy7pztfNgiu0UspuUYhGgSzqM7osHF/FO
	 RjRjqm4u8lMsEV85TRDhDtoGp64DjKNszgp5uY+4snV+7AS1wEJLDdl1OFjBdtF4b9
	 5pXxpTXusvhPg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fixes for inline extent fallback and error handling
Date: Mon, 15 Dec 2025 09:38:24 +0000
Message-ID: <cover.1765743479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple fixes and a cleanup in the inline extent creation path.
Details in the changelogs.

Filipe Manana (3):
  btrfs: do not free data reservation in fallback from inline due to -ENOSPC
  btrfs: fix reservation leak in some error paths when inserting inline extent
  btrfs: update stale comment in __cow_file_range_inline()

 fs/btrfs/inode.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.47.2


