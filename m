Return-Path: <linux-btrfs+bounces-7467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A15495D976
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 01:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F411C21A61
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 23:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492B1C8FD8;
	Fri, 23 Aug 2024 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="km/HYtJL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BzZaYrLS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246E5695;
	Fri, 23 Aug 2024 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454138; cv=none; b=nmDs3rRmqrSfDmpzc77V3EAmpr/AjukPy6idJQHOza9G8DepL1pRlK29fygU0GBiEMrrkfzKTKQLcW2RCS0RvM+nlunm7meFWClCOu1hIYaQ0IYqoWuFUgMgdpnWCWHMhnV0gnoOSnO9hybfEPV4KVbIgPjuA5cJMRXu+V3PDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454138; c=relaxed/simple;
	bh=YBIswP1wr3CI6OKRGG+VpRgzNCammQSE0PfqXiMRIkI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gq5RoiT2WHwCLdipVTLsMk5VL8exxmRDAzYot+rqJSGbwuhCo+2lisfslHXH9kReIZXdvUUGQ/AISQMOOAXtdLCJCb2xmYEbzmOZ5DE/r0l0sTJ7N9wwuf+ZcXrbzzCDILhBltEFo2LiEVS63+YAPfQAlBf4spcOU7JzbyEQ4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=km/HYtJL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BzZaYrLS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C0B6225E4;
	Fri, 23 Aug 2024 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724454133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OZWEoTV/eQAm24TDQV0lqdDKuZH2y4GN305qwdozOGE=;
	b=km/HYtJLdQ/a7yvOrJ9k1euZaCvFPMQCOtENuf/vNnhwT+Z2RIxXx879mdZ7qgvXaMhFzN
	IrzBYak+sTIxE41ZClhiTMry21sHkbXEFCZUdMpTa1NkOnFMnPuGSbVewuavb7tyvMwwds
	VvCuZJ8mtsx8XzaHz/n4Eu2hk0vhFB4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BzZaYrLS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724454132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OZWEoTV/eQAm24TDQV0lqdDKuZH2y4GN305qwdozOGE=;
	b=BzZaYrLSUoV+iYLD346R1Tdv0M6Lih/ndYNINWv5Jhe/DSM1lLkeTy52wrOY4aJN7iCUoq
	n8l65u+HD+cE7HwgHzG0+9E+HSK/2BUWnZQRiJ6wqw6eC2Vz4AUGjSHI0znrY9ktagxxlQ
	TG3ze2eyvoDCWVHJJNgxJSx3AYt0G4I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 210081333E;
	Fri, 23 Aug 2024 23:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QwFwNfIUyWYyBAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 23 Aug 2024 23:02:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/125: do not use raid5 for metadata
Date: Sat, 24 Aug 2024 08:31:45 +0930
Message-ID: <b39ba0c9a496b0ceaa940f4b1e3faf94a4256baf.1724454084.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C0B6225E4
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

[BUG]
There are several bug reports of btrfs/125 failure recently, either
causing balance failure (-EIO), or even kernel crash.

The balance failure looks like this:

     Mount normal and balance
    +ERROR: error during balancing '/mnt/scratch': Input/output error
    +There may be more info in syslog - try dmesg | tail
    +md5sum: /mnt/scratch/tf2: Input/output error

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

   Furthermore this is very hard to fix, unlike data we can fetch the
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
   freeing of a bio, leading to crash when hitting the race window.

   Thankfully the patch has been sent to the mailing list.

[WORKAROUND]
Since it's very hard to fix the RAID56 metadata problem without a
deadlock or a huge code rework, for now just use RAID1 for the metadata
of this particular test case.

There may be a chance to fix the situation by properly marking the
missing-then-reappear device as out-of-date, so no direct read from that
device.

But that will also be a huge new feature, not something can be done
immediately.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/125 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 31379d81ef73..c8c0dd422f72 100755
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


