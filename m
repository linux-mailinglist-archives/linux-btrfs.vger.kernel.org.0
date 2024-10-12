Return-Path: <linux-btrfs+bounces-8872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37D99B178
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 09:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67037B21034
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693813CA8A;
	Sat, 12 Oct 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dm0S19Aq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dm0S19Aq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC5126BE1;
	Sat, 12 Oct 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717528; cv=none; b=ezAAnTaYHGbB0VSsaF32MuvvCzX5Cj+G/a/ZRccZEmjc96K49YznxTA0VkXuD0fuQfsALqaIZoWUFYbf1zzH0dx4vNQrtEtFog8/A0uQC2+X7XNwvrBWyIuS+f50KVft4rfURcfD4bTO4Vn3xRLgA7U/CYHQo9aP39oA50IO0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717528; c=relaxed/simple;
	bh=vocXvbaFptiy92uqXIWXfr/lle+8J8OxakpF2X/qI6o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OrsM38qkQL3fWN0t7MrSBUQlimfnN7na5rnm3basB3K2VDwyIINVBs7UsUceClj7fGRBVWkAnZP1Pz7ucr3CfdCln+FzCmku6trTmETJSJ8gqpDq6usvbp0dpG2DK+vh38as8mLESOW6vEwH+q1QKonDGl9GiXWPD0BbGp2Ikl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dm0S19Aq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dm0S19Aq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A4FF1FF1E;
	Sat, 12 Oct 2024 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728717523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6xDmYW996hVi7qp1KTb37TXogP68P+AYjEFMQxy5P9Q=;
	b=Dm0S19AqzdBDrBKCFDVDmuy/laPJ7y2xvDkic3t3pxakOA7Y0FVhuyPsx/4XOXqxJ8BwQA
	0ehhFfxGvfEtD/1I3QHHNaRKwz6yXS73RwYup9XySCz2c2zZaV5iNlMx523XC+YLqFbnDp
	s7qvQ2i+mDIrlL145jeO6SQjsSHPpbA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Dm0S19Aq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728717523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6xDmYW996hVi7qp1KTb37TXogP68P+AYjEFMQxy5P9Q=;
	b=Dm0S19AqzdBDrBKCFDVDmuy/laPJ7y2xvDkic3t3pxakOA7Y0FVhuyPsx/4XOXqxJ8BwQA
	0ehhFfxGvfEtD/1I3QHHNaRKwz6yXS73RwYup9XySCz2c2zZaV5iNlMx523XC+YLqFbnDp
	s7qvQ2i+mDIrlL145jeO6SQjsSHPpbA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ADF4136BA;
	Sat, 12 Oct 2024 07:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a3dfD9IiCmcbIQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 12 Oct 2024 07:18:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/002: fix the OOM caused by too large block size
Date: Sat, 12 Oct 2024 17:48:24 +1030
Message-ID: <20241012071824.124468-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A4FF1FF1E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
When running the test case btrfs/002, with 64K page size and 64K sector
size, and the VM doesn't have much memory (in my case 4G Vram), the test
case will trigger OOM and fail:

btrfs/002 4s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests-dev/results//btrfs/002.out.bad)
    --- tests/btrfs/002.out	2024-04-25 18:13:45.035555469 +0930
    +++ /home/adam/xfstests-dev/results//btrfs/002.out.bad	2024-10-12 17:19:48.785156223 +1030
    @@ -1,2 +1 @@
     QA output created by 002
    -Silence is golden
    ...

The OOM is triggered by the dd process, and a lot of dd processes are
using too much memory:

 dd invoked oom-killer: gfp_mask=0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), order=0, oom_score_adj=250
 CPU: 0 UID: 0 PID: 185764 Comm: dd Not tainted 6.12.0-rc2-custom+ #76
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 Tasks state (memory values in pages):
 [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
 [ 185665]     0 185665     8688     3840     3840        0         0   458752     4832           250 dd
 [ 185672]     0 185672     8688     2432     2432        0         0   393216     5312           250 dd
 [ 185680]     0 185680     8688     2016     2016        0         0   458752     4960           250 dd
 [ 185686]     0 185686     8688     2080     2080        0         0   458752     3584           250 dd
 [ 185693]     0 185693     8688     2144     2144        0         0   458752     4384           250 dd
 [ 185700]     0 185700     8688     2176     2176        0         0   458752     3584           250 dd
 [ 185707]     0 185707     8688     1792     1792        0         0   524288     3616           250 dd
 [ 185714]     0 185714     8688     2304     2304        0         0   458752     3488           250 dd
 [ 185721]     0 185721     8688     1920     1920        0         0   458752     2624           250 dd
 [ 185728]     0 185728     8688     2272     2272        0         0   393216     2528           250 dd
 [ 185735]     0 185735     8688     2048     2048        0         0   393216     3552           250 dd
 [ 185742]     0 185742     8688     1984     1984        0         0   458752     2816           250 dd
 [ 185751]     0 185751     8688     1600     1600        0         0   458752     2784           250 dd
 [ 185756]     0 185756     8688     1120     1120        0         0   458752     2400           250 dd
 [ 185764]     0 185764     8688     1504     1504        0         0   393216     2240           250 dd
 [ 185772]     0 185772     8688     1504     1504        0         0   458752     1984           250 dd
 [ 185777]     0 185777     8688     1280     1280        0         0   393216     2336           250 dd
 [ 185784]     0 185784     8688     2144     2144        0         0   393216     2272           250 dd
 [ 185791]     0 185791     8688     2176     2176        0         0   458752      576           250 dd
 [ 185798]     0 185798     8688     1696     1696        0         0   458752     1536           250 dd
 [ 185806]     0 185806     8688     1728     1728        0         0   393216      544           250 dd
 [ 185815]     0 185815     8688     2240     2240        0         0   458752        0           250 dd
 [ 185819]     0 185819     8688     1504     1504        0         0   458752      384           250 dd
 [ 185826]     0 185826     8688     1536     1536        0         0   458752      160           250 dd
 [ 185833]     0 185833     8688     2944     2944        0         0   458752       64           250 dd
 [ 185838]     0 185838     8688     2400     2400        0         0   458752        0           250 dd
 [ 185847]     0 185847     8688      864      864        0         0   458752        0           250 dd
 [ 185853]     0 185853     8688     1088     1088        0         0   393216        0           250 dd
 [ 185860]     0 185860     8688      416      416        0         0   393216        0           250 dd
 [ 185867]     0 185867     8688      352      352        0         0   458752        0           250 dd

[CAUSE]
The test case workload _fill_blk() is going to fill the file to its block
boundary.

But the implementation is not taking larger blocks into consideration.

	FSIZE=`stat -t $i | cut -d" " -f2`
	BLKS=`stat -c "%B" $i`
	NBLK=`stat -c "%b" $i`
	FALLOC=$(($BLKS * $NBLK))
	WS=$(($FALLOC - $FSIZE))

$FSIZE is the file size, $BLKS is the size of each reported block,
$NBLK is the number of blocks the file takes, thus $FALLOC is the
rounded up block size.

For 64K sector size, the BLKS is 512, and BLKS is 128 (one 64K sector).
$FALLOC is the correct value of 64K (10K rounded up to 64K).

Then the problem comes to how the write is done:

	_ddt of=$i oseek=$FSIZE obs=$WS count=1 status=noxfer 2>/dev/null &

Unfrotunately the above command is using output block size of 54K, and
need to skip 10K * 54K bytes, resulting a file size of 540M.

So far although it's not the correct intention, it's not yet causing
problem.

But during _append_file(), we further enlarge the file by:

		FSIZE=`stat -t $i | cut -d" " -f2`
		dd if=$X of=$i seek=1 bs=$FSIZE obs=$FSIZE count=1 status=noxfer 2>/dev/null &

In above case, since the previous file is 540M size, the output block
size will also be 540M, taking a lot of memory.

Furthermore since the workload is run in background, we can have many dd
processes taking up at least 540M, causing huge memory usage and trigger
OOM.

[FIX]
The original code is already not doing what it should do, just get rid of
the cursed dd command usage inside _fill_blk(), and use pwrite from
xfs_io instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/002 | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tests/btrfs/002 b/tests/btrfs/002
index f223cc60..0c231b89 100755
--- a/tests/btrfs/002
+++ b/tests/btrfs/002
@@ -70,19 +70,14 @@ _read_modify_write()
 _fill_blk()
 {
 	local FSIZE
-	local BLKS
-	local NBLK
-	local FALLOC
-	local WS
+	local NEWSIZE
 
 	for i in `find /$1 -type f`
 	do
 		FSIZE=`stat -t $i | cut -d" " -f2`
-		BLKS=`stat -c "%B" $i`
-		NBLK=`stat -c "%b" $i`
-		FALLOC=$(($BLKS * $NBLK))
-		WS=$(($FALLOC - $FSIZE))
-		_ddt of=$i oseek=$FSIZE obs=$WS count=1 status=noxfer 2>/dev/null &
+		NEWSIZE=$(( ($FSIZE + $blksize -1 ) / $blksize * $blksize ))
+
+		$XFS_IO_PROG -c "pwrite -i /dev/urandom $FSIZE $(( $NEWSIZE - $FSIZE ))" $i > /dev/null &
 	done
 	wait $!
 }
@@ -118,6 +113,7 @@ $BTRFS_UTIL_PROG subvolume create $firstvol > /dev/null || _fail "btrfs subvolum
 dirp=`mktemp -duq $firstvol/dir.XXXXXX`
 _populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10 -c
 SNAPNAME=0
+blksize=$(_get_block_size $SCRATCH_MNT)
 _create_snap $firstvol
 _save_checksum $firstvol $tmp.sv1.sum
 _verify_checksum $SNAPNAME $tmp.sv1.sum
-- 
2.47.0


