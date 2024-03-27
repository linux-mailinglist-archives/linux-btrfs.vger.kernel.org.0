Return-Path: <linux-btrfs+bounces-3658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB888EC32
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F023B1C26986
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B414E2E4;
	Wed, 27 Mar 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaVh9Ks5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF51304A6;
	Wed, 27 Mar 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559518; cv=none; b=q+zHGbbY3QSGqxYMsvVklQ4KKcAhXWBsCZ8AY456CuJ0NHbHGMJH+fR78Q5bvUnulVOXMg4UwshyCmkBRk/IaRJK1jcOYBOFzX/ik+ayZ/nv7QFnEtitPaJBY0q1/3NjMRq2IoTFAUY0X1pK7Tz1ssB77MrZSllvSC+0HsDw+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559518; c=relaxed/simple;
	bh=ykXCDwMyRWtbED3Ezmvr40N9Yt2CVj0igZe+WCNHjz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB2FXsX0SGV36Y5FrJ6Sob7G6qr8nyU+kwk+a9061EqFot1/YsTaq6hGBVhJ9vJd+EK5byxubLtVCfDL9jZYsYGBt/W+Vx984d6z0rb5vW+huY//SOLE+mMz4wCBf689KsQm3FfwGyqd2T9tu88RpgT5GQfkX5RN92qNJU1msX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaVh9Ks5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B32C433B1;
	Wed, 27 Mar 2024 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559517;
	bh=ykXCDwMyRWtbED3Ezmvr40N9Yt2CVj0igZe+WCNHjz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaVh9Ks5BLLWNTYtfgEzmOkrZ6S8WTXcSnsK6dtP00rpth9RapmsFvlDZqN7IWGYD
	 X7irz6DYzTGN5wk6XYeKoJFZH51H95cvVuLWq8OlzOCWArTDuqAuFMRiCj282qjLUv
	 X12HoEJBWdomzbOGtbTfEnr4DHmfqMdVjpeCveN6Vy92yiX+WnFF1XcPOW/gwB+5TZ
	 nivskJqIHEwU9OCnAX8QJfjQJdV1IeaYuKEHiPwPoKBCeGT886l7/ySl03CBn3WPgX
	 +OIxWmonSnziiWICAjLU4cXZX086dUh8lGlp0NjEe7iGLAZjoWHd+v6v6USEZFQvk4
	 zCaQigBpXocHw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 03/10] btrfs/028: removed redundant sync and scratch filesystem unmount
Date: Wed, 27 Mar 2024 17:11:37 +0000
Message-ID: <b8c6456cf2e61309ca5347c403c96feb876da48b.1711558345.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711558345.git.fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to have an explicit scratch filesystem sync and unmount
at the of the test, as the fstests framework automatically unmounts the
filesystem and the unmount naturally syncs any data and metadata.

So remove them and update the comment to be more clear.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/028 | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/028 b/tests/btrfs/028
index 8fbe8887..0c96b2fe 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -48,11 +48,8 @@ kill $fsstress_pid &> /dev/null
 wait $fsstress_pid &> /dev/null
 _btrfs_kill_stress_balance_pid $balance_pid
 
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
-
-_scratch_unmount
-
-# qgroup will be checked at _check_scratch_fs() by fstest.
+# The qgroups accounting will be checked by 'btrfs check' (fsck) after the
+# fstests framework unmounts the filesystem.
 echo "Silence is golden"
 status=0
 
-- 
2.43.0


