Return-Path: <linux-btrfs+bounces-8243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920AE987052
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EBC286B82
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3631ACE07;
	Thu, 26 Sep 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyufy7kR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94541AC432
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343208; cv=none; b=BEG34sz/lcSIPiTDXmkfIH0twZPw5HlZzARJUsO6Js4f8zt2idiFlIeSCnGwYLNcwvWAISW2Z6qdEi6V2ulhqoQNmoZmG6DCqz0Zlvrc4ALPVNm8+K5AjtIVffsRoMS4fTcNx06lZGRyOk4R7SQvRnmI2+OAzyviIy85JQ6kFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343208; c=relaxed/simple;
	bh=xe0CaZGexeg+F1ShuXAjjpGJqRApENXWnCEFmZ7ALOE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDYg1a4xxEpO7af8q3OAKYuqlgsX54JR9hz0AfjO9QnQQZ/IBOt3AuLiBP8ZNDEMTWzwXRslz1stn6UttRnZwV4L1PPSVVL3WuDrWBGKM9qiy6Tombb9yvYmEvZ9eBr+ugxjKOYUPFTv3F4ofxotNzjOh7MysHYvL7hveHdyEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyufy7kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6690C4CECD
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343208;
	bh=xe0CaZGexeg+F1ShuXAjjpGJqRApENXWnCEFmZ7ALOE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qyufy7kR79RLqgH4qp34h4mDAh+UWTg7ePyK5D5sZUHvPpu3dUQb/6PbmGcStwMbs
	 8acXVHFa1od/g5XWTo4f0Vo4fkF0AatgCZGw+pF3uiIMOOaSch6YKtSRDsybnIdW8e
	 Q+v5WMqqtzxx9HCIW8v0H/fQf5AJpnc2xhO89oHYAA8ETy3XogTSn7uv2tfphBEDpg
	 xkwcAD2fCHFu6FYpyn2VnAG/H2J3FDmA0AfPdnXMml/B4jhM5vInyAAgANK95BFOnp
	 SYIDay0MMaoZs4Il2rUKFI/gJzxDwMqkvUigDL/njr176aaOZjIbkrjuIMugb2VhlD
	 ExXKr38OWZJkQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/8] btrfs: end assignment with semicolon at btrfs_qgroup_extent event class
Date: Thu, 26 Sep 2024 10:33:17 +0100
Message-Id: <2fa0c4f84a98eafe62a13ca552d7810f86fc57dc.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
References: <cover.1727342969.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

While running checkpatch against a patch that modifies the
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


