Return-Path: <linux-btrfs+bounces-6181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD4926A14
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F11F1C21B9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33E18F2CC;
	Wed,  3 Jul 2024 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Xa+iHhMl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r9TqvT6x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E002BB13
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041359; cv=none; b=EogR9jMrhF4b8Repf9YU7LhY9x67ZtfrxvDnUTt57KFW36dVhghXUPpvgf9biPVjffiHp3RU62bd4nci/GJLJVokTuDv6GFP6a4pHisIpgGxXOUkjxr6GU6tTL6UkOB4cY3RLs+DJiKmYOxzmi2bOew/XNvjzTI7e1AKqWRW5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041359; c=relaxed/simple;
	bh=VdraQQVoa8OdnxzyahOYP6Vk9EmoPhN9JeotrRQis48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sQhCh0bw421sXBXpYqmoSTnVNB6wRaoiD2o1G1VKSp5+W6EvZ/UW0ODlxzGVQIrQi069PYfkIC0/njd4Nzs82L/UfvF52NgKtKmd5IyJcEpd2BAkrzu0SR2KyqYOAZQMq4F9KZD4CHnBz+O9ywGh03pkJphQBfJ3rqhnFQxme7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Xa+iHhMl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r9TqvT6x; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2F851138025F;
	Wed,  3 Jul 2024 17:15:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Jul 2024 17:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720041356; x=1720127756; bh=hpk8yn1ysaaPv850ZJE89
	MVKWA9Eifn2eWaJDB+jb/s=; b=Xa+iHhMl2rBwsvI86Dx50V9EUPG2Y/q0IRWqE
	79klvGfyizKBNfEQQvsreVIKAcaRB9p4xToKY0cnO5y+ns0u/QpUpA/j2wlKDx9p
	HMdz27WkVS03+gPBM4Z/Ut/xaw+Tv3WQqETXwIo9j3gYZC6kxE3Olu1r5u88XWKY
	1MgBbdpnGQIarT3MOxBrgDguha1Aryz4fZKHV8g7XMGH5VOJHniNmZn9M34APJXd
	b3/HKMyYj5AwJE48nSmZ409DrCJE2EY2gEZqDQTQyNh0HnJQF0rL+7fiz6Bkrmys
	Ozj5sx+cKWxi7T8XUQeydyB/qgnlwAFIX8pJSKt++nsaSbA0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720041356; x=1720127756; bh=hpk8yn1ysaaPv850ZJE89MVKWA9E
	ifn2eWaJDB+jb/s=; b=r9TqvT6xp3ADSZJds/DyaOw0+NkStwS1BD/5Fnv0tAbC
	nqw8tOJyTTROFGRx76yAjogNyMu++aqQmk3DSMiajrTUxgQcG08LO7N6lxrbEgQ8
	pI+JFtHUo28mzRw0pUqVhBhdar4hgmzxcYc64p8Rg1Rt8NLe7oLkQmuVAJfJegBO
	yWlDDRQWAzERqx60FoxTd5KAeH2uY5p/Qml1aj0canl87MOrNnb0Xrb8i4/ALpEL
	aIrSq/JHQGGB619J+Kt5HrsEeDx4lg/kWSy0PiSbXzxFxWELHeqdiUWnNHEDJJ4G
	L/XP0S75+FrO/lIrvbjf1euzEk4Cu1egAS883zQULA==
X-ME-Sender: <xms:jL-FZt6x78lKxY1UiS1ev1u3gA-YQM8Jevx1cY5paQrBj_gI1qTnqg>
    <xme:jL-FZq5LehlQEMr5hApfuFxsoHwV7iSHYLkP71vTtm-CNC81zMiHWgNoHxE-rLid3
    SFDhVzqm5mx18_Gy8s>
X-ME-Received: <xmr:jL-FZkfl2FjqHrNfZ2cWZGHta19bNDztQcHPmEf8aKeG-p_vp7JrIr5_IjuPAQo0QO5cdB5IksAlWBCzSENJEJ8U2WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:jL-FZmLVrubxtfucfFDXGC3mwgF9ElL_rFLA-5ChLqGwRc4otEMxag>
    <xmx:jL-FZhKrwjrCWFdjIcjdnl7tk1nAbOycc_jrqNaZKMoQKZLY9SXPxg>
    <xmx:jL-FZvyeE7ze4ZVz1Orj_a3ssiQwkWNLEH2vWdKlmdqUfe5ktS1C5Q>
    <xmx:jL-FZtKqHkAiTyYdOBZWfCYm5q-8Ke0Lbl1vQr7vYcAXujVEbu2spw>
    <xmx:jL-FZoVIvR_OXopJzltUlfAWuRIJe8P0lhkuoenH9E3-UMZeNpdgnnB_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 17:15:55 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs-progs: receive: self-contained mode
Date: Wed,  3 Jul 2024 14:15:12 -0700
Message-ID: <f8ae1ad668a50d0b09c2f3e36e87b1ef9381f002.1720041219.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently receive detects the case where it is mounted with -o subvolid
and resolves the path to the mounted subvolume from the root subvolume.
This path is then used to find the absolute paths for sources of
data/metadata for snapshots and reflinks.

Another interpretation of a sendstream is more divorced from the source
filesystem and aims to interpret it in a more self contained way, using
the filesystem as visible to the user. Think usecases in a chroot, user
namespace, mount namespace, etc. applying a generically crafted
sendstream that will apply successfully in the local context.

For such receives, the complexity of resolving this path is unhelpful.
First of all, the backref resolution using inode->subvol resolution uses
CAP_SYS_ADMIN, so it cannot be done in a user namespace. Even if you
could overcome this technically, and the receiving user had permissions
higher up the chain of dirs/subvols back to the root subvol, it's still
unhelpful if you want to do reflinks/snapshots relative to the paths in
the receiving subvolume, not the global paths.

Therefore, provide an option for such a self contained mode:
--self-contained

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog
v2:
- actually add the SELF_CONTAINED option to the enum; re-test
  a non hacked up version for once.. Sorry!

 cmds/receive.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 412bc8afe..d0862271c 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -82,6 +82,8 @@ struct btrfs_receive
 
 	bool force_decompress;
 
+	bool self_contained;
+
 #if COMPRESSION_ZSTD
 	/* Reuse stream objects for encoded_write decompression fallback */
 	ZSTD_DStream *zstd_dstream;
@@ -1518,11 +1520,13 @@ static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
 	}
 
 	root_subvol_path[0] = 0;
-	ret = btrfs_subvolid_resolve(rctx->mnt_fd, root_subvol_path,
-				     PATH_MAX, subvol_id);
-	if (ret) {
-		error("cannot resolve our subvol path");
-		goto out;
+	if (!rctx->self_contained) {
+		ret = btrfs_subvolid_resolve(rctx->mnt_fd, root_subvol_path,
+					     PATH_MAX, subvol_id);
+		if (ret) {
+			error("cannot resolve our subvol path");
+			goto out;
+		}
 	}
 
 	/*
@@ -1645,6 +1649,9 @@ static const char * const cmd_receive_usage[] = {
 		"this file system is mounted."),
 	OPTLINE("--force-decompress", "if the stream contains compressed data, always "
 		"decompress it instead of writing it with encoded I/O"),
+	OPTLINE("--self-contained", "don't resolve snapshot and reflink sources "
+		"relative to the true FS root, only use what is visible to the fs "
+		"as mounted."),
 	OPTLINE("--dump", "dump stream metadata, one line per operation, "
 		"does not require the MOUNT parameter"),
 	OPTLINE("-v", "deprecated, alias for global -v option"),
@@ -1705,6 +1712,7 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		enum {
 			GETOPT_VAL_DUMP = GETOPT_VAL_FIRST,
 			GETOPT_VAL_FORCE_DECOMPRESS,
+			GETOPT_VAL_SELF_CONTAINED,
 		};
 		static const struct option long_opts[] = {
 			{ "max-errors", required_argument, NULL, 'E' },
@@ -1712,6 +1720,7 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
 			{ "quiet", no_argument, NULL, 'q' },
 			{ "force-decompress", no_argument, NULL, GETOPT_VAL_FORCE_DECOMPRESS },
+			{ "self-contained", no_argument, NULL, GETOPT_VAL_SELF_CONTAINED },
 			{ NULL, 0, NULL, 0 }
 		};
 
@@ -1757,6 +1766,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_FORCE_DECOMPRESS:
 			rctx.force_decompress = true;
 			break;
+		case GETOPT_VAL_SELF_CONTAINED:
+			rctx.self_contained = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
-- 
2.45.2


