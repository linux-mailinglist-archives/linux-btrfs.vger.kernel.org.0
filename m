Return-Path: <linux-btrfs+bounces-3626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D3588D029
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419363239E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE613D88C;
	Tue, 26 Mar 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nXDI+8q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAIvpiCQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51663FD4
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489065; cv=none; b=U66AaZFD8vj3+mYHnzLbOYW0zuDOYYMIp5jz7orB+YXmuqxFvgEPGEchRKmYbfsFcBu1WndrIje4u12ZWIVJVYVRDt7AIvk2ASiAoUglACTcB59HaW3PHVoi7eOiVANvTTBhxth+Efd1wP+W53mzrOVCj+qlDhlW4KnvK6sQysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489065; c=relaxed/simple;
	bh=7gg8KVsuRETVMBLiycXwK8U7F/hZEtWO+wSoLiMbHrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QiR20QzfNOWNFFM3FH4lzH2bj4uWZP//E/SOWFj1JIR7ynuwn7w9TTG6T7DWla7JtKQ2w1XN+ap1f8KTaRjkbekwTEKeM2c1QiwVZF9zith7XrDJemc8oL/uk8nUxrJZf97pN9z6fTAXFsU54w0ijCEOjZes36nBRzR0GanAZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nXDI+8q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAIvpiCQ; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id BACA13200392;
	Tue, 26 Mar 2024 17:37:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 17:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1711489061; x=1711575461; bh=O6zTClPpvtAuPeRiFy/Zc
	/cfmn3lbamhyTSnHvrtupY=; b=nXDI+8q2Cd4427U96+ag9URKUPJjmuSa5O9yr
	yoM8+OlF2Dj+SLw20sEtl42jDl9Cjn9yEVsAdcBc6odEHOvuj2yjsIYeqdF5KDWK
	dC6dh/xs3ERUSge2Uvgf5/vNi89CT42mUgTim67Kf0TOiwWpDMgBJl6Zt+B/zsGl
	rLzVw1ZXyM4M34hPa5c6B/sIVh0dpucwmbNuMXtf4Aia5fqcOwcZY1K2guKxWgrx
	951DJIawiIF5RJsoa01BB6YaF7Kgg4hKl0BNBwq0mC8/yGeqUjTuGTPQeHbR+Uiu
	xsiI6drJUJlzXCgaM09RLwD5rmYaeKiUqki1MlZNkpIt/nwsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711489061; x=1711575461; bh=O6zTClPpvtAuPeRiFy/Zc/cfmn3l
	bamhyTSnHvrtupY=; b=NAIvpiCQh1jYppWukQtLTkiYeQTsyyRcIflnTybHwsnv
	lzOMJ0kWZA9mAfurSDQu2m40b5GGbMY1zb1xsQMwqIGYnchJR9Pc4cIKnRd9y2PU
	l0m2VbtuHBo3aqmg95CLyXAKFm3BlDsGXJ68Eo5lvj658oWmYxnY/4oObhV0SMRn
	ZOeTExuMb5WtUnyeY52/RHvEBRaYQSu3r/254/J6TSnFnULoNWoRXBgYtndOMBDZ
	QUMmjPOckkr+reGafJ8JY63RQ8F3pgR1nFTiKhCcvupCHJ7casn1D/dcLyhA6p2f
	jj4g7vFjH/uLrwI5BXObDMft0fw/oVxBWR6kM105Fw==
X-ME-Sender: <xms:JEADZnEZm3OIxUCW93fW2Zc4_HEcb3gUkZcwQzHqVbmxwxX95o4IlA>
    <xme:JEADZkV3B0w86BtBttpv2o26iprITnypqbmUYPuJaVunU-TM3tRssWy16yeSViseZ
    -WZHHL_SCb6tIagCDE>
X-ME-Received: <xmr:JEADZpIeUtX3t0J2TLYdu_WPIiTjkraBeAqnruGuw3wyQX3oiUfPYZ0ZBMsI7iwZN_BHjmK_Jl-8yyrvMJvTfwC8oIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:JEADZlGc6ap-h33ndiYDoXj5dcjG3Hmc72geHs0TA7nDaYfgjsYnhw>
    <xmx:JEADZtUY2DyEoW88MVd8apZc33KDXwr0XxedVb8ah1mNMey83G8u6w>
    <xmx:JEADZgONlCkbEXerMX0Kd1jhYI_tK0NAIhEtpvnvFm1A7d_T6MHysA>
    <xmx:JEADZs1NUjaXrvZp00XH9S7GcIZneCsT24vxyw0KcQ4UGtVKNRF98g>
    <xmx:JUADZseAPyIxyGDv3D7-MdMVUmES4R-h1bCJ8ilpL0n5tmGFh5NE7w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:40 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/7] btrfs: various qg meta rsv leak fixes
Date: Tue, 26 Mar 2024 14:39:34 -0700
Message-ID: <cover.1711488980.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/269 and generic/475 expose a number of reservation accounting
issues in the btrfs quotas code that is shared between qgroups and
squotas. In particular, error paths for failed transactions and errors
in start_transaction and other critical functions for root per-trans
accounting.

These semi-related patches fix up a number of such issues. With them,
generic/269 with -O squota passed 1000+ times in a row for me and
generic/475 has run hundreds of iterations without ever failing on a
metadata reservation leak warning. generic/475 does still see issues
with qgroup data reservation accounting and only passes ~9/10 times
on my system.

Boris Burkov (7):
  btrfs: correctly model root qgroup rsv in convert
  btrfs: fix qgroup prealloc rsv leak in subvolume operations
  btrfs: record delayed inode root in transaction
  btrfs: convert PREALLOC to PERTRANS after record_root_in_trans
  btrfs: free pertrans at end of cleanup_transaction
  btrfs: btrfs_clear_delalloc_extent frees rsv
  btrfs: always clear meta pertrans during commit

 fs/btrfs/delayed-inode.c |  3 +++
 fs/btrfs/disk-io.c       |  3 +--
 fs/btrfs/inode.c         | 15 +++++++++++++--
 fs/btrfs/ioctl.c         | 37 ++++++++++++++++++++++++++++---------
 fs/btrfs/qgroup.c        |  2 ++
 fs/btrfs/root-tree.c     | 10 ----------
 fs/btrfs/root-tree.h     |  2 --
 fs/btrfs/transaction.c   | 19 +++++++++----------
 8 files changed, 56 insertions(+), 35 deletions(-)

-- 
2.44.0


