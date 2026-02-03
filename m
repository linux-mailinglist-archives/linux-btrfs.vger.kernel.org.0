Return-Path: <linux-btrfs+bounces-21329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ovbnKc5AgmmORQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21329-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 19:39:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0657DDB4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 19:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E791306620D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395F366833;
	Tue,  3 Feb 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH8wwJHh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0E31B812;
	Tue,  3 Feb 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143346; cv=none; b=ir7BGXd5ZU50Wab0JgyX1BOAyvQVKAuax81QRuz1Uqsnd3FtoNKboaP4E68nAuCGyUvfimZIXtM+CJdUK/TlBx1HCw3iGMRMlvWSNE1JCpZne9yxbm04OVP9wfSEs4hoigjUQNDQmhHCBlAWh/kw4Wn5t9sseprDtY09g0AO1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143346; c=relaxed/simple;
	bh=tIb2MVQfTYmZIBJEheYn0kvBf/ADzmATawvemxdVY/0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rHX/vA/L8bsrKQuaXTsozo1fxr0S3Pp509Mv8Qu4zlGIKCZxww5WxQp7EBgslCYviCbCgmMcxUMmyWi6YoIfu4X5TT8qkBbc/p87ON+3txsdfRynZgU23dqR6QP3V91k0FaaB/tCGwtW3tULFWR9CJ8qh85na7+cb/ORWCdB+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH8wwJHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C5CC116D0;
	Tue,  3 Feb 2026 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770143345;
	bh=tIb2MVQfTYmZIBJEheYn0kvBf/ADzmATawvemxdVY/0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UH8wwJHhKK8agxQuoD7SeAp0zRpmnA2yLFkUbjBWPonn2SRjIN4al7A0dLtdX65Dq
	 lReV5GogckJCKHIOnE58Ifohzs+8fGShZEI5CBFDN0ornjWvsH+SdYQTizrlWy1GiW
	 QFHaRC1P7wOWTRnqdI7eOML6c/3DE7vy9NdLrtCQu6UQWkdbOQXnQ9iIysuakvtp0w
	 N6B3Asfe/9J4KoFGS9Wb711pxvjv4YTT1rGHwR8ZNCGIvqpXIeDrVV99fI+vWGdIkG
	 Zmweloliu+P9LpsPxKQd8uwb7gERDrnrP2UjvwYQjl7+De9aTXptahbksngPnkOIQ5
	 JvQo1v486500w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9111C3808200;
	Tue,  3 Feb 2026 18:29:03 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.19-rc8+
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1770137071.git.dsterba@suse.com>
References: <cover.1770137071.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1770137071.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc8-tag
X-PR-Tracked-Commit-Id: 29fb415a6a72c9207d118dd0a7a37184a14a3680
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de0674d9bc69699c497477d45172493393ae9007
Message-Id: <177014334226.1592914.15479525661354168599.pr-tracker-bot@kernel.org>
Date: Tue, 03 Feb 2026 18:29:02 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21329-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0657DDB4A
X-Rspamd-Action: no action

The pull request you sent on Tue,  3 Feb 2026 18:45:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de0674d9bc69699c497477d45172493393ae9007

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

