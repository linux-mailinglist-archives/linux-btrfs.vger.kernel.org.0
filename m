Return-Path: <linux-btrfs+bounces-3279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70D87BABD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1971C2154F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797AA6E5F7;
	Thu, 14 Mar 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZoeqAcoe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZoeqAcoe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FB6E2B3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409838; cv=none; b=HfIu9tWtCZ00VrHlFFRnqSmdJ4PPWTlGV8Q+lYXBvY2+vB70+TQNYw7FUC1u/5+bxH7EVvb4dbKBg2ebCvTN/SMl1IIeOjPLXqDV37QBzs6h9uypLcJvmSAPaMh1o7Fnkd8KO2c0+3j+Qku073aaNJmXk5NllOSuAPvIPCDDY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409838; c=relaxed/simple;
	bh=o7Gygh7DWWIXAhlOhncYNWXP2YwNMDqcJeOyq251fsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar5oedNYUrGPfCQyn9wSGnyEp7xq8QdpFVtMVy8pR4/OURhtzxGDs4ufOlDEnmRcxqpwgPO4/WSRpvs1ZClNJ6luYteN3U9V8acAR/FwR/OXBI6n+7zi+susFkvGrrglDhKAw/tMpK6XGEQpNn0dY2iTUBtIlxk2Cuw1Hb0mKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZoeqAcoe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZoeqAcoe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08D261F843
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puiifkLJeICjyp3ZNhV/zQpqmNW6l/R6sB0dTggzZCk=;
	b=ZoeqAcoec9t8mgM70DWvZV1qvfVPTZXv2uIk8C1vf+2OQG3uC1VFhQ3PmPQnFpkfSmuubZ
	Bz3VIMCoQAC0ccl+p7tHkiTOKBAJTbU2l+hKR90pSsttTd3OCZNL08AbVBsXEQNGJyQ3sa
	S0fIE85jpBCvamBLJZqqKGu8TjesEvk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puiifkLJeICjyp3ZNhV/zQpqmNW6l/R6sB0dTggzZCk=;
	b=ZoeqAcoec9t8mgM70DWvZV1qvfVPTZXv2uIk8C1vf+2OQG3uC1VFhQ3PmPQnFpkfSmuubZ
	Bz3VIMCoQAC0ccl+p7tHkiTOKBAJTbU2l+hKR90pSsttTd3OCZNL08AbVBsXEQNGJyQ3sa
	S0fIE85jpBCvamBLJZqqKGu8TjesEvk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 154051386D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0H15LmnI8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: scrub: fix the frequency of error messages
Date: Thu, 14 Mar 2024 20:20:20 +1030
Message-ID: <c46343633e6198f315876179d31b3a66b66a8aa2.1710409033.git.wqu@suse.com>
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
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZoeqAcoe
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim,swarn.dev:url];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: 08D261F843
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

For btrfs scrub error messages, I have hit a lot of support cases on
older kernels where no filename is outputted at all, with only error
messages like:

 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2823, gen 0
 BTRFS error (device dm-0): unable to fixup (regular) error at logical 1563504640 on dev /dev/mapper/sys-rootlv
 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2824, gen 0
 BTRFS error (device dm-0): unable to fixup (regular) error at logical 1579016192 on dev /dev/mapper/sys-rootlv
 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2825, gen 0

The "unable to fixup (regular) error" line shows we hit an unrepairable
error, then normally we would do data/metadata backref walk to grab the
correct info.

But we can hit cases like the inode is already orphan (unlinked from any
parent inode), or even the subvolume is orphan (unlinked and waiting to
be deleted).

In that case we're not sure what's the proper way to continue (Is it
some critical data/metadata? Would it prevent the system from booting?)

To improve the situation, this patch would:

- Ensure we at least output one message for each unrepairable error
  If by somehow we didn't output any error message for the error, we
  always fallback to the basic logical/physical error output, with its
  type (data or metadata).

- Remove the "unable to fixup" error message
  Since we have ensured at least one error message is outputted for each
  unrepairable corruption, there is no need for that fallback one.

Now one unrepairable corruption would output a more refined and less
duplicated error message:

 BTRFS info (device dm-2): scrub: started on devid 1
 BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fileoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
 BTRFS info (device dm-2): scrub: finished on devid 1 with status: 0

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 17e492076bf8..84617a64b2d4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -227,6 +227,7 @@ struct scrub_warning {
 	u64			logical;
 	struct btrfs_device	*dev;
 	int			mirror_num;
+	bool			message_printed;
 };
 
 static void release_scrub_stripe(struct scrub_stripe *stripe)
@@ -426,26 +427,29 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 * we deliberately ignore the bit ipath might have been too small to
 	 * hold all of the paths here
 	 */
-	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
-		btrfs_warn_in_rcu(fs_info,
+	for (i = 0; i < ipath->fspath->elem_cnt; ++i) {
+		btrfs_warn_rl_in_rcu(fs_info,
 "%s at inode %lld/%llu(%s) fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
 				  swarn->errstr, root, inum,
 				  (char *)ipath->fspath->val[i], offset,
 				  swarn->logical, swarn->mirror_num,
 				  swarn->dev->devid, btrfs_dev_name(swarn->dev),
 				  swarn->physical);
+		swarn->message_printed = true;
+	}
 
 	btrfs_put_root(local_root);
 	free_ipath(ipath);
 	return 0;
 
 err:
-	btrfs_warn_in_rcu(fs_info,
+	btrfs_warn_rl_in_rcu(fs_info,
 	"%s at inode %lld/%llu fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
 			  swarn->errstr, root, inum, offset,
 			  swarn->logical, swarn->mirror_num,
 			  swarn->dev->devid, btrfs_dev_name(swarn->dev),
 			  swarn->physical);
+	swarn->message_printed = true;
 	free_ipath(ipath);
 	return 0;
 }
@@ -472,6 +476,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	swarn.errstr = errstr;
 	swarn.dev = NULL;
 	swarn.mirror_num = mirror_num;
+	swarn.message_printed = false;
 
 	ret = extent_from_logical(fs_info, swarn.logical, path, &found_key,
 				  &flags);
@@ -488,26 +493,31 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 		unsigned long ptr = 0;
 		u8 ref_level;
 		u64 ref_root;
+		bool message_printed = false;
 
 		while (true) {
 			ret = tree_backref_for_extent(&ptr, eb, &found_key, ei,
 						      item_size, &ref_root,
 						      &ref_level);
-			if (ret < 0) {
-				btrfs_warn(fs_info,
-				"failed to resolve tree backref for logical %llu: %d",
-						  swarn.logical, ret);
+			if (ret < 0)
 				break;
-			}
 			if (ret > 0)
 				break;
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn_rl_in_rcu(fs_info,
 "%s at metadata in tree %llu(%u), logical %llu(%u) physical %llu(%s)%llu",
 				errstr, ref_root, ref_level,
 				swarn.logical, swarn.mirror_num,
 				dev->devid, btrfs_dev_name(dev),
 				swarn.physical);
+			message_printed = true;
 		}
+		if (!message_printed)
+			btrfs_warn_rl_in_rcu(fs_info,
+"%s at metadata, logical %llu(%u) physical %llu(%s)%llu",
+				errstr, swarn.logical, swarn.mirror_num,
+				dev->devid, btrfs_dev_name(dev),
+				swarn.physical);
+
 		btrfs_release_path(path);
 	} else {
 		struct btrfs_backref_walk_ctx ctx = { 0 };
@@ -522,8 +532,14 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 		swarn.dev = dev;
 
 		iterate_extent_inodes(&ctx, true, scrub_print_warning_inode, &swarn);
+		if (!swarn.message_printed) {
+			btrfs_warn_rl_in_rcu(fs_info,
+"%s at data, unresolved path name, logical %llu(%u) physical %llu(%s)%llu",
+				errstr, swarn.logical, swarn.mirror_num,
+				dev->devid, btrfs_dev_name(dev),
+				swarn.physical);
+		}
 	}
-
 out:
 	btrfs_free_path(path);
 }
@@ -889,12 +905,6 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		}
 
 		/* The remaining are all for unrepaired. */
-		btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu(%u) physical %llu(%s)%llu",
-					    logical, stripe->mirror_num,
-					    dev->devid, btrfs_dev_name(dev),
-					    physical);
-
 		if (test_bit(sector_nr, &stripe->io_error_bitmap))
 			scrub_print_common_warning("i/o error", dev,
 						     logical, physical,
-- 
2.44.0


