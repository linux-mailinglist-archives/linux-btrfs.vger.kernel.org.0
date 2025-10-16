Return-Path: <linux-btrfs+bounces-17902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A28BE4FC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA89D19C5A1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57AB2222D8;
	Thu, 16 Oct 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/pUEqYm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5923346A9;
	Thu, 16 Oct 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638000; cv=none; b=ZPCqnQgfC4/yC4n4fiwbCzRZ3pzUC+D26O63qlvwP9T6JhnQnufP6vLNyp1sFDSJ9NLPknCzZZx2KM0EHyiYT60Ou5sRTM7dQ0ULqkmYzgHW3utEDXJ0gX/bnMg+PXa4L2WbaINDakzlG5u8lDdtXoW1RW4cw/Ztq9j4fHKNxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638000; c=relaxed/simple;
	bh=JmPSl5u9gQaVVWygQOnhGDjqywadR57JmjceiPxl5XY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oUC3Jd11+gr89CD2uScIFjQkB45jcovJsRcYkBqrg1fyDH00Z78d/YxpW5ikjZGdvYxrTsPiSELxMlEXsJH93xp736PYfwWM3aiKGuDOowfZ/F/Y2fYR+6RN5PI/58x5ByGWZDqMQ1phXPOMhTfTystvys52STx9PxYn2dg2B1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/pUEqYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE28CC4CEF1;
	Thu, 16 Oct 2025 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760637999;
	bh=JmPSl5u9gQaVVWygQOnhGDjqywadR57JmjceiPxl5XY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G/pUEqYmYwB/smIcvPEPm9MP0dFzCdfg0bdigX+4q03v/J1fBSavu6HSWXGvyag3S
	 9IdwMI9AkoTFN4/Kq1RaSBlx/Xe4gW2rawN7SUtVmF+EREPlBBRI+8zG/ZZp8QEKbd
	 to2zHdnFTeglM1jMtCqhaKSAUs7I2tV6fhjkFZcbzZZm5Je9MWqly2MbF+7XOUqpKY
	 tXQ133UCZKNi0UHgP3NJRM5QGD/qbj7dC65PpOA80TkgkHO84qVqM0xchIl7SUxkXb
	 +0iQpb6Er/z/M9A1BKKCdOqIZojwhTWO5v+bmpcpSQvfFjPDFRmck4cQsaVXL3n5e/
	 mkCykldzjUFoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3435A383C261;
	Thu, 16 Oct 2025 18:06:25 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1760633129.git.dsterba@suse.com>
References: <cover.1760633129.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1760633129.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc1-tag
X-PR-Tracked-Commit-Id: 8aec9dbf2db2e958de5bd20e23b8fbb8f2aa1fa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f388a653c8a481cbdbdedca081a1f9f3ba204a2
Message-Id: <176063798380.1846882.17081626250257496879.pr-tracker-bot@kernel.org>
Date: Thu, 16 Oct 2025 18:06:23 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Oct 2025 18:59:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f388a653c8a481cbdbdedca081a1f9f3ba204a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

