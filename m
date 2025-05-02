Return-Path: <linux-btrfs+bounces-13612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC118AA6FA3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4294A805B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17A23C507;
	Fri,  2 May 2025 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igHXY/nB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5A23C4E4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181833; cv=none; b=aWvnGD01njuNc2OkTRwpPZREIAnDzG+Qa4wNq1u+Js0xjyPNVnoh87LBDSYvHgACklD0zPDMItv7Zrb6PHdBsDRnaaQ+/TIT1TrMwtKMtMjlc2AKrlXO55elkNizhjvCQrEGDBMYLIjZ5Py1RfDn+AabHqWhNkLZsWgpfAI0ZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181833; c=relaxed/simple;
	bh=zFSSk5r5BlpcL4skqDdVwVPb5nrf/RbQWqsgOdbY2w4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWjtCmnhwx6O6IShGdkmz6jAY91+81n8D6PJZOguY5cDYOHiDVbKg/SHtjRNjjwVOZOy78KypSnV5F/q0JmlUr3uWT0xyA/2xSETiBDNWGpURzATpQxUsuP8hVWp3LYUCKaevkUXgBFdtGN4RrouacKXSZ/AKX5a7cfQbT08rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igHXY/nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84D6C4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181833;
	bh=zFSSk5r5BlpcL4skqDdVwVPb5nrf/RbQWqsgOdbY2w4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=igHXY/nBgN9kQPBAwbYu7tOjx55JPUDZkY6zhm50fR3DdSbIqEJzxQqcNjzJAlYdd
	 xwMDH8XHI5PHpnmuKxQhKQsijnUbFoATDtJnDnMO74u+n5ZKg/zJY+U2UqX1szrMjw
	 iUgZdMt8z8K+cYHe1+cqlTDKRb7R6ykSSyfReNQUdHfSNh1v3z65cx5br97CYbOLHr
	 2PM0o1SPzN7+LN3MiruwNzEs9jn6UVRgAQFOw2qa9vJYzZ1xjoH4cPxxsYzQgqTbye
	 ebRvsL8JSjRED6e06uZakY6apo3TjD7B6c8oI6nJn9Q+54y9BJUxQ0qj4kmuhvqqe+
	 +7Vd2W2XZ80nA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: simplify getting and extracting previous transaction during commit
Date: Fri,  2 May 2025 11:30:21 +0100
Message-Id: <d151a114071ec2440d29ed04eda19e318cde9042.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
References: <cover.1746181528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of detecting if there is a previous transaction by comparing the
current transaction's list prev member to the head of the transaction
list (fs_info->trans_list), use the list_is_first() helper which contains
that logic and the naming makes sense since a new transaction is always
added to the end of the list fs_info->trans_list with list_add_tail().

And instead of extracting the previous transaction with the more generic
list_entry() helper against the current transaction's list prev member,
use the more specific list_prev_entry() helper, which makes it clear what
we are doing and is shorter.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5a58d97a5dfc..fe79d65c8635 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2270,14 +2270,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	wake_up(&fs_info->transaction_blocked_wait);
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 
-	if (cur_trans->list.prev != &fs_info->trans_list) {
+	if (!list_is_first(&cur_trans->list, &fs_info->trans_list)) {
 		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
 
 		if (trans->in_fsync)
 			want_state = TRANS_STATE_SUPER_COMMITTED;
 
-		prev_trans = list_entry(cur_trans->list.prev,
-					struct btrfs_transaction, list);
+		prev_trans = list_prev_entry(cur_trans, list);
 		if (prev_trans->state < want_state) {
 			refcount_inc(&prev_trans->use_count);
 			spin_unlock(&fs_info->trans_lock);
-- 
2.47.2


