Return-Path: <linux-btrfs+bounces-21500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLd9JXLriGkiywQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21500-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:00:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE40010A0FA
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3CD300C913
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2632E14D;
	Sun,  8 Feb 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwN8PiKA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8432D7C7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580842; cv=none; b=L/T93Qlv+9FLf8rMn1Demb5eF1rct9DvxgXnXzvIMvAmOIsRFv62QqnoIoiOo2Jqb1d25HPbHiX8j/rnVLNCV/U3P7RaaQnSjenpOnUqsHhCPCQ6tWWPaAF42hvK0askzMkQhcAljBcls5RtpzwuX7CgvprTsyxZiRHfz6wIfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580842; c=relaxed/simple;
	bh=2Ix7vMmdhdyS36FbLFB404G3sQFrGouDNPRJM4YlDl8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hA0Y+xqdQMa7qXnL6seM9y0Z+SDA7OA28LsipoWMJJZ0yVyZkRDDUwdg4VxosuMJXFcrAhu13kmElfWh3EpfkAEwlDVxbpuwY37ujmKu9xOxsf0m03tg6fFEfb4AB3a95PQ5f/Y55sp5nlky5ITAjOk+PhmUnvijD8SEuXksFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwN8PiKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26AC4CEF7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770580842;
	bh=2Ix7vMmdhdyS36FbLFB404G3sQFrGouDNPRJM4YlDl8=;
	h=From:To:Subject:Date:From;
	b=KwN8PiKAr3/A7RBjLtd22YJmpsW3uyuNQ3Jeuxa3QQuuq+/Nye3cE7mZk5/35q9Ry
	 3C1ZzhdCJ+PYjj/TXZlPnBcDxKLMQS0eNlN8RkFyY9lTUW6vrTehhAJ2sOormbxEPF
	 hqL+Mn3PCvZJddLkvFsBfzAls6A167IK4CclehxzY80WTSFR1272AodN1fdH8FEtyr
	 grTfWKbalgUNpJZtX49BPQuaLiWV4k/mgcbiUDybvw+f1llFw56UB/CUUx7A4eMi2M
	 3N3Ybx9amWoc9BmzzEk3x5cl6DgaLhDaDOV7/CzbuaK2hxVRsb11hzmpG27sqPwuPD
	 zr9izURFCeoSQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: add missing NULL checks when searching for roots
Date: Sun,  8 Feb 2026 20:00:36 +0000
Message-ID: <cover.1770580436.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-21500-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE40010A0FA
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Remove a wrong but harmless expression before loading an extent root and
add missing error handling for some root search functions, which can
return NULL when using the extent tree v2 feature. Some places have the
NULL checks already, but many others completely ignore it. Chris recently
reported this with his AI generated reviews.

Filipe Manana (3):
  btrfs: remove bogus root search condition in load_extent_tree_free()
  btrfs: check for NULL root after calls to btrfs_extent_root()
  btrfs: check for NULL root after calls to btrfs_csum_root()

 fs/btrfs/backref.c         | 28 +++++++++++
 fs/btrfs/block-group.c     | 39 ++++++++++++++-
 fs/btrfs/disk-io.c         | 17 ++++++-
 fs/btrfs/extent-tree.c     | 97 ++++++++++++++++++++++++++++++++++++--
 fs/btrfs/file-item.c       |  7 +++
 fs/btrfs/free-space-tree.c |  7 +++
 fs/btrfs/inode.c           | 18 ++++++-
 fs/btrfs/qgroup.c          |  8 ++++
 fs/btrfs/raid56.c          | 12 ++++-
 fs/btrfs/relocation.c      | 30 +++++++++++-
 fs/btrfs/tree-log.c        | 21 +++++++++
 fs/btrfs/zoned.c           |  7 +++
 12 files changed, 276 insertions(+), 15 deletions(-)

-- 
2.47.2


