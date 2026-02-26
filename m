Return-Path: <linux-btrfs+bounces-21967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGvyKQVboGlPigQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21967-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:39:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7261A7B9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ED1F301AD20
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1F36F401;
	Thu, 26 Feb 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQQoCaS7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE727F72C
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116449; cv=none; b=csGQNRimNsFXVY7xYTnNuomJan+1toVUvbcegmCfbdUuG0lGaqroZZVN01Ghojq6wHDSxGfHQxGJmWwdCErnY+7KH5MxJ78bivQKoaawmuA00j6i7y76n9DE1P9J7IKcmJvLnbdyUchEX7oycvbbkPIglR7RPAQNX+kMaOKWTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116449; c=relaxed/simple;
	bh=k+oP9N20oCE5Z+MS73khOCaJvt4J6QJiupRNUS+v6JY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fYHknXsnGt6PUVDw6TS19XgrwX2av7cbGfS8Prz76XomoN3+4vk4qRM+p54rXPANH/Yj90ztFqc2kpO5rJdWccXz4sJLqH/rGtoJ2oUsuK01EHSI7XgZRy5d6TGADUu/i6R57g8EPxYNpyKrrBar5KqJ8My/avVIXf1fIpk4cS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQQoCaS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C87AC116C6
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116448;
	bh=k+oP9N20oCE5Z+MS73khOCaJvt4J6QJiupRNUS+v6JY=;
	h=From:To:Subject:Date:From;
	b=BQQoCaS7OoKpZSEZKjbsBayI4tJjjm7rxUmjQqYGF3OJwhPr7vOm2aZYa2Xty1rfA
	 GmO7gP2NcdiAb924k9+JZCpEzgWcEyQjIlY9LoSlmLj8AnPFXBhWXhMiXzDyM9FaQC
	 DxKVixAWBn5bBG7/x8m5hSZUI93PhZI5YpuuIAPcp0gL0HQPfg7qSWGKjtDTujZNEx
	 VFZmpPRFbXf/zit418WJUw5aT3OCYLpnexwOKdS9SPVR3MGpFqFnTFTnd7Z+92eAeA
	 C3WbDT+87sice1qlgqEXdQci4cb5+TtIpVb3HYKad239IpPqSz+/gbkhwEtcharrnx
	 cwpdbLpU8grNg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: fix exploits that allow malicious users to turn fs into RO mode
Date: Thu, 26 Feb 2026 14:33:57 +0000
Message-ID: <cover.1772105193.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21967-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B7261A7B9C
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

We have a couple scenarios that regular users can exploit to trigger a
transaction abort and turn a filesystem into RO mode, causing some
disruption. The first 2 patches fix these, the remainder are just a few
trivial and cleanups.

Filipe Manana (5):
  btrfs: fix transaction abort on file creation due to name hash collision
  btrfs: fix transaction abort when snapshotting received subvolumes
  btrfs: stop checking for -EEXIST return value from btrfs_uuid_tree_add()
  btrfs: remove duplicated uuid tree existence check in btrfs_uuid_tree_add()
  btrfs: remove pointless error check in btrfs_check_dir_item_collision()

 fs/btrfs/dir-item.c    |  4 +---
 fs/btrfs/inode.c       | 19 +++++++++++++++++++
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/transaction.c | 18 +++++++++++++++++-
 fs/btrfs/uuid-tree.c   |  5 +----
 5 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.47.2


