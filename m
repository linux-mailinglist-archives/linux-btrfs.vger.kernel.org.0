Return-Path: <linux-btrfs+bounces-6179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11274926917
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8CD1F2548F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398518E74A;
	Wed,  3 Jul 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Jd8//TvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYUpsvVU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD299183080
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035765; cv=none; b=VUwiW4reAvT0Ms8CWrvG+5zj2B4OSMV/2KVwaRpO8ddk+meSJy7TmppVRQXlOacajroHZE60BYirD6UtJoM8jqiMiVdY6zvVRUM57Oy2LvxVSTWa8aHfWYu631yHHk9KmVGY1ZOZZGLWVivljHIhZeqVWKm9wUnlqqz3/kBw4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035765; c=relaxed/simple;
	bh=GI6opTZzuY1nqzM7n47hJbDhrQHWArTGURinCC5AJwg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q2KgJ9l0CiZOufg2VFpwYwwYo0KwzPlOmzflGcosI3N3ZoXQXOoLuNKUyJR23eB+HrETfwlmNYY227AIgM0f8Iny8r3iEgJhlyn0vCHGAPgpc3btZ4cLB/vJISJKVc7AXxKMcMB5utr5rCk3TkjjwO6WfcsRU63dz/6M/4HkheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Jd8//TvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KYUpsvVU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C645E1380102;
	Wed,  3 Jul 2024 15:42:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Jul 2024 15:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720035761; x=1720122161; bh=XKXi9DcU3gyF9yNv9HHUj
	3Vx0bxWumwQoZpBoIk2Yq0=; b=Jd8//TvDbO+1K5rtrmfCSiFtQNOsOJHpmMRzR
	WREFDBp5t9BZe0OIJ/9T0/5uyZySYjioFvHeSqewQEKj1U9dII77DEMpPz8aX7ZS
	pDouUds8C+U7DGidzFas1x40avz847nKalWMMtjP0UVxud+u46BMvjg+hTRwpuMN
	CqjH9qzomZTTl60uliGUyxQygVSNVpqB1Lzb51Tmuaq7mzVdik9l0bxdu/cH4buQ
	/Omik7y3a5IEMgf9Q6z65VvonAbaZfqYgL9YzWJrP/Nh3lvzZrYWCLPoNK0eThWH
	1QHxYeEISHM1gjLoiGIB0MfpjqMDa1LPolKWFhyY6LCZ+nZQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720035761; x=1720122161; bh=XKXi9DcU3gyF9yNv9HHUj3Vx0bxW
	umwQoZpBoIk2Yq0=; b=KYUpsvVU+S+ortpu8Qr5VsGYChB6EsT8eGqFWCJ9afho
	UTT3h3QH9iPtkSR/bofsGdouzkZsjl+mDSVvRvF3c+xZ5/e2MnOkOKgXDYukme4w
	OwoIdkIQNaxgI92IdIoRWgjv31aejtfcFDVcRdSLFQW0cd+JPGQuU397spTLtpCC
	Y8iRRQsIVBAQafd6YV3bHtmabBBa4ZBOZLHXHy0NQhZsaC/tqTJiQOhnzUzo4Szn
	oRDTdLKl9wd/kA0gz7GWBFToqW/h2A1+KD8NzSMr8et1qMceH5paQu0ullcsJ+xL
	7gWQuCb/ubQrDr60diiDsLv/PNxrzxDblwEAQLR1dw==
X-ME-Sender: <xms:samFZjXYdw7xv4mYztqM3Tk4WoJE4jqVVTv9HuSwMihQOwf2Qorh2A>
    <xme:samFZrnIGGSzqt7U058svV1kaPBpnLUfq7e8-eNkyqRgZdALq7Ko5_y-XUMMX4QoC
    PiIRHRf3Fk-g7Zpiqs>
X-ME-Received: <xmr:samFZvYE0FJcwp3Xc-lJffxb4GJFIpP9MrO16gHnfsMcmZSMA_0ELUj0hUFdS_qk8fw2bh0ah-knZSV9SH3lBw25mqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:samFZuWMslKK0TdC1Fb6DMDOEK3HuN4U5YEHCLJOIKDTCAWCEFyLzQ>
    <xmx:samFZtl_-1VmyidVP_F9negc_Pwhxn-KuTkIKOg8UgnjBgnRM3pBIQ>
    <xmx:samFZrcB5Ru2_sKfmbzkzO9NEgFXgLmsgBjsODbpGEVjKpEKDjYnJg>
    <xmx:samFZnG2XVk7mvsjKtIdYY-rhU0e9fU6It09WyZAZa9Kj7bluoeg2Q>
    <xmx:samFZixP-0ekFl-YWByNX7m2NehUAFj-FAt-47CYV0gRSqHSu6FDAi6q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 15:42:41 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs-progs: receive: self-contained mode
Date: Wed,  3 Jul 2024 12:41:53 -0700
Message-ID: <4151c7bf13a6eba774d1ec49a3a281487bc603f6.1720035638.git.boris@bur.io>
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
 cmds/receive.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 412bc8afe..5853d4ca0 100644
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
@@ -1712,6 +1719,7 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
 			{ "quiet", no_argument, NULL, 'q' },
 			{ "force-decompress", no_argument, NULL, GETOPT_VAL_FORCE_DECOMPRESS },
+			{ "self-contained", no_argument, NULL, GETOPT_VAL_SELF_CONTAINED },
 			{ NULL, 0, NULL, 0 }
 		};
 
@@ -1757,6 +1765,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
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


