Return-Path: <linux-btrfs+bounces-839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F380E3C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 06:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE0282D85
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBBB154A4;
	Tue, 12 Dec 2023 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qFidhRvh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qFidhRvh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FDDD5
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 21:24:32 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0152722487
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702358671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mc8arucfvyA/cbTsu7XtrVmlEEHLDpBCK6SwIRY3TCk=;
	b=qFidhRvh4DrfeIk/mvG7N1qswRNfXCJK21UIAx1HDht0tZPFOv6gKYnNs1Ya04qZUfxlIM
	dMBasmAydYd+X8SBp2Zt93IRhw8S8HV41/F7clW1nEnDuBquLvHT//xWAXDBxEe/e3rpvY
	KofiomxXspynu8u/5CmqpaHU+nW+wfE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702358671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mc8arucfvyA/cbTsu7XtrVmlEEHLDpBCK6SwIRY3TCk=;
	b=qFidhRvh4DrfeIk/mvG7N1qswRNfXCJK21UIAx1HDht0tZPFOv6gKYnNs1Ya04qZUfxlIM
	dMBasmAydYd+X8SBp2Zt93IRhw8S8HV41/F7clW1nEnDuBquLvHT//xWAXDBxEe/e3rpvY
	KofiomxXspynu8u/5CmqpaHU+nW+wfE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D22C3139E9
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OYkZHo3ud2VZQQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: migrate the remaining functions exposed by a full fstests with larger metadata folios
Date: Tue, 12 Dec 2023 15:54:08 +1030
Message-ID: <cover.1702354716.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.70
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[15.47%]
X-Spam-Flag: NO

[REPO]
This patchset along with all the previous migrations (and the final
enablement patch) can be found here:

https://github.com/adam900710/linux/tree/eb_memory

With all the previous migrations (although only tested without larger
folios), we are finally just one step away from enabling larger folio
support for btrfs metadata.

During my local full fstests runs with larger metadata folios, there are
only two bugs hit, all related to some code path not yet handling folios
correct:

- eb_bitmap_offset()
- btrfs_repair_eb_io_failure()

Otherwise my local branch can already pass local fstests without new
regressions.

So here is the final (and I hope is the last) migrations for involed
metadata code path, before the final patch enabling larger folio
support.

Qu Wenruo (2):
  btrfs: migrate eb_bitmap_offset() to folio interfaces
  btrfs: migrate btrfs_repair_io_failure() to folio interfaces

 fs/btrfs/bio.c       | 15 +++++++++++----
 fs/btrfs/bio.h       |  4 ++--
 fs/btrfs/disk-io.c   | 13 +++++++------
 fs/btrfs/extent_io.c | 22 ++++++++++------------
 4 files changed, 30 insertions(+), 24 deletions(-)

-- 
2.43.0


