Return-Path: <linux-btrfs+bounces-15202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B076AF5D65
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4C47B9557
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CA2D781B;
	Wed,  2 Jul 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7tYcCwF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225322D9480
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470717; cv=none; b=LijqthSFbuiro2FCiUe3AVPEYl5AwghrAOAab7j0V5uVfP9jJg78cG8FHrv4+DY8YX7eq4yBbwY1iQUJd6UKfaOvC0kePeIINUcbOJU2THRI0j+7OmS6cQZl2o8sALy+XjFK4OUQFBGLM5YtXMdugssiliQUZTFYZACC2KicIhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470717; c=relaxed/simple;
	bh=9qfi/BB8Vkzq5L2E0C4prHHv9Yfh7eFwNcTjgjsbBwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ffdv6RwqkRKwhQ7yJraDcAIXiUM5JY5f2ndsC5aL5YAzSRviSefaQLZ7LFguZU4Ms+1MXHhCs9dHFtYP2o3CF3bVfHmCTDum8xHWtX7XzLDNv1//5AFH7ElHx/E4wgCNmOTtNGxk9REXNiKVtD4286WxTqlXmaleZ0W0yHMiEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7tYcCwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02369C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751470716;
	bh=9qfi/BB8Vkzq5L2E0C4prHHv9Yfh7eFwNcTjgjsbBwU=;
	h=From:To:Subject:Date:From;
	b=h7tYcCwFHI+LQRvIde+xOA7OV4AjEWOsZ9Vrgykx4jffZtZKznvLK5soidWgkRTeR
	 WKin+jy5stBtetwr5xPYJffHgsq7QprOsH9DUe9KtnwhfkoPsXTSttVSiNFzrv0PHG
	 c2cc7i7YapXp1C399Kd5YAZJWkvsH/WYsNTeP2Vaoa3CuqQxKjR0HSOcKZN1PJ11Vn
	 16wuX8ayaJJE/u7bmR01Th3Sx3Md6nT5EDXfS2oxSwhd1gqStzMDxDqk5yCNTmf0LU
	 kCWAz+D8FbU3kz/jzZ2QkfNSD0aM5AbONezPEFBRJZ19z7S1j4LjKHpZp5QySVeVP6
	 pRAQGDwEWse+A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: tree mod log optimizations and cleanup
Date: Wed,  2 Jul 2025 16:38:29 +0100
Message-ID: <cover.1751460099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple optimizations for the tree mod log and a cleanup (related, for
one of the users of tree mog log).

Filipe Manana (3):
  btrfs: avoid logging tree mod log elements for irrelevant extent buffers
  btrfs: reduce size of struct tree_mod_elem
  btrfs: set search_commit_root to false in iterate_inodes_from_logical()

 fs/btrfs/backref.c      | 12 +++---
 fs/btrfs/backref.h      |  3 +-
 fs/btrfs/ioctl.c        | 10 +----
 fs/btrfs/tree-mod-log.c | 81 ++++++++++++++++++++++++++++++-----------
 4 files changed, 68 insertions(+), 38 deletions(-)

-- 
2.47.2


