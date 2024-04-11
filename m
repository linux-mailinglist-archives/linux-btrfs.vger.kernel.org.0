Return-Path: <linux-btrfs+bounces-4175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6F8A2295
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 01:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22FD1C21350
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568F4AEDA;
	Thu, 11 Apr 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dz3/E7nn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257F2C68F;
	Thu, 11 Apr 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879269; cv=none; b=l9SjKNwdGEKVhJYCh1FaWiCw/hvg0HeOZW822RBiHLypkdoICBeIzUMMTxFwJN7C0ETbTyhzP/kbfmM3917PCUQCOUuJXRZITta6cKsCN5spOrtEmavMfLYLLwmfmm9wBp+gdmWY3Fpu/dLAazdSISLf58pMG8H7crjuUFGlrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879269; c=relaxed/simple;
	bh=G70838YmU8xFndV637F6kfSBMzjkQCyOXIC4UCyfMvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hriOmrKEQaMAhU/r4Yf0wjpVVg5sebtsOlKilt0spjKg4EzzIjWd4MLVxJLS87yDjHbnWNsIxVrYzWtbTAkapraAF8E8LDE72Cjh7ttCPTtZOEAu4gmjfOg/3PvfZ/9NJ30Ug5G8e97ioOlq+lEvsK9n0WaRfyBKaBS5HX4fqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dz3/E7nn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nu42pdKspjgkQL4+tWkwDhfWYE6ku+6bIokaCwyyJJ4=; b=Dz3/E7nnJmcMWtn4ccVvPx8iQT
	4EaUIlqTL5rDH27/ArE4zIWnySkdUCMvc7nREib55ODAaYkeUOjOf/OCl4kLRvb8S+wQEEYfWWnqN
	WMVLujOkDbfh+gjt7uG5gsZft8ddJEyxHou1BwKDBMf3iXe1V8u8kP5JDO//hXP+2Pb860PxH+wka
	EBwktlZxkT419wE97+YO8OIn10aeFRebEOBIiaGi+6vzD5fY8wchDj8QVx/0FyXbpTUivw5+PelK3
	6I6mcZO4byIUgJhUgnBG7k1y8Gvx2hFjPhGIapYDsWYjgPOaYgLjEZfjBRVAuGZhSUEPBpKXjx0ZU
	mfOWKLeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv48x-0000000EXKZ-2D5D;
	Thu, 11 Apr 2024 23:47:47 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: kdevops@lists.linux.dev
Cc: linux-btrfs@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH kdevops] xfs: update expunges with two new crashes one related to btrfs sparse files
Date: Thu, 11 Apr 2024 16:47:42 -0700
Message-ID: <20240411234743.3464688-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

One is already known, the other one seems new, and it is triggerable
by using sparse files on a btrfs partition for testing xfs on test
generic/476 (no SOAK_DURATION needed), so the bug is specific to btrfs.
The bug is triggered on the btrfs-endio-write btrfs_work_helper
workqueue and hits BUG_ON() on a dad page state on the call
btrfs_release_extent_buffer_pages() [0].

We've done extensive testing of XFS on v6.6-rc5 and recently we moved
to v6.8, and so this could be an issue introduced on v6.7 or v6.8.

[0] https://gist.github.com/mcgrof/76e026ca48b95922a365be3502fddf45

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

This is a kdevops specific expunge patch, but I figured btrfs folks
would be interested about hearing about this btrfs crash. Hopefully the
above sumarizes enough to enable to folks who may want to reproduce to
give it a shot. I am not yet sure of the failure rate as I just ran into
it on my first shot on v6.8.

A fix for the xfs specifically triggered fsstress + compaction crash is
already on my radar but documenting it for posterity.

 .../fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_4k.txt | 1 +
 .../expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt | 1 +
 .../fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_4k.txt | 1 +
 .../expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt | 1 +
 4 files changed, 4 insertions(+)

diff --git a/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_4k.txt b/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_4k.txt
index 5b12210a6194..12d6702668ab 100644
--- a/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_4k.txt
+++ b/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_4k.txt
@@ -6,6 +6,7 @@ generic/269 # F:1/11
 generic/297
 generic/298
 generic/388 # Hangs. SOAK_DURATION=9900
+generic/447 # korg#218227 fsstress + compaction
 generic/455 # F:1/8
 generic/471
 generic/482 # F:1/4
diff --git a/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt b/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt
index 1fb67ccacd81..aee7b603c9f2 100644
--- a/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt
+++ b/workflows/fstests/expunges/6.8.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt
@@ -8,6 +8,7 @@ generic/388 # Hangs. SOAK_DURATION=9900
 generic/455 # F:1/12
 generic/457 # F:1/6
 generic/471
+generic/476 # Bad page state in workqueue btrfs-endio-write btrfs_work_helper SOAK_DURATION=9900 https://gist.github.com/mcgrof/76e026ca48b95922a365be3502fddf45
 generic/482 # metadata corruption: https://gist.github.com/dagmcr/9fc650327b2dafd89fabd45ede0a932d
 generic/648 # https://gist.githubusercontent.com/dagmcr/447a5030dde1f91206604f1b8ee9d2a5/raw/6c8568284b6c5c05920a132c73c67fd86dcbe6f8/gistfile1.txt
 generic/670
diff --git a/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_4k.txt b/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_4k.txt
index 5b12210a6194..12d6702668ab 100644
--- a/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_4k.txt
+++ b/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_4k.txt
@@ -6,6 +6,7 @@ generic/269 # F:1/11
 generic/297
 generic/298
 generic/388 # Hangs. SOAK_DURATION=9900
+generic/447 # korg#218227 fsstress + compaction
 generic/455 # F:1/8
 generic/471
 generic/482 # F:1/4
diff --git a/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt b/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt
index 1fb67ccacd81..aee7b603c9f2 100644
--- a/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt
+++ b/workflows/fstests/expunges/6.9.0-rc2/xfs/unassigned/xfs_reflink_stripe_len.txt
@@ -8,6 +8,7 @@ generic/388 # Hangs. SOAK_DURATION=9900
 generic/455 # F:1/12
 generic/457 # F:1/6
 generic/471
+generic/476 # Bad page state in workqueue btrfs-endio-write btrfs_work_helper SOAK_DURATION=9900 https://gist.github.com/mcgrof/76e026ca48b95922a365be3502fddf45
 generic/482 # metadata corruption: https://gist.github.com/dagmcr/9fc650327b2dafd89fabd45ede0a932d
 generic/648 # https://gist.githubusercontent.com/dagmcr/447a5030dde1f91206604f1b8ee9d2a5/raw/6c8568284b6c5c05920a132c73c67fd86dcbe6f8/gistfile1.txt
 generic/670
-- 
2.43.0


