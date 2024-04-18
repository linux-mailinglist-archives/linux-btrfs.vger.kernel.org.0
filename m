Return-Path: <linux-btrfs+bounces-4391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3508A90A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 03:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECCC1F2217A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F33A93B;
	Thu, 18 Apr 2024 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFXiBNFM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C996AD6;
	Thu, 18 Apr 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403809; cv=none; b=mBjDxbrSXMA7P3UvhlztLDiSxZQzr/eus2mQVWLm7bdwBZ/hW+0GEPu8htTzw9f/GDTbdNSKgG9qvJTcNWV7LeFdZH1SHn/+xhL2+U/A4K5YtyxHpqvax0g/eVed4+GTTfNl9wyKli/Y93u1h7ArmKtoTZgCf0aDQB8T+oUy05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403809; c=relaxed/simple;
	bh=q0WWKy0BaZrGb+nt1/jgwhAmuTbx7paCup7HpHRg+lg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eZS+sbhfcABNJzw80a3uBD25Bz0i+PBJfbPTtdXM2/I+fgBt0YfeHCMBRmpcFpdJx/c1nUyEX1hnhL+yk4mWCcTTanIPlzDjJMJ2X52xzadJpy6c2q3ul3HOlG6FXHCEOUK8TTVEQ8qHsyhVdpZG0/3gWVlpFA2HJ51IZ9Kn7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFXiBNFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 147DCC072AA;
	Thu, 18 Apr 2024 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713403809;
	bh=q0WWKy0BaZrGb+nt1/jgwhAmuTbx7paCup7HpHRg+lg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mFXiBNFMx1FVO4LgzvQtDk7710Klvkm4Ddy4sZg6WdMi0Plrd/4vObmiM50ssyXsu
	 vALR3tf95dy3F1oOniAPvnV/mZ9a+EIFHOBVrRJEiJ7hn/MwgrOdUoLic/9QoJ+Fwk
	 ozCQaEZcS8q3BzZfpo74OXIJ+zW9AzuaBgt52goHKtAxiHEdJ0kzs3Y7cYpewIs3II
	 j5P+PHD0aGqyfKzTpw1cS8R+2ZdNbPEv9ogdQdzmfsGSaXmuEJNxRAo6SDXrAY9V1j
	 1NjPymd54Sdg8FnZAEE2UDpZQwGUK6hdaOQzLTHtNnjZHNtp29yVzxYegMoWWFLMOS
	 lUf+qvK/OkC7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3460C43617;
	Thu, 18 Apr 2024 01:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1713396900.git.dsterba@suse.com>
References: <cover.1713396900.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1713396900.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc4-tag
X-PR-Tracked-Commit-Id: 1db7959aacd905e6487d0478ac01d89f86eb1e51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cd26fd90c1ad7acdcfb9f69ca99d13aa7b24561
Message-Id: <171340380898.22474.10915339865070824309.pr-tracker-bot@kernel.org>
Date: Thu, 18 Apr 2024 01:30:08 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Apr 2024 01:45:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cd26fd90c1ad7acdcfb9f69ca99d13aa7b24561

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

