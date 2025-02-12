Return-Path: <linux-btrfs+bounces-11427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2DBA33371
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6653C7A2B11
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338B2080F1;
	Wed, 12 Feb 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRqWOvca"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB79209F47;
	Wed, 12 Feb 2025 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403314; cv=none; b=c59waAWlSmu5Uvks1365s1NmoyJjlQa91/SL0lTTO4XGyx0igfeGEF0Tph7qUNBS9g3t31XQdoTTttvaJRGOz4SXj6MctB5F5jBipaXEmI4DTMoTP35HdNJneNmWMH+5wK2FpoxjFjuZH0MLIWAxB94xuI6oDZ6lyR67gggyhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403314; c=relaxed/simple;
	bh=CsPrwnjPgRPuDovhj1tOvm4zfHmUdNDZyqqNP6I3xdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQNis5FI4CrcJuAmYJeamM2jRLREsGKkm+D/uqCYDoJ3A3DAw0RHaztEtFF2FXRvwal8dnwaGupWEzOI0HIVFlv1jAWfz+M/4Fni3veaQ5ESMM8xCWTTYmy/wmBl7U69bZBBT9m/W44EdDfYpVuAEu8ySLpsoE6X9LmnNq4KLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRqWOvca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61D8C4CEDF;
	Wed, 12 Feb 2025 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403313;
	bh=CsPrwnjPgRPuDovhj1tOvm4zfHmUdNDZyqqNP6I3xdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRqWOvca2t4DSkgGi25ZdOdBk65IXGvZOTncaW+94TJmaB87iZd+jcTZDL7dVrRgC
	 w2tPVSK7ATlzweq/ClHyfyW2hIAj+dHeP6n1i7Vma9gsnUf0JNXMeLFWOK7a9biIrF
	 5inirJHCfHWs3b/VaIS8bVsXLUTS14lsm4O4pYUh9eNCG7jUuF0B/kZZkERIRabE/E
	 7BOZjmC5kWoXvjFHQO4DKiPE6rm3BcM+Sp0AH8zTwtzbs7szrrK3sE5vhd5RYlxGfe
	 UaUUtAe11G8UnfypNaa2VcNfJ7aOwNHLjelLrI4fMrLQFmp0AOdQJpLUQIya1zEWCG
	 cfwsgXbtSErHw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 0/8] fstests: btrfs: fix test failures when running with compression or nodatasum
Date: Wed, 12 Feb 2025 23:34:58 +0000
Message-ID: <cover.1739403114.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739379182.git.fdmanana@suse.com>
References: <cover.1739379182.git.fdmanana@suse.com>
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

V2: Updated patch 5/8, the chattr must stay as we really want to create
    an inline compressed extent, otherwise it wouldn't be exercising
    cloning of an inline extent. So skip the test instead of nodatasum
    is present and add a comment about it.

    Added some collect review tags.

Filipe Manana (8):
  btrfs: skip tests incompatible with compression when compression is enabled
  btrfs/290: skip test if we are running with nodatacow mount option
  common/btrfs: add a _require_btrfs_no_nodatasum helper
  btrfs/333: skip the test when running with nodatacow or nodatasum
  btrfs/205: skip test when running with nodatasum mount option
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
 tests/btrfs/205 |  5 +++++
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
 19 files changed, 96 insertions(+), 12 deletions(-)

-- 
2.45.2


