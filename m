Return-Path: <linux-btrfs+bounces-17455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0135BBD775
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3093B27F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0D1F4634;
	Mon,  6 Oct 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V/PRITL/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cjitxrEv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3921F3FE2
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743537; cv=none; b=PUSSE5SucN3U3CmPj0KM0pQ93WZ8aV9r3/1En/MqslCjhvEdapCP8TWE99yPYsRNmkiQfMK3uKEseyH0/hBnNV0D/SCpEGn5XAuNMOFElFvESzLaIA9drYGcTXepWQ5dSMZpQXzQbvxmXggu75Jt9qKNCNXVeapZCDn5txhMLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743537; c=relaxed/simple;
	bh=pHqcAEodukyZtaO4M8cjF11wOgEt5kgnaIIuvvza1Qc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzOOiUoa8OtAFC7tkVhfMmxZtVqTYC0+F6sftYx68WvIyQ1Z2TMmCnP5BjxJSFzuxsa0iLW+d6w93sX77UWvcXzBc6RAgN9dZ40SWSSkpAyotfHB80VmstYNFBh192Vx9zfeg9B4Go0XSSauiDJOo61T5gISVXojNOGh6bWUEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V/PRITL/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cjitxrEv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC5C71F789
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759743527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8a6Lb7f1utGfMoVvFigvbQ6rj0/lOlK+sC7SyGyvMg=;
	b=V/PRITL/JpcrOt+tNoEyxwpOfxHLSRj2Ua6/W9lXQ7/MpC1susSQfyenrim9jyZWfMplYT
	Rv0v8FPSdPr6JuWhlM+aB3cnxPi2iCdsFJN5OZChv7859ys7883xrhTay0QjJavDQHQPTV
	tKgwrna2t1ImxlAfOn+V/Q3twzmyh80=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cjitxrEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759743526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8a6Lb7f1utGfMoVvFigvbQ6rj0/lOlK+sC7SyGyvMg=;
	b=cjitxrEvQ9mZQJj4onHkQTGBMcIQuQFiemEHlb8vDcrtlCo6IJx1V20XKbnzmqEXTy1AL5
	ybBu/nwp72Wx9Af+/YjHCf1Cc4SvH4GhlRGjW8ox7cg2HNc/KRCVu6kYC2Rtx3YuHCGwoo
	s1CWKPzaxy6HiiWfMrR8DzmCdL/2TN0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D61B13700
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eLK5LyWO42iUQgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 09:38:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: a new test case with orphan dev extent
Date: Mon,  6 Oct 2025 20:08:25 +1030
Message-ID: <02bc52f2a5492b007300f911f695efc6b98fb974.1759743405.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1759743405.git.wqu@suse.com>
References: <cover.1759743405.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: CC5C71F789
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The fs has the following chunk tree (minor members removed):

	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
		devid 1 total_bytes 536870912 bytes_used 159383552
		io_align 4096 io_width 4096 sector_size 4096 type 0
	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
		length 8388608 owner 2 stripe_len 65536 type DATA|single
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 itemsize 112
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
		io_align 65536 io_width 65536 sector_size 4096
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 itemsize 112
		length 33554432 owner 2 stripe_len 65536 type METADATA|DUP
		io_align 65536 io_width 65536 sector_size 4096

And the following dev tree:

	item 0 key (DEV_STATS PERSISTENT_ITEM 1) itemoff 16243 itemsize 40
		persistent item objectid DEV_STATS offset 1
		device stats
		write_errs 0 read_errs 0 flush_errs 0 corruption_errs 0 generation 0
	item 1 key (1 DEV_EXTENT 13631488) itemoff 16195 itemsize 48
	item 2 key (1 DEV_EXTENT 22020096) itemoff 16147 itemsize 48
	item 3 key (1 DEV_EXTENT 30408704) itemoff 16099 itemsize 48
	item 4 key (1 DEV_EXTENT 38797312) itemoff 16051 itemsize 48
	item 5 key (1 DEV_EXTENT 72351744) itemoff 16003 itemsize 48
	item 6 key (1 DEV_EXTENT 105906176) itemoff 15955 itemsize 48
		dev extent chunk_tree 3
		chunk_objectid 256 chunk_offset 63963136 length 67108864
		chunk_tree_uuid b2408431-a79a-42b6-aadc-4e853d4caa82

Notice the last dev_extent item, which has no corresponding chunk.

The image is created by calling btrfs_insert_dev_extent(), then
btrfs_update_device() to update dev->bytes_used.

This image can be repaired by both original and lowmem modes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../068-orphan-dev-extent/.lowmem_repairable     |   0
 .../068-orphan-dev-extent/default.img.xz         | Bin 0 -> 1784 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/068-orphan-dev-extent/.lowmem_repairable
 create mode 100644 tests/fsck-tests/068-orphan-dev-extent/default.img.xz

diff --git a/tests/fsck-tests/068-orphan-dev-extent/.lowmem_repairable b/tests/fsck-tests/068-orphan-dev-extent/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/068-orphan-dev-extent/default.img.xz b/tests/fsck-tests/068-orphan-dev-extent/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..6ca960a73a4ded4d7ffe57cb234c9579f8c0f584
GIT binary patch
literal 1784
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
GMgagrz-RdY

literal 0
HcmV?d00001

-- 
2.50.1


