Return-Path: <linux-btrfs+bounces-21312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB4dDGHzgWkMNAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21312-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:08:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8651D9AC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E86493134928
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92B34EEF5;
	Tue,  3 Feb 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUP0qg3U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222534C83D
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123756; cv=none; b=F2UHMds2JImArFyBKabAT8HkGWs1ZStN+mAdB+Ik7vx0lXygYRhw26tpgdTuOVW77T/bdFf1kComlXq2rQ8Zd/us6KTAbXoPFwQcY8vypBsf0zJyPgcmfhso7npCtnADP5t7FlfzEsAl8kYEetxyUw0TTfTtvLCUZoR58DHdJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123756; c=relaxed/simple;
	bh=H0zkurIksZz2m4/JIc/Dij4WF2zuHgMZrjfGKpJpuns=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ken52oksXEm4dC4Hl8SWvZtY28+wn9NzJmF5DW8SvGN9FgyZUQ6iMHXrXrZpHE5BEJkYO4DoDb4xcxwrAqtXuZvTPj6ZcUKftm82jTGzu0QsBHIbXI6LvrF/gjmLD5YWy0kPI7mRco8Pat7ug/keq11hs7ErCnKuwjwT6BcBsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUP0qg3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5961DC116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123755;
	bh=H0zkurIksZz2m4/JIc/Dij4WF2zuHgMZrjfGKpJpuns=;
	h=From:To:Subject:Date:From;
	b=aUP0qg3UwqCNlCHwVf89hMnSyvq/myVP8fJ+y5gnFPzx2wU5Fyb90LxhrdKkab23U
	 5BaPuRPAM4tYRLANjQLMLVhPAmeNYJRZV9C/pRUd/PZ4zjHY7AAaTfndTq+1MDJIA9
	 UOoaHMs0lVEXQvlwRVqzWhqCoW63fAfcZy9OzQGi5M3akOZuxIbwCWZYMuylL2sMxT
	 oRIiPTDcJ4kj10Mbdo3wxv6kbfJzLfWZCReJRSeQwHf28U/AKS9Af0TlI0JoT9s5Pl
	 f4PTJKZ+6PzBSHUWtzKYcVZRKKD7pec/TZfRZoKaLx39f/2w/dPRVyXDZwnRiGub79
	 t/Qt1Y5Fspm/Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: a few space reservation fixes and comment update
Date: Tue,  3 Feb 2026 13:02:30 +0000
Message-ID: <cover.1770123544.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21312-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: B8651D9AC9
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

A couple fixes for metadata space reservation and update a comment.
Details in the changelogs.

Filipe Manana (3):
  btrfs: be less agressive with metadata overcommit when we can do full flushing
  btrfs: don't allow log trees to consume global reserve or overcommit metadata
  btrfs: update comment for BTRFS_RESERVE_NO_FLUSH

 fs/btrfs/block-rsv.c  | 25 +++++++++++++++++++++++++
 fs/btrfs/space-info.c |  7 ++++---
 fs/btrfs/space-info.h | 19 ++++++++++++++++++-
 3 files changed, 47 insertions(+), 4 deletions(-)

-- 
2.47.2


