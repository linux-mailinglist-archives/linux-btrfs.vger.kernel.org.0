Return-Path: <linux-btrfs+bounces-17010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FACB8D4F1
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 06:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD89A3ADDEA
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 04:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E627F015;
	Sun, 21 Sep 2025 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgN04HC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0E2F29;
	Sun, 21 Sep 2025 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758429933; cv=none; b=HjDzBUd56gINaWB+bKmhOGRvWU61a4JR8fdRIkwyO+hnmKesKnvVq9rL2isvHv88n3cHpn2a2v+IYiTix4hUJj7WEmTtKVO0DVCu/It2S/neXcVAjM5inq4UJfMN9qeyj7SZ02vrlL7ZurLgb4/5xiOuaFpdzVWRe3Mmx3e2e60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758429933; c=relaxed/simple;
	bh=qx8GwG2Srx1F4a7u71svjX1Ni3Fi8xyIjfnaJ9DiEvw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oBgbJDrXZXIdHnUQsN+jRWZDSU6sWkKuiX0spEniiz3IstW5zDJedQFbLoaaU+ZG2N8/+B6x3AdC0OPKdC1zA7MSdKsyv7fNFkLE93dtxFv5K2VwGucj3c+7O2dhzlxQAT3hu/FVj/qV1rEt+pXaJzredW/FGg789eC1DHQ32Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgN04HC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750C5C4CEE7;
	Sun, 21 Sep 2025 04:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758429932;
	bh=qx8GwG2Srx1F4a7u71svjX1Ni3Fi8xyIjfnaJ9DiEvw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kgN04HC0hgOW1WN4Okijo4X+ja7Yf8M0Fhsp9/AiGxCyVvP7Cwz/NZLbJw3CA/yw3
	 UbJdZZEU1A0ZiY9R3SCsLStqS3Ozymo5THxtzfvc9grbbpnp00O3baZ7N2R895BGQG
	 WSSprsVgnRM9aZwL25KiCX8yOn7CJGzTxukEB9bzMGtFhQTtGM26kNDuwtCBgUz39Z
	 Wf+qRf4L8OiwUL9yPAHuTMaaTH2kwTfAvcBx+3dlCsGVSwmv3R9RKbTteNmvsBuNh8
	 LWSmdg8nsEFFSzGgOzrQN1HQjdtbhjlYL7z0uXFsN9xXUcMiRrh4eyQYAGukPbamcp
	 q0v1DG/pofmng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3419739D0C20;
	Sun, 21 Sep 2025 04:45:32 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.17-rc7, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1758428886.git.dsterba@suse.com>
References: <cover.1758428886.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1758428886.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc6-tag
X-PR-Tracked-Commit-Id: b98b208300573f4ab29507f81194a6030b208444
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
Message-Id: <175842993071.4062243.15028035083249452714.pr-tracker-bot@kernel.org>
Date: Sun, 21 Sep 2025 04:45:30 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Sep 2025 06:35:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f975f08c2e899ae2484407d7bba6bb7f8b6d9d40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

