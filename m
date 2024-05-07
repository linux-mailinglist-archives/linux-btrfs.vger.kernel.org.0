Return-Path: <linux-btrfs+bounces-4797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B2A8BDBF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45D61C21A54
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229579B99;
	Tue,  7 May 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OhMIK4/2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OhMIK4/2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1078C89
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065116; cv=none; b=kyrxmaK1vRusEpchNLAkWAVqI3GvCOMNkzUyEjDsIW87pmXiPXyX6GTV2xUKbOSbSDry+TNzsN/tnPf9MCRup852M2S7p0OOyqek6SQqgj4GJL08zAn3YcGXtJEwpTW869tER5wUWaCBHGvX1HiO4AmNFyYSwQQzo+x/RD/mLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065116; c=relaxed/simple;
	bh=NffO1YsQfjsYbqetopO+7BUT4i8ofIduhje/H+1ljog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DYTJEO24onSJbVSLJkY8rS3O+XSA7CnFyFGhr+CzqcvsHkRbIO1ubiwTuYzzKECGVsnmvEiiTFcnCQas8KUygsHXnXsUXuytv0wQvmzFAvEk4pK/TIdeBArybzoXofV1YU1S9k8QzxtYl5g9mHFKFvjZFPocWfMd+EkwuyzG9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OhMIK4/2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OhMIK4/2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68D3C20522
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sPIbxS01ZH2BoiUAHN2b+MPhmSVNIdhDYzSsQtslmgo=;
	b=OhMIK4/2GCQFDwE+XdR7NvwLQiEIMLDOfTcFgvGttqZn1QRHD6k41JdakRMtPHc3OnGuBj
	SeiJkegugIEnH4AG8yzkBnTxq64NuCwdlk3ZNnOAewwFWe2EmDI9sumlqzPYpmQGnXxK6d
	CitEIlRv3vkyhh1gCmrSYmgidbvd+BU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="OhMIK4/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sPIbxS01ZH2BoiUAHN2b+MPhmSVNIdhDYzSsQtslmgo=;
	b=OhMIK4/2GCQFDwE+XdR7NvwLQiEIMLDOfTcFgvGttqZn1QRHD6k41JdakRMtPHc3OnGuBj
	SeiJkegugIEnH4AG8yzkBnTxq64NuCwdlk3ZNnOAewwFWe2EmDI9sumlqzPYpmQGnXxK6d
	CitEIlRv3vkyhh1gCmrSYmgidbvd+BU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77ECF139CB
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IfpEDBXROWbSGAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 06:58:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: qgroup: stale qgroups related impromvents
Date: Tue,  7 May 2024 16:28:09 +0930
Message-ID: <cover.1715064550.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 68D3C20522
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]

[CHANGELOG]
v3:
- Do not allow dropping non-zero qgroups for squota
  Due to the design of squota, a fully dropped subvolume can still have
  non-zero qgroups, as in the extent tree the delta is still using the
  original owner (the dropped subvolume).

  So we can not drop any non-zero squota qgroups

- Slight change on the can_delete_qgroup() condition
  To co-operate with above change.

v2:
- Do more sanity checks before deleting a qgroup

- Make squota to handle auto deleted qgroup more gracefully
  Unfortunately the behavior change would affect btrfs/301, as the
  fully deleted subvolume would make the test case to cause bash grammar
  error (since the qgroup is gone with the subvolume).

  Cc Boris for extra comments on squota compatibility and future
  btrfs/311 updates ideas.


We have two problems in recent qgroup code:

- One can not delete a fully removed qgroup if the drop hits
  drop_subtree_threshold
  As hitting drop_subtree_threshold would mark qgroup inconsistent and
  skip all accounting, this would leave qgroup number untouched (thus
  non-zero), and btrfs refuses to delete qgroup with non-zero rfer/excl
  numbers.

  This would be addressed by the first patch, allowing qgroup
  deletion as long as it doesn't have any child nor a corresponding
  subvolume.

- Deleted snapshot would leave a stale qgroup
  This is a long existing problem.

  Although previous pushes all failed, just let me try it again.

  The idea is commit current transaction if needed (full accounting mode
  and qgroup numbers are consistent), then try to remove the subvolume
  qgroup after it is fully dropped.

  For full qgroup mode, no matter if qgroup is inconsistent, we will
  auto remove the dropped 0 level qgroup.
  (If consistent, the qgroup numbers should all be 0, and a safe
   removal. If inconsistent, we still remove the qgroup, leaving
   higher level qgroup incorrect, but since it's already inconsistent,
   we need a rescan anyway).

  For squota mode, we only do the auto reap if the qgroup numbers are
  already 0.
  Otherwise the qgroup numbers would be needed for future accounting.

The behavior change would only affect btrfs/301, which still expects the
dropped subvolume would still leave its qgroup untouched.
But that can be easily fixed by explicitly echoing "0" for dropped
subvolume.

Qu Wenruo (2):
  btrfs: slightly loose the requirement for qgroup removal
  btrfs: automatically remove the subvolume qgroup

 fs/btrfs/extent-tree.c |   8 +++
 fs/btrfs/qgroup.c      | 120 ++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/qgroup.h      |   2 +
 3 files changed, 123 insertions(+), 7 deletions(-)

-- 
2.45.0


