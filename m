Return-Path: <linux-btrfs+bounces-9737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 884029CF49F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C80B34C9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFFC1E32B0;
	Fri, 15 Nov 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQOewYp2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493E17BB32;
	Fri, 15 Nov 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697156; cv=none; b=W1X8e/+Ou1hq1BsJCZZHjZvPGPn5zk6luYKnF26PYsP9RR1vlNFP7jgIm7AGUVQTjYaga31e2ODdzVn8jp8eDQ2sZnkV8ZpFU1vlZn5VyMies74e94b1/2KFjLYvxzULB60y65b/gVqYpJjXHWw0iLkh35x3EEtoRLVXG6rymCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697156; c=relaxed/simple;
	bh=r59Ls4+rTUamoue6EZmgBDa2jy0/MC32GWcYDvnT+E4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CbblriODTzI2HQAVGcLjZ8Vtd6YGKHwrLZIBnOECHexgR301dvg8445n4vMXNZ57YTcm1yQqIkd54kQ4rXZInZak8+BLNPGf0tB4By0i09ecFZwDSpHzg354Np3J1x8c4VNFBvg0IcVhRXxP5J9kHdtAXcWNvKR0Rp5RpA42cNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQOewYp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E835BC4CECF;
	Fri, 15 Nov 2024 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731697155;
	bh=r59Ls4+rTUamoue6EZmgBDa2jy0/MC32GWcYDvnT+E4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cQOewYp265raist0ikKvnaVCgxP7Yb+/kDtUKxNI09SUmG2EJB8lmcwfg8Zj+jZtf
	 0T7dlyC7u/7xk2bRGDVtFSyRZcay0GkMhd4SPW6G7Aiy3R7ksZLTONcpCZPQNz//10
	 AuxV4o3Feziru3QN+Jp199XkiyNCmPkVv8IkHOsijK9qhDf8HbQ17jGlIkmjoukxzy
	 +lNRoU+QYt4heVBuFx2lAYzNFuBZWU8/h/w6aqxg+cCmyy7zKmbEmNuZVPkxgtncFq
	 f+GjZPM3qwDfSogfRki0A3QYs4mbTvqgZVDFLrGMsw4HMnyc5FeIqjNC0Azztcv54J
	 Eqh1XvMkXEwlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0073809A80;
	Fri, 15 Nov 2024 18:59:27 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1731619157.git.dsterba@suse.com>
References: <cover.1731619157.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1731619157.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc7-tag
X-PR-Tracked-Commit-Id: 7d493a5ecc26f861421af6e64427d5f697ddd395
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9dd4571ad38654f26c07ff2b7c7dba03301fc76
Message-Id: <173169716648.2685462.18005617827996840039.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 18:59:26 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Nov 2024 22:22:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9dd4571ad38654f26c07ff2b7c7dba03301fc76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

