Return-Path: <linux-btrfs+bounces-10879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ABAA08179
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 21:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369BD7A367B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C2D1FA8FF;
	Thu,  9 Jan 2025 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1apHoL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353132F43;
	Thu,  9 Jan 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455294; cv=none; b=pVOSSyIAXxtrjDtYv1fv3dY/yxGwhJ9dgia2fUVsD9zI2PDQtUzIn+Zk0Re8gJylZQqyorRtA1vsWhK3DYxA594pjCTlPk2oWStjAXnZk6xNsvwZ6vv0V/p2zoGUh8kdVa5IY6reZQZTXAJl/Cje4sP0rbm13GlkcEPw6TthycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455294; c=relaxed/simple;
	bh=DFvubHHVAwk5K6cxq6f2tHfbfzu7B8uV5DtSNja9PuE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h7aLean6YvkyLBJ4Gin1sHAzpauxDlFv3L114JY1xrW5ts79VvN3Cpzo9jaGrnH4I11FtWmLSCY8EOoJ+FxrQEp3Fzho3RjhtAnkH+6sdixdvjNgxRUHe38k+9iChR/jwUPfVjIu3OGghWdLk/BcUpc5zxnaJ6FJUHuse61590I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1apHoL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D83C4CEDF;
	Thu,  9 Jan 2025 20:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736455293;
	bh=DFvubHHVAwk5K6cxq6f2tHfbfzu7B8uV5DtSNja9PuE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N1apHoL5PRbP4+meNGRoSBB6yR5wYFAXDSpPhux2J+yTpgQ/R5QkaOVobcnqOWwhw
	 UI43xbl+6SwI/d39zo2ajv5rHKgI5NdQ/ToTFLI+t7WAVMPhETDFKm5zCLhy9Yox4P
	 wZqqlMQT4DLk59MAQj7/qoDd/cNP7lvphzLB1SjjLi5qB5ZRuWx4LP+9yVEKQloPWX
	 Ljam3RzNP28K48nAZ5syoFTvl6/mOu2M1l4bqO3XUqcQrG3sKvA4/MO0HjXXX8yMPH
	 27CBBnWshpKWn4wrZh0MSV5gWany3StED+UaCFaxjjkUK/ZSjlVZScMOoPvsKT1SXP
	 SId2/AfwPaV0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE194380A97F;
	Thu,  9 Jan 2025 20:41:56 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1736439697.git.dsterba@suse.com>
References: <cover.1736439697.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1736439697.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc6-tag
X-PR-Tracked-Commit-Id: 0ee4736c003daded513de0ff112d4a1e9c85bbab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 643e2e259c2b25a2af0ae4c23c6e16586d9fd19c
Message-Id: <173645531525.1504273.16253758464646639286.pr-tracker-bot@kernel.org>
Date: Thu, 09 Jan 2025 20:41:55 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Jan 2025 17:42:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/643e2e259c2b25a2af0ae4c23c6e16586d9fd19c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

