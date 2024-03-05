Return-Path: <linux-btrfs+bounces-3029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F38872A05
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EE928372E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 22:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826712D1FF;
	Tue,  5 Mar 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DyvLim9k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DyvLim9k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2AB17BBF
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676970; cv=none; b=tHhIOaA+3He6Ij7ahvbyxbikIgCZHt1Eb/DkjqQsnDdnapG1gcv1jgrGPJ1euYMe6XhJlWe+icmJhUy72GekO31+eE1QjJ+U4tJmzaBfVRb6aLzNY+otp1gsJGyerArGFpmDv6EBRhUdrcggzchaH83AqrR9BopCllyA5poxONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676970; c=relaxed/simple;
	bh=zZ2DOhfp1vnLQoG5EZILdfQaJ2dF/hpIF8tL67eB6aE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EIZ0+dZnpQarGyvAueYIrGn4UXlcm89S6qIle/EEVzwgmlYnBz/1IX5OBP2hgIfj2MXNyvWlOLbJV1C3ZUYCuXFD8jA0TA8L0rS+9u/pt4GGFf7HkwdxwnXd+gvbCAtFlEXwoXzcWvgfnlsY0gvV6pc1uue7vJdxHMnXCnvH0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DyvLim9k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DyvLim9k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA35920F85
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709676964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MvTGoSwSAflJICqFtnwpXWbkfVKc2OZPy7OIhWBMSQ0=;
	b=DyvLim9k0D4qV2xQb1NTpHDIW2G4+PvaPpYwKBsXxI2qGzYV8oCY9yTYPbaEnIpcHqptnd
	5gP9/kYaRz69L46ust4J07uVnKrVmLPj6qlIOQEy0rY7NTkhAasXo86K/XBhVYQh+wgPjn
	UOHlS1B3k6UB6Lpx6RaaBETmq9aEymY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709676964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MvTGoSwSAflJICqFtnwpXWbkfVKc2OZPy7OIhWBMSQ0=;
	b=DyvLim9k0D4qV2xQb1NTpHDIW2G4+PvaPpYwKBsXxI2qGzYV8oCY9yTYPbaEnIpcHqptnd
	5gP9/kYaRz69L46ust4J07uVnKrVmLPj6qlIOQEy0rY7NTkhAasXo86K/XBhVYQh+wgPjn
	UOHlS1B3k6UB6Lpx6RaaBETmq9aEymY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E74FD13A5D
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CVprJqOZ52XsJgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 22:16:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix data corruption/hang/rsv leak in subpage zoned cases
Date: Wed,  6 Mar 2024 08:45:35 +1030
Message-ID: <cover.1709676577.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DyvLim9k
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.22 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.27)[73.93%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.22
X-Rspamd-Queue-Id: DA35920F85
X-Spam-Flag: NO

[REPO]
https://github.com/adam900710/linux/tree/subpage_delalloc

The repo includes the subpage delalloc rework, or subpage zoned won't
work at all.


Although my previous subpage delalloc rework fixes quite a lot of
crashes of subpage + zoned support, it's still pretty easy to cause rsv
leak using single thread fsstress.

It turns out that, it's not a simple problem of some rsv leak, but
certain dirty data ranges never got written back and just skipped with
its dirty flags cleared, no wonder that would lead to rsv leak.

The root cause is again in the extent_write_locked_range() function
doing weird subpage incompatible behaviors, especially when it clears
the page dirty flag for the whole page, causing __extent_writepage_io()
unable to locate any dirty ranges to be submitted.

The first patch would solve the problem, meanwhile for the 2nd patch
it's a cleanup, as we will never hit the error for current subpage +
zoned cases.

Qu Wenruo (2):
  btrfs: do not clear page dirty inside extent_write_locked_range()
  btrfs: make extent_write_locked_range() to handle subpage writeback
    correctly

 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.44.0


