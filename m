Return-Path: <linux-btrfs+bounces-3278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E46587BABC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820211C2166B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF686BFCE;
	Thu, 14 Mar 2024 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MPgZddV+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MPgZddV+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C46CDDB
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409837; cv=none; b=QZtNnX65OSqNKiym5OyS9tDEFPz6WGTLGqwMVlYAxe7j5sQox9NwAL9Z67egToeWNx4BzlENQi2sNwhXGc8hfIutAvGDJHKsJHpT/k3nzOl1pRTSfFw2nDmMFU4ExnauzOsgfdY7oJb+7JvWijWaBUmaEskTOR6H95e/lQGKsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409837; c=relaxed/simple;
	bh=kaMOxLbW6huE86YzBVvtQESgh6qUnHT0G+O86D+5ISQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un78QE3uiul4fBtZWR41Ck5KtWWC4jtI1jNsvU67IcKEABFaIcUvpTCLiOz3e+rQarV2QyyZ9n2ZmYgqYfiytn7Fhit76eC4CRzkQ2A4ThNNMiXP8yJIj0p95zorHEg0k1Q9YRwhfguSA7EyTNrCWCeXjOVvon4NcCaLrzsp4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MPgZddV+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MPgZddV+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7959A21C81
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tr/+Jh6cTbDUx3OXCOZ+r6MpEXVTk8dBykmYX/LSzRE=;
	b=MPgZddV+Mz8+5Lpi1uTNFevUHEZPtW70taMBkqoeP5J/McjTY3AgJT/IlFugvuGiC6gRjz
	aJPaI7gEEb6joTNtx3wglMga+hmpWHw9i91lsV6PLqi68t3D+DaaEpqhHjQlBpEamUxrWQ
	v7U9Y2gjbZMDKsv3lUTPiCMXlDd00pU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tr/+Jh6cTbDUx3OXCOZ+r6MpEXVTk8dBykmYX/LSzRE=;
	b=MPgZddV+Mz8+5Lpi1uTNFevUHEZPtW70taMBkqoeP5J/McjTY3AgJT/IlFugvuGiC6gRjz
	aJPaI7gEEb6joTNtx3wglMga+hmpWHw9i91lsV6PLqi68t3D+DaaEpqhHjQlBpEamUxrWQ
	v7U9Y2gjbZMDKsv3lUTPiCMXlDd00pU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F6A71386D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADqiFGjI8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
Date: Thu, 14 Mar 2024 20:20:19 +1030
Message-ID: <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710409033.git.wqu@suse.com>
References: <cover.1710409033.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MPgZddV+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.51
X-Rspamd-Queue-Id: 7959A21C81
X-Spam-Flag: NO

Currently the scrub error report is pretty long:

 BTRFS error (device dm-2): unable to fixup (regular) error at logical 13647872 on dev /dev/mapper/test-scratch1 physical 13647872
 BTRFS warning (device dm-2): checksum error at logical 13647872 on dev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset 16384, length 4096, links 1 (path: file1)

Since we have so many things to output, it's not a surprise we got long
error lines.

To make the lines a little shorter, and make important info more
obvious, change the unify output to something like this:

 BTRFS error (device dm-2): unable to fixup (regular) error at logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
 BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fileoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872

The idea is, to put large values/small values/string separated meanwhile
skip the some descriptor directly:

- "logical LOGICAL(MIRROR)"
  LOGICAL is always a large value, meanwhile MIRROR is always a single
  digit.
  Thus combining them together, human can still split them instinctively.

- "physical DEVID(DEVPATH)PHYSICAL"
  DEVID is normally a short number, DEVPATH is a long string, and PHYSICAL
  is a normally a large number.
  And for most end users, the most important device path is still easy
  to catch, even surrounded by some large numbers.

- inode ROOT/INO(PATH)
  To locate a btrfs inode, we have to provide both root and inode
  number. Normally ROOT should be a much smaller number (3 digits)
  meanwhile the INO can be pretty large.

  However for the end user, the most important thing is the PATH, which
  is still not hard to locate.

Any better ideas would be appreciated to make those lines shorter.

However what we really need is a proper way to report all those info
(maybe put the file/dev name resolution into the user space) to user
space reliably (without rate limit).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 55 +++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 18b2ee3b1616..17e492076bf8 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -226,6 +226,7 @@ struct scrub_warning {
 	u64			physical;
 	u64			logical;
 	struct btrfs_device	*dev;
+	int			mirror_num;
 };
 
 static void release_scrub_stripe(struct scrub_stripe *stripe)
@@ -427,12 +428,12 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 */
 	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
 		btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, path: %s",
-				  swarn->errstr, swarn->logical,
-				  btrfs_dev_name(swarn->dev),
-				  swarn->physical,
-				  root, inum, offset,
-				  (char *)(unsigned long)ipath->fspath->val[i]);
+"%s at inode %lld/%llu(%s) fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
+				  swarn->errstr, root, inum,
+				  (char *)ipath->fspath->val[i], offset,
+				  swarn->logical, swarn->mirror_num,
+				  swarn->dev->devid, btrfs_dev_name(swarn->dev),
+				  swarn->physical);
 
 	btrfs_put_root(local_root);
 	free_ipath(ipath);
@@ -440,18 +441,17 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 
 err:
 	btrfs_warn_in_rcu(fs_info,
-			  "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
-			  swarn->errstr, swarn->logical,
-			  btrfs_dev_name(swarn->dev),
-			  swarn->physical,
-			  root, inum, offset, ret);
-
+	"%s at inode %lld/%llu fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
+			  swarn->errstr, root, inum, offset,
+			  swarn->logical, swarn->mirror_num,
+			  swarn->dev->devid, btrfs_dev_name(swarn->dev),
+			  swarn->physical);
 	free_ipath(ipath);
 	return 0;
 }
 
 static void scrub_print_common_warning(const char *errstr, struct btrfs_device *dev,
-				       u64 logical, u64 physical)
+				       u64 logical, u64 physical, int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
 	struct btrfs_path *path;
@@ -471,6 +471,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	swarn.logical = logical;
 	swarn.errstr = errstr;
 	swarn.dev = NULL;
+	swarn.mirror_num = mirror_num;
 
 	ret = extent_from_logical(fs_info, swarn.logical, path, &found_key,
 				  &flags);
@@ -501,10 +502,11 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 			if (ret > 0)
 				break;
 			btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
-				errstr, swarn.logical, btrfs_dev_name(dev),
-				swarn.physical, (ref_level ? "node" : "leaf"),
-				ref_level, ref_root);
+"%s at metadata in tree %llu(%u), logical %llu(%u) physical %llu(%s)%llu",
+				errstr, ref_root, ref_level,
+				swarn.logical, swarn.mirror_num,
+				dev->devid, btrfs_dev_name(dev),
+				swarn.physical);
 		}
 		btrfs_release_path(path);
 	} else {
@@ -879,27 +881,32 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		 */
 		if (repaired) {
 			btrfs_err_rl_in_rcu(fs_info,
-			"fixed up error at logical %llu on dev %s physical %llu",
-					    logical, btrfs_dev_name(dev),
+			"fixed up error at logical %llu(%u) physical %llu(%s)%llu",
+					    logical, stripe->mirror_num,
+					    dev->devid, btrfs_dev_name(dev),
 					    physical);
 			continue;
 		}
 
 		/* The remaining are all for unrepaired. */
 		btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
-					    logical, btrfs_dev_name(dev),
+	"unable to fixup (regular) error at logical %llu(%u) physical %llu(%s)%llu",
+					    logical, stripe->mirror_num,
+					    dev->devid, btrfs_dev_name(dev),
 					    physical);
 
 		if (test_bit(sector_nr, &stripe->io_error_bitmap))
 			scrub_print_common_warning("i/o error", dev,
-						     logical, physical);
+						     logical, physical,
+						     stripe->mirror_num);
 		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
 			scrub_print_common_warning("checksum error", dev,
-						     logical, physical);
+						     logical, physical,
+						     stripe->mirror_num);
 		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
 			scrub_print_common_warning("header error", dev,
-						     logical, physical);
+						     logical, physical,
+						     stripe->mirror_num);
 	}
 
 	spin_lock(&sctx->stat_lock);
-- 
2.44.0


