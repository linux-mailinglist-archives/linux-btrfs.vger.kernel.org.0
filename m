Return-Path: <linux-btrfs+bounces-3498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49F885FD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 18:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7759E283DA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185AC1332A1;
	Thu, 21 Mar 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG/gyWYq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC1112E1D7;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042481; cv=none; b=JhsQFlz/cyYngQlnbzFDFqwN1jZvKTuEQp/f1yZ96IUMPI/+nDmkycxs+M8KCQhh4ZE57a6HeSfDL2p6olNtc9UTC9IVy1J30B9QTOk/zYy36kXJbSVS0eCGqy6R78ySKCRw7HilKPRSNzD2uH3TV0dYizqt+i3TkVi8LNAk42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042481; c=relaxed/simple;
	bh=BOFihG2Pt5Il2uylI0MJTy4Tbs//9KAUolbjqPJMWCk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fqew7Sv17fvPeqbhSKNGm/GgcxB9nYsZuM1xYxj6UuBo2KXNjbDrQDoLkoA9FNL0JFz0WuWxDj0Wtoae1QYYwEMjQjOD01Xt6hzxtBXpKzn52Jh4/jAOA7m1MmRnxh1YeERxHULoipkhVVHzMsn7nf7i87xyZPja+kaC46UUbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG/gyWYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCDB7C43399;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711042480;
	bh=BOFihG2Pt5Il2uylI0MJTy4Tbs//9KAUolbjqPJMWCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XG/gyWYqFx7shlntopjGBD9sgMvaz3dpS7ydu+tqbqHRdD4QWrfhGEvHLHS+jfDoY
	 BJXZWohTWl1glYuP7aKKPpKl2VLoBfPblhw/IMod9d6cPWNjR09zZCwZL5TrgcT1Fv
	 CUE21gqfO0+PbUvQi40WjXTJIlBKAGnpiwkD/Hd4T1sCDQJ3Rl0UmCWTBI2dz6fEtH
	 zhkNudiZKyB4dO4wEcfqreaJceJVE3RqjK/CTLBuINodT55PyJQTcC4KQCsBdDpev0
	 H9uxIPLX4cBNp1xlXd69axDcKHozFbW0dxLcdLx7/MO3E2yWeqFK2sF1qAPIkN3nSr
	 lyYENYfStFBuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0F43D84BA6;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1711038961.git.dsterba@suse.com>
References: <cover.1711038961.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1711038961.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-part2-tag
X-PR-Tracked-Commit-Id: d565fffa68560ac540bf3d62cc79719da50d5e7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b65c810a1198b91ed6bdc49ddb470978affd122
Message-Id: <171104248072.9254.6729622821964026515.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 17:34:40 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 17:42:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-part2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b65c810a1198b91ed6bdc49ddb470978affd122

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

