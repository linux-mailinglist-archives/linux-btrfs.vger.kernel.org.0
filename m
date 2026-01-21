Return-Path: <linux-btrfs+bounces-20810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L3NOu25cGmWZQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20810-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:35:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6956119
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F18E9966A14
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889DD3E8C63;
	Wed, 21 Jan 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClTYIF+y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BE332EDE
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994037; cv=none; b=EWpBAD/Vh96nxQxj1VN/krUEVSTZ1kT1QIRtbgrCRcGDDIn+spPrGafmHi7LkFp8vRdfbba1VCbm8vxAgnCYBebjt1M1UYmANbbT0YdI9iM77dGTA65kbJwE7HygMhASG3xZputZp53Ffd8wubLdO9/OZQTe/Erl+JHpM+3z0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994037; c=relaxed/simple;
	bh=XexL4shasCbF45gqF5cZrQXotct5vHt6CGjXYKhrQLo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZF8BL84P1U1oW38a2tSFYb8zrGNrS7xJl9iofIXo7h09xw/f5i4lWOpPHQKuT4UhwzCXtMfqVmvboydt6HO2yfcGXMGs1O4F6hJswrNlEx4OWvaia+o8UA6E8uBpkjvNvJRjVgq9VnQ+JNFSpAIb2bzaSYfg3yuioQm7uh7evfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClTYIF+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B90C116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994037;
	bh=XexL4shasCbF45gqF5cZrQXotct5vHt6CGjXYKhrQLo=;
	h=From:To:Subject:Date:From;
	b=ClTYIF+yXZJiN4WUEYzHly+J1mDiTiTbNXWmcD4RQDpfxbSRAyVbPHj7YfUxFVOcm
	 zzSzXm4LbywicNGXi8JkcC51Q3zKPZlgwbwAXcDnxu8Vyv1ndukxa45ybxAaPJ3esC
	 CUDOsmOtZ5i4htXA+NRjhcTbJv+4wfCYvr9QhSJtcxEH3VcQrN8oersO8iJKZcv6EA
	 RK6hD71U1I9aQu7o7Y89sTWlFjdklowCHJtQlWG/V0YK5OgDPpDG2nyaMQPWdTBF8Q
	 MtTs57vquREDYaF9p4076BSwFsqtv6vnrvb9UN8tvbyW+5qRDL0NJDJHHjL9YW0w3/
	 0LiLxi8o/JEAA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/19] btrfs: fix a return value and remove pointless labels and gotos
Date: Wed, 21 Jan 2026 11:13:34 +0000
Message-ID: <cover.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20810-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 89F6956119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Remove pointless labels and gotos that can be replaced with a single
"return ret" or "return -SOMEERROR", making the code shorter and more
straighforward to follow and to not leave such examples for people to
copy and keep repeating it. The first patch fixes a bug in an error
path where we can end up returning success (0) instead of an error.

Filipe Manana (19):
  btrfs: qgroup: return correct error when deleting qgroup relation item
  btrfs: remove pointless out labels from ioctl.c
  btrfs: remove pointless out labels from send.c
  btrfs: remove pointless out labels from qgroup.c
  btrfs: remove pointless out labels from disk-io.c
  btrfs: remove pointless out labels from extent-tree.c
  btrfs: remove pointless out labels from free-space-cache.c
  btrfs: remove pointless out labels from inode.c
  btrfs: remove pointless out labels from uuid-tree.c
  btrfs: remove out label in load_extent_tree_free()
  btrfs: remove out_failed label in find_lock_delalloc_range()
  btrfs: remove out label in btrfs_csum_file_blocks()
  btrfs: remove out label in btrfs_mark_extent_written()
  btrfs: remove out label in lzo_decompress()
  btrfs: remove out label in scrub_find_fill_first_stripe()
  btrfs: remove out label in finish_verity()
  btrfs: remove out label in btrfs_check_rw_degradable()
  btrfs: remove out label in btrfs_init_space_info()
  btrfs: remove out label in btrfs_wait_for_commit()

 fs/btrfs/block-group.c      | 10 +++---
 fs/btrfs/disk-io.c          | 54 ++++++++++++------------------
 fs/btrfs/extent-tree.c      | 24 ++++++-------
 fs/btrfs/extent_io.c        |  5 ++-
 fs/btrfs/file-item.c        | 16 ++++-----
 fs/btrfs/file.c             | 30 ++++++++---------
 fs/btrfs/free-space-cache.c | 31 +++++++----------
 fs/btrfs/inode.c            | 21 +++++-------
 fs/btrfs/ioctl.c            | 40 +++++++++-------------
 fs/btrfs/lzo.c              | 15 ++++-----
 fs/btrfs/qgroup.c           | 22 +++++-------
 fs/btrfs/scrub.c            |  8 ++---
 fs/btrfs/send.c             | 67 ++++++++++++++++---------------------
 fs/btrfs/space-info.c       | 13 ++++---
 fs/btrfs/transaction.c      |  9 ++---
 fs/btrfs/uuid-tree.c        | 16 ++++-----
 fs/btrfs/verity.c           | 13 +++----
 fs/btrfs/volumes.c          | 12 +++----
 18 files changed, 173 insertions(+), 233 deletions(-)

-- 
2.47.2


