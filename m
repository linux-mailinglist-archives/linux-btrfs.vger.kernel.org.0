Return-Path: <linux-btrfs+bounces-1610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B893383724B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB629302D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 19:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2733F8D4;
	Mon, 22 Jan 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VsqUC0qf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VsqUC0qf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990363D3AB
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950990; cv=none; b=GkgCFwWZ5P2rj1rvnoqZ2OxaHnnk28IS0oErYUioOChviXRp0xDh/ZpoIPcGF7U7rDH00tYk1GwkrS2gAF8Cx9TQJQvsJMQ7gWr1BrCpCNHdhD8k1Q280ejrXDB6AfzsdbZ7G5KfXRTxQ0kXo75vATT27RCDVjchx9cW4lA5exI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950990; c=relaxed/simple;
	bh=3luj2Ih5B6+dPzi10VVWK1p7vj/W2nrG53tLnVZV2qk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PsUWR3obyknoxUXVT5Ee6gu9082vv7a4tdPg6B/03pvUtdlsR884yy+XKZ4XWGtdAs6niW2UOBdRRZXQWg/RneebzPSXBv8dBrVe/1sEx6JKkkI2CNUjTskH1HMO/5jFEoliV4Oje/tsWQ2BEXqkQkJAgz34qaFPIwa4ffJmy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VsqUC0qf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VsqUC0qf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 849311FC31
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705950985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qub4F+CTsrUgEhbAnzmxITvdTF2WZ6/OYFtyfo3CCas=;
	b=VsqUC0qfGZtaUAr/Vg7C/7ZR5+jHTOaJInM8gEjF2ye+mw891aG80BFxGdbHW1kyWsRbb5
	soCU52B4Tydtt/ji2ptczR25pHbCaSeFvoDfbaHzjcouPZS8/jhMrvCpxyA2/ncZt7Hr1j
	tb3L0cpKINLPbkN4co/FW43eCLHVkkE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705950985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qub4F+CTsrUgEhbAnzmxITvdTF2WZ6/OYFtyfo3CCas=;
	b=VsqUC0qfGZtaUAr/Vg7C/7ZR5+jHTOaJInM8gEjF2ye+mw891aG80BFxGdbHW1kyWsRbb5
	soCU52B4Tydtt/ji2ptczR25pHbCaSeFvoDfbaHzjcouPZS8/jhMrvCpxyA2/ncZt7Hr1j
	tb3L0cpKINLPbkN4co/FW43eCLHVkkE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7512E13310
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 19:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +hFKHAm/rmX9cQAAn2gu4w
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 19:16:25 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.7
Date: Mon, 22 Jan 2024 20:16:03 +0100
Message-ID: <20240122191605.6399-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VsqUC0qf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.17)[-0.847];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[25.71%]
X-Spam-Score: 3.52
X-Rspamd-Queue-Id: 849311FC31
X-Spam-Flag: NO

Hi,

btrfs-progs version 6.7 have been released.

Please note the change to the "mkfs --sectorsize", it's 4K by default and
requires the subpage support, recommended lowest kernel is 6.1. It would work
on older kernels too but there could be fixes or functionality missing.

This is namely for hosts that use the same filesystem on architectures with
different page size. In practice x86_64 has 4K, ARM most often configured with
4K too but there are 64K setups and 16K on the Macs.

Changelog:

   * mkfs: make 4k sectorsize default, recommended minimum kernel for that is
     6.1 and requires subpage support on architectures with page size > 4k
   * subvolume create: return correct error code when a target already exists
   * tree-checker: dump tree block on error (btrfs-convert, ...)
   * scrub limit: fix reporting of a limit set while there's none
   * fi usage: fix reporting of unallocated data or raid56 profile without root
     privs due to lack of that information
   * convert:
      * align data block group lengths to 64K
      * fix conversion of a large filesystem when there are partial inode items
        present due to caching
   * other:
      * build fixes
      * updated documentation
      * new and updated tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.7

