Return-Path: <linux-btrfs+bounces-5813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA0890E8F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08021F21C6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6711136664;
	Wed, 19 Jun 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDhy8L8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BD84D13
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795208; cv=none; b=c3yuJcOB2U8O4jkzEaTSrHVjLMCFgRSbD3itwZvm1PcM4UnjkQ0ClJa783PRcQlzpPF6TLU16XqyeK4Dk10zfrUBKoy8nUlK+jff1oM+zZeOoT//PzwXWIWq3Xkx3m9ijr0mXgxNqgRpiLq+iWrz5CJaa2asQemMRv8dbtNc4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795208; c=relaxed/simple;
	bh=PSM/K3EyWle2LvtfhcxWbzV8fUZVbotxCv4oV1TI7IU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=AcG8EKqen2j1EgSuum74f5mAMszqxMOu10XYfUcHY7sosalBW0RolR6m47usomDGebm8FD5fC9x94Q+AFI7G8/6VlGzljHTMJu6HEwph8eDFJ6SPIiCxJB/XD2W2rwA1aKTZcLLgul3hEFit9IFNjTB3S0I/wwyp3oXO5vCwwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDhy8L8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21704C2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795207;
	bh=PSM/K3EyWle2LvtfhcxWbzV8fUZVbotxCv4oV1TI7IU=;
	h=From:To:Subject:Date:From;
	b=iDhy8L8N4v7KBEw1/A1folTZ9UNqD4Ix5PN2pWrDSaBuUKCe3Bdza79irnfB9ojkO
	 70xyssVwnfBtVTY240PEy81usl81M/JBHnrnRHGeMcjsBVT+ffGNCWFGEFZiD0TW/y
	 5xtG7g/py78E01e3MBfgLI10EhV0aQX+wxOoGthMAZVn2UB4O6IGyvK+iJN8Z7ZU7Q
	 bhcXn1kx0E/1KIF0JpD9wVFY+o7nAaneQ1e67+WdTCGHO1wMWqFXfiSAM3lu389QRC
	 jVLzcCexdMD6vmP3lDC5JkFKRVTtVLEc97Rpex+h1bUf/vkhTKnPHo9VdvEWIbGfFg
	 nKXOfxmZKttGA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some cleanups for btrfs_lookup_extent_info()
Date: Wed, 19 Jun 2024 12:06:41 +0100
Message-Id: <cover.1718794792.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Details in the change logs. Trivial changes.

Filipe Manana (3):
  btrfs: remove superfluous metadata check at btrfs_lookup_extent_info()
  btrfs: reduce nesting for extent processing at btrfs_lookup_extent_info()
  btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()

 fs/btrfs/extent-tree.c | 48 ++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

-- 
2.43.0


