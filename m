Return-Path: <linux-btrfs+bounces-11455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63FA34F59
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D326F188F60B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B5266188;
	Thu, 13 Feb 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSok0Nm4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D207266180;
	Thu, 13 Feb 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478484; cv=none; b=fmIluHaw3rlhVw+8kXUu25tGG0iBRHV1JE0W9MhXW9IMl637482V4i2dWPpdScaJwLhqe8f8aXXFngU1vScxZVCsjav4+Y8ay6aigzYBzz6RW7AC5UmhQzT3nkxAWF5oCdfOe1DKj9bcqfyxPh1eR9sR34DSxQpHETONC5OWbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478484; c=relaxed/simple;
	bh=VkSdCVH98io6CNEmEYvxLbvDdssNIGv6artedm8Mfzg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d46K5kl6i7kti0mA3onzhvthPAw8YoEly1EYtjtpr8fhPHigfPDG7nOXMtX17CI/ESOCAMYwBSvfrhAAJVmmsDNgOhOzFfjtgvKqfjDkVFHCuIEy0ldykQQTDA+c+ztwF3BoqFDNTgD+I1QOWPqTRjufmsv9lXBcsYOW9i3EO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSok0Nm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BF4C4CED1;
	Thu, 13 Feb 2025 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478483;
	bh=VkSdCVH98io6CNEmEYvxLbvDdssNIGv6artedm8Mfzg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QSok0Nm4YBf+5KP0sLu67l+H8Ok26mMkz7YGjj3ZKBdTynF/SEetb7TRgrC07YIDY
	 s5Q++U7qP5P7j0BAhImUuIrgA2Upcn2O0Z9gZp85rStwYuqG7kmx4uNnLee/xIZvDj
	 ZxNj7hcHG7p3BBwwz749Gjrw+hB4zOU2Hm5ETsLUbbZ862J/K74vmjWZU7b7erDKEq
	 UMrXjpURj0FQ4emkrIDExGC1TSpDAorT0cO6664X5f0QVaYCRgS2nqK9hd2O4vaRi2
	 z/Iy35emiBOL0rGwFN3IiM/2cmgefivex9zoS3p/nu9gxsjdGSMlZ++6kQwGAVfEWa
	 ZPJ4KkOl0bp0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4D380CEF1;
	Thu, 13 Feb 2025 20:28:34 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1739475780.git.dsterba@suse.com>
References: <cover.1739475780.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1739475780.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc2-tag
X-PR-Tracked-Commit-Id: da2dccd7451de62b175fb8f0808d644959e964c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 945ce413ac14388219afe09de84ee08994f05e53
Message-Id: <173947851292.1363830.5512428614962600136.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 20:28:32 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 21:02:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/945ce413ac14388219afe09de84ee08994f05e53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

