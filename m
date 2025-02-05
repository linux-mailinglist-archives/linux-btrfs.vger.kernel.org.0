Return-Path: <linux-btrfs+bounces-11296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB40A29600
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E49B7A1BBD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401171B3F3D;
	Wed,  5 Feb 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmRALNpM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8D1FC3;
	Wed,  5 Feb 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772157; cv=none; b=nCIFHsZi/Lh8Wz/4oMlI2/1iclIKTjJvKFxTD2sgXa8XhD/HFZ11vWkeur0UhDr/F5ilVlxRa1R1iOeb51Hyw8YhSv+65iZOQjVyKnFFmFIF6fetyzma/LXrBc6esxJkeSkLVNY1xSW7jetj57Nv46seEGu5Q85pZmqQxWiZVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772157; c=relaxed/simple;
	bh=5PDkDDjqwkZnnwDy4OTJ//VqTHJy/9sIIT2t41JVVLk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XBz5R+4QpkKp0uu+pHdlNYJYLTO/s9sBDuMRk4QjRF0kSbLu//gjznalK55xaV56EHZYDJDs9R9J9dODme59dC6ieJJdvpEcNQ6f1gAgS7so1AAosvVSCjXZd7FGYsFmtzGMDJ2uBPLaJZm7ESHNDr2hwsh3TNE33dJyJyJm4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmRALNpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ED0C4CED1;
	Wed,  5 Feb 2025 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738772156;
	bh=5PDkDDjqwkZnnwDy4OTJ//VqTHJy/9sIIT2t41JVVLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pmRALNpMC5QyscLHcVyUtZ8Hr87HA5TB1XoKqA8EnbrfjZYJF6uUbw9YSkhQJ4Ehk
	 hvfTV7D4wHjDodh2HtkSzTXLn5icpxo7suArfojGQzxRkGlacSmaP/BVBdBwAhvRju
	 gV5K2tbEREt0pdg2DJmfJj657AttLQ5efzaNjk/iZFZlDxh7LMrRa38uMUfCaFMOsI
	 KdFNuekCbn8QQ+N6JjD7vwuSWMxENOWxtNb2uLp3sVIfitlxcGTfEiDQX+mC8SLDC+
	 HELyMlfqkJsl6zZdrg4bRp++Bz27Q24wkga2zfUt/pZ82LsRrkJSrpDHV9V75ZBYfs
	 nO9GGpwf1dVRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71106380AAD0;
	Wed,  5 Feb 2025 16:16:25 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1738764049.git.dsterba@suse.com>
References: <cover.1738764049.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1738764049.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc1-tag
X-PR-Tracked-Commit-Id: fdef89ce6fada462aef9cb90a140c93c8c209f0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92514ef226f511f2ca1fb1b8752966097518edc0
Message-Id: <173877218393.819050.16702194158356012746.pr-tracker-bot@kernel.org>
Date: Wed, 05 Feb 2025 16:16:23 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  5 Feb 2025 15:15:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92514ef226f511f2ca1fb1b8752966097518edc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

