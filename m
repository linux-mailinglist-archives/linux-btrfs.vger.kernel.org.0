Return-Path: <linux-btrfs+bounces-17298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7767BAE35C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 19:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1907A8EB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0181330DEB1;
	Tue, 30 Sep 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDxyqsUk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6530CD84;
	Tue, 30 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253740; cv=none; b=qavLBMr6jXOwsVV3a6I1upoHPuY/myW/umZMou+c6fsjFTzw0cTy2LRIivPnvfu2I2u4J/Dzgmf0IUhhAPPxeqQzujdSq5y8JfvCo0ZSpO/tMAMYYPZFvT6uoUj9InyCqSM0+iKzvxKVsh7cydQTx7JfKnrPzr++X2k92AZQSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253740; c=relaxed/simple;
	bh=jX7TCkfEjsRZnU0wNFxRrxoBOtqc/U4dK94akR/S8IA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SsDwl9bOqD+jKRqCC6TKmu134Vu1rkL901Cu0mlrstUdtbWrfWXZqcnGUtB16Mm9V6JVq3DibBFAjvE/wr073A6LpjH4twbZzJkM6Gqu/y+HgeW0IrD9rSaPo3c30JGM0Vjh0IjtV1aEepc3h2dw0YODNU4cRNManjr4xpwC9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDxyqsUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24703C4CEF7;
	Tue, 30 Sep 2025 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253740;
	bh=jX7TCkfEjsRZnU0wNFxRrxoBOtqc/U4dK94akR/S8IA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XDxyqsUkQqmLE4zALz760ZfO84syS3B2qkebj4goH+GhBvj8DGa5aZbJGxJuANBss
	 CcqUpeVz5zgrVm/ll4gVGAcarTC2bAVV9xQiTgHSieBEyNc1ALmD1HGeaSHmhMlcYv
	 7h4newvGLvuvLaVeNLSoG5kISRq84lv6W3AS5nkWWuzXzLIQiaEf6ig9WeFuIro9lY
	 Hpr9wbxrz9TCQvhpfD5XDQZcH0owDDd+rLgcARubsglkEqv0nebepRsncr1BjaDQaj
	 Iab/QO4SCFRVDbBeF/fezd6aHEMSvk0/0SPCtUo/7cyk9bpMeXSXcnb7qdJvNe+NEQ
	 8rFukC+8xBrUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7157539D0C1A;
	Tue, 30 Sep 2025 17:35:34 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1758696658.git.dsterba@suse.com>
References: <cover.1758696658.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1758696658.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag
X-PR-Tracked-Commit-Id: 45c222468d33202c07c41c113301a4b9c8451b8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3827213abae9291b7525b05e6fd29b1f0536ce6
Message-Id: <175925373313.2087146.14816762670402141345.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 17:35:33 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Sep 2025 16:40:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3827213abae9291b7525b05e6fd29b1f0536ce6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

