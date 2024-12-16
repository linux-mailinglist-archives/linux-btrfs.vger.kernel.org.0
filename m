Return-Path: <linux-btrfs+bounces-10393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B99F2956
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 05:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5731B7A2120
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 04:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173D1BDA89;
	Mon, 16 Dec 2024 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uyXDs5dz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uyXDs5dz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600D1B6D1B
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734324697; cv=none; b=UlvawyhTiQ/P6ZJIDlTJCGs/dfo8uwQJBEyO2e0gb3FfZ+PdetBdiuV+FI/6VpP0Qbvnj8uA7x+nAcoMcMP8N5VkOm+zJZei+2aqnDf6znrGcyxjNQWzQC+n3WDMriQ1F4b7HwLHbKJ32E9GO4N+LJrCchW/fOV/nTVW6f4PsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734324697; c=relaxed/simple;
	bh=DK2HWAQDpuF/pswsLdwmvvs0J5FWcNmhhXwMwtGJyF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/mWvfL6DnoK7D8cFNIYIqYXS3DxPHluQetPt2ECoy1Cz6nilya43ml3fSaxOo32e80xBM/nw+XbukLuGFmYGNR28T+zdJrNgL+S4VD9Jnyu+3CIn+JnPn/ymb2zWG+22mPCA2iTodo9C1WV6ckRv0X7Jb6SClG5Lhc3gGd5O8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uyXDs5dz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uyXDs5dz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 008BF211EB
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s01i7gA6369n5CM+g2rBJSkILZ8VKCrLQ0Ak+VU1+q4=;
	b=uyXDs5dzI/7SLXHWqcS6hYqVSfPFiajRr6I10ZdvA1l+7C+wWAEMeGMZPxn7D95BV2jhfa
	q3xREzvCUvDPRJkbhDaO4Le8l3eU2tmYwc7D1I+peHIKXDbvCPh0DDs0XKCSLuv5C9DVQm
	OWIts1EAVlI7F19IBqnx4871TVNM5dY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s01i7gA6369n5CM+g2rBJSkILZ8VKCrLQ0Ak+VU1+q4=;
	b=uyXDs5dzI/7SLXHWqcS6hYqVSfPFiajRr6I10ZdvA1l+7C+wWAEMeGMZPxn7D95BV2jhfa
	q3xREzvCUvDPRJkbhDaO4Le8l3eU2tmYwc7D1I+peHIKXDbvCPh0DDs0XKCSLuv5C9DVQm
	OWIts1EAVlI7F19IBqnx4871TVNM5dY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CB1F137CF
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IAVyMdSxX2ciNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: mkfs: add "--blocksize" option as an alias for "--sectorsize"
Date: Mon, 16 Dec 2024 15:21:05 +1030
Message-ID: <1542ae393d18844ed4edc5442d0ab46e8b14d74d.1734324435.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734324435.git.wqu@suse.com>
References: <cover.1734324435.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Btrfs uses the terminology "sectorsize" for the minimum data allocation
size, which is very different from other filesystems, and can be a
little confusing with the kernel block io sector size (which is the
minimum block io size, and is fixed to 512 bytes).

Let's start migrating mkfs.btrfs and its documentation to use the more
common terminology instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst | 20 +++++++++++++-------
 mkfs/main.c                  |  3 ++-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index b830f8c5be07..2102fab11fe2 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -94,7 +94,7 @@ OPTIONS
         mode may lead to degraded performance on larger filesystems, but is otherwise
         usable, even on multiple devices.
 
-        The *nodesize* and *sectorsize* must be equal, and the block group types must
+        The *nodesize* and *blocksize* must be equal, and the block group types must
         match.
 
         .. note::
@@ -108,7 +108,7 @@ OPTIONS
 -n|--nodesize <size>
         Specify the nodesize, the tree block size in which btrfs stores metadata. The
         default value is 16KiB (16384) or the page size, whichever is bigger. Must be a
-        multiple of the sectorsize and a power of 2, but not larger than 64KiB (65536).
+        multiple of the blocksize and a power of 2, but not larger than 64KiB (65536).
         Leafsize always equals nodesize and the options are aliases.
 
         Smaller node size increases fragmentation but leads to taller b-trees which in
@@ -119,11 +119,17 @@ OPTIONS
         .. note::
                 Versions up to 3.11 set the nodesize to 4KiB.
 
--s|--sectorsize <size>
-        Specify the sectorsize, the minimum data block allocation unit.
+-s|--sectorsize|--blocksize <size>
+        Specify the block size, the minimum data block allocation unit.
 
-        .. note::
-                Versions prior to 6.7 set the sectorsize matching the host CPU
+	.. note::
+		Btrfs-progs versions prior to 6.14 uses the name "sectorsize" to
+		describe the minimum data block allocation unit, which is not
+		following other filesystems' terminology.
+		From version 6.14, documentation and source code will convert
+		to use the name "blocksize" instead.
+
+                Versions prior to 6.7 set the blocksize matching the host CPU
                 page size, starting in 6.7 this is 4KiB for cross-architecture
                 compatibility. Please read more about the :doc:`subpage block size support<Subpage>`
                 and :ref:`its status<status-subpage-block-size>`.
@@ -618,7 +624,7 @@ The combination of small filesystem size and large nodesize is not recommended
 in general and can lead to various ENOSPC-related issues during mount time or runtime.
 
 Since mixed block group creation is optional, we allow small
-filesystem instances with differing values for *sectorsize* and *nodesize*
+filesystem instances with differing values for *blocksize* and *nodesize*
 to be created and could end up in the following situation:
 
 .. code-block:: none
diff --git a/mkfs/main.c b/mkfs/main.c
index 2faabc550887..87c08f3ff9a2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -432,7 +432,7 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("--csum TYPE", ""),
 	OPTLINE("--checksum TYPE", "checksum algorithm to use, crc32c (default), xxhash, sha256, blake2"),
 	OPTLINE("-n|--nodesize SIZE", "size of btree nodes"),
-	OPTLINE("-s|--sectorsize SIZE", "data block size (may not be mountable by current kernel)"),
+	OPTLINE("-s|--sectorsize|--blocksize SIZE", "data block size (may not be mountable by current kernel)"),
 	OPTLINE("-O|--features LIST", "comma separated list of filesystem features (use '-O list-all' to list features)"),
 	OPTLINE("-L|--label LABEL", "set the filesystem label"),
 	OPTLINE("-U|--uuid UUID", "specify the filesystem UUID (must be unique for a filesystem with multiple devices)"),
@@ -1105,6 +1105,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
 			{ "compress", required_argument, NULL,
 				GETOPT_VAL_COMPRESS },
+			{ "blocksize", required_argument, NULL, 's' },
 #if EXPERIMENTAL
 			{ "param", required_argument, NULL, GETOPT_VAL_PARAM },
 			{ "num-global-roots", required_argument, NULL, GETOPT_VAL_GLOBAL_ROOTS },
-- 
2.47.1


