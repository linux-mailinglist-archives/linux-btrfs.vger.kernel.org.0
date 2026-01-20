Return-Path: <linux-btrfs+bounces-20761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG8/H2VOcWkahAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20761-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:08:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 346355E828
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDC68439B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0314279E5;
	Tue, 20 Jan 2026 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCu6Js7Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB9423A74
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911958; cv=none; b=lh3XHm7d9LMAkYv6D/u5g+Y7nZrmlAFOVFy8GwpTNRWzYUrzI8xsZFshhINjB1Y49mgEn8vv/L9brH3d7gRFfb6j+wJ5oZzJYNR2txcGpyecKVMBEf+DjCinWk/qKFZd5hNJA9sTZbvtLg7WJwADy4MJ84hZxTM2OOcKL7+39tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911958; c=relaxed/simple;
	bh=TdO1lF7idxaO8fJy76oXvAIFbmEm5QuWUcx8wxtKfk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CoSyOwYJoQXocnr3jqQ9p4Ip+qWzNGmZRXxpzsjuVnLR/hrjxthxXYOalFDJ4503pBwlExqxLETossqopNu3Pdlsapx/djMzsqgD4aTRjn4Ighvcg4MT8rS5fJnMQw0HLoycH9a0kYoxJ6hvdh2qb2mMj4YUahb8F4wrlFHzaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCu6Js7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F36C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911958;
	bh=TdO1lF7idxaO8fJy76oXvAIFbmEm5QuWUcx8wxtKfk4=;
	h=From:To:Subject:Date:From;
	b=QCu6Js7QbCqlMMEqsWDDz8Yf+HNKnmwKSJiVEisOCAE0jZpugiXj9SR/23ZdBUT9g
	 HHXDE5/ubqjgvaOMvVLEhUXZmp5fqiuaYcBi8lX4VGbCP9M1wcYF6ZOCTdnbj2Ltie
	 /+z/p5ngwWqhcra7VxOKsLPCUKQyiJFwiC4Xz8Y+qmP8wGdFBe+3ZoqFeLwJle4d40
	 DfPl41RrcCv36LQ4QSHRQbeZxltfMExUEuIDFqwsZgNG4dHSlfmY4+nAfLSJAPjy15
	 y0ZosT1I/H4X/90UV9ww/h2T7iI04B28rhA1HUe6Dn7TK6qIN7VFyK4PfO0mpTeL6l
	 iFfC12CX3I5Zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some cleanups to the block group size class code
Date: Tue, 20 Jan 2026 12:25:50 +0000
Message-ID: <cover.1768911827.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[33];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20761-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 346355E828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Simple changes, details in the change logs.

Filipe Manana (4):
  btrfs: make load_block_group_size_class() return void
  btrfs: allocate path in load_block_group_size_class()
  btrfs: don't pass block group argument to load_block_group_size_class()
  btrfs: assert block group is locked in btrfs_use_block_group_size_class()

 fs/btrfs/block-group.c | 52 ++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

-- 
2.47.2


