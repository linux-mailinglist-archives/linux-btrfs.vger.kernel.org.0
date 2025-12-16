Return-Path: <linux-btrfs+bounces-19783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F35CC1C41
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 10:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BEDD302FDEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB9C344056;
	Tue, 16 Dec 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gnmXspra";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gnmXspra"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567534403D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877060; cv=none; b=Lr/eyPTdgUTAGvd0BGBcRDUjF26Hz9JTnRAfgySjO/PWfzmXm9T1aXGEBsUFaZxsrIVytMMVerjfluaI55xa4JSmd7DHvZHz0vT534Ku2wh9hmiC4Grn5CK1O/gC5STmuCYszVwOc8zOVHRam8qVm/GGfoJI8EWaLrBfme/nPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877060; c=relaxed/simple;
	bh=OuH4uPdF7srWxcR3GPLlbjFL2GFKupJoyG0lglhUYFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P64aCdXQiBnVcHx602lyrsCN7zbUrV2rFLTCZInKI5PUqLtvXuI+fLb6nmDZzJJtpI6u8tISUHyxmPuIET7EbMyjfrCe2p9Fk16ZAl+8MpZ8EmNBgqUTa/HVKyxpTcyUslbHycO7VgW3wKGSd0jGVi51EmLe0XI9QR2fW1yvEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gnmXspra; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gnmXspra; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B0C133693;
	Tue, 16 Dec 2025 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765877048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSkFuf6MjYxQj4arY8uaDN+wCm2D1BMIqN7zJFs6p9c=;
	b=gnmXspraEbtkqa1FJrpQzTS/j957zzEqs7GFMiWKtfXE+qz3dKvCd4SgQFiex6KNFpwCtZ
	bNZhZFmKpRadQRhFzI0oG6HjLxtrWfYYd5hmRywwNo2bPgMqk3/4otMKRrNkGSDZE6V7KE
	jh/yIeB/mOU4rg6ypR34YvZDCqwpmXY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765877048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSkFuf6MjYxQj4arY8uaDN+wCm2D1BMIqN7zJFs6p9c=;
	b=gnmXspraEbtkqa1FJrpQzTS/j957zzEqs7GFMiWKtfXE+qz3dKvCd4SgQFiex6KNFpwCtZ
	bNZhZFmKpRadQRhFzI0oG6HjLxtrWfYYd5hmRywwNo2bPgMqk3/4otMKRrNkGSDZE6V7KE
	jh/yIeB/mOU4rg6ypR34YvZDCqwpmXY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C9A93EA65;
	Tue, 16 Dec 2025 09:24:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YATYEzclQWlKNQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 16 Dec 2025 09:24:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: mikkel+btrfs@mikkel.cc
Subject: [PATCH v2 1/2] btrfs-progs: enhance detection on unknown inode keys
Date: Tue, 16 Dec 2025 19:53:47 +1030
Message-ID: <4f3fb9e08ba5f21254b4d542c699b5fba8158d54.1765876829.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765876829.git.wqu@suse.com>
References: <cover.1765876829.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[btrfs];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mikkel.cc:email,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

There is a bug report that a bitflip corrupted one tree block, causing
a corruption that can not be repaired by btrfs-check.

The corruption looks like this:

	item 10 key (730455 INODE_ITEM 0) itemoff 15456 itemsize 160
		generation 7280 transid 9794 size 13829 nbytes 16384
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 11 flags 0x0(none)
		atime 1765397443.29231914 (2025-12-11 06:40:43)
		ctime 1764798591.882909548 (2025-12-04 08:19:51)
		mtime 1764798591.882909548 (2025-12-04 08:19:51)
		otime 1764712848.413821734 (2025-12-03 08:30:48)
	item 11 key (730455 UNKNOWN.8 1924) itemoff 15406 itemsize 50

Note item 11, it has a unknown key, but the itemsize indicates it's an
INODE_REF with 40 name_len (which matches the DIR_ITEM).

bin(BTRFS_INODE_REF_KEY) = 0b1100
bin(8)                   = 0b1000

So it's indeed a bitflip.

At least we should report such unknown inode key types as errors.

The lowmem mode is already doing such report, although not treating them as
an error.
The original mode just ignores them completely.

So this patch enhance btrfs check to:

- Report such unknown item and treat them as error for the original mode

- Treat such unknown item as error for the lowmem mode

Reported-by: mikkel+btrfs@mikkel.cc
Link: https://lore.kernel.org/linux-btrfs/5d5e344e-96be-4436-9a58-d60ba14fdb4f@gmx.com/T/#me22cef92653e660e88a4c005b10f5201a8fd83ac
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        | 7 +++++++
 check/mode-lowmem.c | 5 +++--
 check/mode-lowmem.h | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index db055ae194f8..96c7ef7d8261 100644
--- a/check/main.c
+++ b/check/main.c
@@ -87,6 +87,7 @@ bool is_free_space_tree = false;
 bool init_extent_tree = false;
 bool check_data_csum = false;
 static bool found_free_ino_cache = false;
+static bool found_unknown_key = false;
 struct cache_tree *roots_info_cache = NULL;
 
 enum btrfs_check_mode {
@@ -1895,6 +1896,10 @@ static int process_one_leaf(struct btrfs_root *root, struct extent_buffer *eb,
 			ret = process_xattr_item(eb, i, &key, active_node);
 			break;
 		default:
+			error("Unknown key (%llu %u %llu) found in leaf %llu",
+			      key.objectid, key.type, key.offset,
+			      eb->start);
+			found_unknown_key = true;
 			break;
 		};
 	}
@@ -4027,6 +4032,8 @@ out:
 		free_extent_cache_tree(&wc.shared);
 	if (!cache_tree_empty(&wc.shared))
 		fprintf(stderr, "warning line %d\n", __LINE__);
+	if (!err && found_unknown_key)
+		err = 1;
 
 	return err;
 }
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index ea4d4017827f..8a4c5bc1e10d 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2808,8 +2808,9 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 		case BTRFS_XATTR_ITEM_KEY:
 			break;
 		default:
-			error("ITEM[%llu %u %llu] UNKNOWN TYPE",
-			      key.objectid, key.type, key.offset);
+			error("ITEM[%llu %u %llu] UNKNOWN TYPE in leaf %llu",
+			      key.objectid, key.type, key.offset, node->start);
+			err |= UNKNOWN_KEY;
 		}
 	}
 
diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
index cd0355465be9..ec199b4c8008 100644
--- a/check/mode-lowmem.h
+++ b/check/mode-lowmem.h
@@ -48,6 +48,7 @@
 #define INVALID_GENERATION	(1U << 26)	/* Generation is too new */
 #define SUPER_BYTES_USED_ERROR	(1U << 27)	/* Super bytes_used is invalid */
 #define DUP_FILENAME_ERROR	(1U << 28)	/* DIR_ITEM contains duplicate names */
+#define UNKNOWN_KEY		(1U << 29)	/* Found unknown key type in fs trees */
 
 /*
  * Error bit for low memory mode check.
-- 
2.52.0


