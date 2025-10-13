Return-Path: <linux-btrfs+bounces-17701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C1BD2E72
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D753C34B75B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A326E6F3;
	Mon, 13 Oct 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbn3TpkL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196926E17D
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357139; cv=none; b=mEA08ud47uJBYE2+KV24UFmiwNe3mXzVGYuw9KiO6ZI65ybNwLgkAmun3ofoFeN06CsEuW3y3TFYWO1gtqy2878QlSY3stpyu+MvaIg0oq8T0EuebrTFBxlyudqsKVQ422CeR2jkCCd0ydr5smwzLYCXiFZDkK5IUEPsu9aKLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357139; c=relaxed/simple;
	bh=722Jeh7k3DopfvAZQp0rQWZvrR24CYDO+Rypr394MIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWvkwiduhyue+ZrKPcVXOV8VIL72Cfz/xMsLosUmYEw1hD3lUPrtftR+ZUSS4phALzIWDG5NbCvqPzFrxyeq+MlC81HeoWXAYIqdV6Rq8bnif30KPWpHfvTH4al2x+59tS3L+4OWy4j20q5ZUlSUPjwtbqUnqOCR4KH7WmCtk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbn3TpkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1C2C4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357139;
	bh=722Jeh7k3DopfvAZQp0rQWZvrR24CYDO+Rypr394MIc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qbn3TpkLgthrz3VSCZBwNEYHqrCs/UVJ5Ej1hB0NFabYlyBh8FWD4rJBUW4xEG8e+
	 LhvspnF+GZz7Rc5MwGdL3LE3CPo3JdbPsCRLw+ONb54nj4jBu/yV+cuk8/ZNi/n+Wl
	 2UnfPsIfbhUPe3YKu9ioa5TezrRyFc2LK1wmz838l4o9Fg8VE4tInkD4WUMbt6U9at
	 zBWEUjwGCrp8Bc2+Ax+btfeQKD9DJpcrPNHRl8Ss3fYDDQg6YtxmKpP3zazG9Vd+Ui
	 k7mZudkpjKzIfueYWHJ9OszD1m/LwCCENUDhB5FmIB6HOw0KtPi0GmEQlKYcS5wxiG
	 zRnp7DyOVADTg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: split assertion into two in extent_writepage_io()
Date: Mon, 13 Oct 2025 13:05:28 +0100
Message-ID: <342129175c52b8f7b68fa96d157eb116c9a01873.1760356778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760356778.git.fdmanana@suse.com>
References: <cover.1760356778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If the assertion fails we don't get to know which of the two expressions
failed and neither the values used in each expression.

So split the assertion into two, each for a single expression, so that
if any is triggered we see a line number reported in a stack trace that
points to which expression failed. Also  make the assertions use the
verbose mode to print the values involved in the computations.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c641eb50d0ee..1cb73f55af20 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1698,7 +1698,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	int bit;
 	int ret = 0;
 
-	ASSERT(start >= folio_start && end <= folio_end);
+	ASSERT(start >= folio_start, "start=%llu folio_start=%llu", start, folio_start);
+	ASSERT(end <= folio_end, "start=%llu len=%u folio_start=%llu folio_size=%zu",
+	       start, len, folio_start, folio_size(folio));
 
 	ret = btrfs_writepage_cow_fixup(folio);
 	if (ret == -EAGAIN) {
-- 
2.47.2


