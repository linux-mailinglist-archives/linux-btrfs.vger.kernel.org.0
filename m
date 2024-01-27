Return-Path: <linux-btrfs+bounces-1850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF1B83EF64
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 19:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28AA1F22A79
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A402D634;
	Sat, 27 Jan 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhLcDbWE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3352E62C;
	Sat, 27 Jan 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379350; cv=none; b=UNJmOD7tvnELXFLPAUff1UmEzCI3ftXJLgGQR3oE9fUMJGmimHpZo7Znt6phV0wexf9D2gYT33V1QW4JgmFsY52/37+fdVddTAmMaZVz52B2fRyy5iPWVg+28DrBtnG1otY/rOHvSWjBPTwkvVFMJb9DPIVicUeV4fdOcfa+NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379350; c=relaxed/simple;
	bh=LrU/7SWvwrJVPlG5BOtqJ2kEhJ5lTIQrMwyoQlSYZ4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4kRJo1fvLWfTPfFpZ2ZjSbsHIAEmdDyhHbvE9saIu0RTd4Ttm7YJypqA5wpoWr/VHSM2U7p66iE+xBvHjsizwlF1M9dfN0JWGe+I9guq55avnZs8hCe5wSNJ2xSSP6zi631SPE5BT9I5nPwiebYesy/w2JRZyAPdhEfkbxlW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhLcDbWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05777C433F1;
	Sat, 27 Jan 2024 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706379349;
	bh=LrU/7SWvwrJVPlG5BOtqJ2kEhJ5lTIQrMwyoQlSYZ4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhLcDbWEOY6egcnBMwbRdFmKc7L6/o2vstZhB7pL10Jhn1rjLJmGfpFEH4OqauWdi
	 TjRudwi77U3voqI4IOEvKed7sSjcKBUkRECElxEkuq8IWhdwLWRoT01cL0dVO1Gmwf
	 8wT9yMvYLrMvnhqvXOKLqudXStBhDyyR/Y22iQKzeMke8usAsQwZhXjm1w1GMiXUkN
	 zY1dThNcaudM0Dx8f1bSOCgYVEsRbYFB5CtIyFzRs0CzwwaQJjO8iQbSKyUHstATSa
	 4EfrQzGnuumskY6soF+m24AM7tq5Z5MMmqzjAOV1OQmiQUZb4kxS5d8BSSRPBPdeYJ
	 68It/MKEtp4uA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 0/4 for stable 6.1] btrfs: some directory fixes for stable 6.1
Date: Sat, 27 Jan 2024 18:15:38 +0000
Message-Id: <cover.1706379057.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706377319.git.fdmanana@suse.com>
References: <cover.1706377319.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Here follows the backport of some directory related fixes for the stable
6.1 tree. I tested these on top of 6.1.75.

These were recently requested by a user for 5.15 stable:

   https://lore.kernel.org/linux-btrfs/20240124225522.GA2614102@lxhi-087/

This request is to backport the same patches to 6.1, while the request
for 5.15 stabe is at:

   https://lore.kernel.org/linux-btrfs/cover.1706183427.git.fdmanana@suse.com/

V2: Added missing stashes changes to fix compilation for patch 1/4.

Filipe Manana (4):
  btrfs: fix infinite directory reads
  btrfs: set last dir index to the current last index when opening dir
  btrfs: refresh dir last index during a rewinddir(3) call
  btrfs: fix race between reading a directory and adding entries to it

 fs/btrfs/ctree.h         |   1 +
 fs/btrfs/delayed-inode.c |   5 +-
 fs/btrfs/delayed-inode.h |   1 +
 fs/btrfs/inode.c         | 150 +++++++++++++++++++++++++--------------
 4 files changed, 102 insertions(+), 55 deletions(-)

-- 
2.40.1


