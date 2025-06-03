Return-Path: <linux-btrfs+bounces-14432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05586ACCEDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 23:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90C63A1ECA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52518225760;
	Tue,  3 Jun 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws1X68IW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80554918
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985608; cv=none; b=kLLM4MiVA390tPYpCXjzIf++NgjEMwHTXetzLVBS9OiLSf1FFqOHKw5l2j7Z+XyL7cj/mgTg63uR/pgQDnDPS/0yd5j9PnnmCmCGJo+we1t6CMxJoLjLpdCc5DHIDTpJNHFQTeFDc+2eEvkh3N7maJxVIJ5uCPhph3MheLPfrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985608; c=relaxed/simple;
	bh=xCp4Ti7pHGXB6sT1rkqb+3n91Pi6omK+nAJJvFRSVoc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LKyi7OgP4XGj716qdYyD4j9ZlbGYllaPPgCdsLO262Oezelofklie5X3Yt7zFATyg2aFVveobglzgTLEjweY3toQMZZLbup23TTs9StcEFZArb93zx/ZHVtcN5JQKZTepflesOzBwaLd6uB5036wu/LRvpJLWpmYH7ejFkvQGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws1X68IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F813C4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748985608;
	bh=xCp4Ti7pHGXB6sT1rkqb+3n91Pi6omK+nAJJvFRSVoc=;
	h=From:To:Subject:Date:From;
	b=Ws1X68IWqj5zGFymG3n7Kh7JxskjMy7zRY1Aj5CAhY/H7cInndx5Xpgma0cYrDFkR
	 zh/MT9UMXxMRUP130eIYDPyl6eLCv+aKmlHhyWMdv2O3xlzOsHzCB6znaaOUg5waPt
	 J25vQbaRtAMjk+kXL4XJNThYOo4uYvOuq8bfYEKAUOZupt9Tx4AXWBG2WJkO0TzOBC
	 khI7AedZAcSHqxTJZuTjRziKRL7gmi2RLhRv3G6pJ1L4NE2IcVMGgHtBB7fidQ3Vv8
	 AlUIOM1hUgOLO2JVnlEzV6eEOFGnHPEJGTubdMCpE1quUQ+t3y7VDcpqDsm3vOMiRp
	 ykXotJVoSiOvg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: a couple bug fixes for log replay
Date: Tue,  3 Jun 2025 22:19:56 +0100
Message-ID: <cover.1748985387.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix invalid inode pointer dereferences in error paths of log replay
and stop ignoring invalid extent types.

V2: Updated patch 1/2 to avoid NULL pointer dereference for the case
    where we find an unexpected/invalid extent type and added RB tag.
    Added patch 2/2.

Filipe Manana (2):
  btrfs: fix invalid inode pointer dereferences during log replay
  btrfs: don't silently ignore unexpected extent type when replaying log

 fs/btrfs/tree-log.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.47.2


