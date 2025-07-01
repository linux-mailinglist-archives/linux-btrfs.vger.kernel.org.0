Return-Path: <linux-btrfs+bounces-15168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E0AEFE90
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1F13BE1A5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F327A903;
	Tue,  1 Jul 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD4yg7fA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3727A108
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384547; cv=none; b=TYwu+dJx6U/k2fPydgVYZyL09hfu9FyxMmoYlIDX0gzi1iUSciCOw5+POtxZRiUNc/XOFDDYoNJUmaDNP8AZvztvdLp3LmCwyTVFZ9HvulCYeLtWmc0Ft0RxGsEu5OjfHeBJwwfqfGZIXuhrTXnkuDMTFLq40n9Fxt8lz2aqx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384547; c=relaxed/simple;
	bh=wzF8nNHaIkog7ajAtjyqlFVPW/QdPOM5hvum7xIo8Gg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZfC9lk3KOi0U2YefYkjmK4vHezFRfBenOX3ny6qOTiP/t0dZGA7+y6aDTKLk4ZEhPajudMQdy2Ws29GHZG1VAJCiLvKSKSb90weRT+z/v8l3VbqsUgx1MlM3FifwUy0UuwAsuIddlr3djwLt1XWKEOm8hO02+F8VvSBCTgDwoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD4yg7fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41374C4CEEB
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751384546;
	bh=wzF8nNHaIkog7ajAtjyqlFVPW/QdPOM5hvum7xIo8Gg=;
	h=From:To:Subject:Date:From;
	b=MD4yg7fAawXiRWZC7hYFxfWY8Hihd2nbmEfZCC62ENni8xsPxDGKQG0H7+7n+nvW2
	 P+nCbGEPFYX6xbHMbPnS3RJaZMUCWaLN/HqDNWpTlVMV6S3DVu911SuhNfs/aC08zq
	 /0melI940vwpD2zNUe800fl6XZ2TL+49GJDhls4cb2mXTwBtAZeW4USk5uTgXqw6HD
	 9cjxTR5WzgZRnrl81LLvkXo1iuhW98C2BYZ0Dm6fKc9WNTHczK/joeZHrx89TGZr0R
	 uIMnd1zyVxYne9/OHrEmm41Vr5DZJA67KZXS2Wt/bA4vyjL4q7SBB/98nBGnfwO+bE
	 Xe6kg7IQXQ3Ww==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: qgroup fixes and a cleanup
Date: Tue,  1 Jul 2025 16:42:19 +0100
Message-ID: <cover.1751383079.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple fixes and a cleanup, details in the change logs.

Filipe Manana (3):
  btrfs: qgroup: set quota enabled bit if quota disable fails flushing reservations
  btrfs: qgroup: fix qgroup create ioctl returning success after quotas disabled
  btrfs: qgroup: use btrfs_qgroup_enabled() in ioctls

 fs/btrfs/ioctl.c       | 24 ++++--------------------
 fs/btrfs/qgroup.c      | 10 +++++-----
 fs/btrfs/transaction.c |  6 ++++--
 3 files changed, 13 insertions(+), 27 deletions(-)

-- 
2.47.2


