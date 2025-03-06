Return-Path: <linux-btrfs+bounces-12057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE543A5506B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338ED170C46
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01573211A2A;
	Thu,  6 Mar 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5MQnJAT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0333D6F
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278071; cv=none; b=J82n378Hu+LMZRo0R5IwKVUhaZFRaIZqCq4arnpCQUsQ7LU44yf0i5SNdfzg3xy5c7dTmS4/UHfzl0Q5l2J7KY4+3VgI14pRs8VrJXf/ylHjD7uoT7Db7uI6/XOrTyyuAUURHFg3A/0DzQT5T6RIzAYcXZBB5T8HiZtMfCKPYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278071; c=relaxed/simple;
	bh=26/4C6L0wNMhX+tTEUwCbX0zrNOiunwC/hVAZe9gCfM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hW9TIaHl7q+r0V4QRq6J+HmEb64FvIlhldr2M+FgsVfnPHFRBEiV2MoINFdV0iPNdMHwU8n4J6hv71IYGltR3MGAZIU5oljX59ISkqN6vhOhe5l4PhUqwq/EAUwSpebsxWwOvccuFRFO5t4JKk6Mwx9O23TwIORwe7Lqg+c48CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5MQnJAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F224C4CEE0
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278069;
	bh=26/4C6L0wNMhX+tTEUwCbX0zrNOiunwC/hVAZe9gCfM=;
	h=From:To:Subject:Date:From;
	b=E5MQnJATIzUzmjzSaVVlPu9jCRqEezCJrxnWxYMPz1qDqFhBKTAfhKFk0r/nEMFaI
	 kRUzAUgtFAoW/qLrCaUzD20+Od7v3E1yrUlBt/NIbGtkfipMy7DNWhKKDyAgrW3DSN
	 rGxQSdXw/iugGjHorElwyub6kaPb2FNR4X3EvLdRLYNdA8f/vzZiQZS4F29u8JguNT
	 gJXtXYCybMwRFG3mRgXKQCmC++AvKje9oxQ6Lc8r5+IPgwp2xUoq8vCRNSVoCiYyNL
	 wITHLwtepRDp9GL4Oe0QIOSMaTqbUtJ+Zm+CpmFqMkk70fwdnpF6kpkks0qmVlodiQ
	 eON0iH3oLwAAg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid unnecessary bio dereference at run_one_async_done()
Date: Thu,  6 Mar 2025 16:21:06 +0000
Message-Id: <f0e1ad9fd2ed3e76e041e3f19f493de3e9771057.1741278026.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have dereferenced the async_submit_bio structure and extracted the bio
pointer into a local variable, so there's no need to dereference it again
when calling btrfs_bio_end_io(). Just use "bio->bi_status" instead of the
longer expression "async->bbio->bio.bi_status".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 375cae2fbcad..8c2eee1f1878 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -573,7 +573,7 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 
 	/* If an error occurred we just want to clean up the bio and move on. */
 	if (bio->bi_status) {
-		btrfs_bio_end_io(async->bbio, async->bbio->bio.bi_status);
+		btrfs_bio_end_io(async->bbio, bio->bi_status);
 		return;
 	}
 
-- 
2.45.2


