Return-Path: <linux-btrfs+bounces-4420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F728AA8A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 08:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F23B21166
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377A3A1CF;
	Fri, 19 Apr 2024 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RwwyXOeY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RwwyXOeY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97CF79F9
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509443; cv=none; b=Grh/fdbxN9omc+/4Djtnx6iP7tIgCt0j2idDCPVaoi1zkjQDZhabKv58usm/tEq+ahp2krysA/C1biagceB6+emutJgdgYCTOTpRtfLn1K+A+NwN164T0iDDc2/2QJWUhHhJU+YaqqrGLzfqWOB0/m8GmG7itKUUwwUimC9621E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509443; c=relaxed/simple;
	bh=bJNXgT2syyzUlcH1WYnznE47qmqJnUHBA13OuM2p2Yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ME5fchVVTITtEo1+0R++0Mj4/PKt30+Em8VXdMdSKW5dIeFH7tX28kefg9Qc8tKvrj5vSCT140dzhtnMMljaB+xAQYUKNdICuvOBPD56InzT31BeAeWkZFFyjNUcr5rWA6AQ69s1mjeMyjtW6rOLGwjL1f6KiqqKe0LQ+tuxJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RwwyXOeY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RwwyXOeY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 106EC374DD
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713509439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dkj7+RnCbBr/q68YkJO5z0Jjs0dzut3MDANRBvLMKGk=;
	b=RwwyXOeYYCFHDvnNs3pWTN0HipgWa525769TAA7SgKQwn9DgfjGmWUlWn09AN6w2M8HQ+W
	5WVmx4LRaNbfP6R5PSDVy0BkfvTh/GJPwnwW7dUn/AZZvh67QEiuDpocjb53tqmZFBM7mp
	XSn8btbs/KlWTIEAuDse5lowVDNytmw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713509439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dkj7+RnCbBr/q68YkJO5z0Jjs0dzut3MDANRBvLMKGk=;
	b=RwwyXOeYYCFHDvnNs3pWTN0HipgWa525769TAA7SgKQwn9DgfjGmWUlWn09AN6w2M8HQ+W
	5WVmx4LRaNbfP6R5PSDVy0BkfvTh/GJPwnwW7dUn/AZZvh67QEiuDpocjb53tqmZFBM7mp
	XSn8btbs/KlWTIEAuDse5lowVDNytmw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 234DB13687
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mNoeMj0UImb7RwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: qgroup: stale qgroups related impromvents
Date: Fri, 19 Apr 2024 16:20:17 +0930
Message-ID: <cover.1713508989.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 0.15
X-Spam-Level: 
X-Spamd-Result: default: False [0.15 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.05)[60.37%];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

We have two problems in recent qgroup code:

- One can not delete a fully removed qgroup if the drop hits
  drop_subtree_threshold
  As hitting drop_subtree_threshold would mark qgroup inconsistent and
  skip all accounting, this would leave qgroup number untouched (thus
  non-zero), and btrfs refuses to delete qgroup with non-zero rfer/excl
  numbers.

  This would be addressed by the first patch, to allowing qgroup
  deletion as long as it doesn't have any child nor a corresponding
  subvolume.

- Deleted subvolumes leaves a stale qgroup until next rescan
  This is a long existing problem.

  Although previous pushes all failed, just let me try it again.

  The idea is commit current transaction (to sync qgroup numbers), then
  try to remove the subvolume qgroup if it's fully dropped.

Qu Wenruo (2):
  btrfs: slightly loose the requirement for qgroup removal
  btrfs: automatically remove the subvolume qgroup

 fs/btrfs/extent-tree.c |  9 +++++
 fs/btrfs/qgroup.c      | 76 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/qgroup.h      |  2 ++
 3 files changed, 80 insertions(+), 7 deletions(-)

-- 
2.44.0


