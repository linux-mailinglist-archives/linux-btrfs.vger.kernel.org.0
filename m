Return-Path: <linux-btrfs+bounces-16896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3414B815C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 20:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FB623F0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879383002BE;
	Wed, 17 Sep 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjljpe5/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3E189F5C;
	Wed, 17 Sep 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134282; cv=none; b=PLScZ4VRDOGGpIiDlck/5oGJ+AcP1T0ZOfNMpQnyh9uL4FJMkKVu6dDwp/iMey8OpZHJjpfsdXWmJ33IdULSyVIBEu6V0CCDUd3j+f19iJVQl3P0JKdjZ/0HrbGD1hwfv3jro+EQElbrlvS5YEusAGq7yyp36k4MsOGyI6Nw21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134282; c=relaxed/simple;
	bh=kc0lYyKR7zeTc5iDkUcwaVoI+tcbcKwqoeSqLa9YYZI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L1bQqA/ZHOTYKOp/ifWIgw0TwO4red/dIfzbrL07OZ8sLTXlpo4KhJ+bEnEBBvXduW0T/ErDBj4dq1ejKklBapDdvEx64t7PIH0mk75SlbmajWq6d9MQg1UePIQQsfAmESlQ8algN3xTKncPZkLy8Gw2YzT9Lxs24KWwXPXwuLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjljpe5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE5BC4CEE7;
	Wed, 17 Sep 2025 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758134282;
	bh=kc0lYyKR7zeTc5iDkUcwaVoI+tcbcKwqoeSqLa9YYZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hjljpe5/XyhkV1qRIpqyl5dPo7hhodbH9W0o/N7iNbES81qwX6ZS/vOVPMmBZPm1Z
	 3DwOJzpYnI+n6Q/cBZRbGpjr5XNDUVqulVfJ9xsCMwIhx3R0XT0u6eRgBGbS8HXq+3
	 TaHOYxf1uX7V/9id9mRBGJNMQ33WuwJT4KmPuocl4hbyaoLvjQfk9QqPnE5ysl+ixe
	 zgNrvGHZPmtz+aiR+9Nla/iC29l9NUcDcgwzUBXHmiIvqG+OkkFjQZhR6Q3aOkB1gw
	 VRrnO6UezqYJ8yisnt+h+72ElO0gL65J53IBh2KWOtN2DDZpf5JaJ9VH/hZt+GD0T9
	 Cei/sBelHKc+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3418839D0C20;
	Wed, 17 Sep 2025 18:38:04 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes fur 6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1758085289.git.dsterba@suse.com>
References: <cover.1758085289.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1758085289.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc6-tag
X-PR-Tracked-Commit-Id: 80eb65ccf6f72dc37b972583fe71cd8a50ff7e51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6f456a76f7379fa4e30371e548f40b10a76b60f
Message-Id: <175813428282.2102736.5321254657992813438.pr-tracker-bot@kernel.org>
Date: Wed, 17 Sep 2025 18:38:02 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Sep 2025 07:20:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6f456a76f7379fa4e30371e548f40b10a76b60f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

