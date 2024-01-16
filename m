Return-Path: <linux-btrfs+bounces-1479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCC382F358
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B721F23D9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ED21CABF;
	Tue, 16 Jan 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b69PLPOB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b69PLPOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6691C6AE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426988; cv=none; b=CWp1V3CNoW4RNozPE9GoIlWjoKCpozFtLcPjmR6fjp9CfYIHdDvPvJk/6RxV4iA968DGXROSzVVUsgL3eFgrmWDSp1rCs5r6hjR0hQjMbwELRDb8n/vtqXFvrgyO/tcEUoS4Hd+TVgngYjcduMb95QR0CaUcI/LQz3+SFhu0SL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426988; c=relaxed/simple;
	bh=kpi8m8yMs09ejd97DU6dfe7PH5WCsmTPFyCBfONzIPI=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Spam-Score:X-Spamd-Result:
	 X-Spam-Flag; b=jLzI6PZWa3dW/t4fgo+WGcCLos/doa4ZiyuL6IjKqT4Ep7Nt7tyL/vDy2ej+ajCy7FF3ZLYF8vD7YQSeEZ+od/mrdIZxjzO8xnc/LgHVA3MwRsnclkRs8X8adFiz/tdK67WQkEVDJdi0yZvW/54fRuhNvXulpJitlqRN5LeXmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b69PLPOB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b69PLPOB; arc=none smtp.client-ip=195.135.223.131
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 577291F381;
	Tue, 16 Jan 2024 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705426985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HVibn3mB9T9cJeYGKwddkh+5RqDZ9XI4yln5xIJGSJE=;
	b=b69PLPOBqGo1BDFFmsYYdsost3zCWHE3ZMXxl+TiEvxEMcqWSqHP4iPstU+4XS7K7Z7a09
	r8WjQLRaQm6OS13RZNHwuHi53dEp5hbNM/2ZJoGnVidq4tg/fCOBF5T/UCRLNorYIKpd9J
	AWbL3RxhRPxC2sno2vDsfUbr9UgKYzs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705426985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HVibn3mB9T9cJeYGKwddkh+5RqDZ9XI4yln5xIJGSJE=;
	b=b69PLPOBqGo1BDFFmsYYdsost3zCWHE3ZMXxl+TiEvxEMcqWSqHP4iPstU+4XS7K7Z7a09
	r8WjQLRaQm6OS13RZNHwuHi53dEp5hbNM/2ZJoGnVidq4tg/fCOBF5T/UCRLNorYIKpd9J
	AWbL3RxhRPxC2sno2vDsfUbr9UgKYzs=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C911133CE;
	Tue, 16 Jan 2024 17:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rLtaEinApmUYNAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 16 Jan 2024 17:43:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Error handling in unpin_extent_cache()
Date: Tue, 16 Jan 2024 18:42:46 +0100
Message-ID: <cover.1705426614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.78%]
X-Spam-Flag: NO

Do the erorr handling in unpin_extent_cache so we don't se any "change
the return value to void" patches again. The errors are pushed up one
level in each patch.

There's case in btrfs_finish_extent_commit() that still needs to be
changed from BUG_ON to proper handling but it does not look easy.

David Sterba (3):
  brtfs: handle errors returned from unpin_extent_cache()
  btrfs: return errors from unpin_extent_range()
  btrfs: make btrfs_error_unpin_extent_range() return void

 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/ctree.h       |  3 +--
 fs/btrfs/extent-tree.c | 22 ++++++++++++++++------
 fs/btrfs/extent_map.c  | 10 +++++++++-
 fs/btrfs/inode.c       |  9 +++++++--
 5 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.42.1


