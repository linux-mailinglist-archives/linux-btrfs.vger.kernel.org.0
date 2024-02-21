Return-Path: <linux-btrfs+bounces-2617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C450285E450
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 18:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA52284126
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 17:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267AB83CB7;
	Wed, 21 Feb 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRZHD/+c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5083CB3;
	Wed, 21 Feb 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535829; cv=none; b=RG09qfrQmfsU09kfxQ/hlw8cejPNBiZnOSP26XA/f6xNUVwRDE96e1grXhwXciruQCAdYIiipQQjKNd4BRFR/sjX1MFwZGR92nKaEhecy05hgnFms98Y0bPwQSNj8C8NkdfqKj8cG4z6TNqIaVXd0gZsnQOKlKm3vB3CE8LAY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535829; c=relaxed/simple;
	bh=r2w8OrQyL8/t+A7RQUOligqksp1GGra1bU8dNykMRGQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=otrEv0QVwas0tHofMOI3DbzQWUIRoWXQRokrDtRmDEltPOyo1hnHBguk4kFnVNNEoVvz2dgfkYgLrT3BuSKBke9+Ho07/BZPq65/aBS8hVFmhYTIrca5AZdJW79+byUCuE9urY8zFM1h9vMC8rpiEEzdaN8Xp8YtpnleLRIukpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRZHD/+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1358C43394;
	Wed, 21 Feb 2024 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708535828;
	bh=r2w8OrQyL8/t+A7RQUOligqksp1GGra1bU8dNykMRGQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XRZHD/+cZcm1P2J5ob/onnkFpblfzf544BXON5IqPwVwwxqQepTVu9XazztM0YgI7
	 +YZxxRQ2aB5RSwVDV4iCv2LZai/4eMDARXTSU5XriITY7oT7EooDFYuS1c02pOsw4W
	 EyqkvI4PIIixpyzsBpxhIvms/mMfqnlX3pkBb+e3BFAd69xCk3087eUg27aXrE7wdL
	 PYc+wMpMLPDgNqokHQu+ihkd5nUTh+K68PF+5TMRo+mAeylt8jW7/P2pSaAE3FkW4Q
	 OEjgzt6j/Ln/Fv1qRoylPKMm3/IIvYsBxJlfJJzTZ6fjbim/fy6TkMmF2Z+h/tMU+H
	 T0lEjw5Rd1Zcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0879D84BB9;
	Wed, 21 Feb 2024 17:17:08 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1708514684.git.dsterba@suse.com>
References: <cover.1708514684.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1708514684.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc5-tag
X-PR-Tracked-Commit-Id: b0ad381fa7690244802aed119b478b4bdafc31dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8da8d88455ebbb4e05423cf60cff985e92d43754
Message-Id: <170853582884.5777.17241131858273895728.pr-tracker-bot@kernel.org>
Date: Wed, 21 Feb 2024 17:17:08 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 Feb 2024 12:27:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8da8d88455ebbb4e05423cf60cff985e92d43754

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

