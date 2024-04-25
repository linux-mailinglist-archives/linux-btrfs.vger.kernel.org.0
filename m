Return-Path: <linux-btrfs+bounces-4548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7238B2CC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 00:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE3A1C20CB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 22:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D046178CF1;
	Thu, 25 Apr 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LsA3R3uj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LsA3R3uj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24168178CCD
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082779; cv=none; b=eeDB3onodaLw+p0dnRfNNYi8hGOFXGM/rclIU22xyHLIr2hQCILujkxnl13+9Z/oQR0Dup1b2ic9DKxTgqNSMoaPx2k10Cw7gTwULLx120BsxhbqLVrlBiVM5iQpHZLYagrtIJvkJ8+fMDlxqcTW/ZBkS0M0T9eD7/SlPuRb3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082779; c=relaxed/simple;
	bh=Ks8MJTfCC+ktqauOMPolY7P6Oj1I7nnKxP0UNa3Y8os=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=paX8STWmu1xosyoMF6oyBw9CBWPE0wARZdE92dC6Z03dsYMh0ro5baUQ9Y2MJm9vwXJeStiTtv9YPcPaG/HmHb7bNMywtZ27aHHOlJWoJ3nR15q4EZW923XTihHIgYtNrtdKMCLgpy91+xd03luWCJD2EhPyHGO7nPbhyFhjjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LsA3R3uj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LsA3R3uj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 197B1344E3
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714082774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QrzYR82XkvyMfVxRdXlNc/zl49mfgDzq232VdNW7tV8=;
	b=LsA3R3ujalP9735Cg3wQJIz8Wew4tbwGopATZXkeh5jDZmcDRH4aSTrSJCfqgC501wlvk3
	TopBvEdYgUzrlcbWZ+2NzPemKrdmhkERWOFkilKK9U3Fi6Sj2n1uzBcGT1vDFjhhBFvqz7
	Gue/Ccxj6vbxo7Z//jVHg3yhHuFUuDM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LsA3R3uj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714082774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QrzYR82XkvyMfVxRdXlNc/zl49mfgDzq232VdNW7tV8=;
	b=LsA3R3ujalP9735Cg3wQJIz8Wew4tbwGopATZXkeh5jDZmcDRH4aSTrSJCfqgC501wlvk3
	TopBvEdYgUzrlcbWZ+2NzPemKrdmhkERWOFkilKK9U3Fi6Sj2n1uzBcGT1vDFjhhBFvqz7
	Gue/Ccxj6vbxo7Z//jVHg3yhHuFUuDM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D23B01393C
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5VMcG9TTKmaQdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: revert `btrfs subvolume delete --delete-qgroup` option
Date: Fri, 26 Apr 2024 07:35:51 +0930
Message-ID: <cover.1714082499.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.06 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.05)[60.10%];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -0.06
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 197B1344E3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

The introduction of `btrfs subvolume delete --delete-qgroup` would not
work for a lot of real world cases.

This would leads to unnecessary errors, and can be very confusing for
end users.

Furthermore the new options do not take the lifespan of a subvolume into
consideration or the possible conflicts with other qgroup features.

Although it's already too late, we should revert it to prevent further
confusion and damage.

Qu Wenruo (2):
  Revert "btrfs-progs: subvol delete: add options to delete the qgroup"
  btrfs: misc-tests: remove the subvol-delete-qgroup test case

 Documentation/btrfs-subvolume.rst             |  7 ---
 cmds/subvolume.c                              | 26 ----------
 .../061-subvol-delete-qgroup/test.sh          | 47 -------------------
 3 files changed, 80 deletions(-)
 delete mode 100755 tests/misc-tests/061-subvol-delete-qgroup/test.sh

--
2.44.0


