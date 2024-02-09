Return-Path: <linux-btrfs+bounces-2281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3684FB64
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087211C25B51
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084B80C16;
	Fri,  9 Feb 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1glQiS1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10180BF8
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501655; cv=none; b=ihJZpbJtbLSrI3NDD/Sw0QeEYz3o1Q0ge0zoSVhJOWwxiN3ZPaUp8icatzgbHFyHd8Adq4/QhDmNvNi5AjUPkC2zaE1GYFHuZObB5nYd6+Je3UOzm6IzVYTSyfoYoXduNaI/3Iy+QcBZGq8+nlIn/yn8LqWnjqH+2vHHuZ1TOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501655; c=relaxed/simple;
	bh=+t9JuEzcvMpYb7TJ99TENtOuYJWbwpWfB2HxKNrPFP8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=O5e2hQ78nm7TvVho4VNlx3RUL0YYZSJHeEboAMVwPl2WuPzc5EiCl2VAo3P1wUb3dNuUWswmdcbPqve3j5/ASX6USQVKTK1TgmWwa1z1k1sxgDJXFCSNONLG8K4BweiWtf+D6Vl+x6FpE/VpXGU8cffhyOgm+WOFOY1mYWl7Om4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1glQiS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCEAC433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501655;
	bh=+t9JuEzcvMpYb7TJ99TENtOuYJWbwpWfB2HxKNrPFP8=;
	h=From:To:Subject:Date:From;
	b=p1glQiS1qYaPFsAfxHqYTXlI63Y2S+2Sf+TbtOirAx2WopkTirW4NMYk7F3Q026xc
	 67Y3DrQYtVIBcxK4EHbusJT/CrfV7ovN6kq8O4zRKeLB/mMqekN9z06e4xlgtfQZBP
	 XOlWTRTr+++Uf7+CAG573Y1yvLjzaOEt1hOdWZCvPwqArtz+nbbRMyeQJlqploEYch
	 jbSC1CDFCKavxhEBI3+pYwceL/5VCcpWXjlnf5sDXZKWy/sfRUhbqy+r/QC1Q9dKMc
	 USenthUkEu6mPwQ1u7efySAtBh3Ma1xNRFnNzRD63D57k65GMjYPPick/w4M2SBkBi
	 pEOvTZlehGTWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs: cleanups and minor performance change to setting/clearing delalloc
Date: Fri,  9 Feb 2024 18:00:42 +0000
Message-Id: <cover.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some cleanups and a minor performance improvement around setting and
clearing delalloc ranges. More details in the changelogs.

Filipe Manana (9):
  btrfs: stop passing root argument to btrfs_add_delalloc_inodes()
  btrfs: stop passing root argument to __btrfs_del_delalloc_inode()
  btrfs: assert root delalloc lock is held at __btrfs_del_delalloc_inode()
  btrfs: rename btrfs_add_delalloc_inodes() to singular form
  btrfs: reduce inode lock critical section when setting and clearing delalloc
  btrfs: add lockdep assertion to remaining delalloc callbacks
  btrfs: use assertion instead of BUG_ON when adding/removing to delalloc list
  btrfs: remove do_list variable at btrfs_set_delalloc_extent()
  btrfs: remove do_list variable at btrfs_clear_delalloc_extent()

 fs/btrfs/btrfs_inode.h |  3 +-
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/inode.c       | 93 ++++++++++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 38 deletions(-)

-- 
2.40.1


