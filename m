Return-Path: <linux-btrfs+bounces-9753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825C9D1CF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 02:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EFF283271
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 01:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B187126C08;
	Tue, 19 Nov 2024 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV6lif55"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FC7DA9F;
	Tue, 19 Nov 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978579; cv=none; b=cHEeDaO+WOR8PBZ+j6SuAnsB1yJzBG+pzeI1K252drzOES1qH8sQMT4v4dBXl3TRmKlowZZByyGZ45t37gCKdooOuvFjqxZtHdrqy1TyAkDfIdG6I64qIh0Pa8U2KSh1FDvTkxRycMDsAk9Oi18HLGkKqkXc6KGK7DDOooRFVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978579; c=relaxed/simple;
	bh=zqZp0jD/FpvYvMsJZ7s3eMHXc7ZEtetjR7KKdOxJwpg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XUvGmzT7OWq2Em9s8pQrfl2yCRwK7tpHG74MdHbm3gyVQC37ASyBYdKyLdnzfxkL8Mk7kdqCbCNhQ0etnYUoFA5YX8hSVputHFRu0QOj0Zv8ckhXb3e6EDgR5kBW7bwUKpJe4mv0A4Qvl8KNYRlIFLVhdycdlOA1wtpPwG2oVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV6lif55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCFFC4AF0C;
	Tue, 19 Nov 2024 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731978578;
	bh=zqZp0jD/FpvYvMsJZ7s3eMHXc7ZEtetjR7KKdOxJwpg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DV6lif55ZhMCq1/1qdyE3O8ummSIOreTM6uaeayaTlyJKwal2txftMDiMVgGY5sfI
	 V6EjCw/Any1Bj9cxN9mlxF42Ugc+hUtPYaqnNC7gNPeTvPzvSdgAHTL0RZbmL7zhPp
	 0/o1cVpYhCkrEV8AMxFeRoN2ESKFevI7FxBHXT05zzhi3pL1A1dh1TwffaZSuGytSS
	 5iDdOHgTNcTfGRq3572UY5YW0VBYB61xvXu3ErV2h/vNsWAT71retS761682EDrYbu
	 1CIC1gPnulaPQdtasGNKWWzeGqo+PCSaSR7XnCSShrBve1B2NHpscZXQS+A+yu+ekq
	 AvXrf0uQhJmVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC33809A80;
	Tue, 19 Nov 2024 01:09:51 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1731515050.git.dsterba@suse.com>
References: <cover.1731515050.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1731515050.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-tag
X-PR-Tracked-Commit-Id: e82c936293aafb4f33b153c684c37291b3eed377
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c14a8a4c04c5859322eb5801db662b56b2294f67
Message-Id: <173197859000.48692.7169660299964010828.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 01:09:50 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Nov 2024 19:13:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c14a8a4c04c5859322eb5801db662b56b2294f67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

