Return-Path: <linux-btrfs+bounces-19953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6737CD67B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 16:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 251CF301619C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976C320CBB;
	Mon, 22 Dec 2025 15:08:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-42.mail.aliyun.com (out28-42.mail.aliyun.com [115.124.28.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E720C00C
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416089; cv=none; b=EQQ7gd08qxY4QbsDBF8zov3rA/YYeyp7Hwvi2l+IPFkL6C4bppcHekGyhGlPs7H+hTLyawCMJfkjNn/K5urAp06BmD2xFrO8ZQy3uN+RSXBbkmqVHnUFNlxgfufrcJla1+fQC1OvMumdIBjOotOA1CuEk85ritn13xSb7sFB4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416089; c=relaxed/simple;
	bh=VIlXq7FmyXJzmEgRuVZj5gOM94+DBJCKOIof8y29SBg=;
	h=Date:From:To:Subject:Message-Id:MIME-Version:Content-Type; b=RQPc1hF3nUrCOCqbNpf8K8eh8q+BpgJDMCAmeXQxarzTDgDPXa2h9wI1GhemF4zPdm+2rIX/UfA2zOjZtdyHLLw2FDQXcRfIIBGoM++FKo0SffJobYlW692z3ApuMNpiUyhhPkyPaYrzEsH0xYhbxr2B/pyoJ2s0hvbKg9qzAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.fqVJVjK_1766414220 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 22:37:00 +0800
Date: Mon, 22 Dec 2025 22:37:01 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: btrfs ASSERT() error when make C=1, but OK when make C=0
Message-Id: <20251222223701.F4A2.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.82.01 [en]

Hi,

I noticed a lot of make C=1 error of btrfs ASSERT(),
but make C=0 is OK.

block-group.c: note: in included file:
zoned.h:417:9: error: Expected ) in function call
zoned.h:417:9: error: got __VA_OPT__

static inline bool btrfs_zoned_bg_is_full(const struct btrfs_block_group *bg)
{
L417:    ASSERT(btrfs_is_zoned(bg->fs_info));
    return (bg->alloc_offset == bg->zone_capacity);
}

Any help to fix it?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/12/22



