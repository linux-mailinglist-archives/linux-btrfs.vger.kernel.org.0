Return-Path: <linux-btrfs+bounces-1269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BAF824F35
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 08:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3811C218BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0D20B2D;
	Fri,  5 Jan 2024 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rWkw/YAc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rWkw/YAc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BF20B09
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 55E5E1F890;
	Fri,  5 Jan 2024 07:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704440049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8DYpm6ubSoI24iqyJ+wodYOc0HIsN0f7vobbfL7yULw=;
	b=rWkw/YAcIm0exsPZU+C3HMZbG/rMhhojChQcTNwhQqc0H5vAaKMa2M6Z2Jx8nctQFdYafy
	tt6rU1anAR2xW+UNhyJVuYQnaDv23uja35NmZwrZu5jcPoy/lK290OEM43noiLZeH39CW6
	/PK1eoGfAuxDGW7xKFGFclFAAdkoi6E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704440049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8DYpm6ubSoI24iqyJ+wodYOc0HIsN0f7vobbfL7yULw=;
	b=rWkw/YAcIm0exsPZU+C3HMZbG/rMhhojChQcTNwhQqc0H5vAaKMa2M6Z2Jx8nctQFdYafy
	tt6rU1anAR2xW+UNhyJVuYQnaDv23uja35NmZwrZu5jcPoy/lK290OEM43noiLZeH39CW6
	/PK1eoGfAuxDGW7xKFGFclFAAdkoi6E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCA0113C99;
	Fri,  5 Jan 2024 07:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OMP0Fe+wl2VaLwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 05 Jan 2024 07:34:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Anton Mitterer <calestyo@scientia.org>
Subject: [PATCH] btrfs: defrag: add under utilized extent to defrag target list
Date: Fri,  5 Jan 2024 18:03:40 +1030
Message-ID: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[scientia.org:email,suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.70

[BUG]
The following script can lead to a very under utilized extent and we
have no way to use defrag to properly reclaim its wasted space:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
  # sync
  # btrfs filesystem defrag $mnt/foobar
  # sync

After the above operations, the file "foobar" is still utilizing the
whole 128M:

        item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
                generation 7 transid 8 size 4096 nbytes 4096
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 32770 flags 0x0(none)
        item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
                index 2 namelen 4 name: file
        item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
                generation 7 type 1 (regular)
                extent data disk byte 298844160 nr 134217728 <<<
                extent data offset 0 nr 4096 ram 134217728
                extent compression 0 (none)

Meaning the expected defrag way to reclaim the space is not working.

[CAUSE]
The file extent has no adjacent extent at all, thus all existing defrag
code consider it a perfectly good file extent, even if it's only
utilizing a very tiny amount of space.

[FIX]
Add a special handling for under utilized extents, currently the ratio
is 6.25% (1/16).

This would allow us to add such extent to our defrag target list,
resulting it to be properly defragged.

Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index c276b136ab63..cc319190b6fb 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1070,6 +1070,17 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (!next_mergeable) {
 			struct defrag_target_range *last;
 
+			/*
+			 * Special entry point utilization ratio under 1/16 (only
+			 * referring 1/16 of an on-disk extent).
+			 * This can happen for a truncated large extent.
+			 * If we don't add them, then for a truncated file
+			 * (may be the last 4K of a 128M extent) it will never
+			 * be defraged.
+			 */
+			if (em->ram_bytes < em->orig_block_len / 16)
+				goto add;
+
 			/* Empty target list, no way to merge with last entry */
 			if (list_empty(target_list))
 				goto next;
-- 
2.43.0


