Return-Path: <linux-btrfs+bounces-15601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFA9B0C962
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA7D7AE70C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D88C2E336E;
	Mon, 21 Jul 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dptOIxJJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57192E2EEB
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118209; cv=none; b=Vr7q9cY9IlTxNaWQtzmjK/u7ObXiKLqPCR31trMxEiAUm9uEFxXCMyLxorKbOXMFXbp/4rOVDQvCGZFiPmBR97r/nYRAfTmWyP45CshbBKX/8H8xkld7JaoPK04zA9w8rbV0OPWY+gYBetGNtAsSNRZOiuGBYFtk5S4jPqF5Oqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118209; c=relaxed/simple;
	bh=6uU+XB1V5qCKj64ExKqMg48SfuCE7Tv9DSstMlggtnI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/y57cYaNLPlqXbnTB7C1nF0VeXupy3JfzoJZXQNAIZflYWizJuosQ5WqO5XKS8H/1lhYBAOkYQ1sdVX8C+oauWNLN8zFM/n7KJvSzKru5IRy2A0sff27X7kLgqbps30BEUU1NQ2ybQ75o9ZbQLNchcEU3o/173qtqUCOOe2FA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dptOIxJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EB2C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118208;
	bh=6uU+XB1V5qCKj64ExKqMg48SfuCE7Tv9DSstMlggtnI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dptOIxJJE2rJqU//6ZlVssarthXdW5IR/MqDS/WuNHmp7u0G0oayDj+SnY02aAr8Y
	 9+o/twKnrFSlm46amG+SdHuzSFnFhV8BSw5pMgxRAofDu9oEak12lIoF/ScN2fMFTn
	 Pl2VneCvzJsHa2Q5fEvln74ONAR+p2eR75gUSG2fPDceT5a+PUkd2dq/70Z2Cb48Mz
	 jmL2mSFhpJFr4C8ws71FQjrIAtNM77L3N0dNPZSMpU5E8/evIM0/6AjUbObKClA+sD
	 K0sR2DSMIUwSgtNusmGJn/1dhCN5JSIPsJnNhpDGXsa9tATEGWJ6idB4SaHeSYUr34
	 E22/9sXneD4yw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: return real error from read_alloc_one_name() in drop_one_dir_item()
Date: Mon, 21 Jul 2025 18:16:32 +0100
Message-ID: <68e5879ad29e41fb9456021acbce94af29ee21d5.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If read_alloc_one_name() we explicitly return -ENOMEM and currently that
is fine since it's the only error read_alloc_one_name() can return for
now. However this is fragile and not future proof, so return instead what
read_alloc_one_name() returned.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 0fff6716a7ed..1c6210786a87 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -950,7 +950,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	btrfs_dir_item_key_to_cpu(leaf, di, &location);
 	ret = read_alloc_one_name(leaf, di + 1, btrfs_dir_name_len(leaf, di), &name);
 	if (ret)
-		return -ENOMEM;
+		return ret;
 
 	btrfs_release_path(path);
 
-- 
2.47.2


