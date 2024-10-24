Return-Path: <linux-btrfs+bounces-9143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0C9AEBE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA0281972
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14811F9EBA;
	Thu, 24 Oct 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROPDPZqE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E11F9EA1
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787085; cv=none; b=KugrUecAYRnZ+H3+SFIv9vdhDS6auzhdDE3lffOTTGuq13QA3W0BfnNjvXp4eA4V56MhSnA9bwnQwhFrAYTnn36ANvp18BQLTn3yQPvNM+f98QTU6eC7n+8WB9E1d7ptTVHzlzwI8NjYTDQRWAz9UjDs2r72j/7ImQ23ph04UPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787085; c=relaxed/simple;
	bh=kEKJfMzAf2JPqotlEXtVGEUpGToB83bkX1bYUVKa2XA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TM7j1a9DLvvKVbBJ3/TYj0yoXnqQGUJGM0jgnjeXvXlya+Nzq8C15AXsqSYSppMAyuli4sl0EOscXICbzUrUqRiDQomeS+vZx0q+QkSsxFUalbBWZ8H/fjFX9tpmeplPus9UHSPRd9OgMr8KPl2TYFLI9Ow2xbL7l8tkHOPM30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROPDPZqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C665FC4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787084;
	bh=kEKJfMzAf2JPqotlEXtVGEUpGToB83bkX1bYUVKa2XA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ROPDPZqEZsZHwUz7a43h8goK+a2vwf7l5GFnqZ+ZwEoXLR2sGjb3x1vHZ2oxJxkMH
	 r4TxTqrS5DfmEtLB0tg7dlba4N5bs3MdSSCtXrzwtnQxWrS7YEaCkHDXQtNI3rorkq
	 KF7Hq1zkufneSBixCLqz5g2wA8+VZ9mdTUVZ97ttfMVq6EMkx8ADaEWdOs9yjUJG8k
	 GP/fxAO2niDbtR2EiVuSKpMGrgx9i2YbQDGZDt/IIXFBXQ4v330gWAqH1GhWrgAFwg
	 fCFJuU+XrtMQHg1qMSXxlenjrEv3LiUKr77s9alpw7znjjcEDOwjoN8S4spSsmI6MP
	 kB5QTIdYRb7NA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/18] btrfs: assert delayed refs lock is held at find_first_ref_head()
Date: Thu, 24 Oct 2024 17:24:22 +0100
Message-Id: <a78162a318c70a76a473b117d2c385d8f2b88517.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The delayed refs lock must be held when calling find_first_ref_head(), so
assert that it's being held.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 3aeb2c79c1ae..a8cf76f44b2b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -384,6 +384,8 @@ static struct btrfs_delayed_ref_head *find_first_ref_head(
 	struct rb_node *n;
 	struct btrfs_delayed_ref_head *entry;
 
+	lockdep_assert_held(&dr->lock);
+
 	n = rb_first_cached(&dr->href_root);
 	if (!n)
 		return NULL;
-- 
2.43.0


