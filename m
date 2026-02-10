Return-Path: <linux-btrfs+bounces-21600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GCvC34di2nSPwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21600-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:58:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B1611A7D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE3AF3042626
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC1314B6D;
	Tue, 10 Feb 2026 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw59tb9J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2396327218
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724673; cv=none; b=FWFBr6F8Y+MRXpCYd/JicvwhBJ0D19rMW8YavPS06K/ae4wjwt7LWJBVWAXuu3nB8LK4hlbtBzXc3yRS3HSoffcm+5iPdTlL0osgF78fOb22OrEnded98ACUsbUoWRLww399tw0XOgjaD9zsNiO3EX0VptUBqPUyACc8YLrXbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724673; c=relaxed/simple;
	bh=AtKW4b8WJ3FqZelz/619dVqbIvpEu2Ourg0Iwo9mrCg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2Zy3joKjMyPLYvyNnXoNoSZk1kfqf87GFo3ZZAKbZYNqd6MQjaXemfqV560i1z5EqZTea2cEcOe2R6071fqpHZg43VodCrF1q2Ygwuy9XF7ty+qEvQYRyowRTxjozqe+JOI7SACXTObGEKyQvUVzHzj5gL+revFHTv0rpGA+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw59tb9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0792CC116C6
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770724673;
	bh=AtKW4b8WJ3FqZelz/619dVqbIvpEu2Ourg0Iwo9mrCg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jw59tb9Jf/8Fb4FnsXupSqK02mmyItKLoHN2YaPCR39cND7KKma45HFr+nVCJM7Ss
	 PpNFoQFHWIalWRs6NI0rwfvt2jP/1B/DqiZYJaPJmochTUSf0pOJhqDS7il5N4ZblI
	 vUcdrf9CaxcbLMEx3pQWjHv1lOvaU90Nn5xIt5HHROPtmaL7nuLICfh33F6O33enfZ
	 hfoGcPtPPtno696hoJoA0N55A+zJ3gLdOpcLWJhVCLvxEtutNMpS1J9h+e8UJt/sIl
	 zz8YIuIt5WxR42MUOr/t4muquAmxb4zhKO1/SqpByBAUPoCFnK2RJiYF5o8BRGrbUh
	 vbH1KCZqO86vA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: add missing NULL checks when searching for roots
Date: Tue, 10 Feb 2026 11:57:47 +0000
Message-ID: <cover.1770724034.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770580436.git.fdmanana@suse.com>
References: <cover.1770580436.git.fdmanana@suse.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21600-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85B1611A7D5
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Remove a wrong but harmless expression before loading an extent root and
add missing error handling for some root search functions, which can
return NULL when using the extent tree v2 feature. Some places have the
NULL checks already, but many others completely ignore it. Chris recently
reported this with his AI generated reviews.

V2: Fixed a return without mutex unlock in patch 2/3, updated patch 3/3
    to log the logical bytenr of a delayed ref in case we can't find
    the csum root.

Filipe Manana (3):
  btrfs: remove bogus root search condition in load_extent_tree_free()
  btrfs: check for NULL root after calls to btrfs_extent_root()
  btrfs: check for NULL root after calls to btrfs_csum_root()

 fs/btrfs/backref.c         | 28 +++++++++++
 fs/btrfs/block-group.c     | 39 ++++++++++++++-
 fs/btrfs/disk-io.c         | 17 ++++++-
 fs/btrfs/extent-tree.c     | 98 ++++++++++++++++++++++++++++++++++++--
 fs/btrfs/file-item.c       |  7 +++
 fs/btrfs/free-space-tree.c |  9 +++-
 fs/btrfs/inode.c           | 18 ++++++-
 fs/btrfs/qgroup.c          |  8 ++++
 fs/btrfs/raid56.c          | 12 ++++-
 fs/btrfs/relocation.c      | 30 +++++++++++-
 fs/btrfs/tree-log.c        | 21 ++++++++
 fs/btrfs/zoned.c           |  7 +++
 12 files changed, 278 insertions(+), 16 deletions(-)

-- 
2.47.2


