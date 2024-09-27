Return-Path: <linux-btrfs+bounces-8281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90D987DFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 07:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C861F224C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0C176240;
	Fri, 27 Sep 2024 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HcOV6xE4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HcOV6xE4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000E749C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416428; cv=none; b=YQWF7qo+aPVwsYiYOR115XWxE4B3+qUoK+a4NBMrxaynjc1bJAM6HNykk2OM1NGhYkqKktiZ1lvOl85waQz+5ET9Kj4Ujhjm0l2hrf7Qk1lJs9gqk0W3mX97Ont5k6n074H74USLQsvlCFsfNIuYdckhm4FaLe9fbMiU+tGDLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416428; c=relaxed/simple;
	bh=xetxgFLgsOzgrmUSiUs4oBi5oSH53ktaCVcAsNxFm34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RqTOsV+Lirzeppno3hO6EVgitMGQ6sQ6I3viRyMCXJ/4dkl3m7SXGNoCQdG6ErR6g8Sn1rYtAWtWtA8e/6qExkitNShnFBR5GlCWmdevRNpReUCIy5XhicR0g4Y1JSl1E40McvonZf+34+u7upsUoxoEP8yhkLy4/HGnMT0UHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HcOV6xE4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HcOV6xE4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 734081F88F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727416424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VoG2WFqLdY/B/ZwEKxIyTpByyq7NQxsaH32xMH7DjqA=;
	b=HcOV6xE4kfMI6nd15HhfmEqLo8SRMHgVZAEgVV4d9jdanQlbcbga3RygteeTVdOEJviH92
	KL5lJiuVgWLAHi8roemtGUxl3VQyWBcpRuqmtD8A7qvr9USxsAGxHJ09UDA5N0tLik7/18
	V1h0nFGuNoJ1POHRMOAWIfmw3my3tiY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HcOV6xE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727416424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VoG2WFqLdY/B/ZwEKxIyTpByyq7NQxsaH32xMH7DjqA=;
	b=HcOV6xE4kfMI6nd15HhfmEqLo8SRMHgVZAEgVV4d9jdanQlbcbga3RygteeTVdOEJviH92
	KL5lJiuVgWLAHi8roemtGUxl3VQyWBcpRuqmtD8A7qvr9USxsAGxHJ09UDA5N0tLik7/18
	V1h0nFGuNoJ1POHRMOAWIfmw3my3tiY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACDD613A58
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fUJ0G2dI9maDBwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: receive: workaround full file clone quirk
Date: Fri, 27 Sep 2024 15:23:23 +0930
Message-ID: <cover.1727416314.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 734081F88F
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since kernel commit 46a6e10a1ab1 ("btrfs: send: allow cloning
non-aligned extent if it ends at i_size"), we can have clone commands to
clone a full file.

However such full file clone can have an unaligned length, and such
clone is only allowed if the destination file is no larger than the
clone range.

But we can create a case where such clone called on a destination file
which has a larger size.
This can lead to kernel reject such clone, and fail the receive.

This patchset will handle such quirk by truncate the file size to 0 if
we detect this is a full file clone.

Also add a new test case to verify the behaivor.

Qu Wenruo (2):
  btrfs-progs: receive: workaround unaligned full file clone
  btrfs-progs: misc-tests: new test case check the handling of full file
    clone

 cmds/receive.c                                |  47 ++++++++++++++++++
 .../ro_snap1.stream.zst                       | Bin 0 -> 293 bytes
 .../ro_subv1.stream.zst                       | Bin 0 -> 413 bytes
 .../066-receive-full-file-clone/test.sh       |  24 +++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 tests/misc-tests/066-receive-full-file-clone/ro_snap1.stream.zst
 create mode 100644 tests/misc-tests/066-receive-full-file-clone/ro_subv1.stream.zst
 create mode 100755 tests/misc-tests/066-receive-full-file-clone/test.sh

--
2.46.1


