Return-Path: <linux-btrfs+bounces-14034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDCAB8541
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BDA8C5310
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B9298984;
	Thu, 15 May 2025 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgl8zTFi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DB2980AD;
	Thu, 15 May 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309819; cv=none; b=pgQfzpES5c0cx4fgSN5wUbyHVVzDiMx9lo5sWhtlKTxIyoeoq3/Hg2xKsEH1ot8GTMl198sateq2Wey6dRa4E9LsyfIAK2DlYdMLiWk+4h1vBi4AWXUoAJGQM6XCWr4rDSsnKa3lmrgLa7LtlZpOewHIFs8xzLDbOb2rpy5CZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309819; c=relaxed/simple;
	bh=Ogx4/bXvDLk2lj31tke9+ziPahiQoqxp1/egONG3x2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/7jp0VSQTtKAnZM1EwaQfv51TKfIOwAO4SoXHZF+XFOvE7NzSOb4Sf9y2R0ck0kTmtnAP1t9mhuaRuJtp+TXrn8tzk9LlbQjzblcB1Kx2GxRwTpSLPpslA+PsEcCnkXfuSUdvaFoxDE15UKtfo8RmLUAqaCEGQKpeawQsNMfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgl8zTFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A72C4CEE7;
	Thu, 15 May 2025 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309819;
	bh=Ogx4/bXvDLk2lj31tke9+ziPahiQoqxp1/egONG3x2U=;
	h=From:To:Cc:Subject:Date:From;
	b=Zgl8zTFiSlHrAsmWLo2fxNZQV6IfmD4xTSPtI7p6isqOHXxoiQ+X9R19OCktvcLOu
	 7NEy9p9WfRRRePhe2UJ85yP1cLqShCkbXscjEL19we5zpIVqhHBN1kAdR1ot1muQop
	 AxRVUzVHZCK+kEDfxEr1d3R8QMlj5vlB+rmIqSxgOni20mpQiXYW/PY6nfjaF4+w0w
	 SxSVQkkGSJ53T3zyex5toIpiESB+Tu++U02D8vdDdPbNfSxB5SW5RAZVSnGz9P+WcC
	 2iysYayCF0Aq/ZdWLEY4lRxFWXJxEMtwibNZmdHSBRVEOgGDyunNI4V6QmZYeyEDjq
	 1F0d7ag6/AlOA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] fstests: btrfs: add some missing groups to tests
Date: Thu, 15 May 2025 12:50:06 +0100
Message-ID: <cover.1747309685.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some tests are missing some groups. Details in the change logs.

Filipe Manana (2):
  btrfs: add tests that exercise raid profiles to the raid group
  btrfs/023: add to the quick group

 tests/btrfs/003 | 2 +-
 tests/btrfs/011 | 2 +-
 tests/btrfs/020 | 2 +-
 tests/btrfs/023 | 2 +-
 tests/btrfs/027 | 2 +-
 tests/btrfs/060 | 2 +-
 tests/btrfs/061 | 2 +-
 tests/btrfs/062 | 2 +-
 tests/btrfs/063 | 2 +-
 tests/btrfs/064 | 2 +-
 tests/btrfs/065 | 2 +-
 tests/btrfs/066 | 2 +-
 tests/btrfs/067 | 2 +-
 tests/btrfs/068 | 2 +-
 tests/btrfs/069 | 2 +-
 tests/btrfs/070 | 2 +-
 tests/btrfs/071 | 2 +-
 tests/btrfs/072 | 2 +-
 tests/btrfs/073 | 2 +-
 tests/btrfs/074 | 2 +-
 tests/btrfs/100 | 2 +-
 tests/btrfs/101 | 2 +-
 tests/btrfs/124 | 2 +-
 tests/btrfs/125 | 2 +-
 tests/btrfs/140 | 2 +-
 tests/btrfs/141 | 2 +-
 tests/btrfs/142 | 2 +-
 tests/btrfs/143 | 2 +-
 tests/btrfs/146 | 2 +-
 tests/btrfs/148 | 2 +-
 tests/btrfs/150 | 2 +-
 tests/btrfs/151 | 2 +-
 tests/btrfs/160 | 2 +-
 tests/btrfs/175 | 2 +-
 tests/btrfs/184 | 2 +-
 tests/btrfs/195 | 2 +-
 tests/btrfs/197 | 2 +-
 tests/btrfs/198 | 2 +-
 tests/btrfs/223 | 2 +-
 tests/btrfs/242 | 2 +-
 tests/btrfs/249 | 2 +-
 tests/btrfs/254 | 2 +-
 tests/btrfs/265 | 2 +-
 tests/btrfs/266 | 2 +-
 tests/btrfs/267 | 2 +-
 tests/btrfs/268 | 2 +-
 tests/btrfs/269 | 2 +-
 tests/btrfs/270 | 2 +-
 tests/btrfs/286 | 2 +-
 tests/btrfs/296 | 2 +-
 tests/btrfs/335 | 2 +-
 51 files changed, 51 insertions(+), 51 deletions(-)

-- 
2.47.2


