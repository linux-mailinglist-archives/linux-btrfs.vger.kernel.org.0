Return-Path: <linux-btrfs+bounces-11596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6ECA3C73A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A771518933B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 18:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8D2147EF;
	Wed, 19 Feb 2025 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjOCabQm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF38468;
	Wed, 19 Feb 2025 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989171; cv=none; b=OqLR/+3Amm9agAnyM5GuCiOZqBgfggFYyHAizxNJ7iuehwNSLKeOmjE37VSiCXRbGcRsDwcWPjLUpENpwMamln9QFQ/S7AqRh8jn+w0xO5chpX6L3Osl/0Rd8QmDnAgxVfVqF+JxLpkCvI3A5ORyCVak2HlFhaqEgz0vH48DzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989171; c=relaxed/simple;
	bh=QzR6bpe9oCvOv3JxcFn6FpZvLAdG/hH5DoE1mHy1P5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLDdgvRIGkgCol1lty8XAJgd/VGGp3oyOqwWm/CKyI4uK/uek9IAlHN5eXogvVQ0ztEY1yXHK0se+dba3xHG7msXryp1JvKckNN18XoI/vr7djXYtzATatmQCotbZ7d72z5dvBUIzxwWMFP2bf+d4vTlqZW0bAVzg/Dxr+g53Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjOCabQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872DBC4CED1;
	Wed, 19 Feb 2025 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989170;
	bh=QzR6bpe9oCvOv3JxcFn6FpZvLAdG/hH5DoE1mHy1P5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=kjOCabQmUd7Dk2O4Q03cxsqlfjqc2mwDMurkc8wJafes31DM+UnG06CBfKIorVeJH
	 kT+XWUbRMP8e8x+toUo7SjLP2/bhKYUdsK6iFUpXE+TmG4PYsDq1Q6CESp2Kg1yIFO
	 MsnoV3KRTD+fZg83b5H+RCrOpaDVpiAH1JmKgDYK9eFAy8I7LnCc7Q9xrpGV7TLRGa
	 n+dsmvGo7pgrzCVOiArn9UZowy7+DQ2TbQ2jXgAlEk1Bd7EaU8xopSmt57BaxiXB2e
	 v0CaRAVkz7xBHPawozDPGFsp9HHFmqJ4mrDATP56sqlsbhWoiUl53KeRlbovHkFP0U
	 PTqF4K1hecTFQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] fstests: a couple fixes for btrfs/254
Date: Wed, 19 Feb 2025 18:19:13 +0000
Message-ID: <cover.1739989076.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fixes for btrfs/254, details in the change logs.

Filipe Manana (2):
  btrfs/254: don't leave mount on test fs in case of failure/interruption
  btrfs/254: fix test failure in case scratch devices are larger than 50G

 tests/btrfs/254 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.45.2


