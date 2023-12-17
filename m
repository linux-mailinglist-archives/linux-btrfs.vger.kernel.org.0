Return-Path: <linux-btrfs+bounces-1003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3EF816154
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13EB1F219A3
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CFF47A40;
	Sun, 17 Dec 2023 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz4oP20m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5F46B8A;
	Sun, 17 Dec 2023 17:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38A7CC433D9;
	Sun, 17 Dec 2023 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834727;
	bh=EfhrzwiO51ESBHocL2wxvS7VBr3ILGj+1/afcWCiX9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gz4oP20m6Oe1OJp31jkf07nH+CtjIGRGtr2KzHJkryBNNZvtFQKRGWSJsfQN9dwQn
	 G8CcElx+9PQgh0u1w0rIKHbqNaAfYSzAdoiCuPZoAxKp5zFXhAY2QYd7rrlALqHu0e
	 q/+uc8s7tQX5MSSJgLaMwYi9livT7zXwBRFPI9Pv8yR2nn0FWAyrWdekwSfAuhmFKO
	 QI3+NYgkDtUwIJ1ofGkQpHMGsGHZYdWOCdHT6YzNv2Fs019V8hTqiHJjw4TXnlwxuY
	 418naAUMuzo2Ywrb6st5CQ36wAqnzF6HPjctV6YO+6+HFtiGZdsh8UnnhkvVPIWq3f
	 jVR3RUBh/qhgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26B23C04DD9;
	Sun, 17 Dec 2023 17:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.7-rc6, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1702832900.git.dsterba@suse.com>
References: <cover.1702832900.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1702832900.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc5-tag
X-PR-Tracked-Commit-Id: a8892fd71933126ebae3d60aec5918d4dceaae76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e389834672c723435a44818ed2cabc4dad24429
Message-Id: <170283472715.25242.12767373714578138188.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:47 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 18:17:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e389834672c723435a44818ed2cabc4dad24429

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

