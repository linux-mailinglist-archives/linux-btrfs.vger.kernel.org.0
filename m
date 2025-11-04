Return-Path: <linux-btrfs+bounces-18639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0DC2F658
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 06:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E295189D67B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0F285C85;
	Tue,  4 Nov 2025 05:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRpSqZiT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17734D3B0;
	Tue,  4 Nov 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235130; cv=none; b=XzbiwVcLXXHftiqITY1FnFPxZQjWk/YwymHFB//N9K3Ll+aPfP6psrq5xlwiYFTeZ10SgiireBVNY++bPce2gBzht6xW1eYA8g3nYZ1wVIqt31RYOvniH1Chicaos0LApu1HcGjjJF3T67iYSrAt7YZz3RTuwrLuUgc1lFURgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235130; c=relaxed/simple;
	bh=hkAQZIIwksl7AQ36MUoF49jGN8o/jEcfgz+M+uKR1tY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b8sNXuTI6yIcF8Ukv/FzcJjZoiuy9uWVShac70QMWWmx35asTZgLx0wGPu+ROJRzHZxdGGi4K7z2gQhRBT55P9J3PfiuF/wz3MmRSOfZLKWvZayacBvyjHpIRkZzERgzhNBoJr7fJBwdt+wQqlKE7REqKQk8T37Po2x1gABJCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRpSqZiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4C3C4CEF7;
	Tue,  4 Nov 2025 05:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762235130;
	bh=hkAQZIIwksl7AQ36MUoF49jGN8o/jEcfgz+M+uKR1tY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vRpSqZiTszLA4+OsXwU6FrMjOvb6JqiDcIV0KORZ46QXOpsY7fXpOdpRqtA1yAtpF
	 GTLXoxjsKTN2SDazoK3u0EGOdL8TSYPwO6M+jq6vwROtUDMilKfVt7J0V7iYd0hDpt
	 LmOcN6OyjGCIWyYmMpD0DwFFMMC7KYOVyC23VJ2SRzb/Pj27Chk2rKXlMOm3eHzyu/
	 WsRvR7BMusKQIAJbAwoRsW9dIM4iSNbjfUVkLyq9DnkGBZ4L70DCT7qofuYS5W4pRh
	 1lItIlPc3sAjKYw1S3X4d77W3pIBKn6f0ktjJIxTapltfrzvmv/trhCzwsGgVMlqTa
	 qze+JK62q7h7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC03809ABF;
	Tue,  4 Nov 2025 05:45:05 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1762230638.git.dsterba@suse.com>
References: <cover.1762230638.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1762230638.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc4-tag
X-PR-Tracked-Commit-Id: 3b1a4a59a2086badab391687a6a0b86e03048393
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
Message-Id: <176223510421.2340893.9521774933781902946.pr-tracker-bot@kernel.org>
Date: Tue, 04 Nov 2025 05:45:04 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  4 Nov 2025 05:57:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9cfc122f03711a5124b4aafab3211cf4d35a2ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

