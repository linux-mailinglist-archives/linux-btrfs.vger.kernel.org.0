Return-Path: <linux-btrfs+bounces-5804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52C90E2B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 07:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8401C22472
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D2355898;
	Wed, 19 Jun 2024 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prKYzdM8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prKYzdM8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001902139C9
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775055; cv=none; b=BjZdZrEjbeVpnavI8BF1hNrSZPOn50pCMQZnZD1BncCa7v6Ah744h5CF6gc123F+laXjC57R681eeQ/LEFzzRFApyck3qQkapp0FLmISfrV+Hui+F08lhvNNi2/SlryIdgLvK4m13HZQnOCA4BnXosyLjIAGwoY1Na23cG4rDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775055; c=relaxed/simple;
	bh=PSrHXDI7mviHniCQKfiLBsAAFBaat3z8LtEeFS8MoiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lVYdY8EaUxzcQ3HYBddHGt/HhJtmR1UUCa7yCe7jYEzVubp6VZWKHCUWSNzjl3Y3L3r/vEv+3irJlYppSSXhNTk23VXhRO5iKV1ec9KuwuQOHxNG1W2cuCX2Cg9O0YRvDzvWIwj70SPE4fuWhtKuQUBeppFHsJD+qpvLPuYItPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prKYzdM8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prKYzdM8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53DB01F7DB
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qLLCSKoS/IuYEpjmC0UOWSZ8EOSfUquCqa2PbQ98q7o=;
	b=prKYzdM8uLDOK2bzsu7KTCtL983sf5KaY8+V4caAl4Ag5m/wDFw75xCoSrz3R2eWz3CqF+
	QvmjHr9vJP3TSMNXsBzG9Ia16dlrr4IU9fsjmeol66FACpZgIsgFu/4bL4v010rShJBh0U
	ZihshL6ha4pOe1+RKGItaHzymFDEf9o=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qLLCSKoS/IuYEpjmC0UOWSZ8EOSfUquCqa2PbQ98q7o=;
	b=prKYzdM8uLDOK2bzsu7KTCtL983sf5KaY8+V4caAl4Ag5m/wDFw75xCoSrz3R2eWz3CqF+
	QvmjHr9vJP3TSMNXsBzG9Ia16dlrr4IU9fsjmeol66FACpZgIsgFu/4bL4v010rShJBh0U
	ZihshL6ha4pOe1+RKGItaHzymFDEf9o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6634513AAF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aV65BgttcmYwaAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:30:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests: fix the mount failure detection
Date: Wed, 19 Jun 2024 15:00:29 +0930
Message-ID: <1990108ecf9965436246978a88474607d3814060.1718775020.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.43 / 50.00];
	BAYES_HAM(-2.63)[98.37%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.43
X-Spam-Level: 

[BUG]
After commit "btrfs-progs: tests: dump dmesg if a mount fails", test
case misc/041 would output the following error:

    [TEST/misc]   041-subvolume-delete-during-send
 cat: invalid option -- 'f'
 Try 'cat --help' for more information.
 failed: /home/adam/btrfs-progs/btrfs send -f stream19752.out /home/adam/btrfs-progs/tests/mnt/snap1

[CAUSE]
The send command would fail anyway, but the error message is from the
mount detection, which goes like this:

		if cat "${cmd_array[@]}" | grep -q mount; then

Obviously cat is not the correct animal to print cmd_array to
stdout.

[FIX]
I should go "echo" no matter how I enjoy petting a cat.

It's better to fold this into commit "btrfs-progs: tests: dump dmesg if a
mount fails".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/common b/tests/common
index e9b973e4480b..e996b35af787 100644
--- a/tests/common
+++ b/tests/common
@@ -238,7 +238,7 @@ run_check()
 
 	"${cmd_array[@]}" >> "$RESULTS" 2>&1
 	if [ "$?" -ne 0 ]; then
-		if cat "${cmd_array[@]}" | grep -q mount; then
+		if echo "${cmd_array[@]}" | grep -q mount; then
 			dmesg | tail -n 15 >> "$RESULTS"
 		fi
 		_fail "failed: ${cmd_array[@]}"
-- 
2.45.2


