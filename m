Return-Path: <linux-btrfs+bounces-10594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B609F6FF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 23:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0759A7A16DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F21FD795;
	Wed, 18 Dec 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBQdCERp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234261FCFF4;
	Wed, 18 Dec 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560413; cv=none; b=dBasyNO6CJNW8xZiNZJ5rdxZLZY+H9TLjdVSE5hh5Y1ydqCFKG4VNjRSoQgHSUtu381AeGjwGH1N+8NQQFQrgOlG+hcLfxcoalZMQeGeUdzgKBDGzvsj0BnuJsgiCAQCT0j41s19eOdxt9DdbSQ8TszBbqr1XPVIp8dnF94Rqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560413; c=relaxed/simple;
	bh=ulkY0uZ8iqRslS18qALGww8bj1vfAFLmskEW336Eeg4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O3VPwl1nQyxoXn2AEWrRyOb9KJHM3eylTb5uDNW4Q+XRvAcioyi7K5MEq0YqwBTmCDyd7NLj6oaWmvLW1W20f7PKCPhRnJwfi1sa+9dtpnXvVrm5VnW33aC/rJd1HLlqWBz/RtIMmWXHTcngqh65diFISmin9YJpvgQVnbjVHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBQdCERp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE30C4CED7;
	Wed, 18 Dec 2024 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734560412;
	bh=ulkY0uZ8iqRslS18qALGww8bj1vfAFLmskEW336Eeg4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PBQdCERpMT6DU6CctwQtZj40IM4oSAlbW1D6EgbVF2sDk2v3G6TDEs5nYbdCdWofY
	 +usdM1AjXxZYWOGhJgB8tM/KxVHqnZvBxEEk5SvZ76ZvNNsZG9Cx4Ueqcy8C4uLYRr
	 MK/jYwKXp9zJqZVkUHJqJv0Nsuy3ixYT3aCcBwZItMkackExn3jH2VAZ2x9nbL5j41
	 khCNrQ8H7YiJ2Um+hfccUIYBQOSvLr1WzAzITQe99EAJryyj6TGWCTiKnHQjWuw4jJ
	 StYAeQgKdxkMAFLtUStql0AAQY3mZgt3Ml5qFmI6fOiy5ygMogOPrS1JS2rthhwnXp
	 BqS72SNEvKDDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BC93805DB1;
	Wed, 18 Dec 2024 22:20:31 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1734477842.git.dsterba@suse.com>
References: <cover.1734477842.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1734477842.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc3-tag
X-PR-Tracked-Commit-Id: dfb92681a19e1d5172420baa242806414b3eff6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eabcdba3ad4098460a376538df2ae36500223c1e
Message-Id: <173456043006.1744913.7784458091307440453.pr-tracker-bot@kernel.org>
Date: Wed, 18 Dec 2024 22:20:30 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Dec 2024 18:49:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eabcdba3ad4098460a376538df2ae36500223c1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

