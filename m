Return-Path: <linux-btrfs+bounces-8218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6998575E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 12:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B591F21D88
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617C189516;
	Wed, 25 Sep 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+K1QI3e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5747188A01
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261436; cv=none; b=CwA2jqxdbgrNivPcsJ2R8rrjiwzG/hkiyfZtPJyXevRTTzIa3zWJEqMsDzYoky9jN9JlSidq7zTtDfSVYWCav1H8ZuBDpg4K9GAe7iNh1brqD2T5XGBxgnE4BMq6m/aM+VaN+QUeE+MtRgPOxqZYJ5Wdh9PQBabx9eRPrUQhZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261436; c=relaxed/simple;
	bh=Ys1tQqvHmLxakzsIiAp3aWhuC3EjVvatzB5nxvJTTxM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTjpRX58pfAAxqQ+Y11CAg90AvOcF6BMTYFMxuoTynIgcBx7ofYjT9sKECJ0xkDIGB+IExBHLsh9ZSqmlcQXQk07xlvW3LqRHDWF46lxqhLA37QKOedlTls697TW38cg9M6IeGTPJ5TlLIvQsXJAgIg+aSNHYvvsmK8pl0mj4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+K1QI3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196ADC4CECE
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727261436;
	bh=Ys1tQqvHmLxakzsIiAp3aWhuC3EjVvatzB5nxvJTTxM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N+K1QI3e7PmW3cUPevLjAY2cWlZ7L0xJusSS2stBfKTLbITlIy4UA7Nmm4FYznOkE
	 uL6JTcq/xbXBdksFptkfjjH7j5KIsVionaL7FOGJX80IN1zyx0hVPlynDwe1hC+hvK
	 pb8nV4gm9MlXxonz9vCkJcxndIlJ4fXWbq2eqRLEpBGcSOjB7jEAbqqb1eA2JsjRdb
	 7CtsfC/tOyvUOTdLm9t4q+0kv9JXfOiLTThSWmDYPr2/PyaOp8Enzv8G1xBgKOKsjW
	 KJwD119j2RJzYunD0ppSoCQ18yjFqlurUPmtzz7pO2kEzPXB4WNVaZImMr7ZuEAcsK
	 x72qeEj+540Ig==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: end assignment with semicolon at btrfs_qgroup_extent event class
Date: Wed, 25 Sep 2024 11:50:25 +0100
Message-Id: <124b1f06a8d12f0206fc38e398f707d43acf01b7.1727261112.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727261112.git.fdmanana@suse.com>
References: <cover.1727261112.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

While running checkpatch against against a patch that modifies the
btrfs_qgroup_extent event class, it complained about using a comma instead
of a semicolon:

  $ ./scripts/checkpatch.pl qgroups/0003-btrfs-qgroups-remove-bytenr-field-from-struct-btrfs_.patch
  WARNING: Possible comma where semicolon could be used
  #215: FILE: include/trace/events/btrfs.h:1720:
  +		__entry->bytenr		= bytenr,
		__entry->num_bytes	= rec->num_bytes;

  total: 0 errors, 1 warnings, 184 lines checked

So replace the comma with a semicolon to silence checkpatch and possibly
other tools. It also makes the code consistent with the rest.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 include/trace/events/btrfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index bf60ad50011e..af6b3827fb1d 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1716,7 +1716,7 @@ DECLARE_EVENT_CLASS(btrfs_qgroup_extent,
 	),
 
 	TP_fast_assign_btrfs(fs_info,
-		__entry->bytenr		= rec->bytenr,
+		__entry->bytenr		= rec->bytenr;
 		__entry->num_bytes	= rec->num_bytes;
 	),
 
-- 
2.43.0


