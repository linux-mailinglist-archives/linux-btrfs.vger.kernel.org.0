Return-Path: <linux-btrfs+bounces-3758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8E8891AC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5751C25C6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164E15ECE1;
	Fri, 29 Mar 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcGq9ZDG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E615ECC1;
	Fri, 29 Mar 2024 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715579; cv=none; b=hD3Ghr9GfCiLrr+UjsOXqi7QWXzyO2wFlkr1udhA1ospyMXvbIbxm1jUI3oW5uzZtzib9q9aSBn5FDGsUFrn67MzG0J91ExL/IjUM72oM48QFp18ruPVfcMjNPlre4tvNwAhif4Ns26P4UAq1l5TP+06sbLJDn1VF7TJAKP5j7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715579; c=relaxed/simple;
	bh=1Wra2lwoSp/z48sWnntzoYkS5wx/babMCJBNRI4avDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GO0CKswtufdAIS3qQEZuAqnrfa5rmqQ0F3hFJ8WGlGRCxfy/QXiw/G9b/wPmPtM/djqn2pkLvAfMX0HLw7H9IPaf/Pc1qlgp04t1qy8QssLIpk8d9loL8etgBqfd4pym2nFlo+y1+l3rTOnehvYUdV32TAcN5V7tcOhTkFXWKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcGq9ZDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B150FC433C7;
	Fri, 29 Mar 2024 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715579;
	bh=1Wra2lwoSp/z48sWnntzoYkS5wx/babMCJBNRI4avDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcGq9ZDGxqsOHUyA4CI+uU4iWLnS4LJNdRMYC+WCVF6VoqSPDrjc+hFQBW8ZjONh8
	 V8d/1Q39GG+NSB2t+7WLMLVpyXapSCaKLuxjEzUb4U36nuY2fQoxqQMn4NnTVa0ix0
	 EaCCyYjpkhUzhe6wEJ1G+Rnzq7lBN1jtc6NdpV2tg0K18E7sXqisCQH47zNKFHSuCT
	 KLK3vnxrc6Gmyw4lsIds3LfqmHru1otnNe/0nA8I5eroYLb9cFylZ8o7KmypXrHTC1
	 1dW5n7DdoAMFlaetpnotTq2hoRwMLFEq5JHvseqQ7yJIsSJsIHM30TOR3HrQnGukL1
	 YcECzM7/oAojg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 27/31] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:31:46 -0400
Message-ID: <20240329123207.3085013-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 3c6ee34c6f9cd12802326da26631232a61743501 ]

Change BUG_ON to proper error handling if building the path buffer
fails. The pointers are not printed so we don't accidentally leak kernel
addresses.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9f7ffd9ef6fd7..754a9fb0165fa 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1015,7 +1015,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 					ret = PTR_ERR(start);
 					goto out;
 				}
-				BUG_ON(start < p->buf);
+				if (unlikely(start < p->buf)) {
+					btrfs_err(root->fs_info,
+			"send: path ref buffer underflow for key (%llu %u %llu)",
+						  found_key->objectid,
+						  found_key->type,
+						  found_key->offset);
+					ret = -EINVAL;
+					goto out;
+				}
 			}
 			p->start = start;
 		} else {
-- 
2.43.0


