Return-Path: <linux-btrfs+bounces-419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C837FC453
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 20:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E70EB21548
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF82637D11;
	Tue, 28 Nov 2023 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSMoblQo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC046BA0
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 19:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56BF6C433C7;
	Tue, 28 Nov 2023 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701200175;
	bh=InSCNZvq57DpSpQsC8EpOot3F7N3rHCmHPI+zIqMzZk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KSMoblQoilT9SJnnUGhCNMADNna576RiaN/YrQzVHDV/c3KXeNfXZ5PdQxm0l4uCe
	 CVpg0ZFPoxoJHGzamLGmsTc8rdGDfgGZzEEHodsDyukv+Q/GrywAyBx+C3bw+pbns5
	 nZofil32Zbd5D5FxQH8qNz/e/oJrJwU13qp2vHE72gduZMahchk6F4qKtHqLfIVakp
	 GAyAp6YOeS/fMIjDQAGjyRemHBHYluVykSpWGgeAarfJN7ZLSxV4jJ6uQGv2hqqCjr
	 QNAjMA5KeRxBGcOHPF9ZiIOcTDrYEJ4XhP0dJQ4sbJjBlbIo7UkV9g3t8z+xST+Awq
	 STcUqiCogRPIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4454DDFAA84;
	Tue, 28 Nov 2023 19:36:15 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1701191460.git.dsterba@suse.com>
References: <cover.1701191460.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1701191460.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc3-tag
X-PR-Tracked-Commit-Id: 0ac1d13a55eb37d398b63e6ff6db4a09a2c9128c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18d46e76d7c2eedd8577fae67e3f1d4db25018b0
Message-Id: <170120017526.16687.16192930897558695122.pr-tracker-bot@kernel.org>
Date: Tue, 28 Nov 2023 19:36:15 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 Nov 2023 18:32:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18d46e76d7c2eedd8577fae67e3f1d4db25018b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

