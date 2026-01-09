Return-Path: <linux-btrfs+bounces-20341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5471D0B926
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E78309147B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2B35A938;
	Fri,  9 Jan 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0uUJN0b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78852500973;
	Fri,  9 Jan 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978618; cv=none; b=aG+NGqZO2aKmda1v9O8Bd8sIo3t0xA/N5NL7/TDhtf6fZU6LvY9biuUQ0UuJ85Q5NCHfByUFpRoGyc7EAv1DPKyyZEA2gMyXEwwzbe+A/KeGOTXWM8HDCTsB2Wsqd9W8oX0fyyhOIKRzb9Pys4eA29SFIlPVs5lsGgEwNVLxhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978618; c=relaxed/simple;
	bh=gAEfVmS6Ucn1h5yhh9qvRO4x1KS7ZV6Wyuwt6ikQ+BE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cutcoZkwF1JrTh6C0m5QWADCP3AwBjbvT6NTWfIxcFyJVFm5aR0edpzTsL3FIIFhBSdA54Z8Hw/422jm62suO/l3Ucj7fMWPCB/XrFDvfog40eTQLaynV/83tYdTLLomdIFp0EUA11RF5NpIn7tO5CitkwIUD0aE0Qy8gsGBOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0uUJN0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315B8C4CEF1;
	Fri,  9 Jan 2026 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767978618;
	bh=gAEfVmS6Ucn1h5yhh9qvRO4x1KS7ZV6Wyuwt6ikQ+BE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m0uUJN0bQac6nNoNg1qZxt1Gm5q90lPZ9T5x1H8PF6C1euFQ7hns29MTzVjBhEjou
	 oeVXVWUhhtBxAGNha3GmM0YAeWokmHe23lhO1D0h15yTGq8OUseJpNmeNiYoUk0xmE
	 /IEDPXPK6sdw5Xo6puhLCvHHDXk9ciMpy2DgX/a/jXGcyj48kD02zo26wnBh74u1ek
	 s7m9dYD0ACSfnQOEyLuuKASbqSCu9Z7ozCKNuHmgBajSc+IQMCK2TKjG0+SVfZpDQZ
	 RFIf8Rz1pitvOyXapWA4qu7O8vNRDbIJtcLVrjX1iFXTVeBQouEUBOZnx3H6U2jftk
	 iyfxvbrH31ihQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C8C93AA9A96;
	Fri,  9 Jan 2026 17:06:55 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.19-rc5, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1767974557.git.dsterba@suse.com>
References: <cover.1767974557.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1767974557.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc4-tag
X-PR-Tracked-Commit-Id: 2bb83bc42be6280d9bc363b8fbcd6fdab690d16d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 372800cb95a35a7c40a07e2e0f7de4ce6786d230
Message-Id: <176797841370.335093.2558726200160210980.pr-tracker-bot@kernel.org>
Date: Fri, 09 Jan 2026 17:06:53 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Jan 2026 17:40:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/372800cb95a35a7c40a07e2e0f7de4ce6786d230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

