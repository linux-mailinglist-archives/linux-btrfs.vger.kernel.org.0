Return-Path: <linux-btrfs+bounces-9397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4359C2427
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8AD282ABA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A24420DD42;
	Fri,  8 Nov 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkTIaBvX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5D1C1F3F;
	Fri,  8 Nov 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087555; cv=none; b=AMTi/vXP8srkwsIayTigRm/4P+XKgpS2AH9Tzi2/lOAxR1eEEqLaMbaIe9gDjaUuGRfCjeGO0/QfdexKTx4zY9vzPYQEf8KwgOFOiwaU6SMG6Rs7wM+dPrCS1vwCta/N/fvE6clJBpsr++niqs0b4M/QlIY69EbYD06KLF4Q0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087555; c=relaxed/simple;
	bh=0kFAmvPEntKwdDSErVOOx4lKOlvC71NdwStM0gb4Zls=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p9z62BdHhuJoAmO63O/8pCcDRfHecs8Pwob2qCqVijqGjdWKSJxZ+9r5JCAD6DSxzbF4aw2DHOpG40IE4AvR31pHsxbl6jLIRxi88adHqpwWhY5rLh7+MoOlvMmq221atzaajzZNzmeL+l5MSSCm4vcfnXVsBIKqY1NWhocwW8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkTIaBvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF8C4CECD;
	Fri,  8 Nov 2024 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087555;
	bh=0kFAmvPEntKwdDSErVOOx4lKOlvC71NdwStM0gb4Zls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dkTIaBvX7Q4xUG4BevRMRM04mHPA41zTQDEngcW0ktiB0SfysD7oiBLa5lXifgZR8
	 xOfhN22p6qqU2gh+9q0VbEcnayFXybJGiAJWghwRgGds58e09+1wmTgPgqqGIYNcfJ
	 XowNK5V0S7+RQpDBFbuE0U0Pz96ugD6cfBA6ISJHWWGLA10d/S1Iaj9Ou7s9zz7jJi
	 HFkILcht29pIfQQczcwUZFLIm5y31Q209xq7IwUE/w/AwiqASYOQb/kNlVV6DopSB4
	 1txf57rAbaGLSdjDFEOGfHPSFAXd4s0GDFBknFQrQrmAAxPk+ZfdtDxV2xhlNEI0bR
	 la9F9tOTxhMiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A93809A80;
	Fri,  8 Nov 2024 17:39:25 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1731071660.git.dsterba@suse.com>
References: <cover.1731071660.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1731071660.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc6-tag
X-PR-Tracked-Commit-Id: 2b084d8205949dd804e279df8e68531da78be1e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9183e033ec4f8bdac778070ebccdd41727da2305
Message-Id: <173108756461.2704280.15905230561937937862.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 17:39:24 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Nov 2024 14:45:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9183e033ec4f8bdac778070ebccdd41727da2305

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

