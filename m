Return-Path: <linux-btrfs+bounces-15897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3BBB1C676
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 14:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81EF627478
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36928C024;
	Wed,  6 Aug 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afa3dqyH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123228BAAB;
	Wed,  6 Aug 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484987; cv=none; b=i9rrFr7JmxufxEDtKothifVkhMY3UJPx1iSJMRvOlQASpl/IGSwJ6d9JUyNgVCDOdCnzz02DjCWsGRpS+y0J70luDPipmGg/YR6pR5Ry1AgLBXaZPNDfAc+GZjR/8Tg7k2i4jx0JLJL8ghUllvZ/LOXihW7NAGIV8MStIXcEBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484987; c=relaxed/simple;
	bh=F9aI4z/XIaSrTonWbbbTyixjpDZaeEII490455c3qlw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RFi1f1dt/HhFlmnItj9q4vIJRkLjC4E1uJNPfYPXvYvCsajvgwxhKkSItrTesPbznfT3A3e4i3WbY4I7OsIl2LneBD9NzmIRAsj8oL1txpiWWIgqtLxCLtmXgesjH7GS5TFlHUIRox14FkzUN0T10fZ1IIfIGUyvgyNux8a180I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afa3dqyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C40C4CEE7;
	Wed,  6 Aug 2025 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754484987;
	bh=F9aI4z/XIaSrTonWbbbTyixjpDZaeEII490455c3qlw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Afa3dqyHx0z9ctXtmx9FzRz0wkpdLNaOz9EKQa6kNhSjXLXHDcpjJDYMnzDGPK2WM
	 bL6VOxAnlU4fkKrwtFEkjrzboI49NZJC7zPudahzhil34Xp8i7v4Z9z2kf1miaIyCX
	 CkJGp8bpxebrZn53MS9FWX1dSeSpnkrrxByrmrR8fddq+iUHkFxwlr46LoGmgSpK88
	 xQ/JODPgKCL1a+zKwlHNAgEjxrRhCyNcLsLyX4AdwejvTIqCYPzAkoSfxeaqz2j8n1
	 3IiCb0vmh/52pNaWO3wW7DakW4kaIJ/WoAKc/XhpggYD4EKr2jOZsCPXRrshu24lI4
	 oqBfgmOe70Jag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA4383BF63;
	Wed,  6 Aug 2025 12:56:42 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs urgent fix for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1754478249.git.dsterba@suse.com>
References: <cover.1754478249.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1754478249.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-fix-tag
X-PR-Tracked-Commit-Id: 0a32e4f0025a74c70dcab4478e9b29c22f5ecf2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cca7a0aae8958c9b1cd14116cb8b2f22ace2205e
Message-Id: <175448500110.2781538.11930546201514588439.pr-tracker-bot@kernel.org>
Date: Wed, 06 Aug 2025 12:56:41 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  6 Aug 2025 13:14:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-fix-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cca7a0aae8958c9b1cd14116cb8b2f22ace2205e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

