Return-Path: <linux-btrfs+bounces-11402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C23A32CB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D183A8A53
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39752256C70;
	Wed, 12 Feb 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n218qPB8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE82144AC;
	Wed, 12 Feb 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379737; cv=none; b=mgB7mDRenYMiCMUTlo0571pvQooVle0BL2cgnJdpDn0bxMacCvZCohNAoXWBNDVdahY/YvR0kbABssNSK/h9SCfg1zcrS4XekBiNQkfSeV4gQlJmxjxh5XDDYO0kmEEd8C9ACmcqhn3atw3iVAvQ5OWShJ+uAOHdExg59qLRVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379737; c=relaxed/simple;
	bh=noxPsxbXbJ70/nFs4yNu3KepdehO0gac2yHnT7husjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSvER9SPZFfVPq1Otww/vgIp1nJMSLdhmtCvMYri987WttHrEZJ/bdQ8xeLUhBgqddNvNYP+DwFAcYxrvbxVqMmbN3aactP310ZZORfWRiMXaTvOCPkwXr37Mt5lteXHOpNqn8Kx2Z1Nq5sxTqV66LepS+5uhQb1kXw2DUSaZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n218qPB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C9FC4CEDF;
	Wed, 12 Feb 2025 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379735;
	bh=noxPsxbXbJ70/nFs4yNu3KepdehO0gac2yHnT7husjU=;
	h=From:To:Cc:Subject:Date:From;
	b=n218qPB8IOJClRWm/2qonCsCxkUokJx6hh2aDOJvHfl6zGQQgx5Sn8iRAeQLO7QBV
	 1Alm/zUjCN8GqAosqlhdHEh8d4R3xoMVgWfMI8GMoVLD2+WQWtlN240wTFNIwt4X4y
	 /ypxgj6sbh8/XJ4WswlZkEbS/Vt4aRNVfiSxPFoABEC0Uv1xyb+XNl5bip/HIeRmLS
	 kXf0VxaQlrmHUM5ycGOz0GkxKHkuLxmRHo5TPiZuSqw1hw8U9gJMPQ//zOGhAoGbbo
	 /QwqgJZtkHOCQzEXrFseAJfmKBsQBnROXncsDGV1+ZoKqzStggHsR6kh3Tp9YPMY0L
	 SSGaQH2bXRrmQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/8] fstests: btrfs: fix test failure when running with compression or nodatasum
Date: Wed, 12 Feb 2025 17:01:48 +0000
Message-ID: <cover.1739379182.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several tests fail when running with the compression or nodatasum mount
options. This patchset fixes that by either skipping the tests when those
mount options are present or adapting the tests to able to run.
Details in the changelogs.

Filipe Manana (8):
  btrfs: skip tests incompatible with compression when compression is enabled
  btrfs/290: skip test if we are running with nodatacow mount option
  common/btrfs: add a _require_btrfs_no_nodatasum helper
  btrfs/333: skip the test when running with nodatacow or nodatasum
  btrfs/205: avoid test failure when running with nodatasum mount option
  btrfs: skip tests exercising data corruption and repair when using nodatasum
  btrfs/281: skip test when running with nodatasum mount option
  btrfs: skip tests that exercise compression property when using nodatasum

 common/btrfs    |  7 +++++++
 tests/btrfs/048 |  3 +++
 tests/btrfs/059 |  3 +++
 tests/btrfs/140 |  4 +++-
 tests/btrfs/141 |  4 +++-
 tests/btrfs/157 |  4 +++-
 tests/btrfs/158 |  4 +++-
 tests/btrfs/205 |  2 --
 tests/btrfs/215 |  8 +++++++-
 tests/btrfs/265 |  7 ++++++-
 tests/btrfs/266 |  7 ++++++-
 tests/btrfs/267 |  7 ++++++-
 tests/btrfs/268 |  7 ++++++-
 tests/btrfs/269 |  7 ++++++-
 tests/btrfs/281 |  2 ++
 tests/btrfs/289 |  8 ++++++--
 tests/btrfs/290 | 12 ++++++++++++
 tests/btrfs/297 |  4 ++++
 tests/btrfs/333 |  5 +++++
 19 files changed, 91 insertions(+), 14 deletions(-)

-- 
2.45.2


