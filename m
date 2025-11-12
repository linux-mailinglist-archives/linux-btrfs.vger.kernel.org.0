Return-Path: <linux-btrfs+bounces-18902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DFC54135
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED613B3DC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547134D4CC;
	Wed, 12 Nov 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="qZoyQ7CL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="m9k5eOaQ";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="URGzCgPo";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="5b6zkV5P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender5.mail.selcloud.ru (sender5.mail.selcloud.ru [5.8.75.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577734D38A;
	Wed, 12 Nov 2025 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974480; cv=none; b=KBc3VZ5dZrxlfL/36VFj8lskPkIt8K3tCeJNIa1yhivLt5/fRNp1mmMsV+xqiy+SH69XY8qmbj7GTUZzz4AHuAi9Obit2pYHu+NZKbVwjWCAL6/OROI3GzMEtM3SWdqs1kGoaU+bgj2/J7ZzH4QLE1MSJIX53cKM/Cc9rn5b9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974480; c=relaxed/simple;
	bh=V5fWYnlVVVRJ0ZXaYW4ZbiwWkBGvchEUI5SI/1W/82w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJI6WCRPRTEw8ha4h32j6kYp/o+w/tZLkdZrjhLWRAeG9Pbkj61ZyHPYiTJaL2aSo44+sBcD4WXFpZF+9UeXpubm/hRnTIrdnHSwAa9ld3x7jnFQDQrWwcVf2e6bxWA6sqO61BfZlVwiYbSS2aeq1lLRlPLE9sqZ2ZpzeVY3Kjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=qZoyQ7CL; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=m9k5eOaQ; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=URGzCgPo; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=5b6zkV5P; arc=none smtp.client-ip=5.8.75.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YUpBY81CpFL4cQNk4GiTtgGsVsvDOcDetadJcGbk9zo=; t=1762974477; x=1763147277;
	 b=qZoyQ7CL1CiTZfWMJ1eODP1ewiOuV3bpsK0AV2eCeK+0ErmtYqE4pPbkk/rvqTnW8OFDU3Oq79
	ndzArcQRzobbdyTftxQHObwQQTSWZmNEP/n9G+hx8Mt2TsmyBl46OhWqfpoza+dV9GRY0pjcj0Svq
	kpFMDsfFLPn55L1mVyng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Help:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=YUpBY81CpFL4cQNk4GiTtgGsVsvDOcDetadJcGbk9zo=;
	t=1762974477; x=1763147277; b=m9k5eOaQUQ+QaHqSBtNuA312Y1fjnMfQe7GOhWmDLgwLpPR
	J/4C7T4GFjF7VVBudokhIMqEGYiEJ5Nq5UewClTRsrAqHTaHiHZDxU+Xl/0aeWcRT6JktIgHETeQu
	67jMC07daJH5XjCnVvZ4WWCqJR9Xir00ogp3hKsz+1AoLmo=;
Precedence: bulk
X-Issuen: 1428244
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1428244:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251107.120132
X-SMTPUID: mlgnr59
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973418; bh=YUpBY81CpFL4cQNk4GiTtgG
	sVsvDOcDetadJcGbk9zo=; b=URGzCgPoWPiiOHOoDXBAljuJhUX1tfcyrztn5sEEiP2GVUEFL5
	cQ23Ace5VqZJjq4Lql0HpfTTue5fRuTolOMpQCMmsFgoaMqtiZD+7/gNN/Xa+ztOcH9ZGz6k6yq
	s0QXNQ0VTuYLXqHt1S9U4Dvdvqa1x/lNfitlbMB7Ou8if0vDI1GfSivAfdtYgsTaVEDktSKuS9X
	72ICLZyqZAAX7Z+kL5+jVyrmYBqZLBXRvG2iwlcdFAipJBS1n8S8rcKaYfy6buaj/NVkheSMpxb
	kAzATN3P3mOZivCtotsESxPral/yo+WRhnX0GV4fJp6b/BWUHPmmdoDM03BifPCzjMg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973418; bh=YUpBY81CpFL4cQNk4GiTtgG
	sVsvDOcDetadJcGbk9zo=; b=5b6zkV5PljStXJ6UWY6I9W4Nlx9kEh6/r5KB4lIoZzlp/jbZ7i
	uAaoYknAOcHVrJzf5lB2hf8Bu/9LP6HrDsAw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] use cleanup.h in btrfs
Date: Wed, 12 Nov 2025 21:49:36 +0300
Message-ID: <cover.1762972845.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series represents my experimentation with refactoring with
cleanup guards. In my opinion, RAII-style locking improves readability
in most cases and also improves code robustness for future code changes,
so I tried to refactor simple cases that really benefits from lock guards.

However readability is a subjective concept, so you can freely disagree
and reject any of those changes, I won't insist on any. Please note that
patches 1-3 can be useful even without lock guards.

I didn't know how to split this series, mostly because it's just a lot of
small changes... so I tried to split it by types of transformation:

1. Patches 1-3 include some preparation work and simple fixes I noticed.
2. Patches 4-6  gradually increase the complexity of the refactored
  situations, from simple lock/unlock pairs to scoped guards.
3. Patch 7 refactors functions which control flow can really benefit from
  removed cleanups on exit. E.g. we can get rid of obscure if statements
  in exit paths.
4. Patch 8 is kinda an example of overdone code refactoring and I predict
  that it will be dropped anyway.

There is no TODOs for this series, but it's junk enough to be marked as
RFC.

Gladyshev Ilya (8):
  btrfs: remove redundant label in __del_qgroup_relation
  btrfs: move kfree out of btrfs_create_qgroup's cleanup path
  btrfs: simplify control flow in scrub_simple_mirror
  btrfs: simplify function protections with guards
  btrfs: use cleanup.h guard()s to simplify unlocks on return
  btrfs: simplify cleanup via scoped_guard()
  btrfs: simplify return path via cleanup.h
  btrfs: simplify cleanup in btrfs_add_qgroup_relation

 fs/btrfs/block-group.c      |  24 ++----
 fs/btrfs/compression.c      |  13 ++-
 fs/btrfs/discard.c          |  20 ++---
 fs/btrfs/disk-io.c          |   9 +-
 fs/btrfs/extent-io-tree.c   |  72 ++++++----------
 fs/btrfs/extent-tree.c      | 104 ++++++++++-------------
 fs/btrfs/extent_io.c        |  33 ++++----
 fs/btrfs/file-item.c        |   6 +-
 fs/btrfs/free-space-cache.c |  87 +++++++------------
 fs/btrfs/fs.c               |   9 +-
 fs/btrfs/inode.c            |   3 +-
 fs/btrfs/ordered-data.c     |  67 ++++++---------
 fs/btrfs/qgroup.c           | 165 ++++++++++++++----------------------
 fs/btrfs/raid56.c           |  20 ++---
 fs/btrfs/scrub.c            |  19 ++---
 fs/btrfs/send.c             |  40 ++++-----
 fs/btrfs/space-info.c       |   4 +-
 fs/btrfs/subpage.c          |  41 +++------
 fs/btrfs/tree-log.c         |  28 +++---
 fs/btrfs/volumes.c          |   3 +-
 fs/btrfs/zoned.c            |  13 +--
 fs/btrfs/zstd.c             |  13 +--
 22 files changed, 299 insertions(+), 494 deletions(-)


base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.51.1.dirty


