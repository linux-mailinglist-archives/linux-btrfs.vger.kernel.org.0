Return-Path: <linux-btrfs+bounces-12107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10947A574E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 23:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B908178798
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C4256C80;
	Fri,  7 Mar 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZowIo1b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65719257AFC;
	Fri,  7 Mar 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386578; cv=none; b=ppiGwdgkk015ROYietGgkhY7VFWc6UkVUffY+ItcLLZ9w6IQrE0/2k6xon416+Zxw41HfgAQbtH997JJaIaIHPwcmDHpBgEt8ZaYKDmM0ppIzuOsFk8vSk8dqBYBkKfVfJ2dl0yMHADV2PeIjMqNDQFg3AgQzAqxGCe+aST7O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386578; c=relaxed/simple;
	bh=MTI6kFd4T7+YeIKYBZYcrTZCELyzkl/PLGxDNpuMPKU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lmwLQ6RrnYnL4PNehnoUWaAkUKylxm+zwZwfgQ/5BMnxlq94p4iq6b0VP8XzK/kf15rYY5VYASxLW5aNflx3FgJZEQ123ut2foPrjVcFgfrIKBu19zScNlgxnNYL132SR14wBEPaqQNudPxz5ERg99VyY1az+KURcU8NSL6rIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZowIo1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE36C4CED1;
	Fri,  7 Mar 2025 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741386577;
	bh=MTI6kFd4T7+YeIKYBZYcrTZCELyzkl/PLGxDNpuMPKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OZowIo1bxrlO9j7dva2IcaVJEEHHJsuyNE01IgKNJAhfdL3nQeTSS70kDAMFBTx6J
	 Yw/cW7hPFYQGZhUU7wBv7uKYa5NDKSe41ojwQW3SeZpNblbfqmqbD5VZzOp7IjcE5i
	 olDesDgw+crEr76O36KL8hxTk2QFRrhMMxlOF18rg6a6oVwbKzwMfgJcKnkmrIUZ/Z
	 pwxzTrl5bEkV8ppA6c/v7eOYYdOB862bQKDe4EliZRwJsiFf0Ph/ggXmC4LSzrXiX7
	 q3ItWfI910y10RMsOUYNe3Le9U6HSCwW1sg8uvEJ4j9ItcyA3+a/Uc6t4KVwK2UB+J
	 zXTJ7NOmHIHIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5BC380CFD7;
	Fri,  7 Mar 2025 22:30:12 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1741370327.git.dsterba@suse.com>
References: <cover.1741370327.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1741370327.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc5-tag
X-PR-Tracked-Commit-Id: 35d99c68af40a8ca175babc5a89ef7e2226fb3ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ceb6346b0436ea6591c33ab6ab22e5077ed17e7
Message-Id: <174138661131.2506268.17769470655702144819.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 22:30:11 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Mar 2025 20:58:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ceb6346b0436ea6591c33ab6ab22e5077ed17e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

