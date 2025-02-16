Return-Path: <linux-btrfs+bounces-11485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CA7A3747D
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 14:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F208916C655
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1B1917D9;
	Sun, 16 Feb 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyU2bdde"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772711624C3
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711769; cv=none; b=IGGNz56dl0V2wQtmcbJZm9/DGPb+gExhDdsaMdf5UVpmsMRGUtzwEBDTxIREgf5mR5Uw50s5VWFfmmJ5PmoB9ksxbej/OIiteGhZpqVWjLvLSEGgOhXNtpzWr3KOugkVhyyQ2qNoJCsUHFesWsHbbm+F3HKTGE6/+gz9Veqjk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711769; c=relaxed/simple;
	bh=nZ608LNsJ4MK7FLNJBR+Rjq0xl45IYo+lMQsy6xQtTo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BAb4p3BvbhkuUgqjPAHuIPdopG2QwF9Tmy4Y8F9KW9rkFJe8qtcPM/GRlBnqVsCVArUoj4Fst+APEb+y7cW/BDhRFg3BbUXlNO4eYNA1LAzP/dQa72O2DnSk/SsT+XweAlA/emLHWbs0U8DZEDkvCU7+JcEgMLNWJRe1cgvJ13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyU2bdde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68223C4CEDD
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739711769;
	bh=nZ608LNsJ4MK7FLNJBR+Rjq0xl45IYo+lMQsy6xQtTo=;
	h=From:To:Subject:Date:From;
	b=VyU2bddeDvSb/JUjzKLAcF5m5s/WX+gvXnLyaKYwwH7kZxD3ABi+xJneQEOfdUoGQ
	 +pMRodF0NApY/fz9VcRlChDBOOp/tVqDp20oL9N2DR4a1qsjXLuEbc6+ogxYVjmbJ8
	 qMu2RpiffzMKZi/MPUWbYNYzeEpVOUHB/eFRq9GypF3lRWGh4oFr4KXtI2BBkS0sr1
	 uxyzMa1SSm/wSsB6sGkgQOZ81TBaZeycJoXZqFcCG1N8/fOY88fZFG9en2m/nm4Sy4
	 J4prvapCtEMhUTJhFvecLmmuWSawsiXCSYDbs4ZNCdCfxvR3f9uqKFd/dELH+/b35l
	 mme23r80GHCdA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some fixes related to the extent map shrinker
Date: Sun, 16 Feb 2025 13:16:02 +0000
Message-Id: <cover.1739710434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A few fixes and improvements for the extent map shrinker. The first is a
use-after-free that is likely hard to hit and the other two fixes make
things more efficient by avoiding grabbing and dropping (iput) inodes
which don't have extent maps loaded as well as eleminating the need to
do delayed iputs, as that's not needed anymore.

These are related to a recent report from Ivan Shapovalov where the
cleaner kthread was using over 50% of CPU doing a lot of delayed iputs:

  https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name/

More details in the change logs.

Filipe Manana (3):
  btrfs: fix use-after-free on inode when scanning root during em shrinking
  btrfs: skip inodes without loaded extent maps when shrinking extent maps
  btrfs: do regular iput instead of delayed iput during extent map shrinking

 fs/btrfs/extent_map.c | 82 ++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 24 deletions(-)

-- 
2.45.2


