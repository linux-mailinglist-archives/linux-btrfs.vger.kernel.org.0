Return-Path: <linux-btrfs+bounces-19384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A112C90312
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 22:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B942F4E26AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723252D9ED1;
	Thu, 27 Nov 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tuSH50Ti";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="umsAtYqa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76203B2A0
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279079; cv=none; b=Cg0wplRnwu5OvM+6/PMMLgdIWHw3y3tf+5lxx+i9SW/ZTObBXw0FHid1/e2ZFYnoYuZTYjnbQiIvEEK6OjiBUl9xTFuYggyGHZ0FGqnub0FJ8AYxN6yswhtADIPHfvldvh0JSrHM01WkL6GLge2SSXidC4NpE3Zo51jOV5e7WrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279079; c=relaxed/simple;
	bh=/4UE36Sz3kNKRB/apTfuUAuDjKxDMQHFLCue0Bz04gc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nyJeeIHrc50s5m8+eFCBpwn/YbOUDYwaFXq6zoMPUowYPOn7TdnuvsU/PTwKeF4fziqF2SrQuX5ya3S9H3Ny7d9GUGq40JN+HUyjWxqU6wgUMouObrrZUUKoFyOt2YBv7433mOSDVngI5I+151z/z74yl4UIukWCouQdm9hlJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tuSH50Ti; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=umsAtYqa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF952336A2;
	Thu, 27 Nov 2025 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764279075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBm75b9fuEFjxW5+F2I/HB72fedVhrmICKQrCWumHvI=;
	b=tuSH50TiMVeH1GAVbwVI+B/mxKa6szzPpGjpxIM9NT0WEFGCdNEsmqIyvoMoIWcCGJflHh
	OKNtoVzBHC9OytZgjAPzAZAl2coz2AGbDmbejQ9TFdNgr7+eld5CtMe5/51nusIa62iyXe
	3bzUnlyY+F0HH5DKtaw1oYkkoq99HUk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=umsAtYqa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764279074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBm75b9fuEFjxW5+F2I/HB72fedVhrmICKQrCWumHvI=;
	b=umsAtYqaVy84RLHGGhh8jZQMoJO1aUjipKrb1+5inL89QD9ufBpamkUGj4cHe0DkeUyOYM
	3ki4C7AUSe6Z6dv1Etr6r2/KoH0tbXV4B+vFtjP1xDvqHAGdnUruZJ8LaGRrHS7q+ruMRw
	Wf0Z0e4GhU3FVAMboxhpdQ0wAyGvXyY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1AB03EA63;
	Thu, 27 Nov 2025 21:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xH2mHCHDKGn9IwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 27 Nov 2025 21:31:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/746: skip if btrfs' new block-group-tree is involved
Date: Fri, 28 Nov 2025 08:00:52 +1030
Message-ID: <20251127213052.15859-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AF952336A2

[FALSE ALERT]
The test case will fail on btrfs if the new block-group-tree feature is
enabled:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-rc6-custom+ #321 SMP PREEMPT_DYNAMIC Sun Nov 23 16:34:33 ACDT 2025
MKFS_OPTIONS  -- -O block-group-tree /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

generic/746 44s ... [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/746.out.bad)
    --- tests/generic/746.out	2024-06-27 13:55:51.286338519 +0930
    +++ xfstests-dev/results//generic/746.out.bad	2025-11-28 07:47:17.039827837 +1030
    @@ -2,4 +2,4 @@
     Generating garbage on loop...done.
     Running fstrim...done.
     Detecting interesting holes in image...done.
    -Comparing holes to the reported space from FS...done.
    +Comparing holes to the reported space from FS...Sectors 256-2111 are not marked as free!
    ...
    (Run 'diff -u xfstests-dev/tests/generic/746.out xfstests-dev/results//generic/746.out.bad'  to see the entire diff)

[CAUSE]
Sectors [256, 2048) are the reserved 1M free space.
Sectors [2048, 2112) are the leading free space in the chunk tree.
Sectors [2112, 1244) is the first tree block in the chunk tree.

The reported free sectors from get_free_sectors() looks like this:

  2144 10566
  10688 11711
  ...

Note that there should be a free sector range in [2048, 2122) but it's
not reported in get_free_sectors().

The get_free_sectors() call is fs dependent, and for btrfs it's using
parse-extent-tree.awk script to handle the extent tree dump.

The script uses BLOCK_GROUP_ITEM items to detect the beginning of a
block group so that it can calculate the hole between the bginning of a
block group and the first data/metadata item.

However block-group-tree feature moves BLOCK_GROUP_ITEM items to a
dedicated tree, making the existing script unable to parse the free
space at the beginning of a block group.

[FIX]
For block-group-tree feature, we need to parse both block group tree and
extent tree and do cross-reference.
It is not that simple to do in a single awk script, so unfortunately
skip the test if the btrfs has block-group-tree feature enabled.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/746 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/generic/746 b/tests/generic/746
index 6f02b1cc..c62fdbc9 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -162,6 +162,18 @@ mkdir $loop_mnt
 _mkfs_dev $loop_dev
 _mount $loop_dev $loop_mnt
 
+# The new block-group-tree will feature screw up the extent tree parsing, as
+# there is no more block group item in that tree to mark the start
+# of a block group, causing the free space between the beginning of bg
+# and the first data/metadata block not counted as free space.
+# So reject fs with block-group-tree feature for now.
+if [ $FSTYP = "btrfs" ]; then
+	if $BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev |\
+		grep -q BLOCK_GROUP_TREE; then
+		_notrun "No support for block-group-tree extent tree parsing yet"
+	fi
+fi
+
 echo -n "Generating garbage on loop..."
 # Goal is to fill it up, ignore any errors.
 for i in `seq 1 10`; do
-- 
2.51.2


