Return-Path: <linux-btrfs+bounces-3021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE8872724
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98B9B29213
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F4C24215;
	Tue,  5 Mar 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BPk8g1Oo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gh+5JYgm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5941AACF;
	Tue,  5 Mar 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665153; cv=none; b=PaHdzLm8eSv8koSQ8wPfvL5GUOBfzmLelzZKVEMkNM3n69pX9S+pRDFoUx4UH46TytK4jCNY4sfCUFZZpfh59/kAKbd7YlVRJkCuaI0xib1zZmxibm2DJVGxKP24/ct6NwOIBoHOe+rnUUZ9XwQMHeXnJEbAiZs5M019z+tPodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665153; c=relaxed/simple;
	bh=jhZXT5QS+sQTsR4Zf5MCOXotkTXbHc16FYvPDYj719w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJkQE0hnd5GEM07UPMyL5K7JaSbhZDVu8MljFC6NcwoZ7J2sELIM9+/Rsx0D/SMyikxwjV/Lf78RXON/UCNxrHzxLHjZuVPKWFYwG08jFZW+qG0mR9rEo8tgQv6zw5D4QkT+E3ljpyQ2ILv1+Is40gewlYgnAb9WvJHgX7fsXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BPk8g1Oo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gh+5JYgm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0D9B22A92;
	Tue,  5 Mar 2024 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ3RPk3x0DG3aRdeJlgXiel7sD0/H3U+Tb6ibktVg9k=;
	b=BPk8g1OoO6JF0GHB8gPmoT2/0UJ4ZlJtM+z4glT0eanMVgR+0XsDpTaFjd84NCmjFTaDGL
	PF6qb/h20qIYmryWNgSJpM3GxqdXzcRwd4/scaS74utsmiKk6iQhbFmiDSu7DzD6XutwE8
	REic+NN4uAjvIgZEzZdqEFl4+oGMIKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ3RPk3x0DG3aRdeJlgXiel7sD0/H3U+Tb6ibktVg9k=;
	b=gh+5JYgmKoyq2tYT8v3UHEfSbe+4sHjM2KZvC8nM/O5AMtjvystv34Fri9UTKr6diX8EsF
	Pc8KRklCiJInr91pyCstp1wmpVsh/sDTU9l/eVaZm2+ukce+SV3jFUROWB04pDiErVjb9p
	TcYOJMNzcCryS6HvT7xssevrugCvG2M=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA24F13466;
	Tue,  5 Mar 2024 18:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5z1YMXxr52U3BQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:08 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs/011: increase the runtime for replace cancel
Date: Tue,  5 Mar 2024 19:52:03 +0100
Message-ID: <84c96df7a1fc1fd43e543f0342d46c85b31d4143.1709664047.git.dsterba@suse.com>
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
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gh+5JYgm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.48 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[45.79%]
X-Spam-Score: 3.48
X-Rspamd-Queue-Id: D0D9B22A92
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

This test exercises the btrfs replace cancel path, but in order to do
this we have to have enough work to do in order to successfully cancel
the balance, otherwise the test fails because the operation has
completed before we're able to cancel.  This test has a very low pass
rate because we do not generate a large enough file system for replace
to have enough work, passing around 5% of the time.  Increase the time
spent to 10x the time we wait for the replace to start its work before
we cancel, this allows us to consistently pass this test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/011 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index ff52ada94a17d0..d8b5a978275032 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -60,6 +60,7 @@ wait_time=1
 fill_scratch()
 {
 	local fssize=$1
+	local with_cancel=$2
 	local filler_pid
 
 	# Fill inline extents.
@@ -88,7 +89,11 @@ fill_scratch()
 	$XFS_IO_PROG -f -d -c "pwrite -b 64k 0 1E" "$SCRATCH_MNT/t_filler" &>\
 		$tmp.filler_result &
 	filler_pid=$!
-	sleep $((2 * $wait_time))
+	if [ "${with_cancel}" = "cancel" ]; then
+		sleep $((10 * $wait_time))
+	else
+		sleep $((2 * $wait_time))
+	fi
 	kill -KILL $filler_pid &> /dev/null
 	wait $filler_pid &> /dev/null
 
@@ -125,7 +130,7 @@ workout()
 	_scratch_mount
 	_require_fs_space $SCRATCH_MNT $((2 * 512 * 1024)) #2.5G
 
-	fill_scratch $fssize
+	fill_scratch $fssize $with_cancel
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 
 	echo -e "Replace from $source_dev to $SPARE_DEV\\n" >> $seqres.full
-- 
2.42.1


