Return-Path: <linux-btrfs+bounces-7530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583FB95FD72
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98A81F235A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2461A0712;
	Mon, 26 Aug 2024 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZNBcjZfI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sn4KPvKI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56519D07B;
	Mon, 26 Aug 2024 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712456; cv=none; b=SvAb92mA5lnMnEk57lDyXdRM125eQI9aca2slQ3d8exndYzT2u5L2oHDxIHSbLgqHYcUcryU8t3H8kgfXFPON4xtwzGffZMOryOVryVxMb2PPzeh88Z0UKu1wxcIeGKFuBK2iwCp5rd6v6KDwnasdbSWY6t4BO+GZOwT2mcMmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712456; c=relaxed/simple;
	bh=acmLaQghCWHJkgCN1F81wTRDNj40GOGDzfLTFF9Im4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfQnlOteF7uHqcUwJX8MsyzrWBhlenIKiqpmIo785lBxPmvaNFoqNjFoYh3KcWEnNua1CKUl0GQilhIwfUtmktbiS5wdsDSG6uyr7bmUHDJ8tJitSV018P+IizAUzNkZuEDpu1ilzIj97Rjx2l3yppYChr/8Ki7E9oXcQLdIYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZNBcjZfI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sn4KPvKI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA38221997;
	Mon, 26 Aug 2024 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724712452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xtRDyhTd4mtm4s6AmWEzPG2y7hu+27we2igLdfn6l3g=;
	b=ZNBcjZfI0sVseb/p926cxxLk9ocg1C+rtJ9KY69VZmzhMc6F6W253RUJtzKCcfBXk6gMmY
	Q+kUFJPcixZ+8Bf54EHAVzFRtEOQoH+asQzKVieywxHR+f/Zdby86jT3J8roZ709kg4wHh
	aO4R6WUweNz3y7ppX8t4miOb+jKNu7Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Sn4KPvKI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724712451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xtRDyhTd4mtm4s6AmWEzPG2y7hu+27we2igLdfn6l3g=;
	b=Sn4KPvKIiG2LMeCG9/JyH7KhwzOv1fUqw6jKxCLWDk41Vu0PNnUi/WQlAYYaz1aKLtT/vJ
	R+DEuQ6KbaJCnky+G7hLt6+0HJrGgalyvR5u+wuq4RxezgsPGiZP/HHnNC0uVFE9BZS1th
	8VOBBzykk2V2R2VjNW8j2kGdjt190XI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9937E13724;
	Mon, 26 Aug 2024 22:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S3ObFgIGzWZsbQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 26 Aug 2024 22:47:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] fstests: btrfs/125: do not use raid5 for metadata
Date: Tue, 27 Aug 2024 08:17:08 +0930
Message-ID: <20240826224708.9322-1-wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA38221997
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There are several bug reports of btrfs/125 failure recently, either
causing balance failure (-EIO), or even kernel crash.

The balance failure looks like this:

     Mount normal and balance
    +ERROR: error during balancing '/mnt/scratch': Input/output error
    +There may be more info in syslog - try dmesg | tail
    +md5sum: /mnt/scratch/tf2: Input/output error

The test case btrfs/125 is not reliable in the past, and has been
discussed several times:

https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com/
https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com/#t

[CAUSE]
There are several different factors involved.

1. RMW mix the old and new metadata, causing unrepairable corruption
   E.g. with the following layout:

   data 1   |<- Stale metadata ->| (from the out-of-date device)
   data 2   |     Unused         |
   parity   |PPPPPPPPPPPPPPPPPPPP|

   In above case, although metadata on data 1 is out-of-date, we can
   still rebuild the correct data from parity and data 2.

   But if we have new metadata writes into the data 2 stripe, an RMW
   will screw up the whole situation:

   data 1   |<- Stale metadata ->| (from the out-of-date device)
   data 2   |<-  New metadata  ->|
   parity   |XXXXXXXXXXXXXXXXXXXX|

   The RMW will use the stale metadata and new metadata to calculate new
   parity.
   The resulted new parity will no longer be able to recover the old
   data 1.

   This is a known bug, thus our documentation is already recommending
   to avoid RAID56 for metadata usage.

   > Metadata
   >    Do not use raid5 nor raid6 for metadata. Use raid1 or raid1c3
   >    respectively.

   And this is very hard to fix, unlike data we can fetch the
   data csum and verify during RMW, we can not do that during RMW.

   At the timing of RMW, we're holding the rbio lock for the full
   stripe.
   If the extent tree search requires a read-recover, it will generate
   another rbio, which may cover the same full stripe we're working on,
   leading to a deadlock.

   Furthermore the current RAID56 repair code is all based on veritical
   sectors, but metadata can cross several horizontal sectors.
   This will require multiple combinations to repair a metadata.

2. Crash caused by double freeing a bio
   By chance if the above RMW corrupted csum tree, then during
   btrfs_submit_chunk() we will hit an error path that leads to double
   freeing of a bio, resulting crash or a KASAN report.

   Thankfully the patch fixing the use-after-free is already sent to the
   mailing list:
   https://lore.kernel.org/linux-btrfs/f4f916352ddf3f80048567ec7d8cc64cb388dc09.1724493430.git.wqu@suse.com/

[WORKAROUND]
Since it's very hard to fix the RAID56 metadata problem without a
deadlock or a huge code rework, for now just use RAID1 for the metadata
of this particular test case.

There may be a chance to fix the situation by properly marking the
missing-then-reappear device as out-of-date, so no direct read from that
device.

But that will also be a huge new feature, not something can be done
immediately.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add links to the past discussion of the btrfs/125 failure
- Add a link to the kernel fix of the use-after-free bug
---
 tests/btrfs/125 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 31379d81..c8c0dd42 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -70,7 +70,7 @@ count=$(($max_fs_sz / 1000000))
 echo >> $seqres.full
 echo "max_fs_sz=$max_fs_sz count=$count" >> $seqres.full
 echo "-----Initialize -----" >> $seqres.full
-_scratch_pool_mkfs "-mraid5 -draid5" >> $seqres.full 2>&1
+_scratch_pool_mkfs "-mraid1 -draid5" >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 dd if=/dev/zero of="$SCRATCH_MNT"/tf1 bs=$bs count=1 \
 					>>$seqres.full 2>&1
-- 
2.46.0


