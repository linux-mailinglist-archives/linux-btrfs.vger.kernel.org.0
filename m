Return-Path: <linux-btrfs+bounces-10394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667E9F2957
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 05:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C547A225F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 04:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932B1C3318;
	Mon, 16 Dec 2024 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r/lceDMj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r/lceDMj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02D1BC064
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734324699; cv=none; b=LhTV1tRKJgA/kNYdL9wRT21FVBdDr5CSqdy3mFab3CDIvGyjKEzka6JkYeTIaSfaCvx+49S+yTciD//U6MdNUdI9t0trGXKAOY5YGZ7GfBsgMaZShQH8HkJPwN6Vpj47PD+cJwZfgRv2rxqUxHhphGkz67nLFLH0S1BlE9YR7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734324699; c=relaxed/simple;
	bh=qbJ47YfRup+h/4yfyCBTMJmJK3fbeRDe3amF4uriWME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SInRbw0aPGvCorcgeHip6DR/0fj3YBccil1P5bBG65QtsyqNWDqQ4YZQmmXiupit1yqVb/uE38e+NIYUwUmY5cmYhk0kMG/Q4ckXNtgFOulJTnPGCPy4U7r7H8+PNXLouXTV4qLl6cM1oWNc25u7AX8Wq7DTwXre6osmsa4YNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r/lceDMj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r/lceDMj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B4181F7A1
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPRItFN/41XuTjf9vD+YvXunSmG78Sh5K5JndQeGErE=;
	b=r/lceDMjKLRF/uo5xFDrBj/Nb2q6dGnuu0Rl5HM3058mJakzmR8VmvaSSCIAXIQWpbQKMD
	DagP9zMq/T0sAlyqCjIQEmkeBByPV5LqpHJPJPYv2dcJBcm35YnncaM+EYdxIF5i8tVHpl
	+c+snt76BmIaWH2O0tvfIqULnr0QdeQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="r/lceDMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPRItFN/41XuTjf9vD+YvXunSmG78Sh5K5JndQeGErE=;
	b=r/lceDMjKLRF/uo5xFDrBj/Nb2q6dGnuu0Rl5HM3058mJakzmR8VmvaSSCIAXIQWpbQKMD
	DagP9zMq/T0sAlyqCjIQEmkeBByPV5LqpHJPJPYv2dcJBcm35YnncaM+EYdxIF5i8tVHpl
	+c+snt76BmIaWH2O0tvfIqULnr0QdeQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87D0A137CF
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OGMEENaxX2ciNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: docs: change the terminology from "sectorsize" to "blocksize"
Date: Mon, 16 Dec 2024 15:21:06 +1030
Message-ID: <65825161563e2b67422441e1b23fba3c271b02b0.1734324435.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 6B4181F7A1
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

To align with other filesystems, with extra mentioning of the older
"sectorsize" terminology to reduce confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/Status.rst             |  8 ++++----
 Documentation/Subpage.rst            | 11 ++++++-----
 Documentation/btrfs-convert.rst      |  4 ++--
 Documentation/btrfs-man5.rst         |  4 ++--
 Documentation/ch-balance-filters.rst |  4 ++--
 Documentation/ch-mount-options.rst   |  6 +++---
 Documentation/ch-sysfs.rst           |  2 +-
 7 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/Status.rst b/Documentation/Status.rst
index 37128797f00c..808b6250d356 100644
--- a/Documentation/Status.rst
+++ b/Documentation/Status.rst
@@ -298,9 +298,9 @@ Subpage block size
 ------------------
 
 Most commonly used page sizes are 4KiB, 16KiB and 64KiB. All combinations with
-a 4KiB sector size filesystems are supported. Some features are not compatible
+a 4KiB block size filesystems are supported. Some features are not compatible
 with subpage or require another feature to work. Since btrfs-progs 6.7 the default
-sector size is 4KiB as this allows cross-architecture compatibility.
+block size is 4KiB as this allows cross-architecture compatibility.
 
 .. list-table::
    :header-rows: 1
@@ -317,9 +317,9 @@ sector size is 4KiB as this allows cross-architecture compatibility.
    * - Compression
      - :statusok:`partial support`
      - Only page-aligned ranges can be compressed
-   * - Sectorsize
+   * - Blocksize
      - :statusok:`supported`
-     - The list of supported sector sizes on a given version can be found
+     - The list of supported block sizes on a given version can be found
        in file :file:`/sys/fs/btrfs/features/supported_sectorsizes`
 
 .. _status-zoned:
diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
index 4116f86ee828..44ae55b7bf3e 100644
--- a/Documentation/Subpage.rst
+++ b/Documentation/Subpage.rst
@@ -2,16 +2,17 @@ Subpage support
 ===============
 
 Subpage block size support, or just *subpage* for short, is a feature to allow
-using a filesystem that has different size of data block size (*sectorsize*)
+using a filesystem that has different size of data block size
+(*blocksize*, previously called *sectorsize*)
 and the host CPU page size. For easier implementation the support was limited
 to the exactly same size of the block and page. On x86_64 this is typically
 4KiB, but there are other architectures commonly used that make use of larger
 pages, like 64KiB on 64bit ARM or PowerPC or 16KiB on Apple Silicon. This means
-filesystems created with 64KiB sector size cannot be mounted on a system with
+filesystems created with 64KiB block size cannot be mounted on a system with
 4KiB page size.
 
-Since btrfs-progs 6.7, filesystems are created with a 4KiB sector size by
-default, though it remains possible to create filesystems with other sector sizes
+Since btrfs-progs 6.7, filesystems are created with a 4KiB block size by
+default, though it remains possible to create filesystems with other block sizes
 (such as 64KiB with the "-s 64k" option for :command:`mkfs.btrfs`). This
 ensures that new filesystems are compatible across other architecture variants
 using larger page sizes.
@@ -21,7 +22,7 @@ Requirements, limitations
 
 The initial subpage support has been added in kernel 5.15. Most features are
 already working without problems. On a 64KiB page system, a filesystem with
-4KiB sectorsize can be mounted and used as long as the initial mount succeeds.
+4KiB blocksize can be mounted and used as long as the initial mount succeeds.
 Subpage support is used by default for systems with a non-4KiB page size since
 btrfs-progs 6.7.
 
diff --git a/Documentation/btrfs-convert.rst b/Documentation/btrfs-convert.rst
index 973025aba040..0be54ac4d40a 100644
--- a/Documentation/btrfs-convert.rst
+++ b/Documentation/btrfs-convert.rst
@@ -30,8 +30,8 @@ OPTIONS
 -N|--nodesize <SIZE>
         set filesystem nodesize, the tree block size in which btrfs stores its metadata.
         The default value is 16KiB (16384) or the page size, whichever is bigger.
-        Must be a multiple of the sectorsize, but not larger than 65536. See
-        :doc:`mkfs.btrfs` for more details.
+        Must be a multiple of the block size (previously called "sector size),
+	but not larger than 65536. See :doc:`mkfs.btrfs` for more details.
 -r|--rollback
         rollback to the original ext2/3/4 filesystem if possible
 -l|--label <LABEL>
diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
index 56f9c939d6cd..ad1337b4c39f 100644
--- a/Documentation/btrfs-man5.rst
+++ b/Documentation/btrfs-man5.rst
@@ -182,8 +182,8 @@ supported_checksums
 supported_sectorsizes
         (since: 5.13)
 
-        list of values that are accepted as sector sizes (:command:`mkfs.btrfs --sectorsize`) by
-        the running kernel
+        list of values that are accepted as block sizes (previously known as
+	"sector size", :command:`mkfs.btrfs --sectorsize|--blocksize`) by the running kernel
 
 supported_rescue_options
         (since: 5.11)
diff --git a/Documentation/ch-balance-filters.rst b/Documentation/ch-balance-filters.rst
index 81a0ca8f0345..7eb0a858b875 100644
--- a/Documentation/ch-balance-filters.rst
+++ b/Documentation/ch-balance-filters.rst
@@ -21,8 +21,8 @@ multiple device.
 
 The main reason why you want to have different profiles for data and metadata
 is to provide additional protection of the filesystem's metadata when devices fail,
-since a single sector of unrecoverable metadata will break the filesystem,
-while a single sector of lost data can be trivially recovered by deleting the broken file.
+since a single block of unrecoverable metadata will break the filesystem,
+while a single block of lost data can be trivially recovered by deleting the broken file.
 
 Before changing profiles, make sure there is enough unallocated space on
 existing drives to create new metadata block groups (for filesystems
diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index 1d968f37c14a..9e498c08ced7 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -289,10 +289,10 @@ max_inline=<bytes>
         Specify the maximum amount of space, that can be inlined in
         a metadata b-tree leaf.  The value is specified in bytes, optionally
         with a K suffix (case insensitive).  In practice, this value
-        is limited by the filesystem block size (named *sectorsize* at mkfs time),
-        and memory page size of the system. In case of sectorsize limit, there's
+        is limited by the filesystem block size (named *blocksize* at mkfs time),
+        and memory page size of the system. In case of blocksize limit, there's
         some space unavailable due to b-tree leaf headers.  For example, a 4KiB
-        sectorsize, maximum size of inline data is about 3900 bytes.
+        blocksize, maximum size of inline data is about 3900 bytes.
 
         Inlining can be completely turned off by specifying 0. This will increase data
         block slack if file sizes are much smaller than block size but will reduce
diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
index f58db400fcc7..d1024d4570cd 100644
--- a/Documentation/ch-sysfs.rst
+++ b/Documentation/ch-sysfs.rst
@@ -112,7 +112,7 @@ read_policy
 sectorsize
         (RO, since: 3.14)
 
-        Shows the sectorsize of the mounted filesystem.
+        Shows the block size (previously called "sector size") of the mounted filesystem.
 
 
 temp_fsid
-- 
2.47.1


