Return-Path: <linux-btrfs+bounces-9581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C09C6B7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A81F221EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854F1F80B0;
	Wed, 13 Nov 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A4hod0T2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A4hod0T2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681861F77AC;
	Wed, 13 Nov 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490126; cv=none; b=o6jbQXv6XZseLfhJwYpOca2Ad4rOPwE9gnqSnz72IpCF5r3rXMksWUYwontCKPvxO04g4yRffka63AIuWKUfnVoXqyM1fhivMoypH3CsS+GGn9mjWRabC7TrXxvfNnndjWNhuhjPEH269BXkMAUm8bf0kKDWSWt3mmpLcXyHzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490126; c=relaxed/simple;
	bh=5gt8XkXUYqnkxG+CwMYCglGgFYKYwdIdc1TKuuEomFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYnzkzYolp+04RmzbjXQnVxcMpqnKiK6VxeiKaZkmz+zidrV8ktBc1FKUCIluFsLSeiveyCHQdxll4oXxAKbJhnvRsqIKewkp8VL11QpHWQkPYZpSfobhA6syGlQWliVMkZ1LIfNp2BpO1S7rk9qEhRh4zIIeOpR3wEoxLpDbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A4hod0T2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A4hod0T2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5872D211CB;
	Wed, 13 Nov 2024 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731490122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KeZBkkLCYZg6ijurIbQM0TSw08aecwzuFa9UDon1GLI=;
	b=A4hod0T2gALWeJ44fJGno7AjailAFrIffNYY6Fritden9CNBT3HEGOQwunhNIbxNNbh8Vx
	F44wmPTBbt9s5q5VAZkxc19USW32CNIXGnJHXyhr8O7fCUbQG3ujQcZ0nJNv/J7G8s8rXf
	7RnhHh/pzQ3lm3GSSH1dCxZ7/Unc+Dw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=A4hod0T2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731490122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KeZBkkLCYZg6ijurIbQM0TSw08aecwzuFa9UDon1GLI=;
	b=A4hod0T2gALWeJ44fJGno7AjailAFrIffNYY6Fritden9CNBT3HEGOQwunhNIbxNNbh8Vx
	F44wmPTBbt9s5q5VAZkxc19USW32CNIXGnJHXyhr8O7fCUbQG3ujQcZ0nJNv/J7G8s8rXf
	7RnhHh/pzQ3lm3GSSH1dCxZ7/Unc+Dw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A18D13301;
	Wed, 13 Nov 2024 09:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OtfVLkhxNGdFegAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 13 Nov 2024 09:28:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Long An <lan@suse.com>
Subject: [PATCH] btrfs/321: make the filter to handle older btrfs-progs
Date: Wed, 13 Nov 2024 19:58:38 +1030
Message-ID: <20241113092838.302247-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5872D211CB
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[FALSE ALERT]
With much older distros like SLE12SP5, which is using btrfs-progs 4.5.3,
test case btrfs/321 fails like this:

 btrfs/321       QA output created by 321
 unable to locate the last csum tree leaf
 (see /opt/xfstests/results//btrfs/321.full for details)
 [failed, exit status 1]- output mismatch (see /opt/xfstests/results//btrfs/321.out.bad)
     --- tests/btrfs/321.out	2024-10-28 07:03:54.000000000 -0400
     +++ /opt/xfstests/results//btrfs/321.out.bad	2024-11-07 09:33:58.238442033 -0500
     @@ -1,2 +1,3 @@
      QA output created by 321
     -Silence is golden
     +unable to locate the last csum tree leaf
     +(see /opt/xfstests/results//btrfs/321.full for details)
     ...
     (Run diff -u /opt/xfstests/tests/btrfs/321.out /opt/xfstests/results//btrfs/321.out.bad  to see the entire diff)

[CAUSE]
The full output shows the regular csum tree as usual:

 btrfs-progs v4.5.3+20160729
 checksum tree key (CSUM_TREE ROOT_ITEM 0)
 node 4247552 level 1 items 9 free 112 generation 7 owner 7
 fs uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48
 chunk uuid 0af5a7bd-d2d8-4146-ada8-444f2a2f5351
 	key (EXTENT_CSUM EXTENT_CSUM 20971520) block 4243456 (1036) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 25006080) block 4251648 (1038) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 29040640) block 4255744 (1039) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 33075200) block 4259840 (1040) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 37109760) block 4263936 (1041) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 41144320) block 4268032 (1042) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 45178880) block 4272128 (1043) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 49213440) block 4276224 (1044) gen 7
 	key (EXTENT_CSUM EXTENT_CSUM 53248000) block 4280320 (1045) gen 7
 leaf 4243456 items 1 free space 30 generation 7 owner 7
 fs uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48
 chunk uuid 0af5a7bd-d2d8-4146-ada8-444f2a2f5351
 	item 0 key (EXTENT_CSUM EXTENT_CSUM 20971520) itemoff 55 itemsize 3940
 		extent csum item
 [...]
 leaf 4280320 items 1 free space 2722 generation 7 owner 7
 fs uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48
 chunk uuid 0af5a7bd-d2d8-4146-ada8-444f2a2f5351
 	item 0 key (EXTENT_CSUM EXTENT_CSUM 53248000) itemoff 2747 itemsize 1248
 		extent csum item
 total bytes 25768755200
 bytes used 34213888
 uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48

But notice the header for each leaf, there is no flags for the leaf.
On newer btrfs-progs, the leaf header lines looks like this:

 leaf 5423104 items 1 free space 2918 generation 7 owner CSUM_TREE
 leaf 5423104 flags 0x1(WRITTEN) backref revision 1

It's two lines, not the old one line output.
The new behavior is introduced in btrfs-progs commit 9cc9c9ab3220
("btrfs-progs: print the eb flags for nodes as well"), included by v5.10
release.

So the test case doesn't handle older output format and failed to locate
the target leaf.

[FIX]
Instead of relying on the leaf flags line, use the much older
"leaf <bytenr> items" line as the filter target, so we can support much
older distros.

Reported-by: Long An <lan@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1233303
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/321 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/321 b/tests/btrfs/321
index c13ccc1e..35caade6 100755
--- a/tests/btrfs/321
+++ b/tests/btrfs/321
@@ -43,7 +43,7 @@ _scratch_unmount
 
 # Search for the last leaf of the csum tree, that will be the target to destroy.
 $BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRATCH_DEV >> $seqres.full
-target_bytenr=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRATCH_DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
+target_bytenr=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRATCH_DEV | grep "^leaf.*items" | sort | tail -n1 | cut -f2 -d\ )
 
 if [ -z "$target_bytenr" ]; then
 	_fail "unable to locate the last csum tree leaf"
-- 
2.46.0


