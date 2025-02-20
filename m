Return-Path: <linux-btrfs+bounces-11660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B9A3D7CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60CB17FD90
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4D1F429C;
	Thu, 20 Feb 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+HWilIS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EA1F1913
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049513; cv=none; b=djKgj1UgcPxCZsPTIsEHyKpGMmqaJIjXGl0fqDYggtGh6OwmVCpPKYshlA+fmvRhVkxTZbpe9W8HI/8W2NbwsJjTqdAS673MioAhCJVoGSQenR6ZX/n4yb08U/c7AtiP30wiVdPAVA3jGDn7nJ5KRwoLDxrh4+GbAgtlfP+bnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049513; c=relaxed/simple;
	bh=YRwbdZySKM3CEdobzlcWa7QWhdjG3B8FlMUrlCzFH6U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRjWNPJnNownySbPa5nrSLKJMNdg6Xi4RGNb0mknMnZNIsZ5dXyAk5bTk9/SvUYLTBtivacqo8d72FQPu34l4Fl9j3uR/WNDsoSWkBP8qQpKpGZCKdhi/oQ0jGU21Qx9jho3zWADbTVIT+OuZQSReVKocYvmmYBAp0Jq7q95fQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+HWilIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75CEC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049513;
	bh=YRwbdZySKM3CEdobzlcWa7QWhdjG3B8FlMUrlCzFH6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m+HWilISCi1zKKMd6goABkMRLH8LyaUnjSQyta/sQ+FRFo8JPUXndcq/+NrNk0k+y
	 Hdzt6/uUgZ6m8uBILmGTh31i0Sprixm53lvntkytBbRNFtDK/UlsCy4GgWxoVSxsJN
	 KrHVruFEnfGtZmbUDeq9tlRJ6L+C7aIXln+aCfi0mZ7AJWb1Dh/TfcJdwi6t0MxWI5
	 zfoo+iKfiyo1sr37EpqDqivIpEO+7QLKTWVUlvEHRma5jGgUqPsSDr1JqmUtJkJLaj
	 t1IEYqeqCEjNwyLCaPU9zKRuLh/1baGkiELff4ovNqEHM4pc4iNoZ15b52VgX7MkAM
	 tc0R32PU3sgLA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 25/30] btrfs: send: simplify return logic from send_link()
Date: Thu, 20 Feb 2025 11:04:38 +0000
Message-Id: <3f719e4e989a54bf8cf671d5227969a8e61fc0a1.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d5c151651d07..bda229c7084b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -833,7 +833,7 @@ static int send_link(struct send_ctx *sctx,
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_LINK);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH_LINK, lnk);
@@ -841,7 +841,6 @@ static int send_link(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2


