Return-Path: <linux-btrfs+bounces-9302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEFF9B96D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 18:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952AF1F22C4B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8B1D4151;
	Fri,  1 Nov 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ6ipWTl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8671D1E97;
	Fri,  1 Nov 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483300; cv=none; b=AdEeSUm/HmbLsWB4Kfgs81AjYItXtMx7yYdIaUKgfhtgfHmtEXPh25TBhS14ka1QT6WhrKK+5hI/hH61jYUjV2B880Hkjl6RadwKWz2hzKyU9IBM2KAsDfdFeOAGB2qtt7s5ty+5LX3vydWqd14Ce2Fnorz4WFuLb2rYPbjaIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483300; c=relaxed/simple;
	bh=WniOhPJ/Sf9cY3REbzJg9niY52tLTRjUNROz16takEg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G7cs+1/LmLsfojHKXAGU6MuWwaj5pf9azeHGYFLLZXKLc51gqU7P7s3/gVxo4xAMurwMSORSqvH+zKpGc9sy+p1AaDLhSGz5yjd4XooeWKAYb353Ac6CpGcBX5WqR10d588qtSFC/4q4qOnaLTyN+lY/CjGYhdYyfU/TX8yvP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ6ipWTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2B9C4CECD;
	Fri,  1 Nov 2024 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730483300;
	bh=WniOhPJ/Sf9cY3REbzJg9niY52tLTRjUNROz16takEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YQ6ipWTlxaJZbRoQd8xvHJX0xiW/ek6VfPwZqnJA7BW50bva7O4afCJZa6P/Lz6JZ
	 BE1rZhULHQ0FV+s96zODgJhVKVZfBwfDL5NuGzNTs7DWKnVPrH3B/LnTmAvAT2wQbp
	 Gw9Eg//sAlf2/Mrv88Jqtb6kRiF5XpmgxN9BVycROo56ECE+ovp2z5C3h3WrSuWDBo
	 expJi2i61FbTZmlZ7Rd0DDqEVnTK7na8HbCO96mM7eHW2wminNdatWsSoXqa+6n6ic
	 46Mi0XVLuVnXTM+akJ/fhnngR4AW2VZvSEamHkGAB7/qxVgChx8aXYv5zlx9tR38nq
	 0noJvEo+iY9Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6723AB8975;
	Fri,  1 Nov 2024 17:48:29 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1730474495.git.dsterba@suse.com>
References: <cover.1730474495.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1730474495.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc5-tag
X-PR-Tracked-Commit-Id: 77b0d113eec49a7390ff1a08ca1923e89f5f86c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b4926494ed872803bb0b3c59440ac25c35c9869
Message-Id: <173048330852.2762608.15110048937922260835.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 17:48:28 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Nov 2024 16:33:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b4926494ed872803bb0b3c59440ac25c35c9869

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

