Return-Path: <linux-btrfs+bounces-8564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D84990A5F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 19:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7826C1C21D8E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D11D9A72;
	Fri,  4 Oct 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui8tQFDi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064811DAC97;
	Fri,  4 Oct 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064206; cv=none; b=peatVAxGQSkumiOtmLXbxQBFKC81dx9ElLJnV/O66OU26Pg98h4YLwgq5ETjLQNN1dX4cdmWigU2SVLOUAAaEDGg3K7KtttiTCVs8jwYs6jYX9wCGGPoQupPQ/fB+tVF1akwjZHxWQtb+cDHu7nyeHeCznoh6C6W7IKHkG8r5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064206; c=relaxed/simple;
	bh=cka65DpTVizJWAIs/eUD9qxmqVH11TqP+e2XkJBIE/E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jnx9+thyqdTC2qQObRJ43jXvbQ4D5qczpIcJB6IzhU6/JkRA3aJzTjcU2retwaeQsJUk+aYbD9vYijGwCKcCH+bdgKNqJPM0hYaHFEDanTbQy8euE6/0TMxtzrq7XSfen3R8IvQvRuBFaX586StY3lUymc51LvuNj6eSnX6jT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui8tQFDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B37C4CEC6;
	Fri,  4 Oct 2024 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064205;
	bh=cka65DpTVizJWAIs/eUD9qxmqVH11TqP+e2XkJBIE/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ui8tQFDi1dEPJ25bCAD+OR2QjmV+XQAheYLuJY3/bKr/3NpKiVLQKQNzfG0Y6dzYz
	 x0XvUItcW5tv/FFvqyDIDGRA/lHrltBTIAqhX3saH5nSE16bY+aVpAsXqLGdn7n6+/
	 xo9w5PgOpvIDGuoIY3bwK6qWY4l+rsFPt5j79Sy13BmF8KTZGtw7U3WINg0ueJxiQi
	 ceKh9+W1aOH9ccbHptEpYiu90JpDcwdHc9VlZUc059UKF6vGQpm1tkPUuMt9Wfjtif
	 F0z1Qt6HprKtcTySUWjH9JdXLAm/zuOoaeh//LyGW0ma4BkgmDW2ihyt5J5NkPHeWM
	 bwwTnlAgQamqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B147939F76FF;
	Fri,  4 Oct 2024 17:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1728050979.git.dsterba@suse.com>
References: <cover.1728050979.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1728050979.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc1-tag
X-PR-Tracked-Commit-Id: d6e7ac65d4c106149d08a0ffba39fc516ae3d21b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79eb2c07afbe4d165734ea61a258dd8410ec6624
Message-Id: <172806420953.2676326.11202566046076194348.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 17:50:09 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  4 Oct 2024 16:37:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79eb2c07afbe4d165734ea61a258dd8410ec6624

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

