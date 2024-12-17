Return-Path: <linux-btrfs+bounces-10513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C839F593B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCD16E7AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D871F9F5F;
	Tue, 17 Dec 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V8WkhkPa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V8WkhkPa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B31D5CCC
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472762; cv=none; b=jBwmMiOvi8l4dFjaoZOHKsBhZnnl6v6czl+5feaAaVEKGjU98kR0PutBWC5ZyyY1b6G+QPU5jNyUENJxVmpNF6+8S8jwL+6n4DDN0wZQmebFaC5aicfeWePZz6nZt3a8TK7xmW9xAbxJOXQ/RBklN1vYQ5vG/O5Dq0xbfA4aUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472762; c=relaxed/simple;
	bh=a/TwGVLc6PAQu6T5D1dJooJG4ehuVf1IZlntrOyGX8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RiJqpIbYXChTTjy/wdrm5Iu0lSGCkoh2x9DCgjTZ74c/aKSAbwGq4QmSKooZhFt0rWRr+gIFHpVHc9zfVEhuNq8bIbvtnqXYFY6SdMnZJliEhJ2G9Cb8cAmarhplHMiKRl1npSIVFAyxncUemrq0iUSjzsbK9TXMNdjjgFQNF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V8WkhkPa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V8WkhkPa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E58221162
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ERI7SHn6nQOb/QwKepDE0Gfrd76+eZLgFqN3T/rXuKs=;
	b=V8WkhkPaUEmTCLLwj7OSwrQqXzzx5UizZNYj1e1yCo+0ePkD02nmOxB+fleSRqxN7vYHs2
	ZUeA/oGkphwuf6zbtmorDPF/LzkdpiF3nKNo0S0hgSzg4wcVqHvbt2KNvQXf9hk+jUz7YG
	ExyIKHOp/iMOdh/32OmjuNTjg916adk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ERI7SHn6nQOb/QwKepDE0Gfrd76+eZLgFqN3T/rXuKs=;
	b=V8WkhkPaUEmTCLLwj7OSwrQqXzzx5UizZNYj1e1yCo+0ePkD02nmOxB+fleSRqxN7vYHs2
	ZUeA/oGkphwuf6zbtmorDPF/LzkdpiF3nKNo0S0hgSzg4wcVqHvbt2KNvQXf9hk+jUz7YG
	ExyIKHOp/iMOdh/32OmjuNTjg916adk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 706C313A3C
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jaDyCzX0YWfFEwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/6] reduce boilerplate code within btrfs
Date: Wed, 18 Dec 2024 08:28:49 +1030
Message-ID: <cover.1734472236.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 

[Changelog]
v3:
- Fix the error handling in the 2nd patch

- Fix the backref walk failure
  There are two bugs in the 3rd patch:
  * Bad parent/ref pointer update
    Which only get updated once at the beginning, meanwhile they should
    be updated only when we found an existing node.
  * Order change for prelim_ref
    The prelim_ref_compare() require the first parameter to be the
    existing ref, and the second parameter to be the new one.
    This is different from the new rb_find_add_cached() order
  Fix both and remove unnecessary variables.

- Add named parameters for cmp() function used in rb_find_add_cached()
  To give a more explicit distinguish on which one should be the newer
  node and which should be the existing node.
  This should reduce the confusion on the order.

- Unify the parameters for cmp() functions
  And all internal entry structure will have corresponding "new_/exist_"
  prefix.

- Make all parameters of cmp() to be const

v2: By Roger L
- Fix error handing in the 2nd patch
  Which is still not done correctly

- Add Acked-by tag from Peter

The goal of this patch series is to reduce boilerplate code
within btrfs. To accomplish this rb_find_add_cached() was added
to linux/include/rbtree.h. Any replaceable functions were then 
replaced within btrfs.

changelog: 
updated if() statements to utilize newer error checking
resolved lock error on 0002
edited title of patches to utilize update instead of edit
added Acked-by from Peter Zijlstra to 0001
eliminated extra variables throughout the patch series

Roger L. Beckermeyer III (6):
  rbtree: add rb_find_add_cached() to rbtree.h
  btrfs: update btrfs_add_block_group_cache() to use rb helper
  btrfs: update prelim_ref_insert() to use rb helpers
  btrfs: update __btrfs_add_delayed_item() to use rb helper
  btrfs: update btrfs_add_chunk_map() to use rb helpers
  btrfs: update tree_insert() to use rb helpers

 fs/btrfs/backref.c       | 79 ++++++++++++++++++++--------------------
 fs/btrfs/block-group.c   | 46 +++++++++++------------
 fs/btrfs/delayed-inode.c | 43 ++++++++++------------
 fs/btrfs/delayed-ref.c   | 45 +++++++++--------------
 fs/btrfs/volumes.c       | 41 +++++++++++----------
 include/linux/rbtree.h   | 37 +++++++++++++++++++
 6 files changed, 156 insertions(+), 135 deletions(-)

-- 
2.47.1


