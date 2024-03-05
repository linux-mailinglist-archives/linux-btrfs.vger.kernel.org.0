Return-Path: <linux-btrfs+bounces-3022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178E872725
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4481F2A1EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195951BF5D;
	Tue,  5 Mar 2024 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vRcE29nN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vRcE29nN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F624B59;
	Tue,  5 Mar 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665160; cv=none; b=jOhA9enyVvlhTHgDm1m5lBcmxiJl1lCARtDL7jsyekSUbhBzlM8vzKoRHkxlq2HDJrsRYwXjYBjUpOcsEqYr8w+oyPc9/5ogt+cD3lXjf5rL+7oYhNuh9K8IMuKfPTraZE+6f1vAZQjxekv3sn0CAtkrXdt0IjkMYHQ4ZKTrLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665160; c=relaxed/simple;
	bh=/EBrijUi7iFImBEkOH2iUNg/uuOpjavggEz044N7zLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ3/eJKPQnCAmf8LwxtOxf+G3ug182UOVauqRlfRhi+ufcJtpFlt6fL4YEJOAcvpAWbMcPMkHPLqkTR8mTOv6VEaGGttzyY3aMx83c4LpQkLs+Z8GiEBb+cKDJ/FKcqC0kvTUzc4G4Iu8OP5OrjogFromYfarEmok1aR27IB/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vRcE29nN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vRcE29nN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3843934E57;
	Tue,  5 Mar 2024 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqRZ/Ar6QGLPWQ+QMxyU6AQLlbfPBjk21kd13L0lwOc=;
	b=vRcE29nNfHs9Nzc9YNWTi6DMARWexAQB3fsSmblS7YoXeXP6cq4kLRDH60H502xX+2fB1x
	9iMcPe3p5Yg9gyXL03EHRMZgLpekbaXmBTb25176A1S6Dl3vLGz/9wiRJPJ0Lmmykc+JDW
	29g+ZIvTesn+1mFVlD7fp7K/J9JWSSQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqRZ/Ar6QGLPWQ+QMxyU6AQLlbfPBjk21kd13L0lwOc=;
	b=vRcE29nNfHs9Nzc9YNWTi6DMARWexAQB3fsSmblS7YoXeXP6cq4kLRDH60H502xX+2fB1x
	9iMcPe3p5Yg9gyXL03EHRMZgLpekbaXmBTb25176A1S6Dl3vLGz/9wiRJPJ0Lmmykc+JDW
	29g+ZIvTesn+1mFVlD7fp7K/J9JWSSQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 31E1613466;
	Tue,  5 Mar 2024 18:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Yo0rDINr52U+BQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:15 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs/012: adjust how we populate the fs to convert
Date: Tue,  5 Mar 2024 19:52:06 +0100
Message-ID: <0b465808ecd272a04d5ea16383043b91afb6c2b0.1709664047.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1709664047.git.dsterba@suse.com>
References: <cover.1709664047.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vRcE29nN
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 3843934E57
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

From: Josef Bacik <josef@toxicpanda.com>

/lib/modules/$(uname -r)/ can have symlinks to the source tree where the
kernel was built from, which can have all sorts of stuff, which will
make the runtime for this test exceedingly long.  We're just trying to
copy some data into our tree to test with, we don't need the entire
devel tree of whatever we're doing.  Additionally VM's that aren't built
with modules will fail this test.

Update the test to use /etc, which will always exist.  Additionally use
timeout just in case there's large files or some other shenanigans so
the test doesn't run forever copying large amounts of files.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/012 | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index d9faf81ce1ad8e..7bc0c3ce59d28f 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -33,6 +33,8 @@ _require_non_zoned_device "${SCRATCH_DEV}"
 _require_loop
 _require_extra_fs ext4
 
+SOURCE_DIR=/etc
+BASENAME=$(basename $SOURCE_DIR)
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
 
 # Create & populate an ext4 filesystem
@@ -41,9 +43,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
 
-_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
+_require_fs_space $SCRATCH_MNT $(du -s $SOURCE_DIR | ${AWK_PROG} '{print $1}')
 
-cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
+timeout 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT
 _scratch_unmount
 
 # Convert it to btrfs, mount it, verify the data
@@ -51,7 +53,7 @@ $BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
 	_fail "btrfs-convert failed"
 _try_scratch_mount || _fail "Could not mount new btrfs fs"
 # (Ignore the symlinks which may be broken/nonexistent)
-diff -r /lib/modules/`uname -r`/ $SCRATCH_MNT/`uname -r`/ 2>&1 | grep -vw "source\|build"
+diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
 
 # Old ext4 image file should exist & be consistent
 $E2FSCK_PROG -fn $SCRATCH_MNT/ext2_saved/image >> $seqres.full 2>&1 || \
@@ -62,12 +64,12 @@ mkdir -p $SCRATCH_MNT/mnt
 mount -o loop $SCRATCH_MNT/ext2_saved/image $SCRATCH_MNT/mnt || \
 	_fail "could not loop mount saved ext4 image"
 # Ignore the symlinks which may be broken/nonexistent
-diff -r /lib/modules/`uname -r`/ $SCRATCH_MNT/mnt/`uname -r`/ 2>&1 | grep -vw "source\|build"
+diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/mnt/$BASENAME/ 2>&1
 umount $SCRATCH_MNT/mnt
 
 # Now put some fresh data on the btrfs fs
 mkdir -p $SCRATCH_MNT/new 
-cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
+timeout 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT/new
 
 _scratch_unmount
 
@@ -82,7 +84,7 @@ $E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || \
 # Mount the un-converted ext4 device & check the contents
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
 # (Ignore the symlinks which may be broken/nonexistent)
-diff -r /lib/modules/`uname -r`/ $SCRATCH_MNT/`uname -r`/ 2>&1 | grep -vw "source\|build"
+diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
 
 _scratch_unmount
 
-- 
2.42.1


